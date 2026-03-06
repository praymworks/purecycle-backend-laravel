<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\Route;
use App\Models\Schedule;
use App\Models\Report;
use App\Models\Announcement;
use Illuminate\Http\Request;
use Carbon\Carbon;

class AnalyticsController extends Controller
{
    /**
     * Get dashboard overview statistics
     */
    public function overview()
    {
        try {
            $stats = [
                'total_users' => User::where('status', 'approved')->count(),
                'active_routes' => Route::status('active')->count(),
                'completed_collections' => Schedule::count(),
                'pending_reports' => Report::status('Pending')->count(),
                'active_schedules' => Schedule::status('active')->count(),
                'total_announcements' => Announcement::count(),
            ];

            return response()->json([
                'success' => true,
                'data' => $stats
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch overview statistics',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Get collection statistics (weekly trend)
     */
    public function collectionStats(Request $request)
    {
        try {
            $period = $request->get('period', 'week'); // week, month, year
            
            $startDate = match($period) {
                'week' => now()->startOfWeek(),
                'month' => now()->startOfMonth(),
                'year' => now()->startOfYear(),
                default => now()->startOfWeek(),
            };

            $endDate = match($period) {
                'week' => now()->endOfWeek(),
                'month' => now()->endOfMonth(),
                'year' => now()->endOfYear(),
                default => now()->endOfWeek(),
            };

            // Get daily collection counts
            $collections = Schedule::whereBetween('date', [$startDate, $endDate])
                ->selectRaw('DATE(date) as collection_date, status, COUNT(*) as count')
                ->groupBy('collection_date', 'status')
                ->orderBy('collection_date')
                ->get();

            // Format data for charts
            $chartData = [];
            $currentDate = $startDate->copy();
            
            while ($currentDate <= $endDate) {
                $dateStr = $currentDate->toDateString();
                $dayData = $collections->where('collection_date', $dateStr);
                
                $chartData[] = [
                    'date' => $dateStr,
                    'day' => $currentDate->format('D'),
                    'completed' => $dayData->where('status', 'completed')->sum('count'),
                    'active' => $dayData->where('status', 'active')->sum('count'),
                    'cancelled' => $dayData->where('status', 'cancelled')->sum('count'),
                    'total' => $dayData->sum('count'),
                ];
                
                $currentDate->addDay();
            }

            return response()->json([
                'success' => true,
                'data' => [
                    'period' => $period,
                    'start_date' => $startDate->toDateString(),
                    'end_date' => $endDate->toDateString(),
                    'chart_data' => $chartData,
                    'summary' => [
                        'total_collections' => $collections->sum('count'),
                        'completed' => $collections->where('status', 'completed')->sum('count'),
                        'active' => $collections->where('status', 'active')->sum('count'),
                        'cancelled' => $collections->where('status', 'cancelled')->sum('count'),
                    ]
                ]
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch collection statistics',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Get route performance analytics
     */
    public function routePerformance()
    {
        try {
            $routes = Route::with(['schedules' => function($query) {
                $query->where('status', 'completed');
            }])->get();

            $performance = $routes->map(function($route) {
                $completedSchedules = $route->schedules;
                $totalSchedules = Schedule::where('route_id', $route->id)->count();
                
                return [
                    'route_id' => $route->route_id,
                    'route_name' => $route->name,
                    'municipality' => $route->municipality,
                    'status' => $route->status,
                    'total_trips' => $totalSchedules,
                    'completed_trips' => $completedSchedules->count(),
                    'completion_rate' => $totalSchedules > 0 
                        ? round(($completedSchedules->count() / $totalSchedules) * 100, 2) 
                        : 0,
                    'total_waypoints' => count($route->waypoints),
                    'distance' => $route->distance,
                    'estimated_duration' => $route->estimated_duration,
                ];
            });

            return response()->json([
                'success' => true,
                'data' => $performance
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch route performance',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Get report analytics
     */
    public function reportAnalytics(Request $request)
    {
        try {
            $period = $request->get('period', 'month');
            
            $startDate = match($period) {
                'week' => now()->startOfWeek(),
                'month' => now()->startOfMonth(),
                'year' => now()->startOfYear(),
                default => now()->startOfMonth(),
            };

            $reports = Report::where('created_at', '>=', $startDate)->get();

            $analytics = [
                'total' => $reports->count(),
                'by_status' => [
                    'pending' => $reports->where('status', 'Pending')->count(),
                    'in_progress' => $reports->where('status', 'In Progress')->count(),
                    'resolved' => $reports->where('status', 'Resolved')->count(),
                    'rejected' => $reports->where('status', 'Rejected')->count(),
                ],
                'by_priority' => [
                    'low' => $reports->where('priority', 'Low')->count(),
                    'moderate' => $reports->where('priority', 'Moderate')->count(),
                    'urgent' => $reports->where('priority', 'Urgent')->count(),
                ],
                'by_reporter_role' => [
                    'purok_leader' => $reports->where('reporter_role', 'Purok Leader')->count(),
                    'business_owner' => $reports->where('reporter_role', 'Business Owner')->count(),
                ],
                'resolution_metrics' => [
                    'average_resolution_days' => $this->calculateAverageResolutionDays($reports),
                    'resolved_this_period' => $reports->where('status', 'Resolved')->count(),
                    'resolution_rate' => $reports->count() > 0 
                        ? round(($reports->where('status', 'Resolved')->count() / $reports->count()) * 100, 2)
                        : 0,
                ]
            ];

            return response()->json([
                'success' => true,
                'data' => $analytics
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch report analytics',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Get user activity analytics
     */
    public function userActivity()
    {
        try {
            $thisMonth = now()->startOfMonth();
            
            $analytics = [
                'total_users' => User::count(),
                'active_users' => User::where('status', 'approved')->count(),
                'pending_approval' => User::where('status', 'pending')->count(),
                'new_registrations_this_month' => User::where('created_at', '>=', $thisMonth)->count(),
                'by_role' => [
                    'admin' => User::where('role', 'admin')->count(),
                    'staff' => User::where('role', 'staff')->count(),
                    'purok_leader' => User::where('role', 'purok_leader')->count(),
                    'business_owner' => User::where('role', 'business_owner')->count(),
                ],
                'by_status' => [
                    'approved' => User::where('status', 'approved')->count(),
                    'pending' => User::where('status', 'pending')->count(),
                    'rejected' => User::where('status', 'rejected')->count(),
                    'suspended' => User::where('status', 'suspended')->count(),
                ],
            ];

            return response()->json([
                'success' => true,
                'data' => $analytics
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch user activity',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Get comprehensive dashboard analytics
     */
    public function dashboard(Request $request)
    {
        try {
            $period = $request->get('period', 'month');

            $data = [
                'overview' => $this->getOverviewData(),
                'collections' => $this->getCollectionData($period),
                'routes' => $this->getRouteData(),
                'reports' => $this->getReportData($period),
                'users' => $this->getUserData(),
                'announcements' => $this->getAnnouncementData(),
            ];

            return response()->json([
                'success' => true,
                'data' => $data,
                'generated_at' => now()->toDateTimeString()
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch dashboard analytics',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    // Helper methods
    private function calculateAverageResolutionDays($reports)
    {
        $resolvedReports = $reports->where('status', 'Resolved')->filter(function($report) {
            return $report->resolved_date && $report->date_submitted;
        });

        if ($resolvedReports->count() === 0) {
            return 0;
        }

        $totalDays = $resolvedReports->sum(function($report) {
            return $report->date_submitted->diffInDays($report->resolved_date);
        });

        return round($totalDays / $resolvedReports->count(), 2);
    }

    private function getOverviewData()
    {
        return [
            'total_users' => User::where('status', 'approved')->count(),
            'active_routes' => Route::status('active')->count(),
            'completed_collections' => Schedule::status('completed')
                ->whereBetween('date', [now()->startOfWeek(), now()->endOfWeek()])
                ->count(),
            'pending_reports' => Report::status('Pending')->count(),
        ];
    }

    private function getCollectionData($period)
    {
        return [
            'total' => Schedule::count(),
            'completed' => Schedule::status('completed')->count(),
            'active' => Schedule::status('active')->count(),
            'this_week' => Schedule::whereBetween('date', [now()->startOfWeek(), now()->endOfWeek()])->count(),
        ];
    }

    private function getRouteData()
    {
        return [
            'total' => Route::count(),
            'active' => Route::status('active')->count(),
            'inactive' => Route::status('inactive')->count(),
        ];
    }

    private function getReportData($period)
    {
        return [
            'total' => Report::count(),
            'pending' => Report::status('Pending')->count(),
            'resolved' => Report::status('Resolved')->count(),
            'urgent' => Report::priority('Urgent')->count(),
        ];
    }

    private function getUserData()
    {
        return [
            'total' => User::count(),
            'active' => User::where('status', 'approved')->count(),
            'pending' => User::where('status', 'pending')->count(),
        ];
    }

    private function getAnnouncementData()
    {
        return [
            'total' => Announcement::count(),
            'active' => Announcement::status('Active')->count(),
        ];
    }
}

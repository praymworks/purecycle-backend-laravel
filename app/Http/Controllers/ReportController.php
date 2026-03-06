<?php

namespace App\Http\Controllers;

use App\Models\Report;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Storage;

class ReportController extends Controller
{
    /**
     * Display a listing of reports.
     * Supports filtering by status, priority, barangay, purok, reporter_role
     * Supports search by complaint text or reporter name
     */
    public function index(Request $request)
    {
        try {
            $query = Report::with(['reporter', 'updatedBy']);

            // Filter by status
            if ($request->has('status') && $request->status != '') {
                $query->status($request->status);
            }

            // Filter by priority
            if ($request->has('priority') && $request->priority != '') {
                $query->priority($request->priority);
            }

            // Filter by barangay
            if ($request->has('barangay') && $request->barangay != '') {
                $query->barangay($request->barangay);
            }

            // Filter by purok
            if ($request->has('purok') && $request->purok != '') {
                $query->purok($request->purok);
            }

            // Filter by reporter role
            if ($request->has('reporter_role') && $request->reporter_role != '') {
                $query->reporterRole($request->reporter_role);
            }

            // Search by complaint or reporter name
            if ($request->has('search') && $request->search != '') {
                $search = $request->search;
                $query->where(function($q) use ($search) {
                    $q->where('complaint', 'like', "%{$search}%")
                      ->orWhere('reporter_name', 'like', "%{$search}%")
                      ->orWhere('report_id', 'like', "%{$search}%");
                });
            }

            // Sort by date submitted (newest first by default)
            $sortBy = $request->get('sort_by', 'date_submitted');
            $sortOrder = $request->get('sort_order', 'desc');
            $query->orderBy($sortBy, $sortOrder);

            // Pagination
            $perPage = $request->get('per_page', 15);
            $reports = $query->paginate($perPage);

            return response()->json([
                'success' => true,
                'data' => $reports
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch reports',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Store a newly created report.
     */
    public function store(Request $request)
    {
        try {
            $validator = Validator::make($request->all(), [
                'reporter_id' => 'required|exists:users,id',
                'reporter_name' => 'required|string|max:255',
                'reporter_role' => 'required|string|in:Purok Leader,Business Owner',
                'barangay' => 'required|string|max:255',
                'purok' => 'required|string|max:255',
                'priority' => 'sometimes|in:Low,Moderate,Urgent',
                'status' => 'sometimes|in:Pending,In Progress,Resolved,Rejected',
                'complaint' => 'required|string',
                'photo' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
                'date_submitted' => 'sometimes|date',
                'staff_remarks' => 'nullable|string',
                'resolved_date' => 'nullable|date',
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Validation error',
                    'errors' => $validator->errors()
                ], 422);
            }

            $data = $validator->validated();

            // Generate report ID
            $data['report_id'] = Report::generateReportId();

            // Set default date_submitted to today if not provided
            if (!isset($data['date_submitted'])) {
                $data['date_submitted'] = now()->toDateString();
            }

            // Handle photo upload
            if ($request->hasFile('photo')) {
                $photo = $request->file('photo');
                $filename = time() . '_' . $photo->getClientOriginalName();
                $path = $photo->storeAs('reports', $filename, 'public');
                $data['photo'] = $path;
            }

            $report = Report::create($data);

            return response()->json([
                'success' => true,
                'message' => 'Report created successfully',
                'data' => $report->load('reporter')
            ], 201);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to create report',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Display the specified report.
     */
    public function show($id)
    {
        try {
            $report = Report::with(['reporter', 'updatedBy'])->find($id);

            if (!$report) {
                return response()->json([
                    'success' => false,
                    'message' => 'Report not found'
                ], 404);
            }

            return response()->json([
                'success' => true,
                'data' => $report
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch report',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Update the specified report.
     */
    public function update(Request $request, $id)
    {
        try {
            $report = Report::find($id);

            if (!$report) {
                return response()->json([
                    'success' => false,
                    'message' => 'Report not found'
                ], 404);
            }

            $validator = Validator::make($request->all(), [
                'reporter_id' => 'sometimes|exists:users,id',
                'reporter_name' => 'sometimes|string|max:255',
                'reporter_role' => 'sometimes|string|in:Purok Leader,Business Owner',
                'barangay' => 'sometimes|string|max:255',
                'purok' => 'sometimes|string|max:255',
                'priority' => 'sometimes|in:Low,Moderate,Urgent',
                'status' => 'sometimes|in:Pending,In Progress,Resolved,Rejected',
                'complaint' => 'sometimes|string',
                'photo' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
                'date_submitted' => 'sometimes|date',
                'staff_remarks' => 'nullable|string',
                'resolved_date' => 'nullable|date',
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Validation error',
                    'errors' => $validator->errors()
                ], 422);
            }

            $data = $validator->validated();

            // Handle photo upload
            if ($request->hasFile('photo')) {
                // Delete old photo if exists
                if ($report->photo && Storage::disk('public')->exists($report->photo)) {
                    Storage::disk('public')->delete($report->photo);
                }

                $photo = $request->file('photo');
                $filename = time() . '_' . $photo->getClientOriginalName();
                $path = $photo->storeAs('reports', $filename, 'public');
                $data['photo'] = $path;
            }

            $report->update($data);

            return response()->json([
                'success' => true,
                'message' => 'Report updated successfully',
                'data' => $report->load('reporter')
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to update report',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Remove the specified report (soft delete).
     */
    public function destroy($id)
    {
        try {
            $report = Report::find($id);

            if (!$report) {
                return response()->json([
                    'success' => false,
                    'message' => 'Report not found'
                ], 404);
            }

            $report->delete();

            return response()->json([
                'success' => true,
                'message' => 'Report deleted successfully'
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to delete report',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Update report status.
     */
    public function updateStatus(Request $request, $id)
    {
        try {
            $report = Report::find($id);

            if (!$report) {
                return response()->json([
                    'success' => false,
                    'message' => 'Report not found'
                ], 404);
            }

            $validator = Validator::make($request->all(), [
                'status' => 'required|in:Pending,In Progress,Resolved,Rejected',
                'staff_remarks' => 'nullable|string',
                'remark' => 'nullable|string',
                'resolved_date' => 'nullable|date',
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Validation error',
                    'errors' => $validator->errors()
                ], 422);
            }

            $data = $validator->validated();

            // Auto-set resolved_date if status is Resolved
            if ($data['status'] === 'Resolved' && !isset($data['resolved_date'])) {
                $data['resolved_date'] = now()->toDateString();
            }

            // Clear resolved_date if status is not Resolved
            if ($data['status'] !== 'Resolved') {
                $data['resolved_date'] = null;
            }

            // Set updated_by_id to authenticated user
            $data['updated_by_id'] = auth()->id();

            $report->update($data);

            return response()->json([
                'success' => true,
                'message' => 'Report status updated successfully',
                'data' => $report->load(['reporter', 'updatedBy'])
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to update report status',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Get report statistics.
     */
    public function statistics()
    {
        try {
            $stats = [
                'total' => Report::count(),
                'by_status' => [
                    'pending' => Report::status('Pending')->count(),
                    'in_progress' => Report::status('In Progress')->count(),
                    'resolved' => Report::status('Resolved')->count(),
                    'rejected' => Report::status('Rejected')->count(),
                ],
                'by_priority' => [
                    'low' => Report::priority('Low')->count(),
                    'moderate' => Report::priority('Moderate')->count(),
                    'urgent' => Report::priority('Urgent')->count(),
                ],
                'by_reporter_role' => [
                    'purok_leader' => Report::reporterRole('Purok Leader')->count(),
                    'business_owner' => Report::reporterRole('Business Owner')->count(),
                ]
            ];

            return response()->json([
                'success' => true,
                'data' => $stats
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch statistics',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Get report ranking by area (barangay/purok)
     * Returns count of reports per area for waste watch chart
     */
    public function reportRanking(Request $request)
    {
        try {
            // Get grouping type: barangay or purok
            $groupBy = $request->get('group_by', 'purok'); // default to purok
            
            // Check if custom date range is provided
            if ($request->has('start_date') && $request->has('end_date')) {
                // Use custom date range
                $startDate = \Carbon\Carbon::parse($request->start_date)->startOfDay();
                $endDate = \Carbon\Carbon::parse($request->end_date)->endOfDay();
                $period = 'custom';
            } else {
                // Get time period filter
                $period = $request->get('period', 'month'); // week, month, year
                
                $startDate = match($period) {
                    'week' => now()->startOfWeek(),
                    'month' => now()->startOfMonth(),
                    'year' => now()->startOfYear(),
                    default => now()->startOfMonth(),
                };
                $endDate = now();
            }

            // Group reports by area and count with date filter (using date_submitted)
            $query = Report::selectRaw("$groupBy as area, COUNT(*) as reports")
                ->whereBetween('date_submitted', [$startDate, $endDate])
                ->whereNotNull($groupBy)
                ->where($groupBy, '!=', '')
                ->groupBy($groupBy)
                ->orderByDesc('reports')
                ->limit(10);

            $ranking = $query->get();

            // Format for chart
            $chartData = $ranking->map(function($item) {
                return [
                    'area' => $item->area,
                    'reports' => (int)$item->reports,
                    // Assign colors based on report count (red for high, green for low)
                    'color' => $item->reports >= 15 ? '#f87171' : 
                              ($item->reports >= 10 ? '#fbbf24' : 
                              ($item->reports >= 7 ? '#fde047' : 
                              ($item->reports >= 5 ? '#93c5fd' : '#86efac')))
                ];
            });

            return response()->json([
                'success' => true,
                'data' => [
                    'group_by' => $groupBy,
                    'period' => $period,
                    'start_date' => $startDate->toDateString(),
                    'end_date' => $endDate->toDateString(),
                    'ranking' => $chartData
                ]
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch report ranking',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}

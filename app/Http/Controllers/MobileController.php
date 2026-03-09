<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\Report;
use App\Models\Schedule;
use App\Models\Announcement;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Carbon\Carbon;

class MobileController extends Controller
{
    /**
     * Get current user's location/barangay information
     * 
     * @return \Illuminate\Http\JsonResponse
     */
    public function getLocation(Request $request)
    {
        try {
            $user = Auth::user();

            if (!$user) {
                return response()->json([
                    'success' => false,
                    'message' => 'User not authenticated'
                ], 401);
            }

            // Verify user has mobile role
            if (!in_array($user->role, ['purok_leader', 'business_owner'])) {
                return response()->json([
                    'success' => false,
                    'message' => 'Access denied. This endpoint is only for mobile users.'
                ], 403);
            }

            return response()->json([
                'success' => true,
                'data' => [
                    'barangay' => $user->barangay ?? 'N/A',
                    'municipality' => $user->city_municipality ?? 'N/A',
                    'province' => 'Bohol',
                    'purok' => $user->purok ?? null
                ]
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to retrieve location',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Get basic profile information for logged-in mobile user
     * 
     * @return \Illuminate\Http\JsonResponse
     */
    public function getProfile(Request $request)
    {
        try {
            $user = Auth::user();

            if (!$user) {
                return response()->json([
                    'success' => false,
                    'message' => 'User not authenticated'
                ], 401);
            }

            // Verify user has mobile role
            if (!in_array($user->role, ['purok_leader', 'business_owner'])) {
                return response()->json([
                    'success' => false,
                    'message' => 'Access denied. This endpoint is only for mobile users.'
                ], 403);
            }

            $profileData = [
                'id' => $user->id,
                'name' => $user->fullname,
                'email' => $user->email,
                'role' => $user->role,
                'contact_number' => $user->contact_number,
                'profile_path' => $user->profile_path,
                'status' => $user->status,
            ];

            // Add role-specific details
            if ($user->role === 'purok_leader' && $user->purokLeader) {
                $profileData['purok_leader_details'] = [
                    'valid_id_document' => $user->purokLeader->valid_id_document,
                ];
            } elseif ($user->role === 'business_owner' && $user->businessOwner) {
                $profileData['business_owner_details'] = [
                    'business_name' => $user->businessOwner->business_name,
                    'business_permit' => $user->businessOwner->business_permit,
                    'street' => $user->businessOwner->street,
                    'valid_id_document' => $user->businessOwner->valid_id_document,
                ];
            }

            return response()->json([
                'success' => true,
                'data' => $profileData
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to retrieve profile',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Get dashboard statistics for mobile home screen
     * 
     * @return \Illuminate\Http\JsonResponse
     */
    public function getDashboard(Request $request)
    {
        try {
            $user = Auth::user();

            if (!$user) {
                return response()->json([
                    'success' => false,
                    'message' => 'User not authenticated'
                ], 401);
            }

            // Verify user has mobile role
            if (!in_array($user->role, ['purok_leader', 'business_owner'])) {
                return response()->json([
                    'success' => false,
                    'message' => 'Access denied. This endpoint is only for mobile users.'
                ], 403);
            }

            // Get reports statistics for the logged-in user
            $totalReports = Report::where('reporter_id', $user->id)->count();
            $pendingReports = Report::where('reporter_id', $user->id)
                ->where('status', 'Pending')
                ->count();
            $inProgressReports = Report::where('reporter_id', $user->id)
                ->where('status', 'In Progress')
                ->count();
            $resolvedReports = Report::where('reporter_id', $user->id)
                ->where('status', 'Resolved')
                ->count();
            $rejectedReports = Report::where('reporter_id', $user->id)
                ->where('status', 'Rejected')
                ->count();

            // Get upcoming schedules for user's location
            $upcomingSchedulesCount = Schedule::whereDate('date', '>=', Carbon::today())
                ->where('status', '!=', 'cancelled')
                ->whereJsonContains('stops', function ($query) use ($user) {
                    // This will match stops that contain the user's barangay
                    return ['barangay' => $user->barangay];
                })
                ->count();

            // Get active announcements
            $activeAnnouncementsCount = Announcement::where('status', 'Active')
                ->where('start_date', '<=', Carbon::today())
                ->where('end_date', '>=', Carbon::today())
                ->count();

            return response()->json([
                'success' => true,
                'data' => [
                    'reports' => [
                        'total' => $totalReports,
                        'pending' => $pendingReports,
                        'in_progress' => $inProgressReports,
                        'resolved' => $resolvedReports,
                        'rejected' => $rejectedReports
                    ],
                    'upcoming_schedules' => $upcomingSchedulesCount,
                    'active_announcements' => $activeAnnouncementsCount,
                ]
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to retrieve dashboard data',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Get upcoming waste collection schedules
     * 
     * @return \Illuminate\Http\JsonResponse
     */
    public function getUpcomingCollections(Request $request)
    {
        try {
            $user = Auth::user();

            if (!$user) {
                return response()->json([
                    'success' => false,
                    'message' => 'User not authenticated'
                ], 401);
            }

            // Verify user has mobile role
            if (!in_array($user->role, ['purok_leader', 'business_owner'])) {
                return response()->json([
                    'success' => false,
                    'message' => 'Access denied. This endpoint is only for mobile users.'
                ], 403);
            }

            // Get limit from request or default to 10
            $limit = $request->input('limit', 10);

            // Get schedules from today onwards
            $schedules = Schedule::with('route')
                ->whereDate('date', '>=', Carbon::today())
                ->where('status', '!=', 'cancelled')
                ->orderBy('date', 'asc')
                ->orderBy('start_time', 'asc')
                ->limit($limit)
                ->get();

            $collections = [];

            foreach ($schedules as $schedule) {
                // Parse stops to find relevant locations
                $stops = is_array($schedule->stops) ? $schedule->stops : [];
                
                // Check if any stop matches user's barangay or purok
                $relevantStops = array_filter($stops, function($stop) use ($user) {
                    if (!is_array($stop)) return false;
                    
                    $matchesBarangay = isset($stop['barangay']) && 
                                      strtolower($stop['barangay']) === strtolower($user->barangay);
                    
                    $matchesPurok = isset($stop['purok']) && $user->purok &&
                                   strtolower($stop['purok']) === strtolower($user->purok);
                    
                    return $matchesBarangay || $matchesPurok;
                });

                // Format the collection data
                $locationInfo = 'General Collection';
                if (count($relevantStops) > 0) {
                    $firstStop = reset($relevantStops);
                    $locationInfo = isset($firstStop['location']) ? $firstStop['location'] : 
                                  (isset($firstStop['barangay']) ? $firstStop['barangay'] : 'General Collection');
                } elseif ($schedule->route) {
                    $locationInfo = $schedule->route->name;
                }

                $collections[] = [
                    'id' => $schedule->id,
                    'schedule_id' => $schedule->schedule_id,
                    'day' => $schedule->day,
                    'date' => $schedule->date->format('Y-m-d'),
                    'formatted_date' => $schedule->date->format('M d, Y'),
                    'start_time' => $schedule->start_time ? Carbon::parse($schedule->start_time)->format('g:i A') : 'N/A',
                    'end_time' => $schedule->end_time ? Carbon::parse($schedule->end_time)->format('g:i A') : 'N/A',
                    'time_range' => $schedule->start_time && $schedule->end_time ? 
                        Carbon::parse($schedule->start_time)->format('g:i A') . ' - ' . Carbon::parse($schedule->end_time)->format('g:i A') :
                        ($schedule->start_time ? Carbon::parse($schedule->start_time)->format('g:i A') : 'TBA'),
                    'location' => $locationInfo,
                    'garbage_truck' => $schedule->garbage_truck,
                    'status' => $schedule->status,
                    'route_name' => $schedule->route ? $schedule->route->name : null,
                    'notes' => $schedule->notes,
                    'is_relevant_to_user' => count($relevantStops) > 0,
                ];
            }

            return response()->json([
                'success' => true,
                'data' => $collections,
                'count' => count($collections)
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to retrieve upcoming collections',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Get waste sorting guide information
     * 
     * @return \Illuminate\Http\JsonResponse
     */
    public function getWasteGuide(Request $request)
    {
        try {
            $user = Auth::user();

            if (!$user) {
                return response()->json([
                    'success' => false,
                    'message' => 'User not authenticated'
                ], 401);
            }

            // Verify user has mobile role
            if (!in_array($user->role, ['purok_leader', 'business_owner'])) {
                return response()->json([
                    'success' => false,
                    'message' => 'Access denied. This endpoint is only for mobile users.'
                ], 403);
            }

            // Comprehensive waste sorting guide
            $wasteGuides = [
                [
                    'id' => 1,
                    'type' => 'Biodegradable',
                    'category' => 'organic',
                    'icon_color' => '#6BCF7F',
                    'description' => 'Food waste, plant materials, and organic matter',
                    'examples' => [
                        'Food scraps and leftovers',
                        'Fruit and vegetable peels',
                        'Garden waste and leaves',
                        'Paper products (napkins, tissues)',
                        'Coffee grounds and tea bags'
                    ],
                    'disposal_tips' => [
                        'Keep separate from other waste',
                        'Use biodegradable bags if possible',
                        'Compost when available',
                        'Dispose on designated collection days'
                    ]
                ],
                [
                    'id' => 2,
                    'type' => 'Plastic',
                    'category' => 'recyclable',
                    'icon_color' => '#3B82F6',
                    'description' => 'Clean plastic bottles, containers, and wrappers',
                    'examples' => [
                        'PET bottles (water, soda)',
                        'Plastic containers and jars',
                        'Clean plastic bags',
                        'Plastic cups and utensils',
                        'Bubble wrap and packaging'
                    ],
                    'disposal_tips' => [
                        'Rinse containers before disposal',
                        'Remove labels when possible',
                        'Compress bottles to save space',
                        'Separate by plastic type when indicated'
                    ]
                ],
                [
                    'id' => 3,
                    'type' => 'Paper',
                    'category' => 'recyclable',
                    'icon_color' => '#F59E0B',
                    'description' => 'Clean paper products and cardboard',
                    'examples' => [
                        'Newspapers and magazines',
                        'Office paper and documents',
                        'Cardboard boxes',
                        'Paper bags',
                        'Books and catalogs'
                    ],
                    'disposal_tips' => [
                        'Keep dry and clean',
                        'Flatten cardboard boxes',
                        'Remove plastic windows from envelopes',
                        'Do not include waxed or contaminated paper'
                    ]
                ],
                [
                    'id' => 4,
                    'type' => 'Glass',
                    'category' => 'recyclable',
                    'icon_color' => '#10B981',
                    'description' => 'Glass bottles, jars, and containers',
                    'examples' => [
                        'Glass bottles (beverage, condiment)',
                        'Glass jars',
                        'Clear glass containers',
                        'Colored glass items'
                    ],
                    'disposal_tips' => [
                        'Rinse before disposal',
                        'Remove caps and lids',
                        'Handle carefully to avoid breakage',
                        'Separate by color if required'
                    ]
                ],
                [
                    'id' => 5,
                    'type' => 'Metal',
                    'category' => 'recyclable',
                    'icon_color' => '#6B7280',
                    'description' => 'Metal cans, foils, and scraps',
                    'examples' => [
                        'Aluminum cans',
                        'Steel/tin cans',
                        'Aluminum foil',
                        'Metal caps and lids',
                        'Small metal items'
                    ],
                    'disposal_tips' => [
                        'Rinse cans thoroughly',
                        'Crush cans to save space',
                        'Remove paper labels when possible',
                        'Keep separate from other materials'
                    ]
                ],
                [
                    'id' => 6,
                    'type' => 'Residual/Non-Recyclable',
                    'category' => 'non-recyclable',
                    'icon_color' => '#EF4444',
                    'description' => 'Items that cannot be recycled or composted',
                    'examples' => [
                        'Dirty or contaminated materials',
                        'Mixed-material products',
                        'Styrofoam',
                        'Wrappers with food residue',
                        'Broken ceramics and porcelain'
                    ],
                    'disposal_tips' => [
                        'Minimize residual waste',
                        'Check if items can be cleaned and recycled',
                        'Dispose in designated residual waste bins',
                        'Follow local disposal guidelines'
                    ]
                ],
                [
                    'id' => 7,
                    'type' => 'Special Waste',
                    'category' => 'hazardous',
                    'icon_color' => '#F97316',
                    'description' => 'Electronics, batteries, and hazardous materials',
                    'examples' => [
                        'Batteries (all types)',
                        'Electronic devices',
                        'Light bulbs and fluorescent tubes',
                        'Paint and chemicals',
                        'Medical waste'
                    ],
                    'disposal_tips' => [
                        'Never mix with regular waste',
                        'Use designated collection points',
                        'Contact local authorities for disposal',
                        'Store safely until proper disposal'
                    ]
                ]
            ];

            return response()->json([
                'success' => true,
                'data' => $wasteGuides,
                'count' => count($wasteGuides)
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to retrieve waste guide',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Get active announcements for mobile users
     * 
     * @return \Illuminate\Http\JsonResponse
     */
    public function getAnnouncements(Request $request)
    {
        try {
            $user = Auth::user();

            if (!$user) {
                return response()->json([
                    'success' => false,
                    'message' => 'User not authenticated'
                ], 401);
            }

            // Verify user has mobile role
            if (!in_array($user->role, ['purok_leader', 'business_owner'])) {
                return response()->json([
                    'success' => false,
                    'message' => 'Access denied. This endpoint is only for mobile users.'
                ], 403);
            }

            // Get limit from request or default to 5
            $limit = $request->input('limit', 5);

            // Get active announcements within date range
            $announcements = Announcement::where('status', 'Active')
                ->where('start_date', '<=', Carbon::today())
                ->where('end_date', '>=', Carbon::today())
                ->orderBy('priority', 'desc')
                ->orderBy('date_posted', 'desc')
                ->limit($limit)
                ->get();

            $announcementData = $announcements->map(function($announcement) {
                return [
                    'id' => $announcement->id,
                    'announcement_id' => $announcement->announcement_id,
                    'title' => $announcement->title,
                    'message' => $announcement->message,
                    'priority' => $announcement->priority,
                    'start_date' => $announcement->start_date->format('Y-m-d'),
                    'end_date' => $announcement->end_date->format('Y-m-d'),
                    'date_posted' => $announcement->date_posted->format('Y-m-d'),
                    'formatted_date_posted' => $announcement->date_posted->format('M d, Y'),
                    'status' => $announcement->status,
                    'attachments' => $announcement->attachments,
                ];
            });

            return response()->json([
                'success' => true,
                'data' => $announcementData,
                'count' => $announcementData->count()
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to retrieve announcements',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Get today's collection schedule
     * 
     * @return \Illuminate\Http\JsonResponse
     */
    public function getTodayCollection(Request $request)
    {
        try {
            $user = Auth::user();

            if (!$user) {
                return response()->json([
                    'success' => false,
                    'message' => 'User not authenticated'
                ], 401);
            }

            // Verify user has mobile role
            if (!in_array($user->role, ['purok_leader', 'business_owner'])) {
                return response()->json([
                    'success' => false,
                    'message' => 'Access denied. This endpoint is only for mobile users.'
                ], 403);
            }

            // Get today's schedule
            $today = Carbon::today();
            $schedule = Schedule::with('route')
                ->whereDate('date', $today)
                ->where('status', '!=', 'cancelled')
                ->first();

            if (!$schedule) {
                return response()->json([
                    'success' => true,
                    'data' => null,
                    'message' => 'No collection scheduled for today'
                ], 200);
            }

            // Parse stops to find relevant locations
            $stops = is_array($schedule->stops) ? $schedule->stops : [];
            
            // Check if any stop matches user's barangay or purok
            $relevantStops = array_filter($stops, function($stop) use ($user) {
                if (!is_array($stop)) return false;
                
                $matchesBarangay = isset($stop['barangay']) && 
                                  strtolower($stop['barangay']) === strtolower($user->barangay);
                
                $matchesPurok = isset($stop['purok']) && $user->purok &&
                               strtolower($stop['purok']) === strtolower($user->purok);
                
                return $matchesBarangay || $matchesPurok;
            });

            // Format the collection data
            $locationInfo = 'General Collection';
            if (count($relevantStops) > 0) {
                $firstStop = reset($relevantStops);
                $locationInfo = isset($firstStop['location']) ? $firstStop['location'] : 
                              (isset($firstStop['barangay']) ? $firstStop['barangay'] : 'General Collection');
            } elseif ($schedule->route) {
                $locationInfo = $schedule->route->name;
            }

            $collection = [
                'id' => $schedule->id,
                'schedule_id' => $schedule->schedule_id,
                'day' => $schedule->day,
                'date' => $schedule->date->format('Y-m-d'),
                'formatted_date' => $schedule->date->format('M d, Y'),
                'start_time' => $schedule->start_time ? Carbon::parse($schedule->start_time)->format('g:i A') : 'N/A',
                'end_time' => $schedule->end_time ? Carbon::parse($schedule->end_time)->format('g:i A') : 'N/A',
                'time_range' => $schedule->start_time && $schedule->end_time ? 
                    Carbon::parse($schedule->start_time)->format('g:i A') . ' - ' . Carbon::parse($schedule->end_time)->format('g:i A') :
                    ($schedule->start_time ? Carbon::parse($schedule->start_time)->format('g:i A') : 'TBA'),
                'location' => $locationInfo,
                'garbage_truck' => $schedule->garbage_truck,
                'status' => $schedule->status,
                'route_name' => $schedule->route ? $schedule->route->name : null,
                'notes' => $schedule->notes,
                'is_relevant_to_user' => count($relevantStops) > 0,
            ];

            return response()->json([
                'success' => true,
                'data' => $collection
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to retrieve today\'s collection',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}

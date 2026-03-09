<?php

namespace App\Http\Controllers;

use App\Models\Schedule;
use App\Models\User;
use App\Models\Notification;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Helpers\DateTimeHelper;

class ScheduleController extends Controller
{
    /**
     * Display a listing of schedules.
     * Supports filtering by status, date, day, route
     */
    public function index(Request $request)
    {
        try {
            $query = Schedule::with(['route', 'createdBy', 'assignedDriver']);

            // Filter by status
            if ($request->has('status') && $request->status != '') {
                $query->status($request->status);
            }

            // Filter by specific date
            if ($request->has('date') && $request->date != '') {
                $query->byDate($request->date);
            }

            // Filter by date range
            if ($request->has('start_date') && $request->has('end_date')) {
                $query->dateRange($request->start_date, $request->end_date);
            }

            // Filter by day
            if ($request->has('day') && $request->day != '') {
                $query->byDay($request->day);
            }

            // Filter by route
            if ($request->has('route_id') && $request->route_id != '') {
                $query->byRoute($request->route_id);
            }

            // Filter by garbage truck
            if ($request->has('garbage_truck') && $request->garbage_truck != '') {
                $query->where('garbage_truck', $request->garbage_truck);
            }

            // Search by schedule_id
            if ($request->has('search') && $request->search != '') {
                $search = $request->search;
                $query->where(function($q) use ($search) {
                    $q->where('schedule_id', 'like', "%{$search}%")
                      ->orWhere('day', 'like', "%{$search}%")
                      ->orWhere('notes', 'like', "%{$search}%");
                });
            }

            // Sort by date (newest first by default)
            $sortBy = $request->get('sort_by', 'date');
            $sortOrder = $request->get('sort_order', 'desc');
            $query->orderBy($sortBy, $sortOrder);

            // Pagination
            $schedules = $query->get();

            // Return schedules as-is (no auto-correction needed)
            // The 'day' field should already be correct from when it was created
            return response()->json([
                'success' => true,
                'data' => $schedules
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch schedules',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Store a newly created schedule.
     */
    public function store(Request $request)
    {
        try {
            $validator = Validator::make($request->all(), [
                'route_id' => 'nullable|exists:routes,id',
                'garbage_truck' => 'required|string|in:White Garbage Truck,Red Garbage Truck',
                'day' => 'required|string|in:Monday,Tuesday,Wednesday,Thursday,Friday,Saturday',
                'date' => 'required|date',
                'start_time' => 'sometimes|date_format:H:i:s',
                'end_time' => 'nullable|date_format:H:i:s',
                'status' => 'sometimes|in:active,completed,cancelled,pending',
                'cancel_reason' => 'nullable|string',
                'stops' => 'required|array|min:1',
                'stops.*.location' => 'required|string',
                'stops.*.status' => 'required|in:start,ongoing,finish',
                'stops.*.time' => 'required|string',
                'notes' => 'nullable|string',
                'assigned_driver_id' => 'nullable|exists:users,id',
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Validation error',
                    'errors' => $validator->errors()
                ], 422);
            }

            $data = $validator->validated();

            // Auto-calculate day from date if not provided or incorrect
            if (isset($data['date'])) {
                $data['day'] = DateTimeHelper::getDayName($data['date']);
            }

            // Check if a schedule already exists for this date, route, and truck
            $existingSchedule = Schedule::where('date', $data['date'])
                ->where('route_id', $data['route_id'] ?? null)
                ->where('garbage_truck', $data['garbage_truck'])
                ->whereNull('deleted_at')
                ->first();

            if ($existingSchedule) {
                return response()->json([
                    'success' => false,
                    'message' => 'A schedule already exists for this date, route, and truck',
                    'existing_schedule' => $existingSchedule->schedule_id,
                    'duplicate' => true
                ], 409); // 409 Conflict
            }

            // Generate schedule ID
            $data['schedule_id'] = Schedule::generateScheduleId();

            // Set created_by_id to authenticated user
            $data['created_by_id'] = auth()->id();

            $schedule = Schedule::create($data);

            return response()->json([
                'success' => true,
                'message' => 'Schedule created successfully',
                'data' => $schedule->load(['route', 'createdBy', 'assignedDriver'])
            ], 201);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to create schedule',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Display the specified schedule.
     */
    public function show($id)
    {
        try {
            $schedule = Schedule::with(['route', 'createdBy', 'assignedDriver'])->find($id);

            if (!$schedule) {
                return response()->json([
                    'success' => false,
                    'message' => 'Schedule not found'
                ], 404);
            }

            // Add progress info
            $scheduleData = $schedule->toArray();
            $scheduleData['total_stops'] = $schedule->getTotalStops();
            $scheduleData['completed_stops'] = $schedule->getCompletedStops();
            $scheduleData['progress_percentage'] = $schedule->getProgressPercentage();

            return response()->json([
                'success' => true,
                'data' => $scheduleData
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch schedule',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Update the specified schedule.
     */
    public function update(Request $request, $id)
    {
        try {
            $schedule = Schedule::find($id);

            if (!$schedule) {
                return response()->json([
                    'success' => false,
                    'message' => 'Schedule not found'
                ], 404);
            }

            $validator = Validator::make($request->all(), [
                'route_id' => 'nullable|exists:routes,id',
                'garbage_truck' => 'sometimes|string|in:White Garbage Truck,Red Garbage Truck',
                'day' => 'sometimes|string|in:Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday',
                'date' => 'sometimes|date',
                'start_time' => 'sometimes|date_format:H:i:s',
                'end_time' => 'nullable|date_format:H:i:s',
                'status' => 'sometimes|in:active,completed,cancelled,pending',
                'cancel_reason' => 'nullable|string',
                'stops' => 'sometimes|array|min:1',
                'stops.*.location' => 'required|string',
                'stops.*.status' => 'required|in:start,ongoing,finish',
                'stops.*.time' => 'required|string',
                'notes' => 'nullable|string',
                'assigned_driver_id' => 'nullable|exists:users,id',
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Validation error',
                    'errors' => $validator->errors()
                ], 422);
            }

            $data = $validator->validated();

            // Auto-update the 'day' field based on the 'date' if date is being updated
            if (isset($data['date'])) {
                $data['day'] = DateTimeHelper::getDayName($data['date']);
            }

            $schedule->update($data);

            return response()->json([
                'success' => true,
                'message' => 'Schedule updated successfully',
                'data' => $schedule->load(['route', 'createdBy', 'assignedDriver'])
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to update schedule',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Remove the specified schedule (soft delete).
     */
    public function destroy($id)
    {
        try {
            $schedule = Schedule::find($id);

            if (!$schedule) {
                return response()->json([
                    'success' => false,
                    'message' => 'Schedule not found'
                ], 404);
            }

            $schedule->delete();

            return response()->json([
                'success' => true,
                'message' => 'Schedule deleted successfully'
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to delete schedule',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Update schedule status.
     */
    public function updateStatus(Request $request, $id)
    {
        try {
            $schedule = Schedule::with('route')->find($id);

            if (!$schedule) {
                return response()->json([
                    'success' => false,
                    'message' => 'Schedule not found'
                ], 404);
            }

            $validator = Validator::make($request->all(), [
                'status' => 'required|in:active,completed,cancelled,pending',
                'cancel_reason' => 'nullable|string',
                'notes' => 'nullable|string',
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Validation error',
                    'errors' => $validator->errors()
                ], 422);
            }

            $oldStatus = $schedule->status;
            $newStatus = $request->status;

            $data = ['status' => $newStatus];

            // Update cancel reason if status is cancelled
            if ($newStatus === 'cancelled' && $request->has('cancel_reason')) {
                $data['cancel_reason'] = $request->cancel_reason;
            }

            // Update notes if provided (regardless of status)
            if ($request->has('notes')) {
                $data['notes'] = $request->notes;
            }

            $schedule->update($data);

            // Create notifications for affected users if status changed
            if ($oldStatus !== $newStatus) {
                $this->notifyAffectedUsers($schedule, $newStatus, $request->cancel_reason);
            }

            return response()->json([
                'success' => true,
                'message' => 'Schedule status updated successfully',
                'data' => $schedule->load(['route', 'createdBy', 'assignedDriver'])
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to update schedule status',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Notify affected users when schedule status changes
     */
    private function notifyAffectedUsers($schedule, $newStatus, $cancelReason = null)
    {
        try {
            \Log::info('[Schedule Notification] Starting notification process', [
                'schedule_id' => $schedule->id,
                'schedule_number' => $schedule->schedule_id,
                'new_status' => $newStatus,
                'cancel_reason' => $cancelReason,
            ]);

            // Get route waypoints
            if (!$schedule->route || !$schedule->route->waypoints) {
                \Log::warning('[Schedule Notification] No route or waypoints found - skipping notifications', [
                    'schedule_id' => $schedule->id,
                    'has_route' => !!$schedule->route,
                ]);
                return; // No route or waypoints, skip notification
            }

            $waypoints = $schedule->route->waypoints;

            \Log::info('[Schedule Notification] Route waypoints loaded', [
                'route_id' => $schedule->route->id,
                'route_name' => $schedule->route->name,
                'waypoint_count' => count($waypoints),
            ]);

            // Get all purok_leader and business_owner users
            $users = User::whereIn('role', ['purok_leader', 'business_owner'])
                ->where('status', 'approved')
                ->get();

            \Log::info('[Schedule Notification] Found potential users', [
                'total_users' => $users->count(),
                'roles' => ['purok_leader', 'business_owner'],
            ]);

            $affectedUserIds = [];

            // Filter users based on route coverage
            foreach ($users as $user) {
                $userBarangay = $user->barangay;
                $userPurok = $user->purok;

                if (empty($userBarangay)) {
                    continue; // Skip users without barangay
                }

                // Check if user's location matches any waypoint
                foreach ($waypoints as $waypoint) {
                    $waypointBarangay = $waypoint['barangay'] ?? null;
                    $waypointPurok = $waypoint['purok'] ?? $waypoint['sitio'] ?? $waypoint['purok_sitio'] ?? null;

                    // Match barangay first
                    if ($waypointBarangay !== $userBarangay) {
                        continue;
                    }

                    // If user has no purok, barangay match is sufficient
                    if (empty($userPurok)) {
                        $affectedUserIds[] = $user->id;
                        break; // User matched, move to next user
                    }

                    // If waypoint has no purok, skip this waypoint
                    if (empty($waypointPurok)) {
                        continue;
                    }

                    // Match both barangay AND purok
                    if ($waypointPurok === $userPurok) {
                        $affectedUserIds[] = $user->id;
                        break; // User matched, move to next user
                    }
                }
            }

            // Remove duplicates
            $affectedUserIds = array_unique($affectedUserIds);

            \Log::info('[Schedule Notification] User matching complete', [
                'affected_users_count' => count($affectedUserIds),
                'affected_user_ids' => $affectedUserIds,
            ]);

            if (empty($affectedUserIds)) {
                \Log::warning('[Schedule Notification] No affected users found - skipping notifications', [
                    'schedule_id' => $schedule->id,
                    'route_id' => $schedule->route->id,
                ]);
                return; // No affected users
            }

            // Create notification message based on status
            $statusLabel = ucfirst($newStatus);
            $title = 'Schedule Status Updated';
            
            $message = "Your area's waste collection schedule has been updated to {$statusLabel}.";
            
            if ($newStatus === 'cancelled' && $cancelReason) {
                $message = "Your area's waste collection schedule has been cancelled. Reason: {$cancelReason}";
            } elseif ($newStatus === 'completed') {
                $message = "Your area's waste collection has been completed.";
            } elseif ($newStatus === 'active') {
                $message = "Your area's waste collection schedule is now active.";
            }

            $description = "Schedule: {$schedule->schedule_id} | Date: {$schedule->date} | Day: {$schedule->day}";
            if ($schedule->route) {
                $description .= " | Route: {$schedule->route->name}";
            }

            // Create notification data
            $notificationData = [
                'triggered_by_id' => auth()->id(),
                'title' => $title,
                'message' => $message,
                'description' => $description,
                'type' => 'schedule',
                'priority' => $newStatus === 'cancelled' ? 'high' : 'medium',
                'unread' => true,
                'metadata' => [
                    'schedule_id' => $schedule->id,
                    'schedule_number' => $schedule->schedule_id,
                    'status' => $newStatus,
                    'old_status' => $schedule->getOriginal('status'),
                    'date' => $schedule->date,
                    'day' => $schedule->day,
                    'route_name' => $schedule->route->name ?? null,
                    'cancel_reason' => $cancelReason,
                ],
            ];

            \Log::info('[Schedule Notification] Creating notifications', [
                'notification_data' => $notificationData,
                'recipient_count' => count($affectedUserIds),
            ]);

            // Send notifications to all affected users
            $notificationResult = Notification::notify($affectedUserIds, $notificationData);

            \Log::info('[Schedule Notification] Notifications created successfully', [
                'schedule_id' => $schedule->id,
                'recipients' => count($affectedUserIds),
                'status' => $newStatus,
                'result' => $notificationResult,
            ]);

        } catch (\Exception $e) {
            // Log error but don't fail the status update
            \Log::error('[Schedule Notification] Failed to send schedule status notifications', [
                'error' => $e->getMessage(),
                'trace' => $e->getTraceAsString(),
                'schedule_id' => $schedule->id ?? null,
                'new_status' => $newStatus ?? null,
            ]);
        }
    }

    /**
     * Update stop status in schedule
     */
    public function updateStopStatus(Request $request, $id)
    {
        try {
            $schedule = Schedule::find($id);

            if (!$schedule) {
                return response()->json([
                    'success' => false,
                    'message' => 'Schedule not found'
                ], 404);
            }

            $validator = Validator::make($request->all(), [
                'stop_index' => 'required|integer|min:0',
                'status' => 'required|in:start,ongoing,finish',
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Validation error',
                    'errors' => $validator->errors()
                ], 422);
            }

            $stops = $schedule->stops;
            $stopIndex = $request->stop_index;

            if (!isset($stops[$stopIndex])) {
                return response()->json([
                    'success' => false,
                    'message' => 'Stop not found at specified index'
                ], 404);
            }

            $stops[$stopIndex]['status'] = $request->status;
            $schedule->update(['stops' => $stops]);

            return response()->json([
                'success' => true,
                'message' => 'Stop status updated successfully',
                'data' => $schedule->load(['route', 'createdBy', 'assignedDriver'])
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to update stop status',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Get schedule statistics.
     */
    public function statistics()
    {
        try {
            $stats = [
                'total' => Schedule::count(),
                'by_status' => [
                    'active' => Schedule::status('active')->count(),
                    'completed' => Schedule::status('completed')->count(),
                    'cancelled' => Schedule::status('cancelled')->count(),
                    'pending' => Schedule::status('pending')->count(),
                ],
                'today' => Schedule::byDate(now()->toDateString())->count(),
                'this_week' => Schedule::dateRange(
                    now()->startOfWeek()->toDateString(),
                    now()->endOfWeek()->toDateString()
                )->count(),
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
     * Assign driver to schedule
     */
    public function assignDriver(Request $request, $id)
    {
        try {
            $schedule = Schedule::find($id);

            if (!$schedule) {
                return response()->json([
                    'success' => false,
                    'message' => 'Schedule not found'
                ], 404);
            }

            $validator = Validator::make($request->all(), [
                'assigned_driver_id' => 'required|exists:users,id',
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Validation error',
                    'errors' => $validator->errors()
                ], 422);
            }

            $schedule->update(['assigned_driver_id' => $request->assigned_driver_id]);

            return response()->json([
                'success' => true,
                'message' => 'Driver assigned successfully',
                'data' => $schedule->load(['route', 'createdBy', 'assignedDriver'])
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to assign driver',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Get schedules for mobile app users (purok_leader and business_owner)
     * This endpoint is specifically designed for the Expo mobile app
     * Filters schedules based on user's barangay and purok location
     */
    public function mobileSchedules(Request $request)
    {
        try {
            // Verify user role
            $user = auth()->user();
            
            if (!$user || !in_array($user->role, ['purok_leader', 'business_owner'])) {
                return response()->json([
                    'success' => false,
                    'message' => 'Access denied. This endpoint is only for Purok Leaders and Business Owners.'
                ], 403);
            }

            // Get user's location (barangay and purok)
            $userBarangay = $user->barangay;
            $userPurok = $user->purok;

            // Load schedules with route relationship including waypoints
            $query = Schedule::with(['route' => function($q) {
                $q->select('id', 'route_id', 'name', 'description', 'municipality', 'province', 'color', 'distance', 'estimated_duration', 'waypoints');
            }]);

            // Filter by status (default to active and pending for mobile users)
            if ($request->has('status') && $request->status != '') {
                $query->status($request->status);
            } else {
                // Default: show only active and pending schedules
                $query->whereIn('status', ['active', 'pending']);
            }

            // Filter by specific date
            if ($request->has('date') && $request->date != '') {
                $query->byDate($request->date);
            }

            // Filter by date range
            if ($request->has('date_from') && $request->has('date_to')) {
                $query->dateRange($request->date_from, $request->date_to);
            }

            // Filter by day
            if ($request->has('day') && $request->day != '') {
                $query->byDay($request->day);
            }

            // Sort by date (ascending by default for mobile - show upcoming schedules first)
            $sortBy = $request->get('sort_by', 'date');
            $sortOrder = $request->get('sort_order', 'asc');
            
            $query->orderBy($sortBy, $sortOrder);
            
            // Add secondary sort by start_time
            if ($sortBy !== 'start_time') {
                $query->orderBy('start_time', 'asc');
            }

            // Get all schedules (we'll filter by location in PHP)
            $allSchedules = $query->get();

            // Filter schedules based on user's barangay + purok
            $filteredSchedules = $allSchedules->filter(function ($schedule) use ($userBarangay, $userPurok) {
                // If no route, skip
                if (!$schedule->route) {
                    return false;
                }

                // Get route waypoints
                $waypoints = $schedule->route->waypoints ?? [];
                
                // If no waypoints, skip
                if (empty($waypoints)) {
                    return false;
                }

                // Check if any waypoint matches user's barangay AND purok
                foreach ($waypoints as $waypoint) {
                    $waypointBarangay = $waypoint['barangay'] ?? null;
                    $waypointPurok = $waypoint['purok'] ?? $waypoint['sitio'] ?? $waypoint['purok_sitio'] ?? null;

                    // Match barangay first
                    if ($waypointBarangay !== $userBarangay) {
                        continue;
                    }

                    // If user has no purok, only barangay match is sufficient
                    if (empty($userPurok)) {
                        return true;
                    }

                    // If waypoint has no purok, skip
                    if (empty($waypointPurok)) {
                        continue;
                    }

                    // Match both barangay AND purok
                    if ($waypointPurok === $userPurok) {
                        return true;
                    }
                }

                return false;
            });

            // Paginate manually
            $perPage = $request->get('per_page', 50);
            $page = $request->get('page', 1);
            $total = $filteredSchedules->count();
            $lastPage = ceil($total / $perPage);
            
            $paginatedSchedules = $filteredSchedules->slice(($page - 1) * $perPage, $perPage)->values();

            // Format each schedule for mobile app
            $formattedSchedules = $paginatedSchedules->map(function ($schedule) {
                return [
                    'id' => $schedule->id,
                    'schedule_id' => $schedule->schedule_id,
                    'day' => $schedule->day,
                    'date' => $schedule->date,
                    'start_time' => $schedule->start_time,
                    'end_time' => $schedule->end_time,
                    'status' => $schedule->status,
                    'stops' => $schedule->stops,
                    'notes' => $schedule->notes,
                    'route' => $schedule->route ? [
                        'id' => $schedule->route->id,
                        'route_id' => $schedule->route->route_id,
                        'name' => $schedule->route->name,
                        'description' => $schedule->route->description,
                        'municipality' => $schedule->route->municipality,
                        'province' => $schedule->route->province,
                        'color' => $schedule->route->color,
                        'distance' => $schedule->route->distance,
                        'estimated_duration' => $schedule->route->estimated_duration,
                        'waypoints' => $schedule->route->waypoints,
                    ] : null,
                ];
            });

            return response()->json([
                'success' => true,
                'data' => [
                    'data' => $formattedSchedules,
                    'current_page' => (int)$page,
                    'per_page' => (int)$perPage,
                    'total' => $total,
                    'last_page' => $lastPage,
                ],
                'message' => 'Schedules loaded successfully'
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch schedules',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}

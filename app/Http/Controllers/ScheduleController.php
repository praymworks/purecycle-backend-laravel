<?php

namespace App\Http\Controllers;

use App\Models\Schedule;
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

            // Format each schedule for frontend (ensure date is YYYY-MM-DD, day is calculated from date)
            $formattedSchedules = $schedules->map(function ($schedule) {
                // Auto-correct the 'day' field based on actual date
                $schedule->day = DateTimeHelper::getDayName($schedule->date);
                
                return $schedule;
            });

            return response()->json([
                'success' => true,
                'data' => $formattedSchedules
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
                'day' => 'required|string|in:Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday',
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

            // Check if a schedule already exists for this date and route
            $existingSchedule = Schedule::where('date', $data['date'])
                ->where('route_id', $data['route_id'] ?? null)
                ->whereNull('deleted_at')
                ->first();

            if ($existingSchedule) {
                return response()->json([
                    'success' => false,
                    'message' => 'A schedule already exists for this date and route',
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
            $schedule = Schedule::find($id);

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

            $data = ['status' => $request->status];

            // Update cancel reason if status is cancelled
            if ($request->status === 'cancelled' && $request->has('cancel_reason')) {
                $data['cancel_reason'] = $request->cancel_reason;
            }

            // Update notes if provided (regardless of status)
            if ($request->has('notes')) {
                $data['notes'] = $request->notes;
            }

            $schedule->update($data);

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
}

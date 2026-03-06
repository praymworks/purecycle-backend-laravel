<?php

namespace App\Http\Controllers;

use App\Models\Notification;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class NotificationController extends Controller
{
    /**
     * Get all notifications for authenticated user
     */
    public function index(Request $request)
    {
        try {
            $userId = auth()->id();
            $query = Notification::with(['user', 'triggeredBy'])->where('user_id', $userId);

            // Filter by type
            if ($request->has('type') && $request->type != '') {
                $query->type($request->type);
            }

            // Filter by priority
            if ($request->has('priority') && $request->priority != '') {
                $query->priority($request->priority);
            }

            // Filter by unread
            if ($request->has('unread')) {
                if ($request->unread === 'true' || $request->unread === '1') {
                    $query->unread();
                } else {
                    $query->read();
                }
            }

            // Search
            if ($request->has('search') && $request->search != '') {
                $search = $request->search;
                $query->where(function($q) use ($search) {
                    $q->where('title', 'like', "%{$search}%")
                      ->orWhere('message', 'like', "%{$search}%")
                      ->orWhere('description', 'like', "%{$search}%");
                });
            }

            // Sort by newest first
            $query->orderBy('created_at', 'desc');

            // Pagination
            $perPage = $request->get('per_page', 15);
            $notifications = $query->paginate($perPage);

            return response()->json([
                'success' => true,
                'data' => $notifications
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch notifications',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Get unread count
     */
    public function getUnreadCount()
    {
        try {
            $userId = auth()->id();
            $count = Notification::where('user_id', $userId)
                ->unread()
                ->count();

            return response()->json([
                'success' => true,
                'data' => [
                    'unread_count' => $count
                ]
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to get unread count',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Get notification by ID
     */
    public function show($id)
    {
        try {
            $userId = auth()->id();
            $notification = Notification::with(['user', 'triggeredBy'])->where('user_id', $userId)->find($id);

            if (!$notification) {
                return response()->json([
                    'success' => false,
                    'message' => 'Notification not found'
                ], 404);
            }

            return response()->json([
                'success' => true,
                'data' => $notification
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch notification',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Mark notification as read
     */
    public function markAsRead($id)
    {
        try {
            $userId = auth()->id();
            $notification = Notification::where('user_id', $userId)->find($id);

            if (!$notification) {
                return response()->json([
                    'success' => false,
                    'message' => 'Notification not found'
                ], 404);
            }

            $notification->update(['unread' => false]);

            return response()->json([
                'success' => true,
                'message' => 'Notification marked as read',
                'data' => $notification->load(['user', 'triggeredBy'])
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to mark notification as read',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Mark notification as unread
     */
    public function markAsUnread($id)
    {
        try {
            $userId = auth()->id();
            $notification = Notification::where('user_id', $userId)->find($id);

            if (!$notification) {
                return response()->json([
                    'success' => false,
                    'message' => 'Notification not found'
                ], 404);
            }

            $notification->update(['unread' => true]);

            return response()->json([
                'success' => true,
                'message' => 'Notification marked as unread',
                'data' => $notification->load(['user', 'triggeredBy'])
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to mark notification as unread',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Mark all notifications as read
     */
    public function markAllAsRead()
    {
        try {
            $userId = auth()->id();
            
            Notification::where('user_id', $userId)
                ->unread()
                ->update(['unread' => false]);

            return response()->json([
                'success' => true,
                'message' => 'All notifications marked as read'
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to mark all as read',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Delete notification
     */
    public function destroy($id)
    {
        try {
            $userId = auth()->id();
            $notification = Notification::where('user_id', $userId)->find($id);

            if (!$notification) {
                return response()->json([
                    'success' => false,
                    'message' => 'Notification not found'
                ], 404);
            }

            $notification->delete();

            return response()->json([
                'success' => true,
                'message' => 'Notification deleted successfully'
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to delete notification',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Delete all notifications for user
     */
    public function deleteAll()
    {
        try {
            $userId = auth()->id();
            
            Notification::where('user_id', $userId)->delete();

            return response()->json([
                'success' => true,
                'message' => 'All notifications deleted successfully'
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to delete all notifications',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Create notification (Admin/Staff only)
     */
    public function store(Request $request)
    {
        try {
            $validator = Validator::make($request->all(), [
                'user_ids' => 'required|array',
                'user_ids.*' => 'exists:users,id',
                'title' => 'required|string|max:255',
                'message' => 'required|string',
                'description' => 'nullable|string',
                'type' => 'required|in:report,account,announcement,schedule,system,analytics,route',
                'priority' => 'sometimes|in:low,medium,high',
                'action_url' => 'nullable|string',
                'metadata' => 'nullable|array',
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Validation error',
                    'errors' => $validator->errors()
                ], 422);
            }

            $data = $validator->validated();
            $userIds = $data['user_ids'];
            unset($data['user_ids']);

            // Set triggered_by_id to current user
            $data['triggered_by_id'] = auth()->id();

            // Create notifications for all specified users
            $notifications = Notification::notify($userIds, $data);

            return response()->json([
                'success' => true,
                'message' => 'Notifications created successfully',
                'data' => [
                    'count' => count($notifications),
                    'notifications' => $notifications
                ]
            ], 201);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to create notifications',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Get notification statistics
     */
    public function getStats()
    {
        try {
            $userId = auth()->id();

            $stats = [
                'total' => Notification::where('user_id', $userId)->count(),
                'unread' => Notification::where('user_id', $userId)->unread()->count(),
                'read' => Notification::where('user_id', $userId)->read()->count(),
                'by_type' => [
                    'report' => Notification::where('user_id', $userId)->type('report')->count(),
                    'account' => Notification::where('user_id', $userId)->type('account')->count(),
                    'announcement' => Notification::where('user_id', $userId)->type('announcement')->count(),
                    'schedule' => Notification::where('user_id', $userId)->type('schedule')->count(),
                    'system' => Notification::where('user_id', $userId)->type('system')->count(),
                    'analytics' => Notification::where('user_id', $userId)->type('analytics')->count(),
                    'route' => Notification::where('user_id', $userId)->type('route')->count(),
                ],
                'by_priority' => [
                    'low' => Notification::where('user_id', $userId)->priority('low')->count(),
                    'medium' => Notification::where('user_id', $userId)->priority('medium')->count(),
                    'high' => Notification::where('user_id', $userId)->priority('high')->count(),
                ],
            ];

            return response()->json([
                'success' => true,
                'data' => $stats
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch notification stats',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}

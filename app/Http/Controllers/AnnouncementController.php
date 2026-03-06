<?php

namespace App\Http\Controllers;

use App\Models\Announcement;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\File;

class AnnouncementController extends Controller
{
    /**
     * Display a listing of announcements.
     * Supports filtering by status, priority
     * Supports search by title or message
     */
    public function index(Request $request)
    {
        try {
            $query = Announcement::with('createdBy');

            // Filter by status
            if ($request->has('status') && $request->status != '') {
                $query->status($request->status);
            }

            // Filter by priority
            if ($request->has('priority') && $request->priority != '') {
                $query->priority($request->priority);
            }

            // Get only active announcements
            if ($request->has('active') && $request->active == 'true') {
                $query->active();
            }

            // Search by title or message
            if ($request->has('search') && $request->search != '') {
                $search = $request->search;
                $query->where(function($q) use ($search) {
                    $q->where('title', 'like', "%{$search}%")
                      ->orWhere('message', 'like', "%{$search}%")
                      ->orWhere('announcement_id', 'like', "%{$search}%");
                });
            }

            // Sort by date posted (newest first by default)
            $sortBy = $request->get('sort_by', 'date_posted');
            $sortOrder = $request->get('sort_order', 'desc');
            $query->orderBy($sortBy, $sortOrder);

            // Pagination
            $perPage = $request->get('per_page', 15);
            $announcements = $query->paginate($perPage);

            return response()->json([
                'success' => true,
                'data' => $announcements
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch announcements',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Store a newly created announcement.
     */
    public function store(Request $request)
    {
        try {
            $validator = Validator::make($request->all(), [
                'title' => 'required|string|max:255',
                'message' => 'required|string',
                'priority' => 'sometimes|in:Low,Moderate,Urgent',
                'start_date' => 'required|date',
                'end_date' => 'required|date|after_or_equal:start_date',
                'status' => 'sometimes|in:Draft,Active,Expired,Archived',
                'date_posted' => 'sometimes|date',
                'attachments' => 'nullable|array',
                'attachments.*' => 'string', // Accept URLs as strings
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Validation error',
                    'errors' => $validator->errors()
                ], 422);
            }

            $data = $request->all();

            // Generate announcement ID
            $data['announcement_id'] = Announcement::generateAnnouncementId();

            // Set created_by_id to authenticated user
            $data['created_by_id'] = auth()->id();

            // Set default date_posted to today if not provided
            if (!isset($data['date_posted'])) {
                $data['date_posted'] = now()->toDateString();
            }

            // Attachments are already URLs from pre-upload
            if (!isset($data['attachments'])) {
                $data['attachments'] = [];
            }

            $announcement = Announcement::create($data);

            return response()->json([
                'success' => true,
                'message' => 'Announcement created successfully',
                'data' => $announcement->load('createdBy')
            ], 201);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to create announcement',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Display the specified announcement.
     */
    public function show($id)
    {
        try {
            $announcement = Announcement::with('createdBy')->find($id);

            if (!$announcement) {
                return response()->json([
                    'success' => false,
                    'message' => 'Announcement not found'
                ], 404);
            }

            // Auto-update status if expired
            $announcement->updateStatusBasedOnDates();

            return response()->json([
                'success' => true,
                'data' => $announcement
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch announcement',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Update the specified announcement.
     */
    public function update(Request $request, $id)
    {
        try {
            $announcement = Announcement::find($id);

            if (!$announcement) {
                return response()->json([
                    'success' => false,
                    'message' => 'Announcement not found'
                ], 404);
            }

            $validator = Validator::make($request->all(), [
                'title' => 'sometimes|string|max:255',
                'message' => 'sometimes|string',
                'priority' => 'sometimes|in:Low,Moderate,Urgent',
                'start_date' => 'sometimes|date',
                'end_date' => 'sometimes|date|after_or_equal:start_date',
                'status' => 'sometimes|in:Draft,Active,Expired,Archived',
                'date_posted' => 'sometimes|date',
                'attachments' => 'nullable|array',
                'attachments.*' => 'string', // Accept URLs as strings
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Validation error',
                    'errors' => $validator->errors()
                ], 422);
            }

            $data = $request->all();

            // Attachments are already URLs from pre-upload
            // If not provided, keep existing attachments
            if (!isset($data['attachments'])) {
                unset($data['attachments']);
            }

            $announcement->update($data);

            return response()->json([
                'success' => true,
                'message' => 'Announcement updated successfully',
                'data' => $announcement->load('createdBy')
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to update announcement',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Remove the specified announcement (soft delete).
     */
    public function destroy($id)
    {
        try {
            $announcement = Announcement::find($id);

            if (!$announcement) {
                return response()->json([
                    'success' => false,
                    'message' => 'Announcement not found'
                ], 404);
            }

            $announcement->delete();

            return response()->json([
                'success' => true,
                'message' => 'Announcement deleted successfully'
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to delete announcement',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Update announcement status.
     */
    public function updateStatus(Request $request, $id)
    {
        try {
            $announcement = Announcement::find($id);

            if (!$announcement) {
                return response()->json([
                    'success' => false,
                    'message' => 'Announcement not found'
                ], 404);
            }

            $validator = Validator::make($request->all(), [
                'status' => 'required|in:Draft,Active,Expired,Archived',
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Validation error',
                    'errors' => $validator->errors()
                ], 422);
            }

            $announcement->update(['status' => $request->status]);

            return response()->json([
                'success' => true,
                'message' => 'Announcement status updated successfully',
                'data' => $announcement->load('createdBy')
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to update announcement status',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Get announcement statistics.
     */
    public function statistics()
    {
        try {
            $stats = [
                'total' => Announcement::count(),
                'by_status' => [
                    'draft' => Announcement::status('Draft')->count(),
                    'active' => Announcement::status('Active')->count(),
                    'expired' => Announcement::status('Expired')->count(),
                    'archived' => Announcement::status('Archived')->count(),
                ],
                'by_priority' => [
                    'low' => Announcement::priority('Low')->count(),
                    'moderate' => Announcement::priority('Moderate')->count(),
                    'urgent' => Announcement::priority('Urgent')->count(),
                ],
                'currently_active' => Announcement::active()->count(),
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
     * Delete attachment from announcement
     */
    public function deleteAttachment(Request $request, $id)
    {
        try {
            $announcement = Announcement::find($id);

            if (!$announcement) {
                return response()->json([
                    'success' => false,
                    'message' => 'Announcement not found'
                ], 404);
            }

            $validator = Validator::make($request->all(), [
                'filename' => 'required|string',
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Validation error',
                    'errors' => $validator->errors()
                ], 422);
            }

            $attachments = $announcement->attachments ?? [];
            $filename = $request->filename;

            // Remove from array
            $attachments = array_filter($attachments, function($file) use ($filename) {
                return $file !== $filename;
            });

            // Delete physical file
            $filePath = public_path('uploads/announcements/' . $filename);
            if (File::exists($filePath)) {
                File::delete($filePath);
            }

            $announcement->update(['attachments' => array_values($attachments)]);

            return response()->json([
                'success' => true,
                'message' => 'Attachment deleted successfully',
                'data' => $announcement
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to delete attachment',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}

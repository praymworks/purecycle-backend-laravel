<?php

namespace App\Http\Controllers;

use App\Models\Route;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class RouteController extends Controller
{
    /**
     * Display a listing of routes.
     * Supports filtering by status, municipality, province
     * Supports search by name or description
     */
    public function index(Request $request)
    {
        try {
            $query = Route::with('createdBy');

            // Filter by status
            if ($request->has('status') && $request->status != '') {
                $query->status($request->status);
            }

            // Filter by municipality
            if ($request->has('municipality') && $request->municipality != '') {
                $query->municipality($request->municipality);
            }

            // Filter by province
            if ($request->has('province') && $request->province != '') {
                $query->province($request->province);
            }

            // Search by name or description
            if ($request->has('search') && $request->search != '') {
                $search = $request->search;
                $query->where(function($q) use ($search) {
                    $q->where('name', 'like', "%{$search}%")
                      ->orWhere('description', 'like', "%{$search}%")
                      ->orWhere('route_id', 'like', "%{$search}%");
                });
            }

            // Sort by created_at (newest first by default)
            $sortBy = $request->get('sort_by', 'created_at');
            $sortOrder = $request->get('sort_order', 'desc');
            $query->orderBy($sortBy, $sortOrder);

            // Pagination
          
            $routes = $query->get();

            return response()->json([
                'success' => true,
                'data' => $routes
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch routes',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Store a newly created route.
     */
    public function store(Request $request)
    {
        try {
            $validator = Validator::make($request->all(), [
                'name' => 'required|string|max:255',
                'description' => 'nullable|string',
                'municipality' => 'required|string|max:255',
                'province' => 'required|string|max:255',
                'status' => 'sometimes|in:active,inactive,under_maintenance',
                'color' => 'nullable|string|max:7', // Hex color
                'waypoints' => 'required|array|min:2',
                'waypoints.*.id' => 'required|string',
                'waypoints.*.name' => 'nullable|string',
                'waypoints.*.barangay' => 'nullable|string',
                'waypoints.*.lat' => 'required|numeric',
                'waypoints.*.lng' => 'required|numeric',
                'waypoints.*.address' => 'nullable|string',
                'waypoints.*.type' => 'nullable|in:start,pickup,end',
                'waypoints.*.order' => 'nullable|integer',
                'distance' => 'nullable|string',
                'estimated_duration' => 'nullable|string',
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Validation error',
                    'errors' => $validator->errors()
                ], 422);
            }

            $data = $validator->validated();

            // Generate route ID
            $data['route_id'] = Route::generateRouteId();

            // Set created_by_id to authenticated user
            $data['created_by_id'] = auth()->id();

            $route = Route::create($data);

            return response()->json([
                'success' => true,
                'message' => 'Route created successfully',
                'data' => $route->load('createdBy')
            ], 201);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to create route',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Display the specified route.
     */
    public function show($id)
    {
        try {
            $route = Route::with('createdBy')->find($id);

            if (!$route) {
                return response()->json([
                    'success' => false,
                    'message' => 'Route not found'
                ], 404);
            }

            return response()->json([
                'success' => true,
                'data' => $route
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch route',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Update the specified route.
     */
    public function update(Request $request, $id)
    {
        try {
            $route = Route::where('route_id', $id)->firstOrFail();

            if (!$route) {
                return response()->json([
                    'success' => false,
                    'message' => 'Route not found'
                ], 404);
            }

            $validator = Validator::make($request->all(), [
                'name' => 'sometimes|string|max:255',
                'description' => 'nullable|string',
                'municipality' => 'sometimes|string|max:255',
                'province' => 'sometimes|string|max:255',
                'status' => 'sometimes|in:active,inactive,under_maintenance',
                'color' => 'nullable|string|max:7',
                'waypoints' => 'sometimes|array|min:2',
                'waypoints.*.id' => 'required|string',
                'waypoints.*.name' => 'required|string',
                'waypoints.*.barangay' => 'required|string',
                'waypoints.*.lat' => 'required|numeric',
                'waypoints.*.lng' => 'required|numeric',
                'waypoints.*.address' => 'required|string',
                'waypoints.*.type' => 'required|in:start,pickup,end',
                'waypoints.*.order' => 'required|integer',
                'distance' => 'nullable|string',
                'estimated_duration' => 'nullable|string',
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Validation error',
                    'errors' => $validator->errors()
                ], 422);
            }

            $data = $validator->validated();

            $route->update($data);

            return response()->json([
                'success' => true,
                'message' => 'Route updated successfully',
                'data' => $route->load('createdBy')
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to update route',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Remove the specified route (soft delete).
     */
    public function destroy($id)
    {
        try {
            $route = Route::where('route_id', $id)->firstOrFail();

            if (!$route) {
                return response()->json([
                    'success' => false,
                    'message' => 'Route not found'
                ], 404);
            }

            $route->delete();

            return response()->json([
                'success' => true,
                'message' => 'Route deleted successfully'
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to delete route',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Update route status.
     */
    public function updateStatus(Request $request, $id)
    {
        try {
            $route = Route::find($id);

            if (!$route) {
                return response()->json([
                    'success' => false,
                    'message' => 'Route not found'
                ], 404);
            }

            $validator = Validator::make($request->all(), [
                'status' => 'required|in:active,inactive,under_maintenance',
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Validation error',
                    'errors' => $validator->errors()
                ], 422);
            }

            $route->update(['status' => $request->status]);

            return response()->json([
                'success' => true,
                'message' => 'Route status updated successfully',
                'data' => $route->load('createdBy')
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to update route status',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Get route statistics.
     */
    public function statistics()
    {
        try {
            $stats = [
                'total' => Route::count(),
                'by_status' => [
                    'active' => Route::status('active')->count(),
                    'inactive' => Route::status('inactive')->count(),
                    'under_maintenance' => Route::status('under_maintenance')->count(),
                ],
                'by_municipality' => Route::selectRaw('municipality, COUNT(*) as count')
                    ->groupBy('municipality')
                    ->pluck('count', 'municipality')
                    ->toArray(),
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
     * Get waypoints for a specific route
     */
    public function getWaypoints($id)
    {
        try {
            $route = Route::find($id);

            if (!$route) {
                return response()->json([
                    'success' => false,
                    'message' => 'Route not found'
                ], 404);
            }

            return response()->json([
                'success' => true,
                'data' => [
                    'route_id' => $route->route_id,
                    'route_name' => $route->name,
                    'total_waypoints' => $route->getTotalWaypoints(),
                    'total_pickup_points' => $route->getTotalPickupPoints(),
                    'waypoints' => $route->waypoints
                ]
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch waypoints',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}

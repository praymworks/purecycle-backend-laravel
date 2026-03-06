<?php

namespace App\Http\Controllers;

use App\Models\Permission;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class PermissionController extends Controller
{
    /**
     * Get all permissions
     */
    public function index(Request $request)
    {
        $query = Permission::query();

        // Filter by module
        if ($request->has('module')) {
            $query->where('module', $request->module);
        }

        // Filter by status
        if ($request->has('status')) {
            $query->where('status', $request->status);
        }

        $permissions = $query->get();

        return response()->json([
            'success' => true,
            'data' => $permissions
        ], 200);
    }

    /**
     * Get permissions grouped by module
     */
    public function byModule()
    {
        $permissions = Permission::all()->groupBy('module');

        return response()->json([
            'success' => true,
            'data' => $permissions
        ], 200);
    }

    /**
     * Get a single permission by ID
     */
    public function show($id)
    {
        $permission = Permission::find($id);

        if (!$permission) {
            return response()->json([
                'success' => false,
                'message' => 'Permission not found'
            ], 404);
        }

        return response()->json([
            'success' => true,
            'data' => $permission
        ], 200);
    }

    /**
     * Create a new permission
     */
    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:255',
            'slug' => 'required|string|unique:permissions,slug',
            'module' => 'required|string',
            'description' => 'nullable|string',
            'status' => 'nullable|in:active,inactive,maintenance,unavailable,bug',
            'icon' => 'nullable|string'
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Validation error',
                'errors' => $validator->errors()
            ], 422);
        }

        $permission = Permission::create($request->all());

        return response()->json([
            'success' => true,
            'message' => 'Permission created successfully',
            'data' => $permission
        ], 201);
    }

    /**
     * Update a permission
     */
    public function update(Request $request, $id)
    {
        $permission = Permission::find($id);

        if (!$permission) {
            return response()->json([
                'success' => false,
                'message' => 'Permission not found'
            ], 404);
        }

        $validator = Validator::make($request->all(), [
            'name' => 'sometimes|required|string|max:255',
            'slug' => 'sometimes|required|string|unique:permissions,slug,' . $id,
            'module' => 'sometimes|required|string',
            'description' => 'nullable|string',
            'status' => 'nullable|in:active,inactive,maintenance,unavailable,bug',
            'icon' => 'nullable|string'
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Validation error',
                'errors' => $validator->errors()
            ], 422);
        }

        $permission->update($request->all());

        return response()->json([
            'success' => true,
            'message' => 'Permission updated successfully',
            'data' => $permission
        ], 200);
    }

    /**
     * Delete a permission
     */
    public function destroy($id)
    {
        $permission = Permission::find($id);

        if (!$permission) {
            return response()->json([
                'success' => false,
                'message' => 'Permission not found'
            ], 404);
        }

        $permission->delete();

        return response()->json([
            'success' => true,
            'message' => 'Permission deleted successfully'
        ], 200);
    }
}

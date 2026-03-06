<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\PurokLeader;
use App\Models\BusinessOwner;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;

class UserController extends Controller
{
    /**
     * Get all users
     */
    public function index(Request $request)
    {
        $query = User::with(['purokLeader', 'businessOwner', 'roleDetails']);

        // Filter by role
        if ($request->has('role')) {
            $query->where('role', $request->role);
        }

        // Filter by status
        if ($request->has('status')) {
            $query->where('status', $request->status);
        }

        // Search by name or email
        if ($request->has('search')) {
            $search = $request->search;
            $query->where(function($q) use ($search) {
                $q->where('fullname', 'like', "%{$search}%")
                  ->orWhere('email', 'like', "%{$search}%");
            });
        }

        $users = $query->get();

        return response()->json([
            'success' => true,
            'data' => $users
        ], 200);
    }

    /**
     * Get a single user by ID
     */
    public function show($id)
    {
        $user = User::with(['purokLeader', 'businessOwner', 'roleDetails'])->find($id);

        if (!$user) {
            return response()->json([
                'success' => false,
                'message' => 'User not found'
            ], 404);
        }

        return response()->json([
            'success' => true,
            'data' => $user
        ], 200);
    }

    /**
     * Create a new user
     */
    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|email|unique:users,email',
            'password' => 'required|string|min:6',
            'fullname' => 'required|string|max:255',
            'contact_number' => 'required|string|max:20',
            'city_municipality' => 'required|string',
            'barangay' => 'nullable|string',
            'purok' => 'nullable|string',
            'role' => 'required|in:admin,staff,purok_leader,business_owner',
            'profile_path' => 'nullable|string',
            'status' => 'nullable|in:pending,approved,rejected,suspended',
            
            // Purok Leader specific fields
            'valid_id_document' => 'required_if:role,purok_leader,business_owner|nullable|string',
            
            // Business Owner specific fields
            'business_name' => 'required_if:role,business_owner|nullable|string',
            'business_permit' => 'nullable|string',
            'street' => 'nullable|string',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Validation error',
                'errors' => $validator->errors()
            ], 422);
        }

        // Create user
        $user = User::create([
            'email' => $request->email,
            'password' => Hash::make($request->password),
            'fullname' => $request->fullname,
            'contact_number' => $request->contact_number,
            'city_municipality' => $request->city_municipality,
            'barangay' => $request->barangay,
            'purok' => $request->purok,
            'role' => $request->role,
            'profile_path' => $request->profile_path,
            'status' => $request->status ?? 'approved',
        ]);

        // Create role-specific records
        if ($request->role === 'purok_leader') {
            PurokLeader::create([
                'user_id' => $user->id,
                'valid_id_document' => $request->valid_id_document,
            ]);
        } elseif ($request->role === 'business_owner') {
            BusinessOwner::create([
                'user_id' => $user->id,
                'business_name' => $request->business_name,
                'business_permit' => $request->business_permit,
                'street' => $request->street,
                'valid_id_document' => $request->valid_id_document,
            ]);
        }

        return response()->json([
            'success' => true,
            'message' => 'User created successfully',
            'data' => $user->load(['purokLeader', 'businessOwner'])
        ], 201);
    }

    /**
     * Update a user
     */
    public function update(Request $request, $id)
    {
        $user = User::find($id);

        if (!$user) {
            return response()->json([
                'success' => false,
                'message' => 'User not found'
            ], 404);
        }

        $validator = Validator::make($request->all(), [
            'email' => 'sometimes|required|email|unique:users,email,' . $id,
            'password' => 'sometimes|nullable|string|min:6',
            'fullname' => 'sometimes|required|string|max:255',
            'contact_number' => 'sometimes|required|string|max:20',
            'city_municipality' => 'sometimes|required|string',
            'barangay' => 'nullable|string',
            'purok' => 'nullable|string',
            'role' => 'sometimes|required|in:admin,staff,purok_leader,business_owner',
            'profile_path' => 'nullable|string',
            'status' => 'nullable|in:pending,approved,rejected,suspended',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Validation error',
                'errors' => $validator->errors()
            ], 422);
        }

        $data = $request->except(['password']);
        
        if ($request->has('password') && $request->password) {
            $data['password'] = Hash::make($request->password);
        }

        $user->update($data);

        // Update role-specific records
        if ($request->has('valid_id_document') && $user->role === 'purok_leader') {
            $user->purokLeader()->updateOrCreate(
                ['user_id' => $user->id],
                ['valid_id_document' => $request->valid_id_document]
            );
        }

        if ($user->role === 'business_owner') {
            $user->businessOwner()->updateOrCreate(
                ['user_id' => $user->id],
                [
                    'business_name' => $request->business_name ?? $user->businessOwner->business_name,
                    'business_permit' => $request->business_permit,
                    'street' => $request->street,
                    'valid_id_document' => $request->valid_id_document,
                ]
            );
        }

        return response()->json([
            'success' => true,
            'message' => 'User updated successfully',
            'data' => $user->load(['purokLeader', 'businessOwner'])
        ], 200);
    }

    /**
     * Delete a user
     */
    public function destroy($id)
    {
        $user = User::find($id);

        if (!$user) {
            return response()->json([
                'success' => false,
                'message' => 'User not found'
            ], 404);
        }

        $user->delete();

        return response()->json([
            'success' => true,
            'message' => 'User deleted successfully'
        ], 200);
    }

    /**
     * Approve a user
     */
    public function approve($id)
    {
        $user = User::find($id);

        if (!$user) {
            return response()->json([
                'success' => false,
                'message' => 'User not found'
            ], 404);
        }

        $user->update(['status' => 'approved']);

        return response()->json([
            'success' => true,
            'message' => 'User approved successfully',
            'data' => $user
        ], 200);
    }

    /**
     * Reject a user
     */
    public function reject($id)
    {
        $user = User::find($id);

        if (!$user) {
            return response()->json([
                'success' => false,
                'message' => 'User not found'
            ], 404);
        }

        $user->update(['status' => 'rejected']);

        return response()->json([
            'success' => true,
            'message' => 'User rejected successfully',
            'data' => $user
        ], 200);
    }

    /**
     * Suspend a user
     */
    public function suspend($id)
    {
        $user = User::find($id);

        if (!$user) {
            return response()->json([
                'success' => false,
                'message' => 'User not found'
            ], 404);
        }

        $user->update(['status' => 'suspended']);

        return response()->json([
            'success' => true,
            'message' => 'User suspended successfully',
            'data' => $user
        ], 200);
    }

    /**
     * Reset user password (Admin/Staff only)
     */
    public function resetPassword($id)
    {
        $user = User::find($id);

        if (!$user) {
            return response()->json([
                'success' => false,
                'message' => 'User not found'
            ], 404);
        }

        // Generate a new random password
        $newPassword = Str::random(12);
        
        // Update user password
        $user->update([
            'password' => Hash::make($newPassword)
        ]);

        return response()->json([
            'success' => true,
            'message' => 'Password reset successfully',
            'data' => [
                'user_id' => $user->id,
                'new_password' => $newPassword, // Return the new password
                'note' => 'Please provide this password to the user securely'
            ]
        ], 200);
    }

    /**
     * Update profile (for authenticated user)
     */
    public function updateProfile(Request $request)
    {
        $user = auth()->user();

        if (!$user) {
            return response()->json([
                'success' => false,
                'message' => 'User not found'
            ], 404);
        }

        $validator = Validator::make($request->all(), [
            'fullname' => 'sometimes|required|string|max:255',
            'email' => 'sometimes|required|email|unique:users,email,' . $user->id,
            'contact_number' => 'sometimes|required|string|max:20',
            'city_municipality' => 'sometimes|required|string',
            'barangay' => 'sometimes|required|string',
            'purok' => 'sometimes|required|string',
            'profile_path' => 'sometimes|nullable|string',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Validation error',
                'errors' => $validator->errors()
            ], 422);
        }

        // Update only fields that are provided
        $user->update($request->only([
            'fullname',
            'email',
            'contact_number',
            'city_municipality',
            'barangay',
            'purok',
            'profile_path'
        ]));

        return response()->json([
            'success' => true,
            'message' => 'Profile updated successfully',
            'data' => $user
        ], 200);
    }

    /**
     * Change password (for authenticated user)
     */
    public function changePassword(Request $request)
    {
        $user = auth()->user();

        if (!$user) {
            return response()->json([
                'success' => false,
                'message' => 'User not found'
            ], 404);
        }

        $validator = Validator::make($request->all(), [
            'current_password' => 'required|string',
            'new_password' => 'required|string|min:8|confirmed',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Validation error',
                'errors' => $validator->errors()
            ], 422);
        }

        // Check if current password matches
        if (!Hash::check($request->current_password, $user->password)) {
            return response()->json([
                'success' => false,
                'message' => 'Current password is incorrect',
                'errors' => ['current_password' => ['Current password is incorrect']]
            ], 422);
        }

        // Update password
        $user->update([
            'password' => Hash::make($request->new_password)
        ]);

        return response()->json([
            'success' => true,
            'message' => 'Password changed successfully'
        ], 200);
    }
}

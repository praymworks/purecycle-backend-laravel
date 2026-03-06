<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\PurokLeader;
use App\Models\BusinessOwner;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Tymon\JWTAuth\Facades\JWTAuth;

class AuthController extends Controller
{
    /**
     * Login user and return JWT token
     */
    public function login(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|email',
            'password' => 'required|string|min:6',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Validation error',
                'errors' => $validator->errors()
            ], 422);
        }

        // Check if user exists
        $user = User::where('email', $request->email)->first();
        
        if (!$user) {
            return response()->json([
                'success' => false,
                'message' => 'User or Email not exist'
            ], 404);
        }

        // Check password
        if (!Hash::check($request->password, $user->password)) {
            return response()->json([
                'success' => false,
                'message' => 'Wrong password'
            ], 401);
        }

        // Attempt JWT authentication
        $credentials = $request->only('email', 'password');
        $token = JWTAuth::attempt($credentials);

        // Check if user is approved
        if ($user->status !== 'approved') {
            return response()->json([
                'success' => false,
                'message' => 'Your account is ' . $user->status . '. Please wait for approval.'
            ], 403);
        }

        // Load additional data based on role
        $userData = $user->toArray();
        
        if ($user->role === 'purok_leader') {
            $userData['purok_leader_details'] = $user->purokLeader;
        } elseif ($user->role === 'business_owner') {
            $userData['business_owner_details'] = $user->businessOwner;
        }

        return response()->json([
            'success' => true,
            'message' => 'Login successful',
            'data' => [
                'token' => $token,
                'token_type' => 'bearer',
                'expires_in' => JWTAuth::factory()->getTTL() * 60,
                'user' => $userData
            ]
        ], 200);
    }

    /**
     * Register a new user
     */
    public function register(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|email|unique:users,email',
            'password' => 'required|string|min:6|confirmed',
            'fullname' => 'required|string|max:255',
            'contact_number' => 'required|string|max:20',
            'city_municipality' => 'required|string',
            'barangay' => 'nullable|string',
            'purok' => 'nullable|string',
            'role' => 'required|in:admin,staff,purok_leader,business_owner',
            'profile_path' => 'nullable|string',
            
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
            'status' => in_array($request->role, ['admin', 'staff']) ? 'approved' : 'pending',
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
            'message' => 'User registered successfully',
            'data' => [
                'user' => $user
            ]
        ], 201);
    }

    /**
     * Get authenticated user details
     */
    public function me()
    {
        $user = auth()->user();
        
        $userData = $user->toArray();
        
        if ($user->role === 'purok_leader') {
            $userData['purok_leader_details'] = $user->purokLeader;
        } elseif ($user->role === 'business_owner') {
            $userData['business_owner_details'] = $user->businessOwner;
        }

        $userData['role_details'] = $user->roleDetails;

        return response()->json([
            'success' => true,
            'data' => $userData
        ], 200);
    }

    /**
     * Logout user (invalidate token)
     */
    public function logout()
    {
        JWTAuth::invalidate(JWTAuth::getToken());

        return response()->json([
            'success' => true,
            'message' => 'Logout successful'
        ], 200);
    }

    /**
     * Refresh JWT token
     */
    public function refresh()
    {
        $newToken = JWTAuth::refresh(JWTAuth::getToken());

        return response()->json([
            'success' => true,
            'data' => [
                'token' => $newToken,
                'token_type' => 'bearer',
                'expires_in' => JWTAuth::factory()->getTTL() * 60
            ]
        ], 200);
    }
}

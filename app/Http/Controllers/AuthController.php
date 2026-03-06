<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\PurokLeader;
use App\Models\BusinessOwner;
use App\Models\Notification;
use App\Models\AuditLog;
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
        if ($user->status === 'pending') {
            return response()->json([
                'success' => false,
                'message' => 'Your account is pending approval. Please wait for admin confirmation.'
            ], 403);
        }

        if ($user->status === 'rejected') {
            return response()->json([
                'success' => false,
                'message' => 'Your account has been rejected. Please contact support for more information.'
            ], 403);
        }

        if ($user->status === 'suspended') {
            return response()->json([
                'success' => false,
                'message' => 'Your account has been suspended. Please contact support.'
            ], 403);
        }

        if ($user->status !== 'approved') {
            return response()->json([
                'success' => false,
                'message' => 'Your account status is ' . $user->status . '. Please contact support.'
            ], 403);
        }

        // Check if user role is allowed (admin or staff only for admin portal)
        if (!in_array($user->role, ['admin', 'staff'])) {
            // Log unauthorized access attempt
            $this->logUnauthorizedAccess($user);
            
            // Notify admins about unauthorized access attempt
            $this->notifyAdminsAboutUnauthorizedAccess($user);
            
            return response()->json([
                'success' => false,
                'message' => 'Access denied. Only administrators and staff can access this portal.'
            ], 403);
        }

        // Load additional data based on role
        $userData = $user->toArray();
        
        if ($user->role === 'purok_leader') {
            $userData['purok_leader_details'] = $user->purokLeader;
        } elseif ($user->role === 'business_owner') {
            $userData['business_owner_details'] = $user->businessOwner;
        }

        // IMPORTANT: Include role_details with permissions for frontend permission checking
        // Load role with permissions relationship
        $userData['role_details'] = $user->roleDetails()->with('permissions')->first();

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

        // Notify admins and staff about new registration
        $this->notifyAdminsAboutNewUser($user);

        return response()->json([
            'success' => true,
            'message' => 'User registered successfully. Please wait for admin approval.',
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

        // Load role with permissions relationship
        $userData['role_details'] = $user->roleDetails()->with('permissions')->first();

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

    /**
     * Notify admins and staff about new user registration
     */
    private function notifyAdminsAboutNewUser($user)
    {
        try {
            // Get all admin and staff users
            $adminAndStaffIds = User::whereIn('role', ['admin', 'staff'])->pluck('id')->toArray();

            if (empty($adminAndStaffIds)) {
                return; // No admins or staff to notify
            }

            // Determine user type for display
            $userTypeDisplay = match($user->role) {
                'purok_leader' => 'Purok Leader',
                'business_owner' => 'Business Owner',
                'admin' => 'Admin',
                'staff' => 'Staff',
                default => 'User'
            };

            // Create notification data
            $notificationData = [
                'title' => 'New User Registration',
                'message' => "A new {$userTypeDisplay} has registered: {$user->fullname}",
                'description' => "Email: {$user->email} | Location: {$user->purok}, {$user->barangay}, {$user->city_municipality} | Status: Pending Approval",
                'type' => 'account',
                'priority' => 'medium',
                'action_url' => "/users",
                'metadata' => [
                    'user_id' => $user->id,
                    'user_role' => $user->role,
                    'user_email' => $user->email,
                    'action' => 'registration',
                    'status' => $user->status,
                ],
                'triggered_by_id' => $user->id,
            ];

            // Send notification to all admins and staff
            Notification::notify($adminAndStaffIds, $notificationData);

        } catch (\Exception $e) {
            // Log error but don't fail the registration
            \Log::error('Failed to send registration notification: ' . $e->getMessage());
        }
    }

    /**
     * Log unauthorized access attempt to audit logs
     */
    private function logUnauthorizedAccess($user)
    {
        try {
            AuditLog::create([
                'user_id' => $user->id,
                'action' => 'unauthorized_login_attempt',
                'model' => 'User',
                'model_id' => $user->id,
                'details' => json_encode([
                    'user_email' => $user->email,
                    'user_role' => $user->role,
                    'user_fullname' => $user->fullname,
                    'attempted_portal' => 'Admin Portal',
                    'reason' => 'Role not allowed (only admin and staff can access)',
                    'ip_address' => request()->ip(),
                    'user_agent' => request()->userAgent(),
                ]),
                'ip_address' => request()->ip(),
            ]);
        } catch (\Exception $e) {
            \Log::error('Failed to log unauthorized access: ' . $e->getMessage());
        }
    }

    /**
     * Notify admins about unauthorized access attempt
     */
    private function notifyAdminsAboutUnauthorizedAccess($user)
    {
        try {
            // Get all admin users only (not staff)
            $adminIds = User::where('role', 'admin')->pluck('id')->toArray();

            if (empty($adminIds)) {
                return;
            }

            // Determine user type for display
            $userTypeDisplay = match($user->role) {
                'purok_leader' => 'Purok Leader',
                'business_owner' => 'Business Owner',
                default => 'User'
            };

            // Create notification data
            $notificationData = [
                'title' => '⚠️ Unauthorized Access Attempt',
                'message' => "{$userTypeDisplay} ({$user->fullname}) tried to access the Admin Portal",
                'description' => "Email: {$user->email} | Role: {$user->role} | This user is not authorized to access the admin portal. Only admins and staff are allowed.",
                'type' => 'system',
                'priority' => 'high',
                'action_url' => "/users",
                'metadata' => [
                    'user_id' => $user->id,
                    'user_email' => $user->email,
                    'user_role' => $user->role,
                    'user_fullname' => $user->fullname,
                    'action' => 'unauthorized_access_attempt',
                    'ip_address' => request()->ip(),
                ],
                'triggered_by_id' => $user->id,
            ];

            // Send notification to admins only
            Notification::notify($adminIds, $notificationData);

        } catch (\Exception $e) {
            \Log::error('Failed to send unauthorized access notification: ' . $e->getMessage());
        }
    }
}

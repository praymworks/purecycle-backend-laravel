<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use App\Models\AuditLog;
use Symfony\Component\HttpFoundation\Response;

class AuditLogMiddleware
{
    /**
     * Handle an incoming request and log it to audit trail
     */
    public function handle(Request $request, Closure $next): Response
    {
        $response = $next($request);

        // Only log authenticated requests
        if (auth()->check()) {
            try {
                $this->logRequest($request, $response);
            } catch (\Exception $e) {
                // Don't break the request if logging fails
                \Log::error('Audit log failed: ' . $e->getMessage());
            }
        }

        return $response;
    }

    /**
     * Log the request to audit trail
     */
    private function logRequest(Request $request, Response $response)
    {
        $method = $request->method();
        $path = $request->path();
        $statusCode = $response->getStatusCode();
        
        // Skip logging for certain paths
        if ($this->shouldSkipLogging($path)) {
            return;
        }

        // Determine action and module based on request
        $action = $this->determineAction($method, $path);
        $module = $this->determineModule($path);
        $description = $this->generateDescription($method, $path, $request);
        $status = $statusCode >= 200 && $statusCode < 300 ? 'success' : 'failed';

        AuditLog::create([
            'user_id' => auth()->id(),
            'user_name' => auth()->user()->fullname,
            'user_role' => ucfirst(str_replace('_', ' ', auth()->user()->role)),
            'action' => $action,
            'module' => $module,
            'description' => $description,
            'ip_address' => $request->ip(),
            'status' => $status,
        ]);
    }

    /**
     * Determine if we should skip logging this path
     */
    private function shouldSkipLogging($path)
    {
        $skipPaths = [
            'api/settings/audit-logs',  // Don't log when viewing audit logs
            'api/notifications/unread-count', // Don't log badge checks
            'sanctum/csrf-cookie',
        ];

        foreach ($skipPaths as $skipPath) {
            if (str_contains($path, $skipPath)) {
                return true;
            }
        }

        return false;
    }

    /**
     * Determine the action based on HTTP method and path
     */
    private function determineAction($method, $path)
    {
        // Special cases
        if (str_contains($path, 'login')) return 'Login';
        if (str_contains($path, 'logout')) return 'Logout';
        if (str_contains($path, 'register')) return 'Register';
        if (str_contains($path, 'export')) return 'Export';
        if (str_contains($path, 'backup')) return 'Backup';
        if (str_contains($path, 'approve')) return 'Approve';
        if (str_contains($path, 'reject')) return 'Reject';
        if (str_contains($path, 'suspend')) return 'Suspend';
        if (str_contains($path, 'mark-read')) return 'Mark Read';
        if (str_contains($path, 'assign-driver')) return 'Assign Driver';

        // General HTTP method mapping
        return match($method) {
            'GET' => 'View',
            'POST' => 'Create',
            'PUT', 'PATCH' => 'Update',
            'DELETE' => 'Delete',
            default => 'Access',
        };
    }

    /**
     * Determine the module based on the path
     */
    private function determineModule($path)
    {
        if (str_contains($path, 'auth')) return 'Authentication';
        if (str_contains($path, 'user')) return 'User Management';
        if (str_contains($path, 'role')) return 'Role Management';
        if (str_contains($path, 'permission')) return 'Permission Management';
        if (str_contains($path, 'report')) return 'Reports Management';
        if (str_contains($path, 'announcement')) return 'Announcements';
        if (str_contains($path, 'route')) return 'Routes Management';
        if (str_contains($path, 'schedule')) return 'Schedules Management';
        if (str_contains($path, 'analytics')) return 'Analytics';
        if (str_contains($path, 'notification')) return 'Notifications';
        if (str_contains($path, 'setting')) return 'System Settings';
        if (str_contains($path, 'export')) return 'Data Export';
        if (str_contains($path, 'upload')) return 'File Upload';

        return 'System';
    }

    /**
     * Generate a human-readable description
     */
    private function generateDescription($method, $path, $request)
    {
        $action = $this->determineAction($method, $path);
        $module = $this->determineModule($path);

        // Extract ID from path if exists
        $id = $this->extractIdFromPath($path);
        
        // Build description
        $description = "{$action} in {$module}";
        
        if ($id) {
            $description .= " (ID: {$id})";
        }

        // Add specific details for certain actions
        if ($method === 'POST' && str_contains($path, 'login')) {
            $userRole = auth()->user()->role ?? 'Unknown';
            $userEmail = auth()->user()->email ?? 'Unknown';
            
            if (in_array($userRole, ['admin', 'staff'])) {
                $description = "User logged into the admin portal";
            } else {
                // This should not happen due to AuthController blocking, but just in case
                $description = "User ({$userEmail}) attempted to login to admin portal";
            }
        } elseif ($method === 'POST' && str_contains($path, 'logout')) {
            $description = "User logged out from the system";
        } elseif ($method === 'POST' && str_contains($path, 'register')) {
            $description = "New user registration";
        } elseif ($method === 'GET' && str_contains($path, 'dashboard')) {
            $description = "Accessed Dashboard page";
        } elseif (str_contains($path, 'export')) {
            $exportType = $this->getExportType($path);
            $description = "Exported {$exportType} report";
        } elseif (str_contains($path, 'backup')) {
            $description = "Created database backup";
        } elseif (str_contains($path, 'maintenance')) {
            $description = "Changed system maintenance mode";
        }

        return $description;
    }

    /**
     * Extract ID from path
     */
    private function extractIdFromPath($path)
    {
        // Match patterns like /users/123 or /reports/456
        if (preg_match('/\/(\d+)(?:\/|$)/', $path, $matches)) {
            return $matches[1];
        }
        return null;
    }

    /**
     * Get export type from path
     */
    private function getExportType($path)
    {
        if (str_contains($path, 'collections')) return 'Collections';
        if (str_contains($path, 'reports')) return 'Reports';
        if (str_contains($path, 'route-performance')) return 'Route Performance';
        if (str_contains($path, 'users')) return 'Users';
        if (str_contains($path, 'analytics')) return 'Analytics';
        return 'Data';
    }
}

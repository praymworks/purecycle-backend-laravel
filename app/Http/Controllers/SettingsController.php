<?php

namespace App\Http\Controllers;

use App\Models\AuditLog;
use App\Models\SystemSetting;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\DB;

class SettingsController extends Controller
{
    /**
     * Get recent activity (latest 3 audit logs for dashboard)
     */
    public function getRecentActivity()
    {
        try {
            $activities = AuditLog::with('user')
                ->orderBy('created_at', 'desc')
                ->limit(3)
                ->get()
                ->map(function($log) {
                    return [
                        'id' => $log->id,
                        'user' => $log->user_name,
                        'role' => $log->user?->role ? ucwords(str_replace('_', ' ', $log->user->role)) : 'Unknown',
                        'action' => $log->description,
                        'time' => $log->created_at->diffForHumans(),
                        'badge' => $log->status === 'success' ? 'approved' : ($log->status === 'failed' ? 'rejected' : 'pending'),
                        'module' => $log->module,
                        'created_at' => $log->created_at->toDateTimeString()
                    ];
                });

            return response()->json([
                'success' => true,
                'data' => $activities
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch recent activity',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Get all audit logs
     */
    public function getAuditLogs(Request $request)
    {
        try {
            $query = AuditLog::with('user');

            // Filter by module
            if ($request->has('module') && $request->module != '') {
                $query->where('module', $request->module);
            }

            // Filter by action
            if ($request->has('action') && $request->action != '') {
                $query->where('action', $request->action);
            }

            // Filter by status
            if ($request->has('status') && $request->status != '') {
                $query->where('status', $request->status);
            }

            // Filter by user
            if ($request->has('user_id') && $request->user_id != '') {
                $query->where('user_id', $request->user_id);
            }

            // Search
            if ($request->has('search') && $request->search != '') {
                $search = $request->search;
                $query->where(function($q) use ($search) {
                    $q->where('user_name', 'like', "%{$search}%")
                      ->orWhere('description', 'like', "%{$search}%")
                      ->orWhere('module', 'like', "%{$search}%");
                });
            }

            // Sort by timestamp (newest first by default)
            $sortBy = $request->get('sort_by', 'created_at');
            $sortOrder = $request->get('sort_order', 'desc');
            $query->orderBy($sortBy, $sortOrder);

            // Pagination
            $perPage = $request->get('per_page', 15);
            $logs = $query->paginate($perPage);

            return response()->json([
                'success' => true,
                'data' => $logs
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch audit logs',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Get maintenance mode status
     */
    public function getMaintenanceMode()
    {
        try {
            $isMaintenanceMode = SystemSetting::get('maintenance_mode', false);
            $message = SystemSetting::get('maintenance_message', 'System is currently under maintenance.');

            return response()->json([
                'success' => true,
                'data' => [
                    'maintenance_mode' => $isMaintenanceMode,
                    'maintenance_message' => $message,
                ]
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to get maintenance mode',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Update maintenance mode
     */
    public function updateMaintenanceMode(Request $request)
    {
        try {
            $validator = Validator::make($request->all(), [
                'maintenance_mode' => 'required|boolean',
                'maintenance_message' => 'nullable|string',
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Validation error',
                    'errors' => $validator->errors()
                ], 422);
            }

            SystemSetting::set('maintenance_mode', $request->maintenance_mode ? 'true' : 'false', 'boolean');
            
            if ($request->has('maintenance_message')) {
                SystemSetting::set('maintenance_message', $request->maintenance_message, 'string');
            }

            // Log the action
            AuditLog::log(
                'Update',
                'System Settings',
                'Changed site maintenance mode to ' . ($request->maintenance_mode ? 'ON' : 'OFF')
            );

            return response()->json([
                'success' => true,
                'message' => 'Maintenance mode updated successfully',
                'data' => [
                    'maintenance_mode' => $request->maintenance_mode,
                    'maintenance_message' => $request->maintenance_message ?? SystemSetting::get('maintenance_message'),
                ]
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to update maintenance mode',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Create database backup
     */
    public function createBackup()
    {
        try {
            $filename = 'backup_' . date('Y-m-d_His') . '.sql';
            $uploadPath = public_path('uploads/backups');
            
            // Create directory if not exists
            if (!File::exists($uploadPath)) {
                File::makeDirectory($uploadPath, 0755, true);
            }

            $filePath = $uploadPath . '/' . $filename;

            // Get database configuration
            $host = config('database.connections.mysql.host');
            $database = config('database.connections.mysql.database');
            $username = config('database.connections.mysql.username');
            $password = config('database.connections.mysql.password');

            // Create backup using mysqldump
            $command = sprintf(
                'mysqldump --user=%s --password=%s --host=%s %s > %s',
                escapeshellarg($username),
                escapeshellarg($password),
                escapeshellarg($host),
                escapeshellarg($database),
                escapeshellarg($filePath)
            );

            exec($command, $output, $returnVar);

            if ($returnVar !== 0) {
                // Fallback: Create a simple SQL export using Laravel
                $this->createLaravelBackup($filePath);
            }

            // Get file size
            $fileSize = File::exists($filePath) ? File::size($filePath) : 0;

            // Log the action
            AuditLog::log('Export', 'System Settings', 'Created database backup: ' . $filename);

            return response()->json([
                'success' => true,
                'message' => 'Database backup created successfully',
                'data' => [
                    'filename' => $filename,
                    'path' => 'uploads/backups/' . $filename,
                    'url' => url('uploads/backups/' . $filename),
                    'size' => $fileSize,
                    'created_at' => now()->toDateTimeString(),
                ]
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to create backup',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Get all database backups
     */
    public function getBackups()
    {
        try {
            $uploadPath = public_path('uploads/backups');
            
            if (!File::exists($uploadPath)) {
                return response()->json([
                    'success' => true,
                    'data' => []
                ], 200);
            }

            $files = File::files($uploadPath);
            $backups = [];

            foreach ($files as $file) {
                if ($file->getExtension() === 'sql') {
                    $backups[] = [
                        'filename' => $file->getFilename(),
                        'path' => 'uploads/backups/' . $file->getFilename(),
                        'url' => url('uploads/backups/' . $file->getFilename()),
                        'size' => $file->getSize(),
                        'created_at' => date('Y-m-d H:i:s', $file->getMTime()),
                    ];
                }
            }

            // Sort by created_at desc
            usort($backups, function($a, $b) {
                return strtotime($b['created_at']) - strtotime($a['created_at']);
            });

            return response()->json([
                'success' => true,
                'data' => $backups
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch backups',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Delete database backup
     */
    public function deleteBackup(Request $request)
    {
        try {
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

            $filePath = public_path('uploads/backups/' . $request->filename);

            if (!File::exists($filePath)) {
                return response()->json([
                    'success' => false,
                    'message' => 'Backup file not found'
                ], 404);
            }

            File::delete($filePath);

            // Log the action
            AuditLog::log('Delete', 'System Settings', 'Deleted database backup: ' . $request->filename);

            return response()->json([
                'success' => true,
                'message' => 'Backup deleted successfully'
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to delete backup',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Get system statistics
     */
    public function getSystemStats()
    {
        try {
            $stats = [
                'total_audit_logs' => AuditLog::count(),
                'logs_today' => AuditLog::whereDate('created_at', today())->count(),
                'failed_actions' => AuditLog::where('status', 'failed')->count(),
                'total_backups' => count(File::exists(public_path('uploads/backups')) 
                    ? File::files(public_path('uploads/backups')) 
                    : []),
                'maintenance_mode' => SystemSetting::get('maintenance_mode', false),
            ];

            return response()->json([
                'success' => true,
                'data' => $stats
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch system stats',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Fallback: Create Laravel-based backup
     */
    private function createLaravelBackup($filePath)
    {
        $tables = DB::select('SHOW TABLES');
        $database = config('database.connections.mysql.database');
        $sql = "-- Database Backup: $database\n";
        $sql .= "-- Date: " . date('Y-m-d H:i:s') . "\n\n";

        foreach ($tables as $table) {
            $tableName = $table->{"Tables_in_$database"};
            
            // Get table structure
            $createTable = DB::select("SHOW CREATE TABLE `$tableName`");
            $sql .= "\n\n-- Table: $tableName\n";
            $sql .= "DROP TABLE IF EXISTS `$tableName`;\n";
            $sql .= $createTable[0]->{'Create Table'} . ";\n\n";

            // Get table data
            $rows = DB::table($tableName)->get();
            foreach ($rows as $row) {
                $row = (array) $row;
                $values = array_map(function($value) {
                    return is_null($value) ? 'NULL' : "'" . addslashes($value) . "'";
                }, $row);
                
                $sql .= "INSERT INTO `$tableName` VALUES (" . implode(', ', $values) . ");\n";
            }
        }

        File::put($filePath, $sql);
    }
}

<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\RoleController;
use App\Http\Controllers\PermissionController;
use App\Http\Controllers\ReportController;
use App\Http\Controllers\UploadController;
use App\Http\Controllers\AnnouncementController;
use App\Http\Controllers\RouteController;
use App\Http\Controllers\ScheduleController;
use App\Http\Controllers\AnalyticsController;
use App\Http\Controllers\ExportController;
use App\Http\Controllers\SettingsController;
use App\Http\Controllers\NotificationController;

// Public routes
Route::post('/auth/login', [AuthController::class, 'login']);
Route::post('/auth/register', [AuthController::class, 'register']);

// Maintenance mode check (public)
Route::get('/settings/maintenance', [SettingsController::class, 'getMaintenanceMode']);

// Upload routes (public for registration)
Route::post('/upload/valid-id', [UploadController::class, 'uploadValidId']);
Route::post('/upload/business-permit', [UploadController::class, 'uploadBusinessPermit']);
Route::post('/upload/profile-picture', [UploadController::class, 'uploadProfilePicture']);
Route::post('/upload/announcement-attachment', [UploadController::class, 'uploadAnnouncementAttachment']);
Route::post('/upload/delete', [UploadController::class, 'deleteFile']);

// Protected routes (require JWT authentication)
Route::middleware(['jwt.auth'])->group(function () {
    
    // Auth routes
    Route::post('/auth/logout', [AuthController::class, 'logout']);
    Route::post('/auth/refresh', [AuthController::class, 'refresh']);
    Route::get('/auth/me', [AuthController::class, 'me']);

    // Profile routes (authenticated user)
    Route::put('/profile', [UserController::class, 'updateProfile']);
    Route::post('/profile/change-password', [UserController::class, 'changePassword']);

    // User routes
    Route::get('/users', [UserController::class, 'index']);
    Route::get('/users/{id}', [UserController::class, 'show']);
    
    // Report routes (accessible to all authenticated users)
    Route::get('/reports', [ReportController::class, 'index']);
    Route::get('/reports/statistics', [ReportController::class, 'statistics']);
    Route::get('/reports/ranking', [ReportController::class, 'reportRanking']);
    Route::get('/reports/{id}', [ReportController::class, 'show']);
    Route::post('/reports', [ReportController::class, 'store']);
    
    // Announcement routes (accessible to all authenticated users)
    Route::get('/announcements', [AnnouncementController::class, 'index']);
    Route::get('/announcements/statistics', [AnnouncementController::class, 'statistics']);
    Route::get('/announcements/{id}', [AnnouncementController::class, 'show']);
    
    // Route management routes (accessible to all authenticated users)
    Route::get('/routes', [RouteController::class, 'index']);
    Route::get('/routes/statistics', [RouteController::class, 'statistics']);
    Route::get('/routes/{id}', [RouteController::class, 'show']);
    Route::get('/routes/{id}/waypoints', [RouteController::class, 'getWaypoints']);
    
    // Schedule management routes (accessible to all authenticated users)
    Route::get('/schedules', [ScheduleController::class, 'index']);
    Route::get('/schedules/statistics', [ScheduleController::class, 'statistics']);
    Route::get('/schedules/{id}', [ScheduleController::class, 'show']);
    
    // Analytics routes (accessible to all authenticated users)
    Route::get('/analytics/overview', [AnalyticsController::class, 'overview']);
    Route::get('/analytics/collection-stats', [AnalyticsController::class, 'collectionStats']);
    Route::get('/analytics/route-performance', [AnalyticsController::class, 'routePerformance']);
    Route::get('/analytics/report-analytics', [AnalyticsController::class, 'reportAnalytics']);
    Route::get('/analytics/user-activity', [AnalyticsController::class, 'userActivity']);
    Route::get('/analytics/dashboard', [AnalyticsController::class, 'dashboard']);
    
    // Notification routes (accessible to all authenticated users)
    Route::get('/notifications', [NotificationController::class, 'index']);
    Route::get('/notifications/unread-count', [NotificationController::class, 'getUnreadCount']);
    Route::get('/notifications/stats', [NotificationController::class, 'getStats']);
    Route::get('/notifications/{id}', [NotificationController::class, 'show']);
    Route::post('/notifications/{id}/mark-read', [NotificationController::class, 'markAsRead']);
    Route::post('/notifications/{id}/mark-unread', [NotificationController::class, 'markAsUnread']);
    Route::post('/notifications/mark-all-read', [NotificationController::class, 'markAllAsRead']);
    Route::delete('/notifications/{id}', [NotificationController::class, 'destroy']);
    Route::delete('/notifications', [NotificationController::class, 'deleteAll']);
    
    // Recent Activity (accessible to all authenticated users)
    Route::get('/settings/recent-activity', [SettingsController::class, 'getRecentActivity']);
    
    // Settings routes (Admin only)
    Route::middleware(['role:admin'])->group(function () {
        Route::get('/settings/audit-logs', [SettingsController::class, 'getAuditLogs']);
        Route::get('/settings/system-stats', [SettingsController::class, 'getSystemStats']);
        Route::post('/settings/maintenance', [SettingsController::class, 'updateMaintenanceMode']);
        Route::post('/settings/backup', [SettingsController::class, 'createBackup']);
        Route::get('/settings/backups', [SettingsController::class, 'getBackups']);
        Route::delete('/settings/backup', [SettingsController::class, 'deleteBackup']);
    });
    
    // Export routes (accessible to authenticated users)
    Route::get('/export/collections', [ExportController::class, 'exportCollections']);
    Route::get('/export/reports', [ExportController::class, 'exportReports']);
    Route::get('/export/route-performance', [ExportController::class, 'exportRoutePerformance']);
    Route::get('/export/users', [ExportController::class, 'exportUsers']);
    Route::get('/export/analytics', [ExportController::class, 'exportAnalytics']);
    Route::delete('/export/delete-file', [ExportController::class, 'deleteDownloadedFile']);
    
    // Admin and Staff only routes
    Route::middleware(['role:admin,staff'])->group(function () {
        Route::post('/users', [UserController::class, 'store']);
        Route::put('/users/{id}', [UserController::class, 'update']);
        Route::post('/users/{id}/approve', [UserController::class, 'approve']);
        Route::post('/users/{id}/reject', [UserController::class, 'reject']);
        Route::post('/users/{id}/suspend', [UserController::class, 'suspend']);
        Route::post('/users/{id}/reset-password', [UserController::class, 'resetPassword']);
        
        // Report management (Admin and Staff only)
        Route::put('/reports/{id}', [ReportController::class, 'update']);
        Route::post('/reports/{id}/status', [ReportController::class, 'updateStatus']);
        Route::delete('/reports/{id}', [ReportController::class, 'destroy']);
        
        // Announcement management (Admin and Staff only)
        Route::post('/announcements', [AnnouncementController::class, 'store']);
        Route::put('/announcements/{id}', [AnnouncementController::class, 'update']);
        Route::post('/announcements/{id}/status', [AnnouncementController::class, 'updateStatus']);
        Route::delete('/announcements/{id}', [AnnouncementController::class, 'destroy']);
        Route::post('/announcements/{id}/delete-attachment', [AnnouncementController::class, 'deleteAttachment']);
        
        // Route management (Admin and Staff only)
        Route::post('/routes', [RouteController::class, 'store']);
        Route::put('/routes/{id}', [RouteController::class, 'update']);
        Route::post('/routes/{id}/status', [RouteController::class, 'updateStatus']);
        Route::delete('/routes/{id}', [RouteController::class, 'destroy']);
        
        // Schedule management (Admin and Staff only)
        Route::post('/schedules', [ScheduleController::class, 'store']);
        Route::put('/schedules/{id}', [ScheduleController::class, 'update']);
        Route::post('/schedules/{id}/status', [ScheduleController::class, 'updateStatus']);
        Route::post('/schedules/{id}/stop-status', [ScheduleController::class, 'updateStopStatus']);
        Route::post('/schedules/{id}/assign-driver', [ScheduleController::class, 'assignDriver']);
        Route::delete('/schedules/{id}', [ScheduleController::class, 'destroy']);
        
        // Create notification (Admin and Staff only)
        Route::post('/notifications', [NotificationController::class, 'store']);
    });

    // Admin only routes
    Route::middleware(['role:admin'])->group(function () {
        Route::delete('/users/{id}', [UserController::class, 'destroy']);
        
        // Role management
        Route::get('/roles', [RoleController::class, 'index']);
        Route::get('/roles/{id}', [RoleController::class, 'show']);
        Route::post('/roles', [RoleController::class, 'store']);
        Route::put('/roles/{id}', [RoleController::class, 'update']);
        Route::delete('/roles/{id}', [RoleController::class, 'destroy']);
        Route::post('/roles/{id}/permissions/attach', [RoleController::class, 'attachPermissions']);
        Route::post('/roles/{id}/permissions/detach', [RoleController::class, 'detachPermissions']);

        // Permission management
        Route::get('/permissions', [PermissionController::class, 'index']);
        Route::get('/permissions/by-module', [PermissionController::class, 'byModule']);
        Route::get('/permissions/{id}', [PermissionController::class, 'show']);
        Route::post('/permissions', [PermissionController::class, 'store']);
        Route::put('/permissions/{id}', [PermissionController::class, 'update']);
        Route::delete('/permissions/{id}', [PermissionController::class, 'destroy']);
    });
});
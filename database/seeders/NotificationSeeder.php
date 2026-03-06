<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Notification;
use Carbon\Carbon;

class NotificationSeeder extends Seeder
{
    public function run(): void
    {
        // Admin user_id = 1, Staff user_id = 2
        $notifications = [
            // For Admin
            ['user_id' => 1, 'triggered_by_id' => 4, 'title' => 'New Report Submitted', 'message' => 'Juan Dela Cruz submitted a missed pickup report for Barangay Taloto', 'description' => 'Report ID: #RPT-001. Status: Pending Review. The resident reported that waste collection was missed on their scheduled pickup day.', 'type' => 'report', 'priority' => 'high', 'unread' => true, 'action_url' => '/reports', 'metadata' => ['report_id' => 1], 'created_at' => Carbon::now()->subMinutes(2)],
            
            ['user_id' => 1, 'triggered_by_id' => 1, 'title' => 'Account Approved', 'message' => 'Jonathan G. Buslon account has been approved', 'description' => 'Business Owner account for Jonathan G. Buslon has been successfully verified and approved.', 'type' => 'account', 'priority' => 'medium', 'unread' => true, 'action_url' => '/users', 'created_at' => Carbon::now()->subHour()],
            
            ['user_id' => 1, 'triggered_by_id' => 2, 'title' => 'Announcement Posted', 'message' => 'Waste Collection Delay announcement was posted', 'description' => 'A new announcement titled "Waste Collection Delay" has been published.', 'type' => 'announcement', 'priority' => 'medium', 'unread' => false, 'action_url' => '/announcements', 'created_at' => Carbon::now()->subHours(3)],
            
            ['user_id' => 1, 'triggered_by_id' => 2, 'title' => 'Schedule Updated', 'message' => 'Collection schedule for Zone A has been modified', 'description' => 'The waste collection schedule for Zone A has been updated.', 'type' => 'schedule', 'priority' => 'high', 'unread' => false, 'action_url' => '/schedules', 'created_at' => Carbon::now()->subHours(5)],
            
            ['user_id' => 1, 'triggered_by_id' => 6, 'title' => 'New User Registration', 'message' => 'Maria Santos registered as Purok Leader', 'description' => 'A new Purok Leader registration requires verification.', 'type' => 'account', 'priority' => 'medium', 'unread' => false, 'action_url' => '/users', 'created_at' => Carbon::now()->subDay()],
            
            // For Staff
            ['user_id' => 2, 'triggered_by_id' => 4, 'title' => 'Report Resolved', 'message' => 'Missed pickup report #RPT-001 has been resolved', 'description' => 'The missed pickup report has been marked as resolved.', 'type' => 'report', 'priority' => 'low', 'unread' => false, 'action_url' => '/reports', 'created_at' => Carbon::now()->subDays(2)],
            
            ['user_id' => 2, 'triggered_by_id' => 1, 'title' => 'System Maintenance Notice', 'message' => 'Scheduled system maintenance on March 10, 2026', 'description' => 'The system will undergo scheduled maintenance.', 'type' => 'system', 'priority' => 'medium', 'unread' => false, 'action_url' => null, 'created_at' => Carbon::now()->subDays(3)],
            
            ['user_id' => 2, 'triggered_by_id' => null, 'title' => 'Analytics Report Generated', 'message' => 'Monthly waste collection analytics for February 2026 is ready', 'description' => 'The comprehensive analytics report has been generated.', 'type' => 'analytics', 'priority' => 'low', 'unread' => false, 'action_url' => '/analytics', 'sender_name' => 'Analytics System', 'sender_role' => 'System', 'sender_avatar' => 'AS', 'created_at' => Carbon::now()->subDays(4)],
        ];

        foreach ($notifications as $notification) {
            Notification::create($notification);
        }

        $this->command->info('Notifications seeded successfully!');
    }
}

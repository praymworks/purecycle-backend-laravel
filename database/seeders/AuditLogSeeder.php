<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\AuditLog;
use Carbon\Carbon;

class AuditLogSeeder extends Seeder
{
    public function run(): void
    {
        $logs = [
            ['user_id' => 1, 'user_name' => 'Admin User', 'user_role' => 'Admin', 'action' => 'Login', 'module' => 'Authentication', 'description' => 'User logged into the system', 'ip_address' => '192.168.1.100', 'status' => 'success', 'created_at' => Carbon::parse('2026-03-04 16:45:23')],
            ['user_id' => 1, 'user_name' => 'Admin User', 'user_role' => 'Admin', 'action' => 'View', 'module' => 'Dashboard', 'description' => 'Accessed Dashboard page', 'ip_address' => '192.168.1.100', 'status' => 'success', 'created_at' => Carbon::parse('2026-03-04 16:45:30')],
            ['user_id' => 1, 'user_name' => 'Admin User', 'user_role' => 'Admin', 'action' => 'Update', 'module' => 'User Management', 'description' => 'Updated user information', 'ip_address' => '192.168.1.100', 'status' => 'success', 'created_at' => Carbon::parse('2026-03-04 16:50:15')],
            ['user_id' => 2, 'user_name' => 'Staff User', 'user_role' => 'Staff', 'action' => 'View', 'module' => 'Reports Management', 'description' => 'Viewed report details', 'ip_address' => '192.168.1.105', 'status' => 'success', 'created_at' => Carbon::parse('2026-03-04 16:55:00')],
            ['user_id' => 2, 'user_name' => 'Staff User', 'user_role' => 'Staff', 'action' => 'Update', 'module' => 'Reports Management', 'description' => 'Changed report status to In Progress', 'ip_address' => '192.168.1.105', 'status' => 'success', 'created_at' => Carbon::parse('2026-03-04 16:56:30')],
            ['user_id' => 1, 'user_name' => 'Admin User', 'user_role' => 'Admin', 'action' => 'Create', 'module' => 'Announcements', 'description' => 'Created new announcement', 'ip_address' => '192.168.1.100', 'status' => 'success', 'created_at' => Carbon::parse('2026-03-04 17:00:00')],
            ['user_id' => 1, 'user_name' => 'Admin User', 'user_role' => 'Admin', 'action' => 'Delete', 'module' => 'User Management', 'description' => 'Deleted user account', 'ip_address' => '192.168.1.100', 'status' => 'success', 'created_at' => Carbon::parse('2026-03-04 17:05:45')],
            ['user_id' => 2, 'user_name' => 'Staff User', 'user_role' => 'Staff', 'action' => 'Login', 'module' => 'Authentication', 'description' => 'Failed login attempt - incorrect password', 'ip_address' => '192.168.1.105', 'status' => 'failed', 'created_at' => Carbon::parse('2026-03-04 17:10:00')],
            ['user_id' => 1, 'user_name' => 'Admin User', 'user_role' => 'Admin', 'action' => 'Update', 'module' => 'System Settings', 'description' => 'Changed site maintenance mode to ON', 'ip_address' => '192.168.1.100', 'status' => 'success', 'created_at' => Carbon::parse('2026-03-04 17:15:30')],
            ['user_id' => 1, 'user_name' => 'Admin User', 'user_role' => 'Admin', 'action' => 'Export', 'module' => 'System Settings', 'description' => 'Exported database backup', 'ip_address' => '192.168.1.100', 'status' => 'success', 'created_at' => Carbon::parse('2026-03-04 17:20:00')],
        ];

        foreach ($logs as $log) {
            AuditLog::create($log);
        }

        $this->command->info('Audit logs seeded successfully!');
    }
}

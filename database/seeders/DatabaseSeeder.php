<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        $this->call([
            PermissionSeeder::class,
            RoleSeeder::class,
            UserSeeder::class,
            ReportSeeder::class,
            AnnouncementSeeder::class,
            RouteSeeder::class,
            ScheduleSeeder::class,
            AuditLogSeeder::class,
            NotificationSeeder::class,
        ]);
    }
}

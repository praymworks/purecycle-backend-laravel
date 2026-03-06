<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Announcement;
use Carbon\Carbon;

class AnnouncementSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Admin user_id = 1, Staff user_id = 2
        $announcements = [
            [
                'announcement_id' => 'ANN-001',
                'title' => 'Important Announcement: Waste Collection Delay',
                'message' => 'Please be informed that today\'s waste collection has been temporary cancelled due to unforeseen maintenance issue. Regular collection will resume tomorrow. We apologize for the inconvenience',
                'priority' => 'Moderate',
                'start_date' => '2025-09-12',
                'end_date' => '2025-09-15',
                'status' => 'Expired',
                'date_posted' => '2025-09-12',
                'created_by_id' => 1, // Admin
                'attachments' => [],
                'created_at' => Carbon::parse('2025-09-12 08:00:00'),
                'updated_at' => Carbon::parse('2025-09-12 08:00:00'),
            ],
            [
                'announcement_id' => 'ANN-002',
                'title' => 'Important Notice: Waste Collection Halted',
                'message' => 'Please be informed that today\'s waste collection has been temporary cancelled due to unforeseen maintenance .....',
                'priority' => 'Moderate',
                'start_date' => '2025-03-12',
                'end_date' => '2025-03-20',
                'status' => 'Expired',
                'date_posted' => '2025-03-12',
                'created_by_id' => 2, // Staff
                'attachments' => [],
                'created_at' => Carbon::parse('2025-03-12 09:30:00'),
                'updated_at' => Carbon::parse('2025-03-12 09:30:00'),
            ],
            [
                'announcement_id' => 'ANN-003',
                'title' => 'New Waste Segregation Guidelines',
                'message' => 'Starting next week, new waste segregation rules will be implemented. Please separate biodegradable, non-biodegradable, and recyclable waste.',
                'priority' => 'Low',
                'start_date' => '2025-09-25',
                'end_date' => '2025-10-25',
                'status' => 'Active',
                'date_posted' => '2025-09-23',
                'created_by_id' => 1, // Admin
                'attachments' => ['guidelines.pdf'],
                'created_at' => Carbon::parse('2025-09-23 10:00:00'),
                'updated_at' => Carbon::parse('2025-09-23 10:00:00'),
            ],
            [
                'announcement_id' => 'ANN-004',
                'title' => 'Holiday Schedule Adjustment',
                'message' => 'Waste collection schedule will be adjusted during the upcoming holidays. Please check the updated schedule.',
                'priority' => 'Moderate',
                'start_date' => '2025-10-01',
                'end_date' => '2025-10-15',
                'status' => 'Active',
                'date_posted' => '2025-09-24',
                'created_by_id' => 2, // Staff
                'attachments' => ['holiday-schedule.pdf'],
                'created_at' => Carbon::parse('2025-09-24 14:30:00'),
                'updated_at' => Carbon::parse('2025-09-24 14:30:00'),
            ],
        ];

        foreach ($announcements as $announcement) {
            Announcement::create($announcement);
        }

        $this->command->info('Announcements seeded successfully!');
    }
}

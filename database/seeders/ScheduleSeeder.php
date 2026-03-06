<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Schedule;
use App\Models\Route;
use Carbon\Carbon;

class ScheduleSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Get routes for relationship
        $route1 = Route::where('route_id', 'ROUTE-001')->first();
        $route2 = Route::where('route_id', 'ROUTE-002')->first();
        $route3 = Route::where('route_id', 'ROUTE-003')->first();

        // Admin user_id = 1
        $schedules = [
            [
                'schedule_id' => 'SCH-001',
                'route_id' => $route1 ? $route1->id : null,
                'day' => 'Monday',
                'date' => '2026-03-08',
                'start_time' => '06:00:00',
                'end_time' => '14:30:00',
                'status' => 'active',
                'cancel_reason' => null,
                'stops' => [
                    ['location' => 'Municipal Hall', 'status' => 'start', 'time' => '06:00 AM'],
                    ['location' => 'Mundal Bhouse', 'status' => 'ongoing', 'time' => '06:30 AM'],
                    ['location' => 'TMC via Park in Go', 'status' => 'ongoing', 'time' => '07:00 AM'],
                    ['location' => 'TCES', 'status' => 'ongoing', 'time' => '07:30 AM'],
                    ['location' => 'Brgy.Hall', 'status' => 'ongoing', 'time' => '08:00 AM'],
                    ['location' => 'Arlene Carenderia', 'status' => 'ongoing', 'time' => '08:30 AM'],
                    ['location' => 'Public Market', 'status' => 'ongoing', 'time' => '09:00 AM'],
                    ['location' => 'Municipal Hall Annex', 'status' => 'ongoing', 'time' => '09:30 AM'],
                    ['location' => 'Cultural Center', 'status' => 'ongoing', 'time' => '10:00 AM'],
                    ['location' => 'PENGAVITOR Ent.', 'status' => 'ongoing', 'time' => '10:30 AM'],
                    ['location' => 'Sumatra Res.', 'status' => 'ongoing', 'time' => '11:00 AM'],
                    ['location' => 'F. Gonzales Res', 'status' => 'ongoing', 'time' => '11:30 AM'],
                    ['location' => 'SIA', 'status' => 'ongoing', 'time' => '12:00 PM'],
                    ['location' => 'Shoppers Mart', 'status' => 'ongoing', 'time' => '12:30 PM'],
                    ['location' => 'RCA/MRF', 'status' => 'finish', 'time' => '01:00 PM'],
                    ['location' => 'Crossing Candi Store', 'status' => 'ongoing', 'time' => '01:30 PM'],
                    ['location' => 'Panab an', 'status' => 'ongoing', 'time' => '02:00 PM'],
                    ['location' => 'Entrance SM', 'status' => 'ongoing', 'time' => '02:30 PM'],
                ],
                'notes' => null,
                'created_by_id' => 1,
                'assigned_driver_id' => null,
                'created_at' => Carbon::parse('2026-03-01 10:00:00'),
                'updated_at' => Carbon::parse('2026-03-01 10:00:00'),
            ],
            [
                'schedule_id' => 'SCH-002',
                'route_id' => $route2 ? $route2->id : null,
                'day' => 'Tuesday',
                'date' => '2026-03-09',
                'start_time' => '06:00:00',
                'end_time' => '09:00:00',
                'status' => 'active',
                'cancel_reason' => null,
                'stops' => [
                    ['location' => 'Purok 1', 'status' => 'start', 'time' => '06:00 AM'],
                    ['location' => 'Purok 2', 'status' => 'ongoing', 'time' => '07:00 AM'],
                    ['location' => 'Purok 3', 'status' => 'ongoing', 'time' => '08:00 AM'],
                    ['location' => 'RCA/MRF', 'status' => 'finish', 'time' => '09:00 AM'],
                ],
                'notes' => null,
                'created_by_id' => 1,
                'assigned_driver_id' => null,
                'created_at' => Carbon::parse('2026-03-01 10:30:00'),
                'updated_at' => Carbon::parse('2026-03-01 10:30:00'),
            ],
            [
                'schedule_id' => 'SCH-003',
                'route_id' => $route3 ? $route3->id : null,
                'day' => 'Wednesday',
                'date' => '2026-03-10',
                'start_time' => '06:00:00',
                'end_time' => '09:00:00',
                'status' => 'completed',
                'cancel_reason' => null,
                'stops' => [
                    ['location' => 'Purok 4', 'status' => 'start', 'time' => '06:00 AM'],
                    ['location' => 'Purok 5', 'status' => 'ongoing', 'time' => '07:00 AM'],
                    ['location' => 'Carenderia Area', 'status' => 'ongoing', 'time' => '08:00 AM'],
                    ['location' => 'RCA/MRF', 'status' => 'finish', 'time' => '09:00 AM'],
                ],
                'notes' => null,
                'created_by_id' => 1,
                'assigned_driver_id' => null,
                'created_at' => Carbon::parse('2026-03-01 11:00:00'),
                'updated_at' => Carbon::parse('2026-03-10 09:00:00'),
            ],
            [
                'schedule_id' => 'SCH-004',
                'route_id' => $route1 ? $route1->id : null,
                'day' => 'Thursday',
                'date' => '2026-03-04',
                'start_time' => '06:00:00',
                'end_time' => null,
                'status' => 'cancelled',
                'cancel_reason' => 'Heavy rain and flooding',
                'stops' => [
                    ['location' => 'Municipal Hall', 'status' => 'start', 'time' => '06:00 AM'],
                    ['location' => 'Cogon Elementary School', 'status' => 'ongoing', 'time' => '06:30 AM'],
                    ['location' => 'Cogon Market', 'status' => 'ongoing', 'time' => '07:00 AM'],
                    ['location' => 'Purok 6', 'status' => 'ongoing', 'time' => '07:30 AM'],
                    ['location' => 'Purok 7', 'status' => 'ongoing', 'time' => '08:00 AM'],
                    ['location' => 'Purok 8', 'status' => 'ongoing', 'time' => '08:30 AM'],
                    ['location' => 'Dao Barangay Hall', 'status' => 'ongoing', 'time' => '09:00 AM'],
                    ['location' => 'Dao Chapel', 'status' => 'ongoing', 'time' => '09:30 AM'],
                    ['location' => 'Dao Elementary School', 'status' => 'ongoing', 'time' => '10:00 AM'],
                    ['location' => 'Taloto Main Road', 'status' => 'ongoing', 'time' => '10:30 AM'],
                    ['location' => 'Taloto Commercial Area', 'status' => 'ongoing', 'time' => '11:00 AM'],
                    ['location' => 'Bool Public Market', 'status' => 'ongoing', 'time' => '11:30 AM'],
                    ['location' => 'Bool Plaza', 'status' => 'ongoing', 'time' => '12:00 PM'],
                    ['location' => 'Island City Mall', 'status' => 'ongoing', 'time' => '12:30 PM'],
                    ['location' => 'RCA/MRF', 'status' => 'finish', 'time' => '01:00 PM'],
                ],
                'notes' => 'Cancelled due to bad weather conditions',
                'created_by_id' => 1,
                'assigned_driver_id' => null,
                'created_at' => Carbon::parse('2026-03-01 11:30:00'),
                'updated_at' => Carbon::parse('2026-03-04 05:30:00'),
            ],
            [
                'schedule_id' => 'SCH-005',
                'route_id' => $route2 ? $route2->id : null,
                'day' => 'Friday',
                'date' => '2026-03-05',
                'start_time' => '06:00:00',
                'end_time' => '13:00:00',
                'status' => 'completed',
                'cancel_reason' => null,
                'stops' => [
                    ['location' => 'Municipal Hall', 'status' => 'start', 'time' => '06:00 AM'],
                    ['location' => 'Mansasa Market', 'status' => 'ongoing', 'time' => '06:30 AM'],
                    ['location' => 'Mansasa Barangay Hall', 'status' => 'ongoing', 'time' => '07:00 AM'],
                    ['location' => 'Ubujan Elementary School', 'status' => 'ongoing', 'time' => '07:30 AM'],
                    ['location' => 'Ubujan Chapel', 'status' => 'ongoing', 'time' => '08:00 AM'],
                    ['location' => 'BQ Mall', 'status' => 'ongoing', 'time' => '08:30 AM'],
                    ['location' => 'Alta Citta', 'status' => 'ongoing', 'time' => '09:00 AM'],
                    ['location' => 'City Hall Tagbilaran', 'status' => 'ongoing', 'time' => '09:30 AM'],
                    ['location' => 'St. Joseph Cathedral', 'status' => 'ongoing', 'time' => '10:00 AM'],
                    ['location' => 'Plaza Rizal', 'status' => 'ongoing', 'time' => '10:30 AM'],
                    ['location' => 'Carlos P. Garcia Avenue', 'status' => 'ongoing', 'time' => '11:00 AM'],
                    ['location' => 'TIP Building', 'status' => 'ongoing', 'time' => '11:30 AM'],
                    ['location' => 'Bohol Quality Mall', 'status' => 'ongoing', 'time' => '12:00 PM'],
                    ['location' => 'Graham Avenue', 'status' => 'ongoing', 'time' => '12:30 PM'],
                    ['location' => 'RCA/MRF', 'status' => 'finish', 'time' => '01:00 PM'],
                ],
                'notes' => null,
                'created_by_id' => 1,
                'assigned_driver_id' => null,
                'created_at' => Carbon::parse('2026-03-01 12:00:00'),
                'updated_at' => Carbon::parse('2026-03-05 13:00:00'),
            ],
        ];

        foreach ($schedules as $schedule) {
            Schedule::create($schedule);
        }

        $this->command->info('Schedules seeded successfully!');
    }
}

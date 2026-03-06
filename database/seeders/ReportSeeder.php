<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Report;
use Carbon\Carbon;

class ReportSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Mapping from reports.json reporter IDs to actual user IDs
        $reporterMapping = [
            'PL-001' => 4, // Juan Dela Cruz
            'BO-002' => 5, // Jonathan G. Buslon
            'PL-003' => 6, // Maria Santos
            'BO-004' => 7, // Pedro Reyes
        ];

        $reports = [
            [
                'report_id' => 'RPT-001',
                'reporter_id' => $reporterMapping['PL-001'],
                'reporter_name' => 'Juan Dela Cruz',
                'reporter_role' => 'Purok Leader',
                'barangay' => 'Poblacion',
                'purok' => 'Purok 5',
                'priority' => 'Moderate',
                'status' => 'Resolved',
                'complaint' => 'Garbage was not collected on the scheduled day. Waste has started to accumulate and needs immediate attention',
                'photo' => 'report-photo-001.jpg',
                'date_submitted' => '2025-09-20',
                'staff_remarks' => 'Issue resolved. Pickup rescheduled and completed.',
                'resolved_date' => '2025-09-22',
                'created_at' => Carbon::parse('2025-09-20 08:00:00'),
                'updated_at' => Carbon::parse('2025-09-22 10:30:00'),
            ],
            [
                'report_id' => 'RPT-002',
                'reporter_id' => $reporterMapping['BO-002'],
                'reporter_name' => 'Jonathan G. Buslon',
                'reporter_role' => 'Business Owner',
                'barangay' => 'Poblacion',
                'purok' => 'Purok 7',
                'priority' => 'Low',
                'status' => 'Pending',
                'complaint' => 'Someone is dumping waste in unauthorized area near my business',
                'photo' => 'report-photo-002.jpg',
                'date_submitted' => '2025-09-01',
                'staff_remarks' => null,
                'resolved_date' => null,
                'created_at' => Carbon::parse('2025-09-01 11:15:00'),
                'updated_at' => Carbon::parse('2025-09-01 11:15:00'),
            ],
            [
                'report_id' => 'RPT-003',
                'reporter_id' => $reporterMapping['PL-003'],
                'reporter_name' => 'Maria Santos',
                'reporter_role' => 'Purok Leader',
                'barangay' => 'Poblacion',
                'purok' => 'Purok 1',
                'priority' => 'Urgent',
                'status' => 'In Progress',
                'complaint' => 'Waste collection has been missed for 3 consecutive days. Emergency attention needed.',
                'photo' => 'report-photo-003.jpg',
                'date_submitted' => '2025-09-18',
                'staff_remarks' => 'Team dispatched to the area.',
                'resolved_date' => null,
                'created_at' => Carbon::parse('2025-09-18 09:00:00'),
                'updated_at' => Carbon::parse('2025-09-18 14:20:00'),
            ],
            [
                'report_id' => 'RPT-004',
                'reporter_id' => $reporterMapping['BO-004'],
                'reporter_name' => 'Pedro Reyes',
                'reporter_role' => 'Business Owner',
                'barangay' => 'Poblacion',
                'purok' => 'Purok 3',
                'priority' => 'Moderate',
                'status' => 'Resolved',
                'complaint' => 'Public waste bin is overflowing and creating health hazard',
                'photo' => 'report-photo-004.jpg',
                'date_submitted' => '2025-09-15',
                'staff_remarks' => 'Bin emptied and cleaned.',
                'resolved_date' => '2025-09-16',
                'created_at' => Carbon::parse('2025-09-15 10:30:00'),
                'updated_at' => Carbon::parse('2025-09-16 08:45:00'),
            ],
            [
                'report_id' => 'RPT-005',
                'reporter_id' => $reporterMapping['PL-001'],
                'reporter_name' => 'Juan Dela Cruz',
                'reporter_role' => 'Purok Leader',
                'barangay' => 'Poblacion',
                'purok' => 'Purok 5',
                'priority' => 'Low',
                'status' => 'Rejected',
                'complaint' => 'Missed pickup reported but location was unclear',
                'photo' => 'report-photo-005.jpg',
                'date_submitted' => '2025-09-10',
                'staff_remarks' => 'Unable to locate. Please provide specific address.',
                'resolved_date' => null,
                'created_at' => Carbon::parse('2025-09-10 13:00:00'),
                'updated_at' => Carbon::parse('2025-09-11 09:15:00'),
            ],
            [
                'report_id' => 'RPT-006',
                'reporter_id' => $reporterMapping['PL-003'],
                'reporter_name' => 'Maria Santos',
                'reporter_role' => 'Purok Leader',
                'barangay' => 'Poblacion',
                'purok' => 'Purok 1',
                'priority' => 'Urgent',
                'status' => 'In Progress',
                'complaint' => 'Large amount of construction waste dumped illegally',
                'photo' => 'report-photo-006.jpg',
                'date_submitted' => '2025-09-22',
                'staff_remarks' => 'Investigation ongoing.',
                'resolved_date' => null,
                'created_at' => Carbon::parse('2025-09-22 07:30:00'),
                'updated_at' => Carbon::parse('2025-09-22 15:45:00'),
            ],
        ];

        foreach ($reports as $report) {
            Report::create($report);
        }

        $this->command->info('Reports seeded successfully!');
    }
}

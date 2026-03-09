<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Route;
use Carbon\Carbon;

class RouteSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Admin user_id = 1
        $routes = [
            [
                'route_id' => 'ROUTE-001',
                'name' => 'Trinidad Central Route',
                'description' => 'Main route covering central Trinidad barangays',
                'municipality' => 'Trinidad',
                'province' => 'Bohol',
                'status' => 'active',
                'color' => '#3B82F6',
                'waypoints' => [
                    [
                        'id' => 'WP-001',
                        'name' => 'Trinidad Municipal Hall',
                        'barangay' => 'Poblacion',
                        'purok' => 'Purok 1',
                        'lat' => 10.07970689760644,
                        'lng' => 124.34302082673474,
                        'address' => 'Trinidad Municipal Hall, Trinidad, Bohol',
                        'type' => 'start',
                        'order' => 1
                    ],
                    [
                        'id' => 'WP-002',
                        'name' => 'Barangay CATOOGAN',
                        'barangay' => 'CATOOGAN',
                        'purok' => 'Purok 2',
                        'lat' => 10.04497959694381,
                        'lng' => 124.40353977145442,
                        'address' => 'Barangay CATOOGAN, Trinidad, Bohol',
                        'type' => 'pickup',
                        'order' => 2
                    ],
                    [
                        'id' => 'WP-003',
                        'name' => 'Barangay Guinobatan',
                        'barangay' => 'Guinobatan',
                        'purok' => 'Purok 5',
                        'lat' => 10.073609975988093,
                        'lng' => 124.3562811698296,
                        'address' => 'Barangay Guinobatan, Trinidad, Bohol',
                        'type' => 'pickup',
                        'order' => 3
                    ],
                    [
                        'id' => 'WP-004',
                        'name' => 'Barangay Kauswagan',
                        'barangay' => 'Kauswagan',
                        'purok' => 'Purok 3',
                        'lat' => 10.033511206800622,
                        'lng' => 124.25979675660413,
                        'address' => 'Barangay Kauswagan, Trinidad, Bohol',
                        'type' => 'pickup',
                        'order' => 4
                    ],
                    [
                        'id' => 'WP-005',
                        'name' => 'Trinidad Disposal Facility',
                        'barangay' => 'Poblacion',
                        'purok' => 'Purok 1',
                        'lat' => 10.064948400829833,
                        'lng' => 124.32686535742056,
                        'address' => 'Waste Disposal Facility, Trinidad, Bohol',
                        'type' => 'end',
                        'order' => 5
                    ]
                ],
                'distance' => '12.5 km',
                'estimated_duration' => '45 minutes',
                'created_by_id' => 1, // Admin
                'created_at' => Carbon::parse('2026-03-01 08:00:00'),
                'updated_at' => Carbon::parse('2026-03-03 10:30:00'),
            ],
            [
                'route_id' => 'ROUTE-002',
                'name' => 'Trinidad North Route',
                'description' => 'Northern barangays coverage',
                'municipality' => 'Trinidad',
                'province' => 'Bohol',
                'status' => 'active',
                'color' => '#10B981',
                'waypoints' => [
                    [
                        'id' => 'WP-006',
                        'name' => 'Trinidad Municipal Hall',
                        'barangay' => 'Poblacion',
                        'purok' => 'Purok 1',
                        'lat' => 10.0797,
                        'lng' => 124.3445,
                        'address' => 'Trinidad Municipal Hall, Poblacion, Trinidad, Bohol',
                        'type' => 'start',
                        'order' => 1
                    ],
                    [
                        'id' => 'WP-007',
                        'name' => 'Barangay Banlasan',
                        'barangay' => 'Banlasan',
                        'purok' => 'Purok 4',
                        'lat' => 10.0962,
                        'lng' => 124.3578,
                        'address' => 'Barangay Banlasan, Trinidad, Bohol',
                        'type' => 'pickup',
                        'order' => 2
                    ],
                    [
                        'id' => 'WP-008',
                        'name' => 'Barangay La Union',
                        'barangay' => 'La Union',
                        'purok' => 'Purok 2',
                        'lat' => 10.1045,
                        'lng' => 124.3661,
                        'address' => 'Barangay La Union, Trinidad, Bohol',
                        'type' => 'pickup',
                        'order' => 3
                    ],
                    [
                        'id' => 'WP-009',
                        'name' => 'Barangay Mahagbu',
                        'barangay' => 'Mahagbu',
                        'purok' => 'Purok 6',
                        'lat' => 10.1128,
                        'lng' => 124.3743,
                        'address' => 'Barangay Mahagbu, Trinidad, Bohol',
                        'type' => 'pickup',
                        'order' => 4
                    ],
                    [
                        'id' => 'WP-010',
                        'name' => 'Trinidad Disposal Facility',
                        'barangay' => 'Poblacion',
                        'purok' => 'Purok 1',
                        'lat' => 10.0723,
                        'lng' => 124.3529,
                        'address' => 'Waste Disposal Facility, Trinidad, Bohol',
                        'type' => 'end',
                        'order' => 5
                    ]
                ],
                'distance' => '18.3 km',
                'estimated_duration' => '65 minutes',
                'created_by_id' => 1, // Admin
                'created_at' => Carbon::parse('2026-03-01 08:30:00'),
                'updated_at' => Carbon::parse('2026-03-03 22:00:00'),
            ],
            [
                'route_id' => 'ROUTE-003',
                'name' => 'Trinidad South Route',
                'description' => 'Southern barangays and nearby areas',
                'municipality' => 'Trinidad',
                'province' => 'Bohol',
                'status' => 'active',
                'color' => '#F59E0B',
                'waypoints' => [
                    [
                        'id' => 'WP-011',
                        'name' => 'Trinidad Municipal Hall',
                        'barangay' => 'Poblacion',
                        'purok' => 'Purok 1',
                        'lat' => 10.0797,
                        'lng' => 124.3445,
                        'address' => 'Trinidad Municipal Hall, Poblacion, Trinidad, Bohol',
                        'type' => 'start',
                        'order' => 1
                    ],
                    [
                        'id' => 'WP-012',
                        'name' => 'Barangay Kinan',
                        'barangay' => 'Kinan',
                        'purok' => 'Purok 3',
                        'lat' => 10.0614,
                        'lng' => 124.3562,
                        'address' => 'Barangay Kinan, Trinidad, Bohol',
                        'type' => 'pickup',
                        'order' => 2
                    ],
                    [
                        'id' => 'WP-013',
                        'name' => 'Barangay Hinlayagan Ilaud',
                        'barangay' => 'Hinlayagan Ilaud',
                        'purok' => 'Purok 5',
                        'lat' => 10.0528,
                        'lng' => 124.3654,
                        'address' => 'Barangay Hinlayagan Ilaud, Trinidad, Bohol',
                        'type' => 'pickup',
                        'order' => 3
                    ],
                    [
                        'id' => 'WP-014',
                        'name' => 'Barangay Santo Niño',
                        'barangay' => 'Santo Niño',
                        'purok' => 'Purok 2',
                        'lat' => 10.0437,
                        'lng' => 124.3728,
                        'address' => 'Barangay Santo Niño, Trinidad, Bohol',
                        'type' => 'pickup',
                        'order' => 4
                    ],
                    [
                        'id' => 'WP-015',
                        'name' => 'Trinidad Disposal Facility',
                        'barangay' => 'Poblacion',
                        'purok' => 'Purok 1',
                        'lat' => 10.0723,
                        'lng' => 124.3529,
                        'address' => 'Waste Disposal Facility, Trinidad, Bohol',
                        'type' => 'end',
                        'order' => 5
                    ]
                ],
                'distance' => '15.7 km',
                'estimated_duration' => '55 minutes',
                'created_by_id' => 1, // Admin
                'created_at' => Carbon::parse('2026-03-01 09:00:00'),
                'updated_at' => Carbon::parse('2026-03-03 22:00:00'),
            ],
        ];

        foreach ($routes as $route) {
            Route::create($route);
        }

        $this->command->info('Routes seeded successfully!');
    }
}

<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Permission;
use Illuminate\Support\Facades\File;

class PermissionSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Load permissions from JSON file
        $jsonPath = base_path('../frontend/src/data/permissions.json');
        $permissionsData = json_decode(File::get($jsonPath), true);

        // Track used slugs to avoid duplicates
        $usedSlugs = [];
        $currentId = 1;

        foreach ($permissionsData as $permission) {
            // Skip if this slug was already used
            if (in_array($permission['slug'], $usedSlugs)) {
                continue;
            }

            Permission::create([
                'id' => $currentId,
                'name' => $permission['name'],
                'slug' => $permission['slug'],
                'module' => $permission['module'],
                'description' => $permission['description'] ?? null,
                'status' => $permission['status'] ?? 'active',
                'icon' => $permission['icon'] ?? null,
            ]);

            $usedSlugs[] = $permission['slug'];
            $currentId++;
        }

        $this->command->info('Permissions seeded successfully!');
    }
}

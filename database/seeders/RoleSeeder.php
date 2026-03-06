<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Role;
use App\Models\Permission;
use Illuminate\Support\Facades\File;

class RoleSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Load roles from JSON file
        $jsonPath = base_path('../frontend/src/data/roles.json');
        $rolesData = json_decode(File::get($jsonPath), true);

        foreach ($rolesData as $roleData) {
            // Create the role
            $role = Role::create([
                'id' => $roleData['id'],
                'name' => $roleData['name'],
                'slug' => $roleData['slug'],
                'description' => $roleData['description'] ?? null,
                'user_count' => $roleData['userCount'] ?? 0,
                'is_system' => $roleData['isSystem'] ?? false,
            ]);

            // Attach permissions to the role
            if (isset($roleData['permissions']) && is_array($roleData['permissions'])) {
                $permissionIds = Permission::whereIn('slug', $roleData['permissions'])->pluck('id')->toArray();
                $role->permissions()->attach($permissionIds);
            }
        }

        $this->command->info('Roles seeded successfully with permissions!');
    }
}

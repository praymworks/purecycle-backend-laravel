<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\User;
use App\Models\PurokLeader;
use App\Models\BusinessOwner;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Hash;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Load users from JSON file
        $usersJsonPath = base_path('../frontend/src/data/users.json');
        $usersData = json_decode(File::get($usersJsonPath), true);

        // Load purok leaders from JSON file
        $purokLeadersJsonPath = base_path('../frontend/src/data/purokLeaders.json');
        $purokLeadersData = json_decode(File::get($purokLeadersJsonPath), true);

        // Load business owners from JSON file
        $businessOwnersJsonPath = base_path('../frontend/src/data/businessOwners.json');
        $businessOwnersData = json_decode(File::get($businessOwnersJsonPath), true);

        // Create users
        foreach ($usersData as $userData) {
            $user = User::create([
                'id' => $userData['user_id'],
                'email' => $userData['email'],
                'password' => Hash::make($userData['password']), // Hash the password
                'fullname' => $userData['fullname'],
                'contact_number' => $userData['contact_number'],
                'city_municipality' => $userData['city_municipality'],
                'barangay' => $userData['barangay'] ?? null,
                'purok' => $userData['purok'] ?? null,
                'role' => $userData['role'],
                'profile_path' => $userData['profile_path'] ?? null,
                'status' => $userData['status'] ?? 'pending',
                'created_at' => $userData['created_at'] ?? now(),
                'updated_at' => $userData['updated_at'] ?? now(),
            ]);
        }

        // Create purok leaders
        foreach ($purokLeadersData as $purokLeader) {
            PurokLeader::create([
                'id' => $purokLeader['purok_leader_id'],
                'user_id' => $purokLeader['user_id'],
                'valid_id_document' => $purokLeader['valid_id_document'] ?? null,
                'created_at' => $purokLeader['created_at'] ?? now(),
                'updated_at' => $purokLeader['updated_at'] ?? now(),
            ]);
        }

        // Create business owners
        foreach ($businessOwnersData as $businessOwner) {
            BusinessOwner::create([
                'id' => $businessOwner['business_owner_id'],
                'user_id' => $businessOwner['user_id'],
                'business_name' => $businessOwner['business_name'],
                'business_permit' => $businessOwner['business_permit'] ?? null,
                'street' => $businessOwner['street'] ?? null,
                'valid_id_document' => $businessOwner['valid_id_document'] ?? null,
                'created_at' => $businessOwner['created_at'] ?? now(),
                'updated_at' => $businessOwner['updated_at'] ?? now(),
            ]);
        }

        $this->command->info('Users, Purok Leaders, and Business Owners seeded successfully!');
    }
}

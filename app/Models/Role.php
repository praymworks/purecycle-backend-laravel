<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Role extends Model
{
    use HasFactory;

    protected $fillable = [
        'name',
        'slug',
        'description',
        'user_count',
        'is_system',
    ];

    protected $casts = [
        'is_system' => 'boolean',
        'user_count' => 'integer',
    ];

    /**
     * Get the permissions associated with this role.
     */
    public function permissions()
    {
        return $this->belongsToMany(Permission::class, 'role_permission');
    }

    /**
     * Get all users with this role.
     */
    public function users()
    {
        return $this->hasMany(User::class, 'role', 'slug');
    }

    /**
     * Check if role has a specific permission.
     */
    public function hasPermission(string $permissionSlug): bool
    {
        return $this->permissions()->where('slug', $permissionSlug)->exists();
    }

    /**
     * Attach permissions to this role.
     */
    public function attachPermissions(array $permissionIds)
    {
        $this->permissions()->syncWithoutDetaching($permissionIds);
    }

    /**
     * Detach permissions from this role.
     */
    public function detachPermissions(array $permissionIds)
    {
        $this->permissions()->detach($permissionIds);
    }

    /**
     * Sync permissions to this role.
     */
    public function syncPermissions(array $permissionIds)
    {
        $this->permissions()->sync($permissionIds);
    }
}

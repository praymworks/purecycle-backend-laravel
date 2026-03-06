<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Route extends Model
{
    use HasFactory, SoftDeletes;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'route_id',
        'name',
        'description',
        'municipality',
        'province',
        'status',
        'color',
        'waypoints',
        'distance',
        'estimated_duration',
        'created_by_id',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'waypoints' => 'array',
        'created_at' => 'datetime',
        'updated_at' => 'datetime',
        'deleted_at' => 'datetime',
    ];

    /**
     * Get the user who created the route.
     */
    public function createdBy()
    {
        return $this->belongsTo(User::class, 'created_by_id');
    }

    /**
     * Generate the next route ID
     */
    public static function generateRouteId()
    {
        $lastRoute = self::withTrashed()->orderBy('id', 'desc')->first();
        
        if (!$lastRoute) {
            return 'ROUTE-001';
        }

        // Extract number from last route ID (e.g., ROUTE-001 -> 001)
        $lastNumber = intval(substr($lastRoute->route_id, 6));
        $newNumber = $lastNumber + 1;

        return 'ROUTE-' . str_pad($newNumber, 3, '0', STR_PAD_LEFT);
    }

    /**
     * Scope a query to only include routes with a specific status.
     */
    public function scopeStatus($query, $status)
    {
        return $query->where('status', $status);
    }

    /**
     * Scope a query to filter by municipality.
     */
    public function scopeMunicipality($query, $municipality)
    {
        return $query->where('municipality', $municipality);
    }

    /**
     * Scope a query to filter by province.
     */
    public function scopeProvince($query, $province)
    {
        return $query->where('province', $province);
    }

    /**
     * Get waypoints by type
     */
    public function getWaypointsByType($type)
    {
        return collect($this->waypoints)->filter(function($waypoint) use ($type) {
            return $waypoint['type'] === $type;
        })->values()->all();
    }

    /**
     * Get total number of waypoints
     */
    public function getTotalWaypoints()
    {
        return count($this->waypoints);
    }

    /**
     * Get total number of pickup points
     */
    public function getTotalPickupPoints()
    {
        return count($this->getWaypointsByType('pickup'));
    }

    public function schedules()
    {
        return $this->hasMany(\App\Models\Schedule::class, 'route_id', 'id');
    }
}

<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Schedule extends Model
{
    use HasFactory, SoftDeletes;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'schedule_id',
        'route_id',
        'garbage_truck',
        'day',
        'date',
        'start_time',
        'end_time',
        'status',
        'cancel_reason',
        'stops',
        'notes',
        'created_by_id',
        'assigned_driver_id',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'date' => 'date',
        'start_time' => 'datetime:H:i:s',
        'end_time' => 'datetime:H:i:s',
        'stops' => 'array',
        'created_at' => 'datetime',
        'updated_at' => 'datetime',
        'deleted_at' => 'datetime',
    ];

    /**
     * Get the route associated with the schedule.
     */
    public function route()
    {
        return $this->belongsTo(Route::class, 'route_id');
    }

    /**
     * Get the user who created the schedule.
     */
    public function createdBy()
    {
        return $this->belongsTo(User::class, 'created_by_id');
    }

    /**
     * Get the assigned driver/collector.
     */
    public function assignedDriver()
    {
        return $this->belongsTo(User::class, 'assigned_driver_id');
    }

    /**
     * Generate the next schedule ID
     */
    public static function generateScheduleId()
    {
        $lastSchedule = self::withTrashed()->orderBy('id', 'desc')->first();
        
        if (!$lastSchedule) {
            return 'SCH-001';
        }

        // Extract number from last schedule ID (e.g., SCH-001 -> 001)
        $lastNumber = intval(substr($lastSchedule->schedule_id, 4));
        $newNumber = $lastNumber + 1;

        return 'SCH-' . str_pad($newNumber, 3, '0', STR_PAD_LEFT);
    }

    /**
     * Scope a query to only include schedules with a specific status.
     */
    public function scopeStatus($query, $status)
    {
        return $query->where('status', $status);
    }

    /**
     * Scope a query to filter by date.
     */
    public function scopeByDate($query, $date)
    {
        return $query->whereDate('date', $date);
    }

    /**
     * Scope a query to filter by date range.
     */
    public function scopeDateRange($query, $startDate, $endDate)
    {
        return $query->whereBetween('date', [$startDate, $endDate]);
    }

    /**
     * Scope a query to filter by day.
     */
    public function scopeByDay($query, $day)
    {
        return $query->where('day', $day);
    }

    /**
     * Scope a query to filter by route.
     */
    public function scopeByRoute($query, $routeId)
    {
        return $query->where('route_id', $routeId);
    }

    /**
     * Get total number of stops
     */
    public function getTotalStops()
    {
        return count($this->stops);
    }

    /**
     * Get completed stops
     */
    public function getCompletedStops()
    {
        return collect($this->stops)->filter(function($stop) {
            return isset($stop['status']) && $stop['status'] === 'finish';
        })->count();
    }

    /**
     * Get progress percentage
     */
    public function getProgressPercentage()
    {
        $total = $this->getTotalStops();
        if ($total === 0) {
            return 0;
        }
        
        $completed = $this->getCompletedStops();
        return round(($completed / $total) * 100, 2);
    }
}

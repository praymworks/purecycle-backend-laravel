<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Report extends Model
{
    use HasFactory, SoftDeletes;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'report_id',
        'reporter_id',
        'reporter_name',
        'reporter_role',
        'barangay',
        'purok',
        'priority',
        'status',
        'complaint',
        'photo',
        'date_submitted',
        'staff_remarks',
        'resolved_date',
        'updated_by_id',
        'remark',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'date_submitted' => 'date',
        'resolved_date' => 'date',
        'created_at' => 'datetime',
        'updated_at' => 'datetime',
        'deleted_at' => 'datetime',
    ];

    /**
     * Get the user (reporter) that owns the report.
     */
    public function reporter()
    {
        return $this->belongsTo(User::class, 'reporter_id');
    }

    /**
     * Get the user who last updated the report.
     */
    public function updatedBy()
    {
        return $this->belongsTo(User::class, 'updated_by_id');
    }

    /**
     * Generate the next report ID
     */
    public static function generateReportId()
    {
        $lastReport = self::withTrashed()->orderBy('id', 'desc')->first();
        
        if (!$lastReport) {
            return 'RPT-001';
        }

        // Extract number from last report ID (e.g., RPT-001 -> 001)
        $lastNumber = intval(substr($lastReport->report_id, 4));
        $newNumber = $lastNumber + 1;

        return 'RPT-' . str_pad($newNumber, 3, '0', STR_PAD_LEFT);
    }

    /**
     * Scope a query to only include reports with a specific status.
     */
    public function scopeStatus($query, $status)
    {
        return $query->where('status', $status);
    }

    /**
     * Scope a query to only include reports with a specific priority.
     */
    public function scopePriority($query, $priority)
    {
        return $query->where('priority', $priority);
    }

    /**
     * Scope a query to filter by barangay.
     */
    public function scopeBarangay($query, $barangay)
    {
        return $query->where('barangay', $barangay);
    }

    /**
     * Scope a query to filter by purok.
     */
    public function scopePurok($query, $purok)
    {
        return $query->where('purok', $purok);
    }

    /**
     * Scope a query to filter by reporter role.
     */
    public function scopeReporterRole($query, $role)
    {
        return $query->where('reporter_role', $role);
    }
}

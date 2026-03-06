<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Announcement extends Model
{
    use HasFactory, SoftDeletes;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'announcement_id',
        'title',
        'message',
        'priority',
        'start_date',
        'end_date',
        'status',
        'date_posted',
        'created_by_id',
        'attachments',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'start_date' => 'date',
        'end_date' => 'date',
        'date_posted' => 'date',
        'attachments' => 'array',
        'created_at' => 'datetime',
        'updated_at' => 'datetime',
        'deleted_at' => 'datetime',
    ];

    /**
     * Get the user who created the announcement.
     */
    public function createdBy()
    {
        return $this->belongsTo(User::class, 'created_by_id');
    }

    /**
     * Generate the next announcement ID
     */
    public static function generateAnnouncementId()
    {
        $lastAnnouncement = self::withTrashed()->orderBy('id', 'desc')->first();
        
        if (!$lastAnnouncement) {
            return 'ANN-001';
        }

        // Extract number from last announcement ID (e.g., ANN-001 -> 001)
        $lastNumber = intval(substr($lastAnnouncement->announcement_id, 4));
        $newNumber = $lastNumber + 1;

        return 'ANN-' . str_pad($newNumber, 3, '0', STR_PAD_LEFT);
    }

    /**
     * Scope a query to only include announcements with a specific status.
     */
    public function scopeStatus($query, $status)
    {
        return $query->where('status', $status);
    }

    /**
     * Scope a query to only include announcements with a specific priority.
     */
    public function scopePriority($query, $priority)
    {
        return $query->where('priority', $priority);
    }

    /**
     * Scope a query to only include active announcements.
     */
    public function scopeActive($query)
    {
        return $query->where('status', 'Active')
                     ->where('start_date', '<=', now())
                     ->where('end_date', '>=', now());
    }

    /**
     * Check if announcement is currently active based on dates
     */
    public function isActive()
    {
        $now = now()->toDateString();
        return $this->status === 'Active' 
            && $this->start_date <= $now 
            && $this->end_date >= $now;
    }

    /**
     * Auto-update status based on dates
     */
    public function updateStatusBasedOnDates()
    {
        $now = now()->toDateString();
        
        if ($this->end_date < $now && $this->status === 'Active') {
            $this->update(['status' => 'Expired']);
        }
    }
}

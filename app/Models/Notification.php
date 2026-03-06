<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Notification extends Model
{
    use HasFactory, SoftDeletes;

    protected $fillable = [
        'user_id',
        'triggered_by_id',
        'title',
        'message',
        'description',
        'type',
        'priority',
        'unread',
        'action_url',
        'sender_name',
        'sender_role',
        'sender_avatar',
        'metadata',
    ];

    protected $casts = [
        'unread' => 'boolean',
        'metadata' => 'array',
        'created_at' => 'datetime',
        'updated_at' => 'datetime',
        'deleted_at' => 'datetime',
    ];

    protected $appends = ['time'];

    /**
     * Get the user who receives the notification
     */
    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    /**
     * Get the user who triggered the notification
     */
    public function triggeredBy()
    {
        return $this->belongsTo(User::class, 'triggered_by_id');
    }

    /**
     * Get human-readable time
     */
    public function getTimeAttribute()
    {
        return $this->created_at->diffForHumans();
    }

    /**
     * Scope for unread notifications
     */
    public function scopeUnread($query)
    {
        return $query->where('unread', true);
    }

    /**
     * Scope for read notifications
     */
    public function scopeRead($query)
    {
        return $query->where('unread', false);
    }

    /**
     * Scope by type
     */
    public function scopeType($query, $type)
    {
        return $query->where('type', $type);
    }

    /**
     * Scope by priority
     */
    public function scopePriority($query, $priority)
    {
        return $query->where('priority', $priority);
    }

    /**
     * Boot method to auto-populate sender info
     */
    protected static function boot()
    {
        parent::boot();

        static::creating(function ($notification) {
            // Auto-set sender info if triggered_by_id is provided and sender_name is not set
            if ($notification->triggered_by_id && !$notification->sender_name) {
                $triggeredBy = User::find($notification->triggered_by_id);
                if ($triggeredBy) {
                    $notification->sender_name = $triggeredBy->fullname;
                    $notification->sender_role = ucfirst(str_replace('_', ' ', $triggeredBy->role));
                    $notification->sender_avatar = self::generateAvatar($triggeredBy->fullname);
                }
            }
        });
    }

    /**
     * Generate avatar initials
     */
    private static function generateAvatar($name)
    {
        $words = explode(' ', $name);
        if (count($words) >= 2) {
            return strtoupper(substr($words[0], 0, 1) . substr($words[1], 0, 1));
        }
        return strtoupper(substr($name, 0, 2));
    }

    /**
     * Helper method to notify user(s)
     */
    public static function notify($userIds, $data)
    {
        if (!is_array($userIds)) {
            $userIds = [$userIds];
        }

        $notifications = [];
        foreach ($userIds as $userId) {
            $notifications[] = self::create(array_merge($data, ['user_id' => $userId]));
        }

        return $notifications;
    }

    /**
     * Helper method to notify admins and staff
     */
    public static function notifyAdminsAndStaff($data)
    {
        $adminStaffIds = User::whereIn('role', ['admin', 'staff'])
            ->where('status', 'approved')
            ->pluck('id')
            ->toArray();

        return self::notify($adminStaffIds, $data);
    }
}

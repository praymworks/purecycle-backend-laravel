<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class AuditLog extends Model
{
    use HasFactory, SoftDeletes;

    protected $fillable = [
        'user_id',
        'user_name',
        'user_role',
        'action',
        'module',
        'description',
        'ip_address',
        'status',
    ];

    protected $casts = [
        'created_at' => 'datetime',
        'updated_at' => 'datetime',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    // Helper method to log actions
    public static function log($action, $module, $description, $status = 'success')
    {
        $user = auth()->user();
        
        return self::create([
            'user_id' => $user ? $user->id : null,
            'user_name' => $user ? $user->fullname : 'System',
            'user_role' => $user ? ucfirst(str_replace('_', ' ', $user->role)) : 'System',
            'action' => $action,
            'module' => $module,
            'description' => $description,
            'ip_address' => request()->ip(),
            'status' => $status,
        ]);
    }
}

<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PurokLeader extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'valid_id_document',
    ];

    /**
     * Get the user associated with this purok leader.
     */
    public function user()
    {
        return $this->belongsTo(User::class);
    }
}

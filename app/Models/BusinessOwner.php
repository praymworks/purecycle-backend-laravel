<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BusinessOwner extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'business_name',
        'business_permit',
        'street',
        'valid_id_document',
    ];

    /**
     * Get the user associated with this business owner.
     */
    public function user()
    {
        return $this->belongsTo(User::class);
    }
}

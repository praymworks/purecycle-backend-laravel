<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('routes', function (Blueprint $table) {
            $table->id();
            $table->string('route_id')->unique(); // ROUTE-001, ROUTE-002, etc.
            $table->string('name');
            $table->text('description')->nullable();
            $table->string('municipality');
            $table->string('province');
            $table->enum('status', ['active', 'inactive', 'under_maintenance'])->default('active');
            $table->string('color')->default('#3B82F6'); // Hex color for map display
            $table->json('waypoints'); // Array of waypoint objects
            $table->string('distance')->nullable(); // e.g., "12.5 km"
            $table->string('estimated_duration')->nullable(); // e.g., "45 minutes"
            $table->unsignedBigInteger('created_by_id'); // Who created the route
            $table->timestamps();
            $table->softDeletes();

            // Foreign key constraint
            $table->foreign('created_by_id')->references('id')->on('users')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('routes');
    }
};

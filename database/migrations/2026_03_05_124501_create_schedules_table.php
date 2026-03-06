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
        Schema::create('schedules', function (Blueprint $table) {
            $table->id();
            $table->string('schedule_id')->unique(); // SCH-001, SCH-002, etc.
            $table->unsignedBigInteger('route_id')->nullable(); // Foreign key to routes table
            $table->string('day'); // Monday, Tuesday, etc.
            $table->date('date');
            $table->time('start_time')->default('06:00:00');
            $table->time('end_time')->nullable();
            $table->enum('status', ['active', 'completed', 'cancelled', 'pending'])->default('pending');
            $table->text('cancel_reason')->nullable();
            $table->json('stops'); // Array of stop objects (location, status, time)
            $table->text('notes')->nullable();
            $table->unsignedBigInteger('created_by_id'); // Who created the schedule
            $table->unsignedBigInteger('assigned_driver_id')->nullable(); // Assigned driver/collector
            $table->timestamps();
            $table->softDeletes();

            // Foreign key constraints
            $table->foreign('route_id')->references('id')->on('routes')->onDelete('set null');
            $table->foreign('created_by_id')->references('id')->on('users')->onDelete('cascade');
            $table->foreign('assigned_driver_id')->references('id')->on('users')->onDelete('set null');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('schedules');
    }
};

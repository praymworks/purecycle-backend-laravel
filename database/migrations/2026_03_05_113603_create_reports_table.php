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
        Schema::create('reports', function (Blueprint $table) {
            $table->id();
            $table->string('report_id')->unique(); // RPT-001, RPT-002, etc.
            $table->unsignedBigInteger('reporter_id'); // Foreign key to users table
            $table->string('reporter_name');
            $table->string('reporter_role'); // Purok Leader, Business Owner
            $table->string('barangay');
            $table->string('purok');
            $table->enum('priority', ['Low', 'Moderate', 'Urgent'])->default('Moderate');
            $table->enum('status', ['Pending', 'In Progress', 'Resolved', 'Rejected'])->default('Pending');
            $table->text('complaint');
            $table->string('photo')->nullable();
            $table->date('date_submitted');
            $table->text('staff_remarks')->nullable();
            $table->date('resolved_date')->nullable();
            $table->timestamps();
            $table->softDeletes();

            // Foreign key constraint
            $table->foreign('reporter_id')->references('id')->on('users')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('reports');
    }
};

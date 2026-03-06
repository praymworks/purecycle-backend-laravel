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
        Schema::create('announcements', function (Blueprint $table) {
            $table->id();
            $table->string('announcement_id')->unique(); // ANN-001, ANN-002, etc.
            $table->string('title');
            $table->text('message');
            $table->enum('priority', ['Low', 'Moderate', 'Urgent'])->default('Moderate');
            $table->date('start_date');
            $table->date('end_date');
            $table->enum('status', ['Draft', 'Active', 'Expired', 'Archived'])->default('Draft');
            $table->date('date_posted');
            $table->unsignedBigInteger('created_by_id'); // Who created the announcement
            $table->json('attachments')->nullable(); // Array of attachment filenames
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
        Schema::dropIfExists('announcements');
    }
};

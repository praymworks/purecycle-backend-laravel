<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('notifications', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('user_id'); // Who receives this notification
            $table->unsignedBigInteger('triggered_by_id')->nullable(); // Who triggered/created this notification
            $table->string('title');
            $table->text('message');
            $table->text('description')->nullable();
            $table->enum('type', ['report', 'account', 'announcement', 'schedule', 'system', 'analytics', 'route'])->default('system');
            $table->enum('priority', ['low', 'medium', 'high'])->default('medium');
            $table->boolean('unread')->default(true);
            $table->string('action_url')->nullable();
            $table->string('sender_name')->nullable();
            $table->string('sender_role')->nullable();
            $table->string('sender_avatar')->nullable();
            $table->json('metadata')->nullable(); // Additional data (report_id, schedule_id, etc.)
            $table->timestamps();
            $table->softDeletes();

            // Foreign keys
            $table->foreign('user_id')->references('id')->on('users')->onDelete('cascade');
            $table->foreign('triggered_by_id')->references('id')->on('users')->onDelete('set null');
            
            // Indexes for performance
            $table->index(['user_id', 'unread']);
            $table->index(['user_id', 'type']);
            $table->index(['created_at']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('notifications');
    }
};

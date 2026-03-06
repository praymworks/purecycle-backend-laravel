<?php

namespace App\Helpers;

use Carbon\Carbon;

class DateTimeHelper
{
    /**
     * Format date to YYYY-MM-DD (no time, no timezone)
     * 
     * @param string|Carbon|null $date
     * @return string|null
     */
    public static function formatDate($date)
    {
        if (!$date) {
            return null;
        }

        try {
            return Carbon::parse($date)->format('Y-m-d');
        } catch (\Exception $e) {
            return null;
        }
    }

    /**
     * Format time to HH:MM:SS
     * 
     * @param string|Carbon|null $time
     * @return string|null
     */
    public static function formatTime($time)
    {
        if (!$time) {
            return null;
        }

        try {
            return Carbon::parse($time)->format('H:i:s');
        } catch (\Exception $e) {
            return null;
        }
    }

    /**
     * Format datetime to ISO 8601 format with timezone
     * 
     * @param string|Carbon|null $datetime
     * @return string|null
     */
    public static function formatDateTime($datetime)
    {
        if (!$datetime) {
            return null;
        }

        try {
            return Carbon::parse($datetime)->toIso8601String();
        } catch (\Exception $e) {
            return null;
        }
    }

    /**
     * Get day name from date (Monday, Tuesday, etc.)
     * 
     * @param string|Carbon|null $date
     * @return string|null
     */
    public static function getDayName($date)
    {
        if (!$date) {
            return null;
        }

        try {
            return Carbon::parse($date)->format('l'); // 'l' = full day name
        } catch (\Exception $e) {
            return null;
        }
    }

    /**
     * Convert date to frontend-friendly format (Y-m-d only, no timezone)
     * This ensures no timezone conversion issues
     * 
     * @param string|Carbon|null $date
     * @return string|null
     */
    public static function toFrontendDate($date)
    {
        if (!$date) {
            return null;
        }

        try {
            // Parse and return YYYY-MM-DD only
            $carbon = Carbon::parse($date);
            return $carbon->format('Y-m-d');
        } catch (\Exception $e) {
            return null;
        }
    }

    /**
     * Format schedule response data for frontend
     * 
     * @param object $schedule
     * @return array
     */
    public static function formatScheduleForFrontend($schedule)
    {
        return [
            'id' => $schedule->id,
            'schedule_id' => $schedule->schedule_id,
            'route_id' => $schedule->route_id,
            'day' => self::getDayName($schedule->date) ?? $schedule->day, // Calculate from date
            'date' => self::toFrontendDate($schedule->date), // YYYY-MM-DD only
            'start_time' => $schedule->start_time,
            'end_time' => $schedule->end_time,
            'status' => $schedule->status,
            'cancel_reason' => $schedule->cancel_reason,
            'stops' => $schedule->stops,
            'notes' => $schedule->notes,
            'created_by_id' => $schedule->created_by_id,
            'assigned_driver_id' => $schedule->assigned_driver_id,
            'created_at' => $schedule->created_at,
            'updated_at' => $schedule->updated_at,
        ];
    }
}

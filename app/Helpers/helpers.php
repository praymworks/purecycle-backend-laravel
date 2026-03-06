<?php

use App\Helpers\DateTimeHelper;

if (!function_exists('format_date')) {
    /**
     * Format date to YYYY-MM-DD
     */
    function format_date($date)
    {
        return DateTimeHelper::formatDate($date);
    }
}

if (!function_exists('format_time')) {
    /**
     * Format time to HH:MM:SS
     */
    function format_time($time)
    {
        return DateTimeHelper::formatTime($time);
    }
}

if (!function_exists('get_day_name')) {
    /**
     * Get day name from date
     */
    function get_day_name($date)
    {
        return DateTimeHelper::getDayName($date);
    }
}

if (!function_exists('to_frontend_date')) {
    /**
     * Convert date to frontend format (no timezone issues)
     */
    function to_frontend_date($date)
    {
        return DateTimeHelper::toFrontendDate($date);
    }
}

<?php

namespace App\Http\Controllers;

use App\Models\Schedule;
use App\Models\Report;
use App\Models\Route;
use App\Models\User;
use Illuminate\Http\Request;
use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx;
use PhpOffice\PhpSpreadsheet\Style\Fill;
use PhpOffice\PhpSpreadsheet\Style\Border;
use PhpOffice\PhpSpreadsheet\Style\Alignment;
use Carbon\Carbon;

class ExportController extends Controller
{
    /**
     * Export Collection Report
     */
    public function exportCollections(Request $request)
    {
        try {
            $startDate = $request->get('start_date', now()->startOfMonth()->toDateString());
            $endDate = $request->get('end_date', now()->endOfMonth()->toDateString());

            $schedules = Schedule::with(['route', 'createdBy', 'assignedDriver'])
                ->whereBetween('date', [$startDate, $endDate])
                ->orderBy('date', 'desc')
                ->get();

            $spreadsheet = new Spreadsheet();
            $sheet = $spreadsheet->getActiveSheet();
            $sheet->setTitle('Collections Report');

            // Header
            $headers = ['Schedule ID', 'Route', 'Day', 'Date', 'Start Time', 'End Time', 'Status', 'Total Stops', 'Completed Stops', 'Progress %',  'Created By'];
            $sheet->fromArray($headers, null, 'A1');

            // Style header
            $headerStyle = [
                'font' => ['bold' => true, 'color' => ['rgb' => 'FFFFFF']],
                'fill' => ['fillType' => Fill::FILL_SOLID, 'startColor' => ['rgb' => '4472C4']],
                'alignment' => ['horizontal' => Alignment::HORIZONTAL_CENTER],
            ];
            $sheet->getStyle('A1:L1')->applyFromArray($headerStyle);

            // Data
            $row = 2;
            foreach ($schedules as $schedule) {
                $sheet->fromArray([
                    $schedule->schedule_id,
                    $schedule->route ? $schedule->route->name : 'N/A',
                    $schedule->day,
                    $schedule->date->format('Y-m-d'),
                    $schedule->start_time,
                    $schedule->end_time ?? 'N/A',
                    $schedule->status,
                    $schedule->getTotalStops(),
                    $schedule->getCompletedStops(),
                    $schedule->getProgressPercentage() . '%',
                    $schedule->createdBy ? $schedule->createdBy->fullname : 'N/A',
                ], null, 'A' . $row);
                $row++;
            }

            // Auto-size columns
            foreach (range('A', 'L') as $col) {
                $sheet->getColumnDimension($col)->setAutoSize(true);
            }

            // Generate filename
            $filename = 'Collections_Report_' . date('Y-m-d_His') . '.xlsx';
            $uploadPath = public_path('uploads/downloads');
            
            // Create directory if not exists
            if (!file_exists($uploadPath)) {
                mkdir($uploadPath, 0755, true);
            }

            $filePath = $uploadPath . '/' . $filename;

            $writer = new Xlsx($spreadsheet);
            $writer->save($filePath);

            return response()->json([
                'success' => true,
                'message' => 'Collections report generated successfully',
                'data' => [
                    'filename' => $filename,
                    'path' => 'uploads/downloads/' . $filename,
                    'url' => url('uploads/downloads/' . $filename),
                ]
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to export collections report',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Export Reports Summary
     */
    public function exportReports(Request $request)
    {
        try {
            $startDate = $request->get('start_date', now()->startOfMonth()->toDateString());
            $endDate = $request->get('end_date', now()->endOfMonth()->toDateString());

            $reports = Report::with(['reporter', 'updatedBy'])
                ->whereBetween('date_submitted', [$startDate, $endDate])
                ->orderBy('date_submitted', 'desc')
                ->get();

            $spreadsheet = new Spreadsheet();
            $sheet = $spreadsheet->getActiveSheet();
            $sheet->setTitle('Reports Summary');

            // Header
            $headers = ['Report ID', 'Reporter', 'Role', 'Barangay', 'Purok', 'Priority', 'Status', 'Complaint', 'Date Submitted', 'Resolved Date', 'Resolution Days', 'Staff Remarks', 'Updated By'];
            $sheet->fromArray($headers, null, 'A1');

            // Style header
            $headerStyle = [
                'font' => ['bold' => true, 'color' => ['rgb' => 'FFFFFF']],
                'fill' => ['fillType' => Fill::FILL_SOLID, 'startColor' => ['rgb' => '70AD47']],
                'alignment' => ['horizontal' => Alignment::HORIZONTAL_CENTER],
            ];
            $sheet->getStyle('A1:M1')->applyFromArray($headerStyle);

            // Data
            $row = 2;
            foreach ($reports as $report) {
                $resolutionDays = $report->resolved_date && $report->date_submitted
                    ? $report->date_submitted->diffInDays($report->resolved_date)
                    : 'N/A';

                $sheet->fromArray([
                    $report->report_id,
                    $report->reporter_name,
                    $report->reporter_role,
                    $report->barangay,
                    $report->purok,
                    $report->priority,
                    $report->status,
                    $report->complaint,
                    $report->date_submitted->format('Y-m-d'),
                    $report->resolved_date ? $report->resolved_date->format('Y-m-d') : 'N/A',
                    $resolutionDays,
                    $report->staff_remarks ?? 'N/A',
                    $report->updatedBy ? $report->updatedBy->fullname : 'N/A',
                ], null, 'A' . $row);
                $row++;
            }

            // Auto-size columns
            foreach (range('A', 'M') as $col) {
                $sheet->getColumnDimension($col)->setAutoSize(true);
            }

            // Generate filename
            $filename = 'Reports_Summary_' . date('Y-m-d_His') . '.xlsx';
            $uploadPath = public_path('uploads/downloads');
            
            if (!file_exists($uploadPath)) {
                mkdir($uploadPath, 0755, true);
            }

            $filePath = $uploadPath . '/' . $filename;

            $writer = new Xlsx($spreadsheet);
            $writer->save($filePath);

            return response()->json([
                'success' => true,
                'message' => 'Reports summary generated successfully',
                'data' => [
                    'filename' => $filename,
                    'path' => 'uploads/downloads/' . $filename,
                    'url' => url('uploads/downloads/' . $filename),
                ]
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to export reports summary',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Export Route Performance Report
     */
    public function exportRoutePerformance()
    {
        try {
            $routes = Route::with('createdBy')->get();

            $spreadsheet = new Spreadsheet();
            $sheet = $spreadsheet->getActiveSheet();
            $sheet->setTitle('Route Performance');

            // Header
            $headers = ['Route ID', 'Route Name', 'Municipality', 'Province', 'Status', 'Total Trips', 'Completed Trips', 'Completion Rate %', 'Waypoints', 'Distance', 'Est. Duration', 'Created By'];
            $sheet->fromArray($headers, null, 'A1');

            // Style header
            $headerStyle = [
                'font' => ['bold' => true, 'color' => ['rgb' => 'FFFFFF']],
                'fill' => ['fillType' => Fill::FILL_SOLID, 'startColor' => ['rgb' => 'FFC000']],
                'alignment' => ['horizontal' => Alignment::HORIZONTAL_CENTER],
            ];
            $sheet->getStyle('A1:L1')->applyFromArray($headerStyle);

            // Data
            $row = 2;
            foreach ($routes as $route) {
                $totalTrips = Schedule::where('route_id', $route->id)->count();
                $completedTrips = Schedule::where('route_id', $route->id)->where('status', 'completed')->count();
                $completionRate = $totalTrips > 0 ? round(($completedTrips / $totalTrips) * 100, 2) : 0;

                $sheet->fromArray([
                    $route->route_id,
                    $route->name,
                    $route->municipality,
                    $route->province,
                    $route->status,
                    $totalTrips,
                    $completedTrips,
                    $completionRate,
                    count($route->waypoints),
                    $route->distance ?? 'N/A',
                    $route->estimated_duration ?? 'N/A',
                    $route->createdBy ? $route->createdBy->fullname : 'N/A',
                ], null, 'A' . $row);
                $row++;
            }

            // Auto-size columns
            foreach (range('A', 'L') as $col) {
                $sheet->getColumnDimension($col)->setAutoSize(true);
            }

            // Generate filename
            $filename = 'Route_Performance_' . date('Y-m-d_His') . '.xlsx';
            $uploadPath = public_path('uploads/downloads');
            
            if (!file_exists($uploadPath)) {
                mkdir($uploadPath, 0755, true);
            }

            $filePath = $uploadPath . '/' . $filename;

            $writer = new Xlsx($spreadsheet);
            $writer->save($filePath);

            return response()->json([
                'success' => true,
                'message' => 'Route performance report generated successfully',
                'data' => [
                    'filename' => $filename,
                    'path' => 'uploads/downloads/' . $filename,
                    'url' => url('uploads/downloads/' . $filename),
                ]
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to export route performance',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Export Users Report
     */
    public function exportUsers()
    {
        try {
            $users = User::with(['roleDetails', 'purokLeader', 'businessOwner'])->get();

            $spreadsheet = new Spreadsheet();
            $sheet = $spreadsheet->getActiveSheet();
            $sheet->setTitle('Users Report');

            // Header
            $headers = ['ID', 'Full Name', 'Email', 'Contact Number', 'Role', 'Status', 'City/Municipality', 'Barangay', 'Purok', 'Registration Date'];
            $sheet->fromArray($headers, null, 'A1');

            // Style header
            $headerStyle = [
                'font' => ['bold' => true, 'color' => ['rgb' => 'FFFFFF']],
                'fill' => ['fillType' => Fill::FILL_SOLID, 'startColor' => ['rgb' => 'E74C3C']],
                'alignment' => ['horizontal' => Alignment::HORIZONTAL_CENTER],
            ];
            $sheet->getStyle('A1:J1')->applyFromArray($headerStyle);

            // Data
            $row = 2;
            foreach ($users as $user) {
                $sheet->fromArray([
                    $user->id,
                    $user->fullname,
                    $user->email,
                    $user->contact_number ?? 'N/A',
                    ucfirst(str_replace('_', ' ', $user->role)),
                    ucfirst($user->status),
                    $user->city_municipality ?? 'N/A',
                    $user->barangay ?? 'N/A',
                    $user->purok ?? 'N/A',
                    $user->created_at->format('Y-m-d H:i:s'),
                ], null, 'A' . $row);
                $row++;
            }

            // Auto-size columns
            foreach (range('A', 'J') as $col) {
                $sheet->getColumnDimension($col)->setAutoSize(true);
            }

            // Generate filename
            $filename = 'Users_Report_' . date('Y-m-d_His') . '.xlsx';
            $uploadPath = public_path('uploads/downloads');
            
            if (!file_exists($uploadPath)) {
                mkdir($uploadPath, 0755, true);
            }

            $filePath = $uploadPath . '/' . $filename;

            $writer = new Xlsx($spreadsheet);
            $writer->save($filePath);

            return response()->json([
                'success' => true,
                'message' => 'Users report generated successfully',
                'data' => [
                    'filename' => $filename,
                    'path' => 'uploads/downloads/' . $filename,
                    'url' => url('uploads/downloads/' . $filename),
                ]
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to export users report',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Export Comprehensive Analytics Report (Multiple Sheets)
     */
    public function exportAnalytics(Request $request)
    {
        try {
            $period = $request->get('period', 'month');
            $startDate = match($period) {
                'week' => now()->startOfWeek(),
                'month' => now()->startOfMonth(),
                'year' => now()->startOfYear(),
                default => now()->startOfMonth(),
            };

            $spreadsheet = new Spreadsheet();

            // Sheet 1: Overview
            $this->createOverviewSheet($spreadsheet, 0);

            // Sheet 2: Collections
            $this->createCollectionsSheet($spreadsheet, 1, $startDate, now());

            // Sheet 3: Reports
            $this->createReportsSheet($spreadsheet, 2, $startDate, now());

            // Sheet 4: Routes
            $this->createRoutesSheet($spreadsheet, 3);

            // Generate filename
            $filename = 'Analytics_Report_' . $period . '_' . date('Y-m-d_His') . '.xlsx';
            $uploadPath = public_path('uploads/downloads');
            
            if (!file_exists($uploadPath)) {
                mkdir($uploadPath, 0755, true);
            }

            $filePath = $uploadPath . '/' . $filename;

            $writer = new Xlsx($spreadsheet);
            $writer->save($filePath);

            return response()->json([
                'success' => true,
                'message' => 'Analytics report generated successfully',
                'data' => [
                    'filename' => $filename,
                    'path' => 'uploads/downloads/' . $filename,
                    'url' => url('uploads/downloads/' . $filename),
                ]
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to export analytics report',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Delete a downloaded export file from the server
     */
    public function deleteDownloadedFile(Request $request)
    {
        try {
            $filename = $request->get('filename');

            if (!$filename) {
                return response()->json([
                    'success' => false,
                    'message' => 'Filename is required',
                ], 400);
            }

            // Security: strip any directory traversal, only allow filenames
            $filename = basename($filename);
            $filePath = public_path('uploads/downloads/' . $filename);

            if (file_exists($filePath)) {
                unlink($filePath);
                return response()->json([
                    'success' => true,
                    'message' => 'File deleted successfully',
                ]);
            }

            return response()->json([
                'success' => false,
                'message' => 'File not found',
            ], 404);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to delete file',
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    // Helper methods for multi-sheet export
    private function createOverviewSheet($spreadsheet, $index)
    {
        if ($index === 0) {
            $sheet = $spreadsheet->getActiveSheet();
        } else {
            $sheet = $spreadsheet->createSheet($index);
        }
        $sheet->setTitle('Overview');

        $data = [
            ['Metric', 'Value'],
            ['Total Users', User::count()],
            ['Active Routes', Route::status('active')->count()],
            ['Total Schedules', Schedule::count()],
            ['Completed Collections', Schedule::status('completed')->count()],
            ['Total Reports', Report::count()],
            ['Pending Reports', Report::status('Pending')->count()],
        ];

        $sheet->fromArray($data, null, 'A1');
        $sheet->getStyle('A1:B1')->getFont()->setBold(true);
        $sheet->getColumnDimension('A')->setAutoSize(true);
        $sheet->getColumnDimension('B')->setAutoSize(true);
    }

    private function createCollectionsSheet($spreadsheet, $index, $startDate, $endDate)
    {
        $sheet = $spreadsheet->createSheet($index);
        $sheet->setTitle('Collections');

        $schedules = Schedule::with('route')
            ->whereBetween('date', [$startDate, $endDate])
            ->get();

        $headers = ['Schedule ID', 'Route', 'Date', 'Status', 'Progress %'];
        $sheet->fromArray($headers, null, 'A1');
        $sheet->getStyle('A1:E1')->getFont()->setBold(true);

        $row = 2;
        foreach ($schedules as $schedule) {
            $sheet->fromArray([
                $schedule->schedule_id,
                $schedule->route ? $schedule->route->name : 'N/A',
                $schedule->date->format('Y-m-d'),
                $schedule->status,
                $schedule->getProgressPercentage() . '%',
            ], null, 'A' . $row);
            $row++;
        }

        foreach (range('A', 'E') as $col) {
            $sheet->getColumnDimension($col)->setAutoSize(true);
        }
    }

    private function createReportsSheet($spreadsheet, $index, $startDate, $endDate)
    {
        $sheet = $spreadsheet->createSheet($index);
        $sheet->setTitle('Reports');

        $reports = Report::whereBetween('date_submitted', [$startDate, $endDate])->get();

        $headers = ['Report ID', 'Priority', 'Status', 'Barangay', 'Date Submitted'];
        $sheet->fromArray($headers, null, 'A1');
        $sheet->getStyle('A1:E1')->getFont()->setBold(true);

        $row = 2;
        foreach ($reports as $report) {
            $sheet->fromArray([
                $report->report_id,
                $report->priority,
                $report->status,
                $report->barangay,
                $report->date_submitted->format('Y-m-d'),
            ], null, 'A' . $row);
            $row++;
        }

        foreach (range('A', 'E') as $col) {
            $sheet->getColumnDimension($col)->setAutoSize(true);
        }
    }

    private function createRoutesSheet($spreadsheet, $index)
    {
        $sheet = $spreadsheet->createSheet($index);
        $sheet->setTitle('Routes');

        $routes = Route::all();

        $headers = ['Route ID', 'Name', 'Municipality', 'Status', 'Distance'];
        $sheet->fromArray($headers, null, 'A1');
        $sheet->getStyle('A1:E1')->getFont()->setBold(true);

        $row = 2;
        foreach ($routes as $route) {
            $sheet->fromArray([
                $route->route_id,
                $route->name,
                $route->municipality,
                $route->status,
                $route->distance ?? 'N/A',
            ], null, 'A' . $row);
            $row++;
        }

        foreach (range('A', 'E') as $col) {
            $sheet->getColumnDimension($col)->setAutoSize(true);
        }
    }
}

<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\File;

class UploadController extends Controller
{
    /**
     * Upload valid ID document
     */
    public function uploadValidId(Request $request)
    {
        try {
            $validator = Validator::make($request->all(), [
                'file' => 'required|image|mimes:jpeg,png,jpg,gif|max:5120', // 5MB max
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Validation error',
                    'errors' => $validator->errors()
                ], 422);
            }

            if ($request->hasFile('file')) {
                $file = $request->file('file');
                
                // Create directory if it doesn't exist
                $uploadPath = public_path('uploads/images/id');
                if (!File::exists($uploadPath)) {
                    File::makeDirectory($uploadPath, 0755, true);
                }

                // Generate unique filename
                $filename = time() . '_' . uniqid() . '.' . $file->getClientOriginalExtension();
                
                // Move file to public directory
                $file->move($uploadPath, $filename);

                // Generate URL
                $url = url('uploads/images/id/' . $filename);

                return response()->json([
                    'success' => true,
                    'message' => 'Valid ID uploaded successfully',
                    'data' => [
                        'filename' => $filename,
                        'url' => $url,
                        'path' => 'uploads/images/id/' . $filename
                    ]
                ], 200);
            }

            return response()->json([
                'success' => false,
                'message' => 'No file uploaded'
            ], 400);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to upload valid ID',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Upload business permit
     */
    public function uploadBusinessPermit(Request $request)
    {
        try {
            $validator = Validator::make($request->all(), [
                'file' => 'required|image|mimes:jpeg,png,jpg,gif,pdf|max:5120', // 5MB max
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Validation error',
                    'errors' => $validator->errors()
                ], 422);
            }

            if ($request->hasFile('file')) {
                $file = $request->file('file');
                
                // Create directory if it doesn't exist
                $uploadPath = public_path('uploads/images/business_permit');
                if (!File::exists($uploadPath)) {
                    File::makeDirectory($uploadPath, 0755, true);
                }

                // Generate unique filename
                $filename = time() . '_' . uniqid() . '.' . $file->getClientOriginalExtension();
                
                // Move file to public directory
                $file->move($uploadPath, $filename);

                // Generate URL
                $url = url('uploads/images/business_permit/' . $filename);

                return response()->json([
                    'success' => true,
                    'message' => 'Business permit uploaded successfully',
                    'data' => [
                        'filename' => $filename,
                        'url' => $url,
                        'path' => 'uploads/images/business_permit/' . $filename
                    ]
                ], 200);
            }

            return response()->json([
                'success' => false,
                'message' => 'No file uploaded'
            ], 400);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to upload business permit',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Upload profile picture
     */
    public function uploadProfilePicture(Request $request)
    {
        try {
            $validator = Validator::make($request->all(), [
                'file' => 'required|image|mimes:jpeg,png,jpg,gif|max:5120', // 5MB max
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Validation error',
                    'errors' => $validator->errors()
                ], 422);
            }

            if ($request->hasFile('file')) {
                $file = $request->file('file');
                
                // Create directory if it doesn't exist
                $uploadPath = public_path('uploads/images/profile_path');
                if (!File::exists($uploadPath)) {
                    File::makeDirectory($uploadPath, 0755, true);
                }

                // Generate unique filename
                $filename = time() . '_' . uniqid() . '.' . $file->getClientOriginalExtension();
                
                // Move file to public directory
                $file->move($uploadPath, $filename);

                // Generate URL
                $url = url('uploads/images/profile_path/' . $filename);

                return response()->json([
                    'success' => true,
                    'message' => 'Profile picture uploaded successfully',
                    'data' => [
                        'filename' => $filename,
                        'url' => $url,
                        'path' => 'uploads/images/profile_path/' . $filename
                    ]
                ], 200);
            }

            return response()->json([
                'success' => false,
                'message' => 'No file uploaded'
            ], 400);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to upload profile picture',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Upload announcement attachment (supports images, documents, PDFs, Excel)
     */
    public function uploadAnnouncementAttachment(Request $request)
    {
        try {
            $validator = Validator::make($request->all(), [
                'file' => 'required|file|mimes:jpeg,png,jpg,gif,pdf,doc,docx,xls,xlsx,csv|max:10240', // 10MB max
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Validation error',
                    'errors' => $validator->errors()
                ], 422);
            }

            if ($request->hasFile('file')) {
                $file = $request->file('file');
                $extension = $file->getClientOriginalExtension();
                $originalName = $file->getClientOriginalName();
                $fileSize = $file->getSize(); // Get size before moving
                
                // Determine file type and upload path
                $fileType = '';
                $uploadPath = '';
                
                // Image files
                if (in_array(strtolower($extension), ['jpeg', 'jpg', 'png', 'gif'])) {
                    $fileType = 'image';
                    $uploadPath = public_path('uploads/announcements/images');
                }
                // PDF files
                elseif (strtolower($extension) === 'pdf') {
                    $fileType = 'pdf';
                    $uploadPath = public_path('uploads/announcements/pdf');
                }
                // Word documents
                elseif (in_array(strtolower($extension), ['doc', 'docx'])) {
                    $fileType = 'document';
                    $uploadPath = public_path('uploads/announcements/documents');
                }
                // Excel files
                elseif (in_array(strtolower($extension), ['xls', 'xlsx', 'csv'])) {
                    $fileType = 'spreadsheet';
                    $uploadPath = public_path('uploads/announcements/spreadsheets');
                }
                
                // Create directory if it doesn't exist
                if (!File::exists($uploadPath)) {
                    File::makeDirectory($uploadPath, 0755, true);
                }

                // Generate unique filename
                $filename = time() . '_' . uniqid() . '.' . $extension;
                
                // Move file to public directory
                $file->move($uploadPath, $filename);

                // Generate URL and path
                $relativePath = 'uploads/announcements/' . ($fileType === 'image' ? 'images' : ($fileType === 'pdf' ? 'pdf' : ($fileType === 'document' ? 'documents' : 'spreadsheets'))) . '/' . $filename;
                $url = url($relativePath);

                return response()->json([
                    'success' => true,
                    'message' => 'File uploaded successfully',
                    'data' => [
                        'filename' => $filename,
                        'original_name' => $originalName,
                        'file_type' => $fileType,
                        'extension' => $extension,
                        'size' => $fileSize,
                        'url' => $url,
                        'path' => $relativePath
                    ]
                ], 200);
            }

            return response()->json([
                'success' => false,
                'message' => 'No file uploaded'
            ], 400);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to upload file',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Delete uploaded file
     */
    public function deleteFile(Request $request)
    {
        try {
            $validator = Validator::make($request->all(), [
                'path' => 'required|string',
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Validation error',
                    'errors' => $validator->errors()
                ], 422);
            }

            $filePath = public_path($request->path);

            if (File::exists($filePath)) {
                File::delete($filePath);

                return response()->json([
                    'success' => true,
                    'message' => 'File deleted successfully'
                ], 200);
            }

            return response()->json([
                'success' => false,
                'message' => 'File not found'
            ], 404);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to delete file',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}

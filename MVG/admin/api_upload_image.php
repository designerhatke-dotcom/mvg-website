<?php
/**
 * MVG Power Solutions — Admin Image Upload API
 * Handles file uploads and saves to assets/products/
 */

require_once __DIR__ . '/auth.php';
requireAdminAuth();

header('Content-Type: application/json; charset=utf-8');

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode(['status' => 'error', 'message' => 'Invalid request method.']);
    exit;
}

if (!isset($_FILES['image_file']) || $_FILES['image_file']['error'] !== UPLOAD_ERR_OK) {
    $errCode = $_FILES['image_file']['error'] ?? 'no_file';
    echo json_encode(['status' => 'error', 'message' => 'No file uploaded or upload error occurred (Code: ' . $errCode . ').']);
    exit;
}

$file = $_FILES['image_file'];
$uploadDir = __DIR__ . '/../assets/products/';

if (!is_dir($uploadDir)) {
    mkdir($uploadDir, 0755, true);
}

$allowedExtensions = ['jpg', 'jpeg', 'png', 'webp', 'svg', 'gif'];
$origName = $file['name'];
$ext = strtolower(pathinfo($origName, PATHINFO_EXTENSION));

if (!in_array($ext, $allowedExtensions)) {
    echo json_encode(['status' => 'error', 'message' => 'Invalid file type. Allowed: JPG, PNG, WEBP, SVG, GIF.']);
    exit;
}

// User specified filename or sanitized original name
$customFilename = trim($_POST['desired_filename'] ?? '');
if (!empty($customFilename)) {
    $slugName = preg_replace('/[^A-Za-z0-9_-]+/', '-', pathinfo($customFilename, PATHINFO_FILENAME));
    $filename = $slugName . '.' . $ext;
} else {
    $cleanBasename = preg_replace('/[^A-Za-z0-9_-]+/', '-', pathinfo($origName, PATHINFO_FILENAME));
    $filename = $cleanBasename . '-' . time() . '.' . $ext;
}

$targetPath = $uploadDir . $filename;

if (move_uploaded_file($file['tmp_name'], $targetPath)) {
    $relativeUrl = 'assets/products/' . $filename;
    echo json_encode([
        'status' => 'success',
        'message' => 'Image uploaded successfully.',
        'url' => $relativeUrl,
        'filename' => $filename,
        'size' => filesize($targetPath)
    ]);
} else {
    echo json_encode(['status' => 'error', 'message' => 'Failed to save uploaded file. Check directory permissions.']);
}

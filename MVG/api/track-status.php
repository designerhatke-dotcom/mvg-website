<?php
/**
 * MVG Power Solutions — Inquiry Status Tracker API
 */

require_once __DIR__ . '/../config/constants.php';
require_once __DIR__ . '/../config/db.php';

header('Content-Type: application/json; charset=utf-8');

$rfq = trim($_GET['rfq'] ?? $_POST['rfq'] ?? '');
$phone = trim($_GET['phone'] ?? $_POST['phone'] ?? '');

if (empty($rfq)) {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => 'Please provide an RFQ Reference Number.']);
    exit;
}

$found = null;
$items = [];

// Try database
$pdo = Database::getConnection();
if ($pdo) {
    try {
        $stmt = $pdo->prepare("SELECT * FROM inquiries WHERE rfq_number = ? LIMIT 1");
        $stmt->execute([$rfq]);
        $found = $stmt->fetch();

        if ($found) {
            $itemStmt = $pdo->prepare("SELECT * FROM inquiry_items WHERE inquiry_id = ?");
            $itemStmt->execute([$found['id']]);
            $items = $itemStmt->fetchAll();
        }
    } catch (Exception $e) {}
}

// Fallback to JSON
if (!$found) {
    $jsonFile = __DIR__ . '/../data/inquiries.json';
    if (file_exists($jsonFile)) {
        $inquiries = json_decode(file_get_contents($jsonFile), true) ?: [];
        foreach ($inquiries as $inq) {
            if (strcasecmp($inq['rfq_number'] ?? '', $rfq) === 0) {
                $found = $inq;
                $items = $inq['items'] ?? [];
                break;
            }
        }
    }
}

if (!$found) {
    http_response_code(404);
    echo json_encode(['success' => false, 'message' => 'No quotation request found with reference: ' . htmlspecialchars($rfq)]);
    exit;
}

echo json_encode([
    'success' => true,
    'data'    => [
        'rfq_number'            => $found['rfq_number'],
        'customer_name'         => $found['customer_name'],
        'company_name'          => $found['company_name'] ?? '',
        'status'                => $found['status'] ?? 'new',
        'total_estimated_value' => floatval($found['total_estimated_value'] ?? 0),
        'created_at'            => $found['created_at'],
        'items'                 => $items
    ]
]);

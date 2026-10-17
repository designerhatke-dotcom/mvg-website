<?php
/**
 * MVG Power Solutions — B2B Inquiry & Quotation Request Submission API
 * Handles cart RFQ and product modal inquiries.
 * Saves to MySQL database and JSON fallback.
 */

require_once __DIR__ . '/../config/constants.php';
require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../config/settings.php';

header('Content-Type: application/json; charset=utf-8');

// Allow POST requests only
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['success' => false, 'message' => 'Method Not Allowed']);
    exit;
}

// Receive payload from JSON or standard POST
$rawInput = file_get_contents('php://input');
$inputData = json_decode($rawInput, true);

if (!is_array($inputData)) {
    $inputData = $_POST;
}

// Extract & Validate Fields
$customerName = trim($inputData['customer_name'] ?? $inputData['name'] ?? '');
$companyName  = trim($inputData['company_name'] ?? $inputData['company'] ?? '');
$email        = trim($inputData['email'] ?? '');
$phone        = trim($inputData['phone'] ?? '');
$gstin        = trim($inputData['gstin'] ?? '');
$city         = trim($inputData['city'] ?? '');
$state        = trim($inputData['state'] ?? '');
$pincode      = trim($inputData['pincode'] ?? '');
$address      = trim($inputData['address'] ?? '');
$urgency      = trim($inputData['delivery_urgency'] ?? $inputData['urgency'] ?? 'immediate');
$notes        = trim($inputData['notes'] ?? $inputData['message'] ?? '');
$items        = $inputData['items'] ?? [];

// Single product modal inquiry fallback
if (empty($items) && !empty($inputData['product_name'])) {
    $items = [
        [
            'product_id'   => intval($inputData['product_id'] ?? 0),
            'product_name' => trim($inputData['product_name']),
            'sku'          => trim($inputData['sku'] ?? ''),
            'quantity'     => max(10, intval($inputData['quantity'] ?? 10)),
            'unit_price'   => floatval($inputData['unit_price'] ?? 280.00),
            'specs'        => trim($inputData['specs'] ?? '')
        ]
    ];
}

// Validation
if (empty($customerName) || empty($phone)) {
    http_response_code(400);
    echo json_encode([
        'success' => false, 
        'message' => 'Customer name and active phone/WhatsApp number are required.'
    ]);
    exit;
}

if (empty($items) || !is_array($items)) {
    http_response_code(400);
    echo json_encode([
        'success' => false, 
        'message' => 'Please add at least one current transformer to your inquiry basket.'
    ]);
    exit;
}

// Generate Unique RFQ Number (e.g. RFQ-2026-7842)
$rfqNumber = 'RFQ-' . date('Y') . '-' . mt_rand(1000, 9999);
$ipAddress = $_SERVER['REMOTE_ADDR'] ?? '';

// Calculate total estimated value
$totalEstimated = 0.0;
$cleanedItems = [];

foreach ($items as $item) {
    $qty = max(1, intval($item['quantity'] ?? 10));
    $unitPrice = floatval($item['unit_price'] ?? $item['price'] ?? 280.00);
    $lineTotal = $qty * $unitPrice;
    $totalEstimated += $lineTotal;

    $cleanedItems[] = [
        'product_id'   => intval($item['product_id'] ?? $item['id'] ?? 0),
        'product_name' => trim($item['product_name'] ?? $item['name'] ?? 'Current Transformer'),
        'sku'          => trim($item['sku'] ?? ''),
        'quantity'     => $qty,
        'unit_price'   => $unitPrice,
        'total_price'  => $lineTotal,
        'specs'        => trim($item['specs'] ?? '')
    ];
}

// Save to MySQL Database if connected
$pdo = Database::getConnection();
$savedInDb = false;

if ($pdo) {
    try {
        $stmt = $pdo->prepare("
            INSERT INTO inquiries 
            (rfq_number, customer_name, company_name, email, phone, gstin, delivery_address, city, state, pincode, delivery_urgency, total_estimated_value, notes, status, source, ip_address)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'new', 'web_rfq_cart', ?)
        ");
        $stmt->execute([
            $rfqNumber,
            $customerName,
            $companyName,
            $email,
            $phone,
            $gstin,
            $address,
            $city,
            $state,
            $pincode,
            $urgency,
            $totalEstimated,
            $notes,
            $ipAddress
        ]);
        $inquiryId = $pdo->lastInsertId();

        // Insert Line Items
        $itemStmt = $pdo->prepare("
            INSERT INTO inquiry_items 
            (inquiry_id, product_id, product_name, sku, quantity, unit_price, total_price, requested_specs)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        ");
        foreach ($cleanedItems as $ci) {
            $itemStmt->execute([
                $inquiryId,
                $ci['product_id'] ?: null,
                $ci['product_name'],
                $ci['sku'],
                $ci['quantity'],
                $ci['unit_price'],
                $ci['total_price'],
                $ci['specs']
            ]);
        }
        $savedInDb = true;
    } catch (Exception $e) {
        error_log("Inquiry DB Save Error: " . $e->getMessage());
    }
}

// Fallback & Redundancy: Save to JSON File
$jsonDir = __DIR__ . '/../data';
if (!is_dir($jsonDir)) {
    @mkdir($jsonDir, 0755, true);
}
$inquiriesJsonFile = $jsonDir . '/inquiries.json';
$existingInquiries = file_exists($inquiriesJsonFile) 
    ? (json_decode(file_get_contents($inquiriesJsonFile), true) ?: []) 
    : [];

$inquiryRecord = [
    'id'                    => count($existingInquiries) + 1,
    'rfq_number'            => $rfqNumber,
    'customer_name'         => $customerName,
    'company_name'          => $companyName,
    'email'                 => $email,
    'phone'                 => $phone,
    'gstin'                 => $gstin,
    'delivery_address'      => $address,
    'city'                  => $city,
    'state'                 => $state,
    'pincode'               => $pincode,
    'delivery_urgency'      => $urgency,
    'total_estimated_value' => $totalEstimated,
    'notes'                 => $notes,
    'items'                 => $cleanedItems,
    'status'                => 'new',
    'created_at'            => date('Y-m-d H:i:s')
];

array_unshift($existingInquiries, $inquiryRecord);
@file_put_contents($inquiriesJsonFile, json_encode($existingInquiries, JSON_PRETTY_PRINT));

// Format WhatsApp Inquiry Message
$waText = "Hello MVG Power Solutions,\n\n";
$waText .= "I have submitted an official Quotation Request on your website.\n";
$waText .= "• RFQ Ref: *" . $rfqNumber . "*\n";
$waText .= "• Buyer: " . $customerName . ($companyName ? " (" . $companyName . ")" : "") . "\n";
$waText .= "• Phone: " . $phone . "\n";
if ($city) $waText .= "• Location: " . $city . ($state ? ", " . $state : "") . "\n";
if ($gstin) $waText .= "• GSTIN: " . $gstin . "\n";
$waText .= "\nRequested Items:\n";
foreach ($cleanedItems as $idx => $ci) {
    $waText .= ($idx + 1) . ". " . $ci['product_name'] . " — " . $ci['quantity'] . " pcs\n";
}
$waText .= "\nPlease provide the official proforma quotation with 18% GST ITC and earliest dispatch timeline.";

$waUrl = "https://wa.me/" . WHATSAPP_NUMBER . "?text=" . rawurlencode($waText);

// Return JSON response
echo json_encode([
    'success'      => true,
    'rfq_number'   => $rfqNumber,
    'message'      => 'Quotation request submitted successfully!',
    'redirect_url' => 'inquiry-success.php?rfq=' . urlencode($rfqNumber),
    'whatsapp_url' => $waUrl
]);

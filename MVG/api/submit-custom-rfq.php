<?php
/**
 * MVG Power Solutions — Custom CT Engineering Request API
 */

require_once __DIR__ . '/../config/constants.php';
require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../config/settings.php';

header('Content-Type: application/json; charset=utf-8');

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['success' => false, 'message' => 'Method Not Allowed']);
    exit;
}

$raw = file_get_contents('php://input');
$data = json_decode($raw, true) ?: $_POST;

$companyName       = trim($data['company_name'] ?? '');
$contactPerson     = trim($data['contact_person'] ?? $data['name'] ?? '');
$phone             = trim($data['phone'] ?? '');
$email             = trim($data['email'] ?? '');
$primaryCurrent    = trim($data['primary_current'] ?? '');
$secondaryCurrent  = trim($data['secondary_current'] ?? '5A');
$accuracyClass     = trim($data['accuracy_class'] ?? 'Class 1.0');
$ratedBurden       = trim($data['rated_burden'] ?? '5 VA');
$windowType        = trim($data['window_type'] ?? 'Round Cable');
$windowDimension   = trim($data['window_dimension'] ?? '');
$insulationType    = trim($data['insulation_type'] ?? 'Polycarbonate Encapsulated');
$quantity          = max(1, intval($data['quantity'] ?? 10));
$deliveryTimeline  = trim($data['delivery_timeline'] ?? 'Standard');
$notes             = trim($data['application_notes'] ?? $data['notes'] ?? '');

if (empty($contactPerson) || empty($phone) || empty($primaryCurrent)) {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => 'Please provide Contact Person, Phone, and Required Primary Current.']);
    exit;
}

$rfqNumber = 'CUST-' . date('Y') . '-' . mt_rand(1000, 9999);

$pdo = Database::getConnection();
if ($pdo) {
    try {
        $stmt = $pdo->prepare("
            INSERT INTO custom_ct_rfqs 
            (rfq_number, company_name, contact_person, phone, email, primary_current, secondary_current, accuracy_class, rated_burden, window_type, window_dimension, insulation_type, quantity, delivery_timeline, application_notes, status)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'new')
        ");
        $stmt->execute([
            $rfqNumber,
            $companyName,
            $contactPerson,
            $phone,
            $email,
            $primaryCurrent,
            $secondaryCurrent,
            $accuracyClass,
            $ratedBurden,
            $windowType,
            $windowDimension,
            $insulationType,
            $quantity,
            $deliveryTimeline,
            $notes
        ]);
    } catch (Exception $e) {
        error_log("Custom CT DB error: " . $e->getMessage());
    }
}

// JSON fallback
$jsonFile = __DIR__ . '/../data/custom_rfqs.json';
$existing = file_exists($jsonFile) ? (json_decode(file_get_contents($jsonFile), true) ?: []) : [];
$record = [
    'rfq_number'        => $rfqNumber,
    'company_name'      => $companyName,
    'contact_person'    => $contactPerson,
    'phone'             => $phone,
    'email'             => $email,
    'primary_current'   => $primaryCurrent,
    'secondary_current' => $secondaryCurrent,
    'accuracy_class'    => $accuracyClass,
    'rated_burden'      => $ratedBurden,
    'window_type'       => $windowType,
    'window_dimension'  => $windowDimension,
    'insulation_type'   => $insulationType,
    'quantity'          => $quantity,
    'delivery_timeline' => $deliveryTimeline,
    'application_notes' => $notes,
    'status'            => 'new',
    'created_at'        => date('Y-m-d H:i:s')
];
array_unshift($existing, $record);
@file_put_contents($jsonFile, json_encode($existing, JSON_PRETTY_PRINT));

// WhatsApp prefill
$waText = "Hello MVG Engineering Team,\n\n";
$waText .= "I require a Custom Current Transformer design quotation.\n";
$waText .= "• Ref: *" . $rfqNumber . "*\n";
$waText .= "• Client: " . $contactPerson . ($companyName ? " (" . $companyName . ")" : "") . "\n";
$waText .= "• Ratio: *" . $primaryCurrent . " / " . $secondaryCurrent . "*\n";
$waText .= "• Accuracy Class: " . $accuracyClass . "\n";
$waText .= "• Burden: " . $ratedBurden . "\n";
$waText .= "• Window / Aperture: " . $windowType . ($windowDimension ? " (" . $windowDimension . ")" : "") . "\n";
$waText .= "• Quantity: " . $quantity . " pcs\n";
if ($notes) $waText .= "• Application: " . $notes . "\n";

$waUrl = "https://wa.me/" . WHATSAPP_NUMBER . "?text=" . rawurlencode($waText);

echo json_encode([
    'success'      => true,
    'rfq_number'   => $rfqNumber,
    'message'      => 'Custom transformer specification received! Our technical team is reviewing it.',
    'whatsapp_url' => $waUrl
]);

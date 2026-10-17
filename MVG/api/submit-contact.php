<?php
/**
 * MVG Power Solutions — Contact Form Handler API
 * Saves messages to MySQL database and JSON file backup.
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

$name    = trim($data['name'] ?? '');
$company = trim($data['company'] ?? '');
$email   = trim($data['email'] ?? '');
$phone   = trim($data['phone'] ?? '');
$subject = trim($data['subject'] ?? 'Website Inquiry');
$message = trim($data['message'] ?? '');

if (empty($name) || empty($phone) || empty($message)) {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => 'Please fill in Name, Phone, and Message.']);
    exit;
}

$pdo = Database::getConnection();
if ($pdo) {
    try {
        $stmt = $pdo->prepare("INSERT INTO contact_messages (name, company, email, phone, subject, message) VALUES (?, ?, ?, ?, ?, ?)");
        $stmt->execute([$name, $company, $email, $phone, $subject, $message]);
    } catch (Exception $e) {
        error_log("Contact DB error: " . $e->getMessage());
    }
}

// JSON fallback
$jsonFile = __DIR__ . '/../data/contact_messages.json';
$existing = file_exists($jsonFile) ? (json_decode(file_get_contents($jsonFile), true) ?: []) : [];
$record = [
    'id'         => count($existing) + 1,
    'name'       => $name,
    'company'    => $company,
    'email'      => $email,
    'phone'      => $phone,
    'subject'    => $subject,
    'message'    => $message,
    'created_at' => date('Y-m-d H:i:s')
];
array_unshift($existing, $record);
@file_put_contents($jsonFile, json_encode($existing, JSON_PRETTY_PRINT));

echo json_encode([
    'success' => true,
    'message' => 'Thank you! Your message has been received. Our team will contact you shortly.'
]);

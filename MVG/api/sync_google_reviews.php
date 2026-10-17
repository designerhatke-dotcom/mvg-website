<?php
/**
 * MVG Power Solutions — Live Google Reviews Sync & Diagnostic Endpoint
 */

header('Content-Type: application/json; charset=utf-8');
require_once __DIR__ . '/../config/constants.php';
require_once __DIR__ . '/../includes/google_reviews.php';

$action = $_GET['action'] ?? 'sync';

if ($action === 'test') {
    $apiKey = GOOGLE_PLACES_API_KEY;
    $placeId = GOOGLE_PLACE_ID;

    // Test Places API (New)
    $url = "https://places.googleapis.com/v1/places/{$placeId}?fields=id,displayName,rating,userRatingCount,reviews&key={$apiKey}";
    
    $ch = curl_init($url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_TIMEOUT, 10);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
    $response = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);

    $json = json_decode($response, true);

    if ($httpCode === 200 && !empty($json['id'])) {
        echo json_encode([
            'status' => 'success',
            'http_code' => $httpCode,
            'message' => 'Connected successfully to Google Places API!',
            'data' => $json
        ]);
    } else {
        $errorMessage = $json['error']['message'] ?? 'Unable to connect to Google Places API.';
        $errorStatus = $json['error']['status'] ?? 'ERROR';
        echo json_encode([
            'status' => 'error',
            'http_code' => $httpCode,
            'error_status' => $errorStatus,
            'message' => $errorMessage,
            'raw' => $json
        ]);
    }
    exit;
}

if ($action === 'sync') {
    $forceRefresh = isset($_GET['force']) && $_GET['force'] === '1';
    $data = GoogleReviewsService::getReviewsData($forceRefresh);
    echo json_encode([
        'status' => 'success',
        'data' => $data
    ]);
    exit;
}

if ($action === 'save_list') {
    $raw = file_get_contents('php://input');
    $payload = json_decode($raw, true);
    if (!isset($payload['reviews']) || !is_array($payload['reviews'])) {
        echo json_encode(['status' => 'error', 'message' => 'Invalid reviews payload']);
        exit;
    }

    $cacheFile = __DIR__ . '/../data/google_reviews.json';
    $existing = [];
    if (file_exists($cacheFile)) {
        $existing = json_decode(file_get_contents($cacheFile), true) ?: [];
    }

    $existing['reviews'] = $payload['reviews'];
    $existing['user_ratings_total'] = count($payload['reviews']);
    $existing['last_fetched'] = time();
    $existing['last_fetched_date'] = date('Y-m-d H:i:s');
    if (isset($payload['rating'])) {
        $existing['rating'] = floatval($payload['rating']);
    }

    file_put_contents($cacheFile, json_encode($existing, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES));

    echo json_encode([
        'status' => 'success',
        'message' => 'Reviews updated successfully!',
        'count' => count($payload['reviews'])
    ]);
    exit;
}

echo json_encode(['status' => 'error', 'message' => 'Unknown action']);

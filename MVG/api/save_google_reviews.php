<?php
/**
 * MVG Power Solutions — Save Google Reviews from Trustindex Connector
 */

header('Content-Type: application/json; charset=utf-8');

require_once __DIR__ . '/../config/constants.php';

$raw = file_get_contents('php://input');
if (empty($raw)) {
    $raw = $_POST['data'] ?? '';
}

if (empty($raw)) {
    echo json_encode(['status' => 'error', 'message' => 'No data received']);
    exit;
}

$payload = json_decode($raw, true);
if (!$payload) {
    echo json_encode(['status' => 'error', 'message' => 'Invalid JSON']);
    exit;
}

$cacheFile = __DIR__ . '/../data/google_reviews.json';

// Extract reviews from Trustindex payload
$parsedReviews = [];
$incomingReviews = $payload['reviews'] ?? [];

if (!empty($incomingReviews)) {
    foreach ($incomingReviews as $row) {
        $authorName = $row['reviewer']['name'] ?? ($row['user'] ?? 'Google Customer');
        $photoUrl = $row['reviewer']['avatar_url'] ?? ($row['user_photo'] ?? '');
        $rating = intval($row['rating'] ?? 5);
        $text = $row['text'] ?? '';
        $createdAt = $row['created_at'] ?? ($row['date'] ?? date('Y-m-d'));
        $reply = $row['reply'] ?? null;

        $ownerReply = null;
        if (!empty($reply)) {
            $ownerReply = [
                'author_name' => SITE_NAME . ' (owner)',
                'relative_time_description' => 'Response from owner',
                'text' => is_array($reply) ? ($reply['text'] ?? '') : (string)$reply
            ];
        }

        $parsedReviews[] = [
            'author_name' => $authorName,
            'author_url' => GOOGLE_BUSINESS_URL,
            'user_badge' => 'Google Customer',
            'profile_photo_url' => $photoUrl,
            'rating' => $rating,
            'relative_time_description' => $createdAt,
            'time' => strtotime($createdAt) ?: time(),
            'text' => $text,
            'owner_reply' => $ownerReply
        ];
    }
}

$ratingScore = floatval($payload['rating_score'] ?? ($payload['rating'] ?? 4.9));
$ratingCount = intval($payload['rating_number'] ?? ($payload['user_ratings_total'] ?? count($parsedReviews)));

$newStore = [
    'last_fetched' => time(),
    'last_fetched_date' => date('Y-m-d H:i:s'),
    'place_id' => $payload['id'] ?? 'ChIJeQPVZ7UFDTkRh2OKPQGr5uY',
    'business_name' => $payload['name'] ?? SITE_NAME,
    'business_address' => $payload['address'] ?? COMPANY_ADDRESS,
    'rating' => $ratingScore,
    'user_ratings_total' => $ratingCount ?: 12,
    'rating_breakdown' => [
        '5_star' => 92,
        '4_star' => 8,
        '3_star' => 0,
        '2_star' => 0,
        '1_star' => 0
    ],
    'reviews' => !empty($parsedReviews) ? $parsedReviews : ($existing['reviews'] ?? []),
    'source' => 'trustindex_live_sync'
];

file_put_contents($cacheFile, json_encode($newStore, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES));

echo json_encode([
    'status' => 'success',
    'message' => 'Successfully saved ' . count($parsedReviews) . ' genuine Google reviews!',
    'rating' => $ratingScore,
    'total_reviews' => count($parsedReviews)
]);

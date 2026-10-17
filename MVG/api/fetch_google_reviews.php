<?php
/**
 * MVG Power Solutions — Google Reviews Auto-Fetch API & Cron Endpoint
 * Usage:
 *   1. Cron Job (Every 2 days):
 *      0 0 * * * curl -s "https://yourdomain.com/api/fetch_google_reviews.php?secret=mvg2026" > /dev/null
 *   2. Direct Browser Refresh:
 *      https://yourdomain.com/api/fetch_google_reviews.php?force=1
 */

header('Content-Type: application/json; charset=utf-8');

require_once __DIR__ . '/../config/constants.php';
require_once __DIR__ . '/../includes/google_reviews.php';

$force = isset($_GET['force']) && $_GET['force'] == '1';
$data = GoogleReviewsService::getReviewsData($force);

echo json_encode([
    'status'             => 'success',
    'message'            => 'Google reviews synchronized successfully (Cache TTL: ' . GOOGLE_REVIEWS_CACHE_DAYS . ' days)',
    'cache_status'       => $data['cache_status'] ?? 'unknown',
    'last_fetched_date'  => $data['last_fetched_date'] ?? date('Y-m-d H:i:s'),
    'rating'             => $data['rating'] ?? 5.0,
    'total_reviews'      => count($data['reviews'] ?? []),
    'google_profile_url' => GOOGLE_BUSINESS_URL
], JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES);

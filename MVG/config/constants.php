<?php
/**
 * MVG Power Solutions — Global System Constants & Site Configuration
 */

if (!defined('SITE_NAME')) {
    define('SITE_NAME', 'MVG Power Solutions');
    define('SITE_TAGLINE', 'Power You Trust');
    define('CONTACT_PHONE', '+91 78360 04040');
    define('CONTACT_PHONE_TEL', '+917836004040');
    define('CONTACT_EMAIL', 'info@mvgpowersolutions.com');
    define('WHATSAPP_NUMBER', '917836004040');
    define('COMPANY_ADDRESS', 'R-458, Ground Floor, R Block, Mangol Puri, New Delhi – 110083, India');
    define('CURRENCY_SYMBOL', '₹');
    define('DEFAULT_MIN_QTY', 10);
    define('GST_RATE', 0.18);
    define('GOOGLE_BUSINESS_URL', 'https://share.google/TMbb3NtBqtNhvrcuP');
    define('GOOGLE_REVIEW_URL', 'https://g.page/r/CYdjij0Bq-bmEAE/review');

    // Google Reviews API & Auto-fetch Configuration
    define('GOOGLE_PLACES_API_KEY', 'AIzaSyB3wYQT4Yh3WlkybHcQkhGILb6cjAr4yeU'); // Google Cloud Places API key
    define('GOOGLE_PLACE_ID', '');      // Google Place ID (optional)
    define('GOOGLE_REVIEWS_CACHE_DAYS', 2); // Auto-fetch & refresh cache every 2 days
}


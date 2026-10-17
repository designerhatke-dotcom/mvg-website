<?php
/**
 * MVG Power Solutions — Dynamic Front Controller & Clean URL Router
 *
 * Handles:
 *  - Main Category Hub:   /mvg/current-transformers/ (or /mvg/collections/)
 *  - Subcategory/Category: /mvg/ring-current-transformers/ or /mvg/encapsulated-ring-ct/
 *  - Product Page:        /mvg/200-5a-32mm-current-transformer/ or /mvg/[product-slug]/
 *  - 301 Redirects:       Checks redirect manager before fallback
 */

require_once __DIR__ . '/config/constants.php';
require_once __DIR__ . '/config/db.php';
require_once __DIR__ . '/config/settings.php';

// Extract requested slug from query param or REQUEST_URI
$slug = trim($_GET['slug'] ?? '');

if (empty($slug)) {
    // Parse from REQUEST_URI if slug is empty
    $uri = parse_url($_SERVER['REQUEST_URI'] ?? '', PHP_URL_PATH);
    $uri = trim($uri, '/');
    // Remove 'mvg' prefix if present
    if (strpos($uri, 'mvg/') === 0) {
        $uri = substr($uri, 4);
    } elseif ($uri === 'mvg') {
        $uri = '';
    }
    $segments = explode('/', trim($uri, '/'));
    $slug = end($segments);
}

$slug = strtolower(trim($slug, '/'));

// If no slug requested, route to Home
if (empty($slug) || $slug === 'index' || $slug === 'index.php') {
    include __DIR__ . '/index.php';
    exit;
}

// 1. Check Permanent 301 Redirect Manager
$redirectsFile = __DIR__ . '/data/redirects.json';
if (file_exists($redirectsFile)) {
    $redirects = json_decode(file_get_contents($redirectsFile), true) ?: [];
    foreach ($redirects as $r) {
        $from = strtolower(trim($r['source_url'] ?? '', '/'));
        if ($from === $slug || $from === ('mvg/' . $slug)) {
            $target = $r['target_url'] ?? 'collections.php';
            header("HTTP/1.1 301 Moved Permanently");
            header("Location: " . $target);
            exit;
        }
    }
}

// 2. Main Category Hub Aliases: /current-transformers/ or /collections/
$hubAliases = ['current-transformers', 'collections', 'products', 'current-transformer-collection'];
if (in_array($slug, $hubAliases)) {
    include __DIR__ . '/collections.php';
    exit;
}

// 2b. Static B2B E-Commerce & Information Pages
$staticPages = [
    'about'            => 'about.php',
    'about-us'         => 'about.php',
    'contact'          => 'contact.php',
    'contact-us'       => 'contact.php',
    'custom-ct'        => 'custom-ct.php',
    'custom-rfq'       => 'custom-ct.php',
    'engineering'      => 'custom-ct.php',
    'datasheets'       => 'datasheets.php',
    'downloads'        => 'datasheets.php',
    'faq'              => 'faq.php',
    'faqs'             => 'faq.php',
    'inquiry-cart'     => 'inquiry-cart.php',
    'rfq-cart'         => 'inquiry-cart.php',
    'rfq'              => 'inquiry-cart.php',
    'cart'             => 'inquiry-cart.php',
    'inquiry-success'  => 'inquiry-success.php',
    'thank-you'        => 'inquiry-success.php',
    'track'            => 'track-inquiry.php',
    'track-inquiry'    => 'track-inquiry.php',
    'search'           => 'search.php',
    'privacy-policy'   => 'privacy-policy.php',
    'privacy'          => 'privacy-policy.php',
    'terms-conditions' => 'terms-conditions.php',
    'terms'            => 'terms-conditions.php',
];

if (isset($staticPages[$slug])) {
    include __DIR__ . '/' . $staticPages[$slug];
    exit;
}

// 3. Check Categories & Subcategories
// Fetch categories
$allCategories = Database::getCategories();
foreach ($allCategories as $cat) {
    $catSlug = strtolower(trim($cat['slug']));
    // Check direct slug match or alias match (e.g. ring-current-transformers matches encapsulated-ring-ct)
    if ($catSlug === $slug || 
        str_replace('encapsulated-', '', $catSlug) === $slug ||
        $catSlug === str_replace('-current-transformers', '-ct', $slug) ||
        $catSlug === str_replace('-current-transformers', '', $slug) . '-ct' ||
        $slug === 'ring-current-transformers' && strpos($catSlug, 'ring') !== false) {
        $_GET['slug'] = $cat['slug'];
        $_GET['category'] = $cat['slug'];
        include __DIR__ . '/category.php';
        exit;
    }
}

// 4. Check Products by Slug
$pdo = Database::getConnection();
$matchedProduct = null;

if ($pdo) {
    try {
        $stmt = $pdo->prepare("SELECT id, slug FROM products WHERE slug = ? OR sku = ? LIMIT 1");
        $stmt->execute([$slug, $slug]);
        $matchedProduct = $stmt->fetch();
    } catch (Exception $e) {}
}

if (!$matchedProduct) {
    // Check in products.json
    $jsonPath = __DIR__ . '/data/products.json';
    if (file_exists($jsonPath)) {
        $products = json_decode(file_get_contents($jsonPath), true) ?: [];
        foreach ($products as $p) {
            $pSlug = strtolower(trim($p['slug'] ?? ''));
            $pSku = strtolower(trim($p['sku'] ?? ''));
            
            if ($pSlug === $slug || $pSku === $slug) {
                $matchedProduct = $p;
                break;
            }

            // Approximate slug matching for product names like 200/5A 32mm -> 200-5a-32mm-current-transformer
            $genSlug = strtolower(trim(preg_replace('/[^A-Za-z0-9-]+/', '-', $p['name'] ?? ''), '-'));
            if ($genSlug === $slug || strpos($genSlug, $slug) !== false || strpos($slug, $genSlug) !== false) {
                $matchedProduct = $p;
                break;
            }
        }
    }
}

if ($matchedProduct) {
    $_GET['id'] = $matchedProduct['id'];
    $_GET['slug'] = $matchedProduct['slug'] ?? $slug;
    include __DIR__ . '/product.php';
    exit;
}

// 5. Fallback: If not found, show collections or 404
http_response_code(404);
$pageTitle = "Page Not Found | " . SITE_NAME;
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>404 — Page Not Found | <?php echo SITE_NAME; ?></title>
  <link rel="stylesheet" href="css/style.css">
</head>
<body>
  <header class="mvg-site-header"><?php include __DIR__ . '/includes/header.php'; ?></header>
  <div style="padding: 100px 20px; text-align: center; max-width: 600px; margin: 0 auto;">
    <h1 style="font-size: 48px; color: #0F172A; margin-bottom: 12px;">404</h1>
    <h2 style="font-size: 20px; color: #334155; margin-bottom: 16px;">We couldn't find the page or product you were looking for.</h2>
    <p style="color: #64748B; margin-bottom: 24px;">The current transformer model or category may have been moved or updated.</p>
    <a href="collections.php" class="btn btn-primary" style="padding: 12px 24px; border-radius: 8px;">Explore Our Current Transformer Collection &rarr;</a>
  </div>
  <?php include __DIR__ . '/includes/footer.php'; ?>
</body>
</html>

<?php
/**
 * MVG Power Solutions — 1-Click Database Setup & Seeder
 * Creates tables and populates MySQL from data/products.json & data/google_reviews.json
 */

require_once __DIR__ . '/../config/constants.php';

header('Content-Type: text/html; charset=utf-8');

$host = '127.0.0.1';
$user = 'root';
$pass = ''; // Adjust if MySQL has a password
$dbname = 'mvg_db';

?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Database Setup &amp; Migration — <?php echo SITE_NAME; ?></title>
  <style>
    body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif; background: #0F172A; color: #F8FAFC; padding: 40px 20px; line-height: 1.6; }
    .container { max-width: 800px; margin: 0 auto; background: #1E293B; border-radius: 12px; padding: 32px; box-shadow: 0 10px 30px rgba(0,0,0,0.5); }
    h1 { margin-top: 0; color: #38BDF8; font-size: 24px; }
    .log-item { padding: 10px 14px; margin-bottom: 8px; border-radius: 6px; font-size: 13.5px; font-family: monospace; }
    .log-success { background: #064E3B; color: #6EE7B7; border-left: 4px solid #10B981; }
    .log-info { background: #1E3A8A; color: #93C5FD; border-left: 4px solid #3B82F6; }
    .log-error { background: #7F1D1D; color: #FCA5A5; border-left: 4px solid #EF4444; }
    .btn { display: inline-block; background: #38BDF8; color: #0F172A; font-weight: 700; padding: 12px 24px; border-radius: 8px; text-decoration: none; margin-top: 20px; }
  </style>
</head>
<body>
<div class="container">
  <h1>MVG Database Migration &amp; Setup</h1>
<?php

try {
    // 1. Connect without db to create database if not exists
    $pdo = new PDO("mysql:host={$host};charset=utf8mb4", $user, $pass, [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION
    ]);
    $pdo->exec("CREATE DATABASE IF NOT EXISTS `{$dbname}` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci");
    echo "<div class='log-item log-success'>✓ Database `{$dbname}` created/verified successfully.</div>";

    // 2. Select database
    $pdo->exec("USE `{$dbname}`");

    // 3. Run schema.sql
    $schemaFile = __DIR__ . '/schema.sql';
    if (!file_exists($schemaFile)) {
        throw new Exception("schema.sql not found at " . $schemaFile);
    }
    $sql = file_get_contents($schemaFile);
    $pdo->exec($sql);
    echo "<div class='log-item log-success'>✓ Table structures (admins, categories, products, images, specs, inquiries, reviews, settings) created.</div>";

    // 4. Seed Products from products.json
    $jsonPath = __DIR__ . '/../data/products.json';
    if (file_exists($jsonPath)) {
        $products = json_decode(file_get_contents($jsonPath), true);
        $importedCount = 0;

        $stmtProd = $pdo->prepare("
            INSERT INTO products (id, category_id, name, slug, sku, price, min_qty, short_description, description, featured_image, status)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'published')
            ON DUPLICATE KEY UPDATE 
                name = VALUES(name),
                price = VALUES(price),
                short_description = VALUES(short_description),
                featured_image = VALUES(featured_image)
        ");

        $stmtImg = $pdo->prepare("
            INSERT INTO product_images (product_id, image_url, alt_text, sort_order)
            VALUES (?, ?, ?, ?)
        ");

        $stmtSpec = $pdo->prepare("
            INSERT INTO product_specs (product_id, spec_key, spec_val, sort_order)
            VALUES (?, ?, ?, ?)
        ");

        foreach ($products as $p) {
            $cats = $p['categories'] ?? [];
            $catSlugs = array_column($cats, 'slug');
            $isSquare = in_array('encapsulated-square-ct', $catSlugs) || in_array('square-ct', $catSlugs);
            $catId = $isSquare ? 2 : 1;

            $images = $p['images'] ?? [];
            $featuredImg = !empty($images[0]['src']) ? $images[0]['src'] : 'assets/categories/encapsulated-ring-ct.jpg';
            $price = floatval($p['prices']['price'] ?? 28000) / 100;
            $slug = !empty($p['slug']) ? $p['slug'] : 'product-' . $p['id'];
            $sku = !empty($p['sku']) ? $p['sku'] : 'MVG-CT-' . $p['id'];

            $stmtProd->execute([
                $p['id'],
                $catId,
                $p['name'],
                $slug,
                $sku,
                $price,
                DEFAULT_MIN_QTY,
                $p['short_description'] ?? '',
                $p['description'] ?? '',
                $featuredImg
            ]);

            // Clear old images & specs for clean re-seed
            $pdo->prepare("DELETE FROM product_images WHERE product_id = ?")->execute([$p['id']]);
            $pdo->prepare("DELETE FROM product_specs WHERE product_id = ?")->execute([$p['id']]);

            // Insert gallery images
            foreach ($images as $idx => $img) {
                if (!empty($img['src'])) {
                    $stmtImg->execute([$p['id'], $img['src'], $img['alt'] ?? $p['name'], $idx]);
                }
            }

            // Parse specs
            if (!empty($p['short_description'])) {
                preg_match_all('/<li><strong>(.*?):<\/strong>\s*(.*?)<\/li>/i', $p['short_description'], $matches, PREG_SET_ORDER);
                $sort = 0;
                foreach ($matches as $m) {
                    $k = trim(strip_tags($m[1]));
                    $v = trim(strip_tags($m[2]));
                    if ($k && $v) {
                        $stmtSpec->execute([$p['id'], $k, $v, $sort++]);
                    }
                }
            }

            $importedCount++;
        }
        echo "<div class='log-item log-success'>✓ Successfully imported {$importedCount} industrial products into MySQL!</div>";
    }

    // 5. Seed Reviews from google_reviews.json
    $revPath = __DIR__ . '/../data/google_reviews.json';
    if (file_exists($revPath)) {
        $revData = json_decode(file_get_contents($revPath), true);
        $revs = $revData['reviews'] ?? [];
        $stmtRev = $pdo->prepare("
            INSERT INTO reviews (author_name, user_badge, rating, review_text, owner_reply, review_date)
            VALUES (?, ?, ?, ?, ?, ?)
        ");
        $pdo->exec("TRUNCATE TABLE reviews");
        foreach ($revs as $r) {
            $stmtRev->execute([
                $r['author_name'],
                $r['user_badge'] ?? 'Google Customer',
                $r['rating'] ?? 5,
                $r['text'] ?? '',
                $r['owner_reply']['text'] ?? null,
                $r['relative_time_description'] ?? 'Recently'
            ]);
        }
        echo "<div class='log-item log-success'>✓ Successfully imported " . count($revs) . " reviews into MySQL!</div>";
    }

    echo "<div class='log-item log-info'>🎉 Database setup completed! All data is now live in MySQL (mvg_db).</div>";
    echo "<a href='../admin/index.php' class='btn'>Launch Admin Panel &rarr;</a>";

} catch (Exception $e) {
    echo "<div class='log-item log-error'><strong>Error during setup:</strong> " . htmlspecialchars($e->getMessage()) . "</div>";
    echo "<p style='color:#94A3B8; font-size: 13.5px;'>Make sure MySQL is started in your local server (XAMPP / MAMP / MariaDB) on <code>127.0.0.1:3306</code> with user <code>root</code>.</p>";
}
?>
</div>
</body>
</html>

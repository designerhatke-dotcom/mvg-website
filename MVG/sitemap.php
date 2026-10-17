<?php
/**
 * MVG Power Solutions — Dynamic XML Sitemap Generator
 * Outputs standard Google XML sitemap protocol with all categories and products.
 */

header('Content-Type: application/xml; charset=utf-8');

require_once __DIR__ . '/config/constants.php';
require_once __DIR__ . '/config/db.php';
require_once __DIR__ . '/config/settings.php';

$baseUrl = rtrim(Settings::get('general.site_url', SITE_URL), '/') . '/';
$categories = Database::getCategories();
$products = Database::getProducts();

echo '<?xml version="1.0" encoding="UTF-8"?>' . "\n";
?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"
        xmlns:image="http://www.google.com/schemas/sitemap-image/1.1">

  <!-- Core Pages -->
  <url>
    <loc><?php echo $baseUrl; ?></loc>
    <lastmod><?php echo date('Y-m-d'); ?></lastmod>
    <changefreq>daily</changefreq>
    <priority>1.0</priority>
  </url>

  <url>
    <loc><?php echo $baseUrl; ?>current-transformers/</loc>
    <lastmod><?php echo date('Y-m-d'); ?></lastmod>
    <changefreq>daily</changefreq>
    <priority>0.9</priority>
  </url>

  <!-- Categories -->
  <?php foreach ($categories as $cat): ?>
    <url>
      <loc><?php echo $baseUrl . htmlspecialchars($cat['slug']); ?>/</loc>
      <lastmod><?php echo date('Y-m-d'); ?></lastmod>
      <changefreq>weekly</changefreq>
      <priority>0.8</priority>
    </url>
  <?php endforeach; ?>

  <!-- Products with Image Sitemaps -->
  <?php foreach ($products as $p): ?>
    <?php 
      $pSlug = $p['slug'] ?? ('product-' . $p['id']);
      $img = $p['image'] ?? 'assets/categories/encapsulated-ring-ct.jpg';
      $imgUrl = (strpos($img, 'http') === 0) ? $img : ($baseUrl . ltrim($img, '/'));
    ?>
    <url>
      <loc><?php echo $baseUrl . htmlspecialchars($pSlug); ?>/</loc>
      <lastmod><?php echo date('Y-m-d'); ?></lastmod>
      <changefreq>weekly</changefreq>
      <priority>0.7</priority>
      <image:image>
        <image:loc><?php echo htmlspecialchars($imgUrl); ?></image:loc>
        <image:title><?php echo htmlspecialchars($p['name']); ?></image:title>
        <image:caption><?php echo htmlspecialchars($p['name'] . ' Class 1.0 Current Transformer'); ?></image:caption>
      </image:image>
    </url>
  <?php endforeach; ?>

</urlset>

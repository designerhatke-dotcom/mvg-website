<?php
/**
 * MVG Power Solutions — Product SEO Manager & Bulk Slug / Meta Title Editor
 */

require_once __DIR__ . '/../config/constants.php';
require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../config/settings.php';

$adminTitle = 'Product SEO';
$adminHeading = 'Product Catalog SEO & Clean Slugs Manager';

$jsonPath = __DIR__ . '/../data/products.json';
$products = file_exists($jsonPath) ? (json_decode(file_get_contents($jsonPath), true) ?: []) : [];

$successMsg = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['save_product_seo'])) {
    $titles = $_POST['meta_titles'] ?? [];
    $descs = $_POST['meta_descriptions'] ?? [];
    $slugs = $_POST['slugs'] ?? [];

    foreach ($products as &$p) {
        $pId = $p['id'];
        if (isset($titles[$pId])) $p['meta_title'] = trim($titles[$pId]);
        if (isset($descs[$pId])) $p['meta_description'] = trim($descs[$pId]);
        if (isset($slugs[$pId]) && !empty(trim($slugs[$pId]))) {
            $p['slug'] = strtolower(trim(preg_replace('/[^A-Za-z0-9-]+/', '-', $slugs[$pId]), '-'));
        }
    }
    file_put_contents($jsonPath, json_encode($products, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES));
    $successMsg = '✓ Product SEO meta titles, descriptions, and clean URLs updated!';
}

include __DIR__ . '/header.php';
?>

<div style="max-width: 1200px; margin: 0 auto;">

  <?php if (!empty($successMsg)): ?>
    <div style="background: #F0FDF4; border-left: 4px solid var(--green); color: #166534; padding: 12px 18px; font-size: 13.5px; border-radius: 8px; margin-bottom: 20px;">
      <?php echo $successMsg; ?>
    </div>
  <?php endif; ?>

  <div class="card">
    <div class="card-header">
      <div>
        <h2 class="card-title">Product Catalog SEO (<?php echo count($products); ?> Products)</h2>
        <span style="font-size: 12px; color: var(--text-muted);">Manage clean URL slugs (example.com/mvg/product-slug/), meta titles, and descriptions</span>
      </div>
    </div>

    <form method="POST" action="">
      <input type="hidden" name="save_product_seo" value="1">

      <table class="data-table">
        <thead>
          <tr>
            <th style="width: 220px;">Product Name &amp; SKU</th>
            <th style="width: 240px;">Clean URL Slug</th>
            <th>SEO Meta Title</th>
            <th style="width: 100px; text-align: right;">Action</th>
          </tr>
        </thead>
        <tbody>
          <?php foreach ($products as $p): ?>
            <?php 
              $pId = $p['id'];
              $slug = $p['slug'] ?? strtolower(trim(preg_replace('/[^A-Za-z0-9-]+/', '-', $p['name']), '-'));
              $title = $p['meta_title'] ?? ($p['name'] . ' | ' . SITE_NAME);
            ?>
            <tr>
              <td>
                <strong style="font-size: 13px; color: var(--navy);"><?php echo htmlspecialchars($p['name']); ?></strong>
                <span style="display: block; font-size: 11px; color: var(--text-muted);"><?php echo htmlspecialchars($p['sku'] ?? ''); ?></span>
              </td>
              <td>
                <input type="text" name="slugs[<?php echo $pId; ?>]" class="form-control" value="<?php echo htmlspecialchars($slug); ?>">
              </td>
              <td>
                <input type="text" name="meta_titles[<?php echo $pId; ?>]" class="form-control" value="<?php echo htmlspecialchars($title); ?>">
              </td>
              <td style="text-align: right;">
                <a href="../<?php echo htmlspecialchars($slug); ?>/" target="_blank" class="btn-topbar" style="padding: 4px 8px; font-size: 11px;" title="Test clean URL">
                  View ↗
                </a>
              </td>
            </tr>
          <?php endforeach; ?>
        </tbody>
      </table>

      <div style="padding: 16px; display: flex; justify-content: flex-end; border-top: 1px solid var(--border);">
        <button type="submit" class="btn-topbar btn-topbar-primary" style="padding: 11px 28px; font-weight: 700;">
          💾 Save Product SEO &amp; Slugs
        </button>
      </div>
    </form>
  </div>

</div>

<?php include __DIR__ . '/footer.php'; ?>

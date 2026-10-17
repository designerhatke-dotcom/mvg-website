<?php
/**
 * MVG Power Solutions — Product Galleries Manager
 */

require_once __DIR__ . '/../config/constants.php';
require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../config/settings.php';

$adminTitle = 'Product Galleries';
$adminHeading = 'Multi-Angle Product Photo Galleries';

$products = Database::getProducts();

include __DIR__ . '/header.php';
?>

<div style="max-width: 1100px; margin: 0 auto;">

  <div class="card">
    <div class="card-header">
      <div>
        <h2 class="card-title">Product Image Galleries (<?php echo count($products); ?> Products)</h2>
        <span style="font-size: 12px; color: var(--text-muted);">Manage multi-angle photos, engineering dimensional views, and gallery thumbnails</span>
      </div>
    </div>

    <table class="data-table">
      <thead>
        <tr>
          <th>Product</th>
          <th>SKU</th>
          <th>Gallery Count</th>
          <th>Photos Preview</th>
          <th style="text-align: right;">Action</th>
        </tr>
      </thead>
      <tbody>
        <?php foreach ($products as $p): ?>
          <?php 
            $images = $p['images'] ?? [];
            if (empty($images) && !empty($p['image'])) {
                $images = [['src' => $p['image']]];
            }
          ?>
          <tr>
            <td><strong><?php echo htmlspecialchars($p['name']); ?></strong></td>
            <td><code><?php echo htmlspecialchars($p['sku'] ?? '—'); ?></code></td>
            <td>
              <span class="badge badge-info"><?php echo count($images); ?> Image(s)</span>
            </td>
            <td>
              <div style="display: flex; gap: 6px; flex-wrap: wrap;">
                <?php foreach (array_slice($images, 0, 5) as $img): ?>
                  <?php $src = is_array($img) ? ($img['src'] ?? '') : (string)$img; ?>
                  <img src="../<?php echo htmlspecialchars($src); ?>" style="width: 38px; height: 38px; border-radius: 4px; object-fit: contain; border: 1px solid var(--border);" onerror="this.src='../assets/categories/encapsulated-ring-ct.jpg'">
                <?php endforeach; ?>
                <?php if (count($images) > 5): ?>
                  <span style="font-size: 11px; color: var(--text-muted); align-self: center;">+<?php echo count($images) - 5; ?> more</span>
                <?php endif; ?>
              </div>
            </td>
            <td style="text-align: right;">
              <a href="product_form.php?id=<?php echo $p['id']; ?>" class="btn-topbar" style="padding: 5px 12px; font-size: 12px;">
                Edit Gallery &rarr;
              </a>
            </td>
          </tr>
        <?php endforeach; ?>
      </tbody>
    </table>
  </div>

</div>

<?php include __DIR__ . '/footer.php'; ?>

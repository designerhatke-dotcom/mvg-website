<?php
/**
 * MVG Power Solutions — Image SEO Manager & Audit Tool
 * Audits product images for missing alt text, unoptimized names, and provides bulk SEO metadata editing.
 */

require_once __DIR__ . '/../config/constants.php';
require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../config/settings.php';

$adminTitle = 'Image SEO Manager';
$adminHeading = 'Image SEO Manager & Search Audit';

$jsonPath = __DIR__ . '/../data/products.json';
$products = file_exists($jsonPath) ? (json_decode(file_get_contents($jsonPath), true) ?: []) : [];

$successMsg = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['save_image_seo'])) {
    $altTexts = $_POST['alts'] ?? [];
    $titles = $_POST['titles'] ?? [];

    foreach ($products as &$p) {
        $pId = $p['id'];
        if (isset($altTexts[$pId])) {
            $p['image_meta']['alt'] = trim($altTexts[$pId]);
            if (!empty($p['images']) && is_array($p['images'])) {
                $p['images'][0]['alt'] = trim($altTexts[$pId]);
            }
        }
        if (isset($titles[$pId])) {
            $p['image_meta']['title'] = trim($titles[$pId]);
            if (!empty($p['images']) && is_array($p['images'])) {
                $p['images'][0]['name'] = trim($titles[$pId]);
            }
        }
    }
    file_put_contents($jsonPath, json_encode($products, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES));
    $successMsg = '✓ Image SEO metadata and Alt text saved successfully across catalog!';
}

// Audit statistics
$missingAltCount = 0;
$totalImages = count($products);

foreach ($products as $p) {
    $alt = $p['image_meta']['alt'] ?? ($p['images'][0]['alt'] ?? '');
    if (empty(trim($alt))) {
        $missingAltCount++;
    }
}

include __DIR__ . '/header.php';
?>

<div style="max-width: 1100px; margin: 0 auto;">

  <?php if (!empty($successMsg)): ?>
    <div style="background: #F0FDF4; border-left: 4px solid var(--green); color: #166534; padding: 12px 18px; font-size: 13.5px; border-radius: 8px; margin-bottom: 20px;">
      <?php echo $successMsg; ?>
    </div>
  <?php endif; ?>

  <!-- Image SEO Audit Scorecard -->
  <div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 18px; margin-bottom: 24px;">
    <div class="card" style="text-align: center; padding: 20px;">
      <span style="font-size: 12px; color: var(--text-muted); text-transform: uppercase; font-weight: 700;">Total Catalog Images</span>
      <h3 style="font-size: 32px; color: var(--navy); margin: 6px 0 0 0;"><?php echo $totalImages; ?></h3>
    </div>

    <div class="card" style="text-align: center; padding: 20px; border-left: 4px solid <?php echo ($missingAltCount === 0) ? 'var(--green)' : 'var(--red)'; ?>;">
      <span style="font-size: 12px; color: var(--text-muted); text-transform: uppercase; font-weight: 700;">Missing Alt Text</span>
      <h3 style="font-size: 32px; color: <?php echo ($missingAltCount === 0) ? 'var(--green)' : 'var(--red)'; ?>; margin: 6px 0 0 0;">
        <?php echo $missingAltCount; ?>
      </h3>
    </div>

    <div class="card" style="text-align: center; padding: 20px;">
      <span style="font-size: 12px; color: var(--text-muted); text-transform: uppercase; font-weight: 700;">Google Image Readiness</span>
      <h3 style="font-size: 32px; color: var(--primary); margin: 6px 0 0 0;">
        <?php echo $totalImages > 0 ? round((($totalImages - $missingAltCount) / $totalImages) * 100) : 100; ?>%
      </h3>
    </div>
  </div>

  <!-- Bulk Image SEO Table -->
  <div class="card">
    <div class="card-header">
      <div>
        <h2 class="card-title">Bulk Image SEO Metadata Editor</h2>
        <span style="font-size: 12px; color: var(--text-muted);">Ensure all current transformers have descriptive Alt Text for Google Images rankings</span>
      </div>
      <button type="button" class="btn-topbar" onclick="autoSuggestAll()">⚡ Auto-Suggest All Missing</button>
    </div>

    <form method="POST" action="">
      <input type="hidden" name="save_image_seo" value="1">

      <table class="data-table">
        <thead>
          <tr>
            <th style="width: 70px;">Image</th>
            <th>Product Name</th>
            <th style="min-width: 280px;">Image Alt Text (Google SEO)</th>
            <th style="min-width: 240px;">Image Title (Tooltip)</th>
          </tr>
        </thead>
        <tbody>
          <?php foreach ($products as $p): ?>
            <?php 
              $pId = $p['id'];
              $imgSrc = $p['images'][0]['src'] ?? ($p['image'] ?? 'assets/categories/encapsulated-ring-ct.jpg');
              $alt = $p['image_meta']['alt'] ?? ($p['images'][0]['alt'] ?? $p['name']);
              $title = $p['image_meta']['title'] ?? ($p['images'][0]['name'] ?? $p['name']);
            ?>
            <tr>
              <td>
                <img src="../<?php echo htmlspecialchars($imgSrc); ?>" style="width: 50px; height: 50px; object-fit: contain; border-radius: 6px; border: 1px solid var(--border);" onerror="this.src='../assets/categories/encapsulated-ring-ct.jpg'">
              </td>
              <td>
                <strong style="font-size: 13px; color: var(--navy);"><?php echo htmlspecialchars($p['name']); ?></strong>
                <span style="display: block; font-size: 11px; color: var(--text-muted);"><?php echo htmlspecialchars($p['sku'] ?? ''); ?></span>
              </td>
              <td>
                <input type="text" class="form-control alt-input" name="alts[<?php echo $pId; ?>]" value="<?php echo htmlspecialchars($alt); ?>" data-name="<?php echo htmlspecialchars($p['name']); ?>" placeholder="Descriptive image alt text for SEO">
              </td>
              <td>
                <input type="text" class="form-control" name="titles[<?php echo $pId; ?>]" value="<?php echo htmlspecialchars($title); ?>" placeholder="Title shown on hover">
              </td>
            </tr>
          <?php endforeach; ?>
        </tbody>
      </table>

      <div style="padding: 16px; display: flex; justify-content: flex-end; border-top: 1px solid var(--border);">
        <button type="submit" class="btn-topbar btn-topbar-primary" style="padding: 11px 28px; font-weight: 700;">
          💾 Save All Image SEO Metas
        </button>
      </div>
    </form>
  </div>

</div>

<script>
function autoSuggestAll() {
  document.querySelectorAll('.alt-input').forEach(inp => {
    if (!inp.value.trim()) {
      inp.value = inp.getAttribute('data-name') + ' - MVG Power Solutions';
      inp.style.background = '#EFF6FF';
    }
  });
}
</script>

<?php include __DIR__ . '/footer.php'; ?>

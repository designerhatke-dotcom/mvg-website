<?php
/**
 * MVG Power Solutions — Category SEO Manager
 */

require_once __DIR__ . '/../config/constants.php';
require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../config/settings.php';

$adminTitle = 'Category SEO';
$adminHeading = 'Category & Subcategory SEO Metadata';

$catsFile = __DIR__ . '/../data/categories.json';
$allCategories = file_exists($catsFile) ? (json_decode(file_get_contents($catsFile), true) ?: []) : [];

$successMsg = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['save_cat_seo'])) {
    $descs = $_POST['descriptions'] ?? [];
    $slugs = $_POST['slugs'] ?? [];

    foreach ($allCategories as &$c) {
        $cId = $c['id'];
        if (isset($descs[$cId])) $c['description'] = trim($descs[$cId]);
        if (isset($slugs[$cId]) && !empty(trim($slugs[$cId]))) {
            $c['slug'] = strtolower(trim(preg_replace('/[^A-Za-z0-9-]+/', '-', $slugs[$cId]), '-'));
        }
    }
    file_put_contents($catsFile, json_encode($allCategories, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES));
    $successMsg = '✓ Category SEO descriptions and URL slugs updated!';
}

include __DIR__ . '/header.php';
?>

<div style="max-width: 1100px; margin: 0 auto;">

  <?php if (!empty($successMsg)): ?>
    <div style="background: #F0FDF4; border-left: 4px solid var(--green); color: #166534; padding: 12px 18px; font-size: 13.5px; border-radius: 8px; margin-bottom: 20px;">
      <?php echo $successMsg; ?>
    </div>
  <?php endif; ?>

  <div class="card">
    <div class="card-header">
      <div>
        <h2 class="card-title">Category SEO Slugs &amp; Search Snippets</h2>
        <span style="font-size: 12px; color: var(--text-muted);">Manage clean URLs like <code>example.com/mvg/current-transformers/</code> and <code>example.com/mvg/ring-current-transformers/</code></span>
      </div>
    </div>

    <form method="POST" action="">
      <input type="hidden" name="save_cat_seo" value="1">

      <table class="data-table">
        <thead>
          <tr>
            <th style="width: 220px;">Category Name</th>
            <th style="width: 260px;">Clean URL Slug</th>
            <th>SEO Meta Description</th>
            <th style="width: 90px; text-align: right;">Action</th>
          </tr>
        </thead>
        <tbody>
          <?php foreach ($allCategories as $c): ?>
            <?php 
              $cId = $c['id'];
              $isSub = intval($c['parent'] ?? 0) > 0;
            ?>
            <tr>
              <td>
                <span style="font-weight: 700; color: var(--navy); <?php echo $isSub ? 'padding-left: 14px; font-size: 12.5px;' : ''; ?>">
                  <?php echo $isSub ? '↳ ' : '📁 '; ?><?php echo htmlspecialchars($c['name']); ?>
                </span>
              </td>
              <td>
                <input type="text" name="slugs[<?php echo $cId; ?>]" class="form-control" value="<?php echo htmlspecialchars($c['slug']); ?>">
              </td>
              <td>
                <textarea name="descriptions[<?php echo $cId; ?>]" class="form-control" rows="2"><?php echo htmlspecialchars($c['description'] ?? ''); ?></textarea>
              </td>
              <td style="text-align: right;">
                <a href="../<?php echo htmlspecialchars($c['slug']); ?>/" target="_blank" class="btn-topbar" style="padding: 4px 8px; font-size: 11px;">
                  Test ↗
                </a>
              </td>
            </tr>
          <?php endforeach; ?>
        </tbody>
      </table>

      <div style="padding: 16px; display: flex; justify-content: flex-end; border-top: 1px solid var(--border);">
        <button type="submit" class="btn-topbar btn-topbar-primary" style="padding: 11px 28px; font-weight: 700;">
          💾 Save Category SEO &amp; Slugs
        </button>
      </div>
    </form>
  </div>

</div>

<?php include __DIR__ . '/footer.php'; ?>

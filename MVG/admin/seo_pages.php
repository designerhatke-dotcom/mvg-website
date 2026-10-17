<?php
/**
 * MVG Power Solutions — Static Page SEO Metadata Manager
 */

require_once __DIR__ . '/../config/constants.php';
require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../config/settings.php';

$adminTitle = 'Page SEO';
$adminHeading = 'Static Pages Search Metadata';

$pagesFile = __DIR__ . '/../data/pages_seo.json';
$pagesSeo = file_exists($pagesFile) ? (json_decode(file_get_contents($pagesFile), true) ?: []) : [
    'home' => [
        'name'        => 'Home Page',
        'url'         => 'index.php',
        'title'       => 'MVG Power Solutions — Industrial Current Transformers & Meters',
        'description' => 'Direct factory manufacturer of IS 2705 certified Class 1.0 & 0.5 current transformers with same-day dispatch and 18% GST Input Tax Credit.'
    ],
    'collections' => [
        'name'        => 'Our Current Transformer Collection',
        'url'         => 'collections.php',
        'title'       => 'Our Current Transformer Collection | MVG Power Solutions',
        'description' => 'Explore certified Class 1.0 & Class 0.5 Current Transformers across Encapsulated Square, Ring, Tape Wound, Resin Cast, and Split Core geometries.'
    ]
];

$successMsg = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    foreach ($pagesSeo as $key => &$p) {
        if (isset($_POST[$key . '_title'])) {
            $p['title'] = trim($_POST[$key . '_title']);
            $p['description'] = trim($_POST[$key . '_desc']);
        }
    }
    file_put_contents($pagesFile, json_encode($pagesSeo, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES));
    $successMsg = '✓ Static page SEO titles and descriptions saved!';
}

include __DIR__ . '/header.php';
?>

<div style="max-width: 900px; margin: 0 auto;">

  <?php if (!empty($successMsg)): ?>
    <div style="background: #F0FDF4; border-left: 4px solid var(--green); color: #166534; padding: 12px 18px; font-size: 13.5px; border-radius: 8px; margin-bottom: 20px;">
      <?php echo $successMsg; ?>
    </div>
  <?php endif; ?>

  <div class="card">
    <div class="card-header">
      <h2 class="card-title">Website Core Pages SEO</h2>
    </div>

    <form method="POST" action="">
      <?php foreach ($pagesSeo as $key => $page): ?>
        <div style="padding: 18px 0; border-bottom: 1px solid var(--border);">
          <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px;">
            <strong style="font-size: 14px; color: var(--navy);"><?php echo htmlspecialchars($page['name']); ?></strong>
            <code><?php echo htmlspecialchars($page['url']); ?></code>
          </div>

          <div class="form-group">
            <label>SEO Meta Title</label>
            <input type="text" name="<?php echo $key; ?>_title" class="form-control" value="<?php echo htmlspecialchars($page['title'] ?? ''); ?>">
          </div>

          <div class="form-group">
            <label>SEO Meta Description</label>
            <textarea name="<?php echo $key; ?>_desc" class="form-control" rows="2"><?php echo htmlspecialchars($page['description'] ?? ''); ?></textarea>
          </div>
        </div>
      <?php endforeach; ?>

      <div style="margin-top: 20px; display: flex; justify-content: flex-end;">
        <button type="submit" class="btn-topbar btn-topbar-primary" style="padding: 10px 24px; font-weight: 700;">
          💾 Save Pages SEO
        </button>
      </div>
    </form>
  </div>

</div>

<?php include __DIR__ . '/footer.php'; ?>

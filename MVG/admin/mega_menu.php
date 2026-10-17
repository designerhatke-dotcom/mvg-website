<?php
/**
 * MVG Power Solutions — Mega Menu Builder
 * Multi-column mega menu configuration with featured cards, banners, and aperture columns.
 */

require_once __DIR__ . '/../config/constants.php';
require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../config/settings.php';

$adminTitle = 'Mega Menu Builder';
$adminHeading = 'Multi-Column Mega Menu Visual Configurator';

$megaFile = __DIR__ . '/../data/mega_menu.json';
$allCategories = Database::getCategories();
$parentCats = array_filter($allCategories, function($c) {
    return intval($c['parent'] ?? 0) === 0;
});

$megaConfig = file_exists($megaFile) ? (json_decode(file_get_contents($megaFile), true) ?: []) : [
    'encapsulated-square-ct' => [
        'enabled'        => true,
        'columns'        => 5,
        'featured_title' => 'Square Busbar CT Lineup',
        'featured_badge' => '16 PRODUCTS',
        'featured_image' => 'assets/categories/encapsulated-square-ct.jpg',
        'featured_link'  => 'category.php?slug=encapsulated-square-ct'
    ],
    'encapsulated-ring-ct' => [
        'enabled'        => true,
        'columns'        => 5,
        'featured_title' => 'Ring Metering CT Range',
        'featured_badge' => '24 PRODUCTS',
        'featured_image' => 'assets/categories/encapsulated-ring-ct.jpg',
        'featured_link'  => 'category.php?slug=encapsulated-ring-ct'
    ]
];

$selectedSlug = $_GET['cat'] ?? 'encapsulated-square-ct';
$currConfig = $megaConfig[$selectedSlug] ?? [
    'enabled'        => true,
    'columns'        => 4,
    'featured_title' => 'Featured Lineup',
    'featured_badge' => 'HOT SELLER',
    'featured_image' => 'assets/categories/encapsulated-ring-ct.jpg',
    'featured_link'  => 'category.php?slug=' . $selectedSlug
];

$successMsg = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $megaConfig[$selectedSlug] = [
        'enabled'        => isset($_POST['enabled']),
        'columns'        => intval($_POST['columns'] ?? 4),
        'featured_title' => trim($_POST['featured_title'] ?? ''),
        'featured_badge' => trim($_POST['featured_badge'] ?? ''),
        'featured_image' => trim($_POST['featured_image'] ?? ''),
        'featured_link'  => trim($_POST['featured_link'] ?? '')
    ];
    file_put_contents($megaFile, json_encode($megaConfig, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES));
    $currConfig = $megaConfig[$selectedSlug];
    $successMsg = '✓ Mega Menu layout and spotlight card updated for ' . htmlspecialchars($selectedSlug) . '!';
}

include __DIR__ . '/header.php';
?>

<div style="display: grid; grid-template-columns: 280px 1fr; gap: 24px; align-items: start;">

  <!-- Category Selector Sidebar -->
  <div class="card">
    <div class="card-header">
      <h2 class="card-title">Categories with Mega Menu</h2>
    </div>
    <div style="display: flex; flex-direction: column; gap: 6px;">
      <?php foreach ($parentCats as $p): ?>
        <?php $isSel = ($p['slug'] === $selectedSlug); ?>
        <a href="mega_menu.php?cat=<?php echo htmlspecialchars($p['slug']); ?>" 
           style="display: flex; align-items: center; justify-content: space-between; padding: 10px 14px; border-radius: 8px; text-decoration: none; font-size: 13.5px; font-weight: 600; <?php echo $isSel ? 'background: var(--primary); color: #fff;' : 'background: #F8FAFC; color: #334155; border: 1px solid var(--border);'; ?>">
          <span><?php echo htmlspecialchars($p['name']); ?></span>
          <span style="font-size: 11px; opacity: 0.8;"><?php echo !empty($megaConfig[$p['slug']]['enabled']) ? '● Active' : '○ Off'; ?></span>
        </a>
      <?php endforeach; ?>
    </div>
  </div>

  <!-- Mega Menu Editor & Live Preview -->
  <div class="card">
    <div class="card-header">
      <div>
        <h2 class="card-title">Configure Mega Menu: <?php echo htmlspecialchars($selectedSlug); ?></h2>
        <span style="font-size: 12px; color: var(--text-muted);">Adjust layout columns, featured spotlight thumbnail, and CTA banner</span>
      </div>
    </div>

    <?php if (!empty($successMsg)): ?>
      <div style="background: #F0FDF4; border-left: 4px solid var(--green); color: #166534; padding: 10px 14px; font-size: 13px; border-radius: 6px; margin-bottom: 16px;">
        <?php echo $successMsg; ?>
      </div>
    <?php endif; ?>

    <form method="POST" action="">
      <div style="margin-bottom: 18px; padding: 12px; background: #F8FAFC; border-radius: 8px; border: 1px solid var(--border);">
        <label style="display: flex; align-items: center; gap: 8px; font-size: 13.5px; cursor: pointer;">
          <input type="checkbox" name="enabled" value="1" <?php echo !empty($currConfig['enabled']) ? 'checked' : ''; ?>>
          <span><strong>Enable Rich Mega Dropdown Menu</strong> for this navigation category</span>
        </label>
      </div>

      <div class="form-grid">
        <div class="form-group">
          <label>Layout Columns (Desktop)</label>
          <select name="columns" class="form-control">
            <option value="3" <?php echo ($currConfig['columns'] == 3) ? 'selected' : ''; ?>>3 Columns</option>
            <option value="4" <?php echo ($currConfig['columns'] == 4) ? 'selected' : ''; ?>>4 Columns</option>
            <option value="5" <?php echo ($currConfig['columns'] == 5) ? 'selected' : ''; ?>>5 Columns (Recommended with Spotlight Card)</option>
          </select>
        </div>

        <div class="form-group">
          <label>Spotlight Badge (e.g. 16 PRODUCTS / TOP SELLER)</label>
          <input type="text" name="featured_badge" class="form-control" value="<?php echo htmlspecialchars($currConfig['featured_badge'] ?? ''); ?>">
        </div>

        <div class="form-group" style="grid-column: 1 / -1;">
          <label>Spotlight Product / Series Title</label>
          <input type="text" name="featured_title" class="form-control" value="<?php echo htmlspecialchars($currConfig['featured_title'] ?? ''); ?>">
        </div>

        <div class="form-group">
          <label>Spotlight Image URL</label>
          <input type="text" name="featured_image" class="form-control" value="<?php echo htmlspecialchars($currConfig['featured_image'] ?? ''); ?>">
        </div>

        <div class="form-group">
          <label>Spotlight CTA Destination Link</label>
          <input type="text" name="featured_link" class="form-control" value="<?php echo htmlspecialchars($currConfig['featured_link'] ?? ''); ?>">
        </div>
      </div>

      <button type="submit" class="btn-topbar btn-topbar-primary" style="margin-top: 14px; padding: 10px 24px;">
        💾 Save Mega Menu Settings
      </button>
    </form>
  </div>

</div>

<?php include __DIR__ . '/footer.php'; ?>

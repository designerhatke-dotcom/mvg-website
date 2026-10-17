<?php
/**
 * MVG Power Solutions — Categories Management
 */

require_once __DIR__ . '/../config/constants.php';
require_once __DIR__ . '/../config/db.php';

$adminTitle = 'Categories';
$adminHeading = 'Product Collections & Categories';

$pdo = Database::getConnection();

$categories = [
    [
        'id' => 1,
        'name' => 'Encapsulated Ring CT',
        'slug' => 'encapsulated-ring-ct',
        'description' => 'High-precision Class 1.0 & 0.5 round current transformers with fire-retardant casing for electrical panels.',
        'image' => 'assets/categories/encapsulated-ring-ct.jpg',
        'product_count' => 12
    ],
    [
        'id' => 2,
        'name' => 'Encapsulated Square CT',
        'slug' => 'encapsulated-square-ct',
        'description' => 'Square window current transformers optimized for standard busbars with transparent terminal shrouds.',
        'image' => 'assets/categories/encapsulated-square-ct.jpg',
        'product_count' => 8
    ],
    [
        'id' => 3,
        'name' => 'Tape Wound CT',
        'slug' => 'tape-wound-ct',
        'description' => 'High permeability tape wound CTs for standard industrial metering and control circuits.',
        'image' => 'assets/categories/tape-wound-ct.jpg',
        'product_count' => 0
    ],
    [
        'id' => 4,
        'name' => 'Custom Ratio CT',
        'slug' => 'custom-ratio-ct',
        'description' => 'Custom engineered CTs with bespoke primary ratings, dual ratios, and special burden VA.',
        'image' => 'assets/categories/custom-ratio-ct.jpg',
        'product_count' => 0
    ]
];

if ($pdo) {
    try {
        $stmt = $pdo->query("SELECT * FROM categories ORDER BY sort_order ASC");
        $dbCats = $stmt->fetchAll();
        if ($dbCats) {
            foreach ($dbCats as &$c) {
                $cntStmt = $pdo->prepare("SELECT COUNT(*) FROM products WHERE category_id = ?");
                $cntStmt->execute([$c['id']]);
                $c['product_count'] = $cntStmt->fetchColumn();
            }
            $categories = $dbCats;
        }
    } catch (Exception $e) {}
}

include __DIR__ . '/header.php';
?>

<div class="card">
  <div class="card-header">
    <h2 class="card-title">Active Product Categories</h2>
    <a href="../collections.php" target="_blank" class="btn-topbar">View Collections on Website ↗</a>
  </div>

  <table class="data-table">
    <thead>
      <tr>
        <th style="width: 80px;">Image</th>
        <th>Category Name</th>
        <th>Slug</th>
        <th>Description</th>
        <th>Products</th>
        <th style="text-align: right;">Action</th>
      </tr>
    </thead>
    <tbody>
      <?php foreach ($categories as $cat): ?>
        <tr>
          <td>
            <img src="../<?php echo htmlspecialchars($cat['image']); ?>" style="width: 50px; height: 50px; border-radius: 8px; object-fit: cover; border: 1px solid var(--border);" onerror="this.src='../assets/categories/encapsulated-ring-ct.jpg'" />
          </td>
          <td><strong><?php echo htmlspecialchars($cat['name']); ?></strong></td>
          <td><code><?php echo htmlspecialchars($cat['slug']); ?></code></td>
          <td style="max-width: 320px; font-size: 13px; color: var(--text-muted);">
            <?php echo htmlspecialchars($cat['description']); ?>
          </td>
          <td>
            <span class="badge badge-info"><?php echo $cat['product_count']; ?> products</span>
          </td>
          <td style="text-align: right;">
            <a href="../collections.php?category=<?php echo urlencode($cat['slug']); ?>" target="_blank" class="btn-topbar" style="padding: 6px 12px; font-size: 12px;">
              View ↗
            </a>
          </td>
        </tr>
      <?php endforeach; ?>
    </tbody>
  </table>
</div>

<?php include __DIR__ . '/footer.php'; ?>

<?php
/**
 * MVG Power Solutions — Brands & Manufacturer Management
 */

require_once __DIR__ . '/../config/constants.php';
require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../config/settings.php';

$adminTitle = 'Brands';
$adminHeading = 'Product Brands & Manufacturers';

$brandsFile = __DIR__ . '/../data/brands.json';
$brands = file_exists($brandsFile) ? (json_decode(file_get_contents($brandsFile), true) ?: []) : [];

$successMsg = '';
$errorMsg = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = $_POST['action'] ?? 'add';

    if ($action === 'add') {
        $name = trim($_POST['name'] ?? '');
        $country = trim($_POST['country'] ?? 'India');
        $desc = trim($_POST['description'] ?? '');

        if (!empty($name)) {
            $slug = strtolower(trim(preg_replace('/[^A-Za-z0-9-]+/', '-', $name), '-'));
            $brands[] = [
                'id'          => time(),
                'name'        => $name,
                'slug'        => $slug,
                'country'     => $country,
                'description' => $desc,
                'is_default'  => empty($brands)
            ];
            file_put_contents($brandsFile, json_encode($brands, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES));
            $successMsg = '✓ Brand created successfully!';
        } else {
            $errorMsg = 'Brand name is required.';
        }
    } elseif ($action === 'delete') {
        $delId = intval($_POST['brand_id'] ?? 0);
        $brands = array_values(array_filter($brands, function($b) use ($delId) {
            return ($b['id'] ?? 0) != $delId;
        }));
        file_put_contents($brandsFile, json_encode($brands, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES));
        $successMsg = '✓ Brand removed.';
    }
}

include __DIR__ . '/header.php';
?>

<div style="display: grid; grid-template-columns: 320px 1fr; gap: 24px; align-items: start;">

  <!-- Add Brand Form -->
  <div class="card">
    <div class="card-header">
      <h2 class="card-title">+ Add New Brand</h2>
    </div>

    <?php if (!empty($successMsg)): ?>
      <div style="background: #F0FDF4; border-left: 4px solid var(--green); color: #166534; padding: 10px 14px; font-size: 13px; border-radius: 6px; margin-bottom: 16px;">
        <?php echo $successMsg; ?>
      </div>
    <?php endif; ?>

    <form method="POST" action="">
      <input type="hidden" name="action" value="add">

      <div class="form-group">
        <label>Brand / Manufacturer Name *</label>
        <input type="text" name="name" class="form-control" placeholder="e.g. MVG Power Solutions" required>
      </div>

      <div class="form-group">
        <label>Country of Origin</label>
        <input type="text" name="country" class="form-control" value="India">
      </div>

      <div class="form-group">
        <label>Description / Certification</label>
        <textarea name="description" class="form-control" rows="3" placeholder="e.g. ISO 9001 certified OEM manufacturer"></textarea>
      </div>

      <button type="submit" class="btn-topbar btn-topbar-primary" style="width: 100%; justify-content: center; padding: 11px;">
        + Save Brand
      </button>
    </form>
  </div>

  <!-- Brands Table -->
  <div class="card">
    <div class="card-header">
      <h2 class="card-title">Existing Brands (<?php echo count($brands); ?>)</h2>
    </div>

    <table class="data-table">
      <thead>
        <tr>
          <th>Brand Name</th>
          <th>Slug</th>
          <th>Origin</th>
          <th>Description</th>
          <th style="text-align: right;">Action</th>
        </tr>
      </thead>
      <tbody>
        <?php foreach ($brands as $b): ?>
          <tr>
            <td>
              <strong><?php echo htmlspecialchars($b['name']); ?></strong>
              <?php if (!empty($b['is_default'])): ?>
                <span class="badge badge-success" style="font-size: 10px; margin-left: 6px;">Default</span>
              <?php endif; ?>
            </td>
            <td><code><?php echo htmlspecialchars($b['slug']); ?></code></td>
            <td><?php echo htmlspecialchars($b['country'] ?? 'India'); ?></td>
            <td style="font-size: 12.5px; color: var(--text-muted);"><?php echo htmlspecialchars($b['description'] ?? ''); ?></td>
            <td style="text-align: right;">
              <form method="POST" action="" style="display: inline;" onsubmit="return confirm('Delete brand?');">
                <input type="hidden" name="action" value="delete">
                <input type="hidden" name="brand_id" value="<?php echo $b['id']; ?>">
                <button type="submit" class="btn-gallery-action btn-remove-gallery" style="padding: 4px 8px;">Delete</button>
              </form>
            </td>
          </tr>
        <?php endforeach; ?>
      </tbody>
    </table>
  </div>

</div>

<?php include __DIR__ . '/footer.php'; ?>

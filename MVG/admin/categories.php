<?php
/**
 * MVG Power Solutions — Category & Sub-Category Management
 */

require_once __DIR__ . '/../config/constants.php';
require_once __DIR__ . '/../config/db.php';

$adminTitle = 'Categories & Sub-Categories';
$adminHeading = 'Product Categories & Sub-Categories';

$jsonPath = __DIR__ . '/../data/categories.json';
$allCats = file_exists($jsonPath) ? (json_decode(file_get_contents($jsonPath), true) ?: []) : [];

$successMsg = '';
$errorMsg = '';

// Handle Add / Edit / Delete
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = $_POST['action'] ?? 'add';

    if ($action === 'add') {
        $name = trim($_POST['name'] ?? '');
        $slug = trim($_POST['slug'] ?? '');
        $parentId = intval($_POST['parent_id'] ?? 0);
        $description = trim($_POST['description'] ?? '');
        $image = trim($_POST['image'] ?? 'assets/categories/encapsulated-ring-ct.jpg');

        if (empty($name)) {
            $errorMsg = 'Category name is required.';
        } else {
            if (empty($slug)) {
                $slug = strtolower(trim(preg_replace('/[^A-Za-z0-9-]+/', '-', $name), '-'));
            }

            $newId = time() % 100000;
            $allCats[] = [
                'id'          => $newId,
                'name'        => $name,
                'slug'        => $slug,
                'parent'      => $parentId,
                'description' => $description,
                'image'       => $image
            ];

            file_put_contents($jsonPath, json_encode($allCats, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES));
            $successMsg = ($parentId > 0) ? '✓ Sub-Category created successfully!' : '✓ Main Category created successfully!';
        }
    } elseif ($action === 'delete') {
        $delId = intval($_POST['cat_id'] ?? 0);
        if ($delId > 0) {
            // Remove item and any children
            $allCats = array_values(array_filter($allCats, function($c) use ($delId) {
                return $c['id'] != $delId && ($c['parent'] ?? 0) != $delId;
            }));
            file_put_contents($jsonPath, json_encode($allCats, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES));
            $successMsg = '✓ Category removed successfully.';
        }
    }
}

// Separate parents and sub-categories
$parentCats = [];
$subCatsByParent = [];

foreach ($allCats as $c) {
    $pId = intval($c['parent'] ?? 0);
    if ($pId === 0) {
        $parentCats[] = $c;
    } else {
        $subCatsByParent[$pId][] = $c;
    }
}

include __DIR__ . '/header.php';
?>

<div style="display: grid; grid-template-columns: 340px 1fr; gap: 24px; align-items: start;">

  <!-- LEFT: Add Category / Sub-Category Form -->
  <div class="card">
    <div class="card-header">
      <h2 class="card-title">+ Add New Category / Sub-Category</h2>
    </div>

    <?php if (!empty($successMsg)): ?>
      <div style="background: #F0FDF4; border-left: 4px solid var(--green); color: #166534; padding: 10px 14px; font-size: 13px; border-radius: 6px; margin-bottom: 16px;">
        <?php echo $successMsg; ?>
      </div>
    <?php endif; ?>

    <?php if (!empty($errorMsg)): ?>
      <div style="background: #FEF2F2; border-left: 4px solid var(--red); color: #991B1B; padding: 10px 14px; font-size: 13px; border-radius: 6px; margin-bottom: 16px;">
        <?php echo $errorMsg; ?>
      </div>
    <?php endif; ?>

    <form method="POST" action="categories.php">
      <input type="hidden" name="action" value="add">

      <div class="form-group">
        <label for="name">Name *</label>
        <input 
          type="text" 
          id="name" 
          name="name" 
          class="form-control" 
          placeholder="e.g. Resin Cast CT or 115mm Window" 
          required 
          oninput="document.getElementById('slug').value = this.value.toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/(^-|-$)/g, '')"
        />
      </div>

      <div class="form-group">
        <label for="parent_id">Category Type / Hierarchy *</label>
        <select id="parent_id" name="parent_id" class="form-control">
          <option value="0" style="font-weight: 700;">📁 None (Main Top-Level Category)</option>
          <optgroup label="── Or Select Parent to create a Sub-Category ──">
            <?php foreach ($parentCats as $pCat): ?>
              <option value="<?php echo $pCat['id']; ?>">
                ↳ Under: <?php echo htmlspecialchars($pCat['name']); ?>
              </option>
            <?php endforeach; ?>
          </optgroup>
        </select>
        <span style="font-size: 11px; color: #64748B; margin-top: 4px; display: block;">
          Select a parent category to create a <strong>Sub-Category</strong>.
        </span>
      </div>

      <div class="form-group">
        <label for="slug">Slug (URL)</label>
        <input 
          type="text" 
          id="slug" 
          name="slug" 
          class="form-control" 
          placeholder="e.g. resin-cast-ct" 
        />
        <span style="font-size: 11px; color: #64748B; margin-top: 4px; display: block;">
          URL friendly identifier (lowercase, numbers, hyphens).
        </span>
      </div>

      <div class="form-group">
        <label for="image">Image URL / Path</label>
        <input 
          type="text" 
          id="image" 
          name="image" 
          class="form-control" 
          value="assets/categories/encapsulated-ring-ct.jpg" 
        />
      </div>

      <div class="form-group">
        <label for="description">Description</label>
        <textarea 
          id="description" 
          name="description" 
          class="form-control" 
          rows="3" 
          placeholder="Short overview of this category..."
        ></textarea>
      </div>

      <button type="submit" class="btn-topbar btn-topbar-primary" style="width: 100%; justify-content: center; padding: 11px; font-weight: 700; font-size: 13.5px; margin-top: 8px;">
        + Save Category / Sub-Category
      </button>
    </form>
  </div>

  <!-- RIGHT: Categories & Sub-Categories Hierarchy Table -->
  <div class="card">
    <div class="card-header">
      <div>
        <h2 class="card-title">Category Tree Structure</h2>
        <span style="font-size: 12.5px; color: var(--text-muted);">
          Total: <?php echo count($parentCats); ?> Parent Categories &bull; <?php echo count($allCats) - count($parentCats); ?> Sub-Categories
        </span>
      </div>
      <a href="../collections.php" target="_blank" class="btn-topbar">View Collections on Website ↗</a>
    </div>

    <table class="data-table">
      <thead>
        <tr>
          <th style="width: 60px;">Image</th>
          <th>Name &amp; Hierarchy</th>
          <th>Slug</th>
          <th>Type</th>
          <th>Description</th>
          <th style="text-align: right;">Action</th>
        </tr>
      </thead>
      <tbody>
        <?php foreach ($parentCats as $pCat): ?>
          <!-- Parent Category Row -->
          <tr style="background: #FFFFFF;">
            <td>
              <img src="../<?php echo htmlspecialchars($pCat['image'] ?? 'assets/categories/encapsulated-ring-ct.jpg'); ?>" style="width: 44px; height: 44px; border-radius: 6px; object-fit: cover; border: 1px solid var(--border);" onerror="this.src='../assets/categories/encapsulated-ring-ct.jpg'" />
            </td>
            <td>
              <strong style="font-size: 14px; color: var(--navy); display: flex; align-items: center; gap: 6px;">
                📁 <?php echo htmlspecialchars($pCat['name']); ?>
              </strong>
            </td>
            <td><code><?php echo htmlspecialchars($pCat['slug']); ?></code></td>
            <td><span class="badge badge-info">Parent Category</span></td>
            <td style="max-width: 240px; font-size: 12.5px; color: var(--text-muted);">
              <?php echo htmlspecialchars($pCat['description'] ?? ''); ?>
            </td>
            <td style="text-align: right;">
              <form method="POST" action="categories.php" style="display: inline;" onsubmit="return confirm('Delete this parent category and all its sub-categories?');">
                <input type="hidden" name="action" value="delete">
                <input type="hidden" name="cat_id" value="<?php echo $pCat['id']; ?>">
                <button type="submit" class="btn-gallery-action btn-remove-gallery" style="padding: 5px 9px;">Delete</button>
              </form>
            </td>
          </tr>

          <!-- Child Sub-Categories Rows -->
          <?php if (!empty($subCatsByParent[$pCat['id']])): ?>
            <?php foreach ($subCatsByParent[$pCat['id']] as $sCat): ?>
              <tr style="background: #F8FAFC;">
                <td style="text-align: center; color: #94A3B8;">
                  ↳
                </td>
                <td style="padding-left: 24px;">
                  <span style="font-size: 13.5px; font-weight: 600; color: #334155; display: flex; align-items: center; gap: 6px;">
                    <span style="color: var(--primary); font-weight: bold;">↳</span>
                    <?php echo htmlspecialchars($sCat['name']); ?>
                  </span>
                </td>
                <td><code><?php echo htmlspecialchars($sCat['slug']); ?></code></td>
                <td><span class="badge" style="background: #E2E8F0; color: #475569; font-size: 11px;">Sub-Category</span></td>
                <td style="max-width: 240px; font-size: 12px; color: var(--text-muted);">
                  <?php echo htmlspecialchars($sCat['description'] ?? ''); ?>
                </td>
                <td style="text-align: right;">
                  <form method="POST" action="categories.php" style="display: inline;" onsubmit="return confirm('Delete this sub-category?');">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="cat_id" value="<?php echo $sCat['id']; ?>">
                    <button type="submit" class="btn-gallery-action btn-remove-gallery" style="padding: 5px 9px;">Delete</button>
                  </form>
                </td>
              </tr>
            <?php endforeach; ?>
          <?php endif; ?>

        <?php endforeach; ?>
      </tbody>
    </table>
  </div>

</div>

<?php include __DIR__ . '/footer.php'; ?>

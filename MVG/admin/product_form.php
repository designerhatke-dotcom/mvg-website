<?php
/**
 * MVG Power Solutions — Add / Edit Product
 * Clean standard product form (reverted from WYSIWYG & image SEO modals)
 */

require_once __DIR__ . '/../config/constants.php';
require_once __DIR__ . '/../config/db.php';

$editId = isset($_GET['id']) ? intval($_GET['id']) : null;
$product = null;

if ($editId) {
    $product = Database::getProductById($editId);
}

$adminTitle = $editId ? 'Edit Product #' . $editId : 'Add New Product';
$adminHeading = $editId ? 'Edit Industrial Product' : 'Add New Current Transformer';

$successMsg = '';
$errorMsg = '';

// Fetch all categories for the dropdown
$categories = Database::getCategories();
if (empty($categories)) {
    $categories = [
        ['slug' => 'encapsulated-ring-ct', 'name' => 'Encapsulated Ring CT', 'id' => 1],
        ['slug' => 'encapsulated-square-ct', 'name' => 'Encapsulated Square CT', 'id' => 2],
        ['slug' => 'tape-wound-ring-ct', 'name' => 'Tape Wound Ring CT', 'id' => 3],
        ['slug' => 'resin-cast-rectangular-ct', 'name' => 'Resin Cast Rectangular CT', 'id' => 4],
        ['slug' => 'resin-cast-ring-ct', 'name' => 'Resin Cast Ring CT', 'id' => 5],
        ['slug' => 'split-core-ct', 'name' => 'Split Core CT', 'id' => 6],
    ];
}

// Handle Form Submission
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $name = trim($_POST['name'] ?? '');
    $sku = trim($_POST['sku'] ?? '');
    $price = floatval($_POST['price'] ?? 280);
    $category = trim($_POST['category'] ?? 'encapsulated-ring-ct');
    $minQty = intval($_POST['min_qty'] ?? 10);
    $image = trim($_POST['image'] ?? 'assets/categories/encapsulated-ring-ct.jpg');
    $shortDesc = trim($_POST['short_description'] ?? '');
    $fullDesc = trim($_POST['description'] ?? '');

    if (empty($name) || empty($sku)) {
        $errorMsg = 'Product name and SKU are required.';
    } else {
        $pdo = Database::getConnection();
        $saved = false;

        // 1. Try MySQL if connected
        if ($pdo) {
            try {
                $catId = 1;
                foreach ($categories as $c) {
                    if ($c['slug'] === $category) {
                        $catId = $c['id'];
                        break;
                    }
                }
                $slug = strtolower(trim(preg_replace('/[^A-Za-z0-9-]+/', '-', $name), '-'));

                if ($editId) {
                    $stmt = $pdo->prepare("
                        UPDATE products SET 
                            name = ?, category_id = ?, sku = ?, price = ?, min_qty = ?, 
                            featured_image = ?, short_description = ?, description = ?
                        WHERE id = ?
                    ");
                    $stmt->execute([$name, $catId, $sku, $price, $minQty, $image, $shortDesc, $fullDesc, $editId]);
                } else {
                    $stmt = $pdo->prepare("
                        INSERT INTO products (category_id, name, slug, sku, price, min_qty, featured_image, short_description, description)
                        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
                    ");
                    $stmt->execute([$catId, $name, $slug, $sku, $price, $minQty, $image, $shortDesc, $fullDesc]);
                    $editId = $pdo->lastInsertId();
                }
                $saved = true;
            } catch (Exception $e) {
                // Fallback to JSON
            }
        }

        // 2. Also keep data/products.json updated
        $jsonPath = __DIR__ . '/../data/products.json';
        if (file_exists($jsonPath)) {
            $jsonProducts = json_decode(file_get_contents($jsonPath), true) ?: [];
            $found = false;

            $catName = 'Encapsulated Ring CT';
            foreach ($categories as $c) {
                if ($c['slug'] === $category) {
                    $catName = $c['name'];
                    break;
                }
            }

            foreach ($jsonProducts as &$p) {
                if ($editId && $p['id'] == $editId) {
                    $p['name'] = $name;
                    $p['sku'] = $sku;
                    $p['prices']['price'] = strval($price * 100);
                    $p['images'][0]['src'] = $image;
                    $p['short_description'] = $shortDesc;
                    $p['description'] = $fullDesc;
                    $p['categories'] = [['slug' => $category, 'name' => $catName]];
                    $found = true;
                    break;
                }
            }
            unset($p);

            if (!$found) {
                $newId = $editId ?: (time() % 100000);
                $jsonProducts[] = [
                    'id' => $newId,
                    'name' => $name,
                    'sku' => $sku,
                    'slug' => strtolower(trim(preg_replace('/[^A-Za-z0-9-]+/', '-', $name), '-')),
                    'prices' => ['price' => strval($price * 100)],
                    'categories' => [['slug' => $category, 'name' => $catName]],
                    'images' => [['src' => $image]],
                    'short_description' => $shortDesc,
                    'description' => $fullDesc
                ];
                $editId = $newId;
            }

            file_put_contents($jsonPath, json_encode($jsonProducts, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES));
            $saved = true;
        }

        if ($saved) {
            $successMsg = 'Product saved successfully! Changes are live on your website.';
            $product = Database::getProductById($editId);
        }
    }
}

include __DIR__ . '/header.php';
?>

<div style="max-width: 900px; margin: 0 auto;">

  <?php if (!empty($successMsg)): ?>
    <div class="card" style="border-left: 4px solid var(--green); background: #F0FDF4; padding: 14px 20px;">
      <strong style="color: #166534;"><?php echo $successMsg; ?></strong>
      <div style="margin-top: 6px;">
        <a href="../product.php?id=<?php echo $editId; ?>" target="_blank" style="color: var(--primary); font-size: 13px; font-weight: 700;">
          View Product Page Live &rarr;
        </a>
      </div>
    </div>
  <?php endif; ?>

  <?php if (!empty($errorMsg)): ?>
    <div class="card" style="border-left: 4px solid var(--red); background: #FEF2F2; padding: 14px 20px;">
      <strong style="color: #991B1B;"><?php echo $errorMsg; ?></strong>
    </div>
  <?php endif; ?>

  <div class="card">
    <div class="card-header">
      <h2 class="card-title"><?php echo $editId ? 'Edit Product Details' : 'Product Specifications'; ?></h2>
      <a href="products.php" class="btn-topbar">&larr; Back to Products</a>
    </div>

    <form method="POST" action="">
      <div class="form-grid">
        <div class="form-group" style="grid-column: 1 / -1;">
          <label for="name">Product Name *</label>
          <input 
            type="text" 
            id="name" 
            name="name" 
            class="form-control" 
            value="<?php echo htmlspecialchars($product['name'] ?? ''); ?>" 
            placeholder="e.g. 2500/5A Ring Current Transformer 115mm CT | Class 1.0"
            required 
          />
        </div>

        <div class="form-group">
          <label for="sku">SKU Code *</label>
          <input 
            type="text" 
            id="sku" 
            name="sku" 
            class="form-control" 
            value="<?php echo htmlspecialchars($product['sku'] ?? 'MVG-CT-' . time()); ?>" 
            required 
          />
        </div>

        <div class="form-group">
          <label for="category">Category</label>
          <select id="category" name="category" class="form-control">
            <?php foreach ($categories as $cat): ?>
              <?php $selected = (($product['category'] ?? '') === $cat['slug']) ? 'selected' : ''; ?>
              <option value="<?php echo htmlspecialchars($cat['slug']); ?>" <?php echo $selected; ?>>
                <?php echo htmlspecialchars($cat['name']); ?>
              </option>
            <?php endforeach; ?>
          </select>
        </div>

        <div class="form-group">
          <label for="price">Unit Price (₹ Excl. GST) *</label>
          <input 
            type="number" 
            step="0.01" 
            id="price" 
            name="price" 
            class="form-control" 
            value="<?php echo htmlspecialchars($product['price'] ?? 280); ?>" 
            required 
          />
        </div>

        <div class="form-group">
          <label for="min_qty">Minimum Order Quantity (pcs)</label>
          <input 
            type="number" 
            id="min_qty" 
            name="min_qty" 
            class="form-control" 
            value="<?php echo htmlspecialchars($product['minQty'] ?? DEFAULT_MIN_QTY); ?>" 
            required 
          />
        </div>

        <div class="form-group" style="grid-column: 1 / -1;">
          <label for="image">Primary Image URL</label>
          <input 
            type="text" 
            id="image" 
            name="image" 
            class="form-control" 
            value="<?php echo htmlspecialchars($product['image'] ?? 'assets/categories/encapsulated-ring-ct.jpg'); ?>" 
            placeholder="assets/categories/... or https://..."
          />
        </div>

        <div class="form-group" style="grid-column: 1 / -1;">
          <label for="short_description">Bullet Highlights / Specifications (HTML or Text)</label>
          <textarea 
            id="short_description" 
            name="short_description" 
            class="form-control" 
            rows="5" 
            placeholder="<ul><li><strong>Primary Current:</strong> 2500A</li>...</ul>"
          ><?php echo htmlspecialchars($product['short_description'] ?? ''); ?></textarea>
        </div>

        <div class="form-group" style="grid-column: 1 / -1;">
          <label for="description">Full Product Overview &amp; Applications</label>
          <textarea 
            id="description" 
            name="description" 
            class="form-control" 
            rows="6" 
            placeholder="Detailed description for the product..."
          ><?php echo htmlspecialchars($product['description'] ?? ''); ?></textarea>
        </div>
      </div>

      <div style="margin-top: 24px; padding-top: 18px; border-top: 1px solid var(--border); display: flex; gap: 12px;">
        <button type="submit" class="btn-topbar btn-topbar-primary" style="padding: 12px 24px;">
          💾 Save Product
        </button>
        <a href="products.php" class="btn-topbar" style="padding: 12px 20px;">Cancel</a>
      </div>
    </form>
  </div>

</div>

<?php include __DIR__ . '/footer.php'; ?>

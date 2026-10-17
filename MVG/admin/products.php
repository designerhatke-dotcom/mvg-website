<?php
/**
 * MVG Power Solutions — Product Catalog Management
 */

require_once __DIR__ . '/../config/constants.php';
require_once __DIR__ . '/../config/db.php';

$adminTitle = 'Products Catalog';
$adminHeading = 'Product Catalog';

$categoryFilter = $_GET['category'] ?? 'all';
$searchQuery = trim($_GET['q'] ?? '');

$allProducts = Database::getProducts($categoryFilter);

// Filter by search query if provided
if (!empty($searchQuery)) {
    $filtered = [];
    foreach ($allProducts as $p) {
        if (stripos($p['name'], $searchQuery) !== false || stripos($p['sku'], $searchQuery) !== false) {
            $filtered[] = $p;
        }
    }
    $allProducts = $filtered;
}

include __DIR__ . '/header.php';
?>

<div class="card">
  <div class="card-header">
    <div style="display: flex; gap: 12px; align-items: center; flex: 1; max-width: 600px;">
      <form method="GET" action="products.php" style="display: flex; gap: 8px; flex: 1;">
        <input 
          type="text" 
          name="q" 
          class="form-control" 
          placeholder="Search by name, ratio, or SKU..." 
          value="<?php echo htmlspecialchars($searchQuery); ?>" 
        />
        <select name="category" class="form-control" style="width: 220px;" onchange="this.form.submit()">
          <option value="all" <?php echo ($categoryFilter === 'all') ? 'selected' : ''; ?>>All Categories</option>
          <option value="encapsulated-ring-ct" <?php echo ($categoryFilter === 'encapsulated-ring-ct') ? 'selected' : ''; ?>>Encapsulated Ring CT</option>
          <option value="encapsulated-square-ct" <?php echo ($categoryFilter === 'encapsulated-square-ct') ? 'selected' : ''; ?>>Encapsulated Square CT</option>
        </select>
        <button type="submit" class="btn-topbar btn-topbar-primary">Search</button>
      </form>
    </div>

    <a href="product_form.php" class="btn-topbar btn-topbar-primary">
      + Add New Product
    </a>
  </div>

  <table class="data-table">
    <thead>
      <tr>
        <th style="width: 60px;">Image</th>
        <th>Product Name</th>
        <th>SKU</th>
        <th>Category</th>
        <th>Price (Excl. GST)</th>
        <th>Min Order</th>
        <th style="text-align: right;">Actions</th>
      </tr>
    </thead>
    <tbody>
      <?php if (!empty($allProducts)): ?>
        <?php foreach ($allProducts as $p): ?>
          <tr>
            <td>
              <img src="<?php echo htmlspecialchars($p['image']); ?>" style="width: 44px; height: 44px; border-radius: 6px; object-fit: cover; border: 1px solid var(--border);" />
            </td>
            <td>
              <strong style="font-size: 13.5px; color: var(--navy); display: block; max-width: 360px;">
                <?php echo htmlspecialchars($p['name']); ?>
              </strong>
              <span style="font-size: 11.5px; color: var(--text-muted);">ID: #<?php echo $p['id']; ?></span>
            </td>
            <td><code><?php echo htmlspecialchars($p['sku']); ?></code></td>
            <td>
              <span class="badge badge-info"><?php echo htmlspecialchars($p['categoryName']); ?></span>
              <?php if (!empty($p['sub_category'])): ?>
                <div style="margin-top: 4px;">
                  <span class="badge" style="background: #F1F5F9; color: #475569; font-size: 11px; border: 1px solid var(--border);">
                    ↳ <?php echo htmlspecialchars($p['sub_category']); ?>
                  </span>
                </div>
              <?php endif; ?>
            </td>
            <td>
              <strong>&#8377;<?php echo number_format($p['price'], 2); ?></strong>
              <div style="font-size: 11.5px; color: var(--text-muted);">Incl. 18% GST: &#8377;<?php echo number_format(round($p['price'] * 1.18), 2); ?></div>
            </td>
            <td>
              <span class="badge badge-warning"><?php echo $p['minQty'] ?? DEFAULT_MIN_QTY; ?> pcs</span>
            </td>
            <td style="text-align: right;">
              <div style="display: inline-flex; gap: 8px;">
                <a href="product_form.php?id=<?php echo $p['id']; ?>" class="btn-topbar" style="padding: 6px 10px; font-size: 12px;">Edit</a>
                <a href="../product.php?id=<?php echo $p['id']; ?>" target="_blank" class="btn-topbar" style="padding: 6px 10px; font-size: 12px; color: var(--primary);">View ↗</a>
              </div>
            </td>
          </tr>
        <?php endforeach; ?>
      <?php else: ?>
        <tr>
          <td colspan="7" style="text-align: center; padding: 40px; color: var(--text-muted);">
            No products found matching your search.
          </td>
        </tr>
      <?php endif; ?>
    </tbody>
  </table>
</div>

<?php include __DIR__ . '/footer.php'; ?>

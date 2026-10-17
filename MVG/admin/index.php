<?php
/**
 * MVG Power Solutions — Admin Dashboard
 */

require_once __DIR__ . '/../config/constants.php';
require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../includes/google_reviews.php';

$adminTitle = 'Dashboard';
$adminHeading = 'System & Catalog Overview';

$pdo = Database::getConnection();
$dbConnected = ($pdo !== null);

// Fetch counts
$products = Database::getProducts();
$productCount = count($products);

$reviewsData = GoogleReviewsService::getReviewsData();
$rating = $reviewsData['rating'] ?? 4.9;
$reviewCount = $reviewsData['user_ratings_total'] ?? 12;

$inquiryCount = 0;
$recentInquiries = [];

if ($pdo) {
    try {
        $stmt = $pdo->query("SELECT COUNT(*) FROM inquiries");
        $inquiryCount = $stmt->fetchColumn() ?: 0;

        $stmtRecent = $pdo->query("SELECT * FROM inquiries ORDER BY id DESC LIMIT 5");
        $recentInquiries = $stmtRecent->fetchAll();
    } catch (Exception $e) {
        // Table may not exist yet
    }
}

include __DIR__ . '/header.php';
?>

<!-- Database Connection Status Banner -->
<?php if ($dbConnected): ?>
  <div class="card" style="border-left: 4px solid var(--green); background: #F0FDF4;">
    <div style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 10px;">
      <div>
        <strong style="color: #166534; font-size: 14px;">✓ MySQL Database (mvg_db) Connected Active</strong>
        <p style="margin: 4px 0 0 0; font-size: 13px; color: #15803D;">
          All product updates, inquiries, and reviews are reading/writing directly to your MySQL database.
        </p>
      </div>
      <a href="../database/import_seed.php" class="btn-topbar" target="_blank" style="background: #fff;">
        Re-seed / Migrate Database &rarr;
      </a>
    </div>
  </div>
<?php else: ?>
  <div class="card" style="border-left: 4px solid var(--amber); background: #FFFBEB;">
    <div style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 10px;">
      <div>
        <strong style="color: #92400E; font-size: 14px;">⚠️ Running in JSON Local Provider Mode</strong>
        <p style="margin: 4px 0 0 0; font-size: 13px; color: #B45309;">
          MySQL is not yet connected. The website is seamlessly serving products from <code>data/products.json</code>.
        </p>
      </div>
      <a href="../database/import_seed.php" class="btn-topbar btn-topbar-primary" target="_blank">
        ⚡ 1-Click Run Database Setup
      </a>
    </div>
  </div>
<?php endif; ?>

<!-- Stats Metrics -->
<div class="stats-grid">
  <div class="stat-card">
    <div class="stat-title">Catalog Products</div>
    <div class="stat-value"><?php echo $productCount; ?></div>
    <div class="stat-desc">Industrial Current Transformers</div>
  </div>

  <div class="stat-card">
    <div class="stat-title">Customer Rating</div>
    <div class="stat-value" style="color: #D97706;"><?php echo number_format($rating, 1); ?> ★</div>
    <div class="stat-desc"><?php echo $reviewCount; ?> Verified Google Reviews</div>
  </div>

  <div class="stat-card">
    <div class="stat-title">Active Categories</div>
    <div class="stat-value">4</div>
    <div class="stat-desc">Ring, Square, Tape Wound, Custom</div>
  </div>

  <div class="stat-card">
    <div class="stat-title">Inquiries &amp; RFQs</div>
    <div class="stat-value" style="color: var(--primary);"><?php echo $inquiryCount; ?></div>
    <div class="stat-desc">Commercial Panel Builder Leads</div>
  </div>
</div>

<!-- Quick Shortcuts Grid -->
<div style="display: grid; grid-template-columns: 2fr 1fr; gap: 24px;">

  <!-- Recent Products Table -->
  <div class="card">
    <div class="card-header">
      <h2 class="card-title">Top Products in Catalog</h2>
      <a href="products.php" style="font-size: 13px; color: var(--primary); font-weight: 600; text-decoration: none;">View All &rarr;</a>
    </div>

    <table class="data-table">
      <thead>
        <tr>
          <th>Product Name</th>
          <th>SKU</th>
          <th>Category</th>
          <th>Price</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
        <?php foreach (array_slice($products, 0, 5) as $prod): ?>
          <tr>
            <td>
              <div style="display: flex; align-items: center; gap: 10px;">
                <img src="<?php echo htmlspecialchars($prod['image']); ?>" style="width: 36px; height: 36px; border-radius: 6px; object-fit: cover; border: 1px solid var(--border);" />
                <div>
                  <strong style="font-size: 13px; display: block; max-width: 280px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
                    <?php echo htmlspecialchars($prod['name']); ?>
                  </strong>
                </div>
              </div>
            </td>
            <td><code><?php echo htmlspecialchars($prod['sku']); ?></code></td>
            <td><span class="badge badge-info"><?php echo htmlspecialchars($prod['categoryName']); ?></span></td>
            <td><strong>&#8377;<?php echo number_format($prod['price'], 2); ?></strong></td>
            <td>
              <a href="../product.php?id=<?php echo $prod['id']; ?>" target="_blank" style="font-size: 12.5px; color: var(--primary); text-decoration: none; font-weight: 600;">View ↗</a>
            </td>
          </tr>
        <?php endforeach; ?>
      </tbody>
    </table>
  </div>

  <!-- Quick Actions & Links -->
  <div class="card">
    <div class="card-header">
      <h2 class="card-title">Quick Actions</h2>
    </div>

    <div style="display: flex; flex-direction: column; gap: 12px;">
      <a href="product_form.php" class="btn-topbar btn-topbar-primary" style="justify-content: center; padding: 12px;">
        + Create New Product
      </a>

      <a href="reviews.php" class="btn-topbar" style="justify-content: center; padding: 12px;">
        ⭐ Manage Customer Reviews
      </a>

      <a href="../database/import_seed.php" class="btn-topbar" target="_blank" style="justify-content: center; padding: 12px;">
        🗄️ Run Database Migration
      </a>

      <a href="settings.php" class="btn-topbar" style="justify-content: center; padding: 12px;">
        ⚙️ Company Contact &amp; GST Settings
      </a>
    </div>

    <div style="margin-top: 24px; padding-top: 18px; border-top: 1px solid var(--border); font-size: 12.5px; color: var(--text-muted); line-height: 1.5;">
      <strong>phpMyAdmin Direct Setup:</strong><br>
      To manage tables manually, open <code>http://localhost/phpmyadmin/</code>, select <code>mvg_db</code>, and inspect tables.
    </div>
  </div>

</div>

<?php include __DIR__ . '/footer.php'; ?>

<?php
/**
 * MVG Power Solutions — Products Bulk CSV Import & Export
 */

require_once __DIR__ . '/../config/constants.php';
require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../config/settings.php';

$adminTitle = 'Bulk Import / Export';
$adminHeading = 'Product Catalog CSV Bulk Import & Export';

$products = Database::getProducts();
$msg = '';
$error = '';

// Handle CSV Export
if (isset($_GET['action']) && $_GET['action'] === 'export_csv') {
    header('Content-Type: text/csv; charset=utf-8');
    header('Content-Disposition: attachment; filename="mvg_products_' . date('Y-m-d') . '.csv"');
    
    $out = fopen('php://output', 'w');
    // Header
    fputcsv($out, ['ID', 'Name', 'Slug', 'SKU', 'Category', 'Sub Category', 'Price', 'Min Qty', 'Image URL', 'Short Description']);
    
    foreach ($products as $p) {
        fputcsv($out, [
            $p['id'],
            $p['name'],
            $p['slug'] ?? '',
            $p['sku'] ?? '',
            $p['category'] ?? '',
            $p['sub_category'] ?? '',
            $p['price'] ?? 0,
            $p['minQty'] ?? DEFAULT_MIN_QTY,
            $p['image'] ?? '',
            strip_tags($p['short_description'] ?? '')
        ]);
    }
    fclose($out);
    exit;
}

// Handle CSV Import
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_FILES['csv_file'])) {
    if ($_FILES['csv_file']['error'] === UPLOAD_ERR_OK) {
        $tmp = $_FILES['csv_file']['tmp_name'];
        $handle = fopen($tmp, 'r');
        $headers = fgetcsv($handle);
        $imported = 0;

        $jsonPath = __DIR__ . '/../data/products.json';
        $currentProducts = file_exists($jsonPath) ? (json_decode(file_get_contents($jsonPath), true) ?: []) : [];

        while (($row = fgetcsv($handle)) !== false) {
            if (count($row) >= 4) {
                $imported++;
                // Add or update in list
                $name = trim($row[1] ?? '');
                $sku = trim($row[3] ?? ('MVG-CT-' . time()));
                $price = floatval($row[6] ?? 280);
                
                if (!empty($name)) {
                    $slug = strtolower(trim(preg_replace('/[^A-Za-z0-9-]+/', '-', $name), '-'));
                    $newProd = [
                        'id'                => time() + $imported,
                        'name'              => $name,
                        'slug'              => $slug,
                        'sku'               => $sku,
                        'price'             => $price,
                        'category'          => trim($row[4] ?? 'encapsulated-ring-ct'),
                        'sub_category'      => trim($row[5] ?? ''),
                        'images'            => [['src' => trim($row[8] ?? 'assets/categories/encapsulated-ring-ct.jpg')]],
                        'short_description' => '<p>' . htmlspecialchars($row[9] ?? '') . '</p>'
                    ];
                    $currentProducts[] = $newProd;
                }
            }
        }
        fclose($handle);

        file_put_contents($jsonPath, json_encode($currentProducts, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES));
        $msg = "✓ Successfully processed and imported {$imported} products from CSV!";
    } else {
        $error = 'Please select a valid CSV file to upload.';
    }
}

include __DIR__ . '/header.php';
?>

<div style="max-width: 900px; margin: 0 auto;">

  <?php if (!empty($msg)): ?>
    <div style="background: #F0FDF4; border-left: 4px solid var(--green); color: #166534; padding: 12px 18px; font-size: 13.5px; border-radius: 8px; margin-bottom: 20px;">
      <?php echo $msg; ?>
    </div>
  <?php endif; ?>

  <?php if (!empty($error)): ?>
    <div style="background: #FEF2F2; border-left: 4px solid var(--red); color: #991B1B; padding: 12px 18px; font-size: 13.5px; border-radius: 8px; margin-bottom: 20px;">
      <?php echo $error; ?>
    </div>
  <?php endif; ?>

  <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 24px;">

    <!-- CSV Export Card -->
    <div class="card">
      <div class="card-header">
        <h2 class="card-title">📥 Export Catalog to CSV</h2>
      </div>
      <p style="font-size: 13px; color: var(--text-muted); line-height: 1.6;">
        Download all <strong><?php echo count($products); ?> current transformer models</strong> currently in your catalog in standard UTF-8 CSV spreadsheet format.
      </p>

      <ul style="font-size: 12px; color: var(--text-muted); padding-left: 18px; margin-bottom: 20px; line-height: 1.7;">
        <li>Includes SKU, Name, Slugs, Categories &amp; Pricing</li>
        <li>Includes primary images and specification highlights</li>
        <li>Compatible with Excel, Google Sheets, and ERP systems</li>
      </ul>

      <a href="products_import_export.php?action=export_csv" class="btn-topbar btn-topbar-primary" style="display: inline-flex; justify-content: center; width: 100%; padding: 12px; font-weight: 700; text-decoration: none;">
        📥 Download Products CSV (<?php echo count($products); ?> Items)
      </a>
    </div>

    <!-- CSV Import Card -->
    <div class="card">
      <div class="card-header">
        <h2 class="card-title">📤 Bulk Import / Update from CSV</h2>
      </div>

      <p style="font-size: 13px; color: var(--text-muted); line-height: 1.6;">
        Upload a structured CSV spreadsheet to bulk insert new current transformer models or update existing SKUs.
      </p>

      <form method="POST" enctype="multipart/form-data" action="">
        <div class="form-group" style="margin-bottom: 16px;">
          <label>Select CSV File (.csv)</label>
          <input type="file" name="csv_file" accept=".csv" class="form-control" required style="padding: 8px;">
        </div>

        <button type="submit" class="btn-topbar" style="width: 100%; justify-content: center; padding: 12px; font-weight: 700; background: var(--navy); color: #fff;">
          ⬆️ Upload &amp; Run Bulk Import
        </button>
      </form>
    </div>

  </div>

</div>

<?php include __DIR__ . '/footer.php'; ?>

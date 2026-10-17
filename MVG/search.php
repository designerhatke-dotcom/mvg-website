<?php
/**
 * MVG Power Solutions — Dedicated Catalog Search Page
 */

require_once __DIR__ . '/config/constants.php';
require_once __DIR__ . '/config/db.php';
require_once __DIR__ . '/config/settings.php';

$q = trim($_GET['q'] ?? $_GET['s'] ?? '');
$pageTitle = ($q ? "Search: " . htmlspecialchars($q) . " | " : "Search Current Transformers | ") . SITE_NAME;
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title><?php echo htmlspecialchars($pageTitle); ?></title>
  <link rel="stylesheet" href="css/style.css">
  <style>
    .search-hero {
      background: linear-gradient(135deg, #0F172A 0%, #1E293B 100%);
      color: #FFFFFF;
      padding: 50px 0;
      text-align: center;
    }
    .search-bar-wrap {
      max-width: 640px;
      margin: 20px auto 0 auto;
    }
    .search-input-lg {
      width: 100%;
      padding: 14px 20px;
      font-size: 16px;
      border-radius: 10px;
      border: 1px solid #CBD5E1;
      outline: none;
      box-sizing: border-box;
    }
    .search-input-lg:focus {
      border-color: var(--mvg-brand);
      box-shadow: 0 0 0 3px rgba(2, 132, 199, 0.2);
    }
    .search-main {
      padding: 50px 0 80px 0;
      background: #F8FAFC;
    }
  </style>
</head>
<body>

  <header class="mvg-site-header"><?php include __DIR__ . '/includes/header.php'; ?></header>

  <section class="search-hero">
    <div class="mvg-header-container">
      <h1 style="font-size: 32px; font-weight: 900; margin-bottom: 8px;">Catalog Product Search</h1>
      <p style="color: #94A3B8; font-size: 15px;">Search by Primary Ratio (e.g. 200/5A, 400/5A), Busbar Window, or Model Number.</p>
      
      <div class="search-bar-wrap">
        <input 
          type="search" 
          id="customSearchInput" 
          class="search-input-lg" 
          placeholder="Search by ratio (e.g. 100/5A, 400/5A), busbar size..." 
          value="<?php echo htmlspecialchars($q); ?>"
          oninput="handleSearchType(this.value)"
        />
      </div>
    </div>
  </section>

  <main class="search-main">
    <div class="mvg-header-container">
      
      <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 24px; border-bottom: 2px solid #E2E8F0; padding-bottom: 12px;">
        <h2 id="sectionHeading" style="font-size: 20px; font-weight: 800; color: #0F172A; margin: 0;">Matching Transformer Models</h2>
        <span id="resultsCount" style="font-size: 13px; font-weight: 700; color: var(--mvg-brand);">Showing products</span>
      </div>

      <!-- Controls: 18% GST Switch & Sort -->
      <div style="display: flex; align-items: center; justify-content: flex-end; gap: 16px; margin-bottom: 20px;">
        <div class="gst-toggle-control">
          <span class="gst-label-text">18% GST:</span>
          <label class="switch-control" title="Toggle 18% GST calculation">
            <input type="checkbox" id="gstToggleCheck" />
            <span class="slider"></span>
          </label>
        </div>

        <div class="sort-wrap">
          <label for="sortSelect" style="font-size: 13px; font-weight: 600; color: #475569;">Sort:</label>
          <select id="sortSelect" class="custom-select" style="padding: 6px 12px; border-radius: 6px; border: 1px solid #CBD5E1; font-size: 13px;">
            <option value="featured">Featured</option>
            <option value="price-asc">Price: Low to High</option>
            <option value="price-desc">Price: High to Low</option>
            <option value="name">Name: A to Z</option>
          </select>
        </div>
      </div>

      <!-- Product Cards Grid -->
      <div class="product-cards-grid" id="productGrid" aria-live="polite"></div>

    </div>
  </main>

  <?php include __DIR__ . '/includes/quickview-modal.php'; ?>
  <?php include __DIR__ . '/includes/cart-drawer.php'; ?>
  <?php include __DIR__ . '/includes/footer.php'; ?>

  <script src="js/header.js"></script>
  <script src="js/products.js"></script>
  <script src="js/catalog.js"></script>
  <script>
    function handleSearchType(val) {
      if (window.MVGHub && document.getElementById('mvgSearchInput')) {
        document.getElementById('mvgSearchInput').value = val;
        const event = new Event('input', { bubbles: true });
        document.getElementById('mvgSearchInput').dispatchEvent(event);
      }
    }

    document.addEventListener('DOMContentLoaded', () => {
      const q = "<?php echo addslashes($q); ?>";
      if (q && window.MVGHub) {
        handleSearchType(q);
      }
    });
  </script>
</body>
</html>

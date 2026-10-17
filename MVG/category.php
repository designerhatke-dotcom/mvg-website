<?php
/**
 * MVG Power Solutions — Category Product Catalog Page
 * Built with the high-performance catalog design: Dark Slate Hero Header,
 * Filter Rail, 18% GST toggle, Sorting, and Dynamic Product Cards Grid.
 */

require_once __DIR__ . '/config/constants.php';
require_once __DIR__ . '/config/db.php';

// Detect selected category slug
$selectedCategory = trim($_GET['slug'] ?? $_GET['category'] ?? $_GET['collection'] ?? 'all');

// Fetch categories from Database / JSON
$allCategories = Database::getCategories();
$parentCategories = [];
$subCategoriesByParent = [];
$categoryBySlug = [];

foreach ($allCategories as $c) {
    $categoryBySlug[$c['slug']] = $c;
    $pId = intval($c['parent'] ?? ($c['parent_id'] ?? 0));
    if ($pId === 0) {
        $parentCategories[] = $c;
    } else {
        $subCategoriesByParent[$pId][] = $c;
    }
}

// Current Category Data
$currentCategoryData = $categoryBySlug[$selectedCategory] ?? null;

if ($currentCategoryData) {
    $pageHeading = $currentCategoryData['name'];
    $pageDesc = !empty($currentCategoryData['description']) 
        ? $currentCategoryData['description'] 
        : 'Explore certified Class 1.0 & Class 0.5 ' . $currentCategoryData['name'] . ' units for electrical switchboards, LT panels, and energy management systems.';
    $pageTitle = $pageHeading . " | " . SITE_NAME;
    $currentParentId = $currentCategoryData['id'];
} elseif ($selectedCategory === 'all') {
    $pageHeading = 'All Current Transformers';
    $pageDesc = 'Explore certified Class 1.0 & Class 0.5 Current Transformers across Encapsulated Square, Encapsulated Ring, Tape Wound, Resin Cast, and Split Core geometries designed for panel builders, switchgear manufacturers, and industrial metering.';
    $pageTitle = "All Current Transformers | " . SITE_NAME;
    $currentParentId = 0;
} else {
    // Fallback format
    $cleanName = ucwords(str_replace('-', ' ', $selectedCategory));
    $pageHeading = $cleanName;
    $pageDesc = 'Precision Current Transformers (Class 1.0 & 0.5) manufactured factory-direct by MVG Power Solutions with 18% GST Input Tax Credit.';
    $pageTitle = $pageHeading . " | " . SITE_NAME;
    $currentParentId = 0;
}

// Subcategories for current category if any
$activeSubCats = ($currentParentId > 0 && isset($subCategoriesByParent[$currentParentId])) 
    ? $subCategoriesByParent[$currentParentId] 
    : [];
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title><?php echo htmlspecialchars($pageTitle); ?></title>
  <meta name="description" content="<?php echo htmlspecialchars(substr($pageDesc, 0, 160)); ?>" />
  <link rel="canonical" href="<?php echo htmlspecialchars(SITE_URL); ?>/category.php?slug=<?php echo htmlspecialchars($selectedCategory); ?>" />

  <!-- Inter Font -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">

  <!-- Main Stylesheet -->
  <link rel="stylesheet" href="css/style.css">
  <style>
    .subcat-pills-wrap {
      display: flex;
      flex-wrap: wrap;
      gap: 8px;
      margin-top: 14px;
    }
    .subcat-pill {
      display: inline-flex;
      align-items: center;
      gap: 5px;
      padding: 5px 12px;
      border-radius: 9999px;
      background: rgba(255, 255, 255, 0.12);
      color: #F1F5F9;
      font-size: 12px;
      font-weight: 600;
      text-decoration: none;
      border: 1px solid rgba(255, 255, 255, 0.2);
      transition: all 0.2s ease;
    }
    .subcat-pill:hover {
      background: var(--mvg-brand);
      border-color: var(--mvg-brand);
      color: #ffffff;
      transform: translateY(-1px);
    }
  </style>
</head>
<body>

  <!-- Modular Site Header -->
  <header class="mvg-site-header">
    <?php include __DIR__ . '/includes/header.php'; ?>
  </header>

  <!-- Category Hero Header & Breadcrumbs (#0F172A Dark Slate Background) -->
  <section class="category-hero-section">
    <div class="mvg-header-container">
      <nav class="breadcrumb-trail" aria-label="Breadcrumb">
        <a href="index.php">Home</a>
        <span class="sep">›</span>
        <a href="collections.php">Collections</a>
        <span class="sep">›</span>
        <span class="current"><?php echo htmlspecialchars($pageHeading); ?></span>
      </nav>
      <div class="category-hero-content">
        <h1 class="category-hero-title" id="categoryHeroTitle"><?php echo htmlspecialchars($pageHeading); ?></h1>
        <p class="category-hero-desc" id="categoryHeroDesc">
          <?php echo htmlspecialchars($pageDesc); ?>
        </p>

        <?php if (!empty($activeSubCats)): ?>
          <div class="subcat-pills-wrap">
            <span style="font-size: 12px; color: #94A3B8; display: inline-flex; align-items: center; font-weight: 700; text-transform: uppercase; letter-spacing: 0.5px;">Standard Apertures &amp; Ratios:</span>
            <?php foreach ($activeSubCats as $sc): ?>
              <button type="button" class="subcat-pill" onclick="if(window.MVGHub){window.MVGHub.setCategory('<?php echo htmlspecialchars($selectedCategory); ?>');}">
                ↳ <?php echo htmlspecialchars($sc['name']); ?>
              </button>
            <?php endforeach; ?>
          </div>
        <?php endif; ?>
      </div>
    </div>
  </section>

  <!-- Catalog Section & Filter Rail -->
  <main class="catalog-section" id="catalogMain">
    <div class="mvg-header-container catalog-layout">
      
      <!-- Left Filter Rail -->
      <aside class="catalog-sidebar">
        <div class="sidebar-sticky">
          
          <!-- Category Filter Group -->
          <div class="filter-group">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px;">
              <h4 class="filter-title" style="margin: 0;">
                <span>Categories</span>
              </h4>
              <a href="collections.php" style="font-size: 11.5px; color: var(--mvg-brand); text-decoration: none; font-weight: 700;">View All Collections ↗</a>
            </div>
            
            <ul class="category-menu" id="categoryFilterList">
              <li>
                <button type="button" class="cat-btn <?php echo ($selectedCategory === 'all') ? 'active' : ''; ?>" data-category="all" onclick="window.location.href='category.php?slug=all'">
                  <span>All Current Transformers</span>
                  <span class="cat-count" id="countAll">40</span>
                </button>
              </li>
              <?php foreach ($parentCategories as $pCat): ?>
                <?php $isActive = ($selectedCategory === $pCat['slug']); ?>
                <li>
                  <button type="button" class="cat-btn <?php echo $isActive ? 'active' : ''; ?>" data-category="<?php echo htmlspecialchars($pCat['slug']); ?>" onclick="window.location.href='category.php?slug=<?php echo htmlspecialchars($pCat['slug']); ?>'">
                    <span><?php echo htmlspecialchars($pCat['name']); ?></span>
                    <span class="cat-count"><?php echo ($pCat['slug'] === 'encapsulated-square-ct') ? '16' : (($pCat['slug'] === 'encapsulated-ring-ct') ? '24' : 'RFQ'); ?></span>
                  </button>
                </li>
              <?php endforeach; ?>
            </ul>
          </div>

          <!-- Direct Factory Support Card -->
          <div class="sidebar-help-card">
            <span class="help-badge">DIRECT FACTORY SUPPORT</span>
            <h5>Can’t find your ratio/size?</h5>
            <p>MVG manufactures custom primary currents (30A–4000A), 1A secondary outputs, and bespoke busbar windows.</p>
            <a href="https://wa.me/<?php echo htmlspecialchars(WHATSAPP_NUMBER); ?>?text=Hello%20MVG%20Power%20Solutions,%20I%20have%20an%20inquiry%20regarding%20<?php echo urlencode($pageHeading); ?>." target="_blank" rel="noopener" class="btn btn-outline w-full" style="background: rgba(255,255,255,0.1); border-color: rgba(255,255,255,0.3); color: #ffffff;">
              💬 Custom CT Request
            </a>
          </div>

        </div>
      </aside>

      <!-- Right Catalog Main Area -->
      <div class="catalog-main">

        <!-- Catalog Toolbar -->
        <div class="catalog-toolbar">
          <div class="toolbar-info">
            <h2 class="section-heading" id="sectionHeading"><?php echo htmlspecialchars($pageHeading); ?></h2>
            <span class="results-badge" id="resultsCount">Showing products</span>
          </div>

          <div class="toolbar-controls">
            <!-- 18% GST Input Tax Credit Switch -->
            <div class="gst-toggle-control">
              <span class="gst-label-text">18% GST:</span>
              <label class="switch-control" title="Toggle 18% GST calculation">
                <input type="checkbox" id="gstToggleCheck" />
                <span class="slider"></span>
              </label>
            </div>

            <!-- Sort dropdown -->
            <div class="sort-wrap">
              <label for="sortSelect">Sort:</label>
              <select id="sortSelect" class="custom-select">
                <option value="featured">Featured</option>
                <option value="price-asc">Price: Low to High</option>
                <option value="price-desc">Price: High to Low</option>
                <option value="name">Name: A to Z</option>
              </select>
            </div>
          </div>
        </div>

        <!-- Active Filter Tags Row -->
        <div class="active-tags-row" id="activeTagsRow" style="display:none;">
          <span class="tags-label">Filters:</span>
          <div class="tags-container" id="tagsContainer"></div>
          <button type="button" class="btn-clear-filters" id="clearAllFiltersBtn">Reset</button>
        </div>

        <!-- Product Cards Grid -->
        <div class="product-cards-grid" id="productGrid" aria-live="polite">
          <!-- Rendered dynamically by js/catalog.js using MVG_PRODUCTS -->
        </div>

      </div>

    </div>
  </main>

  <!-- Modular Modals & Slide-Over Drawer -->
  <?php include __DIR__ . '/includes/quickview-modal.php'; ?>
  <?php include __DIR__ . '/includes/cart-drawer.php'; ?>

  <!-- Modular Site Footer -->
  <?php include __DIR__ . '/includes/footer.php'; ?>

  <!-- Scripts -->
  <script src="js/header.js"></script>
  <script src="js/products.js"></script>
  <script src="js/catalog.js"></script>
</body>
</html>

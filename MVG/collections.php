<?php
/**
 * MVG Power Solutions — Product Collections & Catalog Page
 */
require_once __DIR__ . '/config/constants.php';
require_once __DIR__ . '/config/db.php';

$selectedCategory = $_GET['collection'] ?? $_GET['category'] ?? 'all';

$categoryTitles = [
    'all'                        => 'Current Transformer Collections',
    'encapsulated-square-ct'     => 'Encapsulated Square CTs',
    'encapsulated-ring-ct'       => 'Encapsulated Ring CTs',
    'tape-wound-ring-ct'         => 'Tape Wound Ring CTs',
    'resin-cast-rectangular-ct'  => 'Resin Cast Rectangular CTs',
    'resin-cast-ring-ct'         => 'Resin Cast Ring CTs',
    'split-core-ct'              => 'Split Core CTs'
];

$pageHeading = $categoryTitles[$selectedCategory] ?? 'Current Transformer Collections';
$pageTitle = $pageHeading . " | " . SITE_NAME;
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title><?php echo htmlspecialchars($pageTitle); ?></title>
  <meta name="description" content="MVG Power Solutions: Precision Current Transformers (Class 1.0 & 0.5) for industrial switchboards, control panels, and energy metering." />

  <!-- Inter Font -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">

  <!-- Main Stylesheet -->
  <link rel="stylesheet" href="css/style.css">
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
        <span class="current">Current Transformer Collections</span>
      </nav>
      <div class="category-hero-content">
        <h1 class="category-hero-title" id="categoryHeroTitle"><?php echo htmlspecialchars($pageHeading); ?></h1>
        <p class="category-hero-desc" id="categoryHeroDesc">
          Explore certified Class 1.0 &amp; Class 0.5 Current Transformers across Encapsulated Square, Encapsulated Ring, Tape Wound, Resin Cast, and Split Core geometries designed for panel builders, switchgear manufacturers, and industrial metering.
        </p>
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
            <h4 class="filter-title">
              <span>Collections</span>
            </h4>
            <ul class="category-menu" id="categoryFilterList">
              <li>
                <button type="button" class="cat-btn <?php echo ($selectedCategory === 'all') ? 'active' : ''; ?>" data-category="all">
                  <span>All Current Transformers</span>
                  <span class="cat-count" id="countAll">40</span>
                </button>
              </li>
              <li>
                <button type="button" class="cat-btn <?php echo ($selectedCategory === 'encapsulated-square-ct') ? 'active' : ''; ?>" data-category="encapsulated-square-ct">
                  <span>Encapsulated Square CT</span>
                  <span class="cat-count">16</span>
                </button>
              </li>
              <li>
                <button type="button" class="cat-btn <?php echo ($selectedCategory === 'encapsulated-ring-ct') ? 'active' : ''; ?>" data-category="encapsulated-ring-ct">
                  <span>Encapsulated Ring CT</span>
                  <span class="cat-count">24</span>
                </button>
              </li>
              <li>
                <button type="button" class="cat-btn <?php echo ($selectedCategory === 'tape-wound-ring-ct') ? 'active' : ''; ?>" data-category="tape-wound-ring-ct">
                  <span>Tape Wound Ring CT</span>
                  <span class="cat-count">RFQ</span>
                </button>
              </li>
              <li>
                <button type="button" class="cat-btn <?php echo ($selectedCategory === 'resin-cast-rectangular-ct') ? 'active' : ''; ?>" data-category="resin-cast-rectangular-ct">
                  <span>Resin Cast Rectangular CT</span>
                  <span class="cat-count">RFQ</span>
                </button>
              </li>
              <li>
                <button type="button" class="cat-btn <?php echo ($selectedCategory === 'resin-cast-ring-ct') ? 'active' : ''; ?>" data-category="resin-cast-ring-ct">
                  <span>Resin Cast Ring CT</span>
                  <span class="cat-count">RFQ</span>
                </button>
              </li>
              <li>
                <button type="button" class="cat-btn <?php echo ($selectedCategory === 'split-core-ct') ? 'active' : ''; ?>" data-category="split-core-ct">
                  <span>Split Core CT</span>
                  <span class="cat-count">RFQ</span>
                </button>
              </li>
            </ul>
          </div>

          <!-- Direct Factory Support Card -->
          <div class="sidebar-help-card">
            <span class="help-badge">DIRECT FACTORY SUPPORT</span>
            <h5>Can’t find your ratio/size?</h5>
            <p>MVG manufactures custom primary currents (30A–4000A), 1A secondary outputs, and bespoke busbar windows.</p>
            <a href="https://wa.me/<?php echo htmlspecialchars(WHATSAPP_NUMBER); ?>?text=Hello%20MVG%20Power%20Solutions,%20I%20need%20a%20custom%20CT%20inquiry." target="_blank" rel="noopener" class="btn btn-outline w-full" style="background: rgba(255,255,255,0.1); border-color: rgba(255,255,255,0.3); color: #ffffff;">
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
            <span class="results-badge" id="resultsCount">Showing 40 products</span>
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

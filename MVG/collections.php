<?php
/**
 * MVG Power Solutions — Product Collections & Catalog Page
 */
require_once __DIR__ . '/config/constants.php';
require_once __DIR__ . '/config/db.php';
require_once __DIR__ . '/config/settings.php';

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
$pageDesc = "Explore certified Class 1.0 & Class 0.5 Current Transformers across Encapsulated Square, Encapsulated Ring, Tape Wound, Resin Cast, and Split Core geometries designed for panel builders, switchgear manufacturers, and industrial metering.";
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title><?php echo htmlspecialchars($pageTitle); ?></title>
  <meta name="description" content="<?php echo htmlspecialchars($pageDesc); ?>" />
  <link rel="canonical" href="<?php echo htmlspecialchars(SITE_URL); ?>/collections.php" />

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
          <?php echo htmlspecialchars($pageDesc); ?>
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

        <!-- Product Cards Grid (Pre-rendered for high speed & SEO, dynamically filtered by catalog.js) -->
        <div class="product-cards-grid" id="productGrid" aria-live="polite">
          <?php 
            $initialProducts = Database::getProducts($selectedCategory === 'all' ? null : $selectedCategory);
            foreach ($initialProducts as $p):
              $pId = $p['id'];
              $pName = htmlspecialchars($p['name']);
              $pImg = htmlspecialchars($p['image']);
              $pCatName = htmlspecialchars($p['categoryName']);
              $pPrice = floatval($p['price']);
              $pMinQty = intval($p['minQty'] ?? 10);
          ?>
            <article class="product-card" data-product-id="<?php echo $pId; ?>">
              <div class="product-thumb-wrap" onclick="window.location.href='product.php?id=<?php echo $pId; ?>'" title="Click to view full specifications">
                <img src="<?php echo $pImg; ?>" alt="<?php echo $pName; ?>" loading="lazy" />
                <button type="button" class="quick-view-overlay-btn" onclick="event.stopPropagation(); if(window.MVGHub){window.MVGHub.openQuickView(<?php echo $pId; ?>);}">Quick Specs</button>
              </div>
              <div class="card-meta-row">
                <span class="card-category-tag"><?php echo $pCatName; ?></span>
                <span class="card-sku-tag">Class 1.0</span>
              </div>
              <h3 class="card-title" title="<?php echo $pName; ?>">
                <a href="product.php?id=<?php echo $pId; ?>" style="color: inherit; text-decoration: none;"><?php echo $pName; ?></a>
              </h3>
              <div class="card-price-container">
                <div class="price-main-row">
                  <span class="price-retail-label">Price:</span>
                  <span class="price-number">₹<?php echo number_format($pPrice, 0); ?></span>
                </div>
                <div class="card-wholesale-tier-row">
                  <span class="tier-label-sm">Min. Qty:</span>
                  <span class="tier-price-sm"><?php echo $pMinQty; ?> Pcs</span>
                </div>
              </div>
              <div class="card-actions">
                <div class="qty-stepper">
                  <button type="button" class="stepper-btn" onclick="if(window.MVGHub){window.MVGHub.updateCardQty(<?php echo $pId; ?>, -1);}" aria-label="Decrease quantity by 1">−</button>
                  <input 
                    type="number" 
                    class="qty-input" 
                    id="qty-input-<?php echo $pId; ?>" 
                    value="<?php echo $pMinQty; ?>" 
                    min="<?php echo $pMinQty; ?>" 
                    step="1"
                    aria-label="Quantity for <?php echo $pName; ?>"
                    oninput="if(window.MVGHub){window.MVGHub.handleCardQtyInput(<?php echo $pId; ?>, this);}"
                    onblur="if(window.MVGHub){window.MVGHub.handleCardQtyBlur(<?php echo $pId; ?>, this);}"
                  />
                  <button type="button" class="stepper-btn" onclick="if(window.MVGHub){window.MVGHub.updateCardQty(<?php echo $pId; ?>, 1);}" aria-label="Increase quantity by 1">+</button>
                </div>
                <button type="button" class="btn btn-primary btn-sm" onclick="if(window.MVGHub){window.MVGHub.addToCartFromCard(<?php echo $pId; ?>);}">
                  Add to Cart
                </button>
              </div>
            </article>
          <?php endforeach; ?>
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

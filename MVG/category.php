<?php
/**
 * MVG Power Solutions — Category & Subcategory Catalog Page
 * Designed with the exact same visual architecture, hero header, card grid,
 * and B2B wholesale assurance styling as the Collections page.
 */

require_once __DIR__ . '/config/constants.php';
require_once __DIR__ . '/config/db.php';
require_once __DIR__ . '/config/settings.php';

// Detect selected category slug
$selectedCategory = trim($_GET['slug'] ?? $_GET['category'] ?? $_GET['collection'] ?? 'all');

// Normalize aliases (e.g. ring-current-transformers -> encapsulated-ring-ct)
if ($selectedCategory === 'ring-current-transformers' || $selectedCategory === 'ring-ct') {
    $selectedCategory = 'encapsulated-ring-ct';
} elseif ($selectedCategory === 'square-current-transformers' || $selectedCategory === 'square-ct') {
    $selectedCategory = 'encapsulated-square-ct';
} elseif ($selectedCategory === 'current-transformers' || $selectedCategory === 'collections') {
    $selectedCategory = 'all';
}

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
    $isSubCategory = intval($currentCategoryData['parent'] ?? 0) > 0;
} elseif ($selectedCategory === 'all') {
    $pageHeading = 'All Current Transformers';
    $pageDesc = 'Explore certified Class 1.0 & Class 0.5 Current Transformers across Encapsulated Square, Encapsulated Ring, Tape Wound, Resin Cast, and Split Core geometries designed for panel builders, switchgear manufacturers, and industrial metering.';
    $pageTitle = "All Current Transformers | " . SITE_NAME;
    $currentParentId = 0;
    $isSubCategory = false;
} else {
    // Fallback format
    $cleanName = ucwords(str_replace('-', ' ', $selectedCategory));
    $pageHeading = $cleanName;
    $pageDesc = 'Precision Current Transformers (Class 1.0 & 0.5) manufactured factory-direct by MVG Power Solutions with 18% GST Input Tax Credit.';
    $pageTitle = $pageHeading . " | " . SITE_NAME;
    $currentParentId = 0;
    $isSubCategory = false;
}

// Subcategories for current category if any
$activeSubCats = ($currentParentId > 0 && isset($subCategoriesByParent[$currentParentId])) 
    ? $subCategoriesByParent[$currentParentId] 
    : [];

// If this is itself a subcategory, find sibling subcategories
if ($isSubCategory) {
    $parentOfSub = intval($currentCategoryData['parent']);
    $activeSubCats = $subCategoriesByParent[$parentOfSub] ?? [];
}
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
    /* Collections Page Matching Design System */
    .collections-hub-hero {
      background: linear-gradient(135deg, #0F172A 0%, #1E293B 100%);
      color: #ffffff;
      padding: 56px 0 64px 0;
      border-bottom: 1px solid rgba(255, 255, 255, 0.1);
      position: relative;
      overflow: hidden;
    }
    .collections-hub-hero::before {
      content: '';
      position: absolute;
      top: -50%;
      right: -10%;
      width: 500px;
      height: 500px;
      background: radial-gradient(circle, rgba(2, 132, 199, 0.15) 0%, transparent 70%);
      pointer-events: none;
    }
    .collection-hero-badge {
      display: inline-flex;
      align-items: center;
      gap: 7px;
      padding: 6px 14px;
      background: rgba(2, 132, 199, 0.2);
      border: 1px solid rgba(2, 132, 199, 0.4);
      color: #38BDF8;
      border-radius: 9999px;
      font-size: 11.5px;
      font-weight: 800;
      letter-spacing: 0.6px;
      text-transform: uppercase;
      margin-bottom: 16px;
    }
    .collection-hero-h1 {
      font-size: 38px;
      font-weight: 900;
      color: #FFFFFF;
      letter-spacing: -0.6px;
      line-height: 1.2;
      margin-bottom: 14px;
    }
    .collection-hero-lead {
      font-size: 16px;
      color: #94A3B8;
      max-width: 820px;
      line-height: 1.65;
      margin: 0;
    }

    /* Subcategory Pills */
    .subcat-pills-wrap {
      display: flex;
      flex-wrap: wrap;
      gap: 8px;
      margin-top: 18px;
    }
    .subcat-pill {
      display: inline-flex;
      align-items: center;
      gap: 6px;
      padding: 6px 14px;
      border-radius: 9999px;
      background: rgba(255, 255, 255, 0.12);
      color: #F1F5F9;
      font-size: 12.5px;
      font-weight: 600;
      text-decoration: none;
      border: 1px solid rgba(255, 255, 255, 0.2);
      transition: all 0.2s ease;
      cursor: pointer;
    }
    .subcat-pill:hover, .subcat-pill.active {
      background: var(--mvg-brand);
      border-color: var(--mvg-brand);
      color: #ffffff;
      transform: translateY(-1px);
    }

    /* Collections Section Layout */
    .collections-grid-section {
      padding: 50px 0 80px 0;
      background-color: #F8FAFC;
    }
    .collections-card-grid {
      display: grid;
      grid-template-columns: repeat(3, 1fr);
      gap: 26px;
    }
    @media (max-width: 1024px) {
      .collections-card-grid {
        grid-template-columns: repeat(2, 1fr);
      }
    }
    @media (max-width: 640px) {
      .collections-card-grid {
        grid-template-columns: 1fr;
        gap: 20px;
      }
      .collection-hero-h1 {
        font-size: 28px;
      }
    }

    /* Enhanced Category Hub Card */
    .hub-category-card {
      background: #FFFFFF;
      border: 1px solid #E2E8F0;
      border-radius: 16px;
      overflow: hidden;
      display: flex;
      flex-direction: column;
      box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05), 0 2px 4px -2px rgba(0, 0, 0, 0.05);
      transition: all 0.28s cubic-bezier(0.16, 1, 0.3, 1);
      position: relative;
      text-decoration: none;
    }
    .hub-category-card:hover {
      transform: translateY(-6px);
      box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 8px 10px -6px rgba(0, 0, 0, 0.06);
      border-color: var(--mvg-brand);
    }
    .hub-cat-media {
      position: relative;
      width: 100%;
      height: 220px;
      background-color: #F1F5F9;
      display: flex;
      align-items: center;
      justify-content: center;
      overflow: hidden;
      border-bottom: 1px solid #E2E8F0;
      padding: 24px;
    }
    .hub-cat-media img {
      max-width: 100%;
      max-height: 100%;
      object-fit: contain;
      transition: transform 0.35s ease;
    }
    .hub-category-card:hover .hub-cat-media img {
      transform: scale(1.08);
    }
    .hub-status-badge {
      position: absolute;
      top: 14px;
      right: 14px;
      background: #FFFFFF;
      border: 1px solid #E2E8F0;
      font-size: 11px;
      font-weight: 800;
      color: #0F172A;
      padding: 4px 10px;
      border-radius: 9999px;
      box-shadow: 0 2px 4px rgba(0,0,0,0.06);
    }
    .hub-cat-content {
      padding: 22px;
      display: flex;
      flex-direction: column;
      flex: 1;
    }
    .hub-cat-title {
      font-size: 17.5px;
      font-weight: 800;
      color: #0F172A;
      margin-bottom: 8px;
      line-height: 1.3;
      transition: color 0.2s ease;
    }
    .hub-category-card:hover .hub-cat-title {
      color: var(--mvg-brand);
    }
    .hub-cat-desc {
      font-size: 13px;
      color: #64748B;
      line-height: 1.55;
      margin-bottom: 16px;
      flex: 1;
    }
    .hub-cat-cta {
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding-top: 14px;
      border-top: 1px solid #F1F5F9;
      color: var(--mvg-brand);
      font-size: 13.5px;
      font-weight: 700;
    }
    .hub-cat-cta-icon {
      width: 28px;
      height: 28px;
      border-radius: 50%;
      background: var(--mvg-brand-lt);
      display: flex;
      align-items: center;
      justify-content: center;
      transition: all 0.2s ease;
    }
    .hub-category-card:hover .hub-cat-cta-icon {
      background: var(--mvg-brand);
      color: #ffffff;
      transform: translateX(4px);
    }

    /* Wholesale Benefit Banner */
    .b2b-wholesale-strip {
      background: #FFFFFF;
      border: 1px solid #E2E8F0;
      border-radius: 16px;
      padding: 30px;
      margin-top: 48px;
      display: grid;
      grid-template-columns: repeat(4, 1fr);
      gap: 24px;
      box-shadow: 0 4px 6px -1px rgba(0,0,0,0.03);
    }
    @media (max-width: 900px) {
      .b2b-wholesale-strip {
        grid-template-columns: repeat(2, 1fr);
      }
    }
    @media (max-width: 500px) {
      .b2b-wholesale-strip {
        grid-template-columns: 1fr;
      }
    }
    .benefit-item {
      display: flex;
      align-items: flex-start;
      gap: 14px;
    }
    .benefit-icon {
      width: 44px;
      height: 44px;
      border-radius: 10px;
      background: #F0F9FF;
      color: var(--mvg-brand);
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 20px;
      flex-shrink: 0;
    }
    .benefit-title {
      font-size: 14px;
      font-weight: 800;
      color: #0F172A;
      margin-bottom: 4px;
    }
    .benefit-sub {
      font-size: 12.5px;
      color: #64748B;
      line-height: 1.45;
      margin: 0;
    }
    .section-divider-line {
      display: flex;
      align-items: center;
      justify-content: space-between;
      margin: 40px 0 24px 0;
      padding-bottom: 12px;
      border-bottom: 2px solid #E2E8F0;
    }
    .section-divider-line h3 {
      font-size: 22px;
      font-weight: 900;
      color: #0F172A;
      margin: 0;
      display: flex;
      align-items: center;
      gap: 8px;
    }
  </style>
</head>
<body>

  <!-- Modular Site Header -->
  <header class="mvg-site-header">
    <?php include __DIR__ . '/includes/header.php'; ?>
  </header>

  <!-- Hero Header (#0F172A Dark Slate Background) -->
  <section class="collections-hub-hero">
    <div class="mvg-header-container">
      <nav class="breadcrumb-trail" aria-label="Breadcrumb">
        <a href="index.php">Home</a>
        <span class="sep">›</span>
        <a href="collections.php">Collections</a>
        <span class="sep">›</span>
        <span class="current"><?php echo htmlspecialchars($pageHeading); ?></span>
      </nav>

      <div style="margin-top: 12px;">
        <span class="collection-hero-badge">⚡ CERTIFIED INDUSTRIAL PORTFOLIO</span>
        <h1 class="collection-hero-h1"><?php echo htmlspecialchars($pageHeading); ?></h1>
        <p class="collection-hero-lead">
          <?php echo htmlspecialchars($pageDesc); ?>
        </p>

        <!-- Subcategory Quick Filter Pills -->
        <?php if (!empty($activeSubCats)): ?>
          <div class="subcat-pills-wrap">
            <span style="font-size: 12px; color: #94A3B8; display: inline-flex; align-items: center; font-weight: 700; text-transform: uppercase; letter-spacing: 0.5px;">Standard Apertures &amp; Windows:</span>
            <?php foreach ($activeSubCats as $sc): ?>
              <?php $isPillActive = ($selectedCategory === $sc['slug']); ?>
              <a href="category.php?slug=<?php echo htmlspecialchars($sc['slug']); ?>" class="subcat-pill <?php echo $isPillActive ? 'active' : ''; ?>">
                ↳ <?php echo htmlspecialchars($sc['name']); ?>
              </a>
            <?php endforeach; ?>
          </div>
        <?php endif; ?>
      </div>
    </div>
  </section>

  <!-- Main Content Section: Subcategory Cards Grid + Catalog Products Grid -->
  <main class="collections-grid-section">
    <div class="mvg-header-container">

      <!-- SUB-CATEGORIES SECTION: Rendered with identical Card Grid Design as Collections Page -->
      <?php if (!empty($activeSubCats) && !$isSubCategory): ?>
        <div class="section-divider-line">
          <h3>
            <span>📁 Aperture Sizes &amp; Sub-Categories</span>
          </h3>
          <span style="font-size: 13px; color: var(--text-muted); font-weight: 600;">
            <?php echo count($activeSubCats); ?> Aperture Formats Available
          </span>
        </div>

        <div class="collections-card-grid" style="margin-bottom: 48px;">
          <?php foreach ($activeSubCats as $sCat): ?>
            <?php 
              $sImg = htmlspecialchars($sCat['image'] ?? 'assets/categories/encapsulated-ring-ct.jpg');
            ?>
            <a href="category.php?slug=<?php echo htmlspecialchars($sCat['slug']); ?>" class="hub-category-card" title="Browse <?php echo htmlspecialchars($sCat['name']); ?>">
              <div class="hub-cat-media">
                <span class="hub-status-badge">Class 1.0 / 0.5</span>
                <img 
                  src="<?php echo $sImg; ?>" 
                  alt="<?php echo htmlspecialchars($sCat['name']); ?>" 
                  loading="lazy" 
                  onerror="this.src='assets/categories/encapsulated-ring-ct.jpg'"
                />
              </div>

              <div class="hub-cat-content">
                <h4 class="hub-cat-title"><?php echo htmlspecialchars($sCat['name']); ?></h4>
                <p class="hub-cat-desc">
                  <?php echo htmlspecialchars($sCat['description'] ?? 'Precision metering current transformer designed for LT switchboards and industrial control panels.'); ?>
                </p>

                <div class="hub-cat-cta">
                  <span>Explore <?php echo htmlspecialchars($sCat['name']); ?></span>
                  <span class="hub-cat-cta-icon" aria-hidden="true">&rarr;</span>
                </div>
              </div>
            </a>
          <?php endforeach; ?>
        </div>
      <?php endif; ?>

      <!-- PRODUCTS CATALOG SECTION -->
      <div class="section-divider-line">
        <h3>
          <span>⚡ Available Products</span>
        </h3>
        
        <!-- Controls: 18% GST Switch & Sort -->
        <div style="display: flex; align-items: center; gap: 16px;">
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
      </div>

      <!-- Active Filter Tags Row -->
      <div class="active-tags-row" id="activeTagsRow" style="display:none; margin-bottom: 20px;">
        <span class="tags-label">Filters:</span>
        <div class="tags-container" id="tagsContainer"></div>
        <button type="button" class="btn-clear-filters" id="clearAllFiltersBtn">Reset</button>
      </div>

      <!-- Product Cards Grid -->
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

      <!-- B2B Wholesale Assurance Strip (Identical to Collections Page) -->
      <div class="b2b-wholesale-strip">
        <div class="benefit-item">
          <div class="benefit-icon">🏭</div>
          <div>
            <div class="benefit-title">Factory-Direct Supply</div>
            <p class="benefit-sub">Direct manufacturer pricing with tiered wholesale rates for 10+, 50+, 100+ pcs.</p>
          </div>
        </div>

        <div class="benefit-item">
          <div class="benefit-icon">⚡</div>
          <div>
            <div class="benefit-title">Same-Day Dispatch</div>
            <p class="benefit-sub">Delhi NCR warehouse hub dispatching standard CT models within 24 hours.</p>
          </div>
        </div>

        <div class="benefit-item">
          <div class="benefit-icon">🧾</div>
          <div>
            <div class="benefit-title">18% GST Tax Credit</div>
            <p class="benefit-sub">Full B2B tax invoice provided with immediate Input Tax Credit (ITC) eligibility.</p>
          </div>
        </div>

        <div class="benefit-item">
          <div class="benefit-icon">📐</div>
          <div>
            <div class="benefit-title">Custom CT Ratings</div>
            <p class="benefit-sub">Custom primary currents (30A–4000A), 1A secondary, and special busbar windows.</p>
          </div>
        </div>
      </div>

      <!-- Direct Engineering Support Banner -->
      <div style="background: linear-gradient(135deg, #0284C7 0%, #0369A1 100%); border-radius: 16px; padding: 32px 36px; margin-top: 36px; color: #ffffff; display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 20px;">
        <div style="max-width: 650px;">
          <h3 style="font-size: 20px; font-weight: 800; margin-bottom: 6px; color: #ffffff;">Need a custom current transformer specification?</h3>
          <p style="font-size: 14px; margin: 0; color: #E0F2FE; line-height: 1.5;">
            Our electrical engineering team designs custom CT solutions, dual ratios, non-standard burden ratings (2.5VA to 15VA), and special mounting requirements for OEMs.
          </p>
        </div>
        <div style="display: flex; gap: 12px; flex-wrap: wrap;">
          <a href="https://wa.me/<?php echo htmlspecialchars(WHATSAPP_NUMBER); ?>?text=Hello%20MVG%20Power%20Solutions,%20I%20have%20an%20inquiry%20regarding%20<?php echo urlencode($pageHeading); ?>." target="_blank" rel="noopener" class="btn" style="background: #FFFFFF; color: #0284C7; font-weight: 800; border: none; padding: 12px 22px; border-radius: 8px; text-decoration: none;">
            💬 WhatsApp Us
          </a>
          <a href="tel:<?php echo htmlspecialchars(CONTACT_PHONE_TEL); ?>" class="btn" style="background: rgba(255,255,255,0.15); color: #FFFFFF; border: 1px solid rgba(255,255,255,0.4); font-weight: 700; padding: 12px 20px; border-radius: 8px; text-decoration: none;">
            📞 Call Technical Desk
          </a>
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

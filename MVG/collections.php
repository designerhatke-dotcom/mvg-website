<?php
/**
 * MVG Power Solutions — Our Current Transformer Collection
 * Complete B2B Catalog & Collection Hub:
 * - Dark Slate Hero Header with Breadcrumbs & Category Aperture Pills
 * - Category Geometries Card Grid
 * - Dynamic Product Cards Grid with 18% GST Toggle & Sorting
 * - B2B Wholesale Assurance Strip & Direct Engineering Support Banner
 */

require_once __DIR__ . '/config/constants.php';
require_once __DIR__ . '/config/db.php';
require_once __DIR__ . '/config/settings.php';

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

// Active Filter Parameter (default to 'all')
$activeFilter = trim($_GET['slug'] ?? $_GET['category'] ?? $_GET['collection'] ?? 'all');
if (empty($activeFilter)) {
    $activeFilter = 'all';
}

$pageTitle = "Our Current Transformer Collection | " . SITE_NAME;
$pageDesc = "Explore certified Class 1.0 & Class 0.5 Current Transformers across Encapsulated Square, Ring, Tape Wound, Resin Cast, and Split Core geometries. Manufactured factory-direct with 18% GST Input Tax Credit for panel builders, OEMs, and industrial metering.";
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title><?php echo htmlspecialchars($pageTitle); ?></title>
  <meta name="description" content="<?php echo htmlspecialchars(substr($pageDesc, 0, 160)); ?>" />
  <link rel="canonical" href="<?php echo htmlspecialchars(SITE_URL); ?>/collections.php" />

  <!-- Inter Font -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">

  <!-- Main Stylesheet -->
  <link rel="stylesheet" href="css/style.css">
  <style>
    /* Collections Page Design System */
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

    /* Category Filter Pills */
    .subcat-pills-wrap {
      display: flex;
      flex-wrap: wrap;
      gap: 8px;
      margin-top: 22px;
    }
    .subcat-pill {
      display: inline-flex;
      align-items: center;
      gap: 6px;
      padding: 7px 15px;
      border-radius: 9999px;
      background: rgba(255, 255, 255, 0.12);
      color: #F1F5F9;
      font-size: 13px;
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
      box-shadow: 0 4px 12px rgba(2, 132, 199, 0.35);
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

    /* Category Hub Card */
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
    .hub-subcats-tags {
      display: flex;
      flex-wrap: wrap;
      gap: 6px;
      margin-bottom: 18px;
    }
    .hub-subcat-tag {
      font-size: 11px;
      font-weight: 700;
      background: #F1F5F9;
      color: #475569;
      padding: 3px 8px;
      border-radius: 6px;
      border: 1px solid #E2E8F0;
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

    /* Section Dividers */
    .section-divider-line {
      display: flex;
      align-items: center;
      justify-content: space-between;
      margin: 44px 0 24px 0;
      padding-bottom: 12px;
      border-bottom: 2px solid #E2E8F0;
      flex-wrap: wrap;
      gap: 12px;
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
        <span class="current">Our Current Transformer Collection</span>
      </nav>

      <div style="margin-top: 14px;">
        <span class="collection-hero-badge">⚡ CERTIFIED INDUSTRIAL PORTFOLIO</span>
        <h1 class="collection-hero-h1">Our Current Transformer Collection</h1>
        <p class="collection-hero-lead">
          Explore certified Class 1.0 &amp; Class 0.5 Current Transformers across Encapsulated Square, Ring, Tape Wound, Resin Cast, and Split Core geometries. Manufactured factory-direct with 18% GST Input Tax Credit for panel builders, OEMs, and utility metering.
        </p>

        <!-- Quick Filter Pills -->
        <div class="subcat-pills-wrap">
          <a href="collections.php" class="subcat-pill <?php echo ($activeFilter === 'all') ? 'active' : ''; ?>" onclick="if(window.MVGHub){event.preventDefault(); window.MVGHub.setCategory('all'); document.querySelectorAll('.subcat-pill').forEach(p => p.classList.remove('active')); this.classList.add('active');}">
            ⚡ All Collections (40 Products)
          </a>
          <a href="collections.php?category=encapsulated-square-ct" class="subcat-pill <?php echo ($activeFilter === 'encapsulated-square-ct') ? 'active' : ''; ?>" onclick="if(window.MVGHub){event.preventDefault(); window.MVGHub.setCategory('encapsulated-square-ct'); document.querySelectorAll('.subcat-pill').forEach(p => p.classList.remove('active')); this.classList.add('active');}">
            Square CT (16)
          </a>
          <a href="collections.php?category=encapsulated-ring-ct" class="subcat-pill <?php echo ($activeFilter === 'encapsulated-ring-ct') ? 'active' : ''; ?>" onclick="if(window.MVGHub){event.preventDefault(); window.MVGHub.setCategory('encapsulated-ring-ct'); document.querySelectorAll('.subcat-pill').forEach(p => p.classList.remove('active')); this.classList.add('active');}">
            Ring CT (24)
          </a>
          <a href="category.php?slug=tape-wound-ring-ct" class="subcat-pill">
            Tape Wound CT
          </a>
          <a href="category.php?slug=resin-cast-rectangular-ct" class="subcat-pill">
            Resin Cast Rectangular CT
          </a>
          <a href="category.php?slug=resin-cast-ring-ct" class="subcat-pill">
            Resin Cast Ring CT
          </a>
          <a href="category.php?slug=split-core-ct" class="subcat-pill">
            Split Core CT
          </a>
        </div>
      </div>
    </div>
  </section>

  <!-- Main Collections Grid Section -->
  <main class="collections-grid-section">
    <div class="mvg-header-container">

      <!-- 1. CATEGORY GEOMETRIES & FAMILIES -->
      <div class="section-divider-line">
        <h3>
          <span>📁 Transformer Geometries &amp; Series</span>
        </h3>
        <span style="font-size: 13.5px; color: var(--text-muted); font-weight: 600;">
          Select a category or browse all models below
        </span>
      </div>

      <!-- Category Cards Grid -->
      <div class="collections-card-grid">
        <?php foreach ($parentCategories as $pCat): ?>
          <?php 
            $catId = $pCat['id'];
            $subCats = $subCategoriesByParent[$catId] ?? [];
            $imgSrc = htmlspecialchars($pCat['image'] ?? 'assets/categories/encapsulated-ring-ct.jpg');
          ?>
          <a href="category.php?slug=<?php echo htmlspecialchars($pCat['slug']); ?>" class="hub-category-card" title="Browse <?php echo htmlspecialchars($pCat['name']); ?>">
            
            <div class="hub-cat-media">
              <span class="hub-status-badge">Class 1.0 / 0.5</span>
              <img 
                src="<?php echo $imgSrc; ?>" 
                alt="<?php echo htmlspecialchars($pCat['name']); ?>" 
                loading="lazy" 
                onerror="this.src='assets/categories/encapsulated-ring-ct.jpg'"
              />
            </div>

            <div class="hub-cat-content">
              <h2 class="hub-cat-title"><?php echo htmlspecialchars($pCat['name']); ?></h2>
              <p class="hub-cat-desc">
                <?php echo htmlspecialchars($pCat['description'] ?? 'Precision metering current transformer designed for LT switchboards and industrial control panels.'); ?>
              </p>

              <?php if (!empty($subCats)): ?>
                <div class="hub-subcats-tags">
                  <?php 
                    $previewSubs = array_slice($subCats, 0, 4);
                    foreach ($previewSubs as $ps): 
                  ?>
                    <span class="hub-subcat-tag"><?php echo htmlspecialchars($ps['name']); ?></span>
                  <?php endforeach; ?>
                  <?php if (count($subCats) > 4): ?>
                    <span class="hub-subcat-tag">+<?php echo (count($subCats) - 4); ?> more</span>
                  <?php endif; ?>
                </div>
              <?php endif; ?>

              <div class="hub-cat-cta">
                <span>View Products in Category</span>
                <span class="hub-cat-cta-icon" aria-hidden="true">&rarr;</span>
              </div>
            </div>

          </a>
        <?php endforeach; ?>
      </div>

      <!-- 2. FULL PRODUCT CATALOG SECTION -->
      <div class="section-divider-line" id="collectionProductsSection">
        <div>
          <h3 id="sectionHeading">
            <span>⚡ All Collection Products</span>
          </h3>
          <span class="results-badge" id="resultsCount" style="font-size: 13px; font-weight: 700; color: var(--mvg-brand); background: var(--mvg-brand-lt); padding: 3px 10px; border-radius: 6px; margin-top: 4px; display: inline-block;">
            Showing 40 products
          </span>
        </div>
        
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

      <!-- Dynamic Product Cards Grid -->
      <div class="product-cards-grid" id="productGrid" aria-live="polite">
        <?php 
          $initialProducts = Database::getProducts();
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

      <!-- 3. B2B WHOLESALE ASSURANCE STRIP -->
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

      <!-- 4. DIRECT ENGINEERING SUPPORT BANNER -->
      <div style="background: linear-gradient(135deg, #0284C7 0%, #0369A1 100%); border-radius: 16px; padding: 32px 36px; margin-top: 36px; color: #ffffff; display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 20px;">
        <div style="max-width: 650px;">
          <h3 style="font-size: 20px; font-weight: 800; margin-bottom: 6px; color: #ffffff;">Need a custom current transformer specification?</h3>
          <p style="font-size: 14px; margin: 0; color: #E0F2FE; line-height: 1.5;">
            Our electrical engineering team designs custom CT solutions, dual ratios, non-standard burden ratings (2.5VA to 15VA), and special mounting requirements for OEMs.
          </p>
        </div>
        <div style="display: flex; gap: 12px; flex-wrap: wrap;">
          <a href="https://wa.me/<?php echo htmlspecialchars(WHATSAPP_NUMBER); ?>?text=Hello%20MVG%20Power%20Solutions,%20I%20have%20an%20inquiry%20regarding%20Current%20Transformer%20Collection." target="_blank" rel="noopener" class="btn" style="background: #FFFFFF; color: #0284C7; font-weight: 800; border: none; padding: 12px 22px; border-radius: 8px; text-decoration: none;">
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

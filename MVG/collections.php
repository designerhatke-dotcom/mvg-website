<?php
/**
 * MVG Power Solutions — Collections Hub
 * Displays "Our Current Transformer Collection" with direct category family cards,
 * window apertures, specs, and navigation to dedicated category catalog pages.
 */

require_once __DIR__ . '/config/constants.php';
require_once __DIR__ . '/config/db.php';

// Redirect category-filtered requests directly to category.php
$reqCat = trim($_GET['slug'] ?? $_GET['category'] ?? $_GET['collection'] ?? '');
if (!empty($reqCat) && $reqCat !== 'all') {
    header("Location: category.php?slug=" . urlencode($reqCat), true, 301);
    exit;
}

// Fetch categories from Database / JSON
$allCategories = Database::getCategories();
$parentCategories = [];
$subCategoriesByParent = [];

foreach ($allCategories as $c) {
    $pId = intval($c['parent'] ?? ($c['parent_id'] ?? 0));
    if ($pId === 0) {
        $parentCategories[] = $c;
    } else {
        $subCategoriesByParent[$pId][] = $c;
    }
}

$pageTitle = "Our Current Transformer Collection | " . SITE_NAME;
$pageDesc = "Explore certified Class 1.0 & Class 0.5 Current Transformers across Encapsulated Square, Ring, Tape Wound, Resin Cast, and Split Core geometries. Manufactured factory-direct with 18% GST Input Tax Credit.";
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
  <style>
    /* Collections Page Specific Enhancements */
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

    /* Collections Section Layout */
    .collections-grid-section {
      padding: 60px 0 80px 0;
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
      height: 240px;
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
      font-size: 18px;
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
      font-size: 13.5px;
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
        <span class="current">Collections</span>
      </nav>

      <div style="margin-top: 12px;">
        <span class="collection-hero-badge">⚡ CERTIFIED INDUSTRIAL PORTFOLIO</span>
        <h1 class="collection-hero-h1">Our Current Transformer Collection</h1>
        <p class="collection-hero-lead">
          Explore certified Class 1.0 &amp; Class 0.5 Current Transformers across Encapsulated Square, Ring, Tape Wound, Resin Cast, and Split Core geometries. Manufactured factory-direct with 18% GST Input Tax Credit for panel builders, OEMs, and utility metering.
        </p>
      </div>
    </div>
  </section>

  <!-- Main Collections Grid Section -->
  <main class="collections-grid-section">
    <div class="mvg-header-container">

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

      <!-- B2B Wholesale Assurance Strip -->
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
          <a href="https://wa.me/<?php echo htmlspecialchars(WHATSAPP_NUMBER); ?>?text=Hello%20MVG%20Power%20Solutions,%20I%20have%20a%20custom%20CT%20requirement." target="_blank" rel="noopener" class="btn" style="background: #FFFFFF; color: #0284C7; font-weight: 800; border: none; padding: 12px 22px; border-radius: 8px; text-decoration: none;">
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
</body>
</html>

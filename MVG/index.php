<?php
/**
 * MVG Power Solutions — Homepage
 */
require_once __DIR__ . '/config/constants.php';
$pageTitle = SITE_NAME . " | Current Transformers & Digital Meters";
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title><?php echo htmlspecialchars($pageTitle); ?></title>
  
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

  <!-- Hero Banner Showcase -->
  <section class="mvg-hero-banner-section" aria-label="MVG Current Transformer Lineup">
    <div class="mvg-banner-container">
      <div class="mvg-banner-wrapper">
        <img 
          src="assets/banner.jpg" 
          alt="MVG Current Transformer - Precision, Reliability, Performance" 
          class="mvg-banner-img"
          width="1200" 
          height="400"
          loading="eager" 
          fetchpriority="high"
        >
      </div>
    </div>
  </section>

  <!-- Our Current Transformer Collection (4-Column Desktop / 2-Column Mobile) -->
  <section class="mvg-collection-section" aria-labelledby="collectionHeading">
    <div class="mvg-collection-container">
      
      <!-- Section Header -->
      <div class="mvg-collection-header">
        <h2 id="collectionHeading" class="mvg-collection-title">Our Current Transformer Collection</h2>
      </div>

      <!-- Category Cards Grid (6 Categories) -->
      <div class="mvg-categories-grid">

        <!-- Card 1: Encapsulated Square CT -->
        <a href="category.php?slug=encapsulated-square-ct" class="mvg-cat-card" title="Browse Encapsulated Square Current Transformers">
          <div class="mvg-cat-media">
            <img 
              src="assets/categories/encapsulated-square-ct.jpg" 
              alt="Encapsulated Square Current Transformer" 
              loading="lazy"
              width="300"
              height="300"
            >
          </div>
          <div class="mvg-cat-info">
            <h3 class="mvg-cat-name">Encapsulated Square CT</h3>
            <div class="mvg-cat-action">
              <span>View Products</span>
              <span class="mvg-cat-action-icon" aria-hidden="true">&rarr;</span>
            </div>
          </div>
        </a>

        <!-- Card 2: Encapsulated Ring CT -->
        <a href="category.php?slug=encapsulated-ring-ct" class="mvg-cat-card" title="Browse Encapsulated Ring Current Transformers">
          <div class="mvg-cat-media">
            <img 
              src="assets/categories/encapsulated-ring-ct.jpg" 
              alt="Encapsulated Ring Current Transformer" 
              loading="lazy"
              width="300"
              height="300"
            >
          </div>
          <div class="mvg-cat-info">
            <h3 class="mvg-cat-name">Encapsulated Ring CT</h3>
            <div class="mvg-cat-action">
              <span>View Products</span>
              <span class="mvg-cat-action-icon" aria-hidden="true">&rarr;</span>
            </div>
          </div>
        </a>

        <!-- Card 3: Tape Wound Ring CT -->
        <a href="category.php?slug=tape-wound-ring-ct" class="mvg-cat-card" title="Browse Tape Wound Ring Current Transformers">
          <div class="mvg-cat-media">
            <img 
              src="assets/categories/tape-wound-ring-ct.jpg" 
              alt="Tape Wound Ring Current Transformer" 
              loading="lazy"
              width="300"
              height="300"
            >
          </div>
          <div class="mvg-cat-info">
            <h3 class="mvg-cat-name">Tape Wound Ring CT</h3>
            <div class="mvg-cat-action">
              <span>View Products</span>
              <span class="mvg-cat-action-icon" aria-hidden="true">&rarr;</span>
            </div>
          </div>
        </a>

        <!-- Card 4: Resin Cast Rectangular CT -->
        <a href="category.php?slug=resin-cast-rectangular-ct" class="mvg-cat-card" title="Browse Resin Cast Rectangular Current Transformers">
          <div class="mvg-cat-media">
            <img 
              src="assets/categories/resin-cast-rectangular-ct.jpg" 
              alt="Resin Cast Rectangular Current Transformer" 
              loading="lazy"
              width="300"
              height="300"
            >
          </div>
          <div class="mvg-cat-info">
            <h3 class="mvg-cat-name">Resin Cast Rectangular CT</h3>
            <div class="mvg-cat-action">
              <span>View Products</span>
              <span class="mvg-cat-action-icon" aria-hidden="true">&rarr;</span>
            </div>
          </div>
        </a>

        <!-- Card 5: Resin Cast Ring CT -->
        <a href="category.php?slug=resin-cast-ring-ct" class="mvg-cat-card" title="Browse Resin Cast Ring Current Transformers">
          <div class="mvg-cat-media">
            <img 
              src="assets/categories/resin-cast-ring-ct.jpg" 
              alt="Resin Cast Ring Current Transformer" 
              loading="lazy"
              width="300"
              height="300"
            >
          </div>
          <div class="mvg-cat-info">
            <h3 class="mvg-cat-name">Resin Cast Ring CT</h3>
            <div class="mvg-cat-action">
              <span>View Products</span>
              <span class="mvg-cat-action-icon" aria-hidden="true">&rarr;</span>
            </div>
          </div>
        </a>

        <!-- Card 6: Split Core CT -->
        <a href="category.php?slug=split-core-ct" class="mvg-cat-card" title="Browse Split Core Current Transformers">
          <div class="mvg-cat-media">
            <img 
              src="assets/categories/split-core-ct.jpg" 
              alt="Split Core Current Transformer" 
              loading="lazy"
              width="300"
              height="300"
            >
          </div>
          <div class="mvg-cat-info">
            <h3 class="mvg-cat-name">Split Core CT</h3>
            <div class="mvg-cat-action">
              <span>View Products</span>
              <span class="mvg-cat-action-icon" aria-hidden="true">&rarr;</span>
            </div>
          </div>
        </a>

      </div>

      <!-- View All Collections Hub Button -->
      <div style="text-align: center; margin-top: 36px;">
        <a href="collections.php" class="btn btn-outline" style="padding: 12px 28px; font-weight: 700; border-radius: 10px; display: inline-flex; align-items: center; gap: 8px;">
          <span>Explore All Collections Hub</span>
          <span aria-hidden="true">&rarr;</span>
        </a>
      </div>

    </div>
  </section>

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

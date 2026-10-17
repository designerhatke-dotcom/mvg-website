<?php
/**
 * MVG Power Solutions — Product Detail Page
 * High-precision Class 1.0 & 0.5 Current Transformer Showcase
 */
require_once __DIR__ . '/config/constants.php';
require_once __DIR__ . '/config/db.php';
require_once __DIR__ . '/includes/google_reviews.php';

// Fetch Google Reviews with 2-day auto-cache
$googleReviewsData = GoogleReviewsService::getReviewsData();
$googleReviews = $googleReviewsData['reviews'] ?? [];

// Resolve Product ID or fallback to first top-selling product (ID 258)
$productId = isset($_GET['id']) ? intval($_GET['id']) : (isset($_GET['slug']) ? trim($_GET['slug']) : 258);
$product = Database::getProductById($productId);

// If invalid, fallback to top product
if (!$product) {
    $product = Database::getProductById(258);
}

// Related products in the same collection
$relatedProducts = Database::getRelatedProducts($product['id'], $product['category'], 4);

$pageTitle = htmlspecialchars($product['name']) . " | " . SITE_NAME;
$effectiveGstPrice = round($product['price'] * 1.18);
$minQty = $product['minQty'] ?? DEFAULT_MIN_QTY;
$initialBasePrice = $product['price'] * $minQty;
$initialGst = $initialBasePrice * 0.18;
$initialTotalPrice = $initialBasePrice + $initialGst;

// WhatsApp inquiry text
$waMsg = "Hello MVG Power Solutions, I need a quotation for " . $product['name'] . " (SKU: " . $product['sku'] . ", Min Qty: " . $minQty . " pcs). Please share pricing and dispatch timeline.";
$waUrl = "https://wa.me/" . WHATSAPP_NUMBER . "?text=" . rawurlencode($waMsg);
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title><?php echo $pageTitle; ?></title>
  <meta name="description" content="Buy <?php echo htmlspecialchars($product['name']); ?> factory-direct from MVG Power Solutions. Class 1.0 metering, IS 2705 certified with 18% GST Input Tax Credit." />

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

  <!-- Breadcrumb Bar (Clean Light Background) -->
  <div class="pdp-breadcrumb-bar">
    <div class="mvg-header-container">
      <nav class="breadcrumb-trail-clean" aria-label="Breadcrumb">
        <a href="index.php">Home</a>
        <span class="sep">›</span>
        <a href="collections.php?category=<?php echo urlencode($product['category']); ?>"><?php echo htmlspecialchars($product['categoryName']); ?></a>
        <span class="sep">›</span>
        <span class="current"><?php echo htmlspecialchars($product['name']); ?></span>
      </nav>
    </div>
  </div>

  <!-- Main Product Detail Layout -->
  <main class="pdp-section" id="productMain">
    <div class="mvg-header-container">

      <!-- White Outer Card (Matching User Reference Image) -->
      <div class="pdp-white-card">
        <div class="pdp-hero-grid">

          <!-- Left: Product Media Gallery with Slider Controls -->
          <div class="pdp-media-column">
            <div class="pdp-gallery-card-v2">
              
              <!-- Slider Left Arrow -->
              <button 
                type="button" 
                class="gallery-arrow-btn arrow-prev" 
                onclick="window.MVGProductPage.prevImage()" 
                aria-label="Previous Image"
              >
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="15 18 9 12 15 6"></polyline></svg>
              </button>

              <!-- Main Big Image -->
              <div class="pdp-main-image-wrap">
                <img 
                  id="pdpMainImage" 
                  src="<?php echo htmlspecialchars($product['image']); ?>" 
                  alt="<?php echo htmlspecialchars($product['name']); ?>" 
                  width="500" 
                  height="500"
                  fetchpriority="high"
                  loading="eager"
                />
              </div>

              <!-- Slider Right Arrow -->
              <button 
                type="button" 
                class="gallery-arrow-btn arrow-next" 
                onclick="window.MVGProductPage.nextImage()" 
                aria-label="Next Image"
              >
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="9 18 15 12 9 6"></polyline></svg>
              </button>

            </div>

            <!-- Thumbnail Carousel/Row (if multiple images) -->
            <?php if (!empty($product['images']) && count($product['images']) > 1): ?>
              <div class="pdp-thumb-strip" id="pdpThumbStrip">
                <?php foreach ($product['images'] as $idx => $imgSrc): ?>
                  <button 
                    type="button" 
                    class="pdp-thumb-btn <?php echo ($idx === 0) ? 'active' : ''; ?>" 
                    onclick="window.MVGProductPage.switchImage('<?php echo htmlspecialchars($imgSrc); ?>', this)"
                    aria-label="View product angle <?php echo $idx + 1; ?>"
                  >
                    <img src="<?php echo htmlspecialchars($imgSrc); ?>" alt="<?php echo htmlspecialchars($product['name']); ?> thumb" />
                  </button>
                <?php endforeach; ?>
              </div>
            <?php endif; ?>

          </div>

          <!-- Right: Commercial & Purchase Decision Details -->
          <div class="pdp-info-column">
            
            <!-- Badges Row: Category, Compliance & Testing -->
            <div class="pdp-badges-row-v2">
              <a href="collections.php?category=<?php echo urlencode($product['category']); ?>" class="badge-category-v2">
                <?php echo htmlspecialchars($product['categoryName']); ?>
              </a>
              <span class="pdp-badge-is">IS 2705 &amp; IEC 61869-2</span>
              <span class="pdp-badge-tested">100% Factory Routine Tested</span>
            </div>

            <!-- Product Title -->
            <h1 class="pdp-product-title-v2"><?php echo htmlspecialchars($product['name']); ?></h1>

            <!-- SKU / Item ID -->
            <div class="pdp-sku-line-v2">
              SKU / Item ID: <span><?php echo htmlspecialchars($product['sku']); ?></span>
            </div>

            <!-- Price Row -->
            <div class="pdp-price-row-v2">
              <span class="pdp-main-price">₹<?php echo number_format($product['price'], 2); ?></span>
              <span class="pdp-price-unit-v2">/ Pcs</span>
              <span class="pdp-gst-pill-v2">+ 18% GST</span>
            </div>

            <!-- Dynamic Price Breakdown Box -->
            <div class="pdp-breakdown-box">
              <div class="pdp-breakdown-row">
                <span class="pdp-breakdown-label">Base Price</span>
                <span class="pdp-breakdown-val" id="pdpBreakdownBase">₹<?php echo number_format($initialBasePrice, 2); ?></span>
              </div>
              <div class="pdp-breakdown-row">
                <span class="pdp-breakdown-label">GST (18%)</span>
                <span class="pdp-breakdown-val" id="pdpBreakdownGst">₹<?php echo number_format($initialGst, 2); ?></span>
              </div>
              <div class="pdp-breakdown-total">
                <span class="pdp-breakdown-label">Total Price</span>
                <span class="pdp-breakdown-val" id="pdpBreakdownTotal">₹<?php echo number_format($initialTotalPrice, 2); ?></span>
              </div>
            </div>

            <!-- Minimum Order Quantity Line -->
            <div class="pdp-min-qty-line">
              Minimum order quantity: <strong><?php echo $minQty; ?> Pcs</strong>
            </div>

            <!-- Actions Row: Stepper & Add to Cart Button -->
            <div class="pdp-action-row-v2">
              <div class="pdp-stepper-v2">
                <button type="button" class="stepper-btn-v2" onclick="window.MVGProductPage.changeQty(-1)" aria-label="Decrease quantity">−</button>
                <input 
                  type="number" 
                  class="qty-input pdp-qty-input-v2" 
                  id="pdpQtyInput" 
                  value="<?php echo $minQty; ?>" 
                  min="<?php echo $minQty; ?>" 
                  step="1" 
                  aria-label="Order Quantity"
                  oninput="window.MVGProductPage.onQtyInput(this)"
                  onblur="window.MVGProductPage.onQtyBlur(this)"
                  onkeydown="if(event.key==='Enter'){this.blur();}"
                />
                <button type="button" class="stepper-btn-v2" onclick="window.MVGProductPage.changeQty(1)" aria-label="Increase quantity">+</button>
              </div>

              <button 
                type="button" 
                class="pdp-btn-add-v2" 
                id="pdpAddToCartBtn"
                onclick="window.MVGProductPage.addToCart(<?php echo $product['id']; ?>)"
              >
                <span class="add-cart-left">
                  <svg viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="currentColor" stroke-width="2.2" aria-hidden="true">
                    <circle cx="9" cy="21" r="1"></circle>
                    <circle cx="20" cy="21" r="1"></circle>
                    <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path>
                  </svg>
                  <span>ADD TO CART</span>
                </span>
                <span class="add-cart-arrow">›</span>
              </button>
            </div>

            <!-- Inquire for Bulk Orders Button -->
            <a 
              href="<?php echo $waUrl; ?>" 
              target="_blank" 
              rel="noopener" 
              class="pdp-btn-bulk-v2"
              id="pdpWhatsAppBtn"
            >
              <svg viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
                <path d="M21 11.5a8.38 8.38 0 0 1-.9 3.8 8.5 8.5 0 0 1-7.6 4.7 8.38 8.38 0 0 1-3.8-.9L3 21l1.9-5.7a8.38 8.38 0 0 1-.9-3.8 8.5 8.5 0 0 1 4.7-7.6 8.38 8.38 0 0 1 3.8-.9h.5a8.48 8.48 0 0 1 8 8v.5z"></path>
              </svg>
              <span>Inquire for Bulk Orders</span>
            </a>



            <!-- Trust Assurance Strip (Direct Manufacturer, Fast Shipping, GST Invoice) -->
            <div class="mvg-trust-banner-strip">
              <div class="mvg-trust-col">
                <div class="mvg-trust-icon-box">
                  <svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" stroke-width="2.6" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                    <polyline points="20 6 9 17 4 12"></polyline>
                  </svg>
                </div>
                <div class="mvg-trust-info">
                  <span class="mvg-trust-title">Direct Manufacturer</span>
                  <span class="mvg-trust-desc">100% Genuine Quality</span>
                </div>
              </div>

              <div class="mvg-trust-col">
                <div class="mvg-trust-icon-box">
                  <svg viewBox="0 0 24 24" width="20" height="20" fill="currentColor" aria-hidden="true">
                    <path d="M13 2L3 14h8l-2 8 10-12h-8l2-8z"></path>
                  </svg>
                </div>
                <div class="mvg-trust-info">
                  <span class="mvg-trust-title">Fast Shipping</span>
                  <span class="mvg-trust-desc">Dispatched in 24 Hours</span>
                </div>
              </div>

              <div class="mvg-trust-col">
                <div class="mvg-trust-icon-box">
                  <svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
                    <rect x="3.5" y="3.5" width="17" height="17" rx="3" ry="3"></rect>
                    <rect x="8" y="8" width="8" height="8" fill="currentColor"></rect>
                  </svg>
                </div>
                <div class="mvg-trust-info">
                  <span class="mvg-trust-title">GST Invoice</span>
                  <span class="mvg-trust-desc">Input Credit Eligible</span>
                </div>
              </div>
            </div>

          </div>

        </div>
      </div>

      <!-- ===================================================================
           TABS CONTAINER: Specs, Description, Wiring & Bulk RFQ
           =================================================================== -->
      <section class="pdp-tabs-section">
        
        <div class="pdp-tabs-nav" role="tablist">
          <button 
            type="button" 
            class="pdp-tab-btn active" 
            role="tab" 
            aria-selected="true" 
            aria-controls="tabSpecs" 
            id="tabBtnSpecs"
            onclick="window.MVGProductPage.switchTab('tabSpecs', this)"
          >
            Technical Specifications
          </button>
          <button 
            type="button" 
            class="pdp-tab-btn" 
            role="tab" 
            aria-selected="false" 
            aria-controls="tabOverview" 
            id="tabBtnOverview"
            onclick="window.MVGProductPage.switchTab('tabOverview', this)"
          >
            Product Overview &amp; Applications
          </button>
          <button 
            type="button" 
            class="pdp-tab-btn" 
            role="tab" 
            aria-selected="false" 
            aria-controls="tabReviews" 
            id="tabBtnReviews"
            onclick="window.MVGProductPage.switchTab('tabReviews', this)"
          >
            <svg width="15" height="15" viewBox="0 0 24 24" style="vertical-align: -2px; margin-right: 6px;">
              <path fill="#4285F4" d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z"/>
              <path fill="#34A853" d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z"/>
              <path fill="#FBBC05" d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.06H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.94l2.85-2.22.81-.63z"/>
              <path fill="#EA4335" d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.06l3.66 2.84c.87-2.6 3.3-4.52 6.16-4.52z"/>
            </svg>
            Google Customer Reviews (<?php echo count($googleReviews); ?>)
          </button>
        </div>

        <div class="pdp-tabs-body">
          
          <!-- Tab 1: Technical Specifications -->
          <div class="pdp-tab-panel active" id="tabSpecs" role="tabpanel" aria-labelledby="tabBtnSpecs">
            <div class="pdp-specs-wrap">
              <h3 class="tab-inner-title">Electrical &amp; Mechanical Parameters</h3>
              <table class="pdp-specs-table">
                <tbody>
                  <?php foreach ($product['specs'] as $specKey => $specVal): ?>
                    <tr>
                      <th scope="row"><?php echo htmlspecialchars($specKey); ?></th>
                      <td><strong><?php echo htmlspecialchars($specVal); ?></strong></td>
                    </tr>
                  <?php endforeach; ?>
                  <tr>
                    <th scope="row">Standard Compliance</th>
                    <td>IS 2705 (Part 1 &amp; 2) / IEC 61869-2 Certified</td>
                  </tr>
                  <tr>
                    <th scope="row">Highest System Voltage (Um)</th>
                    <td>0.72 kV (Test Withstand Voltage 3 kV / 1 min)</td>
                  </tr>
                  <tr>
                    <th scope="row">Rated Frequency</th>
                    <td>50 / 60 Hz</td>
                  </tr>
                  <tr>
                    <th scope="row">Continuous Thermal Current</th>
                    <td>1.2 × Rated Primary Current</td>
                  </tr>
                  <tr>
                    <th scope="row">Enclosure Material</th>
                    <td>UL94-V0 Grade Flame-Retardant Polycarbonate</td>
                  </tr>
                  <tr>
                    <th scope="row">Secondary Terminals</th>
                    <td>M5 Screws with Captive Spring Washers &amp; Transparent Sealable Cover</td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>

          <!-- Tab 2: Product Overview -->
          <div class="pdp-tab-panel" id="tabOverview" role="tabpanel" aria-labelledby="tabBtnOverview">
            <div class="pdp-overview-content">
              <?php 
                if (!empty($product['description'])) {
                  echo $product['description'];
                } else {
                  echo "<p>High precision current transformer engineered for switchgear, distribution panels, and industrial metering installations. Built with low-loss CRGO silicon steel cores for linear response under high load conditions.</p>";
                }
              ?>
            </div>
          </div>

          <!-- Tab 3: Google Customer Reviews -->
          <div class="pdp-tab-panel" id="tabReviews" role="tabpanel" aria-labelledby="tabBtnReviews">
            <div class="pdp-reviews-wrap">
              
              <!-- Google Reviews Summary Card -->
              <div class="pdp-reviews-summary-card">
                <div class="pdp-reviews-overall">
                  <div class="google-badge-top">
                    <svg width="22" height="22" viewBox="0 0 24 24">
                      <path fill="#4285F4" d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z"/>
                      <path fill="#34A853" d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z"/>
                      <path fill="#FBBC05" d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.06H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.94l2.85-2.22.81-.63z"/>
                      <path fill="#EA4335" d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.06l3.66 2.84c.87-2.6 3.3-4.52 6.16-4.52z"/>
                    </svg>
                    <span>Google Business Reviews</span>
                  </div>
                  <div class="overall-score-row">
                    <span class="overall-score"><?php echo number_format($googleReviewsData['rating'] ?? 4.9, 1); ?></span>
                    <div class="overall-stars-group">
                      <div class="overall-stars"><?php echo GoogleReviewsService::renderStars($googleReviewsData['rating'] ?? 4.9); ?></div>
                      <div class="overall-text">Based on <?php echo intval($googleReviewsData['user_ratings_total'] ?? 12); ?> Google reviews</div>
                    </div>
                  </div>
                  <div class="overall-badge google-verified-pill">
                    <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="20 6 9 17 4 12"></polyline></svg>
                    <span>Auto-syncs with Google every 2 days</span>
                  </div>
                </div>

                <!-- Rating Breakdown Bars -->
                <div class="pdp-reviews-breakdown">
                  <?php 
                    $breakdown = $googleReviewsData['rating_breakdown'] ?? ['5_star' => 92, '4_star' => 8, '3_star' => 0, '2_star' => 0, '1_star' => 0];
                  ?>
                  <div class="rating-bar-row">
                    <span class="star-label">5 Stars</span>
                    <div class="rating-progress-track">
                      <div class="rating-progress-fill" style="width: <?php echo intval($breakdown['5_star'] ?? 92); ?>%;"></div>
                    </div>
                    <span class="count-label"><?php echo intval($breakdown['5_star'] ?? 92); ?>%</span>
                  </div>
                  <div class="rating-bar-row">
                    <span class="star-label">4 Stars</span>
                    <div class="rating-progress-track">
                      <div class="rating-progress-fill" style="width: <?php echo intval($breakdown['4_star'] ?? 8); ?>%;"></div>
                    </div>
                    <span class="count-label"><?php echo intval($breakdown['4_star'] ?? 8); ?>%</span>
                  </div>
                  <div class="rating-bar-row">
                    <span class="star-label">3 Stars</span>
                    <div class="rating-progress-track">
                      <div class="rating-progress-fill" style="width: <?php echo intval($breakdown['3_star'] ?? 0); ?>%;"></div>
                    </div>
                    <span class="count-label"><?php echo intval($breakdown['3_star'] ?? 0); ?>%</span>
                  </div>
                  <div class="rating-bar-row">
                    <span class="star-label">2 Stars</span>
                    <div class="rating-progress-track">
                      <div class="rating-progress-fill" style="width: <?php echo intval($breakdown['2_star'] ?? 0); ?>%;"></div>
                    </div>
                    <span class="count-label"><?php echo intval($breakdown['2_star'] ?? 0); ?>%</span>
                  </div>
                  <div class="rating-bar-row">
                    <span class="star-label">1 Star</span>
                    <div class="rating-progress-track">
                      <div class="rating-progress-fill" style="width: <?php echo intval($breakdown['1_star'] ?? 0); ?>%;"></div>
                    </div>
                    <span class="count-label"><?php echo intval($breakdown['1_star'] ?? 0); ?>%</span>
                  </div>
                </div>

                <!-- Direct Google Action CTA -->
                <div class="pdp-reviews-action-box">
                  <h4>Review MVG on Google</h4>
                  <p>Your feedback helps panel builders and industrial engineers across India.</p>
                  <div class="google-action-buttons">
                    <a 
                      href="<?php echo GOOGLE_REVIEW_URL; ?>" 
                      target="_blank" 
                      rel="noopener noreferrer" 
                      class="btn-google-direct-review"
                    >
                      <svg width="18" height="18" viewBox="0 0 24 24">
                        <path fill="#4285F4" d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z"/>
                        <path fill="#34A853" d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z"/>
                        <path fill="#FBBC05" d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.06H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.94l2.85-2.22.81-.63z"/>
                        <path fill="#EA4335" d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.06l3.66 2.84c.87-2.6 3.3-4.52 6.16-4.52z"/>
                      </svg>
                      <span>Write a Google Review</span>
                    </a>
                    <a 
                      href="<?php echo GOOGLE_BUSINESS_URL; ?>" 
                      target="_blank" 
                      rel="noopener noreferrer" 
                      class="btn-google-maps-view"
                    >
                      <span>View on Google Maps ↗</span>
                    </a>
                  </div>
                </div>
              </div>

              <!-- Customer Reviews List (Verified Google Reviews) -->
              <div class="pdp-reviews-list" id="pdpReviewsList">
                <?php if (!empty($googleReviews)): ?>
                  <?php foreach ($googleReviews as $rev): ?>
                    <div class="review-item-card">
                      <div class="review-header">
                        <div class="reviewer-meta">
                          <?php if (!empty($rev['profile_photo_url'])): ?>
                            <img src="<?php echo htmlspecialchars($rev['profile_photo_url']); ?>" alt="<?php echo htmlspecialchars($rev['author_name']); ?>" class="reviewer-avatar-img" />
                          <?php else: ?>
                            <div class="reviewer-avatar"><?php echo htmlspecialchars(GoogleReviewsService::getInitials($rev['author_name'])); ?></div>
                          <?php endif; ?>
                          <div>
                            <div class="reviewer-name-row">
                              <strong class="reviewer-name"><?php echo htmlspecialchars($rev['author_name']); ?></strong>
                              <span class="verified-google-badge">
                                <svg width="12" height="12" viewBox="0 0 24 24"><path fill="#4285F4" d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z"/><path fill="#34A853" d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z"/><path fill="#FBBC05" d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.06H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.94l2.85-2.22.81-.63z"/><path fill="#EA4335" d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.06l3.66 2.84c.87-2.6 3.3-4.52 6.16-4.52z"/></svg>
                                Verified Google Review
                              </span>
                            </div>
                            <span class="reviewer-role"><?php echo htmlspecialchars($rev['user_badge'] ?? 'Google Customer'); ?></span>
                          </div>
                        </div>
                        <div class="review-rating-date">
                          <div class="review-stars"><?php echo GoogleReviewsService::renderStars($rev['rating'] ?? 5); ?></div>
                          <span class="review-date"><?php echo htmlspecialchars($rev['relative_time_description'] ?? 'Recently'); ?></span>
                        </div>
                      </div>
                      <p class="review-body">
                        <?php echo nl2br(htmlspecialchars($rev['text'] ?? '')); ?>
                      </p>
                      <?php if (!empty($rev['owner_reply'])): ?>
                        <div class="google-owner-reply">
                          <div class="owner-reply-header">
                            <div class="owner-reply-avatar">
                              <svg width="13" height="13" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 3c1.66 0 3 1.34 3 3s-1.34 3-3 3-3-1.34-3-3 1.34-3 3-3zm0 14.2c-2.5 0-4.71-1.28-6-3.22.03-1.99 4-3.08 6-3.08 1.99 0 5.97 1.09 6 3.08-1.29 1.94-3.5 3.22-6 3.22z"/></svg>
                            </div>
                            <strong class="owner-reply-author"><?php echo htmlspecialchars($rev['owner_reply']['author_name']); ?></strong>
                            <span class="owner-reply-date"><?php echo htmlspecialchars($rev['owner_reply']['relative_time_description']); ?></span>
                          </div>
                          <p class="owner-reply-text"><?php echo htmlspecialchars($rev['owner_reply']['text']); ?></p>
                        </div>
                      <?php endif; ?>
                    </div>
                  <?php endforeach; ?>
                <?php else: ?>
                  <div class="review-item-card" style="text-align: center; padding: 32px 20px;">
                    <p style="margin: 0; color: #64748B; font-size: 14px;">No Google reviews found in cache. Click above to write a review or refresh.</p>
                  </div>
                <?php endif; ?>
              </div>

            </div>
          </div>

        </div>

      </section>

      <!-- ===================================================================
           RELATED PRODUCTS SECTION (4 Columns Desktop/Laptop, 2 Columns Mobile)
           =================================================================== -->
      <?php if (!empty($relatedProducts)): ?>
        <section class="pdp-related-section">
          <div class="pdp-related-header">
            <div>
              <h2 class="pdp-related-title">More in this Collection</h2>
              <span class="pdp-related-sub">Frequently paired current transformers in <?php echo htmlspecialchars($product['categoryName']); ?></span>
            </div>
            <a href="collections.php?category=<?php echo urlencode($product['category']); ?>" class="pdp-view-collection-link">
              <span>View All <?php echo htmlspecialchars($product['categoryName']); ?></span>
              <span aria-hidden="true">&rarr;</span>
            </a>
          </div>

          <div class="product-cards-grid">
            <?php foreach ($relatedProducts as $rel): ?>
              <article class="product-card" data-product-id="<?php echo $rel['id']; ?>">
                
                <div class="product-thumb-wrap" onclick="window.location.href='product.php?id=<?php echo $rel['id']; ?>'" title="View <?php echo htmlspecialchars($rel['name']); ?>">
                  <img src="<?php echo htmlspecialchars($rel['image']); ?>" alt="<?php echo htmlspecialchars($rel['name']); ?>" loading="lazy" />
                  <a href="product.php?id=<?php echo $rel['id']; ?>" class="quick-view-overlay-btn" onclick="event.stopPropagation();">View Details</a>
                </div>

                <div class="card-meta-row">
                  <span class="card-category-tag"><?php echo htmlspecialchars($rel['categoryName']); ?></span>
                  <span class="card-sku-tag">Class 1.0</span>
                </div>

                <h3 class="card-title" onclick="window.location.href='product.php?id=<?php echo $rel['id']; ?>'">
                  <a href="product.php?id=<?php echo $rel['id']; ?>" style="color: inherit; text-decoration: none;">
                    <?php echo htmlspecialchars($rel['name']); ?>
                  </a>
                </h3>

                <div class="card-price-container">
                  <div class="price-main-row">
                    <span class="price-retail-label">Price:</span>
                    <span class="price-number">₹<?php echo number_format($rel['price'], 0); ?></span>
                  </div>
                  <div class="card-wholesale-tier-row">
                    <span class="tier-label-sm">Min. Qty:</span>
                    <span class="tier-price-sm"><?php echo $rel['minQty']; ?> Pcs</span>
                  </div>
                </div>

                <div class="card-actions">
                  <div class="qty-stepper">
                    <button type="button" class="stepper-btn" onclick="window.MVGHub.updateCardQty(<?php echo $rel['id']; ?>, -1)" aria-label="Decrease quantity by 1">−</button>
                    <input 
                      type="number" 
                      class="qty-input" 
                      id="qty-input-<?php echo $rel['id']; ?>" 
                      value="<?php echo $rel['minQty']; ?>" 
                      min="<?php echo $rel['minQty']; ?>" 
                      step="1"
                      aria-label="Quantity for <?php echo htmlspecialchars($rel['name']); ?>"
                      oninput="window.MVGHub.handleCardQtyInput(<?php echo $rel['id']; ?>, this)"
                      onblur="window.MVGHub.handleCardQtyBlur(<?php echo $rel['id']; ?>, this)"
                      onkeydown="if(event.key==='Enter'){this.blur();}"
                    />
                    <button type="button" class="stepper-btn" onclick="window.MVGHub.updateCardQty(<?php echo $rel['id']; ?>, 1)" aria-label="Increase quantity by 1">+</button>
                  </div>
                  <button type="button" class="btn btn-primary btn-sm" onclick="window.MVGHub.addToCartFromCard(<?php echo $rel['id']; ?>)">
                    Add to Cart
                  </button>
                </div>

              </article>
            <?php endforeach; ?>
          </div>

        </section>
      <?php endif; ?>

    </div>
  </main>

  <!-- Modular Modals & Slide-Over Drawer -->
  <?php include __DIR__ . '/includes/quickview-modal.php'; ?>
  <?php include __DIR__ . '/includes/cart-drawer.php'; ?>

  <!-- Modular Site Footer -->
  <?php include __DIR__ . '/includes/footer.php'; ?>

  <!-- Floating Sticky Bottom Purchase Bar (Visible on scroll / mobile) -->
  <div class="pdp-sticky-bar" id="pdpStickyBar">
    <div class="sticky-price-group">
      <span class="sticky-price-label">PRICE (EXCL. GST)</span>
      <span class="sticky-price-val" id="pdpStickyPrice">₹<?php echo number_format($initialBasePrice, 2); ?></span>
    </div>
    <div class="pdp-stepper-v2 sticky-stepper">
      <button type="button" class="stepper-btn-v2" onclick="window.MVGProductPage.changeQty(-1)" aria-label="Decrease quantity">−</button>
      <input 
        type="number" 
        class="qty-input pdp-qty-input-v2" 
        id="pdpStickyQtyInput" 
        value="<?php echo $minQty; ?>" 
        min="<?php echo $minQty; ?>" 
        step="1"
        aria-label="Sticky Quantity"
        oninput="window.MVGProductPage.onQtyInput(this)" 
        onblur="window.MVGProductPage.onQtyBlur(this)"
      />
      <button type="button" class="stepper-btn-v2" onclick="window.MVGProductPage.changeQty(1)" aria-label="Increase quantity">+</button>
    </div>
    <button 
      type="button" 
      class="btn-sticky-add-cart" 
      onclick="window.MVGProductPage.addToCart(<?php echo $product['id']; ?>)"
    >
      <svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2.2" aria-hidden="true">
        <circle cx="9" cy="21" r="1"></circle>
        <circle cx="20" cy="21" r="1"></circle>
        <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path>
      </svg>
      <span>ADD TO CART</span>
    </button>
  </div>

  <!-- Scripts -->
  <script>
    window.productPrice = <?php echo json_encode($product['price']); ?>;
    window.productMinQty = <?php echo json_encode($minQty); ?>;
    window.productImages = <?php echo json_encode($product['images'] ?? [$product['image']]); ?>;
    window.productName = <?php echo json_encode($product['name']); ?>;
    window.productSku = <?php echo json_encode($product['sku']); ?>;
    window.mvgWhatsAppBase = "https://wa.me/<?php echo WHATSAPP_NUMBER; ?>?text=";
  </script>
  <script src="js/header.js"></script>
  <script src="js/products.js"></script>
  <script src="js/catalog.js"></script>
  <script src="js/product-page.js"></script>
</body>
</html>

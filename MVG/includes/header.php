<?php
/**
 * MVG Power Solutions — Modular Site Header & Mega Navigation
 */
require_once __DIR__ . '/../config/constants.php';
?>
<!-- Top Announcement Bar -->
<div class="mvg-top-bar">
  <div class="mvg-header-container">
    
    <!-- Left: Warehouse & Dispatch Status -->
    <div class="mvg-top-left">
      <span class="mvg-pulse-dot" aria-hidden="true"></span>
      <span>DELHI NCR WAREHOUSE HUB • SAME-DAY DISPATCH</span>
    </div>

    <!-- Center: B2B GST & Tiered Wholesale Benefit -->
    <div class="mvg-top-center">
      <span>GST Input Tax Credit on All B2B Invoices • <strong>Tiered Wholesale Rates for 10+ / 50+ / 100+ Pcs</strong></span>
    </div>

    <!-- Right: Contact Phone -->
    <div class="mvg-top-right">
      <a href="tel:<?php echo htmlspecialchars(CONTACT_PHONE_TEL); ?>" class="mvg-top-phone" title="Call or WhatsApp MVG Support">
        <svg viewBox="0 0 24 24" fill="none" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
          <path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"></path>
        </svg>
        <span><?php echo htmlspecialchars(CONTACT_PHONE); ?></span>
      </a>
    </div>

  </div>
</div>

<!-- Main Header Row (Logo, Search, Actions) -->
<div class="mvg-main-header">
  <div class="mvg-header-container">
    
    <!-- Mobile Drawer Hamburger -->
    <button id="mvgMobileToggle" class="mvg-mobile-toggle" type="button" aria-label="Open mobile navigation menu">
      <span></span>
      <span></span>
      <span></span>
    </button>

    <!-- Brand Logo -->
    <a href="index.php" class="mvg-brand" title="<?php echo htmlspecialchars(SITE_NAME); ?>">
      <img src="assets/Logo-11.png" alt="<?php echo htmlspecialchars(SITE_NAME); ?>" width="180" height="48">
    </a>

    <!-- Universal Search Input Bar -->
    <div class="mvg-search-wrapper">
      <form class="mvg-search-box" role="search" onsubmit="event.preventDefault();">
        <svg class="mvg-search-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
          <circle cx="11" cy="11" r="8"></circle>
          <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
        </svg>
        <input 
          id="mvgSearchInput" 
          type="search" 
          placeholder="Search by Part Name, Ratio (e.g. 100/5A), Busbar, Ring CT..." 
          autocomplete="off"
          aria-label="Search current transformers and meters"
        >
        <kbd class="mvg-search-key" title="Press '/' to quickly search">/</kbd>
      </form>
    </div>

    <!-- Header Actions: Cart Counter Button -->
    <div class="mvg-header-actions">
      <button id="mvgCartBtn" class="mvg-btn-cart" type="button" aria-label="View Shopping Cart">
        <svg viewBox="0 0 24 24" fill="none" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
          <circle cx="9" cy="21" r="1"></circle>
          <circle cx="20" cy="21" r="1"></circle>
          <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path>
        </svg>
        <span>Cart</span>
        <span class="mvg-cart-badge" id="cartCountBadge">0</span>
      </button>
    </div>

  </div>
</div>

<!-- Main 6-Category Mega Menu Navigation -->
<nav class="mvg-nav-bar" aria-label="Main Product Collections">
  <div class="mvg-header-container">
    <ul class="mvg-nav-list">

      <!-- 1. Encapsulated Square CT -->
      <li class="mvg-nav-item" data-has-mega="true">
        <a href="collections.php?category=encapsulated-square-ct" class="mvg-nav-link">
          <span>Encapsulated Square CT</span>
          <span class="mvg-caret" aria-hidden="true"></span>
        </a>
        <div class="mvg-mega-menu" role="region" aria-label="Encapsulated Square CT Overview">
          <div class="mvg-mega-inner">
            <div class="mvg-mega-grid">
              
              <div class="mvg-mega-col">
                <h3 class="mvg-mega-col-title">Busbar Apertures</h3>
                <ul class="mvg-mega-links">
                  <li><a href="collections.php?category=encapsulated-square-ct">30 × 10 mm Busbar CT</a></li>
                  <li><a href="collections.php?category=encapsulated-square-ct">40 × 10 mm Busbar CT</a></li>
                  <li><a href="collections.php?category=encapsulated-square-ct">60 × 10 mm Busbar CT</a></li>
                  <li><a href="collections.php?category=encapsulated-square-ct">80 × 10 mm Heavy Busbar</a></li>
                  <li><a href="collections.php?category=encapsulated-square-ct">100 × 10 mm Main Incomer</a></li>
                </ul>
              </div>

              <div class="mvg-mega-col">
                <h3 class="mvg-mega-col-title">Current Ratios (A)</h3>
                <ul class="mvg-mega-links">
                  <li><a href="collections.php?category=encapsulated-square-ct">100/5A to 300/5A</a></li>
                  <li><a href="collections.php?category=encapsulated-square-ct">400/5A to 600/5A</a></li>
                  <li><a href="collections.php?category=encapsulated-square-ct">800/5A to 1250/5A</a></li>
                  <li><a href="collections.php?category=encapsulated-square-ct">1600/5A to 2500/5A</a></li>
                </ul>
              </div>

              <div class="mvg-mega-col">
                <h3 class="mvg-mega-col-title">Accuracy &amp; Burden</h3>
                <ul class="mvg-mega-links">
                  <li><a href="collections.php?category=encapsulated-square-ct">Class 1.0 Panel Metering</a></li>
                  <li><a href="collections.php?category=encapsulated-square-ct">Class 0.5 Revenue Grade</a></li>
                  <li><a href="collections.php?category=encapsulated-square-ct">5 VA to 15 VA Rated Burden</a></li>
                </ul>
              </div>

              <div class="mvg-mega-col">
                <h3 class="mvg-mega-col-title">Standards</h3>
                <ul class="mvg-mega-links">
                  <li><a href="javascript:void(0)">IS 2705 Part 1 &amp; 2</a></li>
                  <li><a href="javascript:void(0)">IEC 61869-2 Certified</a></li>
                  <li><a href="javascript:void(0)">Flame-Retardant Polycarbonate</a></li>
                </ul>
              </div>

              <div class="mvg-mega-col">
                <div class="mvg-featured-card">
                  <div class="mvg-featured-top">
                    <div class="mvg-featured-img-wrap">
                      <img src="assets/categories/encapsulated-square-ct.jpg" alt="Encapsulated Square CT" loading="lazy">
                    </div>
                    <div class="mvg-featured-info">
                      <span class="mvg-badge-top-seller">16 PRODUCTS</span>
                      <span class="mvg-featured-title">Square Busbar CT Lineup</span>
                    </div>
                  </div>
                  <a href="collections.php?category=encapsulated-square-ct" class="mvg-featured-link">
                    <span>View Collection</span>
                    <span aria-hidden="true">›</span>
                  </a>
                </div>
              </div>

            </div>

            <div class="mvg-mega-footer">
              <a href="collections.php?category=encapsulated-square-ct" class="mvg-view-all-link">
                <span>VIEW ALL ENCAPSULATED SQUARE CTS</span>
                <span aria-hidden="true">›</span>
              </a>
            </div>
          </div>
        </div>
      </li>

      <!-- 2. Encapsulated Ring CT -->
      <li class="mvg-nav-item" data-has-mega="true">
        <a href="collections.php?category=encapsulated-ring-ct" class="mvg-nav-link">
          <span>Encapsulated Ring CT</span>
          <span class="mvg-caret" aria-hidden="true"></span>
        </a>
        <div class="mvg-mega-menu" role="region" aria-label="Encapsulated Ring CT Overview">
          <div class="mvg-mega-inner">
            <div class="mvg-mega-grid">
              
              <div class="mvg-mega-col">
                <h3 class="mvg-mega-col-title">Internal Diameters</h3>
                <ul class="mvg-mega-links">
                  <li><a href="collections.php?category=encapsulated-ring-ct">35 mm Cable Hole CT</a></li>
                  <li><a href="collections.php?category=encapsulated-ring-ct">45 mm Cable Opening CT</a></li>
                  <li><a href="collections.php?category=encapsulated-ring-ct">65 mm Conductor Opening CT</a></li>
                  <li><a href="collections.php?category=encapsulated-ring-ct">85 mm High Amp Opening CT</a></li>
                  <li><a href="collections.php?category=encapsulated-ring-ct">115 mm Feeder Ring CT</a></li>
                </ul>
              </div>

              <div class="mvg-mega-col">
                <h3 class="mvg-mega-col-title">Primary Currents (A)</h3>
                <ul class="mvg-mega-links">
                  <li><a href="collections.php?category=encapsulated-ring-ct">50A, 100A, 150A, 200A</a></li>
                  <li><a href="collections.php?category=encapsulated-ring-ct">250A, 300A, 400A, 500A</a></li>
                  <li><a href="collections.php?category=encapsulated-ring-ct">600A, 800A, 1000A</a></li>
                  <li><a href="collections.php?category=encapsulated-ring-ct">1200A, 1600A, 2000A, 2500A</a></li>
                </ul>
              </div>

              <div class="mvg-mega-col">
                <h3 class="mvg-mega-col-title">Applications</h3>
                <ul class="mvg-mega-links">
                  <li><a href="javascript:void(0)">Main Incomer Metering</a></li>
                  <li><a href="javascript:void(0)">Motor Control Centers (MCC)</a></li>
                  <li><a href="javascript:void(0)">Power Distribution Boards</a></li>
                  <li><a href="javascript:void(0)">Sub-Metering &amp; Energy Audits</a></li>
                </ul>
              </div>

              <div class="mvg-mega-col">
                <h3 class="mvg-mega-col-title">Key Advantages</h3>
                <ul class="mvg-mega-links">
                  <li><a href="javascript:void(0)">CRGO Toroidal Core</a></li>
                  <li><a href="javascript:void(0)">High Saturation Margin</a></li>
                  <li><a href="javascript:void(0)">IP20 Insulated Terminals</a></li>
                </ul>
              </div>

              <div class="mvg-mega-col">
                <div class="mvg-featured-card">
                  <div class="mvg-featured-top">
                    <div class="mvg-featured-img-wrap">
                      <img src="assets/categories/encapsulated-ring-ct.jpg" alt="Encapsulated Ring CT" loading="lazy">
                    </div>
                    <div class="mvg-featured-info">
                      <span class="mvg-badge-top-seller">24 PRODUCTS</span>
                      <span class="mvg-featured-title">2500/5A to 50/5A Ring CTs</span>
                    </div>
                  </div>
                  <a href="collections.php?category=encapsulated-ring-ct" class="mvg-featured-link">
                    <span>View Collection</span>
                    <span aria-hidden="true">›</span>
                  </a>
                </div>
              </div>

            </div>

            <div class="mvg-mega-footer">
              <a href="collections.php?category=encapsulated-ring-ct" class="mvg-view-all-link">
                <span>VIEW ALL ENCAPSULATED RING CTS</span>
                <span aria-hidden="true">›</span>
              </a>
            </div>
          </div>
        </div>
      </li>

      <!-- 3. Tape Wound Ring CT -->
      <li class="mvg-nav-item">
        <a href="collections.php?category=tape-wound-ring-ct" class="mvg-nav-link">
          <span>Tape Wound Ring CT</span>
        </a>
      </li>

      <!-- 4. Resin Cast Rectangular CT -->
      <li class="mvg-nav-item">
        <a href="collections.php?category=resin-cast-rectangular-ct" class="mvg-nav-link">
          <span>Resin Cast Rectangular CT</span>
        </a>
      </li>

      <!-- 5. Resin Cast Ring CT -->
      <li class="mvg-nav-item">
        <a href="collections.php?category=resin-cast-ring-ct" class="mvg-nav-link">
          <span>Resin Cast Ring CT</span>
        </a>
      </li>

      <!-- 6. Split Core CT -->
      <li class="mvg-nav-item">
        <a href="collections.php?category=split-core-ct" class="mvg-nav-link">
          <span>Split Core CT</span>
        </a>
      </li>

    </ul>
  </div>
</nav>

<!-- Mobile Navigation Drawer -->
<div id="mvgDrawerOverlay" class="mvg-mobile-drawer-overlay" aria-hidden="true"></div>
<aside id="mvgMobileDrawer" class="mvg-mobile-drawer" role="dialog" aria-modal="true" aria-label="Mobile Navigation Menu">
  <div class="mvg-drawer-header">
    <img src="assets/Logo-11.png" alt="<?php echo htmlspecialchars(SITE_NAME); ?>" width="130" height="34" style="object-fit: contain;">
    <button id="mvgDrawerClose" class="mvg-drawer-close" type="button" aria-label="Close menu">&times;</button>
  </div>
  <div class="mvg-drawer-content">
    <div class="mvg-accordion-list">
      <div class="mvg-accordion-item">
        <a href="collections.php?category=encapsulated-square-ct" class="mvg-accordion-trigger">
          <span>Encapsulated Square CT</span>
        </a>
      </div>
      <div class="mvg-accordion-item">
        <a href="collections.php?category=encapsulated-ring-ct" class="mvg-accordion-trigger">
          <span>Encapsulated Ring CT</span>
        </a>
      </div>
      <div class="mvg-accordion-item">
        <a href="collections.php?category=tape-wound-ring-ct" class="mvg-accordion-trigger">
          <span>Tape Wound Ring CT</span>
        </a>
      </div>
      <div class="mvg-accordion-item">
        <a href="collections.php?category=resin-cast-rectangular-ct" class="mvg-accordion-trigger">
          <span>Resin Cast Rectangular CT</span>
        </a>
      </div>
      <div class="mvg-accordion-item">
        <a href="collections.php?category=resin-cast-ring-ct" class="mvg-accordion-trigger">
          <span>Resin Cast Ring CT</span>
        </a>
      </div>
      <div class="mvg-accordion-item">
        <a href="collections.php?category=split-core-ct" class="mvg-accordion-trigger">
          <span>Split Core CT</span>
        </a>
      </div>
    </div>
  </div>
</aside>

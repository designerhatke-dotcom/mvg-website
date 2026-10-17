<?php
/**
 * MVG Power Solutions — Modular 4-Column Industrial Footer
 */
require_once __DIR__ . '/../config/constants.php';
?>
<footer class="mvg-site-footer" role="contentinfo">
  
  <!-- 1. Value Assurances Banner -->
  <div class="mvg-footer-features">
    <div class="mvg-header-container">
      <div class="mvg-features-grid">
        
        <div class="mvg-feature-item">
          <div class="mvg-feature-icon-box">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2">
              <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path>
            </svg>
          </div>
          <div class="mvg-feature-content">
            <span class="mvg-feature-heading">IS 2705 &amp; IEC 61869-2</span>
            <span class="mvg-feature-sub">Certified Accuracy &amp; Dielectric Strength</span>
          </div>
        </div>

        <div class="mvg-feature-item">
          <div class="mvg-feature-icon-box">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2">
              <circle cx="12" cy="12" r="10"></circle>
              <polyline points="12 6 12 12 16 14"></polyline>
            </svg>
          </div>
          <div class="mvg-feature-content">
            <span class="mvg-feature-heading">Delhi NCR Central Depot</span>
            <span class="mvg-feature-sub">Same-Day Dispatch &amp; Fast Transport</span>
          </div>
        </div>

        <div class="mvg-feature-item">
          <div class="mvg-feature-icon-box">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2">
              <rect x="2" y="7" width="20" height="14" rx="2" ry="2"></rect>
              <path d="M16 21V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v16"></path>
            </svg>
          </div>
          <div class="mvg-feature-content">
            <span class="mvg-feature-heading">18% GST Invoicing</span>
            <span class="mvg-feature-sub">Full Input Tax Credit on All Orders</span>
          </div>
        </div>

        <div class="mvg-feature-item">
          <div class="mvg-feature-icon-box">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2">
              <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"></path>
            </svg>
          </div>
          <div class="mvg-feature-content">
            <span class="mvg-feature-heading">Factory Direct Wholesale</span>
            <span class="mvg-feature-sub">Workshop &amp; Panel Builder Tier Rates</span>
          </div>
        </div>

      </div>
    </div>
  </div>

  <!-- 2. Main Footer Navigation & Contact Links -->
  <div class="mvg-footer-main">
    <div class="mvg-header-container">
      <div class="mvg-footer-grid">

        <!-- Col 1: Brand & Contact -->
        <div class="mvg-footer-brand">
          <a href="index.php" class="mvg-footer-logo-wrap" title="<?php echo htmlspecialchars(SITE_NAME); ?>">
            <img src="assets/Logo-11.png" alt="<?php echo htmlspecialchars(SITE_NAME); ?>" width="150" height="38">
          </a>
          <span class="mvg-footer-tagline"><?php echo htmlspecialchars(SITE_TAGLINE); ?></span>
          <p class="mvg-footer-desc">
            Premier manufacturer and wholesale distributor of industrial Current Transformers (CTs) and Digital Meters. Delivering precision measurement, high durability, and certified reliability for switchboards and power distribution panels across India.
          </p>
          <div class="mvg-footer-contact-pills">
            <a href="https://wa.me/<?php echo htmlspecialchars(WHATSAPP_NUMBER); ?>" target="_blank" rel="noopener" class="mvg-footer-contact-pill">
              <span>💬 WhatsApp Support</span>
            </a>
            <a href="tel:<?php echo htmlspecialchars(CONTACT_PHONE_TEL); ?>" class="mvg-footer-contact-pill">
              <span>📞 <?php echo htmlspecialchars(CONTACT_PHONE); ?></span>
            </a>
          </div>
        </div>

        <!-- Col 2: Core CT Collections -->
        <div class="mvg-footer-col">
          <h4 class="mvg-footer-title">Transformer Collections</h4>
          <ul class="mvg-footer-links">
            <li><a href="collections.php?category=encapsulated-square-ct">Encapsulated Square CT</a></li>
            <li><a href="collections.php?category=encapsulated-ring-ct">Encapsulated Ring CT</a></li>
            <li><a href="collections.php?category=tape-wound-ring-ct">Tape Wound Ring CT</a></li>
            <li><a href="collections.php?category=resin-cast-rectangular-ct">Resin Cast Rectangular CT</a></li>
            <li><a href="collections.php?category=resin-cast-ring-ct">Resin Cast Ring CT</a></li>
            <li><a href="collections.php?category=split-core-ct">Split Core CT</a></li>
          </ul>
        </div>

        <!-- Col 3: Engineering & B2B Solutions -->
        <div class="mvg-footer-col">
          <h4 class="mvg-footer-title">B2B &amp; Engineering</h4>
          <ul class="mvg-footer-links">
            <li><a href="javascript:void(0)" onclick="if(window.MVGHub){window.MVGHub.openCartDrawer();}">B2B Order Pad &amp; Cart</a></li>
            <li><a href="collections.php">Custom Primary Currents (30A–4000A)</a></li>
            <li><a href="collections.php">Class 1.0 &amp; Class 0.5 Metering</a></li>
            <li><a href="collections.php">IS 2705 &amp; IEC 61869-2 Standards</a></li>
            <li><a href="collections.php">Workshop Wholesale Minimums</a></li>
            <li><a href="collections.php">GST Invoicing &amp; Input Tax Credit</a></li>
          </ul>
        </div>

        <!-- Col 4: Factory & Operating Details -->
        <div class="mvg-footer-col">
          <h4 class="mvg-footer-title">Factory &amp; Logistics Hub</h4>
          <ul class="mvg-footer-address-list">
            <li class="mvg-footer-address-item">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
                <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path>
                <circle cx="12" cy="10" r="3"></circle>
              </svg>
              <span>
                <strong><?php echo htmlspecialchars(SITE_NAME); ?></strong><br>
                <?php echo nl2br(htmlspecialchars(COMPANY_ADDRESS)); ?>
              </span>
            </li>
            <li class="mvg-footer-address-item">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
                <path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"></path>
              </svg>
              <a href="tel:<?php echo htmlspecialchars(CONTACT_PHONE_TEL); ?>"><?php echo htmlspecialchars(CONTACT_PHONE); ?></a>
            </li>
            <li class="mvg-footer-address-item">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
                <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path>
                <polyline points="22,6 12,13 2,6"></polyline>
              </svg>
              <a href="mailto:<?php echo htmlspecialchars(CONTACT_EMAIL); ?>"><?php echo htmlspecialchars(CONTACT_EMAIL); ?></a>
            </li>
            <li class="mvg-footer-address-item">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
                <circle cx="12" cy="12" r="10"></circle>
                <polyline points="12 6 12 12 16 14"></polyline>
              </svg>
              <span>Mon – Sat: 9:30 AM – 7:30 PM (Sun: Closed)</span>
            </li>
          </ul>
        </div>

      </div>
    </div>
  </div>

  <!-- 3. Bottom Legal & Copyright Strip -->
  <div class="mvg-footer-bottom">
    <div class="mvg-header-container">
      <div>
        <span>&copy; <?php echo date('Y'); ?> <strong><?php echo htmlspecialchars(SITE_NAME); ?></strong>. All rights reserved. <?php echo htmlspecialchars(SITE_TAGLINE); ?>.</span>
      </div>
      <div class="mvg-footer-badges">
        <span class="mvg-footer-pill-tag">🇮🇳 Made in India</span>
        <span class="mvg-footer-pill-tag">✓ 100% Factory Routine Tested</span>
        <span class="mvg-footer-pill-tag">🚚 Delhi NCR Dispatch Hub</span>
      </div>
    </div>
  </div>

</footer>

<!-- Toast Stack -->
<div class="toast-stack" id="toastStack" aria-live="assertive"></div>

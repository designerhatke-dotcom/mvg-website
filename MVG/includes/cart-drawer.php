<?php
/**
 * MVG Power Solutions — Slide-Over Cart & WhatsApp Order Drawer
 */
?>
<div class="drawer-backdrop" id="drawerBackdrop" hidden></div>
<aside class="cart-drawer" id="cartDrawer" aria-hidden="true">
  
  <!-- Drawer Header -->
  <div class="drawer-header">
    <div class="drawer-title-group">
      <h3>Order Cart &amp; Quotation</h3>
      <span class="drawer-item-count" id="drawerItemCount">0 items</span>
    </div>
    <button class="drawer-close" id="drawerCloseBtn" aria-label="Close drawer">&times;</button>
  </div>

  <!-- Drawer Body -->
  <div class="drawer-body" id="drawerBody">
    
    <!-- Empty Cart Notice -->
    <div class="empty-cart" id="emptyCartView">
      <div class="empty-icon">🛒</div>
      <h4>Your Order Cart is Empty</h4>
      <p>Browse our current transformer collection and add items to request a formal quotation or dispatch invoice.</p>
      <button type="button" class="btn btn-primary btn-sm" onclick="window.MVGHub.closeCartDrawer();">Browse Catalog</button>
    </div>

    <!-- Active Cart Items List -->
    <div class="cart-items-list" id="cartItemsList" style="display:none;">
      <!-- Populated dynamically via js/catalog.js -->
    </div>

  </div>

  <!-- Drawer Footer Summary & Actions -->
  <div class="drawer-footer" id="drawerFooter" style="display:none;">
    
    <div class="price-breakdown">
      <div class="price-row">
        <span>Subtotal (Excl. Tax):</span>
        <span id="drawerSubtotal">₹0</span>
      </div>
      <div class="price-row">
        <span>GST (18% ITC Tax):</span>
        <span id="drawerGstAmount">₹0</span>
      </div>
      <div class="price-row grand-total-row">
        <span>Estimated Total:</span>
        <span class="price-big" id="drawerGrandTotal">₹0</span>
      </div>
    </div>

    <div class="drawer-actions">
      <a href="inquiry-cart.php" class="btn btn-primary w-full" style="padding: 12px; font-weight: 800; border-radius: 8px; text-decoration: none; text-align: center; display: block; margin-bottom: 8px;">
        Review &amp; Submit Quotation (RFQ) &rarr;
      </a>
      <button type="button" class="btn btn-whatsapp w-full" id="whatsAppOrderBtn">
        <span>💬 Send Order Inquiry on WhatsApp</span>
      </button>
    </div>

  </div>

</aside>

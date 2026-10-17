<?php
/**
 * MVG Power Solutions — B2B Inquiry Basket & Quotation Request Cart
 * Enterprise RFQ Submission with GSTIN, Multi-Item Quotation, and Dispatch Planning.
 */

require_once __DIR__ . '/config/constants.php';
require_once __DIR__ . '/config/db.php';
require_once __DIR__ . '/config/settings.php';

$pageTitle = "Inquiry Basket & RFQ Quotation Request | " . SITE_NAME;
$pageDesc = "Submit your B2B quotation request for precision Current Transformers with 18% GST Input Tax Credit and factory-direct wholesale pricing from MVG Power Solutions.";
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title><?php echo htmlspecialchars($pageTitle); ?></title>
  <meta name="description" content="<?php echo htmlspecialchars($pageDesc); ?>">
  <link rel="canonical" href="<?php echo htmlspecialchars(SITE_URL); ?>/inquiry-cart.php">

  <!-- Inter Font -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">

  <link rel="stylesheet" href="css/style.css">
  <style>
    .rfq-cart-hero {
      background: linear-gradient(135deg, #0F172A 0%, #1E293B 100%);
      color: #FFFFFF;
      padding: 44px 0 52px 0;
      border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    }
    .rfq-cart-badge {
      display: inline-flex;
      align-items: center;
      gap: 6px;
      padding: 5px 12px;
      background: rgba(2, 132, 199, 0.2);
      border: 1px solid rgba(2, 132, 199, 0.4);
      color: #38BDF8;
      border-radius: 9999px;
      font-size: 11px;
      font-weight: 800;
      text-transform: uppercase;
      margin-bottom: 12px;
    }
    .rfq-cart-title {
      font-size: 32px;
      font-weight: 900;
      color: #FFFFFF;
      margin-bottom: 8px;
    }
    .rfq-cart-sub {
      font-size: 15px;
      color: #94A3B8;
      max-width: 750px;
      line-height: 1.55;
      margin: 0;
    }

    .rfq-layout {
      display: grid;
      grid-template-columns: 1fr 420px;
      gap: 36px;
      padding: 44px 0 80px 0;
      align-items: start;
    }
    @media (max-width: 991px) {
      .rfq-layout {
        grid-template-columns: 1fr;
      }
    }

    .rfq-items-panel {
      background: #FFFFFF;
      border: 1px solid #E2E8F0;
      border-radius: 16px;
      padding: 28px;
      box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.04);
    }
    .rfq-panel-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding-bottom: 16px;
      border-bottom: 1px solid #E2E8F0;
      margin-bottom: 20px;
    }
    .rfq-panel-title {
      font-size: 18px;
      font-weight: 800;
      color: #0F172A;
      margin: 0;
    }
    .rfq-clear-btn {
      background: none;
      border: none;
      color: #EF4444;
      font-size: 13px;
      font-weight: 600;
      cursor: pointer;
      padding: 4px 8px;
    }
    .rfq-clear-btn:hover {
      text-decoration: underline;
    }

    .rfq-table {
      width: 100%;
      border-collapse: collapse;
    }
    .rfq-table th {
      text-align: left;
      font-size: 12px;
      font-weight: 700;
      text-transform: uppercase;
      color: #64748B;
      padding: 10px 14px;
      background: #F8FAFC;
      border-bottom: 1px solid #E2E8F0;
    }
    .rfq-table td {
      padding: 16px 14px;
      border-bottom: 1px solid #F1F5F9;
      vertical-align: middle;
      font-size: 14px;
    }
    .rfq-item-product {
      display: flex;
      align-items: center;
      gap: 14px;
    }
    .rfq-item-img {
      width: 56px;
      height: 56px;
      object-fit: contain;
      border-radius: 8px;
      border: 1px solid #E2E8F0;
      background: #F8FAFC;
      padding: 4px;
      flex-shrink: 0;
    }
    .rfq-item-name {
      font-weight: 700;
      color: #0F172A;
      margin-bottom: 4px;
      line-height: 1.35;
    }
    .rfq-item-meta {
      font-size: 12px;
      color: #64748B;
    }

    /* Stepper */
    .rfq-qty-stepper {
      display: inline-flex;
      align-items: center;
      border: 1px solid #CBD5E1;
      border-radius: 8px;
      overflow: hidden;
      background: #FFFFFF;
    }
    .rfq-stepper-btn {
      background: #F8FAFC;
      border: none;
      width: 32px;
      height: 32px;
      font-size: 16px;
      font-weight: 700;
      color: #334155;
      cursor: pointer;
      display: flex;
      align-items: center;
      justify-content: center;
      transition: background 0.15s;
    }
    .rfq-stepper-btn:hover {
      background: #E2E8F0;
    }
    .rfq-qty-input {
      width: 48px;
      height: 32px;
      text-align: center;
      border: none;
      font-size: 13px;
      font-weight: 700;
      color: #0F172A;
      outline: none;
    }

    .rfq-remove-btn {
      color: #94A3B8;
      background: none;
      border: none;
      font-size: 18px;
      cursor: pointer;
      padding: 4px;
      transition: color 0.15s;
    }
    .rfq-remove-btn:hover {
      color: #EF4444;
    }

    /* Form Panel */
    .rfq-form-panel {
      background: #FFFFFF;
      border: 1px solid #E2E8F0;
      border-radius: 16px;
      padding: 28px;
      box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.04);
      position: sticky;
      top: 100px;
    }
    .rfq-form-header {
      margin-bottom: 20px;
      padding-bottom: 14px;
      border-bottom: 1px solid #E2E8F0;
    }
    .rfq-form-title {
      font-size: 18px;
      font-weight: 800;
      color: #0F172A;
      margin: 0 0 6px 0;
    }
    .rfq-form-desc {
      font-size: 13px;
      color: #64748B;
      margin: 0;
      line-height: 1.45;
    }

    .rfq-form-group {
      margin-bottom: 14px;
    }
    .rfq-form-label {
      display: block;
      font-size: 12.5px;
      font-weight: 700;
      color: #334155;
      margin-bottom: 6px;
    }
    .rfq-form-control {
      width: 100%;
      padding: 10px 14px;
      border: 1px solid #CBD5E1;
      border-radius: 8px;
      font-size: 13.5px;
      color: #0F172A;
      outline: none;
      box-sizing: border-box;
      transition: border-color 0.2s;
    }
    .rfq-form-control:focus {
      border-color: var(--mvg-brand);
      box-shadow: 0 0 0 3px rgba(2, 132, 199, 0.15);
    }
    .rfq-form-row {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 12px;
    }

    .rfq-price-summary {
      background: #F8FAFC;
      border-radius: 10px;
      padding: 16px;
      margin: 20px 0;
      border: 1px solid #E2E8F0;
    }
    .rfq-summary-row {
      display: flex;
      justify-content: space-between;
      font-size: 13.5px;
      color: #475569;
      margin-bottom: 8px;
    }
    .rfq-summary-row.total {
      font-size: 16px;
      font-weight: 800;
      color: #0F172A;
      border-top: 1px dashed #CBD5E1;
      padding-top: 10px;
      margin-top: 10px;
      margin-bottom: 0;
    }

    .rfq-submit-btn {
      width: 100%;
      background: var(--mvg-brand);
      color: #FFFFFF;
      font-weight: 800;
      font-size: 15px;
      padding: 14px 20px;
      border-radius: 10px;
      border: none;
      cursor: pointer;
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 8px;
      transition: all 0.2s;
    }
    .rfq-submit-btn:hover {
      background: #0369A1;
      transform: translateY(-1px);
      box-shadow: 0 4px 12px rgba(2, 132, 199, 0.35);
    }
    .rfq-wa-btn {
      width: 100%;
      background: #25D366;
      color: #FFFFFF;
      font-weight: 700;
      font-size: 14px;
      padding: 12px 18px;
      border-radius: 10px;
      border: none;
      cursor: pointer;
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 8px;
      margin-top: 10px;
      text-decoration: none;
      transition: all 0.2s;
    }
    .rfq-wa-btn:hover {
      background: #1EBE5D;
    }

    .rfq-empty-state {
      text-align: center;
      padding: 60px 20px;
    }
    .rfq-empty-icon {
      font-size: 54px;
      margin-bottom: 16px;
    }
    .rfq-empty-title {
      font-size: 20px;
      font-weight: 800;
      color: #0F172A;
      margin-bottom: 8px;
    }
    .rfq-empty-sub {
      color: #64748B;
      font-size: 14px;
      margin-bottom: 24px;
      max-width: 440px;
      margin-left: auto;
      margin-right: auto;
    }
  </style>
</head>
<body>

  <!-- Modular Site Header -->
  <header class="mvg-site-header">
    <?php include __DIR__ . '/includes/header.php'; ?>
  </header>

  <!-- Hero Header -->
  <section class="rfq-cart-hero">
    <div class="mvg-header-container">
      <nav class="breadcrumb-trail" aria-label="Breadcrumb">
        <a href="index.php">Home</a>
        <span class="sep">›</span>
        <a href="collections.php">Collections</a>
        <span class="sep">›</span>
        <span class="current">Inquiry Basket &amp; RFQ</span>
      </nav>

      <div style="margin-top: 14px;">
        <span class="rfq-cart-badge">📋 B2B WHOLESALE QUOTATION</span>
        <h1 class="rfq-cart-title">Commercial Inquiry &amp; RFQ Basket</h1>
        <p class="rfq-cart-sub">
          Review your selected current transformer models and request a formal B2B proforma quotation with 18% GST Input Tax Credit, bulk tier discounts, and dispatch timelines.
        </p>
      </div>
    </div>
  </section>

  <!-- Main RFQ Layout -->
  <main class="mvg-header-container rfq-layout">

    <!-- Left: Cart Items Table -->
    <div class="rfq-items-panel">
      
      <div class="rfq-panel-header">
        <h2 class="rfq-panel-title">
          <span>Requested Current Transformers</span>
          <span id="rfqItemCountBadge" style="font-size: 13px; font-weight: 700; color: var(--mvg-brand); background: var(--mvg-brand-lt); padding: 2px 8px; border-radius: 6px; margin-left: 8px;">0 Models</span>
        </h2>
        <button type="button" class="rfq-clear-btn" onclick="clearRfqCart()">Clear Basket</button>
      </div>

      <!-- Empty Cart Notice -->
      <div class="rfq-empty-state" id="rfqEmptyState" style="display:none;">
        <div class="rfq-empty-icon">🛒</div>
        <h3 class="rfq-empty-title">Your Inquiry Basket is Empty</h3>
        <p class="rfq-empty-sub">Explore our certified current transformers and add models to generate an official quotation request.</p>
        <a href="collections.php" class="btn btn-primary" style="padding: 12px 24px; border-radius: 8px;">Explore Current Transformer Collection &rarr;</a>
      </div>

      <!-- Cart Items Table -->
      <div id="rfqTableContainer">
        <table class="rfq-table">
          <thead>
            <tr>
              <th>Transformer Model</th>
              <th>Unit Rate</th>
              <th style="width: 140px;">Quantity (MOQ 10)</th>
              <th>Est. Subtotal</th>
              <th></th>
            </tr>
          </thead>
          <tbody id="rfqTableBody">
            <!-- Dynamically populated via JS -->
          </tbody>
        </table>
      </div>

      <div style="margin-top: 24px; padding-top: 20px; border-top: 1px solid #E2E8F0; display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 12px;">
        <a href="collections.php" style="color: var(--mvg-brand); font-weight: 700; text-decoration: none; font-size: 14px;">
          ← Add More Transformers from Catalog
        </a>
        <span style="font-size: 12.5px; color: #64748B;">
          🔒 All quotations prepared under ISO 9001:2015 &amp; IS 2705 calibration standards.
        </span>
      </div>

    </div>

    <!-- Right: Buyer Information & RFQ Submission Form -->
    <div class="rfq-form-panel">
      <div class="rfq-form-header">
        <h3 class="rfq-form-title">Quotation &amp; GST Details</h3>
        <p class="rfq-form-desc">Provide your business details for official Proforma Invoice &amp; GST Input Tax Credit generation.</p>
      </div>

      <form id="rfqSubmissionForm" onsubmit="handleRfqSubmit(event)">
        
        <div class="rfq-form-group">
          <label class="rfq-form-label" for="rfqCompanyName">Company Legal Name *</label>
          <input type="text" id="rfqCompanyName" class="rfq-form-control" placeholder="e.g. Apex Switchboards Pvt Ltd" required>
        </div>

        <div class="rfq-form-group">
          <label class="rfq-form-label" for="rfqCustomerName">Authorized Contact Person *</label>
          <input type="text" id="rfqCustomerName" class="rfq-form-control" placeholder="e.g. Rajesh Sharma" required>
        </div>

        <div class="rfq-form-row">
          <div class="rfq-form-group">
            <label class="rfq-form-label" for="rfqPhone">Phone / WhatsApp *</label>
            <input type="tel" id="rfqPhone" class="rfq-form-control" placeholder="+91 98765 43210" required>
          </div>
          <div class="rfq-form-group">
            <label class="rfq-form-label" for="rfqEmail">Work Email</label>
            <input type="email" id="rfqEmail" class="rfq-form-control" placeholder="purchase@company.com">
          </div>
        </div>

        <div class="rfq-form-group">
          <label class="rfq-form-label" for="rfqGstin">GSTIN (For 18% Tax Credit)</label>
          <input type="text" id="rfqGstin" class="rfq-form-control" placeholder="07AAAAA0000A1Z5" style="text-transform: uppercase;">
        </div>

        <div class="rfq-form-row">
          <div class="rfq-form-group">
            <label class="rfq-form-label" for="rfqCity">Delivery City *</label>
            <input type="text" id="rfqCity" class="rfq-form-control" placeholder="e.g. New Delhi / Ahmedabad" required>
          </div>
          <div class="rfq-form-group">
            <label class="rfq-form-label" for="rfqPincode">Pincode</label>
            <input type="text" id="rfqPincode" class="rfq-form-control" placeholder="e.g. 110020">
          </div>
        </div>

        <div class="rfq-form-group">
          <label class="rfq-form-label" for="rfqUrgency">Required Delivery Timeline</label>
          <select id="rfqUrgency" class="rfq-form-control">
            <option value="immediate">Immediate Dispatch (Delhi NCR Central Depot)</option>
            <option value="1_week">Within 7 Days</option>
            <option value="15_days">Within 15 Days</option>
            <option value="regular_contract">Annual Rate Supply Contract</option>
          </select>
        </div>

        <div class="rfq-form-group">
          <label class="rfq-form-label" for="rfqNotes">Special Requirements / Busbar Notes</label>
          <textarea id="rfqNotes" class="rfq-form-control" rows="2" placeholder="e.g. Special burden (15VA), 1A secondary output, or specific busbar dimensions..."></textarea>
        </div>

        <!-- Price Summary Box -->
        <div class="rfq-price-summary">
          <div class="rfq-summary-row">
            <span>Estimated Subtotal:</span>
            <strong id="rfqSummarySubtotal">₹0</strong>
          </div>
          <div class="rfq-summary-row">
            <span>GST (18% Input Tax Credit):</span>
            <span id="rfqSummaryGst">₹0</span>
          </div>
          <div class="rfq-summary-row total">
            <span>Total Quotation Estimate:</span>
            <span id="rfqSummaryTotal" style="color: var(--mvg-brand);">₹0</span>
          </div>
        </div>

        <button type="submit" class="rfq-submit-btn" id="rfqSubmitBtn">
          <span>Submit Official Quotation Request &rarr;</span>
        </button>

        <a href="javascript:void(0)" onclick="sendWhatsAppRfq()" class="rfq-wa-btn">
          <span>💬 Send Inquiry on WhatsApp Direct</span>
        </a>

      </form>
    </div>

  </main>

  <!-- Modular Modals & Slide-Over Drawer -->
  <?php include __DIR__ . '/includes/cart-drawer.php'; ?>
  <?php include __DIR__ . '/includes/footer.php'; ?>

  <!-- Scripts -->
  <script src="js/header.js"></script>
  <script src="js/products.js"></script>
  <script>
    // RFQ Basket Controller
    let rfqCart = JSON.parse(localStorage.getItem('mvg_cart') || '{}');
    const allProducts = window.MVG_PRODUCTS || [];
    const productMap = {};
    allProducts.forEach(p => productMap[p.id] = p);

    function formatInr(num) {
      return '₹' + Math.round(num).toLocaleString('en-IN');
    }

    function renderRfqTable() {
      const tableBody = document.getElementById('rfqTableBody');
      const tableContainer = document.getElementById('rfqTableContainer');
      const emptyState = document.getElementById('rfqEmptyState');
      const itemCountBadge = document.getElementById('rfqItemCountBadge');
      const submitBtn = document.getElementById('rfqSubmitBtn');

      const itemIds = Object.keys(rfqCart).filter(id => rfqCart[id] > 0);

      if (itemIds.length === 0) {
        if (tableContainer) tableContainer.style.display = 'none';
        if (emptyState) emptyState.style.display = 'block';
        if (itemCountBadge) itemCountBadge.textContent = '0 Models';
        if (submitBtn) submitBtn.disabled = true;
        updateSummary(0);
        return;
      }

      if (tableContainer) tableContainer.style.display = 'block';
      if (emptyState) emptyState.style.display = 'none';
      if (submitBtn) submitBtn.disabled = false;
      if (itemCountBadge) itemCountBadge.textContent = `${itemIds.length} Models`;

      let subtotal = 0;
      let html = '';

      itemIds.forEach(id => {
        const p = productMap[id] || { id: id, name: 'Current Transformer #' + id, price: 280, image: 'assets/categories/encapsulated-ring-ct.jpg', categoryName: 'Current Transformer' };
        const qty = rfqCart[id];
        const lineTotal = qty * p.price;
        subtotal += lineTotal;

        html += `
          <tr>
            <td>
              <div class="rfq-item-product">
                <img src="${p.image}" alt="${p.name}" class="rfq-item-img" />
                <div>
                  <div class="rfq-item-name">${p.name}</div>
                  <div class="rfq-item-meta">${p.categoryName} • Class 1.0</div>
                </div>
              </div>
            </td>
            <td><strong>${formatInr(p.price)}</strong></td>
            <td>
              <div class="rfq-qty-stepper">
                <button type="button" class="rfq-stepper-btn" onclick="updateRfqQty(${id}, -1)">−</button>
                <input type="number" class="rfq-qty-input" value="${qty}" min="10" step="1" onchange="setRfqQty(${id}, this.value)" />
                <button type="button" class="rfq-stepper-btn" onclick="updateRfqQty(${id}, 1)">+</button>
              </div>
            </td>
            <td><strong>${formatInr(lineTotal)}</strong></td>
            <td>
              <button type="button" class="rfq-remove-btn" onclick="removeRfqItem(${id})" title="Remove model">✕</button>
            </td>
          </tr>
        `;
      });

      if (tableBody) tableBody.innerHTML = html;
      updateSummary(subtotal);
    }

    function updateSummary(subtotal) {
      const gst = subtotal * 0.18;
      const total = subtotal + gst;

      document.getElementById('rfqSummarySubtotal').textContent = formatInr(subtotal);
      document.getElementById('rfqSummaryGst').textContent = formatInr(gst);
      document.getElementById('rfqSummaryTotal').textContent = formatInr(total);
    }

    function updateRfqQty(id, delta) {
      const current = rfqCart[id] || 10;
      const updated = Math.max(10, current + delta);
      rfqCart[id] = updated;
      saveCart();
      renderRfqTable();
    }

    function setRfqQty(id, val) {
      const parsed = Math.max(10, parseInt(val, 10) || 10);
      rfqCart[id] = parsed;
      saveCart();
      renderRfqTable();
    }

    function removeRfqItem(id) {
      delete rfqCart[id];
      saveCart();
      renderRfqTable();
    }

    function clearRfqCart() {
      if (confirm('Are you sure you want to clear your inquiry basket?')) {
        rfqCart = {};
        saveCart();
        renderRfqTable();
      }
    }

    function saveCart() {
      localStorage.setItem('mvg_cart', JSON.stringify(rfqCart));
      const badge = document.querySelector('.mvg-cart-badge');
      if (badge) {
        const total = Object.values(rfqCart).reduce((a, b) => a + b, 0);
        badge.textContent = total;
      }
    }

    async function handleRfqSubmit(e) {
      e.preventDefault();
      const submitBtn = document.getElementById('rfqSubmitBtn');
      const itemIds = Object.keys(rfqCart).filter(id => rfqCart[id] > 0);

      if (itemIds.length === 0) {
        alert('Please add at least one current transformer to your inquiry basket.');
        return;
      }

      const items = itemIds.map(id => {
        const p = productMap[id] || { id: id, name: 'Current Transformer #' + id, price: 280, sku: '' };
        return {
          product_id: p.id,
          product_name: p.name,
          sku: p.sku || '',
          quantity: rfqCart[id],
          unit_price: p.price
        };
      });

      const payload = {
        company_name: document.getElementById('rfqCompanyName').value.trim(),
        customer_name: document.getElementById('rfqCustomerName').value.trim(),
        phone: document.getElementById('rfqPhone').value.trim(),
        email: document.getElementById('rfqEmail').value.trim(),
        gstin: document.getElementById('rfqGstin').value.trim(),
        city: document.getElementById('rfqCity').value.trim(),
        pincode: document.getElementById('rfqPincode').value.trim(),
        delivery_urgency: document.getElementById('rfqUrgency').value,
        notes: document.getElementById('rfqNotes').value.trim(),
        items: items
      };

      submitBtn.disabled = true;
      submitBtn.textContent = 'Submitting Quotation Request...';

      try {
        const res = await fetch('api/submit-inquiry.php', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(payload)
        });
        const data = await res.json();

        if (data.success) {
          // Clear cart on success
          rfqCart = {};
          saveCart();
          window.location.href = data.redirect_url;
        } else {
          alert('Error: ' + (data.message || 'Unable to submit quotation.'));
          submitBtn.disabled = false;
          submitBtn.textContent = 'Submit Official Quotation Request →';
        }
      } catch (err) {
        alert('Submission failed. Please check your connection or contact our sales desk.');
        submitBtn.disabled = false;
        submitBtn.textContent = 'Submit Official Quotation Request →';
      }
    }

    function sendWhatsAppRfq() {
      const company = document.getElementById('rfqCompanyName').value.trim();
      const name = document.getElementById('rfqCustomerName').value.trim();
      const phone = document.getElementById('rfqPhone').value.trim();
      const city = document.getElementById('rfqCity').value.trim();
      const itemIds = Object.keys(rfqCart).filter(id => rfqCart[id] > 0);

      let msg = `Hello MVG Power Solutions,\n\nI want to request an official quotation for the following Current Transformers:\n\n`;
      if (company) msg += `• Company: ${company}\n`;
      if (name) msg += `• Contact: ${name}\n`;
      if (city) msg += `• Location: ${city}\n\n`;

      if (itemIds.length === 0) {
        msg += `(General catalog inquiry)\n`;
      } else {
        itemIds.forEach((id, idx) => {
          const p = productMap[id] || { name: 'CT #' + id };
          msg += `${idx + 1}. ${p.name} — ${rfqCart[id]} pcs\n`;
        });
      }

      msg += `\nPlease share proforma invoice with 18% GST and dispatch timeline.`;
      window.open(`https://wa.me/<?php echo WHATSAPP_NUMBER; ?>?text=${encodeURIComponent(msg)}`, '_blank');
    }

    document.addEventListener('DOMContentLoaded', renderRfqTable);
  </script>
</body>
</html>

<?php
/**
 * MVG Power Solutions — Quotation & Inquiry Tracking Portal
 */

require_once __DIR__ . '/config/constants.php';
require_once __DIR__ . '/config/db.php';
require_once __DIR__ . '/config/settings.php';

$searchRfq = trim($_GET['rfq'] ?? '');
$pageTitle = "Track Quotation & Inquiry Status | " . SITE_NAME;
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title><?php echo htmlspecialchars($pageTitle); ?></title>
  <link rel="stylesheet" href="css/style.css">
  <style>
    .track-hero {
      background: linear-gradient(135deg, #0F172A 0%, #1E293B 100%);
      color: #FFFFFF;
      padding: 44px 0 52px 0;
      text-align: center;
    }
    .track-title {
      font-size: 32px;
      font-weight: 900;
      margin-bottom: 8px;
    }
    .track-sub {
      color: #94A3B8;
      font-size: 15px;
      max-width: 600px;
      margin: 0 auto;
    }

    .track-box {
      max-width: 680px;
      margin: -24px auto 60px auto;
      background: #FFFFFF;
      border: 1px solid #E2E8F0;
      border-radius: 16px;
      padding: 24px;
      box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.08);
      position: relative;
      z-index: 2;
    }
    .track-input-group {
      display: flex;
      gap: 10px;
    }
    .track-input {
      flex: 1;
      padding: 12px 16px;
      border: 1px solid #CBD5E1;
      border-radius: 8px;
      font-size: 15px;
      outline: none;
    }
    .track-input:focus {
      border-color: var(--mvg-brand);
      box-shadow: 0 0 0 3px rgba(2, 132, 199, 0.15);
    }
    .track-btn {
      background: var(--mvg-brand);
      color: #FFFFFF;
      font-weight: 700;
      border: none;
      padding: 12px 24px;
      border-radius: 8px;
      cursor: pointer;
      font-size: 14px;
    }

    .track-result-panel {
      max-width: 680px;
      margin: 0 auto 80px auto;
      background: #FFFFFF;
      border: 1px solid #E2E8F0;
      border-radius: 16px;
      padding: 32px;
      box-shadow: 0 4px 6px -1px rgba(0,0,0,0.04);
      display: none;
    }
    .status-badge {
      display: inline-block;
      padding: 6px 14px;
      border-radius: 9999px;
      font-size: 12px;
      font-weight: 800;
      text-transform: uppercase;
      letter-spacing: 0.5px;
    }
    .status-new { background: #FEF3C7; color: #92400E; }
    .status-contacted { background: #DBEAFE; color: #1E40AF; }
    .status-quoted { background: #EDE9FE; color: #5B21B6; }
    .status-converted { background: #D1FAE5; color: #065F46; }
  </style>
</head>
<body>

  <!-- Modular Site Header -->
  <header class="mvg-site-header"><?php include __DIR__ . '/includes/header.php'; ?></header>

  <section class="track-hero">
    <div class="mvg-header-container">
      <h1 class="track-title">Track RFQ &amp; Quotation Status</h1>
      <p class="track-sub">Enter your quotation reference number to check the engineering review, pricing approval, or dispatch status.</p>
    </div>
  </section>

  <div class="mvg-header-container">
    <div class="track-box">
      <form id="trackForm" onsubmit="handleTrack(event)">
        <div class="track-input-group">
          <input 
            type="text" 
            id="trackRfqInput" 
            class="track-input" 
            placeholder="Enter RFQ Reference ID (e.g. RFQ-2026-1001)" 
            value="<?php echo htmlspecialchars($searchRfq); ?>"
            required
          />
          <button type="submit" class="track-btn">Track Status</button>
        </div>
      </form>
    </div>

    <!-- Results Panel -->
    <div class="track-result-panel" id="trackResultPanel">
      <div style="display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #E2E8F0; padding-bottom: 16px; margin-bottom: 20px;">
        <div>
          <span style="font-size: 12px; font-weight: 700; color: #64748B; text-transform: uppercase;">Quotation Reference</span>
          <h2 id="resRfq" style="font-size: 22px; font-weight: 900; color: #0F172A; margin: 2px 0 0 0;"></h2>
        </div>
        <div id="resStatusBadge" class="status-badge status-new">Pending</div>
      </div>

      <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px; margin-bottom: 24px;">
        <div>
          <span style="font-size: 12px; color: #64748B;">Client / Company</span>
          <div id="resCustomer" style="font-weight: 700; color: #0F172A; font-size: 14px;"></div>
        </div>
        <div>
          <span style="font-size: 12px; color: #64748B;">Submission Date</span>
          <div id="resDate" style="font-weight: 700; color: #0F172A; font-size: 14px;"></div>
        </div>
      </div>

      <h3 style="font-size: 15px; font-weight: 800; color: #0F172A; margin-bottom: 12px;">Requested Models</h3>
      <div id="resItemsList" style="border: 1px solid #E2E8F0; border-radius: 8px; overflow: hidden; margin-bottom: 24px;">
        <!-- Items injected here -->
      </div>

      <div style="text-align: center;">
        <a id="resWhatsAppLink" href="#" target="_blank" class="btn" style="background: #25D366; color: #FFFFFF; font-weight: 800; padding: 12px 22px; border-radius: 8px; text-decoration: none;">
          💬 Connect with Assigned Sales Engineer
        </a>
      </div>
    </div>
  </div>

  <?php include __DIR__ . '/includes/footer.php'; ?>

  <script>
    async function handleTrack(e) {
      if (e) e.preventDefault();
      const rfq = document.getElementById('trackRfqInput').value.trim();
      if (!rfq) return;

      const panel = document.getElementById('trackResultPanel');

      try {
        const res = await fetch(`api/track-status.php?rfq=${encodeURIComponent(rfq)}`);
        const data = await res.json();

        if (data.success && data.data) {
          const d = data.data;
          document.getElementById('resRfq').textContent = d.rfq_number;
          document.getElementById('resCustomer').textContent = d.customer_name + (d.company_name ? ` (${d.company_name})` : '');
          document.getElementById('resDate').textContent = d.created_at;

          const badge = document.getElementById('resStatusBadge');
          badge.textContent = d.status.toUpperCase();
          badge.className = 'status-badge status-' + d.status;

          const itemsWrap = document.getElementById('resItemsList');
          if (d.items && d.items.length > 0) {
            itemsWrap.innerHTML = d.items.map(it => `
              <div style="padding: 12px 16px; border-bottom: 1px solid #F1F5F9; display: flex; justify-content: space-between; align-items: center; font-size: 13.5px;">
                <span><strong>${it.product_name}</strong></span>
                <span style="font-weight: 700; color: var(--mvg-brand);">${it.quantity} Pcs</span>
              </div>
            `).join('');
          } else {
            itemsWrap.innerHTML = `<div style="padding: 12px 16px; color: #64748B; font-size: 13px;">Standard Catalog Inquiry</div>`;
          }

          document.getElementById('resWhatsAppLink').href = `https://wa.me/<?php echo WHATSAPP_NUMBER; ?>?text=Hello%20MVG,%20I%20am%20checking%20status%20for%20${encodeURIComponent(d.rfq_number)}`;
          panel.style.display = 'block';
        } else {
          alert(data.message || 'No quotation request found.');
          panel.style.display = 'none';
        }
      } catch (err) {
        alert('Tracking request failed. Please check connection.');
      }
    }

    // Auto-search if rfq in query
    document.addEventListener('DOMContentLoaded', () => {
      const initial = document.getElementById('trackRfqInput').value.trim();
      if (initial) handleTrack();
    });
  </script>
</body>
</html>

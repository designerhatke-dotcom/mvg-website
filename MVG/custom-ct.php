<?php
/**
 * MVG Power Solutions — Custom Current Transformer Design & Engineering RFQ
 */

require_once __DIR__ . '/config/constants.php';
require_once __DIR__ . '/config/settings.php';

$pageTitle = "Custom Current Transformers & OEM Solutions | " . SITE_NAME;
$pageDesc = "Request custom engineered Current Transformers (30A to 5000A, 1A/5A secondary, Class 0.2s/0.5/1.0/5P10, bespoke busbar dimensions) manufactured to IS 2705 and IEC 61869-2 standards.";
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title><?php echo htmlspecialchars($pageTitle); ?></title>
  <meta name="description" content="<?php echo htmlspecialchars($pageDesc); ?>">
  <link rel="stylesheet" href="css/style.css">
  <style>
    .custom-hero {
      background: linear-gradient(135deg, #0F172A 0%, #1E293B 100%);
      color: #FFFFFF;
      padding: 56px 0 64px 0;
      border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    }
    .custom-layout {
      display: grid;
      grid-template-columns: 1fr 480px;
      gap: 40px;
      padding: 60px 0 90px 0;
    }
    @media (max-width: 991px) {
      .custom-layout {
        grid-template-columns: 1fr;
      }
    }
    .spec-card {
      background: #FFFFFF;
      border: 1px solid #E2E8F0;
      border-radius: 16px;
      padding: 32px;
      box-shadow: 0 4px 6px -1px rgba(0,0,0,0.04);
    }
    .form-group {
      margin-bottom: 16px;
    }
    .form-label {
      display: block;
      font-size: 13px;
      font-weight: 700;
      color: #334155;
      margin-bottom: 6px;
    }
    .form-control {
      width: 100%;
      padding: 10px 14px;
      border: 1px solid #CBD5E1;
      border-radius: 8px;
      font-size: 14px;
      box-sizing: border-box;
      outline: none;
    }
    .form-control:focus {
      border-color: var(--mvg-brand);
      box-shadow: 0 0 0 3px rgba(2, 132, 199, 0.15);
    }
    .form-row {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 14px;
    }
    .capability-item {
      display: flex;
      gap: 14px;
      margin-bottom: 24px;
    }
    .cap-icon {
      width: 44px;
      height: 44px;
      border-radius: 10px;
      background: #E0F2FE;
      color: var(--mvg-brand);
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 22px;
      flex-shrink: 0;
    }
  </style>
</head>
<body>

  <header class="mvg-site-header"><?php include __DIR__ . '/includes/header.php'; ?></header>

  <section class="custom-hero">
    <div class="mvg-header-container">
      <nav class="breadcrumb-trail" aria-label="Breadcrumb">
        <a href="index.php">Home</a>
        <span class="sep">›</span>
        <span class="current">Custom CT Engineering</span>
      </nav>
      <div style="margin-top: 14px;">
        <span class="collection-hero-badge">📐 OEM &amp; BESPOKE ELECTRICAL SOLUTIONS</span>
        <h1 class="collection-hero-h1">Custom Current Transformer Manufacturing</h1>
        <p class="collection-hero-lead">
          MVG Power Solutions designs and manufactures custom primary ratios (30A–4000A), 1A secondary outputs, dual ratios, protection classes (5P10, 10P10), and custom busbar window apertures for switchboard builders and panel OEMs across India.
        </p>
      </div>
    </div>
  </section>

  <main class="mvg-header-container custom-layout">
    
    <!-- Left: Engineering Capabilities -->
    <div>
      <h2 style="font-size: 24px; font-weight: 900; color: #0F172A; margin-bottom: 24px;">Factory Customization Capabilities</h2>
      
      <div class="capability-item">
        <div class="cap-icon">⚡</div>
        <div>
          <h3 style="font-size: 16px; font-weight: 800; color: #0F172A; margin-bottom: 4px;">Non-Standard Primary Ratios</h3>
          <p style="font-size: 13.5px; color: #64748B; margin: 0; line-height: 1.5;">
            Custom primary ratings: 30A, 40A, 60A, 75A, 125A, 350A, 750A, 1500A, 2500A, up to 4000A. Exact turns matching for sensitive protection relays.
          </p>
        </div>
      </div>

      <div class="capability-item">
        <div class="cap-icon">🎯</div>
        <div>
          <h3 style="font-size: 16px; font-weight: 800; color: #0F172A; margin-bottom: 4px;">Secondary Currents: 1A &amp; 5A</h3>
          <p style="font-size: 13.5px; color: #64748B; margin: 0; line-height: 1.5;">
            1 Ampere secondary CTs for long-distance cable runs minimizing burden losses, and standard 5 Ampere outputs for switchboard digital meters.
          </p>
        </div>
      </div>

      <div class="capability-item">
        <div class="cap-icon">📐</div>
        <div>
          <h3 style="font-size: 16px; font-weight: 800; color: #0F172A; margin-bottom: 4px;">Custom Busbar &amp; Cable Windows</h3>
          <p style="font-size: 13.5px; color: #64748B; margin: 0; line-height: 1.5;">
            Rectangular busbar apertures up to 120x30mm, multi-bar windows, and toroidal ring cable openings from 25mm to 160mm.
          </p>
        </div>
      </div>

      <div class="capability-item">
        <div class="cap-icon">🛡️</div>
        <div>
          <h3 style="font-size: 16px; font-weight: 800; color: #0F172A; margin-bottom: 4px;">Protection &amp; Class 0.2S Precision</h3>
          <p style="font-size: 13.5px; color: #64748B; margin: 0; line-height: 1.5;">
            Protection CTs (Class 5P10, 5P20, 10P10) for differential and overcurrent relays, and high-accuracy Class 0.2S for tariff sub-metering.
          </p>
        </div>
      </div>

      <div class="capability-item">
        <div class="cap-icon">🏭</div>
        <div>
          <h3 style="font-size: 16px; font-weight: 800; color: #0F172A; margin-bottom: 4px;">Rapid Prototyping (Delhi NCR Facility)</h3>
          <p style="font-size: 13.5px; color: #64748B; margin: 0; line-height: 1.5;">
            CAD drawings and sample prototype CTs manufactured within 3 to 5 business days for panel builder approvals.
          </p>
        </div>
      </div>
    </div>

    <!-- Right: Custom RFQ Form -->
    <div class="spec-card">
      <h3 style="font-size: 20px; font-weight: 800; color: #0F172A; margin-bottom: 6px;">Request Custom CT Engineering Quote</h3>
      <p style="font-size: 13px; color: #64748B; margin-bottom: 20px;">Submit your transformer ratings and our chief electrical design engineer will evaluate your specs.</p>

      <form id="customRfqForm" onsubmit="handleCustomRfq(event)">
        
        <div class="form-row">
          <div class="form-group">
            <label class="form-label" for="cPrimary">Primary Current (A) *</label>
            <input type="text" id="cPrimary" class="form-control" placeholder="e.g. 750A or 125A" required>
          </div>
          <div class="form-group">
            <label class="form-label" for="cSecondary">Secondary Output *</label>
            <select id="cSecondary" class="form-control">
              <option value="5A">5A (Standard)</option>
              <option value="1A">1A (Long Distance)</option>
              <option value="dual_5A_1A">Dual Ratio (5A / 1A)</option>
            </select>
          </div>
        </div>

        <div class="form-row">
          <div class="form-group">
            <label class="form-label" for="cClass">Accuracy Class</label>
            <select id="cClass" class="form-control">
              <option value="Class 1.0">Class 1.0 (Commercial Metering)</option>
              <option value="Class 0.5">Class 0.5 (Precision LT Metering)</option>
              <option value="Class 0.5S">Class 0.5S (Tariff / Auditing)</option>
              <option value="Class 0.2S">Class 0.2S (High Precision)</option>
              <option value="5P10">5P10 (Protection Relay)</option>
              <option value="10P10">10P10 (Protection Relay)</option>
            </select>
          </div>
          <div class="form-group">
            <label class="form-label" for="cBurden">Rated Burden (VA)</label>
            <select id="cBurden" class="form-control">
              <option value="2.5 VA">2.5 VA</option>
              <option value="5 VA">5 VA (Standard)</option>
              <option value="10 VA">10 VA</option>
              <option value="15 VA">15 VA</option>
              <option value="30 VA">30 VA</option>
            </select>
          </div>
        </div>

        <div class="form-row">
          <div class="form-group">
            <label class="form-label" for="cWindow">Window Geometry</label>
            <select id="cWindow" class="form-control">
              <option value="Round Cable">Round Cable Ring</option>
              <option value="Rectangular Busbar">Rectangular Busbar</option>
              <option value="Square Window">Square Window</option>
              <option value="Split Core">Split Core (Retrofit)</option>
            </select>
          </div>
          <div class="form-group">
            <label class="form-label" for="cDimension">Busbar / Hole Size</label>
            <input type="text" id="cDimension" class="form-control" placeholder="e.g. 60x10 mm or 50mm ID">
          </div>
        </div>

        <div class="form-row">
          <div class="form-group">
            <label class="form-label" for="cQty">Quantity (Units) *</label>
            <input type="number" id="cQty" class="form-control" value="10" min="1" required>
          </div>
          <div class="form-group">
            <label class="form-label" for="cTimeline">Required Delivery</label>
            <select id="cTimeline" class="form-control">
              <option value="Urgent (3-5 Days)">Urgent (3-5 Days)</option>
              <option value="Standard (7-10 Days)">Standard (7-10 Days)</option>
              <option value="Monthly Contract">Monthly Scheduled Supply</option>
            </select>
          </div>
        </div>

        <div class="form-group">
          <label class="form-label" for="cCompany">Company Name *</label>
          <input type="text" id="cCompany" class="form-control" placeholder="e.g. Schneider OEM Partner Ltd" required>
        </div>

        <div class="form-row">
          <div class="form-group">
            <label class="form-label" for="cName">Contact Person *</label>
            <input type="text" id="cName" class="form-control" placeholder="Your Name" required>
          </div>
          <div class="form-group">
            <label class="form-label" for="cPhone">WhatsApp / Mobile *</label>
            <input type="tel" id="cPhone" class="form-control" placeholder="+91 99999 00000" required>
          </div>
        </div>

        <div class="form-group">
          <label class="form-label" for="cNotes">Application Details</label>
          <textarea id="cNotes" class="form-control" rows="2" placeholder="e.g. Incomer feeder monitoring, ambient temperature requirements, or CPRI approval specs..."></textarea>
        </div>

        <button type="submit" class="btn btn-primary w-full" id="cSubmitBtn" style="padding: 14px; font-weight: 800; border-radius: 8px;">
          Submit Custom Specification Request &rarr;
        </button>

      </form>
    </div>

  </main>

  <?php include __DIR__ . '/includes/footer.php'; ?>

  <script>
    async function handleCustomRfq(e) {
      e.preventDefault();
      const btn = document.getElementById('cSubmitBtn');
      btn.disabled = true;
      btn.textContent = 'Submitting Custom Spec...';

      const payload = {
        primary_current: document.getElementById('cPrimary').value.trim(),
        secondary_current: document.getElementById('cSecondary').value,
        accuracy_class: document.getElementById('cClass').value,
        rated_burden: document.getElementById('cBurden').value,
        window_type: document.getElementById('cWindow').value,
        window_dimension: document.getElementById('cDimension').value.trim(),
        quantity: document.getElementById('cQty').value,
        delivery_timeline: document.getElementById('cTimeline').value,
        company_name: document.getElementById('cCompany').value.trim(),
        contact_person: document.getElementById('cName').value.trim(),
        phone: document.getElementById('cPhone').value.trim(),
        application_notes: document.getElementById('cNotes').value.trim()
      };

      try {
        const res = await fetch('api/submit-custom-rfq.php', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(payload)
        });
        const data = await res.json();
        if (data.success) {
          alert('Custom CT specifications registered! Ref: ' + data.rfq_number);
          if (data.whatsapp_url) {
            window.location.href = data.whatsapp_url;
          } else {
            window.location.href = 'inquiry-success.php?rfq=' + encodeURIComponent(data.rfq_number);
          }
        } else {
          alert(data.message || 'Error submitting custom request.');
          btn.disabled = false;
          btn.textContent = 'Submit Custom Specification Request →';
        }
      } catch (err) {
        alert('Submission failed. Please contact our engineering desk.');
        btn.disabled = false;
        btn.textContent = 'Submit Custom Specification Request →';
      }
    }
  </script>
</body>
</html>

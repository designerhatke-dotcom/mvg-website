<?php
/**
 * MVG Power Solutions — About Us
 */

require_once __DIR__ . '/config/constants.php';
require_once __DIR__ . '/config/settings.php';

$pageTitle = "About MVG Power Solutions | Precision Current Transformer Manufacturer";
$pageDesc = "Learn about MVG Power Solutions, premier manufacturer of industrial current transformers, digital meters, and switchgear measuring instruments in New Delhi, India.";
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
    .about-hero {
      background: linear-gradient(135deg, #0F172A 0%, #1E293B 100%);
      color: #FFFFFF;
      padding: 60px 0 72px 0;
      border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    }
    .stats-strip {
      background: #FFFFFF;
      border: 1px solid #E2E8F0;
      border-radius: 16px;
      padding: 30px;
      margin-top: -36px;
      position: relative;
      z-index: 2;
      display: grid;
      grid-template-columns: repeat(4, 1fr);
      gap: 20px;
      box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.05);
      text-align: center;
    }
    @media (max-width: 768px) {
      .stats-strip {
        grid-template-columns: repeat(2, 1fr);
      }
    }
    .stat-val {
      font-size: 32px;
      font-weight: 900;
      color: var(--mvg-brand);
      margin-bottom: 4px;
    }
    .stat-lbl {
      font-size: 13px;
      font-weight: 700;
      color: #475569;
      text-transform: uppercase;
      letter-spacing: 0.5px;
    }
    .about-section {
      padding: 70px 0;
    }
    .grid-2col {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 48px;
      align-items: center;
    }
    @media (max-width: 850px) {
      .grid-2col {
        grid-template-columns: 1fr;
      }
    }
    .pillar-card {
      background: #F8FAFC;
      border: 1px solid #E2E8F0;
      border-radius: 14px;
      padding: 24px;
      margin-bottom: 16px;
    }
  </style>
</head>
<body>

  <header class="mvg-site-header"><?php include __DIR__ . '/includes/header.php'; ?></header>

  <section class="about-hero">
    <div class="mvg-header-container">
      <nav class="breadcrumb-trail" aria-label="Breadcrumb">
        <a href="index.php">Home</a>
        <span class="sep">›</span>
        <span class="current">About Us</span>
      </nav>
      <div style="margin-top: 14px; max-width: 820px;">
        <span class="collection-hero-badge">🏭 FACTORY-DIRECT INDUSTRIAL EXCELLENCE</span>
        <h1 class="collection-hero-h1">Precision Electrical Metering Since 2011</h1>
        <p class="collection-hero-lead">
          MVG Power Solutions is a dedicated manufacturer of certified Current Transformers, Digital Panel Meters, and Switchgear Measuring Equipment. Headquartered in New Delhi, we supply leading CPRI-approved panel builders, electrical switchgear OEMs, and utility contractors across India.
        </p>
      </div>
    </div>
  </section>

  <!-- Performance Stats Strip -->
  <div class="mvg-header-container">
    <div class="stats-strip">
      <div>
        <div class="stat-val">100,000+</div>
        <div class="stat-lbl">CTs Delivered</div>
      </div>
      <div>
        <div class="stat-val">IS 2705</div>
        <div class="stat-lbl">Testing Compliance</div>
      </div>
      <div>
        <div class="stat-val">24 Hours</div>
        <div class="stat-lbl">Delhi NCR Dispatch Hub</div>
      </div>
      <div>
        <div class="stat-val">100%</div>
        <div class="stat-lbl">Routine Ratio Tested</div>
      </div>
    </div>
  </div>

  <main class="about-section">
    <div class="mvg-header-container">
      
      <div class="grid-2col">
        <div>
          <span style="font-size: 12px; font-weight: 800; color: var(--mvg-brand); text-transform: uppercase; letter-spacing: 0.6px;">Manufacturing Integrity</span>
          <h2 style="font-size: 28px; font-weight: 900; color: #0F172A; margin: 8px 0 16px 0;">Built for Rigorous Industrial Switchboards</h2>
          <p style="color: #475569; line-height: 1.7; font-size: 15px; margin-bottom: 16px;">
            At MVG Power Solutions, our production protocols prioritize core permeability and thermal durability. Utilizing premium Cold-Rolled Grain-Oriented (CRGO) electrical silicon steel cores and high-purity electrolytic copper windings, every transformer delivers minimum excitation losses and exceptional saturation margins.
          </p>
          <p style="color: #475569; line-height: 1.7; font-size: 15px; margin-bottom: 24px;">
            Our casings are molded from self-extinguishing, flame-retardant polycarbonate (UL94 V-0 grade) engineered to withstand extreme vibrations and panel fault temperatures.
          </p>
          <a href="collections.php" class="btn btn-primary" style="padding: 12px 24px; border-radius: 8px;">Explore Transformer Catalog &rarr;</a>
        </div>

        <div>
          <div class="pillar-card">
            <h3 style="font-size: 17px; font-weight: 800; color: #0F172A; margin-bottom: 6px;">⚡ IS 2705 &amp; IEC 61869-2 Precision</h3>
            <p style="font-size: 13.5px; color: #64748B; margin: 0; line-height: 1.5;">
              Every batch undergoes strict 100% routine verification: Ratio Error Test, Phase Displacement Test, Polarity Verification, and 3kV Power-Frequency Dielectric Withstand.
            </p>
          </div>

          <div class="pillar-card">
            <h3 style="font-size: 17px; font-weight: 800; color: #0F172A; margin-bottom: 6px;">🏢 Delhi NCR Warehouse Hub</h3>
            <p style="font-size: 13.5px; color: #64748B; margin: 0; line-height: 1.5;">
              Our centralized facility in Mangolpuri, New Delhi maintains continuous stock of over 40 standard ratings (50/5A to 4000/5A) for same-day dispatch to industrial hubs across North India.
            </p>
          </div>

          <div class="pillar-card">
            <h3 style="font-size: 17px; font-weight: 800; color: #0F172A; margin-bottom: 6px;">🧾 18% GST Input Tax Credit</h3>
            <p style="font-size: 13.5px; color: #64748B; margin: 0; line-height: 1.5;">
              We provide formal tax invoices with authentic GSTIN identification, HSN code 85043100, and complete Input Tax Credit eligibility for corporate accounting.
            </p>
          </div>
        </div>
      </div>

    </div>
  </main>

  <?php include __DIR__ . '/includes/footer.php'; ?>
</body>
</html>

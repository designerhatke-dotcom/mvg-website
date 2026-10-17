<?php
/**
 * MVG Power Solutions — Technical Datasheets & Resource Center
 */

require_once __DIR__ . '/config/constants.php';
require_once __DIR__ . '/config/settings.php';

$pageTitle = "Technical Datasheets & CAD Dimensions | " . SITE_NAME;
$pageDesc = "Download official engineering datasheets, busbar aperture dimensional drawings, and IS 2705 calibration certificates for MVG Current Transformers.";
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
    .doc-hero {
      background: linear-gradient(135deg, #0F172A 0%, #1E293B 100%);
      color: #FFFFFF;
      padding: 56px 0 64px 0;
      border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    }
    .doc-grid {
      display: grid;
      grid-template-columns: repeat(3, 1fr);
      gap: 24px;
      padding: 60px 0 90px 0;
    }
    @media (max-width: 991px) {
      .doc-grid {
        grid-template-columns: repeat(2, 1fr);
      }
    }
    @media (max-width: 600px) {
      .doc-grid {
        grid-template-columns: 1fr;
      }
    }
    .doc-card {
      background: #FFFFFF;
      border: 1px solid #E2E8F0;
      border-radius: 14px;
      padding: 24px;
      box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.04);
      display: flex;
      flex-direction: column;
      justify-content: space-between;
    }
    .doc-type-badge {
      display: inline-block;
      font-size: 11px;
      font-weight: 800;
      padding: 4px 8px;
      border-radius: 6px;
      background: #F1F5F9;
      color: #475569;
      margin-bottom: 12px;
      text-transform: uppercase;
    }
    .doc-title {
      font-size: 16px;
      font-weight: 800;
      color: #0F172A;
      margin-bottom: 6px;
    }
    .doc-desc {
      font-size: 13px;
      color: #64748B;
      line-height: 1.5;
      margin-bottom: 18px;
    }
  </style>
</head>
<body>

  <header class="mvg-site-header"><?php include __DIR__ . '/includes/header.php'; ?></header>

  <section class="doc-hero">
    <div class="mvg-header-container">
      <nav class="breadcrumb-trail" aria-label="Breadcrumb">
        <a href="index.php">Home</a>
        <span class="sep">›</span>
        <span class="current">Technical Datasheets</span>
      </nav>
      <div style="margin-top: 14px;">
        <span class="collection-hero-badge">📄 ENGINEERING DOCUMENTATION</span>
        <h1 class="collection-hero-h1">Technical Datasheets &amp; Spec Sheets</h1>
        <p class="collection-hero-lead">
          Access verified dimensional drawings, saturation curves, accuracy limits, and electrical compliance certificates for all MVG Current Transformers.
        </p>
      </div>
    </div>
  </section>

  <main class="mvg-header-container doc-grid">

    <!-- Card 1 -->
    <div class="doc-card">
      <div>
        <span class="doc-type-badge">PDF • Technical Catalog</span>
        <h2 class="doc-title">Encapsulated Square CT Series (30x10 to 100x10 mm)</h2>
        <p class="doc-desc">Busbar dimensional drawings, terminal shroud spacing, rated burden VA, and Class 1.0/0.5 error limits for switchboard panels.</p>
      </div>
      <a href="assets/categories/encapsulated-square-ct.jpg" target="_blank" class="btn btn-outline w-full" style="text-align: center; border-radius: 8px;">
        📥 Download Spec Sheet (PDF)
      </a>
    </div>

    <!-- Card 2 -->
    <div class="doc-card">
      <div>
        <span class="doc-type-badge">PDF • Technical Catalog</span>
        <h2 class="doc-title">Encapsulated Ring CT Series (30mm to 115mm ID)</h2>
        <p class="doc-desc">Toroidal round cable current transformers: primary ratings 50A to 2500A, secondary 5A, CRGO magnetic core specifications.</p>
      </div>
      <a href="assets/categories/encapsulated-ring-ct.jpg" target="_blank" class="btn btn-outline w-full" style="text-align: center; border-radius: 8px;">
        📥 Download Spec Sheet (PDF)
      </a>
    </div>

    <!-- Card 3 -->
    <div class="doc-card">
      <div>
        <span class="doc-type-badge">Standard Guide</span>
        <h2 class="doc-title">IS 2705 Accuracy Class &amp; Burden Calculation Chart</h2>
        <p class="doc-desc">Complete engineering guide for selecting correct VA rating and ratio error limits under Indian Standard IS 2705 Part 1 &amp; 2.</p>
      </div>
      <a href="collections.php" class="btn btn-primary w-full" style="text-align: center; border-radius: 8px;">
        View Calculation Guide &rarr;
      </a>
    </div>

    <!-- Card 4 -->
    <div class="doc-card">
      <div>
        <span class="doc-type-badge">Wiring Diagram</span>
        <h2 class="doc-title">3-Phase 4-Wire Metering Connection Scheme</h2>
        <p class="doc-desc">Standard wiring schematics for connecting 3 CTs (R-Y-B) with multifunction energy meters and ammeter selector switches.</p>
      </div>
      <a href="collections.php" class="btn btn-outline w-full" style="text-align: center; border-radius: 8px;">
        📥 View Wiring Diagram
      </a>
    </div>

    <!-- Card 5 -->
    <div class="doc-card">
      <div>
        <span class="doc-type-badge">PDF • Technical Catalog</span>
        <h2 class="doc-title">Tape Wound &amp; Resin Cast Transformer Manual</h2>
        <p class="doc-desc">Heavy-duty tape insulated and epoxy resin cast CTs for high humidity, industrial chemical zones, and outdoor cubicles.</p>
      </div>
      <a href="custom-ct.php" class="btn btn-outline w-full" style="text-align: center; border-radius: 8px;">
        Request Resin Cast Specs
      </a>
    </div>

    <!-- Card 6 -->
    <div class="doc-card">
      <div>
        <span class="doc-type-badge">Quality Certificate</span>
        <h2 class="doc-title">Routine Factory Test Certificate Format</h2>
        <p class="doc-desc">Sample factory routine test certificate including high-voltage flash test (3kV) and ratio/phase angle error compliance report.</p>
      </div>
      <a href="https://wa.me/<?php echo WHATSAPP_NUMBER; ?>?text=Please%20share%20sample%20test%20certificate" target="_blank" rel="noopener" class="btn btn-outline w-full" style="text-align: center; border-radius: 8px;">
        💬 Request Sample Certificate
      </a>
    </div>

  </main>

  <?php include __DIR__ . '/includes/footer.php'; ?>
</body>
</html>

<?php
/**
 * MVG Power Solutions — B2B Frequently Asked Questions (FAQ)
 */

require_once __DIR__ . '/config/constants.php';
require_once __DIR__ . '/config/settings.php';

$pageTitle = "Frequently Asked Questions (FAQ) | " . SITE_NAME;
$pageDesc = "Find answers to common questions about MVG Current Transformers, minimum order quantity (MOQ), 18% GST tax invoices, dispatch timelines, custom ratios, and test reports.";
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
    .faq-hero {
      background: linear-gradient(135deg, #0F172A 0%, #1E293B 100%);
      color: #FFFFFF;
      padding: 56px 0 64px 0;
      border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    }
    .faq-list {
      max-width: 820px;
      margin: 50px auto 90px auto;
      padding: 0 20px;
    }
    .faq-item {
      background: #FFFFFF;
      border: 1px solid #E2E8F0;
      border-radius: 12px;
      padding: 22px 26px;
      margin-bottom: 16px;
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.02);
    }
    .faq-q {
      font-size: 16.5px;
      font-weight: 800;
      color: #0F172A;
      margin-bottom: 10px;
      display: flex;
      align-items: center;
      gap: 10px;
    }
    .faq-a {
      font-size: 14.5px;
      color: #475569;
      line-height: 1.65;
      margin: 0;
    }
  </style>
</head>
<body>

  <header class="mvg-site-header"><?php include __DIR__ . '/includes/header.php'; ?></header>

  <section class="faq-hero">
    <div class="mvg-header-container">
      <nav class="breadcrumb-trail" aria-label="Breadcrumb">
        <a href="index.php">Home</a>
        <span class="sep">›</span>
        <span class="current">FAQ</span>
      </nav>
      <div style="margin-top: 14px;">
        <span class="collection-hero-badge">💡 HELP &amp; COMMERCIAL GUIDELINES</span>
        <h1 class="collection-hero-h1">Frequently Asked Questions</h1>
        <p class="collection-hero-lead">
          Everything you need to know regarding B2B procurement, MOQ minimums, GST invoicing, test reports, and dispatch timelines.
        </p>
      </div>
    </div>
  </section>

  <main class="faq-list">

    <div class="faq-item">
      <h2 class="faq-q"><span>❓</span> What is the Minimum Order Quantity (MOQ)?</h2>
      <p class="faq-a">
        As a dedicated industrial manufacturer, our standard wholesale MOQ is <strong>10 pieces</strong> per model rating. For custom-engineered ratios or bespoke dimensions, prototype sample batches can be arranged upon discussion with our engineering desk.
      </p>
    </div>

    <div class="faq-item">
      <h2 class="faq-q"><span>❓</span> Can we claim 18% GST Input Tax Credit (ITC)?</h2>
      <p class="faq-a">
        <strong>Yes, 100%.</strong> All dispatches are accompanied by a formal B2B Tax Invoice with your company’s GSTIN clearly specified under HSN code <strong>85043100</strong>, ensuring immediate Input Tax Credit eligibility.
      </p>
    </div>

    <div class="faq-item">
      <h2 class="faq-q"><span>❓</span> What are the standard dispatch timelines?</h2>
      <p class="faq-a">
        Standard catalog ratings (50/5A up to 2500/5A in Encapsulated Square and Ring formats) are held in regular stock at our <strong>Delhi NCR Central Depot</strong> and dispatched on the <strong>same day</strong> or within 24 hours. Custom or resin cast units generally take 3 to 7 business days.
      </p>
    </div>

    <div class="faq-item">
      <h2 class="faq-q"><span>❓</span> Are test calibration certificates provided?</h2>
      <p class="faq-a">
        Yes, every dispatched production lot includes a batch <strong>Routine Test Certificate</strong> certifying compliance with Indian Standard <strong>IS 2705 (Part 1 &amp; 2)</strong> and International Standard <strong>IEC 61869-2</strong>.
      </p>
    </div>

    <div class="faq-item">
      <h2 class="faq-q"><span>❓</span> Can you manufacture 1A secondary output CTs?</h2>
      <p class="faq-a">
        Yes! While 5A is standard for control panels, we routinely produce 1A secondary current transformers for remote electrical substations and industrial facilities where long conductor runs between the CT and energy meters cause high VA losses.
      </p>
    </div>

    <div class="faq-item">
      <h2 class="faq-q"><span>❓</span> How does the inquiry and order workflow operate?</h2>
      <p class="faq-a">
        Add required models and quantities to the <strong>Inquiry Basket</strong> and submit your request. Our sales desk generates an official Proforma Invoice with wholesale tiered rates and delivery timeline, which is sent directly to your email and WhatsApp for purchase order approval.
      </p>
    </div>

  </main>

  <?php include __DIR__ . '/includes/footer.php'; ?>
</body>
</html>

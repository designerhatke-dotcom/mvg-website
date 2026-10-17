<?php
/**
 * MVG Power Solutions — Commercial & Quotation Terms
 */

require_once __DIR__ . '/config/constants.php';
require_once __DIR__ . '/config/settings.php';

$pageTitle = "Commercial Terms & Conditions | " . SITE_NAME;
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title><?php echo htmlspecialchars($pageTitle); ?></title>
  <link rel="stylesheet" href="css/style.css">
</head>
<body>
  <header class="mvg-site-header"><?php include __DIR__ . '/includes/header.php'; ?></header>

  <div style="background: #0F172A; color: #FFFFFF; padding: 48px 0;">
    <div class="mvg-header-container">
      <h1 style="font-size: 32px; font-weight: 900; margin-bottom: 8px;">Commercial Terms &amp; Conditions</h1>
      <p style="color: #94A3B8; font-size: 14px;">B2B Supply, Quotation Validity &amp; Warranty Guidelines</p>
    </div>
  </div>

  <main class="mvg-header-container" style="padding: 50px 20px 80px 20px; max-width: 820px; line-height: 1.7; color: #334155; font-size: 15px;">
    
    <h2 style="font-size: 20px; color: #0F172A; margin: 0 0 12px 0;">1. Quotation Validity</h2>
    <p>
      Formal quotations and Proforma Invoices issued by MVG Power Solutions are valid for <strong>30 calendar days</strong> from the date of generation, subject to raw material copper and silicon steel market revisions.
    </p>

    <h2 style="font-size: 20px; color: #0F172A; margin: 28px 0 12px 0;">2. Taxes &amp; GST Compliance</h2>
    <p>
      All catalog and unit prices displayed are exclusive of Goods and Services Tax (GST) unless explicitly toggled as "Inclusive". Standard electrical transformers attract <strong>18% GST</strong> under HSN Code <strong>85043100</strong>. Complete Input Tax Credit (ITC) invoices are issued with confirmed dispatch.
    </p>

    <h2 style="font-size: 20px; color: #0F172A; margin: 28px 0 12px 0;">3. Minimum Order Quantity (MOQ)</h2>
    <p>
      The standard minimum wholesale order quantity is <strong>10 units</strong> per model rating. For custom-engineered ratios, special MOQs apply as stipulated in the formal engineering quotation.
    </p>

    <h2 style="font-size: 20px; color: #0F172A; margin: 28px 0 12px 0;">4. Product Warranty</h2>
    <p>
      All MVG current transformers are covered by a <strong>12-month manufacturer replacement warranty</strong> against manufacturing defects from the date of invoice. The warranty does not cover damages arising from incorrect installation, short-circuit current exceeding rated thermal dynamic limits (Ith), or open-circuited secondary operation.
    </p>

    <h2 style="font-size: 20px; color: #0F172A; margin: 28px 0 12px 0;">5. Dispatch &amp; Freight</h2>
    <p>
      Orders are dispatched Ex-Works from our Delhi NCR Central Depot via trusted industrial transport partners (V-Trans, TCI Freight, Safexpress, Delhivery). Transit insurance and freight charges are billed as per actuals or borne by the purchaser as agreed.
    </p>

  </main>

  <?php include __DIR__ . '/includes/footer.php'; ?>
</body>
</html>

<?php
/**
 * MVG Power Solutions — Privacy Policy
 */

require_once __DIR__ . '/config/constants.php';
require_once __DIR__ . '/config/settings.php';

$pageTitle = "Privacy Policy | " . SITE_NAME;
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
      <h1 style="font-size: 32px; font-weight: 900; margin-bottom: 8px;">Privacy Policy</h1>
      <p style="color: #94A3B8; font-size: 14px;">Last updated: October 2026 • Commercial B2B Data Privacy</p>
    </div>
  </div>

  <main class="mvg-header-container" style="padding: 50px 20px 80px 20px; max-width: 820px; line-height: 1.7; color: #334155; font-size: 15px;">
    <p>
      At <strong><?php echo SITE_NAME; ?></strong>, we are committed to safeguarding the commercial and personal information of our clients, dealers, switchboard builders, and website visitors.
    </p>

    <h2 style="font-size: 20px; color: #0F172A; margin: 28px 0 12px 0;">1. Information We Collect</h2>
    <p>
      When you submit a quotation request (RFQ), contact form, or custom transformer design specification on our website, we collect your company name, contact person name, telephone/WhatsApp number, work email address, delivery city/state, and GSTIN (for B2B tax invoice and Input Tax Credit processing).
    </p>

    <h2 style="font-size: 20px; color: #0F172A; margin: 28px 0 12px 0;">2. How We Use Your Commercial Data</h2>
    <p>
      Your data is strictly utilized to:
    </p>
    <ul>
      <li>Generate formal Proforma Invoices and pricing quotations.</li>
      <li>Coordinate shipping, freight logistics, and delivery timelines from our Delhi NCR depot.</li>
      <li>Provide technical datasheets, test certificates, and warranty documentation.</li>
      <li>Comply with Indian statutory requirements under the GST framework.</li>
    </ul>

    <h2 style="font-size: 20px; color: #0F172A; margin: 28px 0 12px 0;">3. Data Protection &amp; Confidentiality</h2>
    <p>
      We never sell, rent, or trade your contact or business information to third-party marketing agencies. All records are stored securely on our dedicated infrastructure.
    </p>

    <h2 style="font-size: 20px; color: #0F172A; margin: 28px 0 12px 0;">4. Contact Us</h2>
    <p>
      For questions regarding our privacy practices or to request data removal, please email <a href="mailto:<?php echo CONTACT_EMAIL; ?>"><?php echo CONTACT_EMAIL; ?></a> or contact our registered office in New Delhi.
    </p>
  </main>

  <?php include __DIR__ . '/includes/footer.php'; ?>
</body>
</html>

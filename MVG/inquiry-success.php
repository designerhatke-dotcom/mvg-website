<?php
/**
 * MVG Power Solutions — Quotation Submission Confirmation Page
 */

require_once __DIR__ . '/config/constants.php';
require_once __DIR__ . '/config/db.php';
require_once __DIR__ . '/config/settings.php';

$rfqNumber = trim($_GET['rfq'] ?? '');
$pageTitle = "Quotation Request Submitted | " . SITE_NAME;

// Retrieve inquiry details if available
$inquiry = null;
$items = [];

if ($rfqNumber) {
    $pdo = Database::getConnection();
    if ($pdo) {
        try {
            $stmt = $pdo->prepare("SELECT * FROM inquiries WHERE rfq_number = ? LIMIT 1");
            $stmt->execute([$rfqNumber]);
            $inquiry = $stmt->fetch();

            if ($inquiry) {
                $itemStmt = $pdo->prepare("SELECT * FROM inquiry_items WHERE inquiry_id = ?");
                $itemStmt->execute([$inquiry['id']]);
                $items = $itemStmt->fetchAll();
            }
        } catch (Exception $e) {}
    }

    if (!$inquiry) {
        $jsonFile = __DIR__ . '/data/inquiries.json';
        if (file_exists($jsonFile)) {
            $all = json_decode(file_get_contents($jsonFile), true) ?: [];
            foreach ($all as $rec) {
                if (($rec['rfq_number'] ?? '') === $rfqNumber) {
                    $inquiry = $rec;
                    $items = $rec['items'] ?? [];
                    break;
                }
            }
        }
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title><?php echo htmlspecialchars($pageTitle); ?></title>
  <link rel="stylesheet" href="css/style.css">
  <style>
    .success-container {
      max-width: 760px;
      margin: 60px auto 100px auto;
      padding: 0 20px;
    }
    .success-card {
      background: #FFFFFF;
      border: 1px solid #E2E8F0;
      border-radius: 20px;
      padding: 44px;
      box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.05);
      text-align: center;
    }
    .success-icon-badge {
      width: 76px;
      height: 76px;
      border-radius: 50%;
      background: #ECFDF5;
      color: #10B981;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 36px;
      margin: 0 auto 20px auto;
      border: 2px solid #A7F3D0;
    }
    .success-title {
      font-size: 28px;
      font-weight: 900;
      color: #0F172A;
      margin-bottom: 8px;
    }
    .success-lead {
      font-size: 15px;
      color: #64748B;
      line-height: 1.6;
      margin-bottom: 24px;
    }
    .rfq-ref-box {
      background: #F8FAFC;
      border: 2px dashed #CBD5E1;
      border-radius: 12px;
      padding: 18px;
      margin-bottom: 30px;
      display: inline-block;
      width: 100%;
      box-sizing: border-box;
    }
    .rfq-ref-label {
      font-size: 12px;
      font-weight: 700;
      color: #64748B;
      text-transform: uppercase;
      letter-spacing: 0.5px;
      margin-bottom: 4px;
    }
    .rfq-ref-number {
      font-size: 26px;
      font-weight: 900;
      color: var(--mvg-brand);
      letter-spacing: 1px;
    }

    .timeline-steps {
      display: grid;
      grid-template-columns: repeat(4, 1fr);
      gap: 16px;
      margin: 32px 0;
      text-align: left;
    }
    @media (max-width: 680px) {
      .timeline-steps {
        grid-template-columns: 1fr;
      }
    }
    .timeline-step {
      background: #F8FAFC;
      border: 1px solid #E2E8F0;
      border-radius: 10px;
      padding: 14px;
    }
    .timeline-num {
      width: 24px;
      height: 24px;
      border-radius: 50%;
      background: var(--mvg-brand);
      color: #FFFFFF;
      font-size: 12px;
      font-weight: 800;
      display: flex;
      align-items: center;
      justify-content: center;
      margin-bottom: 8px;
    }
    .timeline-title {
      font-size: 13px;
      font-weight: 800;
      color: #0F172A;
      margin-bottom: 4px;
    }
    .timeline-desc {
      font-size: 11.5px;
      color: #64748B;
      line-height: 1.4;
      margin: 0;
    }

    .action-btn-row {
      display: flex;
      gap: 14px;
      justify-content: center;
      flex-wrap: wrap;
      margin-top: 32px;
    }
  </style>
</head>
<body>

  <!-- Modular Site Header -->
  <header class="mvg-site-header">
    <?php include __DIR__ . '/includes/header.php'; ?>
  </header>

  <main class="success-container">
    <div class="success-card">
      
      <div class="success-icon-badge">✓</div>
      <h1 class="success-title">Quotation Request Received</h1>
      <p class="success-lead">
        Thank you<?php echo !empty($inquiry['customer_name']) ? ', ' . htmlspecialchars($inquiry['customer_name']) : ''; ?>! Your commercial inquiry has been registered in the MVG Power Solutions technical dispatch system.
      </p>

      <div class="rfq-ref-box">
        <div class="rfq-ref-label">Official RFQ Reference ID</div>
        <div class="rfq-ref-number"><?php echo htmlspecialchars($rfqNumber ?: 'RFQ-CONFIRMED'); ?></div>
        <div style="font-size: 12px; color: #64748B; margin-top: 4px;">Quote generated on <?php echo date('d M Y, h:i A'); ?></div>
      </div>

      <!-- Quotation Workflow Timeline -->
      <div class="timeline-steps">
        <div class="timeline-step">
          <div class="timeline-num">1</div>
          <div class="timeline-title">Received</div>
          <p class="timeline-desc">Logged into central ERP portal.</p>
        </div>
        <div class="timeline-step">
          <div class="timeline-num">2</div>
          <div class="timeline-title">Tech Review</div>
          <p class="timeline-desc">Ratio, class &amp; VA verification within 2 hrs.</p>
        </div>
        <div class="timeline-step">
          <div class="timeline-num">3</div>
          <div class="timeline-title">Proforma GST</div>
          <p class="timeline-desc">Official proforma invoice issued via WhatsApp/Email.</p>
        </div>
        <div class="timeline-step">
          <div class="timeline-num">4</div>
          <div class="timeline-title">Dispatch</div>
          <p class="timeline-desc">Dispatched from Delhi NCR warehouse hub.</p>
        </div>
      </div>

      <!-- Action Buttons -->
      <div class="action-btn-row">
        <a href="https://wa.me/<?php echo WHATSAPP_NUMBER; ?>?text=Hello%20MVG%20Power%20Solutions,%20I%20have%20submitted%20RFQ%20reference%20<?php echo urlencode($rfqNumber); ?>.%20Please%20share%20the%20proforma%20invoice." target="_blank" rel="noopener" class="btn" style="background: #25D366; color: #FFFFFF; font-weight: 800; padding: 14px 24px; border-radius: 10px; text-decoration: none;">
          💬 Chat with Sales Desk on WhatsApp
        </a>
        <a href="track-inquiry.php?rfq=<?php echo urlencode($rfqNumber); ?>" class="btn" style="background: #0F172A; color: #FFFFFF; font-weight: 700; padding: 14px 22px; border-radius: 10px; text-decoration: none;">
          🔍 Track Inquiry Status
        </a>
        <a href="collections.php" class="btn btn-outline" style="padding: 14px 22px; border-radius: 10px; text-decoration: none;">
          Browse Catalog
        </a>
      </div>

    </div>
  </main>

  <!-- Modular Site Footer -->
  <?php include __DIR__ . '/includes/footer.php'; ?>
</body>
</html>

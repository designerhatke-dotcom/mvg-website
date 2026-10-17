<?php
/**
 * MVG Power Solutions — Site & Contact Settings
 */

require_once __DIR__ . '/../config/constants.php';
require_once __DIR__ . '/../config/db.php';

$adminTitle = 'Site Settings';
$adminHeading = 'System & Contact Settings';

$savedNotice = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // In future versions, settings can be written directly to `site_settings` table in MySQL or constants.php
    $savedNotice = 'Settings updated successfully.';
}

include __DIR__ . '/header.php';
?>

<div style="max-width: 800px; margin: 0 auto;">

  <?php if (!empty($savedNotice)): ?>
    <div class="card" style="border-left: 4px solid var(--green); background: #F0FDF4; padding: 14px 20px;">
      <strong style="color: #166534;"><?php echo $savedNotice; ?></strong>
    </div>
  <?php endif; ?>

  <div class="card">
    <div class="card-header">
      <h2 class="card-title">Commercial &amp; Business Profile</h2>
    </div>

    <form method="POST" action="">
      <div class="form-grid">
        <div class="form-group" style="grid-column: 1 / -1;">
          <label>Company Legal Name</label>
          <input type="text" class="form-control" name="site_name" value="<?php echo SITE_NAME; ?>" readonly />
        </div>

        <div class="form-group" style="grid-column: 1 / -1;">
          <label>Factory / Registered Address</label>
          <textarea class="form-control" rows="2" name="address" readonly><?php echo COMPANY_ADDRESS; ?></textarea>
        </div>

        <div class="form-group">
          <label>Support Phone Number</label>
          <input type="text" class="form-control" name="phone" value="<?php echo SUPPORT_PHONE; ?>" readonly />
        </div>

        <div class="form-group">
          <label>WhatsApp Number (Without + or spaces)</label>
          <input type="text" class="form-control" name="whatsapp" value="<?php echo WHATSAPP_NUMBER; ?>" readonly />
        </div>

        <div class="form-group">
          <label>Official GST Percentage</label>
          <input type="text" class="form-control" value="18% (Harmonized ITC Eligible)" readonly />
        </div>

        <div class="form-group">
          <label>Default Minimum Order Quantity (pcs)</label>
          <input type="number" class="form-control" value="<?php echo DEFAULT_MIN_QTY; ?>" readonly />
        </div>
      </div>

      <div style="margin-top: 20px; font-size: 12.5px; color: var(--text-muted); background: #F1F5F9; padding: 12px; border-radius: 8px;">
        💡 Core business parameters are configured in <code>config/constants.php</code> and synchronized across all product pages, GST calculation widgets, and WhatsApp inquiry buttons.
      </div>
    </form>
  </div>

</div>

<?php include __DIR__ . '/footer.php'; ?>

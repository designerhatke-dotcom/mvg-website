<?php
/**
 * MVG Power Solutions — 3rd Party Integrations & Analytics
 */

require_once __DIR__ . '/../config/constants.php';
require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../config/settings.php';

$adminTitle = 'Integrations';
$adminHeading = 'Analytics, Tracking & Third-Party Integrations';

$successMsg = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $integ = [
        'ga4_measurement_id'       => trim($_POST['ga4_measurement_id'] ?? ''),
        'google_search_console_id' => trim($_POST['google_search_console_id'] ?? ''),
        'gtm_container_id'         => trim($_POST['gtm_container_id'] ?? ''),
        'meta_pixel_id'            => trim($_POST['meta_pixel_id'] ?? ''),
        'whatsapp_cloud_api_key'   => trim($_POST['whatsapp_cloud_api_key'] ?? ''),
        'webhook_order_endpoint'   => trim($_POST['webhook_order_endpoint'] ?? '')
    ];
    Settings::saveGroup('integrations', $integ);
    $successMsg = '✓ Third-party analytics and webhook integrations saved!';
}

$integ = Settings::getGroup('integrations');

include __DIR__ . '/header.php';
?>

<div style="max-width: 900px; margin: 0 auto;">

  <?php if (!empty($successMsg)): ?>
    <div style="background: #F0FDF4; border-left: 4px solid var(--green); color: #166534; padding: 12px 18px; font-size: 13.5px; border-radius: 8px; margin-bottom: 20px;">
      <?php echo $successMsg; ?>
    </div>
  <?php endif; ?>

  <form method="POST" action="">

    <!-- Google Analytics & GTM -->
    <div class="card" style="margin-bottom: 24px;">
      <div class="card-header">
        <h2 class="card-title">📈 Google Analytics &amp; Tag Manager</h2>
      </div>

      <div class="form-grid">
        <div class="form-group">
          <label>Google Analytics 4 (GA4) Measurement ID</label>
          <input type="text" name="ga4_measurement_id" class="form-control" value="<?php echo htmlspecialchars($integ['ga4_measurement_id'] ?? ''); ?>" placeholder="e.g. G-XXXXXXXXXX">
          <span style="font-size: 11px; color: var(--text-muted); margin-top: 3px; display: block;">Tracks page visits, product views, and cart actions</span>
        </div>

        <div class="form-group">
          <label>Google Tag Manager (GTM) Container ID</label>
          <input type="text" name="gtm_container_id" class="form-control" value="<?php echo htmlspecialchars($integ['gtm_container_id'] ?? ''); ?>" placeholder="e.g. GTM-XXXXXXX">
        </div>
      </div>
    </div>

    <!-- Meta / Facebook Pixel & Social Tracking -->
    <div class="card" style="margin-bottom: 24px;">
      <div class="card-header">
        <h2 class="card-title">🎯 Meta / Facebook Pixel &amp; Ad Tracking</h2>
      </div>

      <div class="form-group">
        <label>Meta Pixel ID (Facebook / Instagram Ads)</label>
        <input type="text" name="meta_pixel_id" class="form-control" value="<?php echo htmlspecialchars($integ['meta_pixel_id'] ?? ''); ?>" placeholder="e.g. 1234567890123456">
      </div>
    </div>

    <!-- WhatsApp & CRM Webhooks -->
    <div class="card" style="margin-bottom: 24px;">
      <div class="card-header">
        <h2 class="card-title">⚡ Webhooks &amp; ERP / CRM Automation</h2>
      </div>

      <div class="form-group">
        <label>Inquiry &amp; RFQ Webhook Endpoint URL</label>
        <input type="url" name="webhook_order_endpoint" class="form-control" value="<?php echo htmlspecialchars($integ['webhook_order_endpoint'] ?? ''); ?>" placeholder="https://api.yourcrm.com/v1/inquiries">
        <span style="font-size: 11px; color: var(--text-muted); margin-top: 3px; display: block;">Sends instant JSON payloads to your ERP or Zapier when an RFQ inquiry is submitted</span>
      </div>
    </div>

    <div style="display: flex; justify-content: flex-end; margin-bottom: 40px;">
      <button type="submit" class="btn-topbar btn-topbar-primary" style="padding: 12px 30px; font-weight: 700;">
        💾 Save Integrations
      </button>
    </div>

  </form>

</div>

<?php include __DIR__ . '/footer.php'; ?>

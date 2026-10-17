<?php
/**
 * MVG Power Solutions — Contact & Business Details Manager
 */

require_once __DIR__ . '/../config/constants.php';
require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../config/settings.php';

$adminTitle = 'Contact & Business Details';
$adminHeading = 'Contact Channels & Location Settings';

$successMsg = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $business = [
        'company_name'             => trim($_POST['company_name'] ?? 'MVG Power Solutions'),
        'registered_address'       => trim($_POST['registered_address'] ?? ''),
        'warehouse_address'        => trim($_POST['warehouse_address'] ?? ''),
        'phone_primary'            => trim($_POST['phone_primary'] ?? ''),
        'phone_alternate'          => trim($_POST['phone_alternate'] ?? ''),
        'whatsapp_number'          => trim($_POST['whatsapp_number'] ?? ''),
        'whatsapp_default_message' => trim($_POST['whatsapp_default_message'] ?? ''),
        'email_business'           => trim($_POST['email_business'] ?? ''),
        'email_sales'              => trim($_POST['email_sales'] ?? ''),
        'email_support'            => trim($_POST['email_support'] ?? ''),
        'business_hours'           => trim($_POST['business_hours'] ?? ''),
        'google_maps_embed'        => trim($_POST['google_maps_embed'] ?? ''),
        'google_business_url'      => trim($_POST['google_business_url'] ?? ''),
        'enable_click_to_call'     => isset($_POST['enable_click_to_call']) ? true : false,
        'enable_whatsapp_cta'      => isset($_POST['enable_whatsapp_cta']) ? true : false,
        'enable_email_inquiry'     => isset($_POST['enable_email_inquiry']) ? true : false
    ];
    Settings::saveGroup('business', $business);

    $social = [
        'facebook'  => trim($_POST['facebook'] ?? ''),
        'linkedin'  => trim($_POST['linkedin'] ?? ''),
        'instagram' => trim($_POST['instagram'] ?? ''),
        'youtube'   => trim($_POST['youtube'] ?? ''),
        'twitter'   => trim($_POST['twitter'] ?? '')
    ];
    Settings::saveGroup('social', $social);

    $successMsg = '✓ Contact channels, phone numbers, and location details saved successfully!';
}

$biz = Settings::getGroup('business');
$soc = Settings::getGroup('social');

include __DIR__ . '/header.php';
?>

<div style="max-width: 960px; margin: 0 auto;">

  <?php if (!empty($successMsg)): ?>
    <div style="background: #F0FDF4; border-left: 4px solid var(--green); color: #166534; padding: 12px 18px; font-size: 13.5px; border-radius: 8px; margin-bottom: 20px;">
      <?php echo $successMsg; ?>
    </div>
  <?php endif; ?>

  <form method="POST" action="">

    <!-- Contact Channels & Quick Action Controls -->
    <div class="card" style="margin-bottom: 24px;">
      <div class="card-header">
        <h2 class="card-title">📞 Direct Customer Contact Channels</h2>
      </div>

      <div class="form-grid">
        <div class="form-group">
          <label>Primary Phone Number (Click-to-Call)</label>
          <input type="text" name="phone_primary" class="form-control" value="<?php echo htmlspecialchars($biz['phone_primary'] ?? '+91 78360 04040'); ?>" required>
        </div>

        <div class="form-group">
          <label>Alternate / Dispatch Desk Phone</label>
          <input type="text" name="phone_alternate" class="form-control" value="<?php echo htmlspecialchars($biz['phone_alternate'] ?? '+91 99991 76722'); ?>">
        </div>

        <div class="form-group">
          <label>Official WhatsApp Number (Country code + number without +)</label>
          <input type="text" name="whatsapp_number" class="form-control" value="<?php echo htmlspecialchars($biz['whatsapp_number'] ?? '917836004040'); ?>" required>
        </div>

        <div class="form-group">
          <label>General Business Email</label>
          <input type="email" name="email_business" class="form-control" value="<?php echo htmlspecialchars($biz['email_business'] ?? 'info@mvgpowersolutions.com'); ?>">
        </div>

        <div class="form-group">
          <label>Sales &amp; RFQ Quotation Email</label>
          <input type="email" name="email_sales" class="form-control" value="<?php echo htmlspecialchars($biz['email_sales'] ?? 'sales@mvgpowersolutions.com'); ?>">
        </div>

        <div class="form-group">
          <label>Engineering &amp; Technical Support Email</label>
          <input type="email" name="email_support" class="form-control" value="<?php echo htmlspecialchars($biz['email_support'] ?? 'support@mvgpowersolutions.com'); ?>">
        </div>

        <div class="form-group" style="grid-column: 1 / -1;">
          <label>Default WhatsApp Pre-filled Message</label>
          <textarea name="whatsapp_default_message" class="form-control" rows="2"><?php echo htmlspecialchars($biz['whatsapp_default_message'] ?? 'Hello MVG Power Solutions, I have an inquiry regarding industrial current transformers.'); ?></textarea>
          <span style="font-size: 11px; color: var(--text-muted); margin-top: 3px; display: block;">This message pre-fills when a customer clicks the WhatsApp button on website or product pages.</span>
        </div>

        <div class="form-group" style="grid-column: 1 / -1;">
          <label>Operating Hours / Support Availability</label>
          <input type="text" name="business_hours" class="form-control" value="<?php echo htmlspecialchars($biz['business_hours'] ?? 'Monday – Saturday: 9:00 AM – 7:00 PM IST (Sunday Closed)'); ?>">
        </div>
      </div>

      <div style="margin-top: 14px; padding-top: 14px; border-top: 1px solid var(--border); display: flex; flex-direction: column; gap: 10px;">
        <label style="display: flex; align-items: center; gap: 8px; cursor: pointer; font-size: 13px;">
          <input type="checkbox" name="enable_click_to_call" value="1" <?php echo !isset($biz['enable_click_to_call']) || !empty($biz['enable_click_to_call']) ? 'checked' : ''; ?>>
          <span><strong>Enable Click-to-Call Buttons</strong> in Header and Footer</span>
        </label>
        <label style="display: flex; align-items: center; gap: 8px; cursor: pointer; font-size: 13px;">
          <input type="checkbox" name="enable_whatsapp_cta" value="1" <?php echo !isset($biz['enable_whatsapp_cta']) || !empty($biz['enable_whatsapp_cta']) ? 'checked' : ''; ?>>
          <span><strong>Enable Direct WhatsApp Buttons</strong> on Product Pages &amp; RFQ Drawer</span>
        </label>
        <label style="display: flex; align-items: center; gap: 8px; cursor: pointer; font-size: 13px;">
          <input type="checkbox" name="enable_email_inquiry" value="1" <?php echo !isset($biz['enable_email_inquiry']) || !empty($biz['enable_email_inquiry']) ? 'checked' : ''; ?>>
          <span><strong>Enable Email Inquiry Links</strong></span>
        </label>
      </div>
    </div>

    <!-- Registered Locations & Maps -->
    <div class="card" style="margin-bottom: 24px;">
      <div class="card-header">
        <h2 class="card-title">📍 Registered Office &amp; Warehouse Depot</h2>
      </div>

      <div class="form-grid">
        <div class="form-group" style="grid-column: 1 / -1;">
          <label>Registered Factory Office Address *</label>
          <textarea name="registered_address" class="form-control" rows="2" required><?php echo htmlspecialchars($biz['registered_address'] ?? 'R-458, Ground Floor, R Block, Mangol Puri, New Delhi – 110083, India'); ?></textarea>
        </div>

        <div class="form-group" style="grid-column: 1 / -1;">
          <label>Central Dispatch &amp; Warehouse Depot</label>
          <textarea name="warehouse_address" class="form-control" rows="2"><?php echo htmlspecialchars($biz['warehouse_address'] ?? 'Phase-II, Mayapuri Industrial Area, New Delhi – 110064, India'); ?></textarea>
        </div>

        <div class="form-group" style="grid-column: 1 / -1;">
          <label>Google Maps Embed iframe URL</label>
          <input type="text" name="google_maps_embed" class="form-control" value="<?php echo htmlspecialchars($biz['google_maps_embed'] ?? ''); ?>" placeholder="https://www.google.com/maps/embed?...">
        </div>

        <div class="form-group" style="grid-column: 1 / -1;">
          <label>Google Business Profile / Review URL</label>
          <input type="url" name="google_business_url" class="form-control" value="<?php echo htmlspecialchars($biz['google_business_url'] ?? GOOGLE_BUSINESS_URL); ?>">
        </div>
      </div>
    </div>

    <!-- Social Media Links -->
    <div class="card" style="margin-bottom: 24px;">
      <div class="card-header">
        <h2 class="card-title">🔗 Official Social Media Profiles</h2>
      </div>

      <div class="form-grid">
        <div class="form-group">
          <label>LinkedIn Company URL</label>
          <input type="url" name="linkedin" class="form-control" value="<?php echo htmlspecialchars($soc['linkedin'] ?? ''); ?>" placeholder="https://linkedin.com/company/...">
        </div>

        <div class="form-group">
          <label>Facebook Page URL</label>
          <input type="url" name="facebook" class="form-control" value="<?php echo htmlspecialchars($soc['facebook'] ?? ''); ?>" placeholder="https://facebook.com/...">
        </div>

        <div class="form-group">
          <label>Instagram URL</label>
          <input type="url" name="instagram" class="form-control" value="<?php echo htmlspecialchars($soc['instagram'] ?? ''); ?>" placeholder="https://instagram.com/...">
        </div>

        <div class="form-group">
          <label>YouTube Channel URL</label>
          <input type="url" name="youtube" class="form-control" value="<?php echo htmlspecialchars($soc['youtube'] ?? ''); ?>" placeholder="https://youtube.com/@...">
        </div>
      </div>
    </div>

    <div style="display: flex; justify-content: flex-end; margin-bottom: 40px;">
      <button type="submit" class="btn-topbar btn-topbar-primary" style="padding: 12px 30px; font-size: 14px; font-weight: 700;">
        💾 Save Contact Settings
      </button>
    </div>

  </form>

</div>

<?php include __DIR__ . '/footer.php'; ?>

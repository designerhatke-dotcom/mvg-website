<?php
/**
 * MVG Power Solutions — General & Business Website Settings
 */

require_once __DIR__ . '/../config/constants.php';
require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../config/settings.php';

$adminTitle = 'General Settings';
$adminHeading = 'Website & Business General Settings';

$successMsg = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // 1. General Info
    $general = [
        'site_name'        => trim($_POST['site_name'] ?? 'MVG Power Solutions'),
        'legal_name'       => trim($_POST['legal_name'] ?? 'MVG Power Solutions Private Limited'),
        'tagline'          => trim($_POST['tagline'] ?? ''),
        'site_url'         => trim($_POST['site_url'] ?? ''),
        'logo_url'         => trim($_POST['logo_url'] ?? 'assets/Logo-11.png'),
        'logo_light'       => trim($_POST['logo_light'] ?? 'assets/Logo-11.png'),
        'logo_dark'        => trim($_POST['logo_dark'] ?? 'assets/Logo-11.png'),
        'logo_mobile'      => trim($_POST['logo_mobile'] ?? 'assets/Logo-11.png'),
        'logo_width'       => intval($_POST['logo_width'] ?? 180),
        'logo_height'      => intval($_POST['logo_height'] ?? 48),
        'favicon_url'      => trim($_POST['favicon_url'] ?? 'assets/favicon.ico'),
        'default_language' => trim($_POST['default_language'] ?? 'en'),
        'default_currency' => trim($_POST['default_currency'] ?? 'INR'),
        'currency_symbol'  => trim($_POST['currency_symbol'] ?? '₹'),
        'timezone'         => trim($_POST['timezone'] ?? 'Asia/Kolkata'),
        'copyright_text'   => trim($_POST['copyright_text'] ?? ''),
        'maintenance_mode' => isset($_POST['maintenance_mode']) ? true : false,
        'default_min_qty'  => intval($_POST['default_min_qty'] ?? 10),
        'gst_rate'         => floatval($_POST['gst_rate'] ?? 18)
    ];
    Settings::saveGroup('general', $general);

    // 2. Business Info
    $business = [
        'company_name'       => trim($_POST['company_name'] ?? 'MVG Power Solutions'),
        'business_type'      => trim($_POST['business_type'] ?? 'Manufacturer'),
        'registered_address' => trim($_POST['registered_address'] ?? ''),
        'warehouse_address'  => trim($_POST['warehouse_address'] ?? ''),
        'gstin'              => trim($_POST['gstin'] ?? ''),
        'pan_number'         => trim($_POST['pan_number'] ?? ''),
        'phone_primary'      => trim($_POST['phone_primary'] ?? ''),
        'phone_alternate'    => trim($_POST['phone_alternate'] ?? ''),
        'whatsapp_number'    => trim($_POST['whatsapp_number'] ?? ''),
        'email_business'     => trim($_POST['email_business'] ?? ''),
        'email_sales'        => trim($_POST['email_sales'] ?? ''),
        'email_support'      => trim($_POST['email_support'] ?? ''),
        'business_hours'     => trim($_POST['business_hours'] ?? ''),
        'google_maps_embed'  => trim($_POST['google_maps_embed'] ?? '')
    ];
    Settings::saveGroup('business', $business);

    $successMsg = '✓ All general and business settings saved successfully and synchronized across website!';
}

$gen = Settings::getGroup('general');
$biz = Settings::getGroup('business');

include __DIR__ . '/header.php';
?>

<div style="max-width: 1000px; margin: 0 auto;">

  <?php if (!empty($successMsg)): ?>
    <div style="background: #F0FDF4; border-left: 4px solid var(--green); color: #166534; padding: 12px 18px; font-size: 13.5px; border-radius: 8px; margin-bottom: 20px;">
      <?php echo $successMsg; ?>
    </div>
  <?php endif; ?>

  <form method="POST" action="">
    
    <!-- CARD 1: General Website Information -->
    <div class="card" style="margin-bottom: 24px;">
      <div class="card-header">
        <h2 class="card-title">🌐 General Website Information</h2>
      </div>

      <div class="form-grid">
        <div class="form-group">
          <label>Website Display Name *</label>
          <input type="text" name="site_name" class="form-control" value="<?php echo htmlspecialchars($gen['site_name'] ?? SITE_NAME); ?>" required>
        </div>

        <div class="form-group">
          <label>Company Legal Registered Name *</label>
          <input type="text" name="legal_name" class="form-control" value="<?php echo htmlspecialchars($gen['legal_name'] ?? ''); ?>" required>
        </div>

        <div class="form-group" style="grid-column: 1 / -1;">
          <label>Website Tagline / Slogan</label>
          <input type="text" name="tagline" class="form-control" value="<?php echo htmlspecialchars($gen['tagline'] ?? ''); ?>">
        </div>

        <div class="form-group">
          <label>Base Website URL</label>
          <input type="url" name="site_url" class="form-control" value="<?php echo htmlspecialchars($gen['site_url'] ?? SITE_URL); ?>">
        </div>

        <div class="form-group">
          <label>Favicon URL / Path</label>
          <input type="text" name="favicon_url" class="form-control" value="<?php echo htmlspecialchars($gen['favicon_url'] ?? 'assets/favicon.ico'); ?>">
        </div>

        <div class="form-group">
          <label>Standard Logo Path / URL</label>
          <input type="text" name="logo_url" class="form-control" value="<?php echo htmlspecialchars($gen['logo_url'] ?? 'assets/Logo-11.png'); ?>">
        </div>

        <div class="form-group">
          <label>Light Logo (For Dark Backgrounds)</label>
          <input type="text" name="logo_light" class="form-control" value="<?php echo htmlspecialchars($gen['logo_light'] ?? 'assets/Logo-11.png'); ?>">
        </div>

        <div class="form-group">
          <label>Logo Display Dimensions (Width x Height px)</label>
          <div style="display: flex; gap: 10px;">
            <input type="number" name="logo_width" class="form-control" value="<?php echo htmlspecialchars($gen['logo_width'] ?? 180); ?>" placeholder="Width">
            <input type="number" name="logo_height" class="form-control" value="<?php echo htmlspecialchars($gen['logo_height'] ?? 48); ?>" placeholder="Height">
          </div>
        </div>

        <div class="form-group">
          <label>Default Currency &amp; Symbol</label>
          <div style="display: flex; gap: 10px;">
            <input type="text" name="default_currency" class="form-control" value="<?php echo htmlspecialchars($gen['default_currency'] ?? 'INR'); ?>">
            <input type="text" name="currency_symbol" class="form-control" style="max-width: 80px;" value="<?php echo htmlspecialchars($gen['currency_symbol'] ?? '₹'); ?>">
          </div>
        </div>

        <div class="form-group">
          <label>Default Timezone</label>
          <input type="text" name="timezone" class="form-control" value="<?php echo htmlspecialchars($gen['timezone'] ?? 'Asia/Kolkata'); ?>">
        </div>

        <div class="form-group">
          <label>Default Minimum Order Qty (MOQ)</label>
          <input type="number" name="default_min_qty" class="form-control" value="<?php echo htmlspecialchars($gen['default_min_qty'] ?? 10); ?>">
        </div>

        <div class="form-group" style="grid-column: 1 / -1;">
          <label>Footer Copyright Text</label>
          <input type="text" name="copyright_text" class="form-control" value="<?php echo htmlspecialchars($gen['copyright_text'] ?? ''); ?>">
        </div>

        <div class="form-group" style="grid-column: 1 / -1;">
          <label style="display: flex; align-items: center; gap: 8px; cursor: pointer;">
            <input type="checkbox" name="maintenance_mode" value="1" <?php echo !empty($gen['maintenance_mode']) ? 'checked' : ''; ?>>
            <span><strong>Enable Maintenance Mode</strong> (Temporarily display maintenance screen to public visitors)</span>
          </label>
        </div>
      </div>
    </div>

    <!-- CARD 2: Business & Commercial Profile -->
    <div class="card" style="margin-bottom: 24px;">
      <div class="card-header">
        <h2 class="card-title">🏢 Business &amp; Commercial Information</h2>
      </div>

      <div class="form-grid">
        <div class="form-group">
          <label>Company Trade Name *</label>
          <input type="text" name="company_name" class="form-control" value="<?php echo htmlspecialchars($biz['company_name'] ?? 'MVG Power Solutions'); ?>" required>
        </div>

        <div class="form-group">
          <label>Business Type *</label>
          <select name="business_type" class="form-control">
            <?php 
              $types = ['Manufacturer', 'Wholesaler', 'Distributor', 'Supplier', 'Trader'];
              $currType = $biz['business_type'] ?? 'Manufacturer';
              foreach ($types as $t): 
            ?>
              <option value="<?php echo $t; ?>" <?php echo ($currType === $t) ? 'selected' : ''; ?>><?php echo $t; ?></option>
            <?php endforeach; ?>
          </select>
        </div>

        <div class="form-group">
          <label>GSTIN (18% ITC Invoicing)</label>
          <input type="text" name="gstin" class="form-control" value="<?php echo htmlspecialchars($biz['gstin'] ?? ''); ?>" placeholder="e.g. 07AAECM4040N1Z5">
        </div>

        <div class="form-group">
          <label>PAN Card Number</label>
          <input type="text" name="pan_number" class="form-control" value="<?php echo htmlspecialchars($biz['pan_number'] ?? ''); ?>" placeholder="e.g. AAECM4040N">
        </div>

        <div class="form-group">
          <label>Primary Phone Number</label>
          <input type="text" name="phone_primary" class="form-control" value="<?php echo htmlspecialchars($biz['phone_primary'] ?? '+91 78360 04040'); ?>">
        </div>

        <div class="form-group">
          <label>Alternate Phone Number</label>
          <input type="text" name="phone_alternate" class="form-control" value="<?php echo htmlspecialchars($biz['phone_alternate'] ?? '+91 99991 76722'); ?>">
        </div>

        <div class="form-group">
          <label>WhatsApp Business Number (digits only)</label>
          <input type="text" name="whatsapp_number" class="form-control" value="<?php echo htmlspecialchars($biz['whatsapp_number'] ?? '917836004040'); ?>" placeholder="917836004040">
        </div>

        <div class="form-group">
          <label>General Business Email</label>
          <input type="email" name="email_business" class="form-control" value="<?php echo htmlspecialchars($biz['email_business'] ?? 'info@mvgpowersolutions.com'); ?>">
        </div>

        <div class="form-group">
          <label>Sales &amp; Quotations Email</label>
          <input type="email" name="email_sales" class="form-control" value="<?php echo htmlspecialchars($biz['email_sales'] ?? 'sales@mvgpowersolutions.com'); ?>">
        </div>

        <div class="form-group">
          <label>Technical Support Email</label>
          <input type="email" name="email_support" class="form-control" value="<?php echo htmlspecialchars($biz['email_support'] ?? 'support@mvgpowersolutions.com'); ?>">
        </div>

        <div class="form-group" style="grid-column: 1 / -1;">
          <label>Operating / Business Hours</label>
          <input type="text" name="business_hours" class="form-control" value="<?php echo htmlspecialchars($biz['business_hours'] ?? 'Monday – Saturday: 9:00 AM – 7:00 PM IST'); ?>">
        </div>

        <div class="form-group" style="grid-column: 1 / -1;">
          <label>Registered Office Address *</label>
          <textarea name="registered_address" class="form-control" rows="2"><?php echo htmlspecialchars($biz['registered_address'] ?? ''); ?></textarea>
        </div>

        <div class="form-group" style="grid-column: 1 / -1;">
          <label>Central Warehouse &amp; Dispatch Hub Address</label>
          <textarea name="warehouse_address" class="form-control" rows="2"><?php echo htmlspecialchars($biz['warehouse_address'] ?? ''); ?></textarea>
        </div>

        <div class="form-group" style="grid-column: 1 / -1;">
          <label>Google Maps Embed URL</label>
          <input type="text" name="google_maps_embed" class="form-control" value="<?php echo htmlspecialchars($biz['google_maps_embed'] ?? ''); ?>" placeholder="https://www.google.com/maps/embed?...">
        </div>
      </div>
    </div>

    <div style="display: flex; justify-content: flex-end; margin-bottom: 40px;">
      <button type="submit" class="btn-topbar btn-topbar-primary" style="padding: 12px 30px; font-size: 14px; font-weight: 700;">
        💾 Save All Settings
      </button>
    </div>

  </form>

</div>

<?php include __DIR__ . '/footer.php'; ?>

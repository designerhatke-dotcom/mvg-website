<?php
/**
 * MVG Power Solutions — Site Settings Hub
 */

require_once __DIR__ . '/../config/constants.php';
require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../config/settings.php';

$adminTitle = 'Site Settings Hub';
$adminHeading = 'System & Website Configuration Hub';

$gen = Settings::getGroup('general');
$biz = Settings::getGroup('business');

include __DIR__ . '/header.php';
?>

<div style="max-width: 1000px; margin: 0 auto;">

  <!-- Quick Settings Modules Grid -->
  <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 20px; margin-bottom: 28px;">
    
    <a href="settings_general.php" class="card" style="text-decoration: none; display: flex; flex-direction: column; gap: 8px; transition: transform 0.2s ease, border-color 0.2s ease;">
      <div style="display: flex; align-items: center; gap: 10px;">
        <span style="font-size: 26px;">🌐</span>
        <h3 style="font-size: 15px; font-weight: 800; color: var(--navy); margin: 0;">General Settings</h3>
      </div>
      <p style="font-size: 12.5px; color: var(--text-muted); margin: 0; line-height: 1.5;">
        Website name, logos, favicon, currency, timezone, and maintenance mode.
      </p>
      <span style="margin-top: auto; font-size: 12px; font-weight: 700; color: var(--primary);">Configure &rarr;</span>
    </a>

    <a href="settings_contact.php" class="card" style="text-decoration: none; display: flex; flex-direction: column; gap: 8px;">
      <div style="display: flex; align-items: center; gap: 10px;">
        <span style="font-size: 26px;">🏢</span>
        <h3 style="font-size: 15px; font-weight: 800; color: var(--navy); margin: 0;">Contact &amp; Business</h3>
      </div>
      <p style="font-size: 12.5px; color: var(--text-muted); margin: 0; line-height: 1.5;">
        Phone numbers, WhatsApp, emails, factory address, GSTIN, PAN, and Google Maps.
      </p>
      <span style="margin-top: auto; font-size: 12px; font-weight: 700; color: var(--primary);">Configure &rarr;</span>
    </a>

    <a href="header_navigation.php" class="card" style="text-decoration: none; display: flex; flex-direction: column; gap: 8px;">
      <div style="display: flex; align-items: center; gap: 10px;">
        <span style="font-size: 26px;">🧭</span>
        <h3 style="font-size: 15px; font-weight: 800; color: var(--navy); margin: 0;">Header &amp; Navigation</h3>
      </div>
      <p style="font-size: 12.5px; color: var(--text-muted); margin: 0; line-height: 1.5;">
        Logo dimensions, header height, sticky toggle, colors, and top navigation menu manager.
      </p>
      <span style="margin-top: auto; font-size: 12px; font-weight: 700; color: var(--primary);">Configure &rarr;</span>
    </a>

    <a href="mega_menu.php" class="card" style="text-decoration: none; display: flex; flex-direction: column; gap: 8px;">
      <div style="display: flex; align-items: center; gap: 10px;">
        <span style="font-size: 26px;">📑</span>
        <h3 style="font-size: 15px; font-weight: 800; color: var(--navy); margin: 0;">Mega Menu Builder</h3>
      </div>
      <p style="font-size: 12.5px; color: var(--text-muted); margin: 0; line-height: 1.5;">
        Multi-column mega dropdowns, spotlight product cards, and CT aperture lists.
      </p>
      <span style="margin-top: auto; font-size: 12px; font-weight: 700; color: var(--primary);">Configure &rarr;</span>
    </a>

    <a href="seo_settings.php" class="card" style="text-decoration: none; display: flex; flex-direction: column; gap: 8px;">
      <div style="display: flex; align-items: center; gap: 10px;">
        <span style="font-size: 26px;">🚀</span>
        <h3 style="font-size: 15px; font-weight: 800; color: var(--navy); margin: 0;">Global SEO Settings</h3>
      </div>
      <p style="font-size: 12.5px; color: var(--text-muted); margin: 0; line-height: 1.5;">
        Meta titles, descriptions, Open Graph banners, indexing directives, and webmaster tags.
      </p>
      <span style="margin-top: auto; font-size: 12px; font-weight: 700; color: var(--primary);">Configure &rarr;</span>
    </a>

    <a href="integrations.php" class="card" style="text-decoration: none; display: flex; flex-direction: column; gap: 8px;">
      <div style="display: flex; align-items: center; gap: 10px;">
        <span style="font-size: 26px;">🔌</span>
        <h3 style="font-size: 15px; font-weight: 800; color: var(--navy); margin: 0;">Integrations</h3>
      </div>
      <p style="font-size: 12.5px; color: var(--text-muted); margin: 0; line-height: 1.5;">
        Google Analytics (GA4), GTM, Meta Pixel, WhatsApp Business API, and order webhooks.
      </p>
      <span style="margin-top: auto; font-size: 12px; font-weight: 700; color: var(--primary);">Configure &rarr;</span>
    </a>
  </div>

  <!-- Summary of Active Parameters -->
  <div class="card">
    <div class="card-header">
      <h2 class="card-title">Live Commercial Parameters</h2>
      <a href="settings_general.php" class="btn-topbar">Edit Settings &rarr;</a>
    </div>

    <table class="data-table">
      <tbody>
        <tr>
          <td style="width: 240px; font-weight: 700; color: var(--navy);">Company Legal Name</td>
          <td><?php echo htmlspecialchars($gen['legal_name'] ?? SITE_NAME); ?></td>
        </tr>
        <tr>
          <td style="font-weight: 700; color: var(--navy);">Factory &amp; Registered Address</td>
          <td><?php echo htmlspecialchars($biz['registered_address'] ?? COMPANY_ADDRESS); ?></td>
        </tr>
        <tr>
          <td style="font-weight: 700; color: var(--navy);">Support &amp; WhatsApp Phone</td>
          <td><?php echo htmlspecialchars($biz['phone_primary'] ?? CONTACT_PHONE); ?> &bull; WhatsApp: +<?php echo htmlspecialchars($biz['whatsapp_number'] ?? WHATSAPP_NUMBER); ?></td>
        </tr>
        <tr>
          <td style="font-weight: 700; color: var(--navy);">GST Tax Rate &amp; Invoicing</td>
          <td>18% (Harmonized HSN - Full B2B Input Tax Credit Eligible)</td>
        </tr>
        <tr>
          <td style="font-weight: 700; color: var(--navy);">Default Minimum Order Quantity</td>
          <td><?php echo htmlspecialchars($gen['default_min_qty'] ?? DEFAULT_MIN_QTY); ?> pieces</td>
        </tr>
      </tbody>
    </table>
  </div>

</div>

<?php include __DIR__ . '/footer.php'; ?>

<?php
/**
 * MVG Power Solutions — Schema.org JSON-LD Structured Data Manager
 */

require_once __DIR__ . '/../config/constants.php';
require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../config/settings.php';

$adminTitle = 'Schema Markup';
$adminHeading = 'JSON-LD Structured Data & Rich Snippets';

$biz = Settings::getGroup('business');
$gen = Settings::getGroup('general');
$baseUrl = rtrim(Settings::get('general.site_url', SITE_URL), '/') . '/';

// Generate Sample Organization Schema
$orgSchema = [
    '@context' => 'https://schema.org',
    '@type'    => 'Organization',
    'name'     => $gen['site_name'] ?? SITE_NAME,
    'legalName'=> $gen['legal_name'] ?? 'MVG Power Solutions Private Limited',
    'url'      => $baseUrl,
    'logo'     => $baseUrl . 'assets/Logo-11.png',
    'contactPoint' => [
        '@type'       => 'ContactPoint',
        'telephone'   => $biz['phone_primary'] ?? '+91-7836004040',
        'contactType' => 'sales',
        'areaServed'  => 'IN',
        'availableLanguage' => ['en', 'hi']
    ],
    'address' => [
        '@type'           => 'PostalAddress',
        'streetAddress'   => $biz['registered_address'] ?? COMPANY_ADDRESS,
        'addressLocality' => 'New Delhi',
        'addressRegion'   => 'Delhi',
        'postalCode'      => '110083',
        'addressCountry'  => 'IN'
    ]
];

include __DIR__ . '/header.php';
?>

<div style="max-width: 900px; margin: 0 auto;">

  <div class="card" style="margin-bottom: 24px;">
    <div class="card-header">
      <div>
        <h2 class="card-title">🏷️ Active JSON-LD Schema Markup</h2>
        <span style="font-size: 12px; color: var(--text-muted);">Automatically rendered in the <code>&lt;head&gt;</code> of public pages for Google Rich Snippets</span>
      </div>
      <a href="https://search.google.com/test/rich-results" target="_blank" class="btn-topbar">Google Rich Results Test ↗</a>
    </div>

    <!-- Organization Schema -->
    <div style="margin-bottom: 24px;">
      <h3 style="font-size: 14px; font-weight: 700; color: var(--navy); margin-bottom: 6px;">1. Organization &amp; Manufacturer Schema</h3>
      <p style="font-size: 12.5px; color: var(--text-muted); margin-bottom: 10px;">
        Identifies MVG Power Solutions as a certified legal manufacturer on Google Knowledge Graph.
      </p>
      <pre style="background: #0F172A; color: #38BDF8; padding: 16px; border-radius: 8px; font-size: 12px; overflow-x: auto; line-height: 1.5;"><?php echo htmlspecialchars(json_encode($orgSchema, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES)); ?></pre>
    </div>

    <!-- Product Schema Description -->
    <div>
      <h3 style="font-size: 14px; font-weight: 700; color: var(--navy); margin-bottom: 6px;">2. Dynamic Product &amp; AggregateRating Schema</h3>
      <p style="font-size: 12.5px; color: var(--text-muted); margin-bottom: 10px;">
        Every product page automatically renders Google <code>Product</code> Schema with Class 1.0 specifications, 18% GST price in INR, and verified 5-star Google review stars.
      </p>
      <div style="background: #F0FDF4; border: 1px solid #BBF7D0; border-radius: 8px; padding: 14px; color: #166534; font-size: 13px;">
        ✓ <strong>Fully automated:</strong> Schema is dynamically embedded in <code>MVG/product.php</code>, <code>MVG/collections.php</code>, and <code>MVG/category.php</code>.
      </div>
    </div>
  </div>

</div>

<?php include __DIR__ . '/footer.php'; ?>

<?php
/**
 * MVG Power Solutions — XML Sitemap Manager
 */

require_once __DIR__ . '/../config/constants.php';
require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../config/settings.php';

$adminTitle = 'XML Sitemap';
$adminHeading = 'Search Engine XML Sitemap Settings';

$sitemapUrl = rtrim(Settings::get('general.site_url', SITE_URL), '/') . '/sitemap.php';
$categories = Database::getCategories();
$products = Database::getProducts();
$totalUrls = count($categories) + count($products) + 2;

include __DIR__ . '/header.php';
?>

<div style="max-width: 860px; margin: 0 auto;">

  <div class="card" style="margin-bottom: 24px;">
    <div class="card-header">
      <div>
        <h2 class="card-title">🗺️ Google XML Sitemap</h2>
        <span style="font-size: 12px; color: var(--text-muted);">Real-time auto-generated sitemap including all products, categories, and image tags</span>
      </div>
      <a href="../sitemap.php" target="_blank" class="btn-topbar btn-topbar-primary">View Live XML Sitemap ↗</a>
    </div>

    <div style="background: #F8FAFC; border: 1px solid var(--border); border-radius: 8px; padding: 18px; margin-bottom: 20px;">
      <label style="font-size: 12px; font-weight: 700; color: #475569; text-transform: uppercase;">Public Sitemap URL for Google Search Console:</label>
      <div style="display: flex; gap: 10px; margin-top: 6px;">
        <input type="text" class="form-control" value="<?php echo htmlspecialchars($sitemapUrl); ?>" readonly style="background: #fff; font-family: monospace;">
        <button type="button" class="btn-topbar" onclick="navigator.clipboard.writeText('<?php echo htmlspecialchars($sitemapUrl); ?>'); alert('Copied Sitemap URL: <?php echo htmlspecialchars($sitemapUrl); ?>');">
          📋 Copy
        </button>
      </div>
    </div>

    <div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 16px;">
      <div style="padding: 16px; background: #F0F9FF; border-radius: 8px; border: 1px solid #BAE6FD; text-align: center;">
        <span style="font-size: 12px; color: #0369A1; font-weight: 700;">Total Indexed URLs</span>
        <h3 style="font-size: 28px; color: #0284C7; margin: 4px 0 0 0;"><?php echo $totalUrls; ?></h3>
      </div>
      <div style="padding: 16px; background: #F8FAFC; border-radius: 8px; border: 1px solid var(--border); text-align: center;">
        <span style="font-size: 12px; color: var(--text-muted); font-weight: 700;">Product Pages</span>
        <h3 style="font-size: 28px; color: var(--navy); margin: 4px 0 0 0;"><?php echo count($products); ?></h3>
      </div>
      <div style="padding: 16px; background: #F8FAFC; border-radius: 8px; border: 1px solid var(--border); text-align: center;">
        <span style="font-size: 12px; color: var(--text-muted); font-weight: 700;">Category Pages</span>
        <h3 style="font-size: 28px; color: var(--navy); margin: 4px 0 0 0;"><?php echo count($categories); ?></h3>
      </div>
    </div>

    <div style="margin-top: 24px; font-size: 13px; color: #475569; line-height: 1.6; background: #F1F5F9; padding: 14px; border-radius: 8px;">
      💡 <strong>Zero Maintenance Required:</strong> Whenever you add or edit a product or category in the admin panel, the sitemap updates automatically in real-time without needing manual generation.
    </div>
  </div>

</div>

<?php include __DIR__ . '/footer.php'; ?>

<?php
/**
 * MVG Power Solutions — Robots.txt Manager
 */

require_once __DIR__ . '/../config/constants.php';
require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../config/settings.php';

$adminTitle = 'Robots.txt Settings';
$adminHeading = 'Robots.txt Search Crawler Directives';

$robotsPath = __DIR__ . '/../robots.txt';
$successMsg = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $content = $_POST['robots_content'] ?? '';
    file_put_contents($robotsPath, $content);
    $successMsg = '✓ robots.txt file saved successfully!';
}

$robotsContent = file_exists($robotsPath) ? file_get_contents($robotsPath) : "User-agent: *\nAllow: /\nDisallow: /admin/\nSitemap: " . SITE_URL . "/sitemap.php";

include __DIR__ . '/header.php';
?>

<div style="max-width: 800px; margin: 0 auto;">

  <?php if (!empty($successMsg)): ?>
    <div style="background: #F0FDF4; border-left: 4px solid var(--green); color: #166534; padding: 12px 18px; font-size: 13.5px; border-radius: 8px; margin-bottom: 20px;">
      <?php echo $successMsg; ?>
    </div>
  <?php endif; ?>

  <div class="card">
    <div class="card-header">
      <div>
        <h2 class="card-title">🤖 robots.txt Editor</h2>
        <span style="font-size: 12px; color: var(--text-muted);">Configure crawler access rules for Googlebot, Bingbot, and other search engines</span>
      </div>
      <a href="../robots.txt" target="_blank" class="btn-topbar">View Live robots.txt ↗</a>
    </div>

    <form method="POST" action="">
      <div class="form-group">
        <label>File Content (robots.txt)</label>
        <textarea name="robots_content" class="form-control" rows="12" style="font-family: monospace; font-size: 13px;"><?php echo htmlspecialchars($robotsContent); ?></textarea>
      </div>

      <div style="display: flex; justify-content: flex-end;">
        <button type="submit" class="btn-topbar btn-topbar-primary" style="padding: 10px 24px; font-weight: 700;">
          💾 Save robots.txt
        </button>
      </div>
    </form>
  </div>

</div>

<?php include __DIR__ . '/footer.php'; ?>

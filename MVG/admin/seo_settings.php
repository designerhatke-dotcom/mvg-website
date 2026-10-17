<?php
/**
 * MVG Power Solutions — Global SEO Settings
 */

require_once __DIR__ . '/../config/constants.php';
require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../config/settings.php';

$adminTitle = 'Global SEO Settings';
$adminHeading = 'Search Engine Optimization & Global Meta Controls';

$successMsg = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $seo = [
        'meta_title'               => trim($_POST['meta_title'] ?? ''),
        'meta_description'         => trim($_POST['meta_description'] ?? ''),
        'canonical_base'           => trim($_POST['canonical_base'] ?? ''),
        'og_title'                 => trim($_POST['og_title'] ?? ''),
        'og_description'           => trim($_POST['og_description'] ?? ''),
        'og_image'                 => trim($_POST['og_image'] ?? ''),
        'twitter_card'             => trim($_POST['twitter_card'] ?? 'summary_large_image'),
        'robots_index'             => isset($_POST['robots_index']),
        'robots_follow'            => isset($_POST['robots_follow']),
        'google_site_verification' => trim($_POST['google_site_verification'] ?? ''),
        'bing_verification'        => trim($_POST['bing_verification'] ?? '')
    ];
    Settings::saveGroup('seo', $seo);
    $successMsg = '✓ Global SEO settings, Open Graph and Indexing directives updated!';
}

$seo = Settings::getGroup('seo');

include __DIR__ . '/header.php';
?>

<div style="max-width: 960px; margin: 0 auto;">

  <?php if (!empty($successMsg)): ?>
    <div style="background: #F0FDF4; border-left: 4px solid var(--green); color: #166534; padding: 12px 18px; font-size: 13.5px; border-radius: 8px; margin-bottom: 20px;">
      <?php echo $successMsg; ?>
    </div>
  <?php endif; ?>

  <form method="POST" action="">

    <!-- Global Metas & Google SERP Preview -->
    <div class="card" style="margin-bottom: 24px;">
      <div class="card-header">
        <h2 class="card-title">🔍 Global Default Meta Tags</h2>
      </div>

      <!-- Google SERP Snippet Preview Box -->
      <div style="background: #FFFFFF; border: 1px solid #CBD5E1; border-radius: 8px; padding: 16px 20px; margin-bottom: 20px; font-family: arial, sans-serif;">
        <div style="font-size: 12px; color: #4D5156; display: flex; align-items: center; gap: 6px;">
          <span>www.mvgpowersolutions.com › mvg</span>
        </div>
        <div id="serpTitle" style="color: #1a0dab; font-size: 18px; font-weight: 500; margin-top: 4px; line-height: 1.3;">
          <?php echo htmlspecialchars($seo['meta_title'] ?? 'MVG Power Solutions | Precision Current Transformers Class 1.0 & 0.5'); ?>
        </div>
        <div id="serpDesc" style="color: #4d5156; font-size: 13.5px; line-height: 1.5; margin-top: 4px;">
          <?php echo htmlspecialchars($seo['meta_description'] ?? 'Leading Indian manufacturer of IS 2705 certified current transformers. Ring CT, Square CT, Tape Wound, Resin Cast & Split Core CT with 18% GST Input Tax Credit.'); ?>
        </div>
      </div>

      <div class="form-group">
        <div style="display: flex; justify-content: space-between;">
          <label>Default Website Meta Title *</label>
          <span id="titleCount" style="font-size: 11px; color: var(--text-muted);">60 chars recommended</span>
        </div>
        <input type="text" id="metaTitleInp" name="meta_title" class="form-control" value="<?php echo htmlspecialchars($seo['meta_title'] ?? ''); ?>" required oninput="updatePreview()">
      </div>

      <div class="form-group">
        <div style="display: flex; justify-content: space-between;">
          <label>Default Website Meta Description *</label>
          <span id="descCount" style="font-size: 11px; color: var(--text-muted);">155-160 chars recommended</span>
        </div>
        <textarea id="metaDescInp" name="meta_description" class="form-control" rows="3" required oninput="updatePreview()"><?php echo htmlspecialchars($seo['meta_description'] ?? ''); ?></textarea>
      </div>

      <div class="form-group">
        <label>Website Canonical Base URL</label>
        <input type="url" name="canonical_base" class="form-control" value="<?php echo htmlspecialchars($seo['canonical_base'] ?? SITE_URL . '/'); ?>">
      </div>
    </div>

    <!-- Social Open Graph & Twitter Cards -->
    <div class="card" style="margin-bottom: 24px;">
      <div class="card-header">
        <h2 class="card-title">🌐 Social Sharing (Open Graph &amp; Twitter)</h2>
      </div>

      <div class="form-grid">
        <div class="form-group">
          <label>Open Graph (OG) Title</label>
          <input type="text" name="og_title" class="form-control" value="<?php echo htmlspecialchars($seo['og_title'] ?? ''); ?>">
        </div>

        <div class="form-group">
          <label>Twitter Card Type</label>
          <select name="twitter_card" class="form-control">
            <option value="summary_large_image">summary_large_image (Large Banner)</option>
            <option value="summary">summary (Compact Thumbnail)</option>
          </select>
        </div>

        <div class="form-group" style="grid-column: 1 / -1;">
          <label>Open Graph (OG) Description</label>
          <textarea name="og_description" class="form-control" rows="2"><?php echo htmlspecialchars($seo['og_description'] ?? ''); ?></textarea>
        </div>

        <div class="form-group" style="grid-column: 1 / -1;">
          <label>Default Social Share Image URL</label>
          <input type="text" name="og_image" class="form-control" value="<?php echo htmlspecialchars($seo['og_image'] ?? 'assets/categories/encapsulated-ring-ct.jpg'); ?>">
        </div>
      </div>
    </div>

    <!-- Robots & Webmaster Verification -->
    <div class="card" style="margin-bottom: 24px;">
      <div class="card-header">
        <h2 class="card-title">🤖 Search Engine Indexing &amp; Verification</h2>
      </div>

      <div style="margin-bottom: 16px; display: flex; gap: 24px;">
        <label style="display: flex; align-items: center; gap: 8px; font-size: 13.5px; cursor: pointer;">
          <input type="checkbox" name="robots_index" value="1" <?php echo !isset($seo['robots_index']) || !empty($seo['robots_index']) ? 'checked' : ''; ?>>
          <span><strong>Index</strong> (Allow search engines to index pages)</span>
        </label>
        <label style="display: flex; align-items: center; gap: 8px; font-size: 13.5px; cursor: pointer;">
          <input type="checkbox" name="robots_follow" value="1" <?php echo !isset($seo['robots_follow']) || !empty($seo['robots_follow']) ? 'checked' : ''; ?>>
          <span><strong>Follow</strong> (Allow crawlers to follow links)</span>
        </label>
      </div>

      <div class="form-grid">
        <div class="form-group">
          <label>Google Search Console Verification Code</label>
          <input type="text" name="google_site_verification" class="form-control" value="<?php echo htmlspecialchars($seo['google_site_verification'] ?? ''); ?>" placeholder="google-site-verification=...">
        </div>

        <div class="form-group">
          <label>Bing Webmaster Tools Verification Code</label>
          <input type="text" name="bing_verification" class="form-control" value="<?php echo htmlspecialchars($seo['bing_verification'] ?? ''); ?>" placeholder="XML or Meta code">
        </div>
      </div>
    </div>

    <div style="display: flex; justify-content: flex-end; margin-bottom: 40px;">
      <button type="submit" class="btn-topbar btn-topbar-primary" style="padding: 12px 30px; font-weight: 700;">
        💾 Save Global SEO Settings
      </button>
    </div>

  </form>

</div>

<script>
function updatePreview() {
  const t = document.getElementById('metaTitleInp').value;
  const d = document.getElementById('metaDescInp').value;
  document.getElementById('serpTitle').textContent = t || 'Website Title';
  document.getElementById('serpDesc').textContent = d || 'Meta description snippet';
  document.getElementById('titleCount').textContent = t.length + ' / 60 chars';
  document.getElementById('descCount').textContent = d.length + ' / 160 chars';
}
updatePreview();
</script>

<?php include __DIR__ . '/footer.php'; ?>

<?php
/**
 * MVG Power Solutions — Social Media Profiles Manager
 */

require_once __DIR__ . '/../config/constants.php';
require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../config/settings.php';

$adminTitle = 'Social Media Links';
$adminHeading = 'Official Social Media Profiles';

$successMsg = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $social = [
        'facebook'  => trim($_POST['facebook'] ?? ''),
        'linkedin'  => trim($_POST['linkedin'] ?? ''),
        'instagram' => trim($_POST['instagram'] ?? ''),
        'youtube'   => trim($_POST['youtube'] ?? ''),
        'twitter'   => trim($_POST['twitter'] ?? '')
    ];
    Settings::saveGroup('social', $social);
    $successMsg = '✓ Social media profiles updated successfully.';
}

$soc = Settings::getGroup('social');

include __DIR__ . '/header.php';
?>

<div style="max-width: 760px; margin: 0 auto;">

  <?php if (!empty($successMsg)): ?>
    <div style="background: #F0FDF4; border-left: 4px solid var(--green); color: #166534; padding: 12px 18px; font-size: 13.5px; border-radius: 8px; margin-bottom: 20px;">
      <?php echo $successMsg; ?>
    </div>
  <?php endif; ?>

  <div class="card">
    <div class="card-header">
      <h2 class="card-title">🔗 Social Media URLs &amp; Tracking</h2>
    </div>

    <form method="POST" action="">
      <div class="form-group">
        <label>💼 LinkedIn Company Page</label>
        <input type="url" name="linkedin" class="form-control" value="<?php echo htmlspecialchars($soc['linkedin'] ?? ''); ?>" placeholder="https://linkedin.com/company/mvg-power-solutions">
      </div>

      <div class="form-group">
        <label>📘 Facebook Page</label>
        <input type="url" name="facebook" class="form-control" value="<?php echo htmlspecialchars($soc['facebook'] ?? ''); ?>" placeholder="https://facebook.com/mvgpowersolutions">
      </div>

      <div class="form-group">
        <label>📸 Instagram Business Profile</label>
        <input type="url" name="instagram" class="form-control" value="<?php echo htmlspecialchars($soc['instagram'] ?? ''); ?>" placeholder="https://instagram.com/mvgpowersolutions">
      </div>

      <div class="form-group">
        <label>▶️ YouTube Channel (Video Demonstrations &amp; Testing)</label>
        <input type="url" name="youtube" class="form-control" value="<?php echo htmlspecialchars($soc['youtube'] ?? ''); ?>" placeholder="https://youtube.com/@mvgpowersolutions">
      </div>

      <div class="form-group">
        <label>🐦 Twitter / X Profile</label>
        <input type="url" name="twitter" class="form-control" value="<?php echo htmlspecialchars($soc['twitter'] ?? ''); ?>" placeholder="https://twitter.com/mvgpower">
      </div>

      <button type="submit" class="btn-topbar btn-topbar-primary" style="width: 100%; justify-content: center; padding: 12px; font-weight: 700; margin-top: 10px;">
        💾 Save Social Media Profiles
      </button>
    </form>
  </div>

</div>

<?php include __DIR__ . '/footer.php'; ?>

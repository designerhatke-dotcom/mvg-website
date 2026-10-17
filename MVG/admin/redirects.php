<?php
/**
 * MVG Power Solutions — 301 Permanent Redirect Manager
 */

require_once __DIR__ . '/../config/constants.php';
require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../config/settings.php';

$adminTitle = 'Redirect Manager';
$adminHeading = '301 Permanent Redirect Manager & 404 Prevention';

$redFile = __DIR__ . '/../data/redirects.json';
$redirects = file_exists($redFile) ? (json_decode(file_get_contents($redFile), true) ?: []) : [];

$successMsg = '';
$errorMsg = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = $_POST['action'] ?? 'add';

    if ($action === 'add') {
        $source = trim($_POST['source_url'] ?? '', '/');
        $target = trim($_POST['target_url'] ?? '');
        $code = intval($_POST['status_code'] ?? 301);

        if (!empty($source) && !empty($target)) {
            $redirects[] = [
                'id'          => time(),
                'source_url'  => $source,
                'target_url'  => $target,
                'status_code' => $code,
                'hits'        => 0,
                'created_at'  => date('Y-m-d')
            ];
            file_put_contents($redFile, json_encode($redirects, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES));
            $successMsg = '✓ Redirect rule created successfully!';
        } else {
            $errorMsg = 'Source URL and Target URL are required.';
        }
    } elseif ($action === 'delete') {
        $delId = intval($_POST['red_id'] ?? 0);
        $redirects = array_values(array_filter($redirects, function($r) use ($delId) {
            return ($r['id'] ?? 0) != $delId;
        }));
        file_put_contents($redFile, json_encode($redirects, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES));
        $successMsg = '✓ Redirect rule deleted.';
    }
}

include __DIR__ . '/header.php';
?>

<div style="display: grid; grid-template-columns: 360px 1fr; gap: 24px; align-items: start;">

  <!-- Add Redirect Form -->
  <div class="card">
    <div class="card-header">
      <h2 class="card-title">+ Add 301 / 302 Redirect</h2>
    </div>

    <?php if (!empty($successMsg)): ?>
      <div style="background: #F0FDF4; border-left: 4px solid var(--green); color: #166534; padding: 10px 14px; font-size: 13px; border-radius: 6px; margin-bottom: 16px;">
        <?php echo $successMsg; ?>
      </div>
    <?php endif; ?>

    <form method="POST" action="">
      <input type="hidden" name="action" value="add">

      <div class="form-group">
        <label>Old Path / Source URL *</label>
        <input type="text" name="source_url" class="form-control" placeholder="e.g. old-product-page or product-category/ct" required>
        <span style="font-size: 11px; color: var(--text-muted); margin-top: 3px; display: block;">Relative path without leading slash</span>
      </div>

      <div class="form-group">
        <label>Destination Target URL *</label>
        <input type="text" name="target_url" class="form-control" placeholder="e.g. category.php?slug=encapsulated-ring-ct" required>
      </div>

      <div class="form-group">
        <label>Redirect Type</label>
        <select name="status_code" class="form-control">
          <option value="301">301 Moved Permanently (SEO Recommended)</option>
          <option value="302">302 Found (Temporary Redirect)</option>
        </select>
      </div>

      <button type="submit" class="btn-topbar btn-topbar-primary" style="width: 100%; justify-content: center; padding: 11px;">
        + Create Redirect Rule
      </button>
    </form>
  </div>

  <!-- Existing Redirects Table -->
  <div class="card">
    <div class="card-header">
      <div>
        <h2 class="card-title">Active 301 Redirect Rules (<?php echo count($redirects); ?>)</h2>
        <span style="font-size: 12px; color: var(--text-muted);">Automatically intercepts traffic and routes visitors to new canonical URLs</span>
      </div>
    </div>

    <table class="data-table">
      <thead>
        <tr>
          <th>Source Path</th>
          <th>Destination URL</th>
          <th>Type</th>
          <th>Hits</th>
          <th style="text-align: right;">Action</th>
        </tr>
      </thead>
      <tbody>
        <?php if (empty($redirects)): ?>
          <tr><td colspan="5" style="text-align: center; color: #94A3B8; padding: 20px;">No redirects defined.</td></tr>
        <?php else: ?>
          <?php foreach ($redirects as $r): ?>
            <tr>
              <td><code>/<?php echo htmlspecialchars($r['source_url']); ?></code></td>
              <td><strong><?php echo htmlspecialchars($r['target_url']); ?></strong></td>
              <td><span class="badge badge-success"><?php echo $r['status_code']; ?></span></td>
              <td><?php echo $r['hits'] ?? 0; ?></td>
              <td style="text-align: right;">
                <form method="POST" action="" style="display: inline;" onsubmit="return confirm('Delete redirect rule?');">
                  <input type="hidden" name="action" value="delete">
                  <input type="hidden" name="red_id" value="<?php echo $r['id']; ?>">
                  <button type="submit" class="btn-gallery-action btn-remove-gallery" style="padding: 4px 8px;">Delete</button>
                </form>
              </td>
            </tr>
          <?php endforeach; ?>
        <?php endif; ?>
      </tbody>
    </table>
  </div>

</div>

<?php include __DIR__ . '/footer.php'; ?>

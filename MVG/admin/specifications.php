<?php
/**
 * MVG Power Solutions — Product Specifications Library & Template Manager
 */

require_once __DIR__ . '/../config/constants.php';
require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../config/settings.php';

$adminTitle = 'Product Specifications';
$adminHeading = 'Current Transformer Technical Specifications Library';

$specFile = __DIR__ . '/../data/spec_templates.json';
$specs = file_exists($specFile) ? (json_decode(file_get_contents($specFile), true) ?: []) : [];

$successMsg = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = $_POST['action'] ?? 'add';

    if ($action === 'add') {
        $key = trim($_POST['key'] ?? '');
        $unit = trim($_POST['unit'] ?? '');
        $type = trim($_POST['type'] ?? 'text');
        $default = trim($_POST['default'] ?? '');

        if (!empty($key)) {
            $specs[] = [
                'key'     => $key,
                'unit'    => $unit,
                'type'    => $type,
                'default' => $default
            ];
            file_put_contents($specFile, json_encode($specs, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES));
            $successMsg = '✓ Specification attribute added to library!';
        }
    } elseif ($action === 'delete') {
        $delIdx = intval($_POST['idx'] ?? -1);
        if ($delIdx >= 0 && isset($specs[$delIdx])) {
            array_splice($specs, $delIdx, 1);
            file_put_contents($specFile, json_encode($specs, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES));
            $successMsg = '✓ Specification attribute removed.';
        }
    }
}

include __DIR__ . '/header.php';
?>

<div style="display: grid; grid-template-columns: 340px 1fr; gap: 24px; align-items: start;">

  <!-- Add Specification Field Form -->
  <div class="card">
    <div class="card-header">
      <h2 class="card-title">+ Add Spec Attribute</h2>
    </div>

    <?php if (!empty($successMsg)): ?>
      <div style="background: #F0FDF4; border-left: 4px solid var(--green); color: #166534; padding: 10px 14px; font-size: 13px; border-radius: 6px; margin-bottom: 16px;">
        <?php echo $successMsg; ?>
      </div>
    <?php endif; ?>

    <form method="POST" action="">
      <input type="hidden" name="action" value="add">

      <div class="form-group">
        <label>Specification Name *</label>
        <input type="text" name="key" class="form-control" placeholder="e.g. Primary Current or Burden VA" required>
      </div>

      <div class="form-group">
        <label>Measurement Unit (Optional)</label>
        <input type="text" name="unit" class="form-control" placeholder="e.g. A, V, VA, mm, Hz, °C">
      </div>

      <div class="form-group">
        <label>Field Type</label>
        <select name="type" class="form-control">
          <option value="text">Text Input</option>
          <option value="select">Dropdown Options</option>
          <option value="number">Numeric</option>
        </select>
      </div>

      <div class="form-group">
        <label>Default / Suggested Value</label>
        <input type="text" name="default" class="form-control" placeholder="e.g. 5A (1A on request)">
      </div>

      <button type="submit" class="btn-topbar btn-topbar-primary" style="width: 100%; justify-content: center; padding: 11px;">
        + Save Attribute to Library
      </button>
    </form>
  </div>

  <!-- Technical Specifications Table -->
  <div class="card">
    <div class="card-header">
      <div>
        <h2 class="card-title">Standard CT Specification Attributes (<?php echo count($specs); ?>)</h2>
        <span style="font-size: 12px; color: var(--text-muted);">Attributes automatically available when authoring or editing products</span>
      </div>
    </div>

    <table class="data-table">
      <thead>
        <tr>
          <th>Attribute Name</th>
          <th>Unit</th>
          <th>Type</th>
          <th>Default / Suggested Value</th>
          <th style="text-align: right;">Action</th>
        </tr>
      </thead>
      <tbody>
        <?php foreach ($specs as $idx => $s): ?>
          <tr>
            <td><strong><?php echo htmlspecialchars($s['key']); ?></strong></td>
            <td><code><?php echo htmlspecialchars($s['unit'] ?: '—'); ?></code></td>
            <td><span class="badge badge-info" style="font-size: 11px;"><?php echo htmlspecialchars($s['type'] ?? 'text'); ?></span></td>
            <td style="font-size: 12.5px; color: var(--text-muted);"><?php echo htmlspecialchars($s['default'] ?? '—'); ?></td>
            <td style="text-align: right;">
              <form method="POST" action="" style="display: inline;" onsubmit="return confirm('Remove attribute?');">
                <input type="hidden" name="action" value="delete">
                <input type="hidden" name="idx" value="<?php echo $idx; ?>">
                <button type="submit" class="btn-gallery-action btn-remove-gallery" style="padding: 4px 8px;">Delete</button>
              </form>
            </td>
          </tr>
        <?php endforeach; ?>
      </tbody>
    </table>
  </div>

</div>

<?php include __DIR__ . '/footer.php'; ?>

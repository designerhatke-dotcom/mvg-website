<?php
/**
 * MVG Power Solutions — Header Styling & Navigation Menu Manager
 */

require_once __DIR__ . '/../config/constants.php';
require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../config/settings.php';

$adminTitle = 'Header & Navigation';
$adminHeading = 'Header Configuration & Navigation Menu Manager';

$navJsonFile = __DIR__ . '/../data/navigation.json';
$menuItems = file_exists($navJsonFile) ? (json_decode(file_get_contents($navJsonFile), true) ?: []) : [];
$allCategories = Database::getCategories();

$successMsg = '';
$errorMsg = '';

// Handle actions
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = $_POST['action'] ?? 'save_header';

    if ($action === 'save_header') {
        $header = [
            'header_bg'          => trim($_POST['header_bg'] ?? '#FFFFFF'),
            'nav_text_color'     => trim($_POST['nav_text_color'] ?? '#0F172A'),
            'nav_hover_color'    => trim($_POST['nav_hover_color'] ?? '#0284C7'),
            'nav_active_color'   => trim($_POST['nav_active_color'] ?? '#0284C7'),
            'header_height'      => intval($_POST['header_height'] ?? 76),
            'sticky_header'      => isset($_POST['sticky_header']),
            'transparent_header' => isset($_POST['transparent_header']),
            'search_visible'     => isset($_POST['search_visible']),
            'cta_text'           => trim($_POST['cta_text'] ?? 'Request Quote'),
            'cta_url'            => trim($_POST['cta_url'] ?? '')
        ];
        Settings::saveGroup('header', $header);

        // Update logo dimensions in general group
        Settings::set('general.logo_width', intval($_POST['logo_width'] ?? 180));
        Settings::set('general.logo_height', intval($_POST['logo_height'] ?? 48));
        Settings::set('general.logo_url', trim($_POST['logo_url'] ?? 'assets/Logo-11.png'));

        $successMsg = '✓ Header appearance and styling updated successfully!';
    } elseif ($action === 'add_menu_item') {
        $label = trim($_POST['label'] ?? '');
        $url = trim($_POST['url'] ?? '');
        $type = trim($_POST['type'] ?? 'custom');
        $newTab = isset($_POST['new_tab']);

        if (!empty($label) && !empty($url)) {
            $newItem = [
                'id'      => time(),
                'label'   => $label,
                'url'     => $url,
                'type'    => $type,
                'new_tab' => $newTab,
                'enabled' => true,
                'sort'    => count($menuItems) + 1
            ];
            $menuItems[] = $newItem;
            file_put_contents($navJsonFile, json_encode($menuItems, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES));
            $successMsg = '✓ Navigation menu link added!';
        } else {
            $errorMsg = 'Menu Label and URL are required.';
        }
    } elseif ($action === 'delete_menu_item') {
        $delId = intval($_POST['menu_id'] ?? 0);
        $menuItems = array_values(array_filter($menuItems, function($m) use ($delId) {
            return ($m['id'] ?? 0) != $delId;
        }));
        file_put_contents($navJsonFile, json_encode($menuItems, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES));
        $successMsg = '✓ Navigation menu link removed.';
    } elseif ($action === 'toggle_menu_item') {
        $toggleId = intval($_POST['menu_id'] ?? 0);
        foreach ($menuItems as &$m) {
            if (($m['id'] ?? 0) == $toggleId) {
                $m['enabled'] = !($m['enabled'] ?? true);
                break;
            }
        }
        file_put_contents($navJsonFile, json_encode($menuItems, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES));
        $successMsg = '✓ Menu item status updated.';
    }
}

$hdr = Settings::getGroup('header');
$gen = Settings::getGroup('general');

include __DIR__ . '/header.php';
?>

<div style="display: grid; grid-template-columns: 1fr 1fr; gap: 24px; align-items: start;">

  <!-- LEFT COLUMN: Header Appearance & Layout -->
  <div class="card">
    <div class="card-header">
      <h2 class="card-title">🎨 Header Styling &amp; Controls</h2>
    </div>

    <?php if (!empty($successMsg)): ?>
      <div style="background: #F0FDF4; border-left: 4px solid var(--green); color: #166534; padding: 10px 14px; font-size: 13px; border-radius: 6px; margin-bottom: 16px;">
        <?php echo $successMsg; ?>
      </div>
    <?php endif; ?>

    <form method="POST" action="">
      <input type="hidden" name="action" value="save_header">

      <div class="form-group">
        <label>Website Logo URL / Path</label>
        <input type="text" name="logo_url" class="form-control" value="<?php echo htmlspecialchars($gen['logo_url'] ?? 'assets/Logo-11.png'); ?>">
      </div>

      <div class="form-grid">
        <div class="form-group">
          <label>Logo Width (px)</label>
          <input type="number" name="logo_width" class="form-control" value="<?php echo htmlspecialchars($gen['logo_width'] ?? 180); ?>">
        </div>
        <div class="form-group">
          <label>Logo Height (px)</label>
          <input type="number" name="logo_height" class="form-control" value="<?php echo htmlspecialchars($gen['logo_height'] ?? 48); ?>">
        </div>
      </div>

      <div class="form-grid">
        <div class="form-group">
          <label>Header Height (px)</label>
          <input type="number" name="header_height" class="form-control" value="<?php echo htmlspecialchars($hdr['header_height'] ?? 76); ?>">
        </div>
        <div class="form-group">
          <label>Header Background Color</label>
          <input type="text" name="header_bg" class="form-control" value="<?php echo htmlspecialchars($hdr['header_bg'] ?? '#FFFFFF'); ?>">
        </div>
      </div>

      <div class="form-grid">
        <div class="form-group">
          <label>Nav Text Color</label>
          <input type="text" name="nav_text_color" class="form-control" value="<?php echo htmlspecialchars($hdr['nav_text_color'] ?? '#0F172A'); ?>">
        </div>
        <div class="form-group">
          <label>Nav Hover Color</label>
          <input type="text" name="nav_hover_color" class="form-control" value="<?php echo htmlspecialchars($hdr['nav_hover_color'] ?? '#0284C7'); ?>">
        </div>
      </div>

      <div class="form-grid">
        <div class="form-group">
          <label>Header CTA Button Text</label>
          <input type="text" name="cta_text" class="form-control" value="<?php echo htmlspecialchars($hdr['cta_text'] ?? 'Request Quote'); ?>">
        </div>
        <div class="form-group">
          <label>Header CTA Link</label>
          <input type="text" name="cta_url" class="form-control" value="<?php echo htmlspecialchars($hdr['cta_url'] ?? 'https://wa.me/' . WHATSAPP_NUMBER); ?>">
        </div>
      </div>

      <div style="margin: 16px 0; display: flex; flex-direction: column; gap: 8px;">
        <label style="display: flex; align-items: center; gap: 8px; font-size: 13px; cursor: pointer;">
          <input type="checkbox" name="sticky_header" value="1" <?php echo !isset($hdr['sticky_header']) || !empty($hdr['sticky_header']) ? 'checked' : ''; ?>>
          <span><strong>Sticky Header</strong> (Remains pinned to top during scrolling)</span>
        </label>
        <label style="display: flex; align-items: center; gap: 8px; font-size: 13px; cursor: pointer;">
          <input type="checkbox" name="search_visible" value="1" <?php echo !isset($hdr['search_visible']) || !empty($hdr['search_visible']) ? 'checked' : ''; ?>>
          <span><strong>Display Search Bar</strong> in Header</span>
        </label>
      </div>

      <button type="submit" class="btn-topbar btn-topbar-primary" style="width: 100%; justify-content: center; padding: 11px; font-weight: 700;">
        💾 Save Header Styling
      </button>
    </form>
  </div>

  <!-- RIGHT COLUMN: Navigation Menu Items Manager -->
  <div class="card">
    <div class="card-header">
      <div>
        <h2 class="card-title">🧭 Navigation Menu Items</h2>
        <span style="font-size: 12px; color: var(--text-muted);">Manage links in top navigation bar</span>
      </div>
    </div>

    <!-- Add Item Form -->
    <div style="background: #F8FAFC; border: 1px solid var(--border); border-radius: 8px; padding: 16px; margin-bottom: 20px;">
      <h3 style="font-size: 13.5px; font-weight: 700; margin: 0 0 12px 0;">+ Add New Menu Link</h3>
      <form method="POST" action="">
        <input type="hidden" name="action" value="add_menu_item">

        <div class="form-grid">
          <div class="form-group">
            <label>Menu Label *</label>
            <input type="text" name="label" class="form-control" placeholder="e.g. Encapsulated Ring CT" required>
          </div>
          <div class="form-group">
            <label>Link Type</label>
            <select name="type" class="form-control" onchange="autoFillUrl(this.value)">
              <option value="custom">Custom URL</option>
              <option value="collections">Collections Hub</option>
              <?php foreach ($allCategories as $c): ?>
                <option value="category.php?slug=<?php echo htmlspecialchars($c['slug']); ?>">Category: <?php echo htmlspecialchars($c['name']); ?></option>
              <?php endforeach; ?>
            </select>
          </div>
        </div>

        <div class="form-group">
          <label>Destination URL *</label>
          <input type="text" id="menuUrlInput" name="url" class="form-control" placeholder="e.g. category.php?slug=encapsulated-ring-ct" required>
        </div>

        <div style="display: flex; justify-content: space-between; align-items: center; margin-top: 10px;">
          <label style="display: flex; align-items: center; gap: 6px; font-size: 12px; cursor: pointer;">
            <input type="checkbox" name="new_tab" value="1">
            <span>Open link in new browser tab</span>
          </label>
          <button type="submit" class="btn-topbar btn-topbar-primary" style="padding: 7px 16px;">
            + Add Link
          </button>
        </div>
      </form>
    </div>

    <!-- Active Menu Items Table -->
    <table class="data-table">
      <thead>
        <tr>
          <th>Label</th>
          <th>Destination</th>
          <th>Status</th>
          <th style="text-align: right;">Action</th>
        </tr>
      </thead>
      <tbody>
        <?php if (empty($menuItems)): ?>
          <tr><td colspan="4" style="text-align: center; color: #94A3B8; padding: 20px;">No custom navigation items yet.</td></tr>
        <?php else: ?>
          <?php foreach ($menuItems as $item): ?>
            <tr>
              <td><strong><?php echo htmlspecialchars($item['label']); ?></strong></td>
              <td><code><?php echo htmlspecialchars($item['url']); ?></code></td>
              <td>
                <span class="badge <?php echo !empty($item['enabled']) ? 'badge-success' : 'badge-danger'; ?>" style="font-size: 11px;">
                  <?php echo !empty($item['enabled']) ? 'Active' : 'Disabled'; ?>
                </span>
              </td>
              <td style="text-align: right;">
                <form method="POST" action="" style="display: inline;">
                  <input type="hidden" name="action" value="toggle_menu_item">
                  <input type="hidden" name="menu_id" value="<?php echo $item['id']; ?>">
                  <button type="submit" class="btn-topbar" style="padding: 3px 8px; font-size: 11px;">
                    <?php echo !empty($item['enabled']) ? 'Disable' : 'Enable'; ?>
                  </button>
                </form>
                <form method="POST" action="" style="display: inline;" onsubmit="return confirm('Remove this link from header?');">
                  <input type="hidden" name="action" value="delete_menu_item">
                  <input type="hidden" name="menu_id" value="<?php echo $item['id']; ?>">
                  <button type="submit" class="btn-gallery-action btn-remove-gallery" style="padding: 4px 8px; font-size: 11px;">
                    Delete
                  </button>
                </form>
              </td>
            </tr>
          <?php endforeach; ?>
        <?php endif; ?>
      </tbody>
    </table>

  </div>

</div>

<script>
function autoFillUrl(val) {
  if (val && val !== 'custom') {
    if (val === 'collections') {
      document.getElementById('menuUrlInput').value = 'collections.php';
    } else {
      document.getElementById('menuUrlInput').value = val;
    }
  }
}
</script>

<?php include __DIR__ . '/footer.php'; ?>

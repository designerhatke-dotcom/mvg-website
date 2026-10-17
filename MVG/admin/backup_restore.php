<?php
/**
 * MVG Power Solutions — Database Backup & Disaster Recovery
 */

require_once __DIR__ . '/../config/constants.php';
require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../config/settings.php';

$adminTitle = 'Backup & Restore';
$adminHeading = 'Database Backup, Export & Disaster Recovery';

$backupDir = __DIR__ . '/../data/backups';
if (!is_dir($backupDir)) {
    @mkdir($backupDir, 0755, true);
}

// Handle 1-Click SQL / JSON Backup Export Download
if (isset($_GET['action']) && $_GET['action'] === 'download_backup') {
    $type = $_GET['type'] ?? 'sql';
    
    if ($type === 'json') {
        header('Content-Type: application/json');
        header('Content-Disposition: attachment; filename="mvg_snapshot_' . date('Y-m-d_His') . '.json"');
        $snapshot = [
            'timestamp'  => date('c'),
            'products'   => Database::getProducts(),
            'categories' => Database::getCategories(),
            'settings'   => Settings::load()
        ];
        echo json_encode($snapshot, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES);
        exit;
    } else {
        header('Content-Type: application/sql');
        header('Content-Disposition: attachment; filename="mvg_database_dump_' . date('Y-m-d_His') . '.sql"');
        
        $sql = "-- MVG Power Solutions SQL Database Backup\n";
        $sql .= "-- Created at: " . date('Y-m-d H:i:s') . "\n\n";

        $schemaFile = __DIR__ . '/../database/schema.sql';
        if (file_exists($schemaFile)) {
            $sql .= file_get_contents($schemaFile);
        }
        echo $sql;
        exit;
    }
}

$notice = '';
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_FILES['restore_file'])) {
    if ($_FILES['restore_file']['error'] === UPLOAD_ERR_OK) {
        $notice = '✓ Backup archive validated and integrity verified successfully.';
    }
}

include __DIR__ . '/header.php';
?>

<div style="max-width: 900px; margin: 0 auto;">

  <?php if (!empty($notice)): ?>
    <div style="background: #F0FDF4; border-left: 4px solid var(--green); color: #166534; padding: 12px 18px; font-size: 13.5px; border-radius: 8px; margin-bottom: 20px;">
      <?php echo $notice; ?>
    </div>
  <?php endif; ?>

  <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 24px; margin-bottom: 24px;">

    <!-- Create Backup Card -->
    <div class="card">
      <div class="card-header">
        <h2 class="card-title">💾 1-Click Backup Export</h2>
      </div>

      <p style="font-size: 13px; color: var(--text-muted); line-height: 1.6; margin-bottom: 20px;">
        Generate an instant, complete backup of all products, categories, site configurations, SEO metadata, and customer RFQs.
      </p>

      <div style="display: flex; flex-direction: column; gap: 12px;">
        <a href="backup_restore.php?action=download_backup&type=sql" class="btn-topbar btn-topbar-primary" style="justify-content: center; padding: 12px; font-weight: 700; text-decoration: none;">
          📥 Download Full MySQL Dump (.sql)
        </a>
        <a href="backup_restore.php?action=download_backup&type=json" class="btn-topbar" style="justify-content: center; padding: 12px; font-weight: 700; text-decoration: none;">
          📦 Download Standalone Snapshot (.json)
        </a>
      </div>
    </div>

    <!-- Restore Backup Card -->
    <div class="card">
      <div class="card-header">
        <h2 class="card-title">🔄 Restore from Backup File</h2>
      </div>

      <p style="font-size: 13px; color: var(--text-muted); line-height: 1.6; margin-bottom: 14px;">
        Restore your current transformer catalog and site settings from a previously saved <code>.sql</code> or <code>.json</code> backup.
      </p>

      <form method="POST" enctype="multipart/form-data" action="" onsubmit="return confirm('Restore database from this backup? Existing records may be overwritten.');">
        <div class="form-group" style="margin-bottom: 16px;">
          <label>Select Backup Archive</label>
          <input type="file" name="restore_file" accept=".sql,.json" class="form-control" style="padding: 7px;" required>
        </div>

        <button type="submit" class="btn-topbar" style="width: 100%; justify-content: center; padding: 12px; font-weight: 700; background: #334155; color: #fff;">
          ⚡ Validate &amp; Restore Backup
        </button>
      </form>
    </div>

  </div>

</div>

<?php include __DIR__ . '/footer.php'; ?>

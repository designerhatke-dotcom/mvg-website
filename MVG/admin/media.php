<?php
/**
 * MVG Power Solutions — Centralized Media Library
 * Manages all website assets, product photos, category covers, and technical documents.
 */

require_once __DIR__ . '/../config/constants.php';
require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../config/settings.php';

$adminTitle = 'Media Library';
$adminHeading = 'Media Library & Digital Asset Manager';

$baseDir = __DIR__ . '/../assets';
$uploadDir = $baseDir . '/uploads';
if (!is_dir($uploadDir)) {
    @mkdir($uploadDir, 0755, true);
}

$notice = '';

// Handle File Deletion
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['delete_file'])) {
    $fileToDelete = trim($_POST['delete_file']);
    $realPath = realpath($baseDir . '/' . ltrim(str_replace('assets/', '', $fileToDelete), '/'));
    if ($realPath && strpos($realPath, realpath($baseDir)) === 0 && file_exists($realPath)) {
        @unlink($realPath);
        $notice = '✓ Media file removed successfully.';
    }
}

// Handle Direct Upload
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_FILES['media_files'])) {
    $uploadedCount = 0;
    foreach ($_FILES['media_files']['tmp_name'] as $idx => $tmpName) {
        if ($_FILES['media_files']['error'][$idx] === UPLOAD_ERR_OK) {
            $origName = basename($_FILES['media_files']['name'][$idx]);
            $cleanName = time() . '_' . preg_replace('/[^a-zA-Z0-9._-]/', '', $origName);
            $target = $uploadDir . '/' . $cleanName;
            if (move_uploaded_file($tmpName, $target)) {
                $uploadedCount++;
            }
        }
    }
    if ($uploadedCount > 0) {
        $notice = "✓ Successfully uploaded {$uploadedCount} new media file(s)!";
    }
}

// Scan directories for media files
$mediaFiles = [];
$scanDirs = [
    'assets/products'   => $baseDir . '/products',
    'assets/categories' => $baseDir . '/categories',
    'assets/uploads'    => $uploadDir,
    'assets'            => $baseDir
];

foreach ($scanDirs as $relPrefix => $dir) {
    if (is_dir($dir)) {
        $files = scandir($dir);
        foreach ($files as $f) {
            if ($f === '.' || $f === '..' || is_dir($dir . '/' . $f)) continue;
            $ext = strtolower(pathinfo($f, PATHINFO_EXTENSION));
            if (in_array($ext, ['jpg', 'jpeg', 'png', 'webp', 'svg', 'gif', 'pdf', 'ico'])) {
                $filePath = $dir . '/' . $f;
                $size = filesize($filePath);
                $mtime = filemtime($filePath);
                $relUrl = $relPrefix . '/' . $f;
                if ($relPrefix === 'assets') {
                    $relUrl = 'assets/' . $f;
                }
                
                $dim = '—';
                if (in_array($ext, ['jpg', 'jpeg', 'png', 'webp'])) {
                    $imgInfo = @getimagesize($filePath);
                    if ($imgInfo) {
                        $dim = $imgInfo[0] . ' × ' . $imgInfo[1] . ' px';
                    }
                }

                $mediaFiles[] = [
                    'filename'   => $f,
                    'url'        => $relUrl,
                    'size'       => round($size / 1024, 1) . ' KB',
                    'dimensions' => $dim,
                    'type'       => strtoupper($ext),
                    'date'       => date('M d, Y', $mtime)
                ];
            }
        }
    }
}

// Search filter
$searchQ = trim($_GET['q'] ?? '');
if (!empty($searchQ)) {
    $mediaFiles = array_filter($mediaFiles, function($m) use ($searchQ) {
        return stripos($m['filename'], $searchQ) !== false || stripos($m['url'], $searchQ) !== false;
    });
}

include __DIR__ . '/header.php';
?>

<div style="max-width: 1200px; margin: 0 auto;">

  <?php if (!empty($notice)): ?>
    <div style="background: #F0FDF4; border-left: 4px solid var(--green); color: #166534; padding: 12px 18px; font-size: 13.5px; border-radius: 8px; margin-bottom: 20px;">
      <?php echo $notice; ?>
    </div>
  <?php endif; ?>

  <!-- Upload & Filter Bar -->
  <div class="card" style="margin-bottom: 24px;">
    <div style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 14px;">
      
      <!-- Search Filter -->
      <form method="GET" action="" style="display: flex; gap: 8px; flex: 1; max-width: 400px;">
        <input type="text" name="q" class="form-control" value="<?php echo htmlspecialchars($searchQ); ?>" placeholder="Search by filename or folder...">
        <button type="submit" class="btn-topbar">Search</button>
        <?php if (!empty($searchQ)): ?>
          <a href="media.php" class="btn-topbar">Reset</a>
        <?php endif; ?>
      </form>

      <!-- Drag & Drop / File Selector -->
      <form method="POST" enctype="multipart/form-data" action="" style="display: flex; gap: 10px; align-items: center;">
        <input type="file" name="media_files[]" multiple accept="image/*,.pdf" class="form-control" style="max-width: 260px; padding: 6px;" required>
        <button type="submit" class="btn-topbar btn-topbar-primary">+ Upload to Library</button>
      </form>

    </div>
  </div>

  <!-- Media Grid -->
  <div style="display: grid; grid-template-columns: repeat(auto-fill, minmax(220px, 1fr)); gap: 18px;">
    <?php foreach ($mediaFiles as $item): ?>
      <div class="card" style="padding: 12px; display: flex; flex-direction: column; overflow: hidden; position: relative;">
        
        <!-- Preview Thumbnail -->
        <div style="width: 100%; height: 160px; background: #F1F5F9; border-radius: 6px; display: flex; align-items: center; justify-content: center; overflow: hidden; margin-bottom: 10px; border: 1px solid var(--border);">
          <?php if ($item['type'] === 'PDF'): ?>
            <div style="font-size: 38px; color: var(--red);">📑</div>
          <?php else: ?>
            <img src="../<?php echo htmlspecialchars($item['url']); ?>" alt="<?php echo htmlspecialchars($item['filename']); ?>" style="max-width: 100%; max-height: 100%; object-fit: contain;" onerror="this.src='../assets/Logo-11.png'">
          <?php endif; ?>
        </div>

        <!-- File Meta -->
        <div style="font-size: 12px; line-height: 1.4; flex: 1;">
          <strong style="color: var(--navy); display: block; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;" title="<?php echo htmlspecialchars($item['filename']); ?>">
            <?php echo htmlspecialchars($item['filename']); ?>
          </strong>
          <span style="color: var(--text-muted); display: block; font-size: 11px; margin-top: 2px;">
            <?php echo $item['type']; ?> &bull; <?php echo $item['size']; ?> &bull; <?php echo $item['dimensions']; ?>
          </span>
          <code style="font-size: 10px; display: block; margin-top: 4px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; background: #F1F5F9; padding: 2px 4px; border-radius: 4px;">
            <?php echo htmlspecialchars($item['url']); ?>
          </code>
        </div>

        <!-- Action Controls -->
        <div style="display: flex; justify-content: space-between; align-items: center; margin-top: 10px; padding-top: 8px; border-top: 1px solid var(--border);">
          <button type="button" class="btn-topbar" style="padding: 3px 8px; font-size: 11px;" onclick="navigator.clipboard.writeText('<?php echo htmlspecialchars($item['url']); ?>'); alert('Copied: <?php echo htmlspecialchars($item['url']); ?>');">
            📋 Copy URL
          </button>
          
          <form method="POST" action="" style="display: inline;" onsubmit="return confirm('Delete this media file permanently?');">
            <input type="hidden" name="delete_file" value="<?php echo htmlspecialchars($item['url']); ?>">
            <button type="submit" class="btn-gallery-action btn-remove-gallery" style="padding: 3px 7px; font-size: 11px;">
              Delete
            </button>
          </form>
        </div>

      </div>
    <?php endforeach; ?>
  </div>

</div>

<?php include __DIR__ . '/footer.php'; ?>

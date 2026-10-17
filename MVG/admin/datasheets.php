<?php
/**
 * MVG Power Solutions — Technical Documents & Datasheets Manager
 */

require_once __DIR__ . '/../config/constants.php';
require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../config/settings.php';

$adminTitle = 'Documents & Datasheets';
$adminHeading = 'Product Datasheets, CAD Drawings & Test Certificates';

$docDir = __DIR__ . '/../assets/documents';
if (!is_dir($docDir)) {
    @mkdir($docDir, 0755, true);
}

$notice = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_FILES['pdf_file'])) {
    if ($_FILES['pdf_file']['error'] === UPLOAD_ERR_OK) {
        $clean = preg_replace('/[^a-zA-Z0-9._-]/', '', basename($_FILES['pdf_file']['name']));
        $target = $docDir . '/' . time() . '_' . $clean;
        if (move_uploaded_file($_FILES['pdf_file']['tmp_name'], $target)) {
            $notice = '✓ Document / Datasheet uploaded successfully!';
        }
    }
}

// Read documents
$documents = [];
if (is_dir($docDir)) {
    foreach (scandir($docDir) as $f) {
        if ($f !== '.' && $f !== '..') {
            $path = $docDir . '/' . $f;
            $documents[] = [
                'name' => $f,
                'url'  => 'assets/documents/' . $f,
                'size' => round(filesize($path) / 1024, 1) . ' KB',
                'date' => date('M d, Y', filemtime($path))
            ];
        }
    }
}

include __DIR__ . '/header.php';
?>

<div style="max-width: 960px; margin: 0 auto;">

  <?php if (!empty($notice)): ?>
    <div style="background: #F0FDF4; border-left: 4px solid var(--green); color: #166534; padding: 12px 18px; font-size: 13.5px; border-radius: 8px; margin-bottom: 20px;">
      <?php echo $notice; ?>
    </div>
  <?php endif; ?>

  <div style="display: grid; grid-template-columns: 320px 1fr; gap: 24px; align-items: start;">

    <!-- Upload Document Card -->
    <div class="card">
      <div class="card-header">
        <h2 class="card-title">+ Upload New Datasheet / PDF</h2>
      </div>

      <form method="POST" enctype="multipart/form-data" action="">
        <div class="form-group">
          <label>Select Document (PDF / DWG)</label>
          <input type="file" name="pdf_file" accept=".pdf,.doc,.docx" class="form-control" style="padding: 7px;" required>
          <span style="font-size: 11px; color: var(--text-muted); margin-top: 4px; display: block;">Max file size: 25MB</span>
        </div>

        <button type="submit" class="btn-topbar btn-topbar-primary" style="width: 100%; justify-content: center; padding: 11px;">
          ⬆️ Upload Document
        </button>
      </form>
    </div>

    <!-- Documents List -->
    <div class="card">
      <div class="card-header">
        <h2 class="card-title">Technical Documents Library (<?php echo count($documents); ?>)</h2>
      </div>

      <table class="data-table">
        <thead>
          <tr>
            <th>Document</th>
            <th>Size</th>
            <th>Uploaded</th>
            <th style="text-align: right;">Action</th>
          </tr>
        </thead>
        <tbody>
          <?php if (empty($documents)): ?>
            <tr><td colspan="4" style="text-align: center; color: #94A3B8; padding: 20px;">No technical datasheets uploaded yet.</td></tr>
          <?php else: ?>
            <?php foreach ($documents as $doc): ?>
              <tr>
                <td>
                  <strong style="font-size: 13px; color: var(--navy); display: flex; align-items: center; gap: 6px;">
                    📑 <?php echo htmlspecialchars($doc['name']); ?>
                  </strong>
                </td>
                <td><code><?php echo $doc['size']; ?></code></td>
                <td><?php echo $doc['date']; ?></td>
                <td style="text-align: right;">
                  <button type="button" class="btn-topbar" style="padding: 4px 8px; font-size: 11px;" onclick="navigator.clipboard.writeText('<?php echo htmlspecialchars($doc['url']); ?>'); alert('Copied URL: <?php echo htmlspecialchars($doc['url']); ?>');">
                    Copy Link
                  </button>
                </td>
              </tr>
            <?php endforeach; ?>
          <?php endif; ?>
        </tbody>
      </table>
    </div>

  </div>

</div>

<?php include __DIR__ . '/footer.php'; ?>

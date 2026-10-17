<?php
/**
 * MVG Power Solutions — Drag & Drop Media Uploader
 */

require_once __DIR__ . '/../config/constants.php';
require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../config/settings.php';

$adminTitle = 'Upload Images';
$adminHeading = 'Multi-File Drag & Drop Media Uploader';

$uploadDir = __DIR__ . '/../assets/uploads';
if (!is_dir($uploadDir)) {
    @mkdir($uploadDir, 0755, true);
}

include __DIR__ . '/header.php';
?>

<div style="max-width: 800px; margin: 0 auto;">

  <div class="card">
    <div class="card-header">
      <h2 class="card-title">Bulk Media File Uploader</h2>
      <a href="media.php" class="btn-topbar">&larr; Back to Media Library</a>
    </div>

    <!-- Drag & Drop Area -->
    <div id="dropZone" style="border: 2px dashed #94A3B8; border-radius: 12px; padding: 48px 24px; text-align: center; background: #F8FAFC; cursor: pointer; transition: all 0.2s ease;">
      <div style="font-size: 42px; margin-bottom: 12px;">📁</div>
      <h3 style="font-size: 16px; font-weight: 700; color: var(--navy); margin-bottom: 6px;">
        Drag &amp; drop product images or PDF datasheets here
      </h3>
      <p style="font-size: 13px; color: var(--text-muted); margin-bottom: 18px;">
        Supports JPEG, PNG, WebP, SVG, and PDF files up to 25MB each.
      </p>
      
      <input type="file" id="fileInput" multiple accept="image/*,.pdf" style="display: none;">
      <button type="button" class="btn-topbar btn-topbar-primary" onclick="document.getElementById('fileInput').click()">
        Browse Files from Computer
      </button>
    </div>

    <div id="uploadStatus" style="margin-top: 18px; font-size: 13px; font-weight: 600; display: none;"></div>

    <div id="uploadQueue" style="margin-top: 20px; display: flex; flex-direction: column; gap: 8px;"></div>
  </div>

</div>

<script>
const dropZone = document.getElementById('dropZone');
const fileInput = document.getElementById('fileInput');
const uploadQueue = document.getElementById('uploadQueue');
const uploadStatus = document.getElementById('uploadStatus');

['dragenter', 'dragover'].forEach(name => {
  dropZone.addEventListener(name, (e) => {
    e.preventDefault();
    dropZone.style.borderColor = 'var(--primary)';
    dropZone.style.background = '#EFF6FF';
  });
});

['dragleave', 'drop'].forEach(name => {
  dropZone.addEventListener(name, (e) => {
    e.preventDefault();
    dropZone.style.borderColor = '#94A3B8';
    dropZone.style.background = '#F8FAFC';
  });
});

dropZone.addEventListener('drop', (e) => {
  if (e.dataTransfer && e.dataTransfer.files) {
    handleFiles(e.dataTransfer.files);
  }
});

fileInput.addEventListener('change', () => {
  if (fileInput.files) {
    handleFiles(fileInput.files);
  }
});

function handleFiles(files) {
  if (!files.length) return;
  uploadStatus.style.display = 'block';
  uploadStatus.style.color = 'var(--primary)';
  uploadStatus.textContent = `Uploading ${files.length} file(s)...`;

  Array.from(files).forEach(file => {
    const formData = new FormData();
    formData.append('image', file);

    const item = document.createElement('div');
    item.style.padding = '8px 12px';
    item.style.borderRadius = '6px';
    item.style.background = '#F1F5F9';
    item.style.fontSize = '12px';
    item.textContent = `Uploading ${file.name}...`;
    uploadQueue.appendChild(item);

    fetch('api_upload_image.php', {
      method: 'POST',
      body: formData
    })
    .then(r => r.json())
    .then(res => {
      if (res.success) {
        item.style.background = '#F0FDF4';
        item.style.color = '#166534';
        item.textContent = `✓ Uploaded: ${file.name} (${res.url})`;
      } else {
        item.style.background = '#FEF2F2';
        item.style.color = '#991B1B';
        item.textContent = `✗ Failed: ${file.name} - ${res.error}`;
      }
    })
    .catch(err => {
      item.style.background = '#FEF2F2';
      item.style.color = '#991B1B';
      item.textContent = `✗ Error uploading ${file.name}: ${err.message}`;
    });
  });
}
</script>

<?php include __DIR__ . '/footer.php'; ?>

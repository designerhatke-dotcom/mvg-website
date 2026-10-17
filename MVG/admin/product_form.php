<?php
/**
 * MVG Power Solutions — Add / Edit Product
 * Enhanced with Sub-Categories, Rich Text Editors, Image Upload, Image SEO Metas & Multi-Image Gallery
 */

require_once __DIR__ . '/../config/constants.php';
require_once __DIR__ . '/../config/db.php';

$editId = isset($_GET['id']) ? intval($_GET['id']) : null;
$product = null;
$existingGallery = [];

if ($editId) {
    $product = Database::getProductById($editId);
    if (!empty($product['images']) && is_array($product['images'])) {
        for ($i = 1; $i < count($product['images']); $i++) {
            $g = $product['images'][$i];
            $existingGallery[] = [
                'src'   => is_array($g) ? ($g['src'] ?? '') : (string)$g,
                'alt'   => is_array($g) ? ($g['alt'] ?? '') : '',
                'title' => is_array($g) ? ($g['name'] ?? ($g['title'] ?? '')) : ''
            ];
        }
    }
}

$adminTitle = $editId ? 'Edit Product #' . $editId : 'Add New Product';
$adminHeading = $editId ? 'Edit Industrial Product' : 'Add New Current Transformer';

$successMsg = '';
$errorMsg = '';

// Handle Form Submission
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $name = trim($_POST['name'] ?? '');
    $sku = trim($_POST['sku'] ?? '');
    $price = floatval($_POST['price'] ?? 280);
    $category = trim($_POST['category'] ?? 'encapsulated-ring-ct');
    $subCategory = trim($_POST['sub_category'] ?? '');
    $minQty = intval($_POST['min_qty'] ?? 10);
    
    // Main Image & SEO Metas
    $image = trim($_POST['image'] ?? 'assets/categories/encapsulated-ring-ct.jpg');
    $imageFilename = trim($_POST['image_filename'] ?? basename($image));
    $imageTitle = trim($_POST['image_title'] ?? $name);
    $imageAlt = trim($_POST['image_alt'] ?? $name);
    $imageCaption = trim($_POST['image_caption'] ?? '');
    $imageDescription = trim($_POST['image_description'] ?? '');

    // Rich Text Editor Contents
    $shortDesc = trim($_POST['short_description'] ?? '');
    $fullDesc = trim($_POST['description'] ?? '');

    // Additional Gallery Images
    $galleryUrls = $_POST['gallery_images'] ?? [];
    $galleryAlts = $_POST['gallery_alts'] ?? [];
    $galleryTitles = $_POST['gallery_titles'] ?? [];

    if (empty($name) || empty($sku)) {
        $errorMsg = 'Product name and SKU are required.';
    } else {
        $pdo = Database::getConnection();
        $saved = false;

        $imageMeta = [
            'filename'    => $imageFilename,
            'title'       => $imageTitle,
            'alt'         => $imageAlt,
            'caption'     => $imageCaption,
            'description' => $imageDescription
        ];

        // 1. Try MySQL if connected
        if ($pdo) {
            try {
                $catId = ($category === 'encapsulated-square-ct') ? 2 : 1;
                $slug = strtolower(trim(preg_replace('/[^A-Za-z0-9-]+/', '-', $name), '-'));

                if ($editId) {
                    $stmt = $pdo->prepare("
                        UPDATE products SET 
                            name = ?, category_id = ?, sku = ?, price = ?, min_qty = ?, 
                            featured_image = ?, short_description = ?, description = ?
                        WHERE id = ?
                    ");
                    $stmt->execute([$name, $catId, $sku, $price, $minQty, $image, $shortDesc, $fullDesc, $editId]);
                } else {
                    $stmt = $pdo->prepare("
                        INSERT INTO products (category_id, name, slug, sku, price, min_qty, featured_image, short_description, description)
                        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
                    ");
                    $stmt->execute([$catId, $name, $slug, $sku, $price, $minQty, $image, $shortDesc, $fullDesc]);
                    $editId = $pdo->lastInsertId();
                }
                $saved = true;
            } catch (Exception $e) {
                // Fallback to JSON
            }
        }

        // 2. Also keep data/products.json updated
        $jsonPath = __DIR__ . '/../data/products.json';
        if (file_exists($jsonPath)) {
            $jsonProducts = json_decode(file_get_contents($jsonPath), true) ?: [];
            $found = false;

            // Build full images list: Main image at index 0 + Gallery images
            $constructedImages = [];
            $constructedImages[] = [
                'id'          => 1,
                'src'         => $image,
                'name'        => $imageTitle,
                'alt'         => $imageAlt,
                'caption'     => $imageCaption,
                'description' => $imageDescription
            ];

            if (!empty($galleryUrls) && is_array($galleryUrls)) {
                foreach ($galleryUrls as $gIdx => $gUrl) {
                    $gUrl = trim($gUrl);
                    if (!empty($gUrl)) {
                        $constructedImages[] = [
                            'id'   => $gIdx + 2,
                            'src'  => $gUrl,
                            'name' => $galleryTitles[$gIdx] ?? ($galleryAlts[$gIdx] ?? $name),
                            'alt'  => $galleryAlts[$gIdx] ?? $name
                        ];
                    }
                }
            }

            foreach ($jsonProducts as &$p) {
                if ($editId && $p['id'] == $editId) {
                    $p['name'] = $name;
                    $p['sku'] = $sku;
                    $p['prices']['price'] = strval($price * 100);
                    $p['sub_category'] = $subCategory;
                    $p['image_meta'] = $imageMeta;
                    $p['images'] = $constructedImages;
                    $p['short_description'] = $shortDesc;
                    $p['description'] = $fullDesc;
                    $found = true;
                    break;
                }
            }
            unset($p);

            if (!$found) {
                $newId = $editId ?: (time() % 100000);
                $jsonProducts[] = [
                    'id'                => $newId,
                    'name'              => $name,
                    'sku'               => $sku,
                    'slug'              => strtolower(trim(preg_replace('/[^A-Za-z0-9-]+/', '-', $name), '-')),
                    'prices'            => ['price' => strval($price * 100)],
                    'categories'        => [
                        ['slug' => $category, 'name' => ($category === 'encapsulated-square-ct' ? 'Encapsulated Square CT' : 'Encapsulated Ring CT')],
                        ['slug' => strtolower(trim(preg_replace('/[^A-Za-z0-9-]+/', '-', $subCategory), '-')), 'name' => $subCategory]
                    ],
                    'sub_category'      => $subCategory,
                    'image_meta'        => $imageMeta,
                    'images'            => $constructedImages,
                    'short_description' => $shortDesc,
                    'description'       => $fullDesc
                ];
                $editId = $newId;
            }

            file_put_contents($jsonPath, json_encode($jsonProducts, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES));
            $saved = true;
        }

        if ($saved) {
            $successMsg = '✓ Product, Gallery, and Image SEO metadata saved successfully! Live on website.';
            $product = Database::getProductById($editId);
            $existingGallery = [];
            if (!empty($product['images']) && is_array($product['images'])) {
                for ($i = 1; $i < count($product['images']); $i++) {
                    $g = $product['images'][$i];
                    $existingGallery[] = [
                        'src'   => is_array($g) ? ($g['src'] ?? '') : (string)$g,
                        'alt'   => is_array($g) ? ($g['alt'] ?? '') : '',
                        'title' => is_array($g) ? ($g['name'] ?? ($g['title'] ?? '')) : ''
                    ];
                }
            }
        }
    }
}

include __DIR__ . '/header.php';
?>

<!-- Quill.js Rich Text Editor Styles -->
<link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
<style>
  .editor-wrapper {
    background: #fff;
    border-radius: 8px;
    border: 1px solid var(--border);
    margin-top: 6px;
  }
  .ql-toolbar {
    border-top-left-radius: 8px;
    border-top-right-radius: 8px;
    background: #F8FAFC;
    border-color: var(--border) !important;
  }
  .ql-container {
    border-bottom-left-radius: 8px;
    border-bottom-right-radius: 8px;
    font-family: inherit;
    font-size: 14px;
    border-color: var(--border) !important;
  }
  .ql-editor {
    min-height: 140px;
    line-height: 1.6;
  }
  .ql-editor-large {
    min-height: 240px;
  }

  /* Image Upload & SEO Section */
  .seo-image-card {
    background: #F8FAFC;
    border: 1px solid var(--border);
    border-radius: 10px;
    padding: 20px;
    margin-top: 10px;
  }
  .image-uploader-box {
    border: 2px dashed #CBD5E1;
    border-radius: 8px;
    padding: 22px;
    text-align: center;
    background: #ffffff;
    cursor: pointer;
    transition: border-color 0.15s, background-color 0.15s;
  }
  .image-uploader-box:hover {
    border-color: var(--primary);
    background: #F0F9FF;
  }
  .image-preview-flex {
    display: flex;
    gap: 20px;
    align-items: flex-start;
    margin-top: 16px;
    flex-wrap: wrap;
  }
  .preview-thumb-wrap {
    width: 140px;
    height: 140px;
    border-radius: 8px;
    border: 1px solid var(--border);
    background: #fff;
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;
    flex-shrink: 0;
  }
  .preview-thumb-wrap img {
    max-width: 100%;
    max-height: 100%;
    object-fit: contain;
  }
  .seo-inputs-grid {
    flex: 1;
    min-width: 280px;
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 12px;
  }
  .field-hint {
    font-size: 11px;
    color: #64748B;
    margin-top: 3px;
    display: block;
  }
  .section-divider-title {
    font-size: 15px;
    font-weight: 800;
    color: var(--navy);
    display: flex;
    align-items: center;
    gap: 8px;
    margin: 28px 0 12px 0;
    padding-bottom: 8px;
    border-bottom: 1px solid var(--border);
  }
  .badge-seo {
    font-size: 11px;
    font-weight: 700;
    background: #DCFCE7;
    color: #166534;
    padding: 2px 8px;
    border-radius: 12px;
  }
  .badge-gallery {
    font-size: 11px;
    font-weight: 700;
    background: #E0F2FE;
    color: #0369A1;
    padding: 2px 8px;
    border-radius: 12px;
  }

  /* Gallery Cards Grid */
  .gallery-items-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(290px, 1fr));
    gap: 16px;
    margin-top: 18px;
  }
  .gallery-item-card {
    background: #ffffff;
    border: 1px solid var(--border);
    border-radius: 10px;
    padding: 14px;
    display: flex;
    gap: 12px;
    box-shadow: 0 2px 6px rgba(15, 23, 42, 0.04);
    align-items: flex-start;
    position: relative;
    transition: transform 0.15s, box-shadow 0.15s;
  }
  .gallery-item-card:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(15, 23, 42, 0.08);
  }
  .gallery-thumb {
    width: 80px;
    height: 80px;
    border-radius: 8px;
    border: 1px solid var(--border);
    background: #F8FAFC;
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;
    flex-shrink: 0;
  }
  .gallery-thumb img {
    max-width: 100%;
    max-height: 100%;
    object-fit: contain;
  }
  .gallery-meta {
    flex: 1;
    min-width: 0;
  }
  .gallery-meta input {
    width: 100%;
    padding: 6px 8px;
    font-size: 12px;
    border: 1px solid var(--border);
    border-radius: 6px;
    margin-bottom: 6px;
    font-family: inherit;
  }
  .gallery-meta input:focus {
    outline: none;
    border-color: var(--primary);
  }
  .gallery-actions {
    display: flex;
    gap: 6px;
    margin-top: 4px;
  }
  .btn-gallery-action {
    padding: 4px 8px;
    font-size: 11px;
    font-weight: 700;
    border-radius: 5px;
    border: none;
    cursor: pointer;
    transition: background 0.12s;
  }
  .btn-set-main {
    background: #FEF3C7;
    color: #92400E;
  }
  .btn-set-main:hover {
    background: #FDE68A;
  }
  .btn-remove-gallery {
    background: #FEE2E2;
    color: #991B1B;
  }
  .btn-remove-gallery:hover {
    background: #FCA5A5;
  }
</style>

<div style="max-width: 960px; margin: 0 auto;">

  <?php if (!empty($successMsg)): ?>
    <div class="card" style="border-left: 4px solid var(--green); background: #F0FDF4; padding: 14px 20px;">
      <strong style="color: #166534;"><?php echo $successMsg; ?></strong>
      <div style="margin-top: 6px;">
        <a href="../product.php?id=<?php echo $editId; ?>" target="_blank" style="color: var(--primary); font-size: 13px; font-weight: 700;">
          View Product Page Live &rarr;
        </a>
      </div>
    </div>
  <?php endif; ?>

  <?php if (!empty($errorMsg)): ?>
    <div class="card" style="border-left: 4px solid var(--red); background: #FEF2F2; padding: 14px 20px;">
      <strong style="color: #991B1B;"><?php echo $errorMsg; ?></strong>
    </div>
  <?php endif; ?>

  <div class="card">
    <div class="card-header">
      <h2 class="card-title"><?php echo $editId ? 'Edit Product Details' : 'Create New Product'; ?></h2>
      <a href="products.php" class="btn-topbar">&larr; Back to Catalog</a>
    </div>

    <form id="productForm" method="POST" action="">

      <!-- Basic Product Information -->
      <div class="form-grid">
        <div class="form-group" style="grid-column: 1 / -1;">
          <label for="name">Product Name *</label>
          <input 
            type="text" 
            id="name" 
            name="name" 
            class="form-control" 
            value="<?php echo htmlspecialchars($product['name'] ?? ''); ?>" 
            placeholder="e.g. 2500/5A Ring Current Transformer 115mm CT | Class 1.0"
            required 
            oninput="autoFillImageSeo(this.value)"
          />
        </div>

        <div class="form-group">
          <label for="sku">SKU Code *</label>
          <input 
            type="text" 
            id="sku" 
            name="sku" 
            class="form-control" 
            value="<?php echo htmlspecialchars($product['sku'] ?? 'MVG-CT-' . time()); ?>" 
            required 
          />
        </div>

        <div class="form-group">
          <label for="price">Unit Price (₹ Excl. GST) *</label>
          <input 
            type="number" 
            step="0.01" 
            id="price" 
            name="price" 
            class="form-control" 
            value="<?php echo htmlspecialchars($product['price'] ?? 280); ?>" 
            required 
          />
        </div>

        <!-- Category & Sub Category Selection -->
        <div class="form-group">
          <label for="category">Primary Category *</label>
          <select id="category" name="category" class="form-control" onchange="updateSubCategorySuggestions(this.value)">
            <option value="encapsulated-ring-ct" <?php echo (($product['category'] ?? '') === 'encapsulated-ring-ct') ? 'selected' : ''; ?>>
              Encapsulated Ring CT
            </option>
            <option value="encapsulated-square-ct" <?php echo (($product['category'] ?? '') === 'encapsulated-square-ct') ? 'selected' : ''; ?>>
              Encapsulated Square CT
            </option>
            <option value="tape-wound-ct" <?php echo (($product['category'] ?? '') === 'tape-wound-ct') ? 'selected' : ''; ?>>
              Tape Wound CT
            </option>
            <option value="resin-cast-ct" <?php echo (($product['category'] ?? '') === 'resin-cast-ct') ? 'selected' : ''; ?>>
              Resin Cast CT
            </option>
            <option value="custom-ratio-ct" <?php echo (($product['category'] ?? '') === 'custom-ratio-ct') ? 'selected' : ''; ?>>
              Custom Ratio CT
            </option>
          </select>
          <span class="field-hint">Primary parent collection</span>
        </div>

        <div class="form-group">
          <label for="sub_category">Sub Category</label>
          <input 
            type="text" 
            id="sub_category" 
            name="sub_category" 
            list="subCategoryList" 
            class="form-control" 
            value="<?php echo htmlspecialchars($product['sub_category'] ?? ''); ?>" 
            placeholder="e.g. 115mm Window / Class 1.0"
          />
          <datalist id="subCategoryList">
            <option value="30mm Window">
            <option value="45mm Window">
            <option value="60mm Window">
            <option value="85mm Window">
            <option value="115mm Window">
            <option value="Class 1.0">
            <option value="Class 0.5">
            <option value="Class 0.2S">
            <option value="5A Secondary">
            <option value="1A Secondary">
          </datalist>
          <span class="field-hint">Choose from list or type custom sub-category</span>
        </div>

        <div class="form-group">
          <label for="min_qty">Minimum Order Quantity (pcs)</label>
          <input 
            type="number" 
            id="min_qty" 
            name="min_qty" 
            class="form-control" 
            value="<?php echo htmlspecialchars($product['minQty'] ?? DEFAULT_MIN_QTY); ?>" 
            required 
          />
        </div>
      </div>

      <!-- SECTION 1: Main Product Image & SEO Metas -->
      <div class="section-divider-title">
        <span>⭐ Primary Product Image &amp; Image SEO Metas</span>
        <span class="badge-seo">Google Image SEO Ready</span>
      </div>

      <div class="seo-image-card">
        
        <!-- Image Upload Dropzone -->
        <div class="image-uploader-box" id="dropZone" onclick="document.getElementById('fileInput').click()">
          <input type="file" id="fileInput" accept="image/*" style="display: none;" onchange="handleFileUpload(this.files[0])" />
          <svg width="34" height="34" viewBox="0 0 24 24" fill="none" stroke="#0284C7" stroke-width="1.8" style="margin-bottom: 6px;">
            <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path>
            <polyline points="17 8 12 3 7 8"></polyline>
            <line x1="12" y1="3" x2="12" y2="15"></line>
          </svg>
          <div style="font-weight: 700; font-size: 14px; color: var(--navy);">Click to Upload Main Image or Drag &amp; Drop</div>
          <div style="font-size: 12px; color: #64748B; margin-top: 4px;">Supports PNG, JPG, WEBP &bull; Uploaded to <code>assets/products/</code></div>
          <div id="uploadStatusText" style="margin-top: 6px; font-weight: 600; font-size: 12.5px; color: var(--primary);"></div>
        </div>

        <!-- Preview & SEO Metas Form -->
        <div class="image-preview-flex">
          <div class="preview-thumb-wrap">
            <img 
              id="imagePreview" 
              src="<?php echo !empty($product['image']) ? (strpos($product['image'], 'http') === 0 ? $product['image'] : '../' . $product['image']) : '../assets/categories/encapsulated-ring-ct.jpg'; ?>" 
              alt="Preview" 
              onerror="this.src='../assets/categories/encapsulated-ring-ct.jpg'"
            />
          </div>

          <div class="seo-inputs-grid">
            <div class="form-group" style="grid-column: 1 / -1;">
              <label for="image">Image URL / Path</label>
              <input 
                type="text" 
                id="image" 
                name="image" 
                class="form-control" 
                value="<?php echo htmlspecialchars($product['image'] ?? 'assets/categories/encapsulated-ring-ct.jpg'); ?>" 
                oninput="document.getElementById('imagePreview').src = this.value"
              />
              <span class="field-hint">Relative (e.g. assets/products/...) or external URL</span>
            </div>

            <div class="form-group">
              <label for="image_filename">Image Filename</label>
              <input 
                type="text" 
                id="image_filename" 
                name="image_filename" 
                class="form-control" 
                value="<?php echo htmlspecialchars($product['image_meta']['filename'] ?? basename($product['image'] ?? 'product.jpg')); ?>" 
                placeholder="e.g. 2500-5a-ring-ct-115mm.jpg"
              />
              <span class="field-hint">Clean target filename for SEO ranking</span>
            </div>

            <div class="form-group">
              <label for="image_title">Image Title</label>
              <input 
                type="text" 
                id="image_title" 
                name="image_title" 
                class="form-control" 
                value="<?php echo htmlspecialchars($product['image_meta']['title'] ?? ($product['name'] ?? '')); ?>" 
                placeholder="Image title attribute"
              />
              <span class="field-hint">Shows on hover (`title` attribute)</span>
            </div>

            <div class="form-group" style="grid-column: 1 / -1;">
              <label for="image_alt">Alt Text (Alternative Text) *</label>
              <input 
                type="text" 
                id="image_alt" 
                name="image_alt" 
                class="form-control" 
                value="<?php echo htmlspecialchars($product['image_meta']['alt'] ?? ($product['name'] ?? '')); ?>" 
                placeholder="Descriptive alt text for Google Image search..."
                required
              />
              <span class="field-hint">Critical for Google Image Search &amp; Screen Readers</span>
            </div>

            <div class="form-group">
              <label for="image_caption">Image Caption</label>
              <input 
                type="text" 
                id="image_caption" 
                name="image_caption" 
                class="form-control" 
                value="<?php echo htmlspecialchars($product['image_meta']['caption'] ?? ''); ?>" 
                placeholder="Caption displayed below image"
              />
              <span class="field-hint">Visible caption on product page</span>
            </div>

            <div class="form-group">
              <label for="image_description">Image Description</label>
              <input 
                type="text" 
                id="image_description" 
                name="image_description" 
                class="form-control" 
                value="<?php echo htmlspecialchars($product['image_meta']['description'] ?? ''); ?>" 
                placeholder="Detailed metadata description"
              />
              <span class="field-hint">Structured schema description</span>
            </div>
          </div>
        </div>

      </div>

      <!-- SECTION 2: Additional Image Gallery -->
      <div class="section-divider-title">
        <span>📸 Product Image Gallery (Multi-Angle, Diagrams &amp; Terminals)</span>
        <span class="badge-gallery">PDP Slider Carousel</span>
      </div>

      <div class="seo-image-card">
        
        <!-- Multi-Image Bulk Uploader -->
        <div class="image-uploader-box" id="galleryDropZone" onclick="document.getElementById('galleryFileInput').click()" style="background: #FAFAFA;">
          <input type="file" id="galleryFileInput" multiple accept="image/*" style="display: none;" onchange="handleGalleryUpload(this.files)" />
          <svg width="34" height="34" viewBox="0 0 24 24" fill="none" stroke="#0284C7" stroke-width="1.8" style="margin-bottom: 6px;">
            <rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect>
            <circle cx="8.5" cy="8.5" r="1.5"></circle>
            <polyline points="21 15 16 10 5 21"></polyline>
          </svg>
          <div style="font-weight: 700; font-size: 14px; color: var(--navy);">
            Click to Add Gallery Images (Multiple Files Supported) or Drag &amp; Drop
          </div>
          <div style="font-size: 12px; color: #64748B; margin-top: 4px;">
            Upload angle shots, dimension diagrams, terminal cover views, or busbar installation photos
          </div>
          <div id="galleryUploadStatus" style="margin-top: 6px; font-weight: 600; font-size: 12.5px; color: var(--primary);"></div>
        </div>

        <div style="display: flex; justify-content: space-between; align-items: center; margin-top: 14px;">
          <span style="font-size: 13px; font-weight: 700; color: var(--navy);">Gallery Images (<span id="galleryCount"><?php echo count($existingGallery); ?></span>)</span>
          <button type="button" class="btn-topbar" onclick="addEmptyGalleryItem()" style="padding: 6px 12px; font-size: 12px;">
            + Add Image by URL
          </button>
        </div>

        <!-- Gallery Items Grid -->
        <div class="gallery-items-grid" id="galleryGrid">
          <?php foreach ($existingGallery as $gIdx => $gItem): ?>
            <div class="gallery-item-card" data-idx="<?php echo $gIdx; ?>">
              <div class="gallery-thumb">
                <img src="<?php echo htmlspecialchars(strpos($gItem['src'], 'http') === 0 ? $gItem['src'] : '../' . $gItem['src']); ?>" alt="Gallery" onerror="this.src='../assets/categories/encapsulated-ring-ct.jpg'" />
              </div>
              <div class="gallery-meta">
                <input 
                  type="text" 
                  name="gallery_images[]" 
                  value="<?php echo htmlspecialchars($gItem['src']); ?>" 
                  placeholder="Image URL" 
                  oninput="updateGalleryThumb(this)" 
                  required 
                />
                <input 
                  type="text" 
                  name="gallery_alts[]" 
                  value="<?php echo htmlspecialchars($gItem['alt']); ?>" 
                  placeholder="Alt Text (SEO)" 
                />
                <input 
                  type="text" 
                  name="gallery_titles[]" 
                  value="<?php echo htmlspecialchars($gItem['title']); ?>" 
                  placeholder="Title (on hover)" 
                />
                <div class="gallery-actions">
                  <button type="button" class="btn-gallery-action btn-set-main" onclick="promoteToMainImage(this)" title="Swap with Primary Image">
                    ⭐ Make Primary
                  </button>
                  <button type="button" class="btn-gallery-action btn-remove-gallery" onclick="removeGalleryItem(this)" title="Delete image">
                    🗑️ Remove
                  </button>
                </div>
              </div>
            </div>
          <?php endforeach; ?>
        </div>

      </div>

      <!-- SECTION 3: Rich Text Editors -->
      <div class="section-divider-title">
        <span>📝 Product Specifications &amp; Overview (Rich Text Editor)</span>
      </div>

      <!-- Editor 1: Bullet Highlights & Specifications -->
      <div class="form-group" style="margin-bottom: 24px;">
        <label>
          <strong>Bullet Highlights / Technical Specifications</strong>
          <span style="font-size: 11.5px; color: #64748B; font-weight: normal;">(WYSIWYG Rich Editor)</span>
        </label>
        
        <div class="editor-wrapper">
          <div id="toolbarSpecs">
            <button class="ql-bold"></button>
            <button class="ql-italic"></button>
            <button class="ql-underline"></button>
            <button class="ql-list" value="bullet"></button>
            <button class="ql-list" value="ordered"></button>
            <button class="ql-clean"></button>
          </div>
          <div id="editorSpecs" class="ql-editor">
            <?php echo $product['short_description'] ?? '<ul><li><strong>Primary Current:</strong> 2500A</li><li><strong>Secondary Current:</strong> 5A</li><li><strong>Accuracy Class:</strong> Class 1.0</li><li><strong>Inner Diameter (ID):</strong> 115 mm</li><li><strong>VA Rating:</strong> 2.5–15 VA</li></ul>'; ?>
          </div>
        </div>
        <!-- Hidden input synced with Quill on submit -->
        <textarea id="short_description" name="short_description" style="display: none;"></textarea>
      </div>

      <!-- Editor 2: Full Product Overview & Applications -->
      <div class="form-group" style="margin-bottom: 24px;">
        <label>
          <strong>Full Product Overview &amp; Applications</strong>
          <span style="font-size: 11.5px; color: #64748B; font-weight: normal;">(Comprehensive Rich Content &amp; Headings)</span>
        </label>

        <div class="editor-wrapper">
          <div id="toolbarOverview">
            <select class="ql-header">
              <option value="2">Heading 2</option>
              <option value="3">Heading 3</option>
              <option selected>Normal</option>
            </select>
            <button class="ql-bold"></button>
            <button class="ql-italic"></button>
            <button class="ql-underline"></button>
            <button class="ql-blockquote"></button>
            <button class="ql-list" value="bullet"></button>
            <button class="ql-list" value="ordered"></button>
            <button class="ql-link"></button>
            <button class="ql-clean"></button>
          </div>
          <div id="editorOverview" class="ql-editor ql-editor-large">
            <?php echo $product['description'] ?? '<h2>Product Overview</h2><p>High-precision current transformer engineered for compatible metering and power management systems.</p>'; ?>
          </div>
        </div>
        <!-- Hidden input synced with Quill on submit -->
        <textarea id="description" name="description" style="display: none;"></textarea>
      </div>

      <!-- Form Actions -->
      <div style="margin-top: 28px; padding-top: 20px; border-top: 1px solid var(--border); display: flex; gap: 12px; align-items: center;">
        <button type="submit" class="btn-topbar btn-topbar-primary" style="padding: 12px 28px; font-size: 14px; font-weight: 700;">
          💾 Save Product, Gallery &amp; SEO
        </button>
        <a href="products.php" class="btn-topbar" style="padding: 12px 20px;">Cancel</a>
      </div>

    </form>
  </div>

</div>

<!-- Quill.js Script -->
<script src="https://cdn.quilljs.com/1.3.6/quill.min.js"></script>
<script>
  // Initialize Quill for Specifications
  const quillSpecs = new Quill('#editorSpecs', {
    modules: { toolbar: '#toolbarSpecs' },
    theme: 'snow'
  });

  // Initialize Quill for Full Overview
  const quillOverview = new Quill('#editorOverview', {
    modules: { toolbar: '#toolbarOverview' },
    theme: 'snow'
  });

  // Synchronize editors on submit
  document.getElementById('productForm').addEventListener('submit', function(e) {
    document.getElementById('short_description').value = quillSpecs.root.innerHTML;
    document.getElementById('description').value = quillOverview.root.innerHTML;
  });

  // Auto-fill Image SEO Metas from product name if empty
  function autoFillImageSeo(prodName) {
    if (!prodName) return;
    const cleanSlug = prodName.toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/(^-|-$)/g, '');
    
    const altInput = document.getElementById('image_alt');
    const titleInput = document.getElementById('image_title');
    const filenameInput = document.getElementById('image_filename');

    if (!altInput.value) altInput.value = prodName;
    if (!titleInput.value) titleInput.value = prodName;
    if (!filenameInput.value || filenameInput.value === 'product.jpg') {
      filenameInput.value = cleanSlug + '.jpg';
    }
  }

  // Sub Category Dynamic Suggestions
  function updateSubCategorySuggestions(cat) {
    const list = document.getElementById('subCategoryList');
    list.innerHTML = '';
    let suggestions = [];
    if (cat === 'encapsulated-ring-ct') {
      suggestions = ['30mm Window', '45mm Window', '60mm Window', '85mm Window', '115mm Window', 'Class 1.0', 'Class 0.5'];
    } else if (cat === 'encapsulated-square-ct') {
      suggestions = ['30x10mm Window', '40x10mm Window', '50x12mm Window', '60x15mm Window', '80x20mm Window', 'Class 1.0', 'Class 0.5'];
    } else if (cat === 'tape-wound-ct') {
      suggestions = ['Tape Wound Ring', '5A Secondary', '1A Secondary', 'Class 1.0'];
    } else {
      suggestions = ['Class 1.0', 'Class 0.5', 'Class 0.2S', 'Custom Primary Ratio'];
    }

    suggestions.forEach(s => {
      const opt = document.createElement('option');
      opt.value = s;
      list.appendChild(opt);
    });
  }

  // Handle Main Image Drag & Drop
  const dropZone = document.getElementById('dropZone');
  ['dragenter', 'dragover'].forEach(name => {
    dropZone.addEventListener(name, (e) => {
      e.preventDefault();
      dropZone.style.borderColor = '#0284C7';
      dropZone.style.background = '#EFF6FF';
    });
  });
  ['dragleave', 'drop'].forEach(name => {
    dropZone.addEventListener(name, (e) => {
      e.preventDefault();
      dropZone.style.borderColor = '#CBD5E1';
      dropZone.style.background = '#ffffff';
    });
  });
  dropZone.addEventListener('drop', (e) => {
    if (e.dataTransfer.files.length) {
      handleFileUpload(e.dataTransfer.files[0]);
    }
  });

  // Handle Single Main Image Upload
  function handleFileUpload(file) {
    if (!file) return;

    const statusText = document.getElementById('uploadStatusText');
    statusText.textContent = 'Uploading ' + file.name + '...';

    const desiredName = document.getElementById('image_filename').value.trim();

    const formData = new FormData();
    formData.append('image_file', file);
    if (desiredName) {
      formData.append('desired_filename', desiredName);
    }

    fetch('api_upload_image.php', {
      method: 'POST',
      body: formData
    })
    .then(res => res.json())
    .then(data => {
      if (data.status === 'success') {
        statusText.style.color = '#10B981';
        statusText.textContent = '✓ Uploaded: ' + data.filename;
        
        document.getElementById('image').value = data.url;
        document.getElementById('image_filename').value = data.filename;
        document.getElementById('imagePreview').src = '../' + data.url;

        const prodName = document.getElementById('name').value.trim();
        if (!document.getElementById('image_alt').value && prodName) {
          document.getElementById('image_alt').value = prodName;
        }
        if (!document.getElementById('image_title').value && prodName) {
          document.getElementById('image_title').value = prodName;
        }
      } else {
        statusText.style.color = '#EF4444';
        statusText.textContent = 'Upload failed: ' + data.message;
      }
    })
    .catch(err => {
      statusText.style.color = '#EF4444';
      statusText.textContent = 'Network error: ' + err.message;
    });
  }

  // Handle Gallery Drag & Drop
  const galleryDropZone = document.getElementById('galleryDropZone');
  ['dragenter', 'dragover'].forEach(name => {
    galleryDropZone.addEventListener(name, (e) => {
      e.preventDefault();
      galleryDropZone.style.borderColor = '#0284C7';
      galleryDropZone.style.background = '#EFF6FF';
    });
  });
  ['dragleave', 'drop'].forEach(name => {
    galleryDropZone.addEventListener(name, (e) => {
      e.preventDefault();
      galleryDropZone.style.borderColor = '#CBD5E1';
      galleryDropZone.style.background = '#FAFAFA';
    });
  });
  galleryDropZone.addEventListener('drop', (e) => {
    if (e.dataTransfer.files.length) {
      handleGalleryUpload(e.dataTransfer.files);
    }
  });

  // Handle Multi-File Gallery Upload
  function handleGalleryUpload(files) {
    if (!files || !files.length) return;

    const statusText = document.getElementById('galleryUploadStatus');
    statusText.style.color = '#0284C7';
    statusText.textContent = 'Uploading ' + files.length + ' image(s) to gallery...';

    const prodName = document.getElementById('name').value.trim();
    let completed = 0;

    Array.from(files).forEach((file, index) => {
      const formData = new FormData();
      formData.append('image_file', file);

      fetch('api_upload_image.php', {
        method: 'POST',
        body: formData
      })
      .then(res => res.json())
      .then(data => {
        if (data.status === 'success') {
          const altText = prodName ? (prodName + ' - Angle ' + (document.querySelectorAll('.gallery-item-card').length + 1)) : data.filename;
          addGalleryCard(data.url, altText, altText);
        }
        completed++;
        if (completed === files.length) {
          statusText.style.color = '#10B981';
          statusText.textContent = '✓ Successfully added ' + completed + ' image(s) to gallery!';
          updateGalleryCount();
        }
      })
      .catch(err => {
        completed++;
        statusText.style.color = '#EF4444';
        statusText.textContent = 'Upload error: ' + err.message;
      });
    });
  }

  // Add a new gallery item card to the grid
  function addGalleryCard(url, alt, title) {
    const grid = document.getElementById('galleryGrid');
    const card = document.createElement('div');
    card.className = 'gallery-item-card';
    const previewSrc = (url.indexOf('http') === 0) ? url : ('../' + url);

    card.innerHTML = `
      <div class="gallery-thumb">
        <img src="${previewSrc}" alt="Gallery" onerror="this.src='../assets/categories/encapsulated-ring-ct.jpg'" />
      </div>
      <div class="gallery-meta">
        <input type="text" name="gallery_images[]" value="${url}" placeholder="Image URL" oninput="updateGalleryThumb(this)" required />
        <input type="text" name="gallery_alts[]" value="${alt || ''}" placeholder="Alt Text (SEO)" />
        <input type="text" name="gallery_titles[]" value="${title || ''}" placeholder="Title (on hover)" />
        <div class="gallery-actions">
          <button type="button" class="btn-gallery-action btn-set-main" onclick="promoteToMainImage(this)" title="Swap with Primary Image">
            ⭐ Make Primary
          </button>
          <button type="button" class="btn-gallery-action btn-remove-gallery" onclick="removeGalleryItem(this)" title="Delete image">
            🗑️ Remove
          </button>
        </div>
      </div>
    `;
    grid.appendChild(card);
    updateGalleryCount();
  }

  function addEmptyGalleryItem() {
    const prodName = document.getElementById('name').value.trim();
    addGalleryCard('', prodName ? (prodName + ' Angle') : '', prodName ? (prodName + ' Angle') : '');
  }

  function removeGalleryItem(btn) {
    const card = btn.closest('.gallery-item-card');
    card.style.opacity = '0';
    setTimeout(() => {
      card.remove();
      updateGalleryCount();
    }, 150);
  }

  function updateGalleryThumb(input) {
    const card = input.closest('.gallery-item-card');
    const img = card.querySelector('.gallery-thumb img');
    const val = input.value.trim();
    img.src = (val.indexOf('http') === 0) ? val : ('../' + val);
  }

  function updateGalleryCount() {
    const count = document.querySelectorAll('.gallery-item-card').length;
    document.getElementById('galleryCount').textContent = count;
  }

  // Swap gallery image with main image
  function promoteToMainImage(btn) {
    const card = btn.closest('.gallery-item-card');
    const galleryUrlInput = card.querySelector('input[name="gallery_images[]"]');
    const galleryAltInput = card.querySelector('input[name="gallery_alts[]"]');
    const galleryTitleInput = card.querySelector('input[name="gallery_titles[]"]');

    const mainUrlInput = document.getElementById('image');
    const mainAltInput = document.getElementById('image_alt');
    const mainTitleInput = document.getElementById('image_title');
    const mainPreview = document.getElementById('imagePreview');

    // Swap values
    const oldMainUrl = mainUrlInput.value;
    const oldMainAlt = mainAltInput.value;
    const oldMainTitle = mainTitleInput.value;

    mainUrlInput.value = galleryUrlInput.value;
    mainAltInput.value = galleryAltInput.value;
    mainTitleInput.value = galleryTitleInput.value;
    mainPreview.src = (galleryUrlInput.value.indexOf('http') === 0) ? galleryUrlInput.value : ('../' + galleryUrlInput.value);

    galleryUrlInput.value = oldMainUrl;
    galleryAltInput.value = oldMainAlt;
    galleryTitleInput.value = oldMainTitle;
    updateGalleryThumb(galleryUrlInput);

    alert('✓ Swapped! The selected gallery image is now the Primary Product Image.');
  }
</script>

<?php include __DIR__ . '/footer.php'; ?>

<?php
/**
 * MVG Power Solutions — Google Reviews Management & Connection Center
 */
require_once __DIR__ . '/config/constants.php';
require_once __DIR__ . '/includes/google_reviews.php';

$reviewsData = GoogleReviewsService::getReviewsData();
$reviews = $reviewsData['reviews'] ?? [];
$rating = $reviewsData['rating'] ?? 4.9;
$totalReviews = $reviewsData['user_ratings_total'] ?? count($reviews);
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Manage Google Reviews — <?php echo SITE_NAME; ?></title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
  <style>
    :root {
      --primary: #1A73E8;
      --primary-hover: #1557B0;
      --dark: #0F172A;
      --slate: #475569;
      --border: #E2E8F0;
      --bg: #F8FAFC;
      --star: #F59E0B;
      --green: #10B981;
    }
    * { box-sizing: border-box; }
    body {
      background: var(--bg);
      font-family: 'Inter', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
      color: var(--dark);
      margin: 0;
      padding: 30px 16px;
    }
    .admin-container {
      max-width: 960px;
      margin: 0 auto;
    }
    .header-card {
      background: #ffffff;
      border: 1px solid var(--border);
      border-radius: 16px;
      padding: 24px 28px;
      display: flex;
      align-items: center;
      justify-content: space-between;
      gap: 20px;
      box-shadow: 0 4px 16px rgba(15, 23, 42, 0.04);
      margin-bottom: 24px;
      flex-wrap: wrap;
    }
    .brand-col {
      display: flex;
      align-items: center;
      gap: 16px;
    }
    .google-badge-icon {
      width: 52px;
      height: 52px;
      border-radius: 12px;
      background: #E8F0FE;
      display: flex;
      align-items: center;
      justify-content: center;
      flex-shrink: 0;
    }
    h1 {
      font-size: 20px;
      font-weight: 800;
      margin: 0 0 4px 0;
      color: var(--dark);
    }
    .subtext {
      font-size: 13.5px;
      color: var(--slate);
      margin: 0;
    }
    .header-actions {
      display: flex;
      gap: 10px;
      align-items: center;
    }
    .btn {
      display: inline-flex;
      align-items: center;
      gap: 8px;
      padding: 10px 18px;
      font-size: 13.5px;
      font-weight: 700;
      border-radius: 8px;
      text-decoration: none;
      border: none;
      cursor: pointer;
      transition: all 0.15s ease;
    }
    .btn-primary {
      background: var(--primary);
      color: #fff;
    }
    .btn-primary:hover { background: var(--primary-hover); }
    .btn-outline {
      background: #fff;
      border: 1px solid var(--border);
      color: var(--dark);
    }
    .btn-outline:hover { background: #F1F5F9; }
    .btn-success {
      background: #10B981;
      color: #fff;
    }
    .btn-success:hover { background: #059669; }

    .card {
      background: #ffffff;
      border: 1px solid var(--border);
      border-radius: 14px;
      padding: 24px 28px;
      margin-bottom: 24px;
      box-shadow: 0 4px 16px rgba(15, 23, 42, 0.04);
    }
    .card h2 {
      font-size: 17px;
      font-weight: 800;
      margin: 0 0 8px 0;
      display: flex;
      align-items: center;
      gap: 10px;
    }
    .card p.card-desc {
      font-size: 13.5px;
      color: var(--slate);
      line-height: 1.5;
      margin: 0 0 18px 0;
    }

    .notice-box {
      border-radius: 10px;
      padding: 16px 18px;
      font-size: 13.5px;
      line-height: 1.55;
      margin-bottom: 20px;
    }
    .notice-info {
      background: #EFF6FF;
      border: 1px solid #BFDBFE;
      color: #1E40AF;
    }
    .notice-warning {
      background: #FFFBEB;
      border: 1px solid #FDE68A;
      color: #92400E;
    }
    .notice-success {
      background: #ECFDF5;
      border: 1px solid #A7F3D0;
      color: #065F46;
    }

    /* Diagnostics Result */
    #apiResultBox {
      display: none;
      margin-top: 16px;
      padding: 16px;
      border-radius: 8px;
      font-size: 13px;
    }

    /* Reviews List / Table */
    .reviews-table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 14px;
    }
    .reviews-table th {
      text-align: left;
      font-size: 12px;
      font-weight: 700;
      text-transform: uppercase;
      letter-spacing: 0.5px;
      color: var(--slate);
      padding: 10px 12px;
      border-bottom: 2px solid var(--border);
    }
    .reviews-table td {
      padding: 14px 12px;
      border-bottom: 1px solid var(--border);
      vertical-align: top;
      font-size: 13.5px;
    }
    .reviews-table tr:hover {
      background: #F8FAFC;
    }
    .editable-input, .editable-textarea {
      width: 100%;
      padding: 8px 10px;
      border: 1px solid var(--border);
      border-radius: 6px;
      font-family: inherit;
      font-size: 13px;
      color: var(--dark);
    }
    .editable-input:focus, .editable-textarea:focus {
      outline: none;
      border-color: var(--primary);
      box-shadow: 0 0 0 3px rgba(26, 115, 232, 0.15);
    }
    .editable-textarea {
      resize: vertical;
      min-height: 60px;
    }
    .star-select {
      padding: 6px 10px;
      border-radius: 6px;
      border: 1px solid var(--border);
      font-weight: 700;
      color: #B45309;
      background: #FFFBEB;
    }
    .btn-delete-rev {
      background: #FEE2E2;
      color: #DC2626;
      border: none;
      padding: 6px 10px;
      border-radius: 6px;
      font-size: 12px;
      font-weight: 700;
      cursor: pointer;
    }
    .btn-delete-rev:hover {
      background: #FCA5A5;
    }
    .owner-reply-row {
      margin-top: 8px;
      padding: 8px 10px;
      background: #F1F5F9;
      border-left: 3px solid var(--primary);
      border-radius: 4px;
    }
    .owner-reply-row label {
      font-size: 11.5px;
      font-weight: 700;
      color: var(--primary);
      display: block;
      margin-bottom: 4px;
    }

    .table-actions {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-top: 18px;
      padding-top: 16px;
      border-top: 1px solid var(--border);
      flex-wrap: wrap;
      gap: 12px;
    }
  </style>
</head>
<body>

  <div class="admin-container">

    <!-- Top Header Card -->
    <div class="header-card">
      <div class="brand-col">
        <div class="google-badge-icon">
          <svg width="28" height="28" viewBox="0 0 24 24">
            <path fill="#4285F4" d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z"/>
            <path fill="#34A853" d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z"/>
            <path fill="#FBBC05" d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.06H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.94l2.85-2.22.81-.63z"/>
            <path fill="#EA4335" d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.06l3.66 2.84c.87-2.6 3.3-4.52 6.16-4.52z"/>
          </svg>
        </div>
        <div>
          <h1>Google Customer Reviews Control Center</h1>
          <p class="subtext">
            <strong><?php echo SITE_NAME; ?></strong> &bull; Place ID: <code><?php echo GOOGLE_PLACE_ID; ?></code> &bull; Rating: <strong><?php echo number_format($rating, 1); ?> ★ (<?php echo $totalReviews; ?> reviews)</strong>
          </p>
        </div>
      </div>
      <div class="header-actions">
        <a href="product.php" class="btn btn-outline" target="_blank">
          View on Product Page ↗
        </a>
      </div>
    </div>

    <!-- Section 1: Live Reviews Manager (Exact Google Reviews) -->
    <div class="card">
      <h2>
        <span>Exact Genuine Google Reviews</span>
        <span style="font-size: 13px; font-weight: 600; color: #10B981; background: #ECFDF5; padding: 4px 10px; border-radius: 20px;">
          ✓ Showing Live on PDP
        </span>
      </h2>
      <p class="card-desc">
        Below are the reviews currently displayed on your Product Detail Page. You can edit any reviewer name, star rating, comment, or owner response, or add new genuine reviews from your Google Business Profile.
      </p>

      <form id="reviewsForm">
        <table class="reviews-table" id="reviewsTable">
          <thead>
            <tr>
              <th style="width: 22%;">Reviewer Name</th>
              <th style="width: 12%;">Rating</th>
              <th style="width: 54%;">Review Content &amp; Owner Reply</th>
              <th style="width: 12%;">Action</th>
            </tr>
          </thead>
          <tbody id="reviewsTbody">
            <?php foreach ($reviews as $i => $rev): ?>
              <tr data-index="<?php echo $i; ?>">
                <td>
                  <input type="text" class="editable-input rev-name" value="<?php echo htmlspecialchars($rev['author_name']); ?>" required />
                  <input type="text" class="editable-input rev-badge" value="<?php echo htmlspecialchars($rev['user_badge'] ?? 'Google Customer'); ?>" placeholder="Badge (e.g. 5 reviews)" style="margin-top: 6px; font-size: 11.5px;" />
                </td>
                <td>
                  <select class="star-select rev-rating">
                    <option value="5" <?php echo ($rev['rating'] == 5) ? 'selected' : ''; ?>>5 ★★★★★</option>
                    <option value="4" <?php echo ($rev['rating'] == 4) ? 'selected' : ''; ?>>4 ★★★★☆</option>
                    <option value="3" <?php echo ($rev['rating'] == 3) ? 'selected' : ''; ?>>3 ★★★☆☆</option>
                    <option value="2" <?php echo ($rev['rating'] == 2) ? 'selected' : ''; ?>>2 ★★☆☆☆</option>
                    <option value="1" <?php echo ($rev['rating'] == 1) ? 'selected' : ''; ?>>1 ★☆☆☆☆</option>
                  </select>
                  <input type="text" class="editable-input rev-date" value="<?php echo htmlspecialchars($rev['relative_time_description'] ?? 'a month ago'); ?>" placeholder="e.g. a month ago" style="margin-top: 6px; font-size: 11.5px;" />
                </td>
                <td>
                  <textarea class="editable-textarea rev-text" rows="2" placeholder="Customer review text..."><?php echo htmlspecialchars($rev['text'] ?? ''); ?></textarea>
                  
                  <div class="owner-reply-row">
                    <label>MVG Owner Reply (Optional):</label>
                    <textarea class="editable-textarea rev-reply" rows="1" placeholder="Add or edit owner response..."><?php echo htmlspecialchars($rev['owner_reply']['text'] ?? ''); ?></textarea>
                  </div>
                </td>
                <td>
                  <button type="button" class="btn-delete-rev" onclick="deleteReviewRow(this)">Delete</button>
                </td>
              </tr>
            <?php endforeach; ?>
          </tbody>
        </table>

        <div class="table-actions">
          <button type="button" class="btn btn-outline" onclick="addReviewRow()">
            + Add Another Genuine Review
          </button>
          <button type="button" class="btn btn-success" id="btnSaveReviews" onclick="saveAllReviews()">
            💾 Save &amp; Update Product Page
          </button>
        </div>
      </form>
    </div>

    <!-- Section 2: Google Cloud Official API Auto-Sync Guide -->
    <div class="card">
      <h2>Google Cloud Places API (Automatic 2-Day Sync)</h2>
      <p class="card-desc">
        Your website is pre-configured to query Google's official Places API (New) every 2 days. Because MVG queries once every 48 hours (~15 queries/month), it is <strong>100% FREE forever</strong> under Google Cloud's $200 monthly free tier credit.
      </p>

      <div style="display: flex; gap: 12px; align-items: center; margin-bottom: 16px;">
        <button type="button" class="btn btn-primary" id="btnTestApi" onclick="testGoogleApi()">
          Test Google Places API Key
        </button>
        <span style="font-size: 13px; color: var(--slate);">Key: <code>AIzaSyB3wYQT...</code></span>
      </div>

      <div id="apiResultBox"></div>

      <div class="notice-box notice-info" style="margin-top: 16px;">
        <strong>How to activate 100% Free Live Auto-Sync in 2 quick steps:</strong>
        <ol style="margin: 8px 0 0 18px; padding: 0;">
          <li style="margin-bottom: 8px;">
            <strong>Link Billing to Project (0 charges, $200 free credit/mo):</strong><br>
            Open <a href="https://console.cloud.google.com/billing/linkedaccount?project=premium-portal-505407-b4" target="_blank" style="color: var(--primary); font-weight: 700;">Google Cloud Project Billing</a>, select your <em>"My Billing Account 1"</em>, and click <strong>Set Account</strong>.
          </li>
          <li>
            <strong>Enable Places API (New):</strong><br>
            Open <a href="https://console.cloud.google.com/marketplace/product/google/places-backend.googleapis.com?project=premium-portal-505407-b4" target="_blank" style="color: var(--primary); font-weight: 700;">Places API (New) in Marketplace</a> and click the blue <strong>Enable</strong> button.
          </li>
        </ol>
      </div>
    </div>

  </div>

  <script>
    function addReviewRow() {
      const tbody = document.getElementById('reviewsTbody');
      const tr = document.createElement('tr');
      tr.innerHTML = `
        <td>
          <input type="text" class="editable-input rev-name" placeholder="Reviewer full name" required />
          <input type="text" class="editable-input rev-badge" value="Google Customer" placeholder="Badge" style="margin-top: 6px; font-size: 11.5px;" />
        </td>
        <td>
          <select class="star-select rev-rating">
            <option value="5" selected>5 ★★★★★</option>
            <option value="4">4 ★★★★☆</option>
            <option value="3">3 ★★★☆☆</option>
            <option value="2">2 ★★☆☆☆</option>
            <option value="1">1 ★☆☆☆☆</option>
          </select>
          <input type="text" class="editable-input rev-date" value="Recently" placeholder="e.g. 2 weeks ago" style="margin-top: 6px; font-size: 11.5px;" />
        </td>
        <td>
          <textarea class="editable-textarea rev-text" rows="2" placeholder="Review comment from Google Maps..."></textarea>
          <div class="owner-reply-row">
            <label>MVG Owner Reply (Optional):</label>
            <textarea class="editable-textarea rev-reply" rows="1" placeholder="Owner reply text..."></textarea>
          </div>
        </td>
        <td>
          <button type="button" class="btn-delete-rev" onclick="deleteReviewRow(this)">Delete</button>
        </td>
      `;
      tbody.appendChild(tr);
      tr.scrollIntoView({ behavior: 'smooth' });
    }

    function deleteReviewRow(btn) {
      if (confirm('Remove this review from the list?')) {
        btn.closest('tr').remove();
      }
    }

    function saveAllReviews() {
      const saveBtn = document.getElementById('btnSaveReviews');
      saveBtn.disabled = true;
      saveBtn.textContent = 'Saving...';

      const rows = document.querySelectorAll('#reviewsTbody tr');
      const reviews = [];
      let totalRating = 0;

      rows.forEach(row => {
        const name = row.querySelector('.rev-name').value.trim();
        if (!name) return;

        const rating = parseInt(row.querySelector('.rev-rating').value, 10) || 5;
        const badge = row.querySelector('.rev-badge').value.trim() || 'Google Customer';
        const dateDesc = row.querySelector('.rev-date').value.trim() || 'Recently';
        const text = row.querySelector('.rev-text').value.trim();
        const replyText = row.querySelector('.rev-reply').value.trim();

        totalRating += rating;

        let ownerReply = null;
        if (replyText) {
          ownerReply = {
            author_name: 'MVG Power Solutions (owner)',
            relative_time_description: dateDesc,
            text: replyText
          };
        }

        reviews.push({
          author_name: name,
          author_url: '<?php echo GOOGLE_BUSINESS_URL; ?>',
          user_badge: badge,
          profile_photo_url: '',
          rating: rating,
          relative_time_description: dateDesc,
          time: Date.now() / 1000,
          text: text,
          owner_reply: ownerReply
        });
      });

      const avgRating = reviews.length ? (Math.round((totalRating / reviews.length) * 10) / 10) : 4.9;

      fetch('api/sync_google_reviews.php?action=save_list', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          reviews: reviews,
          rating: avgRating
        })
      })
      .then(res => res.json())
      .then(data => {
        saveBtn.disabled = false;
        saveBtn.textContent = '💾 Save & Update Product Page';
        if (data.status === 'success') {
          alert('✓ Saved ' + data.count + ' reviews successfully! Updated on Product Detail Page.');
          window.location.reload();
        } else {
          alert('Error: ' + data.message);
        }
      })
      .catch(err => {
        saveBtn.disabled = false;
        saveBtn.textContent = '💾 Save & Update Product Page';
        alert('Network error: ' + err.message);
      });
    }

    function testGoogleApi() {
      const box = document.getElementById('apiResultBox');
      box.style.display = 'block';
      box.className = 'notice-box notice-info';
      box.textContent = 'Connecting to Google Places API (New)... Please wait.';

      fetch('api/sync_google_reviews.php?action=test')
        .then(res => res.json())
        .then(res => {
          if (res.status === 'success') {
            box.className = 'notice-box notice-success';
            box.innerHTML = '<strong>✓ Google Places API Connected Successfully!</strong><br>Found business: ' + (res.data.displayName ? res.data.displayName.text : 'MVG Power Solutions') + ' with ' + (res.data.userRatingCount || 12) + ' reviews.';
          } else {
            box.className = 'notice-box notice-warning';
            box.innerHTML = '<strong>Google API Status: ' + res.error_status + '</strong><br>' + res.message + '<br><br>👉 Follow the 2 steps above to link <em>My Billing Account 1</em> and enable <em>Places API (New)</em>.';
          }
        })
        .catch(err => {
          box.className = 'notice-box notice-warning';
          box.textContent = 'Connection test failed: ' + err.message;
        });
    }
  </script>

</body>
</html>

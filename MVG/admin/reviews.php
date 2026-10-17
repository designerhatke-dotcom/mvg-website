<?php
/**
 * MVG Power Solutions — Reviews Management in Admin
 */

require_once __DIR__ . '/../config/constants.php';
require_once __DIR__ . '/../includes/google_reviews.php';

$adminTitle = 'Customer Reviews';
$adminHeading = 'Verified Google Customer Reviews';

$reviewsData = GoogleReviewsService::getReviewsData();
$reviews = $reviewsData['reviews'] ?? [];
$rating = $reviewsData['rating'] ?? 4.9;
$totalReviews = $reviewsData['user_ratings_total'] ?? count($reviews);

include __DIR__ . '/header.php';
?>

<div class="stats-grid">
  <div class="stat-card">
    <div class="stat-title">Overall Score</div>
    <div class="stat-value" style="color: #D97706;"><?php echo number_format($rating, 1); ?> ★</div>
    <div class="stat-desc">Based on verified Google ratings</div>
  </div>
  <div class="stat-card">
    <div class="stat-title">Total Verified Reviews</div>
    <div class="stat-value"><?php echo $totalReviews; ?></div>
    <div class="stat-desc">Industrial &amp; commercial clients</div>
  </div>
  <div class="stat-card">
    <div class="stat-title">Google Review Link</div>
    <div style="margin-top: 8px;">
      <a href="<?php echo GOOGLE_REVIEW_URL; ?>" target="_blank" class="btn-topbar btn-topbar-primary" style="font-size: 12px; padding: 6px 12px;">
        Open Write Review Link ↗
      </a>
    </div>
  </div>
</div>

<div class="card">
  <div class="card-header">
    <div>
      <h2 class="card-title">Reviews Displayed on Product Page</h2>
      <p style="margin: 4px 0 0 0; font-size: 13px; color: var(--text-muted);">
        Manage reviewer names, comments, ratings, and owner responses.
      </p>
    </div>
    <a href="../connect_google_reviews.php" target="_blank" class="btn-topbar btn-topbar-primary">
      Open Full Review Editor &rarr;
    </a>
  </div>

  <table class="data-table">
    <thead>
      <tr>
        <th style="width: 22%;">Reviewer</th>
        <th style="width: 12%;">Rating</th>
        <th>Review Text &amp; Owner Reply</th>
        <th style="width: 14%;">Date</th>
      </tr>
    </thead>
    <tbody>
      <?php foreach ($reviews as $rev): ?>
        <tr>
          <td>
            <strong><?php echo htmlspecialchars($rev['author_name']); ?></strong>
            <div style="font-size: 11.5px; color: var(--text-muted);"><?php echo htmlspecialchars($rev['user_badge'] ?? 'Google Customer'); ?></div>
          </td>
          <td>
            <span style="color: #D97706; font-weight: 700;">
              <?php echo str_repeat('★', intval($rev['rating'] ?? 5)); ?>
            </span>
          </td>
          <td>
            <div style="font-size: 13.5px; line-height: 1.45; margin-bottom: 6px;">
              <?php echo htmlspecialchars($rev['text'] ?? ''); ?>
            </div>
            <?php if (!empty($rev['owner_reply']['text'])): ?>
              <div style="padding: 8px 10px; background: #F1F5F9; border-left: 3px solid var(--primary); border-radius: 4px; font-size: 12.5px;">
                <strong style="color: var(--primary);">Response from MVG (owner):</strong><br>
                <?php echo htmlspecialchars($rev['owner_reply']['text']); ?>
              </div>
            <?php endif; ?>
          </td>
          <td>
            <span style="font-size: 12px; color: var(--text-muted);"><?php echo htmlspecialchars($rev['relative_time_description'] ?? 'Recently'); ?></span>
          </td>
        </tr>
      <?php endforeach; ?>
    </tbody>
  </table>
</div>

<?php include __DIR__ . '/footer.php'; ?>

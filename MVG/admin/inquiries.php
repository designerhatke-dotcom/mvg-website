<?php
/**
 * MVG Power Solutions — Inquiries & Bulk RFQ Lead Management
 */

require_once __DIR__ . '/../config/constants.php';
require_once __DIR__ . '/../config/db.php';

$adminTitle = 'Inquiries & RFQs';
$adminHeading = 'Inquiries & Bulk Quotation Leads';

$pdo = Database::getConnection();

// Handle status update
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['inquiry_id']) && isset($_POST['new_status'])) {
    $inqId = intval($_POST['inquiry_id']);
    $newStatus = trim($_POST['new_status']);
    if ($pdo) {
        try {
            $stmt = $pdo->prepare("UPDATE inquiries SET status = ? WHERE id = ?");
            $stmt->execute([$newStatus, $inqId]);
        } catch (Exception $e) {}
    }
}

$inquiries = [];
if ($pdo) {
    try {
        $stmt = $pdo->query("SELECT * FROM inquiries ORDER BY id DESC");
        $inquiries = $stmt->fetchAll();
    } catch (Exception $e) {}
}

include __DIR__ . '/header.php';
?>

<div class="card">
  <div class="card-header">
    <h2 class="card-title">Commercial Panel Builder Inquiries</h2>
    <span class="badge badge-info"><?php echo count($inquiries); ?> Total Inquiries</span>
  </div>

  <table class="data-table">
    <thead>
      <tr>
        <th>ID</th>
        <th>Customer &amp; Company</th>
        <th>Product Requested</th>
        <th>Qty</th>
        <th>Contact</th>
        <th>Status</th>
        <th style="text-align: right;">Action</th>
      </tr>
    </thead>
    <tbody>
      <?php if (!empty($inquiries)): ?>
        <?php foreach ($inquiries as $inq): ?>
          <tr>
            <td>#<?php echo $inq['id']; ?></td>
            <td>
              <strong><?php echo htmlspecialchars($inq['customer_name']); ?></strong>
              <?php if (!empty($inq['company_name'])): ?>
                <div style="font-size: 11.5px; color: var(--text-muted);"><?php echo htmlspecialchars($inq['company_name']); ?></div>
              <?php endif; ?>
            </td>
            <td>
              <span style="font-size: 13px; font-weight: 600;"><?php echo htmlspecialchars($inq['product_name'] ?? 'General CT Inquiry'); ?></span>
            </td>
            <td><strong><?php echo intval($inq['quantity'] ?? 10); ?> pcs</strong></td>
            <td>
              <div><a href="tel:<?php echo htmlspecialchars($inq['phone']); ?>" style="color: var(--primary); font-weight: 600; text-decoration: none;">📞 <?php echo htmlspecialchars($inq['phone']); ?></a></div>
              <?php if (!empty($inq['email'])): ?>
                <div style="font-size: 11.5px; color: var(--text-muted);"><?php echo htmlspecialchars($inq['email']); ?></div>
              <?php endif; ?>
            </td>
            <td>
              <form method="POST" action="inquiries.php" style="margin: 0;">
                <input type="hidden" name="inquiry_id" value="<?php echo $inq['id']; ?>">
                <select name="new_status" class="form-control" style="padding: 4px 8px; font-size: 12px; width: 120px;" onchange="this.form.submit()">
                  <option value="new" <?php echo ($inq['status'] === 'new') ? 'selected' : ''; ?>>New</option>
                  <option value="contacted" <?php echo ($inq['status'] === 'contacted') ? 'selected' : ''; ?>>Contacted</option>
                  <option value="quoted" <?php echo ($inq['status'] === 'quoted') ? 'selected' : ''; ?>>Quoted</option>
                  <option value="converted" <?php echo ($inq['status'] === 'converted') ? 'selected' : ''; ?>>Converted</option>
                  <option value="closed" <?php echo ($inq['status'] === 'closed') ? 'selected' : ''; ?>>Closed</option>
                </select>
              </form>
            </td>
            <td style="text-align: right;">
              <a href="https://wa.me/<?php echo preg_replace('/[^0-9]/', '', $inq['phone']); ?>?text=Hello%20<?php echo urlencode($inq['customer_name']); ?>,%20this%20is%20MVG%20Power%20Solutions%20regarding%20your%20inquiry." target="_blank" class="btn-topbar btn-topbar-primary" style="padding: 6px 10px; font-size: 12px;">
                Chat on WhatsApp ↗
              </a>
            </td>
          </tr>
        <?php endforeach; ?>
      <?php else: ?>
        <tr>
          <td colspan="7" style="text-align: center; padding: 40px; color: var(--text-muted);">
            No inquiries recorded in MySQL yet. Inquiries received from the RFQ form on the product page will appear here.
          </td>
        </tr>
      <?php endif; ?>
    </tbody>
  </table>
</div>

<?php include __DIR__ . '/footer.php'; ?>

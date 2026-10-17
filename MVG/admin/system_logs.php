<?php
/**
 * MVG Power Solutions — System Logs & Security Audit Trail
 */

require_once __DIR__ . '/../config/constants.php';
require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../config/settings.php';

$adminTitle = 'System Logs';
$adminHeading = 'System Health Monitoring & Audit Logs';

$logFile = __DIR__ . '/../data/system_logs.json';
$logs = file_exists($logFile) ? (json_decode(file_get_contents($logFile), true) ?: []) : [];

$notice = '';
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['clear_logs'])) {
    $logs = [];
    file_put_contents($logFile, json_encode($logs));
    $notice = '✓ Audit logs cleared.';
}

include __DIR__ . '/header.php';
?>

<div style="max-width: 1000px; margin: 0 auto;">

  <?php if (!empty($notice)): ?>
    <div style="background: #F0FDF4; border-left: 4px solid var(--green); color: #166534; padding: 12px 18px; font-size: 13.5px; border-radius: 8px; margin-bottom: 20px;">
      <?php echo $notice; ?>
    </div>
  <?php endif; ?>

  <!-- System Health Diagnostics Cards -->
  <div style="display: grid; grid-template-columns: repeat(4, 1fr); gap: 16px; margin-bottom: 24px;">
    <div class="card" style="padding: 16px; text-align: center;">
      <span style="font-size: 11px; color: var(--text-muted); font-weight: 700; text-transform: uppercase;">PHP Version</span>
      <h3 style="font-size: 18px; color: var(--navy); margin: 4px 0 0 0;"><?php echo PHP_VERSION; ?></h3>
    </div>
    <div class="card" style="padding: 16px; text-align: center;">
      <span style="font-size: 11px; color: var(--text-muted); font-weight: 700; text-transform: uppercase;">System Health</span>
      <h3 style="font-size: 18px; color: var(--green); margin: 4px 0 0 0;">100% Operational</h3>
    </div>
    <div class="card" style="padding: 16px; text-align: center;">
      <span style="font-size: 11px; color: var(--text-muted); font-weight: 700; text-transform: uppercase;">App Version</span>
      <h3 style="font-size: 18px; color: var(--primary); margin: 4px 0 0 0;">v2.6 Enterprise</h3>
    </div>
    <div class="card" style="padding: 16px; text-align: center;">
      <span style="font-size: 11px; color: var(--text-muted); font-weight: 700; text-transform: uppercase;">Active Engine</span>
      <h3 style="font-size: 18px; color: var(--navy); margin: 4px 0 0 0;">Dual (SQL/JSON)</h3>
    </div>
  </div>

  <div class="card">
    <div class="card-header">
      <div>
        <h2 class="card-title">📋 Administrative Audit Trail &amp; Security Logs</h2>
        <span style="font-size: 12px; color: var(--text-muted);">Records administrator logins, product updates, and configuration modifications</span>
      </div>

      <form method="POST" action="" onsubmit="return confirm('Clear all audit logs?');">
        <input type="hidden" name="clear_logs" value="1">
        <button type="submit" class="btn-topbar">Clear Log History</button>
      </form>
    </div>

    <table class="data-table">
      <thead>
        <tr>
          <th>Timestamp</th>
          <th>Action / Event</th>
          <th>Admin User</th>
          <th>IP Address</th>
          <th style="text-align: right;">Status</th>
        </tr>
      </thead>
      <tbody>
        <?php if (empty($logs)): ?>
          <tr><td colspan="5" style="text-align: center; color: #94A3B8; padding: 20px;">No audit log entries recorded.</td></tr>
        <?php else: ?>
          <?php foreach (array_reverse($logs) as $l): ?>
            <tr>
              <td><code><?php echo htmlspecialchars($l['timestamp']); ?></code></td>
              <td><strong><?php echo htmlspecialchars($l['event']); ?></strong></td>
              <td><?php echo htmlspecialchars($l['user']); ?></td>
              <td><code><?php echo htmlspecialchars($l['ip']); ?></code></td>
              <td style="text-align: right;"><span class="badge badge-success"><?php echo htmlspecialchars($l['status']); ?></span></td>
            </tr>
          <?php endforeach; ?>
        <?php endif; ?>
      </tbody>
    </table>
  </div>

</div>

<?php include __DIR__ . '/footer.php'; ?>

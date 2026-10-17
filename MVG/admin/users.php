<?php
/**
 * MVG Power Solutions — Admin User Management
 */

require_once __DIR__ . '/../config/constants.php';
require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../config/settings.php';
require_once __DIR__ . '/auth.php';

$adminTitle = 'User Management';
$adminHeading = 'Administrator Accounts & Access Control';

$usersFile = __DIR__ . '/../data/admin_users.json';
$defaultUsers = [
    [
        'id'        => 1,
        'username'  => 'admin',
        'email'     => 'admin@mvgpowersolutions.com',
        'full_name' => 'MVG Chief Administrator',
        'role'      => 'Super Admin',
        'status'    => 'Active',
        'last_login'=> date('Y-m-d H:i')
    ]
];

$users = file_exists($usersFile) ? (json_decode(file_get_contents($usersFile), true) ?: $defaultUsers) : $defaultUsers;

$notice = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = $_POST['action'] ?? 'add';

    if ($action === 'add') {
        $username = trim($_POST['username'] ?? '');
        $email = trim($_POST['email'] ?? '');
        $name = trim($_POST['full_name'] ?? '');
        $role = trim($_POST['role'] ?? 'Administrator');

        if (!empty($username) && !empty($email)) {
            $users[] = [
                'id'        => time(),
                'username'  => $username,
                'email'     => $email,
                'full_name' => $name ?: $username,
                'role'      => $role,
                'status'    => 'Active',
                'last_login'=> 'Never'
            ];
            file_put_contents($usersFile, json_encode($users, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES));
            $notice = '✓ Administrator account created successfully!';
        }
    } elseif ($action === 'toggle_status') {
        $uid = intval($_POST['user_id'] ?? 0);
        foreach ($users as &$u) {
            if ($u['id'] == $uid && $u['username'] !== 'admin') {
                $u['status'] = ($u['status'] === 'Active') ? 'Deactivated' : 'Active';
                break;
            }
        }
        file_put_contents($usersFile, json_encode($users, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES));
        $notice = '✓ User account status updated.';
    }
}

include __DIR__ . '/header.php';
?>

<div style="display: grid; grid-template-columns: 340px 1fr; gap: 24px; align-items: start;">

  <!-- Add User Card -->
  <div class="card">
    <div class="card-header">
      <h2 class="card-title">+ Create Admin User</h2>
    </div>

    <?php if (!empty($notice)): ?>
      <div style="background: #F0FDF4; border-left: 4px solid var(--green); color: #166534; padding: 10px 14px; font-size: 13px; border-radius: 6px; margin-bottom: 16px;">
        <?php echo $notice; ?>
      </div>
    <?php endif; ?>

    <form method="POST" action="">
      <input type="hidden" name="action" value="add">

      <div class="form-group">
        <label>Full Name *</label>
        <input type="text" name="full_name" class="form-control" placeholder="e.g. Rajesh Sharma" required>
      </div>

      <div class="form-group">
        <label>Username *</label>
        <input type="text" name="username" class="form-control" placeholder="e.g. rajesh.sharma" required>
      </div>

      <div class="form-group">
        <label>Corporate Email *</label>
        <input type="email" name="email" class="form-control" placeholder="e.g. rajesh@mvgpowersolutions.com" required>
      </div>

      <div class="form-group">
        <label>Role &amp; Permissions</label>
        <select name="role" class="form-control">
          <option value="Super Admin">Super Admin (Full Access)</option>
          <option value="Administrator" selected>Administrator</option>
          <option value="Product Manager">Product Manager</option>
          <option value="Content Editor">Content Editor</option>
          <option value="SEO Manager">SEO Manager</option>
        </select>
      </div>

      <div class="form-group">
        <label>Temporary Password</label>
        <input type="password" name="password" class="form-control" placeholder="••••••••" required>
      </div>

      <button type="submit" class="btn-topbar btn-topbar-primary" style="width: 100%; justify-content: center; padding: 11px;">
        + Create Account
      </button>
    </form>
  </div>

  <!-- Users Table -->
  <div class="card">
    <div class="card-header">
      <h2 class="card-title">Authorized Administrators (<?php echo count($users); ?>)</h2>
      <a href="roles.php" class="btn-topbar">View Roles &amp; Permissions &rarr;</a>
    </div>

    <table class="data-table">
      <thead>
        <tr>
          <th>User</th>
          <th>Role</th>
          <th>Status</th>
          <th>Last Login</th>
          <th style="text-align: right;">Action</th>
        </tr>
      </thead>
      <tbody>
        <?php foreach ($users as $u): ?>
          <tr>
            <td>
              <strong style="color: var(--navy);"><?php echo htmlspecialchars($u['full_name']); ?></strong>
              <span style="display: block; font-size: 11px; color: var(--text-muted);"><?php echo htmlspecialchars($u['email']); ?></span>
            </td>
            <td><span class="badge badge-info"><?php echo htmlspecialchars($u['role']); ?></span></td>
            <td>
              <span class="badge <?php echo ($u['status'] === 'Active') ? 'badge-success' : 'badge-danger'; ?>">
                <?php echo htmlspecialchars($u['status']); ?>
              </span>
            </td>
            <td style="font-size: 12px; color: var(--text-muted);"><?php echo htmlspecialchars($u['last_login'] ?? 'Never'); ?></td>
            <td style="text-align: right;">
              <?php if ($u['username'] !== 'admin'): ?>
                <form method="POST" action="" style="display: inline;">
                  <input type="hidden" name="action" value="toggle_status">
                  <input type="hidden" name="user_id" value="<?php echo $u['id']; ?>">
                  <button type="submit" class="btn-topbar" style="padding: 3px 8px; font-size: 11px;">
                    <?php echo ($u['status'] === 'Active') ? 'Deactivate' : 'Activate'; ?>
                  </button>
                </form>
              <?php else: ?>
                <span style="font-size: 11px; color: var(--text-muted);">Root</span>
              <?php endif; ?>
            </td>
          </tr>
        <?php endforeach; ?>
      </tbody>
    </table>
  </div>

</div>

<?php include __DIR__ . '/footer.php'; ?>

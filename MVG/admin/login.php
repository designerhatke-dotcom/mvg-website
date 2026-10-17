<?php
/**
 * MVG Power Solutions — Admin Login
 */

if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

require_once __DIR__ . '/../config/constants.php';
require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/auth.php';

if (isAdminLoggedIn()) {
    header('Location: index.php');
    exit;
}

$error = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = trim($_POST['username'] ?? '');
    $password = trim($_POST['password'] ?? '');

    if (empty($username) || empty($password)) {
        $error = 'Please enter both username and password.';
    } else {
        $pdo = Database::getConnection();
        $authenticated = false;

        // Try MySQL first
        if ($pdo) {
            try {
                $stmt = $pdo->prepare("SELECT * FROM admins WHERE username = ? OR email = ? LIMIT 1");
                $stmt->execute([$username, $username]);
                $user = $stmt->fetch();
                if ($user && (password_verify($password, $user['password_hash']) || ($username === 'admin' && $password === 'admin123'))) {
                    $_SESSION['mvg_admin_id'] = $user['id'];
                    $_SESSION['mvg_admin_user'] = $user['username'];
                    $_SESSION['mvg_admin_name'] = $user['full_name'];
                    $_SESSION['mvg_admin_role'] = $user['role'];
                    $_SESSION['mvg_admin_logged'] = true;
                    $authenticated = true;
                }
            } catch (Exception $e) {
                // Fallback to default
            }
        }

        // Default fallback if database not seeded yet
        if (!$authenticated && $username === 'admin' && $password === 'admin123') {
            $_SESSION['mvg_admin_id'] = 1;
            $_SESSION['mvg_admin_user'] = 'admin';
            $_SESSION['mvg_admin_name'] = 'MVG Administrator';
            $_SESSION['mvg_admin_role'] = 'super_admin';
            $_SESSION['mvg_admin_logged'] = true;
            $authenticated = true;
        }

        if ($authenticated) {
            header('Location: index.php');
            exit;
        } else {
            $error = 'Invalid username or password. Default is: admin / admin123';
        }
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Login — <?php echo SITE_NAME; ?></title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
  <style>
    * { box-sizing: border-box; }
    body {
      background: #0B1329;
      color: #F8FAFC;
      font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
      margin: 0;
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 20px;
    }
    .login-card {
      background: #151F38;
      border: 1px solid #243256;
      border-radius: 16px;
      padding: 40px 36px;
      width: 100%;
      max-width: 420px;
      box-shadow: 0 20px 50px rgba(0, 0, 0, 0.4);
    }
    .brand-header {
      text-align: center;
      margin-bottom: 28px;
    }
    .logo-badge {
      display: inline-flex;
      align-items: center;
      justify-content: center;
      width: 56px;
      height: 56px;
      background: #0284C7;
      border-radius: 14px;
      color: #fff;
      font-weight: 900;
      font-size: 20px;
      letter-spacing: 1px;
      margin-bottom: 14px;
    }
    h1 {
      font-size: 20px;
      font-weight: 800;
      margin: 0 0 6px 0;
      color: #fff;
    }
    .subtext {
      font-size: 13.5px;
      color: #94A3B8;
      margin: 0;
    }
    .form-group {
      margin-bottom: 18px;
    }
    label {
      display: block;
      font-size: 12.5px;
      font-weight: 600;
      color: #CBD5E1;
      margin-bottom: 6px;
    }
    .input-field {
      width: 100%;
      padding: 12px 14px;
      background: #0B1329;
      border: 1px solid #334155;
      border-radius: 8px;
      font-family: inherit;
      font-size: 14px;
      color: #fff;
      transition: border 0.15s;
    }
    .input-field:focus {
      outline: none;
      border-color: #38BDF8;
      box-shadow: 0 0 0 3px rgba(56, 189, 248, 0.2);
    }
    .btn-submit {
      width: 100%;
      padding: 12px;
      background: #0284C7;
      color: #fff;
      border: none;
      border-radius: 8px;
      font-size: 14.5px;
      font-weight: 700;
      cursor: pointer;
      transition: background 0.15s;
      margin-top: 8px;
    }
    .btn-submit:hover {
      background: #0369A1;
    }
    .error-msg {
      background: #7F1D1D;
      color: #FECACA;
      padding: 10px 14px;
      border-radius: 8px;
      font-size: 13px;
      margin-bottom: 18px;
      border-left: 4px solid #EF4444;
    }
    .login-hint {
      margin-top: 20px;
      padding-top: 16px;
      border-top: 1px solid #243256;
      font-size: 12px;
      color: #94A3B8;
      text-align: center;
    }
    .login-hint code {
      color: #38BDF8;
      background: #0B1329;
      padding: 2px 6px;
      border-radius: 4px;
    }
  </style>
</head>
<body>

  <div class="login-card">
    <div class="brand-header">
      <div class="logo-badge">MVG</div>
      <h1>MVG Control Panel</h1>
      <p class="subtext">Industrial CT &amp; Power Solutions</p>
    </div>

    <?php if (!empty($error)): ?>
      <div class="error-msg"><?php echo htmlspecialchars($error); ?></div>
    <?php endif; ?>

    <form method="POST" action="login.php">
      <div class="form-group">
        <label for="username">Username or Email</label>
        <input type="text" id="username" name="username" class="input-field" value="admin" required autofocus />
      </div>

      <div class="form-group">
        <label for="password">Password</label>
        <input type="password" id="password" name="password" class="input-field" value="admin123" required />
      </div>

      <button type="submit" class="btn-submit">Sign In to Dashboard &rarr;</button>
    </form>

    <div class="login-hint">
      Default credentials: <code>admin</code> / <code>admin123</code>
    </div>
  </div>

</body>
</html>

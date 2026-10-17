<?php
/**
 * MVG Power Solutions — Admin Shared Header & Navigation
 */

require_once __DIR__ . '/auth.php';
require_once __DIR__ . '/../config/settings.php';
requireAdminAuth();

$currentAdmin = getLoggedInAdmin();
$activePage = basename($_SERVER['PHP_SELF'], '.php');
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title><?php echo $adminTitle ?? 'Admin Dashboard'; ?> — <?php echo Settings::get('general.site_name', SITE_NAME); ?></title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
  <style>
    :root {
      --sidebar-w: 260px;
      --navy: #0F172A;
      --navy-light: #1E293B;
      --border: #E2E8F0;
      --border-dark: #334155;
      --primary: #0284C7;
      --primary-hover: #0369A1;
      --text: #0F172A;
      --text-muted: #64748B;
      --bg: #F8FAFC;
      --white: #FFFFFF;
      --green: #10B981;
      --amber: #F59E0B;
      --red: #EF4444;
    }
    * { box-sizing: border-box; }
    body {
      margin: 0;
      font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
      background: var(--bg);
      color: var(--text);
      display: flex;
      min-height: 100vh;
    }

    /* Sidebar Navigation */
    .admin-sidebar {
      width: var(--sidebar-w);
      background: var(--navy);
      color: #fff;
      display: flex;
      flex-direction: column;
      position: fixed;
      top: 0;
      left: 0;
      bottom: 0;
      z-index: 100;
      border-right: 1px solid var(--border-dark);
    }
    .sidebar-brand {
      padding: 24px 20px;
      border-bottom: 1px solid var(--border-dark);
      display: flex;
      align-items: center;
      gap: 12px;
    }
    .brand-icon {
      width: 38px;
      height: 38px;
      background: var(--primary);
      border-radius: 8px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-weight: 900;
      font-size: 14px;
      color: #fff;
      letter-spacing: 0.5px;
    }
    .brand-text h2 {
      font-size: 15px;
      font-weight: 800;
      margin: 0;
      color: #fff;
    }
    .brand-text span {
      font-size: 11px;
      color: #94A3B8;
      text-transform: uppercase;
      letter-spacing: 0.5px;
    }

    .sidebar-menu {
      list-style: none;
      padding: 16px 12px;
      margin: 0;
      flex: 1;
      overflow-y: auto;
    }
    .menu-header {
      font-size: 11px;
      font-weight: 700;
      text-transform: uppercase;
      letter-spacing: 0.8px;
      color: #64748B;
      padding: 10px 10px 4px 10px;
      margin-top: 8px;
    }
    .menu-item a {
      display: flex;
      align-items: center;
      gap: 12px;
      padding: 10px 12px;
      color: #94A3B8;
      text-decoration: none;
      font-size: 13.5px;
      font-weight: 600;
      border-radius: 8px;
      transition: all 0.15s ease;
      margin-bottom: 2px;
    }
    .menu-item a:hover {
      background: var(--navy-light);
      color: #fff;
    }
    .menu-item.active a {
      background: var(--primary);
      color: #fff;
    }
    .menu-badge {
      margin-left: auto;
      font-size: 11px;
      font-weight: 700;
      padding: 2px 7px;
      border-radius: 12px;
      background: #0369A1;
      color: #fff;
    }

    .sidebar-footer {
      padding: 16px;
      border-top: 1px solid var(--border-dark);
      display: flex;
      align-items: center;
      justify-content: space-between;
      background: #0B1329;
    }
    .user-info {
      display: flex;
      align-items: center;
      gap: 10px;
    }
    .user-avatar {
      width: 32px;
      height: 32px;
      border-radius: 50%;
      background: var(--primary);
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 12px;
      font-weight: 800;
      color: #fff;
    }
    .user-meta {
      font-size: 12px;
      line-height: 1.2;
    }
    .user-meta strong {
      display: block;
      color: #fff;
    }
    .user-meta span {
      color: #94A3B8;
    }
    .logout-btn {
      color: #94A3B8;
      text-decoration: none;
      font-size: 13px;
    }
    .logout-btn:hover { color: var(--red); }

    /* Main Content Area */
    .admin-main {
      margin-left: var(--sidebar-w);
      flex: 1;
      min-width: 0;
      display: flex;
      flex-direction: column;
    }
    .admin-topbar {
      background: var(--white);
      border-bottom: 1px solid var(--border);
      padding: 14px 30px;
      display: flex;
      align-items: center;
      justify-content: space-between;
      position: sticky;
      top: 0;
      z-index: 90;
    }
    .topbar-title h1 {
      font-size: 18px;
      font-weight: 800;
      margin: 0;
      color: var(--text);
    }
    .topbar-actions {
      display: flex;
      align-items: center;
      gap: 12px;
    }
    .btn-topbar {
      display: inline-flex;
      align-items: center;
      gap: 6px;
      padding: 8px 14px;
      font-size: 13px;
      font-weight: 600;
      border-radius: 6px;
      text-decoration: none;
      border: 1px solid var(--border);
      background: #fff;
      color: var(--text);
      cursor: pointer;
    }
    .btn-topbar:hover { background: #F1F5F9; }
    .btn-topbar-primary {
      background: var(--primary);
      border-color: var(--primary);
      color: #fff;
    }
    .btn-topbar-primary:hover { background: var(--primary-hover); }

    .admin-content {
      padding: 30px;
      flex: 1;
    }

    /* Cards, Tables & Components */
    .stats-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
      gap: 20px;
      margin-bottom: 28px;
    }
    .stat-card {
      background: var(--white);
      border: 1px solid var(--border);
      border-radius: 12px;
      padding: 20px 22px;
      box-shadow: 0 2px 8px rgba(15, 23, 42, 0.03);
    }
    .stat-title {
      font-size: 12.5px;
      font-weight: 600;
      color: var(--text-muted);
      text-transform: uppercase;
      letter-spacing: 0.5px;
      margin-bottom: 8px;
    }
    .stat-value {
      font-size: 26px;
      font-weight: 800;
      color: var(--text);
      margin: 0 0 4px 0;
    }
    .stat-desc {
      font-size: 12px;
      color: var(--text-muted);
    }

    .card {
      background: var(--white);
      border: 1px solid var(--border);
      border-radius: 12px;
      padding: 24px;
      margin-bottom: 24px;
      box-shadow: 0 2px 8px rgba(15, 23, 42, 0.03);
    }
    .card-header {
      display: flex;
      align-items: center;
      justify-content: space-between;
      margin-bottom: 18px;
      padding-bottom: 14px;
      border-bottom: 1px solid var(--border);
      flex-wrap: wrap;
      gap: 12px;
    }
    .card-title {
      font-size: 16px;
      font-weight: 800;
      margin: 0;
    }

    .data-table {
      width: 100%;
      border-collapse: collapse;
    }
    .data-table th {
      text-align: left;
      font-size: 12px;
      font-weight: 700;
      text-transform: uppercase;
      letter-spacing: 0.5px;
      color: var(--text-muted);
      padding: 10px 14px;
      border-bottom: 2px solid var(--border);
      background: #FAFAFA;
    }
    .data-table td {
      padding: 12px 14px;
      border-bottom: 1px solid var(--border);
      font-size: 13.5px;
      vertical-align: middle;
    }
    .data-table tr:hover { background: #F8FAFC; }

    .badge {
      display: inline-block;
      padding: 3px 8px;
      border-radius: 12px;
      font-size: 11.5px;
      font-weight: 700;
    }
    .badge-success { background: #DCFCE7; color: #166534; }
    .badge-info { background: #E0F2FE; color: #0369A1; }
    .badge-warning { background: #FEF3C7; color: #92400E; }
    .badge-danger { background: #FEE2E2; color: #991B1B; }

    /* Form Styles */
    .form-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
      gap: 18px;
    }
    .form-group {
      margin-bottom: 16px;
    }
    .form-group label {
      display: block;
      font-size: 12.5px;
      font-weight: 600;
      color: #334155;
      margin-bottom: 6px;
    }
    .form-control {
      width: 100%;
      padding: 10px 12px;
      border: 1px solid var(--border);
      border-radius: 8px;
      font-family: inherit;
      font-size: 13.5px;
      color: var(--text);
    }
    .form-control:focus {
      outline: none;
      border-color: var(--primary);
      box-shadow: 0 0 0 3px rgba(2, 132, 199, 0.15);
    }
  </style>
</head>
<body>

  <!-- Sidebar -->
  <aside class="admin-sidebar">
    <div class="sidebar-brand">
      <div class="brand-icon">MVG</div>
      <div class="brand-text">
        <h2>MVG Control</h2>
        <span>Power Solutions</span>
      </div>
    </div>

    <ul class="sidebar-menu">
      <!-- OVERVIEW -->
      <li class="menu-header">OVERVIEW</li>
      <li class="menu-item <?php echo ($activePage === 'index') ? 'active' : ''; ?>">
        <a href="index.php">📊 Dashboard</a>
      </li>

      <!-- CATALOG & INVENTORY -->
      <li class="menu-header">CATALOG &amp; INVENTORY</li>
      <li class="menu-item <?php echo ($activePage === 'products') ? 'active' : ''; ?>">
        <a href="products.php">⚡ Products</a>
      </li>
      <li class="menu-item <?php echo ($activePage === 'product_form') ? 'active' : ''; ?>">
        <a href="product_form.php">➕ Add New Product</a>
      </li>
      <li class="menu-item <?php echo ($activePage === 'categories') ? 'active' : ''; ?>">
        <a href="categories.php">📁 Categories</a>
      </li>
      <li class="menu-item <?php echo ($activePage === 'categories' && isset($_GET['tab']) && $_GET['tab'] === 'subcategories') ? 'active' : ''; ?>">
        <a href="categories.php?tab=subcategories">↳ Subcategories</a>
      </li>
      <li class="menu-item <?php echo ($activePage === 'brands') ? 'active' : ''; ?>">
        <a href="brands.php">🏷️ Brands</a>
      </li>
      <li class="menu-item <?php echo ($activePage === 'specifications') ? 'active' : ''; ?>">
        <a href="specifications.php">📐 Product Specifications</a>
      </li>
      <li class="menu-item <?php echo ($activePage === 'products_import_export') ? 'active' : ''; ?>">
        <a href="products_import_export.php">📦 Bulk Import / Export</a>
      </li>

      <!-- WEBSITE MANAGEMENT -->
      <li class="menu-header">WEBSITE MANAGEMENT</li>
      <li class="menu-item <?php echo ($activePage === 'settings_general') ? 'active' : ''; ?>">
        <a href="settings_general.php">🌐 General Settings</a>
      </li>
      <li class="menu-item <?php echo ($activePage === 'header_navigation') ? 'active' : ''; ?>">
        <a href="header_navigation.php">🧭 Header &amp; Navigation</a>
      </li>
      <li class="menu-item <?php echo ($activePage === 'mega_menu') ? 'active' : ''; ?>">
        <a href="mega_menu.php">📑 Mega Menu Builder</a>
      </li>
      <li class="menu-item <?php echo ($activePage === 'settings_contact') ? 'active' : ''; ?>">
        <a href="settings_contact.php">🏢 Contact &amp; Business Details</a>
      </li>
      <li class="menu-item <?php echo ($activePage === 'social_media') ? 'active' : ''; ?>">
        <a href="social_media.php">🔗 Social Media Links</a>
      </li>

      <!-- MEDIA MANAGEMENT -->
      <li class="menu-header">MEDIA MANAGEMENT</li>
      <li class="menu-item <?php echo ($activePage === 'media') ? 'active' : ''; ?>">
        <a href="media.php">🖼️ Media Library</a>
      </li>
      <li class="menu-item <?php echo ($activePage === 'media_upload') ? 'active' : ''; ?>">
        <a href="media_upload.php">⬆️ Upload Images</a>
      </li>
      <li class="menu-item <?php echo ($activePage === 'image_seo') ? 'active' : ''; ?>">
        <a href="image_seo.php">🎯 Image SEO Manager</a>
      </li>
      <li class="menu-item <?php echo ($activePage === 'media_galleries') ? 'active' : ''; ?>">
        <a href="media_galleries.php">📸 Product Galleries</a>
      </li>
      <li class="menu-item <?php echo ($activePage === 'datasheets') ? 'active' : ''; ?>">
        <a href="datasheets.php">📑 Documents &amp; Datasheets</a>
      </li>

      <!-- SEO MANAGEMENT -->
      <li class="menu-header">SEO MANAGEMENT</li>
      <li class="menu-item <?php echo ($activePage === 'seo_settings') ? 'active' : ''; ?>">
        <a href="seo_settings.php">🚀 Global SEO Settings</a>
      </li>
      <li class="menu-item <?php echo ($activePage === 'seo_pages') ? 'active' : ''; ?>">
        <a href="seo_pages.php">📄 Page SEO</a>
      </li>
      <li class="menu-item <?php echo ($activePage === 'seo_products') ? 'active' : ''; ?>">
        <a href="seo_products.php">⚡ Product SEO</a>
      </li>
      <li class="menu-item <?php echo ($activePage === 'seo_categories') ? 'active' : ''; ?>">
        <a href="seo_categories.php">📁 Category SEO</a>
      </li>
      <li class="menu-item <?php echo ($activePage === 'seo_sitemap') ? 'active' : ''; ?>">
        <a href="seo_sitemap.php">🗺️ XML Sitemap Settings</a>
      </li>
      <li class="menu-item <?php echo ($activePage === 'redirects') ? 'active' : ''; ?>">
        <a href="redirects.php">🔀 Redirect Manager</a>
      </li>
      <li class="menu-item <?php echo ($activePage === 'seo_robots') ? 'active' : ''; ?>">
        <a href="seo_robots.php">🤖 Robots.txt Settings</a>
      </li>
      <li class="menu-item <?php echo ($activePage === 'seo_schema') ? 'active' : ''; ?>">
        <a href="seo_schema.php">🏷️ Schema Markup</a>
      </li>

      <!-- DATABASE & SYSTEM -->
      <li class="menu-header">DATABASE &amp; SYSTEM</li>
      <li class="menu-item <?php echo ($activePage === 'database_mgmt') ? 'active' : ''; ?>">
        <a href="database_mgmt.php">🗄️ Database Management</a>
      </li>
      <li class="menu-item <?php echo ($activePage === 'backup_restore') ? 'active' : ''; ?>">
        <a href="backup_restore.php">💾 Backup &amp; Restore</a>
      </li>
      <li class="menu-item <?php echo ($activePage === 'integrations') ? 'active' : ''; ?>">
        <a href="integrations.php">🔌 Integrations</a>
      </li>
      <li class="menu-item <?php echo ($activePage === 'users') ? 'active' : ''; ?>">
        <a href="users.php">👥 User Management</a>
      </li>
      <li class="menu-item <?php echo ($activePage === 'roles') ? 'active' : ''; ?>">
        <a href="roles.php">🛡️ Roles &amp; Permissions</a>
      </li>
      <li class="menu-item <?php echo ($activePage === 'system_logs') ? 'active' : ''; ?>">
        <a href="system_logs.php">📋 System Logs</a>
      </li>
      <li class="menu-item <?php echo ($activePage === 'settings') ? 'active' : ''; ?>">
        <a href="settings.php">⚙️ Site Settings</a>
      </li>
    </ul>

    <div class="sidebar-footer">
      <div class="user-info">
        <div class="user-avatar">A</div>
        <div class="user-meta">
          <strong><?php echo htmlspecialchars($currentAdmin['name']); ?></strong>
          <span>Super Admin</span>
        </div>
      </div>
      <a href="logout.php" class="logout-btn" title="Sign out">Log out</a>
    </div>
  </aside>

  <!-- Main Content Wrapper -->
  <div class="admin-main">
    <div class="admin-topbar">
      <div class="topbar-title">
        <h1><?php echo $adminHeading ?? 'Dashboard'; ?></h1>
      </div>
      <div class="topbar-actions">
        <a href="../product.php" class="btn-topbar" target="_blank">
          View Website ↗
        </a>
        <a href="product_form.php" class="btn-topbar btn-topbar-primary">
          + Add Product
        </a>
      </div>
    </div>
    <div class="admin-content">

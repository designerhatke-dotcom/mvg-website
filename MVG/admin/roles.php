<?php
/**
 * MVG Power Solutions — Roles & Permissions Matrix
 */

require_once __DIR__ . '/../config/constants.php';
require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../config/settings.php';

$adminTitle = 'Roles & Permissions';
$adminHeading = 'User Roles & Access Permissions Matrix';

$roles = [
    'Super Admin' => [
        'desc' => 'Full unrestricted access to all catalog, media, settings, database, and system controls.',
        'permissions' => ['Catalog', 'Settings', 'Media', 'SEO', 'Database Backups', 'User Management', 'Logs']
    ],
    'Administrator' => [
        'desc' => 'Can manage products, categories, media, orders/inquiries, and website navigation.',
        'permissions' => ['Catalog', 'Settings', 'Media', 'SEO']
    ],
    'Product Manager' => [
        'desc' => 'Authorized to add, edit, and publish current transformers and technical specifications.',
        'permissions' => ['Catalog', 'Media', 'Product SEO']
    ],
    'Content Editor' => [
        'desc' => 'Can update descriptions, images, reviews, and blog/datasheet materials.',
        'permissions' => ['Media', 'Product Overviews']
    ],
    'SEO Manager' => [
        'desc' => 'Dedicated access to meta titles, descriptions, sitemaps, redirects, and robots.txt.',
        'permissions' => ['Global SEO', 'Product SEO', 'Redirects', 'Sitemap']
    ]
];

include __DIR__ . '/header.php';
?>

<div style="max-width: 960px; margin: 0 auto;">

  <div class="card">
    <div class="card-header">
      <div>
        <h2 class="card-title">🛡️ System Roles &amp; Granular Permissions</h2>
        <span style="font-size: 12px; color: var(--text-muted);">Defines privilege boundaries across administrators and staff accounts</span>
      </div>
      <a href="users.php" class="btn-topbar btn-topbar-primary">+ Manage Users &rarr;</a>
    </div>

    <div style="display: flex; flex-direction: column; gap: 16px;">
      <?php foreach ($roles as $roleName => $info): ?>
        <div style="padding: 18px; border: 1px solid var(--border); border-radius: 8px; background: #F8FAFC;">
          <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 6px;">
            <strong style="font-size: 15px; color: var(--navy);"><?php echo htmlspecialchars($roleName); ?></strong>
            <span class="badge badge-info" style="font-size: 11px;">Active Role</span>
          </div>
          <p style="font-size: 13px; color: var(--text-muted); margin: 0 0 12px 0;"><?php echo htmlspecialchars($info['desc']); ?></p>
          
          <div style="display: flex; gap: 8px; flex-wrap: wrap;">
            <?php foreach ($info['permissions'] as $perm): ?>
              <span style="font-size: 11px; background: #FFFFFF; border: 1px solid var(--border); color: #334155; padding: 3px 9px; border-radius: 4px; font-weight: 600;">
                ✓ <?php echo htmlspecialchars($perm); ?>
              </span>
            <?php endforeach; ?>
          </div>
        </div>
      <?php endforeach; ?>
    </div>
  </div>

</div>

<?php include __DIR__ . '/footer.php'; ?>

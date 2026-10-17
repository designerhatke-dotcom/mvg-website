<?php
/**
 * MVG Power Solutions — Admin Authentication Guard
 */

if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

require_once __DIR__ . '/../config/constants.php';
require_once __DIR__ . '/../config/db.php';

function isAdminLoggedIn() {
    return !empty($_SESSION['mvg_admin_id']) && !empty($_SESSION['mvg_admin_logged']);
}

function requireAdminAuth() {
    if (!isAdminLoggedIn()) {
        header('Location: login.php');
        exit;
    }
}

function getLoggedInAdmin() {
    return [
        'id' => $_SESSION['mvg_admin_id'] ?? 1,
        'username' => $_SESSION['mvg_admin_user'] ?? 'admin',
        'name' => $_SESSION['mvg_admin_name'] ?? 'MVG Administrator',
        'role' => $_SESSION['mvg_admin_role'] ?? 'super_admin'
    ];
}

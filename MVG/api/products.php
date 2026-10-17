<?php
/**
 * MVG Power Solutions — Product API Endpoint
 * Output: JSON response of current transformer products
 */

header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');

require_once __DIR__ . '/../config/db.php';

$category = $_GET['category'] ?? 'all';
$search = trim($_GET['q'] ?? '');

$products = Database::getProducts($category);

if ($search !== '') {
    $searchLower = strtolower($search);
    $products = array_filter($products, function($p) use ($searchLower) {
        return (stripos($p['name'], $searchLower) !== false) ||
               (stripos($p['sku'], $searchLower) !== false);
    });
    $products = array_values($products);
}

echo json_encode([
    'success' => true,
    'count'   => count($products),
    'data'    => $products
], JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES);

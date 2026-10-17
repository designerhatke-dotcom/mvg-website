<?php
/**
 * MVG Power Solutions — Database Connection & Data Provider
 * Provides PDO connection to MySQL with graceful JSON file fallback.
 */

require_once __DIR__ . '/constants.php';

class Database {
    private static $host = '127.0.0.1';
    private static $db   = 'mvg_db';
    private static $user = 'root';
    private static $pass = '';
    private static $charset = 'utf8mb4';
    private static $pdo = null;

    /**
     * Get active PDO connection if configured
     */
    public static function getConnection() {
        if (self::$pdo === null) {
            $dsn = "mysql:host=" . self::$host . ";dbname=" . self::$db . ";charset=" . self::$charset;
            $options = [
                PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                PDO::ATTR_EMULATE_PREPARES   => false,
            ];
            try {
                self::$pdo = new PDO($dsn, self::$user, self::$pass, $options);
            } catch (PDOException $e) {
                // Return null when MySQL is not configured yet
                self::$pdo = null;
            }
        }
        return self::$pdo;
    }

    /**
     * Fetch products from MySQL, falling back to data/products.json
     */
    public static function getProducts($category = null) {
        $pdo = self::getConnection();
        if ($pdo) {
            try {
                $sql = "SELECT * FROM products WHERE 1=1";
                $params = [];
                if ($category && $category !== 'all') {
                    $sql .= " AND category = ?";
                    $params[] = $category;
                }
                $stmt = $pdo->prepare($sql);
                $stmt->execute($params);
                $rows = $stmt->fetchAll();
                if ($rows) return $rows;
            } catch (Exception $e) {
                // Fall through to JSON provider
            }
        }

        // Local JSON provider fallback
        $jsonPath = __DIR__ . '/../data/products.json';
        if (file_exists($jsonPath)) {
            $raw = json_decode(file_get_contents($jsonPath), true);
            $clean = [];
            foreach ($raw as $p) {
                $cats = $p['categories'] ?? [];
                $catSlugs = array_column($cats, 'slug');
                $isSquare = in_array('encapsulated-square-ct', $catSlugs) || in_array('square-ct', $catSlugs);
                $primaryCat = $isSquare ? 'encapsulated-square-ct' : 'encapsulated-ring-ct';
                $primaryCatName = $isSquare ? 'Encapsulated Square CT' : 'Encapsulated Ring CT';

                if ($category && $category !== 'all' && $primaryCat !== $category) {
                    continue;
                }

                $images = $p['images'] ?? [];
                $imgUrl = !empty($images[0]['src']) ? $images[0]['src'] : 'assets/categories/encapsulated-ring-ct.jpg';
                $price = floatval($p['prices']['price'] ?? 28000) / 100;

                $clean[] = [
                    'id'           => $p['id'],
                    'name'         => $p['name'],
                    'sku'          => $p['sku'] ?? '',
                    'price'        => $price,
                    'category'     => $primaryCat,
                    'categoryName' => $primaryCatName,
                    'sub_category' => $p['sub_category'] ?? ($cats[1]['name'] ?? ''),
                    'image'        => $imgUrl,
                    'minQty'       => DEFAULT_MIN_QTY
                ];
            }
            return $clean;
        }

        return [];
    }

    /**
     * Get a single product by ID or slug with full specs and images
     */
    public static function getProductById($idOrSlug) {
        $jsonPath = __DIR__ . '/../data/products.json';
        if (!file_exists($jsonPath)) return null;

        $raw = json_decode(file_get_contents($jsonPath), true);
        if (!$raw) return null;

        foreach ($raw as $p) {
            if ($p['id'] == $idOrSlug || ($p['slug'] ?? '') === $idOrSlug) {
                $cats = $p['categories'] ?? [];
                $catSlugs = array_column($cats, 'slug');
                $isSquare = in_array('encapsulated-square-ct', $catSlugs) || in_array('square-ct', $catSlugs);
                $primaryCat = $isSquare ? 'encapsulated-square-ct' : 'encapsulated-ring-ct';
                $primaryCatName = $isSquare ? 'Encapsulated Square CT' : 'Encapsulated Ring CT';

                $images = [];
                if (!empty($p['images'])) {
                    foreach ($p['images'] as $img) {
                        if (!empty($img['src'])) {
                            $images[] = $img['src'];
                        }
                    }
                }
                if (empty($images)) {
                    $images[] = 'assets/categories/' . $primaryCat . '.jpg';
                }

                // Parse specifications from short_description
                $specs = [];
                if (!empty($p['short_description'])) {
                    preg_match_all('/<li><strong>(.*?):<\/strong>\s*(.*?)<\/li>/i', $p['short_description'], $matches, PREG_SET_ORDER);
                    foreach ($matches as $m) {
                        $key = trim(strip_tags($m[1]));
                        $val = trim(strip_tags($m[2]));
                        if ($key && $val) {
                            $specs[$key] = $val;
                        }
                    }
                }

                if (empty($specs)) {
                    $specs = [
                        'Primary Current'   => 'As specified',
                        'Secondary Current' => '5A (1A on request)',
                        'Accuracy Class'    => 'Class 1.0 (IS 2705)',
                        'Rated Burden'      => '5 VA – 15 VA',
                        'Rated Voltage'     => '0.72 kV (Test Voltage 3 kV)',
                        'Frequency'         => '50 / 60 Hz',
                        'Enclosure'         => 'Flame-retardant Polycarbonate'
                    ];
                }

                $price = floatval($p['prices']['price'] ?? 28000) / 100;
                $subCat = $p['sub_category'] ?? ($cats[1]['name'] ?? ($cats[1]['slug'] ?? ''));
                $imgMeta = $p['image_meta'] ?? [
                    'filename'    => basename($images[0] ?? 'product.jpg'),
                    'title'       => $p['images'][0]['name'] ?? $p['name'],
                    'alt'         => $p['images'][0]['alt'] ?? $p['name'],
                    'caption'     => $p['images'][0]['caption'] ?? '',
                    'description' => $p['images'][0]['description'] ?? ''
                ];

                return [
                    'id'                => $p['id'],
                    'name'              => $p['name'],
                    'slug'              => $p['slug'] ?? '',
                    'sku'               => $p['sku'] ?? 'MVG-CT-' . $p['id'],
                    'price'             => $price,
                    'category'          => $primaryCat,
                    'categoryName'      => $primaryCatName,
                    'sub_category'      => $subCat,
                    'image'             => $images[0],
                    'images'            => $images,
                    'image_meta'        => $imgMeta,
                    'short_description' => $p['short_description'] ?? '',
                    'description'       => $p['description'] ?? '',
                    'specs'             => $specs,
                    'minQty'            => DEFAULT_MIN_QTY
                ];
            }
        }

        return null;
    }

    /**
     * Get related products from same category
     */
    public static function getRelatedProducts($currentId, $category = null, $limit = 4) {
        $all = self::getProducts($category);
        $related = [];
        foreach ($all as $item) {
            if ($item['id'] != $currentId) {
                $related[] = $item;
                if (count($related) >= $limit) break;
            }
        }
        return $related;
    }
}

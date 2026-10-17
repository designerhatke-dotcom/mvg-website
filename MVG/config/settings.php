<?php
/**
 * MVG Power Solutions — Settings Manager
 * Provides unified get/set access to all website configurations,
 * synchronizing between MySQL `site_settings` table and `data/settings.json`.
 */

require_once __DIR__ . '/constants.php';
require_once __DIR__ . '/db.php';

class Settings {
    private static $cache = null;
    private static $jsonFile = __DIR__ . '/../data/settings.json';

    /**
     * Load all settings into cache
     */
    public static function load() {
        if (self::$cache !== null) {
            return self::$cache;
        }

        // 1. Start with JSON store
        $settings = [];
        if (file_exists(self::$jsonFile)) {
            $settings = json_decode(file_get_contents(self::$jsonFile), true) ?: [];
        }

        // 2. Overlay MySQL `site_settings` table if connected
        $pdo = Database::getConnection();
        if ($pdo) {
            try {
                $stmt = $pdo->query("SELECT setting_key, setting_val, setting_group FROM site_settings");
                $rows = $stmt->fetchAll();
                foreach ($rows as $r) {
                    $group = $r['setting_group'] ?: 'general';
                    $val = $r['setting_val'];
                    // Auto-decode JSON if applicable
                    $decoded = json_decode($val, true);
                    if ($decoded !== null && (is_array($decoded) || is_object($decoded))) {
                        $val = $decoded;
                    }
                    if (!isset($settings[$group])) {
                        $settings[$group] = [];
                    }
                    $settings[$group][$r['setting_key']] = $val;
                }
            } catch (Exception $e) {
                // Silently fallback to JSON
            }
        }

        self::$cache = $settings;
        return self::$cache;
    }

    /**
     * Get a specific setting value (e.g., Settings::get('general.site_name', 'MVG Power Solutions'))
     */
    public static function get($keyPath, $default = null) {
        $data = self::load();
        $parts = explode('.', $keyPath);
        $curr = $data;

        foreach ($parts as $p) {
            if (is_array($curr) && array_key_exists($p, $curr)) {
                $curr = $curr[$p];
            } else {
                return $default;
            }
        }

        return ($curr !== null) ? $curr : $default;
    }

    /**
     * Get an entire group of settings (e.g. Settings::getGroup('business'))
     */
    public static function getGroup($group) {
        $data = self::load();
        return $data[$group] ?? [];
    }

    /**
     * Set a specific setting or update a group
     */
    public static function set($keyPath, $value) {
        self::load();
        $parts = explode('.', $keyPath);
        
        if (count($parts) === 1) {
            self::$cache[$parts[0]] = $value;
        } elseif (count($parts) === 2) {
            $group = $parts[0];
            $key = $parts[1];
            if (!isset(self::$cache[$group]) || !is_array(self::$cache[$group])) {
                self::$cache[$group] = [];
            }
            self::$cache[$group][$key] = $value;

            // Also persist to MySQL if active
            $pdo = Database::getConnection();
            if ($pdo) {
                try {
                    $stmt = $pdo->prepare("
                        INSERT INTO site_settings (setting_key, setting_val, setting_group) 
                        VALUES (?, ?, ?) 
                        ON DUPLICATE KEY UPDATE setting_val = VALUES(setting_val), setting_group = VALUES(setting_group)
                    ");
                    $valStr = is_array($value) ? json_encode($value) : (string)$value;
                    $stmt->execute([$key, $valStr, $group]);
                } catch (Exception $e) {}
            }
        }

        // Always save to JSON file
        file_put_contents(self::$jsonFile, json_encode(self::$cache, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES));
        return true;
    }

    /**
     * Bulk save a group (e.g. Settings::saveGroup('general', $_POST))
     */
    public static function saveGroup($group, array $values) {
        self::load();
        if (!isset(self::$cache[$group]) || !is_array(self::$cache[$group])) {
            self::$cache[$group] = [];
        }

        $pdo = Database::getConnection();

        foreach ($values as $k => $v) {
            self::$cache[$group][$k] = $v;

            if ($pdo) {
                try {
                    $stmt = $pdo->prepare("
                        INSERT INTO site_settings (setting_key, setting_val, setting_group) 
                        VALUES (?, ?, ?) 
                        ON DUPLICATE KEY UPDATE setting_val = VALUES(setting_val), setting_group = VALUES(setting_group)
                    ");
                    $valStr = is_array($v) ? json_encode($v) : (string)$v;
                    $stmt->execute([$k, $valStr, $group]);
                } catch (Exception $e) {}
            }
        }

        file_put_contents(self::$jsonFile, json_encode(self::$cache, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES));
        return true;
    }
}

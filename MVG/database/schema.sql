-- ===================================================================
-- MVG Power Solutions — Complete Database Schema
-- Database: mvg_db
-- Compatibility: MySQL 5.7+ / MySQL 8.0+ / MariaDB 10.3+
-- ===================================================================

CREATE DATABASE IF NOT EXISTS `mvg_db` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `mvg_db`;

-- 1. Admin Users Table
CREATE TABLE IF NOT EXISTS `admins` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `username` VARCHAR(60) NOT NULL UNIQUE,
  `email` VARCHAR(120) NOT NULL UNIQUE,
  `password_hash` VARCHAR(255) NOT NULL,
  `full_name` VARCHAR(100) NOT NULL,
  `role` ENUM('super_admin', 'editor', 'viewer') DEFAULT 'super_admin',
  `last_login` DATETIME NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Default Admin User (admin / admin123)
-- Password hash generated with password_hash('admin123', PASSWORD_BCRYPT)
INSERT INTO `admins` (`id`, `username`, `email`, `password_hash`, `full_name`, `role`)
VALUES (1, 'admin', 'admin@mvgpowersolutions.com', '$2y$10$wS2Wb2Z21a711O8Z9r.2pOUvW9j6X2f.a8264mK9O3a8K13C8K94G', 'MVG Administrator', 'super_admin')
ON DUPLICATE KEY UPDATE `username` = `username`;

-- 2. Product Categories Table
CREATE TABLE IF NOT EXISTS `categories` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(120) NOT NULL,
  `slug` VARCHAR(120) NOT NULL UNIQUE,
  `description` TEXT NULL,
  `image` VARCHAR(255) DEFAULT 'assets/categories/encapsulated-ring-ct.jpg',
  `sort_order` INT DEFAULT 0,
  `status` ENUM('active', 'inactive') DEFAULT 'active',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `categories` (`id`, `name`, `slug`, `description`, `image`, `sort_order`, `status`) VALUES
(1, 'Encapsulated Ring CT', 'encapsulated-ring-ct', 'High-precision Class 1.0 & 0.5 round current transformers with fire-retardant casing for electrical panels.', 'assets/categories/encapsulated-ring-ct.jpg', 1, 'active'),
(2, 'Encapsulated Square CT', 'encapsulated-square-ct', 'Square window current transformers optimized for standard busbars with transparent terminal shrouds.', 'assets/categories/encapsulated-square-ct.jpg', 2, 'active'),
(3, 'Tape Wound CT', 'tape-wound-ct', 'High permeability tape wound CTs for standard industrial metering and control circuits.', 'assets/categories/tape-wound-ct.jpg', 3, 'active'),
(4, 'Custom Ratio CT', 'custom-ratio-ct', 'Custom engineered CTs with bespoke primary ratings, dual ratios, and special burden VA.', 'assets/categories/custom-ratio-ct.jpg', 4, 'active')
ON DUPLICATE KEY UPDATE `name` = VALUES(`name`);

-- 3. Products Table
CREATE TABLE IF NOT EXISTS `products` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `category_id` INT UNSIGNED NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `slug` VARCHAR(255) NOT NULL UNIQUE,
  `sku` VARCHAR(100) NOT NULL,
  `price` DECIMAL(10,2) NOT NULL DEFAULT 280.00,
  `sale_price` DECIMAL(10,2) NULL,
  `min_qty` INT UNSIGNED NOT NULL DEFAULT 10,
  `short_description` TEXT NULL,
  `description` LONGTEXT NULL,
  `featured_image` VARCHAR(255) NULL,
  `is_featured` TINYINT(1) DEFAULT 0,
  `status` ENUM('published', 'draft', 'archived') DEFAULT 'published',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`category_id`) REFERENCES `categories`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 4. Product Gallery Images Table
CREATE TABLE IF NOT EXISTS `product_images` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `product_id` INT UNSIGNED NOT NULL,
  `image_url` VARCHAR(255) NOT NULL,
  `alt_text` VARCHAR(255) NULL,
  `sort_order` INT DEFAULT 0,
  FOREIGN KEY (`product_id`) REFERENCES `products`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 5. Product Technical Specifications Table
CREATE TABLE IF NOT EXISTS `product_specs` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `product_id` INT UNSIGNED NOT NULL,
  `spec_key` VARCHAR(120) NOT NULL,
  `spec_val` VARCHAR(255) NOT NULL,
  `sort_order` INT DEFAULT 0,
  FOREIGN KEY (`product_id`) REFERENCES `products`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 6. RFQ / Bulk Inquiries Table
CREATE TABLE IF NOT EXISTS `inquiries` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `product_id` INT UNSIGNED NULL,
  `product_name` VARCHAR(255) NULL,
  `customer_name` VARCHAR(120) NOT NULL,
  `company_name` VARCHAR(150) NULL,
  `email` VARCHAR(120) NULL,
  `phone` VARCHAR(30) NOT NULL,
  `quantity` INT UNSIGNED DEFAULT 10,
  `city` VARCHAR(80) NULL,
  `notes` TEXT NULL,
  `status` ENUM('new', 'contacted', 'quoted', 'converted', 'closed') DEFAULT 'new',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`product_id`) REFERENCES `products`(`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 7. Verified Reviews Table
CREATE TABLE IF NOT EXISTS `reviews` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `author_name` VARCHAR(120) NOT NULL,
  `user_badge` VARCHAR(100) DEFAULT 'Google Customer',
  `rating` TINYINT UNSIGNED NOT NULL DEFAULT 5,
  `review_text` TEXT NOT NULL,
  `owner_reply` TEXT NULL,
  `review_date` VARCHAR(50) DEFAULT 'Recently',
  `source` VARCHAR(50) DEFAULT 'google',
  `status` ENUM('approved', 'pending', 'hidden') DEFAULT 'approved',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 8. Site Settings Key-Value Table
CREATE TABLE IF NOT EXISTS `site_settings` (
  `setting_key` VARCHAR(60) PRIMARY KEY,
  `setting_val` TEXT NULL,
  `setting_group` VARCHAR(50) DEFAULT 'general',
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `site_settings` (`setting_key`, `setting_val`, `setting_group`) VALUES
('site_name', 'MVG Power Solutions', 'general'),
('company_address', 'GROUND FLOOR, R-458, Block R, Mangolpuri, NEW DELHI, Delhi, 110083, India', 'general'),
('support_phone', '+91 99991 76722', 'contact'),
('whatsapp_number', '919999176722', 'contact'),
('support_email', 'sales@mvgpowersolutions.com', 'contact'),
('gstin', '07XXXXXXXXXX', 'company'),
('default_min_qty', '10', 'shop'),
('gst_percentage', '18', 'shop')
ON DUPLICATE KEY UPDATE `setting_val` = VALUES(`setting_val`);

-- ===================================================================
-- MVG Power Solutions — Complete B2B E-Commerce & Inquiry Database
-- Database: mvg_db
-- Compatibility: MySQL 5.7+ / MySQL 8.0+ / MariaDB 10.3+
-- Generated for full B2B E-Commerce Inquiry & Quotation Workflow
-- ===================================================================

SET FOREIGN_KEY_CHECKS = 0;
CREATE DATABASE IF NOT EXISTS `mvg_db` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `mvg_db`;

-- 1. Admins Table
DROP TABLE IF EXISTS `admins`;
CREATE TABLE `admins` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `username` VARCHAR(60) NOT NULL UNIQUE,
  `email` VARCHAR(120) NOT NULL UNIQUE,
  `password_hash` VARCHAR(255) NOT NULL,
  `full_name` VARCHAR(100) NOT NULL,
  `role` ENUM('super_admin', 'editor', 'sales_manager', 'engineer', 'viewer') DEFAULT 'super_admin',
  `last_login` DATETIME NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `admins` (`id`, `username`, `email`, `password_hash`, `full_name`, `role`) VALUES
(1, 'admin', 'admin@mvgpowersolutions.com', '$2y$10$wS2Wb2Z21a711O8Z9r.2pOUvW9j6X2f.a8264mK9O3a8K13C8K94G', 'MVG Master Administrator', 'super_admin'),
(2, 'sales', 'sales@mvgpowersolutions.com', '$2y$10$wS2Wb2Z21a711O8Z9r.2pOUvW9j6X2f.a8264mK9O3a8K13C8K94G', 'MVG B2B Sales Desk', 'sales_manager');

-- 2. Site Settings Key-Value Table
DROP TABLE IF EXISTS `site_settings`;
CREATE TABLE `site_settings` (
  `setting_key` VARCHAR(80) PRIMARY KEY,
  `setting_val` LONGTEXT NULL,
  `setting_group` VARCHAR(50) DEFAULT 'general',
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `site_settings` (`setting_key`, `setting_val`, `setting_group`) VALUES
('site_name', 'MVG Power Solutions', 'general'),
('legal_name', 'MVG Power Solutions Private Limited', 'general'),
('site_tagline', 'Precision Current Transformers & Energy Meters', 'general'),
('site_url', 'https://www.mvgpowersolutions.com/mvg', 'general'),
('company_address', 'GROUND FLOOR, R-458, Block R, Mangolpuri, NEW DELHI, Delhi, 110083, India', 'contact'),
('factory_address', 'Phase-1 Industrial Area, Mangolpuri, New Delhi - 110083', 'contact'),
('support_phone', '+91 99991 76722', 'contact'),
('support_phone_tel', '+919999176722', 'contact'),
('alternate_phone', '+91 98112 00000', 'contact'),
('whatsapp_number', '919999176722', 'contact'),
('support_email', 'sales@mvgpowersolutions.com', 'contact'),
('technical_email', 'engineering@mvgpowersolutions.com', 'contact'),
('gstin', '07AAGCM1234F1Z8', 'company'),
('pan', 'AAGCM1234F', 'company'),
('business_type', 'Manufacturer & Wholesale Distributor', 'company'),
('currency', 'INR', 'shop'),
('currency_symbol', '₹', 'shop'),
('default_min_qty', '10', 'shop'),
('gst_percentage', '18', 'shop'),
('hsn_default', '85043100', 'shop'),
('meta_title', 'MVG Power Solutions | Industrial Current Transformers (IS 2705 / IEC 61869-2)', 'seo'),
('meta_description', 'Wholesale manufacturer of precision Class 1.0 & 0.5 Current Transformers in Delhi NCR. Encapsulated Square, Ring, Tape Wound, and Resin Cast CTs with 18% GST Input Tax Credit.', 'seo');

-- 3. Categories & Subcategories Table
DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `parent_id` INT UNSIGNED DEFAULT 0,
  `name` VARCHAR(150) NOT NULL,
  `slug` VARCHAR(150) NOT NULL UNIQUE,
  `description` TEXT NULL,
  `image` VARCHAR(255) DEFAULT 'assets/categories/encapsulated-ring-ct.jpg',
  `sort_order` INT DEFAULT 0,
  `status` ENUM('active', 'inactive') DEFAULT 'active',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX (`parent_id`),
  INDEX (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `categories` (`id`, `parent_id`, `name`, `slug`, `description`, `image`, `sort_order`, `status`) VALUES
(1, 0, 'Encapsulated Ring CT', 'encapsulated-ring-ct', 'High-precision Class 1.0 & 0.5 round current transformers with fire-retardant casing for electrical panels.', 'assets/categories/encapsulated-ring-ct.jpg', 1, 'active'),
(11, 1, '30mm Window CT', '30mm-window-ct', 'Compact 30mm aperture ring CT for feeder monitoring up to 400A.', 'assets/categories/encapsulated-ring-ct.jpg', 2, 'active'),
(12, 1, '45mm Window CT', '45mm-window-ct', 'Medium 45mm aperture ring CT for industrial LT distribution.', 'assets/categories/encapsulated-ring-ct.jpg', 3, 'active'),
(13, 1, '60mm Window CT', '60mm-window-ct', '60mm aperture ring CT for commercial sub-feeders up to 1000A.', 'assets/categories/encapsulated-ring-ct.jpg', 4, 'active'),
(14, 1, '85mm Window CT', '85mm-window-ct', '85mm aperture ring CT for heavy cable bundles up to 1600A.', 'assets/categories/encapsulated-ring-ct.jpg', 5, 'active'),
(15, 1, '115mm Window CT', '115mm-window-ct', 'Large 115mm aperture current transformers for main incomers up to 3200A.', 'assets/categories/encapsulated-ring-ct.jpg', 6, 'active'),
(2, 0, 'Encapsulated Square CT', 'encapsulated-square-ct', 'Square window current transformers optimized for standard busbars with transparent terminal shrouds.', 'assets/categories/encapsulated-square-ct.jpg', 7, 'active'),
(21, 2, '30x10mm Window CT', '30x10mm-window-ct', 'Square CT for single 30x10mm flat copper/aluminium busbars.', 'assets/categories/encapsulated-square-ct.jpg', 8, 'active'),
(22, 2, '50x12mm Window CT', '50x12mm-window-ct', 'Square CT for 50x10mm and 50x12mm busbars.', 'assets/categories/encapsulated-square-ct.jpg', 9, 'active'),
(23, 2, '80x20mm Window CT', '80x20mm-window-ct', 'Square window CT for large industrial power busbars up to 2500A.', 'assets/categories/encapsulated-square-ct.jpg', 10, 'active'),
(3, 0, 'Tape Wound CT', 'tape-wound-ct', 'High permeability tape wound CTs for standard industrial metering and control circuits.', 'assets/categories/tape-wound-ring-ct.jpg', 11, 'active'),
(4, 0, 'Resin Cast Rectangular CT', 'resin-cast-rectangular-ct', 'High insulation epoxy resin cast current transformers for high-fault LT panels and harsh environmental installations.', 'assets/categories/resin-cast-rectangular-ct.jpg', 12, 'active'),
(5, 0, 'Resin Cast Ring CT', 'resin-cast-ring-ct', 'Moisture and chemical resistant cast resin round CTs with superior dielectric withstand up to 3.3kV.', 'assets/categories/resin-cast-ring-ct.jpg', 13, 'active'),
(6, 0, 'Split Core CT', 'split-core-ct', 'Hinged split-core current transformers designed for non-intrusive retrofit installation without disconnecting busbars.', 'assets/categories/split-core-ct.jpg', 14, 'active'),
(7, 0, 'Custom Ratio CT', 'custom-ratio-ct', 'Custom engineered CTs with bespoke primary ratings, dual ratios, and special burden VA.', 'assets/categories/split-core-ct.jpg', 15, 'active');

-- 4. Brands Table
DROP TABLE IF EXISTS `brands`;
CREATE TABLE `brands` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(100) NOT NULL UNIQUE,
  `slug` VARCHAR(100) NOT NULL UNIQUE,
  `description` VARCHAR(255) NULL,
  `logo` VARCHAR(255) NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `brands` (`id`, `name`, `slug`, `description`) VALUES
(1, 'MVG Power Solutions', 'mvg-power-solutions', 'Original factory equipment with IS 2705 and IEC 61869-2 calibration compliance'),
(2, 'MVG OEM Custom', 'mvg-oem-custom', 'Custom-engineered transformers for specific switchboard builder layouts');

-- 5. Products Table (Inquiry & Catalog)
DROP TABLE IF EXISTS `products`;
CREATE TABLE `products` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `category_id` INT UNSIGNED NOT NULL,
  `subcategory_id` INT UNSIGNED NULL,
  `brand_id` INT UNSIGNED DEFAULT 1,
  `name` VARCHAR(255) NOT NULL,
  `slug` VARCHAR(255) NOT NULL UNIQUE,
  `sku` VARCHAR(100) NOT NULL,
  `price` DECIMAL(10,2) NOT NULL DEFAULT 280.00,
  `sale_price` DECIMAL(10,2) NULL,
  `min_qty` INT UNSIGNED NOT NULL DEFAULT 10,
  `hsn_code` VARCHAR(20) DEFAULT '85043100',
  `gst_rate` DECIMAL(5,2) DEFAULT 18.00,
  `stock_status` ENUM('in_stock', 'made_to_order', 'out_of_stock') DEFAULT 'in_stock',
  `lead_time_days` INT UNSIGNED DEFAULT 1,
  `short_description` TEXT NULL,
  `description` LONGTEXT NULL,
  `featured_image` VARCHAR(255) NULL,
  `is_featured` TINYINT(1) DEFAULT 0,
  `status` ENUM('published', 'draft', 'archived') DEFAULT 'published',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX (`category_id`),
  INDEX (`subcategory_id`),
  INDEX (`slug`),
  INDEX (`sku`),
  INDEX (`is_featured`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `products` (`id`, `category_id`, `subcategory_id`, `brand_id`, `name`, `slug`, `sku`, `price`, `sale_price`, `min_qty`, `hsn_code`, `gst_rate`, `stock_status`, `short_description`, `description`, `featured_image`, `is_featured`, `status`) VALUES
(258, 1, 60, 1, '2500/5A Ring Current Transformer 115mm CT | Class 1.0 Metering CT', '2500-5a-ring-current-transformer-115mm-ct', '17040-MVG-R-115-1-1-1-1-1', 280.00, 280.00, 10, '85043100', 18.00, 'in_stock', '<ul data-spread="false">
<li><strong>Primary Current:</strong> 2500A</li>
<li><strong>Secondary Current:</strong> 5A</li>
<li><strong>Current Ratio:</strong> 2500/5A</li>
<li><strong>Accuracy Class:</strong> Class 1.0</li>
<li><strong>Inner Diameter (ID):</strong> 115 mm</li>
<li><strong>Outer Diameter (OD):</strong> 170 mm</li>
<li><strong>Width:</strong> 40 mm</li>
<li><strong>VA Rating:</strong> 2.5–15 VA</li>
<li>Ring-type current transformer for compatible metering, current measurement, and monitoring applications</li>
</ul>', '<h2>Product Overview</h2>
<p>The <strong>2500/5A Ring Current Transformer 115mm CT</strong> is a Class 1.0 current transformer designed for compatible electrical current measurement, metering, monitoring, and power management applications. It features a <strong>2500A primary current</strong> and a <strong>5A secondary current</strong>, providing a 2500/5A current ratio for compatible meters, measuring instruments, and monitoring equipment.</p>
<p>This Ring Current Transformer features a <strong>115 mm inner diameter</strong>, providing a defined opening for compatible cables, conductors, or busbar arrangements. The CT has an <strong>outer diameter of 170 mm</strong> and a <strong>40 mm width</strong>, providing important physical dimensions to consider when planning installation in electrical panels, distribution equipment, and other suitable electrical systems.</p>
<p>The <strong>Class 1.0 accuracy</strong> specification makes this CT suitable for compatible metering and current measurement applications where the specified accuracy class is required. The <strong>2.5–15 VA rating</strong> provides a defined burden range for compatible secondary circuits and connected measuring equipment.</p>
<p>With a <strong>2500/5A current ratio</strong>, the transformer provides a 5A secondary output corresponding to the specified primary current. This makes it suitable for compatible electrical meters, monitoring equipment, energy measurement systems, and current measurement applications designed for a 5A CT secondary.</p>
<p>The <strong>115 mm internal opening</strong> should be checked against the actual cable, conductor, or busbar dimensions before installation. Users should also verify the current ratio, secondary rating, accuracy class, VA requirement, physical dimensions, and connected equipment compatibility before selecting the CT.</p>
<h2>Key Features</h2>
<p>The <strong>2500/5A Ring Current Transformer 115mm CT</strong> offers the following features:</p>
<ul>
<li>2500/5A current ratio</li>
<li>2500A primary current</li>
<li>5A secondary current</li>
<li>Class 1.0 accuracy</li>
<li>115 mm inner diameter</li>
<li>170 mm outer diameter</li>
<li>40 mm width</li>
<li>2.5–15 VA rating</li>
<li>Ring-type current transformer configuration</li>
<li>Suitable for compatible metering applications</li>
<li>Suitable for current measurement and monitoring</li>
<li>Suitable for compatible electrical panels</li>
<li>Large internal opening for compatible conductors and busbars</li>
</ul>
<h2>Technical Specifications</h2>
<table>
<thead>
<tr>
<th>Parameter</th>
<th>Specification</th>
</tr>
</thead>
<tbody>
<tr>
<td>Product Type</td>
<td>Current Transformer</td>
</tr>
<tr>
<td>CT Type</td>
<td>Ring Current Transformer</td>
</tr>
<tr>
<td>Primary Current</td>
<td>2500A</td>
</tr>
<tr>
<td>Secondary Current</td>
<td>5A</td>
</tr>
<tr>
<td>Current Ratio</td>
<td>2500/5A</td>
</tr>
<tr>
<td>Accuracy Class</td>
<td>Class 1.0</td>
</tr>
<tr>
<td>Inner Diameter (ID)</td>
<td>115 mm</td>
</tr>
<tr>
<td>Outer Diameter (OD)</td>
<td>170 mm</td>
</tr>
<tr>
<td>Width</td>
<td>40 mm</td>
</tr>
<tr>
<td>VA Rating</td>
<td>2.5–15 VA</td>
</tr>
<tr>
<td>Application</td>
<td>Metering &amp; Current Measurement</td>
</tr>
</tbody>
</table>
<h2>Applications</h2>
<p>The <strong>2500/5A Ring Current Transformer</strong> can be used for compatible electrical measurement, metering, monitoring, and power management applications, including:</p>
<ul>
<li>Energy metering systems</li>
<li>Electrical current measurement</li>
<li>Power monitoring systems</li>
<li>Electrical distribution panels</li>
<li>Electrical control panels</li>
<li>Metering panels</li>
<li>Industrial electrical installations</li>
<li>Current monitoring systems</li>
<li>Energy monitoring equipment</li>
<li>Electrical measurement systems</li>
<li>Distribution equipment</li>
<li>Compatible power management systems</li>
</ul>
<p>The CT should be selected according to the electrical requirements of the installation, including primary current, secondary current, accuracy class, burden, conductor dimensions, and available installation space.</p>
<h2>Why Choose a 2500/5A Class 1.0 Ring CT?</h2>
<p>The <strong>2500/5A Class 1.0 Ring Current Transformer</strong> combines a <strong>2500A primary current rating</strong> with a standard <strong>5A secondary output</strong> for compatible measurement and metering equipment.</p>
<p>Its <strong>115 mm inner diameter</strong> provides a defined opening for compatible cables, conductors, or busbar arrangements. The <strong>170 mm outer diameter and 40 mm width</strong> provide important physical dimensions for checking available panel space and installation requirements.</p>
<p>The <strong>Class 1.0 accuracy</strong> specification makes this CT suitable for compatible metering and current measurement applications requiring the specified accuracy class. Its <strong>2.5–15 VA rating</strong> provides a defined burden range for compatible secondary circuits.</p>
<p>For correct product selection, users should verify the required current ratio, primary current, secondary current, accuracy class, VA rating, inner diameter, outer diameter, width, and installation conditions before ordering.</p>
<h2>Benefits of 2500/5A Current Transformer</h2>
<h3>Class 1.0 Accuracy</h3>
<p>The specified Class 1.0 accuracy makes this CT suitable for compatible metering and current measurement applications where the specified accuracy class is required.</p>
<h3>2500A Primary Current</h3>
<p>The <strong>2500A primary rating</strong> makes this model suitable for compatible electrical systems requiring current measurement around a 2500A primary circuit.</p>
<h3>Standard 5A Secondary</h3>
<p>The 5A secondary output can be connected to compatible meters and measuring equipment designed for a 5A CT secondary.</p>
<h3>115mm Inner Diameter</h3>
<p>The <strong>115 mm ID</strong> provides a defined opening for compatible cables, conductors, and busbar arrangements. Actual conductor dimensions should always be checked before installation.</p>
<h3>Defined Installation Dimensions</h3>
<p>The <strong>170 mm outer diameter and 40 mm width</strong> provide clear physical dimensions that can be considered when planning electrical panel or equipment installation.</p>
<h3>Multiple Compatible Applications</h3>
<p>The CT can be considered for compatible energy metering, current measurement, electrical monitoring, distribution panels, control panels, and power monitoring systems.</p>
<h2>Installation Considerations</h2>
<p>Before installing the <strong>2500/5A Ring Current Transformer</strong>, verify:</p>
<ol>
<li>The primary circuit is compatible with the <strong>2500A primary rating</strong>.</li>
<li>The connected equipment requires a <strong>5A secondary output</strong>.</li>
<li>The required accuracy corresponds to <strong>Class 1.0</strong>.</li>
<li>The cable, conductor, or busbar can pass through the <strong>115 mm ID</strong>.</li>
<li>The available installation space accommodates the <strong>170 mm OD</strong>.</li>
<li>The available space accommodates the <strong>40 mm width</strong>.</li>
<li>The connected secondary circuit is compatible with the <strong>2.5–15 VA</strong> rating.</li>
<li>The CT and connected equipment are installed according to appropriate electrical installation procedures.</li>
</ol>
<p>Always verify the complete electrical and mechanical requirements before installation.</p>
<h2>Frequently Asked Questions</h2>
<h3>What is the current ratio of this CT?</h3>
<p>The current ratio is <strong>2500/5A</strong>, with a 2500A primary current and 5A secondary current.</p>
<h3>What is the primary current?</h3>
<p>The specified primary current is <strong>2500A</strong>.</p>
<h3>What is the secondary current?</h3>
<p>The secondary current is <strong>5A</strong>.</p>
<h3>What is the accuracy class?</h3>
<p>The 2500/5A Ring Current Transformer has a specified <strong>Class 1.0 accuracy class</strong>.</p>
<h3>What is the inner diameter of this Ring CT?</h3>
<p>The specified inner diameter is <strong>115 mm</strong>.</p>
<h3>What is the outer diameter?</h3>
<p>The specified outer diameter is <strong>170 mm</strong>.</p>
<h3>What is the width of the CT?</h3>
<p>The specified width is <strong>40 mm</strong>.</p>
<h3>What is the VA rating?</h3>
<p>The specified VA rating is <strong>2.5–15 VA</strong>.</p>
<h3>Where can a 2500/5A Ring Current Transformer be used?</h3>
<p>It can be used in compatible energy metering, current measurement, electrical monitoring, distribution panels, control panels, industrial electrical installations, and power monitoring systems.</p>
<h3>Can this CT be used with a 5A meter?</h3>
<p>The CT provides a <strong>5A secondary output</strong> and can be used with compatible meters and measuring equipment designed for a 5A CT secondary. Equipment compatibility should be verified before installation.</p>
<h3>What should I check before purchasing this CT?</h3>
<p>Check the required <strong>2500/5A ratio, Class 1.0 accuracy, 115 mm ID, 170 mm OD, 40 mm width, and 2.5–15 VA rating</strong>, along with the available installation space and connected equipment requirements.</p>
<h2>Shipping &amp; Bulk Orders</h2>
<p>MVG Power Solutions supplies Current Transformers for compatible electrical measurement, metering, and monitoring applications. Customers requiring multiple units can contact the team for bulk quantity requirements and quotations.</p>
<p>When requesting a quotation, mention the required <strong>2500/5A current ratio, Class 1.0 accuracy, 115 mm ID, 170 mm OD, 40 mm width, and 2.5–15 VA rating</strong> to help ensure the required specification is identified correctly.</p>
<p>Shipping charges and delivery timelines may vary depending on order quantity and delivery destination.</p>
<h2>Product Summary</h2>
<p>The <strong>2500/5A Ring Current Transformer 115mm CT</strong> is a <strong>Class 1.0</strong> current transformer featuring a <strong>2500A primary current, 5A secondary current, 115 mm inner diameter, 170 mm outer diameter, 40 mm width, and 2.5–15 VA rating</strong>.</p>
<p>It is suitable for compatible metering, current measurement, electrical monitoring, distribution, and power monitoring applications where these electrical and physical specifications meet the requirements of the installation.</p>', 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/2500-A.jpg', 1, 'published'),
(255, 1, 60, 1, '2000/5A Ring Current Transformer 115mm CT | Class 1.0 Metering CT', '2000-5a-ring-current-transformer-115mm-ct', '17040-MVG-R-115-1-1-1-1', 280.00, 280.00, 10, '85043100', 18.00, 'in_stock', '<ul>
<li><strong>Primary Current:</strong> 2000A</li>
<li><strong>Secondary Current:</strong> 5A</li>
<li><strong>Current Ratio:</strong> 2000/5A</li>
<li><strong>Accuracy Class:</strong> Class 1.0</li>
<li><strong>Inner Diameter (ID):</strong> 115 mm</li>
<li><strong>Outer Diameter (OD):</strong> 170 mm</li>
<li><strong>Width:</strong> 40 mm</li>
<li><strong>VA Rating:</strong> 2.5–15 VA</li>
<li>Ring-type current transformer for compatible metering, current measurement, and monitoring applications</li>
</ul>', '<h2>Product Overview</h2>
<p>The <strong>2000/5A Ring Current Transformer 115mm CT</strong> is a Class 1.0 current transformer designed for compatible electrical current measurement, metering, monitoring, and power management applications. It features a <strong>2000A primary current</strong> and a <strong>5A secondary current</strong>, providing a 2000/5A current ratio for compatible meters, measuring instruments, and monitoring equipment.</p>
<p>This Ring Current Transformer features a <strong>115 mm inner diameter</strong>, providing a defined opening for compatible cables, conductors, or busbar arrangements. The CT has an <strong>outer diameter of 170 mm</strong> and a <strong>40 mm width</strong>, giving users important physical dimensions to consider when planning installation inside electrical panels, distribution equipment, and other suitable electrical systems.</p>
<p>The <strong>Class 1.0 accuracy</strong> specification makes this CT suitable for compatible metering and current measurement applications where the specified accuracy class is required. The <strong>2.5–15 VA rating</strong> provides a defined burden range for compatible secondary circuits and connected measuring equipment.</p>
<p>With a <strong>2000/5A current ratio</strong>, the transformer provides a 5A secondary output corresponding to the specified primary current. This makes it suitable for compatible electrical meters, monitoring equipment, energy measurement systems, and current measurement applications designed for a 5A CT secondary.</p>
<p>The <strong>115 mm internal opening</strong> should be checked against the actual cable, conductor, or busbar dimensions before installation. Users should also verify the current ratio, secondary rating, accuracy class, VA requirement, physical dimensions, and connected equipment compatibility before selecting the CT.</p>
<h2>Key Features</h2>
<p>The <strong>2000/5A Ring Current Transformer 115mm CT</strong> offers the following features:</p>
<ul>
<li>2000/5A current ratio</li>
<li>2000A primary current</li>
<li>5A secondary current</li>
<li>Class 1.0 accuracy</li>
<li>115 mm inner diameter</li>
<li>170 mm outer diameter</li>
<li>40 mm width</li>
<li>2.5–15 VA rating</li>
<li>Ring-type current transformer configuration</li>
<li>Suitable for compatible metering applications</li>
<li>Suitable for current measurement and monitoring</li>
<li>Suitable for compatible electrical panels</li>
<li>Large internal opening for compatible conductors and busbars</li>
</ul>
<h2>Technical Specifications</h2>
<table>
<thead>
<tr>
<th>Parameter</th>
<th>Specification</th>
</tr>
</thead>
<tbody>
<tr>
<td>Product Type</td>
<td>Current Transformer</td>
</tr>
<tr>
<td>CT Type</td>
<td>Ring Current Transformer</td>
</tr>
<tr>
<td>Primary Current</td>
<td>2000A</td>
</tr>
<tr>
<td>Secondary Current</td>
<td>5A</td>
</tr>
<tr>
<td>Current Ratio</td>
<td>2000/5A</td>
</tr>
<tr>
<td>Accuracy Class</td>
<td>Class 1.0</td>
</tr>
<tr>
<td>Inner Diameter (ID)</td>
<td>115 mm</td>
</tr>
<tr>
<td>Outer Diameter (OD)</td>
<td>170 mm</td>
</tr>
<tr>
<td>Width</td>
<td>40 mm</td>
</tr>
<tr>
<td>VA Rating</td>
<td>2.5–15 VA</td>
</tr>
<tr>
<td>Application</td>
<td>Metering &amp; Current Measurement</td>
</tr>
</tbody>
</table>
<h2>Applications</h2>
<p>The <strong>2000/5A Ring Current Transformer</strong> can be used for compatible electrical measurement, metering, monitoring, and power management applications, including:</p>
<ul>
<li>Energy metering systems</li>
<li>Electrical current measurement</li>
<li>Power monitoring systems</li>
<li>Electrical distribution panels</li>
<li>Electrical control panels</li>
<li>Metering panels</li>
<li>Industrial electrical installations</li>
<li>Current monitoring systems</li>
<li>Energy monitoring equipment</li>
<li>Electrical measurement systems</li>
<li>Distribution equipment</li>
<li>Compatible power management systems</li>
</ul>
<p>The CT should be selected according to the electrical requirements of the installation, including primary current, secondary current, accuracy class, burden, conductor dimensions, and available installation space.</p>
<h2>Why Choose a 2000/5A Class 1.0 Ring CT?</h2>
<p>The <strong>2000/5A Class 1.0 Ring Current Transformer</strong> combines a <strong>2000A primary current rating</strong> with a standard <strong>5A secondary output</strong> for compatible measurement and metering equipment.</p>
<p>Its <strong>115 mm inner diameter</strong> provides a defined opening for compatible cables, conductors, or busbar arrangements. The <strong>170 mm outer diameter and 40 mm width</strong> provide important physical dimensions for checking available panel space and installation requirements.</p>
<p>The <strong>Class 1.0 accuracy</strong> specification makes this CT suitable for compatible metering and current measurement applications requiring the specified accuracy class. Its <strong>2.5–15 VA rating</strong> provides a defined burden range for compatible secondary circuits.</p>
<p>For correct product selection, users should verify the required current ratio, primary current, secondary current, accuracy class, VA rating, inner diameter, outer diameter, width, and installation conditions before ordering.</p>
<h2>Benefits of 2000/5A Current Transformer</h2>
<h3>Class 1.0 Accuracy</h3>
<p>The specified Class 1.0 accuracy makes this CT suitable for compatible metering and current measurement applications where the specified accuracy class is required.</p>
<h3>2000A Primary Current</h3>
<p>The <strong>2000A primary rating</strong> makes this model suitable for compatible electrical systems requiring current measurement around a 2000A primary circuit.</p>
<h3>Standard 5A Secondary</h3>
<p>The 5A secondary output can be connected to compatible meters and measuring equipment designed for a 5A CT secondary.</p>
<h3>115mm Inner Diameter</h3>
<p>The <strong>115 mm ID</strong> provides a defined opening for compatible cables, conductors, and busbar arrangements. Actual conductor dimensions should always be checked before installation.</p>
<h3>Defined Installation Dimensions</h3>
<p>The <strong>170 mm outer diameter and 40 mm width</strong> provide clear physical dimensions that can be considered when planning electrical panel or equipment installation.</p>
<h3>Multiple Compatible Applications</h3>
<p>The CT can be considered for compatible energy metering, current measurement, electrical monitoring, distribution panels, control panels, and power monitoring systems.</p>
<h2>Installation Considerations</h2>
<p>Before installing the <strong>2000/5A Ring Current Transformer</strong>, verify:</p>
<ol>
<li>The primary circuit is compatible with the <strong>2000A primary rating</strong>.</li>
<li>The connected equipment requires a <strong>5A secondary output</strong>.</li>
<li>The required accuracy corresponds to <strong>Class 1.0</strong>.</li>
<li>The cable, conductor, or busbar can pass through the <strong>115 mm ID</strong>.</li>
<li>The available installation space accommodates the <strong>170 mm OD</strong>.</li>
<li>The available space accommodates the <strong>40 mm width</strong>.</li>
<li>The connected secondary circuit is compatible with the <strong>2.5–15 VA</strong> rating.</li>
<li>The CT and connected equipment are installed according to appropriate electrical installation procedures.</li>
</ol>
<p>Always verify the complete electrical and mechanical requirements before installation.</p>
<h2>Frequently Asked Questions</h2>
<h3>What is the current ratio of this CT?</h3>
<p>The current ratio is <strong>2000/5A</strong>, with a 2000A primary current and 5A secondary current.</p>
<h3>What is the primary current?</h3>
<p>The specified primary current is <strong>2000A</strong>.</p>
<h3>What is the secondary current?</h3>
<p>The secondary current is <strong>5A</strong>.</p>
<h3>What is the accuracy class?</h3>
<p>The 2000/5A Ring Current Transformer has a specified <strong>Class 1.0 accuracy class</strong>.</p>
<h3>What is the inner diameter of this Ring CT?</h3>
<p>The specified inner diameter is <strong>115 mm</strong>.</p>
<h3>What is the outer diameter?</h3>
<p>The specified outer diameter is <strong>170 mm</strong>.</p>
<h3>What is the width of the CT?</h3>
<p>The specified width is <strong>40 mm</strong>.</p>
<h3>What is the VA rating?</h3>
<p>The specified VA rating is <strong>2.5–15 VA</strong>.</p>
<h3>Where can a 2000/5A Ring Current Transformer be used?</h3>
<p>It can be used in compatible energy metering, current measurement, electrical monitoring, distribution panels, control panels, industrial electrical installations, and power monitoring systems.</p>
<h3>Can this CT be used with a 5A meter?</h3>
<p>The CT provides a <strong>5A secondary output</strong> and can be used with compatible meters and measuring equipment designed for a 5A CT secondary. Equipment compatibility should be verified before installation.</p>
<h3>What should I check before purchasing this CT?</h3>
<p>Check the required <strong>2000/5A ratio, Class 1.0 accuracy, 115 mm ID, 170 mm OD, 40 mm width, and 2.5–15 VA rating</strong>, along with the available installation space and connected equipment requirements.</p>
<h2>Shipping &amp; Bulk Orders</h2>
<p>MVG Power Solutions supplies Current Transformers for compatible electrical measurement, metering, and monitoring applications. Customers requiring multiple units can contact the team for bulk quantity requirements and quotations.</p>
<p>When requesting a quotation, mention the required <strong>2000/5A current ratio, Class 1.0 accuracy, 115 mm ID, 170 mm OD, 40 mm width, and 2.5–15 VA rating</strong> to help ensure the required specification is identified correctly.</p>
<p>Shipping charges and delivery timelines may vary depending on order quantity and delivery destination.</p>
<h2>Product Summary</h2>
<p>The <strong>2000/5A Ring Current Transformer 115mm CT</strong> is a <strong>Class 1.0</strong> current transformer featuring a <strong>2000A primary current, 5A secondary current, 115 mm inner diameter, 170 mm outer diameter, 40 mm width, and 2.5–15 VA rating</strong>.</p>
<p>It is suitable for compatible metering, current measurement, electrical monitoring, distribution, and power monitoring applications where these electrical and physical specifications meet the requirements of the installation.</p>', 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/2000-A.jpg', 1, 'published'),
(252, 1, 60, 1, '1600/5A Ring Current Transformer 115mm CT | Class 1.0 Metering CT', '1600-5a-ring-current-transformer-115mm-ct', '17040-MVG-R-115-1-1-1', 280.00, 280.00, 10, '85043100', 18.00, 'in_stock', '<ul data-spread="false">
<li><strong>Primary Current:</strong> 1600A</li>
<li><strong>Secondary Current:</strong> 5A</li>
<li><strong>Current Ratio:</strong> 1600/5A</li>
<li><strong>Accuracy Class:</strong> Class 1.0</li>
<li><strong>Inner Diameter (ID):</strong> 115 mm</li>
<li><strong>Outer Diameter (OD):</strong> 170 mm</li>
<li><strong>Width:</strong> 40 mm</li>
<li><strong>VA Rating:</strong> 2.5–15 VA</li>
<li>Ring-type current transformer for compatible metering, current measurement, and monitoring applications</li>
</ul>', '<h2>Product Overview</h2>
<p>The <strong>1600/5A Ring Current Transformer 115mm CT</strong> is a Class 1.0 current transformer designed for compatible electrical current measurement, metering, monitoring, and power management applications. It features a <strong>1600A primary current</strong> and a <strong>5A secondary current</strong>, providing a 1600/5A current ratio for compatible meters, measuring instruments, and monitoring equipment.</p>
<p>This Ring Current Transformer features a <strong>115 mm inner diameter</strong>, providing a defined opening for compatible cables, conductors, or busbar arrangements. The CT has an <strong>outer diameter of 170 mm</strong> and a <strong>40 mm width</strong>, giving users important physical dimensions to consider when planning installation in electrical panels, distribution equipment, and other compatible electrical systems.</p>
<p>The <strong>Class 1.0 accuracy</strong> specification makes this CT suitable for compatible metering and current measurement applications where the specified accuracy class is required. The <strong>2.5–15 VA rating</strong> provides a defined burden range for compatible secondary circuits and connected measuring equipment.</p>
<p>With a <strong>1600/5A current ratio</strong>, this CT provides a 5A secondary output corresponding to the specified 1600A primary current. It can therefore be considered for compatible electrical meters, monitoring equipment, energy measurement systems, and current measurement applications designed for a 5A CT secondary.</p>
<p>The <strong>115 mm internal opening</strong> should be checked against the actual cable, conductor, or busbar dimensions before installation. Users should also verify the current ratio, secondary current, accuracy class, VA requirement, physical dimensions, and connected equipment compatibility before selecting this CT.</p>
<h2>Key Features</h2>
<p>The <strong>1600/5A Ring Current Transformer 115mm CT</strong> offers the following features:</p>
<ul>
<li>1600/5A current ratio</li>
<li>1600A primary current</li>
<li>5A secondary current</li>
<li>Class 1.0 accuracy</li>
<li>115 mm inner diameter</li>
<li>170 mm outer diameter</li>
<li>40 mm width</li>
<li>2.5–15 VA rating</li>
<li>Ring-type current transformer configuration</li>
<li>Suitable for compatible metering applications</li>
<li>Suitable for current measurement and monitoring</li>
<li>Suitable for compatible electrical panels</li>
<li>Large internal opening for compatible conductors and busbars</li>
</ul>
<h2>Technical Specifications</h2>
<table>
<thead>
<tr>
<th>Parameter</th>
<th>Specification</th>
</tr>
</thead>
<tbody>
<tr>
<td>Product Type</td>
<td>Current Transformer</td>
</tr>
<tr>
<td>CT Type</td>
<td>Ring Current Transformer</td>
</tr>
<tr>
<td>Primary Current</td>
<td>1600A</td>
</tr>
<tr>
<td>Secondary Current</td>
<td>5A</td>
</tr>
<tr>
<td>Current Ratio</td>
<td>1600/5A</td>
</tr>
<tr>
<td>Accuracy Class</td>
<td>Class 1.0</td>
</tr>
<tr>
<td>Inner Diameter (ID)</td>
<td>115 mm</td>
</tr>
<tr>
<td>Outer Diameter (OD)</td>
<td>170 mm</td>
</tr>
<tr>
<td>Width</td>
<td>40 mm</td>
</tr>
<tr>
<td>VA Rating</td>
<td>2.5–15 VA</td>
</tr>
<tr>
<td>Application</td>
<td>Metering &amp; Current Measurement</td>
</tr>
</tbody>
</table>
<h2>Applications</h2>
<p>The <strong>1600/5A Ring Current Transformer</strong> can be used for compatible electrical measurement, metering, monitoring, and power management applications, including:</p>
<ul>
<li>Energy metering systems</li>
<li>Electrical current measurement</li>
<li>Power monitoring systems</li>
<li>Electrical distribution panels</li>
<li>Electrical control panels</li>
<li>Metering panels</li>
<li>Industrial electrical installations</li>
<li>Current monitoring systems</li>
<li>Energy monitoring equipment</li>
<li>Electrical measurement systems</li>
<li>Distribution equipment</li>
<li>Compatible power management systems</li>
</ul>
<p>The CT should be selected according to the electrical requirements of the installation, including primary current, secondary current, accuracy class, burden, conductor dimensions, and available installation space.</p>
<h2>Why Choose a 1600/5A Class 1.0 Ring CT?</h2>
<p>The <strong>1600/5A Class 1.0 Ring Current Transformer</strong> combines a <strong>1600A primary current rating</strong> with a standard <strong>5A secondary output</strong> for compatible measurement and metering equipment.</p>
<p>Its <strong>115 mm inner diameter</strong> provides a defined opening for compatible cables, conductors, or busbar arrangements. The <strong>170 mm outer diameter and 40 mm width</strong> provide important physical dimensions for checking available panel space and installation requirements.</p>
<p>The <strong>Class 1.0 accuracy</strong> specification makes this CT suitable for compatible metering and current measurement applications requiring the specified accuracy class. Its <strong>2.5–15 VA rating</strong> provides a defined burden range for compatible secondary circuits.</p>
<p>For correct product selection, users should verify the required current ratio, primary current, secondary current, accuracy class, VA rating, inner diameter, outer diameter, width, and installation conditions before ordering.</p>
<h2>Benefits of 1600/5A Current Transformer</h2>
<h3>Class 1.0 Accuracy</h3>
<p>The specified Class 1.0 accuracy makes this CT suitable for compatible metering and current measurement applications where the specified accuracy class is required.</p>
<h3>1600A Primary Current</h3>
<p>The <strong>1600A primary rating</strong> makes this model suitable for compatible electrical systems requiring current measurement around a 1600A primary circuit.</p>
<h3>Standard 5A Secondary</h3>
<p>The 5A secondary output can be connected to compatible meters and measuring equipment designed for a 5A CT secondary.</p>
<h3>115mm Inner Diameter</h3>
<p>The <strong>115 mm ID</strong> provides a defined opening for compatible cables, conductors, and busbar arrangements. Actual conductor dimensions should always be checked before installation.</p>
<h3>Defined Installation Dimensions</h3>
<p>The <strong>170 mm outer diameter and 40 mm width</strong> provide clear physical dimensions that can be considered when planning electrical panel or equipment installation.</p>
<h3>Multiple Compatible Applications</h3>
<p>The CT can be considered for compatible energy metering, current measurement, electrical monitoring, distribution panels, control panels, and power monitoring systems.</p>
<h2>Installation Considerations</h2>
<p>Before installing the <strong>1600/5A Ring Current Transformer</strong>, verify:</p>
<ol>
<li>The primary circuit is compatible with the <strong>1600A primary rating</strong>.</li>
<li>The connected equipment requires a <strong>5A secondary output</strong>.</li>
<li>The required accuracy corresponds to <strong>Class 1.0</strong>.</li>
<li>The cable, conductor, or busbar can pass through the <strong>115 mm ID</strong>.</li>
<li>The available installation space accommodates the <strong>170 mm OD</strong>.</li>
<li>The available space accommodates the <strong>40 mm width</strong>.</li>
<li>The connected secondary circuit is compatible with the <strong>2.5–15 VA</strong> rating.</li>
<li>The CT and connected equipment are installed according to appropriate electrical installation procedures.</li>
</ol>
<p>Always verify the complete electrical and mechanical requirements before installation.</p>
<h2>Frequently Asked Questions</h2>
<h3>What is the current ratio of this CT?</h3>
<p>The current ratio is <strong>1600/5A</strong>, with a 1600A primary current and 5A secondary current.</p>
<h3>What is the primary current?</h3>
<p>The specified primary current is <strong>1600A</strong>.</p>
<h3>What is the secondary current?</h3>
<p>The secondary current is <strong>5A</strong>.</p>
<h3>What is the accuracy class?</h3>
<p>The 1600/5A Ring Current Transformer has a specified <strong>Class 1.0 accuracy class</strong>.</p>
<h3>What is the inner diameter of this Ring CT?</h3>
<p>The specified inner diameter is <strong>115 mm</strong>.</p>
<h3>What is the outer diameter?</h3>
<p>The specified outer diameter is <strong>170 mm</strong>.</p>
<h3>What is the width of the CT?</h3>
<p>The specified width is <strong>40 mm</strong>.</p>
<h3>What is the VA rating?</h3>
<p>The specified VA rating is <strong>2.5–15 VA</strong>.</p>
<h3>Where can a 1600/5A Ring Current Transformer be used?</h3>
<p>It can be used in compatible energy metering, current measurement, electrical monitoring, distribution panels, control panels, industrial electrical installations, and power monitoring systems.</p>
<h3>Can this CT be used with a 5A meter?</h3>
<p>The CT provides a <strong>5A secondary output</strong> and can be used with compatible meters and measuring equipment designed for a 5A CT secondary. Equipment compatibility should be verified before installation.</p>
<h3>What should I check before purchasing this CT?</h3>
<p>Check the required <strong>1600/5A ratio, Class 1.0 accuracy, 115 mm ID, 170 mm OD, 40 mm width, and 2.5–15 VA rating</strong>, along with available installation space and connected equipment requirements.</p>
<h2>Shipping &amp; Bulk Orders</h2>
<p>MVG Power Solutions supplies Current Transformers for compatible electrical measurement, metering, and monitoring applications. Customers requiring multiple units can contact the team for bulk quantity requirements and quotations.</p>
<p>When requesting a quotation, mention the required <strong>1600/5A current ratio, Class 1.0 accuracy, 115 mm ID, 170 mm OD, 40 mm width, and 2.5–15 VA rating</strong> to help ensure the required specification is identified correctly.</p>
<p>Shipping charges and delivery timelines may vary depending on order quantity and delivery destination.</p>
<h2>Product Summary</h2>
<p>The <strong>1600/5A Ring Current Transformer 115mm CT</strong> is a <strong>Class 1.0</strong> current transformer featuring a <strong>1600A primary current, 5A secondary current, 115 mm inner diameter, 170 mm outer diameter, 40 mm width, and 2.5–15 VA rating</strong>.</p>
<p>It is suitable for compatible metering, current measurement, electrical monitoring, distribution, and power monitoring applications where these electrical and physical specifications meet the requirements of the installation.</p>', 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/1600-A.jpg', 1, 'published'),
(249, 1, 60, 1, '1200/5A Ring Current Transformer 115mm CT | Class 1.0 Metering CT', '1200-5a-ring-current-transformer-115mm-ct', '17040-MVG-R-115-1-1', 280.00, 280.00, 10, '85043100', 18.00, 'in_stock', '<ul>
<li><strong>Primary Current:</strong> 1200A</li>
<li><strong>Secondary Current:</strong> 5A</li>
<li><strong>Current Ratio:</strong> 1200/5A</li>
<li><strong>Accuracy Class:</strong> Class 1.0</li>
<li><strong>Inner Diameter (ID):</strong> 115 mm</li>
<li><strong>Outer Diameter (OD):</strong> 170 mm</li>
<li><strong>Width:</strong> 40 mm</li>
<li><strong>VA Rating:</strong> 2.5–15 VA</li>
<li>Ring-type current transformer for compatible metering, current measurement, and monitoring applications</li>
</ul>', '<h2>Product Overview</h2>
<p>The <strong>1200/5A Ring Current Transformer 115mm CT</strong> is a Class 1.0 current transformer designed for compatible electrical current measurement, metering, monitoring, and power management applications. It features a <strong>1200A primary current</strong> and a <strong>5A secondary current</strong>, providing a 1200/5A current ratio for compatible meters, measuring instruments, and monitoring equipment.</p>
<p>This Ring Current Transformer features a <strong>115 mm inner diameter</strong>, providing a defined opening for compatible cables, conductors, or busbar arrangements. The CT has an <strong>outer diameter of 170 mm</strong> and a <strong>40 mm width</strong>, allowing users to consider the required physical space when planning installation inside electrical panels, distribution equipment, and other suitable electrical systems.</p>
<p>The <strong>Class 1.0 accuracy</strong> makes this CT suitable for compatible metering and current measurement applications where the specified accuracy class is required. The <strong>2.5–15 VA rating</strong> provides a defined burden range for compatible secondary circuits and connected measuring equipment.</p>
<p>With a <strong>1200/5A current ratio</strong>, the transformer provides a 5A secondary output corresponding to the specified primary current. This makes it suitable for compatible electrical meters, monitoring equipment, energy measurement systems, and current measurement applications designed for a 5A CT secondary.</p>
<p>The <strong>115 mm internal opening</strong> should be checked against the actual cable, conductor, or busbar dimensions before installation. Users should also verify the current ratio, secondary rating, accuracy class, VA requirement, physical dimensions, and connected equipment compatibility before selecting the CT.</p>
<h2>Key Features</h2>
<p>The <strong>1200/5A Ring Current Transformer 115mm CT</strong> offers the following features:</p>
<ul>
<li>1200/5A current ratio</li>
<li>1200A primary current</li>
<li>5A secondary current</li>
<li>Class 1.0 accuracy</li>
<li>115 mm inner diameter</li>
<li>170 mm outer diameter</li>
<li>40 mm width</li>
<li>2.5–15 VA rating</li>
<li>Ring-type current transformer configuration</li>
<li>Suitable for compatible metering applications</li>
<li>Suitable for current measurement and monitoring</li>
<li>Suitable for compatible electrical panels</li>
<li>Large internal opening for compatible conductors and busbars</li>
</ul>
<h2>Technical Specifications</h2>
<table>
<thead>
<tr>
<th>Parameter</th>
<th>Specification</th>
</tr>
</thead>
<tbody>
<tr>
<td>Product Type</td>
<td>Current Transformer</td>
</tr>
<tr>
<td>CT Type</td>
<td>Ring Current Transformer</td>
</tr>
<tr>
<td>Primary Current</td>
<td>1200A</td>
</tr>
<tr>
<td>Secondary Current</td>
<td>5A</td>
</tr>
<tr>
<td>Current Ratio</td>
<td>1200/5A</td>
</tr>
<tr>
<td>Accuracy Class</td>
<td>Class 1.0</td>
</tr>
<tr>
<td>Inner Diameter (ID)</td>
<td>115 mm</td>
</tr>
<tr>
<td>Outer Diameter (OD)</td>
<td>170 mm</td>
</tr>
<tr>
<td>Width</td>
<td>40 mm</td>
</tr>
<tr>
<td>VA Rating</td>
<td>2.5–15 VA</td>
</tr>
<tr>
<td>Application</td>
<td>Metering &amp; Current Measurement</td>
</tr>
</tbody>
</table>
<h2>Applications</h2>
<p>The <strong>1200/5A Ring Current Transformer</strong> can be used for compatible electrical measurement, metering, monitoring, and power management applications, including:</p>
<ul>
<li>Energy metering systems</li>
<li>Electrical current measurement</li>
<li>Power monitoring systems</li>
<li>Electrical distribution panels</li>
<li>Electrical control panels</li>
<li>Metering panels</li>
<li>Industrial electrical installations</li>
<li>Current monitoring systems</li>
<li>Energy monitoring equipment</li>
<li>Electrical measurement systems</li>
<li>Distribution equipment</li>
<li>Compatible power management systems</li>
</ul>
<p>The CT should be selected according to the electrical requirements of the installation, including primary current, secondary current, accuracy class, burden, conductor dimensions, and available installation space.</p>
<h2>Why Choose a 1200/5A Class 1.0 Ring CT?</h2>
<p>The <strong>1200/5A Class 1.0 Ring Current Transformer</strong> combines a <strong>1200A primary current rating</strong> with a standard <strong>5A secondary output</strong> for compatible measurement and metering equipment.</p>
<p>Its <strong>115 mm inner diameter</strong> provides a defined opening for compatible cables, conductors, or busbar arrangements. The <strong>170 mm outer diameter and 40 mm width</strong> provide important physical dimensions for checking panel space and installation requirements.</p>
<p>The <strong>Class 1.0 accuracy</strong> makes this CT suitable for compatible metering and current measurement applications requiring the specified accuracy class. Its <strong>2.5–15 VA rating</strong> provides a defined burden range for compatible secondary circuits.</p>
<p>For correct product selection, users should verify the required current ratio, primary current, secondary current, accuracy class, VA rating, inner diameter, outer diameter, width, and installation conditions before ordering.</p>
<h2>Benefits of 1200/5A Current Transformer</h2>
<h3>Class 1.0 Accuracy</h3>
<p>The specified Class 1.0 accuracy makes this CT suitable for compatible metering and current measurement applications where the specified accuracy class is required.</p>
<h3>1200A Primary Current</h3>
<p>The <strong>1200A primary rating</strong> makes this model suitable for compatible electrical systems requiring current measurement around a 1200A primary circuit.</p>
<h3>Standard 5A Secondary</h3>
<p>The 5A secondary output can be connected to compatible meters and measuring equipment designed for a 5A CT secondary.</p>
<h3>115mm Inner Diameter</h3>
<p>The <strong>115 mm ID</strong> provides a defined opening for compatible cables, conductors, and busbar arrangements. The actual conductor dimensions should be checked before installation.</p>
<h3>Defined Installation Dimensions</h3>
<p>The <strong>170 mm outer diameter and 40 mm width</strong> provide clear physical dimensions that can be considered when planning electrical panel or equipment installation.</p>
<h3>Multiple Compatible Applications</h3>
<p>The CT can be considered for compatible energy metering, current measurement, electrical monitoring, distribution panels, control panels, and power monitoring systems.</p>
<h2>Installation Considerations</h2>
<p>Before installing the <strong>1200/5A Ring Current Transformer</strong>, verify:</p>
<ol>
<li>The primary circuit is compatible with the <strong>1200A primary rating</strong>.</li>
<li>The connected equipment requires a <strong>5A secondary output</strong>.</li>
<li>The required accuracy corresponds to <strong>Class 1.0</strong>.</li>
<li>The cable, conductor, or busbar can pass through the <strong>115 mm ID</strong>.</li>
<li>The available installation space accommodates the <strong>170 mm OD</strong>.</li>
<li>The available space accommodates the <strong>40 mm width</strong>.</li>
<li>The connected secondary circuit is compatible with the <strong>2.5–15 VA</strong> rating.</li>
<li>The CT and connected equipment are installed according to appropriate electrical installation procedures.</li>
</ol>
<p>Always verify the complete electrical and mechanical requirements before installation.</p>
<h2>Frequently Asked Questions</h2>
<h3>What is the current ratio of this CT?</h3>
<p>The current ratio is <strong>1200/5A</strong>, with a 1200A primary current and 5A secondary current.</p>
<h3>What is the primary current?</h3>
<p>The specified primary current is <strong>1200A</strong>.</p>
<h3>What is the secondary current?</h3>
<p>The secondary current is <strong>5A</strong>.</p>
<h3>What is the accuracy class?</h3>
<p>The 1200/5A Ring Current Transformer has a specified <strong>Class 1.0 accuracy class</strong>.</p>
<h3>What is the inner diameter of this Ring CT?</h3>
<p>The specified inner diameter is <strong>115 mm</strong>.</p>
<h3>What is the outer diameter?</h3>
<p>The specified outer diameter is <strong>170 mm</strong>.</p>
<h3>What is the width of the CT?</h3>
<p>The specified width is <strong>40 mm</strong>.</p>
<h3>What is the VA rating?</h3>
<p>The specified VA rating is <strong>2.5–15 VA</strong>.</p>
<h3>Where can a 1200/5A Ring Current Transformer be used?</h3>
<p>It can be used in compatible energy metering, current measurement, electrical monitoring, distribution panels, control panels, industrial electrical installations, and power monitoring systems.</p>
<h3>Can this CT be used with a 5A meter?</h3>
<p>The CT provides a <strong>5A secondary output</strong> and can be used with compatible meters and measuring equipment designed for a 5A CT secondary. Equipment compatibility should be verified before installation.</p>
<h3>What should I check before purchasing this CT?</h3>
<p>Check the required <strong>1200/5A ratio, Class 1.0 accuracy, 115 mm ID, 170 mm OD, 40 mm width, and 2.5–15 VA rating</strong>, along with the available installation space and connected equipment requirements.</p>
<h2>Shipping &amp; Bulk Orders</h2>
<p>MVG Power Solutions supplies Current Transformers for compatible electrical measurement, metering, and monitoring applications. Customers requiring multiple units can contact the team for bulk quantity requirements and quotations.</p>
<p>When requesting a quotation, mention the required <strong>1200/5A current ratio, Class 1.0 accuracy, 115 mm ID, 170 mm OD, 40 mm width, and 2.5–15 VA rating</strong> to help ensure the required specification is identified correctly.</p>
<p>Shipping charges and delivery timelines may vary depending on order quantity and delivery destination.</p>
<h2>Product Summary</h2>
<p>The <strong>1200/5A Ring Current Transformer 115mm CT</strong> is a <strong>Class 1.0</strong> current transformer featuring a <strong>1200A primary current, 5A secondary current, 115 mm inner diameter, 170 mm outer diameter, 40 mm width, and 2.5–15 VA rating</strong>.</p>
<p>It is suitable for compatible metering, current measurement, electrical monitoring, distribution, and power monitoring applications where these electrical and physical specifications meet the requirements of the installation.</p>', 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/1200-A.jpg', 1, 'published'),
(246, 1, 60, 1, '1000/5A Ring Current Transformer 115mm CT | Class 1.0 Metering CT', '1000-5a-ring-current-transformer-115mm-ct', '17040-MVG-R-115-1', 280.00, 280.00, 10, '85043100', 18.00, 'in_stock', '<ul data-spread="false">
<li><strong>Primary Current:</strong> 1000A</li>
<li><strong>Secondary Current:</strong> 5A</li>
<li><strong>Current Ratio:</strong> 1000/5A</li>
<li><strong>Accuracy Class:</strong> Class 1.0</li>
<li><strong>Inner Diameter (ID):</strong> 115 mm</li>
<li><strong>Outer Diameter (OD):</strong> 170 mm</li>
<li><strong>Width:</strong> 40 mm</li>
<li><strong>VA Rating:</strong> 2.5–15 VA</li>
<li>Ring-type current transformer for compatible metering, current measurement, and monitoring applications</li>
</ul>
<h2></h2>', '<h2>Product Overview</h2>
<p>The <strong>1000/5A Ring Current Transformer 115mm CT</strong> is a Class 1.0 current transformer designed for compatible electrical current measurement, metering, monitoring, and power management applications. It features a <strong>1000A primary current</strong> and a <strong>5A secondary current</strong>, providing a 1000/5A current ratio for compatible meters, measuring instruments, and monitoring equipment.</p>
<p>This Ring Current Transformer features a <strong>115 mm inner diameter</strong>, providing a defined opening for compatible cables, conductors, or busbar arrangements. The CT has an <strong>outer diameter of 170 mm</strong> and a <strong>40 mm width</strong>, allowing users to consider the required physical space when planning installation inside electrical panels, distribution equipment, and other suitable systems.</p>
<p>The <strong>Class 1.0 accuracy</strong> makes this CT suitable for compatible metering and current measurement applications where the specified accuracy class is required. The <strong>2.5–15 VA rating</strong> provides a defined burden range for compatible secondary circuits and connected measuring equipment.</p>
<p>With a <strong>1000/5A current ratio</strong>, the transformer provides a 5A secondary output corresponding to the specified primary current. This makes it suitable for compatible electrical meters, monitoring equipment, energy measurement systems, and current measurement applications designed for a 5A CT secondary.</p>
<p>The 115 mm internal opening should be checked against the actual cable, conductor, or busbar dimensions before installation. Users should also verify the current ratio, secondary rating, accuracy class, VA requirement, physical dimensions, and connected equipment compatibility before selecting the CT.</p>
<h2>Key Features</h2>
<p>The <strong>1000/5A Ring Current Transformer 115mm CT</strong> offers the following features:</p>
<ul>
<li>1000/5A current ratio</li>
<li>1000A primary current</li>
<li>5A secondary current</li>
<li>Class 1.0 accuracy</li>
<li>115 mm inner diameter</li>
<li>170 mm outer diameter</li>
<li>40 mm width</li>
<li>2.5–15 VA rating</li>
<li>Ring-type current transformer configuration</li>
<li>Suitable for compatible metering applications</li>
<li>Suitable for current measurement and monitoring</li>
<li>Suitable for compatible electrical panels</li>
<li>Large internal opening for compatible conductors and busbars</li>
</ul>
<h2>Technical Specifications</h2>
<table>
<thead>
<tr>
<th>Parameter</th>
<th>Specification</th>
</tr>
</thead>
<tbody>
<tr>
<td>Product Type</td>
<td>Current Transformer</td>
</tr>
<tr>
<td>CT Type</td>
<td>Ring Current Transformer</td>
</tr>
<tr>
<td>Primary Current</td>
<td>1000A</td>
</tr>
<tr>
<td>Secondary Current</td>
<td>5A</td>
</tr>
<tr>
<td>Current Ratio</td>
<td>1000/5A</td>
</tr>
<tr>
<td>Accuracy Class</td>
<td>Class 1.0</td>
</tr>
<tr>
<td>Inner Diameter (ID)</td>
<td>115 mm</td>
</tr>
<tr>
<td>Outer Diameter (OD)</td>
<td>170 mm</td>
</tr>
<tr>
<td>Width</td>
<td>40 mm</td>
</tr>
<tr>
<td>VA Rating</td>
<td>2.5–15 VA</td>
</tr>
<tr>
<td>Application</td>
<td>Metering &amp; Current Measurement</td>
</tr>
</tbody>
</table>
<h2>Applications</h2>
<p>The <strong>1000/5A Ring Current Transformer</strong> can be used for compatible electrical measurement, metering, monitoring, and power management applications, including:</p>
<ul>
<li>Energy metering systems</li>
<li>Electrical current measurement</li>
<li>Power monitoring systems</li>
<li>Electrical distribution panels</li>
<li>Electrical control panels</li>
<li>Metering panels</li>
<li>Industrial electrical installations</li>
<li>Current monitoring systems</li>
<li>Energy monitoring equipment</li>
<li>Electrical measurement systems</li>
<li>Distribution equipment</li>
<li>Compatible power management systems</li>
</ul>
<p>The CT should be selected according to the electrical requirements of the installation, including primary current, secondary current, accuracy class, burden, conductor dimensions, and available installation space.</p>
<h2>Why Choose a 1000/5A Class 1.0 Ring CT?</h2>
<p>The <strong>1000/5A Class 1.0 Ring Current Transformer</strong> combines a <strong>1000A primary current rating</strong> with a standard <strong>5A secondary output</strong> for compatible measurement and metering equipment.</p>
<p>Its <strong>115 mm inner diameter</strong> provides a defined opening for compatible cables, conductors, or busbar arrangements. The <strong>170 mm outer diameter and 40 mm width</strong> provide important physical dimensions for checking panel space and installation requirements.</p>
<p>The <strong>Class 1.0 accuracy</strong> makes this CT suitable for compatible metering and current measurement applications requiring the specified accuracy class. Its <strong>2.5–15 VA rating</strong> provides a defined burden range for compatible secondary circuits.</p>
<p>For correct product selection, users should verify the required current ratio, primary current, secondary current, accuracy class, VA rating, inner diameter, outer diameter, width, and installation conditions before ordering.</p>
<h2>Benefits of 1000/5A Current Transformer</h2>
<h3>Class 1.0 Accuracy</h3>
<p>The specified Class 1.0 accuracy makes this CT suitable for compatible metering and current measurement applications where the specified accuracy class is required.</p>
<h3>1000A Primary Current</h3>
<p>The 1000A primary rating makes this model suitable for compatible electrical systems requiring current measurement around a 1000A primary circuit.</p>
<h3>Standard 5A Secondary</h3>
<p>The 5A secondary output can be connected to compatible meters and measuring equipment designed for a 5A CT secondary.</p>
<h3>115mm Inner Diameter</h3>
<p>The 115 mm ID provides a defined opening for compatible cables, conductors, and busbar arrangements. The actual conductor dimensions should be checked before installation.</p>
<h3>Defined Installation Dimensions</h3>
<p>The <strong>170 mm outer diameter and 40 mm width</strong> provide clear physical dimensions that can be considered when planning electrical panel or equipment installation.</p>
<h3>Multiple Compatible Applications</h3>
<p>The CT can be considered for compatible energy metering, current measurement, electrical monitoring, distribution panels, control panels, and power monitoring systems.</p>
<h2>Installation Considerations</h2>
<p>Before installing the <strong>1000/5A Ring Current Transformer</strong>, verify:</p>
<ol>
<li>The primary circuit is compatible with the <strong>1000A primary rating</strong>.</li>
<li>The connected equipment requires a <strong>5A secondary output</strong>.</li>
<li>The required accuracy corresponds to <strong>Class 1.0</strong>.</li>
<li>The cable, conductor, or busbar can pass through the <strong>115 mm ID</strong>.</li>
<li>The available installation space accommodates the <strong>170 mm OD</strong>.</li>
<li>The available space accommodates the <strong>40 mm width</strong>.</li>
<li>The connected secondary circuit is compatible with the <strong>2.5–15 VA</strong> rating.</li>
<li>The CT and connected equipment are installed according to appropriate electrical installation procedures.</li>
</ol>
<p>Always verify the complete electrical and mechanical requirements before installation.</p>
<h2>Frequently Asked Questions</h2>
<h3>What is the current ratio of this CT?</h3>
<p>The current ratio is <strong>1000/5A</strong>, with a 1000A primary current and 5A secondary current.</p>
<h3>What is the primary current?</h3>
<p>The specified primary current is <strong>1000A</strong>.</p>
<h3>What is the secondary current?</h3>
<p>The secondary current is <strong>5A</strong>.</p>
<h3>What is the accuracy class?</h3>
<p>The 1000/5A Ring Current Transformer has a specified <strong>Class 1.0 accuracy class</strong>.</p>
<h3>What is the inner diameter of this Ring CT?</h3>
<p>The specified inner diameter is <strong>115 mm</strong>.</p>
<h3>What is the outer diameter?</h3>
<p>The specified outer diameter is <strong>170 mm</strong>.</p>
<h3>What is the width of the CT?</h3>
<p>The specified width is <strong>40 mm</strong>.</p>
<h3>What is the VA rating?</h3>
<p>The specified VA rating is <strong>2.5–15 VA</strong>.</p>
<h3>Where can a 1000/5A Ring Current Transformer be used?</h3>
<p>It can be used in compatible energy metering, current measurement, electrical monitoring, distribution panels, control panels, industrial electrical installations, and power monitoring systems.</p>
<h3>Can this CT be used with a 5A meter?</h3>
<p>The CT provides a <strong>5A secondary output</strong> and can be used with compatible meters and measuring equipment designed for a 5A CT secondary. Equipment compatibility should be verified before installation.</p>
<h3>What should I check before purchasing this CT?</h3>
<p>Check the required <strong>1000/5A ratio, Class 1.0 accuracy, 115 mm ID, 170 mm OD, 40 mm width, and 2.5–15 VA rating</strong>, along with the available installation space and connected equipment requirements.</p>
<h2>Shipping &amp; Bulk Orders</h2>
<p>MVG Power Solutions supplies Current Transformers for compatible electrical measurement, metering, and monitoring applications. Customers requiring multiple units can contact the team for bulk quantity requirements and quotations.</p>
<p>When requesting a quotation, mention the required <strong>1000/5A current ratio, Class 1.0 accuracy, 115 mm ID, 170 mm OD, 40 mm width, and 2.5–15 VA rating</strong> to help ensure the required specification is identified correctly.</p>
<p>Shipping charges and delivery timelines may vary depending on order quantity and delivery destination.</p>
<h2>Product Summary</h2>
<p>The <strong>1000/5A Ring Current Transformer 115mm CT</strong> is a <strong>Class 1.0</strong> current transformer featuring a <strong>1000A primary current, 5A secondary current, 115 mm inner diameter, 170 mm outer diameter, 40 mm width, and 2.5–15 VA rating</strong>.</p>
<p>It is suitable for compatible metering, current measurement, electrical monitoring, distribution, and power monitoring applications where these electrical and physical specifications meet the requirements of the installation.</p>', 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/1000-A-1.jpg', 1, 'published'),
(243, 1, 60, 1, '800/5A Ring Current Transformer 115mm CT | Class 1.0 Metering CT', '800-5a-ring-current-transformer-115mm-ct', '17040-MVG-R-115', 280.00, 280.00, 10, '85043100', 18.00, 'in_stock', '<ul data-spread="false">
<li><strong>Primary Current:</strong> 800A</li>
<li><strong>Secondary Current:</strong> 5A</li>
<li><strong>Current Ratio:</strong> 800/5A</li>
<li><strong>Accuracy Class:</strong> Class 1.0</li>
<li><strong>Inner Diameter (ID):</strong> 115 mm</li>
<li><strong>Outer Diameter (OD):</strong> 170 mm</li>
<li><strong>Width:</strong> 40 mm</li>
<li><strong>VA Rating:</strong> 2.5–15 VA</li>
<li>Ring-type current transformer for compatible metering and current measurement applications</li>
</ul>', '<h1>Product Overview</h1>
<p>The <strong>800/5A Ring Current Transformer 115mm CT</strong> is a Class 1.0 current transformer designed for compatible electrical current measurement, metering, monitoring, and power management applications. It features an <strong>800A primary current</strong> and a <strong>5A secondary current</strong>, providing an 800/5A current ratio for compatible measuring instruments and metering equipment.</p>
<p>This Ring Current Transformer has a large <strong>115 mm inner diameter</strong>, making it suitable for compatible cable, conductor, or busbar arrangements that can fit through the specified CT opening. The CT has an <strong>outer diameter of 170 mm</strong> and a <strong>40 mm width</strong>, providing defined physical dimensions for installation planning inside electrical panels, distribution systems, and other suitable electrical equipment.</p>
<p>With <strong>Class 1.0 accuracy</strong>, this 800/5A CT is intended for compatible metering and current measurement applications where the specified accuracy class is required. The <strong>2.5–15 VA rating</strong> defines the specified burden range for compatible secondary circuits and connected measuring equipment.</p>
<p>The 800/5A ratio converts the primary current measurement into a compatible 5A secondary output. This makes the CT suitable for applications where electrical current needs to be measured through compatible meters, monitoring equipment, energy measurement systems, and electrical control equipment.</p>
<p>Before selecting this CT, users should verify the required primary current, secondary current, accuracy class, VA requirement, conductor dimensions, available installation space, and compatibility with the connected measuring equipment.</p>
<h2>Key Features</h2>
<p>The <strong>800/5A Ring Current Transformer 115mm CT</strong> offers the following features:</p>
<ul>
<li>800/5A current ratio</li>
<li>800A primary current</li>
<li>5A secondary current</li>
<li>Class 1.0 accuracy</li>
<li>115 mm inner diameter</li>
<li>170 mm outer diameter</li>
<li>40 mm width</li>
<li>2.5–15 VA rating</li>
<li>Ring-type CT configuration</li>
<li>Suitable for compatible metering applications</li>
<li>Suitable for current measurement and monitoring</li>
<li>Suitable for compatible electrical panels</li>
<li>Large internal opening for compatible conductors and busbars</li>
</ul>
<h2>Technical Specifications</h2>
<table>
<thead>
<tr>
<th>ParameterSpecification</th>
<th></th>
</tr>
</thead>
<tbody>
<tr>
<td>Product Type</td>
<td>Current Transformer</td>
</tr>
<tr>
<td>CT Type</td>
<td>Ring Current Transformer</td>
</tr>
<tr>
<td>Primary Current</td>
<td>800A</td>
</tr>
<tr>
<td>Secondary Current</td>
<td>5A</td>
</tr>
<tr>
<td>Current Ratio</td>
<td>800/5A</td>
</tr>
<tr>
<td>Accuracy Class</td>
<td>Class 1.0</td>
</tr>
<tr>
<td>Inner Diameter (ID)</td>
<td>115 mm</td>
</tr>
<tr>
<td>Outer Diameter (OD)</td>
<td>170 mm</td>
</tr>
<tr>
<td>Width</td>
<td>40 mm</td>
</tr>
<tr>
<td>VA Rating</td>
<td>2.5–15 VA</td>
</tr>
<tr>
<td>Application</td>
<td>Metering &amp; Current Measurement</td>
</tr>
</tbody>
</table>
<h2>Applications</h2>
<p>The <strong>800/5A Ring Current Transformer</strong> can be used for a variety of compatible electrical measurement and monitoring applications, including:</p>
<ul>
<li>Energy metering systems</li>
<li>Electrical current measurement</li>
<li>Power monitoring systems</li>
<li>Electrical distribution panels</li>
<li>Electrical control panels</li>
<li>Metering panels</li>
<li>Industrial electrical installations</li>
<li>Current monitoring systems</li>
<li>Energy monitoring equipment</li>
<li>Electrical measurement systems</li>
<li>Distribution equipment</li>
<li>Compatible power management systems</li>
</ul>
<p>The CT should be selected according to the electrical requirements of the installation, including primary current, secondary current, accuracy class, burden, conductor dimensions, and available installation space.</p>
<h2>Why Choose an 800/5A Class 1.0 Ring CT?</h2>
<p>The <strong>800/5A Class 1.0 Ring Current Transformer</strong> combines an 800A primary current rating with a standard 5A secondary output for compatible measurement and metering equipment.</p>
<p>Its <strong>115 mm inner diameter</strong> provides a large opening for compatible conductors, cables, or busbar arrangements. The <strong>170 mm outer diameter and 40 mm width</strong> provide defined physical dimensions that can be considered during electrical panel and installation planning.</p>
<p>The <strong>Class 1.0 accuracy</strong> makes this CT suitable for compatible metering and current measurement applications requiring the specified accuracy class. The <strong>2.5–15 VA rating</strong> provides a defined burden range for compatible secondary circuits.</p>
<p>For proper product selection, always verify the current ratio, primary current, secondary current, accuracy class, VA rating, inner diameter, outer diameter, width, and installation requirements before ordering.</p>
<h2>Benefits of 800/5A Current Transformer</h2>
<h3>Class 1.0 Accuracy</h3>
<p>The specified Class 1.0 accuracy makes the CT suitable for compatible metering and current measurement applications where this accuracy class is required.</p>
<h3>800A Primary Current</h3>
<p>The 800A primary rating makes this model suitable for compatible electrical systems requiring current measurement around an 800A primary circuit.</p>
<h3>Standard 5A Secondary</h3>
<p>The 5A secondary output is compatible with measuring and metering equipment designed to operate with a 5A CT secondary.</p>
<h3>Large 115mm Inner Diameter</h3>
<p>The 115 mm ID provides a defined opening for compatible cables, conductors, and busbar arrangements. The actual conductor dimensions should always be checked before installation.</p>
<h3>Defined Installation Dimensions</h3>
<p>The 170 mm outer diameter and 40 mm width allow users to check available installation space before selecting the CT.</p>
<h3>Wide Range of Compatible Applications</h3>
<p>The CT can be considered for compatible energy metering, current measurement, electrical monitoring, distribution panels, control panels, and power monitoring applications.</p>
<h2>Installation Considerations</h2>
<p>Before installing the 800/5A Ring Current Transformer, verify:</p>
<ol>
<li>The primary circuit is compatible with the <strong>800A primary rating</strong>.</li>
<li>The connected equipment requires a <strong>5A secondary output</strong>.</li>
<li>The required accuracy corresponds to <strong>Class 1.0</strong>.</li>
<li>The conductor, cable, or busbar can pass through the <strong>115 mm ID</strong>.</li>
<li>The available installation space accommodates the <strong>170 mm OD</strong>.</li>
<li>The available space accommodates the <strong>40 mm width</strong>.</li>
<li>The connected secondary circuit is compatible with the <strong>2.5–15 VA</strong> rating.</li>
<li>The CT and connected equipment are installed according to appropriate electrical installation procedures.</li>
</ol>
<p>Always verify the complete electrical and mechanical requirements before installation.</p>
<h2>Frequently Asked Questions</h2>
<h3>What is the current ratio of this CT?</h3>
<p>The current ratio is <strong>800/5A</strong>, with an 800A primary current and 5A secondary current.</p>
<h3>What is the primary current?</h3>
<p>The specified primary current is <strong>800A</strong>.</p>
<h3>What is the secondary current?</h3>
<p>The secondary current is <strong>5A</strong>.</p>
<h3>What is the accuracy class?</h3>
<p>This Ring Current Transformer has a specified <strong>Class 1.0 accuracy class</strong>.</p>
<h3>What is the inner diameter of the 800/5A Ring CT?</h3>
<p>The specified inner diameter is <strong>115 mm</strong>.</p>
<h3>What is the outer diameter?</h3>
<p>The specified outer diameter is <strong>170 mm</strong>.</p>
<h3>What is the width of the CT?</h3>
<p>The specified width is <strong>40 mm</strong>.</p>
<h3>What is the VA rating?</h3>
<p>The specified VA rating is <strong>2.5–15 VA</strong>.</p>
<h3>Where can an 800/5A Ring Current Transformer be used?</h3>
<p>It can be used in compatible energy metering, current measurement, electrical monitoring, distribution panels, control panels, industrial electrical installations, and power monitoring systems.</p>
<h3>Can this CT be used with a 5A meter?</h3>
<p>The CT provides a <strong>5A secondary output</strong> and can be used with compatible meters and measuring equipment designed for a 5A CT secondary. Equipment compatibility should be verified before installation.</p>
<h3>What should I check before purchasing this CT?</h3>
<p>Check the required <strong>800/5A ratio, Class 1.0 accuracy, 115 mm ID, 170 mm OD, 40 mm width, 2.5–15 VA rating</strong>, and the available installation space.</p>
<h2>Shipping &amp; Bulk Orders</h2>
<p>MVG Power Solutions supplies Current Transformers for compatible electrical measurement, metering, and monitoring applications. Customers requiring multiple units can contact the team for bulk quantity requirements and quotations.</p>
<p>When requesting a quotation, mention the required <strong>800/5A current ratio, Class 1.0 accuracy, 115 mm ID, 170 mm OD, 40 mm width, and 2.5–15 VA rating</strong> to help ensure the required specification is identified correctly.</p>
<p>Shipping charges and delivery timelines can vary depending on the order quantity and delivery destination.</p>
<h2>Product Summary</h2>
<p>The <strong>800/5A Ring Current Transformer 115mm CT</strong> is a <strong>Class 1.0</strong> current transformer featuring an <strong>800A primary current, 5A secondary current, 115 mm inner diameter, 170 mm outer diameter, 40 mm width, and 2.5–15 VA rating</strong>.</p>
<p>It is suitable for compatible metering, current measurement, electrical monitoring, distribution, and power monitoring applications where these electrical and physical specifications meet the requirements of the installation.</p>', 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/800-A-1.jpg', 1, 'published'),
(240, 1, 60, 1, '1200/5A Ring Current Transformer 85mm | Class 1.0 Metering CT', '1200-5a-85mm-ring-current-transformer', '13540-MVG-R 85-1-1-1', 280.00, 280.00, 10, '85043100', 18.00, 'in_stock', '<ul data-spread="false">
<li><strong>Primary Current:</strong> 1200A</li>
<li><strong>Secondary Current:</strong> 5A</li>
<li><strong>Current Ratio:</strong> 1200/5A</li>
<li><strong>Accuracy Class:</strong> Class 1.0</li>
<li><strong>Inner Diameter (ID):</strong> 85 mm</li>
<li><strong>Outer Diameter (OD):</strong> 135 mm</li>
<li><strong>Width:</strong> 40 mm</li>
<li><strong>VA Rating:</strong> 2.5–15 VA</li>
<li><strong>CT Type:</strong> Encapsulated Round Type Ring Current Transformer</li>
<li><strong>Secondary Output:</strong> 5A</li>
<li><strong>Suitable for:</strong> Metering and current measurement</li>
<li><strong>Suitable for:</strong> Electrical monitoring and compatible panel installations</li>
</ul>
<div>
<hr />
</div>
<h1></h1>', '<h1>Product Overview</h1>
<h2>1200/5A 85mm Ring Current Transformer</h2>
<p class="isSelectedEnd">The <strong>1200/5A Ring Current Transformer 85mm CT</strong> is a Class 1.0 current transformer designed for compatible electrical metering, current measurement and monitoring applications. It features a <strong>1200A primary current</strong> and <strong>5A secondary current</strong>, providing a specified <strong>1200/5A current ratio</strong> for compatible meters, measuring instruments and electrical monitoring equipment.</p>
<p class="isSelectedEnd">This current transformer features an <strong>encapsulated round-type ring construction</strong> with an <strong>85 mm inner diameter</strong>, <strong>135 mm outer diameter</strong>, and <strong>40 mm width</strong>. The larger circular opening provides a defined space for compatible conductors or cables. Before installation, the conductor dimensions should be checked against the available 85mm opening.</p>
<p class="isSelectedEnd">With its <strong>Class 1.0 accuracy</strong>, this CT is suitable for applications where the specified metering accuracy is required. The <strong>5A secondary output</strong> can be connected to compatible meters, monitoring instruments and electrical measurement equipment designed for a 5A CT input.</p>
<p class="isSelectedEnd">The transformer has a specified <strong>2.5–15 VA rating</strong>, which should be considered when matching the CT with the connected secondary circuit. The connected meter, measuring equipment and secondary wiring burden should be checked to ensure compatibility.</p>
<p class="isSelectedEnd">The <strong>85 mm inner diameter</strong>, <strong>135 mm outer diameter</strong> and <strong>40 mm width</strong> should also be considered when planning the available installation space inside an electrical panel, enclosure or other compatible location.</p>
<div>
<hr />
</div>
<h1>Key Features</h1>
<p class="isSelectedEnd">The <strong>1200/5A 85mm Ring Current Transformer</strong> offers the following features:</p>
<ul data-spread="false">
<li>1200/5A current ratio</li>
<li>1200A primary current</li>
<li>5A secondary current</li>
<li>Class 1.0 accuracy</li>
<li>85 mm inner diameter</li>
<li>135 mm outer diameter</li>
<li>40 mm width</li>
<li>2.5–15 VA rating</li>
<li>Encapsulated round-type ring construction</li>
<li>Standard 5A secondary output</li>
<li>Suitable for compatible metering applications</li>
<li>Suitable for electrical current measurement</li>
<li>Suitable for current monitoring systems</li>
<li>Suitable for compatible electrical panels and installations</li>
</ul>
<div>
<hr />
</div>
<h1>Technical Specifications</h1>
<table>
<tbody>
<tr>
<th>Parameter</th>
<th>Specification</th>
</tr>
<tr>
<td>Product Type</td>
<td>Current Transformer</td>
</tr>
<tr>
<td>CT Type</td>
<td>Encapsulated Round Type Ring CT</td>
</tr>
<tr>
<td>Primary Current</td>
<td>1200A</td>
</tr>
<tr>
<td>Secondary Current</td>
<td>5A</td>
</tr>
<tr>
<td>Current Ratio</td>
<td>1200/5A</td>
</tr>
<tr>
<td>Accuracy Class</td>
<td>Class 1.0</td>
</tr>
<tr>
<td>Inner Diameter (ID)</td>
<td>85 mm</td>
</tr>
<tr>
<td>Outer Diameter (OD)</td>
<td>135 mm</td>
</tr>
<tr>
<td>Width</td>
<td>40 mm</td>
</tr>
<tr>
<td>VA Rating</td>
<td>2.5–15 VA</td>
</tr>
<tr>
<td>Application</td>
<td>Metering &amp; Current Measurement</td>
</tr>
</tbody>
</table>
<div>
<hr />
</div>
<h1>1200/5A Ring Current Transformer for Metering</h1>
<p class="isSelectedEnd">The <strong>1200/5A Ring Current Transformer</strong> is designed for compatible electrical metering and current measurement systems. With a <strong>1200A primary current and 5A secondary output</strong>, it provides a specified current transformation ratio for compatible 5A measurement equipment.</p>
<p class="isSelectedEnd">Current transformers are commonly used in electrical systems where current measurement is performed through compatible meters or monitoring instruments. The transformer provides a secondary current corresponding to its specified ratio for use with suitable measurement equipment.</p>
<p class="isSelectedEnd">For this product, the specified current ratio is <strong>1200/5A</strong>. The connected meter or monitoring instrument should be selected according to the CT&#8217;s 5A secondary requirement and the requirements of the overall electrical installation.</p>
<p class="isSelectedEnd">The CT should be selected after checking the required primary current, secondary current, accuracy class, burden, conductor dimensions and physical installation requirements.</p>
<div>
<hr />
</div>
<h1>85mm Inner Diameter Ring CT</h1>
<p class="isSelectedEnd">This model features an <strong>85 mm inner diameter</strong>, providing a larger circular opening for compatible conductors and cables.</p>
<p class="isSelectedEnd">The conductor or cable dimensions should be checked before installation to ensure they can pass through the <strong>85mm opening</strong>. Adequate clearance should be available so the CT can be positioned correctly around the conductor.</p>
<p class="isSelectedEnd">The <strong>135 mm outer diameter</strong> and <strong>40 mm width</strong> should also be considered when determining available space inside an electrical panel, enclosure or other installation location.</p>
<p class="isSelectedEnd">The ring-type construction provides a defined circular CT configuration for compatible electrical measurement and monitoring installations.</p>
<div>
<hr />
</div>
<h1>Class 1.0 Metering Accuracy</h1>
<p class="isSelectedEnd">The <strong>Class 1.0 accuracy</strong> specification is an important consideration when selecting this current transformer for compatible metering and measurement applications.</p>
<p class="isSelectedEnd">The CT should be used with suitable measuring equipment and within the conditions applicable to its specified accuracy class. The complete secondary circuit, including connected equipment and wiring, should be considered during installation planning.</p>
<p class="isSelectedEnd">For applications requiring Class 1.0 accuracy, the <strong>1200/5A Class 1.0 Ring CT</strong> can be considered when its ratio, burden, dimensions and other specifications match the requirements of the electrical system.</p>
<div>
<hr />
</div>
<h1>Standard 5A Secondary Output</h1>
<p class="isSelectedEnd">The <strong>5A secondary output</strong> makes this current transformer suitable for compatible meters and measurement instruments designed for a 5A CT input.</p>
<p class="isSelectedEnd">The secondary rating should match the input specification of the connected measuring equipment. For this product, the specified configuration is <strong>1200A primary / 5A secondary</strong>.</p>
<p class="isSelectedEnd">The secondary circuit should be connected according to the requirements of the CT, measuring equipment and overall electrical installation.</p>
<div>
<hr />
</div>
<h1>2.5–15 VA Rating</h1>
<p class="isSelectedEnd">The <strong>1200/5A 85mm Ring CT</strong> has a specified <strong>2.5–15 VA rating</strong>.</p>
<p class="isSelectedEnd">VA rating is an important consideration when selecting a current transformer because the connected secondary circuit introduces a burden. This may include the connected meter, measuring instrument and secondary wiring.</p>
<p class="isSelectedEnd">Before installation, the expected connected burden should be checked against the specified <strong>2.5–15 VA</strong> range to ensure that the transformer is appropriate for the intended application.</p>
<div>
<hr />
</div>
<h1>Applications</h1>
<p class="isSelectedEnd">The <strong>1200/5A 85mm Ring Current Transformer</strong> can be used in compatible applications such as:</p>
<ul data-spread="false">
<li>Energy metering systems</li>
<li>Electrical current measurement</li>
<li>Current monitoring systems</li>
<li>Power monitoring systems</li>
<li>Metering panels</li>
<li>Electrical distribution panels</li>
<li>Electrical control panels</li>
<li>Industrial electrical installations</li>
<li>Electrical monitoring equipment</li>
<li>Energy measurement systems</li>
<li>Current measurement equipment</li>
<li>Compatible panel metering applications</li>
</ul>
<p class="isSelectedEnd">The CT should be selected according to the required current ratio, secondary current, accuracy class, burden, conductor dimensions and installation requirements.</p>
<div>
<hr />
</div>
<h1>Benefits of 1200/5A 85mm Ring Current Transformer</h1>
<h3>Class 1.0 Accuracy</h3>
<p class="isSelectedEnd">The Class 1.0 specification makes this CT suitable for compatible applications requiring the specified metering accuracy.</p>
<h3>1200/5A Current Ratio</h3>
<p class="isSelectedEnd">The specified <strong>1200/5A ratio</strong> provides a 5A secondary output for compatible current measurement and metering equipment.</p>
<h3>85mm Inner Diameter</h3>
<p class="isSelectedEnd">The <strong>85mm inner diameter</strong> provides a larger defined circular opening for compatible conductors and cables.</p>
<h3>Encapsulated Ring Construction</h3>
<p class="isSelectedEnd">The encapsulated round-type construction provides a ring-style configuration suitable for compatible electrical measurement installations.</p>
<h3>Standard 5A Secondary</h3>
<p class="isSelectedEnd">The 5A secondary output is suitable for compatible measuring equipment designed for a 5A CT input.</p>
<h3>2.5–15 VA Rating</h3>
<p class="isSelectedEnd">The specified <strong>2.5–15 VA rating</strong> allows the CT to be matched with compatible secondary circuits according to their connected burden.</p>
<h3>Defined Physical Dimensions</h3>
<p class="isSelectedEnd">The <strong>135mm OD × 40mm width</strong> provides defined physical dimensions that can be considered during electrical panel and installation planning.</p>
<div>
<hr />
</div>
<h1>Installation Considerations</h1>
<p class="isSelectedEnd">Before installing the <strong>1200/5A 85mm Ring Current Transformer</strong>, check the following:</p>
<ol start="1" data-spread="false">
<li>Confirm that the required CT ratio is <strong>1200/5A</strong>.</li>
<li>Confirm that the primary current requirement is <strong>1200A</strong>.</li>
<li>Verify that the connected equipment requires a <strong>5A secondary</strong>.</li>
<li>Confirm that the required accuracy class is <strong>Class 1.0</strong>.</li>
<li>Check that the conductor or cable fits through the <strong>85mm inner diameter</strong>.</li>
<li>Check the available space against the <strong>135mm outer diameter and 40mm width</strong>.</li>
<li>Verify that the connected secondary burden is compatible with the <strong>2.5–15 VA</strong> rating.</li>
<li>Ensure that the CT secondary connections are made according to the requirements of the electrical installation.</li>
</ol>
<p class="isSelectedEnd">Installation should be performed by a suitably qualified electrical professional following applicable electrical safety practices.</p>
<div>
<hr />
</div>
<h1>Why Choose a 1200/5A 85mm Class 1.0 Ring CT?</h1>
<p class="isSelectedEnd">The <strong>1200/5A 85mm Ring Current Transformer</strong> combines a <strong>1200A primary current</strong>, <strong>5A secondary output</strong>, <strong>Class 1.0 accuracy</strong> and encapsulated ring-type construction.</p>
<p class="isSelectedEnd">Its <strong>85mm inner diameter</strong> provides a larger circular opening for compatible conductors, while the <strong>135mm outer diameter and 40mm width</strong> provide important physical dimensions for installation planning.</p>
<p class="isSelectedEnd">The specified <strong>2.5–15 VA rating</strong> can be considered when matching the CT with the connected metering or measurement circuit.</p>
<p class="isSelectedEnd">Before selecting the CT, users should verify the required current ratio, primary current, secondary current, accuracy class, conductor size, burden and available installation space.</p>
<div>
<hr />
</div>
<h1>Product Summary</h1>
<p class="isSelectedEnd">The <strong>1200/5A Ring Current Transformer 85mm CT</strong> is an encapsulated round-type current transformer featuring:</p>
<ul data-spread="false">
<li><strong>1200A primary current</strong></li>
<li><strong>5A secondary current</strong></li>
<li><strong>1200/5A current ratio</strong></li>
<li><strong>Class 1.0 accuracy</strong></li>
<li><strong>85mm inner diameter</strong></li>
<li><strong>135mm outer diameter</strong></li>
<li><strong>40mm width</strong></li>
<li><strong>2.5–15 VA rating</strong></li>
</ul>
<p class="isSelectedEnd">It is suitable for compatible metering, electrical current measurement and monitoring applications where these specifications meet the requirements of the electrical system.</p>
<div>
<hr />
</div>
<h1>Frequently Asked Questions</h1>
<h3>What is the current ratio of this Ring CT?</h3>
<p class="isSelectedEnd">The current ratio is <strong>1200/5A</strong>.</p>
<h3>What is the primary current?</h3>
<p class="isSelectedEnd">The specified primary current is <strong>1200A</strong>.</p>
<h3>What is the secondary current?</h3>
<p class="isSelectedEnd">The secondary current is <strong>5A</strong>.</p>
<h3>What is the accuracy class?</h3>
<p class="isSelectedEnd">This current transformer has a specified <strong>Class 1.0 accuracy class</strong>.</p>
<h3>What is the inner diameter of this CT?</h3>
<p class="isSelectedEnd">The inner diameter is <strong>85 mm</strong>.</p>
<h3>What is the outer diameter?</h3>
<p class="isSelectedEnd">The outer diameter is <strong>135 mm</strong>.</p>
<h3>What is the width of the Ring CT?</h3>
<p class="isSelectedEnd">The specified width is <strong>40 mm</strong>.</p>
<h3>What is the VA rating?</h3>
<p class="isSelectedEnd">The specified VA rating is <strong>2.5–15 VA</strong>.</p>
<h3>What type of CT is this?</h3>
<p class="isSelectedEnd">It is an <strong>encapsulated round-type ring current transformer</strong>.</p>
<h3>Where can the 1200/5A Ring CT be used?</h3>
<p class="isSelectedEnd">It can be used in compatible metering, current measurement, electrical monitoring, distribution panels, control panels and energy monitoring applications.</p>
<h3>What should I check before buying this CT?</h3>
<p class="isSelectedEnd">Check the <strong>1200/5A ratio, 1200A primary current, 5A secondary, Class 1.0 accuracy, 85mm ID, 135mm OD, 40mm width and 2.5–15 VA rating</strong> against your application requirements.</p>
<div>
<hr />
</div>
<h1>Shipping &amp; Bulk Orders</h1>
<p class="isSelectedEnd">MVG Power Solutions supplies current transformers for compatible electrical metering, monitoring and current measurement requirements.</p>
<p class="isSelectedEnd">For bulk requirements, customers can provide the required quantity and application details to receive product and quotation information.</p>
<p class="isSelectedEnd">Shipping charges and delivery time may vary depending on order quantity and destination.</p>
<p class="isSelectedEnd">For bulk orders, confirm the required <strong>CT ratio, quantity, accuracy class, inner diameter and VA rating</strong> before placing the order.</p>', 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/1200-5a-85mm-ring-current-transformer-specifications-scaled.jpg', 1, 'published'),
(235, 1, 60, 1, '800/5A Ring Current Transformer 85mm | Class 1.0 Metering CT', '800-5a-85mm-ring-current-transformer', '13540-MVG-R 85-1-1', 280.00, 280.00, 10, '85043100', 18.00, 'in_stock', '<ul>
<li><strong>Primary Current:</strong> 800A</li>
<li><strong>Secondary Current:</strong> 5A</li>
<li><strong>Current Ratio:</strong> 800/5A</li>
<li><strong>Accuracy Class:</strong> Class 1.0</li>
<li><strong>Inner Diameter (ID):</strong> 85 mm</li>
<li><strong>Outer Diameter (OD):</strong> 135 mm</li>
<li><strong>Width:</strong> 40 mm</li>
<li><strong>VA Rating:</strong> 2.5–15 VA</li>
<li><strong>CT Type:</strong> Encapsulated Round Type Ring Current Transformer</li>
<li><strong>Secondary Output:</strong> 5A</li>
<li><strong>Suitable for:</strong> Metering and current measurement</li>
<li><strong>Suitable for:</strong> Electrical monitoring and compatible panel installations</li>
</ul>', '<h1>Product Overview</h1>
<h2>800/5A 85mm Ring Current Transformer</h2>
<p class="isSelectedEnd">The <strong>800/5A Ring Current Transformer 85mm CT</strong> is a Class 1.0 current transformer designed for compatible electrical metering, current measurement and monitoring applications. It features an <strong>800A primary current</strong> and <strong>5A secondary current</strong>, providing a specified <strong>800/5A current ratio</strong> for compatible meters, measuring instruments and electrical monitoring equipment.</p>
<p class="isSelectedEnd">This current transformer features an <strong>encapsulated round-type ring construction</strong> with an <strong>85 mm inner diameter</strong>, <strong>135 mm outer diameter</strong>, and <strong>40 mm width</strong>. The larger circular opening provides a defined space for compatible conductors or cables. Before installation, the conductor dimensions should be checked against the available 85mm opening.</p>
<p class="isSelectedEnd">With its <strong>Class 1.0 accuracy</strong>, this CT is suitable for applications where the specified metering accuracy is required. The <strong>5A secondary output</strong> can be connected to compatible meters, monitoring instruments and electrical measurement equipment designed for a 5A CT input.</p>
<p class="isSelectedEnd">The transformer has a specified <strong>2.5–15 VA rating</strong>, which should be considered when matching the CT with the connected secondary circuit. The connected meter, measuring equipment and secondary wiring burden should be checked to ensure compatibility.</p>
<p class="isSelectedEnd">The <strong>85 mm inner diameter</strong>, <strong>135 mm outer diameter</strong> and <strong>40 mm width</strong> should also be considered when planning the available installation space inside an electrical panel, enclosure or other compatible location.</p>
<div>
<hr />
</div>
<h1>Key Features</h1>
<p class="isSelectedEnd">The <strong>800/5A 85mm Ring Current Transformer</strong> offers the following features:</p>
<ul data-spread="false">
<li>800/5A current ratio</li>
<li>800A primary current</li>
<li>5A secondary current</li>
<li>Class 1.0 accuracy</li>
<li>85 mm inner diameter</li>
<li>135 mm outer diameter</li>
<li>40 mm width</li>
<li>2.5–15 VA rating</li>
<li>Encapsulated round-type ring construction</li>
<li>Standard 5A secondary output</li>
<li>Suitable for compatible metering applications</li>
<li>Suitable for electrical current measurement</li>
<li>Suitable for current monitoring systems</li>
<li>Suitable for compatible electrical panels and installations</li>
</ul>
<div>
<hr />
</div>
<h1>Technical Specifications</h1>
<table>
<tbody>
<tr>
<th>Parameter</th>
<th>Specification</th>
</tr>
<tr>
<td>Product Type</td>
<td>Current Transformer</td>
</tr>
<tr>
<td>CT Type</td>
<td>Encapsulated Round Type Ring CT</td>
</tr>
<tr>
<td>Primary Current</td>
<td>800A</td>
</tr>
<tr>
<td>Secondary Current</td>
<td>5A</td>
</tr>
<tr>
<td>Current Ratio</td>
<td>800/5A</td>
</tr>
<tr>
<td>Accuracy Class</td>
<td>Class 1.0</td>
</tr>
<tr>
<td>Inner Diameter (ID)</td>
<td>85 mm</td>
</tr>
<tr>
<td>Outer Diameter (OD)</td>
<td>135 mm</td>
</tr>
<tr>
<td>Width</td>
<td>40 mm</td>
</tr>
<tr>
<td>VA Rating</td>
<td>2.5–15 VA</td>
</tr>
<tr>
<td>Application</td>
<td>Metering &amp; Current Measurement</td>
</tr>
</tbody>
</table>
<div>
<hr />
</div>
<h1>800/5A Ring Current Transformer for Metering</h1>
<p class="isSelectedEnd">The <strong>800/5A Ring Current Transformer</strong> is designed for compatible electrical metering and current measurement systems. With an <strong>800A primary current and 5A secondary output</strong>, it provides a specified current transformation ratio for compatible 5A measurement equipment.</p>
<p class="isSelectedEnd">Current transformers are commonly used in electrical systems where current measurement is performed through compatible meters or monitoring instruments. The transformer provides a secondary current corresponding to its specified ratio for use with suitable measurement equipment.</p>
<p class="isSelectedEnd">For this product, the specified current ratio is <strong>800/5A</strong>. The connected meter or monitoring instrument should be selected according to the CT&#8217;s 5A secondary requirement and the requirements of the overall electrical installation.</p>
<p class="isSelectedEnd">The CT should be selected after checking the required primary current, secondary current, accuracy class, burden, conductor dimensions and physical installation requirements.</p>
<div>
<hr />
</div>
<h1>85mm Inner Diameter Ring CT</h1>
<p class="isSelectedEnd">This model features an <strong>85 mm inner diameter</strong>, providing a larger circular opening for compatible conductors and cables.</p>
<p class="isSelectedEnd">The conductor or cable dimensions should be checked before installation to ensure they can pass through the <strong>85mm opening</strong>. Adequate clearance should be available so the CT can be positioned correctly around the conductor.</p>
<p class="isSelectedEnd">The <strong>135 mm outer diameter</strong> and <strong>40 mm width</strong> should also be considered when determining available space inside an electrical panel, enclosure or other installation location.</p>
<p class="isSelectedEnd">The ring-type construction provides a defined circular CT configuration for compatible electrical measurement and monitoring installations.</p>
<div>
<hr />
</div>
<h1>Class 1.0 Metering Accuracy</h1>
<p class="isSelectedEnd">The <strong>Class 1.0 accuracy</strong> specification is an important consideration when selecting this current transformer for compatible metering and measurement applications.</p>
<p class="isSelectedEnd">The CT should be used with suitable measuring equipment and within the conditions applicable to its specified accuracy class. The complete secondary circuit, including connected equipment and wiring, should be considered during installation planning.</p>
<p class="isSelectedEnd">For applications requiring Class 1.0 accuracy, the <strong>800/5A Class 1.0 Ring CT</strong> can be considered when its ratio, burden, dimensions and other specifications match the requirements of the electrical system.</p>
<div>
<hr />
</div>
<h1>Standard 5A Secondary Output</h1>
<p class="isSelectedEnd">The <strong>5A secondary output</strong> makes this current transformer suitable for compatible meters and measurement instruments designed for a 5A CT input.</p>
<p class="isSelectedEnd">The secondary rating should match the input specification of the connected measuring equipment. For this product, the specified configuration is <strong>800A primary / 5A secondary</strong>.</p>
<p class="isSelectedEnd">The secondary circuit should be connected according to the requirements of the CT, measuring equipment and overall electrical installation.</p>
<div>
<hr />
</div>
<h1>2.5–15 VA Rating</h1>
<p class="isSelectedEnd">The <strong>800/5A 85mm Ring CT</strong> has a specified <strong>2.5–15 VA rating</strong>.</p>
<p class="isSelectedEnd">VA rating is an important consideration when selecting a current transformer because the connected secondary circuit introduces a burden. This may include the connected meter, measuring instrument and secondary wiring.</p>
<p class="isSelectedEnd">Before installation, the expected connected burden should be checked against the specified <strong>2.5–15 VA</strong> range to ensure that the transformer is appropriate for the intended application.</p>
<div>
<hr />
</div>
<h1>Applications</h1>
<p class="isSelectedEnd">The <strong>800/5A 85mm Ring Current Transformer</strong> can be used in compatible applications such as:</p>
<ul data-spread="false">
<li>Energy metering systems</li>
<li>Electrical current measurement</li>
<li>Current monitoring systems</li>
<li>Power monitoring systems</li>
<li>Metering panels</li>
<li>Electrical distribution panels</li>
<li>Electrical control panels</li>
<li>Industrial electrical installations</li>
<li>Electrical monitoring equipment</li>
<li>Energy measurement systems</li>
<li>Current measurement equipment</li>
<li>Compatible panel metering applications</li>
</ul>
<p class="isSelectedEnd">The CT should be selected according to the required current ratio, secondary current, accuracy class, burden, conductor dimensions and installation requirements.</p>
<div>
<hr />
</div>
<h1>Benefits of 800/5A 85mm Ring Current Transformer</h1>
<h3>Class 1.0 Accuracy</h3>
<p class="isSelectedEnd">The Class 1.0 specification makes this CT suitable for compatible applications requiring the specified metering accuracy.</p>
<h3>800/5A Current Ratio</h3>
<p class="isSelectedEnd">The specified <strong>800/5A ratio</strong> provides a 5A secondary output for compatible current measurement and metering equipment.</p>
<h3>85mm Inner Diameter</h3>
<p class="isSelectedEnd">The <strong>85mm inner diameter</strong> provides a larger defined circular opening for compatible conductors and cables.</p>
<h3>Encapsulated Ring Construction</h3>
<p class="isSelectedEnd">The encapsulated round-type construction provides a ring-style configuration suitable for compatible electrical measurement installations.</p>
<h3>Standard 5A Secondary</h3>
<p class="isSelectedEnd">The 5A secondary output is suitable for compatible measuring equipment designed for a 5A CT input.</p>
<h3>2.5–15 VA Rating</h3>
<p class="isSelectedEnd">The specified <strong>2.5–15 VA rating</strong> allows the CT to be matched with compatible secondary circuits according to their connected burden.</p>
<h3>Defined Physical Dimensions</h3>
<p class="isSelectedEnd">The <strong>135mm OD × 40mm width</strong> provides defined physical dimensions that can be considered during electrical panel and installation planning.</p>
<div>
<hr />
</div>
<h1>Installation Considerations</h1>
<p class="isSelectedEnd">Before installing the <strong>800/5A 85mm Ring Current Transformer</strong>, check the following:</p>
<ol start="1" data-spread="false">
<li>Confirm that the required CT ratio is <strong>800/5A</strong>.</li>
<li>Confirm that the primary current requirement is <strong>800A</strong>.</li>
<li>Verify that the connected equipment requires a <strong>5A secondary</strong>.</li>
<li>Confirm that the required accuracy class is <strong>Class 1.0</strong>.</li>
<li>Check that the conductor or cable fits through the <strong>85mm inner diameter</strong>.</li>
<li>Check the available space against the <strong>135mm outer diameter and 40mm width</strong>.</li>
<li>Verify that the connected secondary burden is compatible with the <strong>2.5–15 VA</strong> rating.</li>
<li>Ensure that the CT secondary connections are made according to the requirements of the electrical installation.</li>
</ol>
<p class="isSelectedEnd">Installation should be performed by a suitably qualified electrical professional following applicable electrical safety practices.</p>
<div>
<hr />
</div>
<h1>Why Choose an 800/5A 85mm Class 1.0 Ring CT?</h1>
<p class="isSelectedEnd">The <strong>800/5A 85mm Ring Current Transformer</strong> combines an <strong>800A primary current</strong>, <strong>5A secondary output</strong>, <strong>Class 1.0 accuracy</strong> and encapsulated ring-type construction.</p>
<p class="isSelectedEnd">Its <strong>85mm inner diameter</strong> provides a larger circular opening for compatible conductors, while the <strong>135mm outer diameter and 40mm width</strong> provide important physical dimensions for installation planning.</p>
<p class="isSelectedEnd">The specified <strong>2.5–15 VA rating</strong> can be considered when matching the CT with the connected metering or measurement circuit.</p>
<p class="isSelectedEnd">Before selecting the CT, users should verify the required current ratio, primary current, secondary current, accuracy class, conductor size, burden and available installation space.</p>
<div>
<hr />
</div>
<h1>Product Summary</h1>
<p class="isSelectedEnd">The <strong>800/5A Ring Current Transformer 85mm CT</strong> is an encapsulated round-type current transformer featuring:</p>
<ul data-spread="false">
<li><strong>800A primary current</strong></li>
<li><strong>5A secondary current</strong></li>
<li><strong>800/5A current ratio</strong></li>
<li><strong>Class 1.0 accuracy</strong></li>
<li><strong>85mm inner diameter</strong></li>
<li><strong>135mm outer diameter</strong></li>
<li><strong>40mm width</strong></li>
<li><strong>2.5–15 VA rating</strong></li>
</ul>
<p class="isSelectedEnd">It is suitable for compatible metering, electrical current measurement and monitoring applications where these specifications meet the requirements of the electrical system.</p>
<div>
<hr />
</div>
<h1>Frequently Asked Questions</h1>
<h3>What is the current ratio of this Ring CT?</h3>
<p class="isSelectedEnd">The current ratio is <strong>800/5A</strong>.</p>
<h3>What is the primary current?</h3>
<p class="isSelectedEnd">The specified primary current is <strong>800A</strong>.</p>
<h3>What is the secondary current?</h3>
<p class="isSelectedEnd">The secondary current is <strong>5A</strong>.</p>
<h3>What is the accuracy class?</h3>
<p class="isSelectedEnd">This current transformer has a specified <strong>Class 1.0 accuracy class</strong>.</p>
<h3>What is the inner diameter of this CT?</h3>
<p class="isSelectedEnd">The inner diameter is <strong>85 mm</strong>.</p>
<h3>What is the outer diameter?</h3>
<p class="isSelectedEnd">The outer diameter is <strong>135 mm</strong>.</p>
<h3>What is the width of the Ring CT?</h3>
<p class="isSelectedEnd">The specified width is <strong>40 mm</strong>.</p>
<h3>What is the VA rating?</h3>
<p class="isSelectedEnd">The specified VA rating is <strong>2.5–15 VA</strong>.</p>
<h3>What type of CT is this?</h3>
<p class="isSelectedEnd">It is an <strong>encapsulated round-type ring current transformer</strong>.</p>
<h3>Where can the 800/5A Ring CT be used?</h3>
<p class="isSelectedEnd">It can be used in compatible metering, current measurement, electrical monitoring, distribution panels, control panels and energy monitoring applications.</p>
<h3>What should I check before buying this CT?</h3>
<p class="isSelectedEnd">Check the <strong>800/5A ratio, 800A primary current, 5A secondary, Class 1.0 accuracy, 85mm ID, 135mm OD, 40mm width and 2.5–15 VA rating</strong> against your application requirements.</p>
<div>
<hr />
</div>
<h1>Shipping &amp; Bulk Orders</h1>
<p class="isSelectedEnd">MVG Power Solutions supplies current transformers for compatible electrical metering, monitoring and current measurement requirements.</p>
<p class="isSelectedEnd">For bulk requirements, customers can provide the required quantity and application details to receive product and quotation information.</p>
<p class="isSelectedEnd">Shipping charges and delivery time may vary depending on order quantity and destination.</p>
<p>For bulk orders, confirm the required <strong>CT ratio, quantity, accuracy class, inner diameter and VA rating</strong> before placing the order.</p>', 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/800-5a-85mm-ring-current-transformer-specifications-scaled.jpg', 1, 'published'),
(232, 1, 60, 1, '1000/5A Ring Current Transformer 85mm | Class 1.0 Metering CT', '1000-5a-85mm-ring-current-transformer', '13540-MVG-R 85-1', 280.00, 280.00, 10, '85043100', 18.00, 'in_stock', '<ul data-spread="false">
<li><strong>Primary Current:</strong> 1000A</li>
<li><strong>Secondary Current:</strong> 5A</li>
<li><strong>Current Ratio:</strong> 1000/5A</li>
<li><strong>Accuracy Class:</strong> Class 1.0</li>
<li><strong>Inner Diameter (ID):</strong> 85 mm</li>
<li><strong>Outer Diameter (OD):</strong> 135 mm</li>
<li><strong>Width:</strong> 40 mm</li>
<li><strong>VA Rating:</strong> 2.5–15 VA</li>
<li><strong>CT Type:</strong> Encapsulated Round Type Ring Current Transformer</li>
<li><strong>Secondary Output:</strong> 5A</li>
<li><strong>Suitable for:</strong> Metering and current measurement</li>
<li><strong>Suitable for:</strong> Electrical monitoring and compatible panel installations</li>
</ul>
<div>
<hr />
</div>
<h1></h1>', '<h1>Product Overview</h1>
<h2>1000/5A 85mm Ring Current Transformer</h2>
<p>The <strong>1000/5A Ring Current Transformer 85mm CT</strong> is a Class 1.0 current transformer designed for compatible electrical metering, current measurement and monitoring applications. It features a <strong>1000A primary current</strong> and <strong>5A secondary current</strong>, providing a specified <strong>1000/5A current ratio</strong> for compatible meters, measuring instruments and electrical monitoring equipment.</p>
<p>This current transformer features an <strong>encapsulated round-type ring construction</strong> with an <strong>85 mm inner diameter</strong>, <strong>135 mm outer diameter</strong>, and <strong>40 mm width</strong>. The larger circular opening provides a defined space for compatible conductors or cables and should be checked against the conductor dimensions before installation.</p>
<p>With its <strong>Class 1.0 accuracy</strong>, this CT is suitable for applications where the specified metering accuracy is required. The <strong>5A secondary output</strong> can be connected to compatible meters, monitoring instruments and electrical measurement equipment designed for a 5A CT input.</p>
<p>The transformer has a specified <strong>2.5–15 VA rating</strong>, which should be considered when matching the CT with the connected secondary circuit. The connected meter, measuring equipment and secondary wiring burden should be checked to ensure compatibility.</p>
<p>The <strong>85 mm inner diameter</strong>, <strong>135 mm outer diameter</strong> and <strong>40 mm width</strong> should also be considered when planning the available installation space inside an electrical panel, enclosure or other compatible location.</p>
<hr />
<h1>Key Features</h1>
<p>The <strong>1000/5A 85mm Ring Current Transformer</strong> offers the following features:</p>
<ul>
<li>1000/5A current ratio</li>
<li>1000A primary current</li>
<li>5A secondary current</li>
<li>Class 1.0 accuracy</li>
<li>85 mm inner diameter</li>
<li>135 mm outer diameter</li>
<li>40 mm width</li>
<li>2.5–15 VA rating</li>
<li>Encapsulated round-type ring construction</li>
<li>Standard 5A secondary output</li>
<li>Suitable for compatible metering applications</li>
<li>Suitable for electrical current measurement</li>
<li>Suitable for current monitoring systems</li>
<li>Suitable for compatible electrical panels and installations</li>
</ul>
<hr />
<h1>Technical Specifications</h1>
<table>
<thead>
<tr>
<th>Parameter</th>
<th>Specification</th>
</tr>
</thead>
<tbody>
<tr>
<td>Product Type</td>
<td>Current Transformer</td>
</tr>
<tr>
<td>CT Type</td>
<td>Encapsulated Round Type Ring CT</td>
</tr>
<tr>
<td>Primary Current</td>
<td>1000A</td>
</tr>
<tr>
<td>Secondary Current</td>
<td>5A</td>
</tr>
<tr>
<td>Current Ratio</td>
<td>1000/5A</td>
</tr>
<tr>
<td>Accuracy Class</td>
<td>Class 1.0</td>
</tr>
<tr>
<td>Inner Diameter (ID)</td>
<td>85 mm</td>
</tr>
<tr>
<td>Outer Diameter (OD)</td>
<td>135 mm</td>
</tr>
<tr>
<td>Width</td>
<td>40 mm</td>
</tr>
<tr>
<td>VA Rating</td>
<td>2.5–15 VA</td>
</tr>
<tr>
<td>Application</td>
<td>Metering &amp; Current Measurement</td>
</tr>
</tbody>
</table>
<hr />
<h1>1000/5A Ring Current Transformer for Metering</h1>
<p>The <strong>1000/5A Ring Current Transformer</strong> is designed for compatible electrical metering and current measurement systems. With a <strong>1000A primary current and 5A secondary output</strong>, it provides a specified current transformation ratio for compatible 5A measurement equipment.</p>
<p>Current transformers are commonly used in electrical systems where current measurement is performed through compatible meters or monitoring instruments. The transformer provides a secondary current corresponding to its specified ratio for use with suitable measurement equipment.</p>
<p>For this product, the specified current ratio is <strong>1000/5A</strong>. The connected meter or monitoring instrument should be selected according to the CT&#8217;s 5A secondary requirement and the requirements of the overall electrical installation.</p>
<p>The CT should be selected after checking the required primary current, secondary current, accuracy class, burden, conductor dimensions and physical installation requirements.</p>
<hr />
<h1>85mm Inner Diameter Ring CT</h1>
<p>This model features an <strong>85 mm inner diameter</strong>, providing a larger circular opening for compatible conductors and cables.</p>
<p>The conductor or cable dimensions should be checked before installation to ensure they can pass through the <strong>85mm opening</strong>. Adequate clearance should be available so the CT can be positioned correctly around the conductor.</p>
<p>The <strong>135 mm outer diameter</strong> and <strong>40 mm width</strong> should also be considered when determining available space inside an electrical panel, enclosure or other installation location.</p>
<p>The ring-type construction provides a defined circular CT configuration for compatible electrical measurement and monitoring installations.</p>
<hr />
<h1>Class 1.0 Metering Accuracy</h1>
<p>The <strong>Class 1.0 accuracy</strong> specification is an important consideration when selecting this current transformer for compatible metering and measurement applications.</p>
<p>The CT should be used with suitable measuring equipment and within the conditions applicable to its specified accuracy class. The complete secondary circuit, including connected equipment and wiring, should be considered during installation planning.</p>
<p>For applications requiring Class 1.0 accuracy, the <strong>1000/5A Class 1.0 Ring CT</strong> can be considered when its ratio, burden, dimensions and other specifications match the requirements of the electrical system.</p>
<hr />
<h1>Standard 5A Secondary Output</h1>
<p>The <strong>5A secondary output</strong> makes this current transformer suitable for compatible meters and measurement instruments designed for a 5A CT input.</p>
<p>The secondary rating should match the input specification of the connected measuring equipment. For this product, the specified configuration is <strong>1000A primary / 5A secondary</strong>.</p>
<p>The secondary circuit should be connected according to the requirements of the CT, measuring equipment and overall electrical installation.</p>
<hr />
<h1>2.5–15 VA Rating</h1>
<p>The <strong>1000/5A 85mm Ring CT</strong> has a specified <strong>2.5–15 VA rating</strong>.</p>
<p>VA rating is an important consideration when selecting a current transformer because the connected secondary circuit introduces a burden. This may include the connected meter, measuring instrument and secondary wiring.</p>
<p>Before installation, the expected connected burden should be checked against the specified <strong>2.5–15 VA</strong> range to ensure that the transformer is appropriate for the intended application.</p>
<hr />
<h1>Applications</h1>
<p>The <strong>1000/5A 85mm Ring Current Transformer</strong> can be used in compatible applications such as:</p>
<ul>
<li>Energy metering systems</li>
<li>Electrical current measurement</li>
<li>Current monitoring systems</li>
<li>Power monitoring systems</li>
<li>Metering panels</li>
<li>Electrical distribution panels</li>
<li>Electrical control panels</li>
<li>Industrial electrical installations</li>
<li>Electrical monitoring equipment</li>
<li>Energy measurement systems</li>
<li>Current measurement equipment</li>
<li>Compatible panel metering applications</li>
</ul>
<p>The CT should be selected according to the required current ratio, secondary current, accuracy class, burden, conductor dimensions and installation requirements.</p>
<hr />
<h1>Benefits of 1000/5A 85mm Ring Current Transformer</h1>
<h3>Class 1.0 Accuracy</h3>
<p>The Class 1.0 specification makes this CT suitable for compatible applications requiring the specified metering accuracy.</p>
<h3>1000/5A Current Ratio</h3>
<p>The specified <strong>1000/5A ratio</strong> provides a 5A secondary output for compatible current measurement and metering equipment.</p>
<h3>85mm Inner Diameter</h3>
<p>The <strong>85mm inner diameter</strong> provides a larger defined circular opening for compatible conductors and cables.</p>
<h3>Encapsulated Ring Construction</h3>
<p>The encapsulated round-type construction provides a ring-style configuration suitable for compatible electrical measurement installations.</p>
<h3>Standard 5A Secondary</h3>
<p>The 5A secondary output is suitable for compatible measuring equipment designed for a 5A CT input.</p>
<h3>2.5–15 VA Rating</h3>
<p>The specified <strong>2.5–15 VA rating</strong> allows the CT to be matched with compatible secondary circuits according to their connected burden.</p>
<h3>Defined Physical Dimensions</h3>
<p>The <strong>135mm OD × 40mm width</strong> provides defined physical dimensions that can be considered during electrical panel and installation planning.</p>
<hr />
<h1>Installation Considerations</h1>
<p>Before installing the <strong>1000/5A 85mm Ring Current Transformer</strong>, check the following:</p>
<ol>
<li>Confirm that the required CT ratio is <strong>1000/5A</strong>.</li>
<li>Confirm that the primary current requirement is <strong>1000A</strong>.</li>
<li>Verify that the connected equipment requires a <strong>5A secondary</strong>.</li>
<li>Confirm that the required accuracy class is <strong>Class 1.0</strong>.</li>
<li>Check that the conductor or cable fits through the <strong>85mm inner diameter</strong>.</li>
<li>Check the available space against the <strong>135mm outer diameter and 40mm width</strong>.</li>
<li>Verify that the connected secondary burden is compatible with the <strong>2.5–15 VA</strong> rating.</li>
<li>Ensure that the CT secondary connections are made according to the requirements of the electrical installation.</li>
</ol>
<p>Installation should be performed by a suitably qualified electrical professional following applicable electrical safety practices.</p>
<hr />
<h1>Why Choose a 1000/5A 85mm Class 1.0 Ring CT?</h1>
<p>The <strong>1000/5A 85mm Ring Current Transformer</strong> combines a <strong>1000A primary current</strong>, <strong>5A secondary output</strong>, <strong>Class 1.0 accuracy</strong> and encapsulated ring-type construction.</p>
<p>Its <strong>85mm inner diameter</strong> provides a larger circular opening for compatible conductors, while the <strong>135mm outer diameter and 40mm width</strong> provide important physical dimensions for installation planning.</p>
<p>The specified <strong>2.5–15 VA rating</strong> can be considered when matching the CT with the connected metering or measurement circuit.</p>
<p>Before selecting the CT, users should verify the required current ratio, primary current, secondary current, accuracy class, conductor size, burden and available installation space.</p>
<hr />
<h1>Product Summary</h1>
<p>The <strong>1000/5A Ring Current Transformer 85mm CT</strong> is an encapsulated round-type current transformer featuring:</p>
<ul>
<li><strong>1000A primary current</strong></li>
<li><strong>5A secondary current</strong></li>
<li><strong>1000/5A current ratio</strong></li>
<li><strong>Class 1.0 accuracy</strong></li>
<li><strong>85mm inner diameter</strong></li>
<li><strong>135mm outer diameter</strong></li>
<li><strong>40mm width</strong></li>
<li><strong>2.5–15 VA rating</strong></li>
</ul>
<p>It is suitable for compatible metering, electrical current measurement and monitoring applications where these specifications meet the requirements of the electrical system.</p>
<hr />
<h1>Frequently Asked Questions</h1>
<h3>What is the current ratio of this Ring CT?</h3>
<p>The current ratio is <strong>1000/5A</strong>.</p>
<h3>What is the primary current?</h3>
<p>The specified primary current is <strong>1000A</strong>.</p>
<h3>What is the secondary current?</h3>
<p>The secondary current is <strong>5A</strong>.</p>
<h3>What is the accuracy class?</h3>
<p>This current transformer has a specified <strong>Class 1.0 accuracy class</strong>.</p>
<h3>What is the inner diameter of this CT?</h3>
<p>The inner diameter is <strong>85 mm</strong>.</p>
<h3>What is the outer diameter?</h3>
<p>The outer diameter is <strong>135 mm</strong>.</p>
<h3>What is the width of the Ring CT?</h3>
<p>The specified width is <strong>40 mm</strong>.</p>
<h3>What is the VA rating?</h3>
<p>The specified VA rating is <strong>2.5–15 VA</strong>.</p>
<h3>What type of CT is this?</h3>
<p>It is an <strong>encapsulated round-type ring current transformer</strong>.</p>
<h3>Where can the 1000/5A Ring CT be used?</h3>
<p>It can be used in compatible metering, current measurement, electrical monitoring, distribution panels, control panels and energy monitoring applications.</p>
<h3>What should I check before buying this CT?</h3>
<p>Check the <strong>1000/5A ratio, 1000A primary current, 5A secondary, Class 1.0 accuracy, 85mm ID, 135mm OD, 40mm width and 2.5–15 VA rating</strong> against your application requirements.</p>
<hr />
<h1>Shipping &amp; Bulk Orders</h1>
<p>MVG Power Solutions supplies current transformers for compatible electrical metering, monitoring and current measurement requirements.</p>
<p>For bulk requirements, customers can provide the required quantity and application details to receive product and quotation information.</p>
<p>Shipping charges and delivery time may vary depending on order quantity and destination.</p>
<p>For bulk orders, confirm the required <strong>CT ratio, quantity, accuracy class, inner diameter and VA rating</strong> before placing the order.</p>', 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/1000-5a-85mm-ring-current-transformer-specifications-scaled.jpg', 0, 'published'),
(229, 1, 60, 1, '600/5A Ring Current Transformer 85mm | Class 1.0 Metering CT', '600-5a-85mm-ring-current-transformer', '13540-MVG-R 85', 280.00, 280.00, 10, '85043100', 18.00, 'in_stock', '<ul data-spread="false">
<li><strong>Primary Current:</strong> 1000A</li>
<li><strong>Secondary Current:</strong> 5A</li>
<li><strong>Current Ratio:</strong> 1000/5A</li>
<li><strong>Accuracy Class:</strong> Class 1.0</li>
<li><strong>Inner Diameter (ID):</strong> 65 mm</li>
<li><strong>Outer Diameter (OD):</strong> 120 mm</li>
<li><strong>Width:</strong> 40 mm</li>
<li><strong>VA Rating:</strong> 2.5–15 VA</li>
<li><strong>CT Type:</strong> Encapsulated Round Type Ring Current Transformer</li>
<li><strong>Secondary Output:</strong> 5A</li>
<li><strong>Suitable for:</strong> Metering and current measurement</li>
<li><strong>Suitable for:</strong> Electrical monitoring and compatible panel installations</li>
</ul>
<div>
<hr />
</div>
<h1></h1>', '<h1>Product Overview</h1>
<h2>600/5A 85mm Ring Current Transformer</h2>
<p>The <strong>600/5A Ring Current Transformer 85mm CT</strong> is a Class 1.0 current transformer designed for compatible electrical metering, current measurement and monitoring applications. It features a <strong>600A primary current</strong> and <strong>5A secondary current</strong>, providing a specified <strong>600/5A current ratio</strong> for compatible meters, measuring instruments and electrical monitoring equipment.</p>
<p>This current transformer features an <strong>encapsulated round-type ring construction</strong> with an <strong>85 mm inner diameter</strong>, <strong>135 mm outer diameter</strong>, and <strong>40 mm width</strong>. The larger circular opening provides a defined space for compatible conductors or cables and should be checked against the conductor dimensions before installation.</p>
<p>With its <strong>Class 1.0 accuracy</strong>, this CT is suitable for applications where the specified metering accuracy is required. The <strong>5A secondary output</strong> can be connected to compatible meters, monitoring instruments and electrical measurement equipment designed for a 5A CT input.</p>
<p>The transformer has a specified <strong>2.5–15 VA rating</strong>, which should be considered when matching the CT with the connected secondary circuit. The connected meter, measuring equipment and secondary wiring burden should be checked to ensure compatibility.</p>
<p>The <strong>85 mm inner diameter</strong>, <strong>135 mm outer diameter</strong> and <strong>40 mm width</strong> should also be considered when planning the available installation space inside an electrical panel, enclosure or other compatible location.</p>
<hr />
<h1>Key Features</h1>
<p>The <strong>600/5A 85mm Ring Current Transformer</strong> offers the following features:</p>
<ul>
<li>600/5A current ratio</li>
<li>600A primary current</li>
<li>5A secondary current</li>
<li>Class 1.0 accuracy</li>
<li>85 mm inner diameter</li>
<li>135 mm outer diameter</li>
<li>40 mm width</li>
<li>2.5–15 VA rating</li>
<li>Encapsulated round-type ring construction</li>
<li>Standard 5A secondary output</li>
<li>Suitable for compatible metering applications</li>
<li>Suitable for electrical current measurement</li>
<li>Suitable for current monitoring systems</li>
<li>Suitable for compatible electrical panels and installations</li>
</ul>
<hr />
<h1>Technical Specifications</h1>
<table>
<thead>
<tr>
<th>Parameter</th>
<th>Specification</th>
</tr>
</thead>
<tbody>
<tr>
<td>Product Type</td>
<td>Current Transformer</td>
</tr>
<tr>
<td>CT Type</td>
<td>Encapsulated Round Type Ring CT</td>
</tr>
<tr>
<td>Primary Current</td>
<td>600A</td>
</tr>
<tr>
<td>Secondary Current</td>
<td>5A</td>
</tr>
<tr>
<td>Current Ratio</td>
<td>600/5A</td>
</tr>
<tr>
<td>Accuracy Class</td>
<td>Class 1.0</td>
</tr>
<tr>
<td>Inner Diameter (ID)</td>
<td>85 mm</td>
</tr>
<tr>
<td>Outer Diameter (OD)</td>
<td>135 mm</td>
</tr>
<tr>
<td>Width</td>
<td>40 mm</td>
</tr>
<tr>
<td>VA Rating</td>
<td>2.5–15 VA</td>
</tr>
<tr>
<td>Application</td>
<td>Metering &amp; Current Measurement</td>
</tr>
</tbody>
</table>
<hr />
<h1>600/5A Ring Current Transformer for Metering</h1>
<p>The <strong>600/5A Ring Current Transformer</strong> is designed for compatible electrical metering and current measurement systems. With a <strong>600A primary current and 5A secondary output</strong>, it provides a specified current transformation ratio for compatible 5A measurement equipment.</p>
<p>Current transformers are commonly used in electrical systems where current measurement is performed through compatible meters or monitoring instruments. The transformer provides a secondary current corresponding to its specified ratio for use with suitable measurement equipment.</p>
<p>For this product, the specified current ratio is <strong>600/5A</strong>. The connected meter or monitoring instrument should be selected according to the CT&#8217;s 5A secondary requirement and the requirements of the overall electrical installation.</p>
<p>The CT should be selected after checking the required primary current, secondary current, accuracy class, burden, conductor dimensions and physical installation requirements.</p>
<hr />
<h1>85mm Inner Diameter Ring CT</h1>
<p>This model features an <strong>85 mm inner diameter</strong>, providing a larger circular opening for compatible conductors and cables.</p>
<p>The conductor or cable dimensions should be checked before installation to ensure they can pass through the <strong>85mm opening</strong>. Adequate clearance should be available so the CT can be positioned correctly around the conductor.</p>
<p>The <strong>135 mm outer diameter</strong> and <strong>40 mm width</strong> should also be considered when determining available space inside an electrical panel, enclosure or other installation location.</p>
<p>The ring-type construction provides a defined circular CT configuration for compatible electrical measurement and monitoring installations.</p>
<hr />
<h1>Class 1.0 Metering Accuracy</h1>
<p>The <strong>Class 1.0 accuracy</strong> specification is an important consideration when selecting this current transformer for compatible metering and measurement applications.</p>
<p>The CT should be used with suitable measuring equipment and within the conditions applicable to its specified accuracy class. The complete secondary circuit, including connected equipment and wiring, should be considered during installation planning.</p>
<p>For applications requiring Class 1.0 accuracy, the <strong>600/5A Class 1.0 Ring CT</strong> can be considered when its ratio, burden, dimensions and other specifications match the requirements of the electrical system.</p>
<hr />
<h1>Standard 5A Secondary Output</h1>
<p>The <strong>5A secondary output</strong> makes this current transformer suitable for compatible meters and measurement instruments designed for a 5A CT input.</p>
<p>The secondary rating should match the input specification of the connected measuring equipment. For this product, the specified configuration is <strong>600A primary / 5A secondary</strong>.</p>
<p>The secondary circuit should be connected according to the requirements of the CT, measuring equipment and overall electrical installation.</p>
<hr />
<h1>2.5–15 VA Rating</h1>
<p>The <strong>600/5A 85mm Ring CT</strong> has a specified <strong>2.5–15 VA rating</strong>.</p>
<p>VA rating is an important consideration when selecting a current transformer because the connected secondary circuit introduces a burden. This may include the connected meter, measuring instrument and secondary wiring.</p>
<p>Before installation, the expected connected burden should be checked against the specified <strong>2.5–15 VA</strong> range to ensure that the transformer is appropriate for the intended application.</p>
<hr />
<h1>Applications</h1>
<p>The <strong>600/5A 85mm Ring Current Transformer</strong> can be used in compatible applications such as:</p>
<ul>
<li>Energy metering systems</li>
<li>Electrical current measurement</li>
<li>Current monitoring systems</li>
<li>Power monitoring systems</li>
<li>Metering panels</li>
<li>Electrical distribution panels</li>
<li>Electrical control panels</li>
<li>Industrial electrical installations</li>
<li>Electrical monitoring equipment</li>
<li>Energy measurement systems</li>
<li>Current measurement equipment</li>
<li>Compatible panel metering applications</li>
</ul>
<p>The CT should be selected according to the required current ratio, secondary current, accuracy class, burden, conductor dimensions and installation requirements.</p>
<hr />
<h1>Benefits of 600/5A 85mm Ring Current Transformer</h1>
<h3>Class 1.0 Accuracy</h3>
<p>The Class 1.0 specification makes this CT suitable for compatible applications requiring the specified metering accuracy.</p>
<h3>600/5A Current Ratio</h3>
<p>The specified <strong>600/5A ratio</strong> provides a 5A secondary output for compatible current measurement and metering equipment.</p>
<h3>85mm Inner Diameter</h3>
<p>The <strong>85mm inner diameter</strong> provides a larger defined circular opening for compatible conductors and cables.</p>
<h3>Encapsulated Ring Construction</h3>
<p>The encapsulated round-type construction provides a ring-style configuration suitable for compatible electrical measurement installations.</p>
<h3>Standard 5A Secondary</h3>
<p>The 5A secondary output is suitable for compatible measuring equipment designed for a 5A CT input.</p>
<h3>2.5–15 VA Rating</h3>
<p>The specified <strong>2.5–15 VA rating</strong> allows the CT to be matched with compatible secondary circuits according to their connected burden.</p>
<h3>Defined Physical Dimensions</h3>
<p>The <strong>135mm OD × 40mm width</strong> provides defined physical dimensions that can be considered during electrical panel and installation planning.</p>
<hr />
<h1>Installation Considerations</h1>
<p>Before installing the <strong>600/5A 85mm Ring Current Transformer</strong>, check the following:</p>
<ol>
<li>Confirm that the required CT ratio is <strong>600/5A</strong>.</li>
<li>Confirm that the primary current requirement is <strong>600A</strong>.</li>
<li>Verify that the connected equipment requires a <strong>5A secondary</strong>.</li>
<li>Confirm that the required accuracy class is <strong>Class 1.0</strong>.</li>
<li>Check that the conductor or cable fits through the <strong>85mm inner diameter</strong>.</li>
<li>Check the available space against the <strong>135mm outer diameter and 40mm width</strong>.</li>
<li>Verify that the connected secondary burden is compatible with the <strong>2.5–15 VA</strong> rating.</li>
<li>Ensure that the CT secondary connections are made according to the requirements of the electrical installation.</li>
</ol>
<p>Installation should be performed by a suitably qualified electrical professional following applicable electrical safety practices.</p>
<hr />
<h1>Why Choose a 600/5A 85mm Class 1.0 Ring CT?</h1>
<p>The <strong>600/5A 85mm Ring Current Transformer</strong> combines a <strong>600A primary current</strong>, <strong>5A secondary output</strong>, <strong>Class 1.0 accuracy</strong> and encapsulated ring-type construction.</p>
<p>Its <strong>85mm inner diameter</strong> provides a larger circular opening for compatible conductors, while the <strong>135mm outer diameter and 40mm width</strong> provide important physical dimensions for installation planning.</p>
<p>The specified <strong>2.5–15 VA rating</strong> can be considered when matching the CT with the connected metering or measurement circuit.</p>
<p>Before selecting the CT, users should verify the required current ratio, primary current, secondary current, accuracy class, conductor size, burden and available installation space.</p>
<hr />
<h1>Product Summary</h1>
<p>The <strong>600/5A Ring Current Transformer 85mm CT</strong> is an encapsulated round-type current transformer featuring:</p>
<ul>
<li><strong>600A primary current</strong></li>
<li><strong>5A secondary current</strong></li>
<li><strong>600/5A current ratio</strong></li>
<li><strong>Class 1.0 accuracy</strong></li>
<li><strong>85mm inner diameter</strong></li>
<li><strong>135mm outer diameter</strong></li>
<li><strong>40mm width</strong></li>
<li><strong>2.5–15 VA rating</strong></li>
</ul>
<p>It is suitable for compatible metering, electrical current measurement and monitoring applications where these specifications meet the requirements of the electrical system.</p>
<hr />
<h1>Frequently Asked Questions</h1>
<h3>What is the current ratio of this Ring CT?</h3>
<p>The current ratio is <strong>600/5A</strong>.</p>
<h3>What is the primary current?</h3>
<p>The specified primary current is <strong>600A</strong>.</p>
<h3>What is the secondary current?</h3>
<p>The secondary current is <strong>5A</strong>.</p>
<h3>What is the accuracy class?</h3>
<p>This current transformer has a specified <strong>Class 1.0 accuracy class</strong>.</p>
<h3>What is the inner diameter of this CT?</h3>
<p>The inner diameter is <strong>85 mm</strong>.</p>
<h3>What is the outer diameter?</h3>
<p>The outer diameter is <strong>135 mm</strong>.</p>
<h3>What is the width of the Ring CT?</h3>
<p>The specified width is <strong>40 mm</strong>.</p>
<h3>What is the VA rating?</h3>
<p>The specified VA rating is <strong>2.5–15 VA</strong>.</p>
<h3>What type of CT is this?</h3>
<p>It is an <strong>encapsulated round-type ring current transformer</strong>.</p>
<h3>Where can the 600/5A Ring CT be used?</h3>
<p>It can be used in compatible metering, current measurement, electrical monitoring, distribution panels, control panels and energy monitoring applications.</p>
<h3>What should I check before buying this CT?</h3>
<p>Check the <strong>600/5A ratio, 600A primary current, 5A secondary, Class 1.0 accuracy, 85mm ID, 135mm OD, 40mm width and 2.5–15 VA rating</strong> against your application requirements.</p>
<hr />
<h1>Shipping &amp; Bulk Orders</h1>
<p>MVG Power Solutions supplies current transformers for compatible electrical metering, monitoring and current measurement requirements.</p>
<p>For bulk requirements, customers can provide the required quantity and application details to receive product and quotation information.</p>
<p>Shipping charges and delivery time may vary depending on order quantity and destination.</p>
<p>For bulk orders, confirm the required <strong>CT ratio, quantity, accuracy class, inner diameter and VA rating</strong> before placing the order.</p>', 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/600-5a-85mm-ring-current-transformer-specifications-scaled.jpg', 0, 'published'),
(226, 1, 60, 1, '1000/5A Ring Current Transformer 65mm | Class 1.0 Metering CT', '1000-5a-65mm-ring-current-transformer', '12040-MVG-R-65-1-1-1-1', 280.00, 280.00, 10, '85043100', 18.00, 'in_stock', '<ul data-spread="false">
<li><strong>Primary Current:</strong> 1000A</li>
<li><strong>Secondary Current:</strong> 5A</li>
<li><strong>Current Ratio:</strong> 1000/5A</li>
<li><strong>Accuracy Class:</strong> Class 1.0</li>
<li><strong>Inner Diameter (ID):</strong> 65 mm</li>
<li><strong>Outer Diameter (OD):</strong> 120 mm</li>
<li><strong>Width:</strong> 40 mm</li>
<li><strong>VA Rating:</strong> 2.5–15 VA</li>
<li><strong>CT Type:</strong> Encapsulated Round Type Ring Current Transformer</li>
<li><strong>Secondary Output:</strong> 5A</li>
<li><strong>Suitable for:</strong> Metering and current measurement</li>
<li><strong>Suitable for:</strong> Electrical monitoring and compatible panel installations</li>
</ul>
<div>
<hr />
</div>
<h1></h1>', '<h1>Product Overview</h1>
<h2>1000/5A 65mm Ring Current Transformer</h2>
<p>The <strong>1000/5A Ring Current Transformer 65mm CT</strong> is a Class 1.0 current transformer designed for compatible electrical metering, current measurement and monitoring applications. It features a <strong>1000A primary current</strong> and <strong>5A secondary current</strong>, providing a specified <strong>1000/5A current ratio</strong> for compatible meters, measuring instruments and electrical monitoring equipment.</p>
<p>This current transformer features an <strong>encapsulated round-type ring construction</strong> with a <strong>65 mm inner diameter</strong>, <strong>120 mm outer diameter</strong>, and <strong>40 mm width</strong>. The circular opening provides a defined space for compatible conductors or cables. Before installation, the conductor dimensions should be checked against the available 65mm opening.</p>
<p>With its <strong>Class 1.0 accuracy</strong>, this CT is suitable for applications where the specified metering accuracy is required. The <strong>5A secondary output</strong> can be connected to compatible meters, monitoring instruments and electrical measurement equipment designed for a 5A CT input.</p>
<p>The transformer has a specified <strong>2.5–15 VA rating</strong>, which should be considered when matching the CT with the connected secondary circuit. The connected meter, measuring equipment and secondary wiring burden should be checked to ensure compatibility.</p>
<p>The <strong>65 mm inner diameter</strong>, <strong>120 mm outer diameter</strong> and <strong>40 mm width</strong> should also be considered when planning the available installation space inside an electrical panel or enclosure.</p>
<hr />
<h1>Key Features</h1>
<p>The <strong>1000/5A 65mm Ring Current Transformer</strong> offers the following features:</p>
<ul>
<li>1000/5A current ratio</li>
<li>1000A primary current</li>
<li>5A secondary current</li>
<li>Class 1.0 accuracy</li>
<li>65 mm inner diameter</li>
<li>120 mm outer diameter</li>
<li>40 mm width</li>
<li>2.5–15 VA rating</li>
<li>Encapsulated round-type ring construction</li>
<li>Standard 5A secondary output</li>
<li>Suitable for compatible metering applications</li>
<li>Suitable for electrical current measurement</li>
<li>Suitable for current monitoring systems</li>
<li>Suitable for compatible electrical panels and installations</li>
</ul>
<hr />
<h1>Technical Specifications</h1>
<table>
<thead>
<tr>
<th>Parameter</th>
<th>Specification</th>
</tr>
</thead>
<tbody>
<tr>
<td>Product Type</td>
<td>Current Transformer</td>
</tr>
<tr>
<td>CT Type</td>
<td>Encapsulated Round Type Ring CT</td>
</tr>
<tr>
<td>Primary Current</td>
<td>1000A</td>
</tr>
<tr>
<td>Secondary Current</td>
<td>5A</td>
</tr>
<tr>
<td>Current Ratio</td>
<td>1000/5A</td>
</tr>
<tr>
<td>Accuracy Class</td>
<td>Class 1.0</td>
</tr>
<tr>
<td>Inner Diameter (ID)</td>
<td>65 mm</td>
</tr>
<tr>
<td>Outer Diameter (OD)</td>
<td>120 mm</td>
</tr>
<tr>
<td>Width</td>
<td>40 mm</td>
</tr>
<tr>
<td>VA Rating</td>
<td>2.5–15 VA</td>
</tr>
<tr>
<td>Application</td>
<td>Metering &amp; Current Measurement</td>
</tr>
</tbody>
</table>
<hr />
<h1>1000/5A Ring Current Transformer for Metering</h1>
<p>The <strong>1000/5A Ring Current Transformer</strong> is designed for compatible electrical metering and current measurement systems. With a <strong>1000A primary current and 5A secondary output</strong>, it provides a specified current transformation ratio for compatible 5A measurement equipment.</p>
<p>Current transformers are commonly used in electrical systems where current measurement is performed through compatible meters or monitoring instruments. The transformer provides a secondary current corresponding to its specified ratio for use with suitable measurement equipment.</p>
<p>For this product, the specified current ratio is <strong>1000/5A</strong>. The connected meter or monitoring instrument should be selected according to the CT&#8217;s 5A secondary requirement and the requirements of the overall electrical installation.</p>
<p>When selecting the CT, users should check the required primary current, secondary current, accuracy class, burden, conductor dimensions and physical installation space.</p>
<hr />
<h1>65mm Inner Diameter Ring CT</h1>
<p>This model features a <strong>65 mm inner diameter</strong>, providing a defined circular opening for compatible conductors and cables.</p>
<p>Before installation, the conductor or cable dimensions should be checked against the <strong>65mm inner diameter</strong>. Adequate clearance should be available so the CT can be positioned correctly around the conductor.</p>
<p>The <strong>120 mm outer diameter</strong> and <strong>40 mm width</strong> should also be considered when determining available space inside an electrical panel, enclosure or other installation location.</p>
<p>The ring-type construction provides a circular CT configuration for compatible electrical measurement and monitoring installations.</p>
<hr />
<h1>Class 1.0 Metering Accuracy</h1>
<p>The <strong>Class 1.0 accuracy</strong> specification is an important consideration when selecting this current transformer for compatible metering and measurement applications.</p>
<p>The CT should be used with suitable measuring equipment and within the conditions applicable to its specified accuracy class. The complete secondary circuit, including connected equipment and wiring, should be considered during installation planning.</p>
<p>For applications requiring Class 1.0 accuracy, the <strong>1000/5A Class 1.0 Ring CT</strong> can be considered when its ratio, burden, dimensions and other specifications match the requirements of the electrical system.</p>
<hr />
<h1>Standard 5A Secondary Output</h1>
<p>The <strong>5A secondary output</strong> makes this current transformer suitable for compatible meters and measurement instruments designed for a 5A CT input.</p>
<p>The secondary rating should match the input specification of the connected measuring equipment. For this product, the specified configuration is <strong>1000A primary / 5A secondary</strong>.</p>
<p>The secondary circuit should be connected according to the requirements of the CT, measuring equipment and overall electrical installation.</p>
<hr />
<h1>2.5–15 VA Rating</h1>
<p>The <strong>1000/5A 65mm Ring CT</strong> has a specified <strong>2.5–15 VA rating</strong>.</p>
<p>VA rating is an important consideration when selecting a current transformer because the connected secondary circuit introduces a burden. This may include the connected meter, measuring instrument and secondary wiring.</p>
<p>Before installation, the expected connected burden should be checked against the specified <strong>2.5–15 VA</strong> range to ensure that the transformer is appropriate for the intended application.</p>
<hr />
<h1>Applications</h1>
<p>The <strong>1000/5A 65mm Ring Current Transformer</strong> can be used in compatible applications such as:</p>
<ul>
<li>Energy metering systems</li>
<li>Electrical current measurement</li>
<li>Current monitoring systems</li>
<li>Power monitoring systems</li>
<li>Metering panels</li>
<li>Electrical distribution panels</li>
<li>Electrical control panels</li>
<li>Industrial electrical installations</li>
<li>Electrical monitoring equipment</li>
<li>Energy measurement systems</li>
<li>Current measurement equipment</li>
<li>Compatible panel metering applications</li>
</ul>
<p>The CT should be selected according to the required current ratio, secondary current, accuracy class, burden, conductor dimensions and installation requirements.</p>
<hr />
<h1>Benefits of 1000/5A 65mm Ring Current Transformer</h1>
<h3>Class 1.0 Accuracy</h3>
<p>The Class 1.0 specification makes this CT suitable for compatible applications requiring the specified metering accuracy.</p>
<h3>1000/5A Current Ratio</h3>
<p>The specified <strong>1000/5A ratio</strong> provides a 5A secondary output for compatible current measurement and metering equipment.</p>
<h3>65mm Inner Diameter</h3>
<p>The <strong>65mm inner diameter</strong> provides a defined circular opening for compatible conductors and cables.</p>
<h3>Encapsulated Ring Construction</h3>
<p>The encapsulated round-type construction provides a ring-style configuration suitable for compatible electrical measurement installations.</p>
<h3>Standard 5A Secondary</h3>
<p>The 5A secondary output is suitable for compatible measuring equipment designed for a 5A CT input.</p>
<h3>2.5–15 VA Rating</h3>
<p>The specified <strong>2.5–15 VA rating</strong> allows the CT to be matched with compatible secondary circuits according to their connected burden.</p>
<h3>Defined Physical Dimensions</h3>
<p>The <strong>120mm OD × 40mm width</strong> provides defined physical dimensions that can be considered during electrical panel and installation planning.</p>
<hr />
<h1>Installation Considerations</h1>
<p>Before installing the <strong>1000/5A 65mm Ring Current Transformer</strong>, check the following:</p>
<ol>
<li>Confirm that the required CT ratio is <strong>1000/5A</strong>.</li>
<li>Confirm that the primary current requirement is <strong>1000A</strong>.</li>
<li>Verify that the connected equipment requires a <strong>5A secondary</strong>.</li>
<li>Confirm that the required accuracy class is <strong>Class 1.0</strong>.</li>
<li>Check that the conductor or cable fits through the <strong>65mm inner diameter</strong>.</li>
<li>Check the available space against the <strong>120mm outer diameter and 40mm width</strong>.</li>
<li>Verify that the connected secondary burden is compatible with the <strong>2.5–15 VA</strong> rating.</li>
<li>Ensure that the CT secondary connections are made according to the requirements of the electrical installation.</li>
</ol>
<p>Installation should be performed by a suitably qualified electrical professional following applicable electrical safety practices.</p>
<hr />
<h1>Why Choose a 1000/5A 65mm Class 1.0 Ring CT?</h1>
<p>The <strong>1000/5A 65mm Ring Current Transformer</strong> combines a <strong>1000A primary current</strong>, <strong>5A secondary output</strong>, <strong>Class 1.0 accuracy</strong> and encapsulated ring-type construction.</p>
<p>Its <strong>65mm inner diameter</strong> provides a defined circular opening for compatible conductors, while the <strong>120mm outer diameter and 40mm width</strong> provide important physical dimensions for installation planning.</p>
<p>The specified <strong>2.5–15 VA rating</strong> can be considered when matching the CT with the connected metering or measurement circuit.</p>
<p>Before selecting the CT, users should verify the required current ratio, primary current, secondary current, accuracy class, conductor size, burden and available installation space.</p>
<hr />
<h1>Product Summary</h1>
<p>The <strong>1000/5A Ring Current Transformer 65mm CT</strong> is an encapsulated round-type current transformer featuring:</p>
<ul>
<li><strong>1000A primary current</strong></li>
<li><strong>5A secondary current</strong></li>
<li><strong>1000/5A current ratio</strong></li>
<li><strong>Class 1.0 accuracy</strong></li>
<li><strong>65mm inner diameter</strong></li>
<li><strong>120mm outer diameter</strong></li>
<li><strong>40mm width</strong></li>
<li><strong>2.5–15 VA rating</strong></li>
</ul>
<p>It is suitable for compatible metering, electrical current measurement and monitoring applications where these specifications meet the requirements of the electrical system.</p>
<hr />
<h1>Frequently Asked Questions</h1>
<h3>What is the current ratio of this Ring CT?</h3>
<p>The current ratio is <strong>1000/5A</strong>.</p>
<h3>What is the primary current?</h3>
<p>The specified primary current is <strong>1000A</strong>.</p>
<h3>What is the secondary current?</h3>
<p>The secondary current is <strong>5A</strong>.</p>
<h3>What is the accuracy class?</h3>
<p>This current transformer has a specified <strong>Class 1.0 accuracy class</strong>.</p>
<h3>What is the inner diameter of this CT?</h3>
<p>The inner diameter is <strong>65 mm</strong>.</p>
<h3>What is the outer diameter?</h3>
<p>The outer diameter is <strong>120 mm</strong>.</p>
<h3>What is the width of the Ring CT?</h3>
<p>The specified width is <strong>40 mm</strong>.</p>
<h3>What is the VA rating?</h3>
<p>The specified VA rating is <strong>2.5–15 VA</strong>.</p>
<h3>What type of CT is this?</h3>
<p>It is an <strong>encapsulated round-type ring current transformer</strong>.</p>
<h3>Where can the 1000/5A Ring CT be used?</h3>
<p>It can be used in compatible metering, current measurement, electrical monitoring, distribution panels, control panels and energy monitoring applications.</p>
<h3>What should I check before buying this CT?</h3>
<p>Check the <strong>1000/5A ratio, 1000A primary current, 5A secondary, Class 1.0 accuracy, 65mm ID, 120mm OD, 40mm width and 2.5–15 VA rating</strong> against your application requirements.</p>
<hr />
<h1>Shipping &amp; Bulk Orders</h1>
<p>MVG Power Solutions supplies current transformers for compatible electrical metering, monitoring and current measurement requirements.</p>
<p>For bulk requirements, customers can provide the required quantity and application details to receive product and quotation information.</p>
<p>Shipping charges and delivery time may vary depending on order quantity and destination.</p>
<p>For bulk orders, confirm the required <strong>CT ratio, quantity, accuracy class, inner diameter and VA rating</strong> before placing the order.</p>', 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/1000-5a-65mm-ring-current-transformer-specifications.jpg', 0, 'published'),
(223, 1, 60, 1, '800/5A Ring Current Transformer 65mm | Class 1.0 Metering CT', '800-5a-65mm-ring-current-transformer', '12040-MVG-R-65-1-1-1', 280.00, 280.00, 10, '85043100', 18.00, 'in_stock', '<ul>
<li><strong>Primary Current:</strong> 800A</li>
<li><strong>Secondary Current:</strong> 5A</li>
<li><strong>Current Ratio:</strong> 800/5A</li>
<li><strong>Accuracy Class:</strong> Class 1.0</li>
<li><strong>Inner Diameter (ID):</strong> 65 mm</li>
<li><strong>Outer Diameter (OD):</strong> 120 mm</li>
<li><strong>Width:</strong> 40 mm</li>
<li><strong>VA Rating:</strong> 2.5–15 VA</li>
<li><strong>CT Type:</strong> Encapsulated Round Type Ring Current Transformer</li>
<li><strong>Secondary Output:</strong> 5A</li>
<li><strong>Suitable for:</strong> Metering and current measurement</li>
<li><strong>Suitable for:</strong> Electrical monitoring and compatible panel installations</li>
</ul>', '<h1>Product Overview</h1>
<h2>800/5A 65mm Ring Current Transformer</h2>
<p class="isSelectedEnd">The <strong>800/5A Ring Current Transformer 65mm CT</strong> is a Class 1.0 current transformer designed for compatible electrical metering, current measurement and monitoring applications. It features an <strong>800A primary current</strong> and <strong>5A secondary current</strong>, providing a specified <strong>800/5A current ratio</strong> for compatible meters, measuring instruments and electrical monitoring equipment.</p>
<p class="isSelectedEnd">This current transformer features an <strong>encapsulated round-type ring construction</strong> with a <strong>65 mm inner diameter</strong>, <strong>120 mm outer diameter</strong>, and <strong>40 mm width</strong>. The circular opening provides a defined space for compatible conductors or cables. Before installation, the conductor dimensions should be checked against the available 65mm opening.</p>
<p class="isSelectedEnd">With its <strong>Class 1.0 accuracy</strong>, this CT is suitable for applications where the specified metering accuracy is required. The <strong>5A secondary output</strong> can be connected to compatible meters, monitoring instruments and electrical measurement equipment designed for a 5A CT input.</p>
<p class="isSelectedEnd">The transformer has a specified <strong>2.5–15 VA rating</strong>, which should be considered when matching the CT with the connected secondary circuit. The actual burden of the connected meter, measuring equipment and secondary wiring should be checked to ensure compatibility.</p>
<p class="isSelectedEnd">The <strong>65 mm inner diameter</strong>, <strong>120 mm outer diameter</strong> and <strong>40 mm width</strong> should also be considered when planning the available installation space inside an electrical panel or enclosure.</p>
<div>
<hr />
</div>
<h1>Key Features</h1>
<p class="isSelectedEnd">The <strong>800/5A 65mm Ring Current Transformer</strong> offers the following features:</p>
<ul data-spread="false">
<li>800/5A current ratio</li>
<li>800A primary current</li>
<li>5A secondary current</li>
<li>Class 1.0 accuracy</li>
<li>65 mm inner diameter</li>
<li>120 mm outer diameter</li>
<li>40 mm width</li>
<li>2.5–15 VA rating</li>
<li>Encapsulated round-type ring construction</li>
<li>Standard 5A secondary output</li>
<li>Suitable for compatible metering applications</li>
<li>Suitable for electrical current measurement</li>
<li>Suitable for current monitoring systems</li>
<li>Suitable for compatible electrical panels and installations</li>
</ul>
<div>
<hr />
</div>
<h1>Technical Specifications</h1>
<table>
<tbody>
<tr>
<th>Parameter</th>
<th>Specification</th>
</tr>
<tr>
<td>Product Type</td>
<td>Current Transformer</td>
</tr>
<tr>
<td>CT Type</td>
<td>Encapsulated Round Type Ring CT</td>
</tr>
<tr>
<td>Primary Current</td>
<td>800A</td>
</tr>
<tr>
<td>Secondary Current</td>
<td>5A</td>
</tr>
<tr>
<td>Current Ratio</td>
<td>800/5A</td>
</tr>
<tr>
<td>Accuracy Class</td>
<td>Class 1.0</td>
</tr>
<tr>
<td>Inner Diameter (ID)</td>
<td>65 mm</td>
</tr>
<tr>
<td>Outer Diameter (OD)</td>
<td>120 mm</td>
</tr>
<tr>
<td>Width</td>
<td>40 mm</td>
</tr>
<tr>
<td>VA Rating</td>
<td>2.5–15 VA</td>
</tr>
<tr>
<td>Application</td>
<td>Metering &amp; Current Measurement</td>
</tr>
</tbody>
</table>
<div>
<hr />
</div>
<h1>800/5A Ring Current Transformer for Metering</h1>
<p class="isSelectedEnd">The <strong>800/5A Ring Current Transformer</strong> is designed for compatible electrical metering and current measurement systems. With an <strong>800A primary current and 5A secondary output</strong>, it provides a specified current transformation ratio for compatible 5A measurement equipment.</p>
<p class="isSelectedEnd">Current transformers are commonly used in electrical systems where current measurement is performed through compatible meters or monitoring instruments. The transformer provides a secondary current corresponding to its specified ratio for use with suitable measurement equipment.</p>
<p class="isSelectedEnd">For this product, the specified current ratio is <strong>800/5A</strong>. The connected meter or monitoring instrument should be selected according to the CT&#8217;s 5A secondary requirement and the requirements of the overall electrical installation.</p>
<p class="isSelectedEnd">When selecting the CT, users should check the required primary current, secondary current, accuracy class, burden, conductor dimensions and physical installation space.</p>
<div>
<hr />
</div>
<h1>65mm Inner Diameter Ring CT</h1>
<p class="isSelectedEnd">This model features a <strong>65 mm inner diameter</strong>, providing a defined circular opening for compatible conductors and cables.</p>
<p class="isSelectedEnd">Before installation, the conductor or cable dimensions should be checked against the <strong>65mm inner diameter</strong>. Adequate clearance should be available so the CT can be positioned correctly around the conductor.</p>
<p class="isSelectedEnd">The <strong>120 mm outer diameter</strong> and <strong>40 mm width</strong> should also be considered when determining available space inside an electrical panel, enclosure or other installation location.</p>
<p class="isSelectedEnd">The ring-type construction provides a circular CT configuration for compatible electrical measurement and monitoring installations.</p>
<div>
<hr />
</div>
<h1>Class 1.0 Metering Accuracy</h1>
<p class="isSelectedEnd">The <strong>Class 1.0 accuracy</strong> specification is an important consideration when selecting this current transformer for compatible metering and measurement applications.</p>
<p class="isSelectedEnd">The CT should be used with suitable measuring equipment and within the conditions applicable to its specified accuracy class. The complete secondary circuit, including connected equipment and wiring, should be considered during installation planning.</p>
<p class="isSelectedEnd">For applications requiring Class 1.0 accuracy, the <strong>800/5A Class 1.0 Ring CT</strong> can be considered when its ratio, burden, dimensions and other specifications match the requirements of the electrical system.</p>
<div>
<hr />
</div>
<h1>Standard 5A Secondary Output</h1>
<p class="isSelectedEnd">The <strong>5A secondary output</strong> makes this current transformer suitable for compatible meters and measurement instruments designed for a 5A CT input.</p>
<p class="isSelectedEnd">The secondary rating should match the input specification of the connected measuring equipment. For this product, the specified configuration is <strong>800A primary / 5A secondary</strong>.</p>
<p class="isSelectedEnd">The secondary circuit should be connected according to the requirements of the CT, measuring equipment and overall electrical installation.</p>
<div>
<hr />
</div>
<h1>2.5–15 VA Rating</h1>
<p class="isSelectedEnd">The <strong>800/5A 65mm Ring CT</strong> has a specified <strong>2.5–15 VA rating</strong>.</p>
<p class="isSelectedEnd">VA rating is an important consideration when selecting a current transformer because the connected secondary circuit introduces a burden. This may include the connected meter, measuring instrument and secondary wiring.</p>
<p class="isSelectedEnd">Before installation, the expected connected burden should be checked against the specified <strong>2.5–15 VA</strong> range to ensure that the transformer is appropriate for the intended application.</p>
<div>
<hr />
</div>
<h1>Applications</h1>
<p class="isSelectedEnd">The <strong>800/5A 65mm Ring Current Transformer</strong> can be used in compatible applications such as:</p>
<ul data-spread="false">
<li>Energy metering systems</li>
<li>Electrical current measurement</li>
<li>Current monitoring systems</li>
<li>Power monitoring systems</li>
<li>Metering panels</li>
<li>Electrical distribution panels</li>
<li>Electrical control panels</li>
<li>Industrial electrical installations</li>
<li>Electrical monitoring equipment</li>
<li>Energy measurement systems</li>
<li>Current measurement equipment</li>
<li>Compatible panel metering applications</li>
</ul>
<p class="isSelectedEnd">The CT should be selected according to the required current ratio, secondary current, accuracy class, burden, conductor dimensions and installation requirements.</p>
<div>
<hr />
</div>
<h1>Benefits of 800/5A 65mm Ring Current Transformer</h1>
<h3>Class 1.0 Accuracy</h3>
<p class="isSelectedEnd">The Class 1.0 specification makes this CT suitable for compatible applications requiring the specified metering accuracy.</p>
<h3>800/5A Current Ratio</h3>
<p class="isSelectedEnd">The specified <strong>800/5A ratio</strong> provides a 5A secondary output for compatible current measurement and metering equipment.</p>
<h3>65mm Inner Diameter</h3>
<p class="isSelectedEnd">The <strong>65mm inner diameter</strong> provides a defined circular opening for compatible conductors and cables.</p>
<h3>Encapsulated Ring Construction</h3>
<p class="isSelectedEnd">The encapsulated round-type construction provides a ring-style configuration suitable for compatible electrical measurement installations.</p>
<h3>Standard 5A Secondary</h3>
<p class="isSelectedEnd">The 5A secondary output is suitable for compatible measuring equipment designed for a 5A CT input.</p>
<h3>2.5–15 VA Rating</h3>
<p class="isSelectedEnd">The specified <strong>2.5–15 VA rating</strong> allows the CT to be matched with compatible secondary circuits according to their connected burden.</p>
<h3>Defined Physical Dimensions</h3>
<p class="isSelectedEnd">The <strong>120mm OD × 40mm width</strong> provides defined physical dimensions that can be considered during electrical panel and installation planning.</p>
<div>
<hr />
</div>
<h1>Installation Considerations</h1>
<p class="isSelectedEnd">Before installing the <strong>800/5A 65mm Ring Current Transformer</strong>, check the following:</p>
<ol start="1" data-spread="false">
<li>Confirm that the required CT ratio is <strong>800/5A</strong>.</li>
<li>Confirm that the primary current requirement is <strong>800A</strong>.</li>
<li>Verify that the connected equipment requires a <strong>5A secondary</strong>.</li>
<li>Confirm that the required accuracy class is <strong>Class 1.0</strong>.</li>
<li>Check that the conductor or cable fits through the <strong>65mm inner diameter</strong>.</li>
<li>Check the available space against the <strong>120mm outer diameter and 40mm width</strong>.</li>
<li>Verify that the connected secondary burden is compatible with the <strong>2.5–15 VA</strong> rating.</li>
<li>Ensure that the CT secondary connections are made according to the requirements of the electrical installation.</li>
</ol>
<p class="isSelectedEnd">Installation should be performed by a suitably qualified electrical professional following applicable electrical safety practices.</p>
<div>
<hr />
</div>
<h1>Why Choose a 800/5A 65mm Class 1.0 Ring CT?</h1>
<p class="isSelectedEnd">The <strong>800/5A 65mm Ring Current Transformer</strong> combines an <strong>800A primary current</strong>, <strong>5A secondary output</strong>, <strong>Class 1.0 accuracy</strong> and encapsulated ring-type construction.</p>
<p class="isSelectedEnd">Its <strong>65mm inner diameter</strong> provides a defined circular opening for compatible conductors, while the <strong>120mm outer diameter and 40mm width</strong> provide important physical dimensions for installation planning.</p>
<p class="isSelectedEnd">The specified <strong>2.5–15 VA rating</strong> can be considered when matching the CT with the connected metering or measurement circuit.</p>
<p class="isSelectedEnd">Before selecting the CT, users should verify the required current ratio, primary current, secondary current, accuracy class, conductor size, burden and available installation space.</p>
<div>
<hr />
</div>
<h1>Product Summary</h1>
<p class="isSelectedEnd">The <strong>800/5A Ring Current Transformer 65mm CT</strong> is an encapsulated round-type current transformer featuring:</p>
<ul data-spread="false">
<li><strong>800A primary current</strong></li>
<li><strong>5A secondary current</strong></li>
<li><strong>800/5A current ratio</strong></li>
<li><strong>Class 1.0 accuracy</strong></li>
<li><strong>65mm inner diameter</strong></li>
<li><strong>120mm outer diameter</strong></li>
<li><strong>40mm width</strong></li>
<li><strong>2.5–15 VA rating</strong></li>
</ul>
<p class="isSelectedEnd">It is suitable for compatible metering, electrical current measurement and monitoring applications where these specifications meet the requirements of the electrical system.</p>
<div>
<hr />
</div>
<h1>Frequently Asked Questions</h1>
<h3>What is the current ratio of this Ring CT?</h3>
<p class="isSelectedEnd">The current ratio is <strong>800/5A</strong>.</p>
<h3>What is the primary current?</h3>
<p class="isSelectedEnd">The specified primary current is <strong>800A</strong>.</p>
<h3>What is the secondary current?</h3>
<p class="isSelectedEnd">The secondary current is <strong>5A</strong>.</p>
<h3>What is the accuracy class?</h3>
<p class="isSelectedEnd">This current transformer has a specified <strong>Class 1.0 accuracy class</strong>.</p>
<h3>What is the inner diameter of this CT?</h3>
<p class="isSelectedEnd">The inner diameter is <strong>65 mm</strong>.</p>
<h3>What is the outer diameter?</h3>
<p class="isSelectedEnd">The outer diameter is <strong>120 mm</strong>.</p>
<h3>What is the width of the Ring CT?</h3>
<p class="isSelectedEnd">The specified width is <strong>40 mm</strong>.</p>
<h3>What is the VA rating?</h3>
<p class="isSelectedEnd">The specified VA rating is <strong>2.5–15 VA</strong>.</p>
<h3>What type of CT is this?</h3>
<p class="isSelectedEnd">It is an <strong>encapsulated round-type ring current transformer</strong>.</p>
<h3>Where can the 800/5A Ring CT be used?</h3>
<p class="isSelectedEnd">It can be used in compatible metering, current measurement, electrical monitoring, distribution panels, control panels and energy monitoring applications.</p>
<h3>What should I check before buying this CT?</h3>
<p class="isSelectedEnd">Check the <strong>800/5A ratio, 800A primary current, 5A secondary, Class 1.0 accuracy, 65mm ID, 120mm OD, 40mm width and 2.5–15 VA rating</strong> against your application requirements.</p>
<div>
<hr />
</div>
<h1>Shipping &amp; Bulk Orders</h1>
<p class="isSelectedEnd">MVG Power Solutions supplies current transformers for compatible electrical metering, monitoring and current measurement requirements.</p>
<p class="isSelectedEnd">For bulk requirements, customers can provide the required quantity and application details to receive product and quotation information.</p>
<p class="isSelectedEnd">Shipping charges and delivery time may vary depending on order quantity and destination.</p>
<p>For bulk orders, confirm the required <strong>CT ratio, quantity, accuracy class, inner diameter and VA rating</strong> before placing the order.</p>', 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/800-5a-65mm-ring-current-transformer-specifications.jpg', 0, 'published'),
(220, 1, 60, 1, '600/5A Ring Current Transformer 65mm | Class 1.0 Metering CT', '600-5a-65mm-ring-current-transformer', '12040-MVG-R-65-1-1', 280.00, 280.00, 10, '85043100', 18.00, 'in_stock', '<ul data-spread="false">
<li><strong>Primary Current:</strong> 600A</li>
<li><strong>Secondary Current:</strong> 5A</li>
<li><strong>Current Ratio:</strong> 600/5A</li>
<li><strong>Accuracy Class:</strong> Class 1.0</li>
<li><strong>Inner Diameter (ID):</strong> 65 mm</li>
<li><strong>Outer Diameter (OD):</strong> 120 mm</li>
<li><strong>Width:</strong> 40 mm</li>
<li><strong>VA Rating:</strong> 2.5–15 VA</li>
<li><strong>CT Type:</strong> Encapsulated Round Type Ring Current Transformer</li>
<li><strong>Secondary Output:</strong> 5A</li>
<li><strong>Suitable for:</strong> Metering and current measurement</li>
<li><strong>Suitable for:</strong> Electrical monitoring and compatible panel installations</li>
</ul>', '<p>&nbsp;</p>
<h1>Product Overview</h1>
<h2>600/5A 65mm Ring Current Transformer</h2>
<p>The <strong>600/5A Ring Current Transformer 65mm CT</strong> is a Class 1.0 current transformer designed for compatible electrical metering, current measurement and monitoring applications. It features a <strong>600A primary current</strong> and <strong>5A secondary current</strong>, providing a specified <strong>600/5A current ratio</strong> for compatible meters, measuring instruments and electrical monitoring equipment.</p>
<p>This current transformer features an <strong>encapsulated round-type ring construction</strong> with a <strong>65 mm inner diameter</strong>, <strong>120 mm outer diameter</strong>, and <strong>40 mm width</strong>. The circular opening provides a defined space for compatible conductors or cables, and the conductor dimensions should be checked before installation.</p>
<p>With its <strong>Class 1.0 accuracy</strong>, this CT is suitable for applications where the specified metering accuracy is required. The 5A secondary output can be connected to compatible meters, monitoring instruments and electrical measurement equipment designed for a 5A CT input.</p>
<p>The transformer has a specified <strong>2.5–15 VA rating</strong>, which should be considered when matching the CT with the connected secondary circuit. The connected meter, measuring equipment and secondary wiring burden should be checked to ensure compatibility.</p>
<p>The <strong>65 mm inner diameter</strong>, <strong>120 mm outer diameter</strong> and <strong>40 mm width</strong> should also be considered when planning the available installation space.</p>
<hr />
<h1>Key Features</h1>
<p>The <strong>600/5A 65mm Ring Current Transformer</strong> offers the following features:</p>
<ul>
<li>600/5A current ratio</li>
<li>600A primary current</li>
<li>5A secondary current</li>
<li>Class 1.0 accuracy</li>
<li>65 mm inner diameter</li>
<li>120 mm outer diameter</li>
<li>40 mm width</li>
<li>2.5–15 VA rating</li>
<li>Encapsulated round-type ring construction</li>
<li>Standard 5A secondary output</li>
<li>Suitable for compatible metering applications</li>
<li>Suitable for electrical current measurement</li>
<li>Suitable for current monitoring systems</li>
<li>Suitable for compatible electrical panels and installations</li>
</ul>
<hr />
<h1>Technical Specifications</h1>
<table>
<thead>
<tr>
<th>Parameter</th>
<th>Specification</th>
</tr>
</thead>
<tbody>
<tr>
<td>Product Type</td>
<td>Current Transformer</td>
</tr>
<tr>
<td>CT Type</td>
<td>Encapsulated Round Type Ring CT</td>
</tr>
<tr>
<td>Primary Current</td>
<td>600A</td>
</tr>
<tr>
<td>Secondary Current</td>
<td>5A</td>
</tr>
<tr>
<td>Current Ratio</td>
<td>600/5A</td>
</tr>
<tr>
<td>Accuracy Class</td>
<td>Class 1.0</td>
</tr>
<tr>
<td>Inner Diameter (ID)</td>
<td>65 mm</td>
</tr>
<tr>
<td>Outer Diameter (OD)</td>
<td>120 mm</td>
</tr>
<tr>
<td>Width</td>
<td>40 mm</td>
</tr>
<tr>
<td>VA Rating</td>
<td>2.5–15 VA</td>
</tr>
<tr>
<td>Application</td>
<td>Metering &amp; Current Measurement</td>
</tr>
</tbody>
</table>
<hr />
<h1>600/5A Ring Current Transformer for Metering</h1>
<p>The <strong>600/5A Ring Current Transformer</strong> is designed for compatible electrical metering and current measurement systems. With a <strong>600A primary current and 5A secondary output</strong>, it provides a specified current transformation ratio for compatible 5A measurement equipment.</p>
<p>Current transformers are commonly used in electrical systems where current measurement is performed through compatible meters or monitoring instruments. The transformer provides a secondary current corresponding to its specified ratio for use with suitable measurement equipment.</p>
<p>For this product, the specified current ratio is <strong>600/5A</strong>. The connected meter or monitoring instrument should be selected according to the CT&#8217;s 5A secondary requirement and the requirements of the overall electrical installation.</p>
<p>When selecting the CT, users should check the required primary current, secondary current, accuracy class, burden, conductor dimensions and physical installation space.</p>
<hr />
<h1>65mm Inner Diameter Ring CT</h1>
<p>This model features a <strong>65 mm inner diameter</strong>, providing a defined circular opening for compatible conductors and cables.</p>
<p>Before installation, the conductor or cable dimensions should be checked against the <strong>65mm inner diameter</strong>. Adequate clearance should be available so the CT can be positioned correctly around the conductor.</p>
<p>The <strong>120 mm outer diameter</strong> and <strong>40 mm width</strong> should also be considered when determining the available space inside an electrical panel, enclosure or other installation location.</p>
<p>The ring-type construction provides a circular CT configuration for compatible electrical measurement and monitoring installations.</p>
<hr />
<h1>Class 1.0 Metering Accuracy</h1>
<p>The <strong>Class 1.0 accuracy</strong> specification is an important consideration when selecting this current transformer for compatible metering and measurement applications.</p>
<p>The CT should be used with suitable measuring equipment and within the conditions applicable to its specified accuracy class. The complete secondary circuit, including connected equipment and wiring, should be considered during installation planning.</p>
<p>For applications requiring Class 1.0 accuracy, the <strong>600/5A Class 1.0 Ring CT</strong> can be considered when its ratio, burden, dimensions and other specifications match the requirements of the electrical system.</p>
<hr />
<h1>Standard 5A Secondary Output</h1>
<p>The <strong>5A secondary output</strong> makes this current transformer suitable for compatible meters and measurement instruments designed for a 5A CT input.</p>
<p>The secondary rating should match the input specification of the connected measuring equipment. For this product, the specified configuration is <strong>600A primary / 5A secondary</strong>.</p>
<p>The secondary circuit should be connected according to the requirements of the CT, measuring equipment and overall electrical installation.</p>
<hr />
<h1>2.5–15 VA Rating</h1>
<p>The <strong>600/5A 65mm Ring CT</strong> has a specified <strong>2.5–15 VA rating</strong>.</p>
<p>VA rating is an important consideration when selecting a current transformer because the connected secondary circuit introduces a burden. This may include the connected meter, measuring instrument and secondary wiring.</p>
<p>Before installation, the expected connected burden should be checked against the specified <strong>2.5–15 VA</strong> range to ensure that the transformer is appropriate for the intended application.</p>
<hr />
<h1>Applications</h1>
<p>The <strong>600/5A 65mm Ring Current Transformer</strong> can be used in compatible applications such as:</p>
<ul>
<li>Energy metering systems</li>
<li>Electrical current measurement</li>
<li>Current monitoring systems</li>
<li>Power monitoring systems</li>
<li>Metering panels</li>
<li>Electrical distribution panels</li>
<li>Electrical control panels</li>
<li>Industrial electrical installations</li>
<li>Electrical monitoring equipment</li>
<li>Energy measurement systems</li>
<li>Current measurement equipment</li>
<li>Compatible panel metering applications</li>
</ul>
<p>The CT should be selected according to the required current ratio, secondary current, accuracy class, burden, conductor dimensions and installation requirements.</p>
<hr />
<h1>Benefits of 600/5A 65mm Ring Current Transformer</h1>
<h3>Class 1.0 Accuracy</h3>
<p>The Class 1.0 specification makes this CT suitable for compatible applications requiring the specified metering accuracy.</p>
<h3>600/5A Current Ratio</h3>
<p>The specified <strong>600/5A ratio</strong> provides a 5A secondary output for compatible current measurement and metering equipment.</p>
<h3>65mm Inner Diameter</h3>
<p>The <strong>65mm inner diameter</strong> provides a defined circular opening for compatible conductors and cables.</p>
<h3>Encapsulated Ring Construction</h3>
<p>The encapsulated round-type construction provides a ring-style configuration suitable for compatible electrical measurement installations.</p>
<h3>Standard 5A Secondary</h3>
<p>The 5A secondary output is suitable for compatible measuring equipment designed for a 5A CT input.</p>
<h3>2.5–15 VA Rating</h3>
<p>The specified <strong>2.5–15 VA rating</strong> allows the CT to be matched with compatible secondary circuits according to their connected burden.</p>
<h3>Defined Physical Dimensions</h3>
<p>The <strong>120mm OD × 40mm width</strong> provides defined physical dimensions that can be considered during electrical panel and installation planning.</p>
<hr />
<h1>Installation Considerations</h1>
<p>Before installing the <strong>600/5A 65mm Ring Current Transformer</strong>, check the following:</p>
<ol>
<li>Confirm that the required CT ratio is <strong>600/5A</strong>.</li>
<li>Confirm that the primary current requirement is <strong>600A</strong>.</li>
<li>Verify that the connected equipment requires a <strong>5A secondary</strong>.</li>
<li>Confirm that the required accuracy class is <strong>Class 1.0</strong>.</li>
<li>Check that the conductor or cable fits through the <strong>65mm inner diameter</strong>.</li>
<li>Check the available space against the <strong>120mm outer diameter and 40mm width</strong>.</li>
<li>Verify that the connected secondary burden is compatible with the <strong>2.5–15 VA</strong> rating.</li>
<li>Ensure that the CT secondary connections are made according to the requirements of the electrical installation.</li>
</ol>
<p>Installation should be performed by a suitably qualified electrical professional following applicable electrical safety practices.</p>
<hr />
<h1>Why Choose a 600/5A 65mm Class 1.0 Ring CT?</h1>
<p>The <strong>600/5A 65mm Ring Current Transformer</strong> combines a <strong>600A primary current</strong>, <strong>5A secondary output</strong>, <strong>Class 1.0 accuracy</strong> and encapsulated ring-type construction.</p>
<p>Its <strong>65mm inner diameter</strong> provides a defined circular opening for compatible conductors, while the <strong>120mm outer diameter and 40mm width</strong> provide important physical dimensions for installation planning.</p>
<p>The specified <strong>2.5–15 VA rating</strong> can be considered when matching the CT with the connected metering or measurement circuit.</p>
<p>Before selecting the CT, users should verify the required current ratio, primary current, secondary current, accuracy class, conductor size, burden and available installation space.</p>
<hr />
<h1>Product Summary</h1>
<p>The <strong>600/5A Ring Current Transformer 65mm CT</strong> is an encapsulated round-type current transformer featuring:</p>
<ul>
<li><strong>600A primary current</strong></li>
<li><strong>5A secondary current</strong></li>
<li><strong>600/5A current ratio</strong></li>
<li><strong>Class 1.0 accuracy</strong></li>
<li><strong>65mm inner diameter</strong></li>
<li><strong>120mm outer diameter</strong></li>
<li><strong>40mm width</strong></li>
<li><strong>2.5–15 VA rating</strong></li>
</ul>
<p>It is suitable for compatible metering, electrical current measurement and monitoring applications where these specifications meet the requirements of the electrical system.</p>
<hr />
<h1>Frequently Asked Questions</h1>
<h3>What is the current ratio of this Ring CT?</h3>
<p>The current ratio is <strong>600/5A</strong>.</p>
<h3>What is the primary current?</h3>
<p>The specified primary current is <strong>600A</strong>.</p>
<h3>What is the secondary current?</h3>
<p>The secondary current is <strong>5A</strong>.</p>
<h3>What is the accuracy class?</h3>
<p>This current transformer has a specified <strong>Class 1.0 accuracy class</strong>.</p>
<h3>What is the inner diameter of this CT?</h3>
<p>The inner diameter is <strong>65 mm</strong>.</p>
<h3>What is the outer diameter?</h3>
<p>The outer diameter is <strong>120 mm</strong>.</p>
<h3>What is the width of the Ring CT?</h3>
<p>The specified width is <strong>40 mm</strong>.</p>
<h3>What is the VA rating?</h3>
<p>The specified VA rating is <strong>2.5–15 VA</strong>.</p>
<h3>What type of CT is this?</h3>
<p>It is an <strong>encapsulated round-type ring current transformer</strong>.</p>
<h3>Where can the 600/5A Ring CT be used?</h3>
<p>It can be used in compatible metering, current measurement, electrical monitoring, distribution panels, control panels and energy monitoring applications.</p>
<h3>What should I check before buying this CT?</h3>
<p>Check the <strong>600/5A ratio, 600A primary current, 5A secondary, Class 1.0 accuracy, 65mm ID, 120mm OD, 40mm width and 2.5–15 VA rating</strong> against your application requirements.</p>
<hr />
<h1>Shipping &amp; Bulk Orders</h1>
<p>MVG Power Solutions supplies current transformers for compatible electrical metering, monitoring and current measurement requirements.</p>
<p>For bulk requirements, customers can provide the required quantity and application details to receive product and quotation information.</p>
<p>Shipping charges and delivery time may vary depending on order quantity and destination.</p>
<p>For bulk orders, confirm the required <strong>CT ratio, quantity, accuracy class, inner diameter and VA rating</strong> before placing the order.</p>', 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/600-5a-65mm-ring-current-transformer-specifications.jpg', 0, 'published'),
(217, 1, 60, 1, '500/5A Ring Current Transformer 65mm | Class 1.0 Metering CT', '500-5a-65mm-ring-current-transformer', '12040-MVG-R-65-1', 280.00, 280.00, 10, '85043100', 18.00, 'in_stock', '<ul data-spread="false">
<li><strong>Primary Current:</strong> 500A</li>
<li><strong>Secondary Current:</strong> 5A</li>
<li><strong>Current Ratio:</strong> 500/5A</li>
<li><strong>Accuracy Class:</strong> Class 1.0</li>
<li><strong>Inner Diameter (ID):</strong> 65 mm</li>
<li><strong>Outer Diameter (OD):</strong> 120 mm</li>
<li><strong>Width:</strong> 40 mm</li>
<li><strong>VA Rating:</strong> 2.5–15 VA</li>
<li><strong>CT Type:</strong> Encapsulated Round Type Ring Current Transformer</li>
<li><strong>Secondary Output:</strong> 5A</li>
<li><strong>Suitable for:</strong> Metering and current measurement</li>
<li><strong>Suitable for:</strong> Electrical monitoring and compatible panel installations</li>
</ul>', '<h1>Product Overview</h1>
<h2>500/5A 65mm Ring Current Transformer</h2>
<p>The <strong>500/5A Ring Current Transformer 65mm CT</strong> is a Class 1.0 current transformer designed for compatible electrical metering, current measurement and monitoring applications. It features a <strong>500A primary current</strong> and <strong>5A secondary current</strong>, providing a specified <strong>500/5A current ratio</strong> for compatible meters, measuring instruments and electrical monitoring equipment.</p>
<p>This current transformer features an <strong>encapsulated round-type ring construction</strong> with a <strong>65 mm inner diameter</strong>, <strong>120 mm outer diameter</strong>, and <strong>40 mm width</strong>. The larger circular opening provides a defined space for compatible conductors or cables and should be checked against the conductor dimensions before installation.</p>
<p>With its <strong>Class 1.0 accuracy</strong>, this CT is suitable for applications where the specified metering accuracy is required. The 5A secondary output can be connected to compatible meters, monitoring instruments and electrical measurement equipment designed for a 5A CT input.</p>
<p>The transformer has a specified <strong>2.5–15 VA rating</strong>, which should be considered when matching the CT with the connected secondary circuit. The actual burden of the connected meter, measuring equipment and secondary wiring should be checked to ensure compatibility with the transformer.</p>
<p>The <strong>65 mm inner diameter</strong>, together with the <strong>120 mm outer diameter and 40 mm width</strong>, should be considered when planning the available physical installation space.</p>
<hr />
<h1>Key Features</h1>
<p>The <strong>500/5A 65mm Ring Current Transformer</strong> offers the following features:</p>
<ul>
<li>500/5A current ratio</li>
<li>500A primary current</li>
<li>5A secondary current</li>
<li>Class 1.0 accuracy</li>
<li>65 mm inner diameter</li>
<li>120 mm outer diameter</li>
<li>40 mm width</li>
<li>2.5–15 VA rating</li>
<li>Encapsulated round-type ring construction</li>
<li>Standard 5A secondary output</li>
<li>Suitable for compatible metering applications</li>
<li>Suitable for electrical current measurement</li>
<li>Suitable for current monitoring systems</li>
<li>Suitable for compatible electrical panels and installations</li>
</ul>
<hr />
<h1>Technical Specifications</h1>
<table>
<thead>
<tr>
<th>Parameter</th>
<th>Specification</th>
</tr>
</thead>
<tbody>
<tr>
<td>Product Type</td>
<td>Current Transformer</td>
</tr>
<tr>
<td>CT Type</td>
<td>Encapsulated Round Type Ring CT</td>
</tr>
<tr>
<td>Primary Current</td>
<td>500A</td>
</tr>
<tr>
<td>Secondary Current</td>
<td>5A</td>
</tr>
<tr>
<td>Current Ratio</td>
<td>500/5A</td>
</tr>
<tr>
<td>Accuracy Class</td>
<td>Class 1.0</td>
</tr>
<tr>
<td>Inner Diameter (ID)</td>
<td>65 mm</td>
</tr>
<tr>
<td>Outer Diameter (OD)</td>
<td>120 mm</td>
</tr>
<tr>
<td>Width</td>
<td>40 mm</td>
</tr>
<tr>
<td>VA Rating</td>
<td>2.5–15 VA</td>
</tr>
<tr>
<td>Application</td>
<td>Metering &amp; Current Measurement</td>
</tr>
</tbody>
</table>
<hr />
<h1>500/5A Ring Current Transformer for Metering</h1>
<p>The <strong>500/5A Ring Current Transformer</strong> is designed for compatible electrical metering and current measurement systems. With a <strong>500A primary current and 5A secondary output</strong>, it provides a specified current transformation ratio for compatible 5A measurement equipment.</p>
<p>Current transformers are commonly used in electrical systems where current measurement is performed through compatible meters or monitoring instruments. The transformer provides a secondary current corresponding to its specified ratio for use with suitable measurement equipment.</p>
<p>For this product, the specified current ratio is <strong>500/5A</strong>. The connected meter or monitoring instrument should be selected according to the CT&#8217;s 5A secondary requirement and the overall electrical installation.</p>
<p>The CT should be selected after checking the required primary current, secondary current, accuracy class, burden, conductor dimensions and physical installation requirements.</p>
<hr />
<h1>65mm Inner Diameter Ring CT</h1>
<p>This model features a <strong>65 mm inner diameter</strong>, providing a larger circular opening for compatible conductors and cables.</p>
<p>Before installation, the conductor dimensions should be checked against the 65mm opening. Adequate clearance should be available so the CT can be positioned correctly around the conductor.</p>
<p>The <strong>120 mm outer diameter</strong> and <strong>40 mm width</strong> should also be considered when determining available space inside an electrical panel, enclosure or other installation location.</p>
<p>The ring-type construction provides a defined circular CT configuration for compatible electrical measurement installations.</p>
<hr />
<h1>Class 1.0 Metering Accuracy</h1>
<p>The <strong>Class 1.0 accuracy</strong> specification is an important consideration when selecting this current transformer for compatible metering and measurement applications.</p>
<p>The CT should be used with suitable measuring equipment and within the conditions applicable to its specified accuracy class. The complete secondary circuit, including connected equipment and wiring, should be considered during installation planning.</p>
<p>For applications requiring Class 1.0 accuracy, the <strong>500/5A Class 1.0 Ring CT</strong> can be considered when its ratio, burden, dimensions and other specifications match the requirements of the electrical system.</p>
<hr />
<h1>Standard 5A Secondary Output</h1>
<p>The <strong>5A secondary output</strong> makes this current transformer suitable for compatible meters and measurement instruments designed for a 5A CT input.</p>
<p>The secondary rating should match the input specification of the connected measuring equipment. For this product, the specified configuration is <strong>500A primary / 5A secondary</strong>.</p>
<p>The secondary circuit should be connected according to the requirements of the CT, measuring equipment and overall electrical installation.</p>
<hr />
<h1>2.5–15 VA Rating</h1>
<p>The <strong>500/5A 65mm Ring CT</strong> has a specified <strong>2.5–15 VA rating</strong>.</p>
<p>VA rating is an important consideration when selecting a current transformer because the connected secondary circuit introduces a burden. This may include the connected meter, measuring instrument and secondary wiring.</p>
<p>Before installation, the expected connected burden should be checked against the specified <strong>2.5–15 VA</strong> range to ensure that the transformer is appropriate for the intended application.</p>
<hr />
<h1>Applications</h1>
<p>The <strong>500/5A 65mm Ring Current Transformer</strong> can be used in compatible applications such as:</p>
<ul>
<li>Energy metering systems</li>
<li>Electrical current measurement</li>
<li>Current monitoring systems</li>
<li>Power monitoring systems</li>
<li>Metering panels</li>
<li>Electrical distribution panels</li>
<li>Electrical control panels</li>
<li>Industrial electrical installations</li>
<li>Electrical monitoring equipment</li>
<li>Energy measurement systems</li>
<li>Current measurement equipment</li>
<li>Compatible panel metering applications</li>
</ul>
<p>The CT should be selected according to the required current ratio, secondary current, accuracy class, burden, conductor dimensions and installation requirements.</p>
<hr />
<h1>Benefits of 500/5A 65mm Ring Current Transformer</h1>
<h3>Class 1.0 Accuracy</h3>
<p>The Class 1.0 specification makes this CT suitable for compatible applications requiring the specified metering accuracy.</p>
<h3>500/5A Current Ratio</h3>
<p>The specified <strong>500/5A ratio</strong> provides a 5A secondary output for compatible current measurement and metering equipment.</p>
<h3>65mm Inner Diameter</h3>
<p>The <strong>65mm inner diameter</strong> provides a larger defined circular opening for compatible conductors and cables.</p>
<h3>Encapsulated Ring Construction</h3>
<p>The encapsulated round-type construction provides a ring-style configuration suitable for compatible electrical measurement installations.</p>
<h3>Standard 5A Secondary</h3>
<p>The 5A secondary output is suitable for compatible measuring equipment designed for a 5A CT input.</p>
<h3>2.5–15 VA Rating</h3>
<p>The specified 2.5–15 VA rating allows the CT to be matched with compatible secondary circuits according to their connected burden.</p>
<h3>Defined Physical Dimensions</h3>
<p>The <strong>120mm OD × 40mm width</strong> provides defined physical dimensions that can be considered during electrical panel and installation planning.</p>
<hr />
<h1>Installation Considerations</h1>
<p>Before installing the <strong>500/5A 65mm Ring Current Transformer</strong>, check the following:</p>
<ol>
<li>Confirm that the required CT ratio is <strong>500/5A</strong>.</li>
<li>Confirm that the primary current requirement is <strong>500A</strong>.</li>
<li>Verify that the connected equipment requires a <strong>5A secondary</strong>.</li>
<li>Confirm that the required accuracy class is <strong>Class 1.0</strong>.</li>
<li>Check that the conductor or cable fits through the <strong>65mm inner diameter</strong>.</li>
<li>Check the available space against the <strong>120mm outer diameter and 40mm width</strong>.</li>
<li>Verify that the connected secondary burden is compatible with the <strong>2.5–15 VA</strong> rating.</li>
<li>Ensure that the CT secondary connections are made according to the requirements of the electrical installation.</li>
</ol>
<p>Installation should be performed by a suitably qualified electrical professional following applicable electrical safety practices.</p>
<hr />
<h1>Why Choose a 500/5A 65mm Class 1.0 Ring CT?</h1>
<p>The <strong>500/5A 65mm Ring Current Transformer</strong> combines a <strong>500A primary current</strong>, <strong>5A secondary output</strong>, <strong>Class 1.0 accuracy</strong> and encapsulated ring-type construction.</p>
<p>Its <strong>65mm inner diameter</strong> provides a larger circular opening for compatible conductors, while the <strong>120mm outer diameter and 40mm width</strong> provide important physical dimensions for installation planning.</p>
<p>The specified <strong>2.5–15 VA rating</strong> can be considered when matching the CT with the connected metering or measurement circuit.</p>
<p>Before selecting the CT, users should verify the required current ratio, primary current, secondary current, accuracy class, conductor size, burden and available installation space.</p>
<hr />
<h1>Product Summary</h1>
<p>The <strong>500/5A Ring Current Transformer 65mm CT</strong> is an encapsulated round-type current transformer featuring:</p>
<ul>
<li><strong>500A primary current</strong></li>
<li><strong>5A secondary current</strong></li>
<li><strong>500/5A current ratio</strong></li>
<li><strong>Class 1.0 accuracy</strong></li>
<li><strong>65mm inner diameter</strong></li>
<li><strong>120mm outer diameter</strong></li>
<li><strong>40mm width</strong></li>
<li><strong>2.5–15 VA rating</strong></li>
</ul>
<p>It is suitable for compatible metering, electrical current measurement and monitoring applications where these specifications meet the requirements of the electrical system.</p>
<hr />
<h1>Frequently Asked Questions</h1>
<h3>What is the current ratio of this Ring CT?</h3>
<p>The current ratio is <strong>500/5A</strong>.</p>
<h3>What is the primary current?</h3>
<p>The specified primary current is <strong>500A</strong>.</p>
<h3>What is the secondary current?</h3>
<p>The secondary current is <strong>5A</strong>.</p>
<h3>What is the accuracy class?</h3>
<p>This current transformer has a specified <strong>Class 1.0 accuracy class</strong>.</p>
<h3>What is the inner diameter of this CT?</h3>
<p>The inner diameter is <strong>65 mm</strong>.</p>
<h3>What is the outer diameter?</h3>
<p>The outer diameter is <strong>120 mm</strong>.</p>
<h3>What is the width of the Ring CT?</h3>
<p>The specified width is <strong>40 mm</strong>.</p>
<h3>What is the VA rating?</h3>
<p>The specified VA rating is <strong>2.5–15 VA</strong>.</p>
<h3>What type of CT is this?</h3>
<p>It is an <strong>encapsulated round-type ring current transformer</strong>.</p>
<h3>Where can the 500/5A Ring CT be used?</h3>
<p>It can be used in compatible metering, current measurement, electrical monitoring, distribution panels, control panels and energy monitoring applications.</p>
<h3>What should I check before buying this CT?</h3>
<p>Check the <strong>500/5A ratio, 500A primary current, 5A secondary, Class 1.0 accuracy, 65mm ID, 120mm OD, 40mm width and 2.5–15 VA rating</strong> against your application requirements.</p>
<hr />
<h1>Shipping &amp; Bulk Orders</h1>
<p>MVG Power Solutions supplies current transformers for compatible electrical metering, monitoring and current measurement requirements.</p>
<p>For bulk requirements, customers can provide the required quantity and application details to receive product and quotation information.</p>
<p>Shipping charges and delivery time may vary depending on order quantity and destination.</p>
<p>For bulk orders, confirm the required <strong>CT ratio, quantity, accuracy class, inner diameter and VA rating</strong> before placing the order.</p>', 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/500-5a-65mm-ring-current-transformer-specifications.jpg', 0, 'published'),
(213, 1, 60, 1, '400/5A Ring Current Transformer 65mm | Class 1.0 Metering CT', '400-5a-65mm-ring-current-transformer', '12040-MVG-R-65', 280.00, 280.00, 10, '85043100', 18.00, 'in_stock', '<ul class="ProseMirror-selectednode" data-spread="false">
<li><strong>Primary Current:</strong> 400A</li>
<li><strong>Secondary Current:</strong> 5A</li>
<li><strong>Current Ratio:</strong> 400/5A</li>
<li><strong>Accuracy Class:</strong> Class 1.0</li>
<li><strong>Inner Diameter (ID):</strong> 65 mm</li>
<li><strong>Outer Diameter (OD):</strong> 120 mm</li>
<li><strong>Width:</strong> 40 mm</li>
<li><strong>VA Rating:</strong> 2.5–15 VA</li>
<li><strong>CT Type:</strong> Encapsulated Round Type Ring Current Transformer</li>
<li><strong>Secondary Output:</strong> 5A</li>
<li><strong>Suitable for:</strong> Metering and current measurement</li>
<li><strong>Suitable for:</strong> Electrical monitoring and compatible panel installations</li>
</ul>', '<h1>Product Overview</h1>
<h2>400/5A 65mm Ring Current Transformer</h2>
<p>The <strong>400/5A Ring Current Transformer 65mm CT</strong> is a Class 1.0 current transformer designed for compatible electrical metering, current measurement and monitoring applications. It features a <strong>400A primary current</strong> and <strong>5A secondary current</strong>, providing a specified <strong>400/5A current ratio</strong> for compatible measuring instruments and electrical monitoring equipment.</p>
<p>This current transformer features an <strong>encapsulated round-type ring construction</strong> with a <strong>65 mm inner diameter</strong>, <strong>120 mm outer diameter</strong>, and <strong>40 mm width</strong>. The larger ring opening provides a defined space for compatible conductors or cables and should be checked against the conductor dimensions before installation.</p>
<p>With its <strong>Class 1.0 accuracy</strong>, this CT is suitable for applications where the specified metering accuracy is required. The 5A secondary output can be connected to compatible meters, monitoring instruments and electrical measurement equipment designed for a 5A CT input.</p>
<p>The transformer has a specified <strong>2.5–15 VA rating</strong>, which should be considered when matching the CT with the connected secondary circuit. The actual burden of the connected meter, measuring equipment and secondary wiring should be checked to ensure compatibility.</p>
<p>The <strong>65 mm inner diameter</strong>, together with the <strong>120 mm outer diameter and 40 mm width</strong>, should be considered when planning the physical installation space.</p>
<hr />
<h1>Key Features</h1>
<p>The <strong>400/5A 65mm Ring Current Transformer</strong> offers the following features:</p>
<ul>
<li>400/5A current ratio</li>
<li>400A primary current</li>
<li>5A secondary current</li>
<li>Class 1.0 accuracy</li>
<li>65 mm inner diameter</li>
<li>120 mm outer diameter</li>
<li>40 mm width</li>
<li>2.5–15 VA rating</li>
<li>Encapsulated round-type ring construction</li>
<li>Standard 5A secondary output</li>
<li>Suitable for compatible metering applications</li>
<li>Suitable for electrical current measurement</li>
<li>Suitable for current monitoring systems</li>
<li>Suitable for compatible electrical panels and installations</li>
</ul>
<hr />
<h1>Technical Specifications</h1>
<table>
<thead>
<tr>
<th>Parameter</th>
<th>Specification</th>
</tr>
</thead>
<tbody>
<tr>
<td>Product Type</td>
<td>Current Transformer</td>
</tr>
<tr>
<td>CT Type</td>
<td>Encapsulated Round Type Ring CT</td>
</tr>
<tr>
<td>Primary Current</td>
<td>400A</td>
</tr>
<tr>
<td>Secondary Current</td>
<td>5A</td>
</tr>
<tr>
<td>Current Ratio</td>
<td>400/5A</td>
</tr>
<tr>
<td>Accuracy Class</td>
<td>Class 1.0</td>
</tr>
<tr>
<td>Inner Diameter (ID)</td>
<td>65 mm</td>
</tr>
<tr>
<td>Outer Diameter (OD)</td>
<td>120 mm</td>
</tr>
<tr>
<td>Width</td>
<td>40 mm</td>
</tr>
<tr>
<td>VA Rating</td>
<td>2.5–15 VA</td>
</tr>
<tr>
<td>Application</td>
<td>Metering &amp; Current Measurement</td>
</tr>
</tbody>
</table>
<hr />
<h1>400/5A Ring Current Transformer for Metering</h1>
<p>The <strong>400/5A Ring Current Transformer</strong> is designed for compatible electrical metering and current measurement systems. With a <strong>400A primary current and 5A secondary output</strong>, it provides a specified current transformation ratio for compatible 5A measurement equipment.</p>
<p>Current transformers are commonly used in electrical systems where current measurement is performed through compatible meters or monitoring instruments. The transformer provides a secondary current corresponding to its specified ratio for use with suitable measurement equipment.</p>
<p>For this product, the specified current ratio is <strong>400/5A</strong>. The connected meter or monitoring instrument should be selected according to the CT&#8217;s 5A secondary requirement and the overall electrical installation.</p>
<p>The CT should be selected after checking the required primary current, secondary current, accuracy class, burden, conductor dimensions and physical installation requirements.</p>
<hr />
<h1>65mm Inner Diameter Ring CT</h1>
<p>This model features a <strong>65 mm inner diameter</strong>, providing a larger circular opening for a compatible conductor or cable.</p>
<p>The conductor or cable dimensions should be checked before installation to ensure they can pass through the 65mm opening. Adequate clearance should be available so the CT can be positioned correctly around the conductor.</p>
<p>The <strong>120 mm outer diameter</strong> and <strong>40 mm width</strong> should also be considered when determining available space inside an electrical panel, enclosure or other installation location.</p>
<p>The ring-type construction provides a defined circular CT configuration for compatible electrical measurement installations.</p>
<hr />
<h1>Class 1.0 Metering Accuracy</h1>
<p>The <strong>Class 1.0 accuracy</strong> specification is an important consideration when selecting this current transformer for compatible metering and measurement applications.</p>
<p>The CT should be used with suitable measuring equipment and within the conditions applicable to its specified accuracy class. The complete secondary circuit, including connected equipment and wiring, should be considered during installation planning.</p>
<p>For applications requiring Class 1.0 accuracy, the <strong>400/5A Class 1.0 Ring CT</strong> can be considered when its ratio, burden, dimensions and other specifications match the requirements of the electrical system.</p>
<hr />
<h1>Standard 5A Secondary Output</h1>
<p>The <strong>5A secondary output</strong> makes this current transformer suitable for compatible meters and measurement instruments designed for a 5A CT input.</p>
<p>The secondary rating should match the input specification of the connected measuring equipment. For this product, the specified configuration is <strong>400A primary / 5A secondary</strong>.</p>
<p>The secondary circuit should be connected according to the requirements of the CT, measuring equipment and overall electrical installation.</p>
<hr />
<h1>2.5–15 VA Rating</h1>
<p>The <strong>400/5A 65mm Ring CT</strong> has a specified <strong>2.5–15 VA rating</strong>.</p>
<p>VA rating is an important consideration when selecting a current transformer because the connected secondary circuit introduces a burden. This may include the connected meter, measuring instrument and secondary wiring.</p>
<p>Before installation, the expected connected burden should be checked against the specified <strong>2.5–15 VA</strong> range to ensure that the transformer is appropriate for the intended application.</p>
<hr />
<h1>Applications</h1>
<p>The <strong>400/5A 65mm Ring Current Transformer</strong> can be used in compatible applications such as:</p>
<ul>
<li>Energy metering systems</li>
<li>Electrical current measurement</li>
<li>Current monitoring systems</li>
<li>Power monitoring systems</li>
<li>Metering panels</li>
<li>Electrical distribution panels</li>
<li>Electrical control panels</li>
<li>Industrial electrical installations</li>
<li>Electrical monitoring equipment</li>
<li>Energy measurement systems</li>
<li>Current measurement equipment</li>
<li>Compatible panel metering applications</li>
</ul>
<p>The CT should be selected according to the required current ratio, secondary current, accuracy class, burden, conductor dimensions and installation requirements.</p>
<hr />
<h1>Benefits of 400/5A 65mm Ring Current Transformer</h1>
<h3>Class 1.0 Accuracy</h3>
<p>The Class 1.0 specification makes this CT suitable for compatible applications requiring the specified metering accuracy.</p>
<h3>400/5A Current Ratio</h3>
<p>The specified <strong>400/5A ratio</strong> provides a 5A secondary output for compatible current measurement and metering equipment.</p>
<h3>65mm Inner Diameter</h3>
<p>The <strong>65mm inner diameter</strong> provides a larger defined circular opening for compatible conductors and cables.</p>
<h3>Encapsulated Ring Construction</h3>
<p>The encapsulated round-type construction provides a ring-style configuration suitable for compatible electrical measurement installations.</p>
<h3>Standard 5A Secondary</h3>
<p>The 5A secondary output is suitable for compatible measuring equipment designed for a 5A CT input.</p>
<h3>2.5–15 VA Rating</h3>
<p>The specified 2.5–15 VA rating allows the CT to be matched with compatible secondary circuits according to their connected burden.</p>
<h3>Defined Physical Dimensions</h3>
<p>The <strong>120mm OD × 40mm width</strong> provides defined physical dimensions that can be considered during electrical panel and installation planning.</p>
<hr />
<h1>Installation Considerations</h1>
<p>Before installing the <strong>400/5A 65mm Ring Current Transformer</strong>, check the following:</p>
<ol>
<li>Confirm that the required CT ratio is <strong>400/5A</strong>.</li>
<li>Confirm that the primary current requirement is <strong>400A</strong>.</li>
<li>Verify that the connected equipment requires a <strong>5A secondary</strong>.</li>
<li>Confirm that the required accuracy class is <strong>Class 1.0</strong>.</li>
<li>Check that the conductor or cable fits through the <strong>65mm inner diameter</strong>.</li>
<li>Check the available space against the <strong>120mm outer diameter and 40mm width</strong>.</li>
<li>Verify that the connected secondary burden is compatible with the <strong>2.5–15 VA</strong> rating.</li>
<li>Ensure that the CT secondary connections are made according to the requirements of the electrical installation.</li>
</ol>
<p>Installation should be performed by a suitably qualified electrical professional following applicable electrical safety practices.</p>
<hr />
<h1>Why Choose a 400/5A 65mm Class 1.0 Ring CT?</h1>
<p>The <strong>400/5A 65mm Ring Current Transformer</strong> combines a <strong>400A primary current</strong>, <strong>5A secondary output</strong>, <strong>Class 1.0 accuracy</strong> and encapsulated ring-type construction.</p>
<p>Its <strong>65mm inner diameter</strong> provides a larger circular opening for compatible conductors, while the <strong>120mm outer diameter and 40mm width</strong> provide important physical dimensions for installation planning.</p>
<p>The specified <strong>2.5–15 VA rating</strong> can be considered when matching the CT with the connected metering or measurement circuit.</p>
<p>Before selecting the CT, users should verify the required current ratio, primary current, secondary current, accuracy class, conductor size, burden and available installation space.</p>
<hr />
<h1>Product Summary</h1>
<p>The <strong>400/5A Ring Current Transformer 65mm CT</strong> is an encapsulated round-type current transformer featuring:</p>
<ul>
<li><strong>400A primary current</strong></li>
<li><strong>5A secondary current</strong></li>
<li><strong>400/5A current ratio</strong></li>
<li><strong>Class 1.0 accuracy</strong></li>
<li><strong>65mm inner diameter</strong></li>
<li><strong>120mm outer diameter</strong></li>
<li><strong>40mm width</strong></li>
<li><strong>2.5–15 VA rating</strong></li>
</ul>
<p>It is suitable for compatible metering, electrical current measurement and monitoring applications where these specifications meet the requirements of the electrical system.</p>
<hr />
<h1>Frequently Asked Questions</h1>
<h3>What is the current ratio of this Ring CT?</h3>
<p>The current ratio is <strong>400/5A</strong>.</p>
<h3>What is the primary current?</h3>
<p>The specified primary current is <strong>400A</strong>.</p>
<h3>What is the secondary current?</h3>
<p>The secondary current is <strong>5A</strong>.</p>
<h3>What is the accuracy class?</h3>
<p>This current transformer has a specified <strong>Class 1.0 accuracy class</strong>.</p>
<h3>What is the inner diameter of this CT?</h3>
<p>The inner diameter is <strong>65 mm</strong>.</p>
<h3>What is the outer diameter?</h3>
<p>The outer diameter is <strong>120 mm</strong>.</p>
<h3>What is the width of the Ring CT?</h3>
<p>The specified width is <strong>40 mm</strong>.</p>
<h3>What is the VA rating?</h3>
<p>The specified VA rating is <strong>2.5–15 VA</strong>.</p>
<h3>What type of CT is this?</h3>
<p>It is an <strong>encapsulated round-type ring current transformer</strong>.</p>
<h3>Where can the 400/5A Ring CT be used?</h3>
<p>It can be used in compatible metering, current measurement, electrical monitoring, distribution panels, control panels and energy monitoring applications.</p>
<h3>What should I check before buying this CT?</h3>
<p>Check the <strong>400/5A ratio, 400A primary current, 5A secondary, Class 1.0 accuracy, 65mm ID, 120mm OD, 40mm width and 2.5–15 VA rating</strong> against your application requirements.</p>
<hr />
<h1>Shipping &amp; Bulk Orders</h1>
<p>MVG Power Solutions supplies current transformers for compatible electrical metering, monitoring and current measurement requirements.</p>
<p>For bulk requirements, customers can provide the required quantity and application details to receive product and quotation information.</p>
<p>Shipping charges and delivery time may vary depending on order quantity and destination.</p>
<p>For bulk orders, confirm the required <strong>CT ratio, quantity, accuracy class, inner diameter and VA rating</strong> before placing the order.</p>', 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/400-5a-65mm-ring-current-transformer-specifications.jpg', 0, 'published'),
(207, 1, 60, 1, '500/5A Ring Current Transformer 45mm | Class 1.0 Metering CT', '500-5a-45mm-ring-current-transformer', '9040-MVG-R-45-1-1', 280.00, 280.00, 10, '85043100', 18.00, 'in_stock', '<ul data-spread="false">
<li><strong>Primary Current:</strong> 500A</li>
<li><strong>Secondary Current:</strong> 5A</li>
<li><strong>Current Ratio:</strong> 500/5A</li>
<li><strong>Accuracy Class:</strong> Class 1.0</li>
<li><strong>Inner Diameter (ID):</strong> 45 mm</li>
<li><strong>Outer Diameter (OD):</strong> 90 mm</li>
<li><strong>Width:</strong> 40 mm</li>
<li><strong>VA Rating:</strong> 2.5–15 VA</li>
<li><strong>CT Type:</strong> Encapsulated Round Type Ring Current Transformer</li>
<li><strong>Secondary Output:</strong> 5A</li>
<li><strong>Suitable for:</strong> Metering and current measurement</li>
<li><strong>Suitable for:</strong> Electrical monitoring and compatible panel installations</li>
</ul>
<div>
<hr />
</div>
<h1></h1>', '<h1>Product Overview</h1>
<h2>500/5A 45mm Ring Current Transformer</h2>
<p>The <strong>500/5A Ring Current Transformer 45mm CT</strong> is a Class 1.0 current transformer designed for compatible electrical metering, current measurement and monitoring applications. It features a <strong>500A primary current</strong> and <strong>5A secondary current</strong>, providing a specified <strong>500/5A current ratio</strong> for compatible measuring instruments and electrical monitoring equipment.</p>
<p>This current transformer features an <strong>encapsulated round-type ring construction</strong> with a <strong>45 mm inner diameter</strong>, <strong>90 mm outer diameter</strong>, and <strong>40 mm width</strong>. The ring configuration provides a circular opening through which a compatible conductor or cable can pass during installation.</p>
<p>With its <strong>Class 1.0 accuracy</strong>, this CT is suitable for applications where the specified metering accuracy is required. Its 5A secondary output can be connected to compatible meters, monitoring instruments and electrical measurement equipment designed for a 5A CT input.</p>
<p>The transformer has a specified <strong>2.5–15 VA rating</strong>, which should be considered when matching the CT with the connected secondary circuit. The actual burden of the connected meter, measuring equipment and secondary wiring should be checked to ensure compatibility with the transformer.</p>
<p>The <strong>45 mm inner diameter</strong> provides a defined opening for compatible conductors. Before installation, the conductor or cable dimensions should be checked against the available opening to ensure suitable physical installation.</p>
<hr />
<h1>Key Features</h1>
<p>The <strong>500/5A 45mm Ring Current Transformer</strong> offers the following features:</p>
<ul>
<li>500/5A current ratio</li>
<li>500A primary current</li>
<li>5A secondary current</li>
<li>Class 1.0 accuracy</li>
<li>45 mm inner diameter</li>
<li>90 mm outer diameter</li>
<li>40 mm width</li>
<li>2.5–15 VA rating</li>
<li>Encapsulated round-type ring construction</li>
<li>Standard 5A secondary output</li>
<li>Suitable for compatible metering applications</li>
<li>Suitable for electrical current measurement</li>
<li>Suitable for current monitoring systems</li>
<li>Suitable for compatible electrical panels and installations</li>
</ul>
<hr />
<h1>Technical Specifications</h1>
<table>
<thead>
<tr>
<th>Parameter</th>
<th>Specification</th>
</tr>
</thead>
<tbody>
<tr>
<td>Product Type</td>
<td>Current Transformer</td>
</tr>
<tr>
<td>CT Type</td>
<td>Encapsulated Round Type Ring CT</td>
</tr>
<tr>
<td>Primary Current</td>
<td>500A</td>
</tr>
<tr>
<td>Secondary Current</td>
<td>5A</td>
</tr>
<tr>
<td>Current Ratio</td>
<td>500/5A</td>
</tr>
<tr>
<td>Accuracy Class</td>
<td>Class 1.0</td>
</tr>
<tr>
<td>Inner Diameter (ID)</td>
<td>45 mm</td>
</tr>
<tr>
<td>Outer Diameter (OD)</td>
<td>90 mm</td>
</tr>
<tr>
<td>Width</td>
<td>40 mm</td>
</tr>
<tr>
<td>VA Rating</td>
<td>2.5–15 VA</td>
</tr>
<tr>
<td>Application</td>
<td>Metering &amp; Current Measurement</td>
</tr>
</tbody>
</table>
<hr />
<h1>500/5A Ring Current Transformer for Metering</h1>
<p>The <strong>500/5A Ring Current Transformer</strong> is designed for compatible electrical metering and current measurement systems. With a <strong>500A primary current and 5A secondary output</strong>, the CT provides a specified current transformation ratio for compatible 5A measurement equipment.</p>
<p>Current transformers are commonly used in electrical systems where current measurement is performed through compatible meters or monitoring instruments. The transformer provides a secondary current corresponding to its specified ratio for use with suitable measurement equipment.</p>
<p>For this product, the specified current ratio is <strong>500/5A</strong>. The connected meter or monitoring instrument should be selected according to the CT&#8217;s 5A secondary requirement and the overall electrical installation.</p>
<p>The CT should always be selected after checking the required primary current, secondary current, accuracy class, burden and physical installation requirements.</p>
<hr />
<h1>45mm Inner Diameter Ring CT</h1>
<p>This model features a <strong>45 mm inner diameter</strong>, providing a circular opening for a compatible conductor or cable.</p>
<p>Before installation, the conductor dimensions should be checked against the 45mm opening. Sufficient clearance should be available so the CT can be positioned correctly around the conductor.</p>
<p>The <strong>90 mm outer diameter</strong> and <strong>40 mm width</strong> should also be considered when planning the available installation space inside an electrical panel, enclosure or monitoring system.</p>
<p>The ring-type construction provides a defined circular CT configuration for compatible electrical measurement installations.</p>
<hr />
<h1>Class 1.0 Metering Accuracy</h1>
<p>The <strong>Class 1.0 accuracy</strong> specification is an important consideration when selecting this current transformer for compatible metering and measurement applications.</p>
<p>The CT should be used with suitable measuring equipment and within the conditions applicable to its specified accuracy class. The complete secondary circuit, including connected equipment and wiring, should be considered during installation planning.</p>
<p>For applications requiring Class 1.0 accuracy, the <strong>500/5A Class 1.0 Ring CT</strong> can be considered when its ratio, burden, dimensions and other specifications match the requirements of the electrical system.</p>
<hr />
<h1>Standard 5A Secondary Output</h1>
<p>The <strong>5A secondary output</strong> makes this current transformer suitable for compatible meters and measurement instruments designed for a 5A CT input.</p>
<p>The secondary rating should match the input specification of the connected measuring equipment. For this product, the specified configuration is <strong>500A primary / 5A secondary</strong>.</p>
<p>The secondary circuit should be connected according to the requirements of the CT, measuring equipment and overall electrical installation.</p>
<hr />
<h1>2.5–15 VA Rating</h1>
<p>The <strong>500/5A 45mm Ring CT</strong> has a specified <strong>2.5–15 VA rating</strong>.</p>
<p>VA rating is an important consideration when selecting a current transformer because the connected secondary circuit introduces a burden. This may include the connected meter, measuring instrument and secondary wiring.</p>
<p>Before installation, the expected connected burden should be checked against the specified <strong>2.5–15 VA</strong> range to ensure that the transformer is appropriate for the intended application.</p>
<hr />
<h1>Applications</h1>
<p>The <strong>500/5A 45mm Ring Current Transformer</strong> can be used in compatible applications such as:</p>
<ul>
<li>Energy metering systems</li>
<li>Electrical current measurement</li>
<li>Current monitoring systems</li>
<li>Power monitoring systems</li>
<li>Metering panels</li>
<li>Electrical distribution panels</li>
<li>Electrical control panels</li>
<li>Industrial electrical installations</li>
<li>Electrical monitoring equipment</li>
<li>Energy measurement systems</li>
<li>Current measurement equipment</li>
<li>Compatible panel metering applications</li>
</ul>
<p>The CT should be selected according to the required current ratio, secondary current, accuracy class, burden, conductor dimensions and installation requirements.</p>
<hr />
<h1>Benefits of 500/5A 45mm Ring Current Transformer</h1>
<h3>Class 1.0 Accuracy</h3>
<p>The Class 1.0 specification makes this CT suitable for compatible applications requiring the specified metering accuracy.</p>
<h3>500/5A Current Ratio</h3>
<p>The specified <strong>500/5A ratio</strong> provides a 5A secondary output for compatible current measurement and metering equipment.</p>
<h3>45mm Inner Diameter</h3>
<p>The <strong>45mm inner diameter</strong> provides a defined circular opening for compatible conductors and cables.</p>
<h3>Encapsulated Ring Construction</h3>
<p>The encapsulated round-type construction provides a ring-style configuration suitable for compatible electrical measurement installations.</p>
<h3>Standard 5A Secondary</h3>
<p>The 5A secondary output is suitable for compatible measuring equipment designed for a 5A CT input.</p>
<h3>2.5–15 VA Rating</h3>
<p>The specified 2.5–15 VA rating allows the CT to be matched with compatible secondary circuits according to their connected burden.</p>
<h3>Defined Physical Dimensions</h3>
<p>The <strong>90mm OD × 40mm width</strong> provides defined physical dimensions that can be considered during electrical panel and installation planning.</p>
<hr />
<h1>Installation Considerations</h1>
<p>Before installing the <strong>500/5A 45mm Ring Current Transformer</strong>, check the following:</p>
<ol>
<li>Confirm that the required CT ratio is <strong>500/5A</strong>.</li>
<li>Confirm that the primary current requirement is <strong>500A</strong>.</li>
<li>Verify that the connected equipment requires a <strong>5A secondary</strong>.</li>
<li>Confirm that the required accuracy class is <strong>Class 1.0</strong>.</li>
<li>Check that the conductor or cable fits through the <strong>45mm inner diameter</strong>.</li>
<li>Check the available space against the <strong>90mm outer diameter and 40mm width</strong>.</li>
<li>Verify that the connected secondary burden is compatible with the <strong>2.5–15 VA</strong> rating.</li>
<li>Ensure that the CT secondary connections are made according to the requirements of the electrical installation.</li>
</ol>
<p>Installation should be performed by a suitably qualified electrical professional following applicable electrical safety practices.</p>
<hr />
<h1>Why Choose a 500/5A 45mm Class 1.0 Ring CT?</h1>
<p>The <strong>500/5A 45mm Ring Current Transformer</strong> combines a <strong>500A primary current</strong>, <strong>5A secondary output</strong>, <strong>Class 1.0 accuracy</strong> and encapsulated ring-type construction.</p>
<p>Its <strong>45mm inner diameter</strong> provides a defined circular opening for compatible conductors, while the <strong>90mm outer diameter and 40mm width</strong> provide important physical dimensions for installation planning.</p>
<p>The specified <strong>2.5–15 VA rating</strong> can be considered when matching the CT with the connected metering or measurement circuit.</p>
<p>Before selecting the CT, users should verify the required current ratio, primary current, secondary current, accuracy class, conductor size, burden and available installation space.</p>
<hr />
<h1>Product Summary</h1>
<p>The <strong>500/5A Ring Current Transformer 45mm CT</strong> is an encapsulated round-type current transformer featuring:</p>
<ul>
<li><strong>500A primary current</strong></li>
<li><strong>5A secondary current</strong></li>
<li><strong>500/5A current ratio</strong></li>
<li><strong>Class 1.0 accuracy</strong></li>
<li><strong>45mm inner diameter</strong></li>
<li><strong>90mm outer diameter</strong></li>
<li><strong>40mm width</strong></li>
<li><strong>2.5–15 VA rating</strong></li>
</ul>
<p>It is suitable for compatible metering, electrical current measurement and monitoring applications where these specifications meet the requirements of the electrical system.</p>
<hr />
<h1>Frequently Asked Questions</h1>
<h3>What is the current ratio of this Ring CT?</h3>
<p>The current ratio is <strong>500/5A</strong>.</p>
<h3>What is the primary current?</h3>
<p>The specified primary current is <strong>500A</strong>.</p>
<h3>What is the secondary current?</h3>
<p>The secondary current is <strong>5A</strong>.</p>
<h3>What is the accuracy class?</h3>
<p>This current transformer has a specified <strong>Class 1.0 accuracy class</strong>.</p>
<h3>What is the inner diameter of this CT?</h3>
<p>The inner diameter is <strong>45 mm</strong>.</p>
<h3>What is the outer diameter?</h3>
<p>The outer diameter is <strong>90 mm</strong>.</p>
<h3>What is the width of the Ring CT?</h3>
<p>The specified width is <strong>40 mm</strong>.</p>
<h3>What is the VA rating?</h3>
<p>The specified VA rating is <strong>2.5–15 VA</strong>.</p>
<h3>What type of CT is this?</h3>
<p>It is an <strong>encapsulated round-type ring current transformer</strong>.</p>
<h3>Where can the 500/5A Ring CT be used?</h3>
<p>It can be used in compatible metering, current measurement, electrical monitoring, distribution panels, control panels and energy monitoring applications.</p>
<h3>What should I check before buying this CT?</h3>
<p>Check the <strong>500/5A ratio, 500A primary current, 5A secondary, Class 1.0 accuracy, 45mm ID, 90mm OD, 40mm width and 2.5–15 VA rating</strong> against your application requirements.</p>
<hr />
<h1>Shipping &amp; Bulk Orders</h1>
<p>MVG Power Solutions supplies current transformers for compatible electrical metering, monitoring and current measurement requirements.</p>
<p>For bulk requirements, customers can provide the required quantity and application details to receive product and quotation information.</p>
<p>Shipping charges and delivery time may vary depending on order quantity and destination.</p>
<p>For bulk orders, confirm the required <strong>CT ratio, quantity, accuracy class, inner diameter and VA rating</strong> before placing the order.</p>', 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/500-5a-45mm-ring-current-transformer-specifications.jpg', 0, 'published'),
(203, 1, 60, 1, '300/5A Ring Current Transformer 45mm | Class 1.0 Metering CT', '300-5a-45mm-ring-current-transformer', '9040-MVG-R-45-1', 280.00, 280.00, 10, '85043100', 18.00, 'in_stock', '<ul data-spread="false">
<li><strong>Primary Current:</strong> 300A</li>
<li><strong>Secondary Current:</strong> 5A</li>
<li><strong>Current Ratio:</strong> 300/5A</li>
<li><strong>Accuracy Class:</strong> Class 1.0</li>
<li><strong>Inner Diameter (ID):</strong> 45 mm</li>
<li><strong>Outer Diameter (OD):</strong> 90 mm</li>
<li><strong>Width:</strong> 40 mm</li>
<li><strong>VA Rating:</strong> 2.5–15 VA</li>
<li><strong>CT Type:</strong> Encapsulated Round Type Ring Current Transformer</li>
<li><strong>Secondary Output:</strong> 5A</li>
<li><strong>Suitable for:</strong> Metering and current measurement applications</li>
<li><strong>Suitable for:</strong> Electrical monitoring and compatible panel installations</li>
</ul>
<div>
<hr />
</div>
<h1></h1>', '<h1>Product Overview</h1>
<h2>300/5A 45mm Ring Current Transformer</h2>
<p>The <strong>300/5A Ring Current Transformer 45mm CT</strong> is a Class 1.0 current transformer designed for compatible electrical metering, current measurement and monitoring applications. It features a <strong>300A primary current</strong>, <strong>5A secondary current</strong>, and a <strong>300/5A current ratio</strong>, providing a standard 5A secondary output for compatible measuring instruments and electrical monitoring equipment.</p>
<p>This current transformer uses an <strong>encapsulated round-type ring construction</strong> with a <strong>45 mm inner diameter</strong>, <strong>90 mm outer diameter</strong>, and <strong>40 mm width</strong>. The ring-style design provides a defined central opening through which a compatible conductor or cable can pass, making the CT suitable for installations where a ring-type configuration is required.</p>
<p>The <strong>Class 1.0 accuracy</strong> specification makes this CT suitable for compatible metering and measurement applications where the specified accuracy class is required. The 5A secondary output can be connected to compatible current meters, energy monitoring equipment and other measurement devices designed for a 5A CT secondary.</p>
<p>The CT has a specified <strong>2.5–15 VA rating</strong>, which should be considered when matching the transformer with the connected secondary circuit. The actual connected burden, cable length, measuring equipment and installation requirements should be checked before selecting the CT.</p>
<p>With its <strong>45mm inner diameter</strong>, the transformer provides a defined opening for compatible conductors. The conductor or cable dimensions should be checked before installation to ensure the CT can be properly positioned around the conductor.</p>
<hr />
<h1>Key Features</h1>
<p>The <strong>300/5A 45mm Ring Current Transformer</strong> provides the following features:</p>
<ul>
<li>300/5A current ratio</li>
<li>300A primary current</li>
<li>5A secondary current</li>
<li>Class 1.0 accuracy</li>
<li>45 mm inner diameter</li>
<li>90 mm outer diameter</li>
<li>40 mm width</li>
<li>2.5–15 VA rating</li>
<li>Encapsulated round-type ring construction</li>
<li>Standard 5A secondary output</li>
<li>Suitable for compatible metering applications</li>
<li>Suitable for electrical current measurement</li>
<li>Suitable for current monitoring systems</li>
<li>Suitable for compatible electrical panels and installations</li>
</ul>
<hr />
<h1>Technical Specifications</h1>
<table>
<thead>
<tr>
<th>Parameter</th>
<th>Specification</th>
</tr>
</thead>
<tbody>
<tr>
<td>Product Type</td>
<td>Current Transformer</td>
</tr>
<tr>
<td>CT Type</td>
<td>Encapsulated Round Type Ring CT</td>
</tr>
<tr>
<td>Primary Current</td>
<td>300A</td>
</tr>
<tr>
<td>Secondary Current</td>
<td>5A</td>
</tr>
<tr>
<td>Current Ratio</td>
<td>300/5A</td>
</tr>
<tr>
<td>Accuracy Class</td>
<td>Class 1.0</td>
</tr>
<tr>
<td>Inner Diameter (ID)</td>
<td>45 mm</td>
</tr>
<tr>
<td>Outer Diameter (OD)</td>
<td>90 mm</td>
</tr>
<tr>
<td>Width</td>
<td>40 mm</td>
</tr>
<tr>
<td>VA Rating</td>
<td>2.5–15 VA</td>
</tr>
<tr>
<td>Application</td>
<td>Metering &amp; Current Measurement</td>
</tr>
</tbody>
</table>
<hr />
<h1>300/5A Ring Current Transformer for Metering</h1>
<p>The <strong>300/5A Ring Current Transformer</strong> is designed for compatible electrical metering and current measurement applications. With a <strong>300A primary current and 5A secondary output</strong>, the transformer provides a suitable current transformation configuration for compatible 5A measurement equipment.</p>
<p>Current transformers are used in electrical systems where current measurement needs to be performed using compatible metering or monitoring instruments. The CT allows the connected measurement equipment to work with its specified secondary input rather than being directly connected to the primary current circuit.</p>
<p>The CT ratio should always be selected according to the electrical system and the requirements of the connected measuring equipment. For this product, the specified ratio is <strong>300/5A</strong>.</p>
<hr />
<h1>45mm Inner Diameter Ring CT</h1>
<p>This model features a <strong>45 mm inner diameter</strong>, providing a circular opening for a compatible conductor or cable.</p>
<p>Before installation, the diameter and physical dimensions of the conductor should be checked against the 45mm opening. Adequate clearance should be maintained so the CT can be positioned correctly without creating unnecessary mechanical stress.</p>
<p>The CT has an <strong>outer diameter of 90 mm</strong> and a <strong>width of 40 mm</strong>. These dimensions should also be considered when planning panel space or equipment installation.</p>
<p>The round ring configuration makes the product suitable for applications requiring a circular CT opening around a compatible conductor.</p>
<hr />
<h1>Class 1.0 Metering Accuracy</h1>
<p>The <strong>Class 1.0 accuracy class</strong> is an important specification for selecting this current transformer for compatible metering and measurement applications.</p>
<p>The accuracy class indicates the specified measurement accuracy characteristics of the CT under applicable conditions. The complete measuring circuit should be designed according to the CT specifications and the requirements of the connected equipment.</p>
<p>For applications where Class 1.0 accuracy is required, the <strong>300/5A Class 1.0 CT</strong> can be considered when its other specifications, including ratio, burden and physical dimensions, match the electrical installation.</p>
<hr />
<h1>Standard 5A Secondary Output</h1>
<p>The <strong>5A secondary output</strong> is suitable for compatible meters and measurement equipment designed for a 5A CT input.</p>
<p>When selecting the transformer, the secondary rating of the CT should match the input specification of the connected measuring device. The 300/5A configuration provides a specified <strong>300A primary to 5A secondary</strong> relationship.</p>
<p>The secondary circuit, measuring equipment and connected wiring should be selected according to the requirements of the complete electrical installation.</p>
<hr />
<h1>2.5–15 VA Rating</h1>
<p>This current transformer has a specified <strong>2.5–15 VA rating</strong>.</p>
<p>The VA rating is an important consideration when selecting a CT because the connected secondary circuit creates a burden on the transformer. The burden can include the connected measuring instrument and secondary wiring.</p>
<p>For proper application, the expected connected burden should be checked against the CT&#8217;s specified VA range before installation.</p>
<hr />
<h1>Applications</h1>
<p>The <strong>300/5A 45mm Ring Current Transformer</strong> can be used in compatible applications such as:</p>
<ul>
<li>Energy metering systems</li>
<li>Electrical current measurement</li>
<li>Current monitoring systems</li>
<li>Power monitoring systems</li>
<li>Metering panels</li>
<li>Electrical distribution panels</li>
<li>Electrical control panels</li>
<li>Industrial electrical installations</li>
<li>Electrical monitoring equipment</li>
<li>Energy measurement systems</li>
<li>Compatible panel metering applications</li>
<li>Electrical measurement systems</li>
</ul>
<p>The CT should be selected according to the required current ratio, secondary current, accuracy class, burden, conductor dimensions and installation requirements.</p>
<hr />
<h1>Benefits of 300/5A 45mm Ring Current Transformer</h1>
<h3>Class 1.0 Accuracy</h3>
<p>The Class 1.0 specification makes the CT suitable for compatible applications requiring the specified metering accuracy.</p>
<h3>300/5A Current Ratio</h3>
<p>The specified 300/5A ratio provides a 5A secondary output for compatible current measurement and metering equipment.</p>
<h3>45mm Inner Diameter</h3>
<p>The 45mm inner diameter provides a defined circular opening for compatible conductors and cables.</p>
<h3>Encapsulated Ring Construction</h3>
<p>The encapsulated round-type construction provides a ring-style configuration suitable for compatible electrical measurement installations.</p>
<h3>Standard 5A Secondary</h3>
<p>The 5A secondary output is compatible with measuring instruments designed for a 5A CT secondary input.</p>
<h3>2.5–15 VA Rating</h3>
<p>The specified 2.5–15 VA rating allows the CT to be matched with compatible secondary circuits according to their connected burden.</p>
<h3>Compact Ring-Type Configuration</h3>
<p>The <strong>90mm OD × 40mm width</strong> configuration provides defined physical dimensions that can be considered during electrical panel an</p>
<h1>Installation Considerations</h1>
<p class="isSelectedEnd">Before installing the <strong>300/5A 45mm Ring Current Transformer</strong>, check the following:</p>
<ol start="1" data-spread="false">
<li>Confirm that the required CT ratio is <strong>300/5A</strong>.</li>
<li>Confirm that the primary current specification is <strong>300A</strong>.</li>
<li>Verify that the connected equipment requires a <strong>5A secondary</strong>.</li>
<li>Confirm that the required accuracy class is <strong>Class 1.0</strong>.</li>
<li>Check that the conductor or cable fits through the <strong>45mm inner diameter</strong>.</li>
<li>Check the available installation space against the <strong>90mm outer diameter and 40mm width</strong>.</li>
<li>Verify that the connected secondary burden is compatible with the <strong>2.5–15 VA</strong> rating.</li>
<li>Ensure that the CT secondary connections are made according to the requirements of the electrical installation.</li>
</ol>
<p class="isSelectedEnd">Installation should be performed by a suitably qualified electrical professional following applicable electrical safety practices.</p>
<div>
<hr />
</div>
<h1>Why Choose a 300/5A 45mm Class 1.0 Ring CT?</h1>
<p class="isSelectedEnd">The <strong>300/5A 45mm Ring Current Transformer</strong> combines a 300A primary current, 5A secondary output, Class 1.0 accuracy and encapsulated ring-type construction.</p>
<p class="isSelectedEnd">Its <strong>45mm inner diameter</strong> provides a defined circular opening for compatible conductors, while the <strong>90mm outer diameter and 40mm width</strong> provide clear physical dimensions for installation planning.</p>
<p class="isSelectedEnd">The specified <strong>2.5–15 VA rating</strong> can be considered when matching the CT with the connected metering and measurement circuit.</p>
<p class="isSelectedEnd">For every installation, users should verify the required ratio, primary and secondary current, accuracy class, conductor dimensions, burden and available installation space before selecting the transformer.</p>
<div>
<hr />
</div>
<h1>Product Summary</h1>
<p class="isSelectedEnd">The <strong>300/5A Ring Current Transformer 45mm CT</strong> is an encapsulated round-type current transformer featuring:</p>
<ul data-spread="false">
<li><strong>300A primary current</strong></li>
<li><strong>5A secondary current</strong></li>
<li><strong>300/5A current ratio</strong></li>
<li><strong>Class 1.0 accuracy</strong></li>
<li><strong>45mm inner diameter</strong></li>
<li><strong>90mm outer diameter</strong></li>
<li><strong>40mm width</strong></li>
<li><strong>2.5–15 VA rating</strong></li>
</ul>
<p class="isSelectedEnd">It is suitable for compatible metering, electrical current measurement and monitoring applications where these specifications meet the requirements of the electrical system.</p>
<div>
<hr />
</div>
<h1>Frequently Asked Questions</h1>
<h3>What is the current ratio of this Ring CT?</h3>
<p class="isSelectedEnd">The current ratio is <strong>300/5A</strong>.</p>
<h3>What is the primary current?</h3>
<p class="isSelectedEnd">The specified primary current is <strong>300A</strong>.</p>
<h3>What is the secondary current?</h3>
<p class="isSelectedEnd">The secondary current is <strong>5A</strong>.</p>
<h3>What is the accuracy class?</h3>
<p class="isSelectedEnd">The CT has a specified <strong>Class 1.0 accuracy class</strong>.</p>
<h3>What is the inner diameter of this CT?</h3>
<p class="isSelectedEnd">The inner diameter is <strong>45 mm</strong>.</p>
<h3>What is the outer diameter?</h3>
<p class="isSelectedEnd">The outer diameter is <strong>90 mm</strong>.</p>
<h3>What is the width of the Ring CT?</h3>
<p class="isSelectedEnd">The specified width is <strong>40 mm</strong>.</p>
<h3>What is the VA rating?</h3>
<p class="isSelectedEnd">The specified VA rating is <strong>2.5–15 VA</strong>.</p>
<h3>What type of current transformer is this?</h3>
<p class="isSelectedEnd">It is an <strong>encapsulated round-type ring current transformer</strong>.</p>
<h3>Where can the 300/5A Ring CT be used?</h3>
<p class="isSelectedEnd">It can be used in compatible metering, current measurement, electrical monitoring, distribution panels, control panels and energy monitoring applications.</p>
<h3>What should I check before buying this CT?</h3>
<p class="isSelectedEnd">Check the required <strong>300/5A ratio, 300A primary current, 5A secondary, Class 1.0 accuracy, 45mm inner diameter, 90mm outer diameter, 40mm width and 2.5–15 VA rating</strong> against your application requirements.</p>
<div>
<hr />
</div>
<h1>Shipping &amp; Bulk Orders</h1>
<p class="isSelectedEnd">MVG Power Solutions supplies current transformers for compatible electrical metering, monitoring and current measurement requirements.</p>
<p class="isSelectedEnd">For bulk requirements, customers can provide the required quantity and application details to receive product and quotation information.</p>
<p class="isSelectedEnd">Shipping charges and delivery time may vary depending on the order quantity and destination.</p>
<p>For bulk orders, confirm the required <strong>CT ratio, quantity, accuracy class, inner diameter and VA rating</strong> before placing the order.</p>', 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/300-5a-45mm-encapsulated-ring-current-transformer.jpg', 0, 'published'),
(200, 1, 60, 1, '200/5A Ring Current Transformer 45mm | Class 1.0 Metering CT', '200-5a-45mm-ring-current-transformer', '9040-MVG-R-45', 280.00, 280.00, 10, '85043100', 18.00, 'in_stock', '<ul data-spread="false">
<li><strong>Product Type:</strong> Encapsulated Round Type Ring Current Transformer</li>
<li><strong>Primary Current:</strong> 200A</li>
<li><strong>Secondary Current:</strong> 5A</li>
<li><strong>Current Ratio:</strong> 200/5A</li>
<li><strong>Accuracy Class:</strong> Class 1.0</li>
<li><strong>Inner Diameter (ID):</strong> 45 mm</li>
<li><strong>Outer Diameter (OD):</strong> 90 mm</li>
<li><strong>Width:</strong> 40 mm</li>
<li><strong>VA Rating:</strong> 2.5–15 VA</li>
<li><strong>Secondary Output:</strong> 5A</li>
<li><strong>Construction:</strong> Encapsulated Round / Ring Type</li>
<li><strong>Application:</strong> Metering &amp; Current Measurement</li>
<li><strong>Suitable for:</strong> Electrical panels, metering systems and current monitoring applications</li>
</ul>
<div>
<hr />
</div>
<h2></h2>', '<h2>Product Overview</h2>
<h3>200/5A 45mm Ring Current Transformer</h3>
<p>The <strong>200/5A 45mm Ring Current Transformer</strong> is a Class 1.0 encapsulated round-type current transformer designed for compatible electrical metering, current measurement and monitoring applications. It is specified with a <strong>200A primary current and 5A secondary current</strong>, providing a standard 5A output for compatible meters and electrical measuring equipment.</p>
<p>This ring-type CT features a <strong>45mm inner diameter</strong>, allowing a compatible cable or conductor to pass through the central opening. The transformer has a <strong>90mm outer diameter and 40mm width</strong>, providing defined physical dimensions that should be considered when planning installation inside an electrical panel or suitable enclosure.</p>
<p>The <strong>200/5A current ratio</strong> is designed for electrical systems requiring measurement of a 200A primary current using compatible 5A measuring equipment. The 5A secondary output can be connected to compatible energy meters, digital meters, monitoring equipment and other instruments designed for a 5A CT input.</p>
<p>With <strong>Class 1.0 accuracy</strong>, this current transformer is suitable for compatible metering and current measurement applications where Class 1.0 accuracy is specified. Its <strong>2.5–15 VA rating</strong> should also be considered when matching the CT with the connected secondary circuit and measuring equipment.</p>
<p>The encapsulated round-type construction provides a practical ring configuration for conductor-through-CT installations. Before installation, users should verify the conductor size, CT opening, available installation space, connected burden and measuring equipment requirements.</p>
<hr />
<h2>Key Features</h2>
<p>The <strong>200/5A 45mm Ring Current Transformer</strong> offers:</p>
<ul>
<li>200/5A current ratio</li>
<li>200A primary current</li>
<li>5A secondary current</li>
<li>Class 1.0 accuracy</li>
<li>45mm inner diameter</li>
<li>90mm outer diameter</li>
<li>40mm width</li>
<li>2.5–15 VA rating</li>
<li>Encapsulated round-type construction</li>
<li>Ring-type CT configuration</li>
<li>Standard 5A secondary output</li>
<li>Suitable for metering applications</li>
<li>Suitable for current measurement</li>
<li>Suitable for electrical monitoring</li>
<li>Suitable for compatible electrical panels</li>
</ul>
<hr />
<h2>Technical Specifications</h2>
<table>
<thead>
<tr>
<th>Parameter</th>
<th>Specification</th>
</tr>
</thead>
<tbody>
<tr>
<td><strong>Product Type</strong></td>
<td>Current Transformer</td>
</tr>
<tr>
<td><strong>CT Type</strong></td>
<td>Encapsulated Round / Ring Type</td>
</tr>
<tr>
<td><strong>Primary Current</strong></td>
<td>200A</td>
</tr>
<tr>
<td><strong>Secondary Current</strong></td>
<td>5A</td>
</tr>
<tr>
<td><strong>Current Ratio</strong></td>
<td>200/5A</td>
</tr>
<tr>
<td><strong>Accuracy Class</strong></td>
<td>Class 1.0</td>
</tr>
<tr>
<td><strong>Inner Diameter (ID)</strong></td>
<td>45 mm</td>
</tr>
<tr>
<td><strong>Outer Diameter (OD)</strong></td>
<td>90 mm</td>
</tr>
<tr>
<td><strong>Width</strong></td>
<td>40 mm</td>
</tr>
<tr>
<td><strong>VA Rating</strong></td>
<td>2.5–15 VA</td>
</tr>
<tr>
<td><strong>Application</strong></td>
<td>Metering &amp; Current Measurement</td>
</tr>
</tbody>
</table>
<hr />
<h1>200/5A Ring Current Transformer for Metering</h1>
<p>The <strong>200/5A Ring Current Transformer</strong> is designed for electrical systems requiring measurement of a 200A primary current through a standard 5A secondary output.</p>
<p>This configuration can be used with compatible current meters, energy meters and monitoring equipment designed for a 5A CT input. The <strong>Class 1.0 accuracy</strong> specification makes the CT suitable for compatible metering and current measurement applications where this accuracy class is required.</p>
<p>When selecting a current transformer, the current ratio should not be considered alone. The secondary current, accuracy class, VA rating, physical dimensions, conductor size and connected measuring equipment should also be checked.</p>
<hr />
<h1>45mm Inner Diameter Ring CT</h1>
<p>The <strong>45mm inner diameter</strong> provides the central opening through which a compatible cable or conductor can pass.</p>
<p>Before installation, the actual diameter and shape of the primary conductor should be checked against the 45mm opening. Adequate installation clearance should also be maintained.</p>
<p>The <strong>90mm outer diameter</strong> and <strong>40mm width</strong> are important physical dimensions for determining whether the CT will fit within the available electrical panel or installation area.</p>
<hr />
<h1>Class 1.0 Metering Accuracy</h1>
<p>This <strong>200/5A Current Transformer is specified with Class 1.0 accuracy</strong>. It can be considered for compatible electrical metering and current measurement applications where Class 1.0 accuracy is required.</p>
<p>The complete measurement performance depends on the CT, connected burden, secondary wiring, measuring equipment and operating conditions. Therefore, the complete measurement circuit should be checked against the required specifications.</p>
<hr />
<h1>Standard 5A Secondary Output</h1>
<p>The CT provides a <strong>5A secondary output</strong>, making it suitable for compatible meters and monitoring equipment designed for a 5A current transformer input.</p>
<p>The <strong>200/5A ratio</strong> represents a 200A primary and 5A secondary configuration. The connected measuring equipment should be verified before installation to ensure compatibility with the 5A secondary.</p>
<hr />
<h1>2.5–15 VA Rating</h1>
<p>The specified <strong>VA rating is 2.5–15 VA</strong>. This rating should be considered when matching the current transformer with the connected secondary circuit.</p>
<p>The total connected burden should be compatible with the CT&#8217;s specified rating. Secondary wiring, meters and other connected components can contribute to the overall burden of the measurement circuit.</p>
<hr />
<h1>Applications</h1>
<p>The <strong>200/5A 45mm Ring Current Transformer</strong> can be used in compatible electrical applications including:</p>
<ul>
<li>Energy metering systems</li>
<li>Electrical current measurement</li>
<li>Distribution panels</li>
<li>Electrical control panels</li>
<li>Metering panels</li>
<li>Power monitoring systems</li>
<li>Industrial electrical installations</li>
<li>Current monitoring systems</li>
<li>Electrical monitoring equipment</li>
<li>Energy monitoring applications</li>
<li>Commercial electrical systems</li>
<li>Compatible digital metering systems</li>
</ul>
<p>The CT should be selected according to the required primary current, secondary current, accuracy, VA rating, physical dimensions and electrical installation requirements.</p>
<hr />
<h1>Benefits of 200/5A 45mm Ring Current Transformer</h1>
<h3>Class 1.0 Accuracy</h3>
<p>The Class 1.0 specification makes the CT suitable for compatible metering and current measurement applications requiring the specified accuracy class.</p>
<h3>Standard 5A Secondary</h3>
<p>The 5A secondary output is suitable for compatible meters and current measurement equipment designed for a 5A CT secondary.</p>
<h3>200/5A Current Ratio</h3>
<p>The 200/5A configuration is designed for electrical systems requiring measurement of a 200A primary current through compatible 5A measuring equipment.</p>
<h3>45mm Inner Diameter</h3>
<p>The 45mm opening provides a defined passage for a compatible cable or conductor through the ring-type CT.</p>
<h3>90mm Outer Diameter</h3>
<p>The 90mm outer diameter should be considered when planning installation clearance and available panel space.</p>
<h3>40mm Width</h3>
<p>The 40mm width provides an important physical dimension for determining the required installation space.</p>
<h3>2.5–15 VA Rating</h3>
<p>The 2.5–15 VA specification should be matched with the requirements of the connected secondary circuit.</p>
<h3>Encapsulated Ring Construction</h3>
<p>The encapsulated round construction provides a practical configuration for compatible conductor-through-CT installations.</p>
<hr />
<h1>Installation Considerations</h1>
<p>Before installing the <strong>200/5A 45mm Ring Current Transformer</strong>, verify:</p>
<ol>
<li>The required primary current is 200A.</li>
<li>The connected equipment requires a 5A CT secondary.</li>
<li>Class 1.0 accuracy is suitable for the application.</li>
<li>The primary conductor fits within the 45mm inner diameter.</li>
<li>The 90mm outer diameter is compatible with the available installation space.</li>
<li>The 40mm width is suitable for the installation area.</li>
<li>The connected burden is compatible with the 2.5–15 VA specification.</li>
<li>Secondary wiring and measuring equipment are compatible.</li>
<li>Appropriate electrical installation and safety procedures are followed.</li>
</ol>
<hr />
<h1>Why Choose the 200/5A 45mm Ring CT?</h1>
<p>The <strong>200/5A 45mm Ring Current Transformer</strong> combines a <strong>200A primary rating, 5A secondary output, Class 1.0 accuracy, 45mm inner diameter, 90mm outer diameter, 40mm width and 2.5–15 VA rating</strong> in an encapsulated ring-type configuration.</p>
<p>Its round design provides a practical option for compatible conductor-through-CT installations. The standard 5A secondary output makes it suitable for compatible meters and monitoring equipment designed for 5A CT inputs.</p>
<p>For electrical panels, metering systems and monitoring applications, users should verify the CT ratio, accuracy class, physical opening, dimensions, VA rating and connected equipment requirements before selection.</p>
<hr />
<h1>Product Summary</h1>
<p>The <strong>200/5A 45mm Ring Current Transformer</strong> is a <strong>Class 1.0 encapsulated round-type CT</strong> designed for compatible electrical metering, current measurement and monitoring applications.</p>
<p>It features a <strong>200A primary current, 5A secondary current, 200/5A current ratio, 45mm inner diameter, 90mm outer diameter, 40mm width and 2.5–15 VA rating</strong>.</p>
<p>Its ring-type construction allows a compatible conductor to pass through the central opening for current measurement. The CT can be considered for suitable electrical panels, energy monitoring systems, metering installations and other compatible applications where a 200/5A Class 1.0 current transformer is required.</p>
<hr />
<h1>Frequently Asked Questions</h1>
<h3>What is the current ratio of this CT?</h3>
<p>The current ratio is <strong>200/5A</strong>, with a 200A primary current and 5A secondary current.</p>
<h3>What is the secondary current?</h3>
<p>The specified secondary current is <strong>5A</strong>.</p>
<h3>What is the accuracy class?</h3>
<p>The specified accuracy class is <strong>Class 1.0</strong>.</p>
<h3>What is the inner diameter?</h3>
<p>The specified inner diameter is <strong>45mm</strong>.</p>
<h3>What is the outer diameter?</h3>
<p>The specified outer diameter is <strong>90mm</strong>.</p>
<h3>What is the CT width?</h3>
<p>The specified width is <strong>40mm</strong>.</p>
<h3>What is the VA rating?</h3>
<p>The specified VA rating is <strong>2.5–15 VA</strong>.</p>
<h3>What type of CT is this?</h3>
<p>It is an <strong>encapsulated round-type Ring Current Transformer</strong>.</p>
<h3>Where can this CT be used?</h3>
<p>It can be used in compatible energy metering, electrical current measurement, monitoring systems, distribution panels, control panels and other suitable electrical applications.</p>
<h3>Can it be connected to a digital meter?</h3>
<p>Yes, provided the digital meter is designed for a <strong>5A CT secondary input</strong> and the complete electrical specifications are compatible.</p>
<hr />
<h1>Shipping &amp; Bulk Orders</h1>
<p>MVG Power Solutions supplies Current Transformers for electrical metering, monitoring and current measurement applications.</p>
<p>For bulk requirements, customers can provide the required quantity together with the CT ratio and technical specifications for quotation.</p>
<p>Before ordering, confirm the required <strong>current ratio, accuracy class, secondary current, inner diameter, outer diameter, width and VA rating</strong>.</p>
<p><strong>Contact MVG Power Solutions for product availability, pricing and bulk quotation.</strong></p>', 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/200-5a-45mm-ring-current-transformer-specifications.jpg', 0, 'published'),
(197, 1, 60, 1, '300/5A Ring Current Transformer 35mm | Class 1.0 Metering CT', '300-5a-35mm-ring-current-transformer', '8040-MVG-R-35-1-1-1-1-1', 280.00, 280.00, 10, '85043100', 18.00, 'in_stock', '<ul data-spread="false">
<li><strong>Product Type:</strong> Encapsulated Round Type Ring Current Transformer</li>
<li><strong>Primary Current:</strong> 250A</li>
<li><strong>Secondary Current:</strong> 5A</li>
<li><strong>Current Ratio:</strong> 250/5A</li>
<li><strong>Accuracy Class:</strong> Class 1.0</li>
<li><strong>Inner Diameter (ID):</strong> 35 mm</li>
<li><strong>Outer Diameter (OD):</strong> 80 mm</li>
<li><strong>Width:</strong> 40 mm</li>
<li><strong>VA Rating:</strong> 2.5–15 VA</li>
<li><strong>Secondary Output:</strong> 5A</li>
<li><strong>Construction:</strong> Encapsulated Round / Ring Type</li>
<li><strong>Application:</strong> Metering &amp; Current Measurement</li>
<li><strong>Suitable for:</strong> Electrical panels, metering systems and current monitoring applications</li>
</ul>
<div>
<hr />
</div>
<h2></h2>', '<h2>Product Overview</h2>
<h3>300/5A 35mm Ring Current Transformer</h3>
<p>The <strong>300/5A 35mm Ring Current Transformer</strong> is a Class 1.0 encapsulated round-type current transformer designed for compatible electrical metering, current measurement and monitoring applications. It is specified with a <strong>300A primary current and 5A secondary current</strong>, providing a standard 5A output for compatible meters and electrical measuring equipment.</p>
<p>This ring-type CT features a <strong>35mm inner diameter</strong>, allowing a compatible cable or conductor to pass through the central opening. The transformer has an <strong>80mm outer diameter and 40mm width</strong>, which are important physical dimensions to consider when planning installation inside an electrical panel or suitable enclosure.</p>
<p>The <strong>300/5A current ratio</strong> is designed for electrical systems requiring measurement of a 300A primary current using compatible 5A measuring equipment. The 5A secondary output can be connected to compatible energy meters, digital meters, monitoring equipment and other instruments designed for a 5A CT input.</p>
<p>With <strong>Class 1.0 accuracy</strong>, this current transformer is suitable for compatible metering and current measurement applications where Class 1.0 accuracy is specified. Its <strong>2.5–15 VA rating</strong> should also be considered when matching the CT with the connected secondary circuit and measuring equipment.</p>
<p>The encapsulated round-type construction provides a practical ring configuration for conductor-through-CT installations. Before installation, users should verify the conductor size, CT opening, available installation space, connected burden and measuring equipment requirements.</p>
<hr />
<h2>Key Features</h2>
<p>The <strong>300/5A 35mm Ring Current Transformer</strong> offers:</p>
<ul>
<li>300/5A current ratio</li>
<li>300A primary current</li>
<li>5A secondary current</li>
<li>Class 1.0 accuracy</li>
<li>35mm inner diameter</li>
<li>80mm outer diameter</li>
<li>40mm width</li>
<li>2.5–15 VA rating</li>
<li>Encapsulated round-type construction</li>
<li>Ring-type CT configuration</li>
<li>Standard 5A secondary output</li>
<li>Suitable for metering applications</li>
<li>Suitable for current measurement</li>
<li>Suitable for electrical monitoring</li>
<li>Suitable for compatible electrical panels</li>
</ul>
<hr />
<h2>Technical Specifications</h2>
<table>
<thead>
<tr>
<th>Parameter</th>
<th>Specification</th>
</tr>
</thead>
<tbody>
<tr>
<td><strong>Product Type</strong></td>
<td>Current Transformer</td>
</tr>
<tr>
<td><strong>CT Type</strong></td>
<td>Encapsulated Round / Ring Type</td>
</tr>
<tr>
<td><strong>Primary Current</strong></td>
<td>300A</td>
</tr>
<tr>
<td><strong>Secondary Current</strong></td>
<td>5A</td>
</tr>
<tr>
<td><strong>Current Ratio</strong></td>
<td>300/5A</td>
</tr>
<tr>
<td><strong>Accuracy Class</strong></td>
<td>Class 1.0</td>
</tr>
<tr>
<td><strong>Inner Diameter (ID)</strong></td>
<td>35 mm</td>
</tr>
<tr>
<td><strong>Outer Diameter (OD)</strong></td>
<td>80 mm</td>
</tr>
<tr>
<td><strong>Width</strong></td>
<td>40 mm</td>
</tr>
<tr>
<td><strong>VA Rating</strong></td>
<td>2.5–15 VA</td>
</tr>
<tr>
<td><strong>Application</strong></td>
<td>Metering &amp; Current Measurement</td>
</tr>
</tbody>
</table>
<hr />
<h1>300/5A Ring Current Transformer for Metering</h1>
<p>The <strong>300/5A Ring Current Transformer</strong> is designed for electrical systems requiring measurement of a 300A primary current through a standard 5A secondary output.</p>
<p>This configuration can be used with compatible current meters, energy meters and monitoring equipment designed for a 5A CT input. The <strong>Class 1.0 accuracy</strong> specification makes the CT suitable for compatible metering and current measurement applications where this accuracy class is required.</p>
<p>When selecting a current transformer, the current ratio should not be considered alone. The secondary current, accuracy class, VA rating, physical dimensions, conductor size and connected measuring equipment should also be checked.</p>
<hr />
<h1>35mm Inner Diameter Ring CT</h1>
<p>The <strong>35mm inner diameter</strong> provides the central opening through which a compatible cable or conductor can pass.</p>
<p>Before installation, the actual diameter and shape of the primary conductor should be checked against the 35mm opening. Adequate installation clearance should also be maintained.</p>
<p>The <strong>80mm outer diameter</strong> and <strong>40mm width</strong> are important physical dimensions for determining whether the CT will fit within the available electrical panel or installation area.</p>
<hr />
<h1>Class 1.0 Metering Accuracy</h1>
<p>This <strong>300/5A Current Transformer is specified with Class 1.0 accuracy</strong>. It can be considered for compatible electrical metering and current measurement applications where Class 1.0 accuracy is required.</p>
<p>The complete measurement performance depends on the CT, connected burden, secondary wiring, measuring equipment and operating conditions. Therefore, the complete measurement circuit should be checked against the required specifications.</p>
<hr />
<h1>Standard 5A Secondary Output</h1>
<p>The CT provides a <strong>5A secondary output</strong>, making it suitable for compatible meters and monitoring equipment designed for a 5A current transformer input.</p>
<p>The <strong>300/5A ratio</strong> represents a 300A primary and 5A secondary configuration. The connected measuring equipment should be verified before installation to ensure compatibility with the 5A secondary.</p>
<hr />
<h1>2.5–15 VA Rating</h1>
<p>The specified <strong>VA rating is 2.5–15 VA</strong>. This rating should be considered when matching the current transformer with the connected secondary circuit.</p>
<p>The total connected burden should be compatible with the CT&#8217;s specified rating. Secondary wiring, meters and other connected components can contribute to the overall burden of the measurement circuit.</p>
<hr />
<h1>Applications</h1>
<p>The <strong>300/5A 35mm Ring Current Transformer</strong> can be used in compatible electrical applications including:</p>
<ul>
<li>Energy metering systems</li>
<li>Electrical current measurement</li>
<li>Distribution panels</li>
<li>Electrical control panels</li>
<li>Metering panels</li>
<li>Power monitoring systems</li>
<li>Industrial electrical installations</li>
<li>Current monitoring systems</li>
<li>Electrical monitoring equipment</li>
<li>Energy monitoring applications</li>
<li>Commercial electrical systems</li>
<li>Compatible digital metering systems</li>
</ul>
<p>The CT should be selected according to the required primary current, secondary current, accuracy, VA rating, physical dimensions and electrical installation requirements.</p>
<hr />
<h1>Benefits of 300/5A 35mm Ring Current Transformer</h1>
<h3>Class 1.0 Accuracy</h3>
<p>The Class 1.0 specification makes the CT suitable for compatible metering and current measurement applications requiring the specified accuracy class.</p>
<h3>Standard 5A Secondary</h3>
<p>The 5A secondary output is suitable for compatible meters and current measurement equipment designed for a 5A CT secondary.</p>
<h3>300/5A Current Ratio</h3>
<p>The 300/5A configuration is designed for electrical systems requiring measurement of a 300A primary current through compatible 5A measuring equipment.</p>
<h3>35mm Inner Diameter</h3>
<p>The 35mm opening provides a defined passage for a compatible cable or conductor through the ring-type CT.</p>
<h3>80mm Outer Diameter</h3>
<p>The 80mm outer diameter should be considered when planning installation clearance and available panel space.</p>
<h3>40mm Width</h3>
<p>The 40mm width provides an important physical dimension for determining the required installation space.</p>
<h3>2.5–15 VA Rating</h3>
<p>The 2.5–15 VA specification should be matched with the requirements of the connected secondary circuit.</p>
<h3>Encapsulated Ring Construction</h3>
<p>The encapsulated round construction provides a practical configuration for compatible conductor-through-CT installations.</p>
<hr />
<h1>Installation Considerations</h1>
<p>Before installing the <strong>300/5A 35mm Ring Current Transformer</strong>, verify:</p>
<ol>
<li>The required primary current is 300A.</li>
<li>The connected equipment requires a 5A CT secondary.</li>
<li>Class 1.0 accuracy is suitable for the application.</li>
<li>The primary conductor fits within the 35mm inner diameter.</li>
<li>The 80mm outer diameter is compatible with the available installation space.</li>
<li>The 40mm width is suitable for the installation area.</li>
<li>The connected burden is compatible with the 2.5–15 VA specification.</li>
<li>Secondary wiring and measuring equipment are compatible.</li>
<li>Appropriate electrical installation and safety procedures are followed.</li>
</ol>
<hr />
<h1>Why Choose the 300/5A 35mm Ring CT?</h1>
<p>The <strong>300/5A 35mm Ring Current Transformer</strong> combines a <strong>300A primary rating, 5A secondary output, Class 1.0 accuracy, 35mm inner diameter, 80mm outer diameter, 40mm width and 2.5–15 VA rating</strong> in an encapsulated ring-type configuration.</p>
<p>Its round design provides a practical option for compatible conductor-through-CT installations. The standard 5A secondary output makes it suitable for compatible meters and monitoring equipment designed for 5A CT inputs.</p>
<p>For electrical panels, metering systems and monitoring applications, users should verify the CT ratio, accuracy class, physical opening, dimensions, VA rating and connected equipment requirements before selection.</p>
<hr />
<h1>Product Summary</h1>
<p>The <strong>300/5A 35mm Ring Current Transformer</strong> is a <strong>Class 1.0 encapsulated round-type CT</strong> designed for compatible electrical metering, current measurement and monitoring applications.</p>
<p>It features a <strong>300A primary current, 5A secondary current, 300/5A current ratio, 35mm inner diameter, 80mm outer diameter, 40mm width and 2.5–15 VA rating</strong>.</p>
<p>Its ring-type construction allows a compatible conductor to pass through the central opening for current measurement. The CT can be considered for suitable electrical panels, energy monitoring systems, metering installations and other compatible applications where a 300/5A Class 1.0 current transformer is required.</p>
<hr />
<h1>Frequently Asked Questions</h1>
<h3>What is the current ratio of this CT?</h3>
<p>The current ratio is <strong>300/5A</strong>, with a 300A primary current and 5A secondary current.</p>
<h3>What is the secondary current?</h3>
<p>The specified secondary current is <strong>5A</strong>.</p>
<h3>What is the accuracy class?</h3>
<p>The specified accuracy class is <strong>Class 1.0</strong>.</p>
<h3>What is the inner diameter?</h3>
<p>The specified inner diameter is <strong>35mm</strong>.</p>
<h3>What is the outer diameter?</h3>
<p>The specified outer diameter is <strong>80mm</strong>.</p>
<h3>What is the CT width?</h3>
<p>The specified width is <strong>40mm</strong>.</p>
<h3>What is the VA rating?</h3>
<p>The specified VA rating is <strong>2.5–15 VA</strong>.</p>
<h3>What type of CT is this?</h3>
<p>It is an <strong>encapsulated round-type Ring Current Transformer</strong>.</p>
<h3>Where can this CT be used?</h3>
<p>It can be used in compatible energy metering, electrical current measurement, monitoring systems, distribution panels, control panels and other suitable electrical applications.</p>
<h3>Can it be connected to a digital meter?</h3>
<p>Yes, provided the digital meter is designed for a <strong>5A CT secondary input</strong> and the complete electrical specifications are compatible.</p>
<hr />
<h1>Shipping &amp; Bulk Orders</h1>
<p>MVG Power Solutions supplies Current Transformers for electrical metering, monitoring and current measurement applications.</p>
<p>For bulk requirements, customers can provide the required quantity together with the CT ratio and technical specifications for quotation.</p>
<p>Before ordering, confirm the required <strong>current ratio, accuracy class, secondary current, inner diameter, outer diameter, width and VA rating</strong>.</p>
<p><strong>Contact MVG Power Solutions for product availability, pricing and bulk quotation.</strong></p>', 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/300-5a-35mm-ring-current-transformer-specifications.jpg', 0, 'published'),
(194, 1, 60, 1, '250/5A Ring Current Transformer 35mm | Class 1.0 Metering CT', '250-5a-35mm-ring-current-transformer', '8040-MVG-R-35-1-1-1-1', 280.00, 280.00, 10, '85043100', 18.00, 'in_stock', '<ul data-spread="false">
<li><strong>Product Type:</strong> Encapsulated Round Type Ring Current Transformer</li>
<li><strong>Primary Current:</strong> 250A</li>
<li><strong>Secondary Current:</strong> 5A</li>
<li><strong>Current Ratio:</strong> 250/5A</li>
<li><strong>Accuracy Class:</strong> Class 1.0</li>
<li><strong>Inner Diameter (ID):</strong> 35 mm</li>
<li><strong>Outer Diameter (OD):</strong> 80 mm</li>
<li><strong>Width:</strong> 40 mm</li>
<li><strong>VA Rating:</strong> 2.5–15 VA</li>
<li><strong>Secondary Output:</strong> 5A</li>
<li><strong>Construction:</strong> Encapsulated Round / Ring Type</li>
<li><strong>Application:</strong> Metering &amp; Current Measurement</li>
<li><strong>Suitable for:</strong> Electrical panels, metering systems and current monitoring applications</li>
</ul>
<div>
<hr />
</div>
<h2></h2>', '<h2>Product Overview</h2>
<h3>250/5A 35mm Ring Current Transformer</h3>
<p>The <strong>250/5A 35mm Ring Current Transformer</strong> is a Class 1.0 encapsulated round-type current transformer designed for compatible electrical metering, current measurement and monitoring applications. It is specified with a <strong>250A primary current and 5A secondary current</strong>, providing a standard 5A output for compatible meters and electrical measuring equipment.</p>
<p>This ring-type CT features a <strong>35mm inner diameter</strong>, allowing a compatible cable or conductor to pass through the central opening. The transformer has an <strong>80mm outer diameter and 40mm width</strong>, which are important physical dimensions to consider when planning installation inside an electrical panel or suitable enclosure.</p>
<p>The <strong>250/5A current ratio</strong> is designed for electrical systems requiring measurement of a 250A primary current using compatible 5A measuring equipment. The 5A secondary output can be connected to compatible energy meters, digital meters, monitoring equipment and other instruments designed for a 5A CT input.</p>
<p>With <strong>Class 1.0 accuracy</strong>, this current transformer is suitable for compatible metering and current measurement applications where Class 1.0 accuracy is specified. Its <strong>2.5–15 VA rating</strong> should also be considered when matching the CT with the connected secondary circuit and measuring equipment.</p>
<p>The encapsulated round-type construction provides a practical ring configuration for conductor-through-CT installations. Before installation, users should verify the conductor size, CT opening, available installation space, connected burden and measuring equipment requirements.</p>
<hr />
<h2>Key Features</h2>
<p>The <strong>250/5A 35mm Ring Current Transformer</strong> offers:</p>
<ul>
<li>250/5A current ratio</li>
<li>250A primary current</li>
<li>5A secondary current</li>
<li>Class 1.0 accuracy</li>
<li>35mm inner diameter</li>
<li>80mm outer diameter</li>
<li>40mm width</li>
<li>2.5–15 VA rating</li>
<li>Encapsulated round-type construction</li>
<li>Ring-type CT configuration</li>
<li>Standard 5A secondary output</li>
<li>Suitable for metering applications</li>
<li>Suitable for current measurement</li>
<li>Suitable for electrical monitoring</li>
<li>Suitable for compatible electrical panels</li>
</ul>
<hr />
<h2>Technical Specifications</h2>
<table>
<thead>
<tr>
<th>Parameter</th>
<th>Specification</th>
</tr>
</thead>
<tbody>
<tr>
<td><strong>Product Type</strong></td>
<td>Current Transformer</td>
</tr>
<tr>
<td><strong>CT Type</strong></td>
<td>Encapsulated Round / Ring Type</td>
</tr>
<tr>
<td><strong>Primary Current</strong></td>
<td>250A</td>
</tr>
<tr>
<td><strong>Secondary Current</strong></td>
<td>5A</td>
</tr>
<tr>
<td><strong>Current Ratio</strong></td>
<td>250/5A</td>
</tr>
<tr>
<td><strong>Accuracy Class</strong></td>
<td>Class 1.0</td>
</tr>
<tr>
<td><strong>Inner Diameter (ID)</strong></td>
<td>35 mm</td>
</tr>
<tr>
<td><strong>Outer Diameter (OD)</strong></td>
<td>80 mm</td>
</tr>
<tr>
<td><strong>Width</strong></td>
<td>40 mm</td>
</tr>
<tr>
<td><strong>VA Rating</strong></td>
<td>2.5–15 VA</td>
</tr>
<tr>
<td><strong>Application</strong></td>
<td>Metering &amp; Current Measurement</td>
</tr>
</tbody>
</table>
<hr />
<h1>250/5A Ring Current Transformer for Metering</h1>
<p>The <strong>250/5A Ring Current Transformer</strong> is designed for electrical systems requiring measurement of a 250A primary current through a standard 5A secondary output.</p>
<p>This configuration can be used with compatible current meters, energy meters and monitoring equipment designed for a 5A CT input. The <strong>Class 1.0 accuracy</strong> specification makes the CT suitable for compatible metering and current measurement applications where this accuracy class is required.</p>
<p>When selecting a current transformer, the current ratio should not be considered alone. The secondary current, accuracy class, VA rating, physical dimensions, conductor size and connected measuring equipment should also be checked.</p>
<hr />
<h1>35mm Inner Diameter Ring CT</h1>
<p>The <strong>35mm inner diameter</strong> provides the central opening through which a compatible cable or conductor can pass.</p>
<p>Before installation, the actual diameter and shape of the primary conductor should be checked against the 35mm opening. Adequate installation clearance should also be maintained.</p>
<p>The <strong>80mm outer diameter</strong> and <strong>40mm width</strong> are important physical dimensions for determining whether the CT will fit within the available electrical panel or installation area.</p>
<hr />
<h1>Class 1.0 Metering Accuracy</h1>
<p>This <strong>250/5A Current Transformer is specified with Class 1.0 accuracy</strong>. It can be considered for compatible electrical metering and current measurement applications where Class 1.0 accuracy is required.</p>
<p>The complete measurement performance depends on the CT, connected burden, secondary wiring, measuring equipment and operating conditions. Therefore, the complete measurement circuit should be checked against the required specifications.</p>
<hr />
<h1>Standard 5A Secondary Output</h1>
<p>The CT provides a <strong>5A secondary output</strong>, making it suitable for compatible meters and monitoring equipment designed for a 5A current transformer input.</p>
<p>The <strong>250/5A ratio</strong> represents a 250A primary and 5A secondary configuration. The connected measuring equipment should be verified before installation to ensure compatibility with the 5A secondary.</p>
<hr />
<h1>2.5–15 VA Rating</h1>
<p>The specified <strong>VA rating is 2.5–15 VA</strong>. This rating should be considered when matching the current transformer with the connected secondary circuit.</p>
<p>The total connected burden should be compatible with the CT&#8217;s specified rating. Secondary wiring, meters and other connected components can contribute to the overall burden of the measurement circuit.</p>
<hr />
<h1>Applications</h1>
<p>The <strong>250/5A 35mm Ring Current Transformer</strong> can be used in compatible electrical applications including:</p>
<ul>
<li>Energy metering systems</li>
<li>Electrical current measurement</li>
<li>Distribution panels</li>
<li>Electrical control panels</li>
<li>Metering panels</li>
<li>Power monitoring systems</li>
<li>Industrial electrical installations</li>
<li>Current monitoring systems</li>
<li>Electrical monitoring equipment</li>
<li>Energy monitoring applications</li>
<li>Commercial electrical systems</li>
<li>Compatible digital metering systems</li>
</ul>
<p>The CT should be selected according to the required primary current, secondary current, accuracy, VA rating, physical dimensions and electrical installation requirements.</p>
<hr />
<h1>Benefits of 250/5A 35mm Ring Current Transformer</h1>
<h3>Class 1.0 Accuracy</h3>
<p>The Class 1.0 specification makes the CT suitable for compatible metering and current measurement applications requiring the specified accuracy class.</p>
<h3>Standard 5A Secondary</h3>
<p>The 5A secondary output is suitable for compatible meters and current measurement equipment designed for a 5A CT secondary.</p>
<h3>250/5A Current Ratio</h3>
<p>The 250/5A configuration is designed for electrical systems requiring measurement of a 250A primary current through compatible 5A measuring equipment.</p>
<h3>35mm Inner Diameter</h3>
<p>The 35mm opening provides a defined passage for a compatible cable or conductor through the ring-type CT.</p>
<h3>80mm Outer Diameter</h3>
<p>The 80mm outer diameter should be considered when planning installation clearance and available panel space.</p>
<h3>40mm Width</h3>
<p>The 40mm width provides an important physical dimension for determining the required installation space.</p>
<h3>2.5–15 VA Rating</h3>
<p>The 2.5–15 VA specification should be matched with the requirements of the connected secondary circuit.</p>
<h3>Encapsulated Ring Construction</h3>
<p>The encapsulated round construction provides a practical configuration for compatible conductor-through-CT installations.</p>
<hr />
<h1>Installation Considerations</h1>
<p>Before installing the <strong>250/5A 35mm Ring Current Transformer</strong>, verify:</p>
<ol>
<li>The required primary current is 250A.</li>
<li>The connected equipment requires a 5A CT secondary.</li>
<li>Class 1.0 accuracy is suitable for the application.</li>
<li>The primary conductor fits within the 35mm inner diameter.</li>
<li>The 80mm outer diameter is compatible with the available installation space.</li>
<li>The 40mm width is suitable for the installation area.</li>
<li>The connected burden is compatible with the 2.5–15 VA specification.</li>
<li>Secondary wiring and measuring equipment are compatible.</li>
<li>Appropriate electrical installation and safety procedures are followed.</li>
</ol>
<hr />
<h1>Why Choose the 250/5A 35mm Ring CT?</h1>
<p>The <strong>250/5A 35mm Ring Current Transformer</strong> combines a <strong>250A primary rating, 5A secondary output, Class 1.0 accuracy, 35mm inner diameter, 80mm outer diameter, 40mm width and 2.5–15 VA rating</strong> in an encapsulated ring-type configuration.</p>
<p>Its round design provides a practical option for compatible conductor-through-CT installations. The standard 5A secondary output makes it suitable for compatible meters and monitoring equipment designed for 5A CT inputs.</p>
<p>For electrical panels, metering systems and monitoring applications, users should verify the CT ratio, accuracy class, physical opening, dimensions, VA rating and connected equipment requirements before selection.</p>
<hr />
<h1>Product Summary</h1>
<p>The <strong>250/5A 35mm Ring Current Transformer</strong> is a <strong>Class 1.0 encapsulated round-type CT</strong> designed for compatible electrical metering, current measurement and monitoring applications.</p>
<p>It features a <strong>250A primary current, 5A secondary current, 250/5A current ratio, 35mm inner diameter, 80mm outer diameter, 40mm width and 2.5–15 VA rating</strong>.</p>
<p>Its ring-type construction allows a compatible conductor to pass through the central opening for current measurement. The CT can be considered for suitable electrical panels, energy monitoring systems, metering installations and other compatible applications where a 250/5A Class 1.0 current transformer is required.</p>
<hr />
<h1>Frequently Asked Questions</h1>
<h3>What is the current ratio of this CT?</h3>
<p>The current ratio is <strong>250/5A</strong>, with a 250A primary current and 5A secondary current.</p>
<h3>What is the secondary current?</h3>
<p>The specified secondary current is <strong>5A</strong>.</p>
<h3>What is the accuracy class?</h3>
<p>The specified accuracy class is <strong>Class 1.0</strong>.</p>
<h3>What is the inner diameter?</h3>
<p>The specified inner diameter is <strong>35mm</strong>.</p>
<h3>What is the outer diameter?</h3>
<p>The specified outer diameter is <strong>80mm</strong>.</p>
<h3>What is the CT width?</h3>
<p>The specified width is <strong>40mm</strong>.</p>
<h3>What is the VA rating?</h3>
<p>The specified VA rating is <strong>2.5–15 VA</strong>.</p>
<h3>What type of CT is this?</h3>
<p>It is an <strong>encapsulated round-type Ring Current Transformer</strong>.</p>
<h3>Where can this CT be used?</h3>
<p>It can be used in compatible energy metering, electrical current measurement, monitoring systems, distribution panels, control panels and other suitable electrical applications.</p>
<h3>Can it be connected to a digital meter?</h3>
<p>Yes, provided the digital meter is designed for a <strong>5A CT secondary input</strong> and the complete electrical specifications are compatible.</p>
<hr />
<h1>Shipping &amp; Bulk Orders</h1>
<p>MVG Power Solutions supplies Current Transformers for electrical metering, monitoring and current measurement applications.</p>
<p>For bulk requirements, customers can provide the required quantity together with the CT ratio and technical specifications for quotation.</p>
<p>Before ordering, confirm the required <strong>current ratio, accuracy class, secondary current, inner diameter, outer diameter, width and VA rating</strong>.</p>
<p><strong>Contact MVG Power Solutions for product availability, pricing and bulk quotation.</strong></p>', 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/250-5a-35mm-ring-current-transformer-specifications.jpg', 0, 'published'),
(190, 1, 60, 1, '200/5A Ring Current Transformer 35mm | Class 1.0 Metering CT', '200-5a-35mm-ring-current-transformer', '8040-MVG-R-35-1-1-1', 280.00, 280.00, 10, '85043100', 18.00, 'in_stock', '<ul data-spread="false">
<li><strong>Product Type:</strong> Encapsulated Round Type Ring Current Transformer</li>
<li><strong>Primary Current:</strong> 200A</li>
<li><strong>Secondary Current:</strong> 5A</li>
<li><strong>Current Ratio:</strong> 200/5A</li>
<li><strong>Accuracy Class:</strong> Class 1.0</li>
<li><strong>Inner Diameter (ID):</strong> 35 mm</li>
<li><strong>Outer Diameter (OD):</strong> 80 mm</li>
<li><strong>Width:</strong> 40 mm</li>
<li><strong>VA Rating:</strong> 2.5–15 VA</li>
<li><strong>Secondary Output:</strong> 5A</li>
<li><strong>Construction:</strong> Encapsulated Round / Ring Type</li>
<li><strong>Application:</strong> Metering &amp; Current Measurement</li>
<li><strong>Suitable for:</strong> Electrical panels, metering systems and current monitoring applications</li>
</ul>', '<p>&nbsp;</p>
<h2>Product Overview</h2>
<h3>200/5A 35mm Ring Current Transformer</h3>
<p>The <strong>200/5A 35mm Ring Current Transformer</strong> is a Class 1.0 encapsulated round-type current transformer designed for compatible electrical metering, current measurement and monitoring applications. It is specified with a <strong>200A primary current and 5A secondary current</strong>, providing a standard 5A output for compatible meters and electrical measuring equipment.</p>
<p>This ring-type CT features a <strong>35mm inner diameter</strong>, allowing a compatible cable or conductor to pass through the central opening. The CT has an <strong>80mm outer diameter and 40mm width</strong>, providing defined physical dimensions that should be considered when planning installation inside an electrical panel or other suitable enclosure.</p>
<p>The <strong>200/5A current ratio</strong> is designed for electrical systems requiring measurement of a 200A primary current using compatible 5A measuring equipment. The 5A secondary output can be connected to compatible energy meters, digital meters, monitoring equipment and other instruments designed for a 5A CT secondary.</p>
<p>With <strong>Class 1.0 accuracy</strong>, this current transformer is suitable for compatible metering and current measurement applications where Class 1.0 accuracy is specified. Its <strong>2.5–15 VA rating</strong> should also be considered when matching the CT with the connected secondary circuit and measuring equipment.</p>
<p>The encapsulated round-type construction provides a practical ring configuration for conductor-through-CT installations. Before installation, users should verify the conductor size, CT opening, available installation space, connected burden and measuring equipment requirements.</p>
<hr />
<h2>Key Features</h2>
<p>The <strong>200/5A 35mm Ring Current Transformer</strong> offers:</p>
<ul>
<li>200/5A current ratio</li>
<li>200A primary current</li>
<li>5A secondary current</li>
<li>Class 1.0 accuracy</li>
<li>35mm inner diameter</li>
<li>80mm outer diameter</li>
<li>40mm width</li>
<li>2.5–15 VA rating</li>
<li>Encapsulated round-type construction</li>
<li>Ring-type CT configuration</li>
<li>Standard 5A secondary output</li>
<li>Suitable for metering applications</li>
<li>Suitable for current measurement</li>
<li>Suitable for electrical monitoring</li>
<li>Suitable for compatible electrical panels</li>
</ul>
<hr />
<h2>Technical Specifications</h2>
<table>
<thead>
<tr>
<th>Parameter</th>
<th>Specification</th>
</tr>
</thead>
<tbody>
<tr>
<td><strong>Product Type</strong></td>
<td>Current Transformer</td>
</tr>
<tr>
<td><strong>CT Type</strong></td>
<td>Encapsulated Round / Ring Type</td>
</tr>
<tr>
<td><strong>Primary Current</strong></td>
<td>200A</td>
</tr>
<tr>
<td><strong>Secondary Current</strong></td>
<td>5A</td>
</tr>
<tr>
<td><strong>Current Ratio</strong></td>
<td>200/5A</td>
</tr>
<tr>
<td><strong>Accuracy Class</strong></td>
<td>Class 1.0</td>
</tr>
<tr>
<td><strong>Inner Diameter (ID)</strong></td>
<td>35 mm</td>
</tr>
<tr>
<td><strong>Outer Diameter (OD)</strong></td>
<td>80 mm</td>
</tr>
<tr>
<td><strong>Width</strong></td>
<td>40 mm</td>
</tr>
<tr>
<td><strong>VA Rating</strong></td>
<td>2.5–15 VA</td>
</tr>
<tr>
<td><strong>Application</strong></td>
<td>Metering &amp; Current Measurement</td>
</tr>
</tbody>
</table>
<hr />
<h1>200/5A Ring Current Transformer for Metering</h1>
<p>The <strong>200/5A Ring Current Transformer</strong> is designed for electrical systems requiring measurement of a 200A primary current through a standard 5A secondary output.</p>
<p>This configuration can be used with compatible current meters, energy meters and monitoring equipment designed for a 5A CT input. The <strong>Class 1.0 accuracy</strong> specification makes the CT suitable for compatible metering and current measurement applications where this accuracy class is required.</p>
<p>When selecting a current transformer, the current ratio should not be considered alone. The secondary current, accuracy class, VA rating, physical dimensions, conductor size and connected measuring equipment should also be checked.</p>
<hr />
<h1>35mm Inner Diameter Ring CT</h1>
<p>The <strong>35mm inner diameter</strong> provides the central opening through which a compatible cable or conductor can pass.</p>
<p>Before installation, the actual diameter and shape of the primary conductor should be checked against the 35mm opening. Adequate installation clearance should also be maintained.</p>
<p>The <strong>80mm outer diameter</strong> and <strong>40mm width</strong> are important physical dimensions for determining whether the CT will fit within the available electrical panel or installation area.</p>
<hr />
<h1>Class 1.0 Metering Accuracy</h1>
<p>This <strong>200/5A Current Transformer is specified with Class 1.0 accuracy</strong>. It can be considered for compatible electrical metering and current measurement applications where Class 1.0 accuracy is required.</p>
<p>The complete measurement performance depends on the CT, connected burden, secondary wiring, measuring equipment and operating conditions. Therefore, the complete measurement circuit should be checked against the required specifications.</p>
<hr />
<h1>Standard 5A Secondary Output</h1>
<p>The CT provides a <strong>5A secondary output</strong>, making it suitable for compatible meters and monitoring equipment designed for a 5A current transformer input.</p>
<p>The <strong>200/5A ratio</strong> represents a 200A primary and 5A secondary configuration. The connected measuring equipment should be verified before installation to ensure compatibility with the 5A secondary.</p>
<hr />
<h1>2.5–15 VA Rating</h1>
<p>The specified <strong>VA rating is 2.5–15 VA</strong>. This rating should be considered when matching the current transformer with the connected secondary circuit.</p>
<p>The total connected burden should be compatible with the CT&#8217;s specified rating. Secondary wiring, meters and other connected components can contribute to the overall burden of the measurement circuit.</p>
<hr />
<h1>Applications</h1>
<p>The <strong>200/5A 35mm Ring Current Transformer</strong> can be used in compatible electrical applications including:</p>
<ul>
<li>Energy metering systems</li>
<li>Electrical current measurement</li>
<li>Distribution panels</li>
<li>Electrical control panels</li>
<li>Metering panels</li>
<li>Power monitoring systems</li>
<li>Industrial electrical installations</li>
<li>Current monitoring systems</li>
<li>Electrical monitoring equipment</li>
<li>Energy monitoring applications</li>
<li>Commercial electrical systems</li>
<li>Compatible digital metering systems</li>
</ul>
<p>The CT should be selected according to the required primary current, secondary current, accuracy, VA rating, physical dimensions and electrical installation requirements.</p>
<hr />
<h1>Benefits of 200/5A 35mm Ring Current Transformer</h1>
<h3>Class 1.0 Accuracy</h3>
<p>The Clas</p>', 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/200-5a-35mm-ring-current-transformer-specifications-1.jpg', 0, 'published'),
(187, 1, 60, 1, '150/5A Ring Current Transformer 35mm | Class 1.0 Metering CT', '150-5a-35mm-ring-current-transformer', '8040-MVG-R-35-1-1', 280.00, 280.00, 10, '85043100', 18.00, 'in_stock', '<ul data-spread="false">
<li><strong>Product Type:</strong> Encapsulated Round Type Ring Current Transformer</li>
<li><strong>Primary Current:</strong> 150A</li>
<li><strong>Secondary Current:</strong> 5A</li>
<li><strong>Current Ratio:</strong> 150/5A</li>
<li><strong>Accuracy Class:</strong> Class 1.0</li>
<li><strong>Inner Diameter (ID):</strong> 35 mm</li>
<li><strong>Outer Diameter (OD):</strong> 80 mm</li>
<li><strong>Width:</strong> 40 mm</li>
<li><strong>VA Rating:</strong> 2.5–15 VA</li>
<li><strong>Secondary Output:</strong> 5A</li>
<li><strong>Construction:</strong> Encapsulated Round / Ring Type</li>
<li><strong>Application:</strong> Metering &amp; Current Measurement</li>
</ul>', '<h2>Product Overview</h2>
<p>The <strong>150/5A 35mm Ring Current Transformer</strong> is a Class 1.0 encapsulated round-type current transformer designed for compatible electrical metering, current measurement and monitoring applications. It is designed with a <strong>150A primary current and 5A secondary current</strong>, providing a standard secondary output for compatible meters and measuring equipment.</p>
<p>This ring-type CT features a <strong>35mm inner diameter</strong>, allowing a compatible cable, conductor or suitable primary conductor to pass through the central opening. The transformer has an <strong>80mm outer diameter and 40mm width</strong>, which are important dimensions when planning the installation space inside an electrical panel or other compatible enclosure.</p>
<p>The <strong>150/5A current ratio</strong> is designed for electrical systems requiring measurement of a 150A primary current through compatible 5A measuring equipment. The 5A secondary output can be connected to compatible digital meters, energy meters, monitoring equipment and other instruments designed for a 5A CT input.</p>
<p>With <strong>Class 1.0 accuracy</strong>, this current transformer is suitable for applications where the specified Class 1.0 accuracy is required. Its <strong>2.5–15 VA rating</strong> should be considered when matching the CT with the connected secondary circuit and measuring equipment.</p>
<p>The encapsulated round-type construction provides a practical ring configuration for conductor-through-CT installations. Before installation, users should verify the conductor dimensions, CT opening, available space, connected burden and measuring equipment requirements.</p>
<hr />
<h2>Key Features</h2>
<p>The <strong>150/5A 35mm Ring Current Transformer</strong> offers:</p>
<ul>
<li>150/5A current ratio</li>
<li>150A primary current</li>
<li>5A secondary current</li>
<li>Class 1.0 accuracy</li>
<li>35mm inner diameter</li>
<li>80mm outer diameter</li>
<li>40mm width</li>
<li>2.5–15 VA rating</li>
<li>Encapsulated round-type construction</li>
<li>Ring-type CT configuration</li>
<li>Standard 5A secondary output</li>
<li>Suitable for metering applications</li>
<li>Suitable for current measurement</li>
<li>Suitable for electrical monitoring</li>
<li>Suitable for compatible electrical panels</li>
</ul>
<hr />
<h2>Technical Specifications</h2>
<table>
<thead>
<tr>
<th>Parameter</th>
<th>Specification</th>
</tr>
</thead>
<tbody>
<tr>
<td><strong>Product Type</strong></td>
<td>Current Transformer</td>
</tr>
<tr>
<td><strong>CT Type</strong></td>
<td>Encapsulated Round / Ring Type</td>
</tr>
<tr>
<td><strong>Primary Current</strong></td>
<td>150A</td>
</tr>
<tr>
<td><strong>Secondary Current</strong></td>
<td>5A</td>
</tr>
<tr>
<td><strong>Current Ratio</strong></td>
<td>150/5A</td>
</tr>
<tr>
<td><strong>Accuracy Class</strong></td>
<td>Class 1.0</td>
</tr>
<tr>
<td><strong>Inner Diameter (ID)</strong></td>
<td>35 mm</td>
</tr>
<tr>
<td><strong>Outer Diameter (OD)</strong></td>
<td>80 mm</td>
</tr>
<tr>
<td><strong>Width</strong></td>
<td>40 mm</td>
</tr>
<tr>
<td><strong>VA Rating</strong></td>
<td>2.5–15 VA</td>
</tr>
<tr>
<td><strong>Application</strong></td>
<td>Metering &amp; Current Measurement</td>
</tr>
</tbody>
</table>
<hr />
<h1>150/5A Ring Current Transformer for Metering</h1>
<p>The <strong>150/5A Ring Current Transformer</strong> is designed for electrical systems requiring measurement of a 150A primary current through a standard 5A secondary output.</p>
<p>This configuration can be used with compatible current meters, energy meters and monitoring equipment designed for a 5A CT secondary. The <strong>Class 1.0 accuracy</strong> specification makes it suitable for compatible metering and current measurement applications where this accuracy class is specified.</p>
<p>When selecting a CT, the current ratio should not be considered alone. The secondary current, accuracy class, VA rating, physical dimensions, conductor size and connected measuring equipment should also be checked.</p>
<hr />
<h1>35mm Inner Diameter Ring CT</h1>
<p>The <strong>35mm inner diameter</strong> provides the central opening through which a compatible cable or conductor can pass.</p>
<p>Before installation, the actual diameter and shape of the primary conductor should be checked against the CT opening. Adequate clearance should also be maintained around the transformer.</p>
<p>The <strong>80mm outer diameter</strong> and <strong>40mm width</strong> are important physical dimensions for determining whether the CT will fit within the available electrical panel or installation area.</p>
<hr />
<h1>Class 1.0 Accuracy</h1>
<p>This <strong>150/5A Current Transformer is specified with Class 1.0 accuracy</strong>. It can be considered for compatible metering and electrical current measurement applications where Class 1.0 is required.</p>
<p>The complete measurement performance depends on the CT, connected burden, secondary wiring, measuring equipment and operating conditions. Therefore, the complete measurement circuit should be checked against the required specifications.</p>
<hr />
<h1>Standard 5A Secondary</h1>
<p>The CT provides a <strong>5A secondary output</strong> for compatible meters and monitoring equipment designed for a 5A current transformer input.</p>
<p>The <strong>150/5A ratio</strong> represents a 150A primary and 5A secondary configuration. The connected measuring equipment should be verified before installation to ensure compatibility with the 5A secondary.</p>
<hr />
<h1>2.5–15 VA Rating</h1>
<p>The specified <strong>VA rating is 2.5–15 VA</strong>. This rating should be considered when matching the CT with the connected secondary circuit.</p>
<p>The total burden of the measuring circuit should be compatible with the CT specification. Secondary wiring and connected measuring instruments can contribute to the overall burden.</p>
<hr />
<h1>Applications</h1>
<p>The <strong>150/5A 35mm Ring Current Transformer</strong> can be used in compatible applications including:</p>
<ul>
<li>Energy metering systems</li>
<li>Electrical current measurement</li>
<li>Distribution panels</li>
<li>Electrical control panels</li>
<li>Metering panels</li>
<li>Power monitoring systems</li>
<li>Industrial electrical installations</li>
<li>Current monitoring systems</li>
<li>Electrical monitoring equipment</li>
<li>Energy monitoring applications</li>
<li>Commercial electrical systems</li>
<li>Compatible digital metering systems</li>
</ul>
<p>The CT should be selected according to the required primary current, secondary current, accuracy, burden, physical dimensions and electrical installation requirements.</p>
<hr />
<h1>Benefits of 150/5A 35mm Ring Current Transformer</h1>
<h3>Class 1.0 Accuracy</h3>
<p>The Class 1.0 specification makes the CT suitable for compatible applications requiring the specified metering accuracy.</p>
<h3>Standard 5A Secondary</h3>
<p>The 5A secondary output is suitable for compatible meters and current measurement equipment designed for a 5A CT secondary.</p>
<h3>150/5A Current Ratio</h3>
<p>The 150/5A configuration is designed for systems requiring measurement of a 150A primary current through compatible 5A measuring equipment.</p>
<h3>35mm Inner Diameter</h3>
<p>The 35mm opening provides a defined passage for a compatible conductor through the ring-type CT.</p>
<h3>80mm Outer Diameter</h3>
<p>The 80mm outer diameter should be considered when planning installation clearance and panel space.</p>
<h3>40mm Width</h3>
<p>The 40mm width provides an important physical dimension for installation planning.</p>
<h3>2.5–15 VA Rating</h3>
<p>The 2.5–15 VA specification should be matched with the requirements of the connected secondary circuit.</p>
<h3>Encapsulated Ring Construction</h3>
<p>The encapsulated round construction provides a practical configuration for compatible conductor-through-CT installations.</p>
<hr />
<h1>Installation Considerations</h1>
<p>Before installing the <strong>150/5A 35mm Ring Current Transformer</strong>, verify:</p>
<ol>
<li>The required primary current is 150A.</li>
<li>The connected equipment requires a 5A CT secondary.</li>
<li>Class 1.0 accuracy is suitable for the application.</li>
<li>The conductor fits within the 35mm inner diameter.</li>
<li>The 80mm outer diameter is compatible with the available space.</li>
<li>The 40mm width is suitable for the installation area.</li>
<li>The connected burden is compatible with the 2.5–15 VA specification.</li>
<li>Secondary wiring and measuring equipment are compatible.</li>
<li>Appropriate electrical safety procedures are followed.</li>
</ol>
<hr />
<h1>Why Choose the 150/5A 35mm Ring CT?</h1>
<p>The <strong>150/5A 35mm Ring Current Transformer</strong> combines a <strong>150A primary rating, 5A secondary output, Class 1.0 accuracy, 35mm inner diameter, 80mm outer diameter, 40mm width and 2.5–15 VA rating</strong> in an encapsulated ring-type configuration.</p>
<p>Its round design provides a practical option for compatible conductor-through-CT installations. The 5A secondary output makes it suitable for compatible meters and monitoring equipment designed for 5A CT inputs.</p>
<p>For electrical panels, metering systems and monitoring applications, users should verify the CT ratio, accuracy class, physical opening, dimensions, VA rating and connected equipment requirements before selection.</p>
<hr />
<h1>Product Summary</h1>
<p>The <strong>150/5A 35mm Ring Current Transformer</strong> is a <strong>Class 1.0 encapsulated round-type CT</strong> designed for compatible electrical metering, current measurement and monitoring applications.</p>
<p>It features a <strong>150A primary current, 5A secondary current, 150/5A current ratio, 35mm inner diameter, 80mm outer diameter, 40mm width and 2.5–15 VA rating</strong>.</p>
<p>Its ring-type construction allows a compatible conductor to pass through the central opening for current measurement. The CT can be considered for suitable electrical panels, energy monitoring systems, metering installations and other compatible applications.</p>
<hr />
<h1>Frequently Asked Questions</h1>
<h3>What is the current ratio of this CT?</h3>
<p>The current ratio is <strong>150/5A</strong>, with a 150A primary current and 5A secondary current.</p>
<h3>What is the secondary current?</h3>
<p>The specified secondary current is <strong>5A</strong>.</p>
<h3>What is the accuracy class?</h3>
<p>The specified accuracy class is <strong>Class 1.0</strong>.</p>
<h3>What is the inner diameter?</h3>
<p>The specified inner diameter is <strong>35mm</strong>.</p>
<h3>What is the outer diameter?</h3>
<p>The specified outer diameter is <strong>80mm</strong>.</p>
<h3>What is the CT width?</h3>
<p>The specified width is <strong>40mm</strong>.</p>
<h3>What is the VA rating?</h3>
<p>The specified VA rating is <strong>2.5–15 VA</strong>.</p>
<h3>What type of CT is this?</h3>
<p>It is an <strong>encapsulated round-type Ring Current Transformer</strong>.</p>
<h3>Where can this CT be used?</h3>
<p>It can be used in compatible energy metering, electrical current measurement, monitoring systems, distribution panels, control panels and other suitable electrical applications.</p>
<h3>Can it be connected to a digital meter?</h3>
<p>Yes, provided the digital meter is designed for a <strong>5A CT secondary input</strong> and the complete electrical specifications are compatible.</p>
<hr />
<h1>Shipping &amp; Bulk Orders</h1>
<p>MVG Power Solutions supplies Current Transformers for electrical metering, monitoring and current measurement applications.</p>
<p>For bulk requirements, customers can provide the required quantity together with the CT ratio and technical specifications for quotation.</p>
<p>Before ordering, confirm the required <strong>current ratio, accuracy class, secondary current, inner diameter, outer diameter, width and VA rating</strong>.</p>
<p><strong>Contact MVG Power Solutions for product availability, pricing and bulk quotation.</strong></p>', 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/150-5a-35mm-ring-current-transformer-specifications.jpg', 0, 'published'),
(182, 1, 60, 1, '100/5A Ring Current Transformer 35mm | Class 1.0 Metering CT', '100-5a-35mm-ring-current-transformer', '8040-MVG-R-35-1', 280.00, 280.00, 10, '85043100', 18.00, 'in_stock', '<ul data-start="293" data-end="801">
<li data-section-id="nectbt" data-start="293" data-end="342"><strong data-start="295" data-end="312">Product Type:</strong> Ring Type Current Transformer</li>
<li data-section-id="4fvslj" data-start="343" data-end="370"><strong data-start="345" data-end="365">Primary Current:</strong> 100A</li>
<li data-section-id="j18ppx" data-start="371" data-end="398"><strong data-start="373" data-end="395">Secondary Current:</strong> 5A</li>
<li data-section-id="189rw5s" data-start="399" data-end="426"><strong data-start="401" data-end="419">Current Ratio:</strong> 100/5A</li>
<li data-section-id="p7ye00" data-start="427" data-end="458"><strong data-start="429" data-end="448">Accuracy Class:</strong> Class 1.0</li>
<li data-section-id="10plgx9" data-start="459" data-end="486"><strong data-start="461" data-end="480">Inner Diameter:</strong> 35 mm</li>
<li data-section-id="18ttxfh" data-start="487" data-end="532"><strong data-start="489" data-end="501">CT Type:</strong> Encapsulated Round / Ring Type</li>
<li data-section-id="zakqar" data-start="533" data-end="559"><strong data-start="535" data-end="556">Secondary Output:</strong> 5A</li>
<li data-section-id="xhk2u" data-start="560" data-end="609"><strong data-start="562" data-end="578">Application:</strong> Metering &amp; Current Measurement</li>
<li data-section-id="fr5qed" data-start="610" data-end="701"><strong data-start="612" data-end="629">Suitable for:</strong> Electrical panels, metering systems and current monitoring applications</li>
<li data-section-id="idksew" data-start="702" data-end="744"><strong data-start="704" data-end="721">Construction:</strong> Round ring-type design</li>
<li data-section-id="1jv7yvv" data-start="745" data-end="801"><strong data-start="747" data-end="755">Use:</strong> Electrical current measurement and monitoring</li>
</ul>', '<h2 class="PDq2pG_selectionAnchorContainer" dir="auto" data-section-id="1p927wt" data-start="808" data-end="827">Product Overview</h2>
<h3 dir="auto" data-section-id="h79y8a" data-start="829" data-end="869">100/5A 35mm Ring Current Transformer</h3>
<p dir="auto" data-start="871" data-end="1203">The <strong data-start="875" data-end="915">100/5A 35mm Ring Current Transformer</strong> is a Class 1.0 metering current transformer designed for electrical current measurement, monitoring and compatible metering applications. It is designed to measure a primary current of <strong data-start="1101" data-end="1109">100A</strong> and provide a standard <strong data-start="1133" data-end="1156">5A secondary output</strong> for compatible meters and measuring equipment.</p>
<p dir="auto" data-start="1205" data-end="1525">The ring-type construction allows the current-carrying conductor to pass through the central opening of the current transformer. With a specified <strong data-start="1351" data-end="1375">35 mm inner diameter</strong>, this CT can be considered for electrical installations where the conductor size and available installation space are compatible with the CT opening.</p>
<p dir="auto" data-start="1527" data-end="1804">The <strong data-start="1531" data-end="1555">100/5A current ratio</strong> means that the CT is designed around a 100A primary and 5A secondary configuration. The 5A secondary output is commonly used with compatible current meters, energy meters, monitoring equipment and other measuring devices designed for a 5A CT input.</p>
<p dir="auto" data-start="1806" data-end="2122">With <strong data-start="1811" data-end="1833">Class 1.0 accuracy</strong>, this current transformer is suitable for applications where a Class 1.0 CT is specified for metering or current measurement. The complete CT installation should be selected according to the required current ratio, accuracy class, burden, conductor size and connected measuring equipment.</p>
<hr data-start="2124" data-end="2127" />
<h2 dir="auto" data-section-id="1ma7m6t" data-start="2129" data-end="2144">Key Features</h2>
<p dir="auto" data-start="2146" data-end="2221">The <strong data-start="2150" data-end="2190">100/5A 35mm Ring Current Transformer</strong> offers the following features:</p>
<ul data-start="2223" data-end="2617">
<li data-section-id="1325e0t" data-start="2223" data-end="2245">100A primary current</li>
<li data-section-id="1duzpvz" data-start="2246" data-end="2268">5A secondary current</li>
<li data-section-id="1pxhtm2" data-start="2269" data-end="2291">100/5A current ratio</li>
<li data-section-id="b0p3jo" data-start="2292" data-end="2312">Class 1.0 accuracy</li>
<li data-section-id="igf1rr" data-start="2313" data-end="2335">35 mm inner diameter</li>
<li data-section-id="wvr7wg" data-start="2336" data-end="2380">Ring-type current transformer construction</li>
<li data-section-id="jfp3ag" data-start="2381" data-end="2420">Encapsulated round-type configuration</li>
<li data-section-id="1khqji1" data-start="2421" data-end="2463">Suitable for compatible metering systems</li>
<li data-section-id="mkevep" data-start="2464" data-end="2498">Suitable for current measurement</li>
<li data-section-id="1tujisg" data-start="2499" data-end="2535">Suitable for electrical monitoring</li>
<li data-section-id="7vf7gp" data-start="2536" data-end="2568">Suitable for electrical panels</li>
<li data-section-id="13pn06d" data-start="2569" data-end="2617">Designed for compatible 5A measuring equipment</li>
</ul>
<hr data-start="2619" data-end="2622" />
<h2 dir="auto" data-section-id="1cgu054" data-start="2624" data-end="2651">Technical Specifications</h2>
<div class="group TyagGW_tableContainer" dir="auto">
<div class="TyagGW_tableWrapper flex flex-col-reverse w-fit" tabindex="-1">
<table class="w-fit min-w-(--thread-content-width)" dir="auto" data-start="2653" data-end="3077">
<thead data-start="2653" data-end="2682">
<tr data-start="2653" data-end="2682">
<th class="last:pe-10" data-start="2653" data-end="2665" data-col-size="sm">Parameter</th>
<th class="last:pe-10" data-start="2665" data-end="2682" data-col-size="sm">Specification</th>
</tr>
</thead>
<tbody data-start="2693" data-end="3077">
<tr data-start="2693" data-end="2735">
<td data-start="2693" data-end="2712" data-col-size="sm"><strong data-start="2695" data-end="2711">Product Type</strong></td>
<td data-start="2712" data-end="2735" data-col-size="sm">Current Transformer</td>
</tr>
<tr data-start="2736" data-end="2789">
<td data-start="2736" data-end="2750" data-col-size="sm"><strong data-start="2738" data-end="2749">CT Type</strong></td>
<td data-start="2750" data-end="2789" data-col-size="sm">Ring Type / Encapsulated Round Type</td>
</tr>
<tr data-start="2790" data-end="2820">
<td data-start="2790" data-end="2812" data-col-size="sm"><strong data-start="2792" data-end="2811">Primary Current</strong></td>
<td data-start="2812" data-end="2820" data-col-size="sm">100A</td>
</tr>
<tr data-start="2821" data-end="2851">
<td data-start="2821" data-end="2845" data-col-size="sm"><strong data-start="2823" data-end="2844">Secondary Current</strong></td>
<td data-start="2845" data-end="2851" data-col-size="sm">5A</td>
</tr>
<tr data-start="2852" data-end="2882">
<td data-start="2852" data-end="2872" data-col-size="sm"><strong data-start="2854" data-end="2871">Current Ratio</strong></td>
<td data-col-size="sm" data-start="2872" data-end="2882">100/5A</td>
</tr>
<tr data-start="2883" data-end="2917">
<td data-start="2883" data-end="2904" data-col-size="sm"><strong data-start="2885" data-end="2903">Accuracy Class</strong></td>
<td data-col-size="sm" data-start="2904" data-end="2917">Class 1.0</td>
</tr>
<tr data-start="2918" data-end="2948">
<td data-start="2918" data-end="2939" data-col-size="sm"><strong data-start="2920" data-end="2938">Inner Diameter</strong></td>
<td data-start="2939" data-end="2948" data-col-size="sm">35 mm</td>
</tr>
<tr data-start="2949" data-end="2978">
<td data-start="2949" data-end="2972" data-col-size="sm"><strong data-start="2951" data-end="2971">Secondary Output</strong></td>
<td data-start="2972" data-end="2978" data-col-size="sm">5A</td>
</tr>
<tr data-start="2979" data-end="3031">
<td data-start="2979" data-end="2997" data-col-size="sm"><strong data-start="2981" data-end="2996">Application</strong></td>
<td data-start="2997" data-end="3031" data-col-size="sm">Metering &amp; Current Measurement</td>
</tr>
<tr data-start="3032" data-end="3077">
<td data-start="3032" data-end="3051" data-col-size="sm"><strong data-start="3034" data-end="3050">Construction</strong></td>
<td data-start="3051" data-end="3077" data-col-size="sm">Encapsulated Ring Type</td>
</tr>
</tbody>
</table>
</div>
</div>
<hr data-start="3079" data-end="3082" />
<h1 dir="auto" data-section-id="14yr5oc" data-start="3084" data-end="3130">100/5A Ring Current Transformer for Metering</h1>
<p dir="auto" data-start="3132" data-end="3411">The <strong data-start="3136" data-end="3171">100/5A Ring Current Transformer</strong> is designed for electrical systems that require current measurement through a standard 5A secondary output. Its 100A primary rating makes it suitable for compatible electrical systems where the required current transformer ratio is 100/5A.</p>
<p dir="auto" data-start="3413" data-end="3667">The CT&#8217;s <strong data-start="3422" data-end="3444">Class 1.0 accuracy</strong> makes it suitable for compatible metering and measurement applications where this accuracy class is specified. The secondary winding provides a 5A output that can be connected to compatible meters and monitoring equipment.</p>
<p dir="auto" data-start="3669" data-end="3941">When installing the CT, the conductor should be checked against the <strong data-start="3737" data-end="3760">35mm inner diameter</strong> to ensure suitable physical compatibility. The CT should also be selected according to the electrical characteristics of the installation, connected burden and measuring equipment.</p>
<hr data-start="3943" data-end="3946" />
<h1 dir="auto" data-section-id="17379r0" data-start="3948" data-end="3977">35mm Inner Diameter Ring CT</h1>
<p dir="auto" data-start="3979" data-end="4115">The <strong data-start="3983" data-end="4006">35mm inner diameter</strong> provides a defined central opening through which a suitable cable, conductor or busbar arrangement can pass.</p>
<p dir="auto" data-start="4117" data-end="4391">Before purchasing or installing the CT, the actual diameter and shape of the conductor should be checked. Adequate installation clearance should also be considered so that the CT can be installed without placing unnecessary mechanical stress on the transformer or conductor.</p>
<p dir="auto" data-start="4393" data-end="4574">The 35mm opening makes this configuration suitable for electrical installations where a compact ring-type CT is required while providing sufficient space for a compatible conductor.</p>
<hr data-start="4576" data-end="4579" />
<h1 dir="auto" data-section-id="1p3w301" data-start="4581" data-end="4610">Class 1.0 Metering Accuracy</h1>
<p dir="auto" data-start="4612" data-end="4820">This <strong data-start="4617" data-end="4689">100/5A Ring Current Transformer is specified with Class 1.0 accuracy</strong>. It can therefore be used in compatible electrical metering and current measurement applications where a Class 1.0 CT is required.</p>
<p dir="auto" data-start="4822" data-end="5089">The accuracy of a complete current measurement system depends on factors including the CT specification, connected burden, secondary wiring, measuring instrument and operating conditions. Therefore, the complete metering circuit should be checked before installation.</p>
<hr data-start="5091" data-end="5094" />
<h1 dir="auto" data-section-id="7g2y8c" data-start="5096" data-end="5126">Standard 5A Secondary Output</h1>
<p dir="auto" data-start="5128" data-end="5206">The CT provides a <strong data-start="5146" data-end="5170">5A secondary current</strong> for compatible measuring equipment.</p>
<p dir="auto" data-start="5208" data-end="5481">A 5A CT secondary is commonly used with meters and monitoring equipment specifically designed for 5A current transformer inputs. The connected equipment should always be verified before installation to ensure that its CT input rating matches the 5A secondary specification.</p>
<p dir="auto" data-start="5483" data-end="5612">The <strong data-start="5487" data-end="5503">100/5A ratio</strong> provides the required transformation from the specified primary current to the standard 5A secondary output.</p>
<hr data-start="5614" data-end="5617" />
<h1 dir="auto" data-section-id="c3mln3" data-start="5619" data-end="5633">Applications</h1>
<p dir="auto" data-start="5635" data-end="5738">The <strong data-start="5639" data-end="5679">100/5A 35mm Ring Current Transformer</strong> can be used in compatible electrical applications such as:</p>
<ul data-start="5740" data-end="6108">
<li data-section-id="114lgxj" data-start="5740" data-end="5765">Energy metering systems</li>
<li data-section-id="cqkrd1" data-start="5766" data-end="5798">Electrical current measurement</li>
<li data-section-id="zu8o49" data-start="5799" data-end="5831">Electrical distribution panels</li>
<li data-section-id="18ta6xy" data-start="5832" data-end="5849">Metering panels</li>
<li data-section-id="gkbkck" data-start="5850" data-end="5877">Electrical control panels</li>
<li data-section-id="1oprzil" data-start="5878" data-end="5904">Power monitoring systems</li>
<li data-section-id="1y0axpq" data-start="5905" data-end="5942">Industrial electrical installations</li>
<li data-section-id="1wg4fy3" data-start="5943" data-end="5971">Current monitoring systems</li>
<li data-section-id="1yjg2n4" data-start="5972" data-end="6005">Electrical monitoring equipment</li>
<li data-section-id="tciken" data-start="6006" data-end="6038">Energy monitoring applications</li>
<li data-section-id="7xuclo" data-start="6039" data-end="6070">Commercial electrical systems</li>
<li data-section-id="10jb221" data-start="6071" data-end="6108">Compatible digital metering systems</li>
</ul>
<p dir="auto" data-start="6110" data-end="6272">The CT should be selected according to the required primary current, secondary current, accuracy class, physical dimensions, burden and installation requirements.</p>
<hr data-start="6274" data-end="6277" />
<h1 dir="auto" data-section-id="1162bt3" data-start="6279" data-end="6329">Benefits of 100/5A 35mm Ring Current Transformer</h1>
<h3 dir="auto" data-section-id="1ieyb7e" data-start="6331" data-end="6353">Class 1.0 Accuracy</h3>
<p dir="auto" data-start="6355" data-end="6504">The Class 1.0 specification makes the CT suitable for compatible metering and current measurement applications where this accuracy class is required.</p>
<h3 dir="auto" data-section-id="1jvifus" data-start="6506" data-end="6530">100/5A Current Ratio</h3>
<p dir="auto" data-start="6532" data-end="6694">The 100/5A ratio provides a suitable configuration for electrical systems requiring measurement of a 100A primary current using compatible 5A measuring equipment.</p>
<h3 dir="auto" data-section-id="14qo9sj" data-start="6696" data-end="6721">Standard 5A Secondary</h3>
<p dir="auto" data-start="6723" data-end="6840">The 5A secondary output allows connection with compatible meters and monitoring equipment designed for a 5A CT input.</p>
<h3 dir="auto" data-section-id="1gki321" data-start="6842" data-end="6865">35mm Inner Diameter</h3>
<p dir="auto" data-start="6867" data-end="6969">The 35mm opening provides a defined space for a compatible conductor to pass through the ring-type CT.</p>
<h3 dir="auto" data-section-id="vtwoe4" data-start="6971" data-end="6997">Ring-Type Construction</h3>
<p dir="auto" data-start="6999" data-end="7095">The round ring design provides a practical configuration for conductor-through-CT installations.</p>
<h3 dir="auto" data-section-id="1xjq95w" data-start="7097" data-end="7122">Metering Applications</h3>
<p dir="auto" data-start="7124" data-end="7227">The CT is designed for compatible current measurement, electrical metering and monitoring applications.</p>
<hr data-start="7229" data-end="7232" />
<h1 dir="auto" data-section-id="1wxy7gf" data-start="7234" data-end="7263">Installation Considerations</h1>
<p dir="auto" data-start="7265" data-end="7350">Before installing the <strong data-start="7287" data-end="7327">100/5A 35mm Ring Current Transformer</strong>, verify the following:</p>
<ol data-start="7352" data-end="7831">
<li data-section-id="iio3n4" data-start="7352" data-end="7405">Confirm that the required primary current is 100A.</li>
<li data-section-id="1124zic" data-start="7406" data-end="7473">Confirm that the measuring equipment requires a 5A CT secondary.</li>
<li data-section-id="1e40zxp" data-start="7474" data-end="7516">Verify the required Class 1.0 accuracy.</li>
<li data-section-id="ypb2jz" data-start="7517" data-end="7577">Check that the conductor fits within the 35mm CT opening.</li>
<li data-section-id="1dup3m3" data-start="7578" data-end="7643">Confirm the required burden for the complete metering circuit.</li>
<li data-section-id="63wt6h" data-start="7644" data-end="7696">Check available installation space around the CT.</li>
<li data-section-id="18r58rn" data-start="7697" data-end="7762">Verify secondary wiring and connected equipment compatibility.</li>
<li data-section-id="9p5t68" data-start="7763" data-end="7831">Follow appropriate electrical installation and safety procedures.</li>
</ol>
<p dir="auto" data-start="7833" data-end="7976">The current transformer should be selected according to the requirements of the complete electrical system rather than the current ratio alone.</p>
<hr data-start="7978" data-end="7981" />
<h1 dir="auto" data-section-id="1k592nm" data-start="7983" data-end="8020">Why Choose the 100/5A 35mm Ring CT?</h1>
<p dir="auto" data-start="8022" data-end="8194">The <strong data-start="8026" data-end="8066">100/5A 35mm Ring Current Transformer</strong> combines a 100A primary rating, 5A secondary output, Class 1.0 accuracy and a 35mm inner diameter in a ring-type configuration.</p>
<p dir="auto" data-start="8196" data-end="8422">Its round construction provides a practical solution for compatible conductor-through-CT installations. The 5A secondary output makes it suitable for compatible meters and monitoring systems designed for standard 5A CT inputs.</p>
<p dir="auto" data-start="8424" data-end="8644">For electrical panels, metering systems and current monitoring applications, selecting the correct CT requires consideration of the current ratio, accuracy class, conductor dimensions, burden and installation conditions.</p>
<hr data-start="8646" data-end="8649" />
<h1 dir="auto" data-section-id="1g1xjj5" data-start="8651" data-end="8668">Product Summary</h1>
<p dir="auto" data-start="8670" data-end="8853">The <strong data-start="8674" data-end="8714">100/5A 35mm Ring Current Transformer</strong> is a <strong data-start="8720" data-end="8759">Class 1.0 encapsulated ring-type CT</strong> designed for compatible electrical metering, current measurement and monitoring applications.</p>
<p dir="auto" data-start="8855" data-end="9076">It features a <strong data-start="8869" data-end="8961">100A primary current, 5A secondary current, 100/5A current ratio and 35mm inner diameter</strong>. The ring-type configuration allows a compatible conductor to pass through the CT opening for current measurement.</p>
<p dir="auto" data-start="9078" data-end="9263">For proper selection, customers should verify the required primary current, secondary current, accuracy class, CT opening, burden and physical installation requirements before ordering.</p>
<hr data-start="9265" data-end="9268" />
<h1 dir="auto" data-section-id="hkd5a4" data-start="9270" data-end="9298">Frequently Asked Questions</h1>
<h3 dir="auto" data-section-id="1voi480" data-start="9300" data-end="9341">What is the current ratio of this CT?</h3>
<p dir="auto" data-start="9343" data-end="9429">The current ratio is <strong data-start="9364" data-end="9374">100/5A</strong>, with a 100A primary current and 5A secondary current.</p>
<h3 dir="auto" data-section-id="1hlyhcz" data-start="9431" data-end="9465">What is the secondary current?</h3>
<p dir="auto" data-start="9467" data-end="9499">The secondary current is <strong data-start="9492" data-end="9498">5A</strong>.</p>
<h3 dir="auto" data-section-id="fsj8lf" data-start="9501" data-end="9532">What is the accuracy class?</h3>
<p dir="auto" data-start="9534" data-end="9580">The specified accuracy class is <strong data-start="9566" data-end="9579">Class 1.0</strong>.</p>
<h3 dir="auto" data-section-id="ivpoi9" data-start="9582" data-end="9624">What is the inner diameter of this CT?</h3>
<p dir="auto" data-start="9626" data-end="9667">The specified inner diameter is <strong data-start="9658" data-end="9666">35mm</strong>.</p>
<h3 dir="auto" data-section-id="11c1v4c" data-start="9669" data-end="9714">What type of Current Transformer is this?</h3>
<p dir="auto" data-start="9716" data-end="9784">It is a <strong data-start="9724" data-end="9783">ring-type / encapsulated round-type Current Transformer</strong>.</p>
<h3 dir="auto" data-section-id="1pyc7ti" data-start="9786" data-end="9825">Where can a 100/5A Ring CT be used?</h3>
<p dir="auto" data-start="9827" data-end="10020">It can be used in compatible energy metering, electrical current measurement, monitoring systems, electrical panels, distribution systems and other suitable electrical measurement applications.</p>
<h3 dir="auto" data-section-id="11xcg9i" data-start="10022" data-end="10067">Can this CT be used with a digital meter?</h3>
<p dir="auto" data-start="10069" data-end="10201">Yes, it can be used with a compatible digital meter designed for a <strong data-start="10136" data-end="10161">5A CT secondary input</strong>, subject to the meter&#8217;s specifications.</p>
<h3 dir="auto" data-section-id="uzx60y" data-start="10203" data-end="10243">What should I check before ordering?</h3>
<p dir="auto" data-start="10245" data-end="10406">Confirm the <strong data-start="10257" data-end="10389">100/5A ratio, Class 1.0 accuracy, 35mm inner diameter, secondary rating and the requirements of the connected metering equipment</strong> before ordering.</p>
<hr data-start="10408" data-end="10411" />
<h1 dir="auto" data-section-id="jw2phb" data-start="10413" data-end="10437">Shipping &amp; Bulk Orders</h1>
<p dir="auto" data-start="10439" data-end="10679">MVG Power Solutions supplies Current Transformers for electrical metering, monitoring and current measurement applications. For bulk requirements, customers can contact the sales team with the required quantity and technical specifications.</p>
<p dir="auto" data-start="10681" data-end="10848">For bulk orders, provide the required <strong data-start="10719" data-end="10798">CT ratio, accuracy class, secondary current, inner diameter and application</strong> so that the appropriate product can be confirmed.</p>
<p dir="auto" data-start="10850" data-end="10935"><strong data-start="10850" data-end="10935">Contact MVG Power Solutions for product availability, pricing and bulk quotation.</strong></p>', 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/100-5a-35mm-ring-current-transformer-specifications-1.jpg', 0, 'published'),
(178, 1, 60, 1, '50/5A Ring Current Transformer 35mm | Class 1.0 Metering CT', '50-5a-35mm-ring-current-transformer', '8040-MVG-R-35', 280.00, 280.00, 10, '85043100', 18.00, 'in_stock', '<ul data-spread="false">
<li><strong>Product Type:</strong> Encapsulated Round Type Ring Current Transformer</li>
<li><strong>Model No.:</strong> 8040-MVG-R-35</li>
<li><strong>Primary Current:</strong> 50A</li>
<li><strong>Secondary Current:</strong> 5A</li>
<li><strong>Current Ratio:</strong> 50/5A</li>
<li><strong>Accuracy Class:</strong> Class 1.0</li>
<li><strong>Inner Diameter (ID):</strong> 35mm</li>
<li><strong>Outer Diameter (OD):</strong> 80mm</li>
<li><strong>Width:</strong> 40mm</li>
<li><strong>VA Rating:</strong> 2.5–15 VA</li>
<li><strong>Construction:</strong> Encapsulated Round Type</li>
<li><strong>Secondary Output:</strong> 5A</li>
<li><strong>Application:</strong> Metering &amp; Current Measurement</li>
<li>Suitable for compatible <strong>electrical panels and monitoring systems</strong></li>
<li>Suitable for <strong>current measurement and metering applications</strong></li>
</ul>
<div>
<hr />
</div>
<h1></h1>', '<h1>Product Overview</h1>
<p>The <strong>50/5A 35mm Ring Current Transformer | Class 1.0 Metering CT</strong> is an encapsulated round-type Current Transformer designed for compatible electrical current measurement, metering, and monitoring applications. The CT features a <strong>50A primary current, 5A secondary current, Class 1.0 accuracy, 35mm inner diameter, 80mm outer diameter, 40mm width, and 2.5–15 VA rating</strong>.</p>
<p>This Current Transformer is designed to provide a proportional secondary current to compatible electrical measuring and monitoring equipment. With a <strong>50/5A current ratio</strong>, the CT is configured for a 50A primary current and 5A secondary current.</p>
<p>The <strong>35mm inner diameter</strong> provides the opening through which a compatible conductor or cable can pass. Before installation, the actual conductor dimensions should be checked against the available inner diameter to ensure proper physical compatibility.</p>
<p>The CT has an <strong>80mm outer diameter</strong> and <strong>40mm width</strong>, providing a defined physical form factor for installation planning. Its encapsulated round-type construction makes it suitable for compatible electrical panels, metering systems, monitoring equipment, and current measurement applications.</p>
<p>The specified <strong>2.5–15 VA rating</strong> should be considered along with the connected meter, secondary wiring, and other devices connected to the CT secondary circuit. The complete secondary burden should be compatible with the selected CT configuration.</p>
<p>With <strong>Class 1.0 accuracy</strong> and a standard <strong>5A secondary</strong>, this ring-type Current Transformer can be considered for compatible metering and current measurement applications where these specifications meet the electrical system requirements.</p>
<hr />
<h1>Key Features</h1>
<p>The <strong>50/5A 35mm Ring Current Transformer</strong> offers the following features:</p>
<ul>
<li><strong>50/5A current ratio</strong></li>
<li><strong>50A primary current</strong></li>
<li><strong>5A secondary current</strong></li>
<li><strong>Class 1.0 accuracy</strong></li>
<li><strong>35mm inner diameter</strong></li>
<li><strong>80mm outer diameter</strong></li>
<li><strong>40mm width</strong></li>
<li><strong>2.5–15 VA rating</strong></li>
<li>Encapsulated round-type construction</li>
<li>Model <strong>8040-MVG-R-35</strong></li>
<li>Suitable for compatible metering applications</li>
<li>Suitable for current measurement</li>
<li>Suitable for electrical monitoring</li>
<li>Suitable for compatible electrical panels</li>
<li>Suitable for distribution and measurement systems</li>
</ul>
<hr />
<h1>Technical Specifications</h1>
<table>
<thead>
<tr>
<th>Parameter</th>
<th>Specification</th>
</tr>
</thead>
<tbody>
<tr>
<td><strong>Product Type</strong></td>
<td>Ring Current Transformer</td>
</tr>
<tr>
<td><strong>CT Type</strong></td>
<td>Encapsulated Round Type</td>
</tr>
<tr>
<td><strong>Model No.</strong></td>
<td>8040-MVG-R-35</td>
</tr>
<tr>
<td><strong>Primary Current</strong></td>
<td>50A</td>
</tr>
<tr>
<td><strong>Secondary Current</strong></td>
<td>5A</td>
</tr>
<tr>
<td><strong>Current Ratio</strong></td>
<td>50/5A</td>
</tr>
<tr>
<td><strong>Accuracy Class</strong></td>
<td>Class 1.0</td>
</tr>
<tr>
<td><strong>Inner Diameter (ID)</strong></td>
<td>35mm</td>
</tr>
<tr>
<td><strong>Outer Diameter (OD)</strong></td>
<td>80mm</td>
</tr>
<tr>
<td><strong>Width</strong></td>
<td>40mm</td>
</tr>
<tr>
<td><strong>VA Rating</strong></td>
<td>2.5–15 VA</td>
</tr>
<tr>
<td><strong>Application</strong></td>
<td>Metering &amp; Current Measurement</td>
</tr>
</tbody>
</table>
<hr />
<h1>50/5A Ring Current Transformer for Metering</h1>
<p>The <strong>50/5A Ring Current Transformer</strong> is designed for compatible electrical systems requiring current measurement through a 5A secondary circuit.</p>
<p>The specified <strong>50/5A ratio</strong> provides a defined relationship between the primary and secondary currents. The primary rating is <strong>50A</strong>, while the secondary output is <strong>5A</strong>.</p>
<p>The 5A secondary can be connected to compatible energy meters, current meters, monitoring instruments, and other measurement equipment designed for a 5A CT input.</p>
<p>When selecting a Current Transformer, it is important to check the required current ratio against the electrical system and the requirements of the connected measuring equipment.</p>
<p>The CT ratio should also be correctly accounted for when configuring compatible meters or monitoring systems.</p>
<hr />
<h1>35mm Inner Diameter Ring CT</h1>
<p>The most important physical specification of this ring-type CT is its <strong>35mm inner diameter</strong>.</p>
<p>The inner opening is designed for the passage of a compatible conductor or cable. Before installation, the diameter or dimensions of the conductor should be checked against the <strong>35mm ID</strong>.</p>
<p>The physical dimensions to consider include:</p>
<ul>
<li><strong>Inner Diameter:</strong> 35mm</li>
<li><strong>Outer Diameter:</strong> 80mm</li>
<li><strong>Width:</strong> 40mm</li>
</ul>
<p>Adequate clearance should also be considered when installing the CT around a conductor.</p>
<p>The 35mm opening makes physical compatibility an important consideration during product selection.</p>
<hr />
<h1>Class 1.0 Accuracy</h1>
<p>The <strong>50/5A Ring Current Transformer is specified as Class 1.0</strong>.</p>
<p>Accuracy class is an important specification when selecting a Current Transformer for metering and current measurement applications.</p>
<p>The Class 1.0 specification identifies the specified accuracy class of this CT for compatible applications.</p>
<p>When selecting the CT, users should consider the accuracy requirement of the connected meter or measurement system along with the current ratio and burden.</p>
<p>The CT should be used within the applicable operating conditions and according to the requirements of the complete electrical installation.</p>
<hr />
<h1>2.5–15 VA Rating</h1>
<p>The <strong>50/5A Ring CT has a specified VA rating of 2.5–15 VA</strong>.</p>
<p>The VA rating is associated with the burden connected to the CT secondary circuit. The total burden can include the connected meter, secondary wiring, and other measurement equipment.</p>
<p>Before installation, the connected secondary burden should be checked against the specified <strong>2.5–15 VA</strong> rating.</p>
<p>Selecting a suitable VA rating is important when matching a Current Transformer with the connected metering and measurement circuit.</p>
<hr />
<h1>Standard 5A Secondary</h1>
<p>This Current Transformer has a <strong>5A secondary current</strong>.</p>
<p>The 5A secondary configuration can be used with compatible meters, energy meters, current measuring instruments, and monitoring equipment designed for a 5A CT input.</p>
<p>Before connecting the secondary circuit, verify that the connected equipment is compatible with a <strong>5A CT secondary</strong>.</p>
<p>The <strong>50/5A ratio</strong> should also be correctly configured in compatible metering equipment where required.</p>
<hr />
<h1>80mm Outer Diameter and 40mm Width</h1>
<p>The CT has an <strong>80mm outer diameter</strong> and <strong>40mm width</strong>.</p>
<p>These physical dimensions should be considered when planning the installation.</p>
<p>The outer dimensions determine the space required around the conductor and within the electrical panel or equipment.</p>
<p>Before installation, ensure sufficient space is available for:</p>
<ul>
<li>CT body</li>
<li>Primary conductor</li>
<li>Secondary wiring</li>
<li>Mounting</li>
<li>Required clearance</li>
<li>Cable routing</li>
</ul>
<p>The combination of <strong>35mm ID, 80mm OD, and 40mm width</strong> provides the key physical dimensions required for checking installation compatibility.</p>
<hr />
<h1>Applications</h1>
<p>The <strong>50/5A Ring Current Transformer</strong> can be considered for compatible applications including:</p>
<ul>
<li>Energy metering systems</li>
<li>Electrical current measurement</li>
<li>Electrical monitoring</li>
<li>Metering panels</li>
<li>Electrical control panels</li>
<li>Distribution panels</li>
<li>Power monitoring systems</li>
<li>Industrial electrical installations</li>
<li>Current monitoring systems</li>
<li>Electrical measurement equipment</li>
<li>Energy measurement applications</li>
<li>Compatible electrical panels</li>
<li>Load monitoring applications</li>
</ul>
<p>The actual suitability of the CT depends on the electrical and mechanical requirements of the installation.</p>
<hr />
<h1>Benefits of 50/5A Ring Current Transformer</h1>
<h2>50/5A Current Ratio</h2>
<p>The <strong>50/5A ratio</strong> provides a defined 5A secondary configuration for compatible measurement equipment designed for this CT ratio.</p>
<h2>Class 1.0 Accuracy</h2>
<p>The specified <strong>Class 1.0 accuracy</strong> makes the CT suitable for compatible metering and current measurement applications requiring this accuracy class.</p>
<h2>35mm Inner Diameter</h2>
<p>The <strong>35mm ID</strong> provides a defined opening for compatible conductors or cables.</p>
<h2>80mm Outer Diameter</h2>
<p>The <strong>80mm OD</strong> provides a defined overall circular body dimension for installation planning.</p>
<h2>40mm Width</h2>
<p>The <strong>40mm width</strong> provides a defined physical depth of the ring-type CT.</p>
<h2>5A Secondary</h2>
<p>The standard <strong>5A secondary</strong> is suitable for compatible meters and measurement equipment designed for a 5A CT input.</p>
<h2>2.5–15 VA Rating</h2>
<p>The specified <strong>2.5–15 VA rating</strong> allows the CT to be considered for compatible secondary metering circuits according to the connected burden.</p>
<h2>Encapsulated Round-Type Construction</h2>
<p>The encapsulated round-type configuration provides a defined physical design for suitable electrical measurement and panel applications.</p>
<hr />
<h1>50/5A Ring CT for Electrical Panels</h1>
<p>The <strong>50/5A 35mm Ring Current Transformer</strong> can be considered for compatible electrical panels where current measurement and monitoring are required.</p>
<p>Before selecting the CT, verify:</p>
<ul>
<li><strong>Primary Current:</strong> 50A</li>
<li><strong>Secondary Current:</strong> 5A</li>
<li><strong>Current Ratio:</strong> 50/5A</li>
<li><strong>Accuracy Class:</strong> Class 1.0</li>
<li><strong>Inner Diameter:</strong> 35mm</li>
<li><strong>Outer Diameter:</strong> 80mm</li>
<li><strong>Width:</strong> 40mm</li>
<li><strong>VA Rating:</strong> 2.5–15 VA</li>
</ul>
<p>The conductor or cable should fit within the <strong>35mm inner diameter</strong>.</p>
<p>The available panel space should also be checked against the CT&#8217;s <strong>80mm outer diameter and 40mm width</strong>.</p>
<hr />
<h1>Installation Considerations</h1>
<p>Before installing the 50/5A Ring Current Transformer, verify the electrical and mechanical requirements.</p>
<h3>Check the Current Ratio</h3>
<p>Confirm that the required CT ratio is <strong>50/5A</strong>.</p>
<h3>Check the Secondary Equipment</h3>
<p>Confirm that the connected meter or measurement device supports a <strong>5A CT secondary</strong>.</p>
<h3>Check the Inner Diameter</h3>
<p>Ensure that the conductor or cable can pass through the <strong>35mm inner diameter</strong>.</p>
<h3>Check the Outer Dimensions</h3>
<p>Allow sufficient installation space for the <strong>80mm outer diameter and 40mm width</strong>.</p>
<h3>Check Accuracy Class</h3>
<p>Verify that <strong>Class 1.0</strong> meets the requirements of the intended metering application.</p>
<h3>Check VA Rating</h3>
<p>Confirm that the connected secondary burden is compatible with the <strong>2.5–15 VA</strong> specification.</p>
<p>Installation should be carried out by appropriately qualified electrical personnel using suitable electrical safety procedures.</p>
<hr />
<h1>Why Choose the 50/5A Ring Metering CT?</h1>
<p>The <strong>50/5A Ring Current Transformer</strong> combines a <strong>50A primary rating, 5A secondary, Class 1.0 accuracy, 35mm inner diameter, 80mm outer diameter, 40mm width, and 2.5–15 VA rating</strong> in an encapsulated round-type design.</p>
<p>The ring-type configuration provides a defined circular opening for compatible conductors or cables.</p>
<p>Its <strong>35mm ID</strong> and <strong>80mm OD</strong> make physical dimensions an important part of product selection, while the <strong>40mm width</strong> should be considered when planning the available installation depth.</p>
<p>For electrical contractors, panel builders, distributors, industrial users, and bulk buyers, the CT ratio, quantity, conductor dimensions, and application requirements should be confirmed before ordering.</p>
<hr />
<h1>MVG Power Solutions – Current Transformer Supplier</h1>
<p><strong>MVG Power Solutions</strong> supplies Current Transformers and electrical measurement products for different metering and monitoring requirements.</p>
<p>The CT range includes different current ratios, window sizes, ring-type configurations, construction types, accuracy classes, and VA ratings.</p>
<p>The <strong>50/5A 35mm Ring Current Transformer</strong> is specified with a <strong>50A primary, 5A secondary, Class 1.0 accuracy, 35mm ID, 80mm OD, 40mm width, and 2.5–15 VA rating</strong>.</p>
<p>The model shown in the supplied product image is <strong>8040-MVG-R-35</strong>.</p>
<p>For bulk requirements, electrical contractors, panel builders, distributors, and industrial customers can contact MVG Power Solutions with the required CT ratio, quantity, conductor dimensions, and application details.</p>
<hr />
<h1>Product Summary</h1>
<p>The <strong>50/5A 35mm Ring Current Transformer | Class 1.0 Metering CT</strong> is an encapsulated round-type Current Transformer designed for compatible electrical metering, current measurement, and monitoring applications.</p>
<p>It features a <strong>50A primary current, 5A secondary current, 50/5A current ratio, Class 1.0 accuracy, 35mm inner diameter, 80mm outer diameter, 40mm width, and 2.5–15 VA rating</strong>.</p>
<p>The ring-type design provides a defined opening for compatible conductors or cables, while the 35mm ID, 80mm OD, and 40mm width provide the main physical dimensions for installation planning.</p>
<p>Before ordering, verify the CT ratio, accuracy class, secondary current, conductor dimensions, VA rating, and available installation space.</p>
<hr />
<h1>Frequently Asked Questions</h1>
<h3>What is the current ratio of this Ring Current Transformer?</h3>
<p>The specified current ratio is <strong>50/5A</strong>.</p>
<h3>What is the primary current?</h3>
<p>The specified primary current is <strong>50A</strong>.</p>
<h3>What is the secondary current?</h3>
<p>The secondary current is <strong>5A</strong>.</p>
<h3>What is the accuracy class?</h3>
<p>The Current Transformer has a specified <strong>Class 1.0 accuracy</strong>.</p>
<h3>What is the inner diameter?</h3>
<p>The specified inner diameter is <strong>35mm</strong>.</p>
<h3>What is the outer diameter?</h3>
<p>The specified outer diameter is <strong>80mm</strong>.</p>
<h3>What is the width of the CT?</h3>
<p>The specified width is <strong>40mm</strong>.</p>
<h3>What is the VA rating?</h3>
<p>The specified VA rating is <strong>2.5–15 VA</strong>.</p>
<h3>What is the model number?</h3>
<p>The model number shown in the supplied product image is <strong>8040-MVG-R-35</strong>.</p>
<h3>Is this CT suitable for a 5A meter?</h3>
<p>Yes. The CT has a <strong>5A secondary</strong> and can be considered for compatible measurement equipment designed for a 5A CT input.</p>
<h3>Where can this Ring CT be used?</h3>
<p>It can be considered for compatible <strong>energy metering, current measurement, electrical monitoring, metering panels, control panels, distribution equipment, and other suitable electrical applications</strong>.</p>
<h3>What should I check before purchasing?</h3>
<p>Check the <strong>50/5A ratio, Class 1.0 accuracy, 5A secondary, 35mm inner diameter, 80mm outer diameter, 40mm width, 2.5–15 VA rating, and connected equipment compatibility</strong>.</p>
<hr />
<h1>Shipping &amp; Bulk Orders</h1>
<p>For bulk requirements, customers can contact <strong>MVG Power Solutions</strong> with the required quantity and application details.</p>
<p>For quotations, provide:</p>
<ul>
<li>CT ratio</li>
<li>Accuracy class</li>
<li>Secondary current</li>
<li>Required inner diameter</li>
<li>Quantity</li>
<li>Application requirements</li>
</ul>
<p>For this model, also confirm that the conductor or cable fits within the <strong>35mm ID</strong> before ordering.</p>', 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/50-5a-35mm-ring-current-transformer-specifications.jpg', 0, 'published'),
(173, 2, 59, 1, '1000/5A 62mm Current Transformer | Class 1.0 Metering CT', '1000-5a-62mm-current-transformer', 'MVG-60-6215-1-1-1', 280.00, 280.00, 10, '85043100', 18.00, 'in_stock', '<ul data-spread="false">
<li><strong>Product Type:</strong> Encapsulated Square Type Current Transformer</li>
<li><strong>Primary Current:</strong> 1000A</li>
<li><strong>Secondary Current:</strong> 5A</li>
<li><strong>Current Ratio:</strong> 1000/5A</li>
<li><strong>Accuracy Class:</strong> Class 1.0</li>
<li><strong>Diameter:</strong> 62mm</li>
<li><strong>Busbar Window:</strong> 62 × 15mm</li>
<li><strong>Dimensions (H × L × W):</strong> 110 × 60 × 40mm</li>
<li><strong>VA Rating:</strong> 2.5–15 VA</li>
<li><strong>Construction:</strong> Encapsulated Square Type</li>
<li><strong>Secondary Output:</strong> 5A</li>
<li><strong>Application:</strong> Metering &amp; Current Measurement</li>
<li>Suitable for <strong>electrical panels and metering systems</strong></li>
<li>Suitable for <strong>current measurement and monitoring applications</strong></li>
<li></li>
</ul>', '<h1>Product Overview</h1>
<p class="isSelectedEnd">The <strong>1000/5A 62mm Current Transformer | Class 1.0 Metering CT</strong> is an encapsulated square-type Current Transformer designed for compatible electrical current measurement, metering, monitoring, and distribution applications. It features a <strong>1000A primary current, 5A secondary current, 1000/5A current ratio, Class 1.0 accuracy, 62mm diameter, 62 × 15mm busbar window, 2.5–15 VA rating, and 110 × 60 × 40mm dimensions</strong>.</p>
<p class="isSelectedEnd">A Current Transformer is used to transform a higher primary current into a proportional secondary current for compatible measuring and monitoring equipment. With a <strong>1000/5A current ratio</strong>, this CT is configured for a 1000A primary current and 5A secondary current.</p>
<p class="isSelectedEnd">The <strong>5A secondary output</strong> can be used with compatible energy meters, current meters, monitoring instruments, and other electrical measurement equipment designed for a 5A CT input. The connected equipment should always be checked for the required CT ratio and secondary input before installation.</p>
<p class="isSelectedEnd">This model features a <strong>62mm diameter</strong> and a <strong>62 × 15mm busbar window</strong>. The window size is an important consideration when selecting a CT because the conductor or busbar passing through the transformer must fit within the available opening.</p>
<p class="isSelectedEnd">The overall dimensions of the CT are <strong>110 × 60 × 40mm (H × L × W)</strong>. This provides a defined physical size for compatible electrical panel installations. The encapsulated square-type construction provides a compact configuration for metering panels, distribution equipment, monitoring systems, and other suitable applications.</p>
<p class="isSelectedEnd">The CT has a specified <strong>2.5–15 VA rating</strong>. VA rating should be considered together with the connected meter, secondary wiring, and other devices in the secondary circuit. The total connected burden should be compatible with the CT&#8217;s specified rating.</p>
<div>
<hr />
</div>
<h1>Key Features</h1>
<p class="isSelectedEnd">The <strong>1000/5A 62mm Class 1.0 Current Transformer</strong> offers the following features:</p>
<ul data-spread="false">
<li><strong>1000/5A current ratio</strong></li>
<li><strong>1000A primary current</strong></li>
<li><strong>5A secondary current</strong></li>
<li><strong>Class 1.0 accuracy</strong></li>
<li><strong>62mm diameter</strong></li>
<li><strong>62 × 15mm busbar window</strong></li>
<li><strong>2.5–15 VA rating</strong></li>
<li>Encapsulated square-type construction</li>
<li><strong>110 × 60 × 40mm dimensions</strong></li>
<li>Suitable for compatible metering systems</li>
<li>Suitable for electrical current measurement</li>
<li>Suitable for current monitoring</li>
<li>Suitable for electrical panels</li>
<li>Suitable for compatible distribution equipment</li>
</ul>
<div>
<hr />
</div>
<h1>Technical Specifications</h1>
<table>
<tbody>
<tr>
<th>Parameter</th>
<th>Specification</th>
</tr>
<tr>
<td><strong>Product Type</strong></td>
<td>Current Transformer</td>
</tr>
<tr>
<td><strong>CT Type</strong></td>
<td>Encapsulated Square Type</td>
</tr>
<tr>
<td><strong>Primary Current</strong></td>
<td>1000A</td>
</tr>
<tr>
<td><strong>Secondary Current</strong></td>
<td>5A</td>
</tr>
<tr>
<td><strong>Current Ratio</strong></td>
<td>1000/5A</td>
</tr>
<tr>
<td><strong>Accuracy Class</strong></td>
<td>Class 1.0</td>
</tr>
<tr>
<td><strong>Diameter</strong></td>
<td>62mm</td>
</tr>
<tr>
<td><strong>Busbar Window</strong></td>
<td>62 × 15mm</td>
</tr>
<tr>
<td><strong>Dimensions (H × L × W)</strong></td>
<td>110 × 60 × 40mm</td>
</tr>
<tr>
<td><strong>VA Rating</strong></td>
<td>2.5–15 VA</td>
</tr>
<tr>
<td><strong>Application</strong></td>
<td>Metering &amp; Current Measurement</td>
</tr>
</tbody>
</table>
<div>
<hr />
</div>
<h1>1000/5A Current Transformer for Metering</h1>
<p class="isSelectedEnd">The <strong>1000/5A Current Transformer</strong> is designed for compatible electrical systems where a 1000A primary current rating and 5A secondary measurement input are required.</p>
<p class="isSelectedEnd">The <strong>1000/5A current ratio</strong> provides a defined relationship between the primary and secondary current for compatible measurement equipment. At the specified primary rating, the CT secondary is designed around a 5A output.</p>
<p class="isSelectedEnd">The secondary circuit can be connected to compatible meters, energy monitoring equipment, current measuring instruments, and other devices designed for a 5A CT input.</p>
<p class="isSelectedEnd">When selecting this CT, users should verify the required primary current, secondary current, accuracy class, burden, window dimensions, and connected equipment requirements.</p>
<p class="isSelectedEnd">The CT ratio should also be correctly configured in compatible metering equipment where CT-ratio programming is required.</p>
<div>
<hr />
</div>
<h1>62mm Diameter and 62 × 15mm Busbar Window</h1>
<p class="isSelectedEnd">This Current Transformer has a <strong>62mm diameter</strong> and a <strong>62 × 15mm busbar window</strong>.</p>
<p class="isSelectedEnd">The busbar window is a critical physical specification because the conductor or busbar needs to pass through the CT opening.</p>
<p class="isSelectedEnd">Before ordering or installation, check:</p>
<ul data-spread="false">
<li>Busbar width</li>
<li>Busbar thickness</li>
<li>Conductor dimensions</li>
<li>Available clearance</li>
<li>Electrical panel space</li>
<li>CT mounting arrangement</li>
<li>Cable routing</li>
<li>Connected meter requirements</li>
</ul>
<p class="isSelectedEnd">The <strong>62 × 15mm window</strong> should be compared with the actual dimensions of the conductor or busbar to ensure physical compatibility.</p>
<div>
<hr />
</div>
<h1>Class 1.0 Accuracy</h1>
<p class="isSelectedEnd">The <strong>1000/5A 62mm Current Transformer is specified as Class 1.0</strong>.</p>
<p class="isSelectedEnd">Accuracy class is an important specification for Current Transformers used in metering and current measurement applications. The required accuracy class should be selected according to the requirements of the connected measurement equipment and electrical system.</p>
<p class="isSelectedEnd">The Class 1.0 specification makes this CT suitable for compatible metering applications where this accuracy class is required.</p>
<p class="isSelectedEnd">The actual suitability of the CT should be evaluated together with the current ratio, secondary burden, connected equipment, and operating conditions.</p>
<div>
<hr />
</div>
<h1>2.5–15 VA Rating</h1>
<p class="isSelectedEnd">The <strong>1000/5A 62mm CT</strong> has a specified <strong>2.5–15 VA rating</strong>.</p>
<p class="isSelectedEnd">VA rating relates to the burden connected to the CT secondary circuit. The connected meter, secondary wiring, and other devices can contribute to the total burden.</p>
<p class="isSelectedEnd">Before installation, the total secondary burden should be checked against the CT&#8217;s specified <strong>2.5–15 VA rating</strong>.</p>
<p class="isSelectedEnd">Selecting the appropriate VA rating helps ensure that the CT is compatible with the intended measurement circuit.</p>
<div>
<hr />
</div>
<h1>5A Secondary Current</h1>
<p class="isSelectedEnd">The secondary current of this Current Transformer is <strong>5A</strong>.</p>
<p class="isSelectedEnd">The 5A secondary configuration is suitable for compatible energy meters, current meters, monitoring instruments, and electrical measurement equipment designed for a 5A CT input.</p>
<p class="isSelectedEnd">Before connecting the secondary circuit, confirm that the connected equipment supports a <strong>5A CT secondary</strong>.</p>
<p class="isSelectedEnd">The <strong>1000/5A ratio</strong> should also be correctly entered or configured in compatible metering equipment where required.</p>
<div>
<hr />
</div>
<h1>Compact 110 × 60 × 40mm Construction</h1>
<p class="isSelectedEnd">The CT has overall dimensions of:</p>
<p class="isSelectedEnd"><strong>110 × 60 × 40mm (H × L × W)</strong></p>
<p class="isSelectedEnd">These dimensions should be considered when planning installation inside an electrical panel or other equipment.</p>
<p class="isSelectedEnd">Adequate space should be provided for:</p>
<ul data-spread="false">
<li>CT body</li>
<li>Primary conductor or busbar</li>
<li>Secondary terminals</li>
<li>Wiring</li>
<li>Mounting</li>
<li>Required clearances</li>
</ul>
<p class="isSelectedEnd">The physical installation should also account for the <strong>62 × 15mm busbar window</strong>.</p>
<div>
<hr />
</div>
<h1>Applications</h1>
<p class="isSelectedEnd">The 1000/5A 62mm Current Transformer can be considered for compatible applications including:</p>
<ul data-spread="false">
<li>Energy metering systems</li>
<li>Electrical current measurement</li>
<li>Electrical distribution panels</li>
<li>Metering panels</li>
<li>Electrical control panels</li>
<li>Power monitoring systems</li>
<li>Industrial electrical installations</li>
<li>Electrical monitoring equipment</li>
<li>Current monitoring systems</li>
<li>Distribution equipment</li>
<li>Energy measurement applications</li>
<li>Electrical load monitoring</li>
<li>Compatible panel metering systems</li>
</ul>
<p class="isSelectedEnd">The actual suitability of the CT depends on the electrical and mechanical requirements of the installation.</p>
<div>
<hr />
</div>
<h1>Benefits of 1000/5A Current Transformer</h1>
<h2>1000/5A Current Ratio</h2>
<p class="isSelectedEnd">The <strong>1000/5A ratio</strong> provides a defined 5A secondary configuration for compatible measurement equipment designed for this CT ratio.</p>
<h2>Class 1.0 Accuracy</h2>
<p class="isSelectedEnd">The Class 1.0 specification makes the CT suitable for compatible metering and current measurement applications requiring this accuracy class.</p>
<h2>62mm Diameter</h2>
<p class="isSelectedEnd">The <strong>62mm diameter</strong> provides a defined opening for compatible conductors and busbars.</p>
<h2>62 × 15mm Busbar Window</h2>
<p class="isSelectedEnd">The specified <strong>62 × 15mm busbar window</strong> provides a defined physical opening for compatible busbar installations.</p>
<h2>5A Secondary</h2>
<p class="isSelectedEnd">The 5A secondary configuration is suitable for compatible meters and measurement equipment designed for a 5A CT input.</p>
<h2>2.5–15 VA Rating</h2>
<p class="isSelectedEnd">The specified <strong>2.5–15 VA rating</strong> allows the CT to be considered for compatible secondary metering circuits according to the connected burden.</p>
<h2>Compact Dimensions</h2>
<p class="isSelectedEnd">The <strong>110 × 60 × 40mm</strong> dimensions provide a defined physical form factor for compatible electrical panel installations.</p>
<div>
<hr />
</div>
<h1>1000/5A CT for Electrical Panels</h1>
<p class="isSelectedEnd">The <strong>1000/5A 62mm Current Transformer</strong> can be considered for electrical panels where compatible current measurement and monitoring are required.</p>
<p class="isSelectedEnd">Before selecting the CT, verify:</p>
<ul data-spread="false">
<li><strong>Primary Current:</strong> 1000A</li>
<li><strong>Secondary Current:</strong> 5A</li>
<li><strong>Current Ratio:</strong> 1000/5A</li>
<li><strong>Accuracy Class:</strong> Class 1.0</li>
<li><strong>Diameter:</strong> 62mm</li>
<li><strong>Busbar Window:</strong> 62 × 15mm</li>
<li><strong>Dimensions:</strong> 110 × 60 × 40mm</li>
<li><strong>VA Rating:</strong> 2.5–15 VA</li>
</ul>
<p class="isSelectedEnd">The conductor or busbar should also be checked against the CT window before installation.</p>
<div>
<hr />
</div>
<h1>Installation Considerations</h1>
<p class="isSelectedEnd">Before installing the 1000/5A Current Transformer, verify the complete electrical and mechanical requirements.</p>
<h3>Check the Primary Current</h3>
<p class="isSelectedEnd">Confirm that the <strong>1000A primary rating</strong> is appropriate for the intended electrical system.</p>
<h3>Check the Secondary Equipment</h3>
<p class="isSelectedEnd">Confirm that the connected meter or measurement device supports a <strong>5A CT secondary</strong>.</p>
<h3>Check the Busbar Window</h3>
<p class="isSelectedEnd">Ensure that the conductor or busbar fits within the <strong>62 × 15mm window</strong>.</p>
<h3>Check Accuracy Class</h3>
<p class="isSelectedEnd">Verify that <strong>Class 1.0</strong> meets the requirements of the intended metering application.</p>
<h3>Check Burden</h3>
<p class="isSelectedEnd">Confirm that the connected secondary burden is compatible with the specified <strong>2.5–15 VA</strong> rating.</p>
<h3>Check Physical Space</h3>
<p class="isSelectedEnd">Ensure sufficient space is available for the <strong>110 × 60 × 40mm</strong> CT and its secondary wiring.</p>
<p class="isSelectedEnd">Installation should be performed by appropriately qualified electrical personnel using suitable electrical safety procedures.</p>
<div>
<hr />
</div>
<h1>Why Choose the 1000/5A 62mm Metering CT?</h1>
<p class="isSelectedEnd">The <strong>1000/5A 62mm Current Transformer</strong> combines a <strong>1000A primary rating, 5A secondary, Class 1.0 accuracy, 62mm diameter, 62 × 15mm busbar window, 2.5–15 VA rating, and 110 × 60 × 40mm dimensions</strong> in an encapsulated square-type configuration.</p>
<p class="isSelectedEnd">These specifications make it suitable for consideration in compatible metering, current measurement, monitoring, and electrical panel applications.</p>
<p class="isSelectedEnd">The defined physical dimensions allow users to check compatibility with the available panel space and conductor or busbar arrangement before installation.</p>
<p class="isSelectedEnd">For electrical contractors, panel builders, distributors, industrial users, and bulk buyers, the required CT ratio, quantity, and application should be confirmed before ordering.</p>
<div>
<hr />
</div>
<h1>MVG Power Solutions – Current Transformer Supplier</h1>
<p class="isSelectedEnd"><strong>MVG Power Solutions</strong> supplies Current Transformers and electrical measurement products for different metering and monitoring requirements.</p>
<p class="isSelectedEnd">The CT product range includes different current ratios, window sizes, dimensions, construction types, accuracy classes, and VA ratings.</p>
<p class="isSelectedEnd">The <strong>1000/5A 62mm Class 1.0 Current Transformer</strong> is specified with a <strong>1000A primary, 5A secondary, 62mm diameter, 62 × 15mm busbar window, 110 × 60 × 40mm dimensions, and 2.5–15 VA rating</strong>.</p>
<p class="isSelectedEnd">For bulk requirements, electrical contractors, panel builders, distributors, and industrial customers can contact MVG Power Solutions with the required CT ratio, quantity, and application details.</p>
<div>
<hr />
</div>
<h1>Product Summary</h1>
<p class="isSelectedEnd">The <strong>1000/5A 62mm Current Transformer | Class 1.0 Metering CT</strong> is an encapsulated square-type Current Transformer designed for compatible electrical metering, current measurement, and monitoring applications.</p>
<p class="isSelectedEnd">It features a <strong>1000A primary current, 5A secondary current, 1000/5A current ratio, Class 1.0 accuracy, 62mm diameter, 62 × 15mm busbar window, 2.5–15 VA rating, and 110 × 60 × 40mm dimensions</strong>.</p>
<p class="isSelectedEnd">The CT can be considered for compatible electrical panels, energy metering systems, distribution equipment, current monitoring systems, and electrical measurement applications.</p>
<p class="isSelectedEnd">Before ordering, verify the CT ratio, accuracy class, secondary current, burden, window size, dimensions, and connected equipment requirements.</p>
<div>
<hr />
</div>
<h1>Frequently Asked Questions</h1>
<h3>What is the current ratio of the 1000/5A CT?</h3>
<p class="isSelectedEnd">The current ratio is <strong>1000/5A</strong>, with a 1000A primary current and 5A secondary current.</p>
<h3>What is the primary current?</h3>
<p class="isSelectedEnd">The specified primary current is <strong>1000A</strong>.</p>
<h3>What is the secondary current?</h3>
<p class="isSelectedEnd">The secondary current is <strong>5A</strong>.</p>
<h3>What is the accuracy class?</h3>
<p class="isSelectedEnd">The Current Transformer has a specified <strong>Class 1.0 accuracy</strong>.</p>
<h3>What is the diameter of the CT?</h3>
<p class="isSelectedEnd">The specified diameter is <strong>62mm</strong>.</p>
<h3>What is the busbar window size?</h3>
<p class="isSelectedEnd">The busbar window is <strong>62 × 15mm</strong>.</p>
<h3>What are the dimensions of the CT?</h3>
<p class="isSelectedEnd">The dimensions are <strong>110 × 60 × 40mm (H × L × W)</strong>.</p>
<h3>What is the VA rating?</h3>
<p class="isSelectedEnd">The specified VA rating is <strong>2.5–15 VA</strong>.</p>
<h3>Is this CT suitable for a 5A meter?</h3>
<p class="isSelectedEnd">Yes. The CT has a <strong>5A secondary</strong> and can be considered for compatible meters and measurement equipment designed for a 5A CT input.</p>
<h3>Where can this CT be used?</h3>
<p class="isSelectedEnd">It can be considered for compatible <strong>energy metering, current measurement, electrical monitoring, distribution panels, control panels, metering panels, and power monitoring applications</strong>.</p>
<h3>What should I check before purchasing?</h3>
<p class="isSelectedEnd">Check the <strong>1000/5A current ratio, Class 1.0 accuracy, 5A secondary, 62mm diameter, 62 × 15mm busbar window, 110 × 60 × 40mm dimensions, and 2.5–15 VA rating</strong> before purchasing.</p>
<div>
<hr />
</div>
<h1>Shipping &amp; Bulk Orders</h1>
<p class="isSelectedEnd">For bulk requirements, customers can contact <strong>MVG Power Solutions</strong> with the required quantity and application details.</p>
<p class="isSelectedEnd">For quotations, provide:</p>
<ul data-spread="false">
<li>CT ratio</li>
<li>Accuracy class</li>
<li>Secondary current</li>
<li>Busbar window</li>
<li>Quantity</li>
<li>Application requirements</li>
</ul>
<p>Bulk requirements can be discussed according to the required product configuration and quantity.</p>', 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/1000-5a-62mm-current-transformer-class-1-metering-ct.jpg', 0, 'published'),
(170, 2, 59, 1, '800/5A 62mm Current Transformer | Class 1.0 Metering CT', '800-5a-62mm-current-transformer', 'MVG-60-6215-1-1', 280.00, 280.00, 10, '85043100', 18.00, 'in_stock', '<ul data-spread="false">
<li><strong>Product Type:</strong> Encapsulated Square Type Current Transformer</li>
<li><strong>Primary Current:</strong> 800A</li>
<li><strong>Secondary Current:</strong> 5A</li>
<li><strong>Current Ratio:</strong> 800/5A</li>
<li><strong>Accuracy Class:</strong> Class 1.0</li>
<li><strong>Diameter:</strong> 62mm</li>
<li><strong>Busbar Window:</strong> 62 × 15mm</li>
<li><strong>Dimensions (H × L × W):</strong> 110 × 60 × 40mm</li>
<li><strong>VA Rating:</strong> 2.5–15 VA</li>
<li><strong>Construction:</strong> Encapsulated Square Type</li>
<li><strong>Secondary Output:</strong> 5A</li>
<li><strong>Application:</strong> Metering &amp; Current Measurement</li>
<li>Suitable for <strong>electrical panels and metering systems</strong></li>
<li>Suitable for <strong>current measurement and monitoring applications</strong></li>
</ul>
<div>
<hr />
</div>
<h1></h1>', '<h1>Product Overview</h1>
<p>The <strong>800/5A 62mm Current Transformer | Class 1.0 Metering CT</strong> is an encapsulated square-type Current Transformer designed for compatible electrical current measurement, metering, monitoring, and distribution applications. It features an <strong>800A primary current, 5A secondary current, Class 1.0 accuracy, 62mm diameter, 62 × 15mm busbar window, 2.5–15 VA rating, and 110 × 60 × 40mm dimensions</strong>.</p>
<p>A Current Transformer is used to transform a primary electrical current into a proportional secondary current for compatible measuring and monitoring equipment. The <strong>800/5A current ratio</strong> provides a 5A secondary output corresponding to the specified 800A primary rating under applicable operating conditions.</p>
<p>The <strong>62mm diameter</strong> and <strong>62 × 15mm busbar window</strong> provide a defined opening for compatible conductors or busbars. Before installation, the dimensions of the conductor or busbar should be checked against the CT window to ensure mechanical compatibility.</p>
<p>The CT has overall dimensions of <strong>110 × 60 × 40mm (H × L × W)</strong>. Its encapsulated square-type construction provides a defined compact configuration for suitable electrical panels, metering systems, monitoring equipment, and distribution installations.</p>
<p>The specified <strong>2.5–15 VA rating</strong> should be considered when selecting this CT. The connected meter, secondary wiring, and other devices contribute to the total secondary circuit burden, so the CT should be selected according to the requirements of the complete measurement system.</p>
<hr />
<h1>Key Features</h1>
<p>The 800/5A 62mm Class 1.0 Current Transformer offers the following features:</p>
<ul>
<li><strong>800/5A current ratio</strong></li>
<li><strong>800A primary current</strong></li>
<li><strong>5A secondary current</strong></li>
<li><strong>Class 1.0 accuracy</strong></li>
<li><strong>62mm diameter</strong></li>
<li><strong>62 × 15mm busbar window</strong></li>
<li><strong>2.5–15 VA rating</strong></li>
<li>Encapsulated square-type construction</li>
<li><strong>110 × 60 × 40mm dimensions</strong></li>
<li>Suitable for compatible metering systems</li>
<li>Suitable for electrical current measurement</li>
<li>Suitable for current monitoring</li>
<li>Suitable for electrical panels</li>
<li>Suitable for compatible distribution equipment</li>
</ul>
<hr />
<h1>Technical Specifications</h1>
<table>
<thead>
<tr>
<th>Parameter</th>
<th>Specification</th>
</tr>
</thead>
<tbody>
<tr>
<td><strong>Product Type</strong></td>
<td>Current Transformer</td>
</tr>
<tr>
<td><strong>CT Type</strong></td>
<td>Encapsulated Square Type</td>
</tr>
<tr>
<td><strong>Primary Current</strong></td>
<td>800A</td>
</tr>
<tr>
<td><strong>Secondary Current</strong></td>
<td>5A</td>
</tr>
<tr>
<td><strong>Current Ratio</strong></td>
<td>800/5A</td>
</tr>
<tr>
<td><strong>Accuracy Class</strong></td>
<td>Class 1.0</td>
</tr>
<tr>
<td><strong>Diameter</strong></td>
<td>62mm</td>
</tr>
<tr>
<td><strong>Busbar Window</strong></td>
<td>62 × 15mm</td>
</tr>
<tr>
<td><strong>Dimensions (H × L × W)</strong></td>
<td>110 × 60 × 40mm</td>
</tr>
<tr>
<td><strong>VA Rating</strong></td>
<td>2.5–15 VA</td>
</tr>
<tr>
<td><strong>Application</strong></td>
<td>Metering &amp; Current Measurement</td>
</tr>
</tbody>
</table>
<hr />
<h1>800/5A Current Transformer for Metering</h1>
<p>The <strong>800/5A Current Transformer</strong> is designed for compatible electrical systems where current measurement is required through a 5A secondary circuit.</p>
<p>With an <strong>800A primary current and 5A secondary current</strong>, this CT provides an <strong>800/5A current ratio</strong> for compatible meters and electrical measurement equipment.</p>
<p>The secondary side can be connected to compatible energy meters, current meters, monitoring instruments, and other measurement devices designed for a 5A CT input.</p>
<p>When selecting this Current Transformer, it is important to verify the required primary current, secondary current, accuracy class, burden, physical dimensions, and compatibility with the connected measuring equipment.</p>
<p>The CT ratio should also be correctly accounted for when configuring compatible metering equipment.</p>
<hr />
<h1>62mm Diameter and 62 × 15mm Busbar Window</h1>
<p>This Current Transformer features a <strong>62mm diameter</strong> and a <strong>62 × 15mm busbar window</strong>.</p>
<p>The CT window is an important mechanical specification because the conductor or busbar passing through the transformer must fit within the available opening.</p>
<p>Before ordering or installation, check:</p>
<ul>
<li>Busbar width</li>
<li>Busbar thickness</li>
<li>Conductor dimensions</li>
<li>Available clearance</li>
<li>Panel space</li>
<li>CT mounting arrangement</li>
<li>Cable routing</li>
<li>Connected meter requirements</li>
</ul>
<p>The <strong>62 × 15mm busbar window</strong> provides a defined opening for compatible busbar installations.</p>
<hr />
<h1>Class 1.0 Accuracy</h1>
<p>The <strong>800/5A 62mm Current Transformer is specified as Class 1.0</strong>.</p>
<p>Accuracy class is an important specification when selecting a CT for metering and current measurement applications. The required accuracy class should be selected according to the requirements of the connected measurement equipment.</p>
<p>The Class 1.0 specification makes this CT suitable for compatible metering and current measurement applications where Class 1.0 accuracy is required.</p>
<p>Actual CT performance depends on applicable operating conditions, connected burden, installation conditions, and other system requirements.</p>
<hr />
<h1>2.5–15 VA Rating</h1>
<p>The 800/5A 62mm Current Transformer has a specified <strong>2.5–15 VA rating</strong>.</p>
<p>VA rating is associated with the burden connected to the CT secondary circuit. The connected meter, secondary wiring, and other measurement equipment should be considered when determining the total burden.</p>
<p>Before installation, verify that the connected secondary burden is compatible with the specified <strong>2.5–15 VA</strong> rating.</p>
<p>This specification allows the CT to be considered for compatible metering and monitoring circuits according to the requirements of the installation.</p>
<hr />
<h1>5A Secondary Current</h1>
<p>The secondary current of this Current Transformer is <strong>5A</strong>.</p>
<p>A 5A secondary configuration is used with compatible energy meters, current meters, monitoring instruments, and other electrical equipment designed for a 5A CT input.</p>
<p>Before connecting the CT secondary, confirm that the connected equipment is designed for a <strong>5A CT secondary</strong>.</p>
<p>The <strong>800/5A ratio</strong> should also be correctly accounted for when configuring compatible metering equipment.</p>
<hr />
<h1>Compact 110 × 60 × 40mm Construction</h1>
<p>The overall dimensions of this Current Transformer are:</p>
<p><strong>110 × 60 × 40mm (H × L × W)</strong></p>
<p>These dimensions should be considered when planning installation inside an electrical panel or other equipment.</p>
<p>Adequate space should be provided for:</p>
<ul>
<li>CT body</li>
<li>Primary conductor or busbar</li>
<li>Secondary connections</li>
<li>Wiring</li>
<li>Mounting</li>
<li>Required clearances</li>
</ul>
<p>The <strong>62mm diameter</strong> and <strong>62 × 15mm busbar window</strong> should also be checked against the actual conductor or busbar dimensions.</p>
<hr />
<h1>Applications</h1>
<p>The 800/5A 62mm Current Transformer can be considered for compatible applications including:</p>
<ul>
<li>Energy metering systems</li>
<li>Electrical current measurement</li>
<li>Distribution panels</li>
<li>Electrical control panels</li>
<li>Metering panels</li>
<li>Power monitoring systems</li>
<li>Industrial electrical installations</li>
<li>Electrical monitoring equipment</li>
<li>Current monitoring systems</li>
<li>Distribution equipment</li>
<li>Energy measurement applications</li>
<li>Electrical load monitoring</li>
<li>Compatible panel metering systems</li>
</ul>
<p>The actual suitability of the CT depends on the electrical and mechanical requirements of the installation.</p>
<hr />
<h1>Benefits of 800/5A Current Transformer</h1>
<h2>800/5A Current Ratio</h2>
<p>The <strong>800/5A ratio</strong> provides a defined 5A secondary configuration for compatible measurement equipment designed for this CT ratio.</p>
<h2>Class 1.0 Accuracy</h2>
<p>The Class 1.0 specification makes the CT suitable for compatible metering and current measurement applications requiring this accuracy class.</p>
<h2>62mm Diameter</h2>
<p>The <strong>62mm diameter</strong> provides a defined opening for compatible conductors and busbars.</p>
<h2>62 × 15mm Busbar Window</h2>
<p>The specified <strong>62 × 15mm busbar window</strong> provides a defined physical opening for compatible busbar installations.</p>
<h2>5A Secondary</h2>
<p>The 5A secondary configuration is suitable for compatible meters and measurement equipment designed for a 5A CT input.</p>
<h2>2.5–15 VA Rating</h2>
<p>The specified <strong>2.5–15 VA rating</strong> allows the CT to be considered for compatible secondary metering circuits according to the connected burden.</p>
<h2>Compact Dimensions</h2>
<p>The <strong>110 × 60 × 40mm</strong> dimensions provide a defined compact form factor for compatible electrical panel installations.</p>
<hr />
<h1>800/5A CT for Electrical Panels</h1>
<p>The <strong>800/5A 62mm Current Transformer</strong> can be considered for electrical panels where compatible current measurement and monitoring are required.</p>
<p>Before selecting the CT, verify:</p>
<ul>
<li><strong>Primary Current:</strong> 800A</li>
<li><strong>Secondary Current:</strong> 5A</li>
<li><strong>Current Ratio:</strong> 800/5A</li>
<li><strong>Accuracy Class:</strong> Class 1.0</li>
<li><strong>Diameter:</strong> 62mm</li>
<li><strong>Busbar Window:</strong> 62 × 15mm</li>
<li><strong>Dimensions:</strong> 110 × 60 × 40mm</li>
<li><strong>VA Rating:</strong> 2.5–15 VA</li>
</ul>
<p>The conductor or busbar should also be checked against the CT window before installation.</p>
<hr />
<h1>Installation Considerations</h1>
<p>Before installing the 800/5A Current Transformer, verify the complete electrical and mechanical requirements.</p>
<h3>Check the Primary Current</h3>
<p>Confirm that the <strong>800A primary rating</strong> is appropriate for the intended electrical system.</p>
<h3>Check the Secondary Equipment</h3>
<p>Confirm that the connected meter or measurement device supports a <strong>5A CT secondary</strong>.</p>
<h3>Check the Busbar Window</h3>
<p>Ensure that the conductor or busbar fits within the <strong>62 × 15mm window</strong>.</p>
<h3>Check Accuracy Class</h3>
<p>Verify that <strong>Class 1.0</strong> meets the requirements of the intended metering application.</p>
<h3>Check Burden</h3>
<p>Confirm that the connected secondary burden is compatible with the specified <strong>2.5–15 VA</strong> rating.</p>
<h3>Check Physical Space</h3>
<p>Ensure sufficient space is available for the <strong>110 × 60 × 40mm</strong> CT and its secondary wiring.</p>
<p>Installation should be performed by appropriately qualified electrical personnel using suitable electrical safety procedures.</p>
<hr />
<h1>Why Choose the 800/5A 62mm Metering CT?</h1>
<p>The <strong>800/5A 62mm Current Transformer</strong> combines an <strong>800A primary rating, 5A secondary, Class 1.0 accuracy, 62mm diameter, 62 × 15mm busbar window, 2.5–15 VA rating, and 110 × 60 × 40mm dimensions</strong> in an encapsulated square-type configuration.</p>
<p>These specifications make it suitable for consideration in compatible metering, current measurement, monitoring, and electrical panel applications.</p>
<p>The defined physical dimensions allow users to check compatibility with the available panel space and conductor or busbar arrangement before installation.</p>
<p>For electrical contractors, panel builders, distributors, industrial users, and bulk buyers, the required CT ratio, quantity, and application should be confirmed before ordering.</p>
<hr />
<h1>MVG Power Solutions – Current Transformer Supplier</h1>
<p><strong>MVG Power Solutions</strong> supplies Current Transformers and electrical measurement products for different metering and monitoring requirements.</p>
<p>The CT product range includes different current ratios, window sizes, dimensions, construction types, accuracy classes, and VA ratings.</p>
<p>The <strong>800/5A 62mm Class 1.0 Current Transformer</strong> is specified with an <strong>800A primary, 5A secondary, 62mm diameter, 62 × 15mm busbar window, 110 × 60 × 40mm dimensions, and 2.5–15 VA rating</strong>.</p>
<p>For bulk requirements, electrical contractors, panel builders, distributors, and industrial customers can contact MVG Power Solutions with the required CT ratio, quantity, and application details.</p>
<hr />
<h1>Product Summary</h1>
<p>The <strong>800/5A 62mm Current Transformer | Class 1.0 Metering CT</strong> is an encapsulated square-type Current Transformer designed for compatible electrical metering, current measurement, and monitoring applications.</p>
<p>It features an <strong>800A primary current, 5A secondary current, 800/5A current ratio, Class 1.0 accuracy, 62mm diameter, 62 × 15mm busbar window, 2.5–15 VA rating, and 110 × 60 × 40mm dimensions</strong>.</p>
<p>The CT can be considered for compatible electrical panels, energy metering systems, distribution equipment, current monitoring systems, and electrical measurement applications.</p>
<p>Before ordering, verify the CT ratio, accuracy class, secondary current, burden, window size, dimensions, and connected equipment requirements.</p>
<hr />
<h1>Frequently Asked Questions</h1>
<h3>What is the current ratio of the 800/5A CT?</h3>
<p>The current ratio is <strong>800/5A</strong>, with an 800A primary current and 5A secondary current.</p>
<h3>What is the primary current?</h3>
<p>The specified primary current is <strong>800A</strong>.</p>
<h3>What is the secondary current?</h3>
<p>The secondary current is <strong>5A</strong>.</p>
<h3>What is the accuracy class?</h3>
<p>The Current Transformer has a specified <strong>Class 1.0 accuracy</strong>.</p>
<h3>What is the diameter of the CT?</h3>
<p>The specified diameter is <strong>62mm</strong>.</p>
<h3>What is the busbar window size?</h3>
<p>The busbar window is <strong>62 × 15mm</strong>.</p>
<h3>What are the dimensions of the CT?</h3>
<p>The dimensions are <strong>110 × 60 × 40mm (H × L × W)</strong>.</p>
<h3>What is the VA rating?</h3>
<p>The specified VA rating is <strong>2.5–15 VA</strong>.</p>
<h3>Is this CT suitable for a 5A meter?</h3>
<p>Yes. The CT has a <strong>5A secondary</strong> and can be considered for compatible meters and measurement equipment designed for a 5A CT input.</p>
<h3>Where can this CT be used?</h3>
<p>It can be considered for compatible <strong>energy metering, current measurement, electrical monitoring, distribution panels, control panels, metering panels, and power monitoring applications</strong>.</p>
<h3>What should I check before purchasing?</h3>
<p>Check the <strong>800/5A current ratio, Class 1.0 accuracy, 5A secondary, 62mm diameter, 62 × 15mm busbar window, 110 × 60 × 40mm dimensions, and 2.5–15 VA rating</strong> before purchasing.</p>
<hr />
<h1>Shipping &amp; Bulk Orders</h1>
<p>For bulk requirements, customers can contact <strong>MVG Power Solutions</strong> with the required quantity and application details.</p>
<p>For quotations, provide:</p>
<ul>
<li>CT ratio</li>
<li>Accuracy class</li>
<li>Secondary current</li>
<li>Busbar window</li>
<li>Quantity</li>
<li>Application requirements</li>
</ul>
<p>Bulk requirements can be discussed according to the required product configuration and quantity.</p>', 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/800-5a-62mm-current-transformer-class-1-metering-ct.jpg', 0, 'published'),
(167, 2, 59, 1, '600/5A 62mm Current Transformer | Class 1.0 Metering CT', '600-5a-62mm-current-transformer', 'MVG-60-6215-1', 280.00, 280.00, 10, '85043100', 18.00, 'in_stock', '<ul data-spread="false">
<li><strong>Product Type:</strong> Encapsulated Square Type Current Transformer</li>
<li><strong>Primary Current:</strong> 600A</li>
<li><strong>Secondary Current:</strong> 5A</li>
<li><strong>Current Ratio:</strong> 600/5A</li>
<li><strong>Accuracy Class:</strong> Class 1.0</li>
<li><strong>Diameter:</strong> 62mm</li>
<li><strong>Busbar Window:</strong> 62 × 15mm</li>
<li><strong>Dimensions (H × L × W):</strong> 110 × 60 × 40mm</li>
<li><strong>VA Rating:</strong> 2.5–15 VA</li>
<li><strong>Construction:</strong> Encapsulated Square Type</li>
<li><strong>Secondary Output:</strong> 5A</li>
<li><strong>Application:</strong> Metering &amp; Current Measurement</li>
<li>Suitable for compatible <strong>electrical panels</strong></li>
<li>Suitable for <strong>current measurement and monitoring systems</strong></li>
</ul>
<div>
<hr />
</div>
<h1></h1>', '<h1>Product Overview</h1>
<p>The <strong>600/5A 62mm Current Transformer | Class 1.0 Metering CT</strong> is an encapsulated square-type Current Transformer designed for compatible electrical current measurement, metering, monitoring, and distribution applications. It features a <strong>600A primary current, 5A secondary current, Class 1.0 accuracy, 62mm diameter, 62 × 15mm busbar window, and 2.5–15 VA rating</strong>.</p>
<p>Current Transformers are used to transform a higher primary current into a proportional secondary current that can be measured by compatible meters and electrical monitoring equipment. The <strong>600/5A current ratio</strong> provides a 5A secondary output corresponding to the specified 600A primary rating under the applicable operating conditions.</p>
<p>The <strong>62mm diameter</strong> and <strong>62 × 15mm busbar window</strong> provide a defined physical opening for compatible conductors or busbars. Before installation, the dimensions of the conductor or busbar should be checked to ensure that they are compatible with the CT opening.</p>
<p>The CT has overall dimensions of <strong>110 × 60 × 40mm (H × L × W)</strong>. Its encapsulated square-type construction provides a compact configuration for suitable electrical panels, metering systems, monitoring equipment, and distribution installations.</p>
<p>The specified <strong>2.5–15 VA rating</strong> should also be considered when selecting this CT. The connected meter, secondary wiring, and other devices contribute to the total secondary burden, so the CT should be selected according to the requirements of the complete measurement circuit.</p>
<hr />
<h1>Key Features</h1>
<p>The 600/5A 62mm Current Transformer offers the following features:</p>
<ul>
<li><strong>600/5A current ratio</strong></li>
<li><strong>600A primary current</strong></li>
<li><strong>5A secondary current</strong></li>
<li><strong>Class 1.0 accuracy</strong></li>
<li><strong>62mm diameter</strong></li>
<li><strong>62 × 15mm busbar window</strong></li>
<li><strong>2.5–15 VA rating</strong></li>
<li>Encapsulated square-type construction</li>
<li><strong>110 × 60 × 40mm dimensions</strong></li>
<li>Suitable for compatible metering systems</li>
<li>Suitable for electrical current measurement</li>
<li>Suitable for current monitoring</li>
<li>Suitable for electrical panels</li>
<li>Suitable for compatible distribution equipment</li>
</ul>
<hr />
<h1>Technical Specifications</h1>
<table>
<thead>
<tr>
<th>Parameter</th>
<th>Specification</th>
</tr>
</thead>
<tbody>
<tr>
<td><strong>Product Type</strong></td>
<td>Current Transformer</td>
</tr>
<tr>
<td><strong>CT Type</strong></td>
<td>Encapsulated Square Type</td>
</tr>
<tr>
<td><strong>Primary Current</strong></td>
<td>600A</td>
</tr>
<tr>
<td><strong>Secondary Current</strong></td>
<td>5A</td>
</tr>
<tr>
<td><strong>Current Ratio</strong></td>
<td>600/5A</td>
</tr>
<tr>
<td><strong>Accuracy Class</strong></td>
<td>Class 1.0</td>
</tr>
<tr>
<td><strong>Diameter</strong></td>
<td>62mm</td>
</tr>
<tr>
<td><strong>Busbar Window</strong></td>
<td>62 × 15mm</td>
</tr>
<tr>
<td><strong>Dimensions (H × L × W)</strong></td>
<td>110 × 60 × 40mm</td>
</tr>
<tr>
<td><strong>VA Rating</strong></td>
<td>2.5–15 VA</td>
</tr>
<tr>
<td><strong>Application</strong></td>
<td>Metering &amp; Current Measurement</td>
</tr>
</tbody>
</table>
<hr />
<h1>600/5A Current Transformer for Metering</h1>
<p>The <strong>600/5A Current Transformer</strong> is designed for applications where electrical current needs to be measured through a compatible 5A secondary measurement circuit.</p>
<p>The CT has a <strong>600A primary current and 5A secondary current</strong>, providing a defined <strong>600/5A current ratio</strong> for compatible electrical meters and monitoring equipment.</p>
<p>The secondary side can be connected to suitable energy meters, current meters, monitoring instruments, and other measurement equipment designed for a 5A CT input.</p>
<p>When selecting the CT, the required primary current, secondary input, accuracy class, burden, conductor dimensions, and connected equipment should all be checked.</p>
<p>The correct CT ratio should also be configured in compatible metering equipment where CT-ratio programming is required.</p>
<hr />
<h1>62mm Diameter and 62 × 15mm Busbar Window</h1>
<p>This Current Transformer features a <strong>62mm diameter</strong> and a <strong>62 × 15mm busbar window</strong>.</p>
<p>The window dimensions are important because the conductor or busbar passing through the CT must physically fit within the available opening.</p>
<p>Before ordering or installing the CT, check:</p>
<ul>
<li>Busbar width</li>
<li>Busbar thickness</li>
<li>Conductor dimensions</li>
<li>Available clearance</li>
<li>Panel space</li>
<li>CT mounting arrangement</li>
<li>Cable routing</li>
<li>Connected meter requirements</li>
</ul>
<p>The <strong>62 × 15mm busbar window</strong> provides a defined opening for compatible busbar installations.</p>
<hr />
<h1>Class 1.0 Accuracy</h1>
<p>The <strong>600/5A 62mm Current Transformer is specified as Class 1.0</strong>.</p>
<p>Accuracy class is an important specification when selecting a Current Transformer for metering and measurement applications. The required accuracy class should be selected according to the requirements of the connected measurement equipment.</p>
<p>The Class 1.0 specification makes this CT suitable for compatible metering and current measurement applications where Class 1.0 accuracy is required.</p>
<p>Actual CT performance depends on the applicable operating conditions, connected burden, installation conditions, and other system requirements.</p>
<hr />
<h1>2.5–15 VA Rating</h1>
<p>The 600/5A 62mm CT has a specified <strong>2.5–15 VA rating</strong>.</p>
<p>The VA rating is associated with the burden connected to the CT secondary circuit. The connected meter, secondary wiring, and other measurement devices should be considered when calculating the total secondary burden.</p>
<p>For correct selection, verify that the connected secondary burden is compatible with the specified <strong>2.5–15 VA</strong> rating.</p>
<p>This specification allows the CT to be considered for compatible metering and monitoring circuits according to the requirements of the installation.</p>
<hr />
<h1>5A Secondary Current</h1>
<p>The secondary current of this Current Transformer is <strong>5A</strong>.</p>
<p>A 5A secondary configuration can be used with compatible energy meters, current meters, monitoring instruments, and other equipment designed for a 5A CT input.</p>
<p>Before connecting the CT secondary, confirm that the connected equipment is designed for a <strong>5A CT secondary</strong>.</p>
<p>The <strong>600/5A ratio</strong> should also be correctly accounted for when configuring compatible metering equipment.</p>
<hr />
<h1>Compact 110 × 60 × 40mm Construction</h1>
<p>The overall dimensions of this Current Transformer are:</p>
<p><strong>110 × 60 × 40mm (H × L × W)</strong></p>
<p>These dimensions should be considered when planning installation inside an electrical panel or other equipment.</p>
<p>Adequate space should be provided for:</p>
<ul>
<li>CT body</li>
<li>Primary conductor or busbar</li>
<li>Secondary connections</li>
<li>Wiring</li>
<li>Mounting</li>
<li>Required clearances</li>
</ul>
<p>The <strong>62mm diameter</strong> and <strong>62 × 15mm busbar window</strong> should also be checked against the actual conductor or busbar dimensions.</p>
<hr />
<h1>Applications</h1>
<p>The 600/5A 62mm Current Transformer can be considered for compatible applications including:</p>
<ul>
<li>Energy metering systems</li>
<li>Electrical current measurement</li>
<li>Distribution panels</li>
<li>Electrical control panels</li>
<li>Metering panels</li>
<li>Power monitoring systems</li>
<li>Industrial electrical installations</li>
<li>Electrical monitoring equipment</li>
<li>Current monitoring systems</li>
<li>Distribution equipment</li>
<li>Energy measurement applications</li>
<li>Electrical load monitoring</li>
<li>Compatible panel metering systems</li>
</ul>
<p>The actual suitability of the CT depends on the electrical and mechanical requirements of the installation.</p>
<hr />
<h1>Benefits of 600/5A Current Transformer</h1>
<h2>600/5A Current Ratio</h2>
<p>The <strong>600/5A ratio</strong> provides a defined 5A secondary configuration for compatible measurement equipment designed for this CT ratio.</p>
<h2>Class 1.0 Accuracy</h2>
<p>The Class 1.0 specification makes the CT suitable for compatible metering and current measurement applications requiring this accuracy class.</p>
<h2>62mm Diameter</h2>
<p>The <strong>62mm diameter</strong> provides a defined opening for compatible conductors and busbars.</p>
<h2>62 × 15mm Busbar Window</h2>
<p>The specified <strong>62 × 15mm busbar window</strong> provides a defined physical opening for compatible busbar installations.</p>
<h2>5A Secondary</h2>
<p>The 5A secondary configuration is suitable for compatible meters and measurement equipment designed for a 5A CT input.</p>
<h2>2.5–15 VA Rating</h2>
<p>The specified <strong>2.5–15 VA rating</strong> allows the CT to be considered for compatible secondary metering circuits according to the connected burden.</p>
<h2>Compact Dimensions</h2>
<p>The <strong>110 × 60 × 40mm</strong> dimensions provide a defined compact form factor for compatible electrical panel installations.</p>
<hr />
<h1>600/5A CT for Electrical Panels</h1>
<p>The <strong>600/5A 62mm Current Transformer</strong> can be considered for electrical panels where compatible current measurement and monitoring are required.</p>
<p>Before selecting the CT, verify:</p>
<ul>
<li><strong>Primary Current:</strong> 600A</li>
<li><strong>Secondary Current:</strong> 5A</li>
<li><strong>Current Ratio:</strong> 600/5A</li>
<li><strong>Accuracy Class:</strong> Class 1.0</li>
<li><strong>Diameter:</strong> 62mm</li>
<li><strong>Busbar Window:</strong> 62 × 15mm</li>
<li><strong>Dimensions:</strong> 110 × 60 × 40mm</li>
<li><strong>VA Rating:</strong> 2.5–15 VA</li>
</ul>
<p>The conductor or busbar should also be checked against the CT window before installation.</p>
<hr />
<h1>Installation Considerations</h1>
<p>Before installing the 600/5A Current Transformer, verify the complete electrical and mechanical requirements.</p>
<h3>Check the Primary Current</h3>
<p>Confirm that the <strong>600A primary rating</strong> is appropriate for the intended electrical system.</p>
<h3>Check the Secondary Equipment</h3>
<p>Confirm that the connected meter or measurement device supports a <strong>5A CT secondary</strong>.</p>
<h3>Check the Busbar Window</h3>
<p>Ensure that the conductor or busbar fits within the <strong>62 × 15mm window</strong>.</p>
<h3>Check Accuracy Class</h3>
<p>Verify that <strong>Class 1.0</strong> meets the requirements of the intended metering application.</p>
<h3>Check Burden</h3>
<p>Confirm that the connected secondary burden is compatible with the specified <strong>2.5–15 VA</strong> rating.</p>
<h3>Check Physical Space</h3>
<p>Ensure sufficient space is available for the <strong>110 × 60 × 40mm</strong> CT and its secondary wiring.</p>
<p>Installation should be performed by appropriately qualified electrical personnel using suitable electrical safety procedures.</p>
<hr />
<h1>Why Choose the 600/5A 62mm Metering CT?</h1>
<p>The <strong>600/5A 62mm Current Transformer</strong> combines a <strong>600A primary rating, 5A secondary, Class 1.0 accuracy, 62mm diameter, 62 × 15mm busbar window, 2.5–15 VA rating, and 110 × 60 × 40mm dimensions</strong> in an encapsulated square-type configuration.</p>
<p>These specifications make it suitable for consideration in compatible metering, current measurement, monitoring, and electrical panel applications.</p>
<p>The defined physical dimensions also allow the user to check compatibility with the available panel space and conductor or busbar arrangement before installation.</p>
<p>For electrical contractors, panel builders, distributors, industrial users, and bulk buyers, the required CT ratio, quantity, and application should be confirmed before ordering.</p>
<hr />
<h1>MVG Power Solutions – Current Transformer Supplier</h1>
<p><strong>MVG Power Solutions</strong> supplies Current Transformers and electrical measurement products for different metering and monitoring requirements.</p>
<p>The CT product range includes different current ratios, window sizes, dimensions, construction types, accuracy classes, and VA ratings.</p>
<p>The <strong>600/5A 62mm Class 1.0 Current Transformer</strong> is specified with a <strong>600A primary, 5A secondary, 62mm diameter, 62 × 15mm busbar window, 110 × 60 × 40mm dimensions, and 2.5–15 VA rating</strong>.</p>
<p>For bulk requirements, electrical contractors, panel builders, distributors, and industrial customers can contact MVG Power Solutions with the required CT ratio, quantity, and application details.</p>
<hr />
<h1>Product Summary</h1>
<p>The <strong>600/5A 62mm Current Transformer | Class 1.0 Metering CT</strong> is an encapsulated square-type Current Transformer designed for compatible electrical metering, current measurement, and monitoring applications.</p>
<p>It features a <strong>600A primary current, 5A secondary current, 600/5A current ratio, Class 1.0 accuracy, 62mm diameter, 62 × 15mm busbar window, 2.5–15 VA rating, and 110 × 60 × 40mm dimensions</strong>.</p>
<p>The CT can be considered for compatible electrical panels, energy metering systems, distribution equipment, current monitoring systems, and electrical measurement applications.</p>
<p>Before ordering, verify the CT ratio, accuracy class, secondary current, burden, window size, dimensions, and connected equipment requirements.</p>
<hr />
<h1>Frequently Asked Questions</h1>
<h3>What is the current ratio of the 600/5A CT?</h3>
<p>The current ratio is <strong>600/5A</strong>, with a 600A primary current and 5A secondary current.</p>
<h3>What is the primary current?</h3>
<p>The specified primary current is <strong>600A</strong>.</p>
<h3>What is the secondary current?</h3>
<p>The secondary current is <strong>5A</strong>.</p>
<h3>What is the accuracy class?</h3>
<p>The Current Transformer has a specified <strong>Class 1.0 accuracy</strong>.</p>
<h3>What is the diameter of the CT?</h3>
<p>The specified diameter is <strong>62mm</strong>.</p>
<h3>What is the busbar window size?</h3>
<p>The busbar window is <strong>62 × 15mm</strong>.</p>
<h3>What are the dimensions of the CT?</h3>
<p>The dimensions are <strong>110 × 60 × 40mm (H × L × W)</strong>.</p>
<h3>What is the VA rating?</h3>
<p>The specified VA rating is <strong>2.5–15 VA</strong>.</p>
<h3>Is this CT suitable for a 5A meter?</h3>
<p>Yes. The CT has a <strong>5A secondary</strong> and can be considered for compatible meters and measurement equipment designed for a 5A CT input.</p>
<h3>Where can this CT be used?</h3>
<p>It can be considered for compatible <strong>energy metering, current measurement, electrical monitoring, distribution panels, control panels, metering panels, and power monitoring applications</strong>.</p>
<h3>What should I check before purchasing?</h3>
<p>Check the <strong>current ratio, accuracy class, secondary current, diameter, busbar window, dimensions, VA rating, and connected meter compatibility</strong> before purchasing.</p>
<hr />
<h1>Shipping &amp; Bulk Orders</h1>
<p>For bulk requirements, customers can contact <strong>MVG Power Solutions</strong> with the required quantity and application details.</p>
<p>For quotations, provide:</p>
<ul>
<li>CT ratio</li>
<li>Accuracy class</li>
<li>Secondary current</li>
<li>Busbar window</li>
<li>Quantity</li>
<li>Application requirements</li>
</ul>
<p>Bulk requirements can be discussed according to the required product configuration and quantity.</p>', 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/600-5a-62mm-current-transformer-class-1-metering-ct.jpg', 0, 'published'),
(163, 2, 59, 1, '500/5A 62mm Current Transformer | Class 1.0 Metering CT', '500-5a-62mm-current-transformer', 'MVG-60-6215', 280.00, 280.00, 10, '85043100', 18.00, 'in_stock', '<ul>
<li data-section-id="1tv8pvn" data-start="307" data-end="338"><strong data-start="309" data-end="329">Primary Current:</strong> <strong data-start="330" data-end="338">500A</strong></li>
<li data-section-id="2dmbsl" data-start="339" data-end="370"><strong data-start="341" data-end="363">Secondary Current:</strong> <strong data-start="364" data-end="370">5A</strong></li>
<li data-section-id="1940ems" data-start="371" data-end="402"><strong data-start="373" data-end="391">Current Ratio:</strong> <strong data-start="392" data-end="402">500/5A</strong></li>
<li data-section-id="16yb7c0" data-start="403" data-end="438"><strong data-start="405" data-end="424">Accuracy Class:</strong> <strong data-start="425" data-end="438">Class 1.0</strong></li>
<li data-section-id="mam9ld" data-start="439" data-end="464"><strong data-start="441" data-end="454">Diameter:</strong> <strong data-start="455" data-end="464">62 mm</strong></li>
<li data-section-id="1gkohzw" data-start="465" data-end="500"><strong data-start="467" data-end="485">Busbar Window:</strong> <strong data-start="486" data-end="500">62 × 15 mm</strong></li>
<li data-section-id="d1g2i9" data-start="501" data-end="551"><strong data-start="503" data-end="530">Dimensions (H × L × W):</strong> <strong data-start="531" data-end="551">110 × 60 × 40 mm</strong></li>
<li data-section-id="10orlqj" data-start="552" data-end="582"><strong data-start="554" data-end="568">VA Rating:</strong> <strong data-start="569" data-end="582">2.5–15 VA</strong></li>
<li data-section-id="1qb0zja" data-start="583" data-end="617">Compact square-type construction</li>
<li data-section-id="18xu12i" data-start="618" data-end="642">Encapsulated CT design</li>
<li data-section-id="j6w5vl" data-start="643" data-end="690">Suitable for metering and current measurement</li>
<li data-section-id="1nf6c48" data-start="691" data-end="746">Suitable for electrical panels and monitoring systems</li>
<li data-section-id="1p1d179" data-start="747" data-end="811">Suitable for industrial and commercial electrical applications</li>
<li data-section-id="s9jpm1" data-start="812" data-end="869">Designed for compatible 5A secondary metering equipment</li>
</ul>', '<h1>500/5A 62mm Current Transformer | Class 1.0 Metering CT</h1>
<p>The <strong>500/5A 62mm Current Transformer (CT)</strong> from <strong>MVG Power Solutions</strong> is designed for electrical current measurement, metering, monitoring, and compatible electrical panel applications. Featuring a <strong>500A primary current, 5A secondary current, Class 1.0 accuracy</strong>, and a <strong>62mm diameter/window</strong>, this Current Transformer provides a practical solution for electrical systems requiring a 500/5A CT ratio.</p>
<p>A Current Transformer is used to transform a higher primary current into a lower standardized secondary current that can be connected to compatible meters, measuring instruments, monitoring equipment, and electrical systems. This model provides a <strong>500/5A current ratio</strong>, meaning a primary current of 500A corresponds to a secondary current of 5A under rated operating conditions.</p>
<p>The <strong>500/5A 62mm Current Transformer</strong> is suitable for compatible metering and current measurement applications where a 5A secondary input is required.</p>
<h2>Key Features</h2>
<p>The 500/5A 62mm Current Transformer offers practical features for electrical measurement and monitoring applications:</p>
<ul>
<li><strong>500/5A current ratio</strong></li>
<li><strong>500A primary current</strong></li>
<li><strong>5A secondary current</strong></li>
<li><strong>Class 1.0 accuracy</strong></li>
<li><strong>62mm diameter/window</strong></li>
<li><strong>62 × 15 mm busbar window</strong></li>
<li><strong>2.5–15 VA rating</strong></li>
<li><strong>110 × 60 × 40 mm dimensions</strong></li>
<li>Encapsulated square-type construction</li>
<li>Compact CT design</li>
<li>Suitable for metering applications</li>
<li>Suitable for current measurement and monitoring</li>
<li>Suitable for compatible electrical panels and systems</li>
</ul>
<h2>Technical Specifications</h2>
<table>
<thead>
<tr>
<th>Parameter</th>
<th>Specification</th>
</tr>
</thead>
<tbody>
<tr>
<td>Product Type</td>
<td>Current Transformer</td>
</tr>
<tr>
<td>CT Type</td>
<td>Encapsulated Square Type</td>
</tr>
<tr>
<td>Primary Current</td>
<td>500A</td>
</tr>
<tr>
<td>Secondary Current</td>
<td>5A</td>
</tr>
<tr>
<td>Current Ratio</td>
<td>500/5A</td>
</tr>
<tr>
<td>Accuracy Class</td>
<td>Class 1.0</td>
</tr>
<tr>
<td>Diameter / Window</td>
<td>62 mm</td>
</tr>
<tr>
<td>Busbar Window</td>
<td>62 × 15 mm</td>
</tr>
<tr>
<td>Dimensions (H × L × W)</td>
<td>110 × 60 × 40 mm</td>
</tr>
<tr>
<td>VA Rating</td>
<td>2.5–15 VA</td>
</tr>
<tr>
<td>Application</td>
<td>Metering &amp; Current Measurement</td>
</tr>
</tbody>
</table>
<h2>Product Overview</h2>
<p>The <strong>500/5A 62mm Current Transformer</strong> is a <strong>Class 1.0 metering-class CT</strong> designed for suitable electrical current measurement and monitoring applications. It features a <strong>500A primary current</strong> and <strong>5A secondary current</strong>, providing a standardized secondary output for compatible metering and measurement equipment.</p>
<p>The encapsulated square-type construction provides a practical configuration for installation in compatible electrical panels and measurement systems. The larger <strong>62mm window</strong> provides an opening for suitable conductors or busbars according to the requirements of the electrical installation.</p>
<p>This CT features a <strong>62mm diameter/window</strong> and a <strong>62 × 15 mm busbar window</strong>, allowing installation around compatible conductors or busbars. Before installation, the conductor or busbar dimensions should be checked against the available CT opening.</p>
<p>With <strong>Class 1.0 accuracy</strong>, this Current Transformer is designed for suitable metering and current measurement applications where the specified accuracy class is required. Its <strong>2.5–15 VA rating</strong> provides a specified burden range for compatible metering circuits based on the connected secondary load and system requirements.</p>
<p>The overall dimensions of <strong>110 × 60 × 40 mm (H × L × W)</strong> provide a defined form factor for compatible electrical panels, distribution equipment, monitoring systems, and other suitable installations.</p>
<h2>500/5A Current Transformer for Metering</h2>
<p>The <strong>500/5A CT</strong> is designed for applications where the primary current requirement is <strong>500A</strong> and the connected measuring equipment requires a <strong>5A secondary current</strong>.</p>
<p>The <strong>Class 1.0 accuracy</strong> makes this CT suitable for compatible metering and current measurement applications requiring the specified accuracy class.</p>
<p>The 5A secondary can be connected to compatible energy meters, panel meters, current measuring instruments, monitoring devices, and other electrical equipment designed for a 5A CT secondary.</p>
<p>When selecting a Current Transformer, the current ratio, accuracy class, burden, secondary current, physical dimensions, and window size should be checked against the requirements of the intended electrical installation.</p>
<h2>Applications</h2>
<p>The <strong>500/5A Class 1.0 Current Transformer</strong> can be used in compatible electrical measurement and monitoring applications, including:</p>
<ul>
<li>Energy metering systems</li>
<li>Electrical current measurement</li>
<li>Distribution panels</li>
<li>Electrical control panels</li>
<li>Power monitoring systems</li>
<li>Metering panels</li>
<li>Industrial electrical installations</li>
<li>Commercial electrical systems</li>
<li>Electrical monitoring equipment</li>
<li>Current monitoring systems</li>
<li>Load monitoring applications</li>
<li>Compatible energy measurement applications</li>
</ul>
<p>The CT should be selected according to the required primary current, secondary current, accuracy, burden, physical dimensions, window size, and electrical installation requirements.</p>
<h2>62mm Window and Busbar Design</h2>
<p>The Current Transformer features a <strong>62mm diameter/window</strong> along with a <strong>62 × 15 mm busbar window</strong>.</p>
<p>This opening is designed for compatible conductors and busbars. Before installation, users should verify the actual conductor or busbar dimensions and ensure that they are suitable for the CT opening.</p>
<p>The <strong>110 × 60 × 40 mm</strong> overall dimensions provide a defined form factor for compatible electrical panel installations.</p>
<h2>Class 1.0 Accuracy</h2>
<p>Accuracy class is an important specification when selecting a Current Transformer for metering and measurement applications.</p>
<p>The <strong>Class 1.0</strong> rating identifies the specified accuracy class of this CT under its applicable rated conditions. The <strong>500/5A ratio</strong> provides a 5A secondary output corresponding to a 500A primary current under rated operating conditions.</p>
<p>The CT should be selected according to the requirements of the electrical system and the specifications of the connected measuring equipment.</p>
<h2>2.5–15 VA Rating</h2>
<p>The <strong>500/5A 62mm Current Transformer</strong> has a specified <strong>2.5–15 VA rating</strong>.</p>
<p>VA rating relates to the burden connected to the CT secondary circuit, including compatible meters, measuring instruments, and associated wiring.</p>
<p>When selecting a Current Transformer, the connected secondary load should be considered to ensure that the CT is suitable for the intended metering circuit.</p>
<h2>Standard 5A Secondary</h2>
<p>The <strong>5A secondary current</strong> is suitable for compatible conventional CT meters, energy meters, panel meters, and electrical measuring equipment designed for a 5A CT input.</p>
<p>For this product, the rated ratio is <strong>500/5A</strong>. Under rated operating conditions, a 500A primary current corresponds to a 5A secondary current.</p>
<p>The secondary circuit should always be connected to compatible equipment and installed according to appropriate electrical installation and safety practices.</p>
<h2>Benefits of 500/5A Current Transformer</h2>
<h3>Accurate Current Measurement</h3>
<p>The <strong>Class 1.0 accuracy</strong> makes this CT suitable for compatible applications requiring the specified metering accuracy.</p>
<h3>Standard 5A Secondary</h3>
<p>The <strong>5A secondary output</strong> is suitable for compatible meters and current measurement equipment designed for a 5A CT secondary.</p>
<h3>62mm Window</h3>
<p>The <strong>62mm diameter/window</strong> provides a larger opening compared with smaller CT configurations and can accommodate compatible conductors or busbars within the specified dimensions.</p>
<h3>62 × 15 mm Busbar Window</h3>
<p>The <strong>62 × 15 mm busbar window</strong> provides a defined opening for compatible busbar installations.</p>
<h3>Versatile Metering Applications</h3>
<p>The CT can be used in compatible energy metering, electrical monitoring, current measurement, and distribution-panel applications.</p>
<h2>500/5A CT for Electrical Panels</h2>
<p>The <strong>500/5A 62mm Current Transformer</strong> can be integrated into compatible electrical panels, metering systems, and current monitoring equipment.</p>
<p>Potential compatible equipment includes:</p>
<ul>
<li>Panel meters</li>
<li>Energy meters</li>
<li>Current meters</li>
<li>Power monitoring equipment</li>
<li>Electrical monitoring devices</li>
<li>Metering panels</li>
<li>Control panels</li>
<li>Distribution panels</li>
</ul>
<p>Before installation, verify that the connected equipment requires a <strong>5A CT secondary</strong> and that the CT window and overall dimensions are suitable for the intended application.</p>
<h2>Installation Considerations</h2>
<p>Before installing the <strong>500/5A Current Transformer</strong>, verify the electrical and mechanical requirements of the application.</p>
<p>Important parameters to check include:</p>
<ol>
<li>Primary current requirement</li>
<li>Secondary current requirement</li>
<li>Current ratio</li>
<li>Accuracy class</li>
<li>Connected burden</li>
<li>Conductor or busbar dimensions</li>
<li>CT window size</li>
<li>Available installation space</li>
<li>Meter compatibility</li>
<li>Electrical system requirements</li>
</ol>
<p>The Current Transformer should be installed by a qualified electrical professional following applicable electrical installation practices and the requirements of the connected equipment.</p>
<h2>Why Choose the 500/5A 62mm Current Transformer?</h2>
<p>The <strong>500/5A 62mm Class 1.0 Metering CT</strong> combines:</p>
<ul>
<li><strong>500A primary current</strong></li>
<li><strong>5A secondary current</strong></li>
<li><strong>500/5A current ratio</strong></li>
<li><strong>Class 1.0 accuracy</strong></li>
<li><strong>62mm diameter/window</strong></li>
<li><strong>62 × 15 mm busbar window</strong></li>
<li><strong>110 × 60 × 40 mm dimensions</strong></li>
<li><strong>2.5–15 VA rating</strong></li>
<li>Encapsulated square-type construction</li>
<li>Suitable for metering and current measurement</li>
<li>Suitable for electrical panels and monitoring systems</li>
</ul>
<p>These specifications make the CT suitable for compatible electrical measurement, metering, monitoring, and panel applications requiring a <strong>500/5A Current Transformer</strong>.</p>
<h2>MVG Power Solutions – Current Transformer Supplier</h2>
<p><strong>MVG Power Solutions</strong> supplies Current Transformers and electrical measurement products for industrial, commercial, metering, panel-building, monitoring, and electrical distribution applications.</p>
<p>The <strong>500/5A 62mm Class 1.0 Metering Current Transformer</strong> is designed for applications requiring a <strong>500A primary current, 5A secondary output, 62mm window, 62 × 15 mm busbar opening, and Class 1.0 accuracy</strong>.</p>
<p>For bulk requirements, technical specifications, product availability, or quotations, contact MVG Power Solutions with your required quantity and application details.</p>
<h2>Product Summary</h2>
<p>The <strong>500/5A 62mm Current Transformer | Class 1.0 Metering CT</strong> features a <strong>500A primary current, 5A secondary current, Class 1.0 accuracy, 62mm diameter/window, 62 × 15 mm busbar window, 2.5–15 VA rating, and 110 × 60 × 40 mm dimensions</strong>.</p>
<p>It is designed for compatible <strong>electrical metering, current measurement, power monitoring, electrical panels, distribution systems, control panels, and industrial and commercial applications</strong> requiring a 500/5A Current Transformer.</p>
<h2>Frequently Asked Questions</h2>
<h3>What is the current ratio of this CT?</h3>
<p>The current ratio is <strong>500/5A</strong>, with a 500A primary current and 5A secondary current.</p>
<h3>What is the accuracy class?</h3>
<p>The Current Transformer has <strong>Class 1.0 accuracy</strong> as specified for this product.</p>
<h3>What is the secondary current?</h3>
<p>The secondary current is <strong>5A</strong>.</p>
<h3>What is the CT diameter?</h3>
<p>The specified diameter/window is <strong>62 mm</strong>.</p>
<h3>What is the busbar window size?</h3>
<p>The busbar window is <strong>62 × 15 mm</strong>.</p>
<h3>What are the dimensions?</h3>
<p>The dimensions are <strong>110 × 60 × 40 mm (H × L × W)</strong>.</p>
<h3>What is the VA rating?</h3>
<p>The specified VA rating is <strong>2.5–15 VA</strong>.</p>
<h3>Where can the 500/5A Current Transformer be used?</h3>
<p>It can be used in compatible metering, current measurement, electrical monitoring, distribution panels, control panels, and energy monitoring systems, subject to the electrical requirements of the installation.</p>', 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/500-5a-62mm-current-transformer-class-1-metering-ct.jpg', 0, 'published'),
(160, 2, 59, 1, '600/5A 42mm Current Transformer | Class 1.0 Metering CT', '600-5a-42mm-current-transformer', 'MVG-40-4210-1-1-1-1', 280.00, 280.00, 10, '85043100', 18.00, 'in_stock', '<ul data-start="82" data-end="643">
<li data-section-id="1ryo3q8" data-start="82" data-end="113"><strong data-start="84" data-end="104">Primary Current:</strong> <strong data-start="105" data-end="113">600A</strong></li>
<li data-section-id="2dmbsl" data-start="114" data-end="145"><strong data-start="116" data-end="138">Secondary Current:</strong> <strong data-start="139" data-end="145">5A</strong></li>
<li data-section-id="98pc6v" data-start="146" data-end="177"><strong data-start="148" data-end="166">Current Ratio:</strong> <strong data-start="167" data-end="177">600/5A</strong></li>
<li data-section-id="16yb7c0" data-start="178" data-end="213"><strong data-start="180" data-end="199">Accuracy Class:</strong> <strong data-start="200" data-end="213">Class 1.0</strong></li>
<li data-section-id="1h9uuxf" data-start="214" data-end="239"><strong data-start="216" data-end="229">Diameter:</strong> <strong data-start="230" data-end="239">42 mm</strong></li>
<li data-section-id="4q9ph5" data-start="240" data-end="275"><strong data-start="242" data-end="260">Busbar Window:</strong> <strong data-start="261" data-end="275">42 × 12 mm</strong></li>
<li data-section-id="1m8s0x8" data-start="276" data-end="325"><strong data-start="278" data-end="305">Dimensions (H × L × W):</strong> <strong data-start="306" data-end="325">78 × 60 × 35 mm</strong></li>
<li data-section-id="10orlqj" data-start="326" data-end="356"><strong data-start="328" data-end="342">VA Rating:</strong> <strong data-start="343" data-end="356">2.5–15 VA</strong></li>
<li data-section-id="1qb0zja" data-start="357" data-end="391">Compact square-type construction</li>
<li data-section-id="18xu12i" data-start="392" data-end="416">Encapsulated CT design</li>
<li data-section-id="j6w5vl" data-start="417" data-end="464">Suitable for metering and current measurement</li>
<li data-section-id="1nf6c48" data-start="465" data-end="520">Suitable for electrical panels and monitoring systems</li>
<li data-section-id="1p1d179" data-start="521" data-end="585">Suitable for industrial and commercial electrical applications</li>
<li data-section-id="s9jpm1" data-start="586" data-end="643">Designed for compatible 5A secondary metering equipment</li>
</ul>
<div class="group relative clear-both my-4 w-full overflow-visible z-1" data-writing-block-fullscreen-fallback-target="inline">
<div id="writing-block-c2cb2ff4-7c35-427d-ab14-15844159653b" class="group/writing-block-surface relative isolate w-full min-w-0 overflow-clip rounded-[var(--oai-wb-radius)] [box-shadow:var(--oai-wb-shadow)] [color:var(--oai-wb-text-primary)] [contain:inline-size] [font-family:var(--oai-wb-font-sans)] [--wb-text-primary:var(--text-primary)] [--wb-text-secondary:var(--text-secondary)] [--wb-text-tertiary:var(--text-tertiary)] [--wb-surface-primary:var(--bg-primary)] [--wb-surface-secondary:var(--bg-tertiary)] [--wb-border:rgb(0_0_0/7%)] [--wb-border-hover:rgb(0_0_0/7%)] [--wb-divider:var(--border-light)] [--wb-focus:var(--border-strong)] [--wb-control-border:var(--interactive-border-focus)] [--wb-entity-accent:var(--theme-entity-accent)] [--wb-accent:var(--interactive-label-accent-default)] [--wb-on-accent:var(--bg-primary)] [--wb-interactive-background:var(--interactive-bg-accent-default)] [--wb-selection:var(--theme-user-selection-bg,var(--selection))] [--wb-radius-sm:var(--radius-sm)] [--wb-shadow-lg:var(--shadow-lg)] [--wb-font-sans:var(--font-sans)] [--wb-font-mono:var(--font-mono)] [--wb-shimmer-dark-contrast:var(--gray-550)] [--wb-shimmer-dark-secondary:var(--text-tertiary)] [--wb-radius:24px] [--wb-shadow:0_4px_80px_rgb(0_0_0/2%)] [contain:none]" data-oai-writing-block-surface="" data-writing-block="true" data-testid="writing-block-container">
<div class="pointer-events-none absolute inset-0 rounded-[inherit] z-[-1] [background:var(--oai-wb-surface-primary)] bg-token-bg-primary! dark:bg-[#2a2a2a]!" data-writing-block-fullscreen-shell-surface="true" aria-hidden="true"></div>
<div class="relative z-[1]">
<div class="z-1 relative md:sticky md:top-(--sticky-padding-top)" data-testid="writing-block-header-sticky-container">
<div class="relative isolate flex w-full items-center justify-between gap-3 font-sans py-2.5 pe-3 sm:pe-1" data-testid="writing-block-header-surface">
<div class="bg-token-bg-primary pointer-events-none absolute inset-0 -z-1 dark:bg-[#2a2a2a]" aria-hidden="true" data-writing-block-fullscreen-header-surface="true"></div>
<div class="relative z-1 flex w-full items-center justify-between gap-3" data-writing-block-fullscreen-header-chrome="true" data-writing-block-fullscreen-header-layout="inline">
<div class="flex min-w-0 grow gap-3 items-center">
<div class="flex min-w-0 grow cursor-default items-center self-center max-w-[75%] text-token-text-tertiary text-sm font-medium">
<div class="min-w-0 truncate"></div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>', '<h1>600/5A 42mm Current Transformer | Class 1.0 Metering CT</h1>
<p>The <strong>600/5A 42mm Current Transformer (CT)</strong> from <strong>MVG Power Solutions</strong> is designed for electrical current measurement, metering, monitoring, and compatible electrical panel applications. Featuring a <strong>600A primary current, 5A secondary current, Class 1.0 accuracy</strong>, and a <strong>42mm diameter/window</strong>, this Current Transformer provides a practical solution for electrical systems requiring a 600/5A CT ratio.</p>
<p>A Current Transformer is used to transform a higher primary current into a lower standardized secondary current that can be connected to compatible meters, measuring instruments, monitoring equipment, and electrical systems. This model provides a <strong>600/5A current ratio</strong>, meaning a primary current of 600A corresponds to a secondary current of 5A under rated operating conditions.</p>
<p>The <strong>600/5A 42mm Current Transformer</strong> is suitable for compatible metering and current measurement applications where a 5A secondary input is required.</p>
<h2>Key Features</h2>
<p>The 600/5A 42mm Current Transformer offers practical features for electrical measurement and monitoring applications:</p>
<ul>
<li><strong>600/5A current ratio</strong></li>
<li><strong>600A primary current</strong></li>
<li><strong>5A secondary current</strong></li>
<li><strong>Class 1.0 accuracy</strong></li>
<li><strong>42mm diameter/window</strong></li>
<li><strong>42 × 12 mm busbar window</strong></li>
<li><strong>2.5–15 VA rating</strong></li>
<li><strong>78 × 60 × 35 mm dimensions</strong></li>
<li>Encapsulated square-type construction</li>
<li>Compact CT design</li>
<li>Suitable for metering applications</li>
<li>Suitable for current measurement and monitoring</li>
<li>Suitable for compatible electrical panels and systems</li>
</ul>
<h2>Technical Specifications</h2>
<table>
<thead>
<tr>
<th>Parameter</th>
<th>Specification</th>
</tr>
</thead>
<tbody>
<tr>
<td>Product Type</td>
<td>Current Transformer</td>
</tr>
<tr>
<td>CT Type</td>
<td>Encapsulated Square Type</td>
</tr>
<tr>
<td>Primary Current</td>
<td>600A</td>
</tr>
<tr>
<td>Secondary Current</td>
<td>5A</td>
</tr>
<tr>
<td>Current Ratio</td>
<td>600/5A</td>
</tr>
<tr>
<td>Accuracy Class</td>
<td>Class 1.0</td>
</tr>
<tr>
<td>Diameter / Window</td>
<td>42 mm</td>
</tr>
<tr>
<td>Busbar Window</td>
<td>42 × 12 mm</td>
</tr>
<tr>
<td>Dimensions (H × L × W)</td>
<td>78 × 60 × 35 mm</td>
</tr>
<tr>
<td>VA Rating</td>
<td>2.5–15 VA</td>
</tr>
<tr>
<td>Application</td>
<td>Metering &amp; Current Measurement</td>
</tr>
</tbody>
</table>
<h2>Product Overview</h2>
<p>The <strong>600/5A 42mm Current Transformer</strong> is a compact <strong>Class 1.0 metering-class CT</strong> designed for suitable electrical current measurement and monitoring applications. It features a <strong>600A primary current</strong> and <strong>5A secondary current</strong>, providing a standardized secondary output for compatible metering and measurement equipment.</p>
<p>The encapsulated square-type construction provides a practical configuration for installation in compatible electrical panels and measurement systems. The design is suitable for applications where a defined CT window and compact overall dimensions are required.</p>
<p>This CT features a <strong>42mm diameter/window</strong> and a <strong>42 × 12 mm busbar window</strong>, allowing installation around compatible conductors or busbars. Before installation, the conductor or busbar dimensions should be checked against the available CT opening.</p>
<p>With <strong>Class 1.0 accuracy</strong>, this Current Transformer is designed for suitable metering and current measurement applications where the specified accuracy class is required. Its <strong>2.5–15 VA rating</strong> provides a specified burden range for compatible metering circuits based on the connected secondary load and system requirements.</p>
<p>The overall dimensions of <strong>78 × 60 × 35 mm (H × L × W)</strong> provide a compact form factor for compatible electrical panels, distribution equipment, monitoring systems, and other suitable installations.</p>
<h2>600/5A Current Transformer for Metering</h2>
<p>The <strong>600/5A CT</strong> is designed for applications where the primary current requirement is 600A and the connected measuring equipment requires a 5A secondary current.</p>
<p>The <strong>Class 1.0 accuracy</strong> makes this CT suitable for compatible metering and current measurement applications requiring the specified accuracy class.</p>
<p>The 5A secondary can be connected to compatible energy meters, panel meters, current measuring instruments, monitoring devices, and other electrical equipment designed for a 5A CT secondary.</p>
<p>When selecting a Current Transformer, the current ratio, accuracy class, burden, secondary current, physical dimensions, and window size should be checked against the requirements of the intended electrical installation.</p>
<h2>Applications</h2>
<p>The <strong>600/5A Class 1.0 Current Transformer</strong> can be used in compatible electrical measurement and monitoring applications, including:</p>
<ul>
<li>Energy metering systems</li>
<li>Electrical current measurement</li>
<li>Distribution panels</li>
<li>Electrical control panels</li>
<li>Power monitoring systems</li>
<li>Metering panels</li>
<li>Industrial electrical installations</li>
<li>Commercial electrical systems</li>
<li>Electrical monitoring equipment</li>
<li>Current monitoring systems</li>
<li>Load monitoring applications</li>
<li>Compatible energy measurement applications</li>
</ul>
<p>The CT should be selected according to the required primary current, secondary current, accuracy, burden, physical dimensions, window size, and electrical installation requirements.</p>
<h2>42mm Window and Busbar Design</h2>
<p>The Current Transformer features a <strong>42mm diameter/window</strong> along with a <strong>42 × 12 mm busbar window</strong>.</p>
<p>This opening is designed for compatible conductors and busbars. Before installation, users should verify the actual conductor or busbar dimensions and ensure that they are suitable for the CT opening.</p>
<p>The <strong>78 × 60 × 35 mm</strong> overall dimensions provide a compact form factor for compatible electrical panel installations.</p>
<h2>Class 1.0 Accuracy</h2>
<p>Accuracy class is an important specification when selecting a Current Transformer for metering and measurement applications.</p>
<p>The <strong>Class 1.0</strong> rating identifies the specified accuracy class of this CT under its applicable rated conditions. The <strong>600/5A ratio</strong> provides a 5A secondary output corresponding to a 600A primary current under rated operating conditions.</p>
<p>The CT should be selected according to the requirements of the electrical system and the specifications of the connected measuring equipment.</p>
<h2>2.5–15 VA Rating</h2>
<p>The <strong>600/5A 42mm Current Transformer</strong> has a specified <strong>2.5–15 VA rating</strong>.</p>
<p>VA rating relates to the burden connected to the CT secondary circuit, including compatible meters, measuring instruments, and associated wiring.</p>
<p>When selecting a Current Transformer, the connected secondary load should be considered to ensure that the CT is suitable for the intended metering circuit.</p>
<h2>Standard 5A Secondary</h2>
<p>The <strong>5A secondary current</strong> is suitable for compatible conventional CT meters, energy meters, panel meters, and electrical measuring equipment designed for a 5A CT input.</p>
<p>For this product, the rated ratio is <strong>600/5A</strong>. Under rated operating conditions, a 600A primary current corresponds to a 5A secondary current.</p>
<p>The secondary circuit should always be connected to compatible equipment and installed according to appropriate electrical installation and safety practices.</p>
<h2>Benefits of 600/5A Current Transformer</h2>
<h3>Accurate Current Measurement</h3>
<p>The <strong>Class 1.0 accuracy</strong> makes this CT suitable for compatible applications requiring the specified metering accuracy.</p>
<h3>Standard 5A Secondary</h3>
<p>The <strong>5A secondary output</strong> is suitable for compatible meters and current measurement equipment designed for a 5A CT secondary.</p>
<h3>Compact Design</h3>
<p>The <strong>78 × 60 × 35 mm</strong> dimensions provide a compact form factor for compatible electrical panel installations.</p>
<h3>42mm Window</h3>
<p>The <strong>42mm diameter/window</strong> and <strong>42 × 12 mm busbar window</strong> provide a defined opening for compatible conductor and busbar installations.</p>
<h3>Versatile Metering Applications</h3>
<p>The CT can be used in compatible energy metering, electrical monitoring, current measurement, and distribution-panel applications.</p>
<h2>600/5A CT for Electrical Panels</h2>
<p>The <strong>600/5A 42mm Current Transformer</strong> can be integrated into compatible electrical panels, metering systems, and current monitoring equipment.</p>
<p>Potential compatible equipment includes:</p>
<ul>
<li>Panel meters</li>
<li>Energy meters</li>
<li>Current meters</li>
<li>Power monitoring equipment</li>
<li>Electrical monitoring devices</li>
<li>Metering panels</li>
<li>Control panels</li>
<li>Distribution panels</li>
</ul>
<p>Before installation, verify that the connected equipment requires a <strong>5A CT secondary</strong> and that the CT window and overall dimensions are suitable for the intended application.</p>
<h2>Installation Considerations</h2>
<p>Before installing the <strong>600/5A Current Transformer</strong>, verify the electrical and mechanical requirements of the application.</p>
<p>Important parameters to check include:</p>
<ol>
<li>Primary current requirement</li>
<li>Secondary current requirement</li>
<li>Current ratio</li>
<li>Accuracy class</li>
<li>Connected burden</li>
<li>Conductor or busbar dimensions</li>
<li>CT window size</li>
<li>Available installation space</li>
<li>Meter compatibility</li>
<li>Electrical system requirements</li>
</ol>
<p>The Current Transformer should be installed by a qualified electrical professional following applicable electrical installation practices and the requirements of the connected equipment.</p>
<h2>Why Choose the 600/5A 42mm Current Transformer?</h2>
<p>The <strong>600/5A 42mm Class 1.0 Metering CT</strong> combines:</p>
<ul>
<li><strong>600A primary current</strong></li>
<li><strong>5A secondary current</strong></li>
<li><strong>600/5A current ratio</strong></li>
<li><strong>Class 1.0 accuracy</strong></li>
<li><strong>42mm diameter/window</strong></li>
<li><strong>42 × 12 mm busbar window</strong></li>
<li><strong>78 × 60 × 35 mm dimensions</strong></li>
<li><strong>2.5–15 VA rating</strong></li>
<li>Encapsulated square-type construction</li>
<li>Compact design</li>
<li>Suitable for metering and current measurement</li>
<li>Suitable for electrical panels and monitoring systems</li>
</ul>
<p>These specifications make the CT suitable for compatible electrical measurement, metering, monitoring, and panel applications requiring a <strong>600/5A Current Transformer</strong>.</p>
<h2>MVG Power Solutions – Current Transformer Supplier</h2>
<p><strong>MVG Power Solutions</strong> supplies Current Transformers and electrical measurement products for industrial, commercial, metering, panel-building, monitoring, and electrical distribution applications.</p>
<p>The <strong>600/5A 42mm Class 1.0 Metering Current Transformer</strong> is designed for applications requiring a <strong>600A primary current, 5A secondary output, 42mm window, 42 × 12 mm busbar opening, and Class 1.0 accuracy</strong>.</p>
<p>For bulk requirements, technical specifications, product availability, or quotations, contact MVG Power Solutions with your required quantity and application details.</p>
<h2>Product Summary</h2>
<p>The <strong>600/5A 42mm Current Transformer | Class 1.0 Metering CT</strong> features a <strong>600A primary current, 5A secondary current, Class 1.0 accuracy, 42mm diameter/window, 42 × 12 mm busbar window, 2.5–15 VA rating, and 78 × 60 × 35 mm dimensions</strong>.</p>
<p>It is designed for compatible <strong>electrical metering, current measurement, power monitoring, electrical panels, distribution systems, control panels, and industrial and commercial applications</strong> requiring a 600/5A Current Transformer.</p>
<h2>Frequently Asked Questions</h2>
<h3>What is the current ratio of this CT?</h3>
<p>The current ratio is <strong>600/5A</strong>, with a 600A primary current and 5A secondary current.</p>
<h3>What is the accuracy class?</h3>
<p>The Current Transformer has <strong>Class 1.0 accuracy</strong> as specified for this product.</p>
<h3>What is the secondary current?</h3>
<p>The secondary current is <strong>5A</strong>.</p>
<h3>What is the CT diameter?</h3>
<p>The specified diameter/window is <strong>42 mm</strong>.</p>
<h3>What is the busbar window size?</h3>
<p>The busbar window is <strong>42 × 12 mm</strong>.</p>
<h3>What are the dimensions?</h3>
<p>The dimensions are <strong>78 × 60 × 35 mm (H × L × W)</strong>.</p>
<h3>What is the VA rating?</h3>
<p>The specified VA rating is <strong>2.5–15 VA</strong>.</p>
<h3>Where can the 600/5A Current Transformer be used?</h3>
<p>It can be used in compatible metering, current measurement, electrical monitoring, distribution panels, control panels, and energy monitoring systems, subject to the electrical requirements of the installation.</p>', 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/600-5a-42mm-current-transformer-class-1-metering-ct.jpg', 0, 'published'),
(156, 2, 59, 1, '500/5A 42mm Current Transformer | Class 1.0 Metering CT', '500-5a-42mm-current-transformer', 'MVG-40-4210-1-1-1', 280.00, 280.00, 10, '85043100', 18.00, 'in_stock', '<ul>
<li data-section-id="1tv8pvn" data-start="82" data-end="113"><strong data-start="84" data-end="104">Primary Current:</strong> <strong data-start="105" data-end="113">500A</strong></li>
<li data-section-id="2dmbsl" data-start="114" data-end="145"><strong data-start="116" data-end="138">Secondary Current:</strong> <strong data-start="139" data-end="145">5A</strong></li>
<li data-section-id="1940ems" data-start="146" data-end="177"><strong data-start="148" data-end="166">Current Ratio:</strong> <strong data-start="167" data-end="177">500/5A</strong></li>
<li data-section-id="16yb7c0" data-start="178" data-end="213"><strong data-start="180" data-end="199">Accuracy Class:</strong> <strong data-start="200" data-end="213">Class 1.0</strong></li>
<li data-section-id="1h9uuxf" data-start="214" data-end="239"><strong data-start="216" data-end="229">Diameter:</strong> <strong data-start="230" data-end="239">42 mm</strong></li>
<li data-section-id="4q9ph5" data-start="240" data-end="275"><strong data-start="242" data-end="260">Busbar Window:</strong> <strong data-start="261" data-end="275">42 × 12 mm</strong></li>
<li data-section-id="1m8s0x8" data-start="276" data-end="325"><strong data-start="278" data-end="305">Dimensions (H × L × W):</strong> <strong data-start="306" data-end="325">78 × 60 × 35 mm</strong></li>
<li data-section-id="10orlqj" data-start="326" data-end="356"><strong data-start="328" data-end="342">VA Rating:</strong> <strong data-start="343" data-end="356">2.5–15 VA</strong></li>
<li data-section-id="1qb0zja" data-start="357" data-end="391">Compact square-type construction</li>
<li data-section-id="18xu12i" data-start="392" data-end="416">Encapsulated CT design</li>
<li data-section-id="j6w5vl" data-start="417" data-end="464">Suitable for metering and current measurement</li>
<li data-section-id="1nf6c48" data-start="465" data-end="520">Suitable for electrical panels and monitoring systems</li>
<li data-section-id="1p1d179" data-start="521" data-end="585">Suitable for industrial and commercial electrical applications</li>
<li data-section-id="s9jpm1" data-start="586" data-end="643">Designed for compatible 5A secondary metering equipment</li>
</ul>', '<h1>500/5A 42mm Current Transformer | Class 1.0 Metering CT</h1>
<p>The <strong>500/5A 42mm Current Transformer (CT)</strong> from <strong>MVG Power Solutions</strong> is designed for electrical current measurement, metering, monitoring, and compatible electrical panel applications. Featuring a <strong>500A primary current, 5A secondary current, Class 1.0 accuracy</strong>, and a <strong>42mm diameter/window</strong>, this Current Transformer provides a practical solution for electrical systems requiring a 500/5A CT ratio.</p>
<p>A Current Transformer is used to transform a higher primary current into a lower standardized secondary current that can be connected to compatible meters, measuring instruments, monitoring equipment, and electrical systems. This model provides a <strong>500/5A current ratio</strong>, meaning a primary current of 500A corresponds to a secondary current of 5A under rated operating conditions.</p>
<p>The <strong>500/5A 42mm Current Transformer</strong> is suitable for compatible metering and current measurement applications where a 5A secondary input is required.</p>
<h2>Key Features</h2>
<p>The 500/5A 42mm Current Transformer offers practical features for electrical measurement and monitoring applications:</p>
<ul>
<li><strong>500/5A current ratio</strong></li>
<li><strong>500A primary current</strong></li>
<li><strong>5A secondary current</strong></li>
<li><strong>Class 1.0 accuracy</strong></li>
<li><strong>42mm diameter/window</strong></li>
<li><strong>42 × 12 mm busbar window</strong></li>
<li><strong>2.5–15 VA rating</strong></li>
<li><strong>78 × 60 × 35 mm dimensions</strong></li>
<li>Encapsulated square-type construction</li>
<li>Compact CT design</li>
<li>Suitable for metering applications</li>
<li>Suitable for current measurement and monitoring</li>
<li>Suitable for compatible electrical panels and systems</li>
</ul>
<h2>Technical Specifications</h2>
<table>
<thead>
<tr>
<th>Parameter</th>
<th>Specification</th>
</tr>
</thead>
<tbody>
<tr>
<td>Product Type</td>
<td>Current Transformer</td>
</tr>
<tr>
<td>CT Type</td>
<td>Encapsulated Square Type</td>
</tr>
<tr>
<td>Primary Current</td>
<td>500A</td>
</tr>
<tr>
<td>Secondary Current</td>
<td>5A</td>
</tr>
<tr>
<td>Current Ratio</td>
<td>500/5A</td>
</tr>
<tr>
<td>Accuracy Class</td>
<td>Class 1.0</td>
</tr>
<tr>
<td>Diameter / Window</td>
<td>42 mm</td>
</tr>
<tr>
<td>Busbar Window</td>
<td>42 × 12 mm</td>
</tr>
<tr>
<td>Dimensions (H × L × W)</td>
<td>78 × 60 × 35 mm</td>
</tr>
<tr>
<td>VA Rating</td>
<td>2.5–15 VA</td>
</tr>
<tr>
<td>Application</td>
<td>Metering &amp; Current Measurement</td>
</tr>
</tbody>
</table>
<h2>Product Overview</h2>
<p>The <strong>500/5A 42mm Current Transformer</strong> is a compact <strong>Class 1.0 metering-class CT</strong> designed for suitable electrical current measurement and monitoring applications. It features a <strong>500A primary current</strong> and <strong>5A secondary current</strong>, providing a standardized secondary output for compatible metering and measurement equipment.</p>
<p>The encapsulated square-type construction provides a practical configuration for installation in compatible electrical panels and measurement systems. The design is suitable for applications where a defined CT window and compact overall dimensions are required.</p>
<p>This CT features a <strong>42mm diameter/window</strong> and a <strong>42 × 12 mm busbar window</strong>, allowing installation around compatible conductors or busbars. Before installation, the conductor or busbar dimensions should be checked against the available CT opening.</p>
<p>With <strong>Class 1.0 accuracy</strong>, this Current Transformer is designed for suitable metering and current measurement applications where the specified accuracy class is required. Its <strong>2.5–15 VA rating</strong> provides a specified burden range for compatible metering circuits based on the connected secondary load and system requirements.</p>
<p>The overall dimensions of <strong>78 × 60 × 35 mm (H × L × W)</strong> provide a compact form factor for compatible electrical panels, distribution equipment, monitoring systems, and other suitable installations.</p>
<h2>500/5A Current Transformer for Metering</h2>
<p>The <strong>500/5A CT</strong> is designed for applications where the primary current requirement is 500A and the connected measuring equipment requires a 5A secondary current.</p>
<p>The <strong>Class 1.0 accuracy</strong> makes this CT suitable for compatible metering and current measurement applications requiring the specified accuracy class.</p>
<p>The 5A secondary can be connected to compatible energy meters, panel meters, current measuring instruments, monitoring devices, and other electrical equipment designed for a 5A CT secondary.</p>
<p>When selecting a Current Transformer, the current ratio, accuracy class, burden, secondary current, physical dimensions, and window size should be checked against the requirements of the intended electrical installation.</p>
<h2>Applications</h2>
<p>The <strong>500/5A Class 1.0 Current Transformer</strong> can be used in compatible electrical measurement and monitoring applications, including:</p>
<ul>
<li>Energy metering systems</li>
<li>Electrical current measurement</li>
<li>Distribution panels</li>
<li>Electrical control panels</li>
<li>Power monitoring systems</li>
<li>Metering panels</li>
<li>Industrial electrical installations</li>
<li>Commercial electrical systems</li>
<li>Electrical monitoring equipment</li>
<li>Current monitoring systems</li>
<li>Load monitoring applications</li>
<li>Compatible energy measurement applications</li>
</ul>
<p>The CT should be selected according to the required primary current, secondary current, accuracy, burden, physical dimensions, window size, and electrical installation requirements.</p>
<h2>42mm Window and Busbar Design</h2>
<p>The Current Transformer features a <strong>42mm diameter/window</strong> along with a <strong>42 × 12 mm busbar window</strong>.</p>
<p>This opening is designed for compatible conductors and busbars. Before installation, users should verify the actual conductor or busbar dimensions and ensure that they are suitable for the CT opening.</p>
<p>The <strong>78 × 60 × 35 mm</strong> overall dimensions provide a compact form factor for compatible electrical panel installations.</p>
<h2>Class 1.0 Accuracy</h2>
<p>Accuracy class is an important specification when selecting a Current Transformer for metering and measurement applications.</p>
<p>The <strong>Class 1.0</strong> rating identifies the specified accuracy class of this CT under its applicable rated conditions. The <strong>500/5A ratio</strong> provides a 5A secondary output corresponding to a 500A primary current under rated operating conditions.</p>
<p>The CT should be selected according to the requirements of the electrical system and the specifications of the connected measuring equipment.</p>
<h2>2.5–15 VA Rating</h2>
<p>The <strong>500/5A 42mm Current Transformer</strong> has a specified <strong>2.5–15 VA rating</strong>.</p>
<p>VA rating relates to the burden connected to the CT secondary circuit, including compatible meters, measuring instruments, and associated wiring.</p>
<p>When selecting a Current Transformer, the connected secondary load should be considered to ensure that the CT is suitable for the intended metering circuit.</p>
<h2>Standard 5A Secondary</h2>
<p>The <strong>5A secondary current</strong> is suitable for compatible conventional CT meters, energy meters, panel meters, and electrical measuring equipment designed for a 5A CT input.</p>
<p>For this product, the rated ratio is <strong>500/5A</strong>. Under rated operating conditions, a 500A primary current corresponds to a 5A secondary current.</p>
<p>The secondary circuit should always be connected to compatible equipment and installed according to appropriate electrical installation and safety practices.</p>
<h2>Benefits of 500/5A Current Transformer</h2>
<h3>Accurate Current Measurement</h3>
<p>The <strong>Class 1.0 accuracy</strong> makes this CT suitable for compatible applications requiring the specified metering accuracy.</p>
<h3>Standard 5A Secondary</h3>
<p>The <strong>5A secondary output</strong> is suitable for compatible meters and current measurement equipment designed for a 5A CT secondary.</p>
<h3>Compact Design</h3>
<p>The <strong>78 × 60 × 35 mm</strong> dimensions provide a compact form factor for compatible electrical panel installations.</p>
<h3>42mm Window</h3>
<p>The <strong>42mm diameter/window</strong> and <strong>42 × 12 mm busbar window</strong> provide a defined opening for compatible conductor and busbar installations.</p>
<h3>Versatile Metering Applications</h3>
<p>The CT can be used in compatible energy metering, electrical monitoring, current measurement, and distribution-panel applications.</p>
<h2>500/5A CT for Electrical Panels</h2>
<p>The <strong>500/5A 42mm Current Transformer</strong> can be integrated into compatible electrical panels, metering systems, and current monitoring equipment.</p>
<p>Potential compatible equipment includes:</p>
<ul>
<li>Panel meters</li>
<li>Energy meters</li>
<li>Current meters</li>
<li>Power monitoring equipment</li>
<li>Electrical monitoring devices</li>
<li>Metering panels</li>
<li>Control panels</li>
<li>Distribution panels</li>
</ul>
<p>Before installation, verify that the connected equipment requires a <strong>5A CT secondary</strong> and that the CT window and overall dimensions are suitable for the intended application.</p>
<h2>Installation Considerations</h2>
<p>Before installing the <strong>500/5A Current Transformer</strong>, verify the electrical and mechanical requirements of the application.</p>
<p>Important parameters to check include:</p>
<ol>
<li>Primary current requirement</li>
<li>Secondary current requirement</li>
<li>Current ratio</li>
<li>Accuracy class</li>
<li>Connected burden</li>
<li>Conductor or busbar dimensions</li>
<li>CT window size</li>
<li>Available installation space</li>
<li>Meter compatibility</li>
<li>Electrical system requirements</li>
</ol>
<p>The Current Transformer should be installed by a qualified electrical professional following applicable electrical installation practices and the requirements of the connected equipment.</p>
<h2>Why Choose the 500/5A 42mm Current Transformer?</h2>
<p>The <strong>500/5A 42mm Class 1.0 Metering CT</strong> combines:</p>
<ul>
<li><strong>500A primary current</strong></li>
<li><strong>5A secondary current</strong></li>
<li><strong>500/5A current ratio</strong></li>
<li><strong>Class 1.0 accuracy</strong></li>
<li><strong>42mm diameter/window</strong></li>
<li><strong>42 × 12 mm busbar window</strong></li>
<li><strong>78 × 60 × 35 mm dimensions</strong></li>
<li><strong>2.5–15 VA rating</strong></li>
<li>Encapsulated square-type construction</li>
<li>Compact design</li>
<li>Suitable for metering and current measurement</li>
<li>Suitable for electrical panels and monitoring systems</li>
</ul>
<p>These specifications make the CT suitable for compatible electrical measurement, metering, monitoring, and panel applications requiring a <strong>500/5A Current Transformer</strong>.</p>
<h2>MVG Power Solutions – Current Transformer Supplier</h2>
<p><strong>MVG Power Solutions</strong> supplies Current Transformers and electrical measurement products for industrial, commercial, metering, panel-building, monitoring, and electrical distribution applications.</p>
<p>The <strong>500/5A 42mm Class 1.0 Metering Current Transformer</strong> is designed for applications requiring a <strong>500A primary current, 5A secondary output, 42mm window, 42 × 12 mm busbar opening, and Class 1.0 accuracy</strong>.</p>
<p>For bulk requirements, technical specifications, product availability, or quotations, contact MVG Power Solutions with your required quantity and application details.</p>
<h2>Product Summary</h2>
<p>The <strong>500/5A 42mm Current Transformer | Class 1.0 Metering CT</strong> features a <strong>500A primary current, 5A secondary current, Class 1.0 accuracy, 42mm diameter/window, 42 × 12 mm busbar window, 2.5–15 VA rating, and 78 × 60 × 35 mm dimensions</strong>.</p>
<p>It is designed for compatible <strong>electrical metering, current measurement, power monitoring, electrical panels, distribution systems, control panels, and industrial and commercial applications</strong> requiring a 500/5A Current Transformer.</p>
<h2>Frequently Asked Questions</h2>
<h3>What is the current ratio of this CT?</h3>
<p>The current ratio is <strong>500/5A</strong>, with a 500A primary current and 5A secondary current.</p>
<h3>What is the accuracy class?</h3>
<p>The Current Transformer has <strong>Class 1.0 accuracy</strong> as specified for this product.</p>
<h3>What is the secondary current?</h3>
<p>The secondary current is <strong>5A</strong>.</p>
<h3>What is the CT diameter?</h3>
<p>The specified diameter/window is <strong>42 mm</strong>.</p>
<h3>What is the busbar window size?</h3>
<p>The busbar window is <strong>42 × 12 mm</strong>.</p>
<h3>What are the dimensions?</h3>
<p>The dimensions are <strong>78 × 60 × 35 mm (H × L × W)</strong>.</p>
<h3>What is the VA rating?</h3>
<p>The specified VA rating is <strong>2.5–15 VA</strong>.</p>
<h3>Where can the 500/5A Current Transformer be used?</h3>
<p>It can be used in compatible metering, current measurement, electrical monitoring, distribution panels, control panels, and energy monitoring systems, subject to the electrical requirements of the installation.</p>', 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/500-5a-42mm-current-transformer-class-1-metering-ct.jpg', 0, 'published'),
(151, 2, 59, 1, '400/5A 42mm Current Transformer | Class 1.0 Metering CT', '400-5a-42mm-current-transformer', 'MVG-40-4210-1-1', 280.00, 280.00, 10, '85043100', 18.00, 'in_stock', '<ul>
<li data-section-id="1t9cpb6" data-start="83" data-end="114"><strong data-start="85" data-end="105">Primary Current:</strong> <strong data-start="106" data-end="114">400A</strong></li>
<li data-section-id="2dmbsl" data-start="115" data-end="146"><strong data-start="117" data-end="139">Secondary Current:</strong> <strong data-start="140" data-end="146">5A</strong></li>
<li data-section-id="1x8nw6t" data-start="147" data-end="178"><strong data-start="149" data-end="167">Current Ratio:</strong> <strong data-start="168" data-end="178">400/5A</strong></li>
<li data-section-id="16yb7c0" data-start="179" data-end="214"><strong data-start="181" data-end="200">Accuracy Class:</strong> <strong data-start="201" data-end="214">Class 1.0</strong></li>
<li data-section-id="1h9uuxf" data-start="215" data-end="240"><strong data-start="217" data-end="230">Diameter:</strong> <strong data-start="231" data-end="240">42 mm</strong></li>
<li data-section-id="4q9ph5" data-start="241" data-end="276"><strong data-start="243" data-end="261">Busbar Window:</strong> <strong data-start="262" data-end="276">42 × 12 mm</strong></li>
<li data-section-id="1m8s0x8" data-start="277" data-end="326"><strong data-start="279" data-end="306">Dimensions (H × L × W):</strong> <strong data-start="307" data-end="326">78 × 60 × 35 mm</strong></li>
<li data-section-id="10orlqj" data-start="327" data-end="357"><strong data-start="329" data-end="343">VA Rating:</strong> <strong data-start="344" data-end="357">2.5–15 VA</strong></li>
<li data-section-id="1qb0zja" data-start="358" data-end="392">Compact square-type construction</li>
<li data-section-id="18xu12i" data-start="393" data-end="417">Encapsulated CT design</li>
<li data-section-id="j6w5vl" data-start="418" data-end="465">Suitable for metering and current measurement</li>
<li data-section-id="1nf6c48" data-start="466" data-end="521">Suitable for electrical panels and monitoring systems</li>
<li data-section-id="1p1d179" data-start="522" data-end="586">Suitable for industrial and commercial electrical applications</li>
<li data-section-id="s9jpm1" data-start="587" data-end="644">Designed for compatible 5A secondary metering equipment</li>
</ul>', '<h1>400/5A 42mm Current Transformer | Class 1.0 Metering CT</h1>
<p>The <strong>400/5A 42mm Current Transformer (CT)</strong> from <strong>MVG Power Solutions</strong> is designed for electrical current measurement, metering, monitoring, and compatible electrical panel applications. Featuring a <strong>400A primary current, 5A secondary current, Class 1.0 accuracy</strong>, and a <strong>42mm diameter/window</strong>, this Current Transformer provides a practical solution for electrical systems requiring a 400/5A CT ratio.</p>
<p>A Current Transformer is used to transform a higher primary current into a lower standardized secondary current that can be connected to compatible meters, measuring instruments, monitoring equipment, and electrical systems. This model provides a <strong>400/5A current ratio</strong>, meaning a primary current of 400A corresponds to a secondary current of 5A under rated operating conditions.</p>
<p>The <strong>400/5A 42mm Current Transformer</strong> is suitable for compatible metering and current measurement applications where a 5A secondary input is required.</p>
<h2>Key Features</h2>
<p>The 400/5A 42mm Current Transformer offers practical features for electrical measurement and monitoring applications:</p>
<ul>
<li><strong>400/5A current ratio</strong></li>
<li><strong>400A primary current</strong></li>
<li><strong>5A secondary current</strong></li>
<li><strong>Class 1.0 accuracy</strong></li>
<li><strong>42mm diameter/window</strong></li>
<li><strong>42 × 12 mm busbar window</strong></li>
<li><strong>2.5–15 VA rating</strong></li>
<li><strong>78 × 60 × 35 mm dimensions</strong></li>
<li>Encapsulated square-type construction</li>
<li>Compact CT design</li>
<li>Suitable for metering applications</li>
<li>Suitable for current measurement and monitoring</li>
<li>Suitable for compatible electrical panels and systems</li>
</ul>
<h2>Technical Specifications</h2>
<table>
<thead>
<tr>
<th>Parameter</th>
<th>Specification</th>
</tr>
</thead>
<tbody>
<tr>
<td>Product Type</td>
<td>Current Transformer</td>
</tr>
<tr>
<td>CT Type</td>
<td>Encapsulated Square Type</td>
</tr>
<tr>
<td>Primary Current</td>
<td>400A</td>
</tr>
<tr>
<td>Secondary Current</td>
<td>5A</td>
</tr>
<tr>
<td>Current Ratio</td>
<td>400/5A</td>
</tr>
<tr>
<td>Accuracy Class</td>
<td>Class 1.0</td>
</tr>
<tr>
<td>Diameter / Window</td>
<td>42 mm</td>
</tr>
<tr>
<td>Busbar Window</td>
<td>42 × 12 mm</td>
</tr>
<tr>
<td>Dimensions (H × L × W)</td>
<td>78 × 60 × 35 mm</td>
</tr>
<tr>
<td>VA Rating</td>
<td>2.5–15 VA</td>
</tr>
<tr>
<td>Application</td>
<td>Metering &amp; Current Measurement</td>
</tr>
</tbody>
</table>
<h2>Product Overview</h2>
<p>The <strong>400/5A 42mm Current Transformer</strong> is a compact <strong>Class 1.0 metering-class CT</strong> designed for suitable electrical current measurement and monitoring applications. It features a <strong>400A primary current</strong> and <strong>5A secondary current</strong>, providing a standardized secondary output for compatible metering and measurement equipment.</p>
<p>The encapsulated square-type construction provides a practical configuration for installation in compatible electrical panels and measurement systems. The design is suitable for applications where a defined CT window and compact overall dimensions are required.</p>
<p>This CT features a <strong>42mm diameter/window</strong> and a <strong>42 × 12 mm busbar window</strong>, allowing installation around compatible conductors or busbars. Before installation, the conductor or busbar dimensions should be checked against the available CT opening.</p>
<p>With <strong>Class 1.0 accuracy</strong>, this Current Transformer is designed for suitable metering and current measurement applications where the specified accuracy class is required. Its <strong>2.5–15 VA rating</strong> provides a specified burden range for compatible metering circuits based on the connected secondary load and system requirements.</p>
<p>The overall dimensions of <strong>78 × 60 × 35 mm (H × L × W)</strong> provide a compact form factor for compatible electrical panels, distribution equipment, monitoring systems, and other suitable installations.</p>
<h2>400/5A Current Transformer for Metering</h2>
<p>The <strong>400/5A CT</strong> is designed for applications where the primary current requirement is 400A and the connected measuring equipment requires a 5A secondary current.</p>
<p>The <strong>Class 1.0 accuracy</strong> makes this CT suitable for compatible metering and current measurement applications requiring the specified accuracy class.</p>
<p>The 5A secondary can be connected to compatible energy meters, panel meters, current measuring instruments, monitoring devices, and other electrical equipment designed for a 5A CT secondary.</p>
<p>When selecting a Current Transformer, the current ratio, accuracy class, burden, secondary current, physical dimensions, and window size should be checked against the requirements of the intended electrical installation.</p>
<h2>Applications</h2>
<p>The <strong>400/5A Class 1.0 Current Transformer</strong> can be used in compatible electrical measurement and monitoring applications, including:</p>
<ul>
<li>Energy metering systems</li>
<li>Electrical current measurement</li>
<li>Distribution panels</li>
<li>Electrical control panels</li>
<li>Power monitoring systems</li>
<li>Metering panels</li>
<li>Industrial electrical installations</li>
<li>Commercial electrical systems</li>
<li>Electrical monitoring equipment</li>
<li>Current monitoring systems</li>
<li>Load monitoring applications</li>
<li>Compatible energy measurement applications</li>
</ul>
<p>The CT should be selected according to the required primary current, secondary current, accuracy, burden, physical dimensions, window size, and electrical installation requirements.</p>
<h2>42mm Window and Busbar Design</h2>
<p>The Current Transformer features a <strong>42mm diameter/window</strong> along with a <strong>42 × 12 mm busbar window</strong>.</p>
<p>This opening is designed for compatible conductors and busbars. Before installation, users should verify the actual conductor or busbar dimensions and ensure that they are suitable for the CT opening.</p>
<p>The <strong>78 × 60 × 35 mm</strong> overall dimensions provide a compact form factor for compatible electrical panel installations.</p>
<h2>Class 1.0 Accuracy</h2>
<p>Accuracy class is an important specification when selecting a Current Transformer for metering and measurement applications.</p>
<p>The <strong>Class 1.0</strong> rating identifies the specified accuracy class of this CT under its applicable rated conditions. The <strong>400/5A ratio</strong> provides a 5A secondary output corresponding to a 400A primary current under rated operating conditions.</p>
<p>The CT should be selected according to the requirements of the electrical system and the specifications of the connected measuring equipment.</p>
<h2>2.5–15 VA Rating</h2>
<p>The <strong>400/5A 42mm Current Transformer</strong> has a specified <strong>2.5–15 VA rating</strong>.</p>
<p>VA rating relates to the burden connected to the CT secondary circuit, including compatible meters, measuring instruments, and associated wiring.</p>
<p>When selecting a Current Transformer, the connected secondary load should be considered to ensure that the CT is suitable for the intended metering circuit.</p>
<h2>Standard 5A Secondary</h2>
<p>The <strong>5A secondary current</strong> is suitable for compatible conventional CT meters, energy meters, panel meters, and electrical measuring equipment designed for a 5A CT input.</p>
<p>For this product, the rated ratio is <strong>400/5A</strong>. Under rated operating conditions, a 400A primary current corresponds to a 5A secondary current.</p>
<p>The secondary circuit should always be connected to compatible equipment and installed according to appropriate electrical installation and safety practices.</p>
<h2>Benefits of 400/5A Current Transformer</h2>
<h3>Accurate Current Measurement</h3>
<p>The <strong>Class 1.0 accuracy</strong> makes this CT suitable for compatible applications requiring the specified metering accuracy.</p>
<h3>Standard 5A Secondary</h3>
<p>The <strong>5A secondary output</strong> is suitable for compatible meters and current measurement equipment designed for a 5A CT secondary.</p>
<h3>Compact Design</h3>
<p>The <strong>78 × 60 × 35 mm</strong> dimensions provide a compact form factor for compatible electrical panel installations.</p>
<h3>42mm Window</h3>
<p>The <strong>42mm diameter/window</strong> and <strong>42 × 12 mm busbar window</strong> provide a defined opening for compatible conductor and busbar installations.</p>
<h3>Versatile Metering Applications</h3>
<p>The CT can be used in compatible energy metering, electrical monitoring, current measurement, and distribution-panel applications.</p>
<h2>400/5A CT for Electrical Panels</h2>
<p>The <strong>400/5A 42mm Current Transformer</strong> can be integrated into compatible electrical panels, metering systems, and current monitoring equipment.</p>
<p>Potential compatible equipment includes:</p>
<ul>
<li>Panel meters</li>
<li>Energy meters</li>
<li>Current meters</li>
<li>Power monitoring equipment</li>
<li>Electrical monitoring devices</li>
<li>Metering panels</li>
<li>Control panels</li>
<li>Distribution panels</li>
</ul>
<p>Before installation, verify that the connected equipment requires a <strong>5A CT secondary</strong> and that the CT window and overall dimensions are suitable for the intended application.</p>
<h2>Installation Considerations</h2>
<p>Before installing the <strong>400/5A Current Transformer</strong>, verify the electrical and mechanical requirements of the application.</p>
<p>Important parameters to check include:</p>
<ol>
<li>Primary current requirement</li>
<li>Secondary current requirement</li>
<li>Current ratio</li>
<li>Accuracy class</li>
<li>Connected burden</li>
<li>Conductor or busbar dimensions</li>
<li>CT window size</li>
<li>Available installation space</li>
<li>Meter compatibility</li>
<li>Electrical system requirements</li>
</ol>
<p>The Current Transformer should be installed by a qualified electrical professional following applicable electrical installation practices and the requirements of the connected equipment.</p>
<h2>Why Choose the 400/5A 42mm Current Transformer?</h2>
<p>The <strong>400/5A 42mm Class 1.0 Metering CT</strong> combines:</p>
<ul>
<li><strong>400A primary current</strong></li>
<li><strong>5A secondary current</strong></li>
<li><strong>400/5A current ratio</strong></li>
<li><strong>Class 1.0 accuracy</strong></li>
<li><strong>42mm diameter/window</strong></li>
<li><strong>42 × 12 mm busbar window</strong></li>
<li><strong>78 × 60 × 35 mm dimensions</strong></li>
<li><strong>2.5–15 VA rating</strong></li>
<li>Encapsulated square-type construction</li>
<li>Compact design</li>
<li>Suitable for metering and current measurement</li>
<li>Suitable for electrical panels and monitoring systems</li>
</ul>
<p>These specifications make the CT suitable for compatible electrical measurement, metering, monitoring, and panel applications requiring a <strong>400/5A Current Transformer</strong>.</p>
<h2>MVG Power Solutions – Current Transformer Supplier</h2>
<p><strong>MVG Power Solutions</strong> supplies Current Transformers and electrical measurement products for industrial, commercial, metering, panel-building, monitoring, and electrical distribution applications.</p>
<p>The <strong>400/5A 42mm Class 1.0 Metering Current Transformer</strong> is designed for applications requiring a <strong>400A primary current, 5A secondary output, 42mm window, 42 × 12 mm busbar opening, and Class 1.0 accuracy</strong>.</p>
<p>For bulk requirements, technical specifications, product availability, or quotations, contact MVG Power Solutions with your required quantity and application details.</p>
<h2>Product Summary</h2>
<p>The <strong>400/5A 42mm Current Transformer | Class 1.0 Metering CT</strong> features a <strong>400A primary current, 5A secondary current, Class 1.0 accuracy, 42mm diameter/window, 42 × 12 mm busbar window, 2.5–15 VA rating, and 78 × 60 × 35 mm dimensions</strong>.</p>
<p>It is designed for compatible <strong>electrical metering, current measurement, power monitoring, electrical panels, distribution systems, control panels, and industrial and commercial applications</strong> requiring a 400/5A Current Transformer.</p>
<h2>Frequently Asked Questions</h2>
<h3>What is the current ratio of this CT?</h3>
<p>The current ratio is <strong>400/5A</strong>, with a 400A primary current and 5A secondary current.</p>
<h3>What is the accuracy class?</h3>
<p>The Current Transformer has <strong>Class 1.0 accuracy</strong> as specified for this product.</p>
<h3>What is the secondary current?</h3>
<p>The secondary current is <strong>5A</strong>.</p>
<h3>What is the CT diameter?</h3>
<p>The specified diameter/window is <strong>42 mm</strong>.</p>
<h3>What is the busbar window size?</h3>
<p>The busbar window is <strong>42 × 12 mm</strong>.</p>
<h3>What are the dimensions?</h3>
<p>The dimensions are <strong>78 × 60 × 35 mm (H × L × W)</strong>.</p>
<h3>What is the VA rating?</h3>
<p>The specified VA rating is <strong>2.5–15 VA</strong>.</p>
<h3>Where can the 400/5A Current Transformer be used?</h3>
<p>It can be used in compatible metering, current measurement, electrical monitoring, distribution panels, control panels, and energy monitoring systems, subject to the electrical requirements of the installation.</p>', 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/400-5a-42mm-current-transformer-class-1-metering-ct.jpg', 0, 'published'),
(148, 2, 59, 1, '300/5A 42mm Current Transformer | Class 1.0 Metering CT', '300-5a-42mm-current-transformer', 'MVG-40-4210-1', 280.00, 280.00, 10, '85043100', 18.00, 'in_stock', '<ul data-start="83" data-end="644">
<li data-section-id="1v5rcjp" data-start="83" data-end="114"><strong data-start="85" data-end="105">Primary Current:</strong> <strong data-start="106" data-end="114">300A</strong></li>
<li data-section-id="2dmbsl" data-start="115" data-end="146"><strong data-start="117" data-end="139">Secondary Current:</strong> <strong data-start="140" data-end="146">5A</strong></li>
<li data-section-id="76co2a" data-start="147" data-end="178"><strong data-start="149" data-end="167">Current Ratio:</strong> <strong data-start="168" data-end="178">300/5A</strong></li>
<li data-section-id="16yb7c0" data-start="179" data-end="214"><strong data-start="181" data-end="200">Accuracy Class:</strong> <strong data-start="201" data-end="214">Class 1.0</strong></li>
<li data-section-id="1h9uuxf" data-start="215" data-end="240"><strong data-start="217" data-end="230">Diameter:</strong> <strong data-start="231" data-end="240">42 mm</strong></li>
<li data-section-id="4q9ph5" data-start="241" data-end="276"><strong data-start="243" data-end="261">Busbar Window:</strong> <strong data-start="262" data-end="276">42 × 12 mm</strong></li>
<li data-section-id="1m8s0x8" data-start="277" data-end="326"><strong data-start="279" data-end="306">Dimensions (H × L × W):</strong> <strong data-start="307" data-end="326">78 × 60 × 35 mm</strong></li>
<li data-section-id="10orlqj" data-start="327" data-end="357"><strong data-start="329" data-end="343">VA Rating:</strong> <strong data-start="344" data-end="357">2.5–15 VA</strong></li>
<li data-section-id="1qb0zja" data-start="358" data-end="392">Compact square-type construction</li>
<li data-section-id="18xu12i" data-start="393" data-end="417">Encapsulated CT design</li>
<li data-section-id="j6w5vl" data-start="418" data-end="465">Suitable for metering and current measurement</li>
<li data-section-id="1nf6c48" data-start="466" data-end="521">Suitable for electrical panels and monitoring systems</li>
<li data-section-id="1p1d179" data-start="522" data-end="586">Suitable for industrial and commercial electrical applications</li>
<li data-section-id="s9jpm1" data-start="587" data-end="644">Designed for compatible 5A secondary metering equipment</li>
</ul>
<div class="group relative clear-both my-4 w-full overflow-visible z-1" data-writing-block-fullscreen-fallback-target="inline">
<div id="writing-block-55a61665-824b-45c9-836e-1a614b7783ad" class="group/writing-block-surface relative isolate w-full min-w-0 overflow-clip rounded-[var(--oai-wb-radius)] [box-shadow:var(--oai-wb-shadow)] [color:var(--oai-wb-text-primary)] [contain:inline-size] [font-family:var(--oai-wb-font-sans)] [--wb-text-primary:var(--text-primary)] [--wb-text-secondary:var(--text-secondary)] [--wb-text-tertiary:var(--text-tertiary)] [--wb-surface-primary:var(--bg-primary)] [--wb-surface-secondary:var(--bg-tertiary)] [--wb-border:rgb(0_0_0/7%)] [--wb-border-hover:rgb(0_0_0/7%)] [--wb-divider:var(--border-light)] [--wb-focus:var(--border-strong)] [--wb-control-border:var(--interactive-border-focus)] [--wb-entity-accent:var(--theme-entity-accent)] [--wb-accent:var(--interactive-label-accent-default)] [--wb-on-accent:var(--bg-primary)] [--wb-interactive-background:var(--interactive-bg-accent-default)] [--wb-selection:var(--theme-user-selection-bg,var(--selection))] [--wb-radius-sm:var(--radius-sm)] [--wb-shadow-lg:var(--shadow-lg)] [--wb-font-sans:var(--font-sans)] [--wb-font-mono:var(--font-mono)] [--wb-shimmer-dark-contrast:var(--gray-550)] [--wb-shimmer-dark-secondary:var(--text-tertiary)] [--wb-radius:24px] [--wb-shadow:0_4px_80px_rgb(0_0_0/2%)] [contain:none]" data-oai-writing-block-surface="" data-writing-block="true" data-testid="writing-block-container">
<div class="pointer-events-none absolute inset-0 rounded-[inherit] z-[-1] [background:var(--oai-wb-surface-primary)] bg-token-bg-primary! dark:bg-[#2a2a2a]!" data-writing-block-fullscreen-shell-surface="true" aria-hidden="true"></div>
<div class="relative z-[1]">
<div class="z-1 relative md:sticky md:top-(--sticky-padding-top)" data-testid="writing-block-header-sticky-container">
<div class="relative isolate flex w-full items-center justify-between gap-3 font-sans py-2.5 pe-3 sm:pe-1" data-testid="writing-block-header-surface">
<div class="bg-token-bg-primary pointer-events-none absolute inset-0 -z-1 dark:bg-[#2a2a2a]" aria-hidden="true" data-writing-block-fullscreen-header-surface="true"></div>
<div class="relative z-1 flex w-full items-center justify-between gap-3" data-writing-block-fullscreen-header-chrome="true" data-writing-block-fullscreen-header-layout="inline">
<div class="flex min-w-0 grow gap-3 items-center">
<div class="flex min-w-0 grow cursor-default items-center self-center max-w-[75%] text-token-text-tertiary text-sm font-medium">
<div class="min-w-0 truncate"></div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>', '<h1>300/5A 42mm Current Transformer | Class 1.0 Metering CT</h1>
<p>The <strong>300/5A 42mm Current Transformer (CT)</strong> from <strong>MVG Power Solutions</strong> is designed for electrical current measurement, metering, monitoring, and compatible electrical panel applications. Featuring a <strong>300A primary current, 5A secondary current, Class 1.0 accuracy</strong>, and a <strong>42mm diameter/window</strong>, this Current Transformer provides a practical solution for electrical systems requiring a 300/5A CT ratio.</p>
<p>A Current Transformer is used to transform a higher primary current into a lower standardized secondary current that can be connected to compatible meters, measuring instruments, monitoring equipment, and electrical systems. This model provides a <strong>300/5A current ratio</strong>, meaning a primary current of 300A corresponds to a secondary current of 5A under rated operating conditions.</p>
<p>The <strong>300/5A 42mm Current Transformer</strong> is suitable for compatible metering and current measurement applications where a 5A secondary input is required.</p>
<h2>Key Features</h2>
<p>The 300/5A 42mm Current Transformer offers practical features for electrical measurement and monitoring applications:</p>
<ul>
<li><strong>300/5A current ratio</strong></li>
<li><strong>300A primary current</strong></li>
<li><strong>5A secondary current</strong></li>
<li><strong>Class 1.0 accuracy</strong></li>
<li><strong>42mm diameter/window</strong></li>
<li><strong>42 × 12 mm busbar window</strong></li>
<li><strong>2.5–15 VA rating</strong></li>
<li><strong>78 × 60 × 35 mm dimensions</strong></li>
<li>Encapsulated square-type construction</li>
<li>Compact CT design</li>
<li>Suitable for metering applications</li>
<li>Suitable for current measurement and monitoring</li>
<li>Suitable for compatible electrical panels and systems</li>
</ul>
<h2>Technical Specifications</h2>
<table>
<thead>
<tr>
<th>Parameter</th>
<th>Specification</th>
</tr>
</thead>
<tbody>
<tr>
<td>Product Type</td>
<td>Current Transformer</td>
</tr>
<tr>
<td>CT Type</td>
<td>Encapsulated Square Type</td>
</tr>
<tr>
<td>Primary Current</td>
<td>300A</td>
</tr>
<tr>
<td>Secondary Current</td>
<td>5A</td>
</tr>
<tr>
<td>Current Ratio</td>
<td>300/5A</td>
</tr>
<tr>
<td>Accuracy Class</td>
<td>Class 1.0</td>
</tr>
<tr>
<td>Diameter / Window</td>
<td>42 mm</td>
</tr>
<tr>
<td>Busbar Window</td>
<td>42 × 12 mm</td>
</tr>
<tr>
<td>Dimensions (H × L × W)</td>
<td>78 × 60 × 35 mm</td>
</tr>
<tr>
<td>VA Rating</td>
<td>2.5–15 VA</td>
</tr>
<tr>
<td>Application</td>
<td>Metering &amp; Current Measurement</td>
</tr>
</tbody>
</table>
<h2>Product Overview</h2>
<p>The <strong>300/5A 42mm Current Transformer</strong> is a compact <strong>Class 1.0 metering-class CT</strong> designed for suitable electrical current measurement and monitoring applications. It features a <strong>300A primary current</strong> and <strong>5A secondary current</strong>, providing a standardized secondary output for compatible metering and measurement equipment.</p>
<p>The encapsulated square-type construction provides a practical configuration for installation in compatible electrical panels and measurement systems. The design is suitable for applications where a defined CT window and compact overall dimensions are required.</p>
<p>This CT features a <strong>42mm diameter/window</strong> and a <strong>42 × 12 mm busbar window</strong>, allowing installation around compatible conductors or busbars. Before installation, the conductor or busbar dimensions should be checked against the available CT opening.</p>
<p>With <strong>Class 1.0 accuracy</strong>, this Current Transformer is designed for suitable metering and current measurement applications where the specified accuracy class is required. Its <strong>2.5–15 VA rating</strong> provides a specified burden range for compatible metering circuits based on the connected secondary load and system requirements.</p>
<p>The overall dimensions of <strong>78 × 60 × 35 mm (H × L × W)</strong> provide a compact form factor for compatible electrical panels, distribution equipment, monitoring systems, and other suitable installations.</p>
<h2>300/5A Current Transformer for Metering</h2>
<p>The <strong>300/5A CT</strong> is designed for applications where the primary current requirement is 300A and the connected measuring equipment requires a 5A secondary current.</p>
<p>The <strong>Class 1.0 accuracy</strong> makes this CT suitable for compatible metering and current measurement applications requiring the specified accuracy class.</p>
<p>The 5A secondary can be connected to compatible energy meters, panel meters, current measuring instruments, monitoring devices, and other electrical equipment designed for a 5A CT secondary.</p>
<p>When selecting a Current Transformer, the current ratio, accuracy class, burden, secondary current, physical dimensions, and window size should be checked against the requirements of the intended electrical installation.</p>
<h2>Applications</h2>
<p>The <strong>300/5A Class 1.0 Current Transformer</strong> can be used in compatible electrical measurement and monitoring applications, including:</p>
<ul>
<li>Energy metering systems</li>
<li>Electrical current measurement</li>
<li>Distribution panels</li>
<li>Electrical control panels</li>
<li>Power monitoring systems</li>
<li>Metering panels</li>
<li>Industrial electrical installations</li>
<li>Commercial electrical systems</li>
<li>Electrical monitoring equipment</li>
<li>Current monitoring systems</li>
<li>Load monitoring applications</li>
<li>Compatible energy measurement applications</li>
</ul>
<p>The CT should be selected according to the required primary current, secondary current, accuracy, burden, physical dimensions, window size, and electrical installation requirements.</p>
<h2>42mm Window and Busbar Design</h2>
<p>The Current Transformer features a <strong>42mm diameter/window</strong> along with a <strong>42 × 12 mm busbar window</strong>.</p>
<p>This opening is designed for compatible conductors and busbars. Before installation, users should verify the actual conductor or busbar dimensions and ensure that they are suitable for the CT opening.</p>
<p>The <strong>78 × 60 × 35 mm</strong> overall dimensions provide a compact form factor for compatible electrical panel installations.</p>
<h2>Class 1.0 Accuracy</h2>
<p>Accuracy class is an important specification when selecting a Current Transformer for metering and measurement applications.</p>
<p>The <strong>Class 1.0</strong> rating identifies the specified accuracy class of this CT under its applicable rated conditions. The <strong>300/5A ratio</strong> provides a 5A secondary output corresponding to a 300A primary current under rated operating conditions.</p>
<p>The CT should be selected according to the requirements of the electrical system and the specifications of the connected measuring equipment.</p>
<h2>2.5–15 VA Rating</h2>
<p>The <strong>300/5A 42mm Current Transformer</strong> has a specified <strong>2.5–15 VA rating</strong>.</p>
<p>VA rating relates to the burden connected to the CT secondary circuit, including compatible meters, measuring instruments, and associated wiring.</p>
<p>When selecting a Current Transformer, the connected secondary load should be considered to ensure that the CT is suitable for the intended metering circuit.</p>
<h2>Standard 5A Secondary</h2>
<p>The <strong>5A secondary current</strong> is suitable for compatible conventional CT meters, energy meters, panel meters, and electrical measuring equipment designed for a 5A CT input.</p>
<p>For this product, the rated ratio is <strong>300/5A</strong>. Under rated operating conditions, a 300A primary current corresponds to a 5A secondary current.</p>
<p>The secondary circuit should always be connected to compatible equipment and installed according to appropriate electrical installation and safety practices.</p>
<h2>Benefits of 300/5A Current Transformer</h2>
<h3>Accurate Current Measurement</h3>
<p>The <strong>Class 1.0 accuracy</strong> makes this CT suitable for compatible applications requiring the specified metering accuracy.</p>
<h3>Standard 5A Secondary</h3>
<p>The <strong>5A secondary output</strong> is suitable for compatible meters and current measurement equipment designed for a 5A CT secondary.</p>
<h3>Compact Design</h3>
<p>The <strong>78 × 60 × 35 mm</strong> dimensions provide a compact form factor for compatible electrical panel installations.</p>
<h3>42mm Window</h3>
<p>The <strong>42mm diameter/window</strong> and <strong>42 × 12 mm busbar window</strong> provide a defined opening for compatible conductor and busbar installations.</p>
<h3>Versatile Metering Applications</h3>
<p>The CT can be used in compatible energy metering, electrical monitoring, current measurement, and distribution-panel applications.</p>
<h2>300/5A CT for Electrical Panels</h2>
<p>The <strong>300/5A 42mm Current Transformer</strong> can be integrated into compatible electrical panels, metering systems, and current monitoring equipment.</p>
<p>Potential compatible equipment includes:</p>
<ul>
<li>Panel meters</li>
<li>Energy meters</li>
<li>Current meters</li>
<li>Power monitoring equipment</li>
<li>Electrical monitoring devices</li>
<li>Metering panels</li>
<li>Control panels</li>
<li>Distribution panels</li>
</ul>
<p>Before installation, verify that the connected equipment requires a <strong>5A CT secondary</strong> and that the CT window and overall dimensions are suitable for the intended application.</p>
<h2>Installation Considerations</h2>
<p>Before installing the <strong>300/5A Current Transformer</strong>, verify the electrical and mechanical requirements of the application.</p>
<p>Important parameters to check include:</p>
<ol>
<li>Primary current requirement</li>
<li>Secondary current requirement</li>
<li>Current ratio</li>
<li>Accuracy class</li>
<li>Connected burden</li>
<li>Conductor or busbar dimensions</li>
<li>CT window size</li>
<li>Available installation space</li>
<li>Meter compatibility</li>
<li>Electrical system requirements</li>
</ol>
<p>The Current Transformer should be installed by a qualified electrical professional following applicable electrical installation practices and the requirements of the connected equipment.</p>
<h2>Why Choose the 300/5A 42mm Current Transformer?</h2>
<p>The <strong>300/5A 42mm Class 1.0 Metering CT</strong> combines:</p>
<ul>
<li><strong>300A primary current</strong></li>
<li><strong>5A secondary current</strong></li>
<li><strong>300/5A current ratio</strong></li>
<li><strong>Class 1.0 accuracy</strong></li>
<li><strong>42mm diameter/window</strong></li>
<li><strong>42 × 12 mm busbar window</strong></li>
<li><strong>78 × 60 × 35 mm dimensions</strong></li>
<li><strong>2.5–15 VA rating</strong></li>
<li>Encapsulated square-type construction</li>
<li>Compact design</li>
<li>Suitable for metering and current measurement</li>
<li>Suitable for electrical panels and monitoring systems</li>
</ul>
<p>These specifications make the CT suitable for compatible electrical measurement, metering, monitoring, and panel applications requiring a <strong>300/5A Current Transformer</strong>.</p>
<h2>MVG Power Solutions – Current Transformer Supplier</h2>
<p><strong>MVG Power Solutions</strong> supplies Current Transformers and electrical measurement products for industrial, commercial, metering, panel-building, monitoring, and electrical distribution applications.</p>
<p>The <strong>300/5A 42mm Class 1.0 Metering Current Transformer</strong> is designed for applications requiring a <strong>300A primary current, 5A secondary output, 42mm window, 42 × 12 mm busbar opening, and Class 1.0 accuracy</strong>.</p>
<p>For bulk requirements, technical specifications, product availability, or quotations, contact MVG Power Solutions with your required quantity and application details.</p>
<h2>Product Summary</h2>
<p>The <strong>300/5A 42mm Current Transformer | Class 1.0 Metering CT</strong> features a <strong>300A primary current, 5A secondary current, Class 1.0 accuracy, 42mm diameter/window, 42 × 12 mm busbar window, 2.5–15 VA rating, and 78 × 60 × 35 mm dimensions</strong>.</p>
<p>It is designed for compatible <strong>electrical metering, current measurement, power monitoring, electrical panels, distribution systems, control panels, and industrial and commercial applications</strong> requiring a 300/5A Current Transformer.</p>
<h2>Frequently Asked Questions</h2>
<h3>What is the current ratio of this CT?</h3>
<p>The current ratio is <strong>300/5A</strong>, with a 300A primary current and 5A secondary current.</p>
<h3>What is the accuracy class?</h3>
<p>The Current Transformer has <strong>Class 1.0 accuracy</strong> as specified for this product.</p>
<h3>What is the secondary current?</h3>
<p>The secondary current is <strong>5A</strong>.</p>
<h3>What is the CT diameter?</h3>
<p>The specified diameter/window is <strong>42 mm</strong>.</p>
<h3>What is the busbar window size?</h3>
<p>The busbar window is <strong>42 × 12 mm</strong>.</p>
<h3>What are the dimensions?</h3>
<p>The dimensions are <strong>78 × 60 × 35 mm (H × L × W)</strong>.</p>
<h3>What is the VA rating?</h3>
<p>The specified VA rating is <strong>2.5–15 VA</strong>.</p>
<h3>Where can the 300/5A Current Transformer be used?</h3>
<p>It can be used in compatible metering, current measurement, electrical monitoring, distribution panels, control panels, and energy monitoring systems, subject to the electrical requirements of the installation.</p>', 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/300-5a-42mm-current-transformer-class-1-metering-ct.jpg', 0, 'published'),
(145, 2, 59, 1, '250/5A 42mm Current Transformer | Class 1.0 Metering CT', '250-5a-42mm-current-transformer', 'MVG-40-4210', 280.00, 280.00, 10, '85043100', 18.00, 'in_stock', '<ul>
<li data-section-id="1uhpmn5" data-start="264" data-end="295"><strong data-start="266" data-end="286">Primary Current:</strong> <strong data-start="287" data-end="295">250A</strong></li>
<li data-section-id="2dmbsl" data-start="296" data-end="327"><strong data-start="298" data-end="320">Secondary Current:</strong> <strong data-start="321" data-end="327">5A</strong></li>
<li data-section-id="118e186" data-start="328" data-end="359"><strong data-start="330" data-end="348">Current Ratio:</strong> <strong data-start="349" data-end="359">250/5A</strong></li>
<li data-section-id="16yb7c0" data-start="360" data-end="395"><strong data-start="362" data-end="381">Accuracy Class:</strong> <strong data-start="382" data-end="395">Class 1.0</strong></li>
<li data-section-id="1h9uuxf" data-start="396" data-end="421"><strong data-start="398" data-end="411">Diameter:</strong> <strong data-start="412" data-end="421">42 mm</strong></li>
<li data-section-id="4q9ph5" data-start="422" data-end="457"><strong data-start="424" data-end="442">Busbar Window:</strong> <strong data-start="443" data-end="457">42 × 12 mm</strong></li>
<li data-section-id="1m8s0x8" data-start="458" data-end="507"><strong data-start="460" data-end="487">Dimensions (H × L × W):</strong> <strong data-start="488" data-end="507">78 × 60 × 35 mm</strong></li>
<li data-section-id="10orlqj" data-start="508" data-end="538"><strong data-start="510" data-end="524">VA Rating:</strong> <strong data-start="525" data-end="538">2.5–15 VA</strong></li>
<li data-section-id="1qb0zja" data-start="539" data-end="573">Compact square-type construction</li>
<li data-section-id="18xu12i" data-start="574" data-end="598">Encapsulated CT design</li>
<li data-section-id="j6w5vl" data-start="599" data-end="646">Suitable for metering and current measurement</li>
<li data-section-id="1nf6c48" data-start="647" data-end="702">Suitable for electrical panels and monitoring systems</li>
<li data-section-id="1p1d179" data-start="703" data-end="767">Suitable for industrial and commercial electrical applications</li>
<li data-section-id="s9jpm1" data-start="768" data-end="825">Designed for compatible 5A secondary metering equipment</li>
</ul>', '<h1>250/5A 42mm Current Transformer | Class 1.0 Metering CT</h1>
<p>The <strong>250/5A 42mm Current Transformer (CT)</strong> from <strong>MVG Power Solutions</strong> is designed for electrical current measurement, metering, monitoring, and compatible electrical panel applications. Featuring a <strong>250A primary current, 5A secondary current, Class 1.0 accuracy</strong>, and a <strong>42mm diameter/window</strong>, this Current Transformer provides a practical solution for electrical systems requiring a 250/5A CT ratio.</p>
<p>A Current Transformer is used to transform a higher primary current into a lower standardized secondary current that can be connected to compatible meters, measuring instruments, monitoring equipment, and electrical systems. This model provides a <strong>250/5A current ratio</strong>, meaning a primary current of 250A corresponds to a secondary current of 5A under rated operating conditions.</p>
<p>The <strong>250/5A 42mm Current Transformer</strong> is suitable for compatible metering and current measurement applications where a 5A secondary input is required.</p>
<h2>Key Features</h2>
<p>The 250/5A 42mm Current Transformer offers practical features for electrical measurement and monitoring applications:</p>
<ul>
<li><strong>250/5A current ratio</strong></li>
<li><strong>250A primary current</strong></li>
<li><strong>5A secondary current</strong></li>
<li><strong>Class 1.0 accuracy</strong></li>
<li><strong>42mm diameter/window</strong></li>
<li><strong>42 × 12 mm busbar window</strong></li>
<li><strong>2.5–15 VA rating</strong></li>
<li><strong>78 × 60 × 35 mm dimensions</strong></li>
<li>Encapsulated square-type construction</li>
<li>Compact CT design</li>
<li>Suitable for metering applications</li>
<li>Suitable for current measurement and monitoring</li>
<li>Suitable for compatible electrical panels and systems</li>
</ul>
<h2>Technical Specifications</h2>
<table>
<thead>
<tr>
<th>Parameter</th>
<th>Specification</th>
</tr>
</thead>
<tbody>
<tr>
<td>Product Type</td>
<td>Current Transformer</td>
</tr>
<tr>
<td>CT Type</td>
<td>Encapsulated Square Type</td>
</tr>
<tr>
<td>Primary Current</td>
<td>250A</td>
</tr>
<tr>
<td>Secondary Current</td>
<td>5A</td>
</tr>
<tr>
<td>Current Ratio</td>
<td>250/5A</td>
</tr>
<tr>
<td>Accuracy Class</td>
<td>Class 1.0</td>
</tr>
<tr>
<td>Diameter / Window</td>
<td>42 mm</td>
</tr>
<tr>
<td>Busbar Window</td>
<td>42 × 12 mm</td>
</tr>
<tr>
<td>Dimensions (H × L × W)</td>
<td>78 × 60 × 35 mm</td>
</tr>
<tr>
<td>VA Rating</td>
<td>2.5–15 VA</td>
</tr>
<tr>
<td>Application</td>
<td>Metering &amp; Current Measurement</td>
</tr>
</tbody>
</table>
<h2>Product Overview</h2>
<p>The <strong>250/5A 42mm Current Transformer</strong> is a compact <strong>Class 1.0 metering-class CT</strong> designed for suitable electrical current measurement and monitoring applications. It features a <strong>250A primary current</strong> and <strong>5A secondary current</strong>, providing a standardized secondary output for compatible metering and measurement equipment.</p>
<p>The encapsulated square-type construction provides a practical configuration for installation in compatible electrical panels and measurement systems. The design is suitable for applications where a defined CT window and compact overall dimensions are required.</p>
<p>This CT features a <strong>42mm diameter/window</strong> and a <strong>42 × 12 mm busbar window</strong>, allowing installation around compatible conductors or busbars. Before installation, the conductor or busbar dimensions should be checked against the available CT opening.</p>
<p>With <strong>Class 1.0 accuracy</strong>, this Current Transformer is designed for suitable metering and current measurement applications where the specified accuracy class is required. Its <strong>2.5–15 VA rating</strong> provides a specified burden range for compatible metering circuits based on the connected secondary load and system requirements.</p>
<p>The overall dimensions of <strong>78 × 60 × 35 mm (H × L × W)</strong> provide a compact form factor for compatible electrical panels, distribution equipment, monitoring systems, and other suitable installations.</p>
<h2>250/5A Current Transformer for Metering</h2>
<p>The <strong>250/5A CT</strong> is designed for applications where the primary current requirement is 250A and the connected measuring equipment requires a 5A secondary current.</p>
<p>The <strong>Class 1.0 accuracy</strong> makes this CT suitable for compatible metering and current measurement applications requiring the specified accuracy class.</p>
<p>The 5A secondary can be connected to compatible energy meters, panel meters, current measuring instruments, monitoring devices, and other electrical equipment designed for a 5A CT secondary.</p>
<p>When selecting a Current Transformer, the current ratio, accuracy class, burden, secondary current, physical dimensions, and window size should be checked against the requirements of the intended electrical installation.</p>
<h2>Applications</h2>
<p>The <strong>250/5A Class 1.0 Current Transformer</strong> can be used in compatible electrical measurement and monitoring applications, including:</p>
<ul>
<li>Energy metering systems</li>
<li>Electrical current measurement</li>
<li>Distribution panels</li>
<li>Electrical control panels</li>
<li>Power monitoring systems</li>
<li>Metering panels</li>
<li>Industrial electrical installations</li>
<li>Commercial electrical systems</li>
<li>Electrical monitoring equipment</li>
<li>Current monitoring systems</li>
<li>Load monitoring applications</li>
<li>Compatible energy measurement applications</li>
</ul>
<p>The CT should be selected according to the required primary current, secondary current, accuracy, burden, physical dimensions, window size, and electrical installation requirements.</p>
<h2>42mm Window and Busbar Design</h2>
<p>The Current Transformer features a <strong>42mm diameter/window</strong> along with a <strong>42 × 12 mm busbar window</strong>.</p>
<p>This opening is designed for compatible conductors and busbars. Before installation, users should verify the actual conductor or busbar dimensions and ensure that they are suitable for the CT opening.</p>
<p>The <strong>78 × 60 × 35 mm</strong> overall dimensions provide a compact form factor for compatible electrical panel installations.</p>
<h2>Class 1.0 Accuracy</h2>
<p>Accuracy class is an important specification when selecting a Current Transformer for metering and measurement applications.</p>
<p>The <strong>Class 1.0</strong> rating identifies the specified accuracy class of this CT under its applicable rated conditions. The <strong>250/5A ratio</strong> provides a 5A secondary output corresponding to a 250A primary current under rated operating conditions.</p>
<p>The CT should be selected according to the requirements of the electrical system and the specifications of the connected measuring equipment.</p>
<h2>2.5–15 VA Rating</h2>
<p>The <strong>250/5A 42mm Current Transformer</strong> has a specified <strong>2.5–15 VA rating</strong>.</p>
<p>VA rating relates to the burden connected to the CT secondary circuit, including compatible meters, measuring instruments, and associated wiring.</p>
<p>When selecting a Current Transformer, the connected secondary load should be considered to ensure that the CT is suitable for the intended metering circuit.</p>
<h2>Standard 5A Secondary</h2>
<p>The <strong>5A secondary current</strong> is suitable for compatible conventional CT meters, energy meters, panel meters, and electrical measuring equipment designed for a 5A CT input.</p>
<p>For this product, the rated ratio is <strong>250/5A</strong>. Under rated operating conditions, a 250A primary current corresponds to a 5A secondary current.</p>
<p>The secondary circuit should always be connected to compatible equipment and installed according to appropriate electrical installation and safety practices.</p>
<h2>Benefits of 250/5A Current Transformer</h2>
<h3>Accurate Current Measurement</h3>
<p>The <strong>Class 1.0 accuracy</strong> makes this CT suitable for compatible applications requiring the specified metering accuracy.</p>
<h3>Standard 5A Secondary</h3>
<p>The <strong>5A secondary output</strong> is suitable for compatible meters and current measurement equipment designed for a 5A CT secondary.</p>
<h3>Compact Design</h3>
<p>The <strong>78 × 60 × 35 mm</strong> dimensions provide a compact form factor for compatible electrical panel installations.</p>
<h3>42mm Window</h3>
<p>The <strong>42mm diameter/window</strong> and <strong>42 × 12 mm busbar window</strong> provide a defined opening for compatible conductor and busbar installations.</p>
<h3>Versatile Metering Applications</h3>
<p>The CT can be used in compatible energy metering, electrical monitoring, current measurement, and distribution-panel applications.</p>
<h2>250/5A CT for Electrical Panels</h2>
<p>The <strong>250/5A 42mm Current Transformer</strong> can be integrated into compatible electrical panels, metering systems, and current monitoring equipment.</p>
<p>Potential compatible equipment includes:</p>
<ul>
<li>Panel meters</li>
<li>Energy meters</li>
<li>Current meters</li>
<li>Power monitoring equipment</li>
<li>Electrical monitoring devices</li>
<li>Metering panels</li>
<li>Control panels</li>
<li>Distribution panels</li>
</ul>
<p>Before installation, verify that the connected equipment requires a <strong>5A CT secondary</strong> and that the CT window and overall dimensions are suitable for the intended application.</p>
<h2>Installation Considerations</h2>
<p>Before installing the <strong>250/5A Current Transformer</strong>, verify the electrical and mechanical requirements of the application.</p>
<p>Important parameters to check include:</p>
<ol>
<li>Primary current requirement</li>
<li>Secondary current requirement</li>
<li>Current ratio</li>
<li>Accuracy class</li>
<li>Connected burden</li>
<li>Conductor or busbar dimensions</li>
<li>CT window size</li>
<li>Available installation space</li>
<li>Meter compatibility</li>
<li>Electrical system requirements</li>
</ol>
<p>The Current Transformer should be installed by a qualified electrical professional following applicable electrical installation practices and the requirements of the connected equipment.</p>
<h2>Why Choose the 250/5A 42mm Current Transformer?</h2>
<p>The <strong>250/5A 42mm Class 1.0 Metering CT</strong> combines:</p>
<ul>
<li><strong>250A primary current</strong></li>
<li><strong>5A secondary current</strong></li>
<li><strong>250/5A current ratio</strong></li>
<li><strong>Class 1.0 accuracy</strong></li>
<li><strong>42mm diameter/window</strong></li>
<li><strong>42 × 12 mm busbar window</strong></li>
<li><strong>78 × 60 × 35 mm dimensions</strong></li>
<li><strong>2.5–15 VA rating</strong></li>
<li>Encapsulated square-type construction</li>
<li>Compact design</li>
<li>Suitable for metering and current measurement</li>
<li>Suitable for electrical panels and monitoring systems</li>
</ul>
<p>These specifications make the CT suitable for compatible electrical measurement, metering, monitoring, and panel applications requiring a <strong>250/5A Current Transformer</strong>.</p>
<h2>MVG Power Solutions – Current Transformer Supplier</h2>
<p><strong>MVG Power Solutions</strong> supplies Current Transformers and electrical measurement products for industrial, commercial, metering, panel-building, monitoring, and electrical distribution applications.</p>
<p>The <strong>250/5A 42mm Class 1.0 Metering Current Transformer</strong> is designed for applications requiring a <strong>250A primary current, 5A secondary output, 42mm window, 42 × 12 mm busbar opening, and Class 1.0 accuracy</strong>.</p>
<p>For bulk requirements, technical specifications, product availability, or quotations, contact MVG Power Solutions with your required quantity and application details.</p>
<h2>Product Summary</h2>
<p>The <strong>250/5A 42mm Current Transformer | Class 1.0 Metering CT</strong> features a <strong>250A primary current, 5A secondary current, Class 1.0 accuracy, 42mm diameter/window, 42 × 12 mm busbar window, 2.5–15 VA rating, and 78 × 60 × 35 mm dimensions</strong>.</p>
<p>It is designed for compatible <strong>electrical metering, current measurement, power monitoring, electrical panels, distribution systems, control panels, and industrial and commercial applications</strong> requiring a 250/5A Current Transformer.</p>
<h2>Frequently Asked Questions</h2>
<h3>What is the current ratio of this CT?</h3>
<p>The current ratio is <strong>250/5A</strong>, with a 250A primary current and 5A secondary current.</p>
<h3>What is the accuracy class?</h3>
<p>The Current Transformer has <strong>Class 1.0 accuracy</strong> as specified for this product.</p>
<h3>What is the secondary current?</h3>
<p>The secondary current is <strong>5A</strong>.</p>
<h3>What is the CT diameter?</h3>
<p>The specified diameter/window is <strong>42 mm</strong>.</p>
<h3>What is the busbar window size?</h3>
<p>The busbar window is <strong>42 × 12 mm</strong>.</p>
<h3>What are the dimensions?</h3>
<p>The dimensions are <strong>78 × 60 × 35 mm (H × L × W)</strong>.</p>
<h3>What is the VA rating?</h3>
<p>The specified VA rating is <strong>2.5–15 VA</strong>.</p>
<h3>Where can the 250/5A Current Transformer be used?</h3>
<p>It can be used in compatible metering, current measurement, electrical monitoring, distribution panels, control panels, and energy monitoring systems, subject to the electrical requirements of the installation.</p>', 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/250-5a-42mm-current-transformer-class-1-metering-ct.jpg', 0, 'published'),
(142, 2, 59, 1, '300/5A 32mm Current Transformer | Class 1.0 Metering CT', '300-5a-32mm-current-transformer', 'MVG-30-3210-1-1-1', 280.00, 280.00, 10, '85043100', 18.00, 'in_stock', '<ul>
<li data-section-id="1v5rcjp" data-start="83" data-end="114"><strong data-start="85" data-end="105">Primary Current:</strong> <strong data-start="106" data-end="114">300A</strong></li>
<li data-section-id="2dmbsl" data-start="115" data-end="146"><strong data-start="117" data-end="139">Secondary Current:</strong> <strong data-start="140" data-end="146">5A</strong></li>
<li data-section-id="76co2a" data-start="147" data-end="178"><strong data-start="149" data-end="167">Current Ratio:</strong> <strong data-start="168" data-end="178">300/5A</strong></li>
<li data-section-id="16yb7c0" data-start="179" data-end="214"><strong data-start="181" data-end="200">Accuracy Class:</strong> <strong data-start="201" data-end="214">Class 1.0</strong></li>
<li data-section-id="18zae6s" data-start="215" data-end="240"><strong data-start="217" data-end="230">Diameter:</strong> <strong data-start="231" data-end="240">32 mm</strong></li>
<li data-section-id="1qlojto" data-start="241" data-end="276"><strong data-start="243" data-end="261">Busbar Window:</strong> <strong data-start="262" data-end="276">32 × 10 mm</strong></li>
<li data-section-id="19km674" data-start="277" data-end="326"><strong data-start="279" data-end="306">Dimensions (H × L × W):</strong> <strong data-start="307" data-end="326">70 × 50 × 32 mm</strong></li>
<li data-section-id="10orlqj" data-start="327" data-end="357"><strong data-start="329" data-end="343">VA Rating:</strong> <strong data-start="344" data-end="357">2.5–15 VA</strong></li>
<li data-section-id="1qb0zja" data-start="358" data-end="392">Compact square-type construction</li>
<li data-section-id="18xu12i" data-start="393" data-end="417">Encapsulated CT design</li>
<li data-section-id="dfooz9" data-start="418" data-end="474">Designed for accurate metering and current measurement</li>
<li data-section-id="1nf6c48" data-start="475" data-end="530">Suitable for electrical panels and monitoring systems</li>
<li data-section-id="1p1d179" data-start="531" data-end="595">Suitable for industrial and commercial electrical applications</li>
<li data-section-id="1k6fqcr" data-start="596" data-end="653">Suitable for compatible 5A secondary metering equipment</li>
<li data-section-id="1uhpmn5" data-start="23" data-end="54"></li>
</ul>', '<h1>300/5A 32mm Current Transformer | Class 1.0 Metering CT</h1>
<p>The <strong>300/5A 32mm Current Transformer (CT)</strong> from <strong>MVG Power Solutions</strong> is designed for electrical current measurement, metering, monitoring, and compatible electrical panel applications. Featuring a <strong>300A primary current, 5A secondary current, Class 1.0 accuracy</strong>, and a compact <strong>32mm window</strong>, this Current Transformer provides a practical solution for electrical systems requiring a 300/5A CT ratio.</p>
<p>A Current Transformer is used to transform a higher primary current into a lower standardized secondary current. This allows compatible meters, monitoring equipment, and measuring instruments to measure electrical current safely and conveniently. In this model, the current ratio is <strong>300/5A</strong>, meaning a primary current of 300A corresponds to a secondary current of 5A under rated operating conditions.</p>
<p>The 300/5A configuration is suitable for applications where the connected measuring or metering equipment requires a <strong>5A CT secondary input</strong>.</p>
<h2>Key Features of 300/5A 32mm Current Transformer</h2>
<p>The <strong>300/5A Current Transformer</strong> features a <strong>Class 1.0 accuracy class</strong>, making it suitable for general-purpose current measurement and metering applications requiring the specified accuracy class.</p>
<p>The CT has a <strong>32mm diameter/window</strong> with a <strong>32 × 10 mm busbar window</strong>, providing an opening for compatible conductors or busbars. Its compact <strong>70 × 50 × 32 mm</strong> dimensions make it suitable for compatible electrical panels and installations where space is an important consideration.</p>
<p>The CT has a <strong>2.5–15 VA rated burden range</strong>, making it suitable for compatible meters and measuring equipment operating within the specified burden requirements.</p>
<h2>Technical Specifications</h2>
<table>
<thead>
<tr>
<th>Specification</th>
<th>Details</th>
</tr>
</thead>
<tbody>
<tr>
<td>Product Type</td>
<td>Current Transformer</td>
</tr>
<tr>
<td>Accuracy Class</td>
<td>Class 1.0</td>
</tr>
<tr>
<td>Current Ratio</td>
<td>300/5A</td>
</tr>
<tr>
<td>Primary Current</td>
<td>300A</td>
</tr>
<tr>
<td>Secondary Current</td>
<td>5A</td>
</tr>
<tr>
<td>Diameter / Window</td>
<td>32 mm</td>
</tr>
<tr>
<td>Busbar Window</td>
<td>32 × 10 mm</td>
</tr>
<tr>
<td>Dimensions (H × L × W)</td>
<td>70 × 50 × 32 mm</td>
</tr>
<tr>
<td>Rated Burden</td>
<td>2.5–15 VA</td>
</tr>
<tr>
<td>Construction</td>
<td>Compact / Encapsulated CT</td>
</tr>
<tr>
<td>Application</td>
<td>Metering &amp; Current Measurement</td>
</tr>
</tbody>
</table>
<h2>300/5A Current Transformer for Metering</h2>
<p>The <strong>300/5A 32mm Current Transformer</strong> is designed for electrical measurement applications where the primary current can reach 300A and the connected measuring equipment requires a 5A secondary input.</p>
<p>The <strong>Class 1.0 accuracy rating</strong> identifies the CT&#8217;s specified accuracy class under applicable rated conditions. This makes the CT suitable for compatible general-purpose metering and monitoring applications.</p>
<p>The 5A secondary output can be connected to compatible panel meters, energy meters, measuring instruments, monitoring equipment, and other electrical devices designed for a 5A CT secondary.</p>
<p>When selecting a Current Transformer, the required current ratio, accuracy class, burden, secondary current, window size, and physical dimensions should be checked against the requirements of the electrical system.</p>
<h2>Applications</h2>
<p>The <strong>300/5A Class 1.0 Current Transformer</strong> can be used in a variety of electrical measurement, metering, and monitoring applications.</p>
<p>Common applications include:</p>
<ul>
<li>Electrical energy metering</li>
<li>Current measurement</li>
<li>Electrical distribution panels</li>
<li>LT electrical panels</li>
<li>Control panels</li>
<li>Power monitoring systems</li>
<li>Industrial electrical installations</li>
<li>Commercial electrical systems</li>
<li>Load monitoring</li>
<li>Metering equipment</li>
<li>Electrical testing and measurement</li>
<li>Current monitoring systems</li>
<li>Panel monitoring applications</li>
</ul>
<h2>Compact 32mm CT Design</h2>
<p>The CT has overall dimensions of <strong>70 × 50 × 32 mm</strong>, providing a compact form factor for compatible panel installations.</p>
<p>The <strong>32mm window</strong> and <strong>32 × 10 mm busbar window</strong> provide a defined opening for suitable conductors and busbars. Before installation, the dimensions of the conductor or busbar should be checked to ensure compatibility with the CT opening.</p>
<p>The compact construction can be useful for panel builders, electrical contractors, system integrators, and businesses involved in electrical distribution, metering, and monitoring applications.</p>
<h2>Class 1.0 Accuracy</h2>
<p>The <strong>Class 1.0 accuracy class</strong> is an important specification for Current Transformers used in measurement and metering applications.</p>
<p>The <strong>300/5A ratio</strong> means that at a primary current of 300A, the corresponding rated secondary current is 5A under applicable operating conditions.</p>
<p>The required CT accuracy, ratio, burden, and secondary current should be selected according to the electrical system and connected measuring equipment.</p>
<h2>2.5–15 VA Burden Rating</h2>
<p>This model has a <strong>2.5–15 VA rated burden range</strong>.</p>
<p>Burden refers to the load connected to the secondary circuit of a Current Transformer, including the measuring instrument and associated wiring. The connected secondary load should be considered when selecting a CT for a particular installation.</p>
<p>For proper measurement performance, the CT should be used within its applicable rated specifications.</p>
<h2>5A Secondary Current</h2>
<p>The <strong>5A secondary output</strong> is commonly used with compatible conventional panel meters, energy meters, measuring instruments, and monitoring devices.</p>
<p>For this model, the rated current ratio is <strong>300/5A</strong>. At a primary current of 300A, the CT provides a corresponding rated secondary current of 5A under the specified operating conditions.</p>
<p>The secondary circuit should always be connected to compatible equipment and installed according to appropriate electrical safety practices.</p>
<h2>300/5A CT for Electrical Panels</h2>
<p>The compact <strong>300/5A CT</strong> can be integrated into compatible electrical panels and current monitoring systems.</p>
<p>It can be used with compatible:</p>
<ul>
<li>Panel meters</li>
<li>Energy meters</li>
<li>Current meters</li>
<li>Power monitoring equipment</li>
<li>Monitoring devices</li>
<li>Electrical measuring instruments</li>
<li>Control panels</li>
<li>Distribution panels</li>
</ul>
<p>Before installation, verify that the connected equipment requires a <strong>5A CT secondary</strong> and that the CT window and overall dimensions are suitable for the intended application.</p>
<h2>Installation Considerations</h2>
<p>Before installing the <strong>300/5A Current Transformer</strong>, verify the electrical and mechanical requirements of the application.</p>
<p>Important parameters to check include:</p>
<ol>
<li>Primary current requirement</li>
<li>Secondary current requirement</li>
<li>Current ratio</li>
<li>Accuracy class</li>
<li>Connected burden</li>
<li>Busbar or conductor dimensions</li>
<li>CT window size</li>
<li>Available installation space</li>
<li>Meter compatibility</li>
<li>Electrical system requirements</li>
</ol>
<p>The Current Transformer should be installed by a qualified electrical professional following applicable electrical installation practices and the requirements of the connected equipment.</p>
<h2>Why Choose the 300/5A 32mm Current Transformer?</h2>
<p>The <strong>300/5A 32mm Class 1.0 Metering CT</strong> combines the following specifications:</p>
<ul>
<li><strong>300A primary current</strong></li>
<li><strong>5A secondary current</strong></li>
<li><strong>300/5A current ratio</strong></li>
<li><strong>Class 1.0 accuracy</strong></li>
<li><strong>32mm diameter/window</strong></li>
<li><strong>32 × 10 mm busbar window</strong></li>
<li><strong>70 × 50 × 32 mm dimensions</strong></li>
<li><strong>2.5–15 VA burden rating</strong></li>
<li>Compact construction</li>
<li>Encapsulated CT design</li>
<li>Suitable for metering and current measurement</li>
<li>Suitable for electrical panels and monitoring systems</li>
</ul>
<p>These specifications make the CT suitable for compatible current measurement, metering, monitoring, and electrical panel applications requiring a <strong>300/5A Current Transformer</strong>.</p>
<h2>MVG Power Solutions – Current Transformer Supplier</h2>
<p><strong>MVG Power Solutions</strong> supplies Current Transformers and electrical measurement products for industrial, commercial, metering, panel-building, monitoring, and electrical distribution applications.</p>
<p>The <strong>300/5A 32mm Class 1.0 Metering Current Transformer</strong> is designed for applications requiring a 300A primary current, 5A secondary output, compact 32mm window, and Class 1.0 accuracy.</p>
<p>For bulk requirements, technical specifications, availability, or quotations, contact <strong>MVG Power Solutions</strong> with your required quantity and application details.</p>
<h2>Product Summary</h2>
<p>The <strong>300/5A 32mm Current Transformer | Class 1.0 Metering CT</strong> features a <strong>300A primary current, 5A secondary current, Class 1.0 accuracy, 32mm diameter/window, 32 × 10 mm busbar window, 2.5–15 VA burden, and 70 × 50 × 32 mm dimensions</strong>.</p>
<p>It is designed for compatible <strong>electrical metering, current measurement, power monitoring, electrical panels, distribution systems, and industrial and commercial applications</strong> requiring a 300/5A Current Transformer.</p>', 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/300-5a-32mm-current-transformer-class-1-metering-ct.jpg', 0, 'published'),
(139, 2, 59, 1, '250/5A 32mm Current Transformer | Class 1.0 Metering CT', '250-5a-32mm-current-transformer', 'MVG-30-3210-1-1', 280.00, 280.00, 10, '85043100', 18.00, 'in_stock', '<ul>
<li data-section-id="1uhpmn5" data-start="23" data-end="54"><strong data-start="25" data-end="45">Primary Current:</strong> <strong data-start="46" data-end="54" data-is-only-node="">250A</strong></li>
<li data-section-id="2dmbsl" data-start="55" data-end="86"><strong data-start="57" data-end="79">Secondary Current:</strong> <strong data-start="80" data-end="86" data-is-only-node="">5A</strong></li>
<li data-section-id="118e186" data-start="87" data-end="118"><strong data-start="89" data-end="107">Current Ratio:</strong> <strong data-start="108" data-end="118" data-is-only-node="">250/5A</strong></li>
<li data-section-id="16yb7c0" data-start="119" data-end="154"><strong data-start="121" data-end="140">Accuracy Class:</strong> <strong data-start="141" data-end="154" data-is-only-node="">Class 1.0</strong></li>
<li data-section-id="18zae6s" data-start="155" data-end="180"><strong data-start="157" data-end="170">Diameter:</strong> <strong data-start="171" data-end="180" data-is-only-node="">32 mm</strong></li>
<li data-section-id="1qlojto" data-start="181" data-end="216"><strong data-start="183" data-end="201">Busbar Window:</strong> <strong data-start="202" data-end="216" data-is-only-node="">32 × 10 mm</strong></li>
<li data-section-id="19km674" data-start="217" data-end="266"><strong data-start="219" data-end="246">Dimensions (H × L × W):</strong> <strong data-start="247" data-end="266" data-is-only-node="">70 × 50 × 32 mm</strong></li>
<li data-section-id="10orlqj" data-start="267" data-end="297"><strong data-start="269" data-end="283">VA Rating:</strong> <strong data-start="284" data-end="297" data-is-only-node="">2.5–15 VA</strong></li>
<li data-section-id="1qb0zja" data-start="298" data-end="332">Compact square-type construction</li>
<li data-section-id="18xu12i" data-start="333" data-end="357">Encapsulated CT design</li>
<li data-section-id="dfooz9" data-start="358" data-end="414">Designed for accurate metering and current measurement</li>
<li data-section-id="1nf6c48" data-start="415" data-end="470">Suitable for electrical panels and monitoring systems</li>
<li data-section-id="1p1d179" data-start="471" data-end="535">Suitable for industrial and commercial electrical applications</li>
<li data-section-id="1k6fqcr" data-start="536" data-end="593" data-is-last-node="">Suitable for compatible 5A secondary metering equipment</li>
</ul>', '<h1>250/5A 32mm Current Transformer | Class 1.0 Metering CT</h1>
<p>The <strong>250/5A 32mm Current Transformer (CT)</strong> from <strong>MVG Power Solutions</strong> is designed for accurate current measurement, electrical metering, monitoring, and control applications. With a <strong>250A primary current, 5A secondary current, Class 1.0 accuracy</strong>, and a compact <strong>32mm window</strong>, this current transformer is suitable for a wide range of electrical panel and distribution applications.</p>
<p>A Current Transformer is used to transform a higher primary current into a lower standardized secondary current that can be safely measured by compatible meters, monitoring instruments, and electrical equipment. This model provides a <strong>250/5A current ratio</strong>, meaning a primary current of 250A corresponds to a secondary current of 5A under rated operating conditions.</p>
<p>The <strong>250/5A CT</strong> is suitable for applications where electrical current needs to be monitored or measured through compatible equipment with a 5A CT secondary input.</p>
<h2>Key Features of 250/5A 32mm Current Transformer</h2>
<p>The <strong>250/5A Current Transformer</strong> features a <strong>Class 1.0 accuracy rating</strong>, making it suitable for general-purpose metering and current measurement applications where the specified accuracy class is required.</p>
<p>The CT is designed with a <strong>32mm diameter/window</strong> and a <strong>32 × 10 mm busbar window</strong>, allowing installation around compatible conductors or busbars.</p>
<p>Its compact <strong>70 × 50 × 32 mm dimensions</strong> make it suitable for electrical panels and installations where available space needs to be considered.</p>
<p>The CT also has a <strong>2.5–15 VA rated burden range</strong>, allowing it to be used with compatible meters and measurement equipment within the specified burden requirements.</p>
<h2>Technical Specifications</h2>
<table>
<thead>
<tr>
<th>Specification</th>
<th>Details</th>
</tr>
</thead>
<tbody>
<tr>
<td>Product Type</td>
<td>Current Transformer</td>
</tr>
<tr>
<td>Accuracy Class</td>
<td>Class 1.0</td>
</tr>
<tr>
<td>Current Ratio</td>
<td>250/5A</td>
</tr>
<tr>
<td>Primary Current</td>
<td>250A</td>
</tr>
<tr>
<td>Secondary Current</td>
<td>5A</td>
</tr>
<tr>
<td>Diameter / Window</td>
<td>32 mm</td>
</tr>
<tr>
<td>Busbar Window</td>
<td>32 × 10 mm</td>
</tr>
<tr>
<td>Dimensions (H × L × W)</td>
<td>70 × 50 × 32 mm</td>
</tr>
<tr>
<td>Rated Burden</td>
<td>2.5–15 VA</td>
</tr>
<tr>
<td>Construction</td>
<td>Compact / Encapsulated CT</td>
</tr>
<tr>
<td>Application</td>
<td>Metering &amp; Current Measurement</td>
</tr>
</tbody>
</table>
<h2>250/5A Current Transformer for Metering</h2>
<p>The <strong>250/5A 32mm Current Transformer</strong> is designed for electrical measurement applications where the primary current can reach 250A and the connected measuring equipment requires a 5A CT secondary input.</p>
<p>With its <strong>Class 1.0 accuracy</strong>, the CT is suitable for general metering and monitoring applications requiring the specified accuracy class.</p>
<p>The 5A secondary output can be connected to compatible panel meters, energy meters, current measuring instruments, monitoring devices, and other electrical equipment designed for a 5A CT input.</p>
<p>When selecting a Current Transformer, the current ratio, accuracy class, burden, secondary current, window dimensions, and physical size should be matched with the requirements of the electrical system.</p>
<h2>Applications of 250/5A 32mm CT</h2>
<p>The <strong>250/5A Class 1.0 Current Transformer</strong> can be used in a variety of electrical measurement, monitoring, and metering applications.</p>
<p>Common applications include:</p>
<ul>
<li>Electrical energy metering</li>
<li>Current measurement</li>
<li>Electrical distribution panels</li>
<li>LT electrical panels</li>
<li>Control panels</li>
<li>Power monitoring systems</li>
<li>Industrial electrical systems</li>
<li>Commercial electrical installations</li>
<li>Load monitoring</li>
<li>Metering equipment</li>
<li>Electrical testing and measurement</li>
<li>Current monitoring systems</li>
<li>Panel monitoring applications</li>
</ul>
<h2>Compact 32mm Current Transformer Design</h2>
<p>The CT has overall dimensions of <strong>70 × 50 × 32 mm</strong>, providing a compact form factor for compatible electrical panel applications.</p>
<p>The <strong>32mm window</strong> and <strong>32 × 10 mm busbar window</strong> provide a defined opening for compatible conductors and busbars. Before installation, the conductor or busbar dimensions should be checked to ensure proper compatibility with the CT.</p>
<p>Its compact construction can be useful for panel builders, electrical contractors, system integrators, and businesses involved in electrical distribution and measurement applications.</p>
<h2>Class 1.0 Accuracy</h2>
<p>The <strong>Class 1.0 accuracy class</strong> is an important specification for applications involving electrical current measurement and metering.</p>
<p>The 250/5A ratio allows the CT to transform a primary current of <strong>250A</strong> into a corresponding secondary current of <strong>5A</strong> under rated operating conditions.</p>
<p>The CT should be selected according to the electrical system requirements and connected equipment specifications. The required current ratio, accuracy class, burden, secondary current, and physical dimensions should all be considered before installation.</p>
<h2>2.5–15 VA Burden Rating</h2>
<p>The <strong>250/5A 32mm Current Transformer</strong> has a rated burden range of <strong>2.5–15 VA</strong>.</p>
<p>Burden refers to the load connected to the CT secondary circuit, including the measuring instrument, meter, and associated wiring. Selecting a CT with an appropriate burden specification is important for maintaining the required measurement performance.</p>
<p>The connected secondary load should remain within the applicable specifications of the selected CT.</p>
<h2>5A Secondary Current</h2>
<p>The <strong>5A secondary output</strong> is widely used with compatible conventional current meters, energy meters, panel meters, and electrical measuring instruments.</p>
<p>For this model, the rated current ratio is <strong>250/5A</strong>. This means that at a primary current of 250A, the CT provides a corresponding rated secondary current of 5A under the applicable operating conditions.</p>
<p>The secondary circuit should always be connected to compatible equipment and installed according to appropriate electrical safety practices.</p>
<h2>250/5A CT for Electrical Panels</h2>
<p>The compact design of the <strong>250/5A CT</strong> makes it suitable for integration into compatible electrical panels and monitoring systems.</p>
<p>It can be used with compatible:</p>
<ul>
<li>Panel meters</li>
<li>Energy meters</li>
<li>Current meters</li>
<li>Monitoring devices</li>
<li>Power monitoring systems</li>
<li>Electrical measurement instruments</li>
<li>Control and monitoring panels</li>
</ul>
<p>Before purchasing or installing the CT, verify that the equipment requires a <strong>5A CT secondary</strong> and that the CT window and dimensions are suitable for the intended installation.</p>
<h2>Installation Considerations</h2>
<p>Before installing the <strong>250/5A Current Transformer</strong>, verify all electrical and mechanical requirements of the application.</p>
<p>Important parameters to check include:</p>
<ol>
<li>Primary current requirement</li>
<li>Secondary current requirement</li>
<li>Current ratio</li>
<li>Accuracy class</li>
<li>Connected burden</li>
<li>Busbar or conductor dimensions</li>
<li>CT window size</li>
<li>Available installation space</li>
<li>Compatibility with the connected meter</li>
<li>Electrical system requirements</li>
</ol>
<p>The Current Transformer should be installed by a qualified electrical professional following applicable electrical installation practices and the requirements of the connected equipment.</p>
<h2>Why Choose the 250/5A 32mm Current Transformer?</h2>
<p>The <strong>250/5A 32mm Class 1.0 Metering CT</strong> combines several specifications required for electrical measurement applications:</p>
<ul>
<li><strong>250A primary current</strong></li>
<li><strong>5A secondary current</strong></li>
<li><strong>250/5A current ratio</strong></li>
<li><strong>Class 1.0 accuracy</strong></li>
<li><strong>32mm diameter/window</strong></li>
<li><strong>32 × 10 mm busbar window</strong></li>
<li><strong>70 × 50 × 32 mm dimensions</strong></li>
<li><strong>2.5–15 VA burden rating</strong></li>
<li>Compact construction</li>
<li>Suitable for metering and current measurement</li>
<li>Suitable for electrical panels and monitoring systems</li>
</ul>
<p>These specifications make this CT suitable for compatible electrical metering, monitoring, and current measurement requirements where a 250/5A configuration is required.</p>
<h2>MVG Power Solutions – Current Transformer Supplier</h2>
<p><strong>MVG Power Solutions</strong> supplies Current Transformers and electrical measurement products for industrial, commercial, electrical panel, metering, monitoring, and distribution applications.</p>
<p>The <strong>250/5A 32mm Class 1.0 Metering Current Transformer</strong> is designed for customers requiring a 250A primary, 5A secondary, compact 32mm window, and Class 1.0 accuracy configuration.</p>
<p>For bulk requirements, technical specifications, availability, or quotations, contact <strong>MVG Power Solutions</strong> with your required quantity and application details.</p>
<h2>Product Summary</h2>
<p>The <strong>250/5A 32mm Current Transformer | Class 1.0 Metering CT</strong> features a <strong>250A primary current, 5A secondary current, Class 1.0 accuracy, 32mm diameter/window, 32 × 10 mm busbar window, 2.5–15 VA burden, and 70 × 50 × 32 mm dimensions</strong>.</p>
<p>It is designed for compatible <strong>electrical metering, current measurement, power monitoring, electrical panels, distribution systems, and industrial and commercial applications</strong> requiring a 250/5A Current Transformer.</p>', 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/250-5a-32mm-current-transformer-class-1-metering-ct.jpg', 0, 'published'),
(136, 2, 59, 1, '200/5A 32mm Current Transformer | Class 1.0 Metering CT', '200-5a-32mm-current-transformer', 'MVG-30-3210-1', 280.00, 280.00, 10, '85043100', 18.00, 'in_stock', '<ul>
<li data-section-id="1ujvbz8" data-start="23" data-end="54"><strong data-start="25" data-end="45">Primary Current:</strong> <strong data-start="46" data-end="54" data-is-only-node="">200A</strong></li>
<li data-section-id="2dmbsl" data-start="55" data-end="86"><strong data-start="57" data-end="79">Secondary Current:</strong> <strong data-start="80" data-end="86" data-is-only-node="">5A</strong></li>
<li data-section-id="vb05mb" data-start="87" data-end="118"><strong data-start="89" data-end="107">Current Ratio:</strong> <strong data-start="108" data-end="118" data-is-only-node="">200/5A</strong></li>
<li data-section-id="16yb7c0" data-start="119" data-end="154"><strong data-start="121" data-end="140">Accuracy Class:</strong> <strong data-start="141" data-end="154" data-is-only-node="">Class 1.0</strong></li>
<li data-section-id="18zae6s" data-start="155" data-end="180"><strong data-start="157" data-end="170">Diameter:</strong> <strong data-start="171" data-end="180" data-is-only-node="">32 mm</strong></li>
<li data-section-id="1qlojto" data-start="181" data-end="216"><strong data-start="183" data-end="201">Busbar Window:</strong> <strong data-start="202" data-end="216" data-is-only-node="">32 × 10 mm</strong></li>
<li data-section-id="r31cc2" data-start="217" data-end="254"><strong data-start="219" data-end="234">Dimensions:</strong> <strong data-start="235" data-end="254" data-is-only-node="">70 × 50 × 32 mm</strong></li>
<li data-section-id="10orlqj" data-start="255" data-end="285"><strong data-start="257" data-end="271">VA Rating:</strong> <strong data-start="272" data-end="285" data-is-only-node="">2.5–15 VA</strong></li>
<li data-section-id="1qb0zja" data-start="286" data-end="320">Compact square-type construction</li>
<li data-section-id="18xu12i" data-start="321" data-end="345">Encapsulated CT design</li>
<li data-section-id="dfooz9" data-start="346" data-end="402">Designed for accurate metering and current measurement</li>
<li data-section-id="1nf6c48" data-start="403" data-end="458">Suitable for electrical panels and monitoring systems</li>
<li data-section-id="1p1d179" data-start="459" data-end="523" data-is-last-node="">Suitable for industrial and commercial electrical applications</li>
</ul>', '<h1>200/5A 32mm Current Transformer | Class 1.0 Metering CT</h1>
<p>The <strong>200/5A 32mm Current Transformer (CT)</strong> from <strong>MVG Power Solutions</strong> is designed for accurate electrical current measurement, metering, monitoring, and electrical panel applications. With a <strong>200A primary current, 5A secondary current, Class 1.0 accuracy</strong>, and a compact <strong>32mm window</strong>, this current transformer provides a practical solution for measuring current in electrical distribution and monitoring systems.</p>
<p>A Current Transformer is used to transform a higher primary current into a lower standardized secondary current that can be safely measured by compatible meters, monitoring equipment, and electrical instruments. In this model, a primary current of <strong>200A corresponds to a secondary current of 5A</strong> under rated operating conditions.</p>
<p>The <strong>200/5A CT</strong> is suitable for applications where a 5A secondary current input is required for metering and measurement equipment.</p>
<h2>Key Features of 200/5A 32mm Current Transformer</h2>
<p>This current transformer features a <strong>200/5A current ratio</strong> and <strong>Class 1.0 accuracy</strong>, making it suitable for general-purpose electrical metering and current measurement applications.</p>
<p>The CT has a <strong>32mm diameter/window</strong> with a <strong>32 × 10 mm busbar window</strong>, providing an opening for compatible conductors or busbars. Its compact <strong>70 × 50 × 32 mm</strong> dimensions make it suitable for installation in electrical panels and other space-conscious applications.</p>
<p>The CT has a <strong>2.5–15 VA rated burden range</strong>, allowing it to be used with compatible measuring and metering equipment within the specified burden requirements.</p>
<h2>Technical Specifications</h2>
<table>
<thead>
<tr>
<th>Specification</th>
<th>Details</th>
</tr>
</thead>
<tbody>
<tr>
<td>Product Type</td>
<td>Current Transformer</td>
</tr>
<tr>
<td>Accuracy Class</td>
<td>Class 1.0</td>
</tr>
<tr>
<td>Current Ratio</td>
<td>200/5A</td>
</tr>
<tr>
<td>Primary Current</td>
<td>200A</td>
</tr>
<tr>
<td>Secondary Current</td>
<td>5A</td>
</tr>
<tr>
<td>Diameter / Window</td>
<td>32 mm</td>
</tr>
<tr>
<td>Busbar Window</td>
<td>32 × 10 mm</td>
</tr>
<tr>
<td>Dimensions (H × L × W)</td>
<td>70 × 50 × 32 mm</td>
</tr>
<tr>
<td>Rated Burden</td>
<td>2.5–15 VA</td>
</tr>
<tr>
<td>Construction</td>
<td>Compact / Encapsulated CT</td>
</tr>
<tr>
<td>Application</td>
<td>Metering &amp; Current Measurement</td>
</tr>
</tbody>
</table>
<h2>200/5A Current Transformer for Metering</h2>
<p>The <strong>200/5A 32mm Current Transformer</strong> is designed for electrical measurement applications where the primary current can reach 200A and the connected measuring equipment requires a 5A CT secondary input.</p>
<p>The <strong>Class 1.0 accuracy rating</strong> makes this CT suitable for general metering and monitoring applications requiring the specified accuracy class. It can be integrated with compatible energy meters, panel meters, measuring instruments, and electrical monitoring equipment.</p>
<p>When selecting a CT for an installation, the current ratio, accuracy class, burden, secondary current, window size, and physical dimensions should be matched with the requirements of the electrical system and connected equipment.</p>
<h2>Applications</h2>
<p>The 200/5A 32mm Current Transformer can be used in a variety of electrical measurement and monitoring applications.</p>
<p>Typical applications include:</p>
<ul>
<li>Electrical energy metering</li>
<li>Current measurement</li>
<li>Electrical distribution panels</li>
<li>LT electrical panels</li>
<li>Control panels</li>
<li>Power monitoring systems</li>
<li>Industrial electrical installations</li>
<li>Commercial electrical systems</li>
<li>Load monitoring</li>
<li>Metering equipment</li>
<li>Electrical testing and measurement</li>
<li>Current monitoring systems</li>
</ul>
<h2>Compact 32mm CT Design</h2>
<p>The compact <strong>70 × 50 × 32 mm</strong> design allows the current transformer to be installed in suitable electrical panels and equipment where installation space is limited.</p>
<p>The <strong>32 × 10 mm busbar window</strong> provides a defined opening for compatible busbars. Before installation, the user should confirm the dimensions of the conductor or busbar and ensure that they are compatible with the CT window.</p>
<p>The compact construction also makes the CT suitable for panel builders, electrical contractors, system integrators, and businesses involved in electrical distribution and monitoring applications.</p>
<h2>Class 1.0 Metering Accuracy</h2>
<p>Accuracy class is an important consideration when selecting a current transformer for metering applications. The <strong>Class 1.0</strong> rating identifies the specified accuracy class of the CT under its applicable rated operating conditions.</p>
<p>The 200/5A ratio allows a primary current of up to <strong>200A</strong> to be represented by a corresponding <strong>5A secondary current</strong>, which can then be supplied to compatible measuring and metering equipment.</p>
<p>The CT should always be selected according to the actual system requirements, including primary current, secondary current, connected burden, accuracy requirement, and installation configuration.</p>
<h2>2.5–15 VA Burden Rating</h2>
<p>This model is available with a <strong>2.5–15 VA rated burden range</strong>. Burden represents the load connected to the secondary circuit of a current transformer, including the connected meter, measuring instrument, and associated wiring.</p>
<p>For reliable measurement performance, the connected secondary load should be considered when selecting the appropriate CT specification.</p>
<h2>200/5A CT for Electrical Panels</h2>
<p>The <strong>200/5A 32mm CT</strong> is suitable for electrical panels where current measurement and monitoring are required. Its compact dimensions and 32mm window can make it convenient for integration into compatible panel designs.</p>
<p>It can be used with compatible panel meters, energy meters, monitoring devices, and other electrical measurement equipment designed for a <strong>5A CT secondary input</strong>.</p>
<h2>Why Choose the 200/5A 32mm Current Transformer?</h2>
<p>The 200/5A CT provides a combination of:</p>
<ul>
<li><strong>200/5A current ratio</strong></li>
<li><strong>Class 1.0 accuracy</strong></li>
<li><strong>5A standardized secondary output</strong></li>
<li><strong>32mm window</strong></li>
<li><strong>32 × 10 mm busbar opening</strong></li>
<li><strong>2.5–15 VA burden range</strong></li>
<li><strong>70 × 50 × 32 mm compact dimensions</strong></li>
<li>Suitable construction for panel and metering applications</li>
</ul>
<p>These specifications make the CT suitable for various current measurement, metering, and monitoring requirements where a 200A primary and 5A secondary configuration is required.</p>
<h2>Installation Considerations</h2>
<p>Before installing a current transformer, verify the required primary current ratio and ensure that the CT specifications match the electrical system.</p>
<p>The following parameters should be checked before installation:</p>
<ol>
<li>Required primary current</li>
<li>Required secondary current</li>
<li>Accuracy class</li>
<li>Connected burden</li>
<li>Conductor or busbar dimensions</li>
<li>CT window size</li>
<li>Available panel installation space</li>
<li>Compatibility with the connected meter or measuring device</li>
</ol>
<p>For safe installation and operation, the CT should be installed by a qualified electrical professional according to applicable electrical installation practices and the requirements of the connected equipment.</p>
<h2>MVG Power Solutions – Current Transformer Supplier</h2>
<p><strong>MVG Power Solutions</strong> supplies Current Transformers and electrical measurement products for industrial, commercial, metering, panel-building, and electrical distribution applications.</p>
<p>The <strong>200/5A 32mm Class 1.0 Metering Current Transformer</strong> is suitable for customers looking for a compact CT with a 5A secondary output, 32mm window, and 2.5–15 VA burden range.</p>
<p>For bulk requirements, technical specifications, product availability, or quotations, contact <strong>MVG Power Solutions</strong> with your required quantity and application details.</p>
<h2>Product Summary</h2>
<p>The <strong>200/5A 32mm Current Transformer | Class 1.0 Metering CT</strong> features a <strong>200A primary current, 5A secondary current, Class 1.0 accuracy, 32mm diameter/window, 32 × 10 mm busbar window, 2.5–15 VA burden, and 70 × 50 × 32 mm dimensions</strong>.</p>
<p>It is designed for compatible <strong>electrical metering, current measurement, monitoring, control panels, electrical distribution systems, and industrial applications</strong> requiring a 200/5A Current Transformer.</p>', 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/200-5a-32mm-current-transformer-class-1-metering-ct.jpg', 0, 'published'),
(131, 2, 59, 1, '50/5A 32mm Current Transformer | Class 1.0 Metering CT', '50-5a-32mm-current-transformer', 'MVG-30-3210', 280.00, 280.00, 10, '85043100', 18.00, 'in_stock', '<ul>
<li data-section-id="6atlgz" data-start="23" data-end="53"><strong data-start="25" data-end="45">Primary Current:</strong> <strong data-start="46" data-end="53" data-is-only-node="">50A</strong></li>
<li data-section-id="2dmbsl" data-start="54" data-end="85"><strong data-start="56" data-end="78">Secondary Current:</strong> <strong data-start="79" data-end="85" data-is-only-node="">5A</strong></li>
<li data-section-id="1yax5fo" data-start="86" data-end="116"><strong data-start="88" data-end="106">Current Ratio:</strong> <strong data-start="107" data-end="116" data-is-only-node="">50/5A</strong></li>
<li data-section-id="16yb7c0" data-start="117" data-end="152"><strong data-start="119" data-end="138">Accuracy Class:</strong> <strong data-start="139" data-end="152" data-is-only-node="">Class 1.0</strong></li>
<li data-section-id="18zae6s" data-start="153" data-end="178"><strong data-start="155" data-end="168">Diameter:</strong> <strong data-start="169" data-end="178" data-is-only-node="">32 mm</strong></li>
<li data-section-id="1qlojto" data-start="179" data-end="214"><strong data-start="181" data-end="199">Busbar Window:</strong> <strong data-start="200" data-end="214" data-is-only-node="">32 × 10 mm</strong></li>
<li data-section-id="r31cc2" data-start="215" data-end="252"><strong data-start="217" data-end="232">Dimensions:</strong> <strong data-start="233" data-end="252" data-is-only-node="">70 × 50 × 32 mm</strong></li>
<li data-section-id="10orlqj" data-start="253" data-end="283"><strong data-start="255" data-end="269">VA Rating:</strong> <strong data-start="270" data-end="283" data-is-only-node="">2.5–15 VA</strong></li>
<li data-section-id="1qb0zja" data-start="284" data-end="318">Compact square-type construction</li>
<li data-section-id="18xu12i" data-start="319" data-end="343">Encapsulated CT design</li>
<li data-section-id="dfooz9" data-start="344" data-end="400">Designed for accurate metering and current measurement</li>
<li data-section-id="1nf6c48" data-start="401" data-end="456">Suitable for electrical panels and monitoring systems</li>
<li data-section-id="1p1d179" data-start="457" data-end="521" data-is-last-node="">Suitable for industrial and commercial electrical applications</li>
</ul>', '<h1>50/5A 32mm Current Transformer | Class 1.0 Metering CT</h1>
<p class="isSelectedEnd">The <strong>50/5A 32mm Current Transformer (CT)</strong> from <strong>MVG Power Solutions</strong> is designed for reliable and accurate measurement of electrical current in metering, monitoring, and electrical control applications. With a <strong>50A primary current, 5A secondary current, Class 1.0 accuracy, and 32mm window</strong>, this current transformer provides a practical solution for measuring and monitoring current in electrical distribution systems.</p>
<p class="isSelectedEnd">Current transformers are commonly used to reduce high primary current to a standardized, measurable secondary current that can be safely connected to measuring instruments, energy meters, protection devices, and monitoring equipment. This <strong>50/5A CT</strong> converts a primary current of up to 50A to a 5A secondary output, making it suitable for applications where a 5A secondary current is required.</p>
<h2>50/5A Current Transformer – Key Features</h2>
<p class="isSelectedEnd">The CT is configured with a <strong>50/5A current ratio</strong>, meaning that when the primary current reaches 50A, the corresponding secondary current is 5A under rated operating conditions. Its <strong>Class 1.0 accuracy</strong> makes it suitable for general-purpose metering and measurement applications where dependable current measurement is required.</p>
<p class="isSelectedEnd">The transformer features a <strong>32mm diameter/window</strong> and a <strong>32 × 10 mm busbar window</strong>, allowing it to be installed around compatible conductors or busbars. Its compact <strong>70 × 50 × 32 mm</strong> dimensions make it suitable for electrical panels and installations where available space needs to be considered.</p>
<p class="isSelectedEnd">The CT supports a <strong>rated burden range of 2.5 to 15 VA</strong>, providing flexibility for different connected metering and measurement equipment within the specified operating conditions.</p>
<h2>Technical Specifications</h2>
<table>
<tbody>
<tr>
<th>Specification</th>
<th>Details</th>
</tr>
<tr>
<td>Product Type</td>
<td>Current Transformer</td>
</tr>
<tr>
<td>Accuracy Class</td>
<td>Class 1.0</td>
</tr>
<tr>
<td>Current Ratio</td>
<td>50/5A</td>
</tr>
<tr>
<td>Primary Current</td>
<td>50A</td>
</tr>
<tr>
<td>Secondary Current</td>
<td>5A</td>
</tr>
<tr>
<td>Diameter / Window</td>
<td>32 mm</td>
</tr>
<tr>
<td>Busbar Window</td>
<td>32 × 10 mm</td>
</tr>
<tr>
<td>Dimensions (H × L × W)</td>
<td>70 × 50 × 32 mm</td>
</tr>
<tr>
<td>Rated Burden</td>
<td>2.5 to 15 VA</td>
</tr>
<tr>
<td>Application</td>
<td>Metering &amp; Current Measurement</td>
</tr>
</tbody>
</table>
<h2>Applications of 50/5A 32mm CT</h2>
<p class="isSelectedEnd">The <strong>50/5A 32mm Current Transformer</strong> can be used across a variety of electrical measurement and monitoring applications. Typical applications include electrical distribution panels, control panels, energy metering systems, power monitoring equipment, industrial electrical systems, and current measurement installations.</p>
<p class="isSelectedEnd">It can be used with compatible meters and measuring instruments that require a <strong>5A CT secondary</strong>. The 32mm window and compact construction can make the CT convenient for installations involving suitable cables, conductors, and busbars.</p>
<h3>Common applications include:</h3>
<ul data-spread="false">
<li>Electrical energy metering</li>
<li>Current measurement</li>
<li>Electrical distribution panels</li>
<li>LT electrical panels</li>
<li>Control and monitoring panels</li>
<li>Power monitoring systems</li>
<li>Industrial electrical installations</li>
<li>Metering equipment</li>
<li>Load monitoring systems</li>
<li>Electrical testing and measurement</li>
</ul>
<h2>Why Choose a Class 1.0 Metering CT?</h2>
<p class="isSelectedEnd">Accuracy is an important consideration when selecting a current transformer for measurement applications. The <strong>Class 1.0 rating</strong> indicates the specified accuracy class of the CT under applicable rated conditions. This makes the product suitable for general metering and monitoring requirements where Class 1.0 measurement accuracy is required.</p>
<p class="isSelectedEnd">The <strong>5A secondary output</strong> is also widely used with conventional current-measuring instruments and meters designed for CT secondary inputs. When selecting a CT, the ratio, accuracy class, burden, physical dimensions, and installation window should be matched with the requirements of the electrical system.</p>
<h2>Compact 32mm Design</h2>
<p class="isSelectedEnd">With an overall size of <strong>70 × 50 × 32 mm</strong>, this current transformer provides a compact form factor for panel-based applications. The <strong>32 × 10 mm busbar window</strong> provides a defined opening for compatible busbar installation.</p>
<p class="isSelectedEnd">Before installation, users should verify the conductor or busbar dimensions, CT ratio, secondary requirement, burden, accuracy class, and available installation space to ensure compatibility with the intended electrical system.</p>
<h2>Reliable Current Measurement Solution</h2>
<p class="isSelectedEnd">The <strong>50/5A 32mm Class 1.0 Current Transformer</strong> is a practical solution for electrical current measurement where a 50A primary and 5A secondary configuration is required. Its Class 1.0 accuracy, 32mm window, 2.5–15 VA burden range, and compact 70 × 50 × 32 mm dimensions make it suitable for a range of metering and monitoring installations.</p>
<p class="isSelectedEnd"><strong>MVG Power Solutions</strong> supplies current transformers and electrical measurement products for industrial, commercial, panel-building, metering, and electrical distribution requirements. For product selection, bulk requirements, technical specifications, or quotations, contact MVG Power Solutions with your application and quantity requirements.</p>
<h2>Product Summary</h2>
<p>The <strong>50/5A 32mm Current Transformer | Class 1.0 Metering CT</strong> combines a <strong>50/5A current ratio</strong>, <strong>5A secondary output</strong>, <strong>Class 1.0 accuracy</strong>, <strong>32mm diameter/window</strong>, <strong>32 × 10 mm busbar window</strong>, and <strong>2.5–15 VA rated burden</strong> in a compact <strong>70 × 50 × 32 mm</strong> design. It is intended for current measurement, metering, monitoring, and compatible electrical panel applications.</p>', 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/50-5a-32mm-current-transformer-class-1-metering-ct.jpg', 0, 'published'),
(128, 2, 59, 1, '200/5A 22mm Current Transformer | Class 1.0 Metering CT', '200-5a-22mm-current-transformer', 'MVG-20-2210-3', 280.00, 280.00, 10, '85043100', 18.00, 'in_stock', '<ul>
<li><strong>Primary Current:</strong> <strong>200A</strong></li>
<li><strong>Secondary Current:</strong> <strong>5A</strong></li>
<li><strong>Current Ratio:</strong> <strong>200/5A</strong></li>
<li><strong>Accuracy Class:</strong> <strong>Class 1.0</strong></li>
<li><strong>Inner Diameter:</strong> <strong>22 mm</strong></li>
<li><strong>Busbar Window:</strong> <strong>22 × 10 mm</strong></li>
<li><strong>Dimensions:</strong> <strong>70 × 50 × 32 mm</strong></li>
<li><strong>VA Rating:</strong> <strong>2.5–15 VA</strong></li>
<li>Compact square-type construction</li>
<li>Encapsulated CT design</li>
<li>Suitable for metering and current measurement</li>
<li>Suitable for electrical panels and monitoring systems</li>
</ul>', '<h2>200/5A 22mm Current Transformer</h2>
<p>The <strong>200/5A 22mm Current Transformer</strong> is a compact and practical <strong>Class 1.0 metering class current transformer</strong> designed for electrical current measurement and monitoring applications. It is designed with a <strong>200A primary current and 5A secondary current</strong>, providing a standard secondary output for compatible metering and measurement equipment.</p>
<p>This <strong>200/5A CT</strong> features an encapsulated square-type construction that makes it suitable for installation in electrical panels and other compatible measurement systems. The compact design helps provide a convenient solution where available installation space is limited.</p>
<p>The transformer has a <strong>22 mm inner diameter</strong> along with a <strong>22 × 10 mm busbar window</strong>, allowing installation around compatible conductors or busbars according to the requirements of the electrical system. Before installation, the conductor or busbar dimensions should be checked against the available CT opening.</p>
<p>With <strong>Class 1.0 accuracy</strong>, this current transformer is designed for suitable metering and current measurement applications where this specified accuracy class is required. Its <strong>2.5–15 VA rating</strong> makes it appropriate for compatible metering circuits based on the connected burden and system requirements.</p>
<p>The <strong>70 × 50 × 32 mm (H × L × W)</strong> dimensions provide a compact form factor for electrical panels, distribution equipment, monitoring systems, and other suitable installations.</p>
<h3>Key Features</h3>
<p>The <strong>200/5A 22mm Current Transformer</strong> offers several practical features for electrical measurement applications:</p>
<ul>
<li><strong>200/5A current ratio</strong></li>
<li><strong>200A primary current</strong></li>
<li><strong>5A secondary current</strong></li>
<li><strong>Class 1.0 accuracy</strong></li>
<li><strong>22 mm inner diameter</strong></li>
<li><strong>22 × 10 mm busbar window</strong></li>
<li><strong>2.5–15 VA rating</strong></li>
<li>Encapsulated square-type construction</li>
<li>Compact <strong>70 × 50 × 32 mm</strong> dimensions</li>
<li>Suitable for metering applications</li>
<li>Suitable for current measurement and monitoring</li>
<li>Designed for compatible electrical panels and systems</li>
</ul>
<hr />
<h2>Technical Specifications</h2>
<div>
<div>
<div>
<table>
<thead>
<tr>
<th>Parameter</th>
<th>Specification</th>
</tr>
</thead>
<tbody>
<tr>
<td><strong>Product Type</strong></td>
<td>Current Transformer</td>
</tr>
<tr>
<td><strong>CT Type</strong></td>
<td>Encapsulated Square Type</td>
</tr>
<tr>
<td><strong>Primary Current</strong></td>
<td>200A</td>
</tr>
<tr>
<td><strong>Secondary Current</strong></td>
<td>5A</td>
</tr>
<tr>
<td><strong>Current Ratio</strong></td>
<td>200/5A</td>
</tr>
<tr>
<td><strong>Accuracy Class</strong></td>
<td>Class 1.0</td>
</tr>
<tr>
<td><strong>Inner Diameter</strong></td>
<td>22 mm</td>
</tr>
<tr>
<td><strong>Busbar Window</strong></td>
<td>22 × 10 mm</td>
</tr>
<tr>
<td><strong>Dimensions (H × L × W)</strong></td>
<td>70 × 50 × 32 mm</td>
</tr>
<tr>
<td><strong>VA Rating</strong></td>
<td>2.5–15 VA</td>
</tr>
<tr>
<td><strong>Application</strong></td>
<td>Metering &amp; Current Measurement</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
<hr />
<h1>Applications</h1>
<p>The <strong>200/5A Current Transformer</strong> can be used in compatible electrical measurement and monitoring applications, including:</p>
<ul>
<li>Energy metering systems</li>
<li>Electrical current measurement</li>
<li>Distribution panels</li>
<li>Electrical control panels</li>
<li>Power monitoring systems</li>
<li>Metering panels</li>
<li>Industrial electrical installations</li>
<li>Electrical monitoring equipment</li>
<li>Current monitoring systems</li>
<li>Compatible energy measurement applications</li>
</ul>
<p>The CT should be selected according to the required primary current, secondary current, accuracy, burden, physical dimensions, and electrical installation requirements.</p>
<hr />
<h1>Why Choose a 200/5A Class 1.0 Metering CT?</h1>
<p>The <strong>200/5A Class 1.0 Current Transformer</strong> provides a combination of a <strong>200A primary rating, 5A secondary output, compact construction, and Class 1.0 accuracy</strong> for suitable metering applications.</p>
<p>Its <strong>22 mm inner diameter</strong> and <strong>22 × 10 mm busbar window</strong> provide a compact configuration for compatible conductors and busbars. The encapsulated square-type construction allows the CT to be integrated into suitable electrical panels and measurement equipment.</p>
<p>The <strong>2.5–15 VA rating</strong> provides a specified burden range for compatible applications, while the compact <strong>70 × 50 × 32 mm</strong> dimensions make it suitable for installations where available panel space needs to be considered.</p>
<p>For electrical installations, users should always verify the required current ratio, secondary rating, accuracy class, burden, window size, and installation conditions before selecting a CT.</p>
<hr />
<h1>Benefits of 200/5A Current Transformer</h1>
<h3>Accurate Current Measurement</h3>
<p>The <strong>Class 1.0 accuracy</strong> makes the CT suitable for applications requiring the specified metering accuracy.</p>
<h3>Standard 5A Secondary</h3>
<p>The <strong>5A secondary output</strong> is suitable for compatible meters and current measurement equipment designed for a 5A CT secondary.</p>
<h3>Compact Design</h3>
<p>The <strong>70 × 50 × 32 mm</strong> dimensions provide a compact form factor for compatible electrical panel installations.</p>
<h3>22mm Window</h3>
<p>The <strong>22 mm inner diameter</strong> and <strong>22 × 10 mm busbar window</strong> provide a defined opening for compatible conductor and busbar installations.</p>
<h3>Versatile Metering Applications</h3>
<p>The CT can be used in compatible energy metering, electrical monitoring, current measurement, and distribution-panel applications.</p>
<hr />
<h1>Frequently Asked Questions</h1>
<h3>What is the current ratio of the 200/5A CT?</h3>
<p>The current ratio is <strong>200/5A</strong>, with a <strong>200A primary current</strong> and <strong>5A secondary current</strong>.</p>
<h3>What is the accuracy class?</h3>
<p>The <strong>200/5A Current Transformer has Class 1.0 accuracy</strong> as specified for this product.</p>
<h3>What is the secondary current?</h3>
<p>The secondary current is <strong>5A</strong>.</p>
<h3>What is the inner diameter of the CT?</h3>
<p>The specified inner diameter is <strong>22 mm</strong>.</p>
<h3>What is the busbar window size?</h3>
<p>The busbar window is <strong>22 × 10 mm</strong>.</p>
<h3>What are the dimensions?</h3>
<p>The dimensions are <strong>70 × 50 × 32 mm (H × L × W)</strong>.</p>
<h3>What is the VA rating?</h3>
<p>The specified VA rating is <strong>2.5–15 VA</strong>.</p>
<h3>Where can a 200/5A Current Transformer be used?</h3>
<p>It can be used in compatible <strong>metering, current measurement, electrical monitoring, distribution panels, control panels, and energy monitoring systems</strong>, subject to the electrical requirements of the installation.</p>', 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/200-5a-22mm-current-transformer-class-1-metering-ct.jpg', 0, 'published'),
(125, 2, 59, 1, '100/5A 22mm Current Transformer | Class 1.0 Metering CT', '100-5a-22mm-current-transformer', 'MVG-20-2210-2', 280.00, 280.00, 10, '85043100', 18.00, 'in_stock', '<ul>
<li><strong>Primary Current:</strong> <strong>100A</strong></li>
<li><strong>Secondary Current:</strong> <strong>5A</strong></li>
<li><strong>Current Ratio:</strong> <strong>100/5A</strong></li>
<li><strong>Accuracy Class:</strong> <strong>Class 1.0</strong></li>
<li><strong>Inner Diameter:</strong> <strong>22 mm</strong></li>
<li><strong>Busbar Window:</strong> <strong>22 × 10 mm</strong></li>
<li><strong>Dimensions:</strong> <strong>70 × 50 × 32 mm</strong></li>
<li><strong>VA Rating:</strong> <strong>2.5–15 VA</strong></li>
<li>Compact square-type construction</li>
<li>Encapsulated CT design</li>
<li>Suitable for metering and current measurement</li>
<li>Suitable for electrical panels and monitoring systems</li>
</ul>', '<h2>100/5A 22mm Current Transformer</h2>
<p>The <strong>100/5A 22mm Current Transformer</strong> is a compact <strong>Class 1.0 metering class CT</strong> designed for reliable current measurement and electrical metering applications. With a <strong>100A primary current</strong> and <strong>5A secondary output</strong>, this current transformer provides a practical solution for measuring electrical current through compatible metering and monitoring equipment.</p>
<p>The CT features an <strong>encapsulated square-type construction</strong> that provides a compact configuration for installation in electrical panels and measurement systems. Its <strong>22 mm inner diameter</strong> and <strong>22 × 10 mm busbar window</strong> are designed for compatible conductor and busbar installations.</p>
<p>With <strong>Class 1.0 accuracy</strong>, the <strong>100/5A CT</strong> is suitable for applications requiring the specified level of metering accuracy. The <strong>2.5–15 VA rating</strong> makes it suitable for compatible connected metering circuits according to the required burden and system specifications.</p>
<p>The compact <strong>70 × 50 × 32 mm (H × L × W)</strong> dimensions allow convenient integration into electrical panels and monitoring systems where space-efficient installation is required.</p>
<h3>Key Features</h3>
<ul>
<li><strong>100/5A current ratio</strong></li>
<li><strong>100A primary current</strong></li>
<li><strong>5A secondary current</strong></li>
<li><strong>Class 1.0 accuracy</strong></li>
<li><strong>22 mm inner diameter</strong></li>
<li><strong>22 × 10 mm busbar window</strong></li>
<li><strong>2.5–15 VA rating</strong></li>
<li>Encapsulated square-type construction</li>
<li>Compact <strong>70 × 50 × 32 mm</strong> dimensions</li>
<li>Designed for metering applications</li>
<li>Suitable for current measurement and monitoring</li>
<li>Suitable for compatible electrical panels and distribution systems</li>
</ul>
<hr />
<h1>Technical Specifications</h1>
<div>
<div>
<div>
<table>
<thead>
<tr>
<th>Parameter</th>
<th>Specification</th>
</tr>
</thead>
<tbody>
<tr>
<td><strong>Product Type</strong></td>
<td>Current Transformer</td>
</tr>
<tr>
<td><strong>CT Type</strong></td>
<td>Encapsulated Square Type</td>
</tr>
<tr>
<td><strong>Primary Current</strong></td>
<td>100A</td>
</tr>
<tr>
<td><strong>Secondary Current</strong></td>
<td>5A</td>
</tr>
<tr>
<td><strong>Current Ratio</strong></td>
<td>100/5A</td>
</tr>
<tr>
<td><strong>Accuracy Class</strong></td>
<td>Class 1.0</td>
</tr>
<tr>
<td><strong>Inner Diameter</strong></td>
<td>22 mm</td>
</tr>
<tr>
<td><strong>Busbar Window</strong></td>
<td>22 × 10 mm</td>
</tr>
<tr>
<td><strong>Dimensions (H × L × W)</strong></td>
<td>70 × 50 × 32 mm</td>
</tr>
<tr>
<td><strong>VA Rating</strong></td>
<td>2.5–15 VA</td>
</tr>
<tr>
<td><strong>Application</strong></td>
<td>Metering &amp; Current Measurement</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
<hr />
<h1>Applications</h1>
<p>The <strong>100/5A 22mm Current Transformer</strong> can be used for a range of electrical measurement and monitoring applications, including:</p>
<ul>
<li>Energy metering systems</li>
<li>Electrical current measurement</li>
<li>Electrical distribution panels</li>
<li>Control panels</li>
<li>Power monitoring systems</li>
<li>Metering panels</li>
<li>Industrial electrical installations</li>
<li>Electrical monitoring equipment</li>
<li>Compatible energy measurement systems</li>
<li>Current monitoring applications</li>
</ul>
<hr />
<h1>Why Choose a 100/5A Class 1.0 Metering CT?</h1>
<p>The <strong>100/5A Current Transformer</strong> combines a compact physical design with a <strong>5A secondary output</strong> and <strong>Class 1.0 accuracy</strong> for suitable metering applications. Its <strong>22 mm inner diameter</strong> and <strong>22 × 10 mm busbar window</strong> provide a practical configuration for compatible electrical installations.</p>
<p>The encapsulated square-type construction and <strong>70 × 50 × 32 mm</strong> dimensions make this CT suitable for integration into electrical panels where compact installation is required. With a <strong>2.5–15 VA rating</strong>, it can be used in compatible metering and monitoring circuits based on the application&#8217;s electrical requirements</p>', 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/100-5a-22mm-current-transformer-class-1-metering-ct.jpg', 0, 'published'),
(38, 2, 59, 1, '60/5A 22mm Current Transformer | Class 1.0 Metering CT', '60-5a-22mm-current-transformer', 'MVG-20-2210', 280.00, 280.00, 10, '85043100', 18.00, 'in_stock', '<ul>
<li><strong>Primary Current:</strong> <strong>60A</strong></li>
<li><strong>Secondary Current:</strong> <strong>5A</strong></li>
<li><strong>Accuracy Class:</strong> <strong>Class 1.0</strong></li>
<li><strong>Inner Diameter:</strong> <strong>22 mm</strong></li>
<li><strong>Busbar Window:</strong> <strong>22 × 10 mm</strong></li>
<li><strong>Dimensions:</strong> <strong>70 × 50 × 32 mm</strong></li>
<li><strong>VA Rating:</strong> <strong>2.5–15 VA</strong></li>
<li>Compact square-type construction</li>
<li>Encapsulated CT design</li>
<li>Suitable for metering and current measurement</li>
<li>Suitable for electrical panels and monitoring systems</li>
</ul>', '<h2>60/5A 22mm Current Transformer</h2>
<p>The <strong>60/5A 22mm Current Transformer</strong> is a compact <strong>Class 1.0 metering class CT</strong> designed for reliable current measurement and electrical metering applications. It converts a primary current of <strong>60A</strong> into a standard <strong>5A secondary output</strong>, making it suitable for compatible metering and monitoring equipment.</p>
<p>Designed with an <strong>encapsulated square-type construction</strong>, this current transformer provides a compact solution for installation in electrical panels and measurement systems. The <strong>22 mm inner diameter</strong> and <strong>22 × 10 mm busbar window</strong> allow the CT to accommodate compatible conductors or busbars according to the installation requirements.</p>
<p>With <strong>Class 1.0 accuracy</strong>, the CT is intended for applications where the specified metering accuracy is required. Its <strong>2.5–15 VA rating</strong> provides flexibility for suitable connected metering circuits, subject to the application&#8217;s burden requirements.</p>
<p>The compact <strong>70 × 50 × 32 mm dimensions</strong> make the 60/5A CT suitable for space-conscious electrical panel installations. It can be used for current measurement, electrical metering, power monitoring, and other compatible monitoring applications.</p>
<h3>Key Features</h3>
<ul>
<li><strong>60/5A current ratio</strong></li>
<li><strong>5A secondary current</strong></li>
<li><strong>Class 1.0 accuracy</strong></li>
<li><strong>22 mm inner diameter</strong></li>
<li><strong>22 × 10 mm busbar window</strong></li>
<li><strong>2.5–15 VA rating</strong></li>
<li>Encapsulated square-type construction</li>
<li>Compact <strong>70 × 50 × 32 mm</strong> size</li>
<li>Designed for metering applications</li>
<li>Suitable for current measurement and monitoring</li>
<li>Suitable for compatible electrical panels and distribution systems</li>
</ul>
<hr />
<h2>Technical Specifications</h2>
<div>
<div>
<div>
<table>
<thead>
<tr>
<th>Parameter</th>
<th>Specification</th>
</tr>
</thead>
<tbody>
<tr>
<td><strong>Product Type</strong></td>
<td>Current Transformer</td>
</tr>
<tr>
<td><strong>CT Type</strong></td>
<td>Encapsulated Square Type</td>
</tr>
<tr>
<td><strong>Primary Current</strong></td>
<td>60A</td>
</tr>
<tr>
<td><strong>Secondary Current</strong></td>
<td>5A</td>
</tr>
<tr>
<td><strong>Current Ratio</strong></td>
<td>60/5A</td>
</tr>
<tr>
<td><strong>Accuracy Class</strong></td>
<td>Class 1.0</td>
</tr>
<tr>
<td><strong>Inner Diameter</strong></td>
<td>22 mm</td>
</tr>
<tr>
<td><strong>Busbar Window</strong></td>
<td>22 × 10 mm</td>
</tr>
<tr>
<td><strong>Dimensions (H × L × W)</strong></td>
<td>70 × 50 × 32 mm</td>
</tr>
<tr>
<td><strong>VA Rating</strong></td>
<td>2.5–15 VA</td>
</tr>
<tr>
<td><strong>Application</strong></td>
<td>Metering &amp; Current Measurement</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
<hr />
<h2>Applications</h2>
<p>The <strong>60/5A 22mm Current Transformer</strong> is suitable for various electrical measurement and monitoring applications, including:</p>
<ul>
<li>Energy metering</li>
<li>Electrical current measurement</li>
<li>Electrical distribution panels</li>
<li>Control panels</li>
<li>Power monitoring systems</li>
<li>Metering panels</li>
<li>Industrial electrical systems</li>
<li>Electrical monitoring equipment</li>
<li>Compatible energy measurement applications</li>
</ul>
<hr />
<h2>Why Choose a 60/5A Class 1.0 Metering CT?</h2>
<p>The <strong>60/5A Current Transformer</strong> combines a compact design with a <strong>5A secondary output</strong> and <strong>Class 1.0 accuracy</strong> for suitable metering applications. Its <strong>22 mm inner diameter</strong> and <strong>22 × 10 mm busbar window</strong> provide a practical configuration for compatible electrical installations.</p>
<p>The encapsulated square-type construction and compact dimensions of <strong>70 × 50 × 32 mm</strong> make it suitable for integration into electrical panels where installation space is limited.</p>', 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/08/60-5a-22mm-current-transformer-class-1-metering-ct.jpg', 0, 'published');

-- 6. Product Gallery Images
DROP TABLE IF EXISTS `product_images`;
CREATE TABLE `product_images` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `product_id` INT UNSIGNED NOT NULL,
  `image_url` VARCHAR(255) NOT NULL,
  `alt_text` VARCHAR(255) NULL,
  `sort_order` INT DEFAULT 0,
  INDEX (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `product_images` (`product_id`, `image_url`, `alt_text`, `sort_order`) VALUES
(258, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/2500-A.jpg', '2500/5A 115mm Ring Current Transformer Class 1.0', 0),
(258, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/2500-5a-115mm-ring-current-transformer.jpg', '2500/5A 115mm Ring Current Transformer', 1),
(255, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/2000-A.jpg', '2000/5A 115mm Ring Current Transformer Class 1.0', 0),
(255, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/2000-5a-115mm-ring-current-transformer.jpg', '2000/5A 115mm Ring Current Transformer', 1),
(252, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/1600-A.jpg', '1600/5A 115mm Ring Current Transformer Class 1.0', 0),
(252, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/1600-5a-115mm-ring-current-transformer.jpg', '1600/5A 115mm Ring Current Transformer', 1),
(249, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/1200-A.jpg', '1200/5A 115mm Ring Current Transformer Class 1.0', 0),
(249, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/1200-5a-115mm-ring-current-transformer.jpg', '1200/5A 115mm Ring Current Transformer', 1),
(246, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/1000-A-1.jpg', '1000/5A 115mm Ring Current Transformer Class 1.0', 0),
(246, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/800-5a-115mm-ring-current-transformer-1.jpg', '1000/5A 115mm Ring Current Transformer', 1),
(243, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/800-A-1.jpg', '800/5A 115mm Ring Current Transformer Class 1.0', 0),
(243, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/800-5a-115mm-ring-current-transformer.jpg', '800/5A 115mm Ring Current Transformer', 1),
(240, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/1200-5a-85mm-ring-current-transformer-specifications-scaled.jpg', '1200/5A Ring Current Transformer 85mm | Class 1.0 Metering CT', 0),
(240, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/1200-5a-85mm-encapsulated-ring-current-transformer-scaled.jpg', '1200/5A 85mm Encapsulated Ring Current Transformer', 1),
(235, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/800-5a-85mm-ring-current-transformer-specifications-scaled.jpg', '800/5A 85mm Ring Current Transformer Class 1.0', 0),
(235, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/800-5a-85mm-encapsulated-ring-current-transformer-scaled.jpg', '800/5A 85mm Encapsulated Ring Current Transformer', 1),
(232, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/1000-5a-85mm-ring-current-transformer-specifications-scaled.jpg', '1000/5A Ring Current Transformer 85mm | Class 1.0 Metering CT', 0),
(232, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/1000-5a-85mm-encapsulated-ring-current-transformer-scaled.jpg', '1000/5A 85mm Encapsulated Ring Current Transformer', 1),
(229, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/600-5a-85mm-ring-current-transformer-specifications-scaled.jpg', '600/5A 85mm Ring Current Transformer Class 1.0', 0),
(229, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/600-5a-85mm-encapsulated-ring-current-transformer-scaled.jpg', '600/5A 85mm Encapsulated Ring Current Transformer', 1),
(226, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/1000-5a-65mm-ring-current-transformer-specifications.jpg', '1000/5A 65mm Ring Current Transformer Class 1.0', 0),
(226, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/1000-5a-65mm-encapsulated-ring-current-transformer.jpg', '1000/5A 65mm Encapsulated Ring Current Transformer', 1),
(223, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/800-5a-65mm-ring-current-transformer-specifications.jpg', '800/5A 65mm Ring Current Transformer Class 1.0', 0),
(223, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/800-5a-65mm-encapsulated-ring-current-transformer.jpg', '800/5A 65mm Encapsulated Ring Current Transformer', 1),
(220, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/600-5a-65mm-ring-current-transformer-specifications.jpg', '600/5A 65mm Ring Current Transformer Class 1.0', 0),
(220, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/600-5a-65mm-encapsulated-ring-current-transformer.jpg', '600/5A 65mm Encapsulated Ring Current Transformer', 1),
(217, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/500-5a-65mm-ring-current-transformer-specifications.jpg', '500/5A 65mm Ring Current Transformer Class 1.0', 0),
(217, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/500-5a-65mm-encapsulated-ring-current-transformer.jpg', '500/5A 65mm Encapsulated Ring Current Transformer', 1),
(213, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/400-5a-65mm-ring-current-transformer-specifications.jpg', '400/5A 65mm Ring Current Transformer Class 1.0', 0),
(213, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/400-5a-65mm-encapsulated-ring-current-transformer.jpg', '400/5A 65mm Encapsulated Ring Current Transformer', 1),
(207, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/500-5a-45mm-ring-current-transformer-specifications.jpg', '500/5A 45mm Ring Current Transformer Class 1.0', 0),
(207, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/500-5a-45mm-encapsulated-ring-current-transformer.jpg', '500/5A 45mm Encapsulated Ring Current Transformer', 1),
(203, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/300-5a-45mm-encapsulated-ring-current-transformer.jpg', '300/5A 45mm Ring Current Transformer Class 1.0', 0),
(203, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/300-5a-45mm-encapsulated-ring-current-transformer-1.jpg', '300/5A 45mm Encapsulated Ring Current Transformer', 1),
(200, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/200-5a-45mm-ring-current-transformer-specifications.jpg', '200/5A 45mm Ring Current Transformer Class 1.0', 0),
(200, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/200-5a-45mm-encapsulated-ring-current-transformer.jpg', '200/5A 45mm Encapsulated Ring Current Transformer', 1),
(197, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/300-5a-35mm-ring-current-transformer-specifications.jpg', '300/5A 35mm Ring Current Transformer Class 1.0', 0),
(197, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/300-5a-35mm-encapsulated-ring-current-transformer.jpg', '300/5A 35mm Encapsulated Ring Current Transformer', 1),
(194, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/250-5a-35mm-ring-current-transformer-specifications.jpg', '250/5A 35mm Ring Current Transformer Class 1.0', 0),
(194, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/250-5a-35mm-encapsulated-ring-current-transformer.jpg', '250/5A 35mm Encapsulated Ring Current Transformer', 1),
(190, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/200-5a-35mm-ring-current-transformer-specifications-1.jpg', '200/5A 35mm Ring Current Transformer Class 1.0', 0),
(190, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/200-5a-35mm-encapsulated-ring-current-transformer.jpg', '200/5A 35mm Encapsulated Ring Current Transformer', 1),
(187, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/150-5a-35mm-ring-current-transformer-specifications.jpg', '150/5A 35mm Ring Current Transformer Class 1.0', 0),
(187, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/150-5a-35mm-encapsulated-ring-current-transformer.jpg', '150/5A 35mm Encapsulated Ring Current Transformer', 1),
(182, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/100-5a-35mm-ring-current-transformer-specifications-1.jpg', '100/5A 35mm Ring Current Transformer Class 1.0', 0),
(182, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/100-5a-35mm-encapsulated-ring-current-transformer-1.jpg', '100/5A 35mm Encapsulated Ring Current Transformer', 1),
(178, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/50-5a-35mm-ring-current-transformer-specifications.jpg', '50/5A Class 1.0 Ring Current Transformer 35mm ID 80mm OD', 0),
(178, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/50-5a-35mm-encapsulated-ring-current-transformer.jpg', '50/5A 35mm ID Encapsulated Ring Current Transformer', 1),
(173, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/1000-5a-62mm-current-transformer-class-1-metering-ct.jpg', '1000/5A 62mm Class 1.0 Metering Current Transformer', 0),
(173, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/1000-5a-62mm-ct-62x15mm-busbar-window.jpg', '1000/5A Current Transformer with 62 × 15mm Busbar Window', 1),
(170, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/800-5a-62mm-current-transformer-class-1-metering-ct.jpg', '800/5A 62mm Class 1.0 Metering Current Transformer', 0),
(170, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/800-5a-62mm-ct-62x15mm-busbar-window.jpg', '800/5A Current Transformer with 62 × 15mm Busbar Window', 1),
(167, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/600-5a-62mm-current-transformer-class-1-metering-ct.jpg', '600/5A 62mm Class 1.0 Metering Current Transformer', 0),
(167, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/600-5a-62mm-ct-62x15mm-busbar-window.jpg', '600/5A Current Transformer with 62 × 15mm Busbar Window', 1),
(163, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/500-5a-62mm-current-transformer-class-1-metering-ct.jpg', '500/5A 62mm Class 1.0 Metering Current Transformer', 0),
(163, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/500-5a-62mm-ct-62x15mm-busbar-window.jpg', '500/5A Current Transformer with 62x15mm Busbar Window', 1),
(160, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/600-5a-42mm-current-transformer-class-1-metering-ct.jpg', '600/5A 42mm Class 1.0 Metering Current Transformer', 0),
(160, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/600-5a-42mm-ct-42x12mm-busbar-window.jpg', '600/5A Current Transformer with 42x12mm Busbar Window', 1),
(156, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/500-5a-42mm-current-transformer-class-1-metering-ct.jpg', '500/5A 42mm Class 1.0 Metering Current Transformer', 0),
(156, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/500-5a-42mm-ct-42x12mm-busbar-window.jpg', '500/5A Current Transformer with 42x12mm Busbar Window', 1),
(151, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/400-5a-42mm-current-transformer-class-1-metering-ct.jpg', '400/5A 42mm Class 1.0 Metering Current Transformer', 0),
(151, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/400-5a-42mm-ct-42x12mm-busbar-window.jpg', '400/5A Current Transformer with 42x12mm Busbar Window', 1),
(148, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/300-5a-42mm-current-transformer-class-1-metering-ct.jpg', '300/5A 42mm Class 1.0 Metering Current Transformer', 0),
(148, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/300-5a-42mm-ct-42x12mm-busbar-window.jpg', '300/5A Current Transformer with 42x12mm Busbar Window', 1),
(145, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/250-5a-42mm-current-transformer-class-1-metering-ct.jpg', '250/5A 42mm Class 1.0 Metering Current Transformer', 0),
(145, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/250-5a-42mm-ct-42x12mm-busbar-window.jpg', '250/5A Current Transformer with 42x12mm Busbar Window', 1),
(142, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/300-5a-32mm-current-transformer-class-1-metering-ct.jpg', '300/5A 32mm Class 1.0 Metering Current Transformer', 0),
(142, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/300-5a-32mm-ct-32x10mm-busbar-window.jpg', '300/5A Current Transformer with 32x10mm Busbar Window', 1),
(139, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/250-5a-32mm-current-transformer-class-1-metering-ct.jpg', '250/5A 32mm Class 1.0 Metering Current Transformer', 0),
(139, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/250-5a-32mm-ct-32x10mm-busbar-window.jpg', '250/5A Current Transformer with 32x10mm Busbar Window', 1),
(136, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/200-5a-32mm-current-transformer-class-1-metering-ct.jpg', '200/5A 32mm Class 1.0 Metering Current Transformer', 0),
(136, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/200-5a-32mm-ct-32x10mm-busbar-window.jpg', '200/5A Current Transformer with 32x10mm Busbar Window', 1),
(131, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/50-5a-32mm-current-transformer-class-1-metering-ct.jpg', '50/5A 32mm Class 1.0 Metering Current Transformer', 0),
(131, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/50-5a-32mm-ct-70x50x32mm-busbar-window.jpg', '50/5A Current Transformer 32mm with 32x10mm Busbar Window', 1),
(128, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/200-5a-22mm-current-transformer-class-1-metering-ct.jpg', '200/5A 22mm Current Transformer Class 1.0 Metering CT', 0),
(128, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/200-5a-22mm-current-transformer-technical-specifications.jpg', '200/5A 22mm Current Transformer technical specifications', 1),
(125, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/100-5a-22mm-current-transformer-class-1-metering-ct.jpg', '100/5A 22mm Current Transformer Class 1.0 Metering CT', 0),
(125, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/09/100-5a-22mm-current-transformer-technical-specifications.jpg', '100/5A 22mm Current Transformer technical specifications', 1),
(38, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/08/60-5a-22mm-current-transformer-class-1-metering-ct.jpg', '60/5A 22mm Current Transformer Class 1.0 Metering CT', 0),
(38, 'https://www.mvgpowersolutions.com/wp-content/uploads/2026/08/60-5a-22mm-current-transformer-technical-specifications.jpg', '60/5A 22mm Current Transformer technical specifications', 1);

-- 7. Product Technical Specifications
DROP TABLE IF EXISTS `product_specs`;
CREATE TABLE `product_specs` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `product_id` INT UNSIGNED NOT NULL,
  `spec_key` VARCHAR(120) NOT NULL,
  `spec_val` VARCHAR(255) NOT NULL,
  `sort_order` INT DEFAULT 0,
  INDEX (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `product_specs` (`product_id`, `spec_key`, `spec_val`, `sort_order`) VALUES
(258, 'Primary Current', '2500A', 1),
(258, 'Secondary Current', '5A', 2),
(258, 'Current Ratio', '2500/5A', 3),
(258, 'Accuracy Class', 'Class 1.0', 4),
(258, 'Inner Diameter (ID)', '115 mm', 5),
(258, 'Outer Diameter (OD)', '170 mm', 6),
(258, 'Width', '40 mm', 7),
(258, 'VA Rating', '2.5–15 VA', 8),
(255, 'Primary Current', '2000A', 1),
(255, 'Secondary Current', '5A', 2),
(255, 'Current Ratio', '2000/5A', 3),
(255, 'Accuracy Class', 'Class 1.0', 4),
(255, 'Inner Diameter (ID)', '115 mm', 5),
(255, 'Outer Diameter (OD)', '170 mm', 6),
(255, 'Width', '40 mm', 7),
(255, 'VA Rating', '2.5–15 VA', 8),
(252, 'Primary Current', '1600A', 1),
(252, 'Secondary Current', '5A', 2),
(252, 'Current Ratio', '1600/5A', 3),
(252, 'Accuracy Class', 'Class 1.0', 4),
(252, 'Inner Diameter (ID)', '115 mm', 5),
(252, 'Outer Diameter (OD)', '170 mm', 6),
(252, 'Width', '40 mm', 7),
(252, 'VA Rating', '2.5–15 VA', 8),
(249, 'Primary Current', '1200A', 1),
(249, 'Secondary Current', '5A', 2),
(249, 'Current Ratio', '1200/5A', 3),
(249, 'Accuracy Class', 'Class 1.0', 4),
(249, 'Inner Diameter (ID)', '115 mm', 5),
(249, 'Outer Diameter (OD)', '170 mm', 6),
(249, 'Width', '40 mm', 7),
(249, 'VA Rating', '2.5–15 VA', 8),
(246, 'Primary Current', '1000A', 1),
(246, 'Secondary Current', '5A', 2),
(246, 'Current Ratio', '1000/5A', 3),
(246, 'Accuracy Class', 'Class 1.0', 4),
(246, 'Inner Diameter (ID)', '115 mm', 5),
(246, 'Outer Diameter (OD)', '170 mm', 6),
(246, 'Width', '40 mm', 7),
(246, 'VA Rating', '2.5–15 VA', 8),
(243, 'Primary Current', '800A', 1),
(243, 'Secondary Current', '5A', 2),
(243, 'Current Ratio', '800/5A', 3),
(243, 'Accuracy Class', 'Class 1.0', 4),
(243, 'Inner Diameter (ID)', '115 mm', 5),
(243, 'Outer Diameter (OD)', '170 mm', 6),
(243, 'Width', '40 mm', 7),
(243, 'VA Rating', '2.5–15 VA', 8),
(240, 'Primary Current', '1200A', 1),
(240, 'Secondary Current', '5A', 2),
(240, 'Current Ratio', '1200/5A', 3),
(240, 'Accuracy Class', 'Class 1.0', 4),
(240, 'Inner Diameter (ID)', '85 mm', 5),
(240, 'Outer Diameter (OD)', '135 mm', 6),
(240, 'Width', '40 mm', 7),
(240, 'VA Rating', '2.5–15 VA', 8),
(240, 'CT Type', 'Encapsulated Round Type Ring Current Transformer', 9),
(240, 'Secondary Output', '5A', 10),
(240, 'Suitable for', 'Metering and current measurement', 11),
(240, 'Suitable for', 'Electrical monitoring and compatible panel installations', 12),
(235, 'Primary Current', '800A', 1),
(235, 'Secondary Current', '5A', 2),
(235, 'Current Ratio', '800/5A', 3),
(235, 'Accuracy Class', 'Class 1.0', 4),
(235, 'Inner Diameter (ID)', '85 mm', 5),
(235, 'Outer Diameter (OD)', '135 mm', 6),
(235, 'Width', '40 mm', 7),
(235, 'VA Rating', '2.5–15 VA', 8),
(235, 'CT Type', 'Encapsulated Round Type Ring Current Transformer', 9),
(235, 'Secondary Output', '5A', 10),
(235, 'Suitable for', 'Metering and current measurement', 11),
(235, 'Suitable for', 'Electrical monitoring and compatible panel installations', 12),
(232, 'Primary Current', '1000A', 1),
(232, 'Secondary Current', '5A', 2),
(232, 'Current Ratio', '1000/5A', 3),
(232, 'Accuracy Class', 'Class 1.0', 4),
(232, 'Inner Diameter (ID)', '85 mm', 5),
(232, 'Outer Diameter (OD)', '135 mm', 6),
(232, 'Width', '40 mm', 7),
(232, 'VA Rating', '2.5–15 VA', 8),
(232, 'CT Type', 'Encapsulated Round Type Ring Current Transformer', 9),
(232, 'Secondary Output', '5A', 10),
(232, 'Suitable for', 'Metering and current measurement', 11),
(232, 'Suitable for', 'Electrical monitoring and compatible panel installations', 12),
(229, 'Primary Current', '1000A', 1),
(229, 'Secondary Current', '5A', 2),
(229, 'Current Ratio', '1000/5A', 3),
(229, 'Accuracy Class', 'Class 1.0', 4),
(229, 'Inner Diameter (ID)', '65 mm', 5),
(229, 'Outer Diameter (OD)', '120 mm', 6),
(229, 'Width', '40 mm', 7),
(229, 'VA Rating', '2.5–15 VA', 8),
(229, 'CT Type', 'Encapsulated Round Type Ring Current Transformer', 9),
(229, 'Secondary Output', '5A', 10),
(229, 'Suitable for', 'Metering and current measurement', 11),
(229, 'Suitable for', 'Electrical monitoring and compatible panel installations', 12),
(226, 'Primary Current', '1000A', 1),
(226, 'Secondary Current', '5A', 2),
(226, 'Current Ratio', '1000/5A', 3),
(226, 'Accuracy Class', 'Class 1.0', 4),
(226, 'Inner Diameter (ID)', '65 mm', 5),
(226, 'Outer Diameter (OD)', '120 mm', 6),
(226, 'Width', '40 mm', 7),
(226, 'VA Rating', '2.5–15 VA', 8),
(226, 'CT Type', 'Encapsulated Round Type Ring Current Transformer', 9),
(226, 'Secondary Output', '5A', 10),
(226, 'Suitable for', 'Metering and current measurement', 11),
(226, 'Suitable for', 'Electrical monitoring and compatible panel installations', 12),
(223, 'Primary Current', '800A', 1),
(223, 'Secondary Current', '5A', 2),
(223, 'Current Ratio', '800/5A', 3),
(223, 'Accuracy Class', 'Class 1.0', 4),
(223, 'Inner Diameter (ID)', '65 mm', 5),
(223, 'Outer Diameter (OD)', '120 mm', 6),
(223, 'Width', '40 mm', 7),
(223, 'VA Rating', '2.5–15 VA', 8),
(223, 'CT Type', 'Encapsulated Round Type Ring Current Transformer', 9),
(223, 'Secondary Output', '5A', 10),
(223, 'Suitable for', 'Metering and current measurement', 11),
(223, 'Suitable for', 'Electrical monitoring and compatible panel installations', 12),
(220, 'Primary Current', '600A', 1),
(220, 'Secondary Current', '5A', 2),
(220, 'Current Ratio', '600/5A', 3),
(220, 'Accuracy Class', 'Class 1.0', 4),
(220, 'Inner Diameter (ID)', '65 mm', 5),
(220, 'Outer Diameter (OD)', '120 mm', 6),
(220, 'Width', '40 mm', 7),
(220, 'VA Rating', '2.5–15 VA', 8),
(220, 'CT Type', 'Encapsulated Round Type Ring Current Transformer', 9),
(220, 'Secondary Output', '5A', 10),
(220, 'Suitable for', 'Metering and current measurement', 11),
(220, 'Suitable for', 'Electrical monitoring and compatible panel installations', 12),
(217, 'Primary Current', '500A', 1),
(217, 'Secondary Current', '5A', 2),
(217, 'Current Ratio', '500/5A', 3),
(217, 'Accuracy Class', 'Class 1.0', 4),
(217, 'Inner Diameter (ID)', '65 mm', 5),
(217, 'Outer Diameter (OD)', '120 mm', 6),
(217, 'Width', '40 mm', 7),
(217, 'VA Rating', '2.5–15 VA', 8),
(217, 'CT Type', 'Encapsulated Round Type Ring Current Transformer', 9),
(217, 'Secondary Output', '5A', 10),
(217, 'Suitable for', 'Metering and current measurement', 11),
(217, 'Suitable for', 'Electrical monitoring and compatible panel installations', 12),
(213, 'Primary Current', '400A', 1),
(213, 'Secondary Current', '5A', 2),
(213, 'Current Ratio', '400/5A', 3),
(213, 'Accuracy Class', 'Class 1.0', 4),
(213, 'Inner Diameter (ID)', '65 mm', 5),
(213, 'Outer Diameter (OD)', '120 mm', 6),
(213, 'Width', '40 mm', 7),
(213, 'VA Rating', '2.5–15 VA', 8),
(213, 'CT Type', 'Encapsulated Round Type Ring Current Transformer', 9),
(213, 'Secondary Output', '5A', 10),
(213, 'Suitable for', 'Metering and current measurement', 11),
(213, 'Suitable for', 'Electrical monitoring and compatible panel installations', 12),
(207, 'Primary Current', '500A', 1),
(207, 'Secondary Current', '5A', 2),
(207, 'Current Ratio', '500/5A', 3),
(207, 'Accuracy Class', 'Class 1.0', 4),
(207, 'Inner Diameter (ID)', '45 mm', 5),
(207, 'Outer Diameter (OD)', '90 mm', 6),
(207, 'Width', '40 mm', 7),
(207, 'VA Rating', '2.5–15 VA', 8),
(207, 'CT Type', 'Encapsulated Round Type Ring Current Transformer', 9),
(207, 'Secondary Output', '5A', 10),
(207, 'Suitable for', 'Metering and current measurement', 11),
(207, 'Suitable for', 'Electrical monitoring and compatible panel installations', 12),
(203, 'Primary Current', '300A', 1),
(203, 'Secondary Current', '5A', 2),
(203, 'Current Ratio', '300/5A', 3),
(203, 'Accuracy Class', 'Class 1.0', 4),
(203, 'Inner Diameter (ID)', '45 mm', 5),
(203, 'Outer Diameter (OD)', '90 mm', 6),
(203, 'Width', '40 mm', 7),
(203, 'VA Rating', '2.5–15 VA', 8),
(203, 'CT Type', 'Encapsulated Round Type Ring Current Transformer', 9),
(203, 'Secondary Output', '5A', 10),
(203, 'Suitable for', 'Metering and current measurement applications', 11),
(203, 'Suitable for', 'Electrical monitoring and compatible panel installations', 12),
(200, 'Product Type', 'Encapsulated Round Type Ring Current Transformer', 1),
(200, 'Primary Current', '200A', 2),
(200, 'Secondary Current', '5A', 3),
(200, 'Current Ratio', '200/5A', 4),
(200, 'Accuracy Class', 'Class 1.0', 5),
(200, 'Inner Diameter (ID)', '45 mm', 6),
(200, 'Outer Diameter (OD)', '90 mm', 7),
(200, 'Width', '40 mm', 8),
(200, 'VA Rating', '2.5–15 VA', 9),
(200, 'Secondary Output', '5A', 10),
(200, 'Construction', 'Encapsulated Round / Ring Type', 11),
(200, 'Application', 'Metering &amp; Current Measurement', 12),
(200, 'Suitable for', 'Electrical panels, metering systems and current monitoring applications', 13),
(197, 'Product Type', 'Encapsulated Round Type Ring Current Transformer', 1),
(197, 'Primary Current', '250A', 2),
(197, 'Secondary Current', '5A', 3),
(197, 'Current Ratio', '250/5A', 4),
(197, 'Accuracy Class', 'Class 1.0', 5),
(197, 'Inner Diameter (ID)', '35 mm', 6),
(197, 'Outer Diameter (OD)', '80 mm', 7),
(197, 'Width', '40 mm', 8),
(197, 'VA Rating', '2.5–15 VA', 9),
(197, 'Secondary Output', '5A', 10),
(197, 'Construction', 'Encapsulated Round / Ring Type', 11),
(197, 'Application', 'Metering &amp; Current Measurement', 12),
(197, 'Suitable for', 'Electrical panels, metering systems and current monitoring applications', 13),
(194, 'Product Type', 'Encapsulated Round Type Ring Current Transformer', 1),
(194, 'Primary Current', '250A', 2),
(194, 'Secondary Current', '5A', 3),
(194, 'Current Ratio', '250/5A', 4),
(194, 'Accuracy Class', 'Class 1.0', 5),
(194, 'Inner Diameter (ID)', '35 mm', 6),
(194, 'Outer Diameter (OD)', '80 mm', 7),
(194, 'Width', '40 mm', 8),
(194, 'VA Rating', '2.5–15 VA', 9),
(194, 'Secondary Output', '5A', 10),
(194, 'Construction', 'Encapsulated Round / Ring Type', 11),
(194, 'Application', 'Metering &amp; Current Measurement', 12),
(194, 'Suitable for', 'Electrical panels, metering systems and current monitoring applications', 13),
(190, 'Product Type', 'Encapsulated Round Type Ring Current Transformer', 1),
(190, 'Primary Current', '200A', 2),
(190, 'Secondary Current', '5A', 3),
(190, 'Current Ratio', '200/5A', 4),
(190, 'Accuracy Class', 'Class 1.0', 5),
(190, 'Inner Diameter (ID)', '35 mm', 6),
(190, 'Outer Diameter (OD)', '80 mm', 7),
(190, 'Width', '40 mm', 8),
(190, 'VA Rating', '2.5–15 VA', 9),
(190, 'Secondary Output', '5A', 10),
(190, 'Construction', 'Encapsulated Round / Ring Type', 11),
(190, 'Application', 'Metering &amp; Current Measurement', 12),
(190, 'Suitable for', 'Electrical panels, metering systems and current monitoring applications', 13),
(187, 'Product Type', 'Encapsulated Round Type Ring Current Transformer', 1),
(187, 'Primary Current', '150A', 2),
(187, 'Secondary Current', '5A', 3),
(187, 'Current Ratio', '150/5A', 4),
(187, 'Accuracy Class', 'Class 1.0', 5),
(187, 'Inner Diameter (ID)', '35 mm', 6),
(187, 'Outer Diameter (OD)', '80 mm', 7),
(187, 'Width', '40 mm', 8),
(187, 'VA Rating', '2.5–15 VA', 9),
(187, 'Secondary Output', '5A', 10),
(187, 'Construction', 'Encapsulated Round / Ring Type', 11),
(187, 'Application', 'Metering &amp; Current Measurement', 12),
(182, 'Secondary Current', '5A', 1),
(182, 'Accuracy Class', 'Class 1.0', 2),
(182, 'Rated Burden', '5 VA', 3),
(182, 'Standard Compliance', 'IS 2705 / IEC 61869-2', 4),
(182, 'Insulation Level', '3 kV / 1 min', 5),
(178, 'Product Type', 'Encapsulated Round Type Ring Current Transformer', 1),
(178, 'Model No.', '8040-MVG-R-35', 2),
(178, 'Primary Current', '50A', 3),
(178, 'Secondary Current', '5A', 4),
(178, 'Current Ratio', '50/5A', 5),
(178, 'Accuracy Class', 'Class 1.0', 6),
(178, 'Inner Diameter (ID)', '35mm', 7),
(178, 'Outer Diameter (OD)', '80mm', 8),
(178, 'Width', '40mm', 9),
(178, 'VA Rating', '2.5–15 VA', 10),
(178, 'Construction', 'Encapsulated Round Type', 11),
(178, 'Secondary Output', '5A', 12),
(178, 'Application', 'Metering &amp; Current Measurement', 13),
(173, 'Product Type', 'Encapsulated Square Type Current Transformer', 1),
(173, 'Primary Current', '1000A', 2),
(173, 'Secondary Current', '5A', 3),
(173, 'Current Ratio', '1000/5A', 4),
(173, 'Accuracy Class', 'Class 1.0', 5),
(173, 'Diameter', '62mm', 6),
(173, 'Busbar Window', '62 × 15mm', 7),
(173, 'Dimensions (H × L × W)', '110 × 60 × 40mm', 8),
(173, 'VA Rating', '2.5–15 VA', 9),
(173, 'Construction', 'Encapsulated Square Type', 10),
(173, 'Secondary Output', '5A', 11),
(173, 'Application', 'Metering &amp; Current Measurement', 12),
(170, 'Product Type', 'Encapsulated Square Type Current Transformer', 1),
(170, 'Primary Current', '800A', 2),
(170, 'Secondary Current', '5A', 3),
(170, 'Current Ratio', '800/5A', 4),
(170, 'Accuracy Class', 'Class 1.0', 5),
(170, 'Diameter', '62mm', 6),
(170, 'Busbar Window', '62 × 15mm', 7),
(170, 'Dimensions (H × L × W)', '110 × 60 × 40mm', 8),
(170, 'VA Rating', '2.5–15 VA', 9),
(170, 'Construction', 'Encapsulated Square Type', 10),
(170, 'Secondary Output', '5A', 11),
(170, 'Application', 'Metering &amp; Current Measurement', 12),
(167, 'Product Type', 'Encapsulated Square Type Current Transformer', 1),
(167, 'Primary Current', '600A', 2),
(167, 'Secondary Current', '5A', 3),
(167, 'Current Ratio', '600/5A', 4),
(167, 'Accuracy Class', 'Class 1.0', 5),
(167, 'Diameter', '62mm', 6),
(167, 'Busbar Window', '62 × 15mm', 7),
(167, 'Dimensions (H × L × W)', '110 × 60 × 40mm', 8),
(167, 'VA Rating', '2.5–15 VA', 9),
(167, 'Construction', 'Encapsulated Square Type', 10),
(167, 'Secondary Output', '5A', 11),
(167, 'Application', 'Metering &amp; Current Measurement', 12),
(163, 'Secondary Current', '5A', 1),
(163, 'Accuracy Class', 'Class 1.0', 2),
(163, 'Rated Burden', '5 VA', 3),
(163, 'Standard Compliance', 'IS 2705 / IEC 61869-2', 4),
(163, 'Insulation Level', '3 kV / 1 min', 5),
(160, 'Secondary Current', '5A', 1),
(160, 'Accuracy Class', 'Class 1.0', 2),
(160, 'Rated Burden', '5 VA', 3),
(160, 'Standard Compliance', 'IS 2705 / IEC 61869-2', 4),
(160, 'Insulation Level', '3 kV / 1 min', 5),
(156, 'Secondary Current', '5A', 1),
(156, 'Accuracy Class', 'Class 1.0', 2),
(156, 'Rated Burden', '5 VA', 3),
(156, 'Standard Compliance', 'IS 2705 / IEC 61869-2', 4),
(156, 'Insulation Level', '3 kV / 1 min', 5),
(151, 'Secondary Current', '5A', 1),
(151, 'Accuracy Class', 'Class 1.0', 2),
(151, 'Rated Burden', '5 VA', 3),
(151, 'Standard Compliance', 'IS 2705 / IEC 61869-2', 4),
(151, 'Insulation Level', '3 kV / 1 min', 5),
(148, 'Secondary Current', '5A', 1),
(148, 'Accuracy Class', 'Class 1.0', 2),
(148, 'Rated Burden', '5 VA', 3),
(148, 'Standard Compliance', 'IS 2705 / IEC 61869-2', 4),
(148, 'Insulation Level', '3 kV / 1 min', 5),
(145, 'Secondary Current', '5A', 1),
(145, 'Accuracy Class', 'Class 1.0', 2),
(145, 'Rated Burden', '5 VA', 3),
(145, 'Standard Compliance', 'IS 2705 / IEC 61869-2', 4),
(145, 'Insulation Level', '3 kV / 1 min', 5),
(142, 'Secondary Current', '5A', 1),
(142, 'Accuracy Class', 'Class 1.0', 2),
(142, 'Rated Burden', '5 VA', 3),
(142, 'Standard Compliance', 'IS 2705 / IEC 61869-2', 4),
(142, 'Insulation Level', '3 kV / 1 min', 5),
(139, 'Secondary Current', '5A', 1),
(139, 'Accuracy Class', 'Class 1.0', 2),
(139, 'Rated Burden', '5 VA', 3),
(139, 'Standard Compliance', 'IS 2705 / IEC 61869-2', 4),
(139, 'Insulation Level', '3 kV / 1 min', 5),
(136, 'Secondary Current', '5A', 1),
(136, 'Accuracy Class', 'Class 1.0', 2),
(136, 'Rated Burden', '5 VA', 3),
(136, 'Standard Compliance', 'IS 2705 / IEC 61869-2', 4),
(136, 'Insulation Level', '3 kV / 1 min', 5),
(131, 'Secondary Current', '5A', 1),
(131, 'Accuracy Class', 'Class 1.0', 2),
(131, 'Rated Burden', '5 VA', 3),
(131, 'Standard Compliance', 'IS 2705 / IEC 61869-2', 4),
(131, 'Insulation Level', '3 kV / 1 min', 5),
(128, 'Secondary Current', '5A', 1),
(128, 'Accuracy Class', 'Class 1.0', 2),
(128, 'Rated Burden', '5 VA', 3),
(128, 'Standard Compliance', 'IS 2705 / IEC 61869-2', 4),
(128, 'Insulation Level', '3 kV / 1 min', 5),
(125, 'Secondary Current', '5A', 1),
(125, 'Accuracy Class', 'Class 1.0', 2),
(125, 'Rated Burden', '5 VA', 3),
(125, 'Standard Compliance', 'IS 2705 / IEC 61869-2', 4),
(125, 'Insulation Level', '3 kV / 1 min', 5),
(38, 'Secondary Current', '5A', 1),
(38, 'Accuracy Class', 'Class 1.0', 2),
(38, 'Rated Burden', '5 VA', 3),
(38, 'Standard Compliance', 'IS 2705 / IEC 61869-2', 4),
(38, 'Insulation Level', '3 kV / 1 min', 5);

-- 8. Inquiries & Bulk RFQ Table
DROP TABLE IF EXISTS `inquiries`;
CREATE TABLE `inquiries` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `rfq_number` VARCHAR(40) NOT NULL UNIQUE,
  `customer_name` VARCHAR(120) NOT NULL,
  `company_name` VARCHAR(150) NULL,
  `email` VARCHAR(120) NULL,
  `phone` VARCHAR(30) NOT NULL,
  `gstin` VARCHAR(20) NULL,
  `delivery_address` TEXT NULL,
  `city` VARCHAR(80) NULL,
  `state` VARCHAR(80) NULL,
  `pincode` VARCHAR(12) NULL,
  `delivery_urgency` ENUM('immediate', '1_week', '15_days', 'regular_contract') DEFAULT 'immediate',
  `total_estimated_value` DECIMAL(12,2) DEFAULT 0.00,
  `notes` TEXT NULL,
  `status` ENUM('new', 'contacted', 'quoted', 'converted', 'closed') DEFAULT 'new',
  `source` VARCHAR(50) DEFAULT 'web_rfq_cart',
  `ip_address` VARCHAR(50) NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX (`rfq_number`),
  INDEX (`phone`),
  INDEX (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `inquiries` (`id`, `rfq_number`, `customer_name`, `company_name`, `email`, `phone`, `gstin`, `city`, `state`, `pincode`, `delivery_urgency`, `total_estimated_value`, `notes`, `status`) VALUES
(1, 'RFQ-2026-1001', 'Rajesh Sharma', 'Sharma Electricals & Switchboards', 'rajesh@sharmaelectricals.in', '+91 98765 43210', '07AABCS1234F1Z5', 'New Delhi', 'Delhi', '110020', 'immediate', 14000.00, 'Urgent requirement for Okhla Industrial Area panel installation. Need Class 0.5 certificate.', 'quoted'),
(2, 'RFQ-2026-1002', 'Vikram Patel', 'Apex Automation Pvt Ltd', 'procurement@apexauto.co.in', '+91 98220 11223', '24AAACA9876M1ZG', 'Ahmedabad', 'Gujarat', '382445', '1_week', 28000.00, 'Need 100 pcs 400/5A Square CTs. Please email proforma invoice with 18% GST.', 'new');

-- 9. Inquiry Items Table
DROP TABLE IF EXISTS `inquiry_items`;
CREATE TABLE `inquiry_items` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `inquiry_id` INT UNSIGNED NOT NULL,
  `product_id` INT UNSIGNED NULL,
  `product_name` VARCHAR(255) NOT NULL,
  `sku` VARCHAR(100) NULL,
  `quantity` INT UNSIGNED NOT NULL DEFAULT 10,
  `unit_price` DECIMAL(10,2) DEFAULT 280.00,
  `total_price` DECIMAL(12,2) DEFAULT 2800.00,
  `requested_specs` VARCHAR(255) NULL,
  INDEX (`inquiry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `inquiry_items` (`inquiry_id`, `product_id`, `product_name`, `sku`, `quantity`, `unit_price`, `total_price`) VALUES
(1, 258, '2500/5A Ring Current Transformer 115mm CT', '17040-MVG-R-115-1-1-1-1-1', 50, 280.00, 14000.00),
(2, 259, '2000/5A Ring Current Transformer 115mm CT', '17040-MVG-R-115-1-1-1-1', 100, 280.00, 28000.00);

-- 10. Custom Engineering CT RFQs
DROP TABLE IF EXISTS `custom_ct_rfqs`;
CREATE TABLE `custom_ct_rfqs` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `rfq_number` VARCHAR(40) NOT NULL UNIQUE,
  `company_name` VARCHAR(150) NOT NULL,
  `contact_person` VARCHAR(120) NOT NULL,
  `phone` VARCHAR(30) NOT NULL,
  `email` VARCHAR(120) NOT NULL,
  `primary_current` VARCHAR(60) NOT NULL,
  `secondary_current` VARCHAR(20) DEFAULT '5A',
  `accuracy_class` VARCHAR(30) DEFAULT 'Class 1.0',
  `rated_burden` VARCHAR(30) DEFAULT '5 VA',
  `window_type` VARCHAR(60) DEFAULT 'Round Cable',
  `window_dimension` VARCHAR(80) NULL,
  `insulation_type` VARCHAR(60) DEFAULT 'Polycarbonate Encapsulated',
  `quantity` INT UNSIGNED DEFAULT 10,
  `delivery_timeline` VARCHAR(60) DEFAULT 'Standard (7-10 Days)',
  `application_notes` TEXT NULL,
  `status` ENUM('new', 'design_review', 'quoted', 'approved', 'rejected') DEFAULT 'new',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `custom_ct_rfqs` (`rfq_number`, `company_name`, `contact_person`, `phone`, `email`, `primary_current`, `secondary_current`, `accuracy_class`, `rated_burden`, `window_dimension`, `quantity`, `application_notes`) VALUES
('CUST-2026-001', 'Larsen & Switchgear Panel Builders', 'Arun Mehta', '+91 99100 22334', 'arun@larsenpanels.com', '750A', '1A', 'Class 0.2S', '15 VA', '120x40 mm Busbar', 30, 'Dual core metering + protection CT for 11kV substation feeder panel.');

-- 11. Contact Form Messages
DROP TABLE IF EXISTS `contact_messages`;
CREATE TABLE `contact_messages` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(120) NOT NULL,
  `company` VARCHAR(150) NULL,
  `email` VARCHAR(120) NOT NULL,
  `phone` VARCHAR(30) NOT NULL,
  `subject` VARCHAR(200) NOT NULL,
  `message` TEXT NOT NULL,
  `status` ENUM('unread', 'read', 'replied', 'archived') DEFAULT 'unread',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `contact_messages` (`name`, `company`, `email`, `phone`, `subject`, `message`) VALUES
('Ramesh Kumar', 'Northern Switchgear Systems', 'ramesh@nssdelhi.com', '+91 98101 98101', 'Dealership / Authorized Wholesale Stockist Inquiry', 'We are interested in stocking MVG encapsulated current transformers for Haryana & Punjab industrial zones. Please arrange a call with your sales director.');

-- 12. Reviews Table
DROP TABLE IF EXISTS `reviews`;
CREATE TABLE `reviews` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `author_name` VARCHAR(120) NOT NULL,
  `user_badge` VARCHAR(100) DEFAULT 'Google Verified Customer',
  `rating` TINYINT UNSIGNED NOT NULL DEFAULT 5,
  `review_text` TEXT NOT NULL,
  `owner_reply` TEXT NULL,
  `review_date` VARCHAR(50) DEFAULT 'Recently',
  `source` VARCHAR(50) DEFAULT 'google',
  `status` ENUM('approved', 'pending', 'hidden') DEFAULT 'approved',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `reviews` (`author_name`, `user_badge`, `rating`, `review_text`, `owner_reply`, `review_date`, `source`, `status`) VALUES
('Kuldeep Dahiya', '2 reviews', 4, '', '[object Object]', 'Recently', 'google', 'approved'),
('Meenu Gupta', '5 reviews · 5 photos', 5, '', NULL, 'Recently', 'google', 'approved'),
('Anil Sharma', 'Local Guide · 14 reviews', 5, '', NULL, 'Recently', 'google', 'approved'),
('Pooja Aggarwal', '3 reviews · 2 photos', 5, '', '[object Object]', 'Recently', 'google', 'approved'),
('Sunil Verma', '8 reviews', 5, '', NULL, 'Recently', 'google', 'approved'),
('Manoj Yadav', 'Local Guide · 22 reviews · 11 photos', 5, '', NULL, 'Recently', 'google', 'approved'),
('Rohit Malhotra', '4 reviews', 5, '', NULL, 'Recently', 'google', 'approved'),
('Pradeep Kumar', '6 reviews', 5, '', NULL, 'Recently', 'google', 'approved'),
('Naresh Bansal', '11 reviews · 4 photos', 5, '', NULL, 'Recently', 'google', 'approved'),
('Gaurav Mehta', 'Local Guide · 31 reviews', 5, '', NULL, 'Recently', 'google', 'approved'),
('Sanjay Joshi', '3 reviews', 5, '', NULL, 'Recently', 'google', 'approved'),
('Deepak Chauhan', '7 reviews · 2 photos', 5, '', NULL, 'Recently', 'google', 'approved');

-- 13. System Logs
DROP TABLE IF EXISTS `system_logs`;
CREATE TABLE `system_logs` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `event_type` VARCHAR(60) NOT NULL,
  `description` TEXT NOT NULL,
  `user_id` INT UNSIGNED NULL,
  `ip_address` VARCHAR(50) NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `system_logs` (`event_type`, `description`) VALUES
('SYSTEM_INIT', 'MVG B2B E-Commerce & Inquiry Database Schema initialized with 40 products and full category hierarchy.');

SET FOREIGN_KEY_CHECKS = 1;

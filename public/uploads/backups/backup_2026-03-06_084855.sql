-- Database Backup: laravel
-- Date: 2026-03-06 08:48:57



-- Table: announcements
DROP TABLE IF EXISTS `announcements`;
CREATE TABLE `announcements` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `announcement_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `priority` enum('Low','Moderate','Urgent') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Moderate',
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `status` enum('Draft','Active','Expired','Archived') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Draft',
  `date_posted` date NOT NULL,
  `created_by_id` bigint unsigned NOT NULL,
  `attachments` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `announcements_announcement_id_unique` (`announcement_id`),
  KEY `announcements_created_by_id_foreign` (`created_by_id`),
  CONSTRAINT `announcements_created_by_id_foreign` FOREIGN KEY (`created_by_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `announcements` VALUES ('1', 'ANN-001', 'Important Announcement: Waste Collection Delay', 'Please be informed that today\'s waste collection has been temporary cancelled due to unforeseen maintenance issue. Regular collection will resume tomorrow. We apologize for the inconvenience', 'Moderate', '2025-09-12', '2025-09-15', 'Archived', '2025-09-12', '1', '[\"1772703106_69a94d827eeaf.docx\", \"http://localhost:8000/uploads/announcements/documents/1772703705_69a94fd987a51.docx\"]', '2025-09-12 08:00:00', '2026-03-05 09:41:49', NULL);
INSERT INTO `announcements` VALUES ('2', 'ANN-002', 'Important Notice: Waste Collection Halted', 'Please be informed that today\'s waste collection has been temporary cancelled due to unforeseen maintenance .....', 'Moderate', '2025-03-12', '2025-03-20', 'Expired', '2025-03-12', '2', '[]', '2025-03-12 09:30:00', '2025-03-12 09:30:00', NULL);
INSERT INTO `announcements` VALUES ('3', 'ANN-003', 'New Waste Segregation Guidelines', 'Starting next week, new waste segregation rules will be implemented. Please separate biodegradable, non-biodegradable, and recyclable waste.', 'Low', '2025-09-25', '2025-10-25', 'Expired', '2025-09-23', '1', '[\"guidelines.pdf\"]', '2025-09-23 10:00:00', '2026-03-05 09:23:25', NULL);
INSERT INTO `announcements` VALUES ('4', 'ANN-004', 'Holiday Schedule Adjustment', 'Waste collection schedule will be adjusted during the upcoming holidays. Please check the updated schedule.', 'Moderate', '2025-10-01', '2025-10-15', 'Expired', '2025-09-24', '2', '[\"holiday-schedule.pdf\"]', '2025-09-24 14:30:00', '2026-03-05 09:31:27', NULL);
INSERT INTO `announcements` VALUES ('5', 'ANN-005', 'Samnpoke', 'zdasdfd asdfasdf', 'Urgent', '2026-03-06', '2026-03-07', 'Active', '2026-03-05', '1', '[\"http://localhost:8000/uploads/announcements/documents/1772704300_69a9522c31df9.docx\", \"http://localhost:8000/uploads/announcements/documents/1772704304_69a952307e6a7.docx\"]', '2026-03-05 09:51:47', '2026-03-05 09:52:18', '2026-03-05 09:52:18');


-- Table: audit_logs
DROP TABLE IF EXISTS `audit_logs`;
CREATE TABLE `audit_logs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `user_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_role` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `module` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `ip_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('success','failed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'success',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `audit_logs_user_id_created_at_index` (`user_id`,`created_at`),
  KEY `audit_logs_module_action_index` (`module`,`action`),
  CONSTRAINT `audit_logs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=1654 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `audit_logs` VALUES ('1', '1', 'Admin User', 'Admin', 'Login', 'Authentication', 'User logged into the system', '192.168.1.100', 'success', '2026-03-04 16:45:23', '2026-03-05 07:03:54');
INSERT INTO `audit_logs` VALUES ('2', '1', 'Admin User', 'Admin', 'View', 'Dashboard', 'Accessed Dashboard page', '192.168.1.100', 'success', '2026-03-04 16:45:30', '2026-03-05 07:03:54');
INSERT INTO `audit_logs` VALUES ('3', '1', 'Admin User', 'Admin', 'Update', 'User Management', 'Updated user information', '192.168.1.100', 'success', '2026-03-04 16:50:15', '2026-03-05 07:03:54');
INSERT INTO `audit_logs` VALUES ('4', '2', 'Staff User', 'Staff', 'View', 'Reports Management', 'Viewed report details', '192.168.1.105', 'success', '2026-03-04 16:55:00', '2026-03-05 07:03:54');
INSERT INTO `audit_logs` VALUES ('5', '2', 'Staff User', 'Staff', 'Update', 'Reports Management', 'Changed report status to In Progress', '192.168.1.105', 'success', '2026-03-04 16:56:30', '2026-03-05 07:03:54');
INSERT INTO `audit_logs` VALUES ('6', '1', 'Admin User', 'Admin', 'Create', 'Announcements', 'Created new announcement', '192.168.1.100', 'success', '2026-03-04 17:00:00', '2026-03-05 07:03:54');
INSERT INTO `audit_logs` VALUES ('7', '1', 'Admin User', 'Admin', 'Delete', 'User Management', 'Deleted user account', '192.168.1.100', 'success', '2026-03-04 17:05:45', '2026-03-05 07:03:54');
INSERT INTO `audit_logs` VALUES ('8', '2', 'Staff User', 'Staff', 'Login', 'Authentication', 'Failed login attempt - incorrect password', '192.168.1.105', 'failed', '2026-03-04 17:10:00', '2026-03-05 07:03:54');
INSERT INTO `audit_logs` VALUES ('9', '1', 'Admin User', 'Admin', 'Update', 'System Settings', 'Changed site maintenance mode to ON', '192.168.1.100', 'success', '2026-03-04 17:15:30', '2026-03-05 07:03:54');
INSERT INTO `audit_logs` VALUES ('10', '1', 'Admin User', 'Admin', 'Export', 'System Settings', 'Exported database backup', '192.168.1.100', 'success', '2026-03-04 17:20:00', '2026-03-05 07:03:54');
INSERT INTO `audit_logs` VALUES ('11', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:04:10', '2026-03-05 07:04:10');
INSERT INTO `audit_logs` VALUES ('12', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:04:10', '2026-03-05 07:04:10');
INSERT INTO `audit_logs` VALUES ('13', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:04:11', '2026-03-05 07:04:11');
INSERT INTO `audit_logs` VALUES ('14', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:04:11', '2026-03-05 07:04:11');
INSERT INTO `audit_logs` VALUES ('15', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:04:11', '2026-03-05 07:04:11');
INSERT INTO `audit_logs` VALUES ('16', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:04:11', '2026-03-05 07:04:11');
INSERT INTO `audit_logs` VALUES ('17', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:04:12', '2026-03-05 07:04:12');
INSERT INTO `audit_logs` VALUES ('18', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:04:12', '2026-03-05 07:04:12');
INSERT INTO `audit_logs` VALUES ('19', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:04:12', '2026-03-05 07:04:12');
INSERT INTO `audit_logs` VALUES ('20', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:04:12', '2026-03-05 07:04:12');
INSERT INTO `audit_logs` VALUES ('21', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:04:13', '2026-03-05 07:04:13');
INSERT INTO `audit_logs` VALUES ('22', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:04:51', '2026-03-05 07:04:51');
INSERT INTO `audit_logs` VALUES ('23', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:04:51', '2026-03-05 07:04:51');
INSERT INTO `audit_logs` VALUES ('24', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:04:51', '2026-03-05 07:04:51');
INSERT INTO `audit_logs` VALUES ('25', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:04:52', '2026-03-05 07:04:52');
INSERT INTO `audit_logs` VALUES ('26', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:04:52', '2026-03-05 07:04:52');
INSERT INTO `audit_logs` VALUES ('27', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:04:52', '2026-03-05 07:04:52');
INSERT INTO `audit_logs` VALUES ('28', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:04:53', '2026-03-05 07:04:53');
INSERT INTO `audit_logs` VALUES ('29', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:04:53', '2026-03-05 07:04:53');
INSERT INTO `audit_logs` VALUES ('30', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:04:53', '2026-03-05 07:04:53');
INSERT INTO `audit_logs` VALUES ('31', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:04:53', '2026-03-05 07:04:53');
INSERT INTO `audit_logs` VALUES ('32', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:04:54', '2026-03-05 07:04:54');
INSERT INTO `audit_logs` VALUES ('33', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:05:14', '2026-03-05 07:05:14');
INSERT INTO `audit_logs` VALUES ('34', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:05:14', '2026-03-05 07:05:14');
INSERT INTO `audit_logs` VALUES ('35', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:05:14', '2026-03-05 07:05:14');
INSERT INTO `audit_logs` VALUES ('36', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:05:15', '2026-03-05 07:05:15');
INSERT INTO `audit_logs` VALUES ('37', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:05:15', '2026-03-05 07:05:15');
INSERT INTO `audit_logs` VALUES ('38', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:05:15', '2026-03-05 07:05:15');
INSERT INTO `audit_logs` VALUES ('39', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:05:16', '2026-03-05 07:05:16');
INSERT INTO `audit_logs` VALUES ('40', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:05:16', '2026-03-05 07:05:16');
INSERT INTO `audit_logs` VALUES ('41', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:05:16', '2026-03-05 07:05:16');
INSERT INTO `audit_logs` VALUES ('42', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:05:17', '2026-03-05 07:05:17');
INSERT INTO `audit_logs` VALUES ('43', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:05:17', '2026-03-05 07:05:17');
INSERT INTO `audit_logs` VALUES ('44', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:05:41', '2026-03-05 07:05:41');
INSERT INTO `audit_logs` VALUES ('45', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:05:42', '2026-03-05 07:05:42');
INSERT INTO `audit_logs` VALUES ('46', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:05:42', '2026-03-05 07:05:42');
INSERT INTO `audit_logs` VALUES ('47', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:05:42', '2026-03-05 07:05:42');
INSERT INTO `audit_logs` VALUES ('48', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:05:43', '2026-03-05 07:05:43');
INSERT INTO `audit_logs` VALUES ('49', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:05:43', '2026-03-05 07:05:43');
INSERT INTO `audit_logs` VALUES ('50', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:05:43', '2026-03-05 07:05:43');
INSERT INTO `audit_logs` VALUES ('51', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:05:44', '2026-03-05 07:05:44');
INSERT INTO `audit_logs` VALUES ('52', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:05:44', '2026-03-05 07:05:44');
INSERT INTO `audit_logs` VALUES ('53', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:05:44', '2026-03-05 07:05:44');
INSERT INTO `audit_logs` VALUES ('54', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:05:44', '2026-03-05 07:05:44');
INSERT INTO `audit_logs` VALUES ('55', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:05:49', '2026-03-05 07:05:49');
INSERT INTO `audit_logs` VALUES ('56', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:05:50', '2026-03-05 07:05:50');
INSERT INTO `audit_logs` VALUES ('57', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:05:50', '2026-03-05 07:05:50');
INSERT INTO `audit_logs` VALUES ('58', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:05:50', '2026-03-05 07:05:50');
INSERT INTO `audit_logs` VALUES ('59', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:05:50', '2026-03-05 07:05:50');
INSERT INTO `audit_logs` VALUES ('60', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:05:51', '2026-03-05 07:05:51');
INSERT INTO `audit_logs` VALUES ('61', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:06:43', '2026-03-05 07:06:43');
INSERT INTO `audit_logs` VALUES ('62', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:06:43', '2026-03-05 07:06:43');
INSERT INTO `audit_logs` VALUES ('63', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:06:44', '2026-03-05 07:06:44');
INSERT INTO `audit_logs` VALUES ('64', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:06:44', '2026-03-05 07:06:44');
INSERT INTO `audit_logs` VALUES ('65', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:06:44', '2026-03-05 07:06:44');
INSERT INTO `audit_logs` VALUES ('66', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:06:44', '2026-03-05 07:06:44');
INSERT INTO `audit_logs` VALUES ('67', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:06:45', '2026-03-05 07:06:45');
INSERT INTO `audit_logs` VALUES ('68', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:06:45', '2026-03-05 07:06:45');
INSERT INTO `audit_logs` VALUES ('69', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:06:45', '2026-03-05 07:06:45');
INSERT INTO `audit_logs` VALUES ('70', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:06:45', '2026-03-05 07:06:45');
INSERT INTO `audit_logs` VALUES ('71', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:06:46', '2026-03-05 07:06:46');
INSERT INTO `audit_logs` VALUES ('72', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:07:05', '2026-03-05 07:07:05');
INSERT INTO `audit_logs` VALUES ('73', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:07:06', '2026-03-05 07:07:06');
INSERT INTO `audit_logs` VALUES ('74', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:07:06', '2026-03-05 07:07:06');
INSERT INTO `audit_logs` VALUES ('75', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:07:06', '2026-03-05 07:07:06');
INSERT INTO `audit_logs` VALUES ('76', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:07:06', '2026-03-05 07:07:06');
INSERT INTO `audit_logs` VALUES ('77', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:07:07', '2026-03-05 07:07:07');
INSERT INTO `audit_logs` VALUES ('78', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:07:07', '2026-03-05 07:07:07');
INSERT INTO `audit_logs` VALUES ('79', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:07:07', '2026-03-05 07:07:07');
INSERT INTO `audit_logs` VALUES ('80', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:07:07', '2026-03-05 07:07:07');
INSERT INTO `audit_logs` VALUES ('81', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:07:08', '2026-03-05 07:07:08');
INSERT INTO `audit_logs` VALUES ('82', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:07:08', '2026-03-05 07:07:08');
INSERT INTO `audit_logs` VALUES ('83', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:08:50', '2026-03-05 07:08:50');
INSERT INTO `audit_logs` VALUES ('84', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:08:50', '2026-03-05 07:08:50');
INSERT INTO `audit_logs` VALUES ('85', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:08:50', '2026-03-05 07:08:50');
INSERT INTO `audit_logs` VALUES ('86', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:08:51', '2026-03-05 07:08:51');
INSERT INTO `audit_logs` VALUES ('87', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:08:51', '2026-03-05 07:08:51');
INSERT INTO `audit_logs` VALUES ('88', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:08:51', '2026-03-05 07:08:51');
INSERT INTO `audit_logs` VALUES ('89', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:09:07', '2026-03-05 07:09:07');
INSERT INTO `audit_logs` VALUES ('90', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:09:07', '2026-03-05 07:09:07');
INSERT INTO `audit_logs` VALUES ('91', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:09:07', '2026-03-05 07:09:07');
INSERT INTO `audit_logs` VALUES ('92', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:09:08', '2026-03-05 07:09:08');
INSERT INTO `audit_logs` VALUES ('93', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:09:08', '2026-03-05 07:09:08');
INSERT INTO `audit_logs` VALUES ('94', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:09:09', '2026-03-05 07:09:09');
INSERT INTO `audit_logs` VALUES ('95', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:09:09', '2026-03-05 07:09:09');
INSERT INTO `audit_logs` VALUES ('96', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:09:09', '2026-03-05 07:09:09');
INSERT INTO `audit_logs` VALUES ('97', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:09:10', '2026-03-05 07:09:10');
INSERT INTO `audit_logs` VALUES ('98', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:09:10', '2026-03-05 07:09:10');
INSERT INTO `audit_logs` VALUES ('99', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:09:10', '2026-03-05 07:09:10');
INSERT INTO `audit_logs` VALUES ('100', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:09:11', '2026-03-05 07:09:11');
INSERT INTO `audit_logs` VALUES ('101', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:09:11', '2026-03-05 07:09:11');
INSERT INTO `audit_logs` VALUES ('102', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:09:12', '2026-03-05 07:09:12');
INSERT INTO `audit_logs` VALUES ('103', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:09:12', '2026-03-05 07:09:12');
INSERT INTO `audit_logs` VALUES ('104', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:09:12', '2026-03-05 07:09:12');
INSERT INTO `audit_logs` VALUES ('105', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:09:12', '2026-03-05 07:09:12');
INSERT INTO `audit_logs` VALUES ('106', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:09:13', '2026-03-05 07:09:13');
INSERT INTO `audit_logs` VALUES ('107', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:09:13', '2026-03-05 07:09:13');
INSERT INTO `audit_logs` VALUES ('108', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:09:13', '2026-03-05 07:09:13');
INSERT INTO `audit_logs` VALUES ('109', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:09:13', '2026-03-05 07:09:13');
INSERT INTO `audit_logs` VALUES ('110', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:09:14', '2026-03-05 07:09:14');
INSERT INTO `audit_logs` VALUES ('111', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:09:14', '2026-03-05 07:09:14');
INSERT INTO `audit_logs` VALUES ('112', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:09:14', '2026-03-05 07:09:14');
INSERT INTO `audit_logs` VALUES ('113', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:09:15', '2026-03-05 07:09:15');
INSERT INTO `audit_logs` VALUES ('114', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:09:15', '2026-03-05 07:09:15');
INSERT INTO `audit_logs` VALUES ('115', '1', 'Josh Gracxiosa', 'Admin', 'Mark Read', 'Notifications', 'Mark Read in Notifications (ID: 1)', '127.0.0.1', 'success', '2026-03-05 07:09:17', '2026-03-05 07:09:17');
INSERT INTO `audit_logs` VALUES ('116', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:09:17', '2026-03-05 07:09:17');
INSERT INTO `audit_logs` VALUES ('117', '1', 'Josh Gracxiosa', 'Admin', 'Mark Read', 'Notifications', 'Mark Read in Notifications (ID: 2)', '127.0.0.1', 'success', '2026-03-05 07:09:22', '2026-03-05 07:09:22');
INSERT INTO `audit_logs` VALUES ('118', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:09:22', '2026-03-05 07:09:22');
INSERT INTO `audit_logs` VALUES ('119', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:09:30', '2026-03-05 07:09:30');
INSERT INTO `audit_logs` VALUES ('120', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:09:31', '2026-03-05 07:09:31');
INSERT INTO `audit_logs` VALUES ('121', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:09:31', '2026-03-05 07:09:31');
INSERT INTO `audit_logs` VALUES ('122', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:09:32', '2026-03-05 07:09:32');
INSERT INTO `audit_logs` VALUES ('123', '1', 'Josh Gracxiosa', 'Admin', 'Create', 'Notifications', 'Create in Notifications (ID: 1)', '127.0.0.1', 'success', '2026-03-05 07:09:38', '2026-03-05 07:09:38');
INSERT INTO `audit_logs` VALUES ('124', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:09:38', '2026-03-05 07:09:38');
INSERT INTO `audit_logs` VALUES ('125', '1', 'Josh Gracxiosa', 'Admin', 'Mark Read', 'Notifications', 'Mark Read in Notifications (ID: 1)', '127.0.0.1', 'success', '2026-03-05 07:09:39', '2026-03-05 07:09:39');
INSERT INTO `audit_logs` VALUES ('126', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:09:40', '2026-03-05 07:09:40');
INSERT INTO `audit_logs` VALUES ('127', '1', 'Josh Gracxiosa', 'Admin', 'Create', 'Notifications', 'Create in Notifications (ID: 1)', '127.0.0.1', 'success', '2026-03-05 07:09:41', '2026-03-05 07:09:41');
INSERT INTO `audit_logs` VALUES ('128', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:09:41', '2026-03-05 07:09:41');
INSERT INTO `audit_logs` VALUES ('129', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:09:42', '2026-03-05 07:09:42');
INSERT INTO `audit_logs` VALUES ('130', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:09:42', '2026-03-05 07:09:42');
INSERT INTO `audit_logs` VALUES ('131', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:09:43', '2026-03-05 07:09:43');
INSERT INTO `audit_logs` VALUES ('132', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:09:43', '2026-03-05 07:09:43');
INSERT INTO `audit_logs` VALUES ('133', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:09:43', '2026-03-05 07:09:43');
INSERT INTO `audit_logs` VALUES ('134', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:09:44', '2026-03-05 07:09:44');
INSERT INTO `audit_logs` VALUES ('135', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:09:44', '2026-03-05 07:09:44');
INSERT INTO `audit_logs` VALUES ('136', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:09:44', '2026-03-05 07:09:44');
INSERT INTO `audit_logs` VALUES ('137', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:09:44', '2026-03-05 07:09:44');
INSERT INTO `audit_logs` VALUES ('138', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:09:45', '2026-03-05 07:09:45');
INSERT INTO `audit_logs` VALUES ('139', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:09:45', '2026-03-05 07:09:45');
INSERT INTO `audit_logs` VALUES ('140', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:09:45', '2026-03-05 07:09:45');
INSERT INTO `audit_logs` VALUES ('141', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:09:46', '2026-03-05 07:09:46');
INSERT INTO `audit_logs` VALUES ('142', '1', 'Josh Gracxiosa', 'Admin', 'Mark Read', 'Notifications', 'Mark Read in Notifications (ID: 1)', '127.0.0.1', 'success', '2026-03-05 07:09:46', '2026-03-05 07:09:46');
INSERT INTO `audit_logs` VALUES ('143', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:09:46', '2026-03-05 07:09:46');
INSERT INTO `audit_logs` VALUES ('144', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:09:50', '2026-03-05 07:09:50');
INSERT INTO `audit_logs` VALUES ('145', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:09:50', '2026-03-05 07:09:50');
INSERT INTO `audit_logs` VALUES ('146', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:09:51', '2026-03-05 07:09:51');
INSERT INTO `audit_logs` VALUES ('147', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:09:51', '2026-03-05 07:09:51');
INSERT INTO `audit_logs` VALUES ('148', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:09:51', '2026-03-05 07:09:51');
INSERT INTO `audit_logs` VALUES ('149', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:09:52', '2026-03-05 07:09:52');
INSERT INTO `audit_logs` VALUES ('150', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:09:52', '2026-03-05 07:09:52');
INSERT INTO `audit_logs` VALUES ('151', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:09:52', '2026-03-05 07:09:52');
INSERT INTO `audit_logs` VALUES ('152', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:09:52', '2026-03-05 07:09:52');
INSERT INTO `audit_logs` VALUES ('153', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:09:53', '2026-03-05 07:09:53');
INSERT INTO `audit_logs` VALUES ('154', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:09:53', '2026-03-05 07:09:53');
INSERT INTO `audit_logs` VALUES ('155', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:09:53', '2026-03-05 07:09:53');
INSERT INTO `audit_logs` VALUES ('156', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:10:00', '2026-03-05 07:10:00');
INSERT INTO `audit_logs` VALUES ('157', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:10:01', '2026-03-05 07:10:01');
INSERT INTO `audit_logs` VALUES ('158', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:10:01', '2026-03-05 07:10:01');
INSERT INTO `audit_logs` VALUES ('159', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:10:01', '2026-03-05 07:10:01');
INSERT INTO `audit_logs` VALUES ('160', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:10:12', '2026-03-05 07:10:12');
INSERT INTO `audit_logs` VALUES ('161', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:10:43', '2026-03-05 07:10:43');
INSERT INTO `audit_logs` VALUES ('162', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:11:13', '2026-03-05 07:11:13');
INSERT INTO `audit_logs` VALUES ('163', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:11:43', '2026-03-05 07:11:43');
INSERT INTO `audit_logs` VALUES ('164', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:11:47', '2026-03-05 07:11:47');
INSERT INTO `audit_logs` VALUES ('165', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:11:47', '2026-03-05 07:11:47');
INSERT INTO `audit_logs` VALUES ('166', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:11:48', '2026-03-05 07:11:48');
INSERT INTO `audit_logs` VALUES ('167', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:11:48', '2026-03-05 07:11:48');
INSERT INTO `audit_logs` VALUES ('168', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:11:48', '2026-03-05 07:11:48');
INSERT INTO `audit_logs` VALUES ('169', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:11:49', '2026-03-05 07:11:49');
INSERT INTO `audit_logs` VALUES ('170', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:12:06', '2026-03-05 07:12:06');
INSERT INTO `audit_logs` VALUES ('171', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:12:07', '2026-03-05 07:12:07');
INSERT INTO `audit_logs` VALUES ('172', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:12:07', '2026-03-05 07:12:07');
INSERT INTO `audit_logs` VALUES ('173', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:12:07', '2026-03-05 07:12:07');
INSERT INTO `audit_logs` VALUES ('174', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:12:08', '2026-03-05 07:12:08');
INSERT INTO `audit_logs` VALUES ('175', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:12:08', '2026-03-05 07:12:08');
INSERT INTO `audit_logs` VALUES ('176', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:12:08', '2026-03-05 07:12:08');
INSERT INTO `audit_logs` VALUES ('177', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:12:09', '2026-03-05 07:12:09');
INSERT INTO `audit_logs` VALUES ('178', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:12:09', '2026-03-05 07:12:09');
INSERT INTO `audit_logs` VALUES ('179', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:12:09', '2026-03-05 07:12:09');
INSERT INTO `audit_logs` VALUES ('180', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:12:10', '2026-03-05 07:12:10');
INSERT INTO `audit_logs` VALUES ('181', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:12:10', '2026-03-05 07:12:10');
INSERT INTO `audit_logs` VALUES ('182', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:12:10', '2026-03-05 07:12:10');
INSERT INTO `audit_logs` VALUES ('183', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:12:43', '2026-03-05 07:12:43');
INSERT INTO `audit_logs` VALUES ('184', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:12:43', '2026-03-05 07:12:43');
INSERT INTO `audit_logs` VALUES ('185', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:12:43', '2026-03-05 07:12:43');
INSERT INTO `audit_logs` VALUES ('186', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:12:44', '2026-03-05 07:12:44');
INSERT INTO `audit_logs` VALUES ('187', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:13:33', '2026-03-05 07:13:33');
INSERT INTO `audit_logs` VALUES ('188', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:13:33', '2026-03-05 07:13:33');
INSERT INTO `audit_logs` VALUES ('189', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:13:34', '2026-03-05 07:13:34');
INSERT INTO `audit_logs` VALUES ('190', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:13:34', '2026-03-05 07:13:34');
INSERT INTO `audit_logs` VALUES ('191', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:13:34', '2026-03-05 07:13:34');
INSERT INTO `audit_logs` VALUES ('192', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:13:35', '2026-03-05 07:13:35');
INSERT INTO `audit_logs` VALUES ('193', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:13:35', '2026-03-05 07:13:35');
INSERT INTO `audit_logs` VALUES ('194', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:13:35', '2026-03-05 07:13:35');
INSERT INTO `audit_logs` VALUES ('195', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:13:35', '2026-03-05 07:13:35');
INSERT INTO `audit_logs` VALUES ('196', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:13:36', '2026-03-05 07:13:36');
INSERT INTO `audit_logs` VALUES ('197', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:13:36', '2026-03-05 07:13:36');
INSERT INTO `audit_logs` VALUES ('198', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:13:37', '2026-03-05 07:13:37');
INSERT INTO `audit_logs` VALUES ('199', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:13:37', '2026-03-05 07:13:37');
INSERT INTO `audit_logs` VALUES ('200', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:13:41', '2026-03-05 07:13:41');
INSERT INTO `audit_logs` VALUES ('201', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:13:41', '2026-03-05 07:13:41');
INSERT INTO `audit_logs` VALUES ('202', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:13:41', '2026-03-05 07:13:41');
INSERT INTO `audit_logs` VALUES ('203', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:13:41', '2026-03-05 07:13:41');
INSERT INTO `audit_logs` VALUES ('204', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:13:42', '2026-03-05 07:13:42');
INSERT INTO `audit_logs` VALUES ('205', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:13:42', '2026-03-05 07:13:42');
INSERT INTO `audit_logs` VALUES ('206', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:13:42', '2026-03-05 07:13:42');
INSERT INTO `audit_logs` VALUES ('207', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:13:43', '2026-03-05 07:13:43');
INSERT INTO `audit_logs` VALUES ('208', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:13:43', '2026-03-05 07:13:43');
INSERT INTO `audit_logs` VALUES ('209', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:13:43', '2026-03-05 07:13:43');
INSERT INTO `audit_logs` VALUES ('210', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:13:44', '2026-03-05 07:13:44');
INSERT INTO `audit_logs` VALUES ('211', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:13:44', '2026-03-05 07:13:44');
INSERT INTO `audit_logs` VALUES ('212', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:13:44', '2026-03-05 07:13:44');
INSERT INTO `audit_logs` VALUES ('213', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:13:46', '2026-03-05 07:13:46');
INSERT INTO `audit_logs` VALUES ('214', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:13:47', '2026-03-05 07:13:47');
INSERT INTO `audit_logs` VALUES ('215', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:13:47', '2026-03-05 07:13:47');
INSERT INTO `audit_logs` VALUES ('216', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:13:47', '2026-03-05 07:13:47');
INSERT INTO `audit_logs` VALUES ('217', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:14:31', '2026-03-05 07:14:31');
INSERT INTO `audit_logs` VALUES ('218', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:14:31', '2026-03-05 07:14:31');
INSERT INTO `audit_logs` VALUES ('219', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:14:32', '2026-03-05 07:14:32');
INSERT INTO `audit_logs` VALUES ('220', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:14:33', '2026-03-05 07:14:33');
INSERT INTO `audit_logs` VALUES ('221', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:14:34', '2026-03-05 07:14:34');
INSERT INTO `audit_logs` VALUES ('222', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:14:34', '2026-03-05 07:14:34');
INSERT INTO `audit_logs` VALUES ('223', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:14:35', '2026-03-05 07:14:35');
INSERT INTO `audit_logs` VALUES ('224', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:14:35', '2026-03-05 07:14:35');
INSERT INTO `audit_logs` VALUES ('225', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:14:37', '2026-03-05 07:14:37');
INSERT INTO `audit_logs` VALUES ('226', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:14:37', '2026-03-05 07:14:37');
INSERT INTO `audit_logs` VALUES ('227', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:14:38', '2026-03-05 07:14:38');
INSERT INTO `audit_logs` VALUES ('228', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:14:38', '2026-03-05 07:14:38');
INSERT INTO `audit_logs` VALUES ('229', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:14:39', '2026-03-05 07:14:39');
INSERT INTO `audit_logs` VALUES ('230', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:14:39', '2026-03-05 07:14:39');
INSERT INTO `audit_logs` VALUES ('231', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:14:39', '2026-03-05 07:14:39');
INSERT INTO `audit_logs` VALUES ('232', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:14:40', '2026-03-05 07:14:40');
INSERT INTO `audit_logs` VALUES ('233', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:14:40', '2026-03-05 07:14:40');
INSERT INTO `audit_logs` VALUES ('234', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:14:41', '2026-03-05 07:14:41');
INSERT INTO `audit_logs` VALUES ('235', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:14:41', '2026-03-05 07:14:41');
INSERT INTO `audit_logs` VALUES ('236', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:14:41', '2026-03-05 07:14:41');
INSERT INTO `audit_logs` VALUES ('237', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:14:42', '2026-03-05 07:14:42');
INSERT INTO `audit_logs` VALUES ('238', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:14:42', '2026-03-05 07:14:42');
INSERT INTO `audit_logs` VALUES ('239', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:14:43', '2026-03-05 07:14:43');
INSERT INTO `audit_logs` VALUES ('240', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:14:43', '2026-03-05 07:14:43');
INSERT INTO `audit_logs` VALUES ('241', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:14:44', '2026-03-05 07:14:44');
INSERT INTO `audit_logs` VALUES ('242', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:14:44', '2026-03-05 07:14:44');
INSERT INTO `audit_logs` VALUES ('243', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:14:44', '2026-03-05 07:14:44');
INSERT INTO `audit_logs` VALUES ('244', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:14:45', '2026-03-05 07:14:45');
INSERT INTO `audit_logs` VALUES ('245', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:14:46', '2026-03-05 07:14:46');
INSERT INTO `audit_logs` VALUES ('246', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:14:46', '2026-03-05 07:14:46');
INSERT INTO `audit_logs` VALUES ('247', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:14:46', '2026-03-05 07:14:46');
INSERT INTO `audit_logs` VALUES ('248', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:14:47', '2026-03-05 07:14:47');
INSERT INTO `audit_logs` VALUES ('249', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:14:47', '2026-03-05 07:14:47');
INSERT INTO `audit_logs` VALUES ('250', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:14:48', '2026-03-05 07:14:48');
INSERT INTO `audit_logs` VALUES ('251', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:14:49', '2026-03-05 07:14:49');
INSERT INTO `audit_logs` VALUES ('252', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:14:49', '2026-03-05 07:14:49');
INSERT INTO `audit_logs` VALUES ('253', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:14:50', '2026-03-05 07:14:50');
INSERT INTO `audit_logs` VALUES ('254', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:14:50', '2026-03-05 07:14:50');
INSERT INTO `audit_logs` VALUES ('255', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:14:50', '2026-03-05 07:14:50');
INSERT INTO `audit_logs` VALUES ('256', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:14:51', '2026-03-05 07:14:51');
INSERT INTO `audit_logs` VALUES ('257', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:15:17', '2026-03-05 07:15:17');
INSERT INTO `audit_logs` VALUES ('258', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:16:05', '2026-03-05 07:16:05');
INSERT INTO `audit_logs` VALUES ('259', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:16:06', '2026-03-05 07:16:06');
INSERT INTO `audit_logs` VALUES ('260', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:16:06', '2026-03-05 07:16:06');
INSERT INTO `audit_logs` VALUES ('261', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:16:06', '2026-03-05 07:16:06');
INSERT INTO `audit_logs` VALUES ('262', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:16:07', '2026-03-05 07:16:07');
INSERT INTO `audit_logs` VALUES ('263', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:16:07', '2026-03-05 07:16:07');
INSERT INTO `audit_logs` VALUES ('264', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:16:07', '2026-03-05 07:16:07');
INSERT INTO `audit_logs` VALUES ('265', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:16:08', '2026-03-05 07:16:08');
INSERT INTO `audit_logs` VALUES ('266', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:16:08', '2026-03-05 07:16:08');
INSERT INTO `audit_logs` VALUES ('267', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:16:08', '2026-03-05 07:16:08');
INSERT INTO `audit_logs` VALUES ('268', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:16:09', '2026-03-05 07:16:09');
INSERT INTO `audit_logs` VALUES ('269', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:16:09', '2026-03-05 07:16:09');
INSERT INTO `audit_logs` VALUES ('270', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:16:09', '2026-03-05 07:16:09');
INSERT INTO `audit_logs` VALUES ('271', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:16:12', '2026-03-05 07:16:12');
INSERT INTO `audit_logs` VALUES ('272', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:16:12', '2026-03-05 07:16:12');
INSERT INTO `audit_logs` VALUES ('273', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:16:12', '2026-03-05 07:16:12');
INSERT INTO `audit_logs` VALUES ('274', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:16:13', '2026-03-05 07:16:13');
INSERT INTO `audit_logs` VALUES ('275', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:18:41', '2026-03-05 07:18:41');
INSERT INTO `audit_logs` VALUES ('276', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:18:41', '2026-03-05 07:18:41');
INSERT INTO `audit_logs` VALUES ('277', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:18:42', '2026-03-05 07:18:42');
INSERT INTO `audit_logs` VALUES ('278', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:18:50', '2026-03-05 07:18:50');
INSERT INTO `audit_logs` VALUES ('279', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:18:50', '2026-03-05 07:18:50');
INSERT INTO `audit_logs` VALUES ('280', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:18:51', '2026-03-05 07:18:51');
INSERT INTO `audit_logs` VALUES ('281', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:18:51', '2026-03-05 07:18:51');
INSERT INTO `audit_logs` VALUES ('282', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:18:53', '2026-03-05 07:18:53');
INSERT INTO `audit_logs` VALUES ('283', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:18:54', '2026-03-05 07:18:54');
INSERT INTO `audit_logs` VALUES ('284', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:18:54', '2026-03-05 07:18:54');
INSERT INTO `audit_logs` VALUES ('285', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:18:54', '2026-03-05 07:18:54');
INSERT INTO `audit_logs` VALUES ('286', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:18:55', '2026-03-05 07:18:55');
INSERT INTO `audit_logs` VALUES ('287', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:18:55', '2026-03-05 07:18:55');
INSERT INTO `audit_logs` VALUES ('288', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:18:56', '2026-03-05 07:18:56');
INSERT INTO `audit_logs` VALUES ('289', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:18:56', '2026-03-05 07:18:56');
INSERT INTO `audit_logs` VALUES ('290', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:18:56', '2026-03-05 07:18:56');
INSERT INTO `audit_logs` VALUES ('291', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:18:56', '2026-03-05 07:18:56');
INSERT INTO `audit_logs` VALUES ('292', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:18:57', '2026-03-05 07:18:57');
INSERT INTO `audit_logs` VALUES ('293', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:18:57', '2026-03-05 07:18:57');
INSERT INTO `audit_logs` VALUES ('294', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:18:57', '2026-03-05 07:18:57');
INSERT INTO `audit_logs` VALUES ('295', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:18:58', '2026-03-05 07:18:58');
INSERT INTO `audit_logs` VALUES ('296', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:18:58', '2026-03-05 07:18:58');
INSERT INTO `audit_logs` VALUES ('297', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:18:58', '2026-03-05 07:18:58');
INSERT INTO `audit_logs` VALUES ('298', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:18:59', '2026-03-05 07:18:59');
INSERT INTO `audit_logs` VALUES ('299', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:18:59', '2026-03-05 07:18:59');
INSERT INTO `audit_logs` VALUES ('300', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:18:59', '2026-03-05 07:18:59');
INSERT INTO `audit_logs` VALUES ('301', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:24:08', '2026-03-05 07:24:08');
INSERT INTO `audit_logs` VALUES ('302', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:24:08', '2026-03-05 07:24:08');
INSERT INTO `audit_logs` VALUES ('303', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:24:08', '2026-03-05 07:24:08');
INSERT INTO `audit_logs` VALUES ('304', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:24:09', '2026-03-05 07:24:09');
INSERT INTO `audit_logs` VALUES ('305', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:25:51', '2026-03-05 07:25:51');
INSERT INTO `audit_logs` VALUES ('306', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:25:52', '2026-03-05 07:25:52');
INSERT INTO `audit_logs` VALUES ('307', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:25:52', '2026-03-05 07:25:52');
INSERT INTO `audit_logs` VALUES ('308', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:25:53', '2026-03-05 07:25:53');
INSERT INTO `audit_logs` VALUES ('309', '1', 'Josh Gracxiosa', 'Admin', 'Update', 'System', 'Update in System', '127.0.0.1', 'failed', '2026-03-05 07:27:13', '2026-03-05 07:27:13');
INSERT INTO `audit_logs` VALUES ('310', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:29:16', '2026-03-05 07:29:16');
INSERT INTO `audit_logs` VALUES ('311', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:29:16', '2026-03-05 07:29:16');
INSERT INTO `audit_logs` VALUES ('312', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:29:17', '2026-03-05 07:29:17');
INSERT INTO `audit_logs` VALUES ('313', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:29:17', '2026-03-05 07:29:17');
INSERT INTO `audit_logs` VALUES ('314', '1', 'Josh Gracxiosa', 'Admin', 'Update', 'System', 'Update in System', '127.0.0.1', 'failed', '2026-03-05 07:29:26', '2026-03-05 07:29:26');
INSERT INTO `audit_logs` VALUES ('315', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:31:32', '2026-03-05 07:31:32');
INSERT INTO `audit_logs` VALUES ('316', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:31:32', '2026-03-05 07:31:32');
INSERT INTO `audit_logs` VALUES ('317', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:31:33', '2026-03-05 07:31:33');
INSERT INTO `audit_logs` VALUES ('318', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:31:33', '2026-03-05 07:31:33');
INSERT INTO `audit_logs` VALUES ('319', '1', 'Josh Gracxiosa', 'Admin', 'Update', 'System', 'Update in System', '127.0.0.1', 'success', '2026-03-05 07:31:40', '2026-03-05 07:31:40');
INSERT INTO `audit_logs` VALUES ('320', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:31:40', '2026-03-05 07:31:40');
INSERT INTO `audit_logs` VALUES ('321', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:31:41', '2026-03-05 07:31:41');
INSERT INTO `audit_logs` VALUES ('322', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:31:41', '2026-03-05 07:31:41');
INSERT INTO `audit_logs` VALUES ('323', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:31:42', '2026-03-05 07:31:42');
INSERT INTO `audit_logs` VALUES ('324', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:32:05', '2026-03-05 07:32:05');
INSERT INTO `audit_logs` VALUES ('325', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:32:05', '2026-03-05 07:32:05');
INSERT INTO `audit_logs` VALUES ('326', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:32:05', '2026-03-05 07:32:05');
INSERT INTO `audit_logs` VALUES ('327', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:32:05', '2026-03-05 07:32:05');
INSERT INTO `audit_logs` VALUES ('328', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:32:06', '2026-03-05 07:32:06');
INSERT INTO `audit_logs` VALUES ('329', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:32:06', '2026-03-05 07:32:06');
INSERT INTO `audit_logs` VALUES ('330', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:32:06', '2026-03-05 07:32:06');
INSERT INTO `audit_logs` VALUES ('331', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:32:07', '2026-03-05 07:32:07');
INSERT INTO `audit_logs` VALUES ('332', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:32:07', '2026-03-05 07:32:07');
INSERT INTO `audit_logs` VALUES ('333', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:32:07', '2026-03-05 07:32:07');
INSERT INTO `audit_logs` VALUES ('334', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:32:08', '2026-03-05 07:32:08');
INSERT INTO `audit_logs` VALUES ('335', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:32:08', '2026-03-05 07:32:08');
INSERT INTO `audit_logs` VALUES ('336', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:32:08', '2026-03-05 07:32:08');
INSERT INTO `audit_logs` VALUES ('337', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:34:57', '2026-03-05 07:34:57');
INSERT INTO `audit_logs` VALUES ('338', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:34:57', '2026-03-05 07:34:57');
INSERT INTO `audit_logs` VALUES ('339', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:34:58', '2026-03-05 07:34:58');
INSERT INTO `audit_logs` VALUES ('340', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:34:58', '2026-03-05 07:34:58');
INSERT INTO `audit_logs` VALUES ('341', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:35:23', '2026-03-05 07:35:23');
INSERT INTO `audit_logs` VALUES ('342', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:35:24', '2026-03-05 07:35:24');
INSERT INTO `audit_logs` VALUES ('343', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:35:24', '2026-03-05 07:35:24');
INSERT INTO `audit_logs` VALUES ('344', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:35:25', '2026-03-05 07:35:25');
INSERT INTO `audit_logs` VALUES ('345', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:35:32', '2026-03-05 07:35:32');
INSERT INTO `audit_logs` VALUES ('346', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:35:32', '2026-03-05 07:35:32');
INSERT INTO `audit_logs` VALUES ('347', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:35:33', '2026-03-05 07:35:33');
INSERT INTO `audit_logs` VALUES ('348', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:35:33', '2026-03-05 07:35:33');
INSERT INTO `audit_logs` VALUES ('349', '1', 'Josh Gracxiosa', 'Admin', 'Update', 'System', 'Update in System', '127.0.0.1', 'success', '2026-03-05 07:35:40', '2026-03-05 07:35:40');
INSERT INTO `audit_logs` VALUES ('350', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:35:41', '2026-03-05 07:35:41');
INSERT INTO `audit_logs` VALUES ('351', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:35:41', '2026-03-05 07:35:41');
INSERT INTO `audit_logs` VALUES ('352', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:35:42', '2026-03-05 07:35:42');
INSERT INTO `audit_logs` VALUES ('353', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:35:42', '2026-03-05 07:35:42');
INSERT INTO `audit_logs` VALUES ('354', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:37:11', '2026-03-05 07:37:11');
INSERT INTO `audit_logs` VALUES ('355', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:37:12', '2026-03-05 07:37:12');
INSERT INTO `audit_logs` VALUES ('356', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:37:12', '2026-03-05 07:37:12');
INSERT INTO `audit_logs` VALUES ('357', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:37:12', '2026-03-05 07:37:12');
INSERT INTO `audit_logs` VALUES ('358', '1', 'Josh Gracxiosa', 'Admin', 'Login', 'Authentication', 'User logged into the system', '127.0.0.1', 'success', '2026-03-05 07:37:38', '2026-03-05 07:37:38');
INSERT INTO `audit_logs` VALUES ('359', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:37:39', '2026-03-05 07:37:39');
INSERT INTO `audit_logs` VALUES ('360', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:37:39', '2026-03-05 07:37:39');
INSERT INTO `audit_logs` VALUES ('361', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:37:39', '2026-03-05 07:37:39');
INSERT INTO `audit_logs` VALUES ('362', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:37:40', '2026-03-05 07:37:40');
INSERT INTO `audit_logs` VALUES ('363', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:37:40', '2026-03-05 07:37:40');
INSERT INTO `audit_logs` VALUES ('364', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:37:41', '2026-03-05 07:37:41');
INSERT INTO `audit_logs` VALUES ('365', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:37:41', '2026-03-05 07:37:41');
INSERT INTO `audit_logs` VALUES ('366', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:37:41', '2026-03-05 07:37:41');
INSERT INTO `audit_logs` VALUES ('367', '1', 'Josh Gracxiosa', 'Admin', 'Update', 'System', 'Update in System', '127.0.0.1', 'success', '2026-03-05 07:37:52', '2026-03-05 07:37:52');
INSERT INTO `audit_logs` VALUES ('368', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:37:52', '2026-03-05 07:37:52');
INSERT INTO `audit_logs` VALUES ('369', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:37:53', '2026-03-05 07:37:53');
INSERT INTO `audit_logs` VALUES ('370', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:37:53', '2026-03-05 07:37:53');
INSERT INTO `audit_logs` VALUES ('371', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:37:54', '2026-03-05 07:37:54');
INSERT INTO `audit_logs` VALUES ('372', '1', 'Josh Gracxiosa', 'Admin', 'Update', 'System', 'Update in System', '127.0.0.1', 'success', '2026-03-05 07:38:10', '2026-03-05 07:38:10');
INSERT INTO `audit_logs` VALUES ('373', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:38:10', '2026-03-05 07:38:10');
INSERT INTO `audit_logs` VALUES ('374', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:38:11', '2026-03-05 07:38:11');
INSERT INTO `audit_logs` VALUES ('375', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:38:11', '2026-03-05 07:38:11');
INSERT INTO `audit_logs` VALUES ('376', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:38:12', '2026-03-05 07:38:12');
INSERT INTO `audit_logs` VALUES ('377', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:40:06', '2026-03-05 07:40:06');
INSERT INTO `audit_logs` VALUES ('378', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:40:06', '2026-03-05 07:40:06');
INSERT INTO `audit_logs` VALUES ('379', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:40:07', '2026-03-05 07:40:07');
INSERT INTO `audit_logs` VALUES ('380', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:40:07', '2026-03-05 07:40:07');
INSERT INTO `audit_logs` VALUES ('381', '1', 'Josh Gracxiosa', 'Admin', 'Update', 'System', 'Update in System', '127.0.0.1', 'success', '2026-03-05 07:40:11', '2026-03-05 07:40:11');
INSERT INTO `audit_logs` VALUES ('382', '1', 'Josh Gracxiosa1', 'Admin', 'Update', 'System', 'Update in System', '127.0.0.1', 'success', '2026-03-05 07:40:18', '2026-03-05 07:40:18');
INSERT INTO `audit_logs` VALUES ('383', '1', 'Josh Gracxiosa1', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:40:21', '2026-03-05 07:40:21');
INSERT INTO `audit_logs` VALUES ('384', '1', 'Josh Gracxiosa1', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:40:21', '2026-03-05 07:40:21');
INSERT INTO `audit_logs` VALUES ('385', '1', 'Josh Gracxiosa1', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:40:22', '2026-03-05 07:40:22');
INSERT INTO `audit_logs` VALUES ('386', '1', 'Josh Gracxiosa1', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:40:22', '2026-03-05 07:40:22');
INSERT INTO `audit_logs` VALUES ('387', '1', 'Josh Gracxiosa', 'Admin', 'Update', 'System', 'Update in System', '127.0.0.1', 'success', '2026-03-05 07:40:28', '2026-03-05 07:40:28');
INSERT INTO `audit_logs` VALUES ('388', '1', 'Josh Gracxiosa', 'Admin', 'Update', 'System', 'Update in System', '127.0.0.1', 'success', '2026-03-05 07:40:41', '2026-03-05 07:40:41');
INSERT INTO `audit_logs` VALUES ('389', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:40:43', '2026-03-05 07:40:43');
INSERT INTO `audit_logs` VALUES ('390', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:40:44', '2026-03-05 07:40:44');
INSERT INTO `audit_logs` VALUES ('391', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:40:44', '2026-03-05 07:40:44');
INSERT INTO `audit_logs` VALUES ('392', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:40:45', '2026-03-05 07:40:45');
INSERT INTO `audit_logs` VALUES ('393', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:42:16', '2026-03-05 07:42:16');
INSERT INTO `audit_logs` VALUES ('394', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:42:17', '2026-03-05 07:42:17');
INSERT INTO `audit_logs` VALUES ('395', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:42:17', '2026-03-05 07:42:17');
INSERT INTO `audit_logs` VALUES ('396', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:42:18', '2026-03-05 07:42:18');
INSERT INTO `audit_logs` VALUES ('397', '1', 'Josh Gracxiosa', 'Admin', 'Create', 'System', 'Create in System', '127.0.0.1', 'failed', '2026-03-05 07:43:14', '2026-03-05 07:43:14');
INSERT INTO `audit_logs` VALUES ('398', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:45:36', '2026-03-05 07:45:36');
INSERT INTO `audit_logs` VALUES ('399', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:45:36', '2026-03-05 07:45:36');
INSERT INTO `audit_logs` VALUES ('400', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:45:36', '2026-03-05 07:45:36');
INSERT INTO `audit_logs` VALUES ('401', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:45:37', '2026-03-05 07:45:37');
INSERT INTO `audit_logs` VALUES ('402', '1', 'Josh Gracxiosa', 'Admin', 'Create', 'System', 'Create in System', '127.0.0.1', 'failed', '2026-03-05 07:45:59', '2026-03-05 07:45:59');
INSERT INTO `audit_logs` VALUES ('403', '1', 'Josh Gracxiosa', 'Admin', 'Create', 'System', 'Create in System', '127.0.0.1', 'success', '2026-03-05 07:46:17', '2026-03-05 07:46:17');
INSERT INTO `audit_logs` VALUES ('404', '1', 'Josh Gracxiosa', 'Admin', 'Logout', 'Authentication', 'User logged out from the system', '127.0.0.1', 'success', '2026-03-05 07:46:23', '2026-03-05 07:46:23');
INSERT INTO `audit_logs` VALUES ('405', '1', 'Josh Gracxiosa', 'Admin', 'Login', 'Authentication', 'User logged into the system', '127.0.0.1', 'success', '2026-03-05 07:46:26', '2026-03-05 07:46:26');
INSERT INTO `audit_logs` VALUES ('406', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:46:26', '2026-03-05 07:46:26');
INSERT INTO `audit_logs` VALUES ('407', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:46:27', '2026-03-05 07:46:27');
INSERT INTO `audit_logs` VALUES ('408', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:46:27', '2026-03-05 07:46:27');
INSERT INTO `audit_logs` VALUES ('409', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:46:27', '2026-03-05 07:46:27');
INSERT INTO `audit_logs` VALUES ('410', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:46:27', '2026-03-05 07:46:27');
INSERT INTO `audit_logs` VALUES ('411', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:46:28', '2026-03-05 07:46:28');
INSERT INTO `audit_logs` VALUES ('412', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:46:28', '2026-03-05 07:46:28');
INSERT INTO `audit_logs` VALUES ('413', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:46:28', '2026-03-05 07:46:28');
INSERT INTO `audit_logs` VALUES ('414', '1', 'Josh Gracxiosa', 'Admin', 'Update', 'System', 'Update in System', '127.0.0.1', 'success', '2026-03-05 07:46:42', '2026-03-05 07:46:42');
INSERT INTO `audit_logs` VALUES ('415', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:46:43', '2026-03-05 07:46:43');
INSERT INTO `audit_logs` VALUES ('416', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:46:43', '2026-03-05 07:46:43');
INSERT INTO `audit_logs` VALUES ('417', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:46:43', '2026-03-05 07:46:43');
INSERT INTO `audit_logs` VALUES ('418', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:46:44', '2026-03-05 07:46:44');
INSERT INTO `audit_logs` VALUES ('419', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:46:48', '2026-03-05 07:46:48');
INSERT INTO `audit_logs` VALUES ('420', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:46:49', '2026-03-05 07:46:49');
INSERT INTO `audit_logs` VALUES ('421', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:46:49', '2026-03-05 07:46:49');
INSERT INTO `audit_logs` VALUES ('422', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:46:49', '2026-03-05 07:46:49');
INSERT INTO `audit_logs` VALUES ('423', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:46:49', '2026-03-05 07:46:49');
INSERT INTO `audit_logs` VALUES ('424', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:46:50', '2026-03-05 07:46:50');
INSERT INTO `audit_logs` VALUES ('425', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:46:53', '2026-03-05 07:46:53');
INSERT INTO `audit_logs` VALUES ('426', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:46:53', '2026-03-05 07:46:53');
INSERT INTO `audit_logs` VALUES ('427', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:46:53', '2026-03-05 07:46:53');
INSERT INTO `audit_logs` VALUES ('428', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 07:46:54', '2026-03-05 07:46:54');
INSERT INTO `audit_logs` VALUES ('429', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 07:46:54', '2026-03-05 07:46:54');
INSERT INTO `audit_logs` VALUES ('430', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 07:46:54', '2026-03-05 07:46:54');
INSERT INTO `audit_logs` VALUES ('431', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:50:40', '2026-03-05 07:50:40');
INSERT INTO `audit_logs` VALUES ('432', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:50:40', '2026-03-05 07:50:40');
INSERT INTO `audit_logs` VALUES ('433', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:50:40', '2026-03-05 07:50:40');
INSERT INTO `audit_logs` VALUES ('434', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:50:41', '2026-03-05 07:50:41');
INSERT INTO `audit_logs` VALUES ('435', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 07:50:42', '2026-03-05 07:50:42');
INSERT INTO `audit_logs` VALUES ('436', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:50:42', '2026-03-05 07:50:42');
INSERT INTO `audit_logs` VALUES ('437', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 07:50:42', '2026-03-05 07:50:42');
INSERT INTO `audit_logs` VALUES ('438', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:50:43', '2026-03-05 07:50:43');
INSERT INTO `audit_logs` VALUES ('439', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 07:50:43', '2026-03-05 07:50:43');
INSERT INTO `audit_logs` VALUES ('440', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 07:50:44', '2026-03-05 07:50:44');
INSERT INTO `audit_logs` VALUES ('441', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 07:50:44', '2026-03-05 07:50:44');
INSERT INTO `audit_logs` VALUES ('442', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 08:02:09', '2026-03-05 08:02:09');
INSERT INTO `audit_logs` VALUES ('443', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 08:02:09', '2026-03-05 08:02:09');
INSERT INTO `audit_logs` VALUES ('444', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 08:03:10', '2026-03-05 08:03:10');
INSERT INTO `audit_logs` VALUES ('445', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 08:03:10', '2026-03-05 08:03:10');
INSERT INTO `audit_logs` VALUES ('446', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 08:03:10', '2026-03-05 08:03:10');
INSERT INTO `audit_logs` VALUES ('447', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 08:03:10', '2026-03-05 08:03:10');
INSERT INTO `audit_logs` VALUES ('448', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 08:03:11', '2026-03-05 08:03:11');
INSERT INTO `audit_logs` VALUES ('449', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 08:03:11', '2026-03-05 08:03:11');
INSERT INTO `audit_logs` VALUES ('450', '1', 'Josh Gracxiosa', 'Admin', 'Update', 'User Management', 'Update in User Management (ID: 1)', '127.0.0.1', 'success', '2026-03-05 08:03:34', '2026-03-05 08:03:34');
INSERT INTO `audit_logs` VALUES ('451', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 08:03:34', '2026-03-05 08:03:34');
INSERT INTO `audit_logs` VALUES ('452', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 08:05:18', '2026-03-05 08:05:18');
INSERT INTO `audit_logs` VALUES ('453', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 08:05:32', '2026-03-05 08:05:32');
INSERT INTO `audit_logs` VALUES ('454', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 08:05:32', '2026-03-05 08:05:32');
INSERT INTO `audit_logs` VALUES ('455', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 08:05:32', '2026-03-05 08:05:32');
INSERT INTO `audit_logs` VALUES ('456', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 08:05:32', '2026-03-05 08:05:32');
INSERT INTO `audit_logs` VALUES ('457', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 08:05:33', '2026-03-05 08:05:33');
INSERT INTO `audit_logs` VALUES ('458', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 08:05:33', '2026-03-05 08:05:33');
INSERT INTO `audit_logs` VALUES ('459', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 08:05:36', '2026-03-05 08:05:36');
INSERT INTO `audit_logs` VALUES ('460', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 08:05:37', '2026-03-05 08:05:37');
INSERT INTO `audit_logs` VALUES ('461', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 08:05:37', '2026-03-05 08:05:37');
INSERT INTO `audit_logs` VALUES ('462', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 08:05:37', '2026-03-05 08:05:37');
INSERT INTO `audit_logs` VALUES ('463', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 08:05:37', '2026-03-05 08:05:37');
INSERT INTO `audit_logs` VALUES ('464', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 08:05:38', '2026-03-05 08:05:38');
INSERT INTO `audit_logs` VALUES ('465', '1', 'Josh Gracxiosa', 'Admin', 'Update', 'User Management', 'Update in User Management (ID: 1)', '127.0.0.1', 'success', '2026-03-05 08:05:52', '2026-03-05 08:05:52');
INSERT INTO `audit_logs` VALUES ('466', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 08:05:52', '2026-03-05 08:05:52');
INSERT INTO `audit_logs` VALUES ('467', '1', 'Josh Gracxiosa', 'Admin', 'Update', 'User Management', 'Update in User Management (ID: 1)', '127.0.0.1', 'success', '2026-03-05 08:06:08', '2026-03-05 08:06:08');
INSERT INTO `audit_logs` VALUES ('468', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 08:06:08', '2026-03-05 08:06:08');
INSERT INTO `audit_logs` VALUES ('469', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 08:08:41', '2026-03-05 08:08:41');
INSERT INTO `audit_logs` VALUES ('470', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 08:08:41', '2026-03-05 08:08:41');
INSERT INTO `audit_logs` VALUES ('471', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 08:08:41', '2026-03-05 08:08:41');
INSERT INTO `audit_logs` VALUES ('472', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 08:08:42', '2026-03-05 08:08:42');
INSERT INTO `audit_logs` VALUES ('473', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 08:08:42', '2026-03-05 08:08:42');
INSERT INTO `audit_logs` VALUES ('474', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 08:08:43', '2026-03-05 08:08:43');
INSERT INTO `audit_logs` VALUES ('475', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 08:08:44', '2026-03-05 08:08:44');
INSERT INTO `audit_logs` VALUES ('476', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 08:08:44', '2026-03-05 08:08:44');
INSERT INTO `audit_logs` VALUES ('477', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 08:08:44', '2026-03-05 08:08:44');
INSERT INTO `audit_logs` VALUES ('478', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 08:08:45', '2026-03-05 08:08:45');
INSERT INTO `audit_logs` VALUES ('479', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 08:08:45', '2026-03-05 08:08:45');
INSERT INTO `audit_logs` VALUES ('480', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 08:08:45', '2026-03-05 08:08:45');
INSERT INTO `audit_logs` VALUES ('481', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 08:17:28', '2026-03-05 08:17:28');
INSERT INTO `audit_logs` VALUES ('482', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 08:17:28', '2026-03-05 08:17:28');
INSERT INTO `audit_logs` VALUES ('483', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 08:17:28', '2026-03-05 08:17:28');
INSERT INTO `audit_logs` VALUES ('484', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 08:17:29', '2026-03-05 08:17:29');
INSERT INTO `audit_logs` VALUES ('485', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 08:17:29', '2026-03-05 08:17:29');
INSERT INTO `audit_logs` VALUES ('486', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 08:17:29', '2026-03-05 08:17:29');
INSERT INTO `audit_logs` VALUES ('487', '1', 'Josh Gracxiosa', 'Admin', 'Create', 'User Management', 'Create in User Management', '127.0.0.1', 'success', '2026-03-05 08:18:24', '2026-03-05 08:18:24');
INSERT INTO `audit_logs` VALUES ('488', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 08:18:24', '2026-03-05 08:18:24');
INSERT INTO `audit_logs` VALUES ('489', '1', 'Josh Gracxiosa', 'Admin', 'Logout', 'Authentication', 'User logged out from the system', '127.0.0.1', 'success', '2026-03-05 08:18:30', '2026-03-05 08:18:30');
INSERT INTO `audit_logs` VALUES ('490', '10', 'Sample', 'Admin', 'Login', 'Authentication', 'User logged into the system', '127.0.0.1', 'success', '2026-03-05 08:18:43', '2026-03-05 08:18:43');
INSERT INTO `audit_logs` VALUES ('491', '10', 'Sample', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 08:18:44', '2026-03-05 08:18:44');
INSERT INTO `audit_logs` VALUES ('492', '10', 'Sample', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 08:18:44', '2026-03-05 08:18:44');
INSERT INTO `audit_logs` VALUES ('493', '10', 'Sample', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 08:18:44', '2026-03-05 08:18:44');
INSERT INTO `audit_logs` VALUES ('494', '10', 'Sample', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 08:18:44', '2026-03-05 08:18:44');
INSERT INTO `audit_logs` VALUES ('495', '10', 'Sample', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 08:18:45', '2026-03-05 08:18:45');
INSERT INTO `audit_logs` VALUES ('496', '10', 'Sample', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 08:18:45', '2026-03-05 08:18:45');
INSERT INTO `audit_logs` VALUES ('497', '10', 'Sample', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 08:18:45', '2026-03-05 08:18:45');
INSERT INTO `audit_logs` VALUES ('498', '10', 'Sample', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 08:18:46', '2026-03-05 08:18:46');
INSERT INTO `audit_logs` VALUES ('499', '10', 'Sample', 'Admin', 'Update', 'System', 'Update in System', '127.0.0.1', 'success', '2026-03-05 08:18:56', '2026-03-05 08:18:56');
INSERT INTO `audit_logs` VALUES ('500', '10', 'Sample', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 08:18:57', '2026-03-05 08:18:57');
INSERT INTO `audit_logs` VALUES ('501', '10', 'Sample', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 08:18:57', '2026-03-05 08:18:57');
INSERT INTO `audit_logs` VALUES ('502', '10', 'Sample', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 08:18:57', '2026-03-05 08:18:57');
INSERT INTO `audit_logs` VALUES ('503', '10', 'Sample', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 08:18:58', '2026-03-05 08:18:58');
INSERT INTO `audit_logs` VALUES ('504', '10', 'Sample', 'Admin', 'Create', 'System', 'Create in System', '127.0.0.1', 'success', '2026-03-05 08:19:15', '2026-03-05 08:19:15');
INSERT INTO `audit_logs` VALUES ('505', '10', 'Sample', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 08:19:19', '2026-03-05 08:19:19');
INSERT INTO `audit_logs` VALUES ('506', '10', 'Sample', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 08:19:19', '2026-03-05 08:19:19');
INSERT INTO `audit_logs` VALUES ('507', '10', 'Sample', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 08:19:19', '2026-03-05 08:19:19');
INSERT INTO `audit_logs` VALUES ('508', '10', 'Sample', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 08:19:19', '2026-03-05 08:19:19');
INSERT INTO `audit_logs` VALUES ('509', '10', 'Sample', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 08:19:20', '2026-03-05 08:19:20');
INSERT INTO `audit_logs` VALUES ('510', '10', 'Sample', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 08:19:20', '2026-03-05 08:19:20');
INSERT INTO `audit_logs` VALUES ('511', '10', 'Sample', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 08:19:20', '2026-03-05 08:19:20');
INSERT INTO `audit_logs` VALUES ('512', '10', 'Sample', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 08:19:21', '2026-03-05 08:19:21');
INSERT INTO `audit_logs` VALUES ('513', '10', 'Sample', 'Admin', 'Approve', 'User Management', 'Approve in User Management (ID: 5)', '127.0.0.1', 'success', '2026-03-05 08:19:35', '2026-03-05 08:19:35');
INSERT INTO `audit_logs` VALUES ('514', '10', 'Sample', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 08:19:35', '2026-03-05 08:19:35');
INSERT INTO `audit_logs` VALUES ('515', '10', 'Sample', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 08:19:56', '2026-03-05 08:19:56');
INSERT INTO `audit_logs` VALUES ('516', '10', 'Sample', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 08:19:56', '2026-03-05 08:19:56');
INSERT INTO `audit_logs` VALUES ('517', '10', 'Sample', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 08:19:56', '2026-03-05 08:19:56');
INSERT INTO `audit_logs` VALUES ('518', '10', 'Sample', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 08:19:57', '2026-03-05 08:19:57');
INSERT INTO `audit_logs` VALUES ('519', '10', 'Sample', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 08:19:57', '2026-03-05 08:19:57');
INSERT INTO `audit_logs` VALUES ('520', '10', 'Sample', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 08:19:57', '2026-03-05 08:19:57');
INSERT INTO `audit_logs` VALUES ('521', '10', 'Sample', 'Admin', 'Approve', 'User Management', 'Approve in User Management (ID: 8)', '127.0.0.1', 'success', '2026-03-05 08:20:14', '2026-03-05 08:20:14');
INSERT INTO `audit_logs` VALUES ('522', '10', 'Sample', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 08:20:14', '2026-03-05 08:20:14');
INSERT INTO `audit_logs` VALUES ('523', '10', 'Sample', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 08:47:40', '2026-03-05 08:47:40');
INSERT INTO `audit_logs` VALUES ('524', '10', 'Sample', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 08:47:40', '2026-03-05 08:47:40');
INSERT INTO `audit_logs` VALUES ('525', '10', 'Sample', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 08:47:41', '2026-03-05 08:47:41');
INSERT INTO `audit_logs` VALUES ('526', '10', 'Sample', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 08:47:41', '2026-03-05 08:47:41');
INSERT INTO `audit_logs` VALUES ('527', '10', 'Sample', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 08:47:42', '2026-03-05 08:47:42');
INSERT INTO `audit_logs` VALUES ('528', '10', 'Sample', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 08:47:42', '2026-03-05 08:47:42');
INSERT INTO `audit_logs` VALUES ('529', '10', 'Sample', 'Admin', 'Update', 'User Management', 'Update in User Management (ID: 1)', '127.0.0.1', 'success', '2026-03-05 08:47:49', '2026-03-05 08:47:49');
INSERT INTO `audit_logs` VALUES ('530', '10', 'Sample', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 08:47:49', '2026-03-05 08:47:49');
INSERT INTO `audit_logs` VALUES ('531', '10', 'Sample', 'Admin', 'Create', 'User Management', 'Create in User Management (ID: 1)', '127.0.0.1', 'failed', '2026-03-05 08:50:46', '2026-03-05 08:50:46');
INSERT INTO `audit_logs` VALUES ('532', '10', 'Sample', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 08:51:26', '2026-03-05 08:51:26');
INSERT INTO `audit_logs` VALUES ('533', '10', 'Sample', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 08:51:26', '2026-03-05 08:51:26');
INSERT INTO `audit_logs` VALUES ('534', '10', 'Sample', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 08:51:27', '2026-03-05 08:51:27');
INSERT INTO `audit_logs` VALUES ('535', '10', 'Sample', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 08:51:27', '2026-03-05 08:51:27');
INSERT INTO `audit_logs` VALUES ('536', '10', 'Sample', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 08:51:27', '2026-03-05 08:51:27');
INSERT INTO `audit_logs` VALUES ('537', '10', 'Sample', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 08:51:28', '2026-03-05 08:51:28');
INSERT INTO `audit_logs` VALUES ('538', '10', 'Sample', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 08:51:36', '2026-03-05 08:51:36');
INSERT INTO `audit_logs` VALUES ('539', '10', 'Sample', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 08:51:36', '2026-03-05 08:51:36');
INSERT INTO `audit_logs` VALUES ('540', '10', 'Sample', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 08:51:37', '2026-03-05 08:51:37');
INSERT INTO `audit_logs` VALUES ('541', '10', 'Sample', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 08:51:37', '2026-03-05 08:51:37');
INSERT INTO `audit_logs` VALUES ('542', '10', 'Sample', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 08:51:38', '2026-03-05 08:51:38');
INSERT INTO `audit_logs` VALUES ('543', '10', 'Sample', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 08:51:38', '2026-03-05 08:51:38');
INSERT INTO `audit_logs` VALUES ('544', '10', 'Sample', 'Admin', 'Create', 'User Management', 'Create in User Management (ID: 1)', '127.0.0.1', 'failed', '2026-03-05 08:51:46', '2026-03-05 08:51:46');
INSERT INTO `audit_logs` VALUES ('545', '10', 'Sample', 'Admin', 'Create', 'User Management', 'Create in User Management (ID: 1)', '127.0.0.1', 'failed', '2026-03-05 08:51:46', '2026-03-05 08:51:46');
INSERT INTO `audit_logs` VALUES ('546', '10', 'Sample', 'Admin', 'Create', 'User Management', 'Create in User Management (ID: 1)', '127.0.0.1', 'success', '2026-03-05 08:53:05', '2026-03-05 08:53:05');
INSERT INTO `audit_logs` VALUES ('547', '10', 'Sample', 'Admin', 'Create', 'User Management', 'Create in User Management (ID: 1)', '127.0.0.1', 'success', '2026-03-05 08:53:16', '2026-03-05 08:53:16');
INSERT INTO `audit_logs` VALUES ('548', '10', 'Sample', 'Admin', 'Logout', 'Authentication', 'User logged out from the system', '127.0.0.1', 'success', '2026-03-05 08:53:35', '2026-03-05 08:53:35');
INSERT INTO `audit_logs` VALUES ('549', '1', 'Josh Gracxiosa', 'Admin', 'Login', 'Authentication', 'User logged into the system', '127.0.0.1', 'success', '2026-03-05 08:53:47', '2026-03-05 08:53:47');
INSERT INTO `audit_logs` VALUES ('550', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 08:53:48', '2026-03-05 08:53:48');
INSERT INTO `audit_logs` VALUES ('551', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 08:53:49', '2026-03-05 08:53:49');
INSERT INTO `audit_logs` VALUES ('552', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 08:53:49', '2026-03-05 08:53:49');
INSERT INTO `audit_logs` VALUES ('553', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 08:53:49', '2026-03-05 08:53:49');
INSERT INTO `audit_logs` VALUES ('554', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 08:53:50', '2026-03-05 08:53:50');
INSERT INTO `audit_logs` VALUES ('555', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 08:53:50', '2026-03-05 08:53:50');
INSERT INTO `audit_logs` VALUES ('556', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 08:53:50', '2026-03-05 08:53:50');
INSERT INTO `audit_logs` VALUES ('557', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 08:53:51', '2026-03-05 08:53:51');
INSERT INTO `audit_logs` VALUES ('558', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 08:53:52', '2026-03-05 08:53:52');
INSERT INTO `audit_logs` VALUES ('559', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 08:53:53', '2026-03-05 08:53:53');
INSERT INTO `audit_logs` VALUES ('560', '1', 'Josh Gracxiosa', 'Admin', 'Create', 'User Management', 'Create in User Management (ID: 1)', '127.0.0.1', 'success', '2026-03-05 08:56:00', '2026-03-05 08:56:00');
INSERT INTO `audit_logs` VALUES ('561', '1', 'Josh Gracxiosa', 'Admin', 'Logout', 'Authentication', 'User logged out from the system', '127.0.0.1', 'success', '2026-03-05 08:56:08', '2026-03-05 08:56:08');
INSERT INTO `audit_logs` VALUES ('562', '1', 'Josh Gracxiosa', 'Admin', 'Login', 'Authentication', 'User logged into the system', '127.0.0.1', 'success', '2026-03-05 08:56:11', '2026-03-05 08:56:11');
INSERT INTO `audit_logs` VALUES ('563', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 08:56:12', '2026-03-05 08:56:12');
INSERT INTO `audit_logs` VALUES ('564', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 08:56:12', '2026-03-05 08:56:12');
INSERT INTO `audit_logs` VALUES ('565', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 08:56:12', '2026-03-05 08:56:12');
INSERT INTO `audit_logs` VALUES ('566', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 08:56:12', '2026-03-05 08:56:12');
INSERT INTO `audit_logs` VALUES ('567', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 08:56:13', '2026-03-05 08:56:13');
INSERT INTO `audit_logs` VALUES ('568', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 08:56:13', '2026-03-05 08:56:13');
INSERT INTO `audit_logs` VALUES ('569', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 08:56:14', '2026-03-05 08:56:14');
INSERT INTO `audit_logs` VALUES ('570', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 08:56:14', '2026-03-05 08:56:14');
INSERT INTO `audit_logs` VALUES ('571', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 08:56:15', '2026-03-05 08:56:15');
INSERT INTO `audit_logs` VALUES ('572', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 08:56:16', '2026-03-05 08:56:16');
INSERT INTO `audit_logs` VALUES ('573', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 08:56:17', '2026-03-05 08:56:17');
INSERT INTO `audit_logs` VALUES ('574', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 08:56:17', '2026-03-05 08:56:17');
INSERT INTO `audit_logs` VALUES ('575', '1', 'Josh Gracxiosa', 'Admin', 'Logout', 'Authentication', 'User logged out from the system', '127.0.0.1', 'success', '2026-03-05 08:56:20', '2026-03-05 08:56:20');
INSERT INTO `audit_logs` VALUES ('576', '10', 'Sample', 'Admin', 'Login', 'Authentication', 'User logged into the system', '127.0.0.1', 'success', '2026-03-05 08:56:23', '2026-03-05 08:56:23');
INSERT INTO `audit_logs` VALUES ('577', '10', 'Sample', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 08:56:24', '2026-03-05 08:56:24');
INSERT INTO `audit_logs` VALUES ('578', '10', 'Sample', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 08:56:24', '2026-03-05 08:56:24');
INSERT INTO `audit_logs` VALUES ('579', '10', 'Sample', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 08:56:24', '2026-03-05 08:56:24');
INSERT INTO `audit_logs` VALUES ('580', '10', 'Sample', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 08:56:25', '2026-03-05 08:56:25');
INSERT INTO `audit_logs` VALUES ('581', '10', 'Sample', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 08:56:25', '2026-03-05 08:56:25');
INSERT INTO `audit_logs` VALUES ('582', '10', 'Sample', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 08:56:25', '2026-03-05 08:56:25');
INSERT INTO `audit_logs` VALUES ('583', '10', 'Sample', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 08:56:26', '2026-03-05 08:56:26');
INSERT INTO `audit_logs` VALUES ('584', '10', 'Sample', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 08:56:26', '2026-03-05 08:56:26');
INSERT INTO `audit_logs` VALUES ('585', '10', 'Sample', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 08:56:30', '2026-03-05 08:56:30');
INSERT INTO `audit_logs` VALUES ('586', '10', 'Sample', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 08:56:30', '2026-03-05 08:56:30');
INSERT INTO `audit_logs` VALUES ('587', '10', 'Sample', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 08:56:31', '2026-03-05 08:56:31');
INSERT INTO `audit_logs` VALUES ('588', '10', 'Sample', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 08:56:31', '2026-03-05 08:56:31');
INSERT INTO `audit_logs` VALUES ('589', '10', 'Sample', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 08:56:31', '2026-03-05 08:56:31');
INSERT INTO `audit_logs` VALUES ('590', '10', 'Sample', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 08:56:31', '2026-03-05 08:56:31');
INSERT INTO `audit_logs` VALUES ('591', '10', 'Sample', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 08:56:32', '2026-03-05 08:56:32');
INSERT INTO `audit_logs` VALUES ('592', '10', 'Sample', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 08:56:32', '2026-03-05 08:56:32');
INSERT INTO `audit_logs` VALUES ('593', '10', 'Sample', 'Admin', 'Logout', 'Authentication', 'User logged out from the system', '127.0.0.1', 'success', '2026-03-05 08:56:35', '2026-03-05 08:56:35');
INSERT INTO `audit_logs` VALUES ('594', '2', 'Everly Santos', 'Staff', 'Login', 'Authentication', 'User logged into the system', '127.0.0.1', 'success', '2026-03-05 08:56:50', '2026-03-05 08:56:50');
INSERT INTO `audit_logs` VALUES ('595', '2', 'Everly Santos', 'Staff', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 08:56:50', '2026-03-05 08:56:50');
INSERT INTO `audit_logs` VALUES ('596', '2', 'Everly Santos', 'Staff', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 08:56:51', '2026-03-05 08:56:51');
INSERT INTO `audit_logs` VALUES ('597', '2', 'Everly Santos', 'Staff', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 08:56:51', '2026-03-05 08:56:51');
INSERT INTO `audit_logs` VALUES ('598', '2', 'Everly Santos', 'Staff', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 08:56:51', '2026-03-05 08:56:51');
INSERT INTO `audit_logs` VALUES ('599', '2', 'Everly Santos', 'Staff', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 08:56:51', '2026-03-05 08:56:51');
INSERT INTO `audit_logs` VALUES ('600', '2', 'Everly Santos', 'Staff', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 08:56:52', '2026-03-05 08:56:52');
INSERT INTO `audit_logs` VALUES ('601', '2', 'Everly Santos', 'Staff', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 08:56:52', '2026-03-05 08:56:52');
INSERT INTO `audit_logs` VALUES ('602', '2', 'Everly Santos', 'Staff', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 08:56:52', '2026-03-05 08:56:52');
INSERT INTO `audit_logs` VALUES ('603', '2', 'Everly Santos', 'Staff', 'Logout', 'Authentication', 'User logged out from the system', '127.0.0.1', 'success', '2026-03-05 08:56:56', '2026-03-05 08:56:56');
INSERT INTO `audit_logs` VALUES ('604', '1', 'Josh Gracxiosa', 'Admin', 'Login', 'Authentication', 'User logged into the system', '127.0.0.1', 'success', '2026-03-05 08:57:00', '2026-03-05 08:57:00');
INSERT INTO `audit_logs` VALUES ('605', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 08:57:01', '2026-03-05 08:57:01');
INSERT INTO `audit_logs` VALUES ('606', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 08:57:01', '2026-03-05 08:57:01');
INSERT INTO `audit_logs` VALUES ('607', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 08:57:01', '2026-03-05 08:57:01');
INSERT INTO `audit_logs` VALUES ('608', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 08:57:01', '2026-03-05 08:57:01');
INSERT INTO `audit_logs` VALUES ('609', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 08:57:02', '2026-03-05 08:57:02');
INSERT INTO `audit_logs` VALUES ('610', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 08:57:02', '2026-03-05 08:57:02');
INSERT INTO `audit_logs` VALUES ('611', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 08:57:02', '2026-03-05 08:57:02');
INSERT INTO `audit_logs` VALUES ('612', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 08:57:03', '2026-03-05 08:57:03');
INSERT INTO `audit_logs` VALUES ('613', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 08:57:34', '2026-03-05 08:57:34');
INSERT INTO `audit_logs` VALUES ('614', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 08:57:35', '2026-03-05 08:57:35');
INSERT INTO `audit_logs` VALUES ('615', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 09:01:27', '2026-03-05 09:01:27');
INSERT INTO `audit_logs` VALUES ('616', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 09:01:28', '2026-03-05 09:01:28');
INSERT INTO `audit_logs` VALUES ('617', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 09:01:28', '2026-03-05 09:01:28');
INSERT INTO `audit_logs` VALUES ('618', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 09:01:29', '2026-03-05 09:01:29');
INSERT INTO `audit_logs` VALUES ('619', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 09:01:29', '2026-03-05 09:01:29');
INSERT INTO `audit_logs` VALUES ('620', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 09:01:30', '2026-03-05 09:01:30');
INSERT INTO `audit_logs` VALUES ('621', '1', 'Josh Gracxiosa', 'Admin', 'Create', 'Reports Management', 'Create in Reports Management (ID: 6)', '127.0.0.1', 'success', '2026-03-05 09:03:15', '2026-03-05 09:03:15');
INSERT INTO `audit_logs` VALUES ('622', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 09:03:15', '2026-03-05 09:03:15');
INSERT INTO `audit_logs` VALUES ('623', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 09:06:12', '2026-03-05 09:06:12');
INSERT INTO `audit_logs` VALUES ('624', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 09:06:13', '2026-03-05 09:06:13');
INSERT INTO `audit_logs` VALUES ('625', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 09:06:13', '2026-03-05 09:06:13');
INSERT INTO `audit_logs` VALUES ('626', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 09:06:13', '2026-03-05 09:06:13');
INSERT INTO `audit_logs` VALUES ('627', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 09:06:14', '2026-03-05 09:06:14');
INSERT INTO `audit_logs` VALUES ('628', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 09:06:14', '2026-03-05 09:06:14');
INSERT INTO `audit_logs` VALUES ('629', '1', 'Josh Gracxiosa', 'Admin', 'Create', 'Reports Management', 'Create in Reports Management (ID: 1)', '127.0.0.1', 'success', '2026-03-05 09:06:43', '2026-03-05 09:06:43');
INSERT INTO `audit_logs` VALUES ('630', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 09:06:43', '2026-03-05 09:06:43');
INSERT INTO `audit_logs` VALUES ('631', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 09:09:38', '2026-03-05 09:09:38');
INSERT INTO `audit_logs` VALUES ('632', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 09:09:38', '2026-03-05 09:09:38');
INSERT INTO `audit_logs` VALUES ('633', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 09:09:39', '2026-03-05 09:09:39');
INSERT INTO `audit_logs` VALUES ('634', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 09:09:39', '2026-03-05 09:09:39');
INSERT INTO `audit_logs` VALUES ('635', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 09:09:39', '2026-03-05 09:09:39');
INSERT INTO `audit_logs` VALUES ('636', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 09:09:40', '2026-03-05 09:09:40');
INSERT INTO `audit_logs` VALUES ('637', '1', 'Josh Gracxiosa', 'Admin', 'Create', 'Reports Management', 'Create in Reports Management (ID: 2)', '127.0.0.1', 'success', '2026-03-05 09:09:56', '2026-03-05 09:09:56');
INSERT INTO `audit_logs` VALUES ('638', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 09:09:57', '2026-03-05 09:09:57');
INSERT INTO `audit_logs` VALUES ('639', '1', 'Josh Gracxiosa', 'Admin', 'Create', 'Reports Management', 'Create in Reports Management (ID: 2)', '127.0.0.1', 'success', '2026-03-05 09:10:25', '2026-03-05 09:10:25');
INSERT INTO `audit_logs` VALUES ('640', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 09:10:25', '2026-03-05 09:10:25');
INSERT INTO `audit_logs` VALUES ('641', '1', 'Josh Gracxiosa', 'Admin', 'Create', 'Reports Management', 'Create in Reports Management (ID: 3)', '127.0.0.1', 'success', '2026-03-05 09:12:27', '2026-03-05 09:12:27');
INSERT INTO `audit_logs` VALUES ('642', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 09:12:28', '2026-03-05 09:12:28');
INSERT INTO `audit_logs` VALUES ('643', '1', 'Josh Gracxiosa', 'Admin', 'Create', 'Reports Management', 'Create in Reports Management (ID: 1)', '127.0.0.1', 'success', '2026-03-05 09:13:17', '2026-03-05 09:13:17');
INSERT INTO `audit_logs` VALUES ('644', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 09:13:17', '2026-03-05 09:13:17');
INSERT INTO `audit_logs` VALUES ('645', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 09:13:50', '2026-03-05 09:13:50');
INSERT INTO `audit_logs` VALUES ('646', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 09:13:50', '2026-03-05 09:13:50');
INSERT INTO `audit_logs` VALUES ('647', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 09:13:51', '2026-03-05 09:13:51');
INSERT INTO `audit_logs` VALUES ('648', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 09:13:51', '2026-03-05 09:13:51');
INSERT INTO `audit_logs` VALUES ('649', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 09:13:51', '2026-03-05 09:13:51');
INSERT INTO `audit_logs` VALUES ('650', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 09:13:52', '2026-03-05 09:13:52');
INSERT INTO `audit_logs` VALUES ('651', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 09:19:41', '2026-03-05 09:19:41');
INSERT INTO `audit_logs` VALUES ('652', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 09:19:41', '2026-03-05 09:19:41');
INSERT INTO `audit_logs` VALUES ('653', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 09:19:42', '2026-03-05 09:19:42');
INSERT INTO `audit_logs` VALUES ('654', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 09:19:43', '2026-03-05 09:19:43');
INSERT INTO `audit_logs` VALUES ('655', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:19:43', '2026-03-05 09:19:43');
INSERT INTO `audit_logs` VALUES ('656', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:19:43', '2026-03-05 09:19:43');
INSERT INTO `audit_logs` VALUES ('657', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:19:44', '2026-03-05 09:19:44');
INSERT INTO `audit_logs` VALUES ('658', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:19:44', '2026-03-05 09:19:44');
INSERT INTO `audit_logs` VALUES ('659', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 09:20:38', '2026-03-05 09:20:38');
INSERT INTO `audit_logs` VALUES ('660', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 09:20:38', '2026-03-05 09:20:38');
INSERT INTO `audit_logs` VALUES ('661', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 09:20:38', '2026-03-05 09:20:38');
INSERT INTO `audit_logs` VALUES ('662', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:20:39', '2026-03-05 09:20:39');
INSERT INTO `audit_logs` VALUES ('663', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:20:39', '2026-03-05 09:20:39');
INSERT INTO `audit_logs` VALUES ('664', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 09:20:40', '2026-03-05 09:20:40');
INSERT INTO `audit_logs` VALUES ('665', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:20:40', '2026-03-05 09:20:40');
INSERT INTO `audit_logs` VALUES ('666', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:20:41', '2026-03-05 09:20:41');
INSERT INTO `audit_logs` VALUES ('667', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 09:21:59', '2026-03-05 09:21:59');
INSERT INTO `audit_logs` VALUES ('668', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 09:22:00', '2026-03-05 09:22:00');
INSERT INTO `audit_logs` VALUES ('669', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 09:22:00', '2026-03-05 09:22:00');
INSERT INTO `audit_logs` VALUES ('670', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:22:00', '2026-03-05 09:22:00');
INSERT INTO `audit_logs` VALUES ('671', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:22:01', '2026-03-05 09:22:01');
INSERT INTO `audit_logs` VALUES ('672', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 09:22:01', '2026-03-05 09:22:01');
INSERT INTO `audit_logs` VALUES ('673', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:22:02', '2026-03-05 09:22:02');
INSERT INTO `audit_logs` VALUES ('674', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:22:02', '2026-03-05 09:22:02');
INSERT INTO `audit_logs` VALUES ('675', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:22:09', '2026-03-05 09:22:09');
INSERT INTO `audit_logs` VALUES ('676', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:22:09', '2026-03-05 09:22:09');
INSERT INTO `audit_logs` VALUES ('677', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:22:10', '2026-03-05 09:22:10');
INSERT INTO `audit_logs` VALUES ('678', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:22:10', '2026-03-05 09:22:10');
INSERT INTO `audit_logs` VALUES ('679', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:22:16', '2026-03-05 09:22:16');
INSERT INTO `audit_logs` VALUES ('680', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:22:17', '2026-03-05 09:22:17');
INSERT INTO `audit_logs` VALUES ('681', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:22:19', '2026-03-05 09:22:19');
INSERT INTO `audit_logs` VALUES ('682', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:22:19', '2026-03-05 09:22:19');
INSERT INTO `audit_logs` VALUES ('683', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:22:21', '2026-03-05 09:22:21');
INSERT INTO `audit_logs` VALUES ('684', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:22:22', '2026-03-05 09:22:22');
INSERT INTO `audit_logs` VALUES ('685', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:22:24', '2026-03-05 09:22:24');
INSERT INTO `audit_logs` VALUES ('686', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:22:24', '2026-03-05 09:22:24');
INSERT INTO `audit_logs` VALUES ('687', '1', 'Josh Gracxiosa', 'Admin', 'Update', 'Announcements', 'Update in Announcements (ID: 1)', '127.0.0.1', 'success', '2026-03-05 09:22:40', '2026-03-05 09:22:40');
INSERT INTO `audit_logs` VALUES ('688', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:22:40', '2026-03-05 09:22:40');
INSERT INTO `audit_logs` VALUES ('689', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:22:40', '2026-03-05 09:22:40');
INSERT INTO `audit_logs` VALUES ('690', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements (ID: 2)', '127.0.0.1', 'success', '2026-03-05 09:23:14', '2026-03-05 09:23:14');
INSERT INTO `audit_logs` VALUES ('691', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements (ID: 3)', '127.0.0.1', 'success', '2026-03-05 09:23:25', '2026-03-05 09:23:25');
INSERT INTO `audit_logs` VALUES ('692', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 09:24:36', '2026-03-05 09:24:36');
INSERT INTO `audit_logs` VALUES ('693', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 09:24:37', '2026-03-05 09:24:37');
INSERT INTO `audit_logs` VALUES ('694', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 09:24:37', '2026-03-05 09:24:37');
INSERT INTO `audit_logs` VALUES ('695', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:24:37', '2026-03-05 09:24:37');
INSERT INTO `audit_logs` VALUES ('696', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:24:38', '2026-03-05 09:24:38');
INSERT INTO `audit_logs` VALUES ('697', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 09:24:38', '2026-03-05 09:24:38');
INSERT INTO `audit_logs` VALUES ('698', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:24:38', '2026-03-05 09:24:38');
INSERT INTO `audit_logs` VALUES ('699', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:24:39', '2026-03-05 09:24:39');
INSERT INTO `audit_logs` VALUES ('700', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 09:29:49', '2026-03-05 09:29:49');
INSERT INTO `audit_logs` VALUES ('701', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 09:29:49', '2026-03-05 09:29:49');
INSERT INTO `audit_logs` VALUES ('702', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 09:29:50', '2026-03-05 09:29:50');
INSERT INTO `audit_logs` VALUES ('703', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:29:50', '2026-03-05 09:29:50');
INSERT INTO `audit_logs` VALUES ('704', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:29:50', '2026-03-05 09:29:50');
INSERT INTO `audit_logs` VALUES ('705', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 09:29:50', '2026-03-05 09:29:50');
INSERT INTO `audit_logs` VALUES ('706', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:29:51', '2026-03-05 09:29:51');
INSERT INTO `audit_logs` VALUES ('707', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:29:51', '2026-03-05 09:29:51');
INSERT INTO `audit_logs` VALUES ('708', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:30:45', '2026-03-05 09:30:45');
INSERT INTO `audit_logs` VALUES ('709', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 09:31:11', '2026-03-05 09:31:11');
INSERT INTO `audit_logs` VALUES ('710', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 09:31:12', '2026-03-05 09:31:12');
INSERT INTO `audit_logs` VALUES ('711', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 09:31:12', '2026-03-05 09:31:12');
INSERT INTO `audit_logs` VALUES ('712', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:31:12', '2026-03-05 09:31:12');
INSERT INTO `audit_logs` VALUES ('713', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 09:31:13', '2026-03-05 09:31:13');
INSERT INTO `audit_logs` VALUES ('714', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:31:13', '2026-03-05 09:31:13');
INSERT INTO `audit_logs` VALUES ('715', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 09:31:17', '2026-03-05 09:31:17');
INSERT INTO `audit_logs` VALUES ('716', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 09:31:17', '2026-03-05 09:31:17');
INSERT INTO `audit_logs` VALUES ('717', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:31:18', '2026-03-05 09:31:18');
INSERT INTO `audit_logs` VALUES ('718', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:31:18', '2026-03-05 09:31:18');
INSERT INTO `audit_logs` VALUES ('719', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements (ID: 4)', '127.0.0.1', 'success', '2026-03-05 09:31:27', '2026-03-05 09:31:27');
INSERT INTO `audit_logs` VALUES ('720', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements (ID: 3)', '127.0.0.1', 'success', '2026-03-05 09:31:30', '2026-03-05 09:31:30');
INSERT INTO `audit_logs` VALUES ('721', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements (ID: 1)', '127.0.0.1', 'success', '2026-03-05 09:31:33', '2026-03-05 09:31:33');
INSERT INTO `audit_logs` VALUES ('722', '1', 'Josh Gracxiosa', 'Admin', 'Update', 'Announcements', 'Update in Announcements (ID: 1)', '127.0.0.1', 'success', '2026-03-05 09:31:46', '2026-03-05 09:31:46');
INSERT INTO `audit_logs` VALUES ('723', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:31:47', '2026-03-05 09:31:47');
INSERT INTO `audit_logs` VALUES ('724', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements (ID: 2)', '127.0.0.1', 'success', '2026-03-05 09:31:50', '2026-03-05 09:31:50');
INSERT INTO `audit_logs` VALUES ('725', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:35:55', '2026-03-05 09:35:55');
INSERT INTO `audit_logs` VALUES ('726', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 09:37:44', '2026-03-05 09:37:44');
INSERT INTO `audit_logs` VALUES ('727', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 09:37:44', '2026-03-05 09:37:44');
INSERT INTO `audit_logs` VALUES ('728', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 09:37:44', '2026-03-05 09:37:44');
INSERT INTO `audit_logs` VALUES ('729', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:37:44', '2026-03-05 09:37:44');
INSERT INTO `audit_logs` VALUES ('730', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 09:37:45', '2026-03-05 09:37:45');
INSERT INTO `audit_logs` VALUES ('731', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:37:45', '2026-03-05 09:37:45');
INSERT INTO `audit_logs` VALUES ('732', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements (ID: 4)', '127.0.0.1', 'success', '2026-03-05 09:37:50', '2026-03-05 09:37:50');
INSERT INTO `audit_logs` VALUES ('733', '1', 'Josh Gracxiosa', 'Admin', 'Update', 'Announcements', 'Update in Announcements (ID: 1)', '127.0.0.1', 'failed', '2026-03-05 09:38:26', '2026-03-05 09:38:26');
INSERT INTO `audit_logs` VALUES ('734', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 09:39:49', '2026-03-05 09:39:49');
INSERT INTO `audit_logs` VALUES ('735', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 09:39:49', '2026-03-05 09:39:49');
INSERT INTO `audit_logs` VALUES ('736', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 09:39:50', '2026-03-05 09:39:50');
INSERT INTO `audit_logs` VALUES ('737', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:39:50', '2026-03-05 09:39:50');
INSERT INTO `audit_logs` VALUES ('738', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 09:39:50', '2026-03-05 09:39:50');
INSERT INTO `audit_logs` VALUES ('739', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:39:51', '2026-03-05 09:39:51');
INSERT INTO `audit_logs` VALUES ('740', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 09:41:34', '2026-03-05 09:41:34');
INSERT INTO `audit_logs` VALUES ('741', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 09:41:34', '2026-03-05 09:41:34');
INSERT INTO `audit_logs` VALUES ('742', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 09:41:34', '2026-03-05 09:41:34');
INSERT INTO `audit_logs` VALUES ('743', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:41:35', '2026-03-05 09:41:35');
INSERT INTO `audit_logs` VALUES ('744', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 09:41:35', '2026-03-05 09:41:35');
INSERT INTO `audit_logs` VALUES ('745', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:41:36', '2026-03-05 09:41:36');
INSERT INTO `audit_logs` VALUES ('746', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements (ID: 1)', '127.0.0.1', 'success', '2026-03-05 09:41:40', '2026-03-05 09:41:40');
INSERT INTO `audit_logs` VALUES ('747', '1', 'Josh Gracxiosa', 'Admin', 'Update', 'Announcements', 'Update in Announcements (ID: 1)', '127.0.0.1', 'success', '2026-03-05 09:41:49', '2026-03-05 09:41:49');
INSERT INTO `audit_logs` VALUES ('748', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:41:50', '2026-03-05 09:41:50');
INSERT INTO `audit_logs` VALUES ('749', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements (ID: 2)', '127.0.0.1', 'success', '2026-03-05 09:41:59', '2026-03-05 09:41:59');
INSERT INTO `audit_logs` VALUES ('750', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements (ID: 1)', '127.0.0.1', 'success', '2026-03-05 09:42:02', '2026-03-05 09:42:02');
INSERT INTO `audit_logs` VALUES ('751', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:43:48', '2026-03-05 09:43:48');
INSERT INTO `audit_logs` VALUES ('752', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 09:44:22', '2026-03-05 09:44:22');
INSERT INTO `audit_logs` VALUES ('753', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 09:44:23', '2026-03-05 09:44:23');
INSERT INTO `audit_logs` VALUES ('754', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 09:44:23', '2026-03-05 09:44:23');
INSERT INTO `audit_logs` VALUES ('755', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:44:23', '2026-03-05 09:44:23');
INSERT INTO `audit_logs` VALUES ('756', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 09:44:24', '2026-03-05 09:44:24');
INSERT INTO `audit_logs` VALUES ('757', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:44:24', '2026-03-05 09:44:24');
INSERT INTO `audit_logs` VALUES ('758', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements (ID: 1)', '127.0.0.1', 'success', '2026-03-05 09:44:30', '2026-03-05 09:44:30');
INSERT INTO `audit_logs` VALUES ('759', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements (ID: 1)', '127.0.0.1', 'success', '2026-03-05 09:44:33', '2026-03-05 09:44:33');
INSERT INTO `audit_logs` VALUES ('760', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements (ID: 3)', '127.0.0.1', 'success', '2026-03-05 09:44:44', '2026-03-05 09:44:44');
INSERT INTO `audit_logs` VALUES ('761', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements (ID: 1)', '127.0.0.1', 'success', '2026-03-05 09:44:47', '2026-03-05 09:44:47');
INSERT INTO `audit_logs` VALUES ('762', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements (ID: 1)', '127.0.0.1', 'success', '2026-03-05 09:45:20', '2026-03-05 09:45:20');
INSERT INTO `audit_logs` VALUES ('763', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements (ID: 1)', '127.0.0.1', 'success', '2026-03-05 09:45:30', '2026-03-05 09:45:30');
INSERT INTO `audit_logs` VALUES ('764', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 09:45:59', '2026-03-05 09:45:59');
INSERT INTO `audit_logs` VALUES ('765', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 09:46:00', '2026-03-05 09:46:00');
INSERT INTO `audit_logs` VALUES ('766', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 09:46:00', '2026-03-05 09:46:00');
INSERT INTO `audit_logs` VALUES ('767', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:46:00', '2026-03-05 09:46:00');
INSERT INTO `audit_logs` VALUES ('768', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 09:46:00', '2026-03-05 09:46:00');
INSERT INTO `audit_logs` VALUES ('769', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:46:01', '2026-03-05 09:46:01');
INSERT INTO `audit_logs` VALUES ('770', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements (ID: 1)', '127.0.0.1', 'success', '2026-03-05 09:46:05', '2026-03-05 09:46:05');
INSERT INTO `audit_logs` VALUES ('771', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements (ID: 1)', '127.0.0.1', 'success', '2026-03-05 09:46:17', '2026-03-05 09:46:17');
INSERT INTO `audit_logs` VALUES ('772', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements (ID: 1)', '127.0.0.1', 'success', '2026-03-05 09:46:37', '2026-03-05 09:46:37');
INSERT INTO `audit_logs` VALUES ('773', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 09:48:12', '2026-03-05 09:48:12');
INSERT INTO `audit_logs` VALUES ('774', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 09:48:13', '2026-03-05 09:48:13');
INSERT INTO `audit_logs` VALUES ('775', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 09:48:13', '2026-03-05 09:48:13');
INSERT INTO `audit_logs` VALUES ('776', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:48:13', '2026-03-05 09:48:13');
INSERT INTO `audit_logs` VALUES ('777', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 09:48:14', '2026-03-05 09:48:14');
INSERT INTO `audit_logs` VALUES ('778', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:48:14', '2026-03-05 09:48:14');
INSERT INTO `audit_logs` VALUES ('779', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements (ID: 1)', '127.0.0.1', 'success', '2026-03-05 09:48:20', '2026-03-05 09:48:20');
INSERT INTO `audit_logs` VALUES ('780', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 09:50:00', '2026-03-05 09:50:00');
INSERT INTO `audit_logs` VALUES ('781', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 09:50:01', '2026-03-05 09:50:01');
INSERT INTO `audit_logs` VALUES ('782', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 09:50:01', '2026-03-05 09:50:01');
INSERT INTO `audit_logs` VALUES ('783', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:50:01', '2026-03-05 09:50:01');
INSERT INTO `audit_logs` VALUES ('784', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 09:50:01', '2026-03-05 09:50:01');
INSERT INTO `audit_logs` VALUES ('785', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:50:02', '2026-03-05 09:50:02');
INSERT INTO `audit_logs` VALUES ('786', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements (ID: 4)', '127.0.0.1', 'success', '2026-03-05 09:50:09', '2026-03-05 09:50:09');
INSERT INTO `audit_logs` VALUES ('787', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements (ID: 4)', '127.0.0.1', 'success', '2026-03-05 09:50:17', '2026-03-05 09:50:17');
INSERT INTO `audit_logs` VALUES ('788', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements (ID: 1)', '127.0.0.1', 'success', '2026-03-05 09:50:28', '2026-03-05 09:50:28');
INSERT INTO `audit_logs` VALUES ('789', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:50:57', '2026-03-05 09:50:57');
INSERT INTO `audit_logs` VALUES ('790', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:50:58', '2026-03-05 09:50:58');
INSERT INTO `audit_logs` VALUES ('791', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:51:03', '2026-03-05 09:51:03');
INSERT INTO `audit_logs` VALUES ('792', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:51:04', '2026-03-05 09:51:04');
INSERT INTO `audit_logs` VALUES ('793', '1', 'Josh Gracxiosa', 'Admin', 'Create', 'Announcements', 'Create in Announcements', '127.0.0.1', 'success', '2026-03-05 09:51:47', '2026-03-05 09:51:47');
INSERT INTO `audit_logs` VALUES ('794', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:51:47', '2026-03-05 09:51:47');
INSERT INTO `audit_logs` VALUES ('795', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements (ID: 5)', '127.0.0.1', 'success', '2026-03-05 09:51:50', '2026-03-05 09:51:50');
INSERT INTO `audit_logs` VALUES ('796', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements (ID: 1)', '127.0.0.1', 'success', '2026-03-05 09:52:03', '2026-03-05 09:52:03');
INSERT INTO `audit_logs` VALUES ('797', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements (ID: 3)', '127.0.0.1', 'success', '2026-03-05 09:52:06', '2026-03-05 09:52:06');
INSERT INTO `audit_logs` VALUES ('798', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements (ID: 5)', '127.0.0.1', 'success', '2026-03-05 09:52:11', '2026-03-05 09:52:11');
INSERT INTO `audit_logs` VALUES ('799', '1', 'Josh Gracxiosa', 'Admin', 'Delete', 'Announcements', 'Delete in Announcements (ID: 5)', '127.0.0.1', 'success', '2026-03-05 09:52:18', '2026-03-05 09:52:18');
INSERT INTO `audit_logs` VALUES ('800', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 09:52:18', '2026-03-05 09:52:18');
INSERT INTO `audit_logs` VALUES ('801', '1', 'Josh Gracxiosa', 'Admin', 'Login', 'Authentication', 'User logged into the system', '127.0.0.1', 'success', '2026-03-05 10:04:10', '2026-03-05 10:04:10');
INSERT INTO `audit_logs` VALUES ('802', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:04:11', '2026-03-05 10:04:11');
INSERT INTO `audit_logs` VALUES ('803', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 10:04:11', '2026-03-05 10:04:11');
INSERT INTO `audit_logs` VALUES ('804', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 10:04:12', '2026-03-05 10:04:12');
INSERT INTO `audit_logs` VALUES ('805', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:04:12', '2026-03-05 10:04:12');
INSERT INTO `audit_logs` VALUES ('806', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 10:04:13', '2026-03-05 10:04:13');
INSERT INTO `audit_logs` VALUES ('807', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 10:04:13', '2026-03-05 10:04:13');
INSERT INTO `audit_logs` VALUES ('808', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 10:04:13', '2026-03-05 10:04:13');
INSERT INTO `audit_logs` VALUES ('809', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 10:04:14', '2026-03-05 10:04:14');
INSERT INTO `audit_logs` VALUES ('810', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:04:35', '2026-03-05 10:04:35');
INSERT INTO `audit_logs` VALUES ('811', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:04:36', '2026-03-05 10:04:36');
INSERT INTO `audit_logs` VALUES ('812', '1', 'Josh Gracxiosa', 'Admin', 'Login', 'Authentication', 'User logged into the system', '127.0.0.1', 'success', '2026-03-05 10:04:38', '2026-03-05 10:04:38');
INSERT INTO `audit_logs` VALUES ('813', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:04:38', '2026-03-05 10:04:38');
INSERT INTO `audit_logs` VALUES ('814', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 10:04:38', '2026-03-05 10:04:38');
INSERT INTO `audit_logs` VALUES ('815', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 10:04:39', '2026-03-05 10:04:39');
INSERT INTO `audit_logs` VALUES ('816', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 10:04:39', '2026-03-05 10:04:39');
INSERT INTO `audit_logs` VALUES ('817', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:04:39', '2026-03-05 10:04:39');
INSERT INTO `audit_logs` VALUES ('818', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 10:04:40', '2026-03-05 10:04:40');
INSERT INTO `audit_logs` VALUES ('819', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 10:04:40', '2026-03-05 10:04:40');
INSERT INTO `audit_logs` VALUES ('820', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 10:04:40', '2026-03-05 10:04:40');
INSERT INTO `audit_logs` VALUES ('821', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:05:09', '2026-03-05 10:05:09');
INSERT INTO `audit_logs` VALUES ('822', '1', 'Josh Gracxiosa', 'Admin', 'Login', 'Authentication', 'User logged into the system', '127.0.0.1', 'success', '2026-03-05 10:05:12', '2026-03-05 10:05:12');
INSERT INTO `audit_logs` VALUES ('823', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:05:13', '2026-03-05 10:05:13');
INSERT INTO `audit_logs` VALUES ('824', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 10:05:13', '2026-03-05 10:05:13');
INSERT INTO `audit_logs` VALUES ('825', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 10:05:13', '2026-03-05 10:05:13');
INSERT INTO `audit_logs` VALUES ('826', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 10:05:14', '2026-03-05 10:05:14');
INSERT INTO `audit_logs` VALUES ('827', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:05:14', '2026-03-05 10:05:14');
INSERT INTO `audit_logs` VALUES ('828', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 10:05:14', '2026-03-05 10:05:14');
INSERT INTO `audit_logs` VALUES ('829', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 10:05:15', '2026-03-05 10:05:15');
INSERT INTO `audit_logs` VALUES ('830', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 10:05:15', '2026-03-05 10:05:15');
INSERT INTO `audit_logs` VALUES ('831', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:05:31', '2026-03-05 10:05:31');
INSERT INTO `audit_logs` VALUES ('832', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:05:32', '2026-03-05 10:05:32');
INSERT INTO `audit_logs` VALUES ('833', '1', 'Josh Gracxiosa', 'Admin', 'Login', 'Authentication', 'User logged into the system', '127.0.0.1', 'success', '2026-03-05 10:05:35', '2026-03-05 10:05:35');
INSERT INTO `audit_logs` VALUES ('834', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:05:35', '2026-03-05 10:05:35');
INSERT INTO `audit_logs` VALUES ('835', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 10:05:35', '2026-03-05 10:05:35');
INSERT INTO `audit_logs` VALUES ('836', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 10:05:36', '2026-03-05 10:05:36');
INSERT INTO `audit_logs` VALUES ('837', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 10:05:36', '2026-03-05 10:05:36');
INSERT INTO `audit_logs` VALUES ('838', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:05:36', '2026-03-05 10:05:36');
INSERT INTO `audit_logs` VALUES ('839', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 10:05:37', '2026-03-05 10:05:37');
INSERT INTO `audit_logs` VALUES ('840', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 10:05:37', '2026-03-05 10:05:37');
INSERT INTO `audit_logs` VALUES ('841', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 10:05:38', '2026-03-05 10:05:38');
INSERT INTO `audit_logs` VALUES ('842', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:05:42', '2026-03-05 10:05:42');
INSERT INTO `audit_logs` VALUES ('843', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:05:42', '2026-03-05 10:05:42');
INSERT INTO `audit_logs` VALUES ('844', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:05:43', '2026-03-05 10:05:43');
INSERT INTO `audit_logs` VALUES ('845', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 10:05:43', '2026-03-05 10:05:43');
INSERT INTO `audit_logs` VALUES ('846', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 10:05:43', '2026-03-05 10:05:43');
INSERT INTO `audit_logs` VALUES ('847', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 10:05:44', '2026-03-05 10:05:44');
INSERT INTO `audit_logs` VALUES ('848', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:05:44', '2026-03-05 10:05:44');
INSERT INTO `audit_logs` VALUES ('849', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 10:05:44', '2026-03-05 10:05:44');
INSERT INTO `audit_logs` VALUES ('850', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 10:05:45', '2026-03-05 10:05:45');
INSERT INTO `audit_logs` VALUES ('851', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 10:05:45', '2026-03-05 10:05:45');
INSERT INTO `audit_logs` VALUES ('852', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 10:05:46', '2026-03-05 10:05:46');
INSERT INTO `audit_logs` VALUES ('853', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 10:05:46', '2026-03-05 10:05:46');
INSERT INTO `audit_logs` VALUES ('854', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 10:05:46', '2026-03-05 10:05:46');
INSERT INTO `audit_logs` VALUES ('855', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 10:06:53', '2026-03-05 10:06:53');
INSERT INTO `audit_logs` VALUES ('856', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:06:54', '2026-03-05 10:06:54');
INSERT INTO `audit_logs` VALUES ('857', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:06:54', '2026-03-05 10:06:54');
INSERT INTO `audit_logs` VALUES ('858', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:06:54', '2026-03-05 10:06:54');
INSERT INTO `audit_logs` VALUES ('859', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 10:06:55', '2026-03-05 10:06:55');
INSERT INTO `audit_logs` VALUES ('860', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:06:55', '2026-03-05 10:06:55');
INSERT INTO `audit_logs` VALUES ('861', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 10:06:55', '2026-03-05 10:06:55');
INSERT INTO `audit_logs` VALUES ('862', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:06:59', '2026-03-05 10:06:59');
INSERT INTO `audit_logs` VALUES ('863', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:06:59', '2026-03-05 10:06:59');
INSERT INTO `audit_logs` VALUES ('864', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:07:12', '2026-03-05 10:07:12');
INSERT INTO `audit_logs` VALUES ('865', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:07:12', '2026-03-05 10:07:12');
INSERT INTO `audit_logs` VALUES ('866', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:07:13', '2026-03-05 10:07:13');
INSERT INTO `audit_logs` VALUES ('867', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:07:13', '2026-03-05 10:07:13');
INSERT INTO `audit_logs` VALUES ('868', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:07:13', '2026-03-05 10:07:13');
INSERT INTO `audit_logs` VALUES ('869', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:07:14', '2026-03-05 10:07:14');
INSERT INTO `audit_logs` VALUES ('870', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:07:26', '2026-03-05 10:07:26');
INSERT INTO `audit_logs` VALUES ('871', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:07:26', '2026-03-05 10:07:26');
INSERT INTO `audit_logs` VALUES ('872', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:07:26', '2026-03-05 10:07:26');
INSERT INTO `audit_logs` VALUES ('873', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:07:27', '2026-03-05 10:07:27');
INSERT INTO `audit_logs` VALUES ('874', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:07:27', '2026-03-05 10:07:27');
INSERT INTO `audit_logs` VALUES ('875', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:07:27', '2026-03-05 10:07:27');
INSERT INTO `audit_logs` VALUES ('876', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:07:36', '2026-03-05 10:07:36');
INSERT INTO `audit_logs` VALUES ('877', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:07:36', '2026-03-05 10:07:36');
INSERT INTO `audit_logs` VALUES ('878', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:07:36', '2026-03-05 10:07:36');
INSERT INTO `audit_logs` VALUES ('879', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:07:36', '2026-03-05 10:07:36');
INSERT INTO `audit_logs` VALUES ('880', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:07:37', '2026-03-05 10:07:37');
INSERT INTO `audit_logs` VALUES ('881', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:07:37', '2026-03-05 10:07:37');
INSERT INTO `audit_logs` VALUES ('882', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:08:00', '2026-03-05 10:08:00');
INSERT INTO `audit_logs` VALUES ('883', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:08:00', '2026-03-05 10:08:00');
INSERT INTO `audit_logs` VALUES ('884', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:08:00', '2026-03-05 10:08:00');
INSERT INTO `audit_logs` VALUES ('885', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:08:01', '2026-03-05 10:08:01');
INSERT INTO `audit_logs` VALUES ('886', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:08:01', '2026-03-05 10:08:01');
INSERT INTO `audit_logs` VALUES ('887', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:08:02', '2026-03-05 10:08:02');
INSERT INTO `audit_logs` VALUES ('888', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:08:43', '2026-03-05 10:08:43');
INSERT INTO `audit_logs` VALUES ('889', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:08:43', '2026-03-05 10:08:43');
INSERT INTO `audit_logs` VALUES ('890', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:08:44', '2026-03-05 10:08:44');
INSERT INTO `audit_logs` VALUES ('891', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:08:44', '2026-03-05 10:08:44');
INSERT INTO `audit_logs` VALUES ('892', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:08:44', '2026-03-05 10:08:44');
INSERT INTO `audit_logs` VALUES ('893', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:08:45', '2026-03-05 10:08:45');
INSERT INTO `audit_logs` VALUES ('894', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:09:23', '2026-03-05 10:09:23');
INSERT INTO `audit_logs` VALUES ('895', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:09:24', '2026-03-05 10:09:24');
INSERT INTO `audit_logs` VALUES ('896', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:09:24', '2026-03-05 10:09:24');
INSERT INTO `audit_logs` VALUES ('897', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:09:24', '2026-03-05 10:09:24');
INSERT INTO `audit_logs` VALUES ('898', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:09:25', '2026-03-05 10:09:25');
INSERT INTO `audit_logs` VALUES ('899', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:09:25', '2026-03-05 10:09:25');
INSERT INTO `audit_logs` VALUES ('900', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:10:14', '2026-03-05 10:10:14');
INSERT INTO `audit_logs` VALUES ('901', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:10:14', '2026-03-05 10:10:14');
INSERT INTO `audit_logs` VALUES ('902', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:10:15', '2026-03-05 10:10:15');
INSERT INTO `audit_logs` VALUES ('903', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:10:15', '2026-03-05 10:10:15');
INSERT INTO `audit_logs` VALUES ('904', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:10:15', '2026-03-05 10:10:15');
INSERT INTO `audit_logs` VALUES ('905', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:10:16', '2026-03-05 10:10:16');
INSERT INTO `audit_logs` VALUES ('906', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:10:27', '2026-03-05 10:10:27');
INSERT INTO `audit_logs` VALUES ('907', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:10:27', '2026-03-05 10:10:27');
INSERT INTO `audit_logs` VALUES ('908', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:10:27', '2026-03-05 10:10:27');
INSERT INTO `audit_logs` VALUES ('909', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:10:28', '2026-03-05 10:10:28');
INSERT INTO `audit_logs` VALUES ('910', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:10:28', '2026-03-05 10:10:28');
INSERT INTO `audit_logs` VALUES ('911', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:10:28', '2026-03-05 10:10:28');
INSERT INTO `audit_logs` VALUES ('912', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:11:09', '2026-03-05 10:11:09');
INSERT INTO `audit_logs` VALUES ('913', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:11:09', '2026-03-05 10:11:09');
INSERT INTO `audit_logs` VALUES ('914', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:11:09', '2026-03-05 10:11:09');
INSERT INTO `audit_logs` VALUES ('915', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:11:10', '2026-03-05 10:11:10');
INSERT INTO `audit_logs` VALUES ('916', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:11:10', '2026-03-05 10:11:10');
INSERT INTO `audit_logs` VALUES ('917', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:11:10', '2026-03-05 10:11:10');
INSERT INTO `audit_logs` VALUES ('918', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:11:44', '2026-03-05 10:11:44');
INSERT INTO `audit_logs` VALUES ('919', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:11:44', '2026-03-05 10:11:44');
INSERT INTO `audit_logs` VALUES ('920', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:11:44', '2026-03-05 10:11:44');
INSERT INTO `audit_logs` VALUES ('921', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:11:44', '2026-03-05 10:11:44');
INSERT INTO `audit_logs` VALUES ('922', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:11:45', '2026-03-05 10:11:45');
INSERT INTO `audit_logs` VALUES ('923', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:11:45', '2026-03-05 10:11:45');
INSERT INTO `audit_logs` VALUES ('924', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:12:23', '2026-03-05 10:12:23');
INSERT INTO `audit_logs` VALUES ('925', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:12:23', '2026-03-05 10:12:23');
INSERT INTO `audit_logs` VALUES ('926', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:12:23', '2026-03-05 10:12:23');
INSERT INTO `audit_logs` VALUES ('927', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:12:24', '2026-03-05 10:12:24');
INSERT INTO `audit_logs` VALUES ('928', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:12:24', '2026-03-05 10:12:24');
INSERT INTO `audit_logs` VALUES ('929', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:12:24', '2026-03-05 10:12:24');
INSERT INTO `audit_logs` VALUES ('930', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:14:57', '2026-03-05 10:14:57');
INSERT INTO `audit_logs` VALUES ('931', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:14:58', '2026-03-05 10:14:58');
INSERT INTO `audit_logs` VALUES ('932', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:14:58', '2026-03-05 10:14:58');
INSERT INTO `audit_logs` VALUES ('933', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:14:58', '2026-03-05 10:14:58');
INSERT INTO `audit_logs` VALUES ('934', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:14:59', '2026-03-05 10:14:59');
INSERT INTO `audit_logs` VALUES ('935', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:14:59', '2026-03-05 10:14:59');
INSERT INTO `audit_logs` VALUES ('936', '1', 'Josh Gracxiosa', 'Admin', 'Update', 'Routes Management', 'Update in Routes Management', '127.0.0.1', 'failed', '2026-03-05 10:15:58', '2026-03-05 10:15:58');
INSERT INTO `audit_logs` VALUES ('937', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:19:00', '2026-03-05 10:19:00');
INSERT INTO `audit_logs` VALUES ('938', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:19:00', '2026-03-05 10:19:00');
INSERT INTO `audit_logs` VALUES ('939', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:19:00', '2026-03-05 10:19:00');
INSERT INTO `audit_logs` VALUES ('940', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:19:01', '2026-03-05 10:19:01');
INSERT INTO `audit_logs` VALUES ('941', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:19:01', '2026-03-05 10:19:01');
INSERT INTO `audit_logs` VALUES ('942', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:19:01', '2026-03-05 10:19:01');
INSERT INTO `audit_logs` VALUES ('943', '1', 'Josh Gracxiosa', 'Admin', 'Update', 'Routes Management', 'Update in Routes Management', '127.0.0.1', 'failed', '2026-03-05 10:19:45', '2026-03-05 10:19:45');
INSERT INTO `audit_logs` VALUES ('944', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:21:20', '2026-03-05 10:21:20');
INSERT INTO `audit_logs` VALUES ('945', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:21:20', '2026-03-05 10:21:20');
INSERT INTO `audit_logs` VALUES ('946', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:21:20', '2026-03-05 10:21:20');
INSERT INTO `audit_logs` VALUES ('947', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:21:21', '2026-03-05 10:21:21');
INSERT INTO `audit_logs` VALUES ('948', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:21:21', '2026-03-05 10:21:21');
INSERT INTO `audit_logs` VALUES ('949', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:21:21', '2026-03-05 10:21:21');
INSERT INTO `audit_logs` VALUES ('950', '1', 'Josh Gracxiosa', 'Admin', 'Update', 'Routes Management', 'Update in Routes Management', '127.0.0.1', 'failed', '2026-03-05 10:21:37', '2026-03-05 10:21:37');
INSERT INTO `audit_logs` VALUES ('951', '1', 'Josh Gracxiosa', 'Admin', 'Update', 'Routes Management', 'Update in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:25:05', '2026-03-05 10:25:05');
INSERT INTO `audit_logs` VALUES ('952', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:25:05', '2026-03-05 10:25:05');
INSERT INTO `audit_logs` VALUES ('953', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:25:27', '2026-03-05 10:25:27');
INSERT INTO `audit_logs` VALUES ('954', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:25:27', '2026-03-05 10:25:27');
INSERT INTO `audit_logs` VALUES ('955', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:25:28', '2026-03-05 10:25:28');
INSERT INTO `audit_logs` VALUES ('956', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:25:28', '2026-03-05 10:25:28');
INSERT INTO `audit_logs` VALUES ('957', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:25:28', '2026-03-05 10:25:28');
INSERT INTO `audit_logs` VALUES ('958', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:25:29', '2026-03-05 10:25:29');
INSERT INTO `audit_logs` VALUES ('959', '1', 'Josh Gracxiosa', 'Admin', 'Update', 'Routes Management', 'Update in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:25:40', '2026-03-05 10:25:40');
INSERT INTO `audit_logs` VALUES ('960', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:25:40', '2026-03-05 10:25:40');
INSERT INTO `audit_logs` VALUES ('961', '1', 'Josh Gracxiosa', 'Admin', 'Update', 'Routes Management', 'Update in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:26:16', '2026-03-05 10:26:16');
INSERT INTO `audit_logs` VALUES ('962', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:26:16', '2026-03-05 10:26:16');
INSERT INTO `audit_logs` VALUES ('963', '1', 'Josh Gracxiosa', 'Admin', 'Update', 'Routes Management', 'Update in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:26:39', '2026-03-05 10:26:39');
INSERT INTO `audit_logs` VALUES ('964', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:26:39', '2026-03-05 10:26:39');
INSERT INTO `audit_logs` VALUES ('965', '1', 'Josh Gracxiosa', 'Admin', 'Update', 'Routes Management', 'Update in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:26:57', '2026-03-05 10:26:57');
INSERT INTO `audit_logs` VALUES ('966', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:26:58', '2026-03-05 10:26:58');
INSERT INTO `audit_logs` VALUES ('967', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:31:23', '2026-03-05 10:31:23');
INSERT INTO `audit_logs` VALUES ('968', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:31:23', '2026-03-05 10:31:23');
INSERT INTO `audit_logs` VALUES ('969', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:31:23', '2026-03-05 10:31:23');
INSERT INTO `audit_logs` VALUES ('970', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:31:24', '2026-03-05 10:31:24');
INSERT INTO `audit_logs` VALUES ('971', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:31:24', '2026-03-05 10:31:24');
INSERT INTO `audit_logs` VALUES ('972', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:31:24', '2026-03-05 10:31:24');
INSERT INTO `audit_logs` VALUES ('973', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:35:29', '2026-03-05 10:35:29');
INSERT INTO `audit_logs` VALUES ('974', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:35:29', '2026-03-05 10:35:29');
INSERT INTO `audit_logs` VALUES ('975', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:35:29', '2026-03-05 10:35:29');
INSERT INTO `audit_logs` VALUES ('976', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:35:30', '2026-03-05 10:35:30');
INSERT INTO `audit_logs` VALUES ('977', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:35:30', '2026-03-05 10:35:30');
INSERT INTO `audit_logs` VALUES ('978', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:35:30', '2026-03-05 10:35:30');
INSERT INTO `audit_logs` VALUES ('979', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:40:30', '2026-03-05 10:40:30');
INSERT INTO `audit_logs` VALUES ('980', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:40:30', '2026-03-05 10:40:30');
INSERT INTO `audit_logs` VALUES ('981', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:40:31', '2026-03-05 10:40:31');
INSERT INTO `audit_logs` VALUES ('982', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:40:31', '2026-03-05 10:40:31');
INSERT INTO `audit_logs` VALUES ('983', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:40:31', '2026-03-05 10:40:31');
INSERT INTO `audit_logs` VALUES ('984', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:40:32', '2026-03-05 10:40:32');
INSERT INTO `audit_logs` VALUES ('985', '1', 'Josh Gracxiosa', 'Admin', 'Create', 'Routes Management', 'Create in Routes Management', '127.0.0.1', 'failed', '2026-03-05 10:41:49', '2026-03-05 10:41:49');
INSERT INTO `audit_logs` VALUES ('986', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:44:08', '2026-03-05 10:44:08');
INSERT INTO `audit_logs` VALUES ('987', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:44:08', '2026-03-05 10:44:08');
INSERT INTO `audit_logs` VALUES ('988', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:44:09', '2026-03-05 10:44:09');
INSERT INTO `audit_logs` VALUES ('989', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:44:09', '2026-03-05 10:44:09');
INSERT INTO `audit_logs` VALUES ('990', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:44:09', '2026-03-05 10:44:09');
INSERT INTO `audit_logs` VALUES ('991', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:44:10', '2026-03-05 10:44:10');
INSERT INTO `audit_logs` VALUES ('992', '1', 'Josh Gracxiosa', 'Admin', 'Create', 'Routes Management', 'Create in Routes Management', '127.0.0.1', 'failed', '2026-03-05 10:45:07', '2026-03-05 10:45:07');
INSERT INTO `audit_logs` VALUES ('993', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:47:00', '2026-03-05 10:47:00');
INSERT INTO `audit_logs` VALUES ('994', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:47:00', '2026-03-05 10:47:00');
INSERT INTO `audit_logs` VALUES ('995', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:47:00', '2026-03-05 10:47:00');
INSERT INTO `audit_logs` VALUES ('996', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:47:01', '2026-03-05 10:47:01');
INSERT INTO `audit_logs` VALUES ('997', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:47:01', '2026-03-05 10:47:01');
INSERT INTO `audit_logs` VALUES ('998', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:47:01', '2026-03-05 10:47:01');
INSERT INTO `audit_logs` VALUES ('999', '1', 'Josh Gracxiosa', 'Admin', 'Create', 'Routes Management', 'Create in Routes Management', '127.0.0.1', 'failed', '2026-03-05 10:48:15', '2026-03-05 10:48:15');
INSERT INTO `audit_logs` VALUES ('1000', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:49:32', '2026-03-05 10:49:32');
INSERT INTO `audit_logs` VALUES ('1001', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:49:32', '2026-03-05 10:49:32');
INSERT INTO `audit_logs` VALUES ('1002', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:49:33', '2026-03-05 10:49:33');
INSERT INTO `audit_logs` VALUES ('1003', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:49:33', '2026-03-05 10:49:33');
INSERT INTO `audit_logs` VALUES ('1004', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:49:33', '2026-03-05 10:49:33');
INSERT INTO `audit_logs` VALUES ('1005', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:49:34', '2026-03-05 10:49:34');
INSERT INTO `audit_logs` VALUES ('1006', '1', 'Josh Gracxiosa', 'Admin', 'Create', 'Routes Management', 'Create in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:51:39', '2026-03-05 10:51:39');
INSERT INTO `audit_logs` VALUES ('1007', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:51:39', '2026-03-05 10:51:39');
INSERT INTO `audit_logs` VALUES ('1008', '1', 'Josh Gracxiosa', 'Admin', 'Delete', 'Routes Management', 'Delete in Routes Management', '127.0.0.1', 'failed', '2026-03-05 10:52:02', '2026-03-05 10:52:02');
INSERT INTO `audit_logs` VALUES ('1009', '1', 'Josh Gracxiosa', 'Admin', 'Delete', 'Routes Management', 'Delete in Routes Management', '127.0.0.1', 'failed', '2026-03-05 10:52:17', '2026-03-05 10:52:17');
INSERT INTO `audit_logs` VALUES ('1010', '1', 'Josh Gracxiosa', 'Admin', 'Delete', 'Routes Management', 'Delete in Routes Management', '127.0.0.1', 'failed', '2026-03-05 10:52:27', '2026-03-05 10:52:27');
INSERT INTO `audit_logs` VALUES ('1011', '1', 'Josh Gracxiosa', 'Admin', 'Delete', 'Routes Management', 'Delete in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:53:11', '2026-03-05 10:53:11');
INSERT INTO `audit_logs` VALUES ('1012', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:53:11', '2026-03-05 10:53:11');
INSERT INTO `audit_logs` VALUES ('1013', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:54:51', '2026-03-05 10:54:51');
INSERT INTO `audit_logs` VALUES ('1014', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:57:55', '2026-03-05 10:57:55');
INSERT INTO `audit_logs` VALUES ('1015', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:57:56', '2026-03-05 10:57:56');
INSERT INTO `audit_logs` VALUES ('1016', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:58:05', '2026-03-05 10:58:05');
INSERT INTO `audit_logs` VALUES ('1017', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:58:05', '2026-03-05 10:58:05');
INSERT INTO `audit_logs` VALUES ('1018', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:58:09', '2026-03-05 10:58:09');
INSERT INTO `audit_logs` VALUES ('1019', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:58:09', '2026-03-05 10:58:09');
INSERT INTO `audit_logs` VALUES ('1020', '1', 'Josh Gracxiosa', 'Admin', 'Login', 'Authentication', 'User logged into the system', '127.0.0.1', 'success', '2026-03-05 10:58:20', '2026-03-05 10:58:20');
INSERT INTO `audit_logs` VALUES ('1021', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:58:21', '2026-03-05 10:58:21');
INSERT INTO `audit_logs` VALUES ('1022', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 10:58:21', '2026-03-05 10:58:21');
INSERT INTO `audit_logs` VALUES ('1023', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 10:58:21', '2026-03-05 10:58:21');
INSERT INTO `audit_logs` VALUES ('1024', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 10:58:21', '2026-03-05 10:58:21');
INSERT INTO `audit_logs` VALUES ('1025', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:58:22', '2026-03-05 10:58:22');
INSERT INTO `audit_logs` VALUES ('1026', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 10:58:22', '2026-03-05 10:58:22');
INSERT INTO `audit_logs` VALUES ('1027', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 10:58:22', '2026-03-05 10:58:22');
INSERT INTO `audit_logs` VALUES ('1028', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 10:58:23', '2026-03-05 10:58:23');
INSERT INTO `audit_logs` VALUES ('1029', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:59:22', '2026-03-05 10:59:22');
INSERT INTO `audit_logs` VALUES ('1030', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 10:59:22', '2026-03-05 10:59:22');
INSERT INTO `audit_logs` VALUES ('1031', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:59:23', '2026-03-05 10:59:23');
INSERT INTO `audit_logs` VALUES ('1032', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 10:59:23', '2026-03-05 10:59:23');
INSERT INTO `audit_logs` VALUES ('1033', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 10:59:23', '2026-03-05 10:59:23');
INSERT INTO `audit_logs` VALUES ('1034', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 10:59:24', '2026-03-05 10:59:24');
INSERT INTO `audit_logs` VALUES ('1035', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 10:59:24', '2026-03-05 10:59:24');
INSERT INTO `audit_logs` VALUES ('1036', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 10:59:25', '2026-03-05 10:59:25');
INSERT INTO `audit_logs` VALUES ('1037', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 10:59:26', '2026-03-05 10:59:26');
INSERT INTO `audit_logs` VALUES ('1038', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 10:59:26', '2026-03-05 10:59:26');
INSERT INTO `audit_logs` VALUES ('1039', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 10:59:27', '2026-03-05 10:59:27');
INSERT INTO `audit_logs` VALUES ('1040', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 10:59:27', '2026-03-05 10:59:27');
INSERT INTO `audit_logs` VALUES ('1041', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 10:59:28', '2026-03-05 10:59:28');
INSERT INTO `audit_logs` VALUES ('1042', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:59:28', '2026-03-05 10:59:28');
INSERT INTO `audit_logs` VALUES ('1043', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:59:29', '2026-03-05 10:59:29');
INSERT INTO `audit_logs` VALUES ('1044', '1', 'Josh Gracxiosa', 'Admin', 'Update', 'Routes Management', 'Update in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:59:45', '2026-03-05 10:59:45');
INSERT INTO `audit_logs` VALUES ('1045', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 10:59:45', '2026-03-05 10:59:45');
INSERT INTO `audit_logs` VALUES ('1046', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 11:21:00', '2026-03-05 11:21:00');
INSERT INTO `audit_logs` VALUES ('1047', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 11:21:01', '2026-03-05 11:21:01');
INSERT INTO `audit_logs` VALUES ('1048', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 11:21:23', '2026-03-05 11:21:23');
INSERT INTO `audit_logs` VALUES ('1049', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 11:21:24', '2026-03-05 11:21:24');
INSERT INTO `audit_logs` VALUES ('1050', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 11:21:24', '2026-03-05 11:21:24');
INSERT INTO `audit_logs` VALUES ('1051', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 11:21:25', '2026-03-05 11:21:25');
INSERT INTO `audit_logs` VALUES ('1052', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 11:21:25', '2026-03-05 11:21:25');
INSERT INTO `audit_logs` VALUES ('1053', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 11:21:26', '2026-03-05 11:21:26');
INSERT INTO `audit_logs` VALUES ('1054', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 11:21:26', '2026-03-05 11:21:26');
INSERT INTO `audit_logs` VALUES ('1055', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 11:21:26', '2026-03-05 11:21:26');
INSERT INTO `audit_logs` VALUES ('1056', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 11:25:45', '2026-03-05 11:25:45');
INSERT INTO `audit_logs` VALUES ('1057', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 11:26:15', '2026-03-05 11:26:15');
INSERT INTO `audit_logs` VALUES ('1058', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 11:26:16', '2026-03-05 11:26:16');
INSERT INTO `audit_logs` VALUES ('1059', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 11:26:16', '2026-03-05 11:26:16');
INSERT INTO `audit_logs` VALUES ('1060', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 11:26:16', '2026-03-05 11:26:16');
INSERT INTO `audit_logs` VALUES ('1061', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 11:26:17', '2026-03-05 11:26:17');
INSERT INTO `audit_logs` VALUES ('1062', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 11:26:17', '2026-03-05 11:26:17');
INSERT INTO `audit_logs` VALUES ('1063', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 11:26:25', '2026-03-05 11:26:25');
INSERT INTO `audit_logs` VALUES ('1064', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 11:26:25', '2026-03-05 11:26:25');
INSERT INTO `audit_logs` VALUES ('1065', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 11:26:25', '2026-03-05 11:26:25');
INSERT INTO `audit_logs` VALUES ('1066', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 11:26:26', '2026-03-05 11:26:26');
INSERT INTO `audit_logs` VALUES ('1067', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 11:26:26', '2026-03-05 11:26:26');
INSERT INTO `audit_logs` VALUES ('1068', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 11:26:26', '2026-03-05 11:26:26');
INSERT INTO `audit_logs` VALUES ('1069', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 11:26:37', '2026-03-05 11:26:37');
INSERT INTO `audit_logs` VALUES ('1070', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 11:26:37', '2026-03-05 11:26:37');
INSERT INTO `audit_logs` VALUES ('1071', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 11:26:37', '2026-03-05 11:26:37');
INSERT INTO `audit_logs` VALUES ('1072', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 11:26:37', '2026-03-05 11:26:37');
INSERT INTO `audit_logs` VALUES ('1073', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 11:26:38', '2026-03-05 11:26:38');
INSERT INTO `audit_logs` VALUES ('1074', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 11:26:38', '2026-03-05 11:26:38');
INSERT INTO `audit_logs` VALUES ('1075', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 11:29:03', '2026-03-05 11:29:03');
INSERT INTO `audit_logs` VALUES ('1076', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 11:29:03', '2026-03-05 11:29:03');
INSERT INTO `audit_logs` VALUES ('1077', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 11:29:03', '2026-03-05 11:29:03');
INSERT INTO `audit_logs` VALUES ('1078', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 11:29:04', '2026-03-05 11:29:04');
INSERT INTO `audit_logs` VALUES ('1079', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 11:29:04', '2026-03-05 11:29:04');
INSERT INTO `audit_logs` VALUES ('1080', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 11:29:04', '2026-03-05 11:29:04');
INSERT INTO `audit_logs` VALUES ('1081', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 11:29:18', '2026-03-05 11:29:18');
INSERT INTO `audit_logs` VALUES ('1082', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 11:29:18', '2026-03-05 11:29:18');
INSERT INTO `audit_logs` VALUES ('1083', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 11:29:19', '2026-03-05 11:29:19');
INSERT INTO `audit_logs` VALUES ('1084', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 11:29:19', '2026-03-05 11:29:19');
INSERT INTO `audit_logs` VALUES ('1085', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 11:29:20', '2026-03-05 11:29:20');
INSERT INTO `audit_logs` VALUES ('1086', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 11:29:20', '2026-03-05 11:29:20');
INSERT INTO `audit_logs` VALUES ('1087', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 11:29:47', '2026-03-05 11:29:47');
INSERT INTO `audit_logs` VALUES ('1088', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 11:29:47', '2026-03-05 11:29:47');
INSERT INTO `audit_logs` VALUES ('1089', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 11:29:48', '2026-03-05 11:29:48');
INSERT INTO `audit_logs` VALUES ('1090', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 11:29:48', '2026-03-05 11:29:48');
INSERT INTO `audit_logs` VALUES ('1091', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 11:29:48', '2026-03-05 11:29:48');
INSERT INTO `audit_logs` VALUES ('1092', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 11:29:48', '2026-03-05 11:29:48');
INSERT INTO `audit_logs` VALUES ('1093', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 11:51:01', '2026-03-05 11:51:01');
INSERT INTO `audit_logs` VALUES ('1094', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 11:51:02', '2026-03-05 11:51:02');
INSERT INTO `audit_logs` VALUES ('1095', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 11:51:02', '2026-03-05 11:51:02');
INSERT INTO `audit_logs` VALUES ('1096', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 11:51:02', '2026-03-05 11:51:02');
INSERT INTO `audit_logs` VALUES ('1097', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 11:51:02', '2026-03-05 11:51:02');
INSERT INTO `audit_logs` VALUES ('1098', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 11:51:03', '2026-03-05 11:51:03');
INSERT INTO `audit_logs` VALUES ('1099', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 11:52:47', '2026-03-05 11:52:47');
INSERT INTO `audit_logs` VALUES ('1100', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 11:52:47', '2026-03-05 11:52:47');
INSERT INTO `audit_logs` VALUES ('1101', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 11:52:48', '2026-03-05 11:52:48');
INSERT INTO `audit_logs` VALUES ('1102', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 11:52:48', '2026-03-05 11:52:48');
INSERT INTO `audit_logs` VALUES ('1103', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 11:52:48', '2026-03-05 11:52:48');
INSERT INTO `audit_logs` VALUES ('1104', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 11:52:49', '2026-03-05 11:52:49');
INSERT INTO `audit_logs` VALUES ('1105', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 11:53:14', '2026-03-05 11:53:14');
INSERT INTO `audit_logs` VALUES ('1106', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 11:53:37', '2026-03-05 11:53:37');
INSERT INTO `audit_logs` VALUES ('1107', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 11:53:38', '2026-03-05 11:53:38');
INSERT INTO `audit_logs` VALUES ('1108', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 11:53:40', '2026-03-05 11:53:40');
INSERT INTO `audit_logs` VALUES ('1109', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 11:53:41', '2026-03-05 11:53:41');
INSERT INTO `audit_logs` VALUES ('1110', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 11:57:17', '2026-03-05 11:57:17');
INSERT INTO `audit_logs` VALUES ('1111', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 11:57:18', '2026-03-05 11:57:18');
INSERT INTO `audit_logs` VALUES ('1112', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 11:57:18', '2026-03-05 11:57:18');
INSERT INTO `audit_logs` VALUES ('1113', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 11:57:18', '2026-03-05 11:57:18');
INSERT INTO `audit_logs` VALUES ('1114', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 11:57:19', '2026-03-05 11:57:19');
INSERT INTO `audit_logs` VALUES ('1115', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 11:57:19', '2026-03-05 11:57:19');
INSERT INTO `audit_logs` VALUES ('1116', '1', 'Josh Gracxiosa', 'Admin', 'Login', 'Authentication', 'User logged into the system', '127.0.0.1', 'success', '2026-03-05 12:00:06', '2026-03-05 12:00:06');
INSERT INTO `audit_logs` VALUES ('1117', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 12:00:06', '2026-03-05 12:00:06');
INSERT INTO `audit_logs` VALUES ('1118', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 12:00:06', '2026-03-05 12:00:06');
INSERT INTO `audit_logs` VALUES ('1119', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 12:00:07', '2026-03-05 12:00:07');
INSERT INTO `audit_logs` VALUES ('1120', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 12:00:07', '2026-03-05 12:00:07');
INSERT INTO `audit_logs` VALUES ('1121', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 12:00:07', '2026-03-05 12:00:07');
INSERT INTO `audit_logs` VALUES ('1122', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 12:00:08', '2026-03-05 12:00:08');
INSERT INTO `audit_logs` VALUES ('1123', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 12:00:08', '2026-03-05 12:00:08');
INSERT INTO `audit_logs` VALUES ('1124', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 12:00:08', '2026-03-05 12:00:08');
INSERT INTO `audit_logs` VALUES ('1125', '1', 'Josh Gracxiosa', 'Admin', 'Create', 'System', 'Create in System', '127.0.0.1', 'success', '2026-03-05 12:00:18', '2026-03-05 12:00:18');
INSERT INTO `audit_logs` VALUES ('1126', '1', 'Josh Gracxiosa', 'Admin', 'Login', 'Authentication', 'User logged into the system', '127.0.0.1', 'success', '2026-03-05 12:00:25', '2026-03-05 12:00:25');
INSERT INTO `audit_logs` VALUES ('1127', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 12:00:31', '2026-03-05 12:00:31');
INSERT INTO `audit_logs` VALUES ('1128', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 12:02:06', '2026-03-05 12:02:06');
INSERT INTO `audit_logs` VALUES ('1129', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 12:03:17', '2026-03-05 12:03:17');
INSERT INTO `audit_logs` VALUES ('1130', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 12:03:18', '2026-03-05 12:03:18');
INSERT INTO `audit_logs` VALUES ('1131', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 12:03:24', '2026-03-05 12:03:24');
INSERT INTO `audit_logs` VALUES ('1132', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 12:03:25', '2026-03-05 12:03:25');
INSERT INTO `audit_logs` VALUES ('1133', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 12:03:25', '2026-03-05 12:03:25');
INSERT INTO `audit_logs` VALUES ('1134', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 12:03:25', '2026-03-05 12:03:25');
INSERT INTO `audit_logs` VALUES ('1135', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 12:03:25', '2026-03-05 12:03:25');
INSERT INTO `audit_logs` VALUES ('1136', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 12:03:26', '2026-03-05 12:03:26');
INSERT INTO `audit_logs` VALUES ('1137', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 12:03:37', '2026-03-05 12:03:37');
INSERT INTO `audit_logs` VALUES ('1138', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 12:03:38', '2026-03-05 12:03:38');
INSERT INTO `audit_logs` VALUES ('1139', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 12:03:38', '2026-03-05 12:03:38');
INSERT INTO `audit_logs` VALUES ('1140', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 12:03:39', '2026-03-05 12:03:39');
INSERT INTO `audit_logs` VALUES ('1141', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 12:03:39', '2026-03-05 12:03:39');
INSERT INTO `audit_logs` VALUES ('1142', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 12:03:39', '2026-03-05 12:03:39');
INSERT INTO `audit_logs` VALUES ('1143', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 12:03:40', '2026-03-05 12:03:40');
INSERT INTO `audit_logs` VALUES ('1144', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 12:03:40', '2026-03-05 12:03:40');
INSERT INTO `audit_logs` VALUES ('1145', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 12:03:40', '2026-03-05 12:03:40');
INSERT INTO `audit_logs` VALUES ('1146', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 12:03:41', '2026-03-05 12:03:41');
INSERT INTO `audit_logs` VALUES ('1147', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 12:04:04', '2026-03-05 12:04:04');
INSERT INTO `audit_logs` VALUES ('1148', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 12:04:04', '2026-03-05 12:04:04');
INSERT INTO `audit_logs` VALUES ('1149', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 12:04:04', '2026-03-05 12:04:04');
INSERT INTO `audit_logs` VALUES ('1150', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 12:04:05', '2026-03-05 12:04:05');
INSERT INTO `audit_logs` VALUES ('1151', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 12:05:50', '2026-03-05 12:05:50');
INSERT INTO `audit_logs` VALUES ('1152', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 12:05:50', '2026-03-05 12:05:50');
INSERT INTO `audit_logs` VALUES ('1153', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 12:05:51', '2026-03-05 12:05:51');
INSERT INTO `audit_logs` VALUES ('1154', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 12:05:52', '2026-03-05 12:05:52');
INSERT INTO `audit_logs` VALUES ('1155', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 12:05:52', '2026-03-05 12:05:52');
INSERT INTO `audit_logs` VALUES ('1156', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 12:05:53', '2026-03-05 12:05:53');
INSERT INTO `audit_logs` VALUES ('1157', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 12:09:06', '2026-03-05 12:09:06');
INSERT INTO `audit_logs` VALUES ('1158', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 12:09:06', '2026-03-05 12:09:06');
INSERT INTO `audit_logs` VALUES ('1159', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 12:09:07', '2026-03-05 12:09:07');
INSERT INTO `audit_logs` VALUES ('1160', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 12:09:07', '2026-03-05 12:09:07');
INSERT INTO `audit_logs` VALUES ('1161', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 12:09:07', '2026-03-05 12:09:07');
INSERT INTO `audit_logs` VALUES ('1162', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 12:09:08', '2026-03-05 12:09:08');
INSERT INTO `audit_logs` VALUES ('1163', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 12:10:52', '2026-03-05 12:10:52');
INSERT INTO `audit_logs` VALUES ('1164', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 12:10:52', '2026-03-05 12:10:52');
INSERT INTO `audit_logs` VALUES ('1165', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 12:10:52', '2026-03-05 12:10:52');
INSERT INTO `audit_logs` VALUES ('1166', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 12:10:53', '2026-03-05 12:10:53');
INSERT INTO `audit_logs` VALUES ('1167', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 12:10:53', '2026-03-05 12:10:53');
INSERT INTO `audit_logs` VALUES ('1168', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 12:10:53', '2026-03-05 12:10:53');
INSERT INTO `audit_logs` VALUES ('1169', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 12:11:05', '2026-03-05 12:11:05');
INSERT INTO `audit_logs` VALUES ('1170', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 12:11:05', '2026-03-05 12:11:05');
INSERT INTO `audit_logs` VALUES ('1171', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 12:11:05', '2026-03-05 12:11:05');
INSERT INTO `audit_logs` VALUES ('1172', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 12:11:05', '2026-03-05 12:11:05');
INSERT INTO `audit_logs` VALUES ('1173', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 12:11:06', '2026-03-05 12:11:06');
INSERT INTO `audit_logs` VALUES ('1174', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 12:11:06', '2026-03-05 12:11:06');
INSERT INTO `audit_logs` VALUES ('1175', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 12:13:36', '2026-03-05 12:13:36');
INSERT INTO `audit_logs` VALUES ('1176', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 12:13:36', '2026-03-05 12:13:36');
INSERT INTO `audit_logs` VALUES ('1177', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 12:13:37', '2026-03-05 12:13:37');
INSERT INTO `audit_logs` VALUES ('1178', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 12:13:37', '2026-03-05 12:13:37');
INSERT INTO `audit_logs` VALUES ('1179', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 12:13:37', '2026-03-05 12:13:37');
INSERT INTO `audit_logs` VALUES ('1180', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 12:13:38', '2026-03-05 12:13:38');
INSERT INTO `audit_logs` VALUES ('1181', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 12:14:07', '2026-03-05 12:14:07');
INSERT INTO `audit_logs` VALUES ('1182', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 12:14:07', '2026-03-05 12:14:07');
INSERT INTO `audit_logs` VALUES ('1183', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 12:14:08', '2026-03-05 12:14:08');
INSERT INTO `audit_logs` VALUES ('1184', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 12:14:08', '2026-03-05 12:14:08');
INSERT INTO `audit_logs` VALUES ('1185', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 12:14:08', '2026-03-05 12:14:08');
INSERT INTO `audit_logs` VALUES ('1186', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 12:14:09', '2026-03-05 12:14:09');
INSERT INTO `audit_logs` VALUES ('1187', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 12:15:24', '2026-03-05 12:15:24');
INSERT INTO `audit_logs` VALUES ('1188', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 12:15:24', '2026-03-05 12:15:24');
INSERT INTO `audit_logs` VALUES ('1189', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 12:15:24', '2026-03-05 12:15:24');
INSERT INTO `audit_logs` VALUES ('1190', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 12:15:25', '2026-03-05 12:15:25');
INSERT INTO `audit_logs` VALUES ('1191', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 12:15:25', '2026-03-05 12:15:25');
INSERT INTO `audit_logs` VALUES ('1192', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 12:15:26', '2026-03-05 12:15:26');
INSERT INTO `audit_logs` VALUES ('1193', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 12:16:56', '2026-03-05 12:16:56');
INSERT INTO `audit_logs` VALUES ('1194', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 12:17:35', '2026-03-05 12:17:35');
INSERT INTO `audit_logs` VALUES ('1195', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 12:17:35', '2026-03-05 12:17:35');
INSERT INTO `audit_logs` VALUES ('1196', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 12:17:36', '2026-03-05 12:17:36');
INSERT INTO `audit_logs` VALUES ('1197', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 12:17:36', '2026-03-05 12:17:36');
INSERT INTO `audit_logs` VALUES ('1198', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 12:17:36', '2026-03-05 12:17:36');
INSERT INTO `audit_logs` VALUES ('1199', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 12:17:37', '2026-03-05 12:17:37');
INSERT INTO `audit_logs` VALUES ('1200', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 12:21:18', '2026-03-05 12:21:18');
INSERT INTO `audit_logs` VALUES ('1201', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 12:21:28', '2026-03-05 12:21:28');
INSERT INTO `audit_logs` VALUES ('1202', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 12:21:29', '2026-03-05 12:21:29');
INSERT INTO `audit_logs` VALUES ('1203', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 12:21:29', '2026-03-05 12:21:29');
INSERT INTO `audit_logs` VALUES ('1204', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 12:21:30', '2026-03-05 12:21:30');
INSERT INTO `audit_logs` VALUES ('1205', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 12:21:30', '2026-03-05 12:21:30');
INSERT INTO `audit_logs` VALUES ('1206', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 12:21:30', '2026-03-05 12:21:30');
INSERT INTO `audit_logs` VALUES ('1207', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 12:22:37', '2026-03-05 12:22:37');
INSERT INTO `audit_logs` VALUES ('1208', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 12:22:37', '2026-03-05 12:22:37');
INSERT INTO `audit_logs` VALUES ('1209', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 12:22:38', '2026-03-05 12:22:38');
INSERT INTO `audit_logs` VALUES ('1210', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 12:22:38', '2026-03-05 12:22:38');
INSERT INTO `audit_logs` VALUES ('1211', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 12:22:38', '2026-03-05 12:22:38');
INSERT INTO `audit_logs` VALUES ('1212', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 12:22:39', '2026-03-05 12:22:39');
INSERT INTO `audit_logs` VALUES ('1213', '1', 'Josh Gracxiosa', 'Admin', 'Login', 'Authentication', 'User logged into the system', '127.0.0.1', 'success', '2026-03-05 13:15:19', '2026-03-05 13:15:19');
INSERT INTO `audit_logs` VALUES ('1214', '1', 'Josh Gracxiosa', 'Admin', 'Login', 'Authentication', 'User logged into the system', '127.0.0.1', 'success', '2026-03-05 13:15:43', '2026-03-05 13:15:43');
INSERT INTO `audit_logs` VALUES ('1215', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 13:15:47', '2026-03-05 13:15:47');
INSERT INTO `audit_logs` VALUES ('1216', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 13:15:47', '2026-03-05 13:15:47');
INSERT INTO `audit_logs` VALUES ('1217', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 13:15:47', '2026-03-05 13:15:47');
INSERT INTO `audit_logs` VALUES ('1218', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 13:15:48', '2026-03-05 13:15:48');
INSERT INTO `audit_logs` VALUES ('1219', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 13:15:48', '2026-03-05 13:15:48');
INSERT INTO `audit_logs` VALUES ('1220', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 13:15:49', '2026-03-05 13:15:49');
INSERT INTO `audit_logs` VALUES ('1221', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 13:15:49', '2026-03-05 13:15:49');
INSERT INTO `audit_logs` VALUES ('1222', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 13:15:49', '2026-03-05 13:15:49');
INSERT INTO `audit_logs` VALUES ('1223', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 13:15:54', '2026-03-05 13:15:54');
INSERT INTO `audit_logs` VALUES ('1224', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 13:15:54', '2026-03-05 13:15:54');
INSERT INTO `audit_logs` VALUES ('1225', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 13:15:56', '2026-03-05 13:15:56');
INSERT INTO `audit_logs` VALUES ('1226', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 13:15:56', '2026-03-05 13:15:56');
INSERT INTO `audit_logs` VALUES ('1227', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 13:15:58', '2026-03-05 13:15:58');
INSERT INTO `audit_logs` VALUES ('1228', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 13:15:58', '2026-03-05 13:15:58');
INSERT INTO `audit_logs` VALUES ('1229', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 13:16:01', '2026-03-05 13:16:01');
INSERT INTO `audit_logs` VALUES ('1230', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 13:16:01', '2026-03-05 13:16:01');
INSERT INTO `audit_logs` VALUES ('1231', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 13:16:09', '2026-03-05 13:16:09');
INSERT INTO `audit_logs` VALUES ('1232', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 13:16:09', '2026-03-05 13:16:09');
INSERT INTO `audit_logs` VALUES ('1233', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 13:16:30', '2026-03-05 13:16:30');
INSERT INTO `audit_logs` VALUES ('1234', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 13:16:30', '2026-03-05 13:16:30');
INSERT INTO `audit_logs` VALUES ('1235', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 13:16:31', '2026-03-05 13:16:31');
INSERT INTO `audit_logs` VALUES ('1236', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 13:16:31', '2026-03-05 13:16:31');
INSERT INTO `audit_logs` VALUES ('1237', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 13:16:33', '2026-03-05 13:16:33');
INSERT INTO `audit_logs` VALUES ('1238', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 13:16:33', '2026-03-05 13:16:33');
INSERT INTO `audit_logs` VALUES ('1239', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 13:16:34', '2026-03-05 13:16:34');
INSERT INTO `audit_logs` VALUES ('1240', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 13:16:35', '2026-03-05 13:16:35');
INSERT INTO `audit_logs` VALUES ('1241', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 13:16:37', '2026-03-05 13:16:37');
INSERT INTO `audit_logs` VALUES ('1242', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 13:16:37', '2026-03-05 13:16:37');
INSERT INTO `audit_logs` VALUES ('1243', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 13:17:34', '2026-03-05 13:17:34');
INSERT INTO `audit_logs` VALUES ('1244', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Announcements', 'View in Announcements', '127.0.0.1', 'success', '2026-03-05 13:17:34', '2026-03-05 13:17:34');
INSERT INTO `audit_logs` VALUES ('1245', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 13:17:35', '2026-03-05 13:17:35');
INSERT INTO `audit_logs` VALUES ('1246', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 13:17:36', '2026-03-05 13:17:36');
INSERT INTO `audit_logs` VALUES ('1247', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 13:24:38', '2026-03-05 13:24:38');
INSERT INTO `audit_logs` VALUES ('1248', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Schedules Management', 'View in Schedules Management', '127.0.0.1', 'success', '2026-03-05 13:24:39', '2026-03-05 13:24:39');
INSERT INTO `audit_logs` VALUES ('1249', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 13:48:10', '2026-03-05 13:48:10');
INSERT INTO `audit_logs` VALUES ('1250', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 13:48:10', '2026-03-05 13:48:10');
INSERT INTO `audit_logs` VALUES ('1251', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'failed', '2026-03-05 13:48:11', '2026-03-05 13:48:11');
INSERT INTO `audit_logs` VALUES ('1252', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 13:48:11', '2026-03-05 13:48:11');
INSERT INTO `audit_logs` VALUES ('1253', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 13:48:11', '2026-03-05 13:48:11');
INSERT INTO `audit_logs` VALUES ('1254', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 13:48:26', '2026-03-05 13:48:26');
INSERT INTO `audit_logs` VALUES ('1255', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 13:48:26', '2026-03-05 13:48:26');
INSERT INTO `audit_logs` VALUES ('1256', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 13:48:27', '2026-03-05 13:48:27');
INSERT INTO `audit_logs` VALUES ('1257', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 13:48:27', '2026-03-05 13:48:27');
INSERT INTO `audit_logs` VALUES ('1258', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 13:48:27', '2026-03-05 13:48:27');
INSERT INTO `audit_logs` VALUES ('1259', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 13:48:28', '2026-03-05 13:48:28');
INSERT INTO `audit_logs` VALUES ('1260', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 13:48:30', '2026-03-05 13:48:30');
INSERT INTO `audit_logs` VALUES ('1261', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 13:48:31', '2026-03-05 13:48:31');
INSERT INTO `audit_logs` VALUES ('1262', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'failed', '2026-03-05 13:48:31', '2026-03-05 13:48:31');
INSERT INTO `audit_logs` VALUES ('1263', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 13:48:31', '2026-03-05 13:48:31');
INSERT INTO `audit_logs` VALUES ('1264', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 13:48:32', '2026-03-05 13:48:32');
INSERT INTO `audit_logs` VALUES ('1265', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 13:48:32', '2026-03-05 13:48:32');
INSERT INTO `audit_logs` VALUES ('1266', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 13:48:32', '2026-03-05 13:48:32');
INSERT INTO `audit_logs` VALUES ('1267', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'failed', '2026-03-05 13:48:33', '2026-03-05 13:48:33');
INSERT INTO `audit_logs` VALUES ('1268', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 13:48:33', '2026-03-05 13:48:33');
INSERT INTO `audit_logs` VALUES ('1269', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 13:48:33', '2026-03-05 13:48:33');
INSERT INTO `audit_logs` VALUES ('1270', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 13:48:34', '2026-03-05 13:48:34');
INSERT INTO `audit_logs` VALUES ('1271', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 13:48:34', '2026-03-05 13:48:34');
INSERT INTO `audit_logs` VALUES ('1272', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 13:48:35', '2026-03-05 13:48:35');
INSERT INTO `audit_logs` VALUES ('1273', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 13:48:35', '2026-03-05 13:48:35');
INSERT INTO `audit_logs` VALUES ('1274', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 13:48:36', '2026-03-05 13:48:36');
INSERT INTO `audit_logs` VALUES ('1275', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 13:48:36', '2026-03-05 13:48:36');
INSERT INTO `audit_logs` VALUES ('1276', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 13:48:41', '2026-03-05 13:48:41');
INSERT INTO `audit_logs` VALUES ('1277', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 13:48:42', '2026-03-05 13:48:42');
INSERT INTO `audit_logs` VALUES ('1278', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'failed', '2026-03-05 13:48:42', '2026-03-05 13:48:42');
INSERT INTO `audit_logs` VALUES ('1279', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 13:48:43', '2026-03-05 13:48:43');
INSERT INTO `audit_logs` VALUES ('1280', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 13:48:43', '2026-03-05 13:48:43');
INSERT INTO `audit_logs` VALUES ('1281', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 13:48:44', '2026-03-05 13:48:44');
INSERT INTO `audit_logs` VALUES ('1282', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 13:48:44', '2026-03-05 13:48:44');
INSERT INTO `audit_logs` VALUES ('1283', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'failed', '2026-03-05 13:48:45', '2026-03-05 13:48:45');
INSERT INTO `audit_logs` VALUES ('1284', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 13:48:45', '2026-03-05 13:48:45');
INSERT INTO `audit_logs` VALUES ('1285', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 13:48:45', '2026-03-05 13:48:45');
INSERT INTO `audit_logs` VALUES ('1286', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 13:48:51', '2026-03-05 13:48:51');
INSERT INTO `audit_logs` VALUES ('1287', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 13:48:51', '2026-03-05 13:48:51');
INSERT INTO `audit_logs` VALUES ('1288', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 13:48:52', '2026-03-05 13:48:52');
INSERT INTO `audit_logs` VALUES ('1289', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 13:48:53', '2026-03-05 13:48:53');
INSERT INTO `audit_logs` VALUES ('1290', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'failed', '2026-03-05 13:48:53', '2026-03-05 13:48:53');
INSERT INTO `audit_logs` VALUES ('1291', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 13:48:54', '2026-03-05 13:48:54');
INSERT INTO `audit_logs` VALUES ('1292', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 13:48:54', '2026-03-05 13:48:54');
INSERT INTO `audit_logs` VALUES ('1293', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 13:48:55', '2026-03-05 13:48:55');
INSERT INTO `audit_logs` VALUES ('1294', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 13:48:56', '2026-03-05 13:48:56');
INSERT INTO `audit_logs` VALUES ('1295', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 13:48:56', '2026-03-05 13:48:56');
INSERT INTO `audit_logs` VALUES ('1296', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'failed', '2026-03-05 13:48:57', '2026-03-05 13:48:57');
INSERT INTO `audit_logs` VALUES ('1297', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 13:48:57', '2026-03-05 13:48:57');
INSERT INTO `audit_logs` VALUES ('1298', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 13:48:57', '2026-03-05 13:48:57');
INSERT INTO `audit_logs` VALUES ('1299', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 13:48:58', '2026-03-05 13:48:58');
INSERT INTO `audit_logs` VALUES ('1300', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 13:49:48', '2026-03-05 13:49:48');
INSERT INTO `audit_logs` VALUES ('1301', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 13:49:48', '2026-03-05 13:49:48');
INSERT INTO `audit_logs` VALUES ('1302', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 13:49:48', '2026-03-05 13:49:48');
INSERT INTO `audit_logs` VALUES ('1303', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 13:49:48', '2026-03-05 13:49:48');
INSERT INTO `audit_logs` VALUES ('1304', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 13:49:49', '2026-03-05 13:49:49');
INSERT INTO `audit_logs` VALUES ('1305', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'failed', '2026-03-05 13:49:49', '2026-03-05 13:49:49');
INSERT INTO `audit_logs` VALUES ('1306', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 13:49:49', '2026-03-05 13:49:49');
INSERT INTO `audit_logs` VALUES ('1307', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 13:49:50', '2026-03-05 13:49:50');
INSERT INTO `audit_logs` VALUES ('1308', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 13:49:50', '2026-03-05 13:49:50');
INSERT INTO `audit_logs` VALUES ('1309', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 13:49:50', '2026-03-05 13:49:50');
INSERT INTO `audit_logs` VALUES ('1310', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 13:49:51', '2026-03-05 13:49:51');
INSERT INTO `audit_logs` VALUES ('1311', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'failed', '2026-03-05 13:49:51', '2026-03-05 13:49:51');
INSERT INTO `audit_logs` VALUES ('1312', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 13:49:51', '2026-03-05 13:49:51');
INSERT INTO `audit_logs` VALUES ('1313', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 13:49:52', '2026-03-05 13:49:52');
INSERT INTO `audit_logs` VALUES ('1314', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 13:52:50', '2026-03-05 13:52:50');
INSERT INTO `audit_logs` VALUES ('1315', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 13:52:50', '2026-03-05 13:52:50');
INSERT INTO `audit_logs` VALUES ('1316', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 13:52:51', '2026-03-05 13:52:51');
INSERT INTO `audit_logs` VALUES ('1317', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 13:52:51', '2026-03-05 13:52:51');
INSERT INTO `audit_logs` VALUES ('1318', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 13:52:51', '2026-03-05 13:52:51');
INSERT INTO `audit_logs` VALUES ('1319', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'failed', '2026-03-05 13:52:52', '2026-03-05 13:52:52');
INSERT INTO `audit_logs` VALUES ('1320', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 13:52:52', '2026-03-05 13:52:52');
INSERT INTO `audit_logs` VALUES ('1321', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 13:52:52', '2026-03-05 13:52:52');
INSERT INTO `audit_logs` VALUES ('1322', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 13:52:52', '2026-03-05 13:52:52');
INSERT INTO `audit_logs` VALUES ('1323', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 13:52:53', '2026-03-05 13:52:53');
INSERT INTO `audit_logs` VALUES ('1324', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 13:52:53', '2026-03-05 13:52:53');
INSERT INTO `audit_logs` VALUES ('1325', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'failed', '2026-03-05 13:52:54', '2026-03-05 13:52:54');
INSERT INTO `audit_logs` VALUES ('1326', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 13:52:54', '2026-03-05 13:52:54');
INSERT INTO `audit_logs` VALUES ('1327', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 13:52:54', '2026-03-05 13:52:54');
INSERT INTO `audit_logs` VALUES ('1328', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 13:53:48', '2026-03-05 13:53:48');
INSERT INTO `audit_logs` VALUES ('1329', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 13:53:48', '2026-03-05 13:53:48');
INSERT INTO `audit_logs` VALUES ('1330', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 13:53:48', '2026-03-05 13:53:48');
INSERT INTO `audit_logs` VALUES ('1331', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 13:53:49', '2026-03-05 13:53:49');
INSERT INTO `audit_logs` VALUES ('1332', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 13:53:49', '2026-03-05 13:53:49');
INSERT INTO `audit_logs` VALUES ('1333', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'failed', '2026-03-05 13:53:49', '2026-03-05 13:53:49');
INSERT INTO `audit_logs` VALUES ('1334', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 13:53:49', '2026-03-05 13:53:49');
INSERT INTO `audit_logs` VALUES ('1335', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 13:53:50', '2026-03-05 13:53:50');
INSERT INTO `audit_logs` VALUES ('1336', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 13:53:50', '2026-03-05 13:53:50');
INSERT INTO `audit_logs` VALUES ('1337', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 13:53:51', '2026-03-05 13:53:51');
INSERT INTO `audit_logs` VALUES ('1338', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 13:53:51', '2026-03-05 13:53:51');
INSERT INTO `audit_logs` VALUES ('1339', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'failed', '2026-03-05 13:53:51', '2026-03-05 13:53:51');
INSERT INTO `audit_logs` VALUES ('1340', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 13:53:51', '2026-03-05 13:53:51');
INSERT INTO `audit_logs` VALUES ('1341', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 13:53:52', '2026-03-05 13:53:52');
INSERT INTO `audit_logs` VALUES ('1342', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 13:57:39', '2026-03-05 13:57:39');
INSERT INTO `audit_logs` VALUES ('1343', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 13:57:39', '2026-03-05 13:57:39');
INSERT INTO `audit_logs` VALUES ('1344', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 13:57:40', '2026-03-05 13:57:40');
INSERT INTO `audit_logs` VALUES ('1345', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 13:57:40', '2026-03-05 13:57:40');
INSERT INTO `audit_logs` VALUES ('1346', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 13:57:41', '2026-03-05 13:57:41');
INSERT INTO `audit_logs` VALUES ('1347', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'failed', '2026-03-05 13:57:41', '2026-03-05 13:57:41');
INSERT INTO `audit_logs` VALUES ('1348', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 13:57:41', '2026-03-05 13:57:41');
INSERT INTO `audit_logs` VALUES ('1349', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 13:57:42', '2026-03-05 13:57:42');
INSERT INTO `audit_logs` VALUES ('1350', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 13:57:42', '2026-03-05 13:57:42');
INSERT INTO `audit_logs` VALUES ('1351', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 13:57:43', '2026-03-05 13:57:43');
INSERT INTO `audit_logs` VALUES ('1352', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 13:57:43', '2026-03-05 13:57:43');
INSERT INTO `audit_logs` VALUES ('1353', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'failed', '2026-03-05 13:57:44', '2026-03-05 13:57:44');
INSERT INTO `audit_logs` VALUES ('1354', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 13:57:44', '2026-03-05 13:57:44');
INSERT INTO `audit_logs` VALUES ('1355', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 13:57:44', '2026-03-05 13:57:44');
INSERT INTO `audit_logs` VALUES ('1356', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 14:00:09', '2026-03-05 14:00:09');
INSERT INTO `audit_logs` VALUES ('1357', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 14:00:09', '2026-03-05 14:00:09');
INSERT INTO `audit_logs` VALUES ('1358', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 14:00:09', '2026-03-05 14:00:09');
INSERT INTO `audit_logs` VALUES ('1359', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 14:00:10', '2026-03-05 14:00:10');
INSERT INTO `audit_logs` VALUES ('1360', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 14:00:10', '2026-03-05 14:00:10');
INSERT INTO `audit_logs` VALUES ('1361', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'failed', '2026-03-05 14:00:10', '2026-03-05 14:00:10');
INSERT INTO `audit_logs` VALUES ('1362', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 14:00:11', '2026-03-05 14:00:11');
INSERT INTO `audit_logs` VALUES ('1363', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 14:00:11', '2026-03-05 14:00:11');
INSERT INTO `audit_logs` VALUES ('1364', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 14:00:11', '2026-03-05 14:00:11');
INSERT INTO `audit_logs` VALUES ('1365', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 14:00:12', '2026-03-05 14:00:12');
INSERT INTO `audit_logs` VALUES ('1366', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 14:00:12', '2026-03-05 14:00:12');
INSERT INTO `audit_logs` VALUES ('1367', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'failed', '2026-03-05 14:00:12', '2026-03-05 14:00:12');
INSERT INTO `audit_logs` VALUES ('1368', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 14:00:13', '2026-03-05 14:00:13');
INSERT INTO `audit_logs` VALUES ('1369', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 14:00:13', '2026-03-05 14:00:13');
INSERT INTO `audit_logs` VALUES ('1370', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 14:00:41', '2026-03-05 14:00:41');
INSERT INTO `audit_logs` VALUES ('1371', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 14:00:41', '2026-03-05 14:00:41');
INSERT INTO `audit_logs` VALUES ('1372', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 14:00:42', '2026-03-05 14:00:42');
INSERT INTO `audit_logs` VALUES ('1373', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 14:00:42', '2026-03-05 14:00:42');
INSERT INTO `audit_logs` VALUES ('1374', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 14:00:42', '2026-03-05 14:00:42');
INSERT INTO `audit_logs` VALUES ('1375', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'failed', '2026-03-05 14:00:43', '2026-03-05 14:00:43');
INSERT INTO `audit_logs` VALUES ('1376', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 14:00:43', '2026-03-05 14:00:43');
INSERT INTO `audit_logs` VALUES ('1377', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 14:00:43', '2026-03-05 14:00:43');
INSERT INTO `audit_logs` VALUES ('1378', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 14:00:44', '2026-03-05 14:00:44');
INSERT INTO `audit_logs` VALUES ('1379', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 14:00:45', '2026-03-05 14:00:45');
INSERT INTO `audit_logs` VALUES ('1380', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 14:00:45', '2026-03-05 14:00:45');
INSERT INTO `audit_logs` VALUES ('1381', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'failed', '2026-03-05 14:00:46', '2026-03-05 14:00:46');
INSERT INTO `audit_logs` VALUES ('1382', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 14:00:46', '2026-03-05 14:00:46');
INSERT INTO `audit_logs` VALUES ('1383', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 14:00:46', '2026-03-05 14:00:46');
INSERT INTO `audit_logs` VALUES ('1384', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 14:02:12', '2026-03-05 14:02:12');
INSERT INTO `audit_logs` VALUES ('1385', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 14:02:12', '2026-03-05 14:02:12');
INSERT INTO `audit_logs` VALUES ('1386', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 14:02:13', '2026-03-05 14:02:13');
INSERT INTO `audit_logs` VALUES ('1387', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 14:02:13', '2026-03-05 14:02:13');
INSERT INTO `audit_logs` VALUES ('1388', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 14:02:13', '2026-03-05 14:02:13');
INSERT INTO `audit_logs` VALUES ('1389', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'failed', '2026-03-05 14:02:13', '2026-03-05 14:02:13');
INSERT INTO `audit_logs` VALUES ('1390', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 14:02:14', '2026-03-05 14:02:14');
INSERT INTO `audit_logs` VALUES ('1391', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 14:02:14', '2026-03-05 14:02:14');
INSERT INTO `audit_logs` VALUES ('1392', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 14:02:14', '2026-03-05 14:02:14');
INSERT INTO `audit_logs` VALUES ('1393', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 14:02:15', '2026-03-05 14:02:15');
INSERT INTO `audit_logs` VALUES ('1394', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 14:02:15', '2026-03-05 14:02:15');
INSERT INTO `audit_logs` VALUES ('1395', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'failed', '2026-03-05 14:02:15', '2026-03-05 14:02:15');
INSERT INTO `audit_logs` VALUES ('1396', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 14:02:16', '2026-03-05 14:02:16');
INSERT INTO `audit_logs` VALUES ('1397', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 14:02:16', '2026-03-05 14:02:16');
INSERT INTO `audit_logs` VALUES ('1398', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 14:04:13', '2026-03-05 14:04:13');
INSERT INTO `audit_logs` VALUES ('1399', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 14:04:13', '2026-03-05 14:04:13');
INSERT INTO `audit_logs` VALUES ('1400', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 14:04:13', '2026-03-05 14:04:13');
INSERT INTO `audit_logs` VALUES ('1401', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 14:04:14', '2026-03-05 14:04:14');
INSERT INTO `audit_logs` VALUES ('1402', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 14:04:14', '2026-03-05 14:04:14');
INSERT INTO `audit_logs` VALUES ('1403', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 14:04:14', '2026-03-05 14:04:14');
INSERT INTO `audit_logs` VALUES ('1404', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 14:04:15', '2026-03-05 14:04:15');
INSERT INTO `audit_logs` VALUES ('1405', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 14:04:15', '2026-03-05 14:04:15');
INSERT INTO `audit_logs` VALUES ('1406', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 14:04:15', '2026-03-05 14:04:15');
INSERT INTO `audit_logs` VALUES ('1407', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 14:04:16', '2026-03-05 14:04:16');
INSERT INTO `audit_logs` VALUES ('1408', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 14:04:16', '2026-03-05 14:04:16');
INSERT INTO `audit_logs` VALUES ('1409', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 14:04:16', '2026-03-05 14:04:16');
INSERT INTO `audit_logs` VALUES ('1410', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 14:04:17', '2026-03-05 14:04:17');
INSERT INTO `audit_logs` VALUES ('1411', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 14:04:17', '2026-03-05 14:04:17');
INSERT INTO `audit_logs` VALUES ('1412', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 14:05:57', '2026-03-05 14:05:57');
INSERT INTO `audit_logs` VALUES ('1413', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 14:05:57', '2026-03-05 14:05:57');
INSERT INTO `audit_logs` VALUES ('1414', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 14:05:57', '2026-03-05 14:05:57');
INSERT INTO `audit_logs` VALUES ('1415', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 14:05:58', '2026-03-05 14:05:58');
INSERT INTO `audit_logs` VALUES ('1416', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 14:05:58', '2026-03-05 14:05:58');
INSERT INTO `audit_logs` VALUES ('1417', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 14:05:58', '2026-03-05 14:05:58');
INSERT INTO `audit_logs` VALUES ('1418', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 14:05:59', '2026-03-05 14:05:59');
INSERT INTO `audit_logs` VALUES ('1419', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 14:05:59', '2026-03-05 14:05:59');
INSERT INTO `audit_logs` VALUES ('1420', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 14:06:00', '2026-03-05 14:06:00');
INSERT INTO `audit_logs` VALUES ('1421', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 14:06:01', '2026-03-05 14:06:01');
INSERT INTO `audit_logs` VALUES ('1422', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 14:06:01', '2026-03-05 14:06:01');
INSERT INTO `audit_logs` VALUES ('1423', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 14:06:02', '2026-03-05 14:06:02');
INSERT INTO `audit_logs` VALUES ('1424', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 14:06:02', '2026-03-05 14:06:02');
INSERT INTO `audit_logs` VALUES ('1425', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 14:06:02', '2026-03-05 14:06:02');
INSERT INTO `audit_logs` VALUES ('1426', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 14:08:46', '2026-03-05 14:08:46');
INSERT INTO `audit_logs` VALUES ('1427', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 14:08:46', '2026-03-05 14:08:46');
INSERT INTO `audit_logs` VALUES ('1428', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 14:08:46', '2026-03-05 14:08:46');
INSERT INTO `audit_logs` VALUES ('1429', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 14:08:47', '2026-03-05 14:08:47');
INSERT INTO `audit_logs` VALUES ('1430', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 14:08:47', '2026-03-05 14:08:47');
INSERT INTO `audit_logs` VALUES ('1431', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 14:08:47', '2026-03-05 14:08:47');
INSERT INTO `audit_logs` VALUES ('1432', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 14:08:48', '2026-03-05 14:08:48');
INSERT INTO `audit_logs` VALUES ('1433', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 14:08:48', '2026-03-05 14:08:48');
INSERT INTO `audit_logs` VALUES ('1434', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 14:08:48', '2026-03-05 14:08:48');
INSERT INTO `audit_logs` VALUES ('1435', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 14:08:49', '2026-03-05 14:08:49');
INSERT INTO `audit_logs` VALUES ('1436', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 14:08:49', '2026-03-05 14:08:49');
INSERT INTO `audit_logs` VALUES ('1437', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 14:08:49', '2026-03-05 14:08:49');
INSERT INTO `audit_logs` VALUES ('1438', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 14:08:50', '2026-03-05 14:08:50');
INSERT INTO `audit_logs` VALUES ('1439', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 14:08:50', '2026-03-05 14:08:50');
INSERT INTO `audit_logs` VALUES ('1440', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 14:09:36', '2026-03-05 14:09:36');
INSERT INTO `audit_logs` VALUES ('1441', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 14:09:37', '2026-03-05 14:09:37');
INSERT INTO `audit_logs` VALUES ('1442', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 14:09:37', '2026-03-05 14:09:37');
INSERT INTO `audit_logs` VALUES ('1443', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 14:09:38', '2026-03-05 14:09:38');
INSERT INTO `audit_logs` VALUES ('1444', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 14:09:38', '2026-03-05 14:09:38');
INSERT INTO `audit_logs` VALUES ('1445', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 14:09:38', '2026-03-05 14:09:38');
INSERT INTO `audit_logs` VALUES ('1446', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 14:09:39', '2026-03-05 14:09:39');
INSERT INTO `audit_logs` VALUES ('1447', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 14:09:39', '2026-03-05 14:09:39');
INSERT INTO `audit_logs` VALUES ('1448', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 14:09:40', '2026-03-05 14:09:40');
INSERT INTO `audit_logs` VALUES ('1449', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 14:09:40', '2026-03-05 14:09:40');
INSERT INTO `audit_logs` VALUES ('1450', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 14:09:41', '2026-03-05 14:09:41');
INSERT INTO `audit_logs` VALUES ('1451', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 14:09:41', '2026-03-05 14:09:41');
INSERT INTO `audit_logs` VALUES ('1452', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 14:09:42', '2026-03-05 14:09:42');
INSERT INTO `audit_logs` VALUES ('1453', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 14:09:42', '2026-03-05 14:09:42');
INSERT INTO `audit_logs` VALUES ('1454', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 14:09:42', '2026-03-05 14:09:42');
INSERT INTO `audit_logs` VALUES ('1455', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 14:09:43', '2026-03-05 14:09:43');
INSERT INTO `audit_logs` VALUES ('1456', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 14:09:47', '2026-03-05 14:09:47');
INSERT INTO `audit_logs` VALUES ('1457', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 14:09:47', '2026-03-05 14:09:47');
INSERT INTO `audit_logs` VALUES ('1458', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 14:09:48', '2026-03-05 14:09:48');
INSERT INTO `audit_logs` VALUES ('1459', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 14:09:48', '2026-03-05 14:09:48');
INSERT INTO `audit_logs` VALUES ('1460', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 14:09:49', '2026-03-05 14:09:49');
INSERT INTO `audit_logs` VALUES ('1461', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 14:09:49', '2026-03-05 14:09:49');
INSERT INTO `audit_logs` VALUES ('1462', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 14:09:49', '2026-03-05 14:09:49');
INSERT INTO `audit_logs` VALUES ('1463', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 14:09:50', '2026-03-05 14:09:50');
INSERT INTO `audit_logs` VALUES ('1464', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 14:09:50', '2026-03-05 14:09:50');
INSERT INTO `audit_logs` VALUES ('1465', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 14:09:51', '2026-03-05 14:09:51');
INSERT INTO `audit_logs` VALUES ('1466', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 14:09:52', '2026-03-05 14:09:52');
INSERT INTO `audit_logs` VALUES ('1467', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 14:09:52', '2026-03-05 14:09:52');
INSERT INTO `audit_logs` VALUES ('1468', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 14:09:53', '2026-03-05 14:09:53');
INSERT INTO `audit_logs` VALUES ('1469', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 14:09:53', '2026-03-05 14:09:53');
INSERT INTO `audit_logs` VALUES ('1470', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 14:09:54', '2026-03-05 14:09:54');
INSERT INTO `audit_logs` VALUES ('1471', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 14:09:55', '2026-03-05 14:09:55');
INSERT INTO `audit_logs` VALUES ('1472', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 14:10:54', '2026-03-05 14:10:54');
INSERT INTO `audit_logs` VALUES ('1473', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 14:10:54', '2026-03-05 14:10:54');
INSERT INTO `audit_logs` VALUES ('1474', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 14:10:54', '2026-03-05 14:10:54');
INSERT INTO `audit_logs` VALUES ('1475', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 14:10:54', '2026-03-05 14:10:54');
INSERT INTO `audit_logs` VALUES ('1476', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 14:10:55', '2026-03-05 14:10:55');
INSERT INTO `audit_logs` VALUES ('1477', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 14:10:55', '2026-03-05 14:10:55');
INSERT INTO `audit_logs` VALUES ('1478', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 14:10:55', '2026-03-05 14:10:55');
INSERT INTO `audit_logs` VALUES ('1479', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 14:10:56', '2026-03-05 14:10:56');
INSERT INTO `audit_logs` VALUES ('1480', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 14:10:56', '2026-03-05 14:10:56');
INSERT INTO `audit_logs` VALUES ('1481', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 14:10:57', '2026-03-05 14:10:57');
INSERT INTO `audit_logs` VALUES ('1482', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 14:10:57', '2026-03-05 14:10:57');
INSERT INTO `audit_logs` VALUES ('1483', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 14:10:57', '2026-03-05 14:10:57');
INSERT INTO `audit_logs` VALUES ('1484', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 14:10:57', '2026-03-05 14:10:57');
INSERT INTO `audit_logs` VALUES ('1485', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 14:10:58', '2026-03-05 14:10:58');
INSERT INTO `audit_logs` VALUES ('1486', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 14:11:56', '2026-03-05 14:11:56');
INSERT INTO `audit_logs` VALUES ('1487', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 14:11:56', '2026-03-05 14:11:56');
INSERT INTO `audit_logs` VALUES ('1488', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 14:11:57', '2026-03-05 14:11:57');
INSERT INTO `audit_logs` VALUES ('1489', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 14:11:57', '2026-03-05 14:11:57');
INSERT INTO `audit_logs` VALUES ('1490', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 14:11:58', '2026-03-05 14:11:58');
INSERT INTO `audit_logs` VALUES ('1491', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 14:11:58', '2026-03-05 14:11:58');
INSERT INTO `audit_logs` VALUES ('1492', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 14:11:58', '2026-03-05 14:11:58');
INSERT INTO `audit_logs` VALUES ('1493', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 14:11:59', '2026-03-05 14:11:59');
INSERT INTO `audit_logs` VALUES ('1494', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 14:11:59', '2026-03-05 14:11:59');
INSERT INTO `audit_logs` VALUES ('1495', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 14:12:00', '2026-03-05 14:12:00');
INSERT INTO `audit_logs` VALUES ('1496', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 14:12:01', '2026-03-05 14:12:01');
INSERT INTO `audit_logs` VALUES ('1497', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 14:12:01', '2026-03-05 14:12:01');
INSERT INTO `audit_logs` VALUES ('1498', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 14:12:02', '2026-03-05 14:12:02');
INSERT INTO `audit_logs` VALUES ('1499', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 14:12:02', '2026-03-05 14:12:02');
INSERT INTO `audit_logs` VALUES ('1500', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 14:12:46', '2026-03-05 14:12:46');
INSERT INTO `audit_logs` VALUES ('1501', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 14:12:47', '2026-03-05 14:12:47');
INSERT INTO `audit_logs` VALUES ('1502', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 14:12:47', '2026-03-05 14:12:47');
INSERT INTO `audit_logs` VALUES ('1503', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 14:12:47', '2026-03-05 14:12:47');
INSERT INTO `audit_logs` VALUES ('1504', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 14:12:48', '2026-03-05 14:12:48');
INSERT INTO `audit_logs` VALUES ('1505', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 14:12:48', '2026-03-05 14:12:48');
INSERT INTO `audit_logs` VALUES ('1506', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 14:12:48', '2026-03-05 14:12:48');
INSERT INTO `audit_logs` VALUES ('1507', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 14:12:49', '2026-03-05 14:12:49');
INSERT INTO `audit_logs` VALUES ('1508', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 14:12:49', '2026-03-05 14:12:49');
INSERT INTO `audit_logs` VALUES ('1509', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 14:12:49', '2026-03-05 14:12:49');
INSERT INTO `audit_logs` VALUES ('1510', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 14:12:50', '2026-03-05 14:12:50');
INSERT INTO `audit_logs` VALUES ('1511', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 14:12:50', '2026-03-05 14:12:50');
INSERT INTO `audit_logs` VALUES ('1512', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 14:12:50', '2026-03-05 14:12:50');
INSERT INTO `audit_logs` VALUES ('1513', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 14:12:51', '2026-03-05 14:12:51');
INSERT INTO `audit_logs` VALUES ('1514', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 14:13:41', '2026-03-05 14:13:41');
INSERT INTO `audit_logs` VALUES ('1515', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-05 14:13:42', '2026-03-05 14:13:42');
INSERT INTO `audit_logs` VALUES ('1516', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 14:13:42', '2026-03-05 14:13:42');
INSERT INTO `audit_logs` VALUES ('1517', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 14:13:42', '2026-03-05 14:13:42');
INSERT INTO `audit_logs` VALUES ('1518', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 14:13:43', '2026-03-05 14:13:43');
INSERT INTO `audit_logs` VALUES ('1519', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 14:13:43', '2026-03-05 14:13:43');
INSERT INTO `audit_logs` VALUES ('1520', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 14:13:43', '2026-03-05 14:13:43');
INSERT INTO `audit_logs` VALUES ('1521', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 14:13:44', '2026-03-05 14:13:44');
INSERT INTO `audit_logs` VALUES ('1522', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-05 14:13:44', '2026-03-05 14:13:44');
INSERT INTO `audit_logs` VALUES ('1523', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 14:13:44', '2026-03-05 14:13:44');
INSERT INTO `audit_logs` VALUES ('1524', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-05 14:13:45', '2026-03-05 14:13:45');
INSERT INTO `audit_logs` VALUES ('1525', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-05 14:13:45', '2026-03-05 14:13:45');
INSERT INTO `audit_logs` VALUES ('1526', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 14:13:45', '2026-03-05 14:13:45');
INSERT INTO `audit_logs` VALUES ('1527', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-05 14:13:45', '2026-03-05 14:13:45');
INSERT INTO `audit_logs` VALUES ('1528', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 14:14:07', '2026-03-05 14:14:07');
INSERT INTO `audit_logs` VALUES ('1529', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 14:14:07', '2026-03-05 14:14:07');
INSERT INTO `audit_logs` VALUES ('1530', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 14:14:08', '2026-03-05 14:14:08');
INSERT INTO `audit_logs` VALUES ('1531', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-05 14:14:08', '2026-03-05 14:14:08');
INSERT INTO `audit_logs` VALUES ('1532', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-05 14:14:08', '2026-03-05 14:14:08');
INSERT INTO `audit_logs` VALUES ('1533', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-05 14:14:09', '2026-03-05 14:14:09');
INSERT INTO `audit_logs` VALUES ('1534', '1', 'Josh Gracxiosa', 'Admin', 'Login', 'Authentication', 'User logged into the system', '127.0.0.1', 'success', '2026-03-06 08:18:21', '2026-03-06 08:18:21');
INSERT INTO `audit_logs` VALUES ('1535', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-06 08:18:24', '2026-03-06 08:18:24');
INSERT INTO `audit_logs` VALUES ('1536', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-06 08:18:25', '2026-03-06 08:18:25');
INSERT INTO `audit_logs` VALUES ('1537', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-06 08:18:25', '2026-03-06 08:18:25');
INSERT INTO `audit_logs` VALUES ('1538', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-06 08:18:26', '2026-03-06 08:18:26');
INSERT INTO `audit_logs` VALUES ('1539', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-06 08:18:27', '2026-03-06 08:18:27');
INSERT INTO `audit_logs` VALUES ('1540', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-06 08:18:27', '2026-03-06 08:18:27');
INSERT INTO `audit_logs` VALUES ('1541', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-06 08:18:27', '2026-03-06 08:18:27');
INSERT INTO `audit_logs` VALUES ('1542', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-06 08:18:28', '2026-03-06 08:18:28');
INSERT INTO `audit_logs` VALUES ('1543', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-06 08:18:30', '2026-03-06 08:18:30');
INSERT INTO `audit_logs` VALUES ('1544', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-06 08:18:30', '2026-03-06 08:18:30');
INSERT INTO `audit_logs` VALUES ('1545', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-06 08:18:31', '2026-03-06 08:18:31');
INSERT INTO `audit_logs` VALUES ('1546', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-06 08:18:32', '2026-03-06 08:18:32');
INSERT INTO `audit_logs` VALUES ('1547', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-06 08:18:32', '2026-03-06 08:18:32');
INSERT INTO `audit_logs` VALUES ('1548', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-06 08:18:33', '2026-03-06 08:18:33');
INSERT INTO `audit_logs` VALUES ('1549', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-06 08:18:33', '2026-03-06 08:18:33');
INSERT INTO `audit_logs` VALUES ('1550', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'Accessed Dashboard page', '127.0.0.1', 'success', '2026-03-06 08:18:33', '2026-03-06 08:18:33');
INSERT INTO `audit_logs` VALUES ('1551', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-06 08:18:35', '2026-03-06 08:18:35');
INSERT INTO `audit_logs` VALUES ('1552', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-06 08:18:36', '2026-03-06 08:18:36');
INSERT INTO `audit_logs` VALUES ('1553', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-06 08:18:48', '2026-03-06 08:18:48');
INSERT INTO `audit_logs` VALUES ('1554', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-06 08:18:48', '2026-03-06 08:18:48');
INSERT INTO `audit_logs` VALUES ('1555', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-06 08:18:49', '2026-03-06 08:18:49');
INSERT INTO `audit_logs` VALUES ('1556', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-06 08:18:50', '2026-03-06 08:18:50');
INSERT INTO `audit_logs` VALUES ('1557', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-06 08:18:50', '2026-03-06 08:18:50');
INSERT INTO `audit_logs` VALUES ('1558', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-06 08:18:51', '2026-03-06 08:18:51');
INSERT INTO `audit_logs` VALUES ('1559', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Analytics', 'View in Analytics', '127.0.0.1', 'success', '2026-03-06 08:18:51', '2026-03-06 08:18:51');
INSERT INTO `audit_logs` VALUES ('1560', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Routes Management', 'View in Routes Management', '127.0.0.1', 'success', '2026-03-06 08:18:51', '2026-03-06 08:18:51');
INSERT INTO `audit_logs` VALUES ('1561', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Reports Management', 'View in Reports Management', '127.0.0.1', 'success', '2026-03-06 08:18:52', '2026-03-06 08:18:52');
INSERT INTO `audit_logs` VALUES ('1562', '1', 'Josh Gracxiosa', 'Admin', 'View', 'User Management', 'View in User Management', '127.0.0.1', 'success', '2026-03-06 08:18:52', '2026-03-06 08:18:52');
INSERT INTO `audit_logs` VALUES ('1563', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-06 08:27:19', '2026-03-06 08:27:19');
INSERT INTO `audit_logs` VALUES ('1564', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-06 08:27:19', '2026-03-06 08:27:19');
INSERT INTO `audit_logs` VALUES ('1565', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-06 08:27:20', '2026-03-06 08:27:20');
INSERT INTO `audit_logs` VALUES ('1566', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Role Management', 'View in Role Management', '127.0.0.1', 'success', '2026-03-06 08:27:20', '2026-03-06 08:27:20');
INSERT INTO `audit_logs` VALUES ('1567', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-06 08:27:21', '2026-03-06 08:27:21');
INSERT INTO `audit_logs` VALUES ('1568', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Permission Management', 'View in Permission Management', '127.0.0.1', 'success', '2026-03-06 08:27:21', '2026-03-06 08:27:21');
INSERT INTO `audit_logs` VALUES ('1569', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Role Management', 'View in Role Management', '127.0.0.1', 'success', '2026-03-06 08:27:21', '2026-03-06 08:27:21');
INSERT INTO `audit_logs` VALUES ('1570', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Permission Management', 'View in Permission Management', '127.0.0.1', 'success', '2026-03-06 08:27:22', '2026-03-06 08:27:22');
INSERT INTO `audit_logs` VALUES ('1571', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Permission Management', 'View in Permission Management', '127.0.0.1', 'success', '2026-03-06 08:29:11', '2026-03-06 08:29:11');
INSERT INTO `audit_logs` VALUES ('1572', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Role Management', 'View in Role Management', '127.0.0.1', 'success', '2026-03-06 08:29:11', '2026-03-06 08:29:11');
INSERT INTO `audit_logs` VALUES ('1573', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Permission Management', 'View in Permission Management', '127.0.0.1', 'success', '2026-03-06 08:29:11', '2026-03-06 08:29:11');
INSERT INTO `audit_logs` VALUES ('1574', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Role Management', 'View in Role Management', '127.0.0.1', 'success', '2026-03-06 08:29:12', '2026-03-06 08:29:12');
INSERT INTO `audit_logs` VALUES ('1575', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Role Management', 'View in Role Management', '127.0.0.1', 'success', '2026-03-06 08:29:13', '2026-03-06 08:29:13');
INSERT INTO `audit_logs` VALUES ('1576', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Permission Management', 'View in Permission Management', '127.0.0.1', 'success', '2026-03-06 08:29:13', '2026-03-06 08:29:13');
INSERT INTO `audit_logs` VALUES ('1577', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Role Management', 'View in Role Management', '127.0.0.1', 'success', '2026-03-06 08:29:13', '2026-03-06 08:29:13');
INSERT INTO `audit_logs` VALUES ('1578', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Permission Management', 'View in Permission Management', '127.0.0.1', 'success', '2026-03-06 08:29:13', '2026-03-06 08:29:13');
INSERT INTO `audit_logs` VALUES ('1579', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-06 08:30:08', '2026-03-06 08:30:08');
INSERT INTO `audit_logs` VALUES ('1580', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-06 08:30:08', '2026-03-06 08:30:08');
INSERT INTO `audit_logs` VALUES ('1581', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-06 08:30:08', '2026-03-06 08:30:08');
INSERT INTO `audit_logs` VALUES ('1582', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Role Management', 'View in Role Management', '127.0.0.1', 'success', '2026-03-06 08:30:09', '2026-03-06 08:30:09');
INSERT INTO `audit_logs` VALUES ('1583', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Permission Management', 'View in Permission Management', '127.0.0.1', 'success', '2026-03-06 08:30:09', '2026-03-06 08:30:09');
INSERT INTO `audit_logs` VALUES ('1584', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-06 08:30:09', '2026-03-06 08:30:09');
INSERT INTO `audit_logs` VALUES ('1585', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Role Management', 'View in Role Management', '127.0.0.1', 'success', '2026-03-06 08:30:10', '2026-03-06 08:30:10');
INSERT INTO `audit_logs` VALUES ('1586', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Permission Management', 'View in Permission Management', '127.0.0.1', 'success', '2026-03-06 08:30:10', '2026-03-06 08:30:10');
INSERT INTO `audit_logs` VALUES ('1587', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-06 08:30:25', '2026-03-06 08:30:25');
INSERT INTO `audit_logs` VALUES ('1588', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-06 08:30:25', '2026-03-06 08:30:25');
INSERT INTO `audit_logs` VALUES ('1589', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-06 08:30:26', '2026-03-06 08:30:26');
INSERT INTO `audit_logs` VALUES ('1590', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Role Management', 'View in Role Management', '127.0.0.1', 'success', '2026-03-06 08:30:26', '2026-03-06 08:30:26');
INSERT INTO `audit_logs` VALUES ('1591', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Permission Management', 'View in Permission Management', '127.0.0.1', 'success', '2026-03-06 08:30:26', '2026-03-06 08:30:26');
INSERT INTO `audit_logs` VALUES ('1592', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-06 08:30:27', '2026-03-06 08:30:27');
INSERT INTO `audit_logs` VALUES ('1593', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Role Management', 'View in Role Management', '127.0.0.1', 'success', '2026-03-06 08:30:27', '2026-03-06 08:30:27');
INSERT INTO `audit_logs` VALUES ('1594', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Permission Management', 'View in Permission Management', '127.0.0.1', 'success', '2026-03-06 08:30:27', '2026-03-06 08:30:27');
INSERT INTO `audit_logs` VALUES ('1595', '1', 'Josh Gracxiosa', 'Admin', 'Create', 'Role Management', 'Create in Role Management', '127.0.0.1', 'success', '2026-03-06 08:31:00', '2026-03-06 08:31:00');
INSERT INTO `audit_logs` VALUES ('1596', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Role Management', 'View in Role Management', '127.0.0.1', 'success', '2026-03-06 08:31:00', '2026-03-06 08:31:00');
INSERT INTO `audit_logs` VALUES ('1597', '1', 'Josh Gracxiosa', 'Admin', 'Update', 'Role Management', 'Update in Role Management (ID: 3)', '127.0.0.1', 'success', '2026-03-06 08:31:14', '2026-03-06 08:31:14');
INSERT INTO `audit_logs` VALUES ('1598', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Role Management', 'View in Role Management', '127.0.0.1', 'success', '2026-03-06 08:31:14', '2026-03-06 08:31:14');
INSERT INTO `audit_logs` VALUES ('1599', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-06 08:31:21', '2026-03-06 08:31:21');
INSERT INTO `audit_logs` VALUES ('1600', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-06 08:31:21', '2026-03-06 08:31:21');
INSERT INTO `audit_logs` VALUES ('1601', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-06 08:31:21', '2026-03-06 08:31:21');
INSERT INTO `audit_logs` VALUES ('1602', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Role Management', 'View in Role Management', '127.0.0.1', 'success', '2026-03-06 08:31:22', '2026-03-06 08:31:22');
INSERT INTO `audit_logs` VALUES ('1603', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Permission Management', 'View in Permission Management', '127.0.0.1', 'success', '2026-03-06 08:31:22', '2026-03-06 08:31:22');
INSERT INTO `audit_logs` VALUES ('1604', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-06 08:31:22', '2026-03-06 08:31:22');
INSERT INTO `audit_logs` VALUES ('1605', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Role Management', 'View in Role Management', '127.0.0.1', 'success', '2026-03-06 08:31:23', '2026-03-06 08:31:23');
INSERT INTO `audit_logs` VALUES ('1606', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Permission Management', 'View in Permission Management', '127.0.0.1', 'success', '2026-03-06 08:31:23', '2026-03-06 08:31:23');
INSERT INTO `audit_logs` VALUES ('1607', '1', 'Josh Gracxiosa', 'Admin', 'Update', 'Role Management', 'Update in Role Management (ID: 3)', '127.0.0.1', 'success', '2026-03-06 08:31:28', '2026-03-06 08:31:28');
INSERT INTO `audit_logs` VALUES ('1608', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Role Management', 'View in Role Management', '127.0.0.1', 'success', '2026-03-06 08:31:28', '2026-03-06 08:31:28');
INSERT INTO `audit_logs` VALUES ('1609', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Permission Management', 'View in Permission Management', '127.0.0.1', 'success', '2026-03-06 08:31:31', '2026-03-06 08:31:31');
INSERT INTO `audit_logs` VALUES ('1610', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Role Management', 'View in Role Management', '127.0.0.1', 'success', '2026-03-06 08:31:32', '2026-03-06 08:31:32');
INSERT INTO `audit_logs` VALUES ('1611', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Permission Management', 'View in Permission Management', '127.0.0.1', 'success', '2026-03-06 08:31:32', '2026-03-06 08:31:32');
INSERT INTO `audit_logs` VALUES ('1612', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Role Management', 'View in Role Management', '127.0.0.1', 'success', '2026-03-06 08:31:32', '2026-03-06 08:31:32');
INSERT INTO `audit_logs` VALUES ('1613', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-06 08:34:28', '2026-03-06 08:34:28');
INSERT INTO `audit_logs` VALUES ('1614', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-06 08:34:29', '2026-03-06 08:34:29');
INSERT INTO `audit_logs` VALUES ('1615', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-06 08:34:31', '2026-03-06 08:34:31');
INSERT INTO `audit_logs` VALUES ('1616', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Permission Management', 'View in Permission Management', '127.0.0.1', 'success', '2026-03-06 08:34:32', '2026-03-06 08:34:32');
INSERT INTO `audit_logs` VALUES ('1617', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Role Management', 'View in Role Management', '127.0.0.1', 'success', '2026-03-06 08:34:32', '2026-03-06 08:34:32');
INSERT INTO `audit_logs` VALUES ('1618', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-06 08:34:33', '2026-03-06 08:34:33');
INSERT INTO `audit_logs` VALUES ('1619', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Permission Management', 'View in Permission Management', '127.0.0.1', 'success', '2026-03-06 08:34:34', '2026-03-06 08:34:34');
INSERT INTO `audit_logs` VALUES ('1620', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Role Management', 'View in Role Management', '127.0.0.1', 'success', '2026-03-06 08:34:35', '2026-03-06 08:34:35');
INSERT INTO `audit_logs` VALUES ('1621', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-06 08:40:18', '2026-03-06 08:40:18');
INSERT INTO `audit_logs` VALUES ('1622', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-06 08:40:18', '2026-03-06 08:40:18');
INSERT INTO `audit_logs` VALUES ('1623', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-06 08:40:19', '2026-03-06 08:40:19');
INSERT INTO `audit_logs` VALUES ('1624', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Permission Management', 'View in Permission Management', '127.0.0.1', 'success', '2026-03-06 08:40:19', '2026-03-06 08:40:19');
INSERT INTO `audit_logs` VALUES ('1625', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Role Management', 'View in Role Management', '127.0.0.1', 'success', '2026-03-06 08:40:19', '2026-03-06 08:40:19');
INSERT INTO `audit_logs` VALUES ('1626', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-06 08:40:20', '2026-03-06 08:40:20');
INSERT INTO `audit_logs` VALUES ('1627', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Permission Management', 'View in Permission Management', '127.0.0.1', 'success', '2026-03-06 08:40:20', '2026-03-06 08:40:20');
INSERT INTO `audit_logs` VALUES ('1628', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Role Management', 'View in Role Management', '127.0.0.1', 'success', '2026-03-06 08:40:21', '2026-03-06 08:40:21');
INSERT INTO `audit_logs` VALUES ('1629', '1', 'Josh Gracxiosa', 'Admin', 'Create', 'Permission Management', 'Create in Permission Management', '127.0.0.1', 'success', '2026-03-06 08:41:06', '2026-03-06 08:41:06');
INSERT INTO `audit_logs` VALUES ('1630', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Permission Management', 'View in Permission Management', '127.0.0.1', 'success', '2026-03-06 08:41:06', '2026-03-06 08:41:06');
INSERT INTO `audit_logs` VALUES ('1631', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-06 08:46:19', '2026-03-06 08:46:19');
INSERT INTO `audit_logs` VALUES ('1632', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-06 08:46:19', '2026-03-06 08:46:19');
INSERT INTO `audit_logs` VALUES ('1633', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-06 08:46:58', '2026-03-06 08:46:58');
INSERT INTO `audit_logs` VALUES ('1634', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-06 08:46:58', '2026-03-06 08:46:58');
INSERT INTO `audit_logs` VALUES ('1635', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-06 08:47:10', '2026-03-06 08:47:10');
INSERT INTO `audit_logs` VALUES ('1636', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-06 08:47:11', '2026-03-06 08:47:11');
INSERT INTO `audit_logs` VALUES ('1637', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-06 08:47:11', '2026-03-06 08:47:11');
INSERT INTO `audit_logs` VALUES ('1638', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-06 08:47:12', '2026-03-06 08:47:12');
INSERT INTO `audit_logs` VALUES ('1639', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-06 08:47:13', '2026-03-06 08:47:13');
INSERT INTO `audit_logs` VALUES ('1640', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-06 08:47:14', '2026-03-06 08:47:14');
INSERT INTO `audit_logs` VALUES ('1641', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-06 08:48:32', '2026-03-06 08:48:32');
INSERT INTO `audit_logs` VALUES ('1642', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Authentication', 'View in Authentication', '127.0.0.1', 'success', '2026-03-06 08:48:32', '2026-03-06 08:48:32');
INSERT INTO `audit_logs` VALUES ('1643', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-06 08:48:32', '2026-03-06 08:48:32');
INSERT INTO `audit_logs` VALUES ('1644', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-06 08:48:33', '2026-03-06 08:48:33');
INSERT INTO `audit_logs` VALUES ('1645', '1', 'Josh Gracxiosa', 'Admin', 'View', 'Notifications', 'View in Notifications', '127.0.0.1', 'success', '2026-03-06 08:48:33', '2026-03-06 08:48:33');
INSERT INTO `audit_logs` VALUES ('1646', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-06 08:48:34', '2026-03-06 08:48:34');
INSERT INTO `audit_logs` VALUES ('1647', '1', 'Josh Gracxiosa', 'Admin', 'Update', 'System Settings', 'Changed site maintenance mode to ON', '127.0.0.1', 'success', '2026-03-06 08:48:35', '2026-03-06 08:48:35');
INSERT INTO `audit_logs` VALUES ('1648', '1', 'Josh Gracxiosa', 'Admin', 'Create', 'System Settings', 'Changed system maintenance mode', '127.0.0.1', 'success', '2026-03-06 08:48:35', '2026-03-06 08:48:35');
INSERT INTO `audit_logs` VALUES ('1649', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-06 08:48:36', '2026-03-06 08:48:36');
INSERT INTO `audit_logs` VALUES ('1650', '1', 'Josh Gracxiosa', 'Admin', 'Update', 'System Settings', 'Changed site maintenance mode to OFF', '127.0.0.1', 'success', '2026-03-06 08:48:43', '2026-03-06 08:48:43');
INSERT INTO `audit_logs` VALUES ('1651', '1', 'Josh Gracxiosa', 'Admin', 'Create', 'System Settings', 'Changed system maintenance mode', '127.0.0.1', 'success', '2026-03-06 08:48:43', '2026-03-06 08:48:43');
INSERT INTO `audit_logs` VALUES ('1652', '1', 'Josh Gracxiosa', 'Admin', 'View', 'System Settings', 'View in System Settings', '127.0.0.1', 'success', '2026-03-06 08:48:43', '2026-03-06 08:48:43');
INSERT INTO `audit_logs` VALUES ('1653', '1', 'Josh Gracxiosa', 'Admin', 'Backup', 'System Settings', 'Created database backup', '127.0.0.1', 'success', '2026-03-06 08:48:54', '2026-03-06 08:48:54');


-- Table: business_owners
DROP TABLE IF EXISTS `business_owners`;
CREATE TABLE `business_owners` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `business_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `business_permit` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `street` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `valid_id_document` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `business_owners_user_id_foreign` (`user_id`),
  CONSTRAINT `business_owners_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `business_owners` VALUES ('1', '5', 'Tinglasang Lutong Bahay', 'https://placehold.co/800x600/fff3e0/f57c00?text=Business+Permit+-+Tinglasang+Lutong+Bahay', NULL, 'https://placehold.co/600x400/e3f2fd/1976d2?text=Valid+ID+-+Jonathan+Buslon', '2025-09-01 11:15:00', '2025-09-01 11:15:00');
INSERT INTO `business_owners` VALUES ('2', '7', 'Shoppers Mart', 'https://placehold.co/800x600/fff3e0/f57c00?text=Business+Permit+-+Shoppers+Mart', 'Main Street', 'https://placehold.co/600x400/e3f2fd/1976d2?text=Valid+ID+-+Pedro+Reyes', '2025-08-15 10:30:00', '2025-08-15 10:30:00');
INSERT INTO `business_owners` VALUES ('3', '9', 'YL Carenderia', 'https://placehold.co/800x600/fff3e0/f57c00?text=Business+Permit+-+YL+Carenderia', 'Toril Avenue', 'https://placehold.co/600x400/e3f2fd/1976d2?text=Valid+ID+-+Carlos+Mendoza', '2025-07-05 09:00:00', '2025-07-05 09:00:00');


-- Table: cache
DROP TABLE IF EXISTS `cache`;
CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `cache` VALUES ('purecycle-cache-4UeSgjF5BRpgRTzf', 's:7:\"forever\";', '2088058710');
INSERT INTO `cache` VALUES ('purecycle-cache-akEJzKT5yxgFDW15', 's:7:\"forever\";', '2088060995');
INSERT INTO `cache` VALUES ('purecycle-cache-jHHQymq3KkCKDBJJ', 's:7:\"forever\";', '2088056782');
INSERT INTO `cache` VALUES ('purecycle-cache-LQkAuLs5C5CggJoX', 's:7:\"forever\";', '2088060980');
INSERT INTO `cache` VALUES ('purecycle-cache-PYqhNC7n7MnrFC5x', 's:7:\"forever\";', '2088061016');
INSERT INTO `cache` VALUES ('purecycle-cache-RhHqmFxtBCxUEYrE', 's:7:\"forever\";', '2088060968');
INSERT INTO `cache` VALUES ('purecycle-cache-RKN4B5t48UVZyEI3', 's:7:\"forever\";', '2088060815');


-- Table: cache_locks
DROP TABLE IF EXISTS `cache_locks`;
CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_locks_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



-- Table: failed_jobs
DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



-- Table: job_batches
DROP TABLE IF EXISTS `job_batches`;
CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



-- Table: jobs
DROP TABLE IF EXISTS `jobs`;
CREATE TABLE `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



-- Table: migrations
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `migrations` VALUES ('1', '0001_01_01_000000_create_users_table', '1');
INSERT INTO `migrations` VALUES ('2', '0001_01_01_000001_create_cache_table', '1');
INSERT INTO `migrations` VALUES ('3', '0001_01_01_000002_create_jobs_table', '1');
INSERT INTO `migrations` VALUES ('4', '2026_03_04_151606_create_roles_table', '1');
INSERT INTO `migrations` VALUES ('5', '2026_03_04_151607_create_business_owners_table', '1');
INSERT INTO `migrations` VALUES ('6', '2026_03_04_151608_create_permissions_table', '1');
INSERT INTO `migrations` VALUES ('7', '2026_03_04_151609_create_role_permission_table', '1');
INSERT INTO `migrations` VALUES ('8', '2026_03_04_151610_create_purok_leaders_table', '1');
INSERT INTO `migrations` VALUES ('9', '2026_03_05_113603_create_reports_table', '1');
INSERT INTO `migrations` VALUES ('10', '2026_03_05_121344_add_updated_by_and_remark_to_reports_table', '1');
INSERT INTO `migrations` VALUES ('11', '2026_03_05_122014_create_announcements_table', '1');
INSERT INTO `migrations` VALUES ('12', '2026_03_05_123535_create_routes_table', '1');
INSERT INTO `migrations` VALUES ('13', '2026_03_05_124501_create_schedules_table', '1');
INSERT INTO `migrations` VALUES ('14', '2026_03_05_130000_create_audit_logs_table', '1');
INSERT INTO `migrations` VALUES ('15', '2026_03_05_130001_create_system_settings_table', '1');
INSERT INTO `migrations` VALUES ('16', '2026_03_05_132818_create_notifications_table', '1');


-- Table: notifications
DROP TABLE IF EXISTS `notifications`;
CREATE TABLE `notifications` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `triggered_by_id` bigint unsigned DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `type` enum('report','account','announcement','schedule','system','analytics','route') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'system',
  `priority` enum('low','medium','high') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'medium',
  `unread` tinyint(1) NOT NULL DEFAULT '1',
  `action_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sender_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sender_role` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sender_avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `metadata` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_triggered_by_id_foreign` (`triggered_by_id`),
  KEY `notifications_user_id_unread_index` (`user_id`,`unread`),
  KEY `notifications_user_id_type_index` (`user_id`,`type`),
  KEY `notifications_created_at_index` (`created_at`),
  CONSTRAINT `notifications_triggered_by_id_foreign` FOREIGN KEY (`triggered_by_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `notifications_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `notifications` VALUES ('1', '1', '4', 'New Report Submitted', 'Juan Dela Cruz submitted a missed pickup report for Barangay Taloto', 'Report ID: #RPT-001. Status: Pending Review. The resident reported that waste collection was missed on their scheduled pickup day.', 'report', 'high', '0', '/reports', 'Juan Dela Cruz', 'Purok leader', 'JD', '{\"report_id\": 1}', '2026-03-05 07:01:54', '2026-03-05 07:09:46', NULL);
INSERT INTO `notifications` VALUES ('2', '1', '1', 'Account Approved', 'Jonathan G. Buslon account has been approved', 'Business Owner account for Jonathan G. Buslon has been successfully verified and approved.', 'account', 'medium', '0', '/users', 'Josh Gracxiosa', 'Admin', 'JG', NULL, '2026-03-05 06:03:54', '2026-03-05 07:09:22', NULL);
INSERT INTO `notifications` VALUES ('3', '1', '2', 'Announcement Posted', 'Waste Collection Delay announcement was posted', 'A new announcement titled \"Waste Collection Delay\" has been published.', 'announcement', 'medium', '0', '/announcements', 'Everly Santos', 'Staff', 'ES', NULL, '2026-03-05 04:03:54', '2026-03-05 07:03:54', NULL);
INSERT INTO `notifications` VALUES ('4', '1', '2', 'Schedule Updated', 'Collection schedule for Zone A has been modified', 'The waste collection schedule for Zone A has been updated.', 'schedule', 'high', '0', '/schedules', 'Everly Santos', 'Staff', 'ES', NULL, '2026-03-05 02:03:54', '2026-03-05 07:03:54', NULL);
INSERT INTO `notifications` VALUES ('5', '1', '6', 'New User Registration', 'Maria Santos registered as Purok Leader', 'A new Purok Leader registration requires verification.', 'account', 'medium', '0', '/users', 'Maria Santos', 'Purok leader', 'MS', NULL, '2026-03-04 07:03:54', '2026-03-05 07:03:54', NULL);
INSERT INTO `notifications` VALUES ('6', '2', '4', 'Report Resolved', 'Missed pickup report #RPT-001 has been resolved', 'The missed pickup report has been marked as resolved.', 'report', 'low', '0', '/reports', 'Juan Dela Cruz', 'Purok leader', 'JD', NULL, '2026-03-03 07:03:54', '2026-03-05 07:03:54', NULL);
INSERT INTO `notifications` VALUES ('7', '2', '1', 'System Maintenance Notice', 'Scheduled system maintenance on March 10, 2026', 'The system will undergo scheduled maintenance.', 'system', 'medium', '0', NULL, 'Josh Gracxiosa', 'Admin', 'JG', NULL, '2026-03-02 07:03:54', '2026-03-05 07:03:54', NULL);
INSERT INTO `notifications` VALUES ('8', '2', NULL, 'Analytics Report Generated', 'Monthly waste collection analytics for February 2026 is ready', 'The comprehensive analytics report has been generated.', 'analytics', 'low', '0', '/analytics', 'Analytics System', 'System', 'AS', NULL, '2026-03-01 07:03:54', '2026-03-05 07:03:54', NULL);


-- Table: password_reset_tokens
DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



-- Table: permissions
DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `module` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `status` enum('active','inactive','maintenance','unavailable','bug') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=136 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `permissions` VALUES ('1', 'View Dashboard', 'view_dashboard', 'Dashboard', 'Can access main dashboard page', 'active', 'dashboard', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('2', 'View Total Users Widget', 'view_total_users_widget', 'Dashboard', 'Can view Total Users statistics widget', 'active', 'eye', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('3', 'View Total Reports Widget', 'view_total_reports_widget', 'Dashboard', 'Can view Total Reports statistics widget', 'active', 'eye', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('4', 'View Announcements Widget', 'view_announcements_widget', 'Dashboard', 'Can view Announcements statistics widget', 'active', 'eye', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('5', 'View Pending Approvals Widget', 'view_pending_approvals_widget', 'Dashboard', 'Can view Pending Approvals statistics widget', 'active', 'eye', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('6', 'View Waste Watch Chart', 'view_waste_watch_chart', 'Dashboard', 'Can view Waste Watch Report Ranking chart', 'active', 'chart', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('7', 'Filter Waste Watch Chart', 'filter_waste_watch_chart', 'Dashboard', 'Can filter Waste Watch chart by time (Today, This Week, This Month)', 'active', 'chart', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('8', 'View Recent Activity', 'view_recent_activity', 'Dashboard', 'Can view Recent Activity section', 'active', 'eye', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('9', 'View Quick Actions', 'view_quick_actions', 'Dashboard', 'Can view Quick Actions section', 'active', 'eye', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('10', 'Use Quick Action - Approve Users', 'use_quick_action_approve_users', 'Dashboard', 'Can use \'Approve Users\' quick action button', 'active', 'check', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('11', 'Use Quick Action - Create Announcement', 'use_quick_action_create_announcement', 'Dashboard', 'Can use \'Create Announcement\' quick action button', 'active', 'plus', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('12', 'Use Quick Action - View Analytics', 'use_quick_action_view_analytics', 'Dashboard', 'Can use \'View Analytics\' quick action button', 'active', 'chart', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('13', 'View User Management Module', 'view_user_management_module', 'User Management', 'Can access the User Management page', 'active', 'users', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('14', 'View Users List', 'view_users_list', 'User Management', 'Can view the users list/table', 'active', 'eye', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('15', 'Search Users', 'search_users', 'User Management', 'Can search and filter users', 'active', 'eye', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('16', 'View User Details', 'view_user_details', 'User Management', 'Can view detailed user information in modal', 'active', 'eye', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('17', 'View User Documents', 'view_user_documents', 'User Management', 'Can view uploaded user documents', 'active', 'document', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('18', 'Add New User', 'add_new_user', 'User Management', 'Can create new Admin/Staff user accounts', 'active', 'plus', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('19', 'Edit User', 'edit_user', 'User Management', 'Can edit user information (Admin/Staff only)', 'active', 'pencil', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('20', 'Delete User', 'delete_user', 'User Management', 'Can delete user accounts', 'active', 'trash', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('21', 'Approve User', 'approve_user', 'User Management', 'Can approve pending user registrations', 'active', 'check', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('22', 'Reject User', 'reject_user', 'User Management', 'Can reject pending user registrations', 'active', 'trash', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('23', 'Reset User Password', 'reset_user_password', 'User Management', 'Can reset user passwords', 'active', 'lock', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('24', 'Generate Temporary Password', 'generate_temporary_password', 'User Management', 'Can generate temporary passwords for users', 'active', 'cog', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('25', 'Export Users', 'export_users', 'User Management', 'Can export user data to CSV/Excel', 'active', 'download', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('26', 'View Reports Management Module', 'view_reports_management_module', 'Reports Management', 'Can access the Reports Management page', 'active', 'document', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('27', 'View Reports List', 'view_reports_list', 'Reports Management', 'Can view the reports list/table', 'active', 'eye', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('28', 'Search Reports', 'search_reports', 'Reports Management', 'Can search and filter reports', 'active', 'eye', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('29', 'View Report Details', 'view_report_details', 'Reports Management', 'Can view detailed report information in modal', 'active', 'eye', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('30', 'View Reporter Information', 'view_reporter_information', 'Reports Management', 'Can view reporter details (name, role, location)', 'active', 'user', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('31', 'View Evidence Photo', 'view_evidence_photo', 'Reports Management', 'Can view uploaded evidence photos', 'active', 'eye', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('32', 'View Staff Remarks', 'view_staff_remarks', 'Reports Management', 'Can read staff remarks and notes on reports', 'active', 'document', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('33', 'Start Report Processing', 'start_report_processing', 'Reports Management', 'Can change report status from Pending to In Progress', 'active', 'check', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('34', 'Resolve Report', 'resolve_report', 'Reports Management', 'Can mark reports as Resolved', 'active', 'check', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('35', 'Reject Report', 'reject_report', 'Reports Management', 'Can reject reports', 'active', 'trash', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('36', 'Add Staff Remarks', 'add_staff_remarks', 'Reports Management', 'Can add staff remarks/notes to reports', 'active', 'pencil', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('37', 'Filter Reports by Status', 'filter_reports_by_status', 'Reports Management', 'Can filter reports by status (Pending, In Progress, Resolved, Rejected)', 'active', 'eye', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('38', 'Filter Reports by Priority', 'filter_reports_by_priority', 'Reports Management', 'Can filter reports by priority level', 'active', 'eye', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('39', 'Export Reports', 'export_reports', 'Reports Management', 'Can export reports to PDF/Excel', 'active', 'download', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('40', 'View Announcements Module', 'view_announcements_module', 'Announcements', 'Can access the Announcements page', 'active', 'megaphone', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('41', 'View Announcements List', 'view_announcements_list', 'Announcements', 'Can view the announcements list/table', 'active', 'eye', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('42', 'Search Announcements', 'search_announcements', 'Announcements', 'Can search and filter announcements', 'active', 'eye', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('43', 'View Announcement Details', 'view_announcement_details', 'Announcements', 'Can view detailed announcement information in modal', 'active', 'eye', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('44', 'View Announcement Attachments', 'view_announcement_attachments', 'Announcements', 'Can view attached files in announcements', 'active', 'document', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('45', 'Create Announcement', 'create_announcement', 'Announcements', 'Can create new announcements', 'active', 'plus', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('46', 'Edit Announcement', 'edit_announcement', 'Announcements', 'Can edit existing announcements', 'active', 'pencil', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('47', 'Delete Announcement', 'delete_announcement', 'Announcements', 'Can delete announcements', 'active', 'trash', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('48', 'Set Announcement Priority', 'set_announcement_priority', 'Announcements', 'Can set priority level (Low, Moderate, Urgent)', 'active', 'check', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('49', 'Set Announcement Schedule', 'set_announcement_schedule', 'Announcements', 'Can set start date and end date for announcements', 'active', 'calendar', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('50', 'Filter Announcements by Status', 'filter_announcements_by_status', 'Announcements', 'Can filter announcements by Active/Inactive status', 'active', 'eye', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('51', 'Filter Announcements by Priority', 'filter_announcements_by_priority', 'Announcements', 'Can filter announcements by priority level', 'active', 'eye', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('52', 'View Routes Management Module', 'view_routes_module', 'Routes Management', 'Can access the Routes Management page for garbage collection routes', 'active', 'map', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('53', 'View Routes List', 'view_routes_list', 'Routes Management', 'Can view the routes list/table', 'active', 'eye', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('54', 'Search Routes', 'search_routes', 'Routes Management', 'Can search and filter routes by name, municipality, status', 'active', 'search', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('55', 'View Route Details', 'view_route_details', 'Routes Management', 'Can view detailed route information and statistics', 'active', 'eye', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('56', 'View Route on Map', 'view_route_on_map', 'Routes Management', 'Can view route visualization on interactive map', 'active', 'map', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('57', 'View Route Waypoints', 'view_route_waypoints', 'Routes Management', 'Can view waypoints (start, pickup points, end) of a route', 'active', 'eye', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('58', 'Create Route', 'create_route', 'Routes Management', 'Can create new garbage collection routes with waypoints', 'active', 'plus', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('59', 'Add Waypoint to Route', 'add_waypoint_to_route', 'Routes Management', 'Can add pickup points/waypoints to a route', 'active', 'plus', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('60', 'Edit Route', 'edit_route', 'Routes Management', 'Can edit route details (name, description, waypoints)', 'active', 'pencil', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('61', 'Delete Route', 'delete_route', 'Routes Management', 'Can delete routes permanently', 'active', 'trash', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('62', 'Change Route Status', 'change_route_status', 'Routes Management', 'Can activate or deactivate routes', 'active', 'toggle', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('63', 'View Route Statistics', 'view_route_statistics', 'Routes Management', 'Can view route distance, duration, and performance metrics', 'active', 'chart', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('64', 'Export Routes Data', 'export_routes_data', 'Routes Management', 'Can export routes data to file', 'active', 'download', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('65', 'Switch Map Style', 'switch_map_style', 'Routes Management', 'Can switch between different map styles (Standard, Satellite, Topo)', 'active', 'map', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('66', 'View Schedules Module', 'view_schedules_module', 'Schedules', 'Can access the Collection Schedules page', 'active', 'calendar', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('67', 'View Weekly Overview', 'view_weekly_overview', 'Schedules', 'Can view weekly schedule overview', 'active', 'eye', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('68', 'View Calendar View', 'view_calendar_view', 'Schedules', 'Can view schedules in calendar/monthly view', 'active', 'calendar', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('69', 'Switch View Mode', 'switch_view_mode', 'Schedules', 'Can toggle between List and Calendar view modes', 'active', 'eye', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('70', 'View Schedule Details', 'view_schedule_details', 'Schedules', 'Can view detailed schedule information in modal', 'active', 'eye', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('71', 'Bulk Create Schedules', 'bulk_create_schedules', 'Schedules', 'Can create multiple schedules (specific dates, week, month)', 'active', 'plus', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('72', 'Edit Schedule', 'edit_schedule', 'Schedules', 'Can edit existing schedules (route, date, time)', 'active', 'pencil', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('73', 'Cancel Schedule', 'cancel_schedule', 'Schedules', 'Can cancel schedules with reason', 'active', 'trash', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('74', 'Reactivate Schedule', 'reactivate_schedule', 'Schedules', 'Can reactivate cancelled or completed schedules', 'active', 'check', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('75', 'Mark Schedule as Completed', 'mark_schedule_completed', 'Schedules', 'Can mark schedules as completed', 'active', 'check', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('76', 'Filter Schedules by Day', 'filter_schedules_by_day', 'Schedules', 'Can filter schedules by day of the week', 'active', 'eye', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('77', 'View Analytics Module', 'view_analytics_module', 'Analytics', 'Can access the Analytics Dashboard page', 'active', 'chart', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('78', 'View Statistics Cards', 'view_statistics_cards', 'Analytics', 'Can view main statistics cards (Users, Reports, Announcements, Routes)', 'active', 'eye', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('79', 'View Most Active Reporters Chart', 'view_active_reporters_chart', 'Analytics', 'Can view Most Active Reporters pie chart', 'active', 'chart', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('80', 'View Infographics Reports Chart', 'view_infographics_chart', 'Analytics', 'Can view monthly report trends line chart', 'active', 'chart', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('81', 'View Quick Stats', 'view_quick_stats', 'Analytics', 'Can view quick statistics (Approval Rate, Response Time, Resolution, Active Users)', 'active', 'eye', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('82', 'Export Analytics Report', 'export_analytics_report', 'Analytics', 'Can export analytics data to file', 'active', 'download', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('83', 'Configure Analytics Settings', 'configure_analytics_settings', 'Analytics', 'Can access analytics settings and configuration', 'active', 'cog', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('84', 'View Roles Management Module', 'view_roles_management_module', 'Access Control', 'Can access the Roles Management page', 'active', 'shield', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('85', 'View Roles List', 'view_roles_list', 'Access Control', 'Can view the roles list/table', 'active', 'eye', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('86', 'Search Roles', 'search_roles', 'Access Control', 'Can search and filter roles', 'active', 'eye', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('87', 'View Role Details', 'view_role_details', 'Access Control', 'Can view detailed role information in modal', 'active', 'eye', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('88', 'View Role Permissions', 'view_role_permissions', 'Access Control', 'Can view permissions assigned to a role', 'active', 'shield', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('89', 'Create Role', 'create_role', 'Access Control', 'Can create new roles', 'active', 'plus', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('90', 'Edit Role', 'edit_role', 'Access Control', 'Can edit role name and description', 'active', 'pencil', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('91', 'Delete Role', 'delete_role', 'Access Control', 'Can delete non-system roles', 'active', 'trash', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('92', 'Manage Role Permissions', 'manage_role_permissions', 'Access Control', 'Can assign/remove permissions to/from roles', 'active', 'shield', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('93', 'View Permissions Management Module', 'view_permissions_management_module', 'Access Control', 'Can access the Permissions Management page', 'active', 'shield', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('94', 'View Permissions by Module', 'view_permissions_by_module', 'Access Control', 'Can view permissions grouped by module (card grid)', 'active', 'eye', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('95', 'View All Permissions Table', 'view_all_permissions_table', 'Access Control', 'Can view all permissions in table view', 'active', 'eye', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('96', 'Search Permissions', 'search_permissions', 'Access Control', 'Can search and filter permissions', 'active', 'eye', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('97', 'View Permission Details', 'view_permission_details', 'Access Control', 'Can view detailed permission information', 'active', 'eye', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('98', 'Create Permission', 'create_permission', 'Access Control', 'Can create new permissions', 'active', 'plus', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('99', 'Edit Permission', 'edit_permission', 'Access Control', 'Can edit permission details', 'active', 'pencil', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('100', 'Delete Permission', 'delete_permission', 'Access Control', 'Can delete permissions', 'active', 'trash', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('101', 'Change Permission Status', 'change_permission_status', 'Access Control', 'Can change permission status (active, maintenance, unavailable, bug)', 'active', 'cog', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('102', 'Assign Permission Icon', 'assign_permission_icon', 'Access Control', 'Can assign visual icons to permissions', 'active', 'cog', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('103', 'View Profile', 'view_profile', 'Profile', 'Can view own profile', 'active', 'eye', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('104', 'Edit Profile', 'edit_profile', 'Profile', 'Can edit own profile', 'active', 'pencil', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('105', 'Change Password', 'change_password', 'Profile', 'Can change own password', 'active', 'lock', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('106', 'View Notifications Module', 'view_notifications_module', 'Notifications', 'Can access the Notifications page', 'active', 'bell', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('107', 'View Notifications List', 'view_notifications_list', 'Notifications', 'Can view all notifications', 'active', 'eye', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('108', 'Search Notifications', 'search_notifications', 'Notifications', 'Can search notifications', 'active', 'eye', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('109', 'Filter Notifications by Status', 'filter_notifications_by_status', 'Notifications', 'Can filter by All/Unread/Read status', 'active', 'eye', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('110', 'Filter Notifications by Type', 'filter_notifications_by_type', 'Notifications', 'Can filter by type (Report, Account, Announcement, Schedule, System)', 'active', 'eye', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('111', 'View Notification Details', 'view_notification_details', 'Notifications', 'Can view full notification details', 'active', 'eye', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('112', 'Mark Notification as Read', 'mark_notification_read', 'Notifications', 'Can mark individual notification as read', 'active', 'check', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('113', 'Mark Notification as Unread', 'mark_notification_unread', 'Notifications', 'Can mark notification as unread', 'active', 'check', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('114', 'Mark All Notifications as Read', 'mark_all_notifications_read', 'Notifications', 'Can mark all notifications as read at once', 'active', 'check', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('115', 'Delete Notification', 'delete_notification', 'Notifications', 'Can delete individual notifications', 'active', 'trash', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('116', 'Configure Notification Settings', 'configure_notification_settings', 'Notifications', 'Can access notification settings and configuration', 'active', 'cog', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('117', 'Enable/Disable Notifications by Type', 'enable_disable_notifications_by_type', 'Notifications', 'Can enable/disable specific notification types', 'active', 'cog', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('118', 'Set Notification Recipients by Role', 'set_notification_recipients_by_role', 'Notifications', 'Can configure which roles receive specific notifications', 'active', 'users', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('119', 'View System Settings Module', 'view_system_settings_module', 'System Settings', 'Can access the System Settings page', 'active', 'cog', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('120', 'View General Settings Tab', 'view_general_settings_tab', 'System Settings', 'Can view general settings (site name, email, phone, etc.)', 'active', 'eye', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('121', 'Edit General Settings', 'edit_general_settings', 'System Settings', 'Can edit site name, tagline, email, phone, address, timezone, date/time format', 'active', 'pencil', '2026-03-05 07:03:51', '2026-03-05 07:03:51');
INSERT INTO `permissions` VALUES ('122', 'View Maintenance Tab', 'view_maintenance_tab', 'System Settings', 'Can view site maintenance settings', 'active', 'eye', '2026-03-05 07:03:52', '2026-03-05 07:03:52');
INSERT INTO `permissions` VALUES ('123', 'Enable/Disable Maintenance Mode', 'enable_disable_maintenance_mode', 'System Settings', 'Can toggle system-wide maintenance mode ON/OFF', 'active', 'cog', '2026-03-05 07:03:52', '2026-03-05 07:03:52');
INSERT INTO `permissions` VALUES ('124', 'Edit Maintenance Message', 'edit_maintenance_message', 'System Settings', 'Can edit the maintenance mode message shown to users', 'active', 'pencil', '2026-03-05 07:03:52', '2026-03-05 07:03:52');
INSERT INTO `permissions` VALUES ('125', 'View Database Tab', 'view_database_tab', 'System Settings', 'Can view database management settings', 'active', 'eye', '2026-03-05 07:03:52', '2026-03-05 07:03:52');
INSERT INTO `permissions` VALUES ('126', 'Export Database', 'export_database', 'System Settings', 'Can export database backup', 'active', 'download', '2026-03-05 07:03:52', '2026-03-05 07:03:52');
INSERT INTO `permissions` VALUES ('127', 'Import Database', 'import_database', 'System Settings', 'Can import database from file', 'active', 'download', '2026-03-05 07:03:52', '2026-03-05 07:03:52');
INSERT INTO `permissions` VALUES ('128', 'Configure Auto Backup', 'configure_auto_backup', 'System Settings', 'Can enable/disable auto backup and set frequency/retention', 'active', 'cog', '2026-03-05 07:03:52', '2026-03-05 07:03:52');
INSERT INTO `permissions` VALUES ('129', 'View Security Tab', 'view_security_tab', 'System Settings', 'Can view security and authentication settings', 'active', 'eye', '2026-03-05 07:03:52', '2026-03-05 07:03:52');
INSERT INTO `permissions` VALUES ('130', 'Configure Session Settings', 'configure_session_settings', 'System Settings', 'Can configure session timeout and max login attempts', 'active', 'lock', '2026-03-05 07:03:52', '2026-03-05 07:03:52');
INSERT INTO `permissions` VALUES ('131', 'Configure Password Policy', 'configure_password_policy', 'System Settings', 'Can set password requirements (length, uppercase, numbers, special chars, 2FA)', 'active', 'lock', '2026-03-05 07:03:52', '2026-03-05 07:03:52');
INSERT INTO `permissions` VALUES ('132', 'View Audit Trail Tab', 'view_audit_trail_tab', 'System Settings', 'Can view audit trail/activity logs', 'active', 'document', '2026-03-05 07:03:52', '2026-03-05 07:03:52');
INSERT INTO `permissions` VALUES ('133', 'View Audit Logs', 'view_audit_logs', 'System Settings', 'Can view all user activity logs (login, actions, modules, timestamps)', 'active', 'eye', '2026-03-05 07:03:52', '2026-03-05 07:03:52');
INSERT INTO `permissions` VALUES ('134', 'Export Audit Logs', 'export_audit_logs', 'System Settings', 'Can export audit trail data', 'active', 'download', '2026-03-05 07:03:52', '2026-03-05 07:03:52');
INSERT INTO `permissions` VALUES ('135', 'View Sample', 'view_sample', 'Sample', 'This is for test only', 'active', 'download', '2026-03-06 08:41:06', '2026-03-06 08:41:06');


-- Table: purok_leaders
DROP TABLE IF EXISTS `purok_leaders`;
CREATE TABLE `purok_leaders` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `valid_id_document` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `purok_leaders_user_id_foreign` (`user_id`),
  CONSTRAINT `purok_leaders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `purok_leaders` VALUES ('1', '4', 'https://placehold.co/600x400/e3f2fd/1976d2?text=Valid+ID+-+Juan+Dela+Cruz', '2025-09-14 14:20:00', '2025-09-14 14:20:00');
INSERT INTO `purok_leaders` VALUES ('2', '6', 'https://placehold.co/600x400/e3f2fd/1976d2?text=Valid+ID+-+Maria+Santos', '2025-08-20 13:45:00', '2025-08-20 13:45:00');
INSERT INTO `purok_leaders` VALUES ('3', '8', 'https://placehold.co/600x400/e3f2fd/1976d2?text=Valid+ID+-+Ana+Garcia', '2025-09-10 15:00:00', '2025-09-10 15:00:00');


-- Table: reports
DROP TABLE IF EXISTS `reports`;
CREATE TABLE `reports` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `report_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reporter_id` bigint unsigned NOT NULL,
  `reporter_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reporter_role` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `barangay` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `purok` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `priority` enum('Low','Moderate','Urgent') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Moderate',
  `status` enum('Pending','In Progress','Resolved','Rejected') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Pending',
  `complaint` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_submitted` date NOT NULL,
  `staff_remarks` text COLLATE utf8mb4_unicode_ci,
  `updated_by_id` bigint unsigned DEFAULT NULL,
  `remark` text COLLATE utf8mb4_unicode_ci,
  `resolved_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `reports_report_id_unique` (`report_id`),
  KEY `reports_reporter_id_foreign` (`reporter_id`),
  KEY `reports_updated_by_id_foreign` (`updated_by_id`),
  CONSTRAINT `reports_reporter_id_foreign` FOREIGN KEY (`reporter_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `reports_updated_by_id_foreign` FOREIGN KEY (`updated_by_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `reports` VALUES ('1', 'RPT-001', '4', 'Juan Dela Cruz', 'Purok Leader', 'Poblacion', 'Purok 5', 'Moderate', 'Rejected', 'Garbage was not collected on the scheduled day. Waste has started to accumulate and needs immediate attention', 'report-photo-001.jpg', '2025-09-20', 'It will be rejected', '1', 'It will be rejected', NULL, '2025-09-20 08:00:00', '2026-03-05 09:13:17', NULL);
INSERT INTO `reports` VALUES ('2', 'RPT-002', '5', 'Jonathan G. Buslon', 'Business Owner', 'Poblacion', 'Purok 7', 'Low', 'Resolved', 'Someone is dumping waste in unauthorized area near my business', 'report-photo-002.jpg', '2025-09-01', 'Done na po', '1', 'Done na po', '2026-03-05', '2025-09-01 11:15:00', '2026-03-05 09:10:25', NULL);
INSERT INTO `reports` VALUES ('3', 'RPT-003', '6', 'Maria Santos', 'Purok Leader', 'Poblacion', 'Purok 1', 'Urgent', 'Resolved', 'Waste collection has been missed for 3 consecutive days. Emergency attention needed.', 'report-photo-003.jpg', '2025-09-18', 'We are done here .', '1', 'We are done here .', '2026-03-05', '2025-09-18 09:00:00', '2026-03-05 09:12:27', NULL);
INSERT INTO `reports` VALUES ('4', 'RPT-004', '7', 'Pedro Reyes', 'Business Owner', 'Poblacion', 'Purok 3', 'Moderate', 'Resolved', 'Public waste bin is overflowing and creating health hazard', 'report-photo-004.jpg', '2025-09-15', 'Bin emptied and cleaned.', NULL, NULL, '2025-09-16', '2025-09-15 10:30:00', '2025-09-16 08:45:00', NULL);
INSERT INTO `reports` VALUES ('5', 'RPT-005', '4', 'Juan Dela Cruz', 'Purok Leader', 'Poblacion', 'Purok 5', 'Low', 'Rejected', 'Missed pickup reported but location was unclear', 'report-photo-005.jpg', '2025-09-10', 'Unable to locate. Please provide specific address.', NULL, NULL, NULL, '2025-09-10 13:00:00', '2025-09-11 09:15:00', NULL);
INSERT INTO `reports` VALUES ('6', 'RPT-006', '6', 'Maria Santos', 'Purok Leader', 'Poblacion', 'Purok 1', 'Urgent', 'Pending', 'Large amount of construction waste dumped illegally', 'report-photo-006.jpg', '2025-09-22', NULL, '1', 'Sample Resolved', '2026-03-05', '2025-09-22 07:30:00', '2026-03-05 09:03:14', NULL);


-- Table: role_permission
DROP TABLE IF EXISTS `role_permission`;
CREATE TABLE `role_permission` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `role_id` bigint unsigned NOT NULL,
  `permission_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `role_permission_role_id_permission_id_unique` (`role_id`,`permission_id`),
  KEY `role_permission_permission_id_foreign` (`permission_id`),
  CONSTRAINT `role_permission_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_permission_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=216 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `role_permission` VALUES ('1', '1', '18', NULL, NULL);
INSERT INTO `role_permission` VALUES ('2', '1', '36', NULL, NULL);
INSERT INTO `role_permission` VALUES ('3', '1', '59', NULL, NULL);
INSERT INTO `role_permission` VALUES ('4', '1', '21', NULL, NULL);
INSERT INTO `role_permission` VALUES ('5', '1', '102', NULL, NULL);
INSERT INTO `role_permission` VALUES ('6', '1', '71', NULL, NULL);
INSERT INTO `role_permission` VALUES ('7', '1', '73', NULL, NULL);
INSERT INTO `role_permission` VALUES ('8', '1', '105', NULL, NULL);
INSERT INTO `role_permission` VALUES ('9', '1', '101', NULL, NULL);
INSERT INTO `role_permission` VALUES ('10', '1', '62', NULL, NULL);
INSERT INTO `role_permission` VALUES ('11', '1', '83', NULL, NULL);
INSERT INTO `role_permission` VALUES ('12', '1', '128', NULL, NULL);
INSERT INTO `role_permission` VALUES ('13', '1', '116', NULL, NULL);
INSERT INTO `role_permission` VALUES ('14', '1', '131', NULL, NULL);
INSERT INTO `role_permission` VALUES ('15', '1', '130', NULL, NULL);
INSERT INTO `role_permission` VALUES ('16', '1', '45', NULL, NULL);
INSERT INTO `role_permission` VALUES ('17', '1', '98', NULL, NULL);
INSERT INTO `role_permission` VALUES ('18', '1', '89', NULL, NULL);
INSERT INTO `role_permission` VALUES ('19', '1', '58', NULL, NULL);
INSERT INTO `role_permission` VALUES ('20', '1', '47', NULL, NULL);
INSERT INTO `role_permission` VALUES ('21', '1', '115', NULL, NULL);
INSERT INTO `role_permission` VALUES ('22', '1', '100', NULL, NULL);
INSERT INTO `role_permission` VALUES ('23', '1', '91', NULL, NULL);
INSERT INTO `role_permission` VALUES ('24', '1', '61', NULL, NULL);
INSERT INTO `role_permission` VALUES ('25', '1', '20', NULL, NULL);
INSERT INTO `role_permission` VALUES ('26', '1', '46', NULL, NULL);
INSERT INTO `role_permission` VALUES ('27', '1', '121', NULL, NULL);
INSERT INTO `role_permission` VALUES ('28', '1', '124', NULL, NULL);
INSERT INTO `role_permission` VALUES ('29', '1', '99', NULL, NULL);
INSERT INTO `role_permission` VALUES ('30', '1', '104', NULL, NULL);
INSERT INTO `role_permission` VALUES ('31', '1', '90', NULL, NULL);
INSERT INTO `role_permission` VALUES ('32', '1', '60', NULL, NULL);
INSERT INTO `role_permission` VALUES ('33', '1', '72', NULL, NULL);
INSERT INTO `role_permission` VALUES ('34', '1', '19', NULL, NULL);
INSERT INTO `role_permission` VALUES ('35', '1', '123', NULL, NULL);
INSERT INTO `role_permission` VALUES ('36', '1', '117', NULL, NULL);
INSERT INTO `role_permission` VALUES ('37', '1', '82', NULL, NULL);
INSERT INTO `role_permission` VALUES ('38', '1', '134', NULL, NULL);
INSERT INTO `role_permission` VALUES ('39', '1', '126', NULL, NULL);
INSERT INTO `role_permission` VALUES ('40', '1', '39', NULL, NULL);
INSERT INTO `role_permission` VALUES ('41', '1', '64', NULL, NULL);
INSERT INTO `role_permission` VALUES ('42', '1', '25', NULL, NULL);
INSERT INTO `role_permission` VALUES ('43', '1', '51', NULL, NULL);
INSERT INTO `role_permission` VALUES ('44', '1', '50', NULL, NULL);
INSERT INTO `role_permission` VALUES ('45', '1', '109', NULL, NULL);
INSERT INTO `role_permission` VALUES ('46', '1', '110', NULL, NULL);
INSERT INTO `role_permission` VALUES ('47', '1', '38', NULL, NULL);
INSERT INTO `role_permission` VALUES ('48', '1', '37', NULL, NULL);
INSERT INTO `role_permission` VALUES ('49', '1', '76', NULL, NULL);
INSERT INTO `role_permission` VALUES ('50', '1', '7', NULL, NULL);
INSERT INTO `role_permission` VALUES ('51', '1', '24', NULL, NULL);
INSERT INTO `role_permission` VALUES ('52', '1', '127', NULL, NULL);
INSERT INTO `role_permission` VALUES ('53', '1', '92', NULL, NULL);
INSERT INTO `role_permission` VALUES ('54', '1', '114', NULL, NULL);
INSERT INTO `role_permission` VALUES ('55', '1', '112', NULL, NULL);
INSERT INTO `role_permission` VALUES ('56', '1', '113', NULL, NULL);
INSERT INTO `role_permission` VALUES ('57', '1', '75', NULL, NULL);
INSERT INTO `role_permission` VALUES ('58', '1', '74', NULL, NULL);
INSERT INTO `role_permission` VALUES ('59', '1', '35', NULL, NULL);
INSERT INTO `role_permission` VALUES ('60', '1', '22', NULL, NULL);
INSERT INTO `role_permission` VALUES ('61', '1', '23', NULL, NULL);
INSERT INTO `role_permission` VALUES ('62', '1', '34', NULL, NULL);
INSERT INTO `role_permission` VALUES ('63', '1', '42', NULL, NULL);
INSERT INTO `role_permission` VALUES ('64', '1', '108', NULL, NULL);
INSERT INTO `role_permission` VALUES ('65', '1', '96', NULL, NULL);
INSERT INTO `role_permission` VALUES ('66', '1', '28', NULL, NULL);
INSERT INTO `role_permission` VALUES ('67', '1', '86', NULL, NULL);
INSERT INTO `role_permission` VALUES ('68', '1', '54', NULL, NULL);
INSERT INTO `role_permission` VALUES ('69', '1', '15', NULL, NULL);
INSERT INTO `role_permission` VALUES ('70', '1', '48', NULL, NULL);
INSERT INTO `role_permission` VALUES ('71', '1', '49', NULL, NULL);
INSERT INTO `role_permission` VALUES ('72', '1', '118', NULL, NULL);
INSERT INTO `role_permission` VALUES ('73', '1', '33', NULL, NULL);
INSERT INTO `role_permission` VALUES ('74', '1', '65', NULL, NULL);
INSERT INTO `role_permission` VALUES ('75', '1', '69', NULL, NULL);
INSERT INTO `role_permission` VALUES ('76', '1', '10', NULL, NULL);
INSERT INTO `role_permission` VALUES ('77', '1', '11', NULL, NULL);
INSERT INTO `role_permission` VALUES ('78', '1', '12', NULL, NULL);
INSERT INTO `role_permission` VALUES ('79', '1', '79', NULL, NULL);
INSERT INTO `role_permission` VALUES ('80', '1', '95', NULL, NULL);
INSERT INTO `role_permission` VALUES ('81', '1', '77', NULL, NULL);
INSERT INTO `role_permission` VALUES ('82', '1', '44', NULL, NULL);
INSERT INTO `role_permission` VALUES ('83', '1', '43', NULL, NULL);
INSERT INTO `role_permission` VALUES ('84', '1', '41', NULL, NULL);
INSERT INTO `role_permission` VALUES ('85', '1', '40', NULL, NULL);
INSERT INTO `role_permission` VALUES ('86', '1', '4', NULL, NULL);
INSERT INTO `role_permission` VALUES ('87', '1', '133', NULL, NULL);
INSERT INTO `role_permission` VALUES ('88', '1', '132', NULL, NULL);
INSERT INTO `role_permission` VALUES ('89', '1', '68', NULL, NULL);
INSERT INTO `role_permission` VALUES ('90', '1', '1', NULL, NULL);
INSERT INTO `role_permission` VALUES ('91', '1', '125', NULL, NULL);
INSERT INTO `role_permission` VALUES ('92', '1', '31', NULL, NULL);
INSERT INTO `role_permission` VALUES ('93', '1', '120', NULL, NULL);
INSERT INTO `role_permission` VALUES ('94', '1', '80', NULL, NULL);
INSERT INTO `role_permission` VALUES ('95', '1', '122', NULL, NULL);
INSERT INTO `role_permission` VALUES ('96', '1', '111', NULL, NULL);
INSERT INTO `role_permission` VALUES ('97', '1', '107', NULL, NULL);
INSERT INTO `role_permission` VALUES ('98', '1', '106', NULL, NULL);
INSERT INTO `role_permission` VALUES ('99', '1', '5', NULL, NULL);
INSERT INTO `role_permission` VALUES ('100', '1', '97', NULL, NULL);
INSERT INTO `role_permission` VALUES ('101', '1', '94', NULL, NULL);
INSERT INTO `role_permission` VALUES ('102', '1', '93', NULL, NULL);
INSERT INTO `role_permission` VALUES ('103', '1', '103', NULL, NULL);
INSERT INTO `role_permission` VALUES ('104', '1', '9', NULL, NULL);
INSERT INTO `role_permission` VALUES ('105', '1', '81', NULL, NULL);
INSERT INTO `role_permission` VALUES ('106', '1', '8', NULL, NULL);
INSERT INTO `role_permission` VALUES ('107', '1', '29', NULL, NULL);
INSERT INTO `role_permission` VALUES ('108', '1', '30', NULL, NULL);
INSERT INTO `role_permission` VALUES ('109', '1', '27', NULL, NULL);
INSERT INTO `role_permission` VALUES ('110', '1', '26', NULL, NULL);
INSERT INTO `role_permission` VALUES ('111', '1', '87', NULL, NULL);
INSERT INTO `role_permission` VALUES ('112', '1', '88', NULL, NULL);
INSERT INTO `role_permission` VALUES ('113', '1', '85', NULL, NULL);
INSERT INTO `role_permission` VALUES ('114', '1', '84', NULL, NULL);
INSERT INTO `role_permission` VALUES ('115', '1', '55', NULL, NULL);
INSERT INTO `role_permission` VALUES ('116', '1', '56', NULL, NULL);
INSERT INTO `role_permission` VALUES ('117', '1', '63', NULL, NULL);
INSERT INTO `role_permission` VALUES ('118', '1', '57', NULL, NULL);
INSERT INTO `role_permission` VALUES ('119', '1', '53', NULL, NULL);
INSERT INTO `role_permission` VALUES ('120', '1', '52', NULL, NULL);
INSERT INTO `role_permission` VALUES ('121', '1', '70', NULL, NULL);
INSERT INTO `role_permission` VALUES ('122', '1', '66', NULL, NULL);
INSERT INTO `role_permission` VALUES ('123', '1', '129', NULL, NULL);
INSERT INTO `role_permission` VALUES ('124', '1', '32', NULL, NULL);
INSERT INTO `role_permission` VALUES ('125', '1', '78', NULL, NULL);
INSERT INTO `role_permission` VALUES ('126', '1', '119', NULL, NULL);
INSERT INTO `role_permission` VALUES ('127', '1', '3', NULL, NULL);
INSERT INTO `role_permission` VALUES ('128', '1', '2', NULL, NULL);
INSERT INTO `role_permission` VALUES ('129', '1', '16', NULL, NULL);
INSERT INTO `role_permission` VALUES ('130', '1', '17', NULL, NULL);
INSERT INTO `role_permission` VALUES ('131', '1', '13', NULL, NULL);
INSERT INTO `role_permission` VALUES ('132', '1', '14', NULL, NULL);
INSERT INTO `role_permission` VALUES ('133', '1', '6', NULL, NULL);
INSERT INTO `role_permission` VALUES ('134', '1', '67', NULL, NULL);
INSERT INTO `role_permission` VALUES ('135', '2', '18', NULL, NULL);
INSERT INTO `role_permission` VALUES ('136', '2', '36', NULL, NULL);
INSERT INTO `role_permission` VALUES ('137', '2', '59', NULL, NULL);
INSERT INTO `role_permission` VALUES ('138', '2', '21', NULL, NULL);
INSERT INTO `role_permission` VALUES ('139', '2', '71', NULL, NULL);
INSERT INTO `role_permission` VALUES ('140', '2', '105', NULL, NULL);
INSERT INTO `role_permission` VALUES ('141', '2', '45', NULL, NULL);
INSERT INTO `role_permission` VALUES ('142', '2', '58', NULL, NULL);
INSERT INTO `role_permission` VALUES ('143', '2', '46', NULL, NULL);
INSERT INTO `role_permission` VALUES ('144', '2', '104', NULL, NULL);
INSERT INTO `role_permission` VALUES ('145', '2', '60', NULL, NULL);
INSERT INTO `role_permission` VALUES ('146', '2', '72', NULL, NULL);
INSERT INTO `role_permission` VALUES ('147', '2', '19', NULL, NULL);
INSERT INTO `role_permission` VALUES ('148', '2', '39', NULL, NULL);
INSERT INTO `role_permission` VALUES ('149', '2', '51', NULL, NULL);
INSERT INTO `role_permission` VALUES ('150', '2', '50', NULL, NULL);
INSERT INTO `role_permission` VALUES ('151', '2', '38', NULL, NULL);
INSERT INTO `role_permission` VALUES ('152', '2', '37', NULL, NULL);
INSERT INTO `role_permission` VALUES ('153', '2', '76', NULL, NULL);
INSERT INTO `role_permission` VALUES ('154', '2', '7', NULL, NULL);
INSERT INTO `role_permission` VALUES ('155', '2', '75', NULL, NULL);
INSERT INTO `role_permission` VALUES ('156', '2', '35', NULL, NULL);
INSERT INTO `role_permission` VALUES ('157', '2', '22', NULL, NULL);
INSERT INTO `role_permission` VALUES ('158', '2', '34', NULL, NULL);
INSERT INTO `role_permission` VALUES ('159', '2', '42', NULL, NULL);
INSERT INTO `role_permission` VALUES ('160', '2', '28', NULL, NULL);
INSERT INTO `role_permission` VALUES ('161', '2', '54', NULL, NULL);
INSERT INTO `role_permission` VALUES ('162', '2', '15', NULL, NULL);
INSERT INTO `role_permission` VALUES ('163', '2', '48', NULL, NULL);
INSERT INTO `role_permission` VALUES ('164', '2', '49', NULL, NULL);
INSERT INTO `role_permission` VALUES ('165', '2', '33', NULL, NULL);
INSERT INTO `role_permission` VALUES ('166', '2', '65', NULL, NULL);
INSERT INTO `role_permission` VALUES ('167', '2', '69', NULL, NULL);
INSERT INTO `role_permission` VALUES ('168', '2', '79', NULL, NULL);
INSERT INTO `role_permission` VALUES ('169', '2', '77', NULL, NULL);
INSERT INTO `role_permission` VALUES ('170', '2', '44', NULL, NULL);
INSERT INTO `role_permission` VALUES ('171', '2', '43', NULL, NULL);
INSERT INTO `role_permission` VALUES ('172', '2', '41', NULL, NULL);
INSERT INTO `role_permission` VALUES ('173', '2', '40', NULL, NULL);
INSERT INTO `role_permission` VALUES ('174', '2', '4', NULL, NULL);
INSERT INTO `role_permission` VALUES ('175', '2', '68', NULL, NULL);
INSERT INTO `role_permission` VALUES ('176', '2', '1', NULL, NULL);
INSERT INTO `role_permission` VALUES ('177', '2', '31', NULL, NULL);
INSERT INTO `role_permission` VALUES ('178', '2', '80', NULL, NULL);
INSERT INTO `role_permission` VALUES ('179', '2', '5', NULL, NULL);
INSERT INTO `role_permission` VALUES ('180', '2', '103', NULL, NULL);
INSERT INTO `role_permission` VALUES ('181', '2', '81', NULL, NULL);
INSERT INTO `role_permission` VALUES ('182', '2', '29', NULL, NULL);
INSERT INTO `role_permission` VALUES ('183', '2', '30', NULL, NULL);
INSERT INTO `role_permission` VALUES ('184', '2', '27', NULL, NULL);
INSERT INTO `role_permission` VALUES ('185', '2', '26', NULL, NULL);
INSERT INTO `role_permission` VALUES ('186', '2', '55', NULL, NULL);
INSERT INTO `role_permission` VALUES ('187', '2', '56', NULL, NULL);
INSERT INTO `role_permission` VALUES ('188', '2', '63', NULL, NULL);
INSERT INTO `role_permission` VALUES ('189', '2', '57', NULL, NULL);
INSERT INTO `role_permission` VALUES ('190', '2', '53', NULL, NULL);
INSERT INTO `role_permission` VALUES ('191', '2', '52', NULL, NULL);
INSERT INTO `role_permission` VALUES ('192', '2', '70', NULL, NULL);
INSERT INTO `role_permission` VALUES ('193', '2', '66', NULL, NULL);
INSERT INTO `role_permission` VALUES ('194', '2', '32', NULL, NULL);
INSERT INTO `role_permission` VALUES ('195', '2', '78', NULL, NULL);
INSERT INTO `role_permission` VALUES ('196', '2', '3', NULL, NULL);
INSERT INTO `role_permission` VALUES ('197', '2', '2', NULL, NULL);
INSERT INTO `role_permission` VALUES ('198', '2', '16', NULL, NULL);
INSERT INTO `role_permission` VALUES ('199', '2', '17', NULL, NULL);
INSERT INTO `role_permission` VALUES ('200', '2', '13', NULL, NULL);
INSERT INTO `role_permission` VALUES ('201', '2', '14', NULL, NULL);
INSERT INTO `role_permission` VALUES ('202', '2', '6', NULL, NULL);
INSERT INTO `role_permission` VALUES ('203', '2', '67', NULL, NULL);


-- Table: roles
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `user_count` int NOT NULL DEFAULT '0',
  `is_system` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `roles` VALUES ('1', 'Admin', 'admin', 'Full system access with all permissions', '2', '1', '2026-03-05 07:03:52', '2026-03-05 07:03:52');
INSERT INTO `roles` VALUES ('2', 'Staff', 'staff', 'Limited access for staff members - can view, create, and edit but cannot delete', '3', '1', '2026-03-05 07:03:52', '2026-03-05 07:03:52');
INSERT INTO `roles` VALUES ('3', 'Sample', 'sample', 'asdsd', '0', '0', '2026-03-06 08:31:00', '2026-03-06 08:31:00');


-- Table: routes
DROP TABLE IF EXISTS `routes`;
CREATE TABLE `routes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `route_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `municipality` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `province` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('active','inactive','under_maintenance') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `color` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '#3B82F6',
  `waypoints` json NOT NULL,
  `distance` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estimated_duration` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `routes_route_id_unique` (`route_id`),
  KEY `routes_created_by_id_foreign` (`created_by_id`),
  CONSTRAINT `routes_created_by_id_foreign` FOREIGN KEY (`created_by_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `routes` VALUES ('1', 'ROUTE-001', 'Trinidad Central Route', 'Main route covering central Trinidad barangays', 'Trinidad', 'Bohol', 'active', '#000000', '[{\"id\": \"WP-001\", \"lat\": 10.07970689760644, \"lng\": 124.34302082673474, \"name\": \"Trinidad Municipal Hall\", \"type\": \"start\", \"order\": 1, \"address\": \"Trinidad Municipal Hall, Trinidad, Bohol\", \"barangay\": \"Poblacion\"}, {\"id\": \"WP-002\", \"lat\": 10.04497959694381, \"lng\": 124.40353977145442, \"name\": \"Barangay CATOOGAN\", \"type\": \"pickup\", \"order\": 2, \"address\": \"Barangay CATOOGAN, Trinidad, Bohol\", \"barangay\": \"CATOOGAN\"}, {\"id\": \"WP-003\", \"lat\": 10.073609975988091, \"lng\": 124.3562811698296, \"name\": \"Barangay Guinobatan\", \"type\": \"pickup\", \"order\": 3, \"address\": \"Barangay Guinobatan, Trinidad, Bohol\", \"barangay\": \"Guinobatan\"}, {\"id\": \"WP-004\", \"lat\": 10.033511206800622, \"lng\": 124.25979675660412, \"name\": \"Barangay Kauswagan\", \"type\": \"pickup\", \"order\": 4, \"address\": \"Barangay Kauswagan, Trinidad, Bohol\", \"barangay\": \"Kauswagan\"}, {\"id\": \"WP-005\", \"lat\": 10.064948400829833, \"lng\": 124.32686535742056, \"name\": \"Trinidad Disposal Facility\", \"type\": \"end\", \"order\": 5, \"address\": \"Waste Disposal Facility, Trinidad, Bohol\", \"barangay\": \"Poblacion\"}]', '12.5 km', '45 minutes', '1', '2026-03-01 08:00:00', '2026-03-05 10:26:39', NULL);
INSERT INTO `routes` VALUES ('2', 'ROUTE-002', 'Trinidad North Route', 'Northern barangays coverage', 'Trinidad', 'Bohol', 'active', '#10b713', '[{\"id\": \"WP-006\", \"lat\": 10.0797, \"lng\": 124.3445, \"name\": \"Trinidad Municipal Hall\", \"type\": \"start\", \"order\": 1, \"address\": \"Trinidad Municipal Hall, Poblacion, Trinidad, Bohol\", \"barangay\": \"Poblacion\"}, {\"id\": \"WP-007\", \"lat\": 10.0962, \"lng\": 124.3578, \"name\": \"Barangay Banlasan\", \"type\": \"pickup\", \"order\": 2, \"address\": \"Barangay Banlasan, Trinidad, Bohol\", \"barangay\": \"Banlasan\"}, {\"id\": \"WP-008\", \"lat\": 10.1045, \"lng\": 124.3661, \"name\": \"Barangay La Union\", \"type\": \"pickup\", \"order\": 3, \"address\": \"Barangay La Union, Trinidad, Bohol\", \"barangay\": \"La Union\"}, {\"id\": \"WP-009\", \"lat\": 10.1128, \"lng\": 124.3743, \"name\": \"Barangay Mahagbu\", \"type\": \"pickup\", \"order\": 4, \"address\": \"Barangay Mahagbu, Trinidad, Bohol\", \"barangay\": \"Mahagbu\"}, {\"id\": \"WP-010\", \"lat\": 10.0723, \"lng\": 124.3529, \"name\": \"Trinidad Disposal Facility\", \"type\": \"end\", \"order\": 5, \"address\": \"Waste Disposal Facility, Trinidad, Bohol\", \"barangay\": \"Poblacion\"}]', '18.3 km', '65 minutes', '1', '2026-03-01 08:30:00', '2026-03-05 10:26:16', NULL);
INSERT INTO `routes` VALUES ('3', 'ROUTE-003', 'Trinidad South Route', 'Southern barangays and nearby areas', 'Trinidad', 'Bohol', 'active', '#f50aed', '[{\"id\": \"WP-011\", \"lat\": 10.0797, \"lng\": 124.3445, \"name\": \"Trinidad Municipal Hall\", \"type\": \"start\", \"order\": 1, \"address\": \"Trinidad Municipal Hall, Poblacion, Trinidad, Bohol\", \"barangay\": \"Poblacion\"}, {\"id\": \"WP-012\", \"lat\": 10.0614, \"lng\": 124.3562, \"name\": \"Barangay Kinan\", \"type\": \"pickup\", \"order\": 2, \"address\": \"Barangay Kinan, Trinidad, Bohol\", \"barangay\": \"Kinan\"}, {\"id\": \"WP-013\", \"lat\": 10.0528, \"lng\": 124.3654, \"name\": \"Barangay Hinlayagan Ilaud\", \"type\": \"pickup\", \"order\": 3, \"address\": \"Barangay Hinlayagan Ilaud, Trinidad, Bohol\", \"barangay\": \"Hinlayagan Ilaud\"}, {\"id\": \"WP-014\", \"lat\": 10.0437, \"lng\": 124.3728, \"name\": \"Barangay Santo Niño\", \"type\": \"pickup\", \"order\": 4, \"address\": \"Barangay Santo Niño, Trinidad, Bohol\", \"barangay\": \"Santo Niño\"}, {\"id\": \"WP-015\", \"lat\": 10.0723, \"lng\": 124.3529, \"name\": \"Trinidad Disposal Facility\", \"type\": \"end\", \"order\": 5, \"address\": \"Waste Disposal Facility, Trinidad, Bohol\", \"barangay\": \"Poblacion\"}]', '15.7 km', '55 minutes', '1', '2026-03-01 09:00:00', '2026-03-05 10:59:45', NULL);
INSERT INTO `routes` VALUES ('4', 'ROUTE-004', 'asdasd', 'asd', 'Trinidad', 'Bohol', 'active', '#3B82F6', '[{\"id\": \"WP-1772707865049\", \"lat\": 10.080163883862996, \"lng\": 124.34336801094136, \"name\": \"asdas\", \"type\": \"start\", \"order\": 1, \"barangay\": \"dasdasd\"}, {\"id\": \"WP-1772707869321\", \"lat\": 10.078743127108527, \"lng\": 124.34352355672024, \"name\": \"asd\", \"type\": \"pickup\", \"order\": 2, \"barangay\": \"asd\"}, {\"id\": \"WP-1772707874521\", \"lat\": 10.0776867983253, \"lng\": 124.34357181972452, \"name\": \"asd\", \"type\": \"pickup\", \"order\": 3, \"barangay\": \"asd\"}, {\"id\": \"WP-1772707878960\", \"lat\": 10.07592800322235, \"lng\": 124.34338950771544, \"name\": \"asdasd\", \"type\": \"pickup\", \"order\": 4, \"barangay\": \"asdds\"}, {\"id\": \"WP-1772707882632\", \"lat\": 10.074306522961455, \"lng\": 124.3428691182026, \"name\": \"asd\", \"type\": \"pickup\", \"order\": 5, \"barangay\": \"asd\"}, {\"id\": \"WP-1772707886376\", \"lat\": 10.071713193936931, \"lng\": 124.34202159228984, \"name\": \"asd\", \"type\": \"pickup\", \"order\": 6, \"barangay\": \"asd\"}, {\"id\": \"WP-1772707891721\", \"lat\": 10.0683909560438, \"lng\": 124.34150641271091, \"name\": \"asd\", \"type\": \"end\", \"order\": 7, \"barangay\": \"asd\"}]', '1.33 km', NULL, '1', '2026-03-05 10:51:38', '2026-03-05 10:53:11', '2026-03-05 10:53:11');


-- Table: schedules
DROP TABLE IF EXISTS `schedules`;
CREATE TABLE `schedules` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `schedule_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `route_id` bigint unsigned DEFAULT NULL,
  `day` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` date NOT NULL,
  `start_time` time NOT NULL DEFAULT '06:00:00',
  `end_time` time DEFAULT NULL,
  `status` enum('active','completed','cancelled','pending') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `cancel_reason` text COLLATE utf8mb4_unicode_ci,
  `stops` json NOT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_by_id` bigint unsigned NOT NULL,
  `assigned_driver_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `schedules_schedule_id_unique` (`schedule_id`),
  KEY `schedules_route_id_foreign` (`route_id`),
  KEY `schedules_created_by_id_foreign` (`created_by_id`),
  KEY `schedules_assigned_driver_id_foreign` (`assigned_driver_id`),
  CONSTRAINT `schedules_assigned_driver_id_foreign` FOREIGN KEY (`assigned_driver_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `schedules_created_by_id_foreign` FOREIGN KEY (`created_by_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `schedules_route_id_foreign` FOREIGN KEY (`route_id`) REFERENCES `routes` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `schedules` VALUES ('1', 'SCH-001', '1', 'Monday', '2026-03-08', '06:00:00', '14:30:00', 'active', NULL, '[{\"time\": \"06:00 AM\", \"status\": \"start\", \"location\": \"Municipal Hall\"}, {\"time\": \"06:30 AM\", \"status\": \"ongoing\", \"location\": \"Mundal Bhouse\"}, {\"time\": \"07:00 AM\", \"status\": \"ongoing\", \"location\": \"TMC via Park in Go\"}, {\"time\": \"07:30 AM\", \"status\": \"ongoing\", \"location\": \"TCES\"}, {\"time\": \"08:00 AM\", \"status\": \"ongoing\", \"location\": \"Brgy.Hall\"}, {\"time\": \"08:30 AM\", \"status\": \"ongoing\", \"location\": \"Arlene Carenderia\"}, {\"time\": \"09:00 AM\", \"status\": \"ongoing\", \"location\": \"Public Market\"}, {\"time\": \"09:30 AM\", \"status\": \"ongoing\", \"location\": \"Municipal Hall Annex\"}, {\"time\": \"10:00 AM\", \"status\": \"ongoing\", \"location\": \"Cultural Center\"}, {\"time\": \"10:30 AM\", \"status\": \"ongoing\", \"location\": \"PENGAVITOR Ent.\"}, {\"time\": \"11:00 AM\", \"status\": \"ongoing\", \"location\": \"Sumatra Res.\"}, {\"time\": \"11:30 AM\", \"status\": \"ongoing\", \"location\": \"F. Gonzales Res\"}, {\"time\": \"12:00 PM\", \"status\": \"ongoing\", \"location\": \"SIA\"}, {\"time\": \"12:30 PM\", \"status\": \"ongoing\", \"location\": \"Shoppers Mart\"}, {\"time\": \"01:00 PM\", \"status\": \"finish\", \"location\": \"RCA/MRF\"}, {\"time\": \"01:30 PM\", \"status\": \"ongoing\", \"location\": \"Crossing Candi Store\"}, {\"time\": \"02:00 PM\", \"status\": \"ongoing\", \"location\": \"Panab an\"}, {\"time\": \"02:30 PM\", \"status\": \"ongoing\", \"location\": \"Entrance SM\"}]', NULL, '1', NULL, '2026-03-01 10:00:00', '2026-03-01 10:00:00', NULL);
INSERT INTO `schedules` VALUES ('2', 'SCH-002', '2', 'Tuesday', '2026-03-09', '06:00:00', '09:00:00', 'active', NULL, '[{\"time\": \"06:00 AM\", \"status\": \"start\", \"location\": \"Purok 1\"}, {\"time\": \"07:00 AM\", \"status\": \"ongoing\", \"location\": \"Purok 2\"}, {\"time\": \"08:00 AM\", \"status\": \"ongoing\", \"location\": \"Purok 3\"}, {\"time\": \"09:00 AM\", \"status\": \"finish\", \"location\": \"RCA/MRF\"}]', NULL, '1', NULL, '2026-03-01 10:30:00', '2026-03-01 10:30:00', NULL);
INSERT INTO `schedules` VALUES ('3', 'SCH-003', '3', 'Wednesday', '2026-03-10', '06:00:00', '09:00:00', 'completed', NULL, '[{\"time\": \"06:00 AM\", \"status\": \"start\", \"location\": \"Purok 4\"}, {\"time\": \"07:00 AM\", \"status\": \"ongoing\", \"location\": \"Purok 5\"}, {\"time\": \"08:00 AM\", \"status\": \"ongoing\", \"location\": \"Carenderia Area\"}, {\"time\": \"09:00 AM\", \"status\": \"finish\", \"location\": \"RCA/MRF\"}]', NULL, '1', NULL, '2026-03-01 11:00:00', '2026-03-10 09:00:00', NULL);
INSERT INTO `schedules` VALUES ('4', 'SCH-004', '1', 'Thursday', '2026-03-04', '06:00:00', NULL, 'cancelled', 'Heavy rain and flooding', '[{\"time\": \"06:00 AM\", \"status\": \"start\", \"location\": \"Municipal Hall\"}, {\"time\": \"06:30 AM\", \"status\": \"ongoing\", \"location\": \"Cogon Elementary School\"}, {\"time\": \"07:00 AM\", \"status\": \"ongoing\", \"location\": \"Cogon Market\"}, {\"time\": \"07:30 AM\", \"status\": \"ongoing\", \"location\": \"Purok 6\"}, {\"time\": \"08:00 AM\", \"status\": \"ongoing\", \"location\": \"Purok 7\"}, {\"time\": \"08:30 AM\", \"status\": \"ongoing\", \"location\": \"Purok 8\"}, {\"time\": \"09:00 AM\", \"status\": \"ongoing\", \"location\": \"Dao Barangay Hall\"}, {\"time\": \"09:30 AM\", \"status\": \"ongoing\", \"location\": \"Dao Chapel\"}, {\"time\": \"10:00 AM\", \"status\": \"ongoing\", \"location\": \"Dao Elementary School\"}, {\"time\": \"10:30 AM\", \"status\": \"ongoing\", \"location\": \"Taloto Main Road\"}, {\"time\": \"11:00 AM\", \"status\": \"ongoing\", \"location\": \"Taloto Commercial Area\"}, {\"time\": \"11:30 AM\", \"status\": \"ongoing\", \"location\": \"Bool Public Market\"}, {\"time\": \"12:00 PM\", \"status\": \"ongoing\", \"location\": \"Bool Plaza\"}, {\"time\": \"12:30 PM\", \"status\": \"ongoing\", \"location\": \"Island City Mall\"}, {\"time\": \"01:00 PM\", \"status\": \"finish\", \"location\": \"RCA/MRF\"}]', 'Cancelled due to bad weather conditions', '1', NULL, '2026-03-01 11:30:00', '2026-03-04 05:30:00', NULL);
INSERT INTO `schedules` VALUES ('5', 'SCH-005', '2', 'Friday', '2026-03-05', '06:00:00', '13:00:00', 'completed', NULL, '[{\"time\": \"06:00 AM\", \"status\": \"start\", \"location\": \"Municipal Hall\"}, {\"time\": \"06:30 AM\", \"status\": \"ongoing\", \"location\": \"Mansasa Market\"}, {\"time\": \"07:00 AM\", \"status\": \"ongoing\", \"location\": \"Mansasa Barangay Hall\"}, {\"time\": \"07:30 AM\", \"status\": \"ongoing\", \"location\": \"Ubujan Elementary School\"}, {\"time\": \"08:00 AM\", \"status\": \"ongoing\", \"location\": \"Ubujan Chapel\"}, {\"time\": \"08:30 AM\", \"status\": \"ongoing\", \"location\": \"BQ Mall\"}, {\"time\": \"09:00 AM\", \"status\": \"ongoing\", \"location\": \"Alta Citta\"}, {\"time\": \"09:30 AM\", \"status\": \"ongoing\", \"location\": \"City Hall Tagbilaran\"}, {\"time\": \"10:00 AM\", \"status\": \"ongoing\", \"location\": \"St. Joseph Cathedral\"}, {\"time\": \"10:30 AM\", \"status\": \"ongoing\", \"location\": \"Plaza Rizal\"}, {\"time\": \"11:00 AM\", \"status\": \"ongoing\", \"location\": \"Carlos P. Garcia Avenue\"}, {\"time\": \"11:30 AM\", \"status\": \"ongoing\", \"location\": \"TIP Building\"}, {\"time\": \"12:00 PM\", \"status\": \"ongoing\", \"location\": \"Bohol Quality Mall\"}, {\"time\": \"12:30 PM\", \"status\": \"ongoing\", \"location\": \"Graham Avenue\"}, {\"time\": \"01:00 PM\", \"status\": \"finish\", \"location\": \"RCA/MRF\"}]', NULL, '1', NULL, '2026-03-01 12:00:00', '2026-03-05 13:00:00', NULL);


-- Table: sessions
DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



-- Table: system_settings
DROP TABLE IF EXISTS `system_settings`;
CREATE TABLE `system_settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'string',
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `system_settings_key_unique` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `system_settings` VALUES ('1', 'maintenance_mode', 'false', 'boolean', 'Enable or disable system maintenance mode', '2026-03-05 07:03:50', '2026-03-06 08:48:43');
INSERT INTO `system_settings` VALUES ('2', 'maintenance_message', 'System is currently under maintenance. Please check back later.', 'string', 'Maintenance mode message', '2026-03-05 07:03:50', '2026-03-05 07:03:50');


-- Table: users
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fullname` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact_number` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city_municipality` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `barangay` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `purok` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `profile_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('pending','approved','rejected','suspended') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `users` VALUES ('1', 'admin@purecycle.com', '$2y$12$awDA266p/o6w0PumDmj88O9EEfusRjP9runexoWzKu2WgQbaNbwJu', 'Josh Gracxiosa', '09769783746', 'Trinidad', 'Santo Tomas', 'Purok 1', 'admin', 'uploads/images/profile_path/1772696802_69a934e2207d2.png', 'approved', NULL, NULL, '2025-01-01 08:00:00', '2026-03-05 12:00:18');
INSERT INTO `users` VALUES ('2', 'staff@purecycle.com', '$2y$12$IsS4PEJzpm4KSwluS6FPcO7LqKIOONEHESE4ZM4MLt4V7xs79ksxW', 'Everly Santos', '09123456789', 'Tagbilaran City', NULL, NULL, 'staff', 'https://randomuser.me/api/portraits/women/2.jpg', 'approved', NULL, NULL, '2025-01-15 09:30:00', '2025-01-15 09:30:00');
INSERT INTO `users` VALUES ('3', 'maria.staff@purecycle.com', '$2y$12$BOoCm5PB9oTGhcvnQlKwFekyGSQdZ/fCR8Fr5HfyZUgGc.aqrkaam', 'Maria Garcia', '09987654321', 'Tagbilaran City', NULL, NULL, 'staff', 'https://randomuser.me/api/portraits/women/3.jpg', 'approved', NULL, NULL, '2025-02-01 10:00:00', '2025-02-01 10:00:00');
INSERT INTO `users` VALUES ('4', 'juan@gmail.com', '$2y$12$/r9Vgs7sPJNFFhSrTXTfuu3i.7lL7unGSRoX/iHlIf4V2QA9SqwOW', 'Juan Dela Cruz', '09876758498', 'Tagbilaran City', 'Cogon', 'Purok 5', 'purok_leader', 'https://randomuser.me/api/portraits/men/4.jpg', 'approved', NULL, NULL, '2025-09-14 14:20:00', '2025-09-14 14:20:00');
INSERT INTO `users` VALUES ('5', 'jonathan@gmail.com', '$2y$12$Ox0dHx/Fg5pz9oO8r3RLIOZ9MNkMHnN5XxXYTqHbbMvMDNzjLw03y', 'Jonathan G. Buslon', '09507306781', 'Tagbilaran City', 'Poblacion I', 'Purok 7', 'business_owner', 'https://randomuser.me/api/portraits/men/5.jpg', 'approved', NULL, NULL, '2025-09-01 11:15:00', '2026-03-05 08:19:35');
INSERT INTO `users` VALUES ('6', 'maria.santos@gmail.com', '$2y$12$iZKLpeDQKD7VmqsDiQi3UOAOt7.jlgIMSk/e.8vpPMhPR4GPOaTYm', 'Maria Santos', '09123456789', 'Alburquerque', 'East Poblacion', 'Purok 1', 'purok_leader', 'https://randomuser.me/api/portraits/women/6.jpg', 'approved', NULL, NULL, '2025-08-20 13:45:00', '2025-08-20 13:45:00');
INSERT INTO `users` VALUES ('7', 'pedro.reyes@gmail.com', '$2y$12$QunmmI71/wANDkkSCyVMcuQ9p8vRWEpsHX981o1YnpOaOeGBve72a', 'Pedro Reyes', '09234567890', 'Alicia', 'Poblacion', 'Purok 3', 'business_owner', 'https://randomuser.me/api/portraits/men/7.jpg', 'approved', NULL, NULL, '2025-08-15 10:30:00', '2025-08-15 10:30:00');
INSERT INTO `users` VALUES ('8', 'ana.garcia@gmail.com', '$2y$12$RhKRRZt1hfWAsP.vO9VqH.9xuT090K4.sg.t3T5yZnzTH95Jpteqa', 'Ana Garcia', '09345678901', 'Tagbilaran City', 'Dampas', 'Purok 2', 'purok_leader', 'https://randomuser.me/api/portraits/women/8.jpg', 'approved', NULL, NULL, '2025-09-10 15:00:00', '2026-03-05 08:20:14');
INSERT INTO `users` VALUES ('9', 'carlos@gmail.com', '$2y$12$0cCGMgnKkPD.pAnHoNoaieGJn4pn7lleNgOs8/8viDtbtIDn/Odvu', 'Carlos Mendoza', '09456789012', 'Alburquerque', 'Toril', 'Purok 4', 'business_owner', 'https://randomuser.me/api/portraits/men/9.jpg', 'pending', NULL, NULL, '2025-07-05 09:00:00', '2025-07-05 09:00:00');
INSERT INTO `users` VALUES ('10', 'samle@gmail.com', '$2y$12$doadX9ufHLkZyzOiRcVMxORcX9hdiasn/7mZKWIMIgRK4Er.FrDs.', 'Sample', '09999999999', 'Trinidad', 'Tagum Norte', 'Purok 1', 'admin', 'uploads/images/profile_path/1772698735_69a93c6fd74d0.jpg', 'approved', NULL, NULL, '2026-03-05 08:18:24', '2026-03-05 08:19:15');

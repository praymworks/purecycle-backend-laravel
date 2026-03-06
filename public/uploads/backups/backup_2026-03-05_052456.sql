-- Database Backup: laravel
-- Date: 2026-03-05 05:24:58



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

INSERT INTO `announcements` VALUES ('1', 'ANN-001', 'Important Announcement: Waste Collection Delay', 'Please be informed that today\'s waste collection has been temporary cancelled due to unforeseen maintenance issue. Regular collection will resume tomorrow. We apologize for the inconvenience', 'Moderate', '2025-09-12', '2025-09-15', 'Expired', '2025-09-12', '1', '[]', '2025-09-12 08:00:00', '2025-09-12 08:00:00', NULL);
INSERT INTO `announcements` VALUES ('2', 'ANN-002', 'Important Notice: Waste Collection Halted', 'Please be informed that today\'s waste collection has been temporary cancelled due to unforeseen maintenance .....', 'Moderate', '2025-03-12', '2025-03-20', 'Expired', '2025-03-12', '2', '[]', '2025-03-12 09:30:00', '2025-03-12 09:30:00', NULL);
INSERT INTO `announcements` VALUES ('3', 'ANN-003', 'New Waste Segregation Guidelines', 'Starting next week, new waste segregation rules will be implemented. Please separate biodegradable, non-biodegradable, and recyclable waste.', 'Low', '2025-09-25', '2025-10-25', 'Active', '2025-09-23', '1', '[\"guidelines.pdf\"]', '2025-09-23 10:00:00', '2025-09-23 10:00:00', NULL);
INSERT INTO `announcements` VALUES ('4', 'ANN-004', 'Holiday Schedule Adjustment', 'Waste collection schedule will be adjusted during the upcoming holidays. Please check the updated schedule.', 'Moderate', '2025-10-01', '2025-10-15', 'Active', '2025-09-24', '2', '[\"holiday-schedule.pdf\"]', '2025-09-24 14:30:00', '2025-09-24 14:30:00', NULL);
INSERT INTO `announcements` VALUES ('5', 'ANN-005', 'Important Notice: New Collection Schedule', 'Starting next week, waste collection schedule will be adjusted. Please check the new schedule posted on the bulletin board.', 'Moderate', '2026-03-10', '2026-03-31', 'Active', '2026-03-05', '1', '[]', '2026-03-05 04:23:55', '2026-03-05 04:24:30', '2026-03-05 04:24:30');


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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `audit_logs` VALUES ('1', '1', 'Admin User', 'Admin', 'Login', 'Authentication', 'User logged into the system', '192.168.1.100', 'success', '2026-03-04 16:45:23', '2026-03-05 05:16:53');
INSERT INTO `audit_logs` VALUES ('2', '1', 'Admin User', 'Admin', 'View', 'Dashboard', 'Accessed Dashboard page', '192.168.1.100', 'success', '2026-03-04 16:45:30', '2026-03-05 05:16:53');
INSERT INTO `audit_logs` VALUES ('3', '1', 'Admin User', 'Admin', 'Update', 'User Management', 'Updated user information', '192.168.1.100', 'success', '2026-03-04 16:50:15', '2026-03-05 05:16:53');
INSERT INTO `audit_logs` VALUES ('4', '2', 'Staff User', 'Staff', 'View', 'Reports Management', 'Viewed report details', '192.168.1.105', 'success', '2026-03-04 16:55:00', '2026-03-05 05:16:53');
INSERT INTO `audit_logs` VALUES ('5', '2', 'Staff User', 'Staff', 'Update', 'Reports Management', 'Changed report status to In Progress', '192.168.1.105', 'success', '2026-03-04 16:56:30', '2026-03-05 05:16:53');
INSERT INTO `audit_logs` VALUES ('6', '1', 'Admin User', 'Admin', 'Create', 'Announcements', 'Created new announcement', '192.168.1.100', 'success', '2026-03-04 17:00:00', '2026-03-05 05:16:53');
INSERT INTO `audit_logs` VALUES ('7', '1', 'Admin User', 'Admin', 'Delete', 'User Management', 'Deleted user account', '192.168.1.100', 'success', '2026-03-04 17:05:45', '2026-03-05 05:16:53');
INSERT INTO `audit_logs` VALUES ('8', '2', 'Staff User', 'Staff', 'Login', 'Authentication', 'Failed login attempt - incorrect password', '192.168.1.105', 'failed', '2026-03-04 17:10:00', '2026-03-05 05:16:53');
INSERT INTO `audit_logs` VALUES ('9', '1', 'Admin User', 'Admin', 'Update', 'System Settings', 'Changed site maintenance mode to ON', '192.168.1.100', 'success', '2026-03-04 17:15:30', '2026-03-05 05:16:53');
INSERT INTO `audit_logs` VALUES ('10', '1', 'Admin User', 'Admin', 'Export', 'System Settings', 'Exported database backup', '192.168.1.100', 'success', '2026-03-04 17:20:00', '2026-03-05 05:16:53');


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

INSERT INTO `cache` VALUES ('purecycle-cache-b7whrPCwxjUwkqHZ', 's:7:\"forever\";', '2088048255');


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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `migrations` VALUES ('1', '0001_01_01_000000_create_users_table', '1');
INSERT INTO `migrations` VALUES ('2', '0001_01_01_000001_create_cache_table', '1');
INSERT INTO `migrations` VALUES ('3', '0001_01_01_000002_create_jobs_table', '1');
INSERT INTO `migrations` VALUES ('4', '2026_03_04_151606_create_roles_table', '1');
INSERT INTO `migrations` VALUES ('5', '2026_03_04_151607_create_business_owners_table', '1');
INSERT INTO `migrations` VALUES ('6', '2026_03_04_151608_create_permissions_table', '1');
INSERT INTO `migrations` VALUES ('7', '2026_03_04_151609_create_role_permission_table', '1');
INSERT INTO `migrations` VALUES ('8', '2026_03_04_151610_create_purok_leaders_table', '1');
INSERT INTO `migrations` VALUES ('9', '2026_03_05_113603_create_reports_table', '2');
INSERT INTO `migrations` VALUES ('10', '2026_03_05_121344_add_updated_by_and_remark_to_reports_table', '3');
INSERT INTO `migrations` VALUES ('11', '2026_03_05_122014_create_announcements_table', '4');
INSERT INTO `migrations` VALUES ('12', '2026_03_05_123535_create_routes_table', '5');
INSERT INTO `migrations` VALUES ('13', '2026_03_05_124501_create_schedules_table', '6');
INSERT INTO `migrations` VALUES ('14', '2026_03_05_130000_create_audit_logs_table', '7');
INSERT INTO `migrations` VALUES ('15', '2026_03_05_130001_create_system_settings_table', '7');


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
) ENGINE=InnoDB AUTO_INCREMENT=135 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `permissions` VALUES ('1', 'View Dashboard', 'view_dashboard', 'Dashboard', 'Can access main dashboard page', 'active', 'dashboard', '2026-03-04 15:21:48', '2026-03-04 15:21:48');
INSERT INTO `permissions` VALUES ('2', 'View Total Users Widget', 'view_total_users_widget', 'Dashboard', 'Can view Total Users statistics widget', 'active', 'eye', '2026-03-04 15:21:48', '2026-03-04 15:21:48');
INSERT INTO `permissions` VALUES ('3', 'View Total Reports Widget', 'view_total_reports_widget', 'Dashboard', 'Can view Total Reports statistics widget', 'active', 'eye', '2026-03-04 15:21:48', '2026-03-04 15:21:48');
INSERT INTO `permissions` VALUES ('4', 'View Announcements Widget', 'view_announcements_widget', 'Dashboard', 'Can view Announcements statistics widget', 'active', 'eye', '2026-03-04 15:21:48', '2026-03-04 15:21:48');
INSERT INTO `permissions` VALUES ('5', 'View Pending Approvals Widget', 'view_pending_approvals_widget', 'Dashboard', 'Can view Pending Approvals statistics widget', 'active', 'eye', '2026-03-04 15:21:48', '2026-03-04 15:21:48');
INSERT INTO `permissions` VALUES ('6', 'View Waste Watch Chart', 'view_waste_watch_chart', 'Dashboard', 'Can view Waste Watch Report Ranking chart', 'active', 'chart', '2026-03-04 15:21:48', '2026-03-04 15:21:48');
INSERT INTO `permissions` VALUES ('7', 'Filter Waste Watch Chart', 'filter_waste_watch_chart', 'Dashboard', 'Can filter Waste Watch chart by time (Today, This Week, This Month)', 'active', 'chart', '2026-03-04 15:21:48', '2026-03-04 15:21:48');
INSERT INTO `permissions` VALUES ('8', 'View Recent Activity', 'view_recent_activity', 'Dashboard', 'Can view Recent Activity section', 'active', 'eye', '2026-03-04 15:21:48', '2026-03-04 15:21:48');
INSERT INTO `permissions` VALUES ('9', 'View Quick Actions', 'view_quick_actions', 'Dashboard', 'Can view Quick Actions section', 'active', 'eye', '2026-03-04 15:21:48', '2026-03-04 15:21:48');
INSERT INTO `permissions` VALUES ('10', 'Use Quick Action - Approve Users', 'use_quick_action_approve_users', 'Dashboard', 'Can use \'Approve Users\' quick action button', 'active', 'check', '2026-03-04 15:21:48', '2026-03-04 15:21:48');
INSERT INTO `permissions` VALUES ('11', 'Use Quick Action - Create Announcement', 'use_quick_action_create_announcement', 'Dashboard', 'Can use \'Create Announcement\' quick action button', 'active', 'plus', '2026-03-04 15:21:48', '2026-03-04 15:21:48');
INSERT INTO `permissions` VALUES ('12', 'Use Quick Action - View Analytics', 'use_quick_action_view_analytics', 'Dashboard', 'Can use \'View Analytics\' quick action button', 'active', 'chart', '2026-03-04 15:21:48', '2026-03-04 15:21:48');
INSERT INTO `permissions` VALUES ('13', 'View User Management Module', 'view_user_management_module', 'User Management', 'Can access the User Management page', 'active', 'users', '2026-03-04 15:21:48', '2026-03-04 15:21:48');
INSERT INTO `permissions` VALUES ('14', 'View Users List', 'view_users_list', 'User Management', 'Can view the users list/table', 'active', 'eye', '2026-03-04 15:21:48', '2026-03-04 15:21:48');
INSERT INTO `permissions` VALUES ('15', 'Search Users', 'search_users', 'User Management', 'Can search and filter users', 'active', 'eye', '2026-03-04 15:21:48', '2026-03-04 15:21:48');
INSERT INTO `permissions` VALUES ('16', 'View User Details', 'view_user_details', 'User Management', 'Can view detailed user information in modal', 'active', 'eye', '2026-03-04 15:21:48', '2026-03-04 15:21:48');
INSERT INTO `permissions` VALUES ('17', 'View User Documents', 'view_user_documents', 'User Management', 'Can view uploaded user documents', 'active', 'document', '2026-03-04 15:21:48', '2026-03-04 15:21:48');
INSERT INTO `permissions` VALUES ('18', 'Add New User', 'add_new_user', 'User Management', 'Can create new Admin/Staff user accounts', 'active', 'plus', '2026-03-04 15:21:48', '2026-03-04 15:21:48');
INSERT INTO `permissions` VALUES ('19', 'Edit User', 'edit_user', 'User Management', 'Can edit user information (Admin/Staff only)', 'active', 'pencil', '2026-03-04 15:21:48', '2026-03-04 15:21:48');
INSERT INTO `permissions` VALUES ('20', 'Delete User', 'delete_user', 'User Management', 'Can delete user accounts', 'active', 'trash', '2026-03-04 15:21:48', '2026-03-04 15:21:48');
INSERT INTO `permissions` VALUES ('21', 'Approve User', 'approve_user', 'User Management', 'Can approve pending user registrations', 'active', 'check', '2026-03-04 15:21:48', '2026-03-04 15:21:48');
INSERT INTO `permissions` VALUES ('22', 'Reject User', 'reject_user', 'User Management', 'Can reject pending user registrations', 'active', 'trash', '2026-03-04 15:21:48', '2026-03-04 15:21:48');
INSERT INTO `permissions` VALUES ('23', 'Reset User Password', 'reset_user_password', 'User Management', 'Can reset user passwords', 'active', 'lock', '2026-03-04 15:21:48', '2026-03-04 15:21:48');
INSERT INTO `permissions` VALUES ('24', 'Generate Temporary Password', 'generate_temporary_password', 'User Management', 'Can generate temporary passwords for users', 'active', 'cog', '2026-03-04 15:21:48', '2026-03-04 15:21:48');
INSERT INTO `permissions` VALUES ('25', 'Export Users', 'export_users', 'User Management', 'Can export user data to CSV/Excel', 'active', 'download', '2026-03-04 15:21:48', '2026-03-04 15:21:48');
INSERT INTO `permissions` VALUES ('26', 'View Reports Management Module', 'view_reports_management_module', 'Reports Management', 'Can access the Reports Management page', 'active', 'document', '2026-03-04 15:21:48', '2026-03-04 15:21:48');
INSERT INTO `permissions` VALUES ('27', 'View Reports List', 'view_reports_list', 'Reports Management', 'Can view the reports list/table', 'active', 'eye', '2026-03-04 15:21:48', '2026-03-04 15:21:48');
INSERT INTO `permissions` VALUES ('28', 'Search Reports', 'search_reports', 'Reports Management', 'Can search and filter reports', 'active', 'eye', '2026-03-04 15:21:48', '2026-03-04 15:21:48');
INSERT INTO `permissions` VALUES ('29', 'View Report Details', 'view_report_details', 'Reports Management', 'Can view detailed report information in modal', 'active', 'eye', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('30', 'View Reporter Information', 'view_reporter_information', 'Reports Management', 'Can view reporter details (name, role, location)', 'active', 'user', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('31', 'View Evidence Photo', 'view_evidence_photo', 'Reports Management', 'Can view uploaded evidence photos', 'active', 'eye', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('32', 'View Staff Remarks', 'view_staff_remarks', 'Reports Management', 'Can read staff remarks and notes on reports', 'active', 'document', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('33', 'Start Report Processing', 'start_report_processing', 'Reports Management', 'Can change report status from Pending to In Progress', 'active', 'check', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('34', 'Resolve Report', 'resolve_report', 'Reports Management', 'Can mark reports as Resolved', 'active', 'check', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('35', 'Reject Report', 'reject_report', 'Reports Management', 'Can reject reports', 'active', 'trash', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('36', 'Add Staff Remarks', 'add_staff_remarks', 'Reports Management', 'Can add staff remarks/notes to reports', 'active', 'pencil', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('37', 'Filter Reports by Status', 'filter_reports_by_status', 'Reports Management', 'Can filter reports by status (Pending, In Progress, Resolved, Rejected)', 'active', 'eye', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('38', 'Filter Reports by Priority', 'filter_reports_by_priority', 'Reports Management', 'Can filter reports by priority level', 'active', 'eye', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('39', 'Export Reports', 'export_reports', 'Reports Management', 'Can export reports to PDF/Excel', 'active', 'download', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('40', 'View Announcements Module', 'view_announcements_module', 'Announcements', 'Can access the Announcements page', 'active', 'megaphone', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('41', 'View Announcements List', 'view_announcements_list', 'Announcements', 'Can view the announcements list/table', 'active', 'eye', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('42', 'Search Announcements', 'search_announcements', 'Announcements', 'Can search and filter announcements', 'active', 'eye', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('43', 'View Announcement Details', 'view_announcement_details', 'Announcements', 'Can view detailed announcement information in modal', 'active', 'eye', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('44', 'View Announcement Attachments', 'view_announcement_attachments', 'Announcements', 'Can view attached files in announcements', 'active', 'document', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('45', 'Create Announcement', 'create_announcement', 'Announcements', 'Can create new announcements', 'active', 'plus', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('46', 'Edit Announcement', 'edit_announcement', 'Announcements', 'Can edit existing announcements', 'active', 'pencil', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('47', 'Delete Announcement', 'delete_announcement', 'Announcements', 'Can delete announcements', 'active', 'trash', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('48', 'Set Announcement Priority', 'set_announcement_priority', 'Announcements', 'Can set priority level (Low, Moderate, Urgent)', 'active', 'check', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('49', 'Set Announcement Schedule', 'set_announcement_schedule', 'Announcements', 'Can set start date and end date for announcements', 'active', 'calendar', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('50', 'Filter Announcements by Status', 'filter_announcements_by_status', 'Announcements', 'Can filter announcements by Active/Inactive status', 'active', 'eye', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('51', 'Filter Announcements by Priority', 'filter_announcements_by_priority', 'Announcements', 'Can filter announcements by priority level', 'active', 'eye', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('52', 'View Routes Management Module', 'view_routes_module', 'Routes Management', 'Can access the Routes Management page for garbage collection routes', 'active', 'map', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('53', 'View Routes List', 'view_routes_list', 'Routes Management', 'Can view the routes list/table', 'active', 'eye', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('54', 'Search Routes', 'search_routes', 'Routes Management', 'Can search and filter routes by name, municipality, status', 'active', 'search', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('55', 'View Route Details', 'view_route_details', 'Routes Management', 'Can view detailed route information and statistics', 'active', 'eye', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('56', 'View Route on Map', 'view_route_on_map', 'Routes Management', 'Can view route visualization on interactive map', 'active', 'map', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('57', 'View Route Waypoints', 'view_route_waypoints', 'Routes Management', 'Can view waypoints (start, pickup points, end) of a route', 'active', 'eye', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('58', 'Create Route', 'create_route', 'Routes Management', 'Can create new garbage collection routes with waypoints', 'active', 'plus', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('59', 'Add Waypoint to Route', 'add_waypoint_to_route', 'Routes Management', 'Can add pickup points/waypoints to a route', 'active', 'plus', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('60', 'Edit Route', 'edit_route', 'Routes Management', 'Can edit route details (name, description, waypoints)', 'active', 'pencil', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('61', 'Delete Route', 'delete_route', 'Routes Management', 'Can delete routes permanently', 'active', 'trash', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('62', 'Change Route Status', 'change_route_status', 'Routes Management', 'Can activate or deactivate routes', 'active', 'toggle', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('63', 'View Route Statistics', 'view_route_statistics', 'Routes Management', 'Can view route distance, duration, and performance metrics', 'active', 'chart', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('64', 'Export Routes Data', 'export_routes_data', 'Routes Management', 'Can export routes data to file', 'active', 'download', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('65', 'Switch Map Style', 'switch_map_style', 'Routes Management', 'Can switch between different map styles (Standard, Satellite, Topo)', 'active', 'map', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('66', 'View Schedules Module', 'view_schedules_module', 'Schedules', 'Can access the Collection Schedules page', 'active', 'calendar', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('67', 'View Weekly Overview', 'view_weekly_overview', 'Schedules', 'Can view weekly schedule overview', 'active', 'eye', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('68', 'View Calendar View', 'view_calendar_view', 'Schedules', 'Can view schedules in calendar/monthly view', 'active', 'calendar', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('69', 'Switch View Mode', 'switch_view_mode', 'Schedules', 'Can toggle between List and Calendar view modes', 'active', 'eye', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('70', 'View Schedule Details', 'view_schedule_details', 'Schedules', 'Can view detailed schedule information in modal', 'active', 'eye', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('71', 'Bulk Create Schedules', 'bulk_create_schedules', 'Schedules', 'Can create multiple schedules (specific dates, week, month)', 'active', 'plus', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('72', 'Edit Schedule', 'edit_schedule', 'Schedules', 'Can edit existing schedules (route, date, time)', 'active', 'pencil', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('73', 'Cancel Schedule', 'cancel_schedule', 'Schedules', 'Can cancel schedules with reason', 'active', 'trash', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('74', 'Reactivate Schedule', 'reactivate_schedule', 'Schedules', 'Can reactivate cancelled or completed schedules', 'active', 'check', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('75', 'Mark Schedule as Completed', 'mark_schedule_completed', 'Schedules', 'Can mark schedules as completed', 'active', 'check', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('76', 'Filter Schedules by Day', 'filter_schedules_by_day', 'Schedules', 'Can filter schedules by day of the week', 'active', 'eye', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('77', 'View Analytics Module', 'view_analytics_module', 'Analytics', 'Can access the Analytics Dashboard page', 'active', 'chart', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('78', 'View Statistics Cards', 'view_statistics_cards', 'Analytics', 'Can view main statistics cards (Users, Reports, Announcements, Routes)', 'active', 'eye', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('79', 'View Most Active Reporters Chart', 'view_active_reporters_chart', 'Analytics', 'Can view Most Active Reporters pie chart', 'active', 'chart', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('80', 'View Infographics Reports Chart', 'view_infographics_chart', 'Analytics', 'Can view monthly report trends line chart', 'active', 'chart', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('81', 'View Quick Stats', 'view_quick_stats', 'Analytics', 'Can view quick statistics (Approval Rate, Response Time, Resolution, Active Users)', 'active', 'eye', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('82', 'Export Analytics Report', 'export_analytics_report', 'Analytics', 'Can export analytics data to file', 'active', 'download', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('83', 'Configure Analytics Settings', 'configure_analytics_settings', 'Analytics', 'Can access analytics settings and configuration', 'active', 'cog', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('84', 'View Roles Management Module', 'view_roles_management_module', 'Access Control', 'Can access the Roles Management page', 'active', 'shield', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('85', 'View Roles List', 'view_roles_list', 'Access Control', 'Can view the roles list/table', 'active', 'eye', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('86', 'Search Roles', 'search_roles', 'Access Control', 'Can search and filter roles', 'active', 'eye', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('87', 'View Role Details', 'view_role_details', 'Access Control', 'Can view detailed role information in modal', 'active', 'eye', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('88', 'View Role Permissions', 'view_role_permissions', 'Access Control', 'Can view permissions assigned to a role', 'active', 'shield', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('89', 'Create Role', 'create_role', 'Access Control', 'Can create new roles', 'active', 'plus', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('90', 'Edit Role', 'edit_role', 'Access Control', 'Can edit role name and description', 'active', 'pencil', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('91', 'Delete Role', 'delete_role', 'Access Control', 'Can delete non-system roles', 'active', 'trash', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('92', 'Manage Role Permissions', 'manage_role_permissions', 'Access Control', 'Can assign/remove permissions to/from roles', 'active', 'shield', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('93', 'View Permissions Management Module', 'view_permissions_management_module', 'Access Control', 'Can access the Permissions Management page', 'active', 'shield', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('94', 'View Permissions by Module', 'view_permissions_by_module', 'Access Control', 'Can view permissions grouped by module (card grid)', 'active', 'eye', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('95', 'View All Permissions Table', 'view_all_permissions_table', 'Access Control', 'Can view all permissions in table view', 'active', 'eye', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('96', 'Search Permissions', 'search_permissions', 'Access Control', 'Can search and filter permissions', 'active', 'eye', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('97', 'View Permission Details', 'view_permission_details', 'Access Control', 'Can view detailed permission information', 'active', 'eye', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('98', 'Create Permission', 'create_permission', 'Access Control', 'Can create new permissions', 'active', 'plus', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('99', 'Edit Permission', 'edit_permission', 'Access Control', 'Can edit permission details', 'active', 'pencil', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('100', 'Delete Permission', 'delete_permission', 'Access Control', 'Can delete permissions', 'active', 'trash', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('101', 'Change Permission Status', 'change_permission_status', 'Access Control', 'Can change permission status (active, maintenance, unavailable, bug)', 'active', 'cog', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('102', 'Assign Permission Icon', 'assign_permission_icon', 'Access Control', 'Can assign visual icons to permissions', 'active', 'cog', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('103', 'View Profile', 'view_profile', 'Profile', 'Can view own profile', 'active', 'eye', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('104', 'Edit Profile', 'edit_profile', 'Profile', 'Can edit own profile', 'active', 'pencil', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('105', 'Change Password', 'change_password', 'Profile', 'Can change own password', 'active', 'lock', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('106', 'View Notifications Module', 'view_notifications_module', 'Notifications', 'Can access the Notifications page', 'active', 'bell', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('107', 'View Notifications List', 'view_notifications_list', 'Notifications', 'Can view all notifications', 'active', 'eye', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('108', 'Search Notifications', 'search_notifications', 'Notifications', 'Can search notifications', 'active', 'eye', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('109', 'Filter Notifications by Status', 'filter_notifications_by_status', 'Notifications', 'Can filter by All/Unread/Read status', 'active', 'eye', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('110', 'Filter Notifications by Type', 'filter_notifications_by_type', 'Notifications', 'Can filter by type (Report, Account, Announcement, Schedule, System)', 'active', 'eye', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('111', 'View Notification Details', 'view_notification_details', 'Notifications', 'Can view full notification details', 'active', 'eye', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('112', 'Mark Notification as Read', 'mark_notification_read', 'Notifications', 'Can mark individual notification as read', 'active', 'check', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('113', 'Mark Notification as Unread', 'mark_notification_unread', 'Notifications', 'Can mark notification as unread', 'active', 'check', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('114', 'Mark All Notifications as Read', 'mark_all_notifications_read', 'Notifications', 'Can mark all notifications as read at once', 'active', 'check', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('115', 'Delete Notification', 'delete_notification', 'Notifications', 'Can delete individual notifications', 'active', 'trash', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('116', 'Configure Notification Settings', 'configure_notification_settings', 'Notifications', 'Can access notification settings and configuration', 'active', 'cog', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('117', 'Enable/Disable Notifications by Type', 'enable_disable_notifications_by_type', 'Notifications', 'Can enable/disable specific notification types', 'active', 'cog', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('118', 'Set Notification Recipients by Role', 'set_notification_recipients_by_role', 'Notifications', 'Can configure which roles receive specific notifications', 'active', 'users', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('119', 'View System Settings Module', 'view_system_settings_module', 'System Settings', 'Can access the System Settings page', 'active', 'cog', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('120', 'View General Settings Tab', 'view_general_settings_tab', 'System Settings', 'Can view general settings (site name, email, phone, etc.)', 'active', 'eye', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('121', 'Edit General Settings', 'edit_general_settings', 'System Settings', 'Can edit site name, tagline, email, phone, address, timezone, date/time format', 'active', 'pencil', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('122', 'View Maintenance Tab', 'view_maintenance_tab', 'System Settings', 'Can view site maintenance settings', 'active', 'eye', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('123', 'Enable/Disable Maintenance Mode', 'enable_disable_maintenance_mode', 'System Settings', 'Can toggle system-wide maintenance mode ON/OFF', 'active', 'cog', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('124', 'Edit Maintenance Message', 'edit_maintenance_message', 'System Settings', 'Can edit the maintenance mode message shown to users', 'active', 'pencil', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('125', 'View Database Tab', 'view_database_tab', 'System Settings', 'Can view database management settings', 'active', 'eye', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('126', 'Export Database', 'export_database', 'System Settings', 'Can export database backup', 'active', 'download', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('127', 'Import Database', 'import_database', 'System Settings', 'Can import database from file', 'active', 'download', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('128', 'Configure Auto Backup', 'configure_auto_backup', 'System Settings', 'Can enable/disable auto backup and set frequency/retention', 'active', 'cog', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('129', 'View Security Tab', 'view_security_tab', 'System Settings', 'Can view security and authentication settings', 'active', 'eye', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('130', 'Configure Session Settings', 'configure_session_settings', 'System Settings', 'Can configure session timeout and max login attempts', 'active', 'lock', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('131', 'Configure Password Policy', 'configure_password_policy', 'System Settings', 'Can set password requirements (length, uppercase, numbers, special chars, 2FA)', 'active', 'lock', '2026-03-04 15:21:49', '2026-03-04 15:21:49');
INSERT INTO `permissions` VALUES ('132', 'View Audit Trail Tab', 'view_audit_trail_tab', 'System Settings', 'Can view audit trail/activity logs', 'active', 'document', '2026-03-04 15:21:50', '2026-03-04 15:21:50');
INSERT INTO `permissions` VALUES ('133', 'View Audit Logs', 'view_audit_logs', 'System Settings', 'Can view all user activity logs (login, actions, modules, timestamps)', 'active', 'eye', '2026-03-04 15:21:50', '2026-03-04 15:21:50');
INSERT INTO `permissions` VALUES ('134', 'Export Audit Logs', 'export_audit_logs', 'System Settings', 'Can export audit trail data', 'active', 'download', '2026-03-04 15:21:50', '2026-03-04 15:21:50');


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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `purok_leaders` VALUES ('1', '4', 'https://placehold.co/600x400/e3f2fd/1976d2?text=Valid+ID+-+Juan+Dela+Cruz', '2025-09-14 14:20:00', '2025-09-14 14:20:00');
INSERT INTO `purok_leaders` VALUES ('2', '6', 'https://placehold.co/600x400/e3f2fd/1976d2?text=Valid+ID+-+Maria+Santos', '2025-08-20 13:45:00', '2025-08-20 13:45:00');
INSERT INTO `purok_leaders` VALUES ('3', '8', 'https://placehold.co/600x400/e3f2fd/1976d2?text=Valid+ID+-+Ana+Garcia', '2025-09-10 15:00:00', '2025-09-10 15:00:00');
INSERT INTO `purok_leaders` VALUES ('4', '10', 'https://randomuser.me/api/portraits/men/10.jpg', '2026-03-04 15:56:46', '2026-03-04 15:56:46');


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

INSERT INTO `reports` VALUES ('1', 'RPT-001', '4', 'Juan Dela Cruz', 'Purok Leader', 'Poblacion', 'Purok 5', 'Moderate', 'Resolved', 'Garbage was not collected on the scheduled day. Waste has started to accumulate and needs immediate attention', 'report-photo-001.jpg', '2025-09-20', 'Issue has been addressed and resolved', '1', 'Changed status to Resolved - waste collected successfully', '2025-09-22', '2025-09-20 08:00:00', '2026-03-05 04:15:53', NULL);
INSERT INTO `reports` VALUES ('2', 'RPT-002', '5', 'Jonathan G. Buslon', 'Business Owner', 'Poblacion', 'Purok 7', 'Low', 'Pending', 'Someone is dumping waste in unauthorized area near my business', 'report-photo-002.jpg', '2025-09-01', NULL, NULL, NULL, NULL, '2025-09-01 11:15:00', '2025-09-01 11:15:00', NULL);
INSERT INTO `reports` VALUES ('3', 'RPT-003', '6', 'Maria Santos', 'Purok Leader', 'Poblacion', 'Purok 1', 'Urgent', 'In Progress', 'Waste collection has been missed for 3 consecutive days. Emergency attention needed.', 'report-photo-003.jpg', '2025-09-18', 'Team dispatched to the area.', NULL, NULL, NULL, '2025-09-18 09:00:00', '2025-09-18 14:20:00', NULL);
INSERT INTO `reports` VALUES ('4', 'RPT-004', '7', 'Pedro Reyes', 'Business Owner', 'Poblacion', 'Purok 3', 'Moderate', 'Resolved', 'Public waste bin is overflowing and creating health hazard', 'report-photo-004.jpg', '2025-09-15', 'Bin emptied and cleaned.', NULL, NULL, '2025-09-16', '2025-09-15 10:30:00', '2025-09-16 08:45:00', NULL);
INSERT INTO `reports` VALUES ('5', 'RPT-005', '4', 'Juan Dela Cruz', 'Purok Leader', 'Poblacion', 'Purok 5', 'Low', 'Rejected', 'Missed pickup reported but location was unclear', 'report-photo-005.jpg', '2025-09-10', 'Unable to locate. Please provide specific address.', NULL, NULL, NULL, '2025-09-10 13:00:00', '2025-09-11 09:15:00', NULL);
INSERT INTO `reports` VALUES ('6', 'RPT-006', '6', 'Maria Santos', 'Purok Leader', 'Poblacion', 'Purok 1', 'Urgent', 'In Progress', 'Large amount of construction waste dumped illegally', 'report-photo-006.jpg', '2025-09-22', 'Investigation ongoing.', NULL, NULL, NULL, '2025-09-22 07:30:00', '2025-09-22 15:45:00', NULL);


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
) ENGINE=InnoDB AUTO_INCREMENT=204 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `roles` VALUES ('1', 'Admin', 'admin', 'Full system access with all permissions', '2', '1', '2026-03-04 15:21:50', '2026-03-04 15:21:50');
INSERT INTO `roles` VALUES ('2', 'Staff', 'staff', 'Limited access for staff members - can view, create, and edit but cannot delete', '3', '1', '2026-03-04 15:21:50', '2026-03-04 15:21:50');


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

INSERT INTO `routes` VALUES ('1', 'ROUTE-001', 'Updated Route Name', 'Main route covering central Trinidad barangays', 'Trinidad', 'Bohol', 'under_maintenance', '#3B82F6', '[{\"id\": \"WP-001\", \"lat\": 10.07970689760644, \"lng\": 124.34302082673474, \"name\": \"Trinidad Municipal Hall\", \"type\": \"start\", \"order\": 1, \"address\": \"Trinidad Municipal Hall, Trinidad, Bohol\", \"barangay\": \"Poblacion\"}, {\"id\": \"WP-002\", \"lat\": 10.04497959694381, \"lng\": 124.40353977145442, \"name\": \"Barangay CATOOGAN\", \"type\": \"pickup\", \"order\": 2, \"address\": \"Barangay CATOOGAN, Trinidad, Bohol\", \"barangay\": \"CATOOGAN\"}, {\"id\": \"WP-003\", \"lat\": 10.073609975988091, \"lng\": 124.3562811698296, \"name\": \"Barangay Guinobatan\", \"type\": \"pickup\", \"order\": 3, \"address\": \"Barangay Guinobatan, Trinidad, Bohol\", \"barangay\": \"Guinobatan\"}, {\"id\": \"WP-004\", \"lat\": 10.033511206800622, \"lng\": 124.25979675660412, \"name\": \"Barangay Kauswagan\", \"type\": \"pickup\", \"order\": 4, \"address\": \"Barangay Kauswagan, Trinidad, Bohol\", \"barangay\": \"Kauswagan\"}, {\"id\": \"WP-005\", \"lat\": 10.064948400829833, \"lng\": 124.32686535742056, \"name\": \"Trinidad Disposal Facility\", \"type\": \"end\", \"order\": 5, \"address\": \"Waste Disposal Facility, Trinidad, Bohol\", \"barangay\": \"Poblacion\"}]', '12.5 km', '45 minutes', '1', '2026-03-01 08:00:00', '2026-03-05 04:40:53', NULL);
INSERT INTO `routes` VALUES ('2', 'ROUTE-002', 'Trinidad North Route', 'Northern barangays coverage', 'Trinidad', 'Bohol', 'active', '#10B981', '[{\"id\": \"WP-006\", \"lat\": 10.0797, \"lng\": 124.3445, \"name\": \"Trinidad Municipal Hall\", \"type\": \"start\", \"order\": 1, \"address\": \"Trinidad Municipal Hall, Poblacion, Trinidad, Bohol\", \"barangay\": \"Poblacion\"}, {\"id\": \"WP-007\", \"lat\": 10.0962, \"lng\": 124.3578, \"name\": \"Barangay Banlasan\", \"type\": \"pickup\", \"order\": 2, \"address\": \"Barangay Banlasan, Trinidad, Bohol\", \"barangay\": \"Banlasan\"}, {\"id\": \"WP-008\", \"lat\": 10.1045, \"lng\": 124.3661, \"name\": \"Barangay La Union\", \"type\": \"pickup\", \"order\": 3, \"address\": \"Barangay La Union, Trinidad, Bohol\", \"barangay\": \"La Union\"}, {\"id\": \"WP-009\", \"lat\": 10.1128, \"lng\": 124.3743, \"name\": \"Barangay Mahagbu\", \"type\": \"pickup\", \"order\": 4, \"address\": \"Barangay Mahagbu, Trinidad, Bohol\", \"barangay\": \"Mahagbu\"}, {\"id\": \"WP-010\", \"lat\": 10.0723, \"lng\": 124.3529, \"name\": \"Trinidad Disposal Facility\", \"type\": \"end\", \"order\": 5, \"address\": \"Waste Disposal Facility, Trinidad, Bohol\", \"barangay\": \"Poblacion\"}]', '18.3 km', '65 minutes', '1', '2026-03-01 08:30:00', '2026-03-03 22:00:00', NULL);
INSERT INTO `routes` VALUES ('3', 'ROUTE-003', 'Trinidad South Route', 'Southern barangays and nearby areas', 'Trinidad', 'Bohol', 'active', '#F59E0B', '[{\"id\": \"WP-011\", \"lat\": 10.0797, \"lng\": 124.3445, \"name\": \"Trinidad Municipal Hall\", \"type\": \"start\", \"order\": 1, \"address\": \"Trinidad Municipal Hall, Poblacion, Trinidad, Bohol\", \"barangay\": \"Poblacion\"}, {\"id\": \"WP-012\", \"lat\": 10.0614, \"lng\": 124.3562, \"name\": \"Barangay Kinan\", \"type\": \"pickup\", \"order\": 2, \"address\": \"Barangay Kinan, Trinidad, Bohol\", \"barangay\": \"Kinan\"}, {\"id\": \"WP-013\", \"lat\": 10.0528, \"lng\": 124.3654, \"name\": \"Barangay Hinlayagan Ilaud\", \"type\": \"pickup\", \"order\": 3, \"address\": \"Barangay Hinlayagan Ilaud, Trinidad, Bohol\", \"barangay\": \"Hinlayagan Ilaud\"}, {\"id\": \"WP-014\", \"lat\": 10.0437, \"lng\": 124.3728, \"name\": \"Barangay Santo Niño\", \"type\": \"pickup\", \"order\": 4, \"address\": \"Barangay Santo Niño, Trinidad, Bohol\", \"barangay\": \"Santo Niño\"}, {\"id\": \"WP-015\", \"lat\": 10.0723, \"lng\": 124.3529, \"name\": \"Trinidad Disposal Facility\", \"type\": \"end\", \"order\": 5, \"address\": \"Waste Disposal Facility, Trinidad, Bohol\", \"barangay\": \"Poblacion\"}]', '15.7 km', '55 minutes', '1', '2026-03-01 09:00:00', '2026-03-03 22:00:00', NULL);
INSERT INTO `routes` VALUES ('4', 'ROUTE-004', 'Trinidad East Route', 'Eastern barangays coverage', 'Trinidad', 'Bohol', 'active', '#EF4444', '[{\"id\": \"WP-016\", \"lat\": 10.0797, \"lng\": 124.3445, \"name\": \"Start Point\", \"type\": \"start\", \"order\": 1, \"address\": \"Start Address\", \"barangay\": \"Poblacion\"}, {\"id\": \"WP-017\", \"lat\": 10.085, \"lng\": 124.35, \"name\": \"Pickup Point 1\", \"type\": \"pickup\", \"order\": 2, \"address\": \"Pickup Address\", \"barangay\": \"Barangay Name\"}, {\"id\": \"WP-018\", \"lat\": 10.0723, \"lng\": 124.3529, \"name\": \"End Point\", \"type\": \"end\", \"order\": 3, \"address\": \"End Address\", \"barangay\": \"Poblacion\"}]', '10.2 km', '40 minutes', '1', '2026-03-05 04:40:30', '2026-03-05 04:41:15', '2026-03-05 04:41:15');


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

INSERT INTO `schedules` VALUES ('1', 'SCH-001', '1', 'Monday', '2026-03-08', '06:00:00', '14:30:00', 'active', NULL, '[{\"time\": \"06:00 AM\", \"status\": \"start\", \"location\": \"Municipal Hall\"}, {\"time\": \"06:30 AM\", \"status\": \"ongoing\", \"location\": \"Mundal Bhouse\"}, {\"time\": \"07:00 AM\", \"status\": \"ongoing\", \"location\": \"TMC via Park in Go\"}, {\"time\": \"07:30 AM\", \"status\": \"ongoing\", \"location\": \"TCES\"}, {\"time\": \"08:00 AM\", \"status\": \"ongoing\", \"location\": \"Brgy.Hall\"}, {\"time\": \"08:30 AM\", \"status\": \"ongoing\", \"location\": \"Arlene Carenderia\"}, {\"time\": \"09:00 AM\", \"status\": \"ongoing\", \"location\": \"Public Market\"}, {\"time\": \"09:30 AM\", \"status\": \"ongoing\", \"location\": \"Municipal Hall Annex\"}, {\"time\": \"10:00 AM\", \"status\": \"ongoing\", \"location\": \"Cultural Center\"}, {\"time\": \"10:30 AM\", \"status\": \"ongoing\", \"location\": \"PENGAVITOR Ent.\"}, {\"time\": \"11:00 AM\", \"status\": \"ongoing\", \"location\": \"Sumatra Res.\"}, {\"time\": \"11:30 AM\", \"status\": \"ongoing\", \"location\": \"F. Gonzales Res\"}, {\"time\": \"12:00 PM\", \"status\": \"ongoing\", \"location\": \"SIA\"}, {\"time\": \"12:30 PM\", \"status\": \"ongoing\", \"location\": \"Shoppers Mart\"}, {\"time\": \"01:00 PM\", \"status\": \"finish\", \"location\": \"RCA/MRF\"}, {\"time\": \"01:30 PM\", \"status\": \"ongoing\", \"location\": \"Crossing Candi Store\"}, {\"time\": \"02:00 PM\", \"status\": \"ongoing\", \"location\": \"Panab an\"}, {\"time\": \"02:30 PM\", \"status\": \"ongoing\", \"location\": \"Entrance SM\"}]', NULL, '1', '2', '2026-03-01 10:00:00', '2026-03-05 04:52:16', NULL);
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

INSERT INTO `system_settings` VALUES ('1', 'maintenance_mode', 'false', 'boolean', 'Enable or disable system maintenance mode', '2026-03-05 05:16:52', '2026-03-05 05:16:52');
INSERT INTO `system_settings` VALUES ('2', 'maintenance_message', 'System is currently under maintenance. Please check back later.', 'string', 'Maintenance mode message', '2026-03-05 05:16:52', '2026-03-05 05:16:52');


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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `users` VALUES ('1', 'admin@purecycle.com', '$2y$12$1zvkUtFpd1DqsooidM7QeuXteCCjVjAC9jP/4EafQgHVr4Z4h759S', 'Josh Gracxiosa', '09769783746', 'Trinidad', 'Tagum Norte', 'Purok 7', 'admin', 'https://randomuser.me/api/portraits/men/1.jpg', 'approved', NULL, NULL, '2025-01-01 08:00:00', '2025-01-01 08:00:00');
INSERT INTO `users` VALUES ('2', 'staff@purecycle.com', '$2y$12$uA60lEHO.zIP8bksyiQ0LeOHwNQq0izmnWi4ZJgnIctaqSeMhLXOW', 'Everly Santos', '09123456789', 'Tagbilaran City', NULL, NULL, 'staff', 'https://randomuser.me/api/portraits/women/2.jpg', 'approved', NULL, NULL, '2025-01-15 09:30:00', '2025-01-15 09:30:00');
INSERT INTO `users` VALUES ('3', 'maria.staff@purecycle.com', '$2y$12$zZ8t/QBUbFKzJHfmvCy7JeGv3TWu0VKYIk.PzkjaZvenbvrJHWwem', 'Maria Garcia', '09987654321', 'Tagbilaran City', NULL, NULL, 'staff', 'https://randomuser.me/api/portraits/women/3.jpg', 'approved', NULL, NULL, '2025-02-01 10:00:00', '2025-02-01 10:00:00');
INSERT INTO `users` VALUES ('4', 'juan@gmail.com', '$2y$12$beoTScZbQ3oUOpONQDvcP.JMOn31GY2JOudTP/CId3rXMBzWdh.qO', 'Juan Dela Cruz', '09876758498', 'Tagbilaran City', 'Cogon', 'Purok 5', 'purok_leader', 'https://randomuser.me/api/portraits/men/4.jpg', 'approved', NULL, NULL, '2025-09-14 14:20:00', '2025-09-14 14:20:00');
INSERT INTO `users` VALUES ('5', 'jonathan@gmail.com', '$2y$12$t9fdIVoQpEaxQ4wKeS8Dle.5xNC5iKumkf46BJkQ3MJnFPdl1yVBi', 'Jonathan G. Buslon', '09507306781', 'Tagbilaran City', 'Poblacion I', 'Purok 7', 'business_owner', 'https://randomuser.me/api/portraits/men/5.jpg', 'pending', NULL, NULL, '2025-09-01 11:15:00', '2025-09-01 11:15:00');
INSERT INTO `users` VALUES ('6', 'maria.santos@gmail.com', '$2y$12$iCnI99pK0eqVKIvif7ezZuux00RMauKe0cqDNO25lKWCpKfxiA4Tq', 'Maria Santos', '09123456789', 'Alburquerque', 'East Poblacion', 'Purok 1', 'purok_leader', 'https://randomuser.me/api/portraits/women/6.jpg', 'approved', NULL, NULL, '2025-08-20 13:45:00', '2025-08-20 13:45:00');
INSERT INTO `users` VALUES ('7', 'pedro.reyes@gmail.com', '$2y$12$dQopXOOKTDKcY185JwZ47eKu8FJ6RU84CV9yIROTZHwWASoBvgLZK', 'Pedro Reyes', '09234567890', 'Alicia', 'Poblacion', 'Purok 3', 'business_owner', 'https://randomuser.me/api/portraits/men/7.jpg', 'approved', NULL, NULL, '2025-08-15 10:30:00', '2025-08-15 10:30:00');
INSERT INTO `users` VALUES ('8', 'ana.garcia@gmail.com', '$2y$12$cNyiPPfT48Rviruk6X.Pwey/9YHi02F2cqmmQR5ntehJOmwRnPEBK', 'Ana Garcia', '09345678901', 'Tagbilaran City', 'Dampas', 'Purok 2', 'purok_leader', 'https://randomuser.me/api/portraits/women/8.jpg', 'rejected', NULL, NULL, '2025-09-10 15:00:00', '2025-09-10 15:00:00');
INSERT INTO `users` VALUES ('9', 'carlos@gmail.com', '$2y$12$aZIe/WIRvbSopXrUtJdVUeqaP.I6WFhCfj7vj4CL.VuoMEKju7N16', 'Carlos Mendoza', '09456789012', 'Alburquerque', 'Toril', 'Purok 4', 'business_owner', 'https://randomuser.me/api/portraits/men/9.jpg', 'suspended', NULL, NULL, '2025-07-05 09:00:00', '2025-07-05 09:00:00');
INSERT INTO `users` VALUES ('10', 'newuser@example.com', '$2y$12$XGsZVV478tTtk9rdR0ipd.1Tt0JeYJOdh067IMfos7hjgeW5aWaH.', 'John Doe', '09123456789', 'Tagbilaran City', 'Poblacion', 'Purok 1', 'purok_leader', NULL, 'pending', NULL, NULL, '2026-03-04 15:56:46', '2026-03-04 15:56:46');

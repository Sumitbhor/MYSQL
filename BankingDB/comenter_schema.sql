-- =============================================
-- Database: tflcomentor_db
-- Complete Schema with All Tables
-- =============================================

CREATE DATABASE IF NOT EXISTS `tflcomentor_db` 
/*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ 
/*!80016 DEFAULT ENCRYPTION='N' */;

USE `tflcomentor_db`;

-- =============================================
-- 1. CORE TABLES (Users, Roles, Authentication)
-- =============================================

-- Users table - authentication and status
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `contact` varchar(15) DEFAULT NULL,
  `password` text,
  `status` enum('ACTIVE','INACTIVE','BLOCKED') DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
);

-- Roles table
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `role_id` int NOT NULL AUTO_INCREMENT,
  `role_name` varchar(100) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`role_id`)
);

-- User Roles junction table
DROP TABLE IF EXISTS `user_roles`;
CREATE TABLE `user_roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `role_id` int DEFAULT NULL,
  `assigned_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `user_roles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `user_roles_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`)
);

-- Personal Information table
DROP TABLE IF EXISTS `personal_informations`;
CREATE TABLE `personal_informations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `full_name` varchar(255) GENERATED ALWAYS AS (concat(`first_name`,_utf8mb4' ',`last_name`)) STORED,
  `gender` enum('MALE','FEMALE') DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `pincode` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `personal_informations_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
);

-- Academic Information table
DROP TABLE IF EXISTS `academic_informations`;
CREATE TABLE `academic_informations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `stream_name` varchar(100) DEFAULT NULL,
  `specialization` varchar(100) DEFAULT NULL,
  `enrollment_year` int DEFAULT NULL,
  `passing_year` int DEFAULT NULL,
  `percentage` decimal(5,2) DEFAULT NULL,
  `college_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `academic_informations_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
);

-- Professional Information table
DROP TABLE IF EXISTS `professional_informations`;
CREATE TABLE `professional_informations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `company_name` varchar(255) DEFAULT NULL,
  `job_title` varchar(100) DEFAULT NULL,
  `employment_type` enum('FULL_TIME','PART_TIME','INTERNSHIP') DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `is_current_job` tinyint(1) DEFAULT NULL,
  `experience_years` int DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  `skills` text,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `professional_informations_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
);

-- User Logs table
DROP TABLE IF EXISTS `user_logs`;
CREATE TABLE `user_logs` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint DEFAULT NULL,
  `login_time` datetime DEFAULT NULL,
  `logout_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- =============================================
-- 2. TECHNICAL FRAMEWORK TABLES
-- =============================================

-- Runtimes table
DROP TABLE IF EXISTS `runtimes`;
CREATE TABLE `runtimes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `runtime_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- Languages table
DROP TABLE IF EXISTS `languages`;
CREATE TABLE `languages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `language` varchar(100) DEFAULT NULL,
  `runtime_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `runtime_id` (`runtime_id`),
  CONSTRAINT `languages_ibfk_1` FOREIGN KEY (`runtime_id`) REFERENCES `runtimes` (`id`)
);

-- Layers table
DROP TABLE IF EXISTS `layers`;
CREATE TABLE `layers` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `layers` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- Frameworks table
DROP TABLE IF EXISTS `frameworks`;
CREATE TABLE `frameworks` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `layer_id` bigint DEFAULT NULL,
  `language_id` int DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- Concepts table
DROP TABLE IF EXISTS `concepts`;
CREATE TABLE `concepts` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `status` varchar(50) NOT NULL DEFAULT 'active',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
);

-- Framework-Concepts junction table
DROP TABLE IF EXISTS `framework_concepts`;
CREATE TABLE `framework_concepts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `framework_id` int DEFAULT NULL,
  `concept_id` int DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- =============================================
-- 3. ASSESSMENT & TESTING TABLES
-- =============================================

-- Questions table
DROP TABLE IF EXISTS `questions`;
CREATE TABLE `questions` (
  `question_id` bigint NOT NULL AUTO_INCREMENT,
  `description` text,
  `question_type` varchar(255) DEFAULT NULL,
  `difficulty_level` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`question_id`)
);

-- MCQ Options table
DROP TABLE IF EXISTS `mcq_options`;
CREATE TABLE `mcq_options` (
  `id` int NOT NULL AUTO_INCREMENT,
  `option_a` varchar(255) DEFAULT NULL,
  `option_b` varchar(255) DEFAULT NULL,
  `option_c` varchar(255) DEFAULT NULL,
  `option_d` varchar(255) DEFAULT NULL,
  `correct_answer` varchar(10) DEFAULT NULL,
  `question_id` int DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- Problem Statements table
DROP TABLE IF EXISTS `problem_statements`;
CREATE TABLE `problem_statements` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `question_id` int DEFAULT NULL,
  `description` text,
  `duration` int DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- Problem Statement Answers table
DROP TABLE IF EXISTS `problem_statement_answers`;
CREATE TABLE `problem_statement_answers` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `answer` text,
  `question_id` bigint DEFAULT NULL,
  `submitted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- Hands On table
DROP TABLE IF EXISTS `hands_on`;
CREATE TABLE `hands_on` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `question_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  `description` text,
  `duration` int DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- Hands On Results table
DROP TABLE IF EXISTS `hands_on_results`;
CREATE TABLE `hands_on_results` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `hands_on_id` int DEFAULT NULL,
  `score` int DEFAULT NULL,
  `sme_id` bigint DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `submitted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- Hands On Submissions table
DROP TABLE IF EXISTS `hands_on_submissions`;
CREATE TABLE `hands_on_submissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `hands_on_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  `github_link` varchar(255) DEFAULT NULL,
  `submitted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- Tests table
DROP TABLE IF EXISTS `tests`;
CREATE TABLE `tests` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `sme_id` bigint DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `duration` int DEFAULT NULL,
  `description` text,
  `difficulty` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- Test Questions junction table
DROP TABLE IF EXISTS `test_questions`;
CREATE TABLE `test_questions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `test_id` bigint DEFAULT NULL,
  `question_id` bigint DEFAULT NULL,
  `sequence_order` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKk171b2q5ikck3f9yk4n9lbyvw` (`question_id`),
  KEY `FKq1jpgjcbjbulxvhdkctcxhg12` (`test_id`),
  CONSTRAINT `FKk171b2q5ikck3f9yk4n9lbyvw` FOREIGN KEY (`question_id`) REFERENCES `questions` (`question_id`),
  CONSTRAINT `FKq1jpgjcbjbulxvhdkctcxhg12` FOREIGN KEY (`test_id`) REFERENCES `tests` (`id`)
);

-- Assessments table
DROP TABLE IF EXISTS `assessments`;
CREATE TABLE `assessments` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `test_id` bigint DEFAULT NULL,
  `student_id` bigint DEFAULT NULL,
  `assigned_by` bigint DEFAULT NULL,
  `assigned_at` datetime DEFAULT NULL,
  `scheduled_at` datetime DEFAULT NULL,
  `status` enum('Assigned','Pending','Completed') NOT NULL DEFAULT 'Pending',
  PRIMARY KEY (`id`)
);

-- Student Assessment Results table
DROP TABLE IF EXISTS `student_assessment_results`;
CREATE TABLE `student_assessment_results` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_id` int DEFAULT NULL,
  `assessment_id` int DEFAULT NULL,
  `score` float DEFAULT NULL,
  `percentile` float DEFAULT NULL,
  `time_taken_minutes` int DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- Question Framework Concepts junction
DROP TABLE IF EXISTS `question_framework_concepts`;
CREATE TABLE `question_framework_concepts` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `question_id` bigint DEFAULT NULL,
  `framework_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- =============================================
-- 4. ORAL ASSESSMENT TABLES
-- =============================================

-- Oral Assessments table
DROP TABLE IF EXISTS `oral_assessments`;
CREATE TABLE `oral_assessments` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `student_id` bigint DEFAULT NULL,
  `sme_id` bigint DEFAULT NULL,
  `time_schedule_at` datetime DEFAULT NULL,
  `status` enum('In_progress','Pending','Completed') DEFAULT NULL,
  `concept_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- Oral Question Answers table
DROP TABLE IF EXISTS `oral_question_answers`;
CREATE TABLE `oral_question_answers` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `questions` text,
  `student_id` bigint DEFAULT NULL,
  `answer` text,
  `rating` enum('poor','good','very_good','excellent','worst') DEFAULT NULL,
  `sme_id` bigint DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- =============================================
-- 5. MENTORING TABLES
-- =============================================

-- Mentor-Mentees relationship
DROP TABLE IF EXISTS `mentor_mentees`;
CREATE TABLE `mentor_mentees` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mentor_id` int DEFAULT NULL,
  `mentee_id` int DEFAULT NULL,
  `assigned_on` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mentor_id` (`mentor_id`),
  KEY `mentee_id` (`mentee_id`),
  CONSTRAINT `mentor_mentees_ibfk_1` FOREIGN KEY (`mentor_id`) REFERENCES `users` (`id`),
  CONSTRAINT `mentor_mentees_ibfk_2` FOREIGN KEY (`mentee_id`) REFERENCES `users` (`id`)
);

-- Mentor Appointments table
DROP TABLE IF EXISTS `mentor_appointments`;
CREATE TABLE `mentor_appointments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_id` int DEFAULT NULL,
  `mentor_id` int DEFAULT NULL,
  `appointment_date` date DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `status` enum('SCHEDULED','CANCELLED','COMPLETED') DEFAULT NULL,
  `meeting_link` varchar(255) DEFAULT NULL,
  `agenda` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- Mentor Counselings table
DROP TABLE IF EXISTS `mentor_counselings`;
CREATE TABLE `mentor_counselings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mentor_id` int DEFAULT NULL,
  `mentee_id` int DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `subject` varchar(100) DEFAULT NULL,
  `meeting_link` varchar(255) DEFAULT NULL,
  `counseling_date` datetime DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- Mentor Feedbacks table
DROP TABLE IF EXISTS `mentor_feedbacks`;
CREATE TABLE `mentor_feedbacks` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `mentor_id` bigint DEFAULT NULL,
  `student_id` bigint DEFAULT NULL,
  `rating` int DEFAULT NULL,
  `review_text` text,
  `created_at` datetime DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- =============================================
-- 6. LEARNING PATH TABLES
-- =============================================

-- Learning Paths table
DROP TABLE IF EXISTS `learning_paths`;
CREATE TABLE `learning_paths` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `mentor_id` bigint DEFAULT NULL,
  `title` varchar(200) DEFAULT NULL,
  `description` text,
  `duration` int DEFAULT NULL,
  `total_modules` int DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- Learning Path Progress table
DROP TABLE IF EXISTS `learning_path_progress`;
CREATE TABLE `learning_path_progress` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `student_id` bigint DEFAULT NULL,
  `overall_score` decimal(6,2) DEFAULT NULL,
  `average_percentage` decimal(6,2) DEFAULT NULL,
  `improvement_rate` decimal(5,2) DEFAULT NULL,
  `performance_level_id` bigint DEFAULT NULL,
  `min_score` int DEFAULT NULL,
  `max_score` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `student_id` (`student_id`)
);

-- Student Concept Progress table
DROP TABLE IF EXISTS `student_concept_progress`;
CREATE TABLE `student_concept_progress` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `student_id` bigint DEFAULT NULL,
  `concept_id` bigint DEFAULT NULL,
  `status` enum('In_progress','Pending','Completed') DEFAULT NULL,
  `initiated_at` datetime DEFAULT NULL,
  `completed_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- Learning Resources table
DROP TABLE IF EXISTS `learning_resources`;
CREATE TABLE `learning_resources` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `description` text,
  `resource_url` varchar(255) DEFAULT NULL,
  `type` enum('VIDEO','DOC','LINK') DEFAULT NULL,
  `uploaded_by` bigint DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- =============================================
-- 7. PROJECT TABLES
-- =============================================

-- Projects table
DROP TABLE IF EXISTS `projects`;
CREATE TABLE `projects` (
  `project_id` bigint NOT NULL AUTO_INCREMENT,
  `mentor_id` bigint DEFAULT NULL,
  `project_name` varchar(255) DEFAULT NULL,
  `description` text,
  `repository_url` varchar(255) DEFAULT NULL,
  `status` enum('In_progress','Pending','Completed') DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`project_id`)
);

-- Project Members table
DROP TABLE IF EXISTS `project_members`;
CREATE TABLE `project_members` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `project_id` bigint DEFAULT NULL,
  `student_id` bigint DEFAULT NULL,
  `joined_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- =============================================
-- 8. EMPLOYMENT & REFERRAL TABLES
-- =============================================

-- Companies table
DROP TABLE IF EXISTS `companies`;
CREATE TABLE `companies` (
  `id` int NOT NULL AUTO_INCREMENT,
  `company_name` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `industry` varchar(100) DEFAULT NULL,
  `company_type` enum('STARTUP','PRODUCT_BASE','SERVICE_BASE') DEFAULT NULL,
  `company_size` varchar(100) DEFAULT NULL,
  `description` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- Alumni table
DROP TABLE IF EXISTS `alumni`;
CREATE TABLE `alumni` (
  `alumni_id` bigint NOT NULL AUTO_INCREMENT,
  `company_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  `added_at` datetime DEFAULT NULL,
  PRIMARY KEY (`alumni_id`)
);

-- Job Descriptions table
DROP TABLE IF EXISTS `job_descriptions`;
CREATE TABLE `job_descriptions` (
  `job_id` bigint NOT NULL AUTO_INCREMENT,
  `employer_id` bigint DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` text,
  `location` varchar(100) DEFAULT NULL,
  `job_type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`job_id`)
);

-- Job Applications table
DROP TABLE IF EXISTS `job_applications`;
CREATE TABLE `job_applications` (
  `id` int NOT NULL AUTO_INCREMENT,
  `job_id` int DEFAULT NULL,
  `student_id` int DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `applied_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- Shortlisted Candidates table
DROP TABLE IF EXISTS `shortlisted_candidates`;
CREATE TABLE `shortlisted_candidates` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint DEFAULT NULL,
  `job_id` bigint DEFAULT NULL,
  `shortlisted_at` datetime DEFAULT NULL,
  `round_level` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- Interviews table
DROP TABLE IF EXISTS `interviews`;
CREATE TABLE `interviews` (
  `interview_id` int NOT NULL AUTO_INCREMENT,
  `application_id` int DEFAULT NULL,
  `scheduled_at` datetime DEFAULT NULL,
  `rescheduled_at` datetime DEFAULT NULL,
  `mode` varchar(50) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `remark` text,
  `outcome` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`interview_id`)
);

-- Referrals table
DROP TABLE IF EXISTS `referrals`;
CREATE TABLE `referrals` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `company_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  `alumni_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- =============================================
-- 9. NOTIFICATION TABLES
-- =============================================

-- Notification Categories table
DROP TABLE IF EXISTS `notification_categories`;
CREATE TABLE `notification_categories` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `categories` varchar(100) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`)
);

-- Notifications table
DROP TABLE IF EXISTS `notifications`;
CREATE TABLE `notifications` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint DEFAULT NULL,
  `notification_categories_id` bigint DEFAULT NULL,
  `message` text,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- =============================================
-- 10. SME (Subject Matter Expert) TABLES
-- =============================================

-- SME Runtimes table
DROP TABLE IF EXISTS `sme_runtimes`;
CREATE TABLE `sme_runtimes` (
  `sme_runtime_id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint DEFAULT NULL,
  `runtime_id` bigint DEFAULT NULL,
  PRIMARY KEY (`sme_runtime_id`)
);

-- =============================================
-- 11. PERFORMANCE TRACKING TABLES
-- =============================================

-- Performance Snapshots table
DROP TABLE IF EXISTS `performance_snapshots`;
CREATE TABLE `performance_snapshots` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_id` int DEFAULT NULL,
  `snapshot_date` date DEFAULT NULL,
  `performance_json` json DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- =============================================
-- INSERT SAMPLE DATA
-- =============================================

-- Insert Roles
INSERT INTO `roles` (role_id, role_name, description) VALUES
(1, 'Admin', 'Manages entire system, users, and configurations'),
(2, 'Student', 'Takes assessments and views results'),
(3, 'Mentor', 'Guides students and reviews performance'),
(4, 'SME', 'Creates and reviews questions'),
(5, 'Employer', 'Views candidates and assessments'),
(6, 'Alumni', 'Former students associated with the system'),
(7, 'Unassigned', 'Users who are not assigned any role');

-- Insert Runtimes
INSERT INTO `runtimes` (id, runtime_name) VALUES
(1, 'Python'),
(2, 'Java'),
(3, 'Node.js'),
(4, 'dotnet'),
(5, 'C/C++'),
(6, 'Dart'),
(7, 'Go'),
(8, 'Rust'),
(9, 'R'),
(10, 'Ruby'),
(11, 'Swift'),
(12, 'Shell'),
(13, 'Markup'),
(14, 'DB Engine');

-- Insert Languages
INSERT INTO `languages` (id, language, runtime_id) VALUES
(1, 'Java', 2),
(2, 'C#', 4),
(3, 'JavaScript', 3),
(4, 'Python', 1),
(5, 'Kotlin', 2),
(6, 'TypeScript', 3),
(7, 'C', 5),
(8, 'C++', 5),
(9, 'Dart', 6),
(10, 'Go', 7),
(11, 'Rust', 8),
(12, 'R', 9),
(13, 'Ruby', 10),
(14, 'Swift', 11),
(15, 'Shell Script', 12),
(16, 'HTML', 13),
(17, 'YAML', 13),
(18, 'Markdown', 13),
(19, 'SQL', 14),
(20, 'VB.NET', 4),
(21, 'Bash', 12);

-- Insert Layers
INSERT INTO `layers` (id, layers) VALUES
(1, 'Frontend'),
(2, 'Backend'),
(3, 'Database'),
(4, 'Testing'),
(5, 'AI');

-- Insert Sample Users
INSERT INTO `users` (id, contact, password, status, created_at) VALUES
(1, '9881735801', '12345', 'ACTIVE', '2012-09-05'),
(2, '8433752395', '12345', 'ACTIVE', '2026-02-02'),
(3, '9930952851', '12345', 'ACTIVE', '2024-12-27'),
(4, '9843053149', '12345', 'ACTIVE', '2026-01-19'),
(5, '9309868668', '12345', 'ACTIVE', '2026-01-21');

-- Insert Personal Information
INSERT INTO `personal_informations` (id, user_id, first_name, last_name, gender, date_of_birth, email, address, pincode) VALUES
(1, 1, 'Tejas', 'Naukudkar', 'MALE', '2004-12-10', 'tejas@example.com', 'Navi Mumbai', '410218'),
(2, 2, 'Samruddhi', 'Rasal', 'FEMALE', '2004-02-03', 'samruddhi@example.com', 'Pune', '411043'),
(3, 3, 'Tejas', 'Pawale', 'MALE', '1998-02-24', 'tejas.p@example.com', 'Mumbai', '400084'),
(4, 4, 'Sai', 'Jagdale', 'FEMALE', '2004-06-14', 'sai@example.com', 'Pune', '411043'),
(5, 5, 'Parikshit', 'Shelorkar', 'MALE', '2006-11-16', 'parikshit@example.com', 'Pune', '444107');

-- Insert User Roles
INSERT INTO `user_roles` (user_id, role_id, assigned_at) VALUES
(1, 1, NOW()),
(2, 3, NOW()),
(3, 1, NOW()),
(4, 3, NOW()),
(5, 4, NOW());

-- Insert Academic Information
INSERT INTO `academic_informations` (user_id, stream_name, specialization, enrollment_year, passing_year, percentage, college_name) VALUES
(1, 'Computer Science', 'BCA', 2022, 2025, 61.00, 'Deogiri College'),
(2, 'Computer Science', 'AI & Analytics', 2022, 2026, 80.00, 'MIT ADT University'),
(3, 'Mechanical Engineering', 'Robotics', 2018, 2021, 60.00, 'AMITR'),
(4, 'CSE', 'AI & Analytics', 2022, 2026, 80.00, 'MIT ADT'),
(5, 'Computer Engineering', 'Core', 2024, 2028, 86.50, 'SKNCOE Pune');

-- Insert Professional Information
INSERT INTO `professional_informations` (user_id, company_name, job_title, employment_type, is_current_job, experience_years, skills) VALUES
(1, 'Transflower Learning', 'Developer', 'PART_TIME', 1, 1, 'FullStack'),
(2, 'Transflower Learning', 'Junior Developer', 'PART_TIME', 1, 0, 'C#'),
(3, 'Clover Infotech', 'DBA', 'FULL_TIME', 0, 3, 'Node.js'),
(4, 'Transflower Learning', 'Junior Developer', 'FULL_TIME', 1, NULL, 'C'),
(5, 'Transflower Learning', 'Intern', 'PART_TIME', 1, 0, 'C++');

-- Insert Sample Questions
INSERT INTO `questions` (question_id, description, question_type, difficulty_level, created_at, status) VALUES
(1, 'Check whether a given number is a palindrome.', 'PROBLEM_STATEMENT', 'BEGINNER', NOW(), 1),
(2, 'What is JVM in Java?', 'MCQ', 'BEGINNER', NOW(), 1),
(3, 'Check whether a number is prime.', 'PROBLEM_STATEMENT', 'BEGINNER', NOW(), 1),
(4, 'What is CLR in .NET?', 'MCQ', 'BEGINNER', NOW(), 1),
(5, 'Find factorial of a number using recursion.', 'PROBLEM_STATEMENT', 'BEGINNER', NOW(), 1);

-- Insert Sample Tests
INSERT INTO `tests` (id, sme_id, title, duration, description, difficulty, created_at, status) VALUES
(1, 1, 'Array Sum Problem', 30, 'Write a program to calculate the sum of elements in an array.', 'BEGINNER', NOW(), 1),
(2, 2, 'Palindrome Check', 20, 'Write a program to check whether a string is palindrome.', 'INTERMEDIATE', NOW(), 1),
(3, 1, 'Prime Number Finder', 25, 'Write a program to check if a number is prime.', 'BEGINNER', NOW(), 1);

-- Insert Sample Assessments
INSERT INTO `assessments` (test_id, student_id, assigned_by, assigned_at, scheduled_at, status) VALUES
(1, 1, 1, NOW(), DATE_ADD(NOW(), INTERVAL 1 DAY), 'Assigned'),
(2, 2, 1, NOW(), DATE_ADD(NOW(), INTERVAL 2 DAY), 'Pending'),
(3, 3, 1, NOW(), DATE_ADD(NOW(), INTERVAL 3 DAY), 'Assigned');

-- Insert Sample Companies
INSERT INTO `companies` (company_name, website, industry, company_type, company_size, description) VALUES
('Emsphere', 'https://www.emsphere.com', 'IT Services', 'SERVICE_BASE', '50-200', 'Technology solutions and consulting'),
('Persistent Systems', 'https://www.persistent.com', 'IT Services', 'SERVICE_BASE', '10000+', 'Digital engineering'),
('Microsoft', 'https://www.microsoft.com', 'Technology', 'PRODUCT_BASE', '10000+', 'Software, cloud, and AI solutions');

-- Insert Sample Concepts
INSERT INTO `concepts` (id, name, description, status, created_at) VALUES
(1, 'Variables', 'Basic storage units used to hold data in a program', 'active', NOW()),
(2, 'Data Types', 'Defines the type of data a variable can store', 'active', NOW()),
(3, 'Operators', 'Symbols used to perform operations on variables', 'active', NOW()),
(4, 'Conditional Statements', 'Control flow using conditions like if-else', 'active', NOW()),
(5, 'Loops', 'Used to execute a block of code repeatedly', 'active', NOW());

-- Insert Sample Frameworks
INSERT INTO `frameworks` (id, name, layer_id, language_id, created_at, updated_at) VALUES
(1, 'Spring Boot', 2, 1, NOW(), NOW()),
(2, 'ASP.NET Core', 2, 2, NOW(), NOW()),
(3, 'React', 1, 3, NOW(), NOW()),
(4, 'Node.js', 2, 3, NOW(), NOW()),
(5, 'Django', 2, 4, NOW(), NOW());

-- =============================================
-- HELPER VIEWS FOR EASY QUERYING
-- =============================================

-- View: Complete Student Profile
CREATE OR REPLACE VIEW `student_complete_profile` AS
SELECT 
    u.id AS user_id,
    p.first_name,
    p.last_name,
    p.email,
    p.gender,
    p.date_of_birth,
    a.stream_name,
    a.specialization,
    a.college_name,
    a.percentage AS academic_percentage,
    pr.company_name,
    pr.job_title,
    pr.skills
FROM users u
JOIN personal_informations p ON u.id = p.user_id
LEFT JOIN academic_informations a ON u.id = a.user_id
LEFT JOIN professional_informations pr ON u.id = pr.user_id;

-- View: Assessment Results Summary
CREATE OR REPLACE VIEW `assessment_results_summary` AS
SELECT 
    p.first_name,
    p.last_name,
    t.title AS test_title,
    a.status AS assessment_status,
    sar.score,
    sar.percentile,
    sar.time_taken_minutes
FROM assessments a
JOIN personal_informations p ON a.student_id = p.user_id
JOIN tests t ON a.test_id = t.id
LEFT JOIN student_assessment_results sar ON a.id = sar.assessment_id;

-- View: Framework Concepts Mapping
CREATE OR REPLACE VIEW `framework_concepts_mapping` AS
SELECT 
    f.name AS framework_name,
    l.layers AS layer,
    lang.language,
    c.name AS concept_name,
    c.description AS concept_description
FROM frameworks f
JOIN layers l ON f.layer_id = l.id
JOIN languages lang ON f.language_id = lang.id
JOIN framework_concepts fc ON f.id = fc.framework_id
JOIN concepts c ON fc.concept_id = c.id;

-- =============================================
-- END OF SCHEMA
-- =============================================
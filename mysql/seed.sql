-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: mysql.code.local
-- Generation Time: Oct 22, 2021 at 12:39 PM
-- Server version: 10.5.8-MariaDB-1:10.5.8+maria~focal
-- PHP Version: 7.4.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+06:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_oj`
--

-- --------------------------------------------------------

--
-- Table structure for table `authorizations`
--

CREATE TABLE `authorizations` (
  `id` int(10) UNSIGNED NOT NULL,
  `type` enum('CONTESTANT','MANAGER','MODERATOR','SETTER','TESTER') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'CONTESTANT',
  `contest_id` int(10) UNSIGNED DEFAULT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `problem_id` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `contests`
--

CREATE TABLE `contests` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_time` timestamp NULL DEFAULT NULL,
  `duration` int(11) NOT NULL DEFAULT 300,
  `languages` int(11) NOT NULL DEFAULT 0,
  `type` enum('ICPC','IMO') COLLATE utf8mb4_unicode_ci NOT NULL,
  `privacy` enum('OPEN','CLOSED','INVITE_ONLY') COLLATE utf8mb4_unicode_ci NOT NULL,
  `freeze` tinyint(1) NOT NULL DEFAULT 0,
  `pe_allowed` tinyint(1) NOT NULL DEFAULT 1,
  `offline_submit` tinyint(1) NOT NULL DEFAULT 0,
  `time_penalty` int(11) NOT NULL DEFAULT 20,
  `creator_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `contests`
--

INSERT INTO `contests` (`id`, `name`, `slug`, `start_time`, `duration`, `languages`, `type`, `privacy`, `freeze`, `pe_allowed`, `offline_submit`, `time_penalty`, `creator_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'My First Contest', 'my-first-contest', NULL, 300, 0, 'ICPC', 'INVITE_ONLY', 0, 1, 0, 20, 2, '2021-10-22 18:37:15', '2021-10-22 18:37:15', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `contest_infos`
--

CREATE TABLE `contest_infos` (
  `id` int(10) UNSIGNED NOT NULL,
  `contest_id` int(10) UNSIGNED NOT NULL,
  `notice` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `details` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cover` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `contest_infos`
--

INSERT INTO `contest_infos` (`id`, `contest_id`, `notice`, `details`, `cover`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, NULL, NULL, NULL, '2021-10-22 18:37:15', '2021-10-22 18:37:15', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `contest_requests`
--

CREATE TABLE `contest_requests` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `contest_id` int(10) UNSIGNED NOT NULL,
  `status` enum('PENDING','REJECTED') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PENDING',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `problems`
--

CREATE TABLE `problems` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `memory_limit` int(11) NOT NULL,
  `cpu_limit` int(11) NOT NULL,
  `output_limit` int(11) NOT NULL,
  `type` enum('NORMAL','SPECIAL_JUDGE') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'NORMAL',
  `privacy` enum('PUBLIC','CONTEST','DRAFT') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'DRAFT',
  `hidden` tinyint(1) NOT NULL DEFAULT 0,
  `contest_id` int(10) UNSIGNED DEFAULT NULL,
  `creator_id` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `problems`
--

INSERT INTO `problems` (`id`, `name`, `uuid`, `memory_limit`, `cpu_limit`, `output_limit`, `type`, `privacy`, `hidden`, `contest_id`, `creator_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Problem 001', 'A', 1048576, 1000, 65536, 'NORMAL', 'CONTEST', 0, 1, 2, '2021-10-22 18:37:57', '2021-10-22 18:38:39', '2021-10-22 18:38:39'),
(2, 'Problem 001', 'A', 1048576, 1000, 65536, 'NORMAL', 'CONTEST', 0, 1, 2, '2021-10-22 18:38:29', '2021-10-22 18:38:29', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `problem_descriptions`
--

CREATE TABLE `problem_descriptions` (
  `id` int(10) UNSIGNED NOT NULL,
  `text` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `locale` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'en',
  `problem_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `problem_descriptions`
--

INSERT INTO `problem_descriptions` (`id`, `text`, `locale`, `problem_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, NULL, 'en', 1, '2021-10-22 18:37:57', '2021-10-22 18:38:39', '2021-10-22 18:38:39'),
(2, NULL, 'en', 2, '2021-10-22 18:38:29', '2021-10-22 18:38:29', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `problem_logs`
--

CREATE TABLE `problem_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `problem_id` int(10) UNSIGNED NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `problem_logs`
--

INSERT INTO `problem_logs` (`id`, `problem_id`, `message`, `created_at`) VALUES
(1, 2, '@farhad created the problem.', '2021-10-22 18:38:29');

-- --------------------------------------------------------

--
-- Table structure for table `problem_snapshots`
--

CREATE TABLE `problem_snapshots` (
  `id` int(10) UNSIGNED NOT NULL,
  `hash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alive` int(11) NOT NULL,
  `status` enum('READY','PROCESSING','FAILED','EXPIRED','UNKNOWN') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PROCESSING',
  `problem_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `problem_stats`
--

CREATE TABLE `problem_stats` (
  `id` int(10) UNSIGNED NOT NULL,
  `unique_ac` int(11) NOT NULL DEFAULT 0,
  `total_submission` int(11) NOT NULL DEFAULT 0,
  `problem_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `problem_stats`
--

INSERT INTO `problem_stats` (`id`, `unique_ac`, `total_submission`, `problem_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 0, 0, 1, '2021-10-22 18:37:57', '2021-10-22 18:38:39', '2021-10-22 18:38:39'),
(2, 0, 0, 2, '2021-10-22 18:38:29', '2021-10-22 18:38:29', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `rank_lists`
--

CREATE TABLE `rank_lists` (
  `id` int(10) UNSIGNED NOT NULL,
  `accepted` int(11) NOT NULL DEFAULT 0,
  `public_accepted` int(11) NOT NULL DEFAULT 0,
  `submissions` int(11) NOT NULL DEFAULT 0,
  `penalty` int(11) NOT NULL DEFAULT 0,
  `public_penalty` int(11) NOT NULL DEFAULT 0,
  `mark` int(11) NOT NULL DEFAULT 0,
  `public_mark` int(11) NOT NULL DEFAULT 0,
  `user_id` int(10) UNSIGNED NOT NULL,
  `contest_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sample_test_cases`
--

CREATE TABLE `sample_test_cases` (
  `id` int(10) UNSIGNED NOT NULL,
  `input` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `output` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `problem_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `site_metas`
--

CREATE TABLE `site_metas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `submissions`
--

CREATE TABLE `submissions` (
  `id` int(10) UNSIGNED NOT NULL,
  `verdict` int(11) NOT NULL DEFAULT 7,
  `memory` int(11) DEFAULT NULL,
  `cpu` int(11) DEFAULT NULL,
  `language` int(11) NOT NULL,
  `mark` int(11) NOT NULL DEFAULT 0,
  `source` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` enum('CONTEST','PUBLIC','TEST') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `submitted_at` int(11) DEFAULT NULL,
  `freeze` tinyint(1) NOT NULL DEFAULT 0,
  `hash` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `problem_id` int(10) UNSIGNED NOT NULL,
  `contest_id` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `submission_histories`
--

CREATE TABLE `submission_histories` (
  `id` int(10) UNSIGNED NOT NULL,
  `batch` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `verdict` int(11) DEFAULT NULL,
  `memory` int(11) DEFAULT NULL,
  `cpu` int(11) DEFAULT NULL,
  `mark` int(11) DEFAULT NULL,
  `freeze` tinyint(1) NOT NULL DEFAULT 0,
  `submission_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `submission_metas`
--

CREATE TABLE `submission_metas` (
  `id` int(10) UNSIGNED NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` enum('COMPILE_MSG','JUDGE_MSG') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'JUDGE_MSG',
  `submission_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sub_rank_lists`
--

CREATE TABLE `sub_rank_lists` (
  `id` int(10) UNSIGNED NOT NULL,
  `accepted` tinyint(1) NOT NULL DEFAULT 0,
  `freeze` tinyint(1) NOT NULL DEFAULT 0,
  `submissions` int(11) NOT NULL DEFAULT 0,
  `penalty` int(11) NOT NULL DEFAULT 0,
  `mark` int(11) NOT NULL DEFAULT 0,
  `is_first_solve` tinyint(1) NOT NULL DEFAULT 0,
  `problem_id` int(10) UNSIGNED NOT NULL,
  `rank_list_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sub_submissions`
--

CREATE TABLE `sub_submissions` (
  `id` int(10) UNSIGNED NOT NULL,
  `verdict` int(11) NOT NULL DEFAULT 7,
  `memory` int(11) DEFAULT NULL,
  `cpu` int(11) DEFAULT NULL,
  `mark` int(11) NOT NULL DEFAULT 0,
  `test_case_id` int(10) UNSIGNED DEFAULT NULL,
  `submission_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tags`
--

CREATE TABLE `tags` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `variant` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'success',
  `creator_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tag_mappings`
--

CREATE TABLE `tag_mappings` (
  `id` int(10) UNSIGNED NOT NULL,
  `tag_id` int(10) UNSIGNED NOT NULL,
  `mapped_to` int(10) UNSIGNED NOT NULL,
  `with_type` enum('CONTEST','PROBLEM','SUBMISSION','USER') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `test_cases`
--

CREATE TABLE `test_cases` (
  `id` int(10) UNSIGNED NOT NULL,
  `input` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `output` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mark` int(11) NOT NULL DEFAULT 0,
  `sample` tinyint(1) NOT NULL DEFAULT 0,
  `input_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `input_hash` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `output_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `output_hash` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `problem_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `test_cases`
--

INSERT INTO `test_cases` (`id`, `input`, `output`, `mark`, `sample`, `input_name`, `input_hash`, `output_name`, `output_hash`, `problem_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, '', '', 0, 1, NULL, NULL, NULL, NULL, 1, '2021-10-22 18:37:57', '2021-10-22 18:37:57', NULL),
(2, '', '', 0, 1, NULL, NULL, NULL, NULL, 2, '2021-10-22 18:38:29', '2021-10-22 18:38:29', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('VERIFIED','UNVERIFIED','INACTIVE') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'UNVERIFIED',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `remember_token`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'system', 'system@sustcseoj.com', '$2y$10$0b/skrRBumo8ZRIbnYcHU.RyJYD3.5SL4BldGxfXgB.YDYF7ImZ42', NULL, 'VERIFIED', '2021-01-01 18:16:49', '2021-01-01 18:16:49', NULL),
(2, 'farhad', 'rafikfarhad@gmail.com', '$2y$10$88iZ2Byg/BI2CPFtkuJfWe1WX/SUsLGXyCiL/5oLd0Cti0Ofl/rEW', NULL, 'VERIFIED', '2021-01-01 18:16:49', '2021-01-01 18:16:49', NULL),
(3, 'talat', 'tanveer.2387@gmail.com', '$2y$10$i.8Vna/toHK27Bq236GANuIfRokc54FXNssqQdFS6dWwfySvexEcW', NULL, 'VERIFIED', '2021-01-01 18:16:49', '2021-01-01 18:16:49', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_infos`
--

CREATE TABLE `user_infos` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `institution` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `draft_limit` int(11) NOT NULL DEFAULT 0,
  `user_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_infos`
--

INSERT INTO `user_infos` (`id`, `name`, `institution`, `country`, `avatar`, `draft_limit`, `user_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'System', 'Shahjalal University of Science & Technology', 'BD', 'https://www.gravatar.com/avatar/4937c80c03319b1d7459a7acdcf787b1?d=identicon&r=g', 0, 1, '2021-01-01 18:16:49', '2021-01-01 18:16:49', NULL),
(2, 'Farhad', 'Shahjalal University of Science & Technology', 'BD', 'https://www.gravatar.com/avatar/210c9f408fc1a7782f20b54805eb3787?d=identicon&r=g', 20, 2, '2021-01-01 18:16:49', '2021-01-01 18:16:49', NULL),
(3, 'Talat', 'Shahjalal University of Science & Technology', 'BD', 'https://www.gravatar.com/avatar/00f2aa30455602b0901b49d7c8d7cc21?d=identicon&r=g', 20, 3, '2021-01-01 18:16:49', '2021-01-01 18:16:49', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `validators`
--

CREATE TABLE `validators` (
  `id` int(10) UNSIGNED NOT NULL,
  `source` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `language` int(11) NOT NULL,
  `memory_limit` int(11) NOT NULL DEFAULT 1024,
  `cpu_limit` int(11) NOT NULL DEFAULT 1000,
  `hash` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `problem_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `verification_tokens`
--

CREATE TABLE `verification_tokens` (
  `id` int(10) UNSIGNED NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('VERIFICATION','RESET') COLLATE utf8mb4_unicode_ci NOT NULL,
  `retry_after` datetime NOT NULL DEFAULT current_timestamp(),
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `_migrations`
--

CREATE TABLE `_migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `_migrations`
--

INSERT INTO `_migrations` (`id`, `migration`, `batch`) VALUES
(1, '2019_08_23_002010_create_users_table', 1),
(2, '2019_08_23_002015_create_user_infos_table', 1),
(3, '2019_08_23_002021_create_contests_table', 1),
(4, '2019_08_23_002027_create_contest_infos_table', 1),
(5, '2019_08_23_002033_create_problems_table', 1),
(6, '2019_08_23_002041_create_descriptions_table', 1),
(7, '2019_08_23_002048_create_test_cases_table', 1),
(8, '2019_08_23_002116_create_validators_table', 1),
(9, '2019_08_23_002142_create_authorizations_table', 1),
(10, '2019_08_23_002151_create_submissions_table', 1),
(11, '2019_08_23_002216_create_sub_submissions_table', 1),
(12, '2019_08_23_002221_create_rank_lists_table', 1),
(13, '2019_08_23_012757_create_sub_rank_lists_table', 1),
(14, '2019_08_23_013227_create_contest_requests_table', 1),
(15, '2019_08_27_232623_create_submission_histories_table', 1),
(16, '2019_08_27_232635_create_problem_stats_table', 1),
(17, '2019_08_28_011451_create_permission_tables', 1),
(18, '2019_09_24_215115_create_jobs_table', 1),
(19, '2019_09_24_215119_create_failed_jobs_table', 1),
(20, '2020_01_24_011357_create_verification_tokens_table', 1),
(22, '2020_04_12_045428_create_submission_metas_table', 1),
(23, '2020_04_30_235703_create_problem_snaphots_table', 1),
(24, '2020_06_07_092606_create_tags_table', 1),
(25, '2020_06_07_092746_create_tag_mappings_table', 1),
(26, '2020_07_24_140111_create_site_metas_table', 1),
(27, '2020_12_26_000006_make_contest_id_nullable_in_authorizations_table', 1),
(28, '2020_01_30_100000_create_telescope_entries_table', 2),
(29, '2021_01_09_010043_create_problem_logs_table', 2),
(30, '2021_03_19_015545_create_sample_test_cases_table', 2);

-- --------------------------------------------------------

--
-- Table structure for table `_model_has_permissions`
--

CREATE TABLE `_model_has_permissions` (
  `permission_id` int(10) UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `_model_has_roles`
--

CREATE TABLE `_model_has_roles` (
  `role_id` int(10) UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `_model_has_roles`
--

INSERT INTO `_model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\User', 1),
(1, 'App\\Models\\User', 2),
(1, 'App\\Models\\User', 3);

-- --------------------------------------------------------

--
-- Table structure for table `_permissions`
--

CREATE TABLE `_permissions` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `_permissions`
--

INSERT INTO `_permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'web', '2021-01-01 18:16:49', '2021-01-01 18:16:49'),
(2, 'can-draft', 'web', '2021-01-01 18:16:49', '2021-01-01 18:16:49'),
(3, 'can-manage-user', 'web', '2021-01-01 18:16:49', '2021-01-01 18:16:49'),
(4, 'can-manage-public-problem', 'web', '2021-01-01 18:16:49', '2021-01-01 18:16:49'),
(5, 'can-manage-contest', 'web', '2021-01-01 18:16:49', '2021-01-01 18:16:49'),
(6, 'can-manage-access-control', 'web', '2021-01-01 18:16:49', '2021-01-01 18:16:49'),
(7, 'can-manage-tag', 'web', '2021-01-01 18:16:49', '2021-01-01 18:16:49'),
(8, 'can-maintain', 'web', '2021-01-01 18:16:49', '2021-01-01 18:16:49');

-- --------------------------------------------------------

--
-- Table structure for table `_roles`
--

CREATE TABLE `_roles` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `_roles`
--

INSERT INTO `_roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'super_admin', 'web', '2021-01-01 18:16:49', '2021-01-01 18:16:49');

-- --------------------------------------------------------

--
-- Table structure for table `_role_has_permissions`
--

CREATE TABLE `_role_has_permissions` (
  `permission_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `authorizations`
--
ALTER TABLE `authorizations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `authorizations_contest_id_foreign` (`contest_id`),
  ADD KEY `authorizations_problem_id_foreign` (`problem_id`),
  ADD KEY `authorizations_user_id_contest_id_type_problem_id_index` (`user_id`,`contest_id`,`type`,`problem_id`);

--
-- Indexes for table `contests`
--
ALTER TABLE `contests`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `contests_slug_unique` (`slug`),
  ADD KEY `contests_creator_id_foreign` (`creator_id`);

--
-- Indexes for table `contest_infos`
--
ALTER TABLE `contest_infos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `contest_infos_contest_id_foreign` (`contest_id`);

--
-- Indexes for table `contest_requests`
--
ALTER TABLE `contest_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `contest_requests_user_id_foreign` (`user_id`),
  ADD KEY `contest_requests_contest_id_foreign` (`contest_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `problems`
--
ALTER TABLE `problems`
  ADD PRIMARY KEY (`id`),
  ADD KEY `problems_contest_id_foreign` (`contest_id`),
  ADD KEY `problems_creator_id_foreign` (`creator_id`),
  ADD KEY `problems_uuid_index` (`uuid`);

--
-- Indexes for table `problem_descriptions`
--
ALTER TABLE `problem_descriptions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `problem_descriptions_problem_id_foreign` (`problem_id`);

--
-- Indexes for table `problem_logs`
--
ALTER TABLE `problem_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `problem_logs_problem_id_foreign` (`problem_id`);

--
-- Indexes for table `problem_snapshots`
--
ALTER TABLE `problem_snapshots`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `problem_snapshots_hash_unique` (`hash`),
  ADD KEY `problem_snapshots_problem_id_foreign` (`problem_id`);

--
-- Indexes for table `problem_stats`
--
ALTER TABLE `problem_stats`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `problem_stats_problem_id_unique` (`problem_id`);

--
-- Indexes for table `rank_lists`
--
ALTER TABLE `rank_lists`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `rank_lists_contest_id_user_id_unique` (`contest_id`,`user_id`),
  ADD KEY `rank_lists_user_id_foreign` (`user_id`);

--
-- Indexes for table `sample_test_cases`
--
ALTER TABLE `sample_test_cases`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sample_test_cases_problem_id_foreign` (`problem_id`);

--
-- Indexes for table `site_metas`
--
ALTER TABLE `site_metas`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `submissions`
--
ALTER TABLE `submissions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `submissions_user_id_foreign` (`user_id`),
  ADD KEY `submissions_contest_id_foreign` (`contest_id`),
  ADD KEY `submissions_problem_id_foreign` (`problem_id`);

--
-- Indexes for table `submission_histories`
--
ALTER TABLE `submission_histories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `submission_histories_submission_id_foreign` (`submission_id`);

--
-- Indexes for table `submission_metas`
--
ALTER TABLE `submission_metas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unq_msg_sbmsn` (`submission_id`,`type`);

--
-- Indexes for table `sub_rank_lists`
--
ALTER TABLE `sub_rank_lists`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sub_rank_lists_problem_id_rank_list_id_unique` (`problem_id`,`rank_list_id`),
  ADD KEY `sub_rank_lists_rank_list_id_foreign` (`rank_list_id`);

--
-- Indexes for table `sub_submissions`
--
ALTER TABLE `sub_submissions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sub_submissions_submission_id_foreign` (`submission_id`);

--
-- Indexes for table `tags`
--
ALTER TABLE `tags`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tags_name_unique` (`name`),
  ADD KEY `tags_creator_id_foreign` (`creator_id`);

--
-- Indexes for table `tag_mappings`
--
ALTER TABLE `tag_mappings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_mappings` (`tag_id`,`mapped_to`,`with_type`);

--
-- Indexes for table `test_cases`
--
ALTER TABLE `test_cases`
  ADD PRIMARY KEY (`id`),
  ADD KEY `test_cases_problem_id_foreign` (`problem_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_username_unique` (`username`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `user_infos`
--
ALTER TABLE `user_infos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_infos_user_id_foreign` (`user_id`);

--
-- Indexes for table `validators`
--
ALTER TABLE `validators`
  ADD PRIMARY KEY (`id`),
  ADD KEY `validators_problem_id_foreign` (`problem_id`);

--
-- Indexes for table `verification_tokens`
--
ALTER TABLE `verification_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `verification_tokens_token_unique` (`token`),
  ADD KEY `verification_tokens_user_id_foreign` (`user_id`);

--
-- Indexes for table `_migrations`
--
ALTER TABLE `_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `_model_has_permissions`
--
ALTER TABLE `_model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `_model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `_model_has_roles`
--
ALTER TABLE `_model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `_model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `_permissions`
--
ALTER TABLE `_permissions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `_roles`
--
ALTER TABLE `_roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `_role_has_permissions`
--
ALTER TABLE `_role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `_role_has_permissions_role_id_foreign` (`role_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `authorizations`
--
ALTER TABLE `authorizations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contests`
--
ALTER TABLE `contests`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `contest_infos`
--
ALTER TABLE `contest_infos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `contest_requests`
--
ALTER TABLE `contest_requests`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `problems`
--
ALTER TABLE `problems`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `problem_descriptions`
--
ALTER TABLE `problem_descriptions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `problem_logs`
--
ALTER TABLE `problem_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `problem_snapshots`
--
ALTER TABLE `problem_snapshots`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `problem_stats`
--
ALTER TABLE `problem_stats`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `rank_lists`
--
ALTER TABLE `rank_lists`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sample_test_cases`
--
ALTER TABLE `sample_test_cases`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `site_metas`
--
ALTER TABLE `site_metas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `submissions`
--
ALTER TABLE `submissions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `submission_histories`
--
ALTER TABLE `submission_histories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `submission_metas`
--
ALTER TABLE `submission_metas`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sub_rank_lists`
--
ALTER TABLE `sub_rank_lists`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sub_submissions`
--
ALTER TABLE `sub_submissions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tags`
--
ALTER TABLE `tags`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tag_mappings`
--
ALTER TABLE `tag_mappings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `test_cases`
--
ALTER TABLE `test_cases`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `user_infos`
--
ALTER TABLE `user_infos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `validators`
--
ALTER TABLE `validators`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `verification_tokens`
--
ALTER TABLE `verification_tokens`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `_migrations`
--
ALTER TABLE `_migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `_permissions`
--
ALTER TABLE `_permissions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `_roles`
--
ALTER TABLE `_roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `authorizations`
--
ALTER TABLE `authorizations`
  ADD CONSTRAINT `authorizations_contest_id_foreign` FOREIGN KEY (`contest_id`) REFERENCES `contests` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `authorizations_problem_id_foreign` FOREIGN KEY (`problem_id`) REFERENCES `problems` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `authorizations_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `contests`
--
ALTER TABLE `contests`
  ADD CONSTRAINT `contests_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `contest_infos`
--
ALTER TABLE `contest_infos`
  ADD CONSTRAINT `contest_infos_contest_id_foreign` FOREIGN KEY (`contest_id`) REFERENCES `contests` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `contest_requests`
--
ALTER TABLE `contest_requests`
  ADD CONSTRAINT `contest_requests_contest_id_foreign` FOREIGN KEY (`contest_id`) REFERENCES `contests` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `contest_requests_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `problems`
--
ALTER TABLE `problems`
  ADD CONSTRAINT `problems_contest_id_foreign` FOREIGN KEY (`contest_id`) REFERENCES `contests` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `problems_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `problem_descriptions`
--
ALTER TABLE `problem_descriptions`
  ADD CONSTRAINT `problem_descriptions_problem_id_foreign` FOREIGN KEY (`problem_id`) REFERENCES `problems` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `problem_logs`
--
ALTER TABLE `problem_logs`
  ADD CONSTRAINT `problem_logs_problem_id_foreign` FOREIGN KEY (`problem_id`) REFERENCES `problems` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `problem_snapshots`
--
ALTER TABLE `problem_snapshots`
  ADD CONSTRAINT `problem_snapshots_problem_id_foreign` FOREIGN KEY (`problem_id`) REFERENCES `problems` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `problem_stats`
--
ALTER TABLE `problem_stats`
  ADD CONSTRAINT `problem_stats_problem_id_foreign` FOREIGN KEY (`problem_id`) REFERENCES `problems` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `rank_lists`
--
ALTER TABLE `rank_lists`
  ADD CONSTRAINT `rank_lists_contest_id_foreign` FOREIGN KEY (`contest_id`) REFERENCES `contests` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `rank_lists_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sample_test_cases`
--
ALTER TABLE `sample_test_cases`
  ADD CONSTRAINT `sample_test_cases_problem_id_foreign` FOREIGN KEY (`problem_id`) REFERENCES `problems` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `submissions`
--
ALTER TABLE `submissions`
  ADD CONSTRAINT `submissions_contest_id_foreign` FOREIGN KEY (`contest_id`) REFERENCES `contests` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `submissions_problem_id_foreign` FOREIGN KEY (`problem_id`) REFERENCES `problems` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `submissions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `submission_histories`
--
ALTER TABLE `submission_histories`
  ADD CONSTRAINT `submission_histories_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `submission_metas`
--
ALTER TABLE `submission_metas`
  ADD CONSTRAINT `submission_metas_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sub_rank_lists`
--
ALTER TABLE `sub_rank_lists`
  ADD CONSTRAINT `sub_rank_lists_problem_id_foreign` FOREIGN KEY (`problem_id`) REFERENCES `problems` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `sub_rank_lists_rank_list_id_foreign` FOREIGN KEY (`rank_list_id`) REFERENCES `rank_lists` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sub_submissions`
--
ALTER TABLE `sub_submissions`
  ADD CONSTRAINT `sub_submissions_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tags`
--
ALTER TABLE `tags`
  ADD CONSTRAINT `tags_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tag_mappings`
--
ALTER TABLE `tag_mappings`
  ADD CONSTRAINT `tag_mappings_tag_id_foreign` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `test_cases`
--
ALTER TABLE `test_cases`
  ADD CONSTRAINT `test_cases_problem_id_foreign` FOREIGN KEY (`problem_id`) REFERENCES `problems` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_infos`
--
ALTER TABLE `user_infos`
  ADD CONSTRAINT `user_infos_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `validators`
--
ALTER TABLE `validators`
  ADD CONSTRAINT `validators_problem_id_foreign` FOREIGN KEY (`problem_id`) REFERENCES `problems` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `verification_tokens`
--
ALTER TABLE `verification_tokens`
  ADD CONSTRAINT `verification_tokens_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `_model_has_permissions`
--
ALTER TABLE `_model_has_permissions`
  ADD CONSTRAINT `_model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `_permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `_model_has_roles`
--
ALTER TABLE `_model_has_roles`
  ADD CONSTRAINT `_model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `_roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `_role_has_permissions`
--
ALTER TABLE `_role_has_permissions`
  ADD CONSTRAINT `_role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `_permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `_role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `_roles` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

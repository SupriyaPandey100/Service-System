-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 21, 2026 at 05:01 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `servicehome_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `booking_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL,
  `service_name` varchar(100) NOT NULL,
  `service_price` decimal(10,2) NOT NULL,
  `customer_name` varchar(100) NOT NULL,
  `customer_phone` varchar(20) NOT NULL,
  `preferred_date` date NOT NULL,
  `preferred_time` varchar(50) NOT NULL,
  `service_address` text NOT NULL,
  `additional_notes` text DEFAULT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `status` enum('pending','confirmed','in_progress','completed','cancelled') DEFAULT 'pending',
  `payment_status` enum('pending','paid','refunded') DEFAULT 'pending',
  `payment_method` varchar(50) DEFAULT NULL,
  `booking_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `completed_date` date DEFAULT NULL,
  `cancellation_reason` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`booking_id`, `user_id`, `service_id`, `service_name`, `service_price`, `customer_name`, `customer_phone`, `preferred_date`, `preferred_time`, `service_address`, `additional_notes`, `total_amount`, `status`, `payment_status`, `payment_method`, `booking_date`, `updated_at`, `completed_date`, `cancellation_reason`) VALUES
(1, 2, 1, 'Plumbing Repairs', 1500.00, 'Default Customer', '0000000000', '2026-05-23', 'Afternoon (12:00 PM - 4:00 PM)', 'Baneshwor', 'Check', 1500.00, 'pending', 'pending', NULL, '2026-05-19 06:16:58', '2026-05-19 06:16:58', NULL, NULL),
(2, 2, 1, 'Electrical Installation', 2000.00, 'Default Customer', '0000000000', '2026-05-20', 'Evening (4:00 PM - 8:00 PM)', 'kamal Pokhari', 'ABCD', 2000.00, 'pending', 'pending', NULL, '2026-05-19 06:19:10', '2026-05-19 06:19:10', NULL, NULL),
(3, 2, 1, 'Plumbing Repairs', 1500.00, 'Default Customer', '0000000000', '2026-05-22', 'Morning (8:00 AM - 12:00 PM)', 'Baneshwor', 'abcd', 1500.00, 'pending', 'pending', NULL, '2026-05-19 06:24:09', '2026-05-19 06:24:09', NULL, NULL),
(4, 2, 1, 'Deep Cleaning', 3000.00, 'Default Customer', '0000000000', '2026-05-22', 'Afternoon (12:00 PM - 4:00 PM)', 'Baneshwor', 'abcccddd\r\n', 3000.00, 'pending', 'pending', NULL, '2026-05-19 06:24:57', '2026-05-19 06:24:57', NULL, NULL),
(5, 2, 1, 'Plumbing Repairs', 1500.00, 'Default Customer', '0000000000', '2026-05-21', 'Afternoon (12:00 PM - 4:00 PM)', 'Baneshwor', '', 1500.00, 'pending', 'pending', NULL, '2026-05-19 06:57:55', '2026-05-19 06:57:55', NULL, NULL),
(6, 2, 1, 'Plumbing Repairs', 1500.00, 'Default Customer', '0000000000', '2026-05-22', 'Morning (8:00 AM - 12:00 PM)', 'Baneshwor', 'ABCD', 1500.00, 'pending', 'pending', NULL, '2026-05-19 09:05:14', '2026-05-19 09:05:14', NULL, NULL),
(7, 2, 1, 'Electrical Installation', 2000.00, 'Default Customer', '0000000000', '2026-05-21', 'Afternoon (12:00 PM - 4:00 PM)', 'Kathmandu', 'abcd', 2000.00, 'pending', 'pending', NULL, '2026-05-19 09:05:42', '2026-05-19 09:05:42', NULL, NULL),
(8, 2, 1, 'Plumbing Repairs', 1500.00, 'Default Customer', '0000000000', '2026-05-22', 'Afternoon (12:00 PM - 4:00 PM)', 'Kathmandu', 'HAHHAH', 1500.00, 'pending', 'pending', NULL, '2026-05-19 09:41:44', '2026-05-19 09:41:44', NULL, NULL),
(9, 2, 1, 'Plumbing Repairs', 1500.00, 'Default Customer', '0000000000', '2026-05-22', 'Morning (8:00 AM - 12:00 PM)', 'Kathmandu', 'Check', 1500.00, 'pending', 'pending', NULL, '2026-05-19 13:15:31', '2026-05-19 13:15:31', NULL, NULL),
(10, 2, 1, 'Plumbing Repairs', 1500.00, 'Default Customer', '0000000000', '2026-06-04', 'Afternoon (12:00 PM - 4:00 PM)', 'Lalitpur', 'Need it as soon as possible\r\n', 1500.00, 'pending', 'pending', NULL, '2026-05-19 18:28:41', '2026-05-19 18:28:41', NULL, NULL),
(11, 2, 1, 'Home Sanitization', 2000.00, 'Default Customer', '0000000000', '2026-05-25', 'Evening (4:00 PM - 8:00 PM)', 'Chabahil', 'Need to sanitize home', 2000.00, 'pending', 'pending', NULL, '2026-05-19 18:29:25', '2026-05-19 18:29:25', NULL, NULL),
(12, 2, 1, 'Electrical Installation', 2000.00, 'Default Customer', '0000000000', '2026-05-28', 'Afternoon (12:00 PM - 4:00 PM)', 'Pashupati side', 'We need to repair electric', 2000.00, 'pending', 'pending', NULL, '2026-05-19 18:30:18', '2026-05-19 18:30:18', NULL, NULL),
(13, 2, 1, 'Plumbing Repairs', 1500.00, 'Default Customer', '0000000000', '2026-05-21', 'Afternoon (12:00 PM - 4:00 PM)', 'Kathmandu', 'Need to repair', 1500.00, 'pending', 'pending', NULL, '2026-05-19 22:32:55', '2026-05-19 22:32:55', NULL, NULL),
(14, 2, 1, 'Plumbing Repairs', 1500.00, 'Default Customer', '0000000000', '2026-05-21', 'Evening (4:00 PM - 8:00 PM)', 'Khusibu', 'Sunibha lai toilet', 1500.00, 'pending', 'pending', NULL, '2026-05-20 06:29:15', '2026-05-20 06:29:15', NULL, NULL),
(15, 2, 1, 'Plumbing Repairs', 1500.00, 'Default Customer', '0000000000', '2026-05-30', 'Evening (4:00 PM - 8:00 PM)', 'Khusibu', 'Coursework', 1500.00, 'pending', 'pending', NULL, '2026-05-20 14:11:58', '2026-05-20 14:11:58', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `type` varchar(50) NOT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `user_id`, `message`, `type`, `is_read`, `created_at`) VALUES
(1, 1, 'Welcome to ServiceHub! Your profile is active.', '', 1, '2026-05-18 08:10:41'),
(2, 1, 'Your booking has been successfully received!', 'booking', 1, '2026-05-18 08:24:20');

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `service_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `category` varchar(50) NOT NULL,
  `price` int(11) NOT NULL,
  `image_url` varchar(255) NOT NULL,
  `description` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `services`
--

INSERT INTO `services` (`service_id`, `name`, `category`, `price`, `image_url`, `description`) VALUES
(1, 'Plumbing Repairs', 'Plumbing', 1500, 'images/plumbing.jpg', 'Professional plumbing repair services for leaks, clogs, and pipe issues'),
(2, 'Electrical Installation', 'Electrical', 2000, 'images/electrical.jpg', 'Licensed electricians for wiring, fixtures, and electrical installations'),
(3, 'House Painting', 'Painting', 5000, 'images/painting.jpg', 'Interior and exterior painting with premium quality paints'),
(4, 'Deep Cleaning', 'Cleaning', 3000, 'images/cleaning.jpg', 'Complete deep cleaning for your home'),
(5, 'AC Service & Repair', 'AC Repair', 1800, 'images/ac-repair.jpg', 'Air conditioner servicing and maintenance'),
(6, 'Custom Carpentry', 'Carpentry', 4000, 'images/carpentry.jpg', 'Custom furniture and woodwork solutions'),
(7, 'Kitchen Plumbing', 'Plumbing', 1800, 'images/kitchen-plumbing.jpg', 'Sink and kitchen plumbing services'),
(8, 'Appliance Repair', 'Electrical', 1200, 'images/appliance-repair.jpg', 'Repair services for home appliances'),
(9, 'Home Sanitization', 'Cleaning', 2000, 'images/sanitization.jpg', 'Full home sanitization and disinfection service for a healthy living environment'),
(10, 'Roof Repair', 'Carpentry', 6000, 'images/roof-repair.jpg', 'Professional roof inspection, leak repair, and waterproofing services'),
(11, 'Interior Design', 'Painting', 8000, 'images/interior-design.jpg', 'Complete interior design and room makeover service by expert designers'),
(12, 'Pest Control', 'Cleaning', 2500, 'images/pest-control.jpg', 'Complete home pest control and sanitization treatment');

-- --------------------------------------------------------

--
-- Table structure for table `technicians`
--

CREATE TABLE `technicians` (
  `technician_id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `services` varchar(500) NOT NULL,
  `rating` decimal(3,2) DEFAULT 0.00,
  `completed_jobs` int(11) DEFAULT 0,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(20) NOT NULL,
  `status` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `full_name`, `email`, `phone`, `password`, `role`, `status`) VALUES
(1, 'Test', 'supriya01pandey@gmail.com', '9861315966', 'Test@123', 'customer', 'ACTIVE'),
(2, 'User', 'user123@gmail.com', '9861315966', 'User@123', 'customer', 'ACTIVE'),
(3, 'Sup', 'suuu@gmail.com', '5252552552525', 'Supriya', 'customer', 'ACTIVE'),
(4, 'Test Test', 'Test2323@gmail.com', '9861315966', 'securepass123', 'customer', 'ACTIVE'),
(5, 'admin', 'admin@homeservice.com', '9861315966', 'admin123', 'admin', 'ACTIVE'),
(6, 'test supriya', 's@gmail.com', '9810101010', 'supriya', 'customer', 'ACTIVE'),
(7, 'test 100', 't@gmail.com', '9844444444', 'test100', 'customer', 'ACTIVE'),
(8, 'Nikku', 'Niku@gmail.com', '9999999999', 'niku', 'customer', 'ACTIVE'),
(9, 'smart', 'smart@gmail.com', '9800000000', 'smart', 'USER', 'ACTIVE'),
(10, 'sunicho', 'sunicho@gmail.com', '9800000000', 'sunicho', 'USER', 'REJECTED'),
(11, 'sunichos', 'sunichos@gmail.com', '9800000000', 'sunichos', 'USER', 'ACTIVE'),
(12, 'abcd', 'abcd@gmail.com', '9800000000', 'abcdef', 'USER', 'pending'),
(13, 'Last', 'last@gmail.com', '9800000000', 'last123', 'USER', 'pending');

-- --------------------------------------------------------

--
-- Table structure for table `wishlists`
--

CREATE TABLE `wishlists` (
  `wishlist_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `wishlists`
--

INSERT INTO `wishlists` (`wishlist_id`, `user_id`, `service_id`, `created_at`) VALUES
(29, 2, 2, '2026-05-19 16:29:18'),
(42, 2, 4, '2026-05-20 23:28:58');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`booking_id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `service_id` (`service_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_preferred_date` (`preferred_date`),
  ADD KEY `idx_booking_date` (`booking_date`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`service_id`);

--
-- Indexes for table `technicians`
--
ALTER TABLE `technicians`
  ADD PRIMARY KEY (`technician_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `wishlists`
--
ALTER TABLE `wishlists`
  ADD PRIMARY KEY (`wishlist_id`),
  ADD UNIQUE KEY `unique_user_service` (`user_id`,`service_id`),
  ADD KEY `service_id` (`service_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `booking_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `technicians`
--
ALTER TABLE `technicians`
  MODIFY `technician_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `wishlists`
--
ALTER TABLE `wishlists`
  MODIFY `wishlist_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `wishlists`
--
ALTER TABLE `wishlists`
  ADD CONSTRAINT `wishlists_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `wishlists_ibfk_2` FOREIGN KEY (`service_id`) REFERENCES `services` (`service_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

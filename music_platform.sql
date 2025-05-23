-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 17, 2025 at 10:26 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `music_platform`
--

-- --------------------------------------------------------

--
-- Table structure for table `music`
--

CREATE TABLE `music` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `song_title` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `music`
--

INSERT INTO `music` (`id`, `user_id`, `file_name`, `file_path`, `song_title`) VALUES
(1, 1, 'user_1_67d63ac20061d0.34787856.mp3', 'uploads/blinhalimi/user_1_67d63ac20061d0.34787856.mp3', ''),
(2, 1, 'user_1_67d63bfb36cd16.95097166.mp3', 'uploads/blinhalimi/user_1_67d63bfb36cd16.95097166.mp3', ''),
(3, 1, 'user_1_67d63d5eb8b5b6.20302780.mp3', 'uploads/blinhalimi/user_1_67d63d5eb8b5b6.20302780.mp3', ''),
(4, 1, 'user_1_67d723a91863b7.54171303.mp3', 'uploads/blinhalimi/user_1_67d723a91863b7.54171303.mp3', ''),
(5, 1, 'user_1_67d883f6cb2799.00332450.mp3', 'uploads/blinhalimi/user_1_67d883f6cb2799.00332450.mp3', 'blion'),
(6, 1, 'user_1_67d8854662cfe8.04117216.mp3', 'uploads/blinhalimi/user_1_67d8854662cfe8.04117216.mp3', 'blion'),
(7, 1, 'user_1_67d886d32be9d0.53191109.mp3', 'uploads/blinhalimi/user_1_67d886d32be9d0.53191109.mp3', 'blin'),
(8, 1, 'user_1_67d88863c8eb32.73046048.mp3', 'uploads/blinhalimi/user_1_67d88863c8eb32.73046048.mp3', 'blin'),
(9, 1, 'user_1_67d8896ea48a12.87981125.mp3', 'uploads/blinhalimi/user_1_67d8896ea48a12.87981125.mp3', 'bliner'),
(10, 1, 'user_1_67d88a60e01f30.72864765.mp3', 'uploads/blinhalimi/user_1_67d88a60e01f30.72864765.mp3', 'blion');

-- --------------------------------------------------------

--
-- Table structure for table `music_files`
--

CREATE TABLE `music_files` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `song_title` varchar(255) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `upload_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `email`, `password`, `created_at`) VALUES
(1, 'example_user', 'example@email.com', 'hashed_password', '2025-03-17 21:12:45');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `music`
--
ALTER TABLE `music`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `music_files`
--
ALTER TABLE `music_files`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `music`
--
ALTER TABLE `music`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `music_files`
--
ALTER TABLE `music_files`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `music_files`
--
ALTER TABLE `music_files`
  ADD CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

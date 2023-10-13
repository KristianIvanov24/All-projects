-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Време на генериране:  3 юли 2023 в 10:32
-- Версия на сървъра: 10.4.28-MariaDB
-- Версия на PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данни: `project_db`
--

-- --------------------------------------------------------

--
-- Структура на таблица `going`
--

CREATE TABLE `going` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `date` date NOT NULL,
  `schedule_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `going`
--

INSERT INTO `going` (`id`, `user_id`, `title`, `date`, `schedule_id`) VALUES
(12, 2, 'demo', '2023-06-29', 37),
(13, 2, 'web<3', '1111-11-11', 39),
(14, 2, 'demo', '2023-06-29', 37),
(15, 2, 'demo', '2023-06-29', 37),
(16, 2, 'web<3', '1111-11-11', 39);

-- --------------------------------------------------------

--
-- Структура на таблица `schedules`
--

CREATE TABLE `schedules` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `date` date NOT NULL,
  `schedule_start` time NOT NULL,
  `schedule_end` time NOT NULL,
  `schedule_step` int(11) NOT NULL,
  `created_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `schedules`
--

INSERT INTO `schedules` (`id`, `title`, `date`, `schedule_start`, `schedule_end`, `schedule_step`, `created_by`) VALUES
(37, 'demo', '2023-06-29', '09:10:00', '12:10:00', 12, 2),
(39, 'web<3', '1111-11-11', '13:13:00', '14:14:00', 3, 1);

-- --------------------------------------------------------

--
-- Структура на таблица `schedule_records`
--

CREATE TABLE `schedule_records` (
  `schedule_id` int(11) NOT NULL,
  `slot_number` int(11) NOT NULL,
  `presenter_id` int(11) NOT NULL,
  `presentation_title` varchar(255) NOT NULL,
  `specialty` varchar(50) DEFAULT NULL,
  `course` int(11) NOT NULL,
  `group` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `schedule_records`
--

INSERT INTO `schedule_records` (`schedule_id`, `slot_number`, `presenter_id`, `presentation_title`, `specialty`, `course`, `group`) VALUES
(37, 13, 2, 'yrd', 'gsdg', 3, 2),
(39, 5, 2, 'gfffffff', 'si', 3, 1);

-- --------------------------------------------------------

--
-- Структура на таблица `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `faculty_number` varchar(6) NOT NULL,
  `username` varchar(15) NOT NULL,
  `email` varchar(64) NOT NULL,
  `password` varchar(256) NOT NULL,
  `type` enum('ADMIN','REGULAR') NOT NULL DEFAULT 'REGULAR'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `users`
--

INSERT INTO `users` (`id`, `faculty_number`, `username`, `email`, `password`, `type`) VALUES
(1, '11111', 'kivanov', 'kivanov@gmail.com', '$2y$10$Rc/WD0ipPqWqWNBePfaEL.5/mPdrIEYWZ6IuZHHX4CTcuZl2zoVm.', 'REGULAR'),
(2, '62522', 'mkmitreva', 'mkmitreva@uni-sofia.bg', '$2y$10$qIO6d2m5wmg8ihrymIrii.FW4cBYzjotmpOyhyBhy4eAMo46EKaKC', 'REGULAR');

--
-- Indexes for dumped tables
--

--
-- Индекси за таблица `going`
--
ALTER TABLE `going`
  ADD PRIMARY KEY (`id`),
  ADD KEY `going_users_foreign` (`user_id`),
  ADD KEY `schedules_foreign` (`schedule_id`);

--
-- Индекси за таблица `schedules`
--
ALTER TABLE `schedules`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_by` (`created_by`);

--
-- Индекси за таблица `schedule_records`
--
ALTER TABLE `schedule_records`
  ADD PRIMARY KEY (`schedule_id`,`slot_number`),
  ADD KEY `presenter_id` (`presenter_id`);

--
-- Индекси за таблица `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `faculty_number` (`faculty_number`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `going`
--
ALTER TABLE `going`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `schedules`
--
ALTER TABLE `schedules`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `schedule_records`
--
ALTER TABLE `schedule_records`
  MODIFY `schedule_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- Ограничения за дъмпнати таблици
--

--
-- Ограничения за таблица `going`
--
ALTER TABLE `going`
  ADD CONSTRAINT `going_users_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `schedules_foreign` FOREIGN KEY (`schedule_id`) REFERENCES `schedules` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ограничения за таблица `schedules`
--
ALTER TABLE `schedules`
  ADD CONSTRAINT `schedules_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`);

--
-- Ограничения за таблица `schedule_records`
--
ALTER TABLE `schedule_records`
  ADD CONSTRAINT `schedule_records_ibfk_1` FOREIGN KEY (`schedule_id`) REFERENCES `schedules` (`id`),
  ADD CONSTRAINT `schedule_records_ibfk_2` FOREIGN KEY (`presenter_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

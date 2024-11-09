-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 09, 2024 at 02:02 PM
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
-- Database: `lbms`
--

-- --------------------------------------------------------

--
-- Table structure for table `equipment`
--

CREATE TABLE `equipment` (
  `Equipment_ID` int(11) NOT NULL,
  `Equipment_Name` varchar(100) DEFAULT NULL,
  `Equipment_Type` varchar(50) DEFAULT NULL,
  `Equipment_Status` varchar(50) DEFAULT NULL,
  `Lab_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `equipment`
--

INSERT INTO `equipment` (`Equipment_ID`, `Equipment_Name`, `Equipment_Type`, `Equipment_Status`, `Lab_ID`) VALUES
(1, 'Microscope', 'Optical', 'Available', 1),
(2, 'Spectrometer', 'Chemical', 'Under Maintenance', 1),
(3, 'Thermometer', 'Physical', 'Available', 2),
(4, 'Centrifuge', 'Biological', 'Available', 3);

-- --------------------------------------------------------

--
-- Table structure for table `experiment`
--

CREATE TABLE `experiment` (
  `Experiment_ID` int(11) NOT NULL,
  `Experiment_Name` varchar(100) DEFAULT NULL,
  `Date` date DEFAULT NULL,
  `Lab_ID` int(11) DEFAULT NULL,
  `Staff_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `experiment`
--

INSERT INTO `experiment` (`Experiment_ID`, `Experiment_Name`, `Date`, `Lab_ID`, `Staff_ID`) VALUES
(1, 'Chemical Reactions', '2024-11-10', 1, 1),
(2, 'Physics of Motion', '2024-11-12', 2, 2),
(3, 'Cell Division', '2024-11-15', 3, 3);

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE `inventory` (
  `Item_ID` int(11) NOT NULL,
  `Item_Name` varchar(100) DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL,
  `Supplier` varchar(100) DEFAULT NULL,
  `Expiry_Date` date DEFAULT NULL,
  `Experiment_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `inventory`
--

INSERT INTO `inventory` (`Item_ID`, `Item_Name`, `Quantity`, `Supplier`, `Expiry_Date`, `Experiment_ID`) VALUES
(1, 'Hydrochloric Acid', 50, 'ChemSupply Inc.', '2025-01-01', 2),
(2, 'Sodium Chloride', 100, 'BioChem Ltd.', '2025-03-01', 1),
(3, 'Petri Dishes', 200, 'LabSupplies Co.', '2026-06-15', 3);

-- --------------------------------------------------------

--
-- Table structure for table `lab`
--

CREATE TABLE `lab` (
  `Lab_ID` int(11) NOT NULL,
  `Lab_Name` varchar(100) DEFAULT NULL,
  `Lab_Type` varchar(50) DEFAULT NULL,
  `Lab_Location` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lab`
--

INSERT INTO `lab` (`Lab_ID`, `Lab_Name`, `Lab_Type`, `Lab_Location`) VALUES
(1, 'Chemistry Lab', 'Chemical Analysis', 'Building A'),
(2, 'Physics Lab', 'Physics Experiments', 'Building B'),
(3, 'Biology Lab', 'Biological Research', 'Building C');

-- --------------------------------------------------------

--
-- Table structure for table `schedule`
--

CREATE TABLE `schedule` (
  `Schedule_ID` int(11) NOT NULL,
  `Lab_ID` int(11) DEFAULT NULL,
  `Date` date DEFAULT NULL,
  `Time` time DEFAULT NULL,
  `Equipment_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `schedule`
--

INSERT INTO `schedule` (`Schedule_ID`, `Lab_ID`, `Date`, `Time`, `Equipment_ID`) VALUES
(1, 1, '2024-11-10', '09:00:00', 1),
(2, 2, '2024-11-12', '10:30:00', 3),
(3, 3, '2024-11-15', '14:00:00', 4);

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `Staff_ID` int(11) NOT NULL,
  `Name` varchar(100) DEFAULT NULL,
  `Role` varchar(50) DEFAULT NULL,
  `Contact` varchar(50) DEFAULT NULL,
  `Lab_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`Staff_ID`, `Name`, `Role`, `Contact`, `Lab_ID`) VALUES
(1, 'John Doe', 'Lab Technician', '123-456-7890', 1),
(2, 'Jane Smith', 'Lab Manager', '234-567-8901', 2),
(3, 'Alice Brown', 'Research Assistant', '345-678-9012', 3);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `equipment`
--
ALTER TABLE `equipment`
  ADD PRIMARY KEY (`Equipment_ID`),
  ADD KEY `Lab_ID` (`Lab_ID`);

--
-- Indexes for table `experiment`
--
ALTER TABLE `experiment`
  ADD PRIMARY KEY (`Experiment_ID`),
  ADD KEY `Lab_ID` (`Lab_ID`),
  ADD KEY `Staff_ID` (`Staff_ID`);

--
-- Indexes for table `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`Item_ID`),
  ADD KEY `fk_experiment` (`Experiment_ID`);

--
-- Indexes for table `lab`
--
ALTER TABLE `lab`
  ADD PRIMARY KEY (`Lab_ID`);

--
-- Indexes for table `schedule`
--
ALTER TABLE `schedule`
  ADD PRIMARY KEY (`Schedule_ID`),
  ADD KEY `Lab_ID` (`Lab_ID`),
  ADD KEY `Equipment_ID` (`Equipment_ID`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`Staff_ID`),
  ADD KEY `Lab_ID` (`Lab_ID`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `equipment`
--
ALTER TABLE `equipment`
  ADD CONSTRAINT `equipment_ibfk_1` FOREIGN KEY (`Lab_ID`) REFERENCES `lab` (`Lab_ID`);

--
-- Constraints for table `experiment`
--
ALTER TABLE `experiment`
  ADD CONSTRAINT `experiment_ibfk_1` FOREIGN KEY (`Lab_ID`) REFERENCES `lab` (`Lab_ID`),
  ADD CONSTRAINT `experiment_ibfk_2` FOREIGN KEY (`Staff_ID`) REFERENCES `staff` (`Staff_ID`);

--
-- Constraints for table `inventory`
--
ALTER TABLE `inventory`
  ADD CONSTRAINT `fk_experiment` FOREIGN KEY (`Experiment_ID`) REFERENCES `experiment` (`Experiment_ID`);

--
-- Constraints for table `schedule`
--
ALTER TABLE `schedule`
  ADD CONSTRAINT `schedule_ibfk_1` FOREIGN KEY (`Lab_ID`) REFERENCES `lab` (`Lab_ID`),
  ADD CONSTRAINT `schedule_ibfk_2` FOREIGN KEY (`Equipment_ID`) REFERENCES `equipment` (`Equipment_ID`);

--
-- Constraints for table `staff`
--
ALTER TABLE `staff`
  ADD CONSTRAINT `staff_ibfk_1` FOREIGN KEY (`Lab_ID`) REFERENCES `lab` (`Lab_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

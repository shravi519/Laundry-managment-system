-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 07, 2022 at 10:36 AM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 8.1.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `laundry`
--

-- --------------------------------------------------------
DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_user_view` (IN `coupan_no` INT)  BEGIN

SELECT * FROM user_view WHERE coupan=coupan_no;

END$$

DELIMITER ;
--
-- Table structure for table `bill`
--

CREATE TABLE `bill` (
  `bill_id` int(11) NOT NULL,
  `cid` int(11) NOT NULL,
  `heavy` int(11) NOT NULL,
  `delicate` int(11) NOT NULL,
  `kids` int(11) NOT NULL,
  `other` int(11) NOT NULL,
  `total` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `bill`
--

INSERT INTO `bill` (`bill_id`, `cid`, `heavy`, `delicate`, `kids`, `other`, `total`) VALUES
(1, 1, 20, 20, 20, 20, 80),
(2, 2, 30, 30, 30, 30, 120),
(4, 4, 60, 60, 60, 60, 240),
(5, 5, 60, 60, 60, 60, 240),
(6, 6, 60, 60, 60, 60, 240),
(7, 7, 60, 60, 60, 60, 240),
(8, 8, 60, 60, 60, 60, 240);

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `cid` int(11) NOT NULL,
  `coupan` int(11) NOT NULL,
  `eid` int(11) NOT NULL,
  `cname` varchar(200) NOT NULL,
  `delicate` int(11) NOT NULL,
  `heavy` int(11) NOT NULL,
  `kids` int(11) NOT NULL,
  `other` int(11) NOT NULL,
  `service` varchar(200) NOT NULL,
  `staff` varchar(200) NOT NULL,
  `phone` int(11) NOT NULL,
  `address` varchar(200) NOT NULL,
  `date` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`cid`, `coupan`, `eid`, `cname`, `delicate`, `heavy`, `kids`, `other`, `service`, `staff`, `phone`, `address`, `date`) VALUES
(1, 70, 1, 'seeta', 2, 2, 2, 2, 'Dry wash', 'employee1', 2147483647, 'some address', '2022-12-06'),
(2, 10, 2, 'vani', 3, 3, 3, 3, '2', 'employee2', 2147483647, 'another address', '2022-12-06'),
(4, 20, 1, 'shivani', 2, 2, 2, 2, 'Dry wash', 'employee1', 2147483647, 'belgaum', '2022-12-07'),
(5, 30, 3, 'ff', 2, 2, 2, 2, 'Dry wash', 'employee3', 32423424, 'dfsdfds', '2022-12-07'),
(6, 40, 2, 'harshi', 2, 2, 2, 2, 'Dry wash', 'employee2', 657646533, 'madanthyar', '2022-12-07'),
(7, 60, 1, 'shama', 2, 2, 2, 2, 'Dry wash', 'employee1', 2147483647, 'shimoga', '2022-12-07'),
(8, 50, 2, 'smrithi', 2, 2, 2, 2, '3', 'employee2', 44554767, 'ujire', '2022-12-07'),
(9, 80, 2, 'sidhi', 2, 2, 2, 2, '3', 'employee2', 44554767, 'ujire', '2023-01-14');

-- --------------------------------------------------------
--
-- Triggers `customer`
--
DELIMITER $$
CREATE TRIGGER `on_delete_customer_data` BEFORE DELETE ON `customer` FOR EACH ROW INSERT INTO del_customer_data values(OLD.cname,OLD.phone,OLD.address,OLD.date)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `on_update_customer_data` BEFORE UPDATE ON `customer` FOR EACH ROW INSERT INTO up_cust_data VALUES(OLD.coupan,OLD.cname,OLD.delicate,OLD.heavy,OLD.kids,OLD.other,OLD.service,OLD.staff,OLD.phone,OLD.address)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `del_customer_data`
--

CREATE TABLE `del_customer_data` (
  `name` varchar(200) NOT NULL,
  `phone` int(11) NOT NULL,
  `address` varchar(200) NOT NULL,
  `c_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `del_customer_data`
--

INSERT INTO `del_customer_data` (`name`, `phone`, `address`, `c_date`) VALUES
('seeta', 2147483647, 'some address', '2023-01-06'),
('vani', 2147483647, 'udupi', '2023-01-13'),
('shama', 2147483647, 'shimoga', '2022-12-07')
;

-- --------------------------------------------------------

--
-- Table structure for table `del_emp_data`
--

CREATE TABLE `del_emp_data` (
  `name` varchar(200) NOT NULL,
  `phone` int(11) NOT NULL,
  `address` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `del_emp_data`
--

INSERT INTO `del_emp_data` (`name`, `phone`, `address`) VALUES
('employee3', 2147483647, 'address3'),
('avinash', 2147483647, 'dandeli'),
('hanish', 2147483647, 'kotewada'),
('sandesh', 2147483647, 'address1'),
('Srishti', 864876234, 'Hasan'),
('vidhi', 948534583, 'sirsi'),
('sham', 2147483647, 'thirthalli'),
('avi', 2147483647, 'dandeli');

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `eid` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `phone` int(11) NOT NULL,
  `address` varchar(200) NOT NULL,
  `salary` int(11) NOT NULL,
  `gender` varchar(20) NOT NULL,
  `age` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`eid`, `name`, `phone`, `address`, `salary`, `gender`, `age`) VALUES
(1, 'Aesha', 2147483647, 'address1', 7000, 'Female', 21),
(2, 'Srishti', 864876234, 'Hasan', 8000, 'Female', 35),
(3, 'ramya', 2147483647, 'shivmoga', 9000, 'Male', 23),
(4, 'bhanu', 2147483647, 'thirthalli', 500, 'Male', 21);

--
-- Triggers `employee`
--
DELIMITER $$
CREATE TRIGGER `on_delete_employee_data` BEFORE DELETE ON `employee` FOR EACH ROW INSERT INTO del_emp_data VALUES(OLD.name,OLD.phone,OLD.address)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `on_update_employee_data` BEFORE UPDATE ON `employee` FOR EACH ROW INSERT INTO up_emp_data VALUES(OLD.name,OLD.phone,OLD.address,OLD.salary,OLD.gender,OLD.age)
$$
DELIMITER ;
-- --------------------------------------------------------

--
-- Table structure for table `price`
--

CREATE TABLE `price` (
  `pid` int(11) NOT NULL,
  `heavy` int(11) NOT NULL,
  `delicate` int(11) NOT NULL,
  `kids` int(11) NOT NULL,
  `other` int(11) NOT NULL,
  `date` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `price`
--

INSERT INTO `price` (`pid`, `heavy`, `delicate`, `kids`, `other`, `date`) VALUES
(1, 30, 30, 30, 30, '2022-01-05');

-- --------------------------------------------------------

--
-- Table structure for table `up_cust_data`
--

CREATE TABLE `up_cust_data` (
  `coupan` int(10) NOT NULL,
  `name` varchar(20) NOT NULL,
  `heavy` int(10) NOT NULL,
  `delicate` int(10) NOT NULL,
  `kids` int(10) NOT NULL,
  `other` int(10) NOT NULL,
  `service` varchar(20) NOT NULL,
  `staff` varchar(20) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `address` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `up_cust_data`
--

INSERT INTO `up_cust_data` (`coupan`, `name`, `heavy`, `delicate`, `kids`, `other`, `service`, `staff`, `phone`, `address`) VALUES
(32, 'nikki', 2, 2, 2, 2, 'Dry wash', 'Aesha', '2147483647', 'london');

-- --------------------------------------------------------

--
-- Table structure for table `up_emp_data`
--

CREATE TABLE `up_emp_data` (
  `name` varchar(20) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `address` varchar(20) NOT NULL,
  `salary` int(10) NOT NULL,
  `gender` varchar(10) NOT NULL,
  `age` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `up_emp_data`
--

INSERT INTO `up_emp_data` (`name`, `phone`, `address`, `salary`, `gender`, `age`) VALUES
('Aesha', '2147483647', 'address1', 7000, 'Female', 21);

-- --------------------------------------------------------

--
-- Table structure for table `user_view`
--

CREATE TABLE `user_view` (
  `cid` int(11) NOT NULL,
  `pid` int(11) NOT NULL,
  `coupan` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `heavy` int(11) NOT NULL,
  `delicate` int(11) NOT NULL,
  `kids` int(11) NOT NULL,
  `other` int(11) NOT NULL,
  `t_amount` int(11) NOT NULL,
  `L_status` varchar(20) NOT NULL DEFAULT 'Not done',
  `P_status` varchar(20) NOT NULL DEFAULT 'Not paid'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_view`
--

INSERT INTO `user_view` (`cid`, `pid`, `coupan`, `name`, `heavy`, `delicate`, `kids`, `other`, `t_amount`, `L_status`, `P_status`) VALUES
(1, 1, 40, 'seeta', 2, 2, 2, 2, 80, 'Done', 'Paid'),
(2, 1, 10, 'vani', 3, 3, 3, 3, 120, 'Done', 'Paid'),
(4, 1, 20, 'shivani', 2, 2, 2, 2, 240, 'Done', 'Paid'),
(5, 1, 70, 'ff', 2, 2, 2, 2, 240, 'Done', 'Not Paid'),
(6, 1, 30, 'harshi', 2, 2, 2, 2, 240, 'Not done', 'Not Paid'),
(7, 1, 60, 'shama', 2, 2, 2, 2, 240, 'Not done', 'Not paid'),
(8, 1, 50, 'smriti', 2, 2, 2, 2, 240, 'Not done', 'Not paid');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bill`
--
ALTER TABLE `bill`
  ADD PRIMARY KEY (`bill_id`,`cid`),
  ADD KEY `cid` (`cid`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`cid`,`coupan`,`eid`),
  ADD KEY `eid` (`eid`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`eid`);

--
-- Indexes for table `price`
--
ALTER TABLE `price`
  ADD PRIMARY KEY (`pid`);

--
-- Indexes for table `user_view`
--
ALTER TABLE `user_view`
  ADD PRIMARY KEY (`cid`,`pid`),
  ADD KEY `pid` (`pid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bill`
--
ALTER TABLE `bill`
  MODIFY `bill_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `cid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `employee`
--
ALTER TABLE `employee`
  MODIFY `eid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bill`
--
ALTER TABLE `bill`
  ADD CONSTRAINT `bill_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `customer` (`cid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `customer`
--
ALTER TABLE `customer`
  ADD CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`eid`) REFERENCES `employee` (`eid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_view`
--
ALTER TABLE `user_view`
  ADD CONSTRAINT `user_view_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `customer` (`cid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_view_ibfk_2` FOREIGN KEY (`pid`) REFERENCES `price` (`pid`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

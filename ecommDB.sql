-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Dec 06, 2018 at 11:17 AM
-- Server version: 5.7.24-0ubuntu0.16.04.1
-- PHP Version: 7.0.32-0ubuntu0.16.04.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ecommDB`
--

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `amount` decimal(10,0) NOT NULL,
  `total_items` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `customer_id`, `date_time`, `amount`, `total_items`) VALUES
(1, 9, '2018-12-02 13:16:49', '100', 1),
(2, 10, '2018-12-02 13:16:49', '230', 2),
(3, 13, '2018-12-02 13:20:47', '520', 3),
(4, 13, '2018-12-02 13:20:47', '700', 4),
(5, 11, '2018-12-02 17:35:05', '230', 2),
(6, 14, '2018-12-02 13:20:47', '700', 4);

-- --------------------------------------------------------

--
-- Table structure for table `order_details`
--

CREATE TABLE `order_details` (
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `order_details`
--

INSERT INTO `order_details` (`order_id`, `product_id`, `quantity`) VALUES
(1, 1, 1),
(2, 2, 1),
(2, 3, 1),
(3, 4, 1),
(3, 5, 1),
(3, 6, 1),
(4, 7, 1),
(4, 8, 1),
(4, 9, 1),
(4, 10, 1),
(5, 2, 1),
(5, 3, 1),
(6, 7, 1),
(6, 8, 1),
(6, 9, 1),
(6, 10, 1);

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `product_id` int(11) NOT NULL,
  `product_name` varchar(50) NOT NULL,
  `price` decimal(10,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`product_id`, `product_name`, `price`) VALUES
(1, 'apple', '100'),
(2, 'ball', '110'),
(3, 'cat', '120'),
(4, 'dog', '130'),
(5, 'elephant', '140'),
(6, 'fish', '150'),
(7, 'grapes', '160'),
(8, 'hen', '170'),
(9, 'icecream', '180'),
(10, 'jack', '190');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `email_id` varchar(50) NOT NULL,
  `password` varchar(150) NOT NULL,
  `admin_status` tinyint(1) NOT NULL DEFAULT '0',
  `active_status` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email_id`, `password`, `admin_status`, `active_status`) VALUES
(9, 'dfsd', 'pi1@y.com', '$2b$10$j/F8iJgY6O5qck46ukZOV.ZstGwIIHDSb9rRCwM9l0K7KTd9VrU7W', 0, 1),
(10, 'dfsd', 'p11@y.com', '$2b$10$ur3IYzyimRuw3cQu5w4vCuvztpPD0FR6SXr3eeinDtIBfEg1Y2W8C', 0, 1),
(11, 'new', 'p1@y.com', '$2b$10$2OzSKG7HXLLQpRxg8q4qIubPl14MiRr1.osWkqBl/N0hd/Ou2yjjC', 0, 1),
(13, 'abcd', 'abcd@gmail.com', '$2b$10$bUOhgQC1ipFQvQMhDsWWdu0qnhjl10iQ12Mp2KuQXyod6/2GBU2Q6', 0, 1),
(14, 'vaibhav', 'vaibhav@gmail.com', '$2b$10$yVT6P7hG4uCS9w5eF1ZEI.MsUZ1bZxkILnexfOhMHwokA.7FDBsiq', 1, 1),
(15, 'vaibhav', 'v15@gmail.com', '$2b$10$asdjuLgVdPBFys7I5QQI/uLaBothVWxYrEFu4wVJukmTBDnxd7qRW', 0, 1),
(16, 'vaibhav', 'temp@gmail.com', '$2b$10$QuMO86jjMsJtLoP15B1K0uB.AELOCjBbTxhjOmC8sKzii8wvnJmjm', 0, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `customer_id_fk` (`customer_id`);

--
-- Indexes for table `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`order_id`,`product_id`),
  ADD KEY `product_id_fk` (`product_id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`product_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email_id` (`email_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `customer_id_fk` FOREIGN KEY (`customer_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `order_details`
--
ALTER TABLE `order_details`
  ADD CONSTRAINT `order_id_fk` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `product_id_fk` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

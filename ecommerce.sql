-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 21, 2025 at 05:16 AM
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
-- Database: `ecommerce`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `username`, `email`, `password`, `created_at`) VALUES
(1, 'himash', 'Himashmadushanka@gmail.com', '$2b$12$J/86xpJkNKX6iTbiSqHnCez6qnkW0WMBG4k9l223hZs2zeDC02ZaO', '2025-11-21 04:11:23');

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `id` int(11) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `quantity` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`id`, `username`, `product_id`, `product_name`, `price`, `quantity`) VALUES
(10, 'himash', 40, 'Adidas Hoodie', 80.00, 1);

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`) VALUES
(1, 'Clothing'),
(2, 'Electronics'),
(3, 'Accessoriess'),
(4, 'Home & Kitchen'),
(5, 'Sports & Fitness');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `total_amount` decimal(10,2) DEFAULT NULL,
  `payment_method` varchar(50) DEFAULT NULL,
  `shipping_address` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `username`, `total_amount`, `payment_method`, `shipping_address`, `created_at`) VALUES
(1, 'himash', 1190.00, 'Cash on Delivery', 'ahuug,gfhjh', '2025-11-19 20:06:32'),
(2, 'himash', 80.00, 'Cash on Delivery', 'akuressa,matara', '2025-11-19 20:07:20'),
(3, 'himash', 80.00, 'Cash on Delivery', 'matara', '2025-11-19 20:15:16');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `product_name`, `price`, `quantity`) VALUES
(1, 1, 42, 'Reebok Shoes', 90.00, 1),
(2, 1, 45, 'Samsung Galaxy S23', 1100.00, 1),
(3, 2, 40, 'Adidas Hoodie', 80.00, 1),
(4, 3, 40, 'Adidas Hoodie', 80.00, 1);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `description` text DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `price`, `description`, `image`, `category_id`) VALUES
(39, 'Nike T-Shirt', 25.00, 'Cotton sports t-shirt', 'https://via.placeholder.com/150?text=Nike+T-Shirt', 1),
(40, 'Adidas Hoodie', 80.00, 'Warm hoodie for winter', 'https://via.placeholder.com/150?text=Adidas+Hoodie', 1),
(41, 'Puma Shorts', 30.00, 'Lightweight running shorts', 'https://via.placeholder.com/150?text=Puma+Shorts', 1),
(42, 'Reebok Shoes', 90.00, 'Comfortable running shoes', 'https://via.placeholder.com/150?text=Reebok+Shoes', 1),
(43, 'UnderArmour Cap', 20.00, 'Sports baseball cap', 'https://via.placeholder.com/150?text=UnderArmour+Cap', 1),
(44, 'Apple iPhone 15', 1200.00, 'Latest smartphone', 'https://via.placeholder.com/150?text=iPhone+15', 2),
(45, 'Samsung Galaxy S23', 1100.00, 'High-performance smartphone', 'https://via.placeholder.com/150?text=Galaxy+S23', 2),
(46, 'Sony Headphones', 150.00, 'Noise-canceling headphones', 'https://via.placeholder.com/150?text=Sony+Headphones', 2),
(47, 'Dell Laptop', 950.00, 'Powerful work laptop', 'https://via.placeholder.com/150?text=Dell+Laptop', 2),
(48, 'Canon Camera', 800.00, 'Digital camera for photography', 'https://via.placeholder.com/150?text=Canon+Camera', 2),
(49, 'Ray-Ban Sunglasses', 120.00, 'Stylish sunglasses', 'https://via.placeholder.com/150?text=Ray-Ban+Sunglasses', 3),
(50, 'Fossil Watch', 180.00, 'Leather strap wristwatch', 'https://via.placeholder.com/150?text=Fossil+Watch', 3),
(51, 'Coach Handbag', 250.00, 'Designer handbag', 'https://via.placeholder.com/150?text=Coach+Handbag', 3),
(52, 'Nike Sports Bag', 60.00, 'Gym backpack', 'https://via.placeholder.com/150?text=Nike+Sports+Bag', 3),
(53, 'Apple AirPods', 200.00, 'Wireless earphones', 'https://via.placeholder.com/150?text=AirPods', 3),
(54, 'Instant Pot', 120.00, 'Electric pressure cooker', 'https://via.placeholder.com/150?text=Instant+Pot', 4),
(55, 'Dyson Vacuum', 350.00, 'High-efficiency vacuum cleaner', 'https://via.placeholder.com/150?text=Dyson+Vacuum', 4),
(56, 'KitchenAid Mixer', 400.00, 'Stand mixer for baking', 'https://via.placeholder.com/150?text=KitchenAid+Mixer', 4),
(57, 'Philips Toaster', 50.00, '2-slice toaster', 'https://via.placeholder.com/150?text=Philips+Toaster', 4),
(58, 'Ninja Blender', 80.00, 'High-speed blender', 'https://via.placeholder.com/150?text=Ninja+Blender', 4),
(59, 'Treadmill', 600.00, 'Home fitness treadmill', 'https://via.placeholder.com/150?text=Treadmill', 5),
(60, 'Dumbbell Set', 100.00, 'Adjustable dumbbells', 'https://via.placeholder.com/150?text=Dumbbells', 5),
(61, 'Yoga Mat', 35.00, 'Non-slip exercise mat', 'https://via.placeholder.com/150?text=Yoga+Mat', 5),
(62, 'Exercise Bike', 450.00, 'Stationary bike for home', 'https://via.placeholder.com/150?text=Exercise+Bike', 5),
(63, 'Jump Rope', 15.00, 'Speed skipping rope', 'https://via.placeholder.com/150?text=Jump+Rope', 5),
(64, 'Nike Socks', 12.00, 'Cotton ankle socks', 'https://via.placeholder.com/150?text=Nike+Socks', 1),
(65, 'Adidas Cap', 18.00, 'Baseball cap', 'https://via.placeholder.com/150?text=Adidas+Cap', 1),
(66, 'Puma Jacket', 85.00, 'Sports jacket', 'https://via.placeholder.com/150?text=Puma+Jacket', 1),
(67, 'Reebok Hoodie', 75.00, 'Warm hoodie', 'https://via.placeholder.com/150?text=Reebok+Hoodie', 1),
(68, 'UnderArmour Shorts', 28.00, 'Running shorts', 'https://via.placeholder.com/150?text=UnderArmour+Shorts', 1),
(69, 'Samsung TV 55\"', 700.00, 'LED Smart TV', 'https://via.placeholder.com/150?text=Samsung+TV', 2),
(70, 'LG Monitor', 250.00, '4K computer monitor', 'https://via.placeholder.com/150?text=LG+Monitor', 2),
(71, 'Bose Speakers', 300.00, 'Wireless Bluetooth speakers', 'https://via.placeholder.com/150?text=Bose+Speakers', 2),
(72, 'HP Printer', 150.00, 'All-in-one printer', 'https://via.placeholder.com/150?text=HP+Printer', 2),
(73, 'GoPro Hero 12', 450.00, 'Action camera', 'https://via.placeholder.com/150?text=GoPro+Hero+12', 2),
(74, 'Gucci Wallet', 200.00, 'Leather wallet', 'https://via.placeholder.com/150?text=Gucci+Wallet', 3),
(75, 'Michael Kors Bag', 230.00, 'Designer handbag', 'https://via.placeholder.com/150?text=Michael+Kors+Bag', 3),
(76, 'Apple Watch', 350.00, 'Smartwatch with fitness tracking', 'https://via.placeholder.com/150?text=Apple+Watch', 3),
(77, 'Fitbit Versa', 180.00, 'Smart fitness watch', 'https://via.placeholder.com/150?text=Fitbit+Versa', 3),
(78, 'Herschel Backpack', 90.00, 'Travel backpack', 'https://via.placeholder.com/150?text=Herschel+Backpack', 3),
(79, 'Cuisinart Coffee Maker', 120.00, 'Automatic coffee machine', 'https://via.placeholder.com/150?text=Cuisinart+Coffee+Maker', 4),
(80, 'Breville Kettle', 60.00, 'Electric kettle', 'https://via.placeholder.com/150?text=Breville+Kettle', 4),
(81, 'Samsung Microwave', 150.00, 'Convection microwave', 'https://via.placeholder.com/150?text=Samsung+Microwave', 4),
(82, 'Instant Pot Duo', 130.00, 'Multi-function pressure cooker', 'https://via.placeholder.com/150?text=Instant+Pot+Duo', 4),
(83, 'Vitamix Blender', 400.00, 'High-power blender', 'https://via.placeholder.com/150?text=Vitamix+Blender', 4),
(84, 'Bowflex Weights', 600.00, 'Adjustable home gym set', 'https://via.placeholder.com/150?text=Bowflex+Weights', 5),
(85, 'Kettlebell Set', 90.00, 'Cast iron kettlebells', 'https://via.placeholder.com/150?text=Kettlebells', 5),
(86, 'Resistance Bands', 25.00, 'Fitness resistance bands', 'https://via.placeholder.com/150?text=Resistance+Bands', 5),
(87, 'Medicine Ball', 30.00, 'Weighted ball for workouts', 'https://via.placeholder.com/150?text=Medicine+Ball', 5),
(88, 'Pull-Up Bar', 45.00, 'Doorway pull-up bar', 'https://via.placeholder.com/150?text=Pull-Up+Bar', 5),
(89, 'Nike Shorts', 27.00, 'Casual sports shorts', 'https://via.placeholder.com/150?text=Nike+Shorts', 1),
(90, 'Adidas T-Shirt', 22.00, 'Short sleeve sports t-shirt', 'https://via.placeholder.com/150?text=Adidas+T-Shirt', 1),
(91, 'Puma Cap', 17.00, 'Baseball cap', 'https://via.placeholder.com/150?text=Puma+Cap', 1),
(92, 'Reebok Shoes', 88.00, 'Comfortable running shoes', 'https://via.placeholder.com/150?text=Reebok+Shoes2', 1),
(93, 'UnderArmour Hoodie', 78.00, 'Sports hoodie', 'https://via.placeholder.com/150?text=UnderArmour+Hoodie2', 1),
(94, 'Apple MacBook', 1500.00, 'Laptop for professionals', 'https://via.placeholder.com/150?text=MacBook', 2),
(95, 'Dell XPS', 1200.00, 'High performance laptop', 'https://via.placeholder.com/150?text=Dell+XPS', 2),
(96, 'Samsung Galaxy Tab', 600.00, 'Tablet device', 'https://via.placeholder.com/150?text=Galaxy+Tab', 2),
(97, 'Sony PlayStation 5', 500.00, 'Game console', 'https://via.placeholder.com/150?text=PS5', 2),
(98, 'Nintendo Switch', 400.00, 'Portable game console', 'https://via.placeholder.com/150?text=Switch', 2),
(99, 'Ray-Ban Glasses', 125.00, 'Stylish eyewear', 'https://via.placeholder.com/150?text=Ray-Ban+Glasses', 3),
(100, 'Fossil Watch', 175.00, 'Leather strap watch', 'https://via.placeholder.com/150?text=Fossil+Watch2', 3),
(101, 'Coach Wallet', 180.00, 'Designer wallet', 'https://via.placeholder.com/150?text=Coach+Wallet2', 3),
(102, 'Adidas Bag', 65.00, 'Sports backpack', 'https://via.placeholder.com/150?text=Adidas+Bag', 3),
(103, 'Nike Socks', 14.00, 'Cotton socks', 'https://via.placeholder.com/150?text=Nike+Socks2', 3),
(104, 'KitchenAid Mixer', 400.00, 'Stand mixer for baking', 'https://via.placeholder.com/150?text=KitchenAid+Mixer2', 4),
(105, 'Philips Blender', 85.00, 'High-speed blender', 'https://via.placeholder.com/150?text=Philips+Blender', 4),
(106, 'Dyson Hair Dryer', 300.00, 'Powerful hair dryer', 'https://via.placeholder.com/150?text=Dyson+Hair+Dryer', 4),
(107, 'Instant Pot Duo', 140.00, 'Multi-function pressure cooker', 'https://via.placeholder.com/150?text=Instant+Pot+Duo2', 4),
(108, 'Breville Coffee Maker', 120.00, 'Automatic coffee machine', 'https://via.placeholder.com/150?text=Breville+Coffee+Maker', 4),
(109, 'Treadmill Pro', 650.00, 'Home fitness treadmill', 'https://via.placeholder.com/150?text=Treadmill+Pro', 5),
(110, 'Exercise Bike', 450.00, 'Stationary bike for home', 'https://via.placeholder.com/150?text=Exercise+Bike2', 5),
(111, 'Dumbbell Set', 110.00, 'Adjustable dumbbells', 'https://via.placeholder.com/150?text=Dumbbells+Set', 5),
(112, 'Yoga Mat', 38.00, 'Non-slip exercise mat', 'https://via.placeholder.com/150?text=Yoga+Mat2', 5),
(113, 'Jump Rope', 16.00, 'Speed skipping rope', 'https://via.placeholder.com/150?text=Jump+Rope2', 5);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `street` text DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `zip` varchar(20) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `profile_pic` varchar(255) DEFAULT 'default.png',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_admin` tinyint(1) DEFAULT 0,
  `role` enum('user','admin') DEFAULT 'user'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `phone`, `dob`, `street`, `city`, `state`, `zip`, `country`, `profile_pic`, `created_at`, `is_admin`, `role`) VALUES
(7, 'himash', 'Himashmadushanka975@gmail.com', '$2b$12$ZIw8N1MiqNSFE9DHaZDf0eOVs1j5S4qWiyWP5VpnibCsbaQ0Rz8/K', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'default.png', '2025-11-20 11:44:44', 0, 'user');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=114;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

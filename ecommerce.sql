-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 24, 2025 at 07:19 PM
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
-- Table structure for table `addresses`
--

CREATE TABLE `addresses` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `street` text DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `zip` varchar(20) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `is_default` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `addresses`
--

INSERT INTO `addresses` (`id`, `user_id`, `street`, `city`, `state`, `zip`, `country`, `is_default`, `created_at`, `updated_at`) VALUES
(1, 7, '123 Main Street', 'New York', 'NY', '10000', 'United States', 1, '2025-11-23 10:32:22', '2025-11-23 10:34:44');

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `reset_token` varchar(255) DEFAULT NULL,
  `reset_token_expiry` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `username`, `email`, `password`, `created_at`, `reset_token`, `reset_token_expiry`) VALUES
(1, 'himash', 'Himashmadushanka@gmail.com', '$2b$12$J/86xpJkNKX6iTbiSqHnCez6qnkW0WMBG4k9l223hZs2zeDC02ZaO', '2025-11-21 04:11:23', NULL, NULL),
(2, 'admin', 'Himashmadushanka975@gmail.com', '$2b$12$30LfYhMPSkrRNarDI0LBteReSz0u7YEI7Jqx0NBX/sJOZbABLEUgG', '2025-11-22 14:37:26', NULL, NULL),
(4, 'madu', 'Himas@gmail.com', '$2b$12$cPw7qfWD9VXZKRc.phjaR.4qqklzM9N9okKCJKW3kmmd8d0nDgPPa', '2025-11-23 05:19:43', NULL, NULL);

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
(10, 'himash', 40, 'Adidas Hoodie', 80.00, 1),
(11, 'himash', 42, 'Reebok Shoes', 90.00, 1),
(12, 'himash', 43, 'UnderArmour Cap', 20.00, 1);

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
-- Table structure for table `contact_messages`
--

CREATE TABLE `contact_messages` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_read` tinyint(1) DEFAULT 0,
  `deleted` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contact_messages`
--

INSERT INTO `contact_messages` (`id`, `name`, `email`, `message`, `created_at`, `is_read`, `deleted`) VALUES
(1, 'Himash', 'Himashmadushanka975@gmail.com', 'gjvjkk', '2025-11-23 05:33:38', 1, 1),
(2, '123', 'Himashmadushanka975@gmail.com', 'hello', '2025-11-23 05:34:16', 1, 0);

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
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` varchar(50) DEFAULT 'Pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `username`, `total_amount`, `payment_method`, `shipping_address`, `created_at`, `status`) VALUES
(1, 'himash', 1190.00, 'Cash on Delivery', 'ahuug,gfhjh', '2025-11-19 20:06:32', 'Pending');

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
(2, 1, 45, 'Samsung Galaxy S23', 1100.00, 1);

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
(42, 'Reebok Shoes', 90.00, 'Comfortable running shoes', '/static/images/Reebok_Shoe.jpeg', 1),
(43, 'UnderArmour Cap', 20.00, 'Sports baseball cap', '/static/images/UnderArmour_Cap.jpeg', 1),
(44, 'Apple iPhone 15', 1200.00, 'Latest smartphone', '/static/images/Apple_iPhone15.jpeg', 2),
(45, 'Samsung Galaxy S23', 1100.00, 'High-performance smartphone', '/static/images/SamsungGalaxyS23.jpeg', 2),
(46, 'Sony Headphones', 150.00, 'Noise-canceling headphones', '/static/images/Sony_Headphones.jpeg', 2),
(48, 'Canon Camera', 800.00, 'Digital camera for photography', '/static/images/Canon_Camera.jpeg', 2),
(49, 'Ray-Ban Sunglasses', 120.00, 'Stylish sunglasses', '/static/images/Ray_Ban_Glasses.jpeg', 3),
(50, 'Fossil Watch', 180.00, 'Leather strap wristwatch', '/static/images/Fossil_Watch.jpeg', 3),
(51, 'Coach Handbag', 250.00, 'Designer handbag', '/static/images/Coach_Handbag.jpeg\r\n', 3),
(52, 'Nike Sports Bag', 60.00, 'Gym backpack', '/static/images/Nike_Sports_Bag.jpeg', 3),
(53, 'Apple AirPods', 200.00, 'Wireless earphones', '/static/images/Apple_AirPods.jpeg', 3),
(54, 'Instant Pot', 120.00, 'Electric pressure cooker', '/static/images/Instant_Pot.jpeg', 4),
(55, 'Dyson Vacuum', 350.00, 'High-efficiency vacuum cleaner', '/static/images/\r\nDyson_Vacuum.jpeg\r\n', 4),
(56, 'KitchenAid Mixer', 400.00, 'Stand mixer for baking', '/static/images/\r\nKitchenAid_Mixer.jpeg', 4),
(57, 'Philips Toaster', 50.00, '2-slice toaster', '/static/images/\r\nPhilips_Toaster.jpeg', 4),
(58, 'Ninja Blender', 80.00, 'High-speed blender', '/static/images/\r\nNinja_Blender.jpeg', 4),
(59, 'Treadmill', 600.00, 'Home fitness treadmill', '/static/images/\r\nTreadmill.jpeg', 5),
(60, 'Dumbbell Set', 100.00, 'Adjustable dumbbells', '/static/images/\r\nDumbbell_Sets.jpeg\r\n', 5),
(61, 'Yoga Mat', 35.00, 'Non-slip exercise mat', '/static/images/\r\nYoga_Mat.jpeg', 5),
(63, 'Jump Rope', 15.00, 'Speed skipping rope', '/static/images/\r\nJump_Rope.jpeg', 5),
(64, 'Nike Socks', 12.00, 'Cotton ankle socks', '/static/images/\r\nNike_Sockss.jpeg', 1),
(65, 'Adidas Cap', 18.00, 'Baseball cap', '/static/images/\r\nAdidas_Cap.jpeg', 1),
(66, 'Puma Jacket', 85.00, 'Sports jacket', '/static/images/\r\nPuma_jacket.jpeg', 1),
(67, 'Reebok Hoodie', 75.00, 'Warm hoodie', '/static/images/\r\nReebok_Hoodie.jpeg', 1),
(68, 'UnderArmour Shorts', 28.00, 'Running shorts', '/static/images/\r\nUnderArmour_Shorts.jpeg', 1),
(69, 'Samsung TV 55\"', 700.00, 'LED Smart TV', '/static/images/\r\nSamsung_TV.jpeg', 2),
(70, 'LG Monitor', 250.00, '4K computer monitor', '/static/images/\r\nLG_Monitor.jpeg', 2),
(71, 'Bose Speakers', 300.00, 'Wireless Bluetooth speakers', '/static/images/\r\nBose_Speakers.jpeg', 2),
(72, 'HP Printer', 150.00, 'All-in-one printer', '/static/images/\r\nHP_Printer.jpeg', 2),
(73, 'GoPro Hero 12', 450.00, 'Action camera', '/static/images/\r\nGoPro_Hero12.jpeg', 2),
(74, 'Gucci Wallet', 200.00, 'Leather wallet', '/static/images/\r\nGucci_Wallets.jpeg', 3),
(75, 'Michael Kors Bag', 230.00, 'Designer handbag', '/static/images/\r\nMichael_Kors_Bag.jpeg', 3),
(76, 'Apple Watch', 350.00, 'Fitbit_Versa.jpeg', '/static/images/\r\nApple_Watches.jpeg', 3),
(77, 'Fitbit Versa', 180.00, 'Smart fitness watch', '/static/images/\r\nApple_Watch.jpeg', 3),
(78, 'Herschel Backpack', 90.00, 'Travel backpack', '/static/images/\r\nHerschel_Backpack.jpeg', 3),
(79, 'Automatic coffee machine', 120.00, 'Automatic coffee machine', '/static/images/\r\nBreville_Coffee_Maker.jpeg', 4),
(80, 'Breville Kettle', 60.00, 'Electric kettle', '/static/images/\r\nBreville_Kettle.jpeg', 4),
(81, 'Samsung Microwave', 150.00, 'Convection microwave', '/static/images/\r\nSamsung_Microwave.jpeg', 4),
(82, 'Instant Pot Duo', 130.00, 'Multi-function pressure cooker', '/static/images/\r\nInstant.jpeg', 4),
(83, 'Vitamix Blender', 400.00, 'High-power blender', '/static/images/\r\nVitamix_Blender.jpeg', 4),
(84, 'Bowflex Weights', 600.00, 'Adjustable home gym set', '/static/images/\r\nBowflex_Weights.jpeg', 5),
(85, 'Kettlebell Set', 90.00, 'Cast iron kettlebells', '/static/images/\r\nKettlebell_Set.jpeg', 5),
(86, 'Resistance Bands', 25.00, 'Fitness resistance bands', '/static/images/\r\nResistance_Bands.jpeg', 5),
(87, 'Medicine Ball', 30.00, 'Weighted ball for workouts', '/static/images/\r\nMedicine_Ball.jpeg', 5),
(88, 'Pull-Up Bar', 45.00, 'Doorway pull-up bar', '/static/images/\r\nPull_Up_Bar.jpeg', 5),
(89, 'Nike Shorts', 27.00, 'Casual sports shorts', '/static/images/\r\nNike_Shorts.jpeg', 1),
(90, 'Adidas T-Shirt', 22.00, 'Short sleeve sports t-shirt', '/static/images/\r\nAdidas_T_Shirt.jpeg', 1),
(91, 'Puma Cap', 17.00, 'Baseball cap', '/static/images/\r\nPuma_Cap.jpeg', 1),
(92, 'Reebok Shoes', 88.00, 'Comfortable running shoes', '/static/images/\r\nReebok_Shoes.jpeg', 1),
(93, 'UnderArmour Hoodie', 78.00, 'Sports hoodie', '/static/images/\r\nSports_hoodie.jpeg', 1),
(94, 'Apple MacBook', 1500.00, 'Laptop for professionals', '/static/images/\r\nApple_MacBook.jpeg', 2),
(95, 'Dell XPS', 1200.00, 'High performance laptop', '/static/images/\r\nDell_XPS.jpeg', 2),
(96, 'Samsung Galaxy Tab', 600.00, 'Tablet device', '/static/images/\r\nSamsung_Galaxy_Tab.jpeg', 2),
(97, 'Sony PlayStation 5', 500.00, 'Game console', '/static/images/\r\nSony_PlayStation.jpeg', 2),
(98, 'Nintendo Switch', 400.00, 'Portable game console', '/static/images/\r\nNintendo_Switch.jpeg', 2),
(99, 'Ray-Ban Glasses', 125.00, 'Stylish eyewear', '/static/images/\r\nSunglasses.jpeg', 3),
(100, 'Fossil Watch', 175.00, 'Leather strap watch', '/static/images/\r\nFossil_Watches.jpeg', 3),
(101, 'Coach Wallet', 180.00, 'Designer wallet', '/static/images/\r\nGucci_Wallet.jpeg', 3),
(102, 'Adidas Bag', 65.00, 'Sports backpack', '/static/images/Adidas_Bag.jpeg', 3),
(103, 'Nike Socks', 14.00, 'Cotton socks', '/static/images/Nike_Socks.jpeg', 3),
(104, 'KitchenAid Mixer', 400.00, 'Stand mixer for baking', '/static/images/KitchenAid_Mixere.jpeg', 4),
(105, 'Philips Blender', 85.00, 'High-speed blender', '/static/images/Philips_Blenders.jpeg', 4),
(106, 'Dyson Hair Dryer', 300.00, 'Powerful hair dryer', '/static/images/Dyson_Hair_Dryer.jpeg', 4),
(108, 'Breville Coffee Maker', 120.00, 'Automatic coffee machine', '/static/images/Cuisinart.jpeg', 4),
(109, 'Treadmill Pro', 650.00, 'Home fitness treadmill', '/static/images/Treadmill_Pro.jpeg', 5),
(111, 'Dumbbell Set', 110.00, 'Adjustable dumbbells', '/static/images/Dumbbell_Set.jpeg', 5),
(112, 'Yoga Mat', 38.00, 'Non-slip exercise mat', '/static/images/Yoga_Mats.jpeg', 5),
(113, 'Jump Rope', 16.00, 'Speed skipping rope', '/static/images/Jump_Ropes.jpeg', 5);

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
  `role` enum('user','admin') DEFAULT 'user',
  `reset_token` varchar(255) DEFAULT NULL,
  `reset_token_expiry` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `phone`, `dob`, `street`, `city`, `state`, `zip`, `country`, `profile_pic`, `created_at`, `is_admin`, `role`, `reset_token`, `reset_token_expiry`) VALUES
(7, 'himash', 'Himashmadushanka975@gmail.com', '$2b$12$XdL4/0UeliQqXSMHvpSW4e962VB82dfTMncayxf3fyylOUFih6JXi', '+1 (234) 567-8966', '2008-07-24', NULL, NULL, NULL, NULL, NULL, 'profile_7.jpg', '2025-11-20 11:44:44', 0, 'user', NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

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
-- Indexes for table `contact_messages`
--
ALTER TABLE `contact_messages`
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
-- AUTO_INCREMENT for table `addresses`
--
ALTER TABLE `addresses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `contact_messages`
--
ALTER TABLE `contact_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=115;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `addresses`
--
ALTER TABLE `addresses`
  ADD CONSTRAINT `addresses_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

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

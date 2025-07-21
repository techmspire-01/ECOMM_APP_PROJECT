-- MySQL dump 10.13  Distrib 8.0.42, for Linux (x86_64)
--
-- Host: localhost    Database: ecommerce_db
-- ------------------------------------------------------
-- Server version	8.0.42-0ubuntu0.24.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `quantity` int DEFAULT '1',
  `added_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (14,'Vedant',1,2,'2025-07-21 16:27:32');
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contacts`
--

DROP TABLE IF EXISTS `contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contacts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `message` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contacts`
--

LOCK TABLES `contacts` WRITE;
/*!40000 ALTER TABLE `contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `address` text,
  `payment_mode` varchar(50) DEFAULT NULL,
  `timestamp` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'vedant','Mahesh Thengne','vest 1904 hiranandani fortune city mumbai','Cash on Delivery','2025-07-21 12:13:09'),(2,'vedant','Sachin Tawade','BHOI Line Tadodha, Nandurbar','Card','2025-07-21 12:13:09'),(3,'vedant','EdTech','amaravati','UPI','2025-07-21 12:21:30'),(4,'vedant','Devops-01','nagpur','Cash on Delivery','2025-07-21 12:22:11'),(5,'vedant','Mahesh Thengne','chandrapur','Card','2025-07-21 12:26:30'),(6,'vedant','Snehal Jiwatode','Hiranandani City Mumbai','Cash on Delivery','2025-07-21 12:27:43'),(7,'Vedant','Sachin  tawade ',' Bhoi line nanduebar','UPI','2025-07-21 16:28:02');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Smartphone X1',22999.00,'Mobile Devices','/api/images/Smartphone X1.jpg'),(2,'Bluetooth Earbuds',1499.00,'Audio Accessories','/api/images/Bluetooth Earbuds.jpg'),(3,'Smartwatch Pro',7499.00,'Wearables','/api/images/Smartwatch Pro.jpg'),(4,'Laptop 14-inch',49999.00,'Computers & Laptops','/api/images/Laptop 14-inch.jpg'),(5,'Mechanical Keyboard',3599.00,'Computer Accessories','/api/images/Mechanical Keyboard.jpg'),(6,'Wireless Mouse',899.00,'Computer Accessories','/api/images/Wireless Mouse.jpg'),(7,'USB-C Cable',299.00,'Cables & Connectors','/api/images/USB-C Cable.jpg'),(8,'Gaming Monitor 24\"',12999.00,'Monitors & Displays','/api/images/Gaming Monitor 24.jpg'),(9,'External HDD 1TB',4499.00,'Storage Devices','/api/images/External HDD 1TB.jpg'),(10,'Power Bank 20,000mAh',2499.00,'Charging Accessories','/api/images/Power Bank 20,000mAh.jpg'),(11,'Fitness Band',1899.00,NULL,'/api/images/Fitness Band.jpg'),(12,'Smart TV 43\"',27999.00,'Home Entertainment','/api/images/Smart TV 43.jpg'),(13,'Soundbar 2.1',4999.00,'Audio Accessories','/api/images/Soundbar 2.1.jpg'),(14,'Bluetooth Speaker',1599.00,'Audio Accessories','/api/images/Bluetooth Speaker.jpg'),(15,'Laser Printer',6999.00,'Office Equipment','/api/images/Laser Printer.jpg'),(16,'Router Dual Band',2299.00,'Networking Devices','/api/images/Router Dual Band.jpg'),(17,'Webcam HD',1299.00,'Computer Accessories','/api/images/Webcam HD.jpg'),(18,'Portable Projector',9999.00,'Presentation Equipment','/api/images/Portable Projector.jpg'),(19,'Wireless Charger',1399.00,'Charging Accessories','/api/images/Wireless Charger.jpg'),(20,'Laptop Cooling Pad',1199.00,'Computer Accessories','/api/images/Laptop Cooling Pad.jpg'),(21,'Dash Cam',2999.00,'Automotive Electronics','/api/images/Dash Cam.jpg'),(22,'Digital Photo Frame',3499.00,'Home Gadgets','/api/images/Digital Photo Frame.jpg'),(23,'Flash Drive 64GB',499.00,'Storage Devices','/api/images/Flash Drive 64GB.jpg'),(24,'SSD 500GB',3999.00,'Storage Devices','/api/images/SSD 500GB.jpg'),(25,'VR Headset',8999.00,'Gaming Devices','/api/images/VR Headset.jpg'),(26,'Drone Mini',7499.00,'Drones & Aerial Devices','/api/images/Drone Mini.jpg'),(27,'HDMI Cable',399.00,'Cables & Connectors','/api/images/HDMI Cable.jpg'),(28,'Bluetooth Adapter',799.00,'Networking Devices','/api/images/Bluetooth Adapter.jpg'),(29,'Keyboard Cover',399.00,'Computer Accessories','/api/images/Keyboard Cover.jpg'),(30,'Laptop Backpack',1699.00,'Bags & Cases','/api/images/Laptop Backpack.jpg'),(31,'Noise-Cancelling Headphones',4999.00,'Audio Accessories','/api/images/Noise-Cancelling Headphones.jpg'),(32,'Smart Doorbell',6999.00,'Home Security','/api/images/Smart Doorbell.jpg'),(33,'Smart LED',250.00,'Home Lighting','/api/images/Smart LED.jpg');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'vedant','vedant@gmail.com','vedant123');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-21 19:32:11

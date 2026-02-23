-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: localhost    Database: security_app
-- ------------------------------------------------------
-- Server version	8.0.39

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `authorities`
--

DROP TABLE IF EXISTS `authorities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authorities` (
  `username` varchar(50) NOT NULL,
  `authority` varchar(50) NOT NULL,
  UNIQUE KEY `ix_auth_username` (`username`,`authority`),
  CONSTRAINT `fk_authorities_users` FOREIGN KEY (`username`) REFERENCES `users` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authorities`
--

LOCK TABLES `authorities` WRITE;
/*!40000 ALTER TABLE `authorities` DISABLE KEYS */;
INSERT INTO `authorities` VALUES ('admin','ROLE_ADMIN'),('user1','ROLE_USER'),('user2','ROLE_USER');
/*!40000 ALTER TABLE `authorities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `username` varchar(50) NOT NULL,
  `password` varchar(500) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `role` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('admin','$2a$10$M/0jdnmZT1UJHMWEqUZ6neeXkQl90ydU9lx/4na1DIWUQbyAltyPW',1,NULL),('user1','$2a$10$SPMh72EgM/h6KM9W15DpNemFE2ynMOqsNvlLf2GjyLyhPQp.xFb8K',1,NULL),('user2','$2a$10$.9VJd6aYZYWCPyQBTicQfencFlWvGB6usKK.cy26.rXHzMVEKc5fy',1,NULL);
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

-- Dump completed on 2026-02-23 20:07:27
-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: localhost    Database: springboot_db
-- ------------------------------------------------------
-- Server version	8.0.39

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `activity`
--

DROP TABLE IF EXISTS `activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `activity` (
  `id` varchar(255) NOT NULL,
  `additional_metrics` json DEFAULT NULL,
  `calories_burned` int DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `duration` int DEFAULT NULL,
  `start_time` datetime(6) DEFAULT NULL,
  `type` enum('RUNNING','WALKING','CYCLING','SWIMMING','WEIGHT_TRAINING','YOGA','HIIT','CARDIO','STRETCHING','OTHER') DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `user_id` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_activity_user` (`user_id`),
  CONSTRAINT `fk_activity_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity`
--

LOCK TABLES `activity` WRITE;
/*!40000 ALTER TABLE `activity` DISABLE KEYS */;
INSERT INTO `activity` VALUES ('8fa0600d-d7fd-40ba-bb90-2a321dcbf7d4','{\"exercises\": [\"Bench Press\", \"Squats\", \"Deadlifts\"]}',300,'2026-02-19 10:57:04.410968',45,'2026-02-01 23:54:24.000000','WEIGHT_TRAINING','2026-02-19 10:57:04.410968','1951056b-56e1-4d4d-9691-0f128a8e5039'),('95553e6f-ba93-4098-bbcc-59ca81b56835','{\"exercises\": [\"Bench Press\", \"Squats\", \"Deadlifts\"]}',300,'2026-02-19 11:09:47.376847',45,'2026-02-01 23:54:24.000000','WEIGHT_TRAINING','2026-02-19 11:09:47.376847','1951056b-56e1-4d4d-9691-0f128a8e5039'),('e4a3bf2e-1b3d-4d33-ac7c-3b069f79d3c6','{\"exercises\": [\"Bench Press\", \"Squats\", \"Deadlifts\"]}',300,'2026-02-19 19:26:29.149305',45,'2026-02-01 23:54:24.000000','WEIGHT_TRAINING','2026-02-19 19:26:29.149305','1951056b-56e1-4d4d-9691-0f128a8e5039'),('fb21449c-9a6a-4019-a63f-ccf7e1ea0a1a',NULL,300,'2026-02-19 10:48:50.475254',45,'2026-02-01 23:54:24.000000','WEIGHT_TRAINING','2026-02-19 10:48:50.475254','1951056b-56e1-4d4d-9691-0f128a8e5039');
/*!40000 ALTER TABLE `activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recommendation`
--

DROP TABLE IF EXISTS `recommendation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recommendation` (
  `id` varchar(255) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `improvements` json DEFAULT NULL,
  `recommendation` varchar(2000) DEFAULT NULL,
  `safety` json DEFAULT NULL,
  `suggestions` json DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `activity_id` varchar(255) NOT NULL,
  `user_id` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_recommendation_activity` (`activity_id`),
  KEY `fk_recommendation_user` (`user_id`),
  CONSTRAINT `fk_recommendation_activity` FOREIGN KEY (`activity_id`) REFERENCES `activity` (`id`),
  CONSTRAINT `fk_recommendation_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recommendation`
--

LOCK TABLES `recommendation` WRITE;
/*!40000 ALTER TABLE `recommendation` DISABLE KEYS */;
INSERT INTO `recommendation` VALUES ('1267d3e3-9793-4ab1-b5f3-153ae31ca441','2026-02-19 18:01:08.810748','[\"Increase duration by 10%\", \"Try interval training\"]',NULL,'[\"Listen to your body\", \"Don\'t overexert\"]','[\"Warm up for 5 minutes atleast\", \"Stay hydrated\"]',NULL,'2026-02-19 18:01:08.810748','8fa0600d-d7fd-40ba-bb90-2a321dcbf7d4','1951056b-56e1-4d4d-9691-0f128a8e5039'),('3693afb1-a1f8-4b60-a455-c9c55a8dea5e','2026-02-19 19:26:01.238574','[\"Increase duration by 10%\", \"Try interval training\"]',NULL,'[\"Listen to your body\", \"Don\'t overexert\"]','[\"Warm up for 5 minutes atleast\", \"Stay hydrated\"]',NULL,'2026-02-19 19:26:01.238574','8fa0600d-d7fd-40ba-bb90-2a321dcbf7d4','1951056b-56e1-4d4d-9691-0f128a8e5039'),('6f8af61f-c8f5-4da3-8616-0b7a1ad349dc','2026-02-19 19:26:20.262444','[\"Increase duration by 10%\", \"Try interval training\"]',NULL,'[\"Listen to your body\", \"Don\'t overexert\"]','[\"Warm up for 5 minutes atleast\", \"Stay hydrated\"]',NULL,'2026-02-19 19:26:20.262444','8fa0600d-d7fd-40ba-bb90-2a321dcbf7d4','1951056b-56e1-4d4d-9691-0f128a8e5039'),('7bfbda87-9366-4756-9e8e-550e3514b16f','2026-02-19 18:01:01.235819','[\"Increase duration by 10%\", \"Try interval training\"]',NULL,'[\"Listen to your body\", \"Don\'t overexert\"]','[\"Warm up for 5 minutes atleast\", \"Stay hydrated\"]',NULL,'2026-02-19 18:01:01.235819','8fa0600d-d7fd-40ba-bb90-2a321dcbf7d4','1951056b-56e1-4d4d-9691-0f128a8e5039'),('8a6890ae-3c93-4057-8a35-b618bd23724f','2026-02-19 11:07:27.313465','[\"Increase duration by 10%\", \"Try interval training\"]',NULL,'[\"Listen to your body\", \"Don\'t overexert\"]','[\"Warm up for 5 minutes atleast\", \"Stay hydrated\"]',NULL,'2026-02-19 11:07:27.313465','8fa0600d-d7fd-40ba-bb90-2a321dcbf7d4','1951056b-56e1-4d4d-9691-0f128a8e5039'),('d384c6e7-414d-4dae-a769-6e219f7ca785','2026-02-19 19:26:24.687889','[\"Increase duration by 10%\", \"Try interval training\"]',NULL,'[\"Listen to your body\", \"Don\'t overexert\"]','[\"Warm up for 5 minutes atleast\", \"Stay hydrated\"]',NULL,'2026-02-19 19:26:24.687889','8fa0600d-d7fd-40ba-bb90-2a321dcbf7d4','1951056b-56e1-4d4d-9691-0f128a8e5039');
/*!40000 ALTER TABLE `recommendation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` varchar(255) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role` enum('USER','ADMIN') DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_ob8kqyqqgmefl0aco34akdtpe` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('1951056b-56e1-4d4d-9691-0f128a8e5039','2026-02-18 15:59:50.893297','pandeymurari768@gmail.com','Murari','Pandey','$2a$10$iqNfFTFrMDHEQWOYa6xrSeF.rhNddu/qeKa7IkmMuR8LnOmJpN0r2','USER','2026-02-18 15:59:50.894734'),('213e20ee-429c-4296-9fb3-cecf315ba909','2026-02-19 19:30:10.201936','pandeymurari66@gmail.com','Murari','Pandey','$2a$10$cw5XYxIPsPc/LxhzbFlJl.nqAK8YL.TPBLbpW5TQw6NBjeiIpXkFS','USER','2026-02-19 19:30:10.201936'),('549febe9-9239-4c3a-82ba-395f250b850c','2026-02-19 19:34:15.963989','pandeymurari88@gmail.com','Murari','Pandey','$2a$10$Nc5SW/8Nss7yieJgETuo0uzQuptb4r4Z0oEJt0exwdwW3hiO91dXS','USER','2026-02-19 19:34:15.963989'),('69202c18-6bc1-4436-881d-db84c25f0900','2026-02-19 20:02:22.026847','pandeymurari9@gmail.com','Murari','Pandey','$2a$10$IsFCQVzAMJcDfbhNno1k.eSdjNON7bOKISB31VL9Yl.rGPxOQbBcu','USER','2026-02-19 20:02:22.026847'),('77ad15ed-9370-458e-8039-b06f61dcc3b9','2026-02-19 19:33:41.348484','pandeymurari898@gmail.com','Murari','Pandey','$2a$10$C/JRpRP76DaaqAwzFuwnhunx1we.QxMGBWu0paH.DKkDCWeXkVZT.','USER','2026-02-19 19:33:41.349483'),('c986da81-9f3d-4835-8677-556745ffe2dc','2026-02-19 19:28:51.605340','pandeymurari571@gmail.com','Murari','Pandey','$2a$10$SlDsV6nx1n.H09x6Vmlxgui2xTQtzxE1C03Nv9hupYY7axB.yyrN2','USER','2026-02-19 19:28:51.605340'),('f8da655d-e00c-40fe-8dae-56cb5be696d8','2026-02-19 19:42:05.147898','pandeymurari89@gmail.com','Murari','Pandey','$2a$10$skTLaqv9Wwl9jnC8Ko073eOv70Ocsn.mAENz0q1i8Qp2y05Sy3Y5K','USER','2026-02-19 19:42:05.147898');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-02-23 20:07:27

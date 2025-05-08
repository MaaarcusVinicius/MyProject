-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: localhost    Database: agenda
-- ------------------------------------------------------
-- Server version	5.7.43-log

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
-- Table structure for table `agendamento`
--

DROP TABLE IF EXISTS `agendamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `agendamento` (
  `id_agendamento` int(11) NOT NULL,
  `cli_id_cliente` int(11) NOT NULL,
  `pro_id_profissional` int(11) NOT NULL,
  `usu_id_usuarios` int(11) NOT NULL,
  `dt_data` date DEFAULT NULL,
  `hr_hora` char(5) DEFAULT NULL,
  `ds_obs` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_agendamento`),
  KEY `fk_agendamento_clientes_idx` (`cli_id_cliente`),
  KEY `fk_agendamento_profissionais1_idx` (`pro_id_profissional`),
  KEY `fk_agendamento_usuarios1_idx` (`usu_id_usuarios`),
  CONSTRAINT `fk_agendamento_clientes` FOREIGN KEY (`cli_id_cliente`) REFERENCES `clientes` (`id_cliente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_agendamento_profissionais1` FOREIGN KEY (`pro_id_profissional`) REFERENCES `profissionais` (`id_profissional`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_agendamento_usuarios1` FOREIGN KEY (`usu_id_usuarios`) REFERENCES `usuarios` (`id_usuarios`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agendamento`
--

LOCK TABLES `agendamento` WRITE;
/*!40000 ALTER TABLE `agendamento` DISABLE KEYS */;
INSERT INTO `agendamento` VALUES (1,1,10,1,'2025-04-01','08:00','TESTE INSERT INTO TABLE'),(2,1,10,1,'2025-04-01','08:15','TESTE INSERT INTO TABLE'),(3,2,10,1,'2025-04-01','08:30','TESTE INSERT INTO TABLE'),(4,1,11,1,'2025-04-01','08:00','Marcus'),(5,1,10,1,'2025-04-01','08:45',''),(6,1,11,1,'2025-04-24','08:00','INICIAL'),(7,1,11,1,'2025-04-24','09:00',''),(9,4,10,1,'2025-04-25','08:00',''),(10,1,10,1,'2025-04-25','08:15',''),(11,5,10,1,'2025-04-25','08:30',''),(12,3,10,1,'2025-04-25','08:45',''),(14,1,18,1,'2025-04-25','08:00',''),(15,1,18,1,'2025-05-02','08:00','teste'),(16,1,18,1,'2025-05-02','08:15',''),(17,5,19,1,'2025-05-05','08:00',''),(18,1,11,1,'2025-05-06','08:00','TESTE'),(19,1,10,1,'2025-05-06','08:00','teste'),(20,6,10,1,'2025-05-06','08:15','protesis'),(21,3,10,1,'2025-05-06','09:45',''),(22,2,10,1,'2025-05-06','11:00',''),(23,3,10,1,'2025-05-06','08:45',''),(24,4,10,1,'2025-05-06','09:30','');
/*!40000 ALTER TABLE `agendamento` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-07  9:28:27

-- MySQL dump 10.13  Distrib 5.7.19, for Linux (x86_64)
--
-- Host: localhost    Database: futbol
-- ------------------------------------------------------
-- Server version	5.7.19-0ubuntu0.16.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Banderas`
--

DROP TABLE IF EXISTS `Banderas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Banderas` (
  `id` int(10) unsigned NOT NULL,
  `color_primario` varchar(20) NOT NULL,
  `color_secundario` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `Banderas_ibfk_1` FOREIGN KEY (`id`) REFERENCES `Equipos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Banderas`
--

LOCK TABLES `Banderas` WRITE;
/*!40000 ALTER TABLE `Banderas` DISABLE KEYS */;
INSERT INTO `Banderas` VALUES (1,'Rojo','Blanco'),(2,'Azul','Amarillo'),(3,'Blanco','Rojo'),(4,'Celeste','Blanco'),(5,'Rojo','Azul');
/*!40000 ALTER TABLE `Banderas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Campeonatos`
--

DROP TABLE IF EXISTS `Campeonatos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Campeonatos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `campeon` int(10) unsigned NOT NULL,
  `copa` int(10) unsigned NOT NULL,
  `anio` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `copa` (`copa`,`anio`),
  KEY `campeon` (`campeon`),
  CONSTRAINT `Campeonatos_ibfk_1` FOREIGN KEY (`copa`) REFERENCES `Copas` (`id`),
  CONSTRAINT `Campeonatos_ibfk_2` FOREIGN KEY (`campeon`) REFERENCES `Equipos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Campeonatos`
--

LOCK TABLES `Campeonatos` WRITE;
/*!40000 ALTER TABLE `Campeonatos` DISABLE KEYS */;
INSERT INTO `Campeonatos` VALUES (1,1,1,1964),(2,1,1,1965),(3,1,1,1972),(4,1,1,1973),(5,1,1,1974),(6,1,1,1975),(7,1,1,1984),(8,1,2,2010),(9,2,1,1977),(10,2,1,1978),(11,2,1,2000),(12,2,1,2001),(13,2,1,2003),(14,2,1,2007),(15,2,2,2004),(16,2,2,2005),(17,3,1,1986),(18,3,1,1996),(19,3,1,2015),(20,3,2,2014),(21,5,1,2014),(22,5,2,2002),(23,4,1,1967);
/*!40000 ALTER TABLE `Campeonatos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Copas`
--

DROP TABLE IF EXISTS `Copas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Copas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(40) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Copas`
--

LOCK TABLES `Copas` WRITE;
/*!40000 ALTER TABLE `Copas` DISABLE KEYS */;
INSERT INTO `Copas` VALUES (1,'Libertadores'),(2,'Sudamericana');
/*!40000 ALTER TABLE `Copas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Equipos`
--

DROP TABLE IF EXISTS `Equipos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Equipos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(20) NOT NULL,
  `creado` date DEFAULT NULL,
  `socios` int(10) unsigned DEFAULT NULL,
  `dt` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`),
  UNIQUE KEY `dt` (`dt`),
  CONSTRAINT `Equipos_ibfk_1` FOREIGN KEY (`dt`) REFERENCES `dt` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Equipos`
--

LOCK TABLES `Equipos` WRITE;
/*!40000 ALTER TABLE `Equipos` DISABLE KEYS */;
INSERT INTO `Equipos` VALUES (1,'Independiente','1905-01-01',110000,1),(2,'Boca','1905-04-03',140000,3),(3,'River','1901-05-25',123500,2),(4,'Racing','1903-03-25',70000,NULL),(5,'San Lorenzo','1908-04-01',70000,5);
/*!40000 ALTER TABLE `Equipos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Jugadores`
--

DROP TABLE IF EXISTS `Jugadores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Jugadores` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(20) NOT NULL,
  `apellido` varchar(20) NOT NULL,
  `equipo` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`,`apellido`),
  KEY `equipo` (`equipo`),
  CONSTRAINT `Jugadores_ibfk_1` FOREIGN KEY (`equipo`) REFERENCES `Equipos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Jugadores`
--

LOCK TABLES `Jugadores` WRITE;
/*!40000 ALTER TABLE `Jugadores` DISABLE KEYS */;
INSERT INTO `Jugadores` VALUES (1,'Nicolas','Tagliafico',1),(2,'Diego','Rodriguez',1),(3,'Ezequiel','Barco',1),(4,'Fernando','Gago',2);
/*!40000 ALTER TABLE `Jugadores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dt`
--

DROP TABLE IF EXISTS `dt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dt` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(20) NOT NULL,
  `apellido` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`,`apellido`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dt`
--

LOCK TABLES `dt` WRITE;
/*!40000 ALTER TABLE `dt` DISABLE KEYS */;
INSERT INTO `dt` VALUES (1,'Daniel','Hollan'),(5,'Diego','Aguirre'),(4,'Diego','Cocca'),(3,'Guillermo','Barros Schelotto'),(2,'Marcelo','Gallardo');
/*!40000 ALTER TABLE `dt` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-08-27 18:28:02

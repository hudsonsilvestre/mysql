-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: db_cds
-- ------------------------------------------------------
-- Server version	9.6.0

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
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '668adaec-38ec-11f1-b5d9-0a0027000010:1-290';

--
-- Table structure for table `artista`
--

DROP TABLE IF EXISTS `artista`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `artista` (
  `cod_art` int NOT NULL AUTO_INCREMENT,
  `nome_art` varchar(100) NOT NULL,
  PRIMARY KEY (`cod_art`),
  UNIQUE KEY `nome_art` (`nome_art`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoria` (
  `cod_cat` int NOT NULL AUTO_INCREMENT,
  `nome_cat` varchar(50) NOT NULL,
  PRIMARY KEY (`cod_cat`),
  UNIQUE KEY `uq_cat` (`nome_cat`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cidade`
--

DROP TABLE IF EXISTS `cidade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cidade` (
  `cod_cid` int NOT NULL AUTO_INCREMENT,
  `sigla_est` char(2) NOT NULL,
  `nome_cid` varchar(100) NOT NULL,
  PRIMARY KEY (`cod_cid`),
  KEY `fk_cid` (`sigla_est`),
  CONSTRAINT `fk_cid` FOREIGN KEY (`sigla_est`) REFERENCES `estados` (`sigla_est`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `cod_cli` int NOT NULL AUTO_INCREMENT,
  `cod_cid` int NOT NULL,
  `nome_cli` varchar(100) NOT NULL,
  `end_cli` varchar(100) NOT NULL,
  `renda_cli` decimal(10,2) NOT NULL DEFAULT '0.00',
  `sexo_cli` char(1) NOT NULL DEFAULT 'f',
  PRIMARY KEY (`cod_cli`),
  KEY `fk_cli` (`cod_cid`),
  CONSTRAINT `fk_cli` FOREIGN KEY (`cod_cid`) REFERENCES `cidade` (`cod_cid`),
  CONSTRAINT `ch_cli_1` CHECK ((`renda_cli` >= 0)),
  CONSTRAINT `ch_cli_2` CHECK ((`sexo_cli` in (_utf8mb4'f',_utf8mb4'm')))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `conjuges`
--

DROP TABLE IF EXISTS `conjuges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `conjuges` (
  `cod_cli` int NOT NULL,
  `nome_conj` varchar(100) NOT NULL,
  `renda_conj` decimal(10,2) NOT NULL DEFAULT '0.00',
  `sexo_conj` char(1) NOT NULL DEFAULT 'm',
  PRIMARY KEY (`cod_cli`),
  CONSTRAINT `fk_conj` FOREIGN KEY (`cod_cli`) REFERENCES `clientes` (`cod_cli`),
  CONSTRAINT `ch_conj_1` CHECK ((`renda_conj` >= 0)),
  CONSTRAINT `ch_conj_2` CHECK ((`sexo_conj` in (_utf8mb4'f',_utf8mb4'm')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dependentes`
--

DROP TABLE IF EXISTS `dependentes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dependentes` (
  `cod_dep` int NOT NULL AUTO_INCREMENT,
  `cod_func` int NOT NULL,
  `nome_dep` varchar(100) NOT NULL,
  `sexo_dep` char(1) NOT NULL DEFAULT 'm',
  PRIMARY KEY (`cod_dep`),
  KEY `fk_dep` (`cod_func`),
  CONSTRAINT `fk_dep` FOREIGN KEY (`cod_func`) REFERENCES `funcionarios` (`cod_func`),
  CONSTRAINT `ch_dep` CHECK ((`sexo_dep` in (_utf8mb4'f',_utf8mb4'm')))
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `estados`
--

DROP TABLE IF EXISTS `estados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estados` (
  `sigla_est` char(2) NOT NULL,
  `nome_est` varchar(50) NOT NULL,
  PRIMARY KEY (`sigla_est`),
  UNIQUE KEY `uq_est` (`nome_est`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `funcionarios`
--

DROP TABLE IF EXISTS `funcionarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `funcionarios` (
  `cod_func` int NOT NULL AUTO_INCREMENT,
  `nome_func` varchar(100) NOT NULL,
  `end_func` varchar(200) NOT NULL,
  `sal_func` decimal(10,2) NOT NULL DEFAULT '0.00',
  `sexo_func` char(1) NOT NULL DEFAULT 'f',
  PRIMARY KEY (`cod_func`),
  CONSTRAINT `ch_func_1` CHECK ((`sal_func` >= 0)),
  CONSTRAINT `ch_func_2` CHECK ((`sexo_func` in (_utf8mb4'f',_utf8mb4'm')))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gravadora`
--

DROP TABLE IF EXISTS `gravadora`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gravadora` (
  `cod_grav` int NOT NULL AUTO_INCREMENT,
  `nome_grav` varchar(50) NOT NULL,
  PRIMARY KEY (`cod_grav`),
  UNIQUE KEY `nome_grav` (`nome_grav`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos` (
  `num_ped` int NOT NULL AUTO_INCREMENT,
  `cod_cli` int NOT NULL,
  `cod_func` int NOT NULL,
  `data_ped` datetime NOT NULL,
  PRIMARY KEY (`num_ped`),
  KEY `fk_ped_1` (`cod_cli`),
  KEY `fk_ped_2` (`cod_func`),
  CONSTRAINT `fk_ped_1` FOREIGN KEY (`cod_cli`) REFERENCES `clientes` (`cod_cli`),
  CONSTRAINT `fk_ped_2` FOREIGN KEY (`cod_func`) REFERENCES `funcionarios` (`cod_func`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `titulos`
--

DROP TABLE IF EXISTS `titulos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `titulos` (
  `cod_tit` int NOT NULL AUTO_INCREMENT,
  `cod_cat` int NOT NULL,
  `cod_grav` int NOT NULL,
  `nome_cd` varchar(100) NOT NULL,
  `val_compra` decimal(10,2) NOT NULL,
  `val_cd` decimal(10,2) NOT NULL,
  `qtd_estq` int NOT NULL,
  PRIMARY KEY (`cod_tit`),
  UNIQUE KEY `uq_tit` (`nome_cd`),
  KEY `fk_tit_1` (`cod_cat`),
  KEY `fk_tit_2` (`cod_grav`),
  CONSTRAINT `fk_tit_1` FOREIGN KEY (`cod_cat`) REFERENCES `categoria` (`cod_cat`),
  CONSTRAINT `fk_tit_2` FOREIGN KEY (`cod_grav`) REFERENCES `gravadora` (`cod_grav`),
  CONSTRAINT `ch_tit_1` CHECK ((`val_cd` >= 0)),
  CONSTRAINT `ch_tit_2` CHECK ((`qtd_estq` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `titulos_artistas`
--

DROP TABLE IF EXISTS `titulos_artistas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `titulos_artistas` (
  `cod_tit` int NOT NULL,
  `cod_art` int NOT NULL,
  PRIMARY KEY (`cod_tit`,`cod_art`),
  KEY `fk2_titart` (`cod_art`),
  CONSTRAINT `fk1_titart` FOREIGN KEY (`cod_tit`) REFERENCES `titulos` (`cod_tit`),
  CONSTRAINT `fk2_titart` FOREIGN KEY (`cod_art`) REFERENCES `artista` (`cod_art`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `titulos_pedidos`
--

DROP TABLE IF EXISTS `titulos_pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `titulos_pedidos` (
  `num_ped` int NOT NULL,
  `cod_tit` int NOT NULL,
  `qtd_cd` int NOT NULL,
  `val_cd` decimal(10,2) NOT NULL,
  PRIMARY KEY (`num_ped`,`cod_tit`),
  KEY `fk_tiped_4` (`cod_tit`),
  CONSTRAINT `fk_tiped_4` FOREIGN KEY (`cod_tit`) REFERENCES `titulos` (`cod_tit`),
  CONSTRAINT `fk_titped_3` FOREIGN KEY (`num_ped`) REFERENCES `pedidos` (`num_ped`),
  CONSTRAINT `ch_titped_2` CHECK ((`qtd_cd` >= 1)),
  CONSTRAINT `ch_titped_3` CHECK ((`val_cd` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-10 11:34:34

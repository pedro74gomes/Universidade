CREATE DATABASE IF NOT EXISTS QuantifiedSelf 
DEFAULT CHARACTER SET utf8;
SHOW WARNINGS;

-- Indicação da base de dados de trabalho
USE QuantifiedSelf;
-- -----------------------------------------------------
-- Apagar a Base de dados
-- DROP DATABASE QuantifiedSelf;

-- -----------------------------------------------------
-- Criação das tabelas da base de dados
-- -----------------------------------------------------
-- Criação da Tabela "Utilizador"
-- DROP TABLE Utilizador;
-- DESC Utilizador;
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Utilizador` (
  `idUtilizador` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(75) NOT NULL,
  `Endereco_Gmail` VARCHAR(150) NOT NULL,
  
  PRIMARY KEY (`idUtilizador`));


-- -----------------------------------------------------
-- Criação da Tabela "Contacto"
-- DROP TABLE Contacto;
-- DESC Contacto;
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Contacto` (
  `Endereco_Email` VARCHAR(150) NOT NULL,
  `Nome` VARCHAR(75) NOT NULL,
  
  PRIMARY KEY (`Endereco_Email`));


-- -----------------------------------------------------
-- Criação da Tabela "Mensagem_Email"
-- DROP TABLE Mensagem_Email;
-- DESC Mensagem_Email;
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Mensagem_Email` (
  `idMensagem_Email` INT NOT NULL AUTO_INCREMENT,
  `Nome_Email` VARCHAR(250) NOT NULL,
  `Bcc` VARCHAR(75) NULL,
  `Data` DATETIME NOT NULL,
  `Subject` VARCHAR(75) NULL,
  `Body` TEXT NULL,
  `idUtilizador` INT NOT NULL,
  `Endereco_Email` VARCHAR(150) NOT NULL,
  
  PRIMARY KEY (`idMensagem_Email`),
  FOREIGN KEY (`idUtilizador`)
	REFERENCES `Utilizador`(`idUtilizador`),
  FOREIGN KEY (`Endereco_Email`)
    REFERENCES `Contacto`(`Endereco_Email`));
    
INSERT INTO Utilizador (idUtilizador, Nome, Endereco_Gmail) VALUES('1','Moki','mokinmooo@gmail.com'); 

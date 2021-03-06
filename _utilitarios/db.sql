-- MySQL Script generated by MySQL Workbench
-- Sat Jun 30 08:37:56 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema db_esic
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema db_esic
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_esic` DEFAULT CHARACTER SET utf8 ;
USE `db_esic` ;

-- -----------------------------------------------------
-- Table `db_esic`.`ger_escolaridade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_esic`.`ger_escolaridade` (
  `n_cod_escolaridade` INT NOT NULL AUTO_INCREMENT,
  `c_desc_escolaridade` VARCHAR(45) NULL,
  PRIMARY KEY (`n_cod_escolaridade`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_esic`.`ger_profissao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_esic`.`ger_profissao` (
  `n_cod_profissao` INT NOT NULL AUTO_INCREMENT,
  `c_desc_profissao` VARCHAR(60) NULL,
  PRIMARY KEY (`n_cod_profissao`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_esic`.`ger_pessoa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_esic`.`ger_pessoa` (
  `n_cod_pessoa` INT NOT NULL,
  `c_nome_pessoa` VARCHAR(45) NULL,
  `c_nome_razao_social` VARCHAR(45) NULL,
  `c_cpfcnpj` VARCHAR(18) NULL,
  `d_dtnascimento` DATE NULL,
  `c_sexo` VARCHAR(2) NULL,
  `n_cod_endereco` INT NULL,
  `c_telefone_celular` VARCHAR(18) NULL,
  `c_telefone_fixo` VARCHAR(18) NULL,
  `c_email` VARCHAR(30) NULL,
  `ger_escolaridade_n_cod_escolaridade` INT NOT NULL,
  `ger_profissao_n_cod_profissao` INT NOT NULL,
  PRIMARY KEY (`n_cod_pessoa`, `ger_escolaridade_n_cod_escolaridade`, `ger_profissao_n_cod_profissao`),
  INDEX `fk_ger_pessoa_ger_escolaridade1_idx` (`ger_escolaridade_n_cod_escolaridade` ASC),
  INDEX `fk_ger_pessoa_ger_profissao1_idx` (`ger_profissao_n_cod_profissao` ASC),
  CONSTRAINT `fk_ger_pessoa_ger_escolaridade1`
    FOREIGN KEY (`ger_escolaridade_n_cod_escolaridade`)
    REFERENCES `db_esic`.`ger_escolaridade` (`n_cod_escolaridade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ger_pessoa_ger_profissao1`
    FOREIGN KEY (`ger_profissao_n_cod_profissao`)
    REFERENCES `db_esic`.`ger_profissao` (`n_cod_profissao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_esic`.`ger_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_esic`.`ger_usuario` (
  `n_cod_usuario` INT NOT NULL,
  `c_tipo` VARCHAR(3) NULL,
  `c_email` VARCHAR(30) NULL,
  `c_senha` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL,
  `c_usuario` VARCHAR(45) NULL,
  `c_session_id` VARCHAR(100) NULL,
  `c_permissoes` VARCHAR(255) NULL,
  `c_senha_anterior` VARCHAR(45) NULL,
  `c_ativo_sn` VARCHAR(5) NULL,
  `d_expira_senha_atual` DATE NULL,
  `d_criacao_usuario` DATETIME NULL,
  PRIMARY KEY (`n_cod_usuario`),
  CONSTRAINT `n_cod_usuario`
    FOREIGN KEY (`n_cod_usuario`)
    REFERENCES `db_esic`.`ger_pessoa` (`n_cod_pessoa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_esic`.`ger_endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_esic`.`ger_endereco` (
  `n_cod_endereco` INT NOT NULL,
  `c_cep` VARCHAR(45) NULL,
  `c_cidade` VARCHAR(45) NULL,
  `c_uf` VARCHAR(45) NULL,
  `c_logradouro` VARCHAR(45) NULL,
  `c_bairro` VARCHAR(45) NULL,
  `c_numero` VARCHAR(45) NULL,
  `c_complemento` VARCHAR(45) NULL,
  PRIMARY KEY (`n_cod_endereco`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_esic`.`ger_solicitacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_esic`.`ger_solicitacao` (
  `n_cod_solicitacao` INT NOT NULL AUTO_INCREMENT,
  `n_cod_protocolo` VARCHAR(45) NULL,
  `d_data_ini_protocolo` DATETIME NULL,
  `c_status_protocolo` CHAR NULL,
  `n_cod_receb_resposta` INT NULL,
  `c_desc_solicitacao` VARCHAR(255) NULL,
  `c_autoriza_divulgar` CHAR NULL,
  `c_arq_solicitado` VARCHAR(255) NULL,
  `ger_pessoa_n_cod_pessoa` INT NOT NULL,
  PRIMARY KEY (`n_cod_solicitacao`, `ger_pessoa_n_cod_pessoa`),
  INDEX `fk_ger_solicitacao_ger_pessoa1_idx` (`ger_pessoa_n_cod_pessoa` ASC),
  CONSTRAINT `fk_ger_solicitacao_ger_pessoa1`
    FOREIGN KEY (`ger_pessoa_n_cod_pessoa`)
    REFERENCES `db_esic`.`ger_pessoa` (`n_cod_pessoa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_esic`.`ger_endereco_x_pessoa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_esic`.`ger_endereco_x_pessoa` (
  `c_rua` VARCHAR(60) NULL,
  `n_numero` INT NULL,
  `n_complemento` VARCHAR(45) NULL,
  `c_cidade` VARCHAR(45) NULL,
  `c_uf_sigla` VARCHAR(3) NULL,
  `c_ende_principal_sn` VARCHAR(2) NULL,
  `ger_pessoa_n_cod_pessoa` INT NOT NULL,
  `ger_endereco_n_cod_endereco` INT NOT NULL,
  PRIMARY KEY (`ger_pessoa_n_cod_pessoa`, `ger_endereco_n_cod_endereco`),
  INDEX `fk_ger_endereco_x_pessoa_ger_endereco1_idx` (`ger_endereco_n_cod_endereco` ASC),
  CONSTRAINT `fk_ger_endereco_x_pessoa_ger_pessoa1`
    FOREIGN KEY (`ger_pessoa_n_cod_pessoa`)
    REFERENCES `db_esic`.`ger_pessoa` (`n_cod_pessoa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ger_endereco_x_pessoa_ger_endereco1`
    FOREIGN KEY (`ger_endereco_n_cod_endereco`)
    REFERENCES `db_esic`.`ger_endereco` (`n_cod_endereco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_esic`.`ger_pj_area_atuacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_esic`.`ger_pj_area_atuacao` (
  `n_cod_area` INT NOT NULL AUTO_INCREMENT,
  `c_desc_area_atuacao` VARCHAR(60) NULL,
  PRIMARY KEY (`n_cod_area`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_esic`.`ger_pj_tipo_atuacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_esic`.`ger_pj_tipo_atuacao` (
  `n_cod_tipo_atuacao` INT NOT NULL AUTO_INCREMENT,
  `c_desc_atuacao` VARCHAR(45) NULL,
  PRIMARY KEY (`n_cod_tipo_atuacao`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_esic`.`ger_pj_instituicao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_esic`.`ger_pj_instituicao` (
  `ger_pj_area_atuacao_n_cod_area` INT NOT NULL,
  `ger_pj_tipo_atuacao_n_cod_tipo_atuacao` INT NOT NULL,
  `ger_pessoa_n_cod_pessoa` INT NOT NULL,
  `ger_pessoa_ger_escolaridade_n_cod_escolaridade` INT NULL,
  `ger_pessoa_ger_profissao_n_cod_profissao` INT NULL,
  INDEX `fk_ger_pj_instituicao_ger_pj_area_atuacao1_idx` (`ger_pj_area_atuacao_n_cod_area` ASC),
  INDEX `fk_ger_pj_instituicao_ger_pj_tipo_atuacao1_idx` (`ger_pj_tipo_atuacao_n_cod_tipo_atuacao` ASC),
  INDEX `fk_ger_pj_instituicao_ger_pessoa1_idx` (`ger_pessoa_n_cod_pessoa` ASC, `ger_pessoa_ger_escolaridade_n_cod_escolaridade` ASC, `ger_pessoa_ger_profissao_n_cod_profissao` ASC),
  CONSTRAINT `fk_ger_pj_instituicao_ger_pj_area_atuacao1`
    FOREIGN KEY (`ger_pj_area_atuacao_n_cod_area`)
    REFERENCES `db_esic`.`ger_pj_area_atuacao` (`n_cod_area`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ger_pj_instituicao_ger_pj_tipo_atuacao1`
    FOREIGN KEY (`ger_pj_tipo_atuacao_n_cod_tipo_atuacao`)
    REFERENCES `db_esic`.`ger_pj_tipo_atuacao` (`n_cod_tipo_atuacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ger_pj_instituicao_ger_pessoa1`
    FOREIGN KEY (`ger_pessoa_n_cod_pessoa` , `ger_pessoa_ger_escolaridade_n_cod_escolaridade` , `ger_pessoa_ger_profissao_n_cod_profissao`)
    REFERENCES `db_esic`.`ger_pessoa` (`n_cod_pessoa` , `ger_escolaridade_n_cod_escolaridade` , `ger_profissao_n_cod_profissao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

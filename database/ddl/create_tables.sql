-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema cricket
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema cricket
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cricket` DEFAULT CHARACTER SET latin1 ;
USE `cricket` ;

-- -----------------------------------------------------
-- Table `cricket`.`players`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cricket`.`players` (
  `player_id` INT(11) NOT NULL AUTO_INCREMENT,
  `player_name` VARCHAR(45) NOT NULL,
  `player_role` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`player_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `cricket`.`team`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cricket`.`team` (
  `team_id` INT(11) NOT NULL AUTO_INCREMENT,
  `team_name` VARCHAR(45) NULL DEFAULT NULL,
  `captain` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`team_id`),
  INDEX `captain_id_idx` (`captain` ASC),
  CONSTRAINT `captain_id`
    FOREIGN KEY (`captain`)
    REFERENCES `cricket`.`players` (`player_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `cricket`.`players_team`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cricket`.`players_team` (
  `players_player_id` INT(11) NOT NULL,
  `team_team_id` INT(11) NOT NULL,
  PRIMARY KEY (`players_player_id`, `team_team_id`),
  INDEX `fk_players_has_team_team1_idx` (`team_team_id` ASC),
  INDEX `fk_players_has_team_players_idx` (`players_player_id` ASC),
  CONSTRAINT `fk_players_has_team_players`
    FOREIGN KEY (`players_player_id`)
    REFERENCES `cricket`.`players` (`player_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_players_has_team_team1`
    FOREIGN KEY (`team_team_id`)
    REFERENCES `cricket`.`team` (`team_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `cricket`.`series`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cricket`.`series` (
  `series_id` INT NOT NULL AUTO_INCREMENT,
  `series_name` VARCHAR(45) NULL,
  PRIMARY KEY (`series_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cricket`.`matches`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cricket`.`matches` (
  `match_id` INT NOT NULL AUTO_INCREMENT,
  `match_name` VARCHAR(45) NULL,
  `series_id` INT NOT NULL,
  `won_by_team_id` INT(11) NOT NULL,
  PRIMARY KEY (`match_id`, `series_id`, `won_by_team_id`),
  INDEX `fk_matches_series1_idx` (`series_id` ASC),
  INDEX `fk_matches_team1_idx` (`won_by_team_id` ASC),
  CONSTRAINT `fk_matches_series1`
    FOREIGN KEY (`series_id`)
    REFERENCES `cricket`.`series` (`series_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_matches_team1`
    FOREIGN KEY (`won_by_team_id`)
    REFERENCES `cricket`.`team` (`team_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

CREATE DATABASE IF NOT EXISTS `DT_DB` DEFAULT CHARACTER SET utf8mb4;
USE `DT_DB`;

CREATE TABLE IF NOT EXISTS `players` (
	`uid` int(6) NOT NULL AUTO_INCREMENT,
	`name` varchar(32) NOT NULL,
	`pid` varchar(17) NOT NULL,
	`cash` int(100) NOT NULL DEFAULT '0',
	`bank` int(100) NOT NULL DEFAULT '50000',
	`dojlevel` enum('0','1','2','3','4','5') NOT NULL DEFAULT '0',
	`coplevel` enum('0','1','2','3','4','5','6','7') NOT NULL DEFAULT '0',
	`mediclevel` enum('0','1','2','3','4','5','6','7') NOT NULL DEFAULT '0',
	`cop_department` enum('0','1','2','3','4','5') NOT NULL DEFAULT '0',
	`medic_department` enum('0','1','2','3','4','5') NOT NULL DEFAULT '0',
	`licenses` text NOT NULL DEFAULT '[]',
	`civ_gear` text NOT NULL DEFAULT '[]',
	`cop_gear` text NOT NULL DEFAULT '[]',
	`med_gear` text NOT NULL DEFAULT '[]',
	`stats` varchar(48) NOT NULL DEFAULT '[100,100,100,5000,0,0,0,0]', /*[hunger,thirst,battery,blood,head,torso,arms,legs]*/
	`jail_details` text NOT NULL DEFAULT '[0,"",0,""]',
	`donorlevel` enum('0','1','2','3','4','5') NOT NULL DEFAULT '0',
	`alive` tinyint(1) NOT NULL DEFAULT '0',
	`position` varchar(64) NOT NULL DEFAULT '[0,0,0]',
	`phone_number` varchar(12) NOT NULL,
	`phone_settings` varchar(150) NOT NULL DEFAULT '[1,"",""]', /*[sound mode,background_path,ringtone_sound]*/
	`phone_contacts` varchar(150) NOT NULL DEFAULT '[]', /*[number,name]*/
	`skills` varchar(100) NOT NULL DEFAULT '[0,0,0,0,0]',
	PRIMARY KEY (`uid`),
	UNIQUE KEY `pid` (`pid`),
	UNIQUE KEY `phone_number` (`phone_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `vehicles` (
	`id` int(6) NOT NULL AUTO_INCREMENT,
	`faction` varchar(6) NOT NULL,
	`classname` varchar(64) NOT NULL,
	`type` varchar(10) NOT NULL,
	`pid` varchar(17) NOT NULL,
	`active` tinyint(1) NOT NULL DEFAULT '1',
	`plate` varchar(7) NOT NULL,
	`colour` int(3) NOT NULL,
	`fuel` double NOT NULL DEFAULT '1',
	`damage` varchar(256) NOT NULL DEFAULT '[]',
	`impounded` tinyint(1) NOT NULL DEFAULT '0',
	PRIMARY KEY (`id`),
	UNIQUE KEY `plate` (`plate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `houses` (
	`id` int(6) NOT NULL AUTO_INCREMENT,
	`pid` varchar(17) NOT NULL,
	`pos` varchar(64) DEFAULT NULL,
	`type` tinyint(1) NOT NULL DEFAULT '0',
	`furniture` text NOT NULL DEFAULT '[]', /*[[id,class,pos,gear,dir],[]]*/
	`shared` varchar(300) NOT NULL DEFAULT '[]',
	`alarm` varchar(300) NOT NULL DEFAULT '[false,false,[]]',
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `shops` (
	`id` int(6) NOT NULL AUTO_INCREMENT,
	`company_name` varchar(48) DEFAULT NULL,
	`pos` varchar(64) DEFAULT NULL,
	`items` text NOT NULL DEFAULT '[]', /*[[item,price]]*/
	`funds` int(100) NOT NULL DEFAULT '0',
	`transaction_log` text NOT NULL DEFAULT '[]',
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `companies` (
	`id` int(6) NOT NULL AUTO_INCREMENT,
	`owner` varchar(32) NOT NULL,
	`owner_name` varchar(32) NOT NULL,
	`name` varchar(48) NOT NULL,
	`description` text  NOT NULL,
	`bank` int(100) NOT NULL DEFAULT '0',
	`employees` text,
	`active` tinyint(1) DEFAULT '1',
	PRIMARY KEY (`id`),
	UNIQUE KEY `owner` (`owner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `pd_db_arrests` (
	`id` int(6) NOT NULL AUTO_INCREMENT,
	`name` varchar(64) NOT NULL,
	`crimes` text NOT NULL,
	`officer` varchar(64) NOT NULL,
	`time` int(4) NOT NULL,
	`bail` int(9) NOT NULL,
	`insert_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `pd_db_tickets` (
	`id` int(6) NOT NULL AUTO_INCREMENT,
	`name` varchar(64) NOT NULL,
	`crimes` text NOT NULL,
	`officer` varchar(64) NOT NULL,
	`cost` int(7) NOT NULL,
	`insert_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `pd_db_warrants` (
	`id` int(6) NOT NULL AUTO_INCREMENT,
	`name` varchar(64) NOT NULL,
	`crimes` text NOT NULL,
	`officer` varchar(64) NOT NULL,
	`notes` text NOT NULL,
	`type` tinyint(1) DEFAULT '0',
	`approved` tinyint(1) DEFAULT '0',
	`active` tinyint(1) DEFAULT '0',
	`completed_by` varchar(64),
	`insert_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `gangs` (
	`id` int(6) NOT NULL AUTO_INCREMENT,
	`name` varchar(48) NOT NULL,
	`leader` varchar(32) DEFAULT NULL,
	`members` text NOT NULL DEFAULT '[]',
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `logs` (
	`id` int(6) NOT NULL AUTO_INCREMENT,
	`pid` varchar(17) NOT NULL,
	`name` varchar(32) NOT NULL,
	`action` varchar(255) DEFAULT NULL,
	`insert_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `persis_vars` (
	`threat` varchar(10) NOT NULL DEFAULT 'Green',
	`mayor` varchar(32) NOT NULL,
	`tax` varchar(100) NOT NULL DEFAULT '[0,0,0]', /*atm,item,vehicle*/
	`bank` int(100) NOT NULL DEFAULT '0',
	PRIMARY KEY (`threat`,`mayor`,`tax`,`bank`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP DATABASE IF EXISTS `stormatic`;
CREATE DATABASE `stormatic` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;
USE `stormatic`;

DROP TABLE IF EXISTS `llx_accounting_account`;
CREATE TABLE `llx_accounting_account` (
  `rowid` bigint(20) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_pcg_version` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `pcg_type` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `account_number` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `account_parent` int(11) DEFAULT '0',
  `label` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `labelshort` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_accounting_category` int(11) DEFAULT '0',
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `reconcilable` tinyint(4) NOT NULL DEFAULT '0',
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `extraparams` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_accounting_account` (`account_number`,`entity`,`fk_pcg_version`),
  KEY `idx_accounting_account_fk_pcg_version` (`fk_pcg_version`),
  KEY `idx_accounting_account_account_parent` (`account_parent`),
  CONSTRAINT `fk_accounting_account_fk_pcg_version` FOREIGN KEY (`fk_pcg_version`) REFERENCES `llx_accounting_system` (`pcg_version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_accounting_bookkeeping`;
CREATE TABLE `llx_accounting_bookkeeping` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `piece_num` int(11) NOT NULL,
  `doc_date` date NOT NULL,
  `doc_type` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `doc_ref` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
  `fk_doc` int(11) NOT NULL,
  `fk_docdet` int(11) NOT NULL,
  `thirdparty_code` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `subledger_account` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `subledger_label` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `numero_compte` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `label_compte` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `label_operation` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `debit` double(24,8) NOT NULL,
  `credit` double(24,8) NOT NULL,
  `montant` double(24,8) DEFAULT NULL,
  `sens` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `multicurrency_amount` double(24,8) DEFAULT NULL,
  `multicurrency_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lettering_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_lettering` datetime DEFAULT NULL,
  `date_lim_reglement` datetime DEFAULT NULL,
  `fk_user_author` int(11) NOT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `date_creation` datetime DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_user` int(11) DEFAULT NULL,
  `code_journal` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `journal_label` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_validated` datetime DEFAULT NULL,
  `date_export` datetime DEFAULT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `extraparams` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_accounting_bookkeeping_fk_doc` (`fk_doc`),
  KEY `idx_accounting_bookkeeping_fk_docdet` (`fk_docdet`),
  KEY `idx_accounting_bookkeeping_doc_date` (`doc_date`),
  KEY `idx_accounting_bookkeeping_numero_compte` (`numero_compte`,`entity`),
  KEY `idx_accounting_bookkeeping_code_journal` (`code_journal`,`entity`),
  KEY `idx_accounting_bookkeeping_piece_num` (`piece_num`,`entity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_accounting_bookkeeping_tmp`;
CREATE TABLE `llx_accounting_bookkeeping_tmp` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `doc_date` date NOT NULL,
  `doc_type` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `doc_ref` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
  `fk_doc` int(11) NOT NULL,
  `fk_docdet` int(11) NOT NULL,
  `thirdparty_code` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `subledger_account` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `subledger_label` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `numero_compte` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `label_compte` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `label_operation` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `debit` double(24,8) NOT NULL,
  `credit` double(24,8) NOT NULL,
  `montant` double(24,8) NOT NULL,
  `sens` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `multicurrency_amount` double(24,8) DEFAULT NULL,
  `multicurrency_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lettering_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_lettering` datetime DEFAULT NULL,
  `date_lim_reglement` datetime DEFAULT NULL,
  `fk_user_author` int(11) NOT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `date_creation` datetime DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_user` int(11) DEFAULT NULL,
  `code_journal` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `journal_label` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `piece_num` int(11) NOT NULL,
  `date_validated` datetime DEFAULT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `extraparams` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_accounting_bookkeeping_tmp_doc_date` (`doc_date`),
  KEY `idx_accounting_bookkeeping_tmp_fk_docdet` (`fk_docdet`),
  KEY `idx_accounting_bookkeeping_tmp_numero_compte` (`numero_compte`),
  KEY `idx_accounting_bookkeeping_tmp_code_journal` (`code_journal`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_accounting_fiscalyear`;
CREATE TABLE `llx_accounting_fiscalyear` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `date_start` date DEFAULT NULL,
  `date_end` date DEFAULT NULL,
  `statut` tinyint(4) NOT NULL DEFAULT '0',
  `entity` int(11) NOT NULL DEFAULT '1',
  `datec` datetime NOT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_accounting_groups_account`;
CREATE TABLE `llx_accounting_groups_account` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_accounting_account` int(11) NOT NULL,
  `fk_c_accounting_category` int(11) NOT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_accounting_journal`;
CREATE TABLE `llx_accounting_journal` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `code` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `label` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `nature` smallint(6) NOT NULL DEFAULT '1',
  `active` smallint(6) DEFAULT '0',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_accounting_journal_code` (`code`,`entity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_accounting_journal` (`rowid`, `entity`, `code`, `label`, `nature`, `active`) VALUES
(1,	1,	'VT',	'ACCOUNTING_SELL_JOURNAL',	2,	1),
(2,	1,	'AC',	'ACCOUNTING_PURCHASE_JOURNAL',	3,	1),
(3,	1,	'BQ',	'FinanceJournal',	4,	1),
(4,	1,	'OD',	'ACCOUNTING_MISCELLANEOUS_JOURNAL',	1,	1),
(5,	1,	'AN',	'ACCOUNTING_HAS_NEW_JOURNAL',	9,	1),
(6,	1,	'ER',	'ExpenseReportsJournal',	5,	1),
(7,	1,	'INV',	'InventoryJournal',	8,	1);

DROP TABLE IF EXISTS `llx_accounting_system`;
CREATE TABLE `llx_accounting_system` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_country` int(11) DEFAULT NULL,
  `pcg_version` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `label` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `active` smallint(6) DEFAULT '0',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_accounting_system_pcg_version` (`pcg_version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_accounting_system` (`rowid`, `fk_country`, `pcg_version`, `label`, `active`) VALUES
(1,	1,	'PCG99-ABREGE',	'The simple accountancy french plan',	1),
(2,	1,	'PCG99-BASE',	'The base accountancy french plan',	1),
(3,	1,	'PCG14-DEV',	'The developed accountancy french plan 2014',	1),
(4,	1,	'PCG18-ASSOC',	'French foundation chart of accounts 2018',	1),
(5,	1,	'PCGAFR14-DEV',	'The developed farm accountancy french plan 2014',	1),
(6,	2,	'PCMN-BASE',	'The base accountancy belgium plan',	1),
(7,	4,	'PCG08-PYME',	'The PYME accountancy spanish plan',	1),
(8,	5,	'SKR03',	'Standardkontenrahmen SKR 03',	1),
(9,	5,	'SKR04',	'Standardkontenrahmen SKR 04',	1),
(10,	6,	'PCG_SUISSE',	'Switzerland plan',	1),
(11,	7,	'ENG-BASE',	'England plan',	1),
(12,	10,	'PCT',	'The Tunisia plan',	1),
(13,	12,	'PCG',	'The Moroccan chart of accounts',	1),
(14,	13,	'NSCF',	'Nouveau syst??me comptable financier',	1),
(15,	17,	'NL-VERKORT',	'Verkort rekeningschema',	1),
(16,	20,	'BAS-K1-MINI',	'The Swedish mini chart of accounts',	1),
(17,	41,	'AT-BASE',	'Plan Austria',	1),
(18,	67,	'PC-MIPYME',	'The PYME accountancy Chile plan',	1),
(19,	80,	'DK-STD',	'Standardkontoplan fra SKAT',	1),
(20,	84,	'EC-SUPERCIAS',	'Plan de cuentas Ecuador',	1),
(21,	140,	'PCN-LUXEMBURG',	'Plan comptable normalis?? Luxembourgeois',	1),
(22,	188,	'RO-BASE',	'Plan de conturi romanesc',	1),
(23,	49,	'SYSCOHADA-BJ',	'Plan comptable Ouest-Africain',	1),
(24,	60,	'SYSCOHADA-BF',	'Plan comptable Ouest-Africain',	1),
(25,	73,	'SYSCOHADA-CD',	'Plan comptable Ouest-Africain',	1),
(26,	65,	'SYSCOHADA-CF',	'Plan comptable Ouest-Africain',	1),
(27,	72,	'SYSCOHADA-CG',	'Plan comptable Ouest-Africain',	1),
(28,	21,	'SYSCOHADA-CI',	'Plan comptable Ouest-Africain',	1),
(29,	24,	'SYSCOHADA-CM',	'Plan comptable Ouest-Africain',	1),
(30,	16,	'SYSCOHADA-GA',	'Plan comptable Ouest-Africain',	1),
(31,	87,	'SYSCOHADA-GQ',	'Plan comptable Ouest-Africain',	1),
(32,	71,	'SYSCOHADA-KM',	'Plan comptable Ouest-Africain',	1),
(33,	147,	'SYSCOHADA-ML',	'Plan comptable Ouest-Africain',	1),
(34,	168,	'SYSCOHADA-NE',	'Plan comptable Ouest-Africain',	1),
(35,	22,	'SYSCOHADA-SN',	'Plan comptable Ouest-Africain',	1),
(36,	66,	'SYSCOHADA-TD',	'Plan comptable Ouest-Africain',	1),
(37,	15,	'SYSCOHADA-TG',	'Plan comptable Ouest-Africain',	1),
(38,	11,	'US-BASE',	'USA basic chart of accounts',	1),
(39,	14,	'CA-ENG-BASE',	'Canadian basic chart of accounts - English',	1),
(40,	154,	'SAT/24-2019',	'Catalogo y codigo agrupador fiscal del 2019',	1);

DROP TABLE IF EXISTS `llx_actioncomm`;
CREATE TABLE `llx_actioncomm` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ref` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `ref_ext` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `datep` datetime DEFAULT NULL,
  `datep2` datetime DEFAULT NULL,
  `fk_action` int(11) DEFAULT NULL,
  `code` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_mod` int(11) DEFAULT NULL,
  `fk_project` int(11) DEFAULT NULL,
  `fk_soc` int(11) DEFAULT NULL,
  `fk_contact` int(11) DEFAULT NULL,
  `fk_parent` int(11) NOT NULL DEFAULT '0',
  `fk_user_action` int(11) DEFAULT NULL,
  `fk_user_done` int(11) DEFAULT NULL,
  `transparency` int(11) DEFAULT NULL,
  `priority` smallint(6) DEFAULT NULL,
  `visibility` varchar(12) COLLATE utf8_unicode_ci DEFAULT 'default',
  `fulldayevent` smallint(6) NOT NULL DEFAULT '0',
  `percent` smallint(6) NOT NULL DEFAULT '0',
  `location` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `durationp` double DEFAULT NULL,
  `label` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `note` text COLLATE utf8_unicode_ci,
  `calling_duration` int(11) DEFAULT NULL,
  `email_subject` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email_msgid` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email_from` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email_sender` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email_to` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email_tocc` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email_tobcc` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `errors_to` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reply_to` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `recurid` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `recurrule` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `recurdateend` datetime DEFAULT NULL,
  `num_vote` int(11) DEFAULT NULL,
  `event_paid` smallint(6) NOT NULL DEFAULT '0',
  `status` smallint(6) NOT NULL DEFAULT '0',
  `fk_element` int(11) DEFAULT NULL,
  `elementtype` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `extraparams` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_actioncomm_ref` (`ref`,`entity`),
  KEY `idx_actioncomm_fk_soc` (`fk_soc`),
  KEY `idx_actioncomm_fk_contact` (`fk_contact`),
  KEY `idx_actioncomm_code` (`code`),
  KEY `idx_actioncomm_fk_element` (`fk_element`),
  KEY `idx_actioncomm_fk_user_action` (`fk_user_action`),
  KEY `idx_actioncomm_fk_project` (`fk_project`),
  KEY `idx_actioncomm_datep` (`datep`),
  KEY `idx_actioncomm_datep2` (`datep2`),
  KEY `idx_actioncomm_recurid` (`recurid`),
  KEY `idx_actioncomm_ref_ext` (`ref_ext`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_actioncomm_extrafields`;
CREATE TABLE `llx_actioncomm_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_actioncomm_extrafields` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_actioncomm_reminder`;
CREATE TABLE `llx_actioncomm_reminder` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `dateremind` datetime NOT NULL,
  `typeremind` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `fk_user` int(11) NOT NULL,
  `offsetvalue` int(11) NOT NULL,
  `offsetunit` varchar(1) COLLATE utf8_unicode_ci NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `lasterror` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `fk_actioncomm` int(11) NOT NULL,
  `fk_email_template` int(11) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_actioncomm_reminder_unique` (`fk_actioncomm`,`fk_user`,`typeremind`,`offsetvalue`,`offsetunit`),
  KEY `idx_actioncomm_reminder_dateremind` (`dateremind`),
  KEY `idx_actioncomm_reminder_fk_user` (`fk_user`),
  KEY `idx_actioncomm_reminder_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_actioncomm_resources`;
CREATE TABLE `llx_actioncomm_resources` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_actioncomm` int(11) NOT NULL,
  `element_type` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `fk_element` int(11) NOT NULL,
  `answer_status` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mandatory` smallint(6) DEFAULT NULL,
  `transparency` smallint(6) DEFAULT '1',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_actioncomm_resources` (`fk_actioncomm`,`element_type`,`fk_element`),
  KEY `idx_actioncomm_resources_fk_element` (`fk_element`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_adherent`;
CREATE TABLE `llx_adherent` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `ref` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `ref_ext` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gender` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `civility` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lastname` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `firstname` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `login` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pass` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pass_crypted` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_adherent_type` int(11) NOT NULL,
  `morphy` varchar(3) COLLATE utf8_unicode_ci NOT NULL,
  `societe` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_soc` int(11) DEFAULT NULL,
  `address` text COLLATE utf8_unicode_ci,
  `zip` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `town` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `state_id` int(11) DEFAULT NULL,
  `country` int(11) DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `socialnetworks` text COLLATE utf8_unicode_ci,
  `phone` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_perso` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_mobile` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `birth` date DEFAULT NULL,
  `photo` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `statut` smallint(6) NOT NULL DEFAULT '0',
  `public` smallint(6) NOT NULL DEFAULT '0',
  `datefin` datetime DEFAULT NULL,
  `note_private` text COLLATE utf8_unicode_ci,
  `note_public` text COLLATE utf8_unicode_ci,
  `model_pdf` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `datevalid` datetime DEFAULT NULL,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_mod` int(11) DEFAULT NULL,
  `fk_user_valid` int(11) DEFAULT NULL,
  `canvas` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_adherent_ref` (`ref`,`entity`),
  UNIQUE KEY `uk_adherent_login` (`login`,`entity`),
  UNIQUE KEY `uk_adherent_fk_soc` (`fk_soc`),
  KEY `idx_adherent_fk_adherent_type` (`fk_adherent_type`),
  CONSTRAINT `adherent_fk_soc` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`),
  CONSTRAINT `fk_adherent_adherent_type` FOREIGN KEY (`fk_adherent_type`) REFERENCES `llx_adherent_type` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_adherent_extrafields`;
CREATE TABLE `llx_adherent_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_adherent_extrafields` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_adherent_type`;
CREATE TABLE `llx_adherent_type` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `statut` smallint(6) NOT NULL DEFAULT '0',
  `libelle` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `morphy` varchar(3) COLLATE utf8_unicode_ci NOT NULL,
  `duration` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `subscription` varchar(3) COLLATE utf8_unicode_ci NOT NULL DEFAULT '1',
  `amount` double(24,8) DEFAULT NULL,
  `vote` varchar(3) COLLATE utf8_unicode_ci NOT NULL DEFAULT '1',
  `note` text COLLATE utf8_unicode_ci,
  `mail_valid` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_adherent_type_libelle` (`libelle`,`entity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_adherent_type_extrafields`;
CREATE TABLE `llx_adherent_type_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_adherent_type_extrafields` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_adherent_type_lang`;
CREATE TABLE `llx_adherent_type_lang` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_type` int(11) NOT NULL DEFAULT '0',
  `lang` varchar(5) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `label` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `email` text COLLATE utf8_unicode_ci,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_advtargetemailing`;
CREATE TABLE `llx_advtargetemailing` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(180) COLLATE utf8_unicode_ci NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `fk_element` int(11) NOT NULL,
  `type_element` varchar(180) COLLATE utf8_unicode_ci NOT NULL,
  `filtervalue` text COLLATE utf8_unicode_ci,
  `fk_user_author` int(11) NOT NULL,
  `datec` datetime NOT NULL,
  `fk_user_mod` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_advtargetemailing_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_asset`;
CREATE TABLE `llx_asset` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `ref` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `label` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `amount_ht` double(24,8) DEFAULT NULL,
  `amount_vat` double(24,8) DEFAULT NULL,
  `fk_asset_type` int(11) NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `note_public` text COLLATE utf8_unicode_ci,
  `note_private` text COLLATE utf8_unicode_ci,
  `date_creation` datetime NOT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_user_creat` int(11) NOT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_asset_rowid` (`rowid`),
  KEY `idx_asset_ref` (`ref`),
  KEY `idx_asset_entity` (`entity`),
  KEY `idx_asset_fk_asset_type` (`fk_asset_type`),
  CONSTRAINT `fk_asset_asset_type` FOREIGN KEY (`fk_asset_type`) REFERENCES `llx_asset_type` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_asset_extrafields`;
CREATE TABLE `llx_asset_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_asset_extrafields` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_asset_type`;
CREATE TABLE `llx_asset_type` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `label` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `accountancy_code_asset` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `accountancy_code_depreciation_asset` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `accountancy_code_depreciation_expense` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `note` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_asset_type_label` (`label`,`entity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_asset_type_extrafields`;
CREATE TABLE `llx_asset_type_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_asset_type_extrafields` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_bank`;
CREATE TABLE `llx_bank` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `datev` date DEFAULT NULL,
  `dateo` date DEFAULT NULL,
  `amount` double(24,8) NOT NULL DEFAULT '0.00000000',
  `amount_main_currency` double(24,8) DEFAULT NULL,
  `label` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_account` int(11) DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_rappro` int(11) DEFAULT NULL,
  `fk_type` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `num_releve` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `num_chq` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `numero_compte` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `rappro` tinyint(4) DEFAULT '0',
  `note` text COLLATE utf8_unicode_ci,
  `fk_bordereau` int(11) DEFAULT '0',
  `banque` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `emetteur` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `author` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `origin_id` int(11) DEFAULT NULL,
  `origin_type` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_bank_datev` (`datev`),
  KEY `idx_bank_dateo` (`dateo`),
  KEY `idx_bank_fk_account` (`fk_account`),
  KEY `idx_bank_rappro` (`rappro`),
  KEY `idx_bank_num_releve` (`num_releve`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_bank_account`;
CREATE TABLE `llx_bank_account` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ref` varchar(12) COLLATE utf8_unicode_ci NOT NULL,
  `label` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `bank` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL,
  `code_banque` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `code_guichet` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cle_rib` varchar(5) COLLATE utf8_unicode_ci DEFAULT NULL,
  `bic` varchar(11) COLLATE utf8_unicode_ci DEFAULT NULL,
  `iban_prefix` varchar(34) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country_iban` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cle_iban` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `domiciliation` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `state_id` int(11) DEFAULT NULL,
  `fk_pays` int(11) NOT NULL,
  `proprio` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL,
  `owner_address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `courant` smallint(6) NOT NULL DEFAULT '0',
  `clos` smallint(6) NOT NULL DEFAULT '0',
  `rappro` smallint(6) DEFAULT '1',
  `url` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `account_number` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_accountancy_journal` int(11) DEFAULT NULL,
  `currency_code` varchar(3) COLLATE utf8_unicode_ci NOT NULL,
  `min_allowed` int(11) DEFAULT '0',
  `min_desired` int(11) DEFAULT '0',
  `comment` text COLLATE utf8_unicode_ci,
  `note_public` text COLLATE utf8_unicode_ci,
  `model_pdf` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `extraparams` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ics` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ics_transfer` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_bank_account_label` (`label`,`entity`),
  KEY `idx_fk_accountancy_journal` (`fk_accountancy_journal`),
  CONSTRAINT `fk_bank_account_accountancy_journal` FOREIGN KEY (`fk_accountancy_journal`) REFERENCES `llx_accounting_journal` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_bank_account_extrafields`;
CREATE TABLE `llx_bank_account_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_bank_account_extrafields` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_bank_categ`;
CREATE TABLE `llx_bank_categ` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_bank_class`;
CREATE TABLE `llx_bank_class` (
  `lineid` int(11) NOT NULL,
  `fk_categ` int(11) NOT NULL,
  UNIQUE KEY `uk_bank_class_lineid` (`lineid`,`fk_categ`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_bank_url`;
CREATE TABLE `llx_bank_url` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_bank` int(11) DEFAULT NULL,
  `url_id` int(11) DEFAULT NULL,
  `url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `label` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_bank_url` (`fk_bank`,`url_id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_blockedlog`;
CREATE TABLE `llx_blockedlog` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `date_creation` datetime DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `action` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `amounts` double(24,8) NOT NULL,
  `element` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_user` int(11) DEFAULT NULL,
  `user_fullname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_object` int(11) DEFAULT NULL,
  `ref_object` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_object` datetime DEFAULT NULL,
  `signature` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `signature_line` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `object_data` mediumtext COLLATE utf8_unicode_ci,
  `object_version` varchar(32) COLLATE utf8_unicode_ci DEFAULT '',
  `certified` int(11) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `signature` (`signature`),
  KEY `fk_object_element` (`fk_object`,`element`),
  KEY `entity` (`entity`),
  KEY `fk_user` (`fk_user`),
  KEY `entity_action` (`entity`,`action`),
  KEY `entity_action_certified` (`entity`,`action`,`certified`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_blockedlog_authority`;
CREATE TABLE `llx_blockedlog_authority` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `blockchain` longtext COLLATE utf8_unicode_ci NOT NULL,
  `signature` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`rowid`),
  KEY `signature` (`signature`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_bom_bom`;
CREATE TABLE `llx_bom_bom` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `ref` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `bomtype` int(11) DEFAULT '0',
  `label` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_product` int(11) DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `note_public` text COLLATE utf8_unicode_ci,
  `note_private` text COLLATE utf8_unicode_ci,
  `fk_warehouse` int(11) DEFAULT NULL,
  `qty` double(24,8) DEFAULT NULL,
  `efficiency` double(24,8) DEFAULT '1.00000000',
  `duration` double(24,8) DEFAULT NULL,
  `date_creation` datetime NOT NULL,
  `date_valid` datetime DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_user_creat` int(11) NOT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `fk_user_valid` int(11) DEFAULT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `model_pdf` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_bom_bom_ref` (`ref`,`entity`),
  KEY `idx_bom_bom_rowid` (`rowid`),
  KEY `idx_bom_bom_ref` (`ref`),
  KEY `llx_bom_bom_fk_user_creat` (`fk_user_creat`),
  KEY `idx_bom_bom_status` (`status`),
  KEY `idx_bom_bom_fk_product` (`fk_product`),
  CONSTRAINT `llx_bom_bom_fk_user_creat` FOREIGN KEY (`fk_user_creat`) REFERENCES `llx_user` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_bom_bomline`;
CREATE TABLE `llx_bom_bomline` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_bom` int(11) NOT NULL,
  `fk_product` int(11) NOT NULL,
  `fk_bom_child` int(11) DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `qty` double(24,8) NOT NULL,
  `qty_frozen` smallint(6) DEFAULT '0',
  `disable_stock_change` smallint(6) DEFAULT '0',
  `efficiency` double(24,8) NOT NULL DEFAULT '1.00000000',
  `position` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`rowid`),
  KEY `idx_bom_bomline_rowid` (`rowid`),
  KEY `idx_bom_bomline_fk_product` (`fk_product`),
  KEY `idx_bom_bomline_fk_bom` (`fk_bom`),
  CONSTRAINT `llx_bom_bomline_fk_bom` FOREIGN KEY (`fk_bom`) REFERENCES `llx_bom_bom` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_bom_bomline_extrafields`;
CREATE TABLE `llx_bom_bomline_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_bom_bom_extrafields`;
CREATE TABLE `llx_bom_bom_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_bom_bom_extrafields_fk_object` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_bookmark`;
CREATE TABLE `llx_bookmark` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_user` int(11) NOT NULL,
  `dateb` datetime DEFAULT NULL,
  `url` text COLLATE utf8_unicode_ci,
  `target` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  `title` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `favicon` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `position` int(11) DEFAULT '0',
  `entity` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_bookmark_title` (`fk_user`,`entity`,`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_bordereau_cheque`;
CREATE TABLE `llx_bordereau_cheque` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `ref` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `ref_ext` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `datec` datetime NOT NULL,
  `date_bordereau` date DEFAULT NULL,
  `amount` double(24,8) NOT NULL,
  `nbcheque` smallint(6) NOT NULL,
  `fk_bank_account` int(11) DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `statut` smallint(6) NOT NULL DEFAULT '0',
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `note` text COLLATE utf8_unicode_ci,
  `entity` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_bordereau_cheque` (`ref`,`entity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_boxes`;
CREATE TABLE `llx_boxes` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `box_id` int(11) NOT NULL,
  `position` smallint(6) NOT NULL,
  `box_order` varchar(3) COLLATE utf8_unicode_ci NOT NULL,
  `fk_user` int(11) NOT NULL DEFAULT '0',
  `maxline` int(11) DEFAULT NULL,
  `params` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_boxes` (`entity`,`box_id`,`position`,`fk_user`),
  KEY `idx_boxes_boxid` (`box_id`),
  KEY `idx_boxes_fk_user` (`fk_user`),
  CONSTRAINT `fk_boxes_box_id` FOREIGN KEY (`box_id`) REFERENCES `llx_boxes_def` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_boxes` (`rowid`, `entity`, `box_id`, `position`, `box_order`, `fk_user`, `maxline`, `params`) VALUES
(1,	1,	1,	0,	'B28',	0,	NULL,	NULL),
(2,	1,	2,	0,	'A19',	0,	NULL,	NULL),
(3,	1,	3,	0,	'B10',	0,	NULL,	NULL),
(4,	1,	4,	0,	'B14',	0,	NULL,	NULL),
(5,	1,	5,	0,	'A11',	0,	NULL,	NULL),
(6,	1,	6,	0,	'A13',	0,	NULL,	NULL),
(7,	1,	7,	0,	'A09',	0,	NULL,	NULL),
(8,	1,	8,	0,	'A15',	0,	NULL,	NULL),
(9,	1,	9,	0,	'A25',	0,	NULL,	NULL),
(10,	1,	10,	0,	'B22',	0,	NULL,	NULL),
(11,	1,	11,	0,	'A27',	0,	NULL,	NULL),
(12,	1,	12,	0,	'B08',	0,	NULL,	NULL),
(13,	1,	13,	0,	'A03',	0,	NULL,	NULL),
(14,	1,	14,	0,	'A17',	0,	NULL,	NULL),
(15,	1,	15,	0,	'B12',	0,	NULL,	NULL),
(16,	1,	16,	0,	'A21',	0,	NULL,	NULL),
(17,	1,	17,	0,	'B04',	0,	NULL,	NULL),
(18,	1,	18,	0,	'A05',	0,	NULL,	NULL),
(19,	1,	19,	0,	'B18',	0,	NULL,	NULL),
(20,	1,	20,	0,	'B24',	0,	NULL,	NULL),
(21,	1,	21,	0,	'B26',	0,	NULL,	NULL),
(22,	1,	22,	0,	'B20',	0,	NULL,	NULL),
(23,	1,	23,	0,	'A23',	0,	NULL,	NULL),
(24,	1,	24,	0,	'B16',	0,	NULL,	NULL),
(25,	1,	25,	0,	'A07',	0,	NULL,	NULL),
(26,	1,	26,	0,	'A29',	0,	NULL,	NULL),
(27,	1,	26,	1,	'B30',	0,	NULL,	NULL),
(28,	1,	26,	2,	'A31',	0,	NULL,	NULL),
(29,	1,	26,	3,	'B32',	0,	NULL,	NULL),
(30,	1,	26,	11,	'A33',	0,	NULL,	NULL),
(31,	1,	26,	27,	'B34',	0,	NULL,	NULL),
(32,	1,	27,	0,	'B06',	0,	NULL,	NULL),
(33,	1,	28,	0,	'B02',	0,	NULL,	NULL),
(62,	1,	57,	0,	'A01',	0,	NULL,	NULL);

DROP TABLE IF EXISTS `llx_boxes_def`;
CREATE TABLE `llx_boxes_def` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `file` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `note` varchar(130) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_boxes_def` (`file`,`entity`,`note`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_boxes_def` (`rowid`, `file`, `entity`, `tms`, `note`) VALUES
(1,	'box_lastlogin.php',	1,	'2022-09-06 10:07:15',	NULL),
(2,	'box_birthdays.php',	1,	'2022-09-06 10:07:15',	NULL),
(3,	'box_dolibarr_state_board.php',	1,	'2022-09-06 10:07:15',	NULL),
(4,	'box_commandes.php',	1,	'2022-09-06 10:16:33',	NULL),
(5,	'box_graph_orders_permonth.php',	1,	'2022-09-06 10:16:33',	NULL),
(6,	'box_clients.php',	1,	'2022-09-06 10:16:33',	NULL),
(7,	'box_prospect.php',	1,	'2022-09-06 10:16:33',	NULL),
(8,	'box_contacts.php',	1,	'2022-09-06 10:16:33',	NULL),
(9,	'box_activity.php',	1,	'2022-09-06 10:16:33',	'(WarningUsingThisBoxSlowDown)'),
(10,	'box_goodcustomers.php',	1,	'2022-09-06 10:16:33',	'(WarningUsingThisBoxSlowDown)'),
(11,	'box_graph_propales_permonth.php',	1,	'2022-09-06 10:16:41',	NULL),
(12,	'box_propales.php',	1,	'2022-09-06 10:16:41',	NULL),
(13,	'box_shipments.php',	1,	'2022-09-06 10:16:47',	NULL),
(14,	'box_graph_invoices_supplier_permonth.php',	1,	'2022-09-06 10:17:01',	NULL),
(15,	'box_graph_orders_supplier_permonth.php',	1,	'2022-09-06 10:17:01',	NULL),
(16,	'box_fournisseurs.php',	1,	'2022-09-06 10:17:01',	NULL),
(17,	'box_factures_fourn_imp.php',	1,	'2022-09-06 10:17:01',	NULL),
(18,	'box_factures_fourn.php',	1,	'2022-09-06 10:17:01',	NULL),
(19,	'box_supplier_orders.php',	1,	'2022-09-06 10:17:01',	NULL),
(20,	'box_supplier_orders_awaiting_reception.php',	1,	'2022-09-06 10:17:01',	NULL),
(21,	'box_factures_imp.php',	1,	'2022-09-06 10:17:23',	NULL),
(22,	'box_factures.php',	1,	'2022-09-06 10:17:23',	NULL),
(23,	'box_graph_invoices_permonth.php',	1,	'2022-09-06 10:17:23',	NULL),
(24,	'box_customers_outstanding_bill_reached.php',	1,	'2022-09-06 10:17:23',	NULL),
(25,	'box_produits.php',	1,	'2022-09-06 10:17:39',	NULL),
(26,	'box_produits_alerte_stock.php',	1,	'2022-09-06 10:17:39',	NULL),
(27,	'box_graph_product_distribution.php',	1,	'2022-09-06 10:17:39',	NULL),
(28,	'box_services_contracts.php',	1,	'2022-09-06 14:53:12',	NULL),
(57,	'importfilescsvwidget1.php@importfilescsv',	1,	'2022-09-15 15:13:41',	'Widget provided by ImportFilesCSV');

DROP TABLE IF EXISTS `llx_budget`;
CREATE TABLE `llx_budget` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `label` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status` int(11) DEFAULT NULL,
  `note` text COLLATE utf8_unicode_ci,
  `date_start` date DEFAULT NULL,
  `date_end` date DEFAULT NULL,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_user_creat` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `import_key` int(11) DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_budget_lines`;
CREATE TABLE `llx_budget_lines` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_budget` int(11) NOT NULL,
  `fk_project_ids` varchar(180) COLLATE utf8_unicode_ci NOT NULL,
  `amount` double(24,8) NOT NULL,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_user_creat` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `import_key` int(11) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_budget_lines` (`fk_budget`,`fk_project_ids`),
  CONSTRAINT `fk_budget_lines_budget` FOREIGN KEY (`fk_budget`) REFERENCES `llx_budget` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_categorie`;
CREATE TABLE `llx_categorie` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `fk_parent` int(11) NOT NULL DEFAULT '0',
  `label` varchar(180) COLLATE utf8_unicode_ci NOT NULL,
  `ref_ext` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` int(11) NOT NULL DEFAULT '1',
  `description` text COLLATE utf8_unicode_ci,
  `color` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_soc` int(11) DEFAULT NULL,
  `visible` tinyint(4) NOT NULL DEFAULT '1',
  `date_creation` datetime DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_user_creat` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_categorie` (`rowid`, `entity`, `fk_parent`, `label`, `ref_ext`, `type`, `description`, `color`, `fk_soc`, `visible`, `date_creation`, `tms`, `fk_user_creat`, `fk_user_modif`, `import_key`) VALUES
(1,	1,	0,	'Pi??ce d??tach??e',	NULL,	0,	'',	'',	NULL,	0,	'2022-09-06 14:55:46',	'2022-09-06 14:55:46',	1,	NULL,	NULL),
(2,	1,	0,	'Produits Abaques',	'',	0,	'',	'',	NULL,	0,	'2022-09-06 14:57:06',	'2022-10-07 07:39:41',	1,	1,	NULL),
(3,	1,	2,	'Cat??gorie 1',	NULL,	0,	'',	'',	NULL,	0,	'2022-10-06 09:29:48',	'2022-10-06 09:29:48',	1,	NULL,	NULL),
(4,	1,	2,	'Cat??gorie 2',	NULL,	0,	'',	'',	NULL,	0,	'2022-10-06 09:30:25',	'2022-10-06 09:30:25',	1,	NULL,	NULL),
(5,	1,	2,	'Cat??gorie 3',	NULL,	0,	'',	'',	NULL,	0,	'2022-10-07 07:36:35',	'2022-10-07 07:36:35',	1,	NULL,	NULL),
(6,	1,	2,	'Cat??gorie 4',	NULL,	0,	'',	'',	NULL,	0,	'2022-10-07 07:37:12',	'2022-10-07 07:37:12',	1,	NULL,	NULL);

DROP TABLE IF EXISTS `llx_categories_extrafields`;
CREATE TABLE `llx_categories_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `prixtransport` double(5,2) DEFAULT NULL,
  `marge` double(5,2) DEFAULT NULL,
  `tauxchange` double(4,2) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_categories_extrafields` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_categories_extrafields` (`rowid`, `tms`, `fk_object`, `import_key`, `prixtransport`, `marge`, `tauxchange`) VALUES
(1,	'2022-10-06 09:29:48',	3,	NULL,	10.00,	10.00,	2.00),
(2,	'2022-10-06 09:30:25',	4,	NULL,	10.00,	20.00,	2.00),
(3,	'2022-10-07 07:36:35',	5,	NULL,	NULL,	20.00,	2.00),
(4,	'2022-10-07 07:37:12',	6,	NULL,	NULL,	20.00,	NULL),
(6,	'2022-10-07 16:00:20',	2,	NULL,	10.00,	5.00,	2.00);

DROP TABLE IF EXISTS `llx_categorie_account`;
CREATE TABLE `llx_categorie_account` (
  `fk_categorie` int(11) NOT NULL,
  `fk_account` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`fk_categorie`,`fk_account`),
  KEY `idx_categorie_account_fk_categorie` (`fk_categorie`),
  KEY `idx_categorie_account_fk_account` (`fk_account`),
  CONSTRAINT `fk_categorie_account_categorie_rowid` FOREIGN KEY (`fk_categorie`) REFERENCES `llx_categorie` (`rowid`),
  CONSTRAINT `fk_categorie_account_fk_account` FOREIGN KEY (`fk_account`) REFERENCES `llx_bank_account` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_categorie_actioncomm`;
CREATE TABLE `llx_categorie_actioncomm` (
  `fk_categorie` int(11) NOT NULL,
  `fk_actioncomm` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`fk_categorie`,`fk_actioncomm`),
  KEY `idx_categorie_actioncomm_fk_categorie` (`fk_categorie`),
  KEY `idx_categorie_actioncomm_fk_actioncomm` (`fk_actioncomm`),
  CONSTRAINT `fk_categorie_actioncomm_categorie_rowid` FOREIGN KEY (`fk_categorie`) REFERENCES `llx_categorie` (`rowid`),
  CONSTRAINT `fk_categorie_actioncomm_fk_actioncomm` FOREIGN KEY (`fk_actioncomm`) REFERENCES `llx_actioncomm` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_categorie_contact`;
CREATE TABLE `llx_categorie_contact` (
  `fk_categorie` int(11) NOT NULL,
  `fk_socpeople` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`fk_categorie`,`fk_socpeople`),
  KEY `idx_categorie_contact_fk_categorie` (`fk_categorie`),
  KEY `idx_categorie_contact_fk_socpeople` (`fk_socpeople`),
  CONSTRAINT `fk_categorie_contact_categorie_rowid` FOREIGN KEY (`fk_categorie`) REFERENCES `llx_categorie` (`rowid`),
  CONSTRAINT `fk_categorie_contact_fk_socpeople` FOREIGN KEY (`fk_socpeople`) REFERENCES `llx_socpeople` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_categorie_fournisseur`;
CREATE TABLE `llx_categorie_fournisseur` (
  `fk_categorie` int(11) NOT NULL,
  `fk_soc` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`fk_categorie`,`fk_soc`),
  KEY `idx_categorie_fournisseur_fk_categorie` (`fk_categorie`),
  KEY `idx_categorie_fournisseur_fk_societe` (`fk_soc`),
  CONSTRAINT `fk_categorie_fournisseur_categorie_rowid` FOREIGN KEY (`fk_categorie`) REFERENCES `llx_categorie` (`rowid`),
  CONSTRAINT `fk_categorie_fournisseur_fk_soc` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_categorie_knowledgemanagement`;
CREATE TABLE `llx_categorie_knowledgemanagement` (
  `fk_categorie` int(11) NOT NULL,
  `fk_knowledgemanagement` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`fk_categorie`,`fk_knowledgemanagement`),
  KEY `idx_categorie_knowledgemanagement_fk_categorie` (`fk_categorie`),
  KEY `idx_categorie_knowledgemanagement_fk_knowledgemanagement` (`fk_knowledgemanagement`),
  CONSTRAINT `fk_categorie_knowledgemanagement_categorie_rowid` FOREIGN KEY (`fk_categorie`) REFERENCES `llx_categorie` (`rowid`),
  CONSTRAINT `fk_categorie_knowledgemanagement_knowledgemanagement_rowid` FOREIGN KEY (`fk_knowledgemanagement`) REFERENCES `llx_knowledgemanagement_knowledgerecord` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_categorie_lang`;
CREATE TABLE `llx_categorie_lang` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_category` int(11) NOT NULL DEFAULT '0',
  `lang` varchar(5) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `label` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_category_lang` (`fk_category`,`lang`),
  CONSTRAINT `fk_category_lang_fk_category` FOREIGN KEY (`fk_category`) REFERENCES `llx_categorie` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_categorie_member`;
CREATE TABLE `llx_categorie_member` (
  `fk_categorie` int(11) NOT NULL,
  `fk_member` int(11) NOT NULL,
  PRIMARY KEY (`fk_categorie`,`fk_member`),
  KEY `idx_categorie_member_fk_categorie` (`fk_categorie`),
  KEY `idx_categorie_member_fk_member` (`fk_member`),
  CONSTRAINT `fk_categorie_member_categorie_rowid` FOREIGN KEY (`fk_categorie`) REFERENCES `llx_categorie` (`rowid`),
  CONSTRAINT `fk_categorie_member_member_rowid` FOREIGN KEY (`fk_member`) REFERENCES `llx_adherent` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_categorie_product`;
CREATE TABLE `llx_categorie_product` (
  `fk_categorie` int(11) NOT NULL,
  `fk_product` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`fk_categorie`,`fk_product`),
  KEY `idx_categorie_product_fk_categorie` (`fk_categorie`),
  KEY `idx_categorie_product_fk_product` (`fk_product`),
  CONSTRAINT `fk_categorie_product_categorie_rowid` FOREIGN KEY (`fk_categorie`) REFERENCES `llx_categorie` (`rowid`),
  CONSTRAINT `fk_categorie_product_product_rowid` FOREIGN KEY (`fk_product`) REFERENCES `llx_product` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_categorie_product` (`fk_categorie`, `fk_product`, `import_key`) VALUES
(4,	356,	NULL);

DROP TABLE IF EXISTS `llx_categorie_project`;
CREATE TABLE `llx_categorie_project` (
  `fk_categorie` int(11) NOT NULL,
  `fk_project` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`fk_categorie`,`fk_project`),
  KEY `idx_categorie_project_fk_categorie` (`fk_categorie`),
  KEY `idx_categorie_project_fk_project` (`fk_project`),
  CONSTRAINT `fk_categorie_project_categorie_rowid` FOREIGN KEY (`fk_categorie`) REFERENCES `llx_categorie` (`rowid`),
  CONSTRAINT `fk_categorie_project_fk_project_rowid` FOREIGN KEY (`fk_project`) REFERENCES `llx_projet` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_categorie_societe`;
CREATE TABLE `llx_categorie_societe` (
  `fk_categorie` int(11) NOT NULL,
  `fk_soc` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`fk_categorie`,`fk_soc`),
  KEY `idx_categorie_societe_fk_categorie` (`fk_categorie`),
  KEY `idx_categorie_societe_fk_societe` (`fk_soc`),
  CONSTRAINT `fk_categorie_societe_categorie_rowid` FOREIGN KEY (`fk_categorie`) REFERENCES `llx_categorie` (`rowid`),
  CONSTRAINT `fk_categorie_societe_fk_soc` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_categorie_ticket`;
CREATE TABLE `llx_categorie_ticket` (
  `fk_categorie` int(11) NOT NULL,
  `fk_ticket` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`fk_categorie`,`fk_ticket`),
  KEY `idx_categorie_ticket_fk_categorie` (`fk_categorie`),
  KEY `idx_categorie_ticket_fk_ticket` (`fk_ticket`),
  CONSTRAINT `fk_categorie_ticket_categorie_rowid` FOREIGN KEY (`fk_categorie`) REFERENCES `llx_categorie` (`rowid`),
  CONSTRAINT `fk_categorie_ticket_ticket_rowid` FOREIGN KEY (`fk_ticket`) REFERENCES `llx_ticket` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_categorie_user`;
CREATE TABLE `llx_categorie_user` (
  `fk_categorie` int(11) NOT NULL,
  `fk_user` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`fk_categorie`,`fk_user`),
  KEY `idx_categorie_user_fk_categorie` (`fk_categorie`),
  KEY `idx_categorie_user_fk_user` (`fk_user`),
  CONSTRAINT `fk_categorie_user_categorie_rowid` FOREIGN KEY (`fk_categorie`) REFERENCES `llx_categorie` (`rowid`),
  CONSTRAINT `fk_categorie_user_fk_user` FOREIGN KEY (`fk_user`) REFERENCES `llx_user` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_categorie_warehouse`;
CREATE TABLE `llx_categorie_warehouse` (
  `fk_categorie` int(11) NOT NULL,
  `fk_warehouse` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`fk_categorie`,`fk_warehouse`),
  KEY `idx_categorie_warehouse_fk_categorie` (`fk_categorie`),
  KEY `idx_categorie_warehouse_fk_warehouse` (`fk_warehouse`),
  CONSTRAINT `fk_categorie_warehouse_categorie_rowid` FOREIGN KEY (`fk_categorie`) REFERENCES `llx_categorie` (`rowid`),
  CONSTRAINT `fk_categorie_warehouse_fk_warehouse_rowid` FOREIGN KEY (`fk_warehouse`) REFERENCES `llx_entrepot` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_categorie_website_page`;
CREATE TABLE `llx_categorie_website_page` (
  `fk_categorie` int(11) NOT NULL,
  `fk_website_page` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`fk_categorie`,`fk_website_page`),
  KEY `idx_categorie_website_page_fk_categorie` (`fk_categorie`),
  KEY `idx_categorie_website_page_fk_website_page` (`fk_website_page`),
  CONSTRAINT `fk_categorie_websitepage_categorie_rowid` FOREIGN KEY (`fk_categorie`) REFERENCES `llx_categorie` (`rowid`),
  CONSTRAINT `fk_categorie_websitepage_website_page_rowid` FOREIGN KEY (`fk_website_page`) REFERENCES `llx_website_page` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_chargesociales`;
CREATE TABLE `llx_chargesociales` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `ref` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_ech` datetime NOT NULL,
  `libelle` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `date_creation` datetime DEFAULT NULL,
  `date_valid` datetime DEFAULT NULL,
  `fk_user` int(11) DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `fk_user_valid` int(11) DEFAULT NULL,
  `fk_type` int(11) NOT NULL,
  `fk_account` int(11) DEFAULT NULL,
  `fk_mode_reglement` int(11) DEFAULT NULL,
  `amount` double(24,8) NOT NULL DEFAULT '0.00000000',
  `paye` smallint(6) NOT NULL DEFAULT '0',
  `periode` date DEFAULT NULL,
  `fk_projet` int(11) DEFAULT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_commande`;
CREATE TABLE `llx_commande` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `ref` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `ref_ext` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ref_int` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ref_client` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_soc` int(11) NOT NULL,
  `fk_projet` int(11) DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `date_creation` datetime DEFAULT NULL,
  `date_valid` datetime DEFAULT NULL,
  `date_cloture` datetime DEFAULT NULL,
  `date_commande` date DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `fk_user_valid` int(11) DEFAULT NULL,
  `fk_user_cloture` int(11) DEFAULT NULL,
  `source` smallint(6) DEFAULT NULL,
  `fk_statut` smallint(6) DEFAULT '0',
  `amount_ht` double(24,8) DEFAULT '0.00000000',
  `remise_percent` double DEFAULT '0',
  `remise_absolue` double DEFAULT '0',
  `remise` double DEFAULT '0',
  `total_tva` double(24,8) DEFAULT '0.00000000',
  `localtax1` double(24,8) DEFAULT '0.00000000',
  `localtax2` double(24,8) DEFAULT '0.00000000',
  `total_ht` double(24,8) DEFAULT '0.00000000',
  `total_ttc` double(24,8) DEFAULT '0.00000000',
  `note_private` text COLLATE utf8_unicode_ci,
  `note_public` text COLLATE utf8_unicode_ci,
  `model_pdf` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_main_doc` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `module_source` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pos_source` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `facture` tinyint(4) DEFAULT '0',
  `fk_account` int(11) DEFAULT NULL,
  `fk_currency` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_cond_reglement` int(11) DEFAULT NULL,
  `fk_mode_reglement` int(11) DEFAULT NULL,
  `date_livraison` datetime DEFAULT NULL,
  `fk_shipping_method` int(11) DEFAULT NULL,
  `fk_warehouse` int(11) DEFAULT NULL,
  `fk_availability` int(11) DEFAULT NULL,
  `fk_input_reason` int(11) DEFAULT NULL,
  `fk_delivery_address` int(11) DEFAULT NULL,
  `fk_incoterms` int(11) DEFAULT NULL,
  `location_incoterms` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `extraparams` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_multicurrency` int(11) DEFAULT NULL,
  `multicurrency_code` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `multicurrency_tx` double(24,8) DEFAULT '1.00000000',
  `multicurrency_total_ht` double(24,8) DEFAULT '0.00000000',
  `multicurrency_total_tva` double(24,8) DEFAULT '0.00000000',
  `multicurrency_total_ttc` double(24,8) DEFAULT '0.00000000',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_commande_ref` (`ref`,`entity`),
  KEY `idx_commande_fk_soc` (`fk_soc`),
  KEY `idx_commande_fk_user_author` (`fk_user_author`),
  KEY `idx_commande_fk_user_valid` (`fk_user_valid`),
  KEY `idx_commande_fk_user_cloture` (`fk_user_cloture`),
  KEY `idx_commande_fk_projet` (`fk_projet`),
  KEY `idx_commande_fk_account` (`fk_account`),
  KEY `idx_commande_fk_currency` (`fk_currency`),
  CONSTRAINT `fk_commande_fk_projet` FOREIGN KEY (`fk_projet`) REFERENCES `llx_projet` (`rowid`),
  CONSTRAINT `fk_commande_fk_soc` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`),
  CONSTRAINT `fk_commande_fk_user_author` FOREIGN KEY (`fk_user_author`) REFERENCES `llx_user` (`rowid`),
  CONSTRAINT `fk_commande_fk_user_cloture` FOREIGN KEY (`fk_user_cloture`) REFERENCES `llx_user` (`rowid`),
  CONSTRAINT `fk_commande_fk_user_valid` FOREIGN KEY (`fk_user_valid`) REFERENCES `llx_user` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_commandedet`;
CREATE TABLE `llx_commandedet` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_commande` int(11) NOT NULL,
  `fk_parent_line` int(11) DEFAULT NULL,
  `fk_product` int(11) DEFAULT NULL,
  `label` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `vat_src_code` varchar(10) COLLATE utf8_unicode_ci DEFAULT '',
  `tva_tx` double(7,4) DEFAULT NULL,
  `localtax1_tx` double(7,4) DEFAULT '0.0000',
  `localtax1_type` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `localtax2_tx` double(7,4) DEFAULT '0.0000',
  `localtax2_type` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `qty` double DEFAULT NULL,
  `remise_percent` double DEFAULT '0',
  `remise` double DEFAULT '0',
  `fk_remise_except` int(11) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `subprice` double(24,8) DEFAULT '0.00000000',
  `total_ht` double(24,8) DEFAULT '0.00000000',
  `total_tva` double(24,8) DEFAULT '0.00000000',
  `total_localtax1` double(24,8) DEFAULT '0.00000000',
  `total_localtax2` double(24,8) DEFAULT '0.00000000',
  `total_ttc` double(24,8) DEFAULT '0.00000000',
  `product_type` int(11) DEFAULT '0',
  `date_start` datetime DEFAULT NULL,
  `date_end` datetime DEFAULT NULL,
  `info_bits` int(11) DEFAULT '0',
  `buy_price_ht` double(24,8) DEFAULT '0.00000000',
  `fk_product_fournisseur_price` int(11) DEFAULT NULL,
  `special_code` int(11) DEFAULT '0',
  `rang` int(11) DEFAULT '0',
  `fk_unit` int(11) DEFAULT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ref_ext` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_commandefourndet` int(11) DEFAULT NULL,
  `fk_multicurrency` int(11) DEFAULT NULL,
  `multicurrency_code` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `multicurrency_subprice` double(24,8) DEFAULT '0.00000000',
  `multicurrency_total_ht` double(24,8) DEFAULT '0.00000000',
  `multicurrency_total_tva` double(24,8) DEFAULT '0.00000000',
  `multicurrency_total_ttc` double(24,8) DEFAULT '0.00000000',
  PRIMARY KEY (`rowid`),
  KEY `idx_commandedet_fk_commande` (`fk_commande`),
  KEY `idx_commandedet_fk_product` (`fk_product`),
  KEY `fk_commandedet_fk_unit` (`fk_unit`),
  KEY `fk_commandedet_fk_commandefourndet` (`fk_commandefourndet`),
  CONSTRAINT `fk_commandedet_fk_commande` FOREIGN KEY (`fk_commande`) REFERENCES `llx_commande` (`rowid`),
  CONSTRAINT `fk_commandedet_fk_commandefourndet` FOREIGN KEY (`fk_commandefourndet`) REFERENCES `llx_commande_fournisseurdet` (`rowid`),
  CONSTRAINT `fk_commandedet_fk_unit` FOREIGN KEY (`fk_unit`) REFERENCES `llx_c_units` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_commandedet_extrafields`;
CREATE TABLE `llx_commandedet_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `abaquesize` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_commandedet_extrafields` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_commande_extrafields`;
CREATE TABLE `llx_commande_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_commande_extrafields` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_commande_fournisseur`;
CREATE TABLE `llx_commande_fournisseur` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `ref` varchar(180) COLLATE utf8_unicode_ci NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `ref_ext` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ref_supplier` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_soc` int(11) NOT NULL,
  `fk_projet` int(11) DEFAULT '0',
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `date_creation` datetime DEFAULT NULL,
  `date_valid` datetime DEFAULT NULL,
  `date_approve` datetime DEFAULT NULL,
  `date_approve2` datetime DEFAULT NULL,
  `date_commande` date DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `fk_user_valid` int(11) DEFAULT NULL,
  `fk_user_approve` int(11) DEFAULT NULL,
  `fk_user_approve2` int(11) DEFAULT NULL,
  `source` smallint(6) NOT NULL,
  `fk_statut` smallint(6) DEFAULT '0',
  `billed` smallint(6) DEFAULT '0',
  `amount_ht` double(24,8) DEFAULT '0.00000000',
  `remise_percent` double DEFAULT '0',
  `remise` double DEFAULT '0',
  `total_tva` double(24,8) DEFAULT '0.00000000',
  `localtax1` double(24,8) DEFAULT '0.00000000',
  `localtax2` double(24,8) DEFAULT '0.00000000',
  `total_ht` double(24,8) DEFAULT '0.00000000',
  `total_ttc` double(24,8) DEFAULT '0.00000000',
  `note_private` text COLLATE utf8_unicode_ci,
  `note_public` text COLLATE utf8_unicode_ci,
  `model_pdf` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_main_doc` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_livraison` datetime DEFAULT NULL,
  `fk_account` int(11) DEFAULT NULL,
  `fk_cond_reglement` int(11) DEFAULT NULL,
  `fk_mode_reglement` int(11) DEFAULT NULL,
  `fk_input_method` int(11) DEFAULT '0',
  `fk_incoterms` int(11) DEFAULT NULL,
  `location_incoterms` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `extraparams` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_multicurrency` int(11) DEFAULT NULL,
  `multicurrency_code` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `multicurrency_tx` double(24,8) DEFAULT '1.00000000',
  `multicurrency_total_ht` double(24,8) DEFAULT '0.00000000',
  `multicurrency_total_tva` double(24,8) DEFAULT '0.00000000',
  `multicurrency_total_ttc` double(24,8) DEFAULT '0.00000000',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_commande_fournisseur_ref` (`ref`,`fk_soc`,`entity`),
  KEY `idx_commande_fournisseur_fk_soc` (`fk_soc`),
  KEY `billed` (`billed`),
  CONSTRAINT `fk_commande_fournisseur_fk_soc` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_commande_fournisseurdet`;
CREATE TABLE `llx_commande_fournisseurdet` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_commande` int(11) NOT NULL,
  `fk_parent_line` int(11) DEFAULT NULL,
  `fk_product` int(11) DEFAULT NULL,
  `ref` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `label` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `vat_src_code` varchar(10) COLLATE utf8_unicode_ci DEFAULT '',
  `tva_tx` double(7,4) DEFAULT '0.0000',
  `localtax1_tx` double(7,4) DEFAULT '0.0000',
  `localtax1_type` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `localtax2_tx` double(7,4) DEFAULT '0.0000',
  `localtax2_type` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `qty` double DEFAULT NULL,
  `remise_percent` double DEFAULT '0',
  `remise` double DEFAULT '0',
  `subprice` double(24,8) DEFAULT '0.00000000',
  `total_ht` double(24,8) DEFAULT '0.00000000',
  `total_tva` double(24,8) DEFAULT '0.00000000',
  `total_localtax1` double(24,8) DEFAULT '0.00000000',
  `total_localtax2` double(24,8) DEFAULT '0.00000000',
  `total_ttc` double(24,8) DEFAULT '0.00000000',
  `product_type` int(11) DEFAULT '0',
  `date_start` datetime DEFAULT NULL,
  `date_end` datetime DEFAULT NULL,
  `info_bits` int(11) DEFAULT '0',
  `special_code` int(11) DEFAULT '0',
  `rang` int(11) DEFAULT '0',
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_unit` int(11) DEFAULT NULL,
  `fk_multicurrency` int(11) DEFAULT NULL,
  `multicurrency_code` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `multicurrency_subprice` double(24,8) DEFAULT '0.00000000',
  `multicurrency_total_ht` double(24,8) DEFAULT '0.00000000',
  `multicurrency_total_tva` double(24,8) DEFAULT '0.00000000',
  `multicurrency_total_ttc` double(24,8) DEFAULT '0.00000000',
  PRIMARY KEY (`rowid`),
  KEY `fk_commande_fournisseurdet_fk_unit` (`fk_unit`),
  KEY `idx_commande_fournisseurdet_fk_commande` (`fk_commande`),
  KEY `idx_commande_fournisseurdet_fk_product` (`fk_product`),
  CONSTRAINT `fk_commande_fournisseurdet_fk_unit` FOREIGN KEY (`fk_unit`) REFERENCES `llx_c_units` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_commande_fournisseurdet_extrafields`;
CREATE TABLE `llx_commande_fournisseurdet_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `show_total_ht` int(10) DEFAULT NULL,
  `show_reduc` int(10) DEFAULT NULL,
  `subtotal_show_qty` int(10) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_commande_fournisseurdet_extrafields` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_commande_fournisseur_dispatch`;
CREATE TABLE `llx_commande_fournisseur_dispatch` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_commande` int(11) DEFAULT NULL,
  `fk_product` int(11) DEFAULT NULL,
  `fk_commandefourndet` int(11) DEFAULT NULL,
  `fk_projet` int(11) DEFAULT NULL,
  `fk_reception` int(11) DEFAULT NULL,
  `qty` float DEFAULT NULL,
  `fk_entrepot` int(11) DEFAULT NULL,
  `fk_user` int(11) DEFAULT NULL,
  `comment` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `batch` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `eatby` date DEFAULT NULL,
  `sellby` date DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `cost_price` double(24,8) DEFAULT '0.00000000',
  PRIMARY KEY (`rowid`),
  KEY `idx_commande_fournisseur_dispatch_fk_commande` (`fk_commande`),
  KEY `idx_commande_fournisseur_dispatch_fk_reception` (`fk_reception`),
  CONSTRAINT `fk_commande_fournisseur_dispatch_fk_reception` FOREIGN KEY (`fk_reception`) REFERENCES `llx_reception` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_commande_fournisseur_dispatch_extrafields`;
CREATE TABLE `llx_commande_fournisseur_dispatch_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_commande_fournisseur_dispatch_extrafields` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_commande_fournisseur_extrafields`;
CREATE TABLE `llx_commande_fournisseur_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_commande_fournisseur_extrafields` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_commande_fournisseur_log`;
CREATE TABLE `llx_commande_fournisseur_log` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `datelog` datetime NOT NULL,
  `fk_commande` int(11) NOT NULL,
  `fk_statut` smallint(6) NOT NULL,
  `fk_user` int(11) NOT NULL,
  `comment` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_comment`;
CREATE TABLE `llx_comment` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `fk_element` int(11) DEFAULT NULL,
  `element_type` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `entity` int(11) DEFAULT '1',
  `import_key` varchar(125) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_const`;
CREATE TABLE `llx_const` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(180) COLLATE utf8_unicode_ci NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `value` text COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(64) COLLATE utf8_unicode_ci DEFAULT 'string',
  `visible` tinyint(4) NOT NULL DEFAULT '1',
  `note` text COLLATE utf8_unicode_ci,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_const` (`name`,`entity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_const` (`rowid`, `name`, `entity`, `value`, `type`, `visible`, `note`, `tms`) VALUES
(2,	'MAIN_FEATURES_LEVEL',	0,	'0',	'chaine',	1,	'Level of features to show: -1=stable+deprecated, 0=stable only (default), 1=stable+experimental, 2=stable+experimental+development',	'2022-09-06 10:05:28'),
(3,	'MAILING_LIMIT_SENDBYWEB',	0,	'25',	'chaine',	1,	'Number of targets to defined packet size when sending mass email',	'2022-09-06 10:05:28'),
(4,	'MAIN_ENABLE_LOG_TO_HTML',	0,	'0',	'chaine',	1,	'If this option is set to 1, it is possible to see log output at end of HTML sources by adding paramater logtohtml=1 on URL. Module log must also be enabled.',	'2022-09-06 10:05:28'),
(5,	'SYSLOG_HANDLERS',	0,	'[\"mod_syslog_file\"]',	'chaine',	0,	'Which logger to use',	'2022-09-06 10:05:28'),
(6,	'SYSLOG_FILE',	0,	'DOL_DATA_ROOT/dolibarr.log',	'chaine',	0,	'Directory where to write log file',	'2022-09-06 10:05:28'),
(7,	'SYSLOG_LEVEL',	0,	'7',	'chaine',	0,	'Level of debug info to show',	'2022-09-06 10:05:28'),
(8,	'MAIN_UPLOAD_DOC',	0,	'2048',	'chaine',	0,	'Max size for file upload (0 means no upload allowed)',	'2022-09-06 10:05:28'),
(9,	'MAIN_ENABLE_OVERWRITE_TRANSLATION',	1,	'1',	'chaine',	0,	'Enable translation overwrite',	'2022-09-06 10:05:28'),
(10,	'MAIN_ENABLE_DEFAULT_VALUES',	1,	'1',	'chaine',	0,	'Enable default value overwrite',	'2022-09-06 10:05:28'),
(12,	'MAIN_MAIL_SMTP_SERVER',	1,	'',	'chaine',	0,	'Host or ip address for SMTP server',	'2022-09-06 10:05:28'),
(13,	'MAIN_MAIL_SMTP_PORT',	1,	'',	'chaine',	0,	'Port for SMTP server',	'2022-09-06 10:05:28'),
(14,	'MAIN_MAIL_EMAIL_FROM',	1,	'robot@domain.com',	'chaine',	0,	'email emitter for Dolibarr automatic emails',	'2022-09-06 10:05:28'),
(15,	'MAIN_SIZE_LISTE_LIMIT',	0,	'20',	'chaine',	0,	'Maximum length of lists',	'2022-09-06 10:05:28'),
(16,	'MAIN_SIZE_SHORTLIST_LIMIT',	0,	'3',	'chaine',	0,	'Maximum length of short lists',	'2022-09-06 10:05:28'),
(17,	'MAIN_MENU_STANDARD',	0,	'eldy_menu.php',	'chaine',	0,	'Menu manager for internal users',	'2022-09-06 10:05:28'),
(18,	'MAIN_MENUFRONT_STANDARD',	0,	'eldy_menu.php',	'chaine',	0,	'Menu manager for external users',	'2022-09-06 10:05:28'),
(19,	'MAIN_MENU_SMARTPHONE',	0,	'eldy_menu.php',	'chaine',	0,	'Menu manager for internal users using smartphones',	'2022-09-06 10:05:28'),
(20,	'MAIN_MENUFRONT_SMARTPHONE',	0,	'eldy_menu.php',	'chaine',	0,	'Menu manager for external users using smartphones',	'2022-09-06 10:05:28'),
(21,	'MAIN_DELAY_ACTIONS_TODO',	1,	'7',	'chaine',	0,	'Tol??rance de retard avant alerte (en jours) sur actions planifi??es non r??alis??es',	'2022-09-06 10:05:28'),
(22,	'MAIN_DELAY_ORDERS_TO_PROCESS',	1,	'2',	'chaine',	0,	'Tol??rance de retard avant alerte (en jours) sur commandes clients non trait??es',	'2022-09-06 10:05:28'),
(23,	'MAIN_DELAY_SUPPLIER_ORDERS_TO_PROCESS',	1,	'7',	'chaine',	0,	'Tol??rance de retard avant alerte (en jours) sur commandes fournisseurs non trait??es',	'2022-09-06 10:05:28'),
(24,	'MAIN_DELAY_PROPALS_TO_CLOSE',	1,	'31',	'chaine',	0,	'Tol??rance de retard avant alerte (en jours) sur propales ?? cloturer',	'2022-09-06 10:05:28'),
(25,	'MAIN_DELAY_PROPALS_TO_BILL',	1,	'7',	'chaine',	0,	'Tol??rance de retard avant alerte (en jours) sur propales non factur??es',	'2022-09-06 10:05:28'),
(26,	'MAIN_DELAY_CUSTOMER_BILLS_UNPAYED',	1,	'31',	'chaine',	0,	'Tol??rance de retard avant alerte (en jours) sur factures client impay??es',	'2022-09-06 10:05:28'),
(27,	'MAIN_DELAY_SUPPLIER_BILLS_TO_PAY',	1,	'2',	'chaine',	0,	'Tol??rance de retard avant alerte (en jours) sur factures fournisseur impay??es',	'2022-09-06 10:05:28'),
(28,	'MAIN_DELAY_NOT_ACTIVATED_SERVICES',	1,	'0',	'chaine',	0,	'Tol??rance de retard avant alerte (en jours) sur services ?? activer',	'2022-09-06 10:05:28'),
(29,	'MAIN_DELAY_RUNNING_SERVICES',	1,	'0',	'chaine',	0,	'Tol??rance de retard avant alerte (en jours) sur services expir??s',	'2022-09-06 10:05:28'),
(30,	'MAIN_DELAY_MEMBERS',	1,	'31',	'chaine',	0,	'Tol??rance de retard avant alerte (en jours) sur cotisations adh??rent en retard',	'2022-09-06 10:05:28'),
(31,	'MAIN_DELAY_TRANSACTIONS_TO_CONCILIATE',	1,	'62',	'chaine',	0,	'Tol??rance de retard avant alerte (en jours) sur rapprochements bancaires ?? faire',	'2022-09-06 10:05:28'),
(32,	'MAIN_DELAY_EXPENSEREPORTS_TO_PAY',	1,	'31',	'chaine',	0,	'Tol??rance de retard avant alerte (en jours) sur les notes de frais impay??es',	'2022-09-06 10:05:28'),
(33,	'MAILING_EMAIL_FROM',	1,	'no-reply@mydomain.com',	'chaine',	0,	'EMail emmetteur pour les envois d emailings',	'2022-09-06 10:05:28'),
(34,	'PRODUCT_ADDON_PDF_ODT_PATH',	1,	'DOL_DATA_ROOT/doctemplates/products',	'chaine',	0,	NULL,	'2022-09-06 10:05:28'),
(35,	'CONTRACT_ADDON_PDF_ODT_PATH',	1,	'DOL_DATA_ROOT/doctemplates/contracts',	'chaine',	0,	NULL,	'2022-09-06 10:05:28'),
(36,	'USERGROUP_ADDON_PDF_ODT_PATH',	1,	'DOL_DATA_ROOT/doctemplates/usergroups',	'chaine',	0,	NULL,	'2022-09-06 10:05:28'),
(37,	'USER_ADDON_PDF_ODT_PATH',	1,	'DOL_DATA_ROOT/doctemplates/users',	'chaine',	0,	NULL,	'2022-09-06 10:05:28'),
(38,	'PRODUCT_PRICE_BASE_TYPE',	0,	'HT',	'string',	0,	NULL,	'2022-09-06 10:05:28'),
(39,	'ADHERENT_LOGIN_NOT_REQUIRED',	0,	'1',	'string',	0,	NULL,	'2022-09-06 10:05:28'),
(40,	'MAIN_MODULE_USER',	0,	'1',	'string',	0,	'{\"authorid\":0,\"ip\":\"127.0.0.1\",\"lastactivationversion\":\"dolibarr\"}',	'2022-09-06 10:07:15'),
(41,	'DATABASE_PWD_ENCRYPTED',	1,	'1',	'chaine',	0,	'',	'2022-09-06 10:07:15'),
(42,	'MAIN_SECURITY_SALT',	0,	'20220906100715',	'chaine',	0,	'',	'2022-09-06 10:07:15'),
(43,	'MAIN_SECURITY_HASH_ALGO',	0,	'password_hash',	'chaine',	0,	'',	'2022-09-06 10:07:15'),
(44,	'MAIN_VERSION_FIRST_INSTALL',	0,	'15.0.3',	'chaine',	0,	'Dolibarr version when first install',	'2022-09-06 10:07:15'),
(45,	'MAIN_VERSION_LAST_INSTALL',	0,	'15.0.3',	'chaine',	0,	'Dolibarr version when last install',	'2022-09-06 10:07:15'),
(46,	'MAIN_LANG_DEFAULT',	1,	'fr_FR',	'chaine',	0,	'Default language',	'2022-09-06 10:07:15'),
(52,	'MAIN_INFO_SOCIETE_COUNTRY',	1,	'6:CH:Suisse',	'chaine',	0,	'',	'2022-09-06 10:15:09'),
(53,	'MAIN_INFO_SOCIETE_NOM',	1,	'Stormatic',	'chaine',	0,	'',	'2022-09-06 10:15:09'),
(54,	'MAIN_MONNAIE',	1,	'CHF',	'chaine',	0,	'',	'2022-09-06 10:15:10'),
(55,	'MAIN_INFO_SOCIETE_FORME_JURIDIQUE',	1,	'0',	'chaine',	0,	'',	'2022-09-06 10:15:10'),
(56,	'SOCIETE_FISCAL_MONTH_START',	1,	'1',	'chaine',	0,	'',	'2022-09-06 10:15:10'),
(57,	'FACTURE_TVAOPTION',	1,	'1',	'chaine',	0,	'',	'2022-09-06 10:15:10'),
(58,	'MAIN_MODULE_COMMANDE',	1,	'1',	'string',	0,	'{\"authorid\":\"1\",\"ip\":\"127.0.0.1\",\"lastactivationversion\":\"dolibarr\"}',	'2022-09-06 10:16:33'),
(60,	'COMMANDE_ADDON',	1,	'mod_commande_marbre',	'chaine',	0,	'Name of numbering numerotation rules of order',	'2022-09-06 10:16:33'),
(61,	'COMMANDE_ADDON_PDF_ODT_PATH',	1,	'DOL_DATA_ROOT/doctemplates/orders',	'chaine',	0,	NULL,	'2022-09-06 10:16:33'),
(62,	'MAIN_MODULE_SOCIETE',	1,	'1',	'string',	0,	'{\"authorid\":\"1\",\"ip\":\"127.0.0.1\",\"lastactivationversion\":\"dolibarr\"}',	'2022-09-06 10:16:33'),
(63,	'SOCIETE_CODECLIENT_ADDON',	1,	'mod_codeclient_monkey',	'chaine',	0,	'Module to control third parties codes',	'2022-09-06 10:16:33'),
(64,	'SOCIETE_CODECOMPTA_ADDON',	1,	'mod_codecompta_panicum',	'chaine',	0,	'Module to control third parties codes',	'2022-09-06 10:16:33'),
(65,	'COMPANY_ADDON_PDF_ODT_PATH',	1,	'DOL_DATA_ROOT/doctemplates/thirdparties',	'chaine',	0,	NULL,	'2022-09-06 10:16:33'),
(66,	'SOCIETE_ADD_REF_IN_LIST',	1,	'0',	'yesno',	0,	'Display customer ref into select list',	'2022-09-06 10:16:33'),
(68,	'MAIN_MODULE_PROPALE',	1,	'1',	'string',	0,	'{\"authorid\":\"1\",\"ip\":\"127.0.0.1\",\"lastactivationversion\":\"dolibarr\"}',	'2022-09-06 10:16:41'),
(70,	'PROPALE_ADDON',	1,	'mod_propale_marbre',	'chaine',	0,	'Name of proposal numbering manager',	'2022-09-06 10:16:41'),
(71,	'PROPALE_VALIDITY_DURATION',	1,	'15',	'chaine',	0,	'Duration of validity of business proposals',	'2022-09-06 10:16:41'),
(72,	'PROPALE_ADDON_PDF_ODT_PATH',	1,	'DOL_DATA_ROOT/doctemplates/proposals',	'chaine',	0,	NULL,	'2022-09-06 10:16:41'),
(74,	'MAIN_MODULE_EXPEDITION',	1,	'1',	'string',	0,	'{\"authorid\":\"1\",\"ip\":\"127.0.0.1\",\"lastactivationversion\":\"dolibarr\"}',	'2022-09-06 10:16:47'),
(75,	'EXPEDITION_ADDON_PDF',	1,	'rouget',	'chaine',	0,	'Nom du gestionnaire de generation des bons expeditions en PDF',	'2022-09-06 10:16:47'),
(76,	'EXPEDITION_ADDON_NUMBER',	1,	'mod_expedition_safor',	'chaine',	0,	'Name for numbering manager for shipments',	'2022-09-06 10:16:47'),
(77,	'EXPEDITION_ADDON_PDF_ODT_PATH',	1,	'DOL_DATA_ROOT/doctemplates/shipments',	'chaine',	0,	NULL,	'2022-09-06 10:16:47'),
(78,	'DELIVERY_ADDON_PDF',	1,	'typhon',	'chaine',	0,	'Nom du gestionnaire de generation des bons de reception en PDF',	'2022-09-06 10:16:47'),
(79,	'DELIVERY_ADDON_NUMBER',	1,	'mod_delivery_jade',	'chaine',	0,	'Nom du gestionnaire de numerotation des bons de reception',	'2022-09-06 10:16:47'),
(80,	'DELIVERY_ADDON_PDF_ODT_PATH',	1,	'DOL_DATA_ROOT/doctemplates/deliveries',	'chaine',	0,	NULL,	'2022-09-06 10:16:47'),
(81,	'MAIN_SUBMODULE_EXPEDITION',	1,	'1',	'chaine',	0,	'Enable delivery receipts',	'2022-09-06 10:16:47'),
(83,	'MAIN_MODULE_FOURNISSEUR',	1,	'1',	'string',	0,	'{\"authorid\":\"1\",\"ip\":\"127.0.0.1\",\"lastactivationversion\":\"dolibarr\"}',	'2022-09-06 10:17:01'),
(84,	'COMMANDE_SUPPLIER_ADDON_PDF',	1,	'muscadet',	'chaine',	0,	'Nom du gestionnaire de generation des bons de commande en PDF',	'2022-09-06 10:17:01'),
(85,	'COMMANDE_SUPPLIER_ADDON_NUMBER',	1,	'mod_commande_fournisseur_muguet',	'chaine',	0,	'Nom du gestionnaire de numerotation des commandes fournisseur',	'2022-09-06 10:17:01'),
(86,	'INVOICE_SUPPLIER_ADDON_NUMBER',	1,	'mod_facture_fournisseur_cactus',	'chaine',	0,	'Nom du gestionnaire de numerotation des factures fournisseur',	'2022-09-06 10:17:01'),
(87,	'SUPPLIER_ORDER_ADDON_PDF_ODT_PATH',	1,	'DOL_DATA_ROOT/doctemplates/supplier_orders',	'chaine',	0,	NULL,	'2022-09-06 10:17:01'),
(89,	'MAIN_MODULE_FACTURE',	1,	'1',	'string',	0,	'{\"authorid\":\"1\",\"ip\":\"127.0.0.1\",\"lastactivationversion\":\"dolibarr\"}',	'2022-09-06 10:17:23'),
(90,	'FACTURE_ADDON',	1,	'mod_facture_terre',	'chaine',	0,	'Name of numbering numerotation rules of invoice',	'2022-09-06 10:17:23'),
(92,	'FACTURE_ADDON_PDF_ODT_PATH',	1,	'DOL_DATA_ROOT/doctemplates/invoices',	'chaine',	0,	NULL,	'2022-09-06 10:17:23'),
(94,	'MAIN_MODULE_MARGIN',	1,	'1',	'string',	0,	'{\"authorid\":\"1\",\"ip\":\"127.0.0.1\",\"lastactivationversion\":\"dolibarr\"}',	'2022-09-06 10:17:39'),
(95,	'MAIN_MODULE_MARGIN_TABS_0',	1,	'product:+margin:Margins:margins:$user->rights->margins->liretous:/margin/tabs/productMargins.php?id=__ID__',	'chaine',	0,	NULL,	'2022-09-06 10:17:39'),
(96,	'MAIN_MODULE_MARGIN_TABS_1',	1,	'thirdparty:+margin:Margins:margins:empty($user->socid) && $user->rights->margins->liretous && ($object->client > 0):/margin/tabs/thirdpartyMargins.php?socid=__ID__',	'chaine',	0,	NULL,	'2022-09-06 10:17:39'),
(98,	'MAIN_MODULE_PRODUCT',	1,	'1',	'string',	0,	'{\"authorid\":\"1\",\"ip\":\"127.0.0.1\",\"lastactivationversion\":\"dolibarr\"}',	'2022-09-06 10:17:39'),
(99,	'PRODUCT_CODEPRODUCT_ADDON',	1,	'mod_codeproduct_leopard',	'chaine',	0,	'Module to control product codes',	'2022-09-06 10:17:39'),
(102,	'MAIN_MODULE_STOCK',	1,	'1',	'string',	0,	'{\"authorid\":\"1\",\"ip\":\"127.0.0.1\",\"lastactivationversion\":\"dolibarr\"}',	'2022-09-06 10:17:45'),
(103,	'STOCK_ALLOW_NEGATIVE_TRANSFER',	1,	'1',	'chaine',	1,	NULL,	'2022-09-06 10:17:45'),
(104,	'STOCK_ADDON_PDF',	1,	'standard',	'chaine',	0,	'Name of PDF model of stock',	'2022-09-06 10:17:45'),
(105,	'MOUVEMENT_ADDON_PDF',	1,	'stdmovement',	'chaine',	0,	'Name of PDF model of stock mouvement',	'2022-09-06 10:17:45'),
(106,	'STOCK_ADDON_PDF_ODT_PATH',	1,	'DOL_DATA_ROOT/doctemplates/stocks',	'chaine',	0,	NULL,	'2022-09-06 10:17:45'),
(107,	'MOUVEMENT_ADDON_PDF_ODT_PATH',	1,	'DOL_DATA_ROOT/doctemplates/stocks/mouvements',	'chaine',	0,	NULL,	'2022-09-06 10:17:45'),
(109,	'MAIN_MODULE_VARIANTS',	1,	'1',	'string',	0,	'{\"authorid\":\"1\",\"ip\":\"127.0.0.1\",\"lastactivationversion\":\"dolibarr\"}',	'2022-09-06 10:17:51'),
(111,	'MAIN_FIRST_PING_OK_DATE',	1,	'20220906102151',	'chaine',	0,	'',	'2022-09-06 10:21:51'),
(112,	'MAIN_FIRST_PING_OK_ID',	1,	'disabled',	'chaine',	0,	'',	'2022-09-06 10:21:51'),
(113,	'MAIN_MODULE_SUPPLIERPROPOSAL',	1,	'1',	'string',	0,	'{\"authorid\":\"1\",\"ip\":\"127.0.0.1\",\"lastactivationversion\":\"dolibarr\"}',	'2022-09-06 14:50:36'),
(114,	'SUPPLIER_PROPOSAL_ADDON_PDF',	1,	'aurore',	'chaine',	0,	'Name of submodule to generate PDF for supplier quotation request',	'2022-09-06 14:50:36'),
(115,	'SUPPLIER_PROPOSAL_ADDON',	1,	'mod_supplier_proposal_marbre',	'chaine',	0,	'Name of submodule to number supplier quotation request',	'2022-09-06 14:50:36'),
(116,	'SUPPLIER_PROPOSAL_ADDON_PDF_ODT_PATH',	1,	'DOL_DATA_ROOT/doctemplates/supplier_proposals',	'chaine',	0,	NULL,	'2022-09-06 14:50:36'),
(118,	'MAIN_MODULE_TAX',	1,	'1',	'string',	0,	'{\"authorid\":\"1\",\"ip\":\"127.0.0.1\",\"lastactivationversion\":\"dolibarr\"}',	'2022-09-06 14:51:09'),
(120,	'TAX_MODE',	1,	'0',	'chaine',	0,	'',	'2022-09-06 14:51:25'),
(121,	'TAX_MODE_SELL_PRODUCT',	1,	'invoice',	'chaine',	0,	'',	'2022-09-06 14:51:25'),
(122,	'TAX_MODE_BUY_PRODUCT',	1,	'invoice',	'chaine',	0,	'',	'2022-09-06 14:51:25'),
(123,	'TAX_MODE_SELL_SERVICE',	1,	'payment',	'chaine',	0,	'',	'2022-09-06 14:51:25'),
(124,	'TAX_MODE_BUY_SERVICE',	1,	'payment',	'chaine',	0,	'',	'2022-09-06 14:51:25'),
(125,	'MAIN_INFO_VAT_RETURN',	1,	'0',	'chaine',	0,	'',	'2022-09-06 14:51:25'),
(126,	'MAIN_MODULE_SERVICE',	1,	'1',	'string',	0,	'{\"authorid\":\"1\",\"ip\":\"127.0.0.1\",\"lastactivationversion\":\"dolibarr\"}',	'2022-09-06 14:53:12'),
(128,	'MAIN_MODULE_CATEGORIE',	1,	'1',	'string',	0,	'{\"authorid\":\"1\",\"ip\":\"127.0.0.1\",\"lastactivationversion\":\"dolibarr\"}',	'2022-09-06 14:54:52'),
(131,	'MAIN_MODULE_CRMENHANCED',	1,	'1',	'string',	0,	'{\"authorid\":\"1\",\"ip\":\"127.0.0.1\",\"lastactivationversion\":\"2.1\"}',	'2022-09-07 14:01:54'),
(132,	'MAIN_MODULE_CRMENHANCED_TABS_0',	1,	'thirdparty:+activitylist:ActivityList:crmenhanced@crmenhanced:$user->rights->crmenhanced->readactivity:/crmenhanced/activitiestab.php?socid=__ID__',	'chaine',	0,	NULL,	'2022-09-07 14:01:54'),
(133,	'MAIN_MODULE_CRMENHANCED_TRIGGERS',	1,	'1',	'chaine',	0,	NULL,	'2022-09-07 14:01:54'),
(134,	'MAIN_MODULE_CRMENHANCED_LOGIN',	1,	'0',	'chaine',	0,	NULL,	'2022-09-07 14:01:54'),
(135,	'MAIN_MODULE_CRMENHANCED_SUBSTITUTIONS',	1,	'1',	'chaine',	0,	NULL,	'2022-09-07 14:01:54'),
(136,	'MAIN_MODULE_CRMENHANCED_MENUS',	1,	'0',	'chaine',	0,	NULL,	'2022-09-07 14:01:54'),
(137,	'MAIN_MODULE_CRMENHANCED_THEME',	1,	'0',	'chaine',	0,	NULL,	'2022-09-07 14:01:54'),
(138,	'MAIN_MODULE_CRMENHANCED_TPL',	1,	'0',	'chaine',	0,	NULL,	'2022-09-07 14:01:54'),
(139,	'MAIN_MODULE_CRMENHANCED_BARCODE',	1,	'0',	'chaine',	0,	NULL,	'2022-09-07 14:01:54'),
(140,	'MAIN_MODULE_CRMENHANCED_MODELS',	1,	'0',	'chaine',	0,	NULL,	'2022-09-07 14:01:54'),
(141,	'MAIN_MODULE_CRMENHANCED_HOOKS',	0,	'[\"mail\",\"globalcard\"]',	'chaine',	0,	NULL,	'2022-09-07 14:01:54'),
(143,	'MAIN_MODULE_KANPROSPECTS',	1,	'1',	'string',	0,	'{\"authorid\":\"1\",\"ip\":\"127.0.0.1\",\"lastactivationversion\":\"1.4\"}',	'2022-09-07 14:01:59'),
(144,	'MAIN_MODULE_KANPROSPECTS_TRIGGERS',	1,	'0',	'chaine',	0,	NULL,	'2022-09-07 14:01:59'),
(145,	'MAIN_MODULE_KANPROSPECTS_LOGIN',	1,	'0',	'chaine',	0,	NULL,	'2022-09-07 14:01:59'),
(146,	'MAIN_MODULE_KANPROSPECTS_SUBSTITUTIONS',	1,	'0',	'chaine',	0,	NULL,	'2022-09-07 14:01:59'),
(147,	'MAIN_MODULE_KANPROSPECTS_MENUS',	1,	'0',	'chaine',	0,	NULL,	'2022-09-07 14:01:59'),
(148,	'MAIN_MODULE_KANPROSPECTS_THEME',	1,	'0',	'chaine',	0,	NULL,	'2022-09-07 14:01:59'),
(149,	'MAIN_MODULE_KANPROSPECTS_TPL',	1,	'0',	'chaine',	0,	NULL,	'2022-09-07 14:01:59'),
(150,	'MAIN_MODULE_KANPROSPECTS_BARCODE',	1,	'0',	'chaine',	0,	NULL,	'2022-09-07 14:01:59'),
(151,	'MAIN_MODULE_KANPROSPECTS_MODELS',	1,	'0',	'chaine',	0,	NULL,	'2022-09-07 14:01:59'),
(152,	'KANPROSPECTS_SHOW_PICTO',	1,	'1',	'yesno',	0,	'KANPROSPECTS_SHOW_PICTO',	'2022-09-07 14:01:59'),
(153,	'KANPROSPECTS_PROSPECTS_TAG',	1,	'prospectlevel_label',	'string',	0,	'KANPROSPECTS_PROSPECTS_TAG',	'2022-09-07 14:01:59'),
(154,	'KANPROSPECTS_PROSPECTS_PL_HIGH_COLOR',	1,	'#73bf44',	'string',	0,	'KANPROSPECTS_PROSPECTS_PL_HIGH_COLOR',	'2022-09-07 14:01:59'),
(155,	'KANPROSPECTS_PROSPECTS_PL_LOW_COLOR',	1,	'#b76caa',	'string',	0,	'KANPROSPECTS_PROSPECTS_PL_LOW_COLOR',	'2022-09-07 14:01:59'),
(156,	'KANPROSPECTS_PROSPECTS_PL_MEDIUM_COLOR',	1,	'#f7991d',	'string',	0,	'KANPROSPECTS_PROSPECTS_PL_MEDIUM_COLOR',	'2022-09-07 14:01:59'),
(157,	'KANPROSPECTS_PROSPECTS_PL_NONE_COLOR',	1,	'#ff0000',	'string',	0,	'KANPROSPECTS_PROSPECTS_PL_NONE_COLOR',	'2022-09-07 14:01:59'),
(159,	'MAIN_MODULE_SUBTOTAL',	1,	'1',	'string',	0,	'{\"authorid\":\"1\",\"ip\":\"127.0.0.1\",\"lastactivationversion\":\"3.14.5\"}',	'2022-09-07 14:02:04'),
(160,	'MAIN_MODULE_SUBTOTAL_TRIGGERS',	1,	'1',	'chaine',	0,	NULL,	'2022-09-07 14:02:04'),
(161,	'MAIN_MODULE_SUBTOTAL_MODELS',	1,	'1',	'chaine',	0,	NULL,	'2022-09-07 14:02:04'),
(162,	'MAIN_MODULE_SUBTOTAL_HOOKS',	1,	'[\"invoicecard\",\"invoicesuppliercard\",\"propalcard\",\"supplier_proposalcard\",\"ordercard\",\"ordersuppliercard\",\"odtgeneration\",\"orderstoinvoice\",\"orderstoinvoicesupplier\",\"admin\",\"invoicereccard\",\"consumptionthirdparty\",\"ordershipmentcard\",\"expeditioncard\",\"deliverycard\",\"paiementcard\",\"referencelettersinstacecard\",\"shippableorderlist\",\"propallist\",\"orderlist\",\"invoicelist\",\"supplierorderlist\",\"supplierinvoicelist\"]',	'chaine',	0,	NULL,	'2022-09-07 14:02:04'),
(163,	'MAIN_MODULE_SUBTOTAL_TPL',	1,	'1',	'chaine',	0,	NULL,	'2022-09-07 14:02:04'),
(164,	'SUBTOTAL_STYLE_TITRES_SI_LIGNES_CACHEES',	1,	'I',	'chaine',	1,	'D??finit le style (B : gras, I : Italique, U : Soulign??) des sous titres lorsque le d??tail des lignes et des ensembles est cach??',	'2022-09-07 14:02:04'),
(165,	'SUBTOTAL_ALLOW_ADD_BLOCK',	1,	'1',	'chaine',	0,	'Permet l\'ajout de titres et sous-totaux',	'2022-09-07 14:02:04'),
(166,	'SUBTOTAL_ALLOW_EDIT_BLOCK',	1,	'1',	'chaine',	0,	'Permet de modifier titres et sous-totaux',	'2022-09-07 14:02:04'),
(167,	'SUBTOTAL_ALLOW_REMOVE_BLOCK',	1,	'1',	'chaine',	0,	'Permet de supprimer les titres et sous-totaux',	'2022-09-07 14:02:04'),
(168,	'SUBTOTAL_TITLE_STYLE',	1,	'BU',	'chaine',	0,	NULL,	'2022-09-07 14:02:04'),
(169,	'SUBTOTAL_SUBTOTAL_STYLE',	1,	'B',	'chaine',	0,	NULL,	'2022-09-07 14:02:04'),
(171,	'FACTURE_ADDON_PDF',	1,	'payplug',	'chaine',	0,	'',	'2022-09-07 14:02:20'),
(172,	'MAIN_MODULE_MODULEBUILDER',	1,	'1',	'string',	0,	'{\"authorid\":\"1\",\"ip\":\"127.0.0.1\",\"lastactivationversion\":\"dolibarr\"}',	'2022-09-09 10:20:08'),
(376,	'PROJECT_ADDON_PDF',	1,	'baleine',	'chaine',	0,	'Name of PDF/ODT project manager class',	'2022-09-09 15:16:49'),
(377,	'PROJECT_ADDON',	1,	'mod_project_simple',	'chaine',	0,	'Name of Numbering Rule project manager class',	'2022-09-09 15:16:49'),
(378,	'PROJECT_ADDON_PDF_ODT_PATH',	1,	'DOL_DATA_ROOT/doctemplates/projects',	'chaine',	0,	NULL,	'2022-09-09 15:16:49'),
(379,	'PROJECT_TASK_ADDON_PDF',	1,	'',	'chaine',	0,	'Name of PDF/ODT tasks manager class',	'2022-09-09 15:16:49'),
(380,	'PROJECT_TASK_ADDON',	1,	'mod_task_simple',	'chaine',	0,	'Name of Numbering Rule task manager class',	'2022-09-09 15:16:49'),
(381,	'PROJECT_TASK_ADDON_PDF_ODT_PATH',	1,	'DOL_DATA_ROOT/doctemplates/tasks',	'chaine',	0,	NULL,	'2022-09-09 15:16:49'),
(382,	'PROJECT_USE_OPPORTUNITIES',	1,	'1',	'chaine',	0,	NULL,	'2022-09-09 15:16:49'),
(383,	'MAIN_DELAY_PROJECT_TO_CLOSE',	1,	'7',	'chaine',	0,	NULL,	'2022-09-09 15:16:49'),
(384,	'MAIN_DELAY_TASKS_TODO',	1,	'7',	'chaine',	0,	NULL,	'2022-09-09 15:16:49'),
(438,	'MAIN_MODULE_SYSLOG',	0,	'1',	'string',	0,	'{\"authorid\":\"1\",\"ip\":\"127.0.0.1\",\"lastactivationversion\":\"dolibarr\"}',	'2022-09-12 09:52:47'),
(452,	'MAIN_MODULE_IMPORT',	1,	'1',	'string',	0,	'{\"authorid\":\"1\",\"ip\":\"127.0.0.1\",\"lastactivationversion\":\"dolibarr\"}',	'2022-09-12 10:24:24'),
(454,	'IMPORT_CSV_SEPARATOR_TO_USE',	1,	',',	'chaine',	0,	'',	'2022-09-12 10:24:32'),
(499,	'MAIN_MODULE_EXPORT',	1,	'1',	'string',	0,	'{\"authorid\":\"1\",\"ip\":\"127.0.0.1\",\"lastactivationversion\":\"dolibarr\"}',	'2022-09-12 13:22:41'),
(501,	'MAIN_MODULE_API',	0,	'1',	'string',	0,	'{\"authorid\":\"1\",\"ip\":\"127.0.0.1\",\"lastactivationversion\":\"dolibarr\"}',	'2022-09-12 13:29:59'),
(1678,	'MAIN_MODULE_WEBSERVICES',	1,	'1',	'string',	0,	'{\"authorid\":\"1\",\"ip\":\"127.0.0.1\",\"lastactivationversion\":\"dolibarr\"}',	'2022-09-29 16:42:21'),
(1680,	'WEBSERVICES_KEY',	1,	'99t0RlMoWdbS33GM22nMZ008qdQzNbfC',	'chaine',	0,	'',	'2022-09-29 16:42:36'),
(1681,	'PROPALE_ADDON_PDF',	1,	'cyan',	'chaine',	0,	'',	'2022-09-30 12:01:20'),
(1682,	'COMMANDE_ADDON_PDF',	1,	'eratosthene',	'chaine',	0,	'',	'2022-09-30 12:28:36'),
(1773,	'CATEGORIE_RECURSIV_ADD',	1,	'1',	'chaine',	0,	'',	'2022-10-06 09:15:18'),
(1813,	'IMPORTFILESCSV_MYPARAM1',	1,	'10',	'chaine',	0,	'',	'2022-10-07 16:01:23'),
(1814,	'IMPORTFILESCSV_MYPARAM2',	1,	'20',	'chaine',	0,	'',	'2022-10-07 16:01:23'),
(1815,	'DefaultTransportFee',	1,	'50',	'chaine',	0,	'',	'2022-10-07 21:35:47'),
(1816,	'DefaultMarginRate',	1,	'200',	'chaine',	0,	'',	'2022-10-07 21:35:47'),
(1817,	'DefaultExchangeRate',	1,	'20',	'chaine',	0,	'',	'2022-10-07 21:35:47'),
(1828,	'PRODUIT_LIMIT_SIZE',	1,	'1000',	'chaine',	0,	'',	'2022-10-10 15:01:18'),
(1829,	'PRODUIT_MULTIPRICES_LIMIT',	1,	'3',	'chaine',	0,	'',	'2022-10-10 15:01:18'),
(1830,	'PRODUCT_PRICE_UNIQ',	1,	'0',	'chaine',	0,	'',	'2022-10-10 15:01:18'),
(1831,	'PRODUIT_MULTIPRICES',	1,	'1',	'chaine',	0,	'',	'2022-10-10 15:01:18'),
(1832,	'PRODUIT_CUSTOMER_PRICES',	1,	'0',	'chaine',	0,	'',	'2022-10-10 15:01:18'),
(1833,	'PRODUCT_PRICE_BASE_TYPE',	1,	'HT',	'chaine',	0,	'',	'2022-10-10 15:01:18'),
(1834,	'PRODUIT_DESC_IN_FORM',	1,	'0',	'chaine',	0,	'',	'2022-10-10 15:01:18'),
(1835,	'PRODUIT_USE_SEARCH_TO_SELECT',	1,	'0',	'chaine',	0,	'',	'2022-10-10 15:01:18'),
(1836,	'PRODUIT_FOURN_TEXTS',	1,	'0',	'chaine',	0,	'',	'2022-10-10 15:01:18'),
(1837,	'PRODUIT_AUTOFILL_DESC',	1,	'0',	'chaine',	0,	'',	'2022-10-10 15:01:18'),
(1838,	'PRODUCT_USE_SUPPLIER_PACKAGING',	1,	'0',	'chaine',	0,	'',	'2022-10-10 15:01:18'),
(1869,	'PRODUIT_MULTIPRICES_LABEL2',	1,	'Pro',	'chaine',	0,	'',	'2022-10-11 10:00:44'),
(1870,	'PRODUIT_MULTIPRICES_LABEL1',	1,	'Particulier',	'chaine',	0,	'',	'2022-10-11 10:01:06'),
(1871,	'PRODUIT_MULTIPRICES_LABEL3',	1,	'Collectivit??',	'chaine',	0,	'',	'2022-10-11 10:01:16'),
(1898,	'DISPLAY_MARGIN_RATES',	1,	'1',	'chaine',	0,	'',	'2022-10-11 15:51:59'),
(1899,	'DISPLAY_MARK_RATES',	1,	'1',	'chaine',	0,	'',	'2022-10-11 15:52:00'),
(1901,	'MARGIN_TYPE',	1,	'1',	'chaine',	0,	'',	'2022-10-11 15:55:03'),
(1902,	'MAIN_MAX_DECIMALS_UNIT',	1,	'2',	'chaine',	0,	'',	'2022-10-13 10:34:16'),
(1903,	'MAIN_MAX_DECIMALS_TOT',	1,	'2',	'chaine',	0,	'',	'2022-10-13 10:34:16'),
(1904,	'MAIN_MAX_DECIMALS_SHOWN',	1,	'8',	'chaine',	0,	'',	'2022-10-13 10:34:16'),
(1905,	'MAIN_INFO_ACCOUNTANT_STATE',	1,	'0',	'chaine',	0,	'',	'2022-10-13 11:55:36'),
(1906,	'MAIN_VAT_DEFAULT_IF_AUTODETECT_FAILS',	1,	'7.7',	'chaine',	1,	'TVA par d??faut',	'2022-10-13 12:07:10'),
(2352,	'MAIN_IHM_PARAMS_REV',	1,	'48',	'chaine',	0,	'',	'2022-10-18 13:28:42'),
(2353,	'MAIN_MODULE_STORMATIC',	1,	'1',	'string',	0,	'{\"authorid\":\"1\",\"ip\":\"127.0.0.1\",\"lastactivationversion\":\"1.0\"}',	'2022-10-18 13:30:35'),
(2354,	'MAIN_MODULE_STORMATIC_TABS_0',	1,	'product:+tabname1:ProduitAbaque:mylangfile@stormatic:$user->rights->stormatic->csv->read:../product/abaque.php?id=__ID__',	'chaine',	0,	NULL,	'2022-10-18 13:30:35'),
(2355,	'MAIN_MODULE_STORMATIC_TRIGGERS',	1,	'1',	'chaine',	0,	NULL,	'2022-10-18 13:30:35'),
(2356,	'MAIN_MODULE_STORMATIC_LOGIN',	1,	'0',	'chaine',	0,	NULL,	'2022-10-18 13:30:35'),
(2357,	'MAIN_MODULE_STORMATIC_SUBSTITUTIONS',	1,	'0',	'chaine',	0,	NULL,	'2022-10-18 13:30:35'),
(2358,	'MAIN_MODULE_STORMATIC_MENUS',	1,	'0',	'chaine',	0,	NULL,	'2022-10-18 13:30:35'),
(2359,	'MAIN_MODULE_STORMATIC_TPL',	1,	'0',	'chaine',	0,	NULL,	'2022-10-18 13:30:35'),
(2360,	'MAIN_MODULE_STORMATIC_BARCODE',	1,	'0',	'chaine',	0,	NULL,	'2022-10-18 13:30:35'),
(2361,	'MAIN_MODULE_STORMATIC_MODELS',	1,	'1',	'chaine',	0,	NULL,	'2022-10-18 13:30:35'),
(2362,	'MAIN_MODULE_STORMATIC_PRINTING',	1,	'0',	'chaine',	0,	NULL,	'2022-10-18 13:30:35'),
(2363,	'MAIN_MODULE_STORMATIC_THEME',	1,	'0',	'chaine',	0,	NULL,	'2022-10-18 13:30:35'),
(2364,	'MAIN_MODULE_STORMATIC_HOOKS',	1,	'[\"propalcard\",\"ordercard\",\"invoicecard\"]',	'chaine',	0,	NULL,	'2022-10-18 13:30:35'),
(2365,	'MAIN_MODULE_STORMATIC_MODULEFOREXTERNAL',	1,	'0',	'chaine',	0,	NULL,	'2022-10-18 13:30:35');

DROP TABLE IF EXISTS `llx_contrat`;
CREATE TABLE `llx_contrat` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `ref` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ref_customer` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ref_supplier` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ref_ext` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `datec` datetime DEFAULT NULL,
  `date_contrat` datetime DEFAULT NULL,
  `statut` smallint(6) DEFAULT '0',
  `fin_validite` datetime DEFAULT NULL,
  `date_cloture` datetime DEFAULT NULL,
  `fk_soc` int(11) NOT NULL,
  `fk_projet` int(11) DEFAULT NULL,
  `fk_commercial_signature` int(11) DEFAULT NULL,
  `fk_commercial_suivi` int(11) DEFAULT NULL,
  `fk_user_author` int(11) NOT NULL DEFAULT '0',
  `fk_user_modif` int(11) DEFAULT NULL,
  `fk_user_cloture` int(11) DEFAULT NULL,
  `note_private` text COLLATE utf8_unicode_ci,
  `note_public` text COLLATE utf8_unicode_ci,
  `model_pdf` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_main_doc` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `extraparams` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_contrat_ref` (`ref`,`entity`),
  KEY `idx_contrat_fk_soc` (`fk_soc`),
  KEY `idx_contrat_fk_user_author` (`fk_user_author`),
  CONSTRAINT `fk_contrat_fk_soc` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`),
  CONSTRAINT `fk_contrat_user_author` FOREIGN KEY (`fk_user_author`) REFERENCES `llx_user` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_contratdet`;
CREATE TABLE `llx_contratdet` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_contrat` int(11) NOT NULL,
  `fk_product` int(11) DEFAULT NULL,
  `statut` smallint(6) DEFAULT '0',
  `label` text COLLATE utf8_unicode_ci,
  `description` text COLLATE utf8_unicode_ci,
  `fk_remise_except` int(11) DEFAULT NULL,
  `date_commande` datetime DEFAULT NULL,
  `date_ouverture_prevue` datetime DEFAULT NULL,
  `date_ouverture` datetime DEFAULT NULL,
  `date_fin_validite` datetime DEFAULT NULL,
  `date_cloture` datetime DEFAULT NULL,
  `vat_src_code` varchar(10) COLLATE utf8_unicode_ci DEFAULT '',
  `tva_tx` double(7,4) DEFAULT '0.0000',
  `localtax1_tx` double(7,4) DEFAULT '0.0000',
  `localtax1_type` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `localtax2_tx` double(7,4) DEFAULT '0.0000',
  `localtax2_type` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `qty` double NOT NULL,
  `remise_percent` double DEFAULT '0',
  `subprice` double(24,8) DEFAULT '0.00000000',
  `price_ht` double DEFAULT NULL,
  `remise` double DEFAULT '0',
  `total_ht` double(24,8) DEFAULT '0.00000000',
  `total_tva` double(24,8) DEFAULT '0.00000000',
  `total_localtax1` double(24,8) DEFAULT '0.00000000',
  `total_localtax2` double(24,8) DEFAULT '0.00000000',
  `total_ttc` double(24,8) DEFAULT '0.00000000',
  `product_type` int(11) DEFAULT '1',
  `info_bits` int(11) DEFAULT '0',
  `buy_price_ht` double(24,8) DEFAULT NULL,
  `fk_product_fournisseur_price` int(11) DEFAULT NULL,
  `fk_user_author` int(11) NOT NULL DEFAULT '0',
  `fk_user_ouverture` int(11) DEFAULT NULL,
  `fk_user_cloture` int(11) DEFAULT NULL,
  `commentaire` text COLLATE utf8_unicode_ci,
  `fk_unit` int(11) DEFAULT NULL,
  `fk_multicurrency` int(11) DEFAULT NULL,
  `multicurrency_code` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `multicurrency_subprice` double(24,8) DEFAULT '0.00000000',
  `multicurrency_total_ht` double(24,8) DEFAULT '0.00000000',
  `multicurrency_total_tva` double(24,8) DEFAULT '0.00000000',
  `multicurrency_total_ttc` double(24,8) DEFAULT '0.00000000',
  PRIMARY KEY (`rowid`),
  KEY `idx_contratdet_fk_contrat` (`fk_contrat`),
  KEY `idx_contratdet_fk_product` (`fk_product`),
  KEY `idx_contratdet_date_ouverture_prevue` (`date_ouverture_prevue`),
  KEY `idx_contratdet_date_ouverture` (`date_ouverture`),
  KEY `idx_contratdet_date_fin_validite` (`date_fin_validite`),
  KEY `fk_contratdet_fk_unit` (`fk_unit`),
  CONSTRAINT `fk_contratdet_fk_contrat` FOREIGN KEY (`fk_contrat`) REFERENCES `llx_contrat` (`rowid`),
  CONSTRAINT `fk_contratdet_fk_product` FOREIGN KEY (`fk_product`) REFERENCES `llx_product` (`rowid`),
  CONSTRAINT `fk_contratdet_fk_unit` FOREIGN KEY (`fk_unit`) REFERENCES `llx_c_units` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_contratdet_extrafields`;
CREATE TABLE `llx_contratdet_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_contratdet_extrafields` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_contratdet_log`;
CREATE TABLE `llx_contratdet_log` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_contratdet` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `statut` smallint(6) NOT NULL,
  `fk_user_author` int(11) NOT NULL,
  `commentaire` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`rowid`),
  KEY `idx_contratdet_log_fk_contratdet` (`fk_contratdet`),
  KEY `idx_contratdet_log_date` (`date`),
  CONSTRAINT `fk_contratdet_log_fk_contratdet` FOREIGN KEY (`fk_contratdet`) REFERENCES `llx_contratdet` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_contrat_extrafields`;
CREATE TABLE `llx_contrat_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_contrat_extrafields` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_crm_activity`;
CREATE TABLE `llx_crm_activity` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `datec` datetime DEFAULT NULL,
  `fk_campaign` int(11) DEFAULT NULL,
  `priority` int(2) DEFAULT NULL,
  `activity_type` char(1) NOT NULL,
  `fk_mode` int(11) NOT NULL,
  `fk_status` int(11) NOT NULL,
  `fk_thirdparty` int(11) NOT NULL,
  `fk_contact` int(11) DEFAULT NULL,
  `fk_owner` int(11) DEFAULT NULL,
  `duration` datetime DEFAULT NULL,
  `fk_object` int(11) NOT NULL,
  `note` text,
  `fk_next_owner` int(11) DEFAULT NULL,
  `next_date` datetime DEFAULT NULL,
  `next_note` text,
  PRIMARY KEY (`rowid`),
  KEY `fk_activity_fk_mode` (`fk_mode`),
  KEY `fk_activity_fk_thirdparty` (`fk_thirdparty`),
  KEY `fk_activity_fk_contact` (`fk_contact`),
  KEY `fk_activity_fk_owner` (`fk_owner`),
  KEY `fk_activity_fk_object` (`fk_object`),
  KEY `fk_activity_fk_new_owner` (`fk_next_owner`),
  KEY `fk_activity_fk_status` (`fk_status`),
  KEY `fk_activity_fk_campaign` (`fk_campaign`),
  CONSTRAINT `fk_activity_fk_campaign` FOREIGN KEY (`fk_campaign`) REFERENCES `llx_crm_campaigns` (`rowid`),
  CONSTRAINT `fk_activity_fk_contact` FOREIGN KEY (`fk_contact`) REFERENCES `llx_socpeople` (`rowid`),
  CONSTRAINT `fk_activity_fk_mode` FOREIGN KEY (`fk_mode`) REFERENCES `llx_crm_activity_mode` (`rowid`),
  CONSTRAINT `fk_activity_fk_new_owner` FOREIGN KEY (`fk_next_owner`) REFERENCES `llx_user` (`rowid`),
  CONSTRAINT `fk_activity_fk_object` FOREIGN KEY (`fk_object`) REFERENCES `llx_crm_activity_object` (`rowid`),
  CONSTRAINT `fk_activity_fk_owner` FOREIGN KEY (`fk_owner`) REFERENCES `llx_user` (`rowid`),
  CONSTRAINT `fk_activity_fk_status` FOREIGN KEY (`fk_status`) REFERENCES `llx_crm_activity_status` (`rowid`),
  CONSTRAINT `fk_activity_fk_thirdparty` FOREIGN KEY (`fk_thirdparty`) REFERENCES `llx_societe` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `llx_crm_activity_mode`;
CREATE TABLE `llx_crm_activity_mode` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(30) NOT NULL,
  `label` varchar(60) NOT NULL,
  `active` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Contains the activity modes';


DROP TABLE IF EXISTS `llx_crm_activity_object`;
CREATE TABLE `llx_crm_activity_object` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(30) NOT NULL,
  `label` varchar(60) NOT NULL,
  `active` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Contains the activity tipoligies';


DROP TABLE IF EXISTS `llx_crm_activity_status`;
CREATE TABLE `llx_crm_activity_status` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(30) NOT NULL,
  `label` varchar(60) NOT NULL,
  `active` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Contains the activities status';


DROP TABLE IF EXISTS `llx_crm_campaigns`;
CREATE TABLE `llx_crm_campaigns` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `datec` datetime DEFAULT NULL,
  `label` varchar(255) NOT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `llx_crm_event`;
CREATE TABLE `llx_crm_event` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_message` int(11) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `event` varchar(12) DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `duplicati` (`fk_message`,`date`,`event`),
  CONSTRAINT `fk_crm_eventfk_crm_messages` FOREIGN KEY (`fk_message`) REFERENCES `llx_crm_messages` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `llx_crm_groups`;
CREATE TABLE `llx_crm_groups` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `fk_parent` int(11) NOT NULL DEFAULT '0',
  `label` varchar(30) NOT NULL,
  PRIMARY KEY (`rowid`,`entity`,`fk_parent`,`label`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `llx_crm_group_recipient`;
CREATE TABLE `llx_crm_group_recipient` (
  `fk_societe` int(11) NOT NULL,
  `fk_group` int(11) NOT NULL,
  `source_type` varchar(16) NOT NULL,
  `fk_entity` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`fk_societe`,`fk_group`,`fk_entity`,`source_type`),
  KEY `fk_gr_tp_crmgroup` (`fk_group`),
  CONSTRAINT `fk_gr_tp_crmgroup` FOREIGN KEY (`fk_group`) REFERENCES `llx_crm_groups` (`rowid`),
  CONSTRAINT `fk_gr_tp_societe` FOREIGN KEY (`fk_societe`) REFERENCES `llx_societe` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `llx_crm_messages`;
CREATE TABLE `llx_crm_messages` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) DEFAULT '1',
  `fk_campaign` int(11) DEFAULT NULL,
  `type` varchar(1) DEFAULT NULL,
  `title` varchar(128) DEFAULT NULL,
  `status` smallint(6) DEFAULT '0',
  `date` datetime DEFAULT NULL,
  `date_send` datetime DEFAULT NULL,
  `subject` varchar(128) DEFAULT NULL,
  `body` mediumtext,
  `from` varchar(160) DEFAULT NULL,
  `to` varchar(160) DEFAULT NULL,
  `reply_to` varchar(160) DEFAULT NULL,
  `cc` text,
  `bcc` text,
  `external_key` decimal(23,11) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `fk_message_fk_campaign` (`fk_campaign`),
  CONSTRAINT `fk_message_fk_campaign` FOREIGN KEY (`fk_campaign`) REFERENCES `llx_crm_campaigns` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `llx_crm_recipient`;
CREATE TABLE `llx_crm_recipient` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_message` int(11) NOT NULL,
  `fk_recipient` int(11) DEFAULT NULL,
  `date_send` datetime DEFAULT NULL,
  `source_type` varchar(16) DEFAULT NULL,
  `status` smallint(6) DEFAULT '0',
  `external_key` decimal(23,11) DEFAULT '0.00000000000',
  PRIMARY KEY (`rowid`),
  KEY `fk_crm_recipient_fk_crm_messages` (`fk_message`),
  CONSTRAINT `fk_crm_recipient_fk_crm_messages` FOREIGN KEY (`fk_message`) REFERENCES `llx_crm_messages` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `llx_cronjob`;
CREATE TABLE `llx_cronjob` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `datec` datetime DEFAULT NULL,
  `jobtype` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `label` text COLLATE utf8_unicode_ci NOT NULL,
  `command` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `classesname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `objectname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `methodename` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `params` text COLLATE utf8_unicode_ci,
  `md5params` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `module_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `priority` int(11) DEFAULT '0',
  `datelastrun` datetime DEFAULT NULL,
  `datenextrun` datetime DEFAULT NULL,
  `datestart` datetime DEFAULT NULL,
  `dateend` datetime DEFAULT NULL,
  `datelastresult` datetime DEFAULT NULL,
  `lastresult` text COLLATE utf8_unicode_ci,
  `lastoutput` text COLLATE utf8_unicode_ci,
  `unitfrequency` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '3600',
  `frequency` int(11) NOT NULL DEFAULT '0',
  `maxrun` int(11) NOT NULL DEFAULT '0',
  `nbrun` int(11) DEFAULT NULL,
  `autodelete` int(11) DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '1',
  `processing` int(11) NOT NULL DEFAULT '0',
  `test` varchar(255) COLLATE utf8_unicode_ci DEFAULT '1',
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_mod` int(11) DEFAULT NULL,
  `fk_mailing` int(11) DEFAULT NULL,
  `note` text COLLATE utf8_unicode_ci,
  `libname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `entity` int(11) DEFAULT '0',
  PRIMARY KEY (`rowid`),
  KEY `idx_cronjob_status` (`status`),
  KEY `idx_cronjob_datelastrun` (`datelastrun`),
  KEY `idx_cronjob_datenextrun` (`datenextrun`),
  KEY `idx_cronjob_datestart` (`datestart`),
  KEY `idx_cronjob_dateend` (`dateend`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_cronjob` (`rowid`, `tms`, `datec`, `jobtype`, `label`, `command`, `classesname`, `objectname`, `methodename`, `params`, `md5params`, `module_name`, `priority`, `datelastrun`, `datenextrun`, `datestart`, `dateend`, `datelastresult`, `lastresult`, `lastoutput`, `unitfrequency`, `frequency`, `maxrun`, `nbrun`, `autodelete`, `status`, `processing`, `test`, `fk_user_author`, `fk_user_mod`, `fk_mailing`, `note`, `libname`, `entity`) VALUES
(1,	'2022-09-06 10:17:23',	'2022-09-06 10:17:23',	'method',	'RecurringInvoices',	NULL,	'compta/facture/class/facture-rec.class.php',	'FactureRec',	'createRecurringInvoices',	NULL,	NULL,	'facture',	50,	NULL,	NULL,	'2022-09-06 23:00:00',	NULL,	NULL,	NULL,	NULL,	'86400',	1,	0,	NULL,	0,	1,	0,	'$conf->facture->enabled',	NULL,	NULL,	NULL,	'Generate recurring invoices',	NULL,	1),
(2,	'2022-09-06 10:17:23',	'2022-09-06 10:17:23',	'method',	'SendEmailsRemindersOnInvoiceDueDate',	NULL,	'compta/facture/class/facture.class.php',	'Facture',	'sendEmailsRemindersOnInvoiceDueDate',	'10,all,EmailTemplateCode',	NULL,	'facture',	50,	NULL,	NULL,	'2022-09-06 23:00:00',	NULL,	NULL,	NULL,	NULL,	'86400',	1,	0,	NULL,	0,	0,	0,	'$conf->facture->enabled',	NULL,	NULL,	NULL,	'Send an emails when the unpaid invoices reach a due date + n days = today. First param is the offset n of days, second parameter is \"all\" or a payment mode code, last parameter is the code of email template to use (an email template with EmailTemplateCode must exists. the version in the language of the thirdparty will be used in priority).',	NULL,	1),
(3,	'2022-09-12 09:52:47',	'2022-09-12 09:52:47',	'method',	'CompressSyslogs',	NULL,	'core/class/utils.class.php',	'Utils',	'compressSyslogs',	NULL,	NULL,	'syslog',	50,	NULL,	NULL,	'2022-09-12 09:52:47',	NULL,	NULL,	NULL,	NULL,	'86400',	1,	0,	NULL,	0,	0,	0,	'1',	NULL,	NULL,	NULL,	'Compress and archive log files. The number of versions to keep is defined into the setup of module. Warning: Main application cron script must be run with same account than your web server to avoid to get log files with different owner than required by web server. Another solution is to set web server Operating System group as the group of directory documents and set GROUP permission \"rws\" on this directory so log files will always have the group and permissions of the web server Operating System group.',	NULL,	1);

DROP TABLE IF EXISTS `llx_c_accounting_category`;
CREATE TABLE `llx_c_accounting_category` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `code` varchar(16) COLLATE utf8_unicode_ci NOT NULL,
  `label` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `range_account` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sens` tinyint(4) NOT NULL DEFAULT '0',
  `category_type` tinyint(4) NOT NULL DEFAULT '0',
  `formula` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `position` int(11) DEFAULT '0',
  `fk_country` int(11) DEFAULT NULL,
  `active` int(11) DEFAULT '1',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_c_accounting_category` (`code`,`entity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_c_accounting_category` (`rowid`, `entity`, `code`, `label`, `range_account`, `sens`, `category_type`, `formula`, `position`, `fk_country`, `active`) VALUES
(1,	1,	'INCOMES',	'Income of products/services',	'Example: 7xxxxx',	0,	0,	'',	10,	0,	1),
(2,	1,	'EXPENSES',	'Expenses of products/services',	'Example: 6xxxxx',	0,	0,	'',	20,	0,	1),
(3,	1,	'PROFIT',	'Balance',	'',	0,	1,	'INCOMES+EXPENSES',	30,	0,	1);

DROP TABLE IF EXISTS `llx_c_actioncomm`;
CREATE TABLE `llx_c_actioncomm` (
  `id` int(11) NOT NULL,
  `code` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'system',
  `libelle` varchar(48) COLLATE utf8_unicode_ci NOT NULL,
  `module` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `todo` tinyint(4) DEFAULT NULL,
  `color` varchar(9) COLLATE utf8_unicode_ci DEFAULT NULL,
  `picto` varchar(48) COLLATE utf8_unicode_ci DEFAULT NULL,
  `position` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_c_actioncomm` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_c_actioncomm` (`id`, `code`, `type`, `libelle`, `module`, `active`, `todo`, `color`, `picto`, `position`) VALUES
(1,	'AC_TEL',	'system',	'Phone call',	NULL,	1,	NULL,	NULL,	NULL,	2),
(2,	'AC_FAX',	'system',	'Send Fax',	NULL,	1,	NULL,	NULL,	NULL,	3),
(4,	'AC_EMAIL',	'system',	'Send Email',	NULL,	1,	NULL,	NULL,	NULL,	4),
(5,	'AC_RDV',	'system',	'Rendez-vous',	NULL,	1,	NULL,	NULL,	NULL,	1),
(6,	'AC_EMAIL_IN',	'system',	'reception Email',	NULL,	1,	NULL,	NULL,	NULL,	4),
(11,	'AC_INT',	'system',	'Intervention on site',	NULL,	1,	NULL,	NULL,	NULL,	4),
(40,	'AC_OTH_AUTO',	'systemauto',	'Other (automatically inserted events)',	NULL,	1,	NULL,	NULL,	NULL,	20),
(50,	'AC_OTH',	'systemauto',	'Other (manually inserted events)',	NULL,	1,	NULL,	NULL,	NULL,	5),
(60,	'AC_EO_ONLINECONF',	'module',	'Online/Virtual conference',	'conference@eventorganization',	1,	NULL,	NULL,	NULL,	60),
(61,	'AC_EO_INDOORCONF',	'module',	'Indoor conference',	'conference@eventorganization',	1,	NULL,	NULL,	NULL,	61),
(62,	'AC_EO_ONLINEBOOTH',	'module',	'Online/Virtual booth',	'booth@eventorganization',	1,	NULL,	NULL,	NULL,	62),
(63,	'AC_EO_INDOORBOOTH',	'module',	'Indoor booth',	'booth@eventorganization',	1,	NULL,	NULL,	NULL,	63),
(99,	'AC_ACTIVITY',	'system',	'CRM action',	NULL,	1,	NULL,	NULL,	NULL,	99);

DROP TABLE IF EXISTS `llx_c_action_trigger`;
CREATE TABLE `llx_c_action_trigger` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `elementtype` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `code` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `label` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `rang` int(11) DEFAULT '0',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_action_trigger_code` (`code`),
  KEY `idx_action_trigger_rang` (`rang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_c_action_trigger` (`rowid`, `elementtype`, `code`, `label`, `description`, `rang`) VALUES
(1,	'societe',	'COMPANY_CREATE',	'Third party created',	'Executed when a third party is created',	1),
(2,	'societe',	'COMPANY_MODIFY',	'Third party update',	'Executed when you update third party',	1),
(3,	'societe',	'COMPANY_SENTBYMAIL',	'Mails sent from third party card',	'Executed when you send email from third party card',	1),
(4,	'societe',	'COMPANY_DELETE',	'Third party deleted',	'Executed when you delete third party',	1),
(5,	'propal',	'PROPAL_VALIDATE',	'Customer proposal validated',	'Executed when a commercial proposal is validated',	2),
(6,	'propal',	'PROPAL_SENTBYMAIL',	'Commercial proposal sent by mail',	'Executed when a commercial proposal is sent by mail',	3),
(7,	'propal',	'PROPAL_CLOSE_SIGNED',	'Customer proposal closed signed',	'Executed when a customer proposal is closed signed',	2),
(8,	'propal',	'PROPAL_CLOSE_REFUSED',	'Customer proposal closed refused',	'Executed when a customer proposal is closed refused',	2),
(9,	'propal',	'PROPAL_CLASSIFY_BILLED',	'Customer proposal set billed',	'Executed when a customer proposal is set to billed',	2),
(10,	'propal',	'PROPAL_DELETE',	'Customer proposal deleted',	'Executed when a customer proposal is deleted',	2),
(11,	'commande',	'ORDER_VALIDATE',	'Customer order validate',	'Executed when a customer order is validated',	4),
(12,	'commande',	'ORDER_CLOSE',	'Customer order classify delivered',	'Executed when a customer order is set delivered',	5),
(13,	'commande',	'ORDER_CLASSIFY_BILLED',	'Customer order classify billed',	'Executed when a customer order is set to billed',	5),
(14,	'commande',	'ORDER_CANCEL',	'Customer order canceled',	'Executed when a customer order is canceled',	5),
(15,	'commande',	'ORDER_SENTBYMAIL',	'Customer order sent by mail',	'Executed when a customer order is sent by mail ',	5),
(16,	'commande',	'ORDER_DELETE',	'Customer order deleted',	'Executed when a customer order is deleted',	5),
(17,	'facture',	'BILL_VALIDATE',	'Customer invoice validated',	'Executed when a customer invoice is approved',	6),
(18,	'facture',	'BILL_PAYED',	'Customer invoice payed',	'Executed when a customer invoice is payed',	7),
(19,	'facture',	'BILL_CANCEL',	'Customer invoice canceled',	'Executed when a customer invoice is conceled',	8),
(20,	'facture',	'BILL_SENTBYMAIL',	'Customer invoice sent by mail',	'Executed when a customer invoice is sent by mail',	9),
(21,	'facture',	'BILL_UNVALIDATE',	'Customer invoice unvalidated',	'Executed when a customer invoice status set back to draft',	9),
(22,	'facture',	'BILL_DELETE',	'Customer invoice deleted',	'Executed when a customer invoice is deleted',	9),
(23,	'proposal_supplier',	'PROPOSAL_SUPPLIER_VALIDATE',	'Price request validated',	'Executed when a commercial proposal is validated',	10),
(24,	'proposal_supplier',	'PROPOSAL_SUPPLIER_SENTBYMAIL',	'Price request sent by mail',	'Executed when a commercial proposal is sent by mail',	10),
(25,	'proposal_supplier',	'PROPOSAL_SUPPLIER_CLOSE_SIGNED',	'Price request closed signed',	'Executed when a customer proposal is closed signed',	10),
(26,	'proposal_supplier',	'PROPOSAL_SUPPLIER_CLOSE_REFUSED',	'Price request closed refused',	'Executed when a customer proposal is closed refused',	10),
(27,	'proposal_supplier',	'PROPOSAL_SUPPLIER_DELETE',	'Price request deleted',	'Executed when a customer proposal delete',	10),
(28,	'order_supplier',	'ORDER_SUPPLIER_VALIDATE',	'Supplier order validated',	'Executed when a supplier order is validated',	12),
(29,	'order_supplier',	'ORDER_SUPPLIER_APPROVE',	'Supplier order request approved',	'Executed when a supplier order is approved',	13),
(30,	'order_supplier',	'ORDER_SUPPLIER_SUBMIT',	'Supplier order request submited',	'Executed when a supplier order is approved',	13),
(31,	'order_supplier',	'ORDER_SUPPLIER_RECEIVE',	'Supplier order request received',	'Executed when a supplier order is received',	13),
(32,	'order_supplier',	'ORDER_SUPPLIER_REFUSE',	'Supplier order request refused',	'Executed when a supplier order is refused',	13),
(33,	'order_supplier',	'ORDER_SUPPLIER_CANCEL',	'Supplier order request canceled',	'Executed when a supplier order is canceled',	13),
(34,	'order_supplier',	'ORDER_SUPPLIER_SENTBYMAIL',	'Supplier order sent by mail',	'Executed when a supplier order is sent by mail',	14),
(35,	'order_supplier',	'ORDER_SUPPLIER_CLASSIFY_BILLED',	'Supplier order set billed',	'Executed when a supplier order is set as billed',	14),
(36,	'order_supplier',	'ORDER_SUPPLIER_DELETE',	'Supplier order deleted',	'Executed when a supplier order is deleted',	14),
(37,	'invoice_supplier',	'BILL_SUPPLIER_VALIDATE',	'Supplier invoice validated',	'Executed when a supplier invoice is validated',	15),
(38,	'invoice_supplier',	'BILL_SUPPLIER_UNVALIDATE',	'Supplier invoice unvalidated',	'Executed when a supplier invoice status is set back to draft',	15),
(39,	'invoice_supplier',	'BILL_SUPPLIER_PAYED',	'Supplier invoice payed',	'Executed when a supplier invoice is payed',	16),
(40,	'invoice_supplier',	'BILL_SUPPLIER_SENTBYMAIL',	'Supplier invoice sent by mail',	'Executed when a supplier invoice is sent by mail',	17),
(41,	'invoice_supplier',	'BILL_SUPPLIER_CANCELED',	'Supplier invoice cancelled',	'Executed when a supplier invoice is cancelled',	17),
(42,	'invoice_supplier',	'BILL_SUPPLIER_DELETE',	'Supplier invoice deleted',	'Executed when a supplier invoice is deleted',	17),
(43,	'contrat',	'CONTRACT_VALIDATE',	'Contract validated',	'Executed when a contract is validated',	18),
(44,	'contrat',	'CONTRACT_SENTBYMAIL',	'Contract sent by mail',	'Executed when a contract is sent by mail',	18),
(45,	'contrat',	'CONTRACT_DELETE',	'Contract deleted',	'Executed when a contract is deleted',	18),
(46,	'shipping',	'SHIPPING_VALIDATE',	'Shipping validated',	'Executed when a shipping is validated',	20),
(47,	'shipping',	'SHIPPING_SENTBYMAIL',	'Shipping sent by mail',	'Executed when a shipping is sent by mail',	21),
(48,	'shipping',	'SHIPPING_DELETE',	'Shipping sent is deleted',	'Executed when a shipping is deleted',	21),
(49,	'reception',	'RECEPTION_VALIDATE',	'Reception validated',	'Executed when a reception is validated',	22),
(50,	'reception',	'RECEPTION_SENTBYMAIL',	'Reception sent by mail',	'Executed when a reception is sent by mail',	22),
(51,	'member',	'MEMBER_VALIDATE',	'Member validated',	'Executed when a member is validated',	22),
(52,	'member',	'MEMBER_SENTBYMAIL',	'Mails sent from member card',	'Executed when you send email from member card',	23),
(53,	'member',	'MEMBER_SUBSCRIPTION_CREATE',	'Member subscribtion recorded',	'Executed when a member subscribtion is deleted',	24),
(54,	'member',	'MEMBER_SUBSCRIPTION_MODIFY',	'Member subscribtion modified',	'Executed when a member subscribtion is modified',	24),
(55,	'member',	'MEMBER_SUBSCRIPTION_DELETE',	'Member subscribtion deleted',	'Executed when a member subscribtion is deleted',	24),
(56,	'member',	'MEMBER_RESILIATE',	'Member resiliated',	'Executed when a member is resiliated',	25),
(57,	'member',	'MEMBER_DELETE',	'Member deleted',	'Executed when a member is deleted',	26),
(58,	'member',	'MEMBER_EXCLUDE',	'Member excluded',	'Executed when a member is excluded',	27),
(59,	'ficheinter',	'FICHINTER_VALIDATE',	'Intervention validated',	'Executed when a intervention is validated',	30),
(60,	'ficheinter',	'FICHINTER_CLASSIFY_BILLED',	'Intervention set billed',	'Executed when a intervention is set to billed (when option FICHINTER_CLASSIFY_BILLED is set)',	32),
(61,	'ficheinter',	'FICHINTER_CLASSIFY_UNBILLED',	'Intervention set unbilled',	'Executed when a intervention is set to unbilled (when option FICHINTER_CLASSIFY_BILLED is set)',	33),
(62,	'ficheinter',	'FICHINTER_REOPEN',	'Intervention opened',	'Executed when a intervention is re-opened',	34),
(63,	'ficheinter',	'FICHINTER_SENTBYMAIL',	'Intervention sent by mail',	'Executed when a intervention is sent by mail',	35),
(64,	'ficheinter',	'FICHINTER_DELETE',	'Intervention is deleted',	'Executed when a intervention is deleted',	35),
(65,	'product',	'PRODUCT_CREATE',	'Product or service created',	'Executed when a product or sevice is created',	40),
(66,	'product',	'PRODUCT_DELETE',	'Product or service deleted',	'Executed when a product or sevice is deleted',	42),
(67,	'expensereport',	'EXPENSE_REPORT_CREATE',	'Expense report created',	'Executed when an expense report is created',	201),
(68,	'expensereport',	'EXPENSE_REPORT_VALIDATE',	'Expense report validated',	'Executed when an expense report is validated',	202),
(69,	'expensereport',	'EXPENSE_REPORT_APPROVE',	'Expense report approved',	'Executed when an expense report is approved',	203),
(70,	'expensereport',	'EXPENSE_REPORT_PAID',	'Expense report billed',	'Executed when an expense report is set as billed',	204),
(71,	'expensereport',	'EXPENSE_REPORT_DELETE',	'Expense report deleted',	'Executed when an expense report is deleted',	205),
(72,	'expensereport',	'HOLIDAY_VALIDATE',	'Expense report validated',	'Executed when an expense report is validated',	211),
(73,	'expensereport',	'HOLIDAY_APPROVE',	'Expense report approved',	'Executed when an expense report is approved',	212),
(74,	'project',	'PROJECT_VALIDATE',	'Project validation',	'Executed when a project is validated',	141),
(75,	'project',	'PROJECT_DELETE',	'Project deleted',	'Executed when a project is deleted',	143),
(76,	'ticket',	'TICKET_CREATE',	'Ticket created',	'Executed when a ticket is created',	161),
(77,	'ticket',	'TICKET_MODIFY',	'Ticket modified',	'Executed when a ticket is modified',	163),
(78,	'ticket',	'TICKET_ASSIGNED',	'Ticket assigned',	'Executed when a ticket is modified',	164),
(79,	'ticket',	'TICKET_CLOSE',	'Ticket closed',	'Executed when a ticket is closed',	165),
(80,	'ticket',	'TICKET_SENTBYMAIL',	'Ticket message sent by email',	'Executed when a message is sent from the ticket record',	166),
(81,	'ticket',	'TICKET_DELETE',	'Ticket deleted',	'Executed when a ticket is deleted',	167),
(82,	'user',	'USER_SENTBYMAIL',	'Email sent',	'Executed when an email is sent from user card',	300),
(83,	'user',	'USER_CREATE',	'User created',	'Executed when a user is created',	301),
(84,	'user',	'USER_MODIFY',	'User update',	'Executed when a user is updated',	302),
(85,	'user',	'USER_DELETE',	'User update',	'Executed when a user is deleted',	303),
(86,	'user',	'USER_NEW_PASSWORD',	'User update',	'Executed when a user is change password',	304),
(87,	'user',	'USER_ENABLEDISABLE',	'User update',	'Executed when a user is enable or disable',	305),
(88,	'product',	'PRODUCT_MODIFY',	'Product or service modified',	'Executed when a product or sevice is modified',	41),
(89,	'member',	'MEMBER_MODIFY',	'Member modified',	'Executed when a member is modified',	23),
(90,	'ficheinter',	'FICHINTER_MODIFY',	'Intervention modified',	'Executed when a intervention is modified',	19),
(91,	'project',	'PROJECT_CREATE',	'Project creation',	'Executed when a project is created',	140),
(92,	'project',	'PROJECT_MODIFY',	'Project modified',	'Executed when a project is modified',	142),
(93,	'bom',	'BOM_VALIDATE',	'BOM validated',	'Executed when a BOM is validated',	650),
(94,	'bom',	'BOM_UNVALIDATE',	'BOM unvalidated',	'Executed when a BOM is unvalidated',	651),
(95,	'bom',	'BOM_CLOSE',	'BOM disabled',	'Executed when a BOM is disabled',	652),
(96,	'bom',	'BOM_REOPEN',	'BOM reopen',	'Executed when a BOM is re-open',	653),
(97,	'bom',	'BOM_DELETE',	'BOM deleted',	'Executed when a BOM deleted',	654),
(98,	'mrp',	'MRP_MO_VALIDATE',	'MO validated',	'Executed when a MO is validated',	660),
(99,	'mrp',	'MRP_MO_PRODUCED',	'MO produced',	'Executed when a MO is produced',	661),
(100,	'mrp',	'MRP_MO_DELETE',	'MO deleted',	'Executed when a MO is deleted',	662),
(101,	'mrp',	'MRP_MO_CANCEL',	'MO canceled',	'Executed when a MO is canceled',	663),
(102,	'contact',	'CONTACT_CREATE',	'Contact address created',	'Executed when a contact is created',	50),
(103,	'contact',	'CONTACT_MODIFY',	'Contact address update',	'Executed when a contact is updated',	51),
(104,	'contact',	'CONTACT_SENTBYMAIL',	'Mails sent from third party card',	'Executed when you send email from contact address record',	52),
(105,	'contact',	'CONTACT_DELETE',	'Contact address deleted',	'Executed when a contact is deleted',	53),
(106,	'recruitment',	'RECRUITMENTJOBPOSITION_CREATE',	'Job created',	'Executed when a job is created',	7500),
(107,	'recruitment',	'RECRUITMENTJOBPOSITION_MODIFY',	'Job modified',	'Executed when a job is modified',	7502),
(108,	'recruitment',	'RECRUITMENTJOBPOSITION_SENTBYMAIL',	'Mails sent from job record',	'Executed when you send email from job record',	7504),
(109,	'recruitment',	'RECRUITMENTJOBPOSITION_DELETE',	'Job deleted',	'Executed when a job is deleted',	7506),
(110,	'recruitment',	'RECRUITMENTCANDIDATURE_CREATE',	'Candidature created',	'Executed when a candidature is created',	7510),
(111,	'recruitment',	'RECRUITMENTCANDIDATURE_MODIFY',	'Candidature modified',	'Executed when a candidature is modified',	7512),
(112,	'recruitment',	'RECRUITMENTCANDIDATURE_SENTBYMAIL',	'Mails sent from candidature record',	'Executed when you send email from candidature record',	7514),
(113,	'recruitment',	'RECRUITMENTCANDIDATURE_DELETE',	'Candidature deleted',	'Executed when a candidature is deleted',	7516),
(114,	'project',	'TASK_CREATE',	'Task created',	'Executed when a project task is created',	150),
(115,	'project',	'TASK_MODIFY',	'Task modified',	'Executed when a project task is modified',	151),
(116,	'project',	'TASK_DELETE',	'Task deleted',	'Executed when a project task is deleted',	152),
(117,	'agenda',	'ACTION_CREATE',	'Action added',	'Executed when an action is added to the agenda',	700),
(118,	'holiday',	'HOLIDAY_CREATE',	'Holiday created',	'Executed when a holiday is created',	800),
(119,	'holiday',	'HOLIDAY_MODIFY',	'Holiday modified',	'Executed when a holiday is modified',	801),
(122,	'holiday',	'HOLIDAY_CANCEL',	'Holiday canceled',	'Executed when a holiday is canceled',	802),
(123,	'holiday',	'HOLIDAY_DELETE',	'Holiday deleted',	'Executed when a holiday is deleted',	804);

DROP TABLE IF EXISTS `llx_c_availability`;
CREATE TABLE `llx_c_availability` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `label` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `position` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_c_availability` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_c_availability` (`rowid`, `code`, `label`, `active`, `position`) VALUES
(1,	'AV_NOW',	'Immediate',	1,	10),
(2,	'AV_1W',	'1 week',	1,	20),
(3,	'AV_2W',	'2 weeks',	1,	30),
(4,	'AV_3W',	'3 weeks',	1,	40),
(5,	'AV_4W',	'4 weeks',	1,	50);

DROP TABLE IF EXISTS `llx_c_barcode_type`;
CREATE TABLE `llx_c_barcode_type` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(16) COLLATE utf8_unicode_ci NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `libelle` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `coder` varchar(16) COLLATE utf8_unicode_ci NOT NULL,
  `example` varchar(16) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_c_barcode_type` (`code`,`entity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_c_chargesociales`;
CREATE TABLE `llx_c_chargesociales` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `libelle` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deductible` smallint(6) NOT NULL DEFAULT '0',
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `code` varchar(12) COLLATE utf8_unicode_ci NOT NULL,
  `accountancy_code` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_pays` int(11) NOT NULL DEFAULT '1',
  `module` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_c_chargesociales` (`id`, `libelle`, `deductible`, `active`, `code`, `accountancy_code`, `fk_pays`, `module`) VALUES
(1,	'Securite sociale (URSSAF / MSA)',	1,	1,	'TAXSECU',	NULL,	1,	NULL),
(2,	'Securite sociale des ind??pendants (URSSAF)',	1,	1,	'TAXSSI',	NULL,	1,	NULL),
(10,	'Taxe apprentissage',	1,	1,	'TAXAPP',	NULL,	1,	NULL),
(11,	'Formation professionnelle continue',	1,	1,	'TAXFPC',	NULL,	1,	NULL),
(12,	'Cotisation fonciere des entreprises (CFE)',	1,	1,	'TAXCFE',	NULL,	1,	NULL),
(13,	'Cotisation sur la valeur ajoutee des entreprises (CVAE)',	1,	1,	'TAXCVAE',	NULL,	1,	NULL),
(20,	'Taxe fonciere',	1,	1,	'TAXFON',	NULL,	1,	NULL),
(25,	'Prelevement ?? la source (PAS)',	0,	1,	'TAXPAS',	NULL,	1,	NULL),
(30,	'Prevoyance',	1,	1,	'TAXPREV',	NULL,	1,	NULL),
(40,	'Mutuelle',	1,	1,	'TAXMUT',	NULL,	1,	NULL),
(50,	'Retraite',	1,	1,	'TAXRET',	NULL,	1,	NULL),
(60,	'Taxe sur vehicule societe (TVS)',	0,	1,	'TAXTVS',	NULL,	1,	NULL),
(70,	'imp??ts sur les soci??t??s (IS)',	0,	1,	'TAXIS',	NULL,	1,	NULL),
(201,	'ONSS',	1,	1,	'TAXBEONSS',	NULL,	2,	NULL),
(210,	'Precompte professionnel',	1,	1,	'TAXBEPREPRO',	NULL,	2,	NULL),
(220,	'Prime existence',	1,	1,	'TAXBEPRIEXI',	NULL,	2,	NULL),
(230,	'Precompte immobilier',	1,	1,	'TAXBEPREIMMO',	NULL,	2,	NULL),
(4101,	'Krankenversicherung',	1,	1,	'TAXATKV',	NULL,	41,	NULL),
(4102,	'Unfallversicherung',	1,	1,	'TAXATUV',	NULL,	41,	NULL),
(4103,	'Pensionsversicherung',	1,	1,	'TAXATPV',	NULL,	41,	NULL),
(4104,	'Arbeitslosenversicherung',	1,	1,	'TAXATAV',	NULL,	41,	NULL),
(4105,	'Insolvenzentgeltsicherungsfond',	1,	1,	'TAXATIESG',	NULL,	41,	NULL),
(4106,	'Wohnbauf??rderung',	1,	1,	'TAXATWF',	NULL,	41,	NULL),
(4107,	'Arbeiterkammerumlage',	1,	1,	'TAXATAK',	NULL,	41,	NULL),
(4108,	'Mitarbeitervorsorgekasse',	1,	1,	'TAXATMVK',	NULL,	41,	NULL),
(4109,	'Familienlastenausgleichsfond',	1,	1,	'TAXATFLAF',	NULL,	41,	NULL);

DROP TABLE IF EXISTS `llx_c_civility`;
CREATE TABLE `llx_c_civility` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(6) COLLATE utf8_unicode_ci NOT NULL,
  `label` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `module` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_c_civility` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_c_civility` (`rowid`, `code`, `label`, `active`, `module`) VALUES
(1,	'MME',	'Madame',	1,	NULL),
(3,	'MR',	'Monsieur',	1,	NULL),
(5,	'MLE',	'Mademoiselle',	1,	NULL),
(7,	'MTRE',	'Ma??tre',	1,	NULL),
(8,	'DR',	'Docteur',	1,	NULL);

DROP TABLE IF EXISTS `llx_c_country`;
CREATE TABLE `llx_c_country` (
  `rowid` int(11) NOT NULL,
  `code` varchar(2) COLLATE utf8_unicode_ci NOT NULL,
  `code_iso` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `label` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `eec` int(11) DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `favorite` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `idx_c_country_code` (`code`),
  UNIQUE KEY `idx_c_country_label` (`label`),
  UNIQUE KEY `idx_c_country_code_iso` (`code_iso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_c_country` (`rowid`, `code`, `code_iso`, `label`, `eec`, `active`, `favorite`) VALUES
(0,	'',	NULL,	'-',	NULL,	1,	1),
(1,	'FR',	'FRA',	'France',	1,	1,	0),
(2,	'BE',	'BEL',	'Belgium',	1,	1,	0),
(3,	'IT',	'ITA',	'Italy',	1,	1,	0),
(4,	'ES',	'ESP',	'Spain',	1,	1,	0),
(5,	'DE',	'DEU',	'Germany',	1,	1,	0),
(6,	'CH',	'CHE',	'Switzerland',	NULL,	1,	0),
(7,	'GB',	'GBR',	'United Kingdom',	NULL,	1,	0),
(8,	'IE',	'IRL',	'Ireland',	1,	1,	0),
(9,	'CN',	'CHN',	'China',	NULL,	1,	0),
(10,	'TN',	'TUN',	'Tunisia',	NULL,	1,	0),
(11,	'US',	'USA',	'United States',	NULL,	1,	0),
(12,	'MA',	'MAR',	'Morocco',	NULL,	1,	0),
(13,	'DZ',	'DZA',	'Algeria',	NULL,	1,	0),
(14,	'CA',	'CAN',	'Canada',	NULL,	1,	0),
(15,	'TG',	'TGO',	'Togo',	NULL,	1,	0),
(16,	'GA',	'GAB',	'Gabon',	NULL,	1,	0),
(17,	'NL',	'NLD',	'Netherlands',	1,	1,	0),
(18,	'HU',	'HUN',	'Hungary',	1,	1,	0),
(19,	'RU',	'RUS',	'Russia',	NULL,	1,	0),
(20,	'SE',	'SWE',	'Sweden',	1,	1,	0),
(21,	'CI',	'CIV',	'C??te d\'Ivoire',	NULL,	1,	0),
(22,	'SN',	'SEN',	'Senegal',	NULL,	1,	0),
(23,	'AR',	'ARG',	'Argentina',	NULL,	1,	0),
(24,	'CM',	'CMR',	'Cameroun',	NULL,	1,	0),
(25,	'PT',	'PRT',	'Portugal',	1,	1,	0),
(26,	'SA',	'SAU',	'Saudi Arabia',	NULL,	1,	0),
(27,	'MC',	'MCO',	'Monaco',	1,	1,	0),
(28,	'AU',	'AUS',	'Australia',	NULL,	1,	0),
(29,	'SG',	'SGP',	'Singapore',	NULL,	1,	0),
(30,	'AF',	'AFG',	'Afghanistan',	NULL,	1,	0),
(31,	'AX',	'ALA',	'??land Island',	NULL,	1,	0),
(32,	'AL',	'ALB',	'Albania',	NULL,	1,	0),
(33,	'AS',	'ASM',	'American Samoa',	NULL,	1,	0),
(34,	'AD',	'AND',	'Andorra',	NULL,	1,	0),
(35,	'AO',	'AGO',	'Angola',	NULL,	1,	0),
(36,	'AI',	'AIA',	'Anguilla',	NULL,	1,	0),
(37,	'AQ',	'ATA',	'Antarctica',	NULL,	1,	0),
(38,	'AG',	'ATG',	'Antigua and Barbuda',	NULL,	1,	0),
(39,	'AM',	'ARM',	'Armenia',	NULL,	1,	0),
(40,	'AW',	'ABW',	'Aruba',	NULL,	1,	0),
(41,	'AT',	'AUT',	'Austria',	1,	1,	0),
(42,	'AZ',	'AZE',	'Azerbaijan',	NULL,	1,	0),
(43,	'BS',	'BHS',	'Bahamas',	NULL,	1,	0),
(44,	'BH',	'BHR',	'Bahre??n',	NULL,	1,	0),
(45,	'BD',	'BGD',	'Bangladesh',	NULL,	1,	0),
(46,	'BB',	'BRB',	'Barbade',	NULL,	1,	0),
(47,	'BY',	'BLR',	'Belarus',	NULL,	1,	0),
(48,	'BZ',	'BLZ',	'Belize',	NULL,	1,	0),
(49,	'BJ',	'BEN',	'B??nin',	NULL,	1,	0),
(50,	'BM',	'BMU',	'Bermudes',	NULL,	1,	0),
(51,	'BT',	'BTN',	'Bhoutan',	NULL,	1,	0),
(52,	'BO',	'BOL',	'Bolivie',	NULL,	1,	0),
(53,	'BA',	'BIH',	'Bosnie-Herz??govine',	NULL,	1,	0),
(54,	'BW',	'BWA',	'Botswana',	NULL,	1,	0),
(55,	'BV',	'BVT',	'Ile Bouvet',	NULL,	1,	0),
(56,	'BR',	'BRA',	'Brazil',	NULL,	1,	0),
(57,	'IO',	'IOT',	'Territoire britannique de l\'Oc??an Indien',	NULL,	1,	0),
(58,	'BN',	'BRN',	'Brunei',	NULL,	1,	0),
(59,	'BG',	'BGR',	'Bulgarie',	1,	1,	0),
(60,	'BF',	'BFA',	'Burkina Faso',	NULL,	1,	0),
(61,	'BI',	'BDI',	'Burundi',	NULL,	1,	0),
(62,	'KH',	'KHM',	'Cambodge',	NULL,	1,	0),
(63,	'CV',	'CPV',	'Cap-Vert',	NULL,	1,	0),
(64,	'KY',	'CYM',	'Iles Cayman',	NULL,	1,	0),
(65,	'CF',	'CAF',	'R??publique centrafricaine',	NULL,	1,	0),
(66,	'TD',	'TCD',	'Tchad',	NULL,	1,	0),
(67,	'CL',	'CHL',	'Chili',	NULL,	1,	0),
(68,	'CX',	'CXR',	'Ile Christmas',	NULL,	1,	0),
(69,	'CC',	'CCK',	'Iles des Cocos (Keeling)',	NULL,	1,	0),
(70,	'CO',	'COL',	'Colombie',	NULL,	1,	0),
(71,	'KM',	'COM',	'Comores',	NULL,	1,	0),
(72,	'CG',	'COG',	'Congo',	NULL,	1,	0),
(73,	'CD',	'COD',	'R??publique d??mocratique du Congo',	NULL,	1,	0),
(74,	'CK',	'COK',	'Iles Cook',	NULL,	1,	0),
(75,	'CR',	'CRI',	'Costa Rica',	NULL,	1,	0),
(76,	'HR',	'HRV',	'Croatie',	1,	1,	0),
(77,	'CU',	'CUB',	'Cuba',	NULL,	1,	0),
(78,	'CY',	'CYP',	'Cyprus',	1,	1,	0),
(79,	'CZ',	'CZE',	'Czech Republic',	1,	1,	0),
(80,	'DK',	'DNK',	'Denmark',	1,	1,	0),
(81,	'DJ',	'DJI',	'Djibouti',	NULL,	1,	0),
(82,	'DM',	'DMA',	'Dominica',	NULL,	1,	0),
(83,	'DO',	'DOM',	'Dominican Republic',	NULL,	1,	0),
(84,	'EC',	'ECU',	'Republic of Ecuador',	NULL,	1,	0),
(85,	'EG',	'EGY',	'Egypt',	NULL,	1,	0),
(86,	'SV',	'SLV',	'El Salvador',	NULL,	1,	0),
(87,	'GQ',	'GNQ',	'Equatorial Guinea',	NULL,	1,	0),
(88,	'ER',	'ERI',	'Eritrea',	NULL,	1,	0),
(89,	'EE',	'EST',	'Estonia',	1,	1,	0),
(90,	'ET',	'ETH',	'Ethiopia',	NULL,	1,	0),
(91,	'FK',	'FLK',	'Falkland Islands',	NULL,	1,	0),
(92,	'FO',	'FRO',	'Faroe Islands',	NULL,	1,	0),
(93,	'FJ',	'FJI',	'Fidji Islands',	NULL,	1,	0),
(94,	'FI',	'FIN',	'Finland',	1,	1,	0),
(95,	'GF',	'GUF',	'French Guiana',	NULL,	1,	0),
(96,	'PF',	'PYF',	'French Polynesia',	NULL,	1,	0),
(97,	'TF',	'ATF',	'Terres australes fran??aises',	NULL,	1,	0),
(98,	'GM',	'GMB',	'Gambie',	NULL,	1,	0),
(99,	'GE',	'GEO',	'Georgia',	NULL,	1,	0),
(100,	'GH',	'GHA',	'Ghana',	NULL,	1,	0),
(101,	'GI',	'GIB',	'Gibraltar',	NULL,	1,	0),
(102,	'GR',	'GRC',	'Greece',	1,	1,	0),
(103,	'GL',	'GRL',	'Groenland',	NULL,	1,	0),
(104,	'GD',	'GRD',	'Grenade',	NULL,	1,	0),
(106,	'GU',	'GUM',	'Guam',	NULL,	1,	0),
(107,	'GT',	'GTM',	'Guatemala',	NULL,	1,	0),
(108,	'GN',	'GIN',	'Guinea',	NULL,	1,	0),
(109,	'GW',	'GNB',	'Guinea-Bissao',	NULL,	1,	0),
(111,	'HT',	'HTI',	'Haiti',	NULL,	1,	0),
(112,	'HM',	'HMD',	'Iles Heard et McDonald',	NULL,	1,	0),
(113,	'VA',	'VAT',	'Saint-Si??ge (Vatican)',	NULL,	1,	0),
(114,	'HN',	'HND',	'Honduras',	NULL,	1,	0),
(115,	'HK',	'HKG',	'Hong Kong',	NULL,	1,	0),
(116,	'IS',	'ISL',	'Islande',	NULL,	1,	0),
(117,	'IN',	'IND',	'India',	NULL,	1,	0),
(118,	'ID',	'IDN',	'Indon??sie',	NULL,	1,	0),
(119,	'IR',	'IRN',	'Iran',	NULL,	1,	0),
(120,	'IQ',	'IRQ',	'Iraq',	NULL,	1,	0),
(121,	'IL',	'ISR',	'Israel',	NULL,	1,	0),
(122,	'JM',	'JAM',	'Jama??que',	NULL,	1,	0),
(123,	'JP',	'JPN',	'Japon',	NULL,	1,	0),
(124,	'JO',	'JOR',	'Jordanie',	NULL,	1,	0),
(125,	'KZ',	'KAZ',	'Kazakhstan',	NULL,	1,	0),
(126,	'KE',	'KEN',	'Kenya',	NULL,	1,	0),
(127,	'KI',	'KIR',	'Kiribati',	NULL,	1,	0),
(128,	'KP',	'PRK',	'North Corea',	NULL,	1,	0),
(129,	'KR',	'KOR',	'South Corea',	NULL,	1,	0),
(130,	'KW',	'KWT',	'Kowe??t',	NULL,	1,	0),
(131,	'KG',	'KGZ',	'Kirghizistan',	NULL,	1,	0),
(132,	'LA',	'LAO',	'Laos',	NULL,	1,	0),
(133,	'LV',	'LVA',	'Lettonie',	1,	1,	0),
(134,	'LB',	'LBN',	'Liban',	NULL,	1,	0),
(135,	'LS',	'LSO',	'Lesotho',	NULL,	1,	0),
(136,	'LR',	'LBR',	'Liberia',	NULL,	1,	0),
(137,	'LY',	'LBY',	'Libye',	NULL,	1,	0),
(138,	'LI',	'LIE',	'Liechtenstein',	NULL,	1,	0),
(139,	'LT',	'LTU',	'Lituanie',	1,	1,	0),
(140,	'LU',	'LUX',	'Luxembourg',	1,	1,	0),
(141,	'MO',	'MAC',	'Macao',	NULL,	1,	0),
(142,	'MK',	'MKD',	'ex-R??publique yougoslave de Mac??doine',	NULL,	1,	0),
(143,	'MG',	'MDG',	'Madagascar',	NULL,	1,	0),
(144,	'MW',	'MWI',	'Malawi',	NULL,	1,	0),
(145,	'MY',	'MYS',	'Malaisie',	NULL,	1,	0),
(146,	'MV',	'MDV',	'Maldives',	NULL,	1,	0),
(147,	'ML',	'MLI',	'Mali',	NULL,	1,	0),
(148,	'MT',	'MLT',	'Malte',	1,	1,	0),
(149,	'MH',	'MHL',	'Iles Marshall',	NULL,	1,	0),
(151,	'MR',	'MRT',	'Mauritanie',	NULL,	1,	0),
(152,	'MU',	'MUS',	'Maurice',	NULL,	1,	0),
(153,	'YT',	'MYT',	'Mayotte',	NULL,	1,	0),
(154,	'MX',	'MEX',	'Mexique',	NULL,	1,	0),
(155,	'FM',	'FSM',	'Micron??sie',	NULL,	1,	0),
(156,	'MD',	'MDA',	'Moldavie',	NULL,	1,	0),
(157,	'MN',	'MNG',	'Mongolie',	NULL,	1,	0),
(158,	'MS',	'MSR',	'Monserrat',	NULL,	1,	0),
(159,	'MZ',	'MOZ',	'Mozambique',	NULL,	1,	0),
(160,	'MM',	'MMR',	'Birmanie (Myanmar)',	NULL,	1,	0),
(161,	'NA',	'NAM',	'Namibie',	NULL,	1,	0),
(162,	'NR',	'NRU',	'Nauru',	NULL,	1,	0),
(163,	'NP',	'NPL',	'N??pal',	NULL,	1,	0),
(165,	'NC',	'NCL',	'New Caledonia',	NULL,	1,	0),
(166,	'NZ',	'NZL',	'New Zealand',	NULL,	1,	0),
(167,	'NI',	'NIC',	'Nicaragua',	NULL,	1,	0),
(168,	'NE',	'NER',	'Niger',	NULL,	1,	0),
(169,	'NG',	'NGA',	'Nigeria',	NULL,	1,	0),
(170,	'NU',	'NIU',	'Niue',	NULL,	1,	0),
(171,	'NF',	'NFK',	'Norfolk Island',	NULL,	1,	0),
(172,	'MP',	'MNP',	'Northern Mariana Islands',	NULL,	1,	0),
(173,	'NO',	'NOR',	'Norway',	NULL,	1,	0),
(174,	'OM',	'OMN',	'Oman',	NULL,	1,	0),
(175,	'PK',	'PAK',	'Pakistan',	NULL,	1,	0),
(176,	'PW',	'PLW',	'Palau',	NULL,	1,	0),
(177,	'PS',	'PSE',	'Palestinian territories',	NULL,	1,	0),
(178,	'PA',	'PAN',	'Panama',	NULL,	1,	0),
(179,	'PG',	'PNG',	'Papua New Guinea',	NULL,	1,	0),
(180,	'PY',	'PRY',	'Paraguay',	NULL,	1,	0),
(181,	'PE',	'PER',	'Peru',	NULL,	1,	0),
(182,	'PH',	'PHL',	'Philippines',	NULL,	1,	0),
(183,	'PN',	'PCN',	'Pitcairn Islands',	NULL,	1,	0),
(184,	'PL',	'POL',	'Pologne',	1,	1,	0),
(185,	'PR',	'PRI',	'Puerto Rico',	NULL,	1,	0),
(186,	'QA',	'QAT',	'Qatar',	NULL,	1,	0),
(188,	'RO',	'ROU',	'Romania',	1,	1,	0),
(189,	'RW',	'RWA',	'Rwanda',	NULL,	1,	0),
(190,	'SH',	'SHN',	'Saint Helena',	NULL,	1,	0),
(191,	'KN',	'KNA',	'Saint Kitts and Nevis',	NULL,	1,	0),
(192,	'LC',	'LCA',	'Saint Lucia',	NULL,	1,	0),
(193,	'PM',	'SPM',	'Saint Pierre and Miquelon',	NULL,	1,	0),
(194,	'VC',	'VCT',	'Saint Vincent and the Grenadines',	NULL,	1,	0),
(195,	'WS',	'WSM',	'Samoa',	NULL,	1,	0),
(196,	'SM',	'SMR',	'San Marino ',	NULL,	1,	0),
(197,	'ST',	'STP',	'Saint Thomas and Prince',	NULL,	1,	0),
(198,	'RS',	'SRB',	'Serbia',	NULL,	1,	0),
(199,	'SC',	'SYC',	'Seychelles',	NULL,	1,	0),
(200,	'SL',	'SLE',	'Sierra Leone',	NULL,	1,	0),
(201,	'SK',	'SVK',	'Slovakia',	1,	1,	0),
(202,	'SI',	'SVN',	'Slovenia',	1,	1,	0),
(203,	'SB',	'SLB',	'Solomon Islands',	NULL,	1,	0),
(204,	'SO',	'SOM',	'Somalia',	NULL,	1,	0),
(205,	'ZA',	'ZAF',	'South Africa',	NULL,	1,	0),
(206,	'GS',	'SGS',	'South Georgia and the South Sandwich Islands ',	NULL,	1,	0),
(207,	'LK',	'LKA',	'Sri Lanka',	NULL,	1,	0),
(208,	'SD',	'SDN',	'Sudan',	NULL,	1,	0),
(209,	'SR',	'SUR',	'Suriname',	NULL,	1,	0),
(210,	'SJ',	'SJM',	'Svalbard and Jan Mayen',	NULL,	1,	0),
(211,	'SZ',	'SWZ',	'Swaziland / Eswatini',	NULL,	1,	0),
(212,	'SY',	'SYR',	'Syria',	NULL,	1,	0),
(213,	'TW',	'TWN',	'Taiwan',	NULL,	1,	0),
(214,	'TJ',	'TJK',	'Tajikistan',	NULL,	1,	0),
(215,	'TZ',	'TZA',	'Tanzania',	NULL,	1,	0),
(216,	'TH',	'THA',	'Thailand',	NULL,	1,	0),
(217,	'TL',	'TLS',	'Timor-Leste',	NULL,	1,	0),
(218,	'TK',	'TKL',	'Tokelau',	NULL,	1,	0),
(219,	'TO',	'TON',	'Tonga',	NULL,	1,	0),
(220,	'TT',	'TTO',	'Trinidad and Tobago',	NULL,	1,	0),
(221,	'TR',	'TUR',	'Turkey',	NULL,	1,	0),
(222,	'TM',	'TKM',	'Turkmenistan',	NULL,	1,	0),
(223,	'TC',	'TCA',	'Turks and Caicos Islands',	NULL,	1,	0),
(224,	'TV',	'TUV',	'Tuvalu',	NULL,	1,	0),
(225,	'UG',	'UGA',	'Uganda',	NULL,	1,	0),
(226,	'UA',	'UKR',	'Ukraine',	NULL,	1,	0),
(227,	'AE',	'ARE',	'United Arab Emirates',	NULL,	1,	0),
(228,	'UM',	'UMI',	'United States Minor Outlying Islands',	NULL,	1,	0),
(229,	'UY',	'URY',	'Uruguay',	NULL,	1,	0),
(230,	'UZ',	'UZB',	'Uzbekistan',	NULL,	1,	0),
(231,	'VU',	'VUT',	'Vanuatu',	NULL,	1,	0),
(232,	'VE',	'VEN',	'Venezuela',	NULL,	1,	0),
(233,	'VN',	'VNM',	'Vietnam',	NULL,	1,	0),
(234,	'VG',	'VGB',	'British Virgin Islands',	NULL,	1,	0),
(235,	'VI',	'VIR',	'Virgin Islands of the United States',	NULL,	1,	0),
(236,	'WF',	'WLF',	'Wallis and Futuna',	NULL,	1,	0),
(237,	'EH',	'ESH',	'Western Sahara',	NULL,	1,	0),
(238,	'YE',	'YEM',	'Yemen',	NULL,	1,	0),
(239,	'ZM',	'ZMB',	'Zambia',	NULL,	1,	0),
(240,	'ZW',	'ZWE',	'Zimbabwe',	NULL,	1,	0),
(241,	'GG',	'GGY',	'Guernsey',	NULL,	1,	0),
(242,	'IM',	'IMN',	'Isle of Man',	NULL,	1,	0),
(243,	'JE',	'JEY',	'Jersey',	NULL,	1,	0),
(244,	'ME',	'MNE',	'Montenegro',	NULL,	1,	0),
(245,	'BL',	'BLM',	'Saint-Barth??lemy',	NULL,	1,	0),
(246,	'MF',	'MAF',	'Saint-Martin',	NULL,	1,	0),
(247,	'XK',	'XKX',	'Kosovo',	NULL,	1,	0),
(300,	'CW',	'CUW',	'Cura??ao',	NULL,	1,	0),
(301,	'SX',	'SXM',	'Sint Maarten',	NULL,	1,	0);

DROP TABLE IF EXISTS `llx_c_currencies`;
CREATE TABLE `llx_c_currencies` (
  `code_iso` varchar(3) COLLATE utf8_unicode_ci NOT NULL,
  `label` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `unicode` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`code_iso`),
  UNIQUE KEY `uk_c_currencies_code_iso` (`code_iso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_c_currencies` (`code_iso`, `label`, `unicode`, `active`) VALUES
('AED',	'United Arab Emirates Dirham',	NULL,	1),
('AFN',	'Afghanistan Afghani',	'[1547]',	1),
('ALL',	'Albania Lek',	'[76,101,107]',	1),
('ANG',	'Netherlands Antilles Guilder',	'[402]',	1),
('AOA',	'Angola Kwanza',	NULL,	1),
('ARP',	'Pesos argentins',	NULL,	0),
('ARS',	'Argentino Peso',	'[36]',	1),
('ATS',	'Shiliing autrichiens',	NULL,	0),
('AUD',	'Australia Dollar',	'[36]',	1),
('AWG',	'Aruba Guilder',	'[402]',	1),
('AZN',	'Azerbaijan New Manat',	'[1084,1072,1085]',	1),
('BAM',	'Bosnia and Herzegovina Convertible Marka',	'[75,77]',	1),
('BBD',	'Barbados Dollar',	'[36]',	1),
('BDT',	'Bangladeshi Taka',	'[2547]',	1),
('BEF',	'Francs belges',	NULL,	0),
('BGN',	'Bulgaria Lev',	'[1083,1074]',	1),
('BHD',	'Bahrain',	NULL,	1),
('BMD',	'Bermuda Dollar',	'[36]',	1),
('BND',	'Brunei Darussalam Dollar',	'[36]',	1),
('BOB',	'Bolivia Boliviano',	'[66,115]',	1),
('BRL',	'Brazil Real',	'[82,36]',	1),
('BSD',	'Bahamas Dollar',	'[36]',	1),
('BWP',	'Botswana Pula',	'[80]',	1),
('BYR',	'Belarus Ruble',	'[112,46]',	1),
('BZD',	'Belize Dollar',	'[66,90,36]',	1),
('CAD',	'Canada Dollar',	'[36]',	1),
('CHF',	'Switzerland Franc',	'[67,72,70]',	1),
('CLP',	'Chile Peso',	'[36]',	1),
('CNY',	'China Yuan Renminbi',	'[165]',	1),
('COP',	'Colombia Peso',	'[36]',	1),
('CRC',	'Costa Rica Colon',	'[8353]',	1),
('CUP',	'Cuba Peso',	'[8369]',	1),
('CVE',	'Cap Verde Escudo',	'[4217]',	1),
('CZK',	'Czech Republic Koruna',	'[75,269]',	1),
('DEM',	'Deutsche Mark',	NULL,	0),
('DKK',	'Denmark Krone',	'[107,114]',	1),
('DOP',	'Dominican Republic Peso',	'[82,68,36]',	1),
('DZD',	'Algeria Dinar',	NULL,	1),
('ECS',	'Ecuador Sucre',	'[83,47,46]',	1),
('EEK',	'Estonia Kroon',	'[107,114]',	1),
('EGP',	'Egypt Pound',	'[163]',	1),
('ESP',	'Pesete',	NULL,	0),
('ETB',	'Ethiopian Birr',	NULL,	1),
('EUR',	'Euro Member Countries',	'[8364]',	1),
('FIM',	'Mark finlandais',	NULL,	0),
('FJD',	'Fiji Dollar',	'[36]',	1),
('FKP',	'Falkland Islands (Malvinas) Pound',	'[163]',	1),
('FRF',	'Francs francais',	NULL,	0),
('GBP',	'United Kingdom Pound',	'[163]',	1),
('GGP',	'Guernsey Pound',	'[163]',	1),
('GHC',	'Ghana Cedis',	'[162]',	1),
('GIP',	'Gibraltar Pound',	'[163]',	1),
('GNF',	'Guinea Franc',	'[70,71]',	1),
('GRD',	'Drachme (grece)',	NULL,	0),
('GTQ',	'Guatemala Quetzal',	'[81]',	1),
('GYD',	'Guyana Dollar',	'[36]',	1),
('HKD',	'Hong Kong Dollar',	'[36]',	1),
('HNL',	'Honduras Lempira',	'[76]',	1),
('HRK',	'Croatia Kuna',	'[107,110]',	1),
('HUF',	'Hungary Forint',	'[70,116]',	1),
('IDR',	'Indonesia Rupiah',	'[82,112]',	1),
('IEP',	'Livres irlandaises',	NULL,	0),
('ILS',	'Israel Shekel',	'[8362]',	1),
('IMP',	'Isle of Man Pound',	'[163]',	1),
('INR',	'India Rupee',	'[8377]',	1),
('IRR',	'Iran Rial',	'[65020]',	1),
('ISK',	'Iceland Krona',	'[107,114]',	1),
('ITL',	'Lires',	NULL,	0),
('JEP',	'Jersey Pound',	'[163]',	1),
('JMD',	'Jamaica Dollar',	'[74,36]',	1),
('JPY',	'Japan Yen',	'[165]',	1),
('KES',	'Kenya Shilling',	NULL,	1),
('KGS',	'Kyrgyzstan Som',	'[1083,1074]',	1),
('KHR',	'Cambodia Riel',	'[6107]',	1),
('KPW',	'Korea (North) Won',	'[8361]',	1),
('KRW',	'Korea (South) Won',	'[8361]',	1),
('KYD',	'Cayman Islands Dollar',	'[36]',	1),
('KZT',	'Kazakhstan Tenge',	'[1083,1074]',	1),
('LAK',	'Laos Kip',	'[8365]',	1),
('LBP',	'Lebanon Pound',	'[163]',	1),
('LKR',	'Sri Lanka Rupee',	'[8360]',	1),
('LRD',	'Liberia Dollar',	'[36]',	1),
('LTL',	'Lithuania Litas',	'[76,116]',	1),
('LUF',	'Francs luxembourgeois',	NULL,	0),
('LVL',	'Latvia Lat',	'[76,115]',	1),
('MAD',	'Morocco Dirham',	NULL,	1),
('MDL',	'Moldova Leu',	NULL,	1),
('MGA',	'Ariary',	NULL,	1),
('MKD',	'Macedonia Denar',	'[1076,1077,1085]',	1),
('MNT',	'Mongolia Tughrik',	'[8366]',	1),
('MRO',	'Mauritania Ouguiya',	NULL,	1),
('MUR',	'Mauritius Rupee',	'[8360]',	1),
('MXN',	'Mexico Peso',	'[36]',	1),
('MXP',	'Pesos Mexicans',	NULL,	0),
('MYR',	'Malaysia Ringgit',	'[82,77]',	1),
('MZN',	'Mozambique Metical',	'[77,84]',	1),
('NAD',	'Namibia Dollar',	'[36]',	1),
('NGN',	'Nigeria Naira',	'[8358]',	1),
('NIO',	'Nicaragua Cordoba',	'[67,36]',	1),
('NLG',	'Florins',	NULL,	0),
('NOK',	'Norway Krone',	'[107,114]',	1),
('NPR',	'Nepal Rupee',	'[8360]',	1),
('NZD',	'New Zealand Dollar',	'[36]',	1),
('OMR',	'Oman Rial',	'[65020]',	1),
('PAB',	'Panama Balboa',	'[66,47,46]',	1),
('PEN',	'Per?? Sol',	'[83,47]',	1),
('PHP',	'Philippines Peso',	'[8369]',	1),
('PKR',	'Pakistan Rupee',	'[8360]',	1),
('PLN',	'Poland Zloty',	'[122,322]',	1),
('PTE',	'Escudos',	NULL,	0),
('PYG',	'Paraguay Guarani',	'[71,115]',	1),
('QAR',	'Qatar Riyal',	'[65020]',	1),
('RON',	'Romania New Leu',	'[108,101,105]',	1),
('RSD',	'Serbia Dinar',	'[1044,1080,1085,46]',	1),
('RUB',	'Russia Ruble',	'[1088,1091,1073]',	1),
('SAR',	'Saudi Arabia Riyal',	'[65020]',	1),
('SBD',	'Solomon Islands Dollar',	'[36]',	1),
('SCR',	'Seychelles Rupee',	'[8360]',	1),
('SEK',	'Sweden Krona',	'[107,114]',	1),
('SGD',	'Singapore Dollar',	'[36]',	1),
('SHP',	'Saint Helena Pound',	'[163]',	1),
('SKK',	'Couronnes slovaques',	NULL,	0),
('SOS',	'Somalia Shilling',	'[83]',	1),
('SRD',	'Suriname Dollar',	'[36]',	1),
('SUR',	'Rouble',	NULL,	0),
('SVC',	'El Salvador Colon',	'[36]',	1),
('SYP',	'Syria Pound',	'[163]',	1),
('THB',	'Thailand Baht',	'[3647]',	1),
('TND',	'Tunisia Dinar',	NULL,	1),
('TRL',	'Turkey Lira',	'[84,76]',	0),
('TRY',	'Turkey Lira',	'[8356]',	1),
('TTD',	'Trinidad and Tobago Dollar',	'[84,84,36]',	1),
('TVD',	'Tuvalu Dollar',	'[36]',	1),
('TWD',	'Taiwan New Dollar',	'[78,84,36]',	1),
('UAH',	'Ukraine Hryvna',	'[8372]',	1),
('USD',	'United States Dollar',	'[36]',	1),
('UYU',	'Uruguay Peso',	'[36,85]',	1),
('UZS',	'Uzbekistan Som',	'[1083,1074]',	1),
('VEF',	'Venezuela Bolivar Fuerte',	'[66,115]',	1),
('VND',	'Viet Nam Dong',	'[8363]',	1),
('XAF',	'Communaute Financiere Africaine (BEAC) CFA Franc',	NULL,	1),
('XCD',	'East Caribbean Dollar',	'[36]',	1),
('XEU',	'Ecus',	NULL,	0),
('XOF',	'Communaute Financiere Africaine (BCEAO) Franc',	NULL,	1),
('XPF',	'Franc CFP',	'[70]',	1),
('YER',	'Yemen Rial',	'[65020]',	1),
('ZAR',	'South Africa Rand',	'[82]',	1),
('ZWD',	'Zimbabwe Dollar',	'[90,36]',	1);

DROP TABLE IF EXISTS `llx_c_departements`;
CREATE TABLE `llx_c_departements` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `code_departement` varchar(6) COLLATE utf8_unicode_ci NOT NULL,
  `fk_region` int(11) DEFAULT NULL,
  `cheflieu` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tncc` int(11) DEFAULT NULL,
  `ncc` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nom` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_departements` (`code_departement`,`fk_region`),
  KEY `idx_departements_fk_region` (`fk_region`),
  CONSTRAINT `fk_departements_fk_region` FOREIGN KEY (`fk_region`) REFERENCES `llx_c_regions` (`code_region`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_c_departements` (`rowid`, `code_departement`, `fk_region`, `cheflieu`, `tncc`, `ncc`, `nom`, `active`) VALUES
(1,	'0',	0,	'0',	0,	'-',	'-',	1),
(2,	'AL01',	1301,	'',	0,	'',	'Wilaya d\'Adrar',	1),
(3,	'AL02',	1301,	'',	0,	'',	'Wilaya de Chlef',	1),
(4,	'AL03',	1301,	'',	0,	'',	'Wilaya de Laghouat',	1),
(5,	'AL04',	1301,	'',	0,	'',	'Wilaya d\'Oum El Bouaghi',	1),
(6,	'AL05',	1301,	'',	0,	'',	'Wilaya de Batna',	1),
(7,	'AL06',	1301,	'',	0,	'',	'Wilaya de B??ja??a',	1),
(8,	'AL07',	1301,	'',	0,	'',	'Wilaya de Biskra',	1),
(9,	'AL08',	1301,	'',	0,	'',	'Wilaya de B??char',	1),
(10,	'AL09',	1301,	'',	0,	'',	'Wilaya de Blida',	1),
(11,	'AL10',	1301,	'',	0,	'',	'Wilaya de Bouira',	1),
(12,	'AL11',	1301,	'',	0,	'',	'Wilaya de Tamanrasset',	1),
(13,	'AL12',	1301,	'',	0,	'',	'Wilaya de T??bessa',	1),
(14,	'AL13',	1301,	'',	0,	'',	'Wilaya de Tlemcen',	1),
(15,	'AL14',	1301,	'',	0,	'',	'Wilaya de Tiaret',	1),
(16,	'AL15',	1301,	'',	0,	'',	'Wilaya de Tizi Ouzou',	1),
(17,	'AL16',	1301,	'',	0,	'',	'Wilaya d\'Alger',	1),
(18,	'AL17',	1301,	'',	0,	'',	'Wilaya de Djelfa',	1),
(19,	'AL18',	1301,	'',	0,	'',	'Wilaya de Jijel',	1),
(20,	'AL19',	1301,	'',	0,	'',	'Wilaya de S??tif',	1),
(21,	'AL20',	1301,	'',	0,	'',	'Wilaya de Sa??da',	1),
(22,	'AL21',	1301,	'',	0,	'',	'Wilaya de Skikda',	1),
(23,	'AL22',	1301,	'',	0,	'',	'Wilaya de Sidi Bel Abb??s',	1),
(24,	'AL23',	1301,	'',	0,	'',	'Wilaya d\'Annaba',	1),
(25,	'AL24',	1301,	'',	0,	'',	'Wilaya de Guelma',	1),
(26,	'AL25',	1301,	'',	0,	'',	'Wilaya de Constantine',	1),
(27,	'AL26',	1301,	'',	0,	'',	'Wilaya de M??d??a',	1),
(28,	'AL27',	1301,	'',	0,	'',	'Wilaya de Mostaganem',	1),
(29,	'AL28',	1301,	'',	0,	'',	'Wilaya de M\'Sila',	1),
(30,	'AL29',	1301,	'',	0,	'',	'Wilaya de Mascara',	1),
(31,	'AL30',	1301,	'',	0,	'',	'Wilaya d\'Ouargla',	1),
(32,	'AL31',	1301,	'',	0,	'',	'Wilaya d\'Oran',	1),
(33,	'AL32',	1301,	'',	0,	'',	'Wilaya d\'El Bayadh',	1),
(34,	'AL33',	1301,	'',	0,	'',	'Wilaya d\'Illizi',	1),
(35,	'AL34',	1301,	'',	0,	'',	'Wilaya de Bordj Bou Arreridj',	1),
(36,	'AL35',	1301,	'',	0,	'',	'Wilaya de Boumerd??s',	1),
(37,	'AL36',	1301,	'',	0,	'',	'Wilaya d\'El Tarf',	1),
(38,	'AL37',	1301,	'',	0,	'',	'Wilaya de Tindouf',	1),
(39,	'AL38',	1301,	'',	0,	'',	'Wilaya de Tissemsilt',	1),
(40,	'AL39',	1301,	'',	0,	'',	'Wilaya d\'El Oued',	1),
(41,	'AL40',	1301,	'',	0,	'',	'Wilaya de Khenchela',	1),
(42,	'AL41',	1301,	'',	0,	'',	'Wilaya de Souk Ahras',	1),
(43,	'AL42',	1301,	'',	0,	'',	'Wilaya de Tipaza',	1),
(44,	'AL43',	1301,	'',	0,	'',	'Wilaya de Mila',	1),
(45,	'AL44',	1301,	'',	0,	'',	'Wilaya d\'A??n Defla',	1),
(46,	'AL45',	1301,	'',	0,	'',	'Wilaya de Na??ma',	1),
(47,	'AL46',	1301,	'',	0,	'',	'Wilaya d\'A??n T??mouchent',	1),
(48,	'AL47',	1301,	'',	0,	'',	'Wilaya de Ghardaia',	1),
(49,	'AL48',	1301,	'',	0,	'',	'Wilaya de Relizane',	1),
(50,	'AD-002',	34000,	'AD100',	NULL,	NULL,	'Canillo',	1),
(51,	'AD-003',	34000,	'AD200',	NULL,	NULL,	'Encamp',	1),
(52,	'AD-004',	34000,	'AD400',	NULL,	NULL,	'La Massana',	1),
(53,	'AD-005',	34000,	'AD300',	NULL,	NULL,	'Ordino',	1),
(54,	'AD-006',	34000,	'AD600',	NULL,	NULL,	'Sant Juli?? de L??ria',	1),
(55,	'AD-007',	34000,	'AD500',	NULL,	NULL,	'Andorra la Vella',	1),
(56,	'AD-008',	34000,	'AD700',	NULL,	NULL,	'Escaldes-Engordany',	1),
(57,	'AO-ABO',	35001,	NULL,	NULL,	'BENGO',	'Bengo',	1),
(58,	'AO-BGU',	35001,	NULL,	NULL,	'BENGUELA',	'Benguela',	1),
(59,	'AO-BIE',	35001,	NULL,	NULL,	'BI??',	'Bi??',	1),
(60,	'AO-CAB',	35001,	NULL,	NULL,	'CABINDA',	'Cabinda',	1),
(61,	'AO-CCU',	35001,	NULL,	NULL,	'KUANDO KUBANGO',	'Kuando Kubango',	1),
(62,	'AO-CNO',	35001,	NULL,	NULL,	'KWANZA NORTE',	'Kwanza Norte',	1),
(63,	'AO-CUS',	35001,	NULL,	NULL,	'KWANZA SUL',	'Kwanza Sul',	1),
(64,	'AO-CNN',	35001,	NULL,	NULL,	'CUNENE',	'Cunene',	1),
(65,	'AO-HUA',	35001,	NULL,	NULL,	'HUAMBO',	'Huambo',	1),
(66,	'AO-HUI',	35001,	NULL,	NULL,	'HU??LA',	'Huila',	1),
(67,	'AO-LUA',	35001,	NULL,	NULL,	'LUANDA',	'Luanda',	1),
(68,	'AO-LNO',	35001,	NULL,	NULL,	'LUNDA-NORTE',	'Lunda-Norte',	1),
(69,	'AO-LSU',	35001,	NULL,	NULL,	'LUNDA-SUL',	'Lunda-Sul',	1),
(70,	'AO-MAL',	35001,	NULL,	NULL,	'MALANGE',	'Malange',	1),
(71,	'AO-MOX',	35001,	NULL,	NULL,	'MOXICO',	'Moxico',	1),
(72,	'AO-NAM',	35001,	NULL,	NULL,	'NAM??BE',	'Nam??be',	1),
(73,	'AO-UIG',	35001,	NULL,	NULL,	'U??GE',	'U??ge',	1),
(74,	'AO-ZAI',	35001,	NULL,	NULL,	'ZA??RE',	'Za??re',	1),
(75,	'2301',	2301,	'',	0,	'CATAMARCA',	'Catamarca',	1),
(76,	'2302',	2301,	'',	0,	'JUJUY',	'Jujuy',	1),
(77,	'2303',	2301,	'',	0,	'TUCAMAN',	'Tucam??n',	1),
(78,	'2304',	2301,	'',	0,	'SANTIAGO DEL ESTERO',	'Santiago del Estero',	1),
(79,	'2305',	2301,	'',	0,	'SALTA',	'Salta',	1),
(80,	'2306',	2302,	'',	0,	'CHACO',	'Chaco',	1),
(81,	'2307',	2302,	'',	0,	'CORRIENTES',	'Corrientes',	1),
(82,	'2308',	2302,	'',	0,	'ENTRE RIOS',	'Entre R??os',	1),
(83,	'2309',	2302,	'',	0,	'FORMOSA',	'Formosa',	1),
(84,	'2310',	2302,	'',	0,	'SANTA FE',	'Santa Fe',	1),
(85,	'2311',	2303,	'',	0,	'LA RIOJA',	'La Rioja',	1),
(86,	'2312',	2303,	'',	0,	'MENDOZA',	'Mendoza',	1),
(87,	'2313',	2303,	'',	0,	'SAN JUAN',	'San Juan',	1),
(88,	'2314',	2303,	'',	0,	'SAN LUIS',	'San Luis',	1),
(89,	'2315',	2304,	'',	0,	'CORDOBA',	'C??rdoba',	1),
(90,	'2316',	2304,	'',	0,	'BUENOS AIRES',	'Buenos Aires',	1),
(91,	'2317',	2304,	'',	0,	'CABA',	'Caba',	1),
(92,	'2318',	2305,	'',	0,	'LA PAMPA',	'La Pampa',	1),
(93,	'2319',	2305,	'',	0,	'NEUQUEN',	'Neuqu??n',	1),
(94,	'2320',	2305,	'',	0,	'RIO NEGRO',	'R??o Negro',	1),
(95,	'2321',	2305,	'',	0,	'CHUBUT',	'Chubut',	1),
(96,	'2322',	2305,	'',	0,	'SANTA CRUZ',	'Santa Cruz',	1),
(97,	'2323',	2305,	'',	0,	'TIERRA DEL FUEGO',	'Tierra del Fuego',	1),
(98,	'2324',	2305,	'',	0,	'ISLAS MALVINAS',	'Islas Malvinas',	1),
(99,	'2325',	2305,	'',	0,	'ANTARTIDA',	'Ant??rtida',	1),
(100,	'2326',	2305,	'',	0,	'MISIONES',	'Misiones',	1),
(101,	'NSW',	2801,	'',	1,	'',	'New South Wales',	1),
(102,	'VIC',	2801,	'',	1,	'',	'Victoria',	1),
(103,	'QLD',	2801,	'',	1,	'',	'Queensland',	1),
(104,	'SA',	2801,	'',	1,	'',	'South Australia',	1),
(105,	'ACT',	2801,	'',	1,	'',	'Australia Capital Territory',	1),
(106,	'TAS',	2801,	'',	1,	'',	'Tasmania',	1),
(107,	'WA',	2801,	'',	1,	'',	'Western Australia',	1),
(108,	'NT',	2801,	'',	1,	'',	'Northern Territory',	1),
(109,	'B',	4101,	NULL,	NULL,	'BURGENLAND',	'Burgenland',	1),
(110,	'K',	4101,	NULL,	NULL,	'KAERNTEN',	'K??rnten',	1),
(111,	'N',	4101,	NULL,	NULL,	'NIEDEROESTERREICH',	'Nieder??sterreich',	1),
(112,	'O',	4101,	NULL,	NULL,	'OBEROESTERREICH',	'Ober??sterreich',	1),
(113,	'S',	4101,	NULL,	NULL,	'SALZBURG',	'Salzburg',	1),
(114,	'ST',	4101,	NULL,	NULL,	'STEIERMARK',	'Steiermark',	1),
(115,	'T',	4101,	NULL,	NULL,	'TIROL',	'Tirol',	1),
(116,	'V',	4101,	NULL,	NULL,	'VORARLBERG',	'Vorarlberg',	1),
(117,	'W',	4101,	NULL,	NULL,	'WIEN',	'Wien',	1),
(118,	'CC',	4601,	'Oistins',	0,	'CC',	'Christ Church',	1),
(119,	'SA',	4601,	'Greenland',	0,	'SA',	'Saint Andrew',	1),
(120,	'SG',	4601,	'Bulkeley',	0,	'SG',	'Saint George',	1),
(121,	'JA',	4601,	'Holetown',	0,	'JA',	'Saint James',	1),
(122,	'SJ',	4601,	'Four Roads',	0,	'SJ',	'Saint John',	1),
(123,	'SB',	4601,	'Bathsheba',	0,	'SB',	'Saint Joseph',	1),
(124,	'SL',	4601,	'Crab Hill',	0,	'SL',	'Saint Lucy',	1),
(125,	'SM',	4601,	'Bridgetown',	0,	'SM',	'Saint Michael',	1),
(126,	'SP',	4601,	'Speightstown',	0,	'SP',	'Saint Peter',	1),
(127,	'SC',	4601,	'Crane',	0,	'SC',	'Saint Philip',	1),
(128,	'ST',	4601,	'Hillaby',	0,	'ST',	'Saint Thomas',	1),
(129,	'01',	201,	'',	1,	'ANVERS',	'Anvers',	1),
(130,	'02',	203,	'',	3,	'BRUXELLES-CAPITALE',	'Bruxelles-Capitale',	1),
(131,	'03',	202,	'',	2,	'BRABANT-WALLON',	'Brabant-Wallon',	1),
(132,	'04',	201,	'',	1,	'BRABANT-FLAMAND',	'Brabant-Flamand',	1),
(133,	'05',	201,	'',	1,	'FLANDRE-OCCIDENTALE',	'Flandre-Occidentale',	1),
(134,	'06',	201,	'',	1,	'FLANDRE-ORIENTALE',	'Flandre-Orientale',	1),
(135,	'07',	202,	'',	2,	'HAINAUT',	'Hainaut',	1),
(136,	'08',	202,	'',	2,	'LIEGE',	'Li??ge',	1),
(137,	'09',	202,	'',	1,	'LIMBOURG',	'Limbourg',	1),
(138,	'10',	202,	'',	2,	'LUXEMBOURG',	'Luxembourg',	1),
(139,	'11',	202,	'',	2,	'NAMUR',	'Namur',	1),
(140,	'AC',	5601,	'ACRE',	0,	'AC',	'Acre',	1),
(141,	'AL',	5601,	'ALAGOAS',	0,	'AL',	'Alagoas',	1),
(142,	'AP',	5601,	'AMAPA',	0,	'AP',	'Amap??',	1),
(143,	'AM',	5601,	'AMAZONAS',	0,	'AM',	'Amazonas',	1),
(144,	'BA',	5601,	'BAHIA',	0,	'BA',	'Bahia',	1),
(145,	'CE',	5601,	'CEARA',	0,	'CE',	'Cear??',	1),
(146,	'ES',	5601,	'ESPIRITO SANTO',	0,	'ES',	'Espirito Santo',	1),
(147,	'GO',	5601,	'GOIAS',	0,	'GO',	'Goi??s',	1),
(148,	'MA',	5601,	'MARANHAO',	0,	'MA',	'Maranh??o',	1),
(149,	'MT',	5601,	'MATO GROSSO',	0,	'MT',	'Mato Grosso',	1),
(150,	'MS',	5601,	'MATO GROSSO DO SUL',	0,	'MS',	'Mato Grosso do Sul',	1),
(151,	'MG',	5601,	'MINAS GERAIS',	0,	'MG',	'Minas Gerais',	1),
(152,	'PA',	5601,	'PARA',	0,	'PA',	'Par??',	1),
(153,	'PB',	5601,	'PARAIBA',	0,	'PB',	'Paraiba',	1),
(154,	'PR',	5601,	'PARANA',	0,	'PR',	'Paran??',	1),
(155,	'PE',	5601,	'PERNAMBUCO',	0,	'PE',	'Pernambuco',	1),
(156,	'PI',	5601,	'PIAUI',	0,	'PI',	'Piau??',	1),
(157,	'RJ',	5601,	'RIO DE JANEIRO',	0,	'RJ',	'Rio de Janeiro',	1),
(158,	'RN',	5601,	'RIO GRANDE DO NORTE',	0,	'RN',	'Rio Grande do Norte',	1),
(159,	'RS',	5601,	'RIO GRANDE DO SUL',	0,	'RS',	'Rio Grande do Sul',	1),
(160,	'RO',	5601,	'RONDONIA',	0,	'RO',	'Rond??nia',	1),
(161,	'RR',	5601,	'RORAIMA',	0,	'RR',	'Roraima',	1),
(162,	'SC',	5601,	'SANTA CATARINA',	0,	'SC',	'Santa Catarina',	1),
(163,	'SE',	5601,	'SERGIPE',	0,	'SE',	'Sergipe',	1),
(164,	'SP',	5601,	'SAO PAULO',	0,	'SP',	'Sao Paulo',	1),
(165,	'TO',	5601,	'TOCANTINS',	0,	'TO',	'Tocantins',	1),
(166,	'DF',	5601,	'DISTRITO FEDERAL',	0,	'DF',	'Distrito Federal',	1),
(167,	'ON',	1401,	'',	1,	'',	'Ontario',	1),
(168,	'QC',	1401,	'',	1,	'',	'Quebec',	1),
(169,	'NS',	1401,	'',	1,	'',	'Nova Scotia',	1),
(170,	'NB',	1401,	'',	1,	'',	'New Brunswick',	1),
(171,	'MB',	1401,	'',	1,	'',	'Manitoba',	1),
(172,	'BC',	1401,	'',	1,	'',	'British Columbia',	1),
(173,	'PE',	1401,	'',	1,	'',	'Prince Edward Island',	1),
(174,	'SK',	1401,	'',	1,	'',	'Saskatchewan',	1),
(175,	'AB',	1401,	'',	1,	'',	'Alberta',	1),
(176,	'NL',	1401,	'',	1,	'',	'Newfoundland and Labrador',	1),
(177,	'011',	6701,	'',	0,	'011',	'Iquique',	1),
(178,	'014',	6701,	'',	0,	'014',	'Tamarugal',	1),
(179,	'021',	6702,	'',	0,	'021',	'Antofagasa',	1),
(180,	'022',	6702,	'',	0,	'022',	'El Loa',	1),
(181,	'023',	6702,	'',	0,	'023',	'Tocopilla',	1),
(182,	'031',	6703,	'',	0,	'031',	'Copiap??',	1),
(183,	'032',	6703,	'',	0,	'032',	'Cha??aral',	1),
(184,	'033',	6703,	'',	0,	'033',	'Huasco',	1),
(185,	'041',	6704,	'',	0,	'041',	'Elqui',	1),
(186,	'042',	6704,	'',	0,	'042',	'Choapa',	1),
(187,	'043',	6704,	'',	0,	'043',	'Limar??',	1),
(188,	'051',	6705,	'',	0,	'051',	'Valpara??so',	1),
(189,	'052',	6705,	'',	0,	'052',	'Isla de Pascua',	1),
(190,	'053',	6705,	'',	0,	'053',	'Los Andes',	1),
(191,	'054',	6705,	'',	0,	'054',	'Petorca',	1),
(192,	'055',	6705,	'',	0,	'055',	'Quillota',	1),
(193,	'056',	6705,	'',	0,	'056',	'San Antonio',	1),
(194,	'057',	6705,	'',	0,	'057',	'San Felipe de Aconcagua',	1),
(195,	'058',	6705,	'',	0,	'058',	'Marga Marga',	1),
(196,	'061',	6706,	'',	0,	'061',	'Cachapoal',	1),
(197,	'062',	6706,	'',	0,	'062',	'Cardenal Caro',	1),
(198,	'063',	6706,	'',	0,	'063',	'Colchagua',	1),
(199,	'071',	6707,	'',	0,	'071',	'Talca',	1),
(200,	'072',	6707,	'',	0,	'072',	'Cauquenes',	1),
(201,	'073',	6707,	'',	0,	'073',	'Curic??',	1),
(202,	'074',	6707,	'',	0,	'074',	'Linares',	1),
(203,	'081',	6708,	'',	0,	'081',	'Concepci??n',	1),
(204,	'082',	6708,	'',	0,	'082',	'Arauco',	1),
(205,	'083',	6708,	'',	0,	'083',	'Biob??o',	1),
(206,	'084',	6708,	'',	0,	'084',	'??uble',	1),
(207,	'091',	6709,	'',	0,	'091',	'Caut??n',	1),
(208,	'092',	6709,	'',	0,	'092',	'Malleco',	1),
(209,	'101',	6710,	'',	0,	'101',	'Llanquihue',	1),
(210,	'102',	6710,	'',	0,	'102',	'Chilo??',	1),
(211,	'103',	6710,	'',	0,	'103',	'Osorno',	1),
(212,	'104',	6710,	'',	0,	'104',	'Palena',	1),
(213,	'111',	6711,	'',	0,	'111',	'Coihaique',	1),
(214,	'112',	6711,	'',	0,	'112',	'Ais??n',	1),
(215,	'113',	6711,	'',	0,	'113',	'Capit??n Prat',	1),
(216,	'114',	6711,	'',	0,	'114',	'General Carrera',	1),
(217,	'121',	6712,	'',	0,	'121',	'Magallanes',	1),
(218,	'122',	6712,	'',	0,	'122',	'Ant??rtica Chilena',	1),
(219,	'123',	6712,	'',	0,	'123',	'Tierra del Fuego',	1),
(220,	'124',	6712,	'',	0,	'124',	'??ltima Esperanza',	1),
(221,	'131',	6713,	'',	0,	'131',	'Santiago',	1),
(222,	'132',	6713,	'',	0,	'132',	'Cordillera',	1),
(223,	'133',	6713,	'',	0,	'133',	'Chacabuco',	1),
(224,	'134',	6713,	'',	0,	'134',	'Maipo',	1),
(225,	'135',	6713,	'',	0,	'135',	'Melipilla',	1),
(226,	'136',	6713,	'',	0,	'136',	'Talagante',	1),
(227,	'141',	6714,	'',	0,	'141',	'Valdivia',	1),
(228,	'142',	6714,	'',	0,	'142',	'Ranco',	1),
(229,	'151',	6715,	'',	0,	'151',	'Arica',	1),
(230,	'152',	6715,	'',	0,	'152',	'Parinacota',	1),
(231,	'ANT',	7001,	'',	0,	'ANT',	'Antioquia',	1),
(232,	'BOL',	7001,	'',	0,	'BOL',	'Bol??var',	1),
(233,	'BOY',	7001,	'',	0,	'BOY',	'Boyac??',	1),
(234,	'CAL',	7001,	'',	0,	'CAL',	'Caldas',	1),
(235,	'CAU',	7001,	'',	0,	'CAU',	'Cauca',	1),
(236,	'CUN',	7001,	'',	0,	'CUN',	'Cundinamarca',	1),
(237,	'HUI',	7001,	'',	0,	'HUI',	'Huila',	1),
(238,	'LAG',	7001,	'',	0,	'LAG',	'La Guajira',	1),
(239,	'MET',	7001,	'',	0,	'MET',	'Meta',	1),
(240,	'NAR',	7001,	'',	0,	'NAR',	'Nari??o',	1),
(241,	'NDS',	7001,	'',	0,	'NDS',	'Norte de Santander',	1),
(242,	'SAN',	7001,	'',	0,	'SAN',	'Santander',	1),
(243,	'SUC',	7001,	'',	0,	'SUC',	'Sucre',	1),
(244,	'TOL',	7001,	'',	0,	'TOL',	'Tolima',	1),
(245,	'VAC',	7001,	'',	0,	'VAC',	'Valle del Cauca',	1),
(246,	'RIS',	7001,	'',	0,	'RIS',	'Risalda',	1),
(247,	'ATL',	7001,	'',	0,	'ATL',	'Atl??ntico',	1),
(248,	'COR',	7001,	'',	0,	'COR',	'C??rdoba',	1),
(249,	'SAP',	7001,	'',	0,	'SAP',	'San Andr??s, Providencia y Santa Catalina',	1),
(250,	'ARA',	7001,	'',	0,	'ARA',	'Arauca',	1),
(251,	'CAS',	7001,	'',	0,	'CAS',	'Casanare',	1),
(252,	'AMA',	7001,	'',	0,	'AMA',	'Amazonas',	1),
(253,	'CAQ',	7001,	'',	0,	'CAQ',	'Caquet??',	1),
(254,	'CHO',	7001,	'',	0,	'CHO',	'Choc??',	1),
(255,	'GUA',	7001,	'',	0,	'GUA',	'Guain??a',	1),
(256,	'GUV',	7001,	'',	0,	'GUV',	'Guaviare',	1),
(257,	'PUT',	7001,	'',	0,	'PUT',	'Putumayo',	1),
(258,	'QUI',	7001,	'',	0,	'QUI',	'Quind??o',	1),
(259,	'VAU',	7001,	'',	0,	'VAU',	'Vaup??s',	1),
(260,	'BOG',	7001,	'',	0,	'BOG',	'Bogot??',	1),
(261,	'VID',	7001,	'',	0,	'VID',	'Vichada',	1),
(262,	'CES',	7001,	'',	0,	'CES',	'Cesar',	1),
(263,	'MAG',	7001,	'',	0,	'MAG',	'Magdalena',	1),
(264,	'971',	1,	'97105',	3,	'GUADELOUPE',	'Guadeloupe',	1),
(265,	'972',	2,	'97209',	3,	'MARTINIQUE',	'Martinique',	1),
(266,	'973',	3,	'97302',	3,	'GUYANE',	'Guyane',	1),
(267,	'974',	4,	'97411',	3,	'REUNION',	'R??union',	1),
(268,	'976',	6,	'97601',	3,	'MAYOTTE',	'Mayotte',	1),
(269,	'01',	84,	'01053',	5,	'AIN',	'Ain',	1),
(270,	'02',	32,	'02408',	5,	'AISNE',	'Aisne',	1),
(271,	'03',	84,	'03190',	5,	'ALLIER',	'Allier',	1),
(272,	'04',	93,	'04070',	4,	'ALPES-DE-HAUTE-PROVENCE',	'Alpes-de-Haute-Provence',	1),
(273,	'05',	93,	'05061',	4,	'HAUTES-ALPES',	'Hautes-Alpes',	1),
(274,	'06',	93,	'06088',	4,	'ALPES-MARITIMES',	'Alpes-Maritimes',	1),
(275,	'07',	84,	'07186',	5,	'ARDECHE',	'Ard??che',	1),
(276,	'08',	44,	'08105',	4,	'ARDENNES',	'Ardennes',	1),
(277,	'09',	76,	'09122',	5,	'ARIEGE',	'Ari??ge',	1),
(278,	'10',	44,	'10387',	5,	'AUBE',	'Aube',	1),
(279,	'11',	76,	'11069',	5,	'AUDE',	'Aude',	1),
(280,	'12',	76,	'12202',	5,	'AVEYRON',	'Aveyron',	1),
(281,	'13',	93,	'13055',	4,	'BOUCHES-DU-RHONE',	'Bouches-du-Rh??ne',	1),
(282,	'14',	28,	'14118',	2,	'CALVADOS',	'Calvados',	1),
(283,	'15',	84,	'15014',	2,	'CANTAL',	'Cantal',	1),
(284,	'16',	75,	'16015',	3,	'CHARENTE',	'Charente',	1),
(285,	'17',	75,	'17300',	3,	'CHARENTE-MARITIME',	'Charente-Maritime',	1),
(286,	'18',	24,	'18033',	2,	'CHER',	'Cher',	1),
(287,	'19',	75,	'19272',	3,	'CORREZE',	'Corr??ze',	1),
(288,	'2A',	94,	'2A004',	3,	'CORSE-DU-SUD',	'Corse-du-Sud',	1),
(289,	'2B',	94,	'2B033',	3,	'HAUTE-CORSE',	'Haute-Corse',	1),
(290,	'21',	27,	'21231',	3,	'COTE-D OR',	'C??te-d Or',	1),
(291,	'22',	53,	'22278',	4,	'COTES-D ARMOR',	'C??tes-d Armor',	1),
(292,	'23',	75,	'23096',	3,	'CREUSE',	'Creuse',	1),
(293,	'24',	75,	'24322',	3,	'DORDOGNE',	'Dordogne',	1),
(294,	'25',	27,	'25056',	2,	'DOUBS',	'Doubs',	1),
(295,	'26',	84,	'26362',	3,	'DROME',	'Dr??me',	1),
(296,	'27',	28,	'27229',	5,	'EURE',	'Eure',	1),
(297,	'28',	24,	'28085',	1,	'EURE-ET-LOIR',	'Eure-et-Loir',	1),
(298,	'29',	53,	'29232',	2,	'FINISTERE',	'Finist??re',	1),
(299,	'30',	76,	'30189',	2,	'GARD',	'Gard',	1),
(300,	'31',	76,	'31555',	3,	'HAUTE-GARONNE',	'Haute-Garonne',	1),
(301,	'32',	76,	'32013',	2,	'GERS',	'Gers',	1),
(302,	'33',	75,	'33063',	3,	'GIRONDE',	'Gironde',	1),
(303,	'34',	76,	'34172',	5,	'HERAULT',	'H??rault',	1),
(304,	'35',	53,	'35238',	1,	'ILLE-ET-VILAINE',	'Ille-et-Vilaine',	1),
(305,	'36',	24,	'36044',	5,	'INDRE',	'Indre',	1),
(306,	'37',	24,	'37261',	1,	'INDRE-ET-LOIRE',	'Indre-et-Loire',	1),
(307,	'38',	84,	'38185',	5,	'ISERE',	'Is??re',	1),
(308,	'39',	27,	'39300',	2,	'JURA',	'Jura',	1),
(309,	'40',	75,	'40192',	4,	'LANDES',	'Landes',	1),
(310,	'41',	24,	'41018',	0,	'LOIR-ET-CHER',	'Loir-et-Cher',	1),
(311,	'42',	84,	'42218',	3,	'LOIRE',	'Loire',	1),
(312,	'43',	84,	'43157',	3,	'HAUTE-LOIRE',	'Haute-Loire',	1),
(313,	'44',	52,	'44109',	3,	'LOIRE-ATLANTIQUE',	'Loire-Atlantique',	1),
(314,	'45',	24,	'45234',	2,	'LOIRET',	'Loiret',	1),
(315,	'46',	76,	'46042',	2,	'LOT',	'Lot',	1),
(316,	'47',	75,	'47001',	0,	'LOT-ET-GARONNE',	'Lot-et-Garonne',	1),
(317,	'48',	76,	'48095',	3,	'LOZERE',	'Loz??re',	1),
(318,	'49',	52,	'49007',	0,	'MAINE-ET-LOIRE',	'Maine-et-Loire',	1),
(319,	'50',	28,	'50502',	3,	'MANCHE',	'Manche',	1),
(320,	'51',	44,	'51108',	3,	'MARNE',	'Marne',	1),
(321,	'52',	44,	'52121',	3,	'HAUTE-MARNE',	'Haute-Marne',	1),
(322,	'53',	52,	'53130',	3,	'MAYENNE',	'Mayenne',	1),
(323,	'54',	44,	'54395',	0,	'MEURTHE-ET-MOSELLE',	'Meurthe-et-Moselle',	1),
(324,	'55',	44,	'55029',	3,	'MEUSE',	'Meuse',	1),
(325,	'56',	53,	'56260',	2,	'MORBIHAN',	'Morbihan',	1),
(326,	'57',	44,	'57463',	3,	'MOSELLE',	'Moselle',	1),
(327,	'58',	27,	'58194',	3,	'NIEVRE',	'Ni??vre',	1),
(328,	'59',	32,	'59350',	2,	'NORD',	'Nord',	1),
(329,	'60',	32,	'60057',	5,	'OISE',	'Oise',	1),
(330,	'61',	28,	'61001',	5,	'ORNE',	'Orne',	1),
(331,	'62',	32,	'62041',	2,	'PAS-DE-CALAIS',	'Pas-de-Calais',	1),
(332,	'63',	84,	'63113',	2,	'PUY-DE-DOME',	'Puy-de-D??me',	1),
(333,	'64',	75,	'64445',	4,	'PYRENEES-ATLANTIQUES',	'Pyr??n??es-Atlantiques',	1),
(334,	'65',	76,	'65440',	4,	'HAUTES-PYRENEES',	'Hautes-Pyr??n??es',	1),
(335,	'66',	76,	'66136',	4,	'PYRENEES-ORIENTALES',	'Pyr??n??es-Orientales',	1),
(336,	'67',	44,	'67482',	2,	'BAS-RHIN',	'Bas-Rhin',	1),
(337,	'68',	44,	'68066',	2,	'HAUT-RHIN',	'Haut-Rhin',	1),
(338,	'69',	84,	'69123',	2,	'RHONE',	'Rh??ne',	1),
(339,	'70',	27,	'70550',	3,	'HAUTE-SAONE',	'Haute-Sa??ne',	1),
(340,	'71',	27,	'71270',	0,	'SAONE-ET-LOIRE',	'Sa??ne-et-Loire',	1),
(341,	'72',	52,	'72181',	3,	'SARTHE',	'Sarthe',	1),
(342,	'73',	84,	'73065',	3,	'SAVOIE',	'Savoie',	1),
(343,	'74',	84,	'74010',	3,	'HAUTE-SAVOIE',	'Haute-Savoie',	1),
(344,	'75',	11,	'75056',	0,	'PARIS',	'Paris',	1),
(345,	'76',	28,	'76540',	3,	'SEINE-MARITIME',	'Seine-Maritime',	1),
(346,	'77',	11,	'77288',	0,	'SEINE-ET-MARNE',	'Seine-et-Marne',	1),
(347,	'78',	11,	'78646',	4,	'YVELINES',	'Yvelines',	1),
(348,	'79',	75,	'79191',	4,	'DEUX-SEVRES',	'Deux-S??vres',	1),
(349,	'80',	32,	'80021',	3,	'SOMME',	'Somme',	1),
(350,	'81',	76,	'81004',	2,	'TARN',	'Tarn',	1),
(351,	'82',	76,	'82121',	0,	'TARN-ET-GARONNE',	'Tarn-et-Garonne',	1),
(352,	'83',	93,	'83137',	2,	'VAR',	'Var',	1),
(353,	'84',	93,	'84007',	0,	'VAUCLUSE',	'Vaucluse',	1),
(354,	'85',	52,	'85191',	3,	'VENDEE',	'Vend??e',	1),
(355,	'86',	75,	'86194',	3,	'VIENNE',	'Vienne',	1),
(356,	'87',	75,	'87085',	3,	'HAUTE-VIENNE',	'Haute-Vienne',	1),
(357,	'88',	44,	'88160',	4,	'VOSGES',	'Vosges',	1),
(358,	'89',	27,	'89024',	5,	'YONNE',	'Yonne',	1),
(359,	'90',	27,	'90010',	0,	'TERRITOIRE DE BELFORT',	'Territoire de Belfort',	1),
(360,	'91',	11,	'91228',	5,	'ESSONNE',	'Essonne',	1),
(361,	'92',	11,	'92050',	4,	'HAUTS-DE-SEINE',	'Hauts-de-Seine',	1),
(362,	'93',	11,	'93008',	3,	'SEINE-SAINT-DENIS',	'Seine-Saint-Denis',	1),
(363,	'94',	11,	'94028',	2,	'VAL-DE-MARNE',	'Val-de-Marne',	1),
(364,	'95',	11,	'95500',	2,	'VAL-D OISE',	'Val-d Oise',	1),
(365,	'BW',	501,	NULL,	NULL,	'BADEN-W??RTTEMBERG',	'Baden-W??rttemberg',	1),
(366,	'BY',	501,	NULL,	NULL,	'BAYERN',	'Bayern',	1),
(367,	'BE',	501,	NULL,	NULL,	'BERLIN',	'Berlin',	1),
(368,	'BB',	501,	NULL,	NULL,	'BRANDENBURG',	'Brandenburg',	1),
(369,	'HB',	501,	NULL,	NULL,	'BREMEN',	'Bremen',	1),
(370,	'HH',	501,	NULL,	NULL,	'HAMBURG',	'Hamburg',	1),
(371,	'HE',	501,	NULL,	NULL,	'HESSEN',	'Hessen',	1),
(372,	'MV',	501,	NULL,	NULL,	'MECKLENBURG-VORPOMMERN',	'Mecklenburg-Vorpommern',	1),
(373,	'NI',	501,	NULL,	NULL,	'NIEDERSACHSEN',	'Niedersachsen',	1),
(374,	'NW',	501,	NULL,	NULL,	'NORDRHEIN-WESTFALEN',	'Nordrhein-Westfalen',	1),
(375,	'RP',	501,	NULL,	NULL,	'RHEINLAND-PFALZ',	'Rheinland-Pfalz',	1),
(376,	'SL',	501,	NULL,	NULL,	'SAARLAND',	'Saarland',	1),
(377,	'SN',	501,	NULL,	NULL,	'SACHSEN',	'Sachsen',	1),
(378,	'ST',	501,	NULL,	NULL,	'SACHSEN-ANHALT',	'Sachsen-Anhalt',	1),
(379,	'SH',	501,	NULL,	NULL,	'SCHLESWIG-HOLSTEIN',	'Schleswig-Holstein',	1),
(380,	'TH',	501,	NULL,	NULL,	'TH??RINGEN',	'Th??ringen',	1),
(381,	'AT',	11401,	'',	0,	'AT',	'Atl??ntida',	1),
(382,	'CH',	11401,	'',	0,	'CH',	'Choluteca',	1),
(383,	'CL',	11401,	'',	0,	'CL',	'Col??n',	1),
(384,	'CM',	11401,	'',	0,	'CM',	'Comayagua',	1),
(385,	'CO',	11401,	'',	0,	'CO',	'Cop??n',	1),
(386,	'CR',	11401,	'',	0,	'CR',	'Cort??s',	1),
(387,	'EP',	11401,	'',	0,	'EP',	'El Para??so',	1),
(388,	'FM',	11401,	'',	0,	'FM',	'Francisco Moraz??n',	1),
(389,	'GD',	11401,	'',	0,	'GD',	'Gracias a Dios',	1),
(390,	'IN',	11401,	'',	0,	'IN',	'Intibuc??',	1),
(391,	'IB',	11401,	'',	0,	'IB',	'Islas de la Bah??a',	1),
(392,	'LP',	11401,	'',	0,	'LP',	'La Paz',	1),
(393,	'LM',	11401,	'',	0,	'LM',	'Lempira',	1),
(394,	'OC',	11401,	'',	0,	'OC',	'Ocotepeque',	1),
(395,	'OL',	11401,	'',	0,	'OL',	'Olancho',	1),
(396,	'SB',	11401,	'',	0,	'SB',	'Santa B??rbara',	1),
(397,	'VL',	11401,	'',	0,	'VL',	'Valle',	1),
(398,	'YO',	11401,	'',	0,	'YO',	'Yoro',	1),
(399,	'DC',	11401,	'',	0,	'DC',	'Distrito Central',	1),
(400,	'HU-BU',	180100,	'HU101',	NULL,	NULL,	'Budapest',	1),
(401,	'HU-PE',	180100,	'HU102',	NULL,	NULL,	'Pest',	1),
(402,	'HU-FE',	182100,	'HU211',	NULL,	NULL,	'Fej??r',	1),
(403,	'HU-KE',	182100,	'HU212',	NULL,	NULL,	'Kom??rom-Esztergom',	1),
(404,	'HU-VE',	182100,	'HU213',	NULL,	NULL,	'Veszpr??m',	1),
(405,	'HU-GS',	182200,	'HU221',	NULL,	NULL,	'Gy??r-Moson-Sopron',	1),
(406,	'HU-VA',	182200,	'HU222',	NULL,	NULL,	'Vas',	1),
(407,	'HU-ZA',	182200,	'HU223',	NULL,	NULL,	'Zala',	1),
(408,	'HU-BA',	182300,	'HU231',	NULL,	NULL,	'Baranya',	1),
(409,	'HU-SO',	182300,	'HU232',	NULL,	NULL,	'Somogy',	1),
(410,	'HU-TO',	182300,	'HU233',	NULL,	NULL,	'Tolna',	1),
(411,	'HU-BZ',	183100,	'HU311',	NULL,	NULL,	'Borsod-Aba??j-Zempl??n',	1),
(412,	'HU-HE',	183100,	'HU312',	NULL,	NULL,	'Heves',	1),
(413,	'HU-NO',	183100,	'HU313',	NULL,	NULL,	'N??gr??d',	1),
(414,	'HU-HB',	183200,	'HU321',	NULL,	NULL,	'Hajd??-Bihar',	1),
(415,	'HU-JN',	183200,	'HU322',	NULL,	NULL,	'J??sz-Nagykun-Szolnok',	1),
(416,	'HU-SZ',	183200,	'HU323',	NULL,	NULL,	'Szabolcs-Szatm??r-Bereg',	1),
(417,	'HU-BK',	183300,	'HU331',	NULL,	NULL,	'B??cs-Kiskun',	1),
(418,	'HU-BE',	183300,	'HU332',	NULL,	NULL,	'B??k??s',	1),
(419,	'HU-CS',	183300,	'HU333',	NULL,	NULL,	'Csongr??d',	1),
(420,	'AG',	315,	NULL,	NULL,	NULL,	'AGRIGENTO',	1),
(421,	'AL',	312,	NULL,	NULL,	NULL,	'ALESSANDRIA',	1),
(422,	'AN',	310,	NULL,	NULL,	NULL,	'ANCONA',	1),
(423,	'AO',	319,	NULL,	NULL,	NULL,	'AOSTA',	1),
(424,	'AR',	316,	NULL,	NULL,	NULL,	'AREZZO',	1),
(425,	'AP',	310,	NULL,	NULL,	NULL,	'ASCOLI PICENO',	1),
(426,	'AT',	312,	NULL,	NULL,	NULL,	'ASTI',	1),
(427,	'AV',	304,	NULL,	NULL,	NULL,	'AVELLINO',	1),
(428,	'BA',	313,	NULL,	NULL,	NULL,	'BARI',	1),
(429,	'BT',	313,	NULL,	NULL,	NULL,	'BARLETTA-ANDRIA-TRANI',	1),
(430,	'BL',	320,	NULL,	NULL,	NULL,	'BELLUNO',	1),
(431,	'BN',	304,	NULL,	NULL,	NULL,	'BENEVENTO',	1),
(432,	'BG',	309,	NULL,	NULL,	NULL,	'BERGAMO',	1),
(433,	'BI',	312,	NULL,	NULL,	NULL,	'BIELLA',	1),
(434,	'BO',	305,	NULL,	NULL,	NULL,	'BOLOGNA',	1),
(435,	'BZ',	317,	NULL,	NULL,	NULL,	'BOLZANO',	1),
(436,	'BS',	309,	NULL,	NULL,	NULL,	'BRESCIA',	1),
(437,	'BR',	313,	NULL,	NULL,	NULL,	'BRINDISI',	1),
(438,	'CA',	314,	NULL,	NULL,	NULL,	'CAGLIARI',	1),
(439,	'CL',	315,	NULL,	NULL,	NULL,	'CALTANISSETTA',	1),
(440,	'CB',	311,	NULL,	NULL,	NULL,	'CAMPOBASSO',	1),
(441,	'CI',	314,	NULL,	NULL,	NULL,	'CARBONIA-IGLESIAS',	1),
(442,	'CE',	304,	NULL,	NULL,	NULL,	'CASERTA',	1),
(443,	'CT',	315,	NULL,	NULL,	NULL,	'CATANIA',	1),
(444,	'CZ',	303,	NULL,	NULL,	NULL,	'CATANZARO',	1),
(445,	'CH',	301,	NULL,	NULL,	NULL,	'CHIETI',	1),
(446,	'CO',	309,	NULL,	NULL,	NULL,	'COMO',	1),
(447,	'CS',	303,	NULL,	NULL,	NULL,	'COSENZA',	1),
(448,	'CR',	309,	NULL,	NULL,	NULL,	'CREMONA',	1),
(449,	'KR',	303,	NULL,	NULL,	NULL,	'CROTONE',	1),
(450,	'CN',	312,	NULL,	NULL,	NULL,	'CUNEO',	1),
(451,	'EN',	315,	NULL,	NULL,	NULL,	'ENNA',	1),
(452,	'FM',	310,	NULL,	NULL,	NULL,	'FERMO',	1),
(453,	'FE',	305,	NULL,	NULL,	NULL,	'FERRARA',	1),
(454,	'FI',	316,	NULL,	NULL,	NULL,	'FIRENZE',	1),
(455,	'FG',	313,	NULL,	NULL,	NULL,	'FOGGIA',	1),
(456,	'FC',	305,	NULL,	NULL,	NULL,	'FORLI-CESENA',	1),
(457,	'FR',	307,	NULL,	NULL,	NULL,	'FROSINONE',	1),
(458,	'GE',	308,	NULL,	NULL,	NULL,	'GENOVA',	1),
(459,	'GO',	306,	NULL,	NULL,	NULL,	'GORIZIA',	1),
(460,	'GR',	316,	NULL,	NULL,	NULL,	'GROSSETO',	1),
(461,	'IM',	308,	NULL,	NULL,	NULL,	'IMPERIA',	1),
(462,	'IS',	311,	NULL,	NULL,	NULL,	'ISERNIA',	1),
(463,	'SP',	308,	NULL,	NULL,	NULL,	'LA SPEZIA',	1),
(464,	'AQ',	301,	NULL,	NULL,	NULL,	'L AQUILA',	1),
(465,	'LT',	307,	NULL,	NULL,	NULL,	'LATINA',	1),
(466,	'LE',	313,	NULL,	NULL,	NULL,	'LECCE',	1),
(467,	'LC',	309,	NULL,	NULL,	NULL,	'LECCO',	1),
(468,	'LI',	316,	NULL,	NULL,	NULL,	'LIVORNO',	1),
(469,	'LO',	309,	NULL,	NULL,	NULL,	'LODI',	1),
(470,	'LU',	316,	NULL,	NULL,	NULL,	'LUCCA',	1),
(471,	'MC',	310,	NULL,	NULL,	NULL,	'MACERATA',	1),
(472,	'MN',	309,	NULL,	NULL,	NULL,	'MANTOVA',	1),
(473,	'MS',	316,	NULL,	NULL,	NULL,	'MASSA-CARRARA',	1),
(474,	'MT',	302,	NULL,	NULL,	NULL,	'MATERA',	1),
(475,	'VS',	314,	NULL,	NULL,	NULL,	'MEDIO CAMPIDANO',	1),
(476,	'ME',	315,	NULL,	NULL,	NULL,	'MESSINA',	1),
(477,	'MI',	309,	NULL,	NULL,	NULL,	'MILANO',	1),
(478,	'MB',	309,	NULL,	NULL,	NULL,	'MONZA e BRIANZA',	1),
(479,	'MO',	305,	NULL,	NULL,	NULL,	'MODENA',	1),
(480,	'NA',	304,	NULL,	NULL,	NULL,	'NAPOLI',	1),
(481,	'NO',	312,	NULL,	NULL,	NULL,	'NOVARA',	1),
(482,	'NU',	314,	NULL,	NULL,	NULL,	'NUORO',	1),
(483,	'OG',	314,	NULL,	NULL,	NULL,	'OGLIASTRA',	1),
(484,	'OT',	314,	NULL,	NULL,	NULL,	'OLBIA-TEMPIO',	1),
(485,	'OR',	314,	NULL,	NULL,	NULL,	'ORISTANO',	1),
(486,	'PD',	320,	NULL,	NULL,	NULL,	'PADOVA',	1),
(487,	'PA',	315,	NULL,	NULL,	NULL,	'PALERMO',	1),
(488,	'PR',	305,	NULL,	NULL,	NULL,	'PARMA',	1),
(489,	'PV',	309,	NULL,	NULL,	NULL,	'PAVIA',	1),
(490,	'PG',	318,	NULL,	NULL,	NULL,	'PERUGIA',	1),
(491,	'PU',	310,	NULL,	NULL,	NULL,	'PESARO e URBINO',	1),
(492,	'PE',	301,	NULL,	NULL,	NULL,	'PESCARA',	1),
(493,	'PC',	305,	NULL,	NULL,	NULL,	'PIACENZA',	1),
(494,	'PI',	316,	NULL,	NULL,	NULL,	'PISA',	1),
(495,	'PT',	316,	NULL,	NULL,	NULL,	'PISTOIA',	1),
(496,	'PN',	306,	NULL,	NULL,	NULL,	'PORDENONE',	1),
(497,	'PZ',	302,	NULL,	NULL,	NULL,	'POTENZA',	1),
(498,	'PO',	316,	NULL,	NULL,	NULL,	'PRATO',	1),
(499,	'RG',	315,	NULL,	NULL,	NULL,	'RAGUSA',	1),
(500,	'RA',	305,	NULL,	NULL,	NULL,	'RAVENNA',	1),
(501,	'RC',	303,	NULL,	NULL,	NULL,	'REGGIO CALABRIA',	1),
(502,	'RE',	305,	NULL,	NULL,	NULL,	'REGGIO NELL EMILIA',	1),
(503,	'RI',	307,	NULL,	NULL,	NULL,	'RIETI',	1),
(504,	'RN',	305,	NULL,	NULL,	NULL,	'RIMINI',	1),
(505,	'RM',	307,	NULL,	NULL,	NULL,	'ROMA',	1),
(506,	'RO',	320,	NULL,	NULL,	NULL,	'ROVIGO',	1),
(507,	'SA',	304,	NULL,	NULL,	NULL,	'SALERNO',	1),
(508,	'SS',	314,	NULL,	NULL,	NULL,	'SASSARI',	1),
(509,	'SV',	308,	NULL,	NULL,	NULL,	'SAVONA',	1),
(510,	'SI',	316,	NULL,	NULL,	NULL,	'SIENA',	1),
(511,	'SR',	315,	NULL,	NULL,	NULL,	'SIRACUSA',	1),
(512,	'SO',	309,	NULL,	NULL,	NULL,	'SONDRIO',	1),
(513,	'TA',	313,	NULL,	NULL,	NULL,	'TARANTO',	1),
(514,	'TE',	301,	NULL,	NULL,	NULL,	'TERAMO',	1),
(515,	'TR',	318,	NULL,	NULL,	NULL,	'TERNI',	1),
(516,	'TO',	312,	NULL,	NULL,	NULL,	'TORINO',	1),
(517,	'TP',	315,	NULL,	NULL,	NULL,	'TRAPANI',	1),
(518,	'TN',	317,	NULL,	NULL,	NULL,	'TRENTO',	1),
(519,	'TV',	320,	NULL,	NULL,	NULL,	'TREVISO',	1),
(520,	'TS',	306,	NULL,	NULL,	NULL,	'TRIESTE',	1),
(521,	'UD',	306,	NULL,	NULL,	NULL,	'UDINE',	1),
(522,	'VA',	309,	NULL,	NULL,	NULL,	'VARESE',	1),
(523,	'VE',	320,	NULL,	NULL,	NULL,	'VENEZIA',	1),
(524,	'VB',	312,	NULL,	NULL,	NULL,	'VERBANO-CUSIO-OSSOLA',	1),
(525,	'VC',	312,	NULL,	NULL,	NULL,	'VERCELLI',	1),
(526,	'VR',	320,	NULL,	NULL,	NULL,	'VERONA',	1),
(527,	'VV',	303,	NULL,	NULL,	NULL,	'VIBO VALENTIA',	1),
(528,	'VI',	320,	NULL,	NULL,	NULL,	'VICENZA',	1),
(529,	'VT',	307,	NULL,	NULL,	NULL,	'VITERBO',	1),
(530,	'LU0001',	14001,	'',	0,	'',	'Clervaux',	1),
(531,	'LU0002',	14001,	'',	0,	'',	'Diekirch',	1),
(532,	'LU0003',	14001,	'',	0,	'',	'Redange',	1),
(533,	'LU0004',	14001,	'',	0,	'',	'Vianden',	1),
(534,	'LU0005',	14001,	'',	0,	'',	'Wiltz',	1),
(535,	'LU0006',	14002,	'',	0,	'',	'Echternach',	1),
(536,	'LU0007',	14002,	'',	0,	'',	'Grevenmacher',	1),
(537,	'LU0008',	14002,	'',	0,	'',	'Remich',	1),
(538,	'LU0009',	14003,	'',	0,	'',	'Capellen',	1),
(539,	'LU0010',	14003,	'',	0,	'',	'Esch-sur-Alzette',	1),
(540,	'LU0011',	14003,	'',	0,	'',	'Luxembourg',	1),
(541,	'LU0012',	14003,	'',	0,	'',	'Mersch',	1),
(542,	'MA',	1209,	'',	0,	'',	'Province de Benslimane',	1),
(543,	'MA1',	1209,	'',	0,	'',	'Province de Berrechid',	1),
(544,	'MA2',	1209,	'',	0,	'',	'Province de Khouribga',	1),
(545,	'MA3',	1209,	'',	0,	'',	'Province de Settat',	1),
(546,	'MA4',	1210,	'',	0,	'',	'Province d\'El Jadida',	1),
(547,	'MA5',	1210,	'',	0,	'',	'Province de Safi',	1),
(548,	'MA6',	1210,	'',	0,	'',	'Province de Sidi Bennour',	1),
(549,	'MA7',	1210,	'',	0,	'',	'Province de Youssoufia',	1),
(550,	'MA6B',	1205,	'',	0,	'',	'Pr??fecture de F??s',	1),
(551,	'MA7B',	1205,	'',	0,	'',	'Province de Boulemane',	1),
(552,	'MA8',	1205,	'',	0,	'',	'Province de Moulay Yacoub',	1),
(553,	'MA9',	1205,	'',	0,	'',	'Province de Sefrou',	1),
(554,	'MA8A',	1202,	'',	0,	'',	'Province de K??nitra',	1),
(555,	'MA9A',	1202,	'',	0,	'',	'Province de Sidi Kacem',	1),
(556,	'MA10',	1202,	'',	0,	'',	'Province de Sidi Slimane',	1),
(557,	'MA11',	1208,	'',	0,	'',	'Pr??fecture de Casablanca',	1),
(558,	'MA12',	1208,	'',	0,	'',	'Pr??fecture de Mohamm??dia',	1),
(559,	'MA13',	1208,	'',	0,	'',	'Province de M??diouna',	1),
(560,	'MA14',	1208,	'',	0,	'',	'Province de Nouaceur',	1),
(561,	'MA15',	1214,	'',	0,	'',	'Province d\'Assa-Zag',	1),
(562,	'MA16',	1214,	'',	0,	'',	'Province d\'Es-Semara',	1),
(563,	'MA17A',	1214,	'',	0,	'',	'Province de Guelmim',	1),
(564,	'MA18',	1214,	'',	0,	'',	'Province de Tata',	1),
(565,	'MA19',	1214,	'',	0,	'',	'Province de Tan-Tan',	1),
(566,	'MA15',	1215,	'',	0,	'',	'Province de Boujdour',	1),
(567,	'MA16',	1215,	'',	0,	'',	'Province de L??ayoune',	1),
(568,	'MA17',	1215,	'',	0,	'',	'Province de Tarfaya',	1),
(569,	'MA18',	1211,	'',	0,	'',	'Pr??fecture de Marrakech',	1),
(570,	'MA19',	1211,	'',	0,	'',	'Province d\'Al Haouz',	1),
(571,	'MA20',	1211,	'',	0,	'',	'Province de Chichaoua',	1),
(572,	'MA21',	1211,	'',	0,	'',	'Province d\'El Kel??a des Sraghna',	1),
(573,	'MA22',	1211,	'',	0,	'',	'Province d\'Essaouira',	1),
(574,	'MA23',	1211,	'',	0,	'',	'Province de Rehamna',	1),
(575,	'MA24',	1206,	'',	0,	'',	'Pr??fecture de Mekn??s',	1),
(576,	'MA25',	1206,	'',	0,	'',	'Province d???El Hajeb',	1),
(577,	'MA26',	1206,	'',	0,	'',	'Province d\'Errachidia',	1),
(578,	'MA27',	1206,	'',	0,	'',	'Province d???Ifrane',	1),
(579,	'MA28',	1206,	'',	0,	'',	'Province de Kh??nifra',	1),
(580,	'MA29',	1206,	'',	0,	'',	'Province de Midelt',	1),
(581,	'MA30',	1204,	'',	0,	'',	'Pr??fecture d\'Oujda-Angad',	1),
(582,	'MA31',	1204,	'',	0,	'',	'Province de Berkane',	1),
(583,	'MA32',	1204,	'',	0,	'',	'Province de Driouch',	1),
(584,	'MA33',	1204,	'',	0,	'',	'Province de Figuig',	1),
(585,	'MA34',	1204,	'',	0,	'',	'Province de Jerada',	1),
(586,	'MA35',	1204,	'',	0,	'',	'Province de Nador',	1),
(587,	'MA36',	1204,	'',	0,	'',	'Province de Taourirt',	1),
(588,	'MA37',	1216,	'',	0,	'',	'Province d\'Aousserd',	1),
(589,	'MA38',	1216,	'',	0,	'',	'Province d\'Oued Ed-Dahab',	1),
(590,	'MA39',	1207,	'',	0,	'',	'Pr??fecture de Rabat',	1),
(591,	'MA40',	1207,	'',	0,	'',	'Pr??fecture de Skhirat-T??mara',	1),
(592,	'MA41',	1207,	'',	0,	'',	'Pr??fecture de Sal??',	1),
(593,	'MA42',	1207,	'',	0,	'',	'Province de Kh??misset',	1),
(594,	'MA43',	1213,	'',	0,	'',	'Pr??fecture d\'Agadir Ida-Outanane',	1),
(595,	'MA44',	1213,	'',	0,	'',	'Pr??fecture d\'Inezgane-A??t Melloul',	1),
(596,	'MA45',	1213,	'',	0,	'',	'Province de Chtouka-A??t Baha',	1),
(597,	'MA46',	1213,	'',	0,	'',	'Province d\'Ouarzazate',	1),
(598,	'MA47',	1213,	'',	0,	'',	'Province de Sidi Ifni',	1),
(599,	'MA48',	1213,	'',	0,	'',	'Province de Taroudant',	1),
(600,	'MA49',	1213,	'',	0,	'',	'Province de Tinghir',	1),
(601,	'MA50',	1213,	'',	0,	'',	'Province de Tiznit',	1),
(602,	'MA51',	1213,	'',	0,	'',	'Province de Zagora',	1),
(603,	'MA52',	1212,	'',	0,	'',	'Province d\'Azilal',	1),
(604,	'MA53',	1212,	'',	0,	'',	'Province de Beni Mellal',	1),
(605,	'MA54',	1212,	'',	0,	'',	'Province de Fquih Ben Salah',	1),
(606,	'MA55',	1201,	'',	0,	'',	'Pr??fecture de M\'diq-Fnideq',	1),
(607,	'MA56',	1201,	'',	0,	'',	'Pr??fecture de Tanger-Asilah',	1),
(608,	'MA57',	1201,	'',	0,	'',	'Province de Chefchaouen',	1),
(609,	'MA58',	1201,	'',	0,	'',	'Province de Fahs-Anjra',	1),
(610,	'MA59',	1201,	'',	0,	'',	'Province de Larache',	1),
(611,	'MA60',	1201,	'',	0,	'',	'Province d\'Ouezzane',	1),
(612,	'MA61',	1201,	'',	0,	'',	'Province de T??touan',	1),
(613,	'MA62',	1203,	'',	0,	'',	'Province de Guercif',	1),
(614,	'MA63',	1203,	'',	0,	'',	'Province d\'Al Hoce??ma',	1),
(615,	'MA64',	1203,	'',	0,	'',	'Province de Taounate',	1),
(616,	'MA65',	1203,	'',	0,	'',	'Province de Taza',	1),
(617,	'MA6A',	1205,	'',	0,	'',	'Pr??fecture de F??s',	1),
(618,	'MA7A',	1205,	'',	0,	'',	'Province de Boulemane',	1),
(619,	'MA15A',	1214,	'',	0,	'',	'Province d\'Assa-Zag',	1),
(620,	'MA16A',	1214,	'',	0,	'',	'Province d\'Es-Semara',	1),
(621,	'MA18A',	1211,	'',	0,	'',	'Pr??fecture de Marrakech',	1),
(622,	'MA19A',	1214,	'',	0,	'',	'Province de Tan-Tan',	1),
(623,	'MA19B',	1214,	'',	0,	'',	'Province de Tan-Tan',	1),
(624,	'GR',	1701,	NULL,	NULL,	NULL,	'Groningen',	1),
(625,	'FR',	1701,	NULL,	NULL,	NULL,	'Friesland',	1),
(626,	'DR',	1701,	NULL,	NULL,	NULL,	'Drenthe',	1),
(627,	'OV',	1701,	NULL,	NULL,	NULL,	'Overijssel',	1),
(628,	'GD',	1701,	NULL,	NULL,	NULL,	'Gelderland',	1),
(629,	'FL',	1701,	NULL,	NULL,	NULL,	'Flevoland',	1),
(630,	'UT',	1701,	NULL,	NULL,	NULL,	'Utrecht',	1),
(631,	'NH',	1701,	NULL,	NULL,	NULL,	'Noord-Holland',	1),
(632,	'ZH',	1701,	NULL,	NULL,	NULL,	'Zuid-Holland',	1),
(633,	'ZL',	1701,	NULL,	NULL,	NULL,	'Zeeland',	1),
(634,	'NB',	1701,	NULL,	NULL,	NULL,	'Noord-Brabant',	1),
(635,	'LB',	1701,	NULL,	NULL,	NULL,	'Limburg',	1),
(636,	'PA-1',	17801,	'',	0,	'',	'Bocas del Toro',	1),
(637,	'PA-2',	17801,	'',	0,	'',	'Cocl??',	1),
(638,	'PA-3',	17801,	'',	0,	'',	'Col??n',	1),
(639,	'PA-4',	17801,	'',	0,	'',	'Chiriqu??',	1),
(640,	'PA-5',	17801,	'',	0,	'',	'Dari??n',	1),
(641,	'PA-6',	17801,	'',	0,	'',	'Herrera',	1),
(642,	'PA-7',	17801,	'',	0,	'',	'Los Santos',	1),
(643,	'PA-8',	17801,	'',	0,	'',	'Panam??',	1),
(644,	'PA-9',	17801,	'',	0,	'',	'Veraguas',	1),
(645,	'PA-13',	17801,	'',	0,	'',	'Panam?? Oeste',	1),
(646,	'0101',	18101,	'',	0,	'',	'Chachapoyas',	1),
(647,	'0102',	18101,	'',	0,	'',	'Bagua',	1),
(648,	'0103',	18101,	'',	0,	'',	'Bongar??',	1),
(649,	'0104',	18101,	'',	0,	'',	'Condorcanqui',	1),
(650,	'0105',	18101,	'',	0,	'',	'Luya',	1),
(651,	'0106',	18101,	'',	0,	'',	'Rodr??guez de Mendoza',	1),
(652,	'0107',	18101,	'',	0,	'',	'Utcubamba',	1),
(653,	'0201',	18102,	'',	0,	'',	'Huaraz',	1),
(654,	'0202',	18102,	'',	0,	'',	'Aija',	1),
(655,	'0203',	18102,	'',	0,	'',	'Antonio Raymondi',	1),
(656,	'0204',	18102,	'',	0,	'',	'Asunci??n',	1),
(657,	'0205',	18102,	'',	0,	'',	'Bolognesi',	1),
(658,	'0206',	18102,	'',	0,	'',	'Carhuaz',	1),
(659,	'0207',	18102,	'',	0,	'',	'Carlos Ferm??n Fitzcarrald',	1),
(660,	'0208',	18102,	'',	0,	'',	'Casma',	1),
(661,	'0209',	18102,	'',	0,	'',	'Corongo',	1),
(662,	'0210',	18102,	'',	0,	'',	'Huari',	1),
(663,	'0211',	18102,	'',	0,	'',	'Huarmey',	1),
(664,	'0212',	18102,	'',	0,	'',	'Huaylas',	1),
(665,	'0213',	18102,	'',	0,	'',	'Mariscal Luzuriaga',	1),
(666,	'0214',	18102,	'',	0,	'',	'Ocros',	1),
(667,	'0215',	18102,	'',	0,	'',	'Pallasca',	1),
(668,	'0216',	18102,	'',	0,	'',	'Pomabamba',	1),
(669,	'0217',	18102,	'',	0,	'',	'Recuay',	1),
(670,	'0218',	18102,	'',	0,	'',	'Pap??',	1),
(671,	'0219',	18102,	'',	0,	'',	'Sihuas',	1),
(672,	'0220',	18102,	'',	0,	'',	'Yungay',	1),
(673,	'0301',	18103,	'',	0,	'',	'Abancay',	1),
(674,	'0302',	18103,	'',	0,	'',	'Andahuaylas',	1),
(675,	'0303',	18103,	'',	0,	'',	'Antabamba',	1),
(676,	'0304',	18103,	'',	0,	'',	'Aymaraes',	1),
(677,	'0305',	18103,	'',	0,	'',	'Cotabambas',	1),
(678,	'0306',	18103,	'',	0,	'',	'Chincheros',	1),
(679,	'0307',	18103,	'',	0,	'',	'Grau',	1),
(680,	'0401',	18104,	'',	0,	'',	'Arequipa',	1),
(681,	'0402',	18104,	'',	0,	'',	'Caman??',	1),
(682,	'0403',	18104,	'',	0,	'',	'Caravel??',	1),
(683,	'0404',	18104,	'',	0,	'',	'Castilla',	1),
(684,	'0405',	18104,	'',	0,	'',	'Caylloma',	1),
(685,	'0406',	18104,	'',	0,	'',	'Condesuyos',	1),
(686,	'0407',	18104,	'',	0,	'',	'Islay',	1),
(687,	'0408',	18104,	'',	0,	'',	'La Uni??n',	1),
(688,	'0501',	18105,	'',	0,	'',	'Huamanga',	1),
(689,	'0502',	18105,	'',	0,	'',	'Cangallo',	1),
(690,	'0503',	18105,	'',	0,	'',	'Huanca Sancos',	1),
(691,	'0504',	18105,	'',	0,	'',	'Huanta',	1),
(692,	'0505',	18105,	'',	0,	'',	'La Mar',	1),
(693,	'0506',	18105,	'',	0,	'',	'Lucanas',	1),
(694,	'0507',	18105,	'',	0,	'',	'Parinacochas',	1),
(695,	'0508',	18105,	'',	0,	'',	'P??ucar del Sara Sara',	1),
(696,	'0509',	18105,	'',	0,	'',	'Sucre',	1),
(697,	'0510',	18105,	'',	0,	'',	'V??ctor Fajardo',	1),
(698,	'0511',	18105,	'',	0,	'',	'Vilcas Huam??n',	1),
(699,	'0601',	18106,	'',	0,	'',	'Cajamarca',	1),
(700,	'0602',	18106,	'',	0,	'',	'Cajabamba',	1),
(701,	'0603',	18106,	'',	0,	'',	'Celend??n',	1),
(702,	'0604',	18106,	'',	0,	'',	'Chota',	1),
(703,	'0605',	18106,	'',	0,	'',	'Contumaz??',	1),
(704,	'0606',	18106,	'',	0,	'',	'Cutervo',	1),
(705,	'0607',	18106,	'',	0,	'',	'Hualgayoc',	1),
(706,	'0608',	18106,	'',	0,	'',	'Ja??n',	1),
(707,	'0609',	18106,	'',	0,	'',	'San Ignacio',	1),
(708,	'0610',	18106,	'',	0,	'',	'San Marcos',	1),
(709,	'0611',	18106,	'',	0,	'',	'San Miguel',	1),
(710,	'0612',	18106,	'',	0,	'',	'San Pablo',	1),
(711,	'0613',	18106,	'',	0,	'',	'Santa Cruz',	1),
(712,	'0701',	18107,	'',	0,	'',	'Callao',	1),
(713,	'0801',	18108,	'',	0,	'',	'Cusco',	1),
(714,	'0802',	18108,	'',	0,	'',	'Acomayo',	1),
(715,	'0803',	18108,	'',	0,	'',	'Anta',	1),
(716,	'0804',	18108,	'',	0,	'',	'Calca',	1),
(717,	'0805',	18108,	'',	0,	'',	'Canas',	1),
(718,	'0806',	18108,	'',	0,	'',	'Canchis',	1),
(719,	'0807',	18108,	'',	0,	'',	'Chumbivilcas',	1),
(720,	'0808',	18108,	'',	0,	'',	'Espinar',	1),
(721,	'0809',	18108,	'',	0,	'',	'La Convenci??n',	1),
(722,	'0810',	18108,	'',	0,	'',	'Paruro',	1),
(723,	'0811',	18108,	'',	0,	'',	'Paucartambo',	1),
(724,	'0812',	18108,	'',	0,	'',	'Quispicanchi',	1),
(725,	'0813',	18108,	'',	0,	'',	'Urubamba',	1),
(726,	'0901',	18109,	'',	0,	'',	'Huancavelica',	1),
(727,	'0902',	18109,	'',	0,	'',	'Acobamba',	1),
(728,	'0903',	18109,	'',	0,	'',	'Angaraes',	1),
(729,	'0904',	18109,	'',	0,	'',	'Castrovirreyna',	1),
(730,	'0905',	18109,	'',	0,	'',	'Churcampa',	1),
(731,	'0906',	18109,	'',	0,	'',	'Huaytar??',	1),
(732,	'0907',	18109,	'',	0,	'',	'Tayacaja',	1),
(733,	'1001',	18110,	'',	0,	'',	'Hu??nuco',	1),
(734,	'1002',	18110,	'',	0,	'',	'Amb??n',	1),
(735,	'1003',	18110,	'',	0,	'',	'Dos de Mayo',	1),
(736,	'1004',	18110,	'',	0,	'',	'Huacaybamba',	1),
(737,	'1005',	18110,	'',	0,	'',	'Huamal??es',	1),
(738,	'1006',	18110,	'',	0,	'',	'Leoncio Prado',	1),
(739,	'1007',	18110,	'',	0,	'',	'Mara????n',	1),
(740,	'1008',	18110,	'',	0,	'',	'Pachitea',	1),
(741,	'1009',	18110,	'',	0,	'',	'Puerto Inca',	1),
(742,	'1010',	18110,	'',	0,	'',	'Lauricocha',	1),
(743,	'1011',	18110,	'',	0,	'',	'Yarowilca',	1),
(744,	'1101',	18111,	'',	0,	'',	'Ica',	1),
(745,	'1102',	18111,	'',	0,	'',	'Chincha',	1),
(746,	'1103',	18111,	'',	0,	'',	'Nazca',	1),
(747,	'1104',	18111,	'',	0,	'',	'Palpa',	1),
(748,	'1105',	18111,	'',	0,	'',	'Pisco',	1),
(749,	'1201',	18112,	'',	0,	'',	'Huancayo',	1),
(750,	'1202',	18112,	'',	0,	'',	'Concepci??n',	1),
(751,	'1203',	18112,	'',	0,	'',	'Chanchamayo',	1),
(752,	'1204',	18112,	'',	0,	'',	'Jauja',	1),
(753,	'1205',	18112,	'',	0,	'',	'Jun??n',	1),
(754,	'1206',	18112,	'',	0,	'',	'Satipo',	1),
(755,	'1207',	18112,	'',	0,	'',	'Tarma',	1),
(756,	'1208',	18112,	'',	0,	'',	'Yauli',	1),
(757,	'1209',	18112,	'',	0,	'',	'Chupaca',	1),
(758,	'1301',	18113,	'',	0,	'',	'Trujillo',	1),
(759,	'1302',	18113,	'',	0,	'',	'Ascope',	1),
(760,	'1303',	18113,	'',	0,	'',	'Bol??var',	1),
(761,	'1304',	18113,	'',	0,	'',	'Chep??n',	1),
(762,	'1305',	18113,	'',	0,	'',	'Julc??n',	1),
(763,	'1306',	18113,	'',	0,	'',	'Otuzco',	1),
(764,	'1307',	18113,	'',	0,	'',	'Pacasmayo',	1),
(765,	'1308',	18113,	'',	0,	'',	'Pataz',	1),
(766,	'1309',	18113,	'',	0,	'',	'S??nchez Carri??n',	1),
(767,	'1310',	18113,	'',	0,	'',	'Santiago de Chuco',	1),
(768,	'1311',	18113,	'',	0,	'',	'Gran Chim??',	1),
(769,	'1312',	18113,	'',	0,	'',	'Vir??',	1),
(770,	'1401',	18114,	'',	0,	'',	'Chiclayo',	1),
(771,	'1402',	18114,	'',	0,	'',	'Ferre??afe',	1),
(772,	'1403',	18114,	'',	0,	'',	'Lambayeque',	1),
(773,	'1501',	18115,	'',	0,	'',	'Lima',	1),
(774,	'1502',	18116,	'',	0,	'',	'Huaura',	1),
(775,	'1503',	18116,	'',	0,	'',	'Barranca',	1),
(776,	'1504',	18116,	'',	0,	'',	'Cajatambo',	1),
(777,	'1505',	18116,	'',	0,	'',	'Canta',	1),
(778,	'1506',	18116,	'',	0,	'',	'Ca??ete',	1),
(779,	'1507',	18116,	'',	0,	'',	'Huaral',	1),
(780,	'1508',	18116,	'',	0,	'',	'Huarochir??',	1),
(781,	'1509',	18116,	'',	0,	'',	'Oy??n',	1),
(782,	'1510',	18116,	'',	0,	'',	'Yauyos',	1),
(783,	'1601',	18117,	'',	0,	'',	'Maynas',	1),
(784,	'1602',	18117,	'',	0,	'',	'Alto Amazonas',	1),
(785,	'1603',	18117,	'',	0,	'',	'Loreto',	1),
(786,	'1604',	18117,	'',	0,	'',	'Mariscal Ram??n Castilla',	1),
(787,	'1605',	18117,	'',	0,	'',	'Requena',	1),
(788,	'1606',	18117,	'',	0,	'',	'Ucayali',	1),
(789,	'1607',	18117,	'',	0,	'',	'Datem del Mara????n',	1),
(790,	'1701',	18118,	'',	0,	'',	'Tambopata',	1),
(791,	'1702',	18118,	'',	0,	'',	'Man??',	1),
(792,	'1703',	18118,	'',	0,	'',	'Tahuamanu',	1),
(793,	'1801',	18119,	'',	0,	'',	'Mariscal Nieto',	1),
(794,	'1802',	18119,	'',	0,	'',	'General S??nchez Cerro',	1),
(795,	'1803',	18119,	'',	0,	'',	'Ilo',	1),
(796,	'1901',	18120,	'',	0,	'',	'Pasco',	1),
(797,	'1902',	18120,	'',	0,	'',	'Daniel Alcides Carri??n',	1),
(798,	'1903',	18120,	'',	0,	'',	'Oxapampa',	1),
(799,	'2001',	18121,	'',	0,	'',	'Piura',	1),
(800,	'2002',	18121,	'',	0,	'',	'Ayabaca',	1),
(801,	'2003',	18121,	'',	0,	'',	'Huancabamba',	1),
(802,	'2004',	18121,	'',	0,	'',	'Morrop??n',	1),
(803,	'2005',	18121,	'',	0,	'',	'Paita',	1),
(804,	'2006',	18121,	'',	0,	'',	'Sullana',	1),
(805,	'2007',	18121,	'',	0,	'',	'Talara',	1),
(806,	'2008',	18121,	'',	0,	'',	'Sechura',	1),
(807,	'2101',	18122,	'',	0,	'',	'Puno',	1),
(808,	'2102',	18122,	'',	0,	'',	'Az??ngaro',	1),
(809,	'2103',	18122,	'',	0,	'',	'Carabaya',	1),
(810,	'2104',	18122,	'',	0,	'',	'Chucuito',	1),
(811,	'2105',	18122,	'',	0,	'',	'El Collao',	1),
(812,	'2106',	18122,	'',	0,	'',	'Huancan??',	1),
(813,	'2107',	18122,	'',	0,	'',	'Lampa',	1),
(814,	'2108',	18122,	'',	0,	'',	'Melgar',	1),
(815,	'2109',	18122,	'',	0,	'',	'Moho',	1),
(816,	'2110',	18122,	'',	0,	'',	'San Antonio de Putina',	1),
(817,	'2111',	18122,	'',	0,	'',	'San Rom??n',	1),
(818,	'2112',	18122,	'',	0,	'',	'Sandia',	1),
(819,	'2113',	18122,	'',	0,	'',	'Yunguyo',	1),
(820,	'2201',	18123,	'',	0,	'',	'Moyobamba',	1),
(821,	'2202',	18123,	'',	0,	'',	'Bellavista',	1),
(822,	'2203',	18123,	'',	0,	'',	'El Dorado',	1),
(823,	'2204',	18123,	'',	0,	'',	'Huallaga',	1),
(824,	'2205',	18123,	'',	0,	'',	'Lamas',	1),
(825,	'2206',	18123,	'',	0,	'',	'Mariscal C??ceres',	1),
(826,	'2207',	18123,	'',	0,	'',	'Picota',	1),
(827,	'2208',	18123,	'',	0,	'',	'La Rioja',	1),
(828,	'2209',	18123,	'',	0,	'',	'San Mart??n',	1),
(829,	'2210',	18123,	'',	0,	'',	'Tocache',	1),
(830,	'2301',	18124,	'',	0,	'',	'Tacna',	1),
(831,	'2302',	18124,	'',	0,	'',	'Candarave',	1),
(832,	'2303',	18124,	'',	0,	'',	'Jorge Basadre',	1),
(833,	'2304',	18124,	'',	0,	'',	'Tarata',	1),
(834,	'2401',	18125,	'',	0,	'',	'Tumbes',	1),
(835,	'2402',	18125,	'',	0,	'',	'Contralmirante Villar',	1),
(836,	'2403',	18125,	'',	0,	'',	'Zarumilla',	1),
(837,	'2501',	18126,	'',	0,	'',	'Coronel Portillo',	1),
(838,	'2502',	18126,	'',	0,	'',	'Atalaya',	1),
(839,	'2503',	18126,	'',	0,	'',	'Padre Abad',	1),
(840,	'2504',	18126,	'',	0,	'',	'Pur??s',	1),
(841,	'PT-AV',	15001,	NULL,	NULL,	'AVEIRO',	'Aveiro',	1),
(842,	'PT-AC',	15002,	NULL,	NULL,	'AZORES',	'Azores',	1),
(843,	'PT-BE',	15001,	NULL,	NULL,	'BEJA',	'Beja',	1),
(844,	'PT-BR',	15001,	NULL,	NULL,	'BRAGA',	'Braga',	1),
(845,	'PT-BA',	15001,	NULL,	NULL,	'BRAGANCA',	'Bragan??a',	1),
(846,	'PT-CB',	15001,	NULL,	NULL,	'CASTELO BRANCO',	'Castelo Branco',	1),
(847,	'PT-CO',	15001,	NULL,	NULL,	'COIMBRA',	'Coimbra',	1),
(848,	'PT-EV',	15001,	NULL,	NULL,	'EVORA',	'??vora',	1),
(849,	'PT-FA',	15001,	NULL,	NULL,	'FARO',	'Faro',	1),
(850,	'PT-GU',	15001,	NULL,	NULL,	'GUARDA',	'Guarda',	1),
(851,	'PT-LE',	15001,	NULL,	NULL,	'LEIRIA',	'Leiria',	1),
(852,	'PT-LI',	15001,	NULL,	NULL,	'LISBON',	'Lisboa',	1),
(853,	'PT-AML',	15001,	NULL,	NULL,	'AREA METROPOLITANA LISBOA',	'??rea Metropolitana de Lisboa',	1),
(854,	'PT-MA',	15002,	NULL,	NULL,	'MADEIRA',	'Madeira',	1),
(855,	'PT-PA',	15001,	NULL,	NULL,	'PORTALEGRE',	'Portalegre',	1),
(856,	'PT-PO',	15001,	NULL,	NULL,	'PORTO',	'Porto',	1),
(857,	'PT-SA',	15001,	NULL,	NULL,	'SANTAREM',	'Santar??m',	1),
(858,	'PT-SE',	15001,	NULL,	NULL,	'SETUBAL',	'Set??bal',	1),
(859,	'PT-VC',	15001,	NULL,	NULL,	'VIANA DO CASTELO',	'Viana Do Castelo',	1),
(860,	'PT-VR',	15001,	NULL,	NULL,	'VILA REAL',	'Vila Real',	1),
(861,	'PT-VI',	15001,	NULL,	NULL,	'VISEU',	'Viseu',	1),
(862,	'AB',	18801,	'',	0,	'',	'Alba',	1),
(863,	'AR',	18801,	'',	0,	'',	'Arad',	1),
(864,	'AG',	18801,	'',	0,	'',	'Arge??',	1),
(865,	'BC',	18801,	'',	0,	'',	'Bac??u',	1),
(866,	'BH',	18801,	'',	0,	'',	'Bihor',	1),
(867,	'BN',	18801,	'',	0,	'',	'Bistri??a-N??s??ud',	1),
(868,	'BT',	18801,	'',	0,	'',	'Boto??ani',	1),
(869,	'BV',	18801,	'',	0,	'',	'Bra??ov',	1),
(870,	'BR',	18801,	'',	0,	'',	'Br??ila',	1),
(871,	'BU',	18801,	'',	0,	'',	'Bucuresti',	1),
(872,	'BZ',	18801,	'',	0,	'',	'Buz??u',	1),
(873,	'CL',	18801,	'',	0,	'',	'C??l??ra??i',	1),
(874,	'CS',	18801,	'',	0,	'',	'Cara??-Severin',	1),
(875,	'CJ',	18801,	'',	0,	'',	'Cluj',	1),
(876,	'CT',	18801,	'',	0,	'',	'Constan??a',	1),
(877,	'CV',	18801,	'',	0,	'',	'Covasna',	1),
(878,	'DB',	18801,	'',	0,	'',	'D??mbovi??a',	1),
(879,	'DJ',	18801,	'',	0,	'',	'Dolj',	1),
(880,	'GL',	18801,	'',	0,	'',	'Gala??i',	1),
(881,	'GR',	18801,	'',	0,	'',	'Giurgiu',	1),
(882,	'GJ',	18801,	'',	0,	'',	'Gorj',	1),
(883,	'HR',	18801,	'',	0,	'',	'Harghita',	1),
(884,	'HD',	18801,	'',	0,	'',	'Hunedoara',	1),
(885,	'IL',	18801,	'',	0,	'',	'Ialomi??a',	1),
(886,	'IS',	18801,	'',	0,	'',	'Ia??i',	1),
(887,	'IF',	18801,	'',	0,	'',	'Ilfov',	1),
(888,	'MM',	18801,	'',	0,	'',	'Maramure??',	1),
(889,	'MH',	18801,	'',	0,	'',	'Mehedin??i',	1),
(890,	'MS',	18801,	'',	0,	'',	'Mure??',	1),
(891,	'NT',	18801,	'',	0,	'',	'Neam??',	1),
(892,	'OT',	18801,	'',	0,	'',	'Olt',	1),
(893,	'PH',	18801,	'',	0,	'',	'Prahova',	1),
(894,	'SM',	18801,	'',	0,	'',	'Satu Mare',	1),
(895,	'SJ',	18801,	'',	0,	'',	'S??laj',	1),
(896,	'SB',	18801,	'',	0,	'',	'Sibiu',	1),
(897,	'SV',	18801,	'',	0,	'',	'Suceava',	1),
(898,	'TR',	18801,	'',	0,	'',	'Teleorman',	1),
(899,	'TM',	18801,	'',	0,	'',	'Timi??',	1),
(900,	'TL',	18801,	'',	0,	'',	'Tulcea',	1),
(901,	'VS',	18801,	'',	0,	'',	'Vaslui',	1),
(902,	'VL',	18801,	'',	0,	'',	'V??lcea',	1),
(903,	'VN',	18801,	'',	0,	'',	'Vrancea',	1),
(904,	'SI031',	20203,	NULL,	NULL,	'MURA',	'Mura',	1),
(905,	'SI032',	20203,	NULL,	NULL,	'DRAVA',	'Drava',	1),
(906,	'SI033',	20203,	NULL,	NULL,	'CARINTHIA',	'Carinthia',	1),
(907,	'SI034',	20203,	NULL,	NULL,	'SAVINJA',	'Savinja',	1),
(908,	'SI035',	20203,	NULL,	NULL,	'CENTRAL SAVA',	'Central Sava',	1),
(909,	'SI036',	20203,	NULL,	NULL,	'LOWER SAVA',	'Lower Sava',	1),
(910,	'SI037',	20203,	NULL,	NULL,	'SOUTHEAST SLOVENIA',	'Southeast Slovenia',	1),
(911,	'SI038',	20203,	NULL,	NULL,	'LITTORAL???INNER CARNIOLA',	'Littoral???Inner Carniola',	1),
(912,	'SI041',	20204,	NULL,	NULL,	'CENTRAL SLOVENIA',	'Central Slovenia',	1),
(913,	'SI038',	20204,	NULL,	NULL,	'UPPER CARNIOLA',	'Upper Carniola',	1),
(914,	'SI043',	20204,	NULL,	NULL,	'GORIZIA',	'Gorizia',	1),
(915,	'SI044',	20204,	NULL,	NULL,	'COASTAL???KARST',	'Coastal???Karst',	1),
(916,	'TW-KLU',	21301,	'KLU',	NULL,	NULL,	'?????????',	1),
(917,	'TW-TPE',	21301,	'TPE',	NULL,	NULL,	'?????????',	1),
(918,	'TW-TPH',	21301,	'TPH',	NULL,	NULL,	'?????????',	1),
(919,	'TW-TYC',	21301,	'TYC',	NULL,	NULL,	'?????????',	1),
(920,	'TW-HSH',	21301,	'HSH',	NULL,	NULL,	'?????????',	1),
(921,	'TW-HSC',	21301,	'HSC',	NULL,	NULL,	'?????????',	1),
(922,	'TW-MAL',	21301,	'MAL',	NULL,	NULL,	'?????????',	1),
(923,	'TW-MAC',	21301,	'MAC',	NULL,	NULL,	'?????????',	1),
(924,	'TW-TXG',	21301,	'TXG',	NULL,	NULL,	'?????????',	1),
(925,	'TW-CWH',	21301,	'CWH',	NULL,	NULL,	'?????????',	1),
(926,	'TW-CWS',	21301,	'CWS',	NULL,	NULL,	'?????????',	1),
(927,	'TW-NTC',	21301,	'NTC',	NULL,	NULL,	'?????????',	1),
(928,	'TW-NTO',	21301,	'NTO',	NULL,	NULL,	'?????????',	1),
(929,	'TW-YLH',	21301,	'YLH',	NULL,	NULL,	'?????????',	1),
(930,	'TW-CHY',	21301,	'CHY',	NULL,	NULL,	'?????????',	1),
(931,	'TW-CYI',	21301,	'CYI',	NULL,	NULL,	'?????????',	1),
(932,	'TW-TNN',	21301,	'TNN',	NULL,	NULL,	'?????????',	1),
(933,	'TW-KHH',	21301,	'KHH',	NULL,	NULL,	'?????????',	1),
(934,	'TW-IUH',	21301,	'IUH',	NULL,	NULL,	'?????????',	1),
(935,	'TW-PTS',	21301,	'PTS',	NULL,	NULL,	'?????????',	1),
(936,	'TW-ILN',	21301,	'ILN',	NULL,	NULL,	'?????????',	1),
(937,	'TW-ILC',	21301,	'ILC',	NULL,	NULL,	'?????????',	1),
(938,	'TW-HWA',	21301,	'HWA',	NULL,	NULL,	'?????????',	1),
(939,	'TW-HWC',	21301,	'HWC',	NULL,	NULL,	'?????????',	1),
(940,	'TW-TTC',	21301,	'TTC',	NULL,	NULL,	'?????????',	1),
(941,	'TW-TTT',	21301,	'TTT',	NULL,	NULL,	'?????????',	1),
(942,	'TW-PEH',	21301,	'PEH',	NULL,	NULL,	'?????????',	1),
(943,	'TW-GNI',	21301,	'GNI',	NULL,	NULL,	'??????',	1),
(944,	'TW-KYD',	21301,	'KYD',	NULL,	NULL,	'??????',	1),
(945,	'TW-KMN',	21301,	'KMN',	NULL,	NULL,	'?????????',	1),
(946,	'TW-LNN',	21301,	'LNN',	NULL,	NULL,	'?????????',	1),
(947,	'TN01',	1001,	'',	0,	'',	'Ariana',	1),
(948,	'TN02',	1001,	'',	0,	'',	'B??ja',	1),
(949,	'TN03',	1001,	'',	0,	'',	'Ben Arous',	1),
(950,	'TN04',	1001,	'',	0,	'',	'Bizerte',	1),
(951,	'TN05',	1001,	'',	0,	'',	'Gab??s',	1),
(952,	'TN06',	1001,	'',	0,	'',	'Gafsa',	1),
(953,	'TN07',	1001,	'',	0,	'',	'Jendouba',	1),
(954,	'TN08',	1001,	'',	0,	'',	'Kairouan',	1),
(955,	'TN09',	1001,	'',	0,	'',	'Kasserine',	1),
(956,	'TN10',	1001,	'',	0,	'',	'K??bili',	1),
(957,	'TN11',	1001,	'',	0,	'',	'La Manouba',	1),
(958,	'TN12',	1001,	'',	0,	'',	'Le Kef',	1),
(959,	'TN13',	1001,	'',	0,	'',	'Mahdia',	1),
(960,	'TN14',	1001,	'',	0,	'',	'M??denine',	1),
(961,	'TN15',	1001,	'',	0,	'',	'Monastir',	1),
(962,	'TN16',	1001,	'',	0,	'',	'Nabeul',	1),
(963,	'TN17',	1001,	'',	0,	'',	'Sfax',	1),
(964,	'TN18',	1001,	'',	0,	'',	'Sidi Bouzid',	1),
(965,	'TN19',	1001,	'',	0,	'',	'Siliana',	1),
(966,	'TN20',	1001,	'',	0,	'',	'Sousse',	1),
(967,	'TN21',	1001,	'',	0,	'',	'Tataouine',	1),
(968,	'TN22',	1001,	'',	0,	'',	'Tozeur',	1),
(969,	'TN23',	1001,	'',	0,	'',	'Tunis',	1),
(970,	'TN24',	1001,	'',	0,	'',	'Zaghouan',	1),
(971,	'AL',	1101,	'',	0,	'ALABAMA',	'Alabama',	1),
(972,	'AK',	1101,	'',	0,	'ALASKA',	'Alaska',	1),
(973,	'AZ',	1101,	'',	0,	'ARIZONA',	'Arizona',	1),
(974,	'AR',	1101,	'',	0,	'ARKANSAS',	'Arkansas',	1),
(975,	'CA',	1101,	'',	0,	'CALIFORNIA',	'California',	1),
(976,	'CO',	1101,	'',	0,	'COLORADO',	'Colorado',	1),
(977,	'CT',	1101,	'',	0,	'CONNECTICUT',	'Connecticut',	1),
(978,	'DE',	1101,	'',	0,	'DELAWARE',	'Delaware',	1),
(979,	'FL',	1101,	'',	0,	'FLORIDA',	'Florida',	1),
(980,	'GA',	1101,	'',	0,	'GEORGIA',	'Georgia',	1),
(981,	'HI',	1101,	'',	0,	'HAWAII',	'Hawaii',	1),
(982,	'ID',	1101,	'',	0,	'IDAHO',	'Idaho',	1),
(983,	'IL',	1101,	'',	0,	'ILLINOIS',	'Illinois',	1),
(984,	'IN',	1101,	'',	0,	'INDIANA',	'Indiana',	1),
(985,	'IA',	1101,	'',	0,	'IOWA',	'Iowa',	1),
(986,	'KS',	1101,	'',	0,	'KANSAS',	'Kansas',	1),
(987,	'KY',	1101,	'',	0,	'KENTUCKY',	'Kentucky',	1),
(988,	'LA',	1101,	'',	0,	'LOUISIANA',	'Louisiana',	1),
(989,	'ME',	1101,	'',	0,	'MAINE',	'Maine',	1),
(990,	'MD',	1101,	'',	0,	'MARYLAND',	'Maryland',	1),
(991,	'MA',	1101,	'',	0,	'MASSACHUSSETTS',	'Massachusetts',	1),
(992,	'MI',	1101,	'',	0,	'MICHIGAN',	'Michigan',	1),
(993,	'MN',	1101,	'',	0,	'MINNESOTA',	'Minnesota',	1),
(994,	'MS',	1101,	'',	0,	'MISSISSIPPI',	'Mississippi',	1),
(995,	'MO',	1101,	'',	0,	'MISSOURI',	'Missouri',	1),
(996,	'MT',	1101,	'',	0,	'MONTANA',	'Montana',	1),
(997,	'NE',	1101,	'',	0,	'NEBRASKA',	'Nebraska',	1),
(998,	'NV',	1101,	'',	0,	'NEVADA',	'Nevada',	1),
(999,	'NH',	1101,	'',	0,	'NEW HAMPSHIRE',	'New Hampshire',	1),
(1000,	'NJ',	1101,	'',	0,	'NEW JERSEY',	'New Jersey',	1),
(1001,	'NM',	1101,	'',	0,	'NEW MEXICO',	'New Mexico',	1),
(1002,	'NY',	1101,	'',	0,	'NEW YORK',	'New York',	1),
(1003,	'NC',	1101,	'',	0,	'NORTH CAROLINA',	'North Carolina',	1),
(1004,	'ND',	1101,	'',	0,	'NORTH DAKOTA',	'North Dakota',	1),
(1005,	'OH',	1101,	'',	0,	'OHIO',	'Ohio',	1),
(1006,	'OK',	1101,	'',	0,	'OKLAHOMA',	'Oklahoma',	1),
(1007,	'OR',	1101,	'',	0,	'OREGON',	'Oregon',	1),
(1008,	'PA',	1101,	'',	0,	'PENNSYLVANIA',	'Pennsylvania',	1),
(1009,	'RI',	1101,	'',	0,	'RHODE ISLAND',	'Rhode Island',	1),
(1010,	'SC',	1101,	'',	0,	'SOUTH CAROLINA',	'South Carolina',	1),
(1011,	'SD',	1101,	'',	0,	'SOUTH DAKOTA',	'South Dakota',	1),
(1012,	'TN',	1101,	'',	0,	'TENNESSEE',	'Tennessee',	1),
(1013,	'TX',	1101,	'',	0,	'TEXAS',	'Texas',	1),
(1014,	'UT',	1101,	'',	0,	'UTAH',	'Utah',	1),
(1015,	'VT',	1101,	'',	0,	'VERMONT',	'Vermont',	1),
(1016,	'VA',	1101,	'',	0,	'VIRGINIA',	'Virginia',	1),
(1017,	'WA',	1101,	'',	0,	'WASHINGTON',	'Washington',	1),
(1018,	'WV',	1101,	'',	0,	'WEST VIRGINIA',	'West Virginia',	1),
(1019,	'WI',	1101,	'',	0,	'WISCONSIN',	'Wisconsin',	1),
(1020,	'WY',	1101,	'',	0,	'WYOMING',	'Wyoming',	1),
(1021,	'001',	5201,	'',	0,	'',	'Belisario Boeto',	1),
(1022,	'002',	5201,	'',	0,	'',	'Hernando Siles',	1),
(1023,	'003',	5201,	'',	0,	'',	'Jaime Zud????ez',	1),
(1024,	'004',	5201,	'',	0,	'',	'Juana Azurduy de Padilla',	1),
(1025,	'005',	5201,	'',	0,	'',	'Luis Calvo',	1),
(1026,	'006',	5201,	'',	0,	'',	'Nor Cinti',	1),
(1027,	'007',	5201,	'',	0,	'',	'Oropeza',	1),
(1028,	'008',	5201,	'',	0,	'',	'Sud Cinti',	1),
(1029,	'009',	5201,	'',	0,	'',	'Tomina',	1),
(1030,	'010',	5201,	'',	0,	'',	'Yampar??ez',	1),
(1031,	'011',	5202,	'',	0,	'',	'Abel Iturralde',	1),
(1032,	'012',	5202,	'',	0,	'',	'Aroma',	1),
(1033,	'013',	5202,	'',	0,	'',	'Bautista Saavedra',	1),
(1034,	'014',	5202,	'',	0,	'',	'Caranavi',	1),
(1035,	'015',	5202,	'',	0,	'',	'Eliodoro Camacho',	1),
(1036,	'016',	5202,	'',	0,	'',	'Franz Tamayo',	1),
(1037,	'017',	5202,	'',	0,	'',	'Gualberto Villarroel',	1),
(1038,	'018',	5202,	'',	0,	'',	'Ingav??',	1),
(1039,	'019',	5202,	'',	0,	'',	'Inquisivi',	1),
(1040,	'020',	5202,	'',	0,	'',	'Jos?? Ram??n Loayza',	1),
(1041,	'021',	5202,	'',	0,	'',	'Larecaja',	1),
(1042,	'022',	5202,	'',	0,	'',	'Los Andes (Bolivia)',	1),
(1043,	'023',	5202,	'',	0,	'',	'Manco Kapac',	1),
(1044,	'024',	5202,	'',	0,	'',	'Mu??ecas',	1),
(1045,	'025',	5202,	'',	0,	'',	'Nor Yungas',	1),
(1046,	'026',	5202,	'',	0,	'',	'Omasuyos',	1),
(1047,	'027',	5202,	'',	0,	'',	'Pacajes',	1),
(1048,	'028',	5202,	'',	0,	'',	'Pedro Domingo Murillo',	1),
(1049,	'029',	5202,	'',	0,	'',	'Sud Yungas',	1),
(1050,	'030',	5202,	'',	0,	'',	'General Jos?? Manuel Pando',	1),
(1051,	'031',	5203,	'',	0,	'',	'Arani',	1),
(1052,	'032',	5203,	'',	0,	'',	'Arque',	1),
(1053,	'033',	5203,	'',	0,	'',	'Ayopaya',	1),
(1054,	'034',	5203,	'',	0,	'',	'Bol??var (Bolivia)',	1),
(1055,	'035',	5203,	'',	0,	'',	'Campero',	1),
(1056,	'036',	5203,	'',	0,	'',	'Capinota',	1),
(1057,	'037',	5203,	'',	0,	'',	'Cercado (Cochabamba)',	1),
(1058,	'038',	5203,	'',	0,	'',	'Esteban Arze',	1),
(1059,	'039',	5203,	'',	0,	'',	'Germ??n Jord??n',	1),
(1060,	'040',	5203,	'',	0,	'',	'Jos?? Carrasco',	1),
(1061,	'041',	5203,	'',	0,	'',	'Mizque',	1),
(1062,	'042',	5203,	'',	0,	'',	'Punata',	1),
(1063,	'043',	5203,	'',	0,	'',	'Quillacollo',	1),
(1064,	'044',	5203,	'',	0,	'',	'Tapacar??',	1),
(1065,	'045',	5203,	'',	0,	'',	'Tiraque',	1),
(1066,	'046',	5203,	'',	0,	'',	'Chapare',	1),
(1067,	'047',	5204,	'',	0,	'',	'Carangas',	1),
(1068,	'048',	5204,	'',	0,	'',	'Cercado (Oruro)',	1),
(1069,	'049',	5204,	'',	0,	'',	'Eduardo Avaroa',	1),
(1070,	'050',	5204,	'',	0,	'',	'Ladislao Cabrera',	1),
(1071,	'051',	5204,	'',	0,	'',	'Litoral de Atacama',	1),
(1072,	'052',	5204,	'',	0,	'',	'Mejillones',	1),
(1073,	'053',	5204,	'',	0,	'',	'Nor Carangas',	1),
(1074,	'054',	5204,	'',	0,	'',	'Pantale??n Dalence',	1),
(1075,	'055',	5204,	'',	0,	'',	'Poop??',	1),
(1076,	'056',	5204,	'',	0,	'',	'Sabaya',	1),
(1077,	'057',	5204,	'',	0,	'',	'Sajama',	1),
(1078,	'058',	5204,	'',	0,	'',	'San Pedro de Totora',	1),
(1079,	'059',	5204,	'',	0,	'',	'Saucar??',	1),
(1080,	'060',	5204,	'',	0,	'',	'Sebasti??n Pagador',	1),
(1081,	'061',	5204,	'',	0,	'',	'Sud Carangas',	1),
(1082,	'062',	5204,	'',	0,	'',	'Tom??s Barr??n',	1),
(1083,	'063',	5205,	'',	0,	'',	'Alonso de Ib????ez',	1),
(1084,	'064',	5205,	'',	0,	'',	'Antonio Quijarro',	1),
(1085,	'065',	5205,	'',	0,	'',	'Bernardino Bilbao',	1),
(1086,	'066',	5205,	'',	0,	'',	'Charcas (Potos??)',	1),
(1087,	'067',	5205,	'',	0,	'',	'Chayanta',	1),
(1088,	'068',	5205,	'',	0,	'',	'Cornelio Saavedra',	1),
(1089,	'069',	5205,	'',	0,	'',	'Daniel Campos',	1),
(1090,	'070',	5205,	'',	0,	'',	'Enrique Baldivieso',	1),
(1091,	'071',	5205,	'',	0,	'',	'Jos?? Mar??a Linares',	1),
(1092,	'072',	5205,	'',	0,	'',	'Modesto Omiste',	1),
(1093,	'073',	5205,	'',	0,	'',	'Nor Chichas',	1),
(1094,	'074',	5205,	'',	0,	'',	'Nor L??pez',	1),
(1095,	'075',	5205,	'',	0,	'',	'Rafael Bustillo',	1),
(1096,	'076',	5205,	'',	0,	'',	'Sud Chichas',	1),
(1097,	'077',	5205,	'',	0,	'',	'Sud L??pez',	1),
(1098,	'078',	5205,	'',	0,	'',	'Tom??s Fr??as',	1),
(1099,	'079',	5206,	'',	0,	'',	'Aniceto Arce',	1),
(1100,	'080',	5206,	'',	0,	'',	'Burdet O\'Connor',	1),
(1101,	'081',	5206,	'',	0,	'',	'Cercado (Tarija)',	1),
(1102,	'082',	5206,	'',	0,	'',	'Eustaquio M??ndez',	1),
(1103,	'083',	5206,	'',	0,	'',	'Jos?? Mar??a Avil??s',	1),
(1104,	'084',	5206,	'',	0,	'',	'Gran Chaco',	1),
(1105,	'085',	5207,	'',	0,	'',	'Andr??s Ib????ez',	1),
(1106,	'086',	5207,	'',	0,	'',	'Caballero',	1),
(1107,	'087',	5207,	'',	0,	'',	'Chiquitos',	1),
(1108,	'088',	5207,	'',	0,	'',	'Cordillera (Bolivia)',	1),
(1109,	'089',	5207,	'',	0,	'',	'Florida',	1),
(1110,	'090',	5207,	'',	0,	'',	'Germ??n Busch',	1),
(1111,	'091',	5207,	'',	0,	'',	'Guarayos',	1),
(1112,	'092',	5207,	'',	0,	'',	'Ichilo',	1),
(1113,	'093',	5207,	'',	0,	'',	'Obispo Santistevan',	1),
(1114,	'094',	5207,	'',	0,	'',	'Sara',	1),
(1115,	'095',	5207,	'',	0,	'',	'Vallegrande',	1),
(1116,	'096',	5207,	'',	0,	'',	'Velasco',	1),
(1117,	'097',	5207,	'',	0,	'',	'Warnes',	1),
(1118,	'098',	5207,	'',	0,	'',	'??ngel Sand??val',	1),
(1119,	'099',	5207,	'',	0,	'',	'??uflo de Chaves',	1),
(1120,	'100',	5208,	'',	0,	'',	'Cercado (Beni)',	1),
(1121,	'101',	5208,	'',	0,	'',	'It??nez',	1),
(1122,	'102',	5208,	'',	0,	'',	'Mamor??',	1),
(1123,	'103',	5208,	'',	0,	'',	'Marb??n',	1),
(1124,	'104',	5208,	'',	0,	'',	'Moxos',	1),
(1125,	'105',	5208,	'',	0,	'',	'Vaca D??ez',	1),
(1126,	'106',	5208,	'',	0,	'',	'Yacuma',	1),
(1127,	'107',	5208,	'',	0,	'',	'General Jos?? Ballivi??n Segurola',	1),
(1128,	'108',	5209,	'',	0,	'',	'Abun??',	1),
(1129,	'109',	5209,	'',	0,	'',	'Madre de Dios',	1),
(1130,	'110',	5209,	'',	0,	'',	'Manuripi',	1),
(1131,	'111',	5209,	'',	0,	'',	'Nicol??s Su??rez',	1),
(1132,	'112',	5209,	'',	0,	'',	'General Federico Rom??n',	1),
(1133,	'VI',	419,	'01',	19,	'ALAVA',	'??lava',	1),
(1134,	'AB',	404,	'02',	4,	'ALBACETE',	'Albacete',	1),
(1135,	'A',	411,	'03',	11,	'ALICANTE',	'Alicante',	1),
(1136,	'AL',	401,	'04',	1,	'ALMERIA',	'Almer??a',	1),
(1137,	'O',	418,	'33',	18,	'ASTURIAS',	'Asturias',	1),
(1138,	'AV',	403,	'05',	3,	'AVILA',	'??vila',	1),
(1139,	'BA',	412,	'06',	12,	'BADAJOZ',	'Badajoz',	1),
(1140,	'B',	406,	'08',	6,	'BARCELONA',	'Barcelona',	1),
(1141,	'BU',	403,	'09',	8,	'BURGOS',	'Burgos',	1),
(1142,	'CC',	412,	'10',	12,	'CACERES',	'C??ceres',	1),
(1143,	'CA',	401,	'11',	1,	'CADIZ',	'C??diz',	1),
(1144,	'S',	410,	'39',	10,	'CANTABRIA',	'Cantabria',	1),
(1145,	'CS',	411,	'12',	11,	'CASTELLON',	'Castell??n',	1),
(1146,	'CE',	407,	'51',	7,	'CEUTA',	'Ceuta',	1),
(1147,	'CR',	404,	'13',	4,	'CIUDAD REAL',	'Ciudad Real',	1),
(1148,	'CO',	401,	'14',	1,	'CORDOBA',	'C??rdoba',	1),
(1149,	'CU',	404,	'16',	4,	'CUENCA',	'Cuenca',	1),
(1150,	'GI',	406,	'17',	6,	'GERONA',	'Gerona',	1),
(1151,	'GR',	401,	'18',	1,	'GRANADA',	'Granada',	1),
(1152,	'GU',	404,	'19',	4,	'GUADALAJARA',	'Guadalajara',	1),
(1153,	'SS',	419,	'20',	19,	'GUIPUZCOA',	'Guip??zcoa',	1),
(1154,	'H',	401,	'21',	1,	'HUELVA',	'Huelva',	1),
(1155,	'HU',	402,	'22',	2,	'HUESCA',	'Huesca',	1),
(1156,	'PM',	414,	'07',	14,	'ISLAS BALEARES',	'Islas Baleares',	1),
(1157,	'J',	401,	'23',	1,	'JAEN',	'Ja??n',	1),
(1158,	'C',	413,	'15',	13,	'LA CORU??A',	'La Coru??a',	1),
(1159,	'LO',	415,	'26',	15,	'LA RIOJA',	'La Rioja',	1),
(1160,	'GC',	405,	'35',	5,	'LAS PALMAS',	'Las Palmas',	1),
(1161,	'LE',	403,	'24',	3,	'LEON',	'Le??n',	1),
(1162,	'L',	406,	'25',	6,	'LERIDA',	'L??rida',	1),
(1163,	'LU',	413,	'27',	13,	'LUGO',	'Lugo',	1),
(1164,	'M',	416,	'28',	16,	'MADRID',	'Madrid',	1),
(1165,	'MA',	401,	'29',	1,	'MALAGA',	'M??laga',	1),
(1166,	'ML',	409,	'52',	9,	'MELILLA',	'Melilla',	1),
(1167,	'MU',	417,	'30',	17,	'MURCIA',	'Murcia',	1),
(1168,	'NA',	408,	'31',	8,	'NAVARRA',	'Navarra',	1),
(1169,	'OR',	413,	'32',	13,	'ORENSE',	'Orense',	1),
(1170,	'P',	403,	'34',	3,	'PALENCIA',	'Palencia',	1),
(1171,	'PO',	413,	'36',	13,	'PONTEVEDRA',	'Pontevedra',	1),
(1172,	'SA',	403,	'37',	3,	'SALAMANCA',	'Salamanca',	1),
(1173,	'TF',	405,	'38',	5,	'STA. CRUZ DE TENERIFE',	'Santa Cruz de Tenerife',	1),
(1174,	'SG',	403,	'40',	3,	'SEGOVIA',	'Segovia',	1),
(1175,	'SE',	401,	'41',	1,	'SEVILLA',	'Sevilla',	1),
(1176,	'SO',	403,	'42',	3,	'SORIA',	'Soria',	1),
(1177,	'T',	406,	'43',	6,	'TARRAGONA',	'Tarragona',	1),
(1178,	'TE',	402,	'44',	2,	'TERUEL',	'Teruel',	1),
(1179,	'TO',	404,	'45',	5,	'TOLEDO',	'Toledo',	1),
(1180,	'V',	411,	'46',	11,	'VALENCIA',	'Valencia',	1),
(1181,	'VA',	403,	'47',	3,	'VALLADOLID',	'Valladolid',	1),
(1182,	'BI',	419,	'48',	19,	'VIZCAYA',	'Vizcaya',	1),
(1183,	'ZA',	403,	'49',	3,	'ZAMORA',	'Zamora',	1),
(1184,	'Z',	402,	'50',	1,	'ZARAGOZA',	'Zaragoza',	1),
(1185,	'66',	10201,	'',	0,	'',	'??????????',	1),
(1186,	'67',	10205,	'',	0,	'',	'??????????',	1),
(1187,	'01',	10205,	'',	0,	'',	'??????????',	1),
(1188,	'02',	10205,	'',	0,	'',	'??????????',	1),
(1189,	'03',	10205,	'',	0,	'',	'????????????',	1),
(1190,	'04',	10205,	'',	0,	'',	'??????????',	1),
(1191,	'05',	10205,	'',	0,	'',	'????????????',	1),
(1192,	'06',	10203,	'',	0,	'',	'????????????',	1),
(1193,	'07',	10203,	'',	0,	'',	'??????????????????????',	1),
(1194,	'08',	10203,	'',	0,	'',	'????????????',	1),
(1195,	'09',	10203,	'',	0,	'',	'??????????',	1),
(1196,	'10',	10203,	'',	0,	'',	'????????????',	1),
(1197,	'11',	10203,	'',	0,	'',	'????????????',	1),
(1198,	'12',	10203,	'',	0,	'',	'??????????????????',	1),
(1199,	'13',	10206,	'',	0,	'',	'????????',	1),
(1200,	'14',	10206,	'',	0,	'',	'??????????????????',	1),
(1201,	'15',	10206,	'',	0,	'',	'????????????????',	1),
(1202,	'16',	10206,	'',	0,	'',	'??????????????',	1),
(1203,	'17',	10213,	'',	0,	'',	'??????????????',	1),
(1204,	'18',	10213,	'',	0,	'',	'????????????????',	1),
(1205,	'19',	10213,	'',	0,	'',	'????????????',	1),
(1206,	'20',	10213,	'',	0,	'',	'??????????????',	1),
(1207,	'21',	10212,	'',	0,	'',	'????????????????',	1),
(1208,	'22',	10212,	'',	0,	'',	'????????????',	1),
(1209,	'23',	10212,	'',	0,	'',	'????????????????',	1),
(1210,	'24',	10212,	'',	0,	'',	'??????????????',	1),
(1211,	'25',	10212,	'',	0,	'',	'????????????????',	1),
(1212,	'26',	10212,	'',	0,	'',	'??????????????',	1),
(1213,	'27',	10202,	'',	0,	'',	'????????????',	1),
(1214,	'28',	10202,	'',	0,	'',	'??????????????????',	1),
(1215,	'29',	10202,	'',	0,	'',	'????????????????',	1),
(1216,	'30',	10202,	'',	0,	'',	'????????????',	1),
(1217,	'31',	10209,	'',	0,	'',	'????????????????',	1),
(1218,	'32',	10209,	'',	0,	'',	'??????????????',	1),
(1219,	'33',	10209,	'',	0,	'',	'????????????????',	1),
(1220,	'34',	10209,	'',	0,	'',	'??????????????',	1),
(1221,	'35',	10209,	'',	0,	'',	'????????????????',	1),
(1222,	'36',	10211,	'',	0,	'',	'??????????????????????????????',	1),
(1223,	'37',	10211,	'',	0,	'',	'??????????',	1),
(1224,	'38',	10211,	'',	0,	'',	'??????????',	1),
(1225,	'39',	10207,	'',	0,	'',	'????????????????',	1),
(1226,	'40',	10207,	'',	0,	'',	'??????????????',	1),
(1227,	'41',	10207,	'',	0,	'',	'????????????????????',	1),
(1228,	'42',	10207,	'',	0,	'',	'??????????',	1),
(1229,	'43',	10207,	'',	0,	'',	'??????????????',	1),
(1230,	'44',	10208,	'',	0,	'',	'????????????',	1),
(1231,	'45',	10208,	'',	0,	'',	'????????????',	1),
(1232,	'46',	10208,	'',	0,	'',	'????????????',	1),
(1233,	'47',	10208,	'',	0,	'',	'??????????',	1),
(1234,	'48',	10208,	'',	0,	'',	'????????',	1),
(1235,	'49',	10210,	'',	0,	'',	'????????????',	1),
(1236,	'50',	10210,	'',	0,	'',	'????????',	1),
(1237,	'51',	10210,	'',	0,	'',	'????????????????',	1),
(1238,	'52',	10210,	'',	0,	'',	'????????????????',	1),
(1239,	'53',	10210,	'',	0,	'',	'??????-????????????',	1),
(1240,	'54',	10210,	'',	0,	'',	'????',	1),
(1241,	'55',	10210,	'',	0,	'',	'??????????',	1),
(1242,	'56',	10210,	'',	0,	'',	'??????????????',	1),
(1243,	'57',	10210,	'',	0,	'',	'??????????',	1),
(1244,	'58',	10210,	'',	0,	'',	'??????????',	1),
(1245,	'59',	10210,	'',	0,	'',	'??????????',	1),
(1246,	'60',	10210,	'',	0,	'',	'??????????',	1),
(1247,	'61',	10210,	'',	0,	'',	'??????????',	1),
(1248,	'62',	10204,	'',	0,	'',	'????????????????',	1),
(1249,	'63',	10204,	'',	0,	'',	'????????????',	1),
(1250,	'64',	10204,	'',	0,	'',	'??????????????',	1),
(1251,	'65',	10204,	'',	0,	'',	'??????????',	1),
(1252,	'AG',	601,	NULL,	NULL,	'ARGOVIE',	'Argovie',	1),
(1253,	'AI',	601,	NULL,	NULL,	'APPENZELL RHODES INTERIEURES',	'Appenzell Rhodes int??rieures',	1),
(1254,	'AR',	601,	NULL,	NULL,	'APPENZELL RHODES EXTERIEURES',	'Appenzell Rhodes ext??rieures',	1),
(1255,	'BE',	601,	NULL,	NULL,	'BERNE',	'Berne',	1),
(1256,	'BL',	601,	NULL,	NULL,	'BALE CAMPAGNE',	'B??le Campagne',	1),
(1257,	'BS',	601,	NULL,	NULL,	'BALE VILLE',	'B??le Ville',	1),
(1258,	'FR',	601,	NULL,	NULL,	'FRIBOURG',	'Fribourg',	1),
(1259,	'GE',	601,	NULL,	NULL,	'GENEVE',	'Gen??ve',	1),
(1260,	'GL',	601,	NULL,	NULL,	'GLARIS',	'Glaris',	1),
(1261,	'GR',	601,	NULL,	NULL,	'GRISONS',	'Grisons',	1),
(1262,	'JU',	601,	NULL,	NULL,	'JURA',	'Jura',	1),
(1263,	'LU',	601,	NULL,	NULL,	'LUCERNE',	'Lucerne',	1),
(1264,	'NE',	601,	NULL,	NULL,	'NEUCHATEL',	'Neuch??tel',	1),
(1265,	'NW',	601,	NULL,	NULL,	'NIDWALD',	'Nidwald',	1),
(1266,	'OW',	601,	NULL,	NULL,	'OBWALD',	'Obwald',	1),
(1267,	'SG',	601,	NULL,	NULL,	'SAINT-GALL',	'Saint-Gall',	1),
(1268,	'SH',	601,	NULL,	NULL,	'SCHAFFHOUSE',	'Schaffhouse',	1),
(1269,	'SO',	601,	NULL,	NULL,	'SOLEURE',	'Soleure',	1),
(1270,	'SZ',	601,	NULL,	NULL,	'SCHWYZ',	'Schwyz',	1),
(1271,	'TG',	601,	NULL,	NULL,	'THURGOVIE',	'Thurgovie',	1),
(1272,	'TI',	601,	NULL,	NULL,	'TESSIN',	'Tessin',	1),
(1273,	'UR',	601,	NULL,	NULL,	'URI',	'Uri',	1),
(1274,	'VD',	601,	NULL,	NULL,	'VAUD',	'Vaud',	1),
(1275,	'VS',	601,	NULL,	NULL,	'VALAIS',	'Valais',	1),
(1276,	'ZG',	601,	NULL,	NULL,	'ZUG',	'Zug',	1),
(1277,	'ZH',	601,	NULL,	NULL,	'ZURICH',	'Z??rich',	1),
(1278,	'701',	701,	NULL,	0,	NULL,	'Bedfordshire',	1),
(1279,	'702',	701,	NULL,	0,	NULL,	'Berkshire',	1),
(1280,	'703',	701,	NULL,	0,	NULL,	'Bristol, City of',	1),
(1281,	'704',	701,	NULL,	0,	NULL,	'Buckinghamshire',	1),
(1282,	'705',	701,	NULL,	0,	NULL,	'Cambridgeshire',	1),
(1283,	'706',	701,	NULL,	0,	NULL,	'Cheshire',	1),
(1284,	'707',	701,	NULL,	0,	NULL,	'Cleveland',	1),
(1285,	'708',	701,	NULL,	0,	NULL,	'Cornwall',	1),
(1286,	'709',	701,	NULL,	0,	NULL,	'Cumberland',	1),
(1287,	'710',	701,	NULL,	0,	NULL,	'Cumbria',	1),
(1288,	'711',	701,	NULL,	0,	NULL,	'Derbyshire',	1),
(1289,	'712',	701,	NULL,	0,	NULL,	'Devon',	1),
(1290,	'713',	701,	NULL,	0,	NULL,	'Dorset',	1),
(1291,	'714',	701,	NULL,	0,	NULL,	'Co. Durham',	1),
(1292,	'715',	701,	NULL,	0,	NULL,	'East Riding of Yorkshire',	1),
(1293,	'716',	701,	NULL,	0,	NULL,	'East Sussex',	1),
(1294,	'717',	701,	NULL,	0,	NULL,	'Essex',	1),
(1295,	'718',	701,	NULL,	0,	NULL,	'Gloucestershire',	1),
(1296,	'719',	701,	NULL,	0,	NULL,	'Greater Manchester',	1),
(1297,	'720',	701,	NULL,	0,	NULL,	'Hampshire',	1),
(1298,	'721',	701,	NULL,	0,	NULL,	'Hertfordshire',	1),
(1299,	'722',	701,	NULL,	0,	NULL,	'Hereford and Worcester',	1),
(1300,	'723',	701,	NULL,	0,	NULL,	'Herefordshire',	1),
(1301,	'724',	701,	NULL,	0,	NULL,	'Huntingdonshire',	1),
(1302,	'725',	701,	NULL,	0,	NULL,	'Isle of Man',	1),
(1303,	'726',	701,	NULL,	0,	NULL,	'Isle of Wight',	1),
(1304,	'727',	701,	NULL,	0,	NULL,	'Jersey',	1),
(1305,	'728',	701,	NULL,	0,	NULL,	'Kent',	1),
(1306,	'729',	701,	NULL,	0,	NULL,	'Lancashire',	1),
(1307,	'730',	701,	NULL,	0,	NULL,	'Leicestershire',	1),
(1308,	'731',	701,	NULL,	0,	NULL,	'Lincolnshire',	1),
(1309,	'732',	701,	NULL,	0,	NULL,	'London - City of London',	1),
(1310,	'733',	701,	NULL,	0,	NULL,	'Merseyside',	1),
(1311,	'734',	701,	NULL,	0,	NULL,	'Middlesex',	1),
(1312,	'735',	701,	NULL,	0,	NULL,	'Norfolk',	1),
(1313,	'736',	701,	NULL,	0,	NULL,	'North Yorkshire',	1),
(1314,	'737',	701,	NULL,	0,	NULL,	'North Riding of Yorkshire',	1),
(1315,	'738',	701,	NULL,	0,	NULL,	'Northamptonshire',	1),
(1316,	'739',	701,	NULL,	0,	NULL,	'Northumberland',	1),
(1317,	'740',	701,	NULL,	0,	NULL,	'Nottinghamshire',	1),
(1318,	'741',	701,	NULL,	0,	NULL,	'Oxfordshire',	1),
(1319,	'742',	701,	NULL,	0,	NULL,	'Rutland',	1),
(1320,	'743',	701,	NULL,	0,	NULL,	'Shropshire',	1),
(1321,	'744',	701,	NULL,	0,	NULL,	'Somerset',	1),
(1322,	'745',	701,	NULL,	0,	NULL,	'Staffordshire',	1),
(1323,	'746',	701,	NULL,	0,	NULL,	'Suffolk',	1),
(1324,	'747',	701,	NULL,	0,	NULL,	'Surrey',	1),
(1325,	'748',	701,	NULL,	0,	NULL,	'Sussex',	1),
(1326,	'749',	701,	NULL,	0,	NULL,	'Tyne and Wear',	1),
(1327,	'750',	701,	NULL,	0,	NULL,	'Warwickshire',	1),
(1328,	'751',	701,	NULL,	0,	NULL,	'West Midlands',	1),
(1329,	'752',	701,	NULL,	0,	NULL,	'West Sussex',	1),
(1330,	'753',	701,	NULL,	0,	NULL,	'West Yorkshire',	1),
(1331,	'754',	701,	NULL,	0,	NULL,	'West Riding of Yorkshire',	1),
(1332,	'755',	701,	NULL,	0,	NULL,	'Wiltshire',	1),
(1333,	'756',	701,	NULL,	0,	NULL,	'Worcestershire',	1),
(1334,	'757',	701,	NULL,	0,	NULL,	'Yorkshire',	1),
(1335,	'758',	702,	NULL,	0,	NULL,	'Anglesey',	1),
(1336,	'759',	702,	NULL,	0,	NULL,	'Breconshire',	1),
(1337,	'760',	702,	NULL,	0,	NULL,	'Caernarvonshire',	1),
(1338,	'761',	702,	NULL,	0,	NULL,	'Cardiganshire',	1),
(1339,	'762',	702,	NULL,	0,	NULL,	'Carmarthenshire',	1),
(1340,	'763',	702,	NULL,	0,	NULL,	'Ceredigion',	1),
(1341,	'764',	702,	NULL,	0,	NULL,	'Denbighshire',	1),
(1342,	'765',	702,	NULL,	0,	NULL,	'Flintshire',	1),
(1343,	'766',	702,	NULL,	0,	NULL,	'Glamorgan',	1),
(1344,	'767',	702,	NULL,	0,	NULL,	'Gwent',	1),
(1345,	'768',	702,	NULL,	0,	NULL,	'Gwynedd',	1),
(1346,	'769',	702,	NULL,	0,	NULL,	'Merionethshire',	1),
(1347,	'770',	702,	NULL,	0,	NULL,	'Monmouthshire',	1),
(1348,	'771',	702,	NULL,	0,	NULL,	'Mid Glamorgan',	1),
(1349,	'772',	702,	NULL,	0,	NULL,	'Montgomeryshire',	1),
(1350,	'773',	702,	NULL,	0,	NULL,	'Pembrokeshire',	1),
(1351,	'774',	702,	NULL,	0,	NULL,	'Powys',	1),
(1352,	'775',	702,	NULL,	0,	NULL,	'Radnorshire',	1),
(1353,	'776',	702,	NULL,	0,	NULL,	'South Glamorgan',	1),
(1354,	'777',	703,	NULL,	0,	NULL,	'Aberdeen, City of',	1),
(1355,	'778',	703,	NULL,	0,	NULL,	'Angus',	1),
(1356,	'779',	703,	NULL,	0,	NULL,	'Argyll',	1),
(1357,	'780',	703,	NULL,	0,	NULL,	'Ayrshire',	1),
(1358,	'781',	703,	NULL,	0,	NULL,	'Banffshire',	1),
(1359,	'782',	703,	NULL,	0,	NULL,	'Berwickshire',	1),
(1360,	'783',	703,	NULL,	0,	NULL,	'Bute',	1),
(1361,	'784',	703,	NULL,	0,	NULL,	'Caithness',	1),
(1362,	'785',	703,	NULL,	0,	NULL,	'Clackmannanshire',	1),
(1363,	'786',	703,	NULL,	0,	NULL,	'Dumfriesshire',	1),
(1364,	'787',	703,	NULL,	0,	NULL,	'Dumbartonshire',	1),
(1365,	'788',	703,	NULL,	0,	NULL,	'Dundee, City of',	1),
(1366,	'789',	703,	NULL,	0,	NULL,	'East Lothian',	1),
(1367,	'790',	703,	NULL,	0,	NULL,	'Fife',	1),
(1368,	'791',	703,	NULL,	0,	NULL,	'Inverness',	1),
(1369,	'792',	703,	NULL,	0,	NULL,	'Kincardineshire',	1),
(1370,	'793',	703,	NULL,	0,	NULL,	'Kinross-shire',	1),
(1371,	'794',	703,	NULL,	0,	NULL,	'Kirkcudbrightshire',	1),
(1372,	'795',	703,	NULL,	0,	NULL,	'Lanarkshire',	1),
(1373,	'796',	703,	NULL,	0,	NULL,	'Midlothian',	1),
(1374,	'797',	703,	NULL,	0,	NULL,	'Morayshire',	1),
(1375,	'798',	703,	NULL,	0,	NULL,	'Nairnshire',	1),
(1376,	'799',	703,	NULL,	0,	NULL,	'Orkney',	1),
(1377,	'800',	703,	NULL,	0,	NULL,	'Peebleshire',	1),
(1378,	'801',	703,	NULL,	0,	NULL,	'Perthshire',	1),
(1379,	'802',	703,	NULL,	0,	NULL,	'Renfrewshire',	1),
(1380,	'803',	703,	NULL,	0,	NULL,	'Ross & Cromarty',	1),
(1381,	'804',	703,	NULL,	0,	NULL,	'Roxburghshire',	1),
(1382,	'805',	703,	NULL,	0,	NULL,	'Selkirkshire',	1),
(1383,	'806',	703,	NULL,	0,	NULL,	'Shetland',	1),
(1384,	'807',	703,	NULL,	0,	NULL,	'Stirlingshire',	1),
(1385,	'808',	703,	NULL,	0,	NULL,	'Sutherland',	1),
(1386,	'809',	703,	NULL,	0,	NULL,	'West Lothian',	1),
(1387,	'810',	703,	NULL,	0,	NULL,	'Wigtownshire',	1),
(1388,	'811',	704,	NULL,	0,	NULL,	'Antrim',	1),
(1389,	'812',	704,	NULL,	0,	NULL,	'Armagh',	1),
(1390,	'813',	704,	NULL,	0,	NULL,	'Co. Down',	1),
(1391,	'814',	704,	NULL,	0,	NULL,	'Co. Fermanagh',	1),
(1392,	'815',	704,	NULL,	0,	NULL,	'Co. Londonderry',	1),
(1393,	'SS',	8601,	'',	0,	'',	'San Salvador',	1),
(1394,	'SA',	8603,	'',	0,	'',	'Santa Ana',	1),
(1395,	'AH',	8603,	'',	0,	'',	'Ahuachapan',	1),
(1396,	'SO',	8603,	'',	0,	'',	'Sonsonate',	1),
(1397,	'US',	8602,	'',	0,	'',	'Usulutan',	1),
(1398,	'SM',	8602,	'',	0,	'',	'San Miguel',	1),
(1399,	'MO',	8602,	'',	0,	'',	'Morazan',	1),
(1400,	'LU',	8602,	'',	0,	'',	'La Union',	1),
(1401,	'LL',	8601,	'',	0,	'',	'La Libertad',	1),
(1402,	'CH',	8601,	'',	0,	'',	'Chalatenango',	1),
(1403,	'CA',	8601,	'',	0,	'',	'Caba??as',	1),
(1404,	'LP',	8601,	'',	0,	'',	'La Paz',	1),
(1405,	'SV',	8601,	'',	0,	'',	'San Vicente',	1),
(1406,	'CU',	8601,	'',	0,	'',	'Cuscatlan',	1),
(1407,	'AN',	11701,	NULL,	0,	'AN',	'Andaman & Nicobar',	1),
(1408,	'AP',	11701,	NULL,	0,	'AP',	'Andhra Pradesh',	1),
(1409,	'AR',	11701,	NULL,	0,	'AR',	'Arunachal Pradesh',	1),
(1410,	'AS',	11701,	NULL,	0,	'AS',	'Assam',	1),
(1411,	'BR',	11701,	NULL,	0,	'BR',	'Bihar',	1),
(1412,	'CG',	11701,	NULL,	0,	'CG',	'Chattisgarh',	1),
(1413,	'CH',	11701,	NULL,	0,	'CH',	'Chandigarh',	1),
(1414,	'DD',	11701,	NULL,	0,	'DD',	'Daman & Diu',	1),
(1415,	'DL',	11701,	NULL,	0,	'DL',	'Delhi',	1),
(1416,	'DN',	11701,	NULL,	0,	'DN',	'Dadra and Nagar Haveli',	1),
(1417,	'GA',	11701,	NULL,	0,	'GA',	'Goa',	1),
(1418,	'GJ',	11701,	NULL,	0,	'GJ',	'Gujarat',	1),
(1419,	'HP',	11701,	NULL,	0,	'HP',	'Himachal Pradesh',	1),
(1420,	'HR',	11701,	NULL,	0,	'HR',	'Haryana',	1),
(1421,	'JH',	11701,	NULL,	0,	'JH',	'Jharkhand',	1),
(1422,	'JK',	11701,	NULL,	0,	'JK',	'Jammu & Kashmir',	1),
(1423,	'KA',	11701,	NULL,	0,	'KA',	'Karnataka',	1),
(1424,	'KL',	11701,	NULL,	0,	'KL',	'Kerala',	1),
(1425,	'LD',	11701,	NULL,	0,	'LD',	'Lakshadweep',	1),
(1426,	'MH',	11701,	NULL,	0,	'MH',	'Maharashtra',	1),
(1427,	'ML',	11701,	NULL,	0,	'ML',	'Meghalaya',	1),
(1428,	'MN',	11701,	NULL,	0,	'MN',	'Manipur',	1),
(1429,	'MP',	11701,	NULL,	0,	'MP',	'Madhya Pradesh',	1),
(1430,	'MZ',	11701,	NULL,	0,	'MZ',	'Mizoram',	1),
(1431,	'NL',	11701,	NULL,	0,	'NL',	'Nagaland',	1),
(1432,	'OR',	11701,	NULL,	0,	'OR',	'Orissa',	1),
(1433,	'PB',	11701,	NULL,	0,	'PB',	'Punjab',	1),
(1434,	'PY',	11701,	NULL,	0,	'PY',	'Puducherry',	1),
(1435,	'RJ',	11701,	NULL,	0,	'RJ',	'Rajasthan',	1),
(1436,	'SK',	11701,	NULL,	0,	'SK',	'Sikkim',	1),
(1437,	'TE',	11701,	NULL,	0,	'TE',	'Telangana',	1),
(1438,	'TN',	11701,	NULL,	0,	'TN',	'Tamil Nadu',	1),
(1439,	'TR',	11701,	NULL,	0,	'TR',	'Tripura',	1),
(1440,	'UL',	11701,	NULL,	0,	'UL',	'Uttarakhand',	1),
(1441,	'UP',	11701,	NULL,	0,	'UP',	'Uttar Pradesh',	1),
(1442,	'WB',	11701,	NULL,	0,	'WB',	'West Bengal',	1),
(1443,	'BA',	11801,	NULL,	0,	'BA',	'Bali',	1),
(1444,	'BB',	11801,	NULL,	0,	'BB',	'Bangka Belitung',	1),
(1445,	'BT',	11801,	NULL,	0,	'BT',	'Banten',	1),
(1446,	'BE',	11801,	NULL,	0,	'BA',	'Bengkulu',	1),
(1447,	'YO',	11801,	NULL,	0,	'YO',	'DI Yogyakarta',	1),
(1448,	'JK',	11801,	NULL,	0,	'JK',	'DKI Jakarta',	1),
(1449,	'GO',	11801,	NULL,	0,	'GO',	'Gorontalo',	1),
(1450,	'JA',	11801,	NULL,	0,	'JA',	'Jambi',	1),
(1451,	'JB',	11801,	NULL,	0,	'JB',	'Jawa Barat',	1),
(1452,	'JT',	11801,	NULL,	0,	'JT',	'Jawa Tengah',	1),
(1453,	'JI',	11801,	NULL,	0,	'JI',	'Jawa Timur',	1),
(1454,	'KB',	11801,	NULL,	0,	'KB',	'Kalimantan Barat',	1),
(1455,	'KS',	11801,	NULL,	0,	'KS',	'Kalimantan Selatan',	1),
(1456,	'KT',	11801,	NULL,	0,	'KT',	'Kalimantan Tengah',	1),
(1457,	'KI',	11801,	NULL,	0,	'KI',	'Kalimantan Timur',	1),
(1458,	'KU',	11801,	NULL,	0,	'KU',	'Kalimantan Utara',	1),
(1459,	'KR',	11801,	NULL,	0,	'KR',	'Kepulauan Riau',	1),
(1460,	'LA',	11801,	NULL,	0,	'LA',	'Lampung',	1),
(1461,	'MA',	11801,	NULL,	0,	'MA',	'Maluku',	1),
(1462,	'MU',	11801,	NULL,	0,	'MU',	'Maluku Utara',	1),
(1463,	'AC',	11801,	NULL,	0,	'AC',	'Nanggroe Aceh Darussalam',	1),
(1464,	'NB',	11801,	NULL,	0,	'NB',	'Nusa Tenggara Barat',	1),
(1465,	'NT',	11801,	NULL,	0,	'NT',	'Nusa Tenggara Timur',	1),
(1466,	'PA',	11801,	NULL,	0,	'PA',	'Papua',	1),
(1467,	'PB',	11801,	NULL,	0,	'PB',	'Papua Barat',	1),
(1468,	'RI',	11801,	NULL,	0,	'RI',	'Riau',	1),
(1469,	'SR',	11801,	NULL,	0,	'SR',	'Sulawesi Barat',	1),
(1470,	'SN',	11801,	NULL,	0,	'SN',	'Sulawesi Selatan',	1),
(1471,	'ST',	11801,	NULL,	0,	'ST',	'Sulawesi Tengah',	1),
(1472,	'SG',	11801,	NULL,	0,	'SG',	'Sulawesi Tenggara',	1),
(1473,	'SA',	11801,	NULL,	0,	'SA',	'Sulawesi Utara',	1),
(1474,	'SB',	11801,	NULL,	0,	'SB',	'Sumatera Barat',	1),
(1475,	'SS',	11801,	NULL,	0,	'SS',	'Sumatera Selatan',	1),
(1476,	'SU',	11801,	NULL,	0,	'SU',	'Sumatera Utara	',	1),
(1477,	'CMX',	15401,	'',	0,	'CMX',	'Ciudad de M??xico',	1),
(1478,	'AGS',	15401,	'',	0,	'AGS',	'Aguascalientes',	1),
(1479,	'BCN',	15401,	'',	0,	'BCN',	'Baja California Norte',	1),
(1480,	'BCS',	15401,	'',	0,	'BCS',	'Baja California Sur',	1),
(1481,	'CAM',	15401,	'',	0,	'CAM',	'Campeche',	1),
(1482,	'CHP',	15401,	'',	0,	'CHP',	'Chiapas',	1),
(1483,	'CHI',	15401,	'',	0,	'CHI',	'Chihuahua',	1),
(1484,	'COA',	15401,	'',	0,	'COA',	'Coahuila',	1),
(1485,	'COL',	15401,	'',	0,	'COL',	'Colima',	1),
(1486,	'DUR',	15401,	'',	0,	'DUR',	'Durango',	1),
(1487,	'GTO',	15401,	'',	0,	'GTO',	'Guanajuato',	1),
(1488,	'GRO',	15401,	'',	0,	'GRO',	'Guerrero',	1),
(1489,	'HGO',	15401,	'',	0,	'HGO',	'Hidalgo',	1),
(1490,	'JAL',	15401,	'',	0,	'JAL',	'Jalisco',	1),
(1491,	'MEX',	15401,	'',	0,	'MEX',	'M??xico',	1),
(1492,	'MIC',	15401,	'',	0,	'MIC',	'Michoac??n de Ocampo',	1),
(1493,	'MOR',	15401,	'',	0,	'MOR',	'Morelos',	1),
(1494,	'NAY',	15401,	'',	0,	'NAY',	'Nayarit',	1),
(1495,	'NLE',	15401,	'',	0,	'NLE',	'Nuevo Le??n',	1),
(1496,	'OAX',	15401,	'',	0,	'OAX',	'Oaxaca',	1),
(1497,	'PUE',	15401,	'',	0,	'PUE',	'Puebla',	1),
(1498,	'QRO',	15401,	'',	0,	'QRO',	'Quer??taro',	1),
(1499,	'ROO',	15401,	'',	0,	'ROO',	'Quintana Roo',	1),
(1500,	'SLP',	15401,	'',	0,	'SLP',	'San Luis Potos??',	1),
(1501,	'SIN',	15401,	'',	0,	'SIN',	'Sinaloa',	1),
(1502,	'SON',	15401,	'',	0,	'SON',	'Sonora',	1),
(1503,	'TAB',	15401,	'',	0,	'TAB',	'Tabasco',	1),
(1504,	'TAM',	15401,	'',	0,	'TAM',	'Tamaulipas',	1),
(1505,	'TLX',	15401,	'',	0,	'TLX',	'Tlaxcala',	1),
(1506,	'VER',	15401,	'',	0,	'VER',	'Veracruz',	1),
(1507,	'YUC',	15401,	'',	0,	'YUC',	'Yucat??n',	1),
(1508,	'ZAC',	15401,	'',	0,	'ZAC',	'Zacatecas',	1),
(1509,	'VE-L',	23201,	'',	0,	'VE-L',	'M??rida',	1),
(1510,	'VE-T',	23201,	'',	0,	'VE-T',	'Trujillo',	1),
(1511,	'VE-E',	23201,	'',	0,	'VE-E',	'Barinas',	1),
(1512,	'VE-M',	23202,	'',	0,	'VE-M',	'Miranda',	1),
(1513,	'VE-W',	23202,	'',	0,	'VE-W',	'Vargas',	1),
(1514,	'VE-A',	23202,	'',	0,	'VE-A',	'Distrito Capital',	1),
(1515,	'VE-D',	23203,	'',	0,	'VE-D',	'Aragua',	1),
(1516,	'VE-G',	23203,	'',	0,	'VE-G',	'Carabobo',	1),
(1517,	'VE-I',	23204,	'',	0,	'VE-I',	'Falc??n',	1),
(1518,	'VE-K',	23204,	'',	0,	'VE-K',	'Lara',	1),
(1519,	'VE-U',	23204,	'',	0,	'VE-U',	'Yaracuy',	1),
(1520,	'VE-F',	23205,	'',	0,	'VE-F',	'Bol??var',	1),
(1521,	'VE-X',	23205,	'',	0,	'VE-X',	'Amazonas',	1),
(1522,	'VE-Y',	23205,	'',	0,	'VE-Y',	'Delta Amacuro',	1),
(1523,	'VE-O',	23206,	'',	0,	'VE-O',	'Nueva Esparta',	1),
(1524,	'VE-Z',	23206,	'',	0,	'VE-Z',	'Dependencias Federales',	1),
(1525,	'VE-C',	23207,	'',	0,	'VE-C',	'Apure',	1),
(1526,	'VE-J',	23207,	'',	0,	'VE-J',	'Gu??rico',	1),
(1527,	'VE-H',	23207,	'',	0,	'VE-H',	'Cojedes',	1),
(1528,	'VE-P',	23207,	'',	0,	'VE-P',	'Portuguesa',	1),
(1529,	'VE-B',	23208,	'',	0,	'VE-B',	'Anzo??tegui',	1),
(1530,	'VE-N',	23208,	'',	0,	'VE-N',	'Monagas',	1),
(1531,	'VE-R',	23208,	'',	0,	'VE-R',	'Sucre',	1),
(1532,	'VE-V',	23209,	'',	0,	'VE-V',	'Zulia',	1),
(1533,	'VE-S',	23209,	'',	0,	'VE-S',	'T??chira',	1),
(1534,	'AE-1',	22701,	'',	0,	'',	'Abu Dhabi',	1),
(1535,	'AE-2',	22701,	'',	0,	'',	'Dubai',	1),
(1536,	'AE-3',	22701,	'',	0,	'',	'Ajman',	1),
(1537,	'AE-4',	22701,	'',	0,	'',	'Fujairah',	1),
(1538,	'AE-5',	22701,	'',	0,	'',	'Ras al-Khaimah',	1),
(1539,	'AE-6',	22701,	'',	0,	'',	'Sharjah',	1),
(1540,	'AE-7',	22701,	'',	0,	'',	'Umm al-Quwain',	1);

DROP TABLE IF EXISTS `llx_c_ecotaxe`;
CREATE TABLE `llx_c_ecotaxe` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `label` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `price` double(24,8) DEFAULT NULL,
  `organization` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_pays` int(11) NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_c_ecotaxe` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_c_ecotaxe` (`rowid`, `code`, `label`, `price`, `organization`, `fk_pays`, `active`) VALUES
(1,	'25040',	'PETIT APPAREILS MENAGERS',	0.25000000,	'Eco-syst??mes',	1,	1),
(2,	'25050',	'TRES PETIT APPAREILS MENAGERS',	0.08000000,	'Eco-syst??mes',	1,	1),
(3,	'32070',	'ECRAN POIDS < 5 KG',	2.08000000,	'Eco-syst??mes',	1,	1),
(4,	'32080',	'ECRAN POIDS > 5 KG',	1.25000000,	'Eco-syst??mes',	1,	1),
(5,	'32051',	'ORDINATEUR PORTABLE',	0.42000000,	'Eco-syst??mes',	1,	1),
(6,	'32061',	'TABLETTE INFORMATIQUE',	0.84000000,	'Eco-syst??mes',	1,	1),
(7,	'36011',	'ORDINATEUR FIXE (UC)',	1.15000000,	'Eco-syst??mes',	1,	1),
(8,	'36021',	'IMPRIMANTES',	0.83000000,	'Eco-syst??mes',	1,	1),
(9,	'36030',	'IT (INFORMATIQUE ET TELECOMS)',	0.83000000,	'Eco-syst??mes',	1,	1),
(10,	'36040',	'PETIT IT (CLAVIERS / SOURIS)',	0.08000000,	'Eco-syst??mes',	1,	1),
(11,	'36050',	'TELEPHONIE MOBILE',	0.02000000,	'Eco-syst??mes',	1,	1),
(12,	'36060',	'CONNECTIQUE CABLES',	0.02000000,	'Eco-syst??mes',	1,	1),
(13,	'45010',	'GROS MATERIEL GRAND PUBLIC (TELEAGRANDISSEURS)',	1.67000000,	'Eco-syst??mes',	1,	1),
(14,	'45020',	'MOYEN MATERIEL GRAND PUBLIC (LOUPES ELECTRONIQUES)',	0.42000000,	'Eco-syst??mes',	1,	1),
(15,	'45030',	'PETIT MATERIEL GRAND PUBLIC (VIE QUOTIDIENNE)',	0.08000000,	'Eco-syst??mes',	1,	1),
(16,	'75030',	'JOUETS < 0,5 KG',	0.08000000,	'Eco-syst??mes',	1,	1),
(17,	'75040',	'JOUETS ENTRE 0,5 KG ET 10 KG',	0.17000000,	'Eco-syst??mes',	1,	1),
(18,	'74050',	'JOUETS > 10 KG',	1.67000000,	'Eco-syst??mes',	1,	1),
(19,	'85010',	'EQUIPEMENT MEDICAL < 0,5 KG',	0.08000000,	'Eco-syst??mes',	1,	1);

DROP TABLE IF EXISTS `llx_c_effectif`;
CREATE TABLE `llx_c_effectif` (
  `id` int(11) NOT NULL,
  `code` varchar(12) COLLATE utf8_unicode_ci NOT NULL,
  `libelle` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `module` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_c_effectif` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_c_effectif` (`id`, `code`, `libelle`, `active`, `module`) VALUES
(0,	'EF0',	'-',	1,	NULL),
(1,	'EF1-5',	'1 - 5',	1,	NULL),
(2,	'EF6-10',	'6 - 10',	1,	NULL),
(3,	'EF11-50',	'11 - 50',	1,	NULL),
(4,	'EF51-100',	'51 - 100',	1,	NULL),
(5,	'EF100-500',	'100 - 500',	1,	NULL),
(6,	'EF500-',	'> 500',	1,	NULL);

DROP TABLE IF EXISTS `llx_c_email_senderprofile`;
CREATE TABLE `llx_c_email_senderprofile` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `private` smallint(6) NOT NULL DEFAULT '0',
  `date_creation` datetime DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `label` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `signature` text COLLATE utf8_unicode_ci,
  `position` smallint(6) DEFAULT '0',
  `active` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_c_email_senderprofile` (`entity`,`label`,`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_c_email_templates`;
CREATE TABLE `llx_c_email_templates` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `module` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type_template` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lang` varchar(6) COLLATE utf8_unicode_ci DEFAULT '',
  `private` smallint(6) NOT NULL DEFAULT '0',
  `fk_user` int(11) DEFAULT NULL,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `label` varchar(180) COLLATE utf8_unicode_ci DEFAULT NULL,
  `position` smallint(6) DEFAULT NULL,
  `enabled` varchar(255) COLLATE utf8_unicode_ci DEFAULT '1',
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `topic` text COLLATE utf8_unicode_ci,
  `joinfiles` text COLLATE utf8_unicode_ci,
  `content` mediumtext COLLATE utf8_unicode_ci,
  `content_lines` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_c_email_templates` (`entity`,`label`,`lang`),
  KEY `idx_type` (`type_template`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_c_email_templates` (`rowid`, `entity`, `module`, `type_template`, `lang`, `private`, `fk_user`, `datec`, `tms`, `label`, `position`, `enabled`, `active`, `topic`, `joinfiles`, `content`, `content_lines`) VALUES
(1,	0,	'banque',	'thirdparty',	'',	0,	NULL,	NULL,	'2022-09-06 10:05:27',	'(YourSEPAMandate)',	1,	'$conf->societe->enabled && $conf->banque->enabled && $conf->prelevement->enabled',	0,	'__(YourSEPAMandate)__',	'0',	'__(Hello)__,<br><br>\n\n__(FindYourSEPAMandate)__ :<br>\n__MYCOMPANY_NAME__<br>\n__MYCOMPANY_FULLADDRESS__<br><br>\n__(Sincerely)__<br>\n__USER_SIGNATURE__',	NULL),
(2,	0,	'adherent',	'member',	'',	0,	NULL,	NULL,	'2022-09-06 10:05:27',	'(SendingEmailOnAutoSubscription)',	10,	'$conf->adherent->enabled',	1,	'[__[MAIN_INFO_SOCIETE_NOM]__] __(YourMembershipRequestWasReceived)__',	'0',	'__(Hello)__ __MEMBER_FULLNAME__,<br><br>\n\n__(ThisIsContentOfYourMembershipRequestWasReceived)__<br>\n<br>__ONLINE_PAYMENT_TEXT_AND_URL__<br>\n<br><br>\n__(Sincerely)__<br>__USER_SIGNATURE__',	NULL),
(3,	0,	'adherent',	'member',	'',	0,	NULL,	NULL,	'2022-09-06 10:05:27',	'(SendingEmailOnMemberValidation)',	20,	'$conf->adherent->enabled',	1,	'[__[MAIN_INFO_SOCIETE_NOM]__] __(YourMembershipWasValidated)__',	'0',	'__(Hello)__ __MEMBER_FULLNAME__,<br><br>\n\n__(ThisIsContentOfYourMembershipWasValidated)__<br>__(FirstName)__ : __MEMBER_FIRSTNAME__<br>__(LastName)__ : __MEMBER_LASTNAME__<br>__(ID)__ : __MEMBER_ID__<br>\n<br>__ONLINE_PAYMENT_TEXT_AND_URL__<br>\n<br><br>\n__(Sincerely)__<br>__USER_SIGNATURE__',	NULL),
(4,	0,	'adherent',	'member',	'',	0,	NULL,	NULL,	'2022-09-06 10:05:27',	'(SendingEmailOnNewSubscription)',	30,	'$conf->adherent->enabled',	1,	'[__[MAIN_INFO_SOCIETE_NOM]__] __(YourSubscriptionWasRecorded)__',	'1',	'__(Hello)__ __MEMBER_FULLNAME__,<br><br>\n\n__(ThisIsContentOfYourSubscriptionWasRecorded)__<br>\n\n<br><br>\n__(Sincerely)__<br>__USER_SIGNATURE__',	NULL),
(5,	0,	'adherent',	'member',	'',	0,	NULL,	NULL,	'2022-09-06 10:05:27',	'(SendingReminderForExpiredSubscription)',	40,	'$conf->adherent->enabled',	1,	'[__[MAIN_INFO_SOCIETE_NOM]__] __(SubscriptionReminderEmail)__',	'0',	'__(Hello)__ __MEMBER_FULLNAME__,<br><br>\n\n__(ThisIsContentOfSubscriptionReminderEmail)__<br>\n<br>__ONLINE_PAYMENT_TEXT_AND_URL__<br>\n<br><br>\n__(Sincerely)__<br>__USER_SIGNATURE__',	NULL),
(6,	0,	'adherent',	'member',	'',	0,	NULL,	NULL,	'2022-09-06 10:05:27',	'(SendingEmailOnCancelation)',	50,	'$conf->adherent->enabled',	1,	'[__[MAIN_INFO_SOCIETE_NOM]__] __(YourMembershipWasCanceled)__',	'0',	'__(Hello)__ __MEMBER_FULLNAME__,<br><br>\n\n__(YourMembershipWasCanceled)__<br>\n<br><br>\n__(Sincerely)__<br>__USER_SIGNATURE__',	NULL),
(7,	0,	'adherent',	'member',	'',	0,	NULL,	NULL,	'2022-09-06 10:05:27',	'(SendingAnEMailToMember)',	60,	'$conf->adherent->enabled',	1,	'[__[MAIN_INFO_SOCIETE_NOM]__] __(CardContent)__',	'0',	'__(Hello)__,<br><br>\n\n__(ThisIsContentOfYourCard)__<br>\n__(ID)__ : __ID__<br>\n__(Civility)__ : __MEMBER_CIVILITY__<br>\n__(Firstname)__ : __MEMBER_FIRSTNAME__<br>\n__(Lastname)__ : __MEMBER_LASTNAME__<br>\n__(Fullname)__ : __MEMBER_FULLNAME__<br>\n__(Company)__ : __MEMBER_COMPANY__<br>\n__(Address)__ : __MEMBER_ADDRESS__<br>\n__(Zip)__ : __MEMBER_ZIP__<br>\n__(Town)__ : __MEMBER_TOWN__<br>\n__(Country)__ : __MEMBER_COUNTRY__<br>\n__(Email)__ : __MEMBER_EMAIL__<br>\n__(Birthday)__ : __MEMBER_BIRTH__<br>\n__(Photo)__ : __MEMBER_PHOTO__<br>\n__(Login)__ : __MEMBER_LOGIN__<br>\n__(Phone)__ : __MEMBER_PHONE__<br>\n__(PhonePerso)__ : __MEMBER_PHONEPRO__<br>\n__(PhoneMobile)__ : __MEMBER_PHONEMOBILE__<br><br>\n__(Sincerely)__<br>__USER_SIGNATURE__',	NULL),
(8,	0,	'recruitment',	'recruitmentcandidature_send',	'',	0,	NULL,	NULL,	'2022-09-06 10:05:27',	'(AnswerCandidature)',	100,	'$conf->recruitment->enabled',	1,	'[__[MAIN_INFO_SOCIETE_NOM]__] __(YourCandidature)__',	'0',	'__(Hello)__ __CANDIDATE_FULLNAME__,<br><br>\n\n__(YourCandidatureAnswerMessage)__<br>__ONLINE_INTERVIEW_SCHEDULER_TEXT_AND_URL__\n<br><br>\n__(Sincerely)__<br>__USER_SIGNATURE__',	NULL),
(9,	0,	'',	'conferenceorbooth',	'',	0,	NULL,	NULL,	'2022-09-06 10:05:27',	'(EventOrganizationEmailAskConf)',	10,	'1',	1,	'[__[MAIN_INFO_SOCIETE_NOM]__] __(EventOrganizationEmailAskConf)__',	NULL,	'__(Hello)__,<br /><br />__(OrganizationEventConfRequestWasReceived)__<br /><br /><br />__(Sincerely)__<br />__USER_SIGNATURE__',	NULL),
(10,	0,	'',	'conferenceorbooth',	'',	0,	NULL,	NULL,	'2022-09-06 10:05:27',	'(EventOrganizationEmailAskBooth)',	20,	'1',	1,	'[__[MAIN_INFO_SOCIETE_NOM]__] __(EventOrganizationEmailAskBooth)__',	NULL,	'__(Hello)__,<br /><br />__(OrganizationEventBoothRequestWasReceived)__<br /><br /><br />__(Sincerely)__<br />__USER_SIGNATURE__',	NULL),
(11,	0,	'',	'conferenceorbooth',	'',	0,	NULL,	NULL,	'2022-09-06 10:05:27',	'(EventOrganizationEmailSubsBooth)',	30,	'1',	1,	'[__[MAIN_INFO_SOCIETE_NOM]__] __(EventOrganizationEmailBoothPayment)__',	NULL,	'__(Hello)__,<br /><br />__(OrganizationEventPaymentOfBoothWasReceived)__<br /><br /><br />__(Sincerely)__<br />__USER_SIGNATURE__',	NULL),
(12,	0,	'',	'conferenceorbooth',	'',	0,	NULL,	NULL,	'2022-09-06 10:05:27',	'(EventOrganizationEmailSubsEvent)',	40,	'1',	1,	'[__[MAIN_INFO_SOCIETE_NOM]__] __(EventOrganizationEmailRegistrationPayment)__',	NULL,	'__(Hello)__,<br /><br />__(OrganizationEventPaymentOfRegistrationWasReceived)__<br /><br />__(Sincerely)__<br />__USER_SIGNATURE__',	NULL),
(13,	0,	'',	'conferenceorbooth',	'',	0,	NULL,	NULL,	'2022-09-06 10:05:27',	'(EventOrganizationMassEmailAttendees)',	50,	'1',	1,	'[__[MAIN_INFO_SOCIETE_NOM]__] __(EventOrganizationMassEmailAttendees)__',	NULL,	'__(Hello)__,<br /><br />__(OrganizationEventBulkMailToAttendees)__<br /><br />__(Sincerely)__<br />__USER_SIGNATURE__',	NULL),
(14,	0,	'',	'conferenceorbooth',	'',	0,	NULL,	NULL,	'2022-09-06 10:05:27',	'(EventOrganizationMassEmailSpeakers)',	60,	'1',	1,	'[__[MAIN_INFO_SOCIETE_NOM]__] __(EventOrganizationMassEmailSpeakers)__',	NULL,	'__(Hello)__,<br /><br />__(OrganizationEventBulkMailToSpeakers)__<br /><br />__(Sincerely)__<br />__USER_SIGNATURE__',	NULL),
(15,	0,	'partnership',	'partnership_send',	'',	0,	NULL,	NULL,	'2022-09-06 10:05:27',	'(SendingEmailOnPartnershipWillSoonBeCanceled)',	100,	'1',	1,	'[__[MAIN_INFO_SOCIETE_NOM]__] - __(YourPartnershipWillSoonBeCanceledTopic)__',	'0',	'<body>\n <p>__(Hello)__,<br><br>\n__(YourPartnershipWillSoonBeCanceledContent)__</p>\n<br />\n\n<br />\n\n            __(Sincerely)__ <br />\n            __[MAIN_INFO_SOCIETE_NOM]__ <br />\n </body>\n',	NULL),
(16,	0,	'partnership',	'partnership_send',	'',	0,	NULL,	NULL,	'2022-09-06 10:05:27',	'(SendingEmailOnPartnershipCanceled)',	100,	'1',	1,	'[__[MAIN_INFO_SOCIETE_NOM]__] - __(YourPartnershipCanceledTopic)__',	'0',	'<body>\n <p>__(Hello)__,<br><br>\n__(YourPartnershipCanceledContent)__</p>\n<br />\n\n<br />\n\n            __(Sincerely)__ <br />\n            __[MAIN_INFO_SOCIETE_NOM]__ <br />\n </body>\n',	NULL),
(17,	0,	'partnership',	'partnership_send',	'',	0,	NULL,	NULL,	'2022-09-06 10:05:27',	'(SendingEmailOnPartnershipRefused)',	100,	'1',	1,	'[__[MAIN_INFO_SOCIETE_NOM]__] - __(YourPartnershipRefusedTopic)__',	'0',	'<body>\n <p>__(Hello)__,<br><br>\n__(YourPartnershipRefusedContent)__</p>\n<br />\n\n<br />\n\n            __(Sincerely)__ <br />\n            __[MAIN_INFO_SOCIETE_NOM]__ <br />\n </body>\n',	NULL),
(18,	0,	'partnership',	'partnership_send',	'',	0,	NULL,	NULL,	'2022-09-06 10:05:27',	'(SendingEmailOnPartnershipAccepted)',	100,	'1',	1,	'[__[MAIN_INFO_SOCIETE_NOM]__] - __(YourPartnershipAcceptedTopic)__',	'0',	'<body>\n <p>__(Hello)__,<br><br>\n__(YourPartnershipAcceptedContent)__</p>\n<br />\n\n<br />\n\n            __(Sincerely)__ <br />\n            __[MAIN_INFO_SOCIETE_NOM]__ <br />\n </body>\n',	NULL);

DROP TABLE IF EXISTS `llx_c_exp_tax_cat`;
CREATE TABLE `llx_c_exp_tax_cat` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(48) COLLATE utf8_unicode_ci NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `active` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_c_exp_tax_cat` (`rowid`, `label`, `entity`, `active`) VALUES
(1,	'ExpAutoCat',	1,	0),
(2,	'ExpCycloCat',	1,	0),
(3,	'ExpMotoCat',	1,	0),
(4,	'ExpAuto3CV',	1,	1),
(5,	'ExpAuto4CV',	1,	1),
(6,	'ExpAuto5CV',	1,	1),
(7,	'ExpAuto6CV',	1,	1),
(8,	'ExpAuto7CV',	1,	1),
(9,	'ExpAuto8CV',	1,	1),
(10,	'ExpAuto9CV',	1,	0),
(11,	'ExpAuto10CV',	1,	0),
(12,	'ExpAuto11CV',	1,	0),
(13,	'ExpAuto12CV',	1,	0),
(14,	'ExpAuto3PCV',	1,	0),
(15,	'ExpAuto4PCV',	1,	0),
(16,	'ExpAuto5PCV',	1,	0),
(17,	'ExpAuto6PCV',	1,	0),
(18,	'ExpAuto7PCV',	1,	0),
(19,	'ExpAuto8PCV',	1,	0),
(20,	'ExpAuto9PCV',	1,	0),
(21,	'ExpAuto10PCV',	1,	0),
(22,	'ExpAuto11PCV',	1,	0),
(23,	'ExpAuto12PCV',	1,	0),
(24,	'ExpAuto13PCV',	1,	0),
(25,	'ExpCyclo',	1,	0),
(26,	'ExpMoto12CV',	1,	0),
(27,	'ExpMoto345CV',	1,	0),
(28,	'ExpMoto5PCV',	1,	0);

DROP TABLE IF EXISTS `llx_c_exp_tax_range`;
CREATE TABLE `llx_c_exp_tax_range` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_c_exp_tax_cat` int(11) NOT NULL DEFAULT '1',
  `range_ik` double NOT NULL DEFAULT '0',
  `entity` int(11) NOT NULL DEFAULT '1',
  `active` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_c_exp_tax_range` (`rowid`, `fk_c_exp_tax_cat`, `range_ik`, `entity`, `active`) VALUES
(1,	4,	0,	1,	1),
(2,	4,	5000,	1,	1),
(3,	4,	20000,	1,	1),
(4,	5,	0,	1,	1),
(5,	5,	5000,	1,	1),
(6,	5,	20000,	1,	1),
(7,	6,	0,	1,	1),
(8,	6,	5000,	1,	1),
(9,	6,	20000,	1,	1),
(10,	7,	0,	1,	1),
(11,	7,	5000,	1,	1),
(12,	7,	20000,	1,	1),
(13,	8,	0,	1,	1),
(14,	8,	5000,	1,	1),
(15,	8,	20000,	1,	1);

DROP TABLE IF EXISTS `llx_c_field_list`;
CREATE TABLE `llx_c_field_list` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `element` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `name` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `alias` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `align` varchar(6) COLLATE utf8_unicode_ci DEFAULT 'left',
  `sort` tinyint(4) NOT NULL DEFAULT '1',
  `search` tinyint(4) NOT NULL DEFAULT '0',
  `visible` tinyint(4) NOT NULL DEFAULT '1',
  `enabled` varchar(255) COLLATE utf8_unicode_ci DEFAULT '1',
  `rang` int(11) DEFAULT '0',
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_c_format_cards`;
CREATE TABLE `llx_c_format_cards` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `paper_size` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `orientation` varchar(1) COLLATE utf8_unicode_ci NOT NULL,
  `metric` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `leftmargin` double(24,8) NOT NULL,
  `topmargin` double(24,8) NOT NULL,
  `nx` int(11) NOT NULL,
  `ny` int(11) NOT NULL,
  `spacex` double(24,8) NOT NULL,
  `spacey` double(24,8) NOT NULL,
  `width` double(24,8) NOT NULL,
  `height` double(24,8) NOT NULL,
  `font_size` int(11) NOT NULL,
  `custom_x` double(24,8) NOT NULL,
  `custom_y` double(24,8) NOT NULL,
  `active` int(11) NOT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_c_format_cards` (`rowid`, `code`, `name`, `paper_size`, `orientation`, `metric`, `leftmargin`, `topmargin`, `nx`, `ny`, `spacex`, `spacey`, `width`, `height`, `font_size`, `custom_x`, `custom_y`, `active`) VALUES
(1,	'5160',	'Avery-5160, WL-875WX',	'letter',	'P',	'mm',	5.58165000,	12.70000000,	3,	10,	3.55600000,	0.00000000,	65.87490000,	25.40000000,	7,	0.00000000,	0.00000000,	1),
(2,	'5161',	'Avery-5161, WL-75WX',	'letter',	'P',	'mm',	4.44500000,	12.70000000,	2,	10,	3.96800000,	0.00000000,	101.60000000,	25.40000000,	7,	0.00000000,	0.00000000,	1),
(3,	'5162',	'Avery-5162, WL-100WX',	'letter',	'P',	'mm',	3.87350000,	22.35200000,	2,	7,	4.95400000,	0.00000000,	101.60000000,	33.78100000,	8,	0.00000000,	0.00000000,	1),
(4,	'5163',	'Avery-5163, WL-125WX',	'letter',	'P',	'mm',	4.57200000,	12.70000000,	2,	5,	3.55600000,	0.00000000,	101.60000000,	50.80000000,	10,	0.00000000,	0.00000000,	1),
(5,	'5164',	'Avery-5164 (inch)',	'letter',	'P',	'in',	0.14800000,	0.50000000,	2,	3,	0.20310000,	0.00000000,	4.00000000,	3.33000000,	12,	0.00000000,	0.00000000,	0),
(6,	'8600',	'Avery-8600',	'letter',	'P',	'mm',	7.10000000,	19.00000000,	3,	10,	9.50000000,	3.10000000,	66.60000000,	25.40000000,	7,	0.00000000,	0.00000000,	1),
(7,	'99012',	'DYMO 99012 89*36mm',	'custom',	'L',	'mm',	1.00000000,	1.00000000,	1,	1,	0.00000000,	0.00000000,	36.00000000,	89.00000000,	10,	36.00000000,	89.00000000,	1),
(8,	'99014',	'DYMO 99014 101*54mm',	'custom',	'L',	'mm',	1.00000000,	1.00000000,	1,	1,	0.00000000,	0.00000000,	54.00000000,	101.00000000,	10,	54.00000000,	101.00000000,	1),
(9,	'AVERYC32010',	'Avery-C32010',	'A4',	'P',	'mm',	15.00000000,	13.00000000,	2,	5,	10.00000000,	0.00000000,	85.00000000,	54.00000000,	10,	0.00000000,	0.00000000,	1),
(10,	'CARD',	'Dolibarr Business cards',	'A4',	'P',	'mm',	15.00000000,	15.00000000,	2,	5,	0.00000000,	0.00000000,	85.00000000,	54.00000000,	10,	0.00000000,	0.00000000,	1),
(11,	'L7163',	'Avery-L7163',	'A4',	'P',	'mm',	5.00000000,	15.00000000,	2,	7,	2.50000000,	0.00000000,	99.10000000,	38.10000000,	8,	0.00000000,	0.00000000,	1);

DROP TABLE IF EXISTS `llx_c_forme_juridique`;
CREATE TABLE `llx_c_forme_juridique` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `code` int(11) NOT NULL,
  `fk_pays` int(11) NOT NULL,
  `libelle` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `isvatexempted` tinyint(4) NOT NULL DEFAULT '0',
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `module` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `position` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_c_forme_juridique` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_c_forme_juridique` (`rowid`, `code`, `fk_pays`, `libelle`, `isvatexempted`, `active`, `module`, `position`) VALUES
(1,	0,	0,	'-',	0,	1,	NULL,	0),
(2,	2301,	23,	'Monotributista',	0,	1,	NULL,	0),
(3,	2302,	23,	'Sociedad Civil',	0,	1,	NULL,	0),
(4,	2303,	23,	'Sociedades Comerciales',	0,	1,	NULL,	0),
(5,	2304,	23,	'Sociedades de Hecho',	0,	1,	NULL,	0),
(6,	2305,	23,	'Sociedades Irregulares',	0,	1,	NULL,	0),
(7,	2306,	23,	'Sociedad Colectiva',	0,	1,	NULL,	0),
(8,	2307,	23,	'Sociedad en Comandita Simple',	0,	1,	NULL,	0),
(9,	2308,	23,	'Sociedad de Capital e Industria',	0,	1,	NULL,	0),
(10,	2309,	23,	'Sociedad Accidental o en participaci??n',	0,	1,	NULL,	0),
(11,	2310,	23,	'Sociedad de Responsabilidad Limitada',	0,	1,	NULL,	0),
(12,	2311,	23,	'Sociedad An??nima',	0,	1,	NULL,	0),
(13,	2312,	23,	'Sociedad An??nima con Participaci??n Estatal Mayoritaria',	0,	1,	NULL,	0),
(14,	2313,	23,	'Sociedad en Comandita por Acciones (arts. 315 a 324, LSC)',	0,	1,	NULL,	0),
(15,	4100,	41,	'GmbH - Gesellschaft mit beschr??nkter Haftung',	0,	1,	NULL,	0),
(16,	4101,	41,	'GesmbH - Gesellschaft mit beschr??nkter Haftung',	0,	1,	NULL,	0),
(17,	4102,	41,	'AG - Aktiengesellschaft',	0,	1,	NULL,	0),
(18,	4103,	41,	'EWIV - Europ??ische wirtschaftliche Interessenvereinigung',	0,	1,	NULL,	0),
(19,	4104,	41,	'KEG - Kommanditerwerbsgesellschaft',	0,	1,	NULL,	0),
(20,	4105,	41,	'OEG - Offene Erwerbsgesellschaft',	0,	1,	NULL,	0),
(21,	4106,	41,	'OHG - Offene Handelsgesellschaft',	0,	1,	NULL,	0),
(22,	4107,	41,	'AG & Co KG - Kommanditgesellschaft',	0,	1,	NULL,	0),
(23,	4108,	41,	'GmbH & Co KG - Kommanditgesellschaft',	0,	1,	NULL,	0),
(24,	4109,	41,	'KG - Kommanditgesellschaft',	0,	1,	NULL,	0),
(25,	4110,	41,	'OG - Offene Gesellschaft',	0,	1,	NULL,	0),
(26,	4111,	41,	'GbR - Gesellschaft nach b??rgerlichem Recht',	0,	1,	NULL,	0),
(27,	4112,	41,	'GesbR - Gesellschaft nach b??rgerlichem Recht',	0,	1,	NULL,	0),
(28,	4113,	41,	'GesnbR - Gesellschaft nach b??rgerlichem Recht',	0,	1,	NULL,	0),
(29,	4114,	41,	'e.U. - eingetragener Einzelunternehmer',	0,	1,	NULL,	0),
(30,	200,	2,	'Ind??pendant',	0,	1,	NULL,	0),
(31,	201,	2,	'SRL - Soci??t?? ?? responsabilit?? limit??e',	0,	1,	NULL,	0),
(32,	202,	2,	'SA   - Soci??t?? Anonyme',	0,	1,	NULL,	0),
(33,	203,	2,	'SCRL - Soci??t?? coop??rative ?? responsabilit?? limit??e',	0,	1,	NULL,	0),
(34,	204,	2,	'ASBL - Association sans but Lucratif',	0,	1,	NULL,	0),
(35,	205,	2,	'SCRI - Soci??t?? coop??rative ?? responsabilit?? illimit??e',	0,	1,	NULL,	0),
(36,	206,	2,	'SCS  - Soci??t?? en commandite simple',	0,	1,	NULL,	0),
(37,	207,	2,	'SCA  - Soci??t?? en commandite par action',	0,	1,	NULL,	0),
(38,	208,	2,	'SNC  - Soci??t?? en nom collectif',	0,	1,	NULL,	0),
(39,	209,	2,	'GIE  - Groupement d int??r??t ??conomique',	0,	1,	NULL,	0),
(40,	210,	2,	'GEIE - Groupement europ??en d int??r??t ??conomique',	0,	1,	NULL,	0),
(41,	220,	2,	'Eenmanszaak',	0,	1,	NULL,	0),
(42,	221,	2,	'BVBA - Besloten vennootschap met beperkte aansprakelijkheid',	0,	1,	NULL,	0),
(43,	222,	2,	'NV   - Naamloze Vennootschap',	0,	1,	NULL,	0),
(44,	223,	2,	'CVBA - Co??peratieve vennootschap met beperkte aansprakelijkheid',	0,	1,	NULL,	0),
(45,	224,	2,	'VZW  - Vereniging zonder winstoogmerk',	0,	1,	NULL,	0),
(46,	225,	2,	'CVOA - Co??peratieve vennootschap met onbeperkte aansprakelijkheid ',	0,	1,	NULL,	0),
(47,	226,	2,	'GCV  - Gewone commanditaire vennootschap',	0,	1,	NULL,	0),
(48,	227,	2,	'Comm.VA - Commanditaire vennootschap op aandelen',	0,	1,	NULL,	0),
(49,	228,	2,	'VOF  - Vennootschap onder firma',	0,	1,	NULL,	0),
(50,	229,	2,	'VS0  - Vennootschap met sociaal oogmerk',	0,	1,	NULL,	0),
(51,	11,	1,	'Artisan Commer??ant (EI)',	0,	1,	NULL,	0),
(52,	12,	1,	'Commer??ant (EI)',	0,	1,	NULL,	0),
(53,	13,	1,	'Artisan (EI)',	0,	1,	NULL,	0),
(54,	14,	1,	'Officier public ou minist??riel',	0,	1,	NULL,	0),
(55,	15,	1,	'Profession lib??rale (EI)',	0,	1,	NULL,	0),
(56,	16,	1,	'Exploitant agricole',	0,	1,	NULL,	0),
(57,	17,	1,	'Agent commercial',	0,	1,	NULL,	0),
(58,	18,	1,	'Associ?? G??rant de soci??t??',	0,	1,	NULL,	0),
(59,	19,	1,	'Personne physique',	0,	1,	NULL,	0),
(60,	21,	1,	'Indivision',	0,	1,	NULL,	0),
(61,	22,	1,	'Soci??t?? cr????e de fait',	0,	1,	NULL,	0),
(62,	23,	1,	'Soci??t?? en participation',	0,	1,	NULL,	0),
(63,	24,	1,	'Soci??t?? coop??rative d\'interet collectif (SCIC)',	0,	1,	NULL,	0),
(64,	25,	1,	'Soci??t?? coop??rative de production ?? responsabilit?? limit??e (SCOP)',	0,	1,	NULL,	0),
(65,	27,	1,	'Paroisse hors zone concordataire',	0,	1,	NULL,	0),
(66,	29,	1,	'Groupement de droit priv?? non dot?? de la personnalit?? morale',	0,	1,	NULL,	0),
(67,	31,	1,	'Personne morale de droit ??tranger, immatricul??e au RCS',	0,	1,	NULL,	0),
(68,	32,	1,	'Personne morale de droit ??tranger, non immatricul??e au RCS',	0,	1,	NULL,	0),
(69,	35,	1,	'R??gime auto-entrepreneur',	0,	1,	NULL,	0),
(70,	41,	1,	'Etablissement public ou r??gie ?? caract??re industriel ou commercial',	0,	1,	NULL,	0),
(71,	51,	1,	'Soci??t?? coop??rative commerciale particuli??re',	0,	1,	NULL,	0),
(72,	52,	1,	'Soci??t?? en nom collectif',	0,	1,	NULL,	0),
(73,	53,	1,	'Soci??t?? en commandite',	0,	1,	NULL,	0),
(74,	54,	1,	'Soci??t?? ?? responsabilit?? limit??e (SARL)',	0,	1,	NULL,	0),
(75,	55,	1,	'Soci??t?? anonyme ?? conseil d administration',	0,	1,	NULL,	0),
(76,	56,	1,	'Soci??t?? anonyme ?? directoire',	0,	1,	NULL,	0),
(77,	57,	1,	'Soci??t?? par actions simplifi??e (SAS)',	0,	1,	NULL,	0),
(78,	58,	1,	'Entreprise Unipersonnelle ?? Responsabilit?? Limit??e (EURL)',	0,	1,	NULL,	0),
(79,	59,	1,	'Soci??t?? par actions simplifi??e unipersonnelle (SASU)',	0,	1,	NULL,	0),
(80,	60,	1,	'Entreprise Individuelle ?? Responsabilit?? Limit??e (EIRL)',	0,	1,	NULL,	0),
(81,	61,	1,	'Caisse d\'??pargne et de pr??voyance',	0,	1,	NULL,	0),
(82,	62,	1,	'Groupement d\'int??r??t ??conomique (GIE)',	0,	1,	NULL,	0),
(83,	63,	1,	'Soci??t?? coop??rative agricole',	0,	1,	NULL,	0),
(84,	64,	1,	'Soci??t?? non commerciale d assurances',	0,	1,	NULL,	0),
(85,	65,	1,	'Soci??t?? civile',	0,	1,	NULL,	0),
(86,	69,	1,	'Personnes de droit priv?? inscrites au RCS',	0,	1,	NULL,	0),
(87,	71,	1,	'Administration de l ??tat',	0,	1,	NULL,	0),
(88,	72,	1,	'Collectivit?? territoriale',	0,	1,	NULL,	0),
(89,	73,	1,	'Etablissement public administratif',	0,	1,	NULL,	0),
(90,	74,	1,	'Personne morale de droit public administratif',	0,	1,	NULL,	0),
(91,	81,	1,	'Organisme g??rant r??gime de protection social ?? adh??sion obligatoire',	0,	1,	NULL,	0),
(92,	82,	1,	'Organisme mutualiste',	0,	1,	NULL,	0),
(93,	83,	1,	'Comit?? d entreprise',	0,	1,	NULL,	0),
(94,	84,	1,	'Organisme professionnel',	0,	1,	NULL,	0),
(95,	85,	1,	'Organisme de retraite ?? adh??sion non obligatoire',	0,	1,	NULL,	0),
(96,	91,	1,	'Syndicat de propri??taires',	0,	1,	NULL,	0),
(97,	92,	1,	'Association loi 1901 ou assimil??',	0,	1,	NULL,	0),
(98,	93,	1,	'Fondation',	0,	1,	NULL,	0),
(99,	99,	1,	'Personne morale de droit priv??',	0,	1,	NULL,	0),
(100,	500,	5,	'GmbH - Gesellschaft mit beschr??nkter Haftung',	0,	1,	NULL,	0),
(101,	501,	5,	'AG - Aktiengesellschaft ',	0,	1,	NULL,	0),
(102,	502,	5,	'GmbH&Co. KG - Gesellschaft mit beschr??nkter Haftung & Compagnie Kommanditgesellschaft',	0,	1,	NULL,	0),
(103,	503,	5,	'Gewerbe - Personengesellschaft',	0,	1,	NULL,	0),
(104,	504,	5,	'UG - Unternehmergesellschaft -haftungsbeschr??nkt-',	0,	1,	NULL,	0),
(105,	505,	5,	'GbR - Gesellschaft des b??rgerlichen Rechts',	0,	1,	NULL,	0),
(106,	506,	5,	'KG - Kommanditgesellschaft',	0,	1,	NULL,	0),
(107,	507,	5,	'Ltd. - Limited Company',	0,	1,	NULL,	0),
(108,	508,	5,	'OHG - Offene Handelsgesellschaft',	0,	1,	NULL,	0),
(109,	509,	5,	'eG - eingetragene Genossenschaft',	0,	1,	NULL,	0),
(110,	8001,	80,	'Aktieselvskab A/S',	0,	1,	NULL,	0),
(111,	8002,	80,	'Anparts Selvskab ApS',	0,	1,	NULL,	0),
(112,	8003,	80,	'Personlig ejet selvskab',	0,	1,	NULL,	0),
(113,	8004,	80,	'Iv??rks??tterselvskab IVS',	0,	1,	NULL,	0),
(114,	8005,	80,	'Interessentskab I/S',	0,	1,	NULL,	0),
(115,	8006,	80,	'Holdingselskab',	0,	1,	NULL,	0),
(116,	8007,	80,	'Selskab Med Begr??nset H??ftelse SMBA',	0,	1,	NULL,	0),
(117,	8008,	80,	'Kommanditselskab K/S',	0,	1,	NULL,	0),
(118,	8009,	80,	'SPE-selskab',	0,	1,	NULL,	0),
(119,	10201,	102,	'?????????????? ????????????????????',	0,	1,	NULL,	0),
(120,	10202,	102,	'????????????????  ????????????????????',	0,	1,	NULL,	0),
(121,	10203,	102,	'?????????????????? ???????????????? ??.??',	0,	1,	NULL,	0),
(122,	10204,	102,	'?????????????????????? ???????????????? ??.??',	0,	1,	NULL,	0),
(123,	10205,	102,	'???????????????? ?????????????????????????? ?????????????? ??.??.??',	0,	1,	NULL,	0),
(124,	10206,	102,	'?????????????? ???????????????? ??.??',	0,	1,	NULL,	0),
(125,	10207,	102,	'?????????????? ???????????????????? ???????????????? ??.??.??',	0,	1,	NULL,	0),
(126,	10208,	102,	'??????????????????????????',	0,	1,	NULL,	0),
(127,	10209,	102,	'????????????????????????????',	0,	1,	NULL,	0),
(128,	301,	3,	'Societ?? semplice',	0,	1,	NULL,	0),
(129,	302,	3,	'Societ?? in nome collettivo s.n.c.',	0,	1,	NULL,	0),
(130,	303,	3,	'Societ?? in accomandita semplice s.a.s.',	0,	1,	NULL,	0),
(131,	304,	3,	'Societ?? per azioni s.p.a.',	0,	1,	NULL,	0),
(132,	305,	3,	'Societ?? a responsabilit?? limitata s.r.l.',	0,	1,	NULL,	0),
(133,	306,	3,	'Societ?? in accomandita per azioni s.a.p.a.',	0,	1,	NULL,	0),
(134,	307,	3,	'Societ?? cooperativa a r.l.',	0,	1,	NULL,	0),
(135,	308,	3,	'Societ?? consortile',	0,	1,	NULL,	0),
(136,	309,	3,	'Societ?? europea',	0,	1,	NULL,	0),
(137,	310,	3,	'Societ?? cooperativa europea',	0,	1,	NULL,	0),
(138,	311,	3,	'Societ?? unipersonale',	0,	1,	NULL,	0),
(139,	312,	3,	'Societ?? di professionisti',	0,	1,	NULL,	0),
(140,	313,	3,	'Societ?? di fatto',	0,	1,	NULL,	0),
(141,	315,	3,	'Societ?? apparente',	0,	1,	NULL,	0),
(142,	316,	3,	'Impresa individuale ',	0,	1,	NULL,	0),
(143,	317,	3,	'Impresa coniugale',	0,	1,	NULL,	0),
(144,	318,	3,	'Impresa familiare',	0,	1,	NULL,	0),
(145,	319,	3,	'Consorzio cooperativo',	0,	1,	NULL,	0),
(146,	320,	3,	'Societ?? cooperativa sociale',	0,	1,	NULL,	0),
(147,	321,	3,	'Societ?? cooperativa di consumo',	0,	1,	NULL,	0),
(148,	322,	3,	'Societ?? cooperativa agricola',	0,	1,	NULL,	0),
(149,	323,	3,	'A.T.I. Associazione temporanea di imprese',	0,	1,	NULL,	0),
(150,	324,	3,	'R.T.I. Raggruppamento temporaneo di imprese',	0,	1,	NULL,	0),
(151,	325,	3,	'Studio associato',	0,	1,	NULL,	0),
(152,	600,	6,	'Raison Individuelle',	0,	1,	NULL,	0),
(153,	601,	6,	'Soci??t?? Simple',	0,	1,	NULL,	0),
(154,	602,	6,	'Soci??t?? en nom collectif',	0,	1,	NULL,	0),
(155,	603,	6,	'Soci??t?? en commandite',	0,	1,	NULL,	0),
(156,	604,	6,	'Soci??t?? anonyme (SA)',	0,	1,	NULL,	0),
(157,	605,	6,	'Soci??t?? en commandite par actions',	0,	1,	NULL,	0),
(158,	606,	6,	'Soci??t?? ?? responsabilit?? limit??e (SARL)',	0,	1,	NULL,	0),
(159,	607,	6,	'Soci??t?? coop??rative',	0,	1,	NULL,	0),
(160,	608,	6,	'Association',	0,	1,	NULL,	0),
(161,	609,	6,	'Fondation',	0,	1,	NULL,	0),
(162,	700,	7,	'Sole Trader',	0,	1,	NULL,	0),
(163,	701,	7,	'Partnership',	0,	1,	NULL,	0),
(164,	702,	7,	'Private Limited Company by shares (LTD)',	0,	1,	NULL,	0),
(165,	703,	7,	'Public Limited Company',	0,	1,	NULL,	0),
(166,	704,	7,	'Workers Cooperative',	0,	1,	NULL,	0),
(167,	705,	7,	'Limited Liability Partnership',	0,	1,	NULL,	0),
(168,	706,	7,	'Franchise',	0,	1,	NULL,	0),
(169,	1000,	10,	'Soci??t?? ?? responsabilit?? limit??e (SARL)',	0,	1,	NULL,	0),
(170,	1001,	10,	'Soci??t?? en Nom Collectif (SNC)',	0,	1,	NULL,	0),
(171,	1002,	10,	'Soci??t?? en Commandite Simple (SCS)',	0,	1,	NULL,	0),
(172,	1003,	10,	'soci??t?? en participation',	0,	1,	NULL,	0),
(173,	1004,	10,	'Soci??t?? Anonyme (SA)',	0,	1,	NULL,	0),
(174,	1005,	10,	'Soci??t?? Unipersonnelle ?? Responsabilit?? Limit??e (SUARL)',	0,	1,	NULL,	0),
(175,	1006,	10,	'Groupement d\'int??r??t ??conomique (GEI)',	0,	1,	NULL,	0),
(176,	1007,	10,	'Groupe de soci??t??s',	0,	1,	NULL,	0),
(177,	1701,	17,	'Eenmanszaak',	0,	1,	NULL,	0),
(178,	1702,	17,	'Maatschap',	0,	1,	NULL,	0),
(179,	1703,	17,	'Vennootschap onder firma',	0,	1,	NULL,	0),
(180,	1704,	17,	'Commanditaire vennootschap',	0,	1,	NULL,	0),
(181,	1705,	17,	'Besloten vennootschap (BV)',	0,	1,	NULL,	0),
(182,	1706,	17,	'Naamloze Vennootschap (NV)',	0,	1,	NULL,	0),
(183,	1707,	17,	'Vereniging',	0,	1,	NULL,	0),
(184,	1708,	17,	'Stichting',	0,	1,	NULL,	0),
(185,	1709,	17,	'Co??peratie met beperkte aansprakelijkheid (BA)',	0,	1,	NULL,	0),
(186,	1710,	17,	'Co??peratie met uitgesloten aansprakelijkheid (UA)',	0,	1,	NULL,	0),
(187,	1711,	17,	'Co??peratie met wettelijke aansprakelijkheid (WA)',	0,	1,	NULL,	0),
(188,	1712,	17,	'Onderlinge waarborgmaatschappij',	0,	1,	NULL,	0),
(189,	401,	4,	'Empresario Individual',	0,	1,	NULL,	0),
(190,	402,	4,	'Comunidad de Bienes',	0,	1,	NULL,	0),
(191,	403,	4,	'Sociedad Civil',	0,	1,	NULL,	0),
(192,	404,	4,	'Sociedad Colectiva',	0,	1,	NULL,	0),
(193,	405,	4,	'Sociedad Limitada',	0,	1,	NULL,	0),
(194,	406,	4,	'Sociedad An??nima',	0,	1,	NULL,	0),
(195,	407,	4,	'Sociedad Comanditaria por Acciones',	0,	1,	NULL,	0),
(196,	408,	4,	'Sociedad Comanditaria Simple',	0,	1,	NULL,	0),
(197,	409,	4,	'Sociedad Laboral',	0,	1,	NULL,	0),
(198,	410,	4,	'Sociedad Cooperativa',	0,	1,	NULL,	0),
(199,	411,	4,	'Sociedad de Garant??a Rec??proca',	0,	1,	NULL,	0),
(200,	412,	4,	'Entidad de Capital-Riesgo',	0,	1,	NULL,	0),
(201,	413,	4,	'Agrupaci??n de Inter??s Econ??mico',	0,	1,	NULL,	0),
(202,	414,	4,	'Sociedad de Inversi??n Mobiliaria',	0,	1,	NULL,	0),
(203,	415,	4,	'Agrupaci??n sin ??nimo de Lucro',	0,	1,	NULL,	0),
(204,	15201,	152,	'Mauritius Private Company Limited By Shares',	0,	1,	NULL,	0),
(205,	15202,	152,	'Mauritius Company Limited By Guarantee',	0,	1,	NULL,	0),
(206,	15203,	152,	'Mauritius Public Company Limited By Shares',	0,	1,	NULL,	0),
(207,	15204,	152,	'Mauritius Foreign Company',	0,	1,	NULL,	0),
(208,	15205,	152,	'Mauritius GBC1 (Offshore Company)',	0,	1,	NULL,	0),
(209,	15206,	152,	'Mauritius GBC2 (International Company)',	0,	1,	NULL,	0),
(210,	15207,	152,	'Mauritius General Partnership',	0,	1,	NULL,	0),
(211,	15208,	152,	'Mauritius Limited Partnership',	0,	1,	NULL,	0),
(212,	15209,	152,	'Mauritius Sole Proprietorship',	0,	1,	NULL,	0),
(213,	15210,	152,	'Mauritius Trusts',	0,	1,	NULL,	0),
(214,	15401,	154,	'Sociedad en nombre colectivo',	0,	1,	NULL,	0),
(215,	15402,	154,	'Sociedad en comandita simple',	0,	1,	NULL,	0),
(216,	15403,	154,	'Sociedad de responsabilidad limitada',	0,	1,	NULL,	0),
(217,	15404,	154,	'Sociedad an??nima',	0,	1,	NULL,	0),
(218,	15405,	154,	'Sociedad en comandita por acciones',	0,	1,	NULL,	0),
(219,	15406,	154,	'Sociedad cooperativa',	0,	1,	NULL,	0),
(220,	14001,	140,	'Entreprise individuelle',	0,	1,	NULL,	0),
(221,	14002,	140,	'Soci??t?? en nom collectif (SENC)',	0,	1,	NULL,	0),
(222,	14003,	140,	'Soci??t?? en commandite simple (SECS)',	0,	1,	NULL,	0),
(223,	14004,	140,	'Soci??t?? en commandite par actions (SECA)',	0,	1,	NULL,	0),
(224,	14005,	140,	'Soci??t?? ?? responsabilit?? limit??e (SARL)',	0,	1,	NULL,	0),
(225,	14006,	140,	'Soci??t?? anonyme (SA)',	0,	1,	NULL,	0),
(226,	14007,	140,	'Soci??t?? coop??rative (SC)',	0,	1,	NULL,	0),
(227,	14008,	140,	'Soci??t?? europ??enne (SE)',	0,	1,	NULL,	0),
(228,	18801,	188,	'AFJ - Alte forme juridice',	0,	1,	NULL,	0),
(229,	18802,	188,	'ASF - Asociatie familial??',	0,	1,	NULL,	0),
(230,	18803,	188,	'CON - Concesiune',	0,	1,	NULL,	0),
(231,	18804,	188,	'CRL - Soc civil?? profesionala cu pers. juridica si r??spundere limitata (SPRL)',	0,	1,	NULL,	0),
(232,	18805,	188,	'INC - ??nchiriere',	0,	1,	NULL,	0),
(233,	18806,	188,	'LOC - Loca??ie de gestiune',	0,	1,	NULL,	0),
(234,	18807,	188,	'OC1 - Organiza??ie cooperatist?? me??te??ug??reasc??',	0,	1,	NULL,	0),
(235,	18808,	188,	'OC2 - Organiza??ie cooperatist?? de consum',	0,	1,	NULL,	0),
(236,	18809,	188,	'OC3 - Organiza??ie cooperatist?? de credit',	0,	1,	NULL,	0),
(237,	18810,	188,	'PFA - Persoan?? fizic?? independent??',	0,	1,	NULL,	0),
(238,	18811,	188,	'RA - Regie autonom??',	0,	1,	NULL,	0),
(239,	18812,	188,	'SA - Societate comercial?? pe ac??iuni',	0,	1,	NULL,	0),
(240,	18813,	188,	'SCS - Societate comercial?? ??n comandit?? simpl??',	0,	1,	NULL,	0),
(241,	18814,	188,	'SNC - Societate comercial?? ??n nume colectiv',	0,	1,	NULL,	0),
(242,	18815,	188,	'SPI - Societate profesionala practicieni in insolventa (SPPI)',	0,	1,	NULL,	0),
(243,	18816,	188,	'SRL - Societate comercial?? cu r??spundere limitat??',	0,	1,	NULL,	0),
(244,	18817,	188,	'URL - Intreprindere profesionala unipersonala cu r??spundere limitata (IPURL)',	0,	1,	NULL,	0),
(245,	17801,	178,	'Empresa individual',	0,	1,	NULL,	0),
(246,	17802,	178,	'Asociaci??n General',	0,	1,	NULL,	0),
(247,	17803,	178,	'Sociedad de Responsabilidad Limitada',	0,	1,	NULL,	0),
(248,	17804,	178,	'Sociedad Civil',	0,	1,	NULL,	0),
(249,	17805,	178,	'Sociedad An??nima',	0,	1,	NULL,	0),
(250,	1300,	13,	'Personne physique',	0,	1,	NULL,	0),
(251,	1301,	13,	'Soci??t?? ?? responsabilit?? limit??e (SARL)',	0,	1,	NULL,	0),
(252,	1302,	13,	'Entreprise unipersonnelle ?? responsabilit?? limit??e (EURL)',	0,	1,	NULL,	0),
(253,	1303,	13,	'Soci??t?? en Nom Collectif (SNC)',	0,	1,	NULL,	0),
(254,	1304,	13,	'soci??t?? par actions (SPA)',	0,	1,	NULL,	0),
(255,	1305,	13,	'Soci??t?? en Commandite Simple (SCS)',	0,	1,	NULL,	0),
(256,	1306,	13,	'Soci??t?? en commandite par actions (SCA)',	0,	1,	NULL,	0),
(257,	1307,	13,	'Soci??t?? en participation',	0,	1,	NULL,	0),
(258,	1308,	13,	'Groupe de soci??t??s',	0,	1,	NULL,	0),
(259,	2001,	20,	'Aktiebolag',	0,	1,	NULL,	0),
(260,	2002,	20,	'Publikt aktiebolag (AB publ)',	0,	1,	NULL,	0),
(261,	2003,	20,	'Ekonomisk f??rening (ek. f??r.)',	0,	1,	NULL,	0),
(262,	2004,	20,	'Bostadsr??ttsf??rening (BRF)',	0,	1,	NULL,	0),
(263,	2005,	20,	'Hyresr??ttsf??rening (HRF)',	0,	1,	NULL,	0),
(264,	2006,	20,	'Kooperativ',	0,	1,	NULL,	0),
(265,	2007,	20,	'Enskild firma (EF)',	0,	1,	NULL,	0),
(266,	2008,	20,	'Handelsbolag (HB)',	0,	1,	NULL,	0),
(267,	2009,	20,	'Kommanditbolag (KB)',	0,	1,	NULL,	0),
(268,	2010,	20,	'Enkelt bolag',	0,	1,	NULL,	0),
(269,	2011,	20,	'Ideell f??rening',	0,	1,	NULL,	0),
(270,	2012,	20,	'Stiftelse',	0,	1,	NULL,	0);

DROP TABLE IF EXISTS `llx_c_holiday_types`;
CREATE TABLE `llx_c_holiday_types` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(16) COLLATE utf8_unicode_ci NOT NULL,
  `label` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `affect` int(11) NOT NULL,
  `delay` int(11) NOT NULL,
  `newbymonth` double(8,5) NOT NULL DEFAULT '0.00000',
  `fk_country` int(11) DEFAULT NULL,
  `active` int(11) DEFAULT '1',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_c_holiday_types` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_c_holiday_types` (`rowid`, `code`, `label`, `affect`, `delay`, `newbymonth`, `fk_country`, `active`) VALUES
(1,	'LEAVE_SICK',	'Sick leave',	0,	0,	0.00000,	NULL,	1),
(2,	'LEAVE_OTHER',	'Other leave',	0,	0,	0.00000,	NULL,	1),
(3,	'LEAVE_PAID',	'Paid vacation',	1,	7,	0.00000,	NULL,	0),
(4,	'LEAVE_RTT_FR',	'RTT',	1,	7,	0.83000,	1,	1),
(5,	'LEAVE_PAID_FR',	'Paid vacation',	1,	30,	2.08334,	1,	1);

DROP TABLE IF EXISTS `llx_c_hrm_department`;
CREATE TABLE `llx_c_hrm_department` (
  `rowid` int(11) NOT NULL,
  `pos` tinyint(4) NOT NULL DEFAULT '0',
  `code` varchar(16) COLLATE utf8_unicode_ci NOT NULL,
  `label` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_c_hrm_department` (`rowid`, `pos`, `code`, `label`, `active`) VALUES
(1,	5,	'MANAGEMENT',	'Management',	1),
(3,	15,	'TRAINING',	'Training',	1),
(4,	20,	'IT',	'Inform. Technology (IT)',	0),
(5,	25,	'MARKETING',	'Marketing',	0),
(6,	30,	'SALES',	'Sales',	1),
(7,	35,	'LEGAL',	'Legal',	0),
(8,	40,	'FINANCIAL',	'Financial accounting',	1),
(9,	45,	'HUMANRES',	'Human resources',	1),
(10,	50,	'PURCHASING',	'Purchasing',	1),
(12,	60,	'CUSTOMSERV',	'Customer service',	0),
(14,	70,	'LOGISTIC',	'Logistics',	1),
(15,	75,	'CONSTRUCT',	'Engineering/design',	0),
(16,	80,	'PRODUCTION',	'Production',	1),
(17,	85,	'QUALITY',	'Quality assurance',	0);

DROP TABLE IF EXISTS `llx_c_hrm_function`;
CREATE TABLE `llx_c_hrm_function` (
  `rowid` int(11) NOT NULL,
  `pos` tinyint(4) NOT NULL DEFAULT '0',
  `code` varchar(16) COLLATE utf8_unicode_ci NOT NULL,
  `label` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `c_level` tinyint(4) NOT NULL DEFAULT '0',
  `active` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_c_hrm_function` (`rowid`, `pos`, `code`, `label`, `c_level`, `active`) VALUES
(1,	5,	'EXECBOARD',	'Executive board',	0,	1),
(2,	10,	'MANAGDIR',	'Managing director',	1,	1),
(3,	15,	'ACCOUNTMANAG',	'Account manager',	0,	1),
(4,	20,	'ENGAGDIR',	'Engagement director',	1,	1),
(5,	25,	'DIRECTOR',	'Director',	1,	1),
(6,	30,	'PROJMANAG',	'Project manager',	0,	1),
(7,	35,	'DEPHEAD',	'Department head',	0,	1),
(8,	40,	'SECRETAR',	'Secretary',	0,	1),
(9,	45,	'EMPLOYEE',	'Department employee',	0,	1);

DROP TABLE IF EXISTS `llx_c_hrm_public_holiday`;
CREATE TABLE `llx_c_hrm_public_holiday` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '0',
  `fk_country` int(11) DEFAULT NULL,
  `code` varchar(62) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dayrule` varchar(64) COLLATE utf8_unicode_ci DEFAULT '',
  `day` int(11) DEFAULT NULL,
  `month` int(11) DEFAULT NULL,
  `year` int(11) DEFAULT NULL,
  `active` int(11) DEFAULT '1',
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_c_hrm_public_holiday` (`entity`,`code`),
  UNIQUE KEY `uk_c_hrm_public_holiday2` (`entity`,`fk_country`,`dayrule`,`day`,`month`,`year`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_c_hrm_public_holiday` (`id`, `entity`, `fk_country`, `code`, `dayrule`, `day`, `month`, `year`, `active`, `import_key`) VALUES
(1,	0,	0,	'NEWYEARDAY1',	'',	1,	1,	0,	1,	NULL),
(2,	0,	0,	'LABORDAY1',	'',	1,	5,	0,	1,	NULL),
(3,	0,	0,	'ASSOMPTIONDAY1',	'',	15,	8,	0,	1,	NULL),
(4,	0,	0,	'CHRISTMASDAY1',	'',	25,	12,	0,	1,	NULL),
(5,	0,	1,	'FR-VICTORYDAY',	'',	8,	5,	0,	1,	NULL),
(6,	0,	1,	'FR-NATIONALDAY',	'',	14,	7,	0,	1,	NULL),
(7,	0,	1,	'FR-ASSOMPTION',	'',	15,	8,	0,	1,	NULL),
(8,	0,	1,	'FR-TOUSSAINT',	'',	1,	11,	0,	1,	NULL),
(9,	0,	1,	'FR-ARMISTICE',	'',	11,	11,	0,	1,	NULL),
(10,	0,	1,	'FR-EASTER',	'eastermonday',	0,	0,	0,	1,	NULL),
(11,	0,	1,	'FR-ASCENSION',	'ascension',	0,	0,	0,	1,	NULL),
(12,	0,	1,	'FR-PENTECOST',	'pentecost',	0,	0,	0,	1,	NULL),
(13,	0,	3,	'IT-LIBEAZIONE',	'',	25,	4,	0,	1,	NULL),
(14,	0,	3,	'IT-EPIPHANY',	'',	1,	6,	0,	1,	NULL),
(15,	0,	3,	'IT-REPUBBLICA',	'',	2,	6,	0,	1,	NULL),
(16,	0,	3,	'IT-TUTTISANTIT',	'',	1,	11,	0,	1,	NULL),
(17,	0,	3,	'IT-IMMACULE',	'',	8,	12,	0,	1,	NULL),
(18,	0,	3,	'IT-SAINTSTEFAN',	'',	26,	12,	0,	1,	NULL),
(19,	0,	4,	'ES-EASTER',	'easter',	0,	0,	0,	1,	NULL),
(20,	0,	4,	'ES-REYE',	'',	1,	6,	0,	1,	NULL),
(21,	0,	4,	'ES-HISPANIDAD',	'',	12,	10,	0,	1,	NULL),
(22,	0,	4,	'ES-TOUSSAINT',	'',	1,	11,	0,	1,	NULL),
(23,	0,	4,	'ES-CONSTITUIZION',	'',	6,	12,	0,	1,	NULL),
(24,	0,	4,	'ES-IMMACULE',	'',	8,	12,	0,	1,	NULL),
(25,	0,	41,	'AT-EASTER',	'eastermonday',	0,	0,	0,	1,	NULL),
(26,	0,	41,	'AT-ASCENSION',	'ascension',	0,	0,	0,	1,	NULL),
(27,	0,	41,	'AT-PENTECOST',	'pentecost',	0,	0,	0,	1,	NULL),
(28,	0,	41,	'AT-FRONLEICHNAM',	'fronleichnam',	0,	0,	0,	1,	NULL),
(29,	0,	41,	'AT-KONEGIE',	'',	1,	6,	0,	1,	NULL),
(30,	0,	41,	'AT-26OKT',	'',	26,	10,	0,	1,	NULL),
(31,	0,	41,	'AT-TOUSSAINT',	'',	1,	11,	0,	1,	NULL),
(32,	0,	41,	'AT-IMMACULE',	'',	8,	12,	0,	1,	NULL),
(33,	0,	41,	'AT-24DEC',	'',	24,	12,	0,	1,	NULL),
(34,	0,	41,	'AT-SAINTSTEFAN',	'',	26,	12,	0,	1,	NULL),
(35,	0,	41,	'AT-Silvester',	'',	31,	12,	0,	1,	NULL),
(36,	0,	117,	'IN-REPUBLICDAY',	'',	26,	1,	0,	1,	NULL),
(37,	0,	117,	'IN-GANDI',	'',	2,	10,	0,	1,	NULL);

DROP TABLE IF EXISTS `llx_c_incoterms`;
CREATE TABLE `llx_c_incoterms` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(3) COLLATE utf8_unicode_ci NOT NULL,
  `label` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `libelle` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_c_incoterms` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_c_incoterms` (`rowid`, `code`, `label`, `libelle`, `active`) VALUES
(1,	'EXW',	'Ex Works',	'Ex Works, au d??part non charg??, non d??douan?? sortie d\'usine (uniquement adapt?? aux flux domestiques, nationaux)',	1),
(2,	'FCA',	'Free Carrier',	'Free Carrier, marchandises d??douan??es et charg??es dans le pays de d??part, chez le vendeur ou chez le commissionnaire de transport de l\'acheteur',	1),
(3,	'FAS',	'Free Alongside Ship',	'Free Alongside Ship, sur le quai du port de d??part',	1),
(4,	'FOB',	'Free On Board',	'Free On Board, charg?? sur le bateau, les frais de chargement dans celui-ci ??tant fonction du liner term indiqu?? par la compagnie maritime (?? la charge du vendeur)',	1),
(5,	'CFR',	'Cost and Freight',	'Cost and Freight, charg?? dans le bateau, livraison au port de d??part, frais pay??s jusqu\'au port d\'arriv??e, sans assurance pour le transport, non d??charg?? du navire ?? destination (les frais de d??chargement sont inclus ou non au port d\'arriv??e)',	1),
(6,	'CIF',	'Cost, Insurance, Freight',	'Cost, Insurance and Freight, charg?? sur le bateau, frais jusqu\'au port d\'arriv??e, avec l\'assurance marchandise transport??e souscrite par le vendeur pour le compte de l\'acheteur',	1),
(7,	'CPT',	'Carriage Paid To',	'Carriage Paid To, livraison au premier transporteur, frais jusqu\'au d??chargement du mode de transport, sans assurance pour le transport',	1),
(8,	'CIP',	'Carriage Insurance Paid',	'Carriage and Insurance Paid to, idem CPT, avec assurance marchandise transport??e souscrite par le vendeur pour le compte de l\'acheteur',	1),
(9,	'DAT',	'Delivered At Terminal',	'Delivered At Terminal, marchandises (d??charg??es) livr??es sur quai, dans un terminal maritime, fluvial, a??rien, routier ou ferroviaire d??sign?? (d??douanement import, et post-acheminement pay??s par l\'acheteur)',	1),
(10,	'DAP',	'Delivered At Place',	'Delivered At Place, marchandises (non d??charg??es) mises ?? disposition de l\'acheteur dans le pays d\'importation au lieu pr??cis?? dans le contrat (d??chargement, d??douanement import pay?? par l\'acheteur)',	1),
(11,	'DDP',	'Delivered Duty Paid',	'Delivered Duty Paid, marchandises (non d??charg??es) livr??es ?? destination finale, d??douanement import et taxes ?? la charge du vendeur ; l\'acheteur prend en charge uniquement le d??chargement (si exclusion des taxes type TVA, le pr??ciser clairement)',	1),
(12,	'DPU',	'Delivered at Place Unloaded',	'Delivered at Place unloaded',	1);

DROP TABLE IF EXISTS `llx_c_input_method`;
CREATE TABLE `llx_c_input_method` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `libelle` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `module` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_c_input_method` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_c_input_method` (`rowid`, `code`, `libelle`, `active`, `module`) VALUES
(1,	'OrderByMail',	'Courrier',	1,	NULL),
(2,	'OrderByFax',	'Fax',	1,	NULL),
(3,	'OrderByEMail',	'EMail',	1,	NULL),
(4,	'OrderByPhone',	'T??l??phone',	1,	NULL),
(5,	'OrderByWWW',	'En ligne',	1,	NULL);

DROP TABLE IF EXISTS `llx_c_input_reason`;
CREATE TABLE `llx_c_input_reason` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `label` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `module` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_c_input_reason` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_c_input_reason` (`rowid`, `code`, `label`, `active`, `module`) VALUES
(1,	'SRC_INTE',	'Web site',	1,	NULL),
(2,	'SRC_CAMP_MAIL',	'Mailing campaign',	1,	NULL),
(3,	'SRC_CAMP_PHO',	'Phone campaign',	1,	NULL),
(4,	'SRC_CAMP_FAX',	'Fax campaign',	1,	NULL),
(5,	'SRC_COMM',	'Commercial contact',	1,	NULL),
(6,	'SRC_SHOP',	'Shop contact',	1,	NULL),
(7,	'SRC_CAMP_EMAIL',	'EMailing campaign',	1,	NULL),
(8,	'SRC_WOM',	'Word of mouth',	1,	NULL),
(9,	'SRC_PARTNER',	'Partner',	1,	NULL),
(10,	'SRC_EMPLOYEE',	'Employee',	1,	NULL),
(11,	'SRC_SPONSORING',	'Sponsorship',	1,	NULL),
(12,	'SRC_CUSTOMER',	'Incoming contact of a customer',	1,	NULL);

DROP TABLE IF EXISTS `llx_c_lead_status`;
CREATE TABLE `llx_c_lead_status` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `label` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  `percent` double(5,2) DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_c_lead_status_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_c_lead_status` (`rowid`, `code`, `label`, `position`, `percent`, `active`) VALUES
(1,	'PROSP',	'Prospection',	10,	0.00,	1),
(2,	'QUAL',	'Qualification',	20,	20.00,	1),
(3,	'PROPO',	'Proposal',	30,	40.00,	1),
(4,	'NEGO',	'Negotiation',	40,	60.00,	1),
(5,	'PENDING',	'Pending',	50,	50.00,	0),
(6,	'WON',	'Won',	60,	100.00,	1),
(7,	'LOST',	'Lost',	70,	0.00,	1);

DROP TABLE IF EXISTS `llx_c_paiement`;
CREATE TABLE `llx_c_paiement` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `code` varchar(6) COLLATE utf8_unicode_ci NOT NULL,
  `libelle` varchar(62) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` smallint(6) DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `accountancy_code` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `module` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `position` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_c_paiement_code` (`entity`,`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_c_paiement` (`id`, `entity`, `code`, `libelle`, `type`, `active`, `accountancy_code`, `module`, `position`) VALUES
(1,	1,	'TIP',	'TIP',	2,	0,	NULL,	NULL,	0),
(2,	1,	'VIR',	'Transfer',	2,	1,	NULL,	NULL,	0),
(3,	1,	'PRE',	'Debit order',	2,	1,	NULL,	NULL,	0),
(4,	1,	'LIQ',	'Cash',	2,	1,	NULL,	NULL,	0),
(6,	1,	'CB',	'Credit card',	2,	1,	NULL,	NULL,	0),
(7,	1,	'CHQ',	'Cheque',	2,	1,	NULL,	NULL,	0),
(50,	1,	'VAD',	'Online payment',	2,	0,	NULL,	NULL,	0),
(51,	1,	'TRA',	'Traite',	2,	0,	NULL,	NULL,	0),
(52,	1,	'LCR',	'LCR',	2,	0,	NULL,	NULL,	0),
(53,	1,	'FAC',	'Factor',	2,	0,	NULL,	NULL,	0),
(100,	1,	'KLA',	'Klarna',	1,	0,	NULL,	NULL,	0),
(101,	1,	'SOF',	'Sofort',	1,	0,	NULL,	NULL,	0),
(102,	1,	'BAN',	'Bancontact',	1,	0,	NULL,	NULL,	0),
(103,	1,	'IDE',	'iDeal',	1,	0,	NULL,	NULL,	0),
(104,	1,	'GIR',	'Giropay',	1,	0,	NULL,	NULL,	0);

DROP TABLE IF EXISTS `llx_c_paper_format`;
CREATE TABLE `llx_c_paper_format` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(16) COLLATE utf8_unicode_ci NOT NULL,
  `label` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `width` float(6,2) DEFAULT '0.00',
  `height` float(6,2) DEFAULT '0.00',
  `unit` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `module` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_c_paper_format` (`rowid`, `code`, `label`, `width`, `height`, `unit`, `active`, `module`) VALUES
(1,	'EU4A0',	'Format 4A0',	1682.00,	2378.00,	'mm',	1,	NULL),
(2,	'EU2A0',	'Format 2A0',	1189.00,	1682.00,	'mm',	1,	NULL),
(3,	'EUA0',	'Format A0',	840.00,	1189.00,	'mm',	1,	NULL),
(4,	'EUA1',	'Format A1',	594.00,	840.00,	'mm',	1,	NULL),
(5,	'EUA2',	'Format A2',	420.00,	594.00,	'mm',	1,	NULL),
(6,	'EUA3',	'Format A3',	297.00,	420.00,	'mm',	1,	NULL),
(7,	'EUA4',	'Format A4',	210.00,	297.00,	'mm',	1,	NULL),
(8,	'EUA5',	'Format A5',	148.00,	210.00,	'mm',	1,	NULL),
(9,	'EUA6',	'Format A6',	105.00,	148.00,	'mm',	1,	NULL),
(100,	'USLetter',	'Format Letter (A)',	216.00,	279.00,	'mm',	1,	NULL),
(105,	'USLegal',	'Format Legal',	216.00,	356.00,	'mm',	1,	NULL),
(110,	'USExecutive',	'Format Executive',	190.00,	254.00,	'mm',	1,	NULL),
(115,	'USLedger',	'Format Ledger/Tabloid (B)',	279.00,	432.00,	'mm',	1,	NULL),
(200,	'CAP1',	'Format Canadian P1',	560.00,	860.00,	'mm',	1,	NULL),
(205,	'CAP2',	'Format Canadian P2',	430.00,	560.00,	'mm',	1,	NULL),
(210,	'CAP3',	'Format Canadian P3',	280.00,	430.00,	'mm',	1,	NULL),
(215,	'CAP4',	'Format Canadian P4',	215.00,	280.00,	'mm',	1,	NULL),
(220,	'CAP5',	'Format Canadian P5',	140.00,	215.00,	'mm',	1,	NULL),
(225,	'CAP6',	'Format Canadian P6',	107.00,	140.00,	'mm',	1,	NULL);

DROP TABLE IF EXISTS `llx_c_partnership_type`;
CREATE TABLE `llx_c_partnership_type` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `code` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `label` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_c_partnership_type` (`entity`,`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_c_partnership_type` (`rowid`, `entity`, `code`, `label`, `active`) VALUES
(1,	1,	'DEFAULT',	'Default',	1);

DROP TABLE IF EXISTS `llx_c_payment_term`;
CREATE TABLE `llx_c_payment_term` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `code` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sortorder` smallint(6) DEFAULT NULL,
  `active` tinyint(4) DEFAULT '1',
  `libelle` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `libelle_facture` text COLLATE utf8_unicode_ci,
  `type_cdr` tinyint(4) DEFAULT NULL,
  `nbjour` smallint(6) DEFAULT NULL,
  `decalage` smallint(6) DEFAULT NULL,
  `module` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `position` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_c_payment_term_code` (`entity`,`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_c_payment_term` (`rowid`, `entity`, `code`, `sortorder`, `active`, `libelle`, `libelle_facture`, `type_cdr`, `nbjour`, `decalage`, `module`, `position`) VALUES
(1,	1,	'RECEP',	1,	1,	'Due upon receipt',	'Due upon receipt',	0,	1,	NULL,	NULL,	0),
(2,	1,	'30D',	2,	1,	'30 days',	'Due in 30 days',	0,	30,	NULL,	NULL,	0),
(3,	1,	'30DENDMONTH',	3,	1,	'30 days end of month',	'Due in 30 days, end of month',	1,	30,	NULL,	NULL,	0),
(4,	1,	'60D',	4,	1,	'60 days',	'Due in 60 days, end of month',	0,	60,	NULL,	NULL,	0),
(5,	1,	'60DENDMONTH',	5,	1,	'60 days end of month',	'Due in 60 days, end of month',	1,	60,	NULL,	NULL,	0),
(6,	1,	'PT_ORDER',	6,	1,	'Due on order',	'Due on order',	0,	1,	NULL,	NULL,	0),
(7,	1,	'PT_DELIVERY',	7,	1,	'Due on delivery',	'Due on delivery',	0,	1,	NULL,	NULL,	0),
(8,	1,	'PT_5050',	8,	1,	'50 and 50',	'50% on order, 50% on delivery',	0,	1,	NULL,	NULL,	0),
(9,	1,	'10D',	9,	1,	'10 days',	'Due in 10 days',	0,	10,	NULL,	NULL,	0),
(10,	1,	'10DENDMONTH',	10,	1,	'10 days end of month',	'Due in 10 days, end of month',	1,	10,	NULL,	NULL,	0),
(11,	1,	'14D',	11,	1,	'14 days',	'Due in 14 days',	0,	14,	NULL,	NULL,	0),
(12,	1,	'14DENDMONTH',	12,	1,	'14 days end of month',	'Due in 14 days, end of month',	1,	14,	NULL,	NULL,	0);

DROP TABLE IF EXISTS `llx_c_price_expression`;
CREATE TABLE `llx_c_price_expression` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `expression` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_c_price_global_variable`;
CREATE TABLE `llx_c_price_global_variable` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `value` double(24,8) DEFAULT '0.00000000',
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_c_price_global_variable_updater`;
CREATE TABLE `llx_c_price_global_variable_updater` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `parameters` text COLLATE utf8_unicode_ci,
  `fk_variable` int(11) NOT NULL,
  `update_interval` int(11) DEFAULT '0',
  `next_update` int(11) DEFAULT '0',
  `last_status` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_c_productbatch_qcstatus`;
CREATE TABLE `llx_c_productbatch_qcstatus` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `code` varchar(16) COLLATE utf8_unicode_ci NOT NULL,
  `label` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `active` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_c_productbatch_qcstatus` (`code`,`entity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_c_productbatch_qcstatus` (`rowid`, `entity`, `code`, `label`, `active`) VALUES
(1,	1,	'OK',	'InWorkingOrder',	1),
(2,	1,	'KO',	'OutOfOrder',	1);

DROP TABLE IF EXISTS `llx_c_product_nature`;
CREATE TABLE `llx_c_product_nature` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `code` tinyint(4) NOT NULL,
  `label` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_c_product_nature` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_c_product_nature` (`rowid`, `code`, `label`, `active`) VALUES
(1,	0,	'RowMaterial',	1),
(2,	1,	'Finished',	1);

DROP TABLE IF EXISTS `llx_c_propalst`;
CREATE TABLE `llx_c_propalst` (
  `id` smallint(6) NOT NULL,
  `code` varchar(12) COLLATE utf8_unicode_ci NOT NULL,
  `label` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_c_propalst` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_c_propalst` (`id`, `code`, `label`, `active`) VALUES
(0,	'PR_DRAFT',	'Brouillon',	1),
(1,	'PR_OPEN',	'Ouverte',	1),
(2,	'PR_SIGNED',	'Sign??e',	1),
(3,	'PR_NOTSIGNED',	'Non Sign??e',	1),
(4,	'PR_FAC',	'Factur??e',	1);

DROP TABLE IF EXISTS `llx_c_prospectcontactlevel`;
CREATE TABLE `llx_c_prospectcontactlevel` (
  `code` varchar(12) COLLATE utf8_unicode_ci NOT NULL,
  `label` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sortorder` smallint(6) DEFAULT NULL,
  `active` smallint(6) NOT NULL DEFAULT '1',
  `module` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_c_prospectcontactlevel` (`code`, `label`, `sortorder`, `active`, `module`) VALUES
('PL_HIGH',	'High',	4,	1,	NULL),
('PL_LOW',	'Low',	2,	1,	NULL),
('PL_MEDIUM',	'Medium',	3,	1,	NULL),
('PL_NONE',	'None',	1,	1,	NULL);

DROP TABLE IF EXISTS `llx_c_prospectlevel`;
CREATE TABLE `llx_c_prospectlevel` (
  `code` varchar(12) COLLATE utf8_unicode_ci NOT NULL,
  `label` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sortorder` smallint(6) DEFAULT NULL,
  `active` smallint(6) NOT NULL DEFAULT '1',
  `module` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_c_prospectlevel` (`code`, `label`, `sortorder`, `active`, `module`) VALUES
('PL_HIGH',	'High',	4,	1,	NULL),
('PL_LOW',	'Low',	2,	1,	NULL),
('PL_MEDIUM',	'Medium',	3,	1,	NULL),
('PL_NONE',	'None',	1,	1,	NULL);

DROP TABLE IF EXISTS `llx_c_recruitment_origin`;
CREATE TABLE `llx_c_recruitment_origin` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `label` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_c_regions`;
CREATE TABLE `llx_c_regions` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `code_region` int(11) NOT NULL,
  `fk_pays` int(11) NOT NULL,
  `cheflieu` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tncc` int(11) DEFAULT NULL,
  `nom` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_code_region` (`code_region`),
  KEY `idx_c_regions_fk_pays` (`fk_pays`),
  CONSTRAINT `fk_c_regions_fk_pays` FOREIGN KEY (`fk_pays`) REFERENCES `llx_c_country` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_c_regions` (`rowid`, `code_region`, `fk_pays`, `cheflieu`, `tncc`, `nom`, `active`) VALUES
(1,	0,	0,	'0',	0,	'-',	1),
(2,	1301,	13,	'',	0,	'Algerie',	1),
(3,	34000,	34,	'AD',	NULL,	'Andorra',	1),
(4,	35001,	35,	'AO',	NULL,	'Angola',	1),
(5,	2301,	23,	'',	0,	'Norte',	1),
(6,	2302,	23,	'',	0,	'Litoral',	1),
(7,	2303,	23,	'',	0,	'Cuyana',	1),
(8,	2304,	23,	'',	0,	'Central',	1),
(9,	2305,	23,	'',	0,	'Patagonia',	1),
(10,	2801,	28,	'',	0,	'Australia',	1),
(11,	4101,	41,	'',	0,	'??sterreich',	1),
(12,	4601,	46,	'',	0,	'Barbados',	1),
(13,	201,	2,	'',	1,	'Flandre',	1),
(14,	202,	2,	'',	2,	'Wallonie',	1),
(15,	203,	2,	'',	3,	'Bruxelles-Capitale',	1),
(16,	5201,	52,	'',	0,	'Chuquisaca',	1),
(17,	5202,	52,	'',	0,	'La Paz',	1),
(18,	5203,	52,	'',	0,	'Cochabamba',	1),
(19,	5204,	52,	'',	0,	'Oruro',	1),
(20,	5205,	52,	'',	0,	'Potos??',	1),
(21,	5206,	52,	'',	0,	'Tarija',	1),
(22,	5207,	52,	'',	0,	'Santa Cruz',	1),
(23,	5208,	52,	'',	0,	'El Beni',	1),
(24,	5209,	52,	'',	0,	'Pando',	1),
(25,	5601,	56,	'',	0,	'Brasil',	1),
(26,	1401,	14,	'',	0,	'Canada',	1),
(27,	6701,	67,	NULL,	NULL,	'Tarapac??',	1),
(28,	6702,	67,	NULL,	NULL,	'Antofagasta',	1),
(29,	6703,	67,	NULL,	NULL,	'Atacama',	1),
(30,	6704,	67,	NULL,	NULL,	'Coquimbo',	1),
(31,	6705,	67,	NULL,	NULL,	'Valpara??so',	1),
(32,	6706,	67,	NULL,	NULL,	'General Bernardo O Higgins',	1),
(33,	6707,	67,	NULL,	NULL,	'Maule',	1),
(34,	6708,	67,	NULL,	NULL,	'Biob??o',	1),
(35,	6709,	67,	NULL,	NULL,	'Raucan??a',	1),
(36,	6710,	67,	NULL,	NULL,	'Los Lagos',	1),
(37,	6711,	67,	NULL,	NULL,	'Ays??n General Carlos Ib????ez del Campo',	1),
(38,	6712,	67,	NULL,	NULL,	'Magallanes y Ant??rtica Chilena',	1),
(39,	6713,	67,	NULL,	NULL,	'Metropolitana de Santiago',	1),
(40,	6714,	67,	NULL,	NULL,	'Los R??os',	1),
(41,	6715,	67,	NULL,	NULL,	'Arica y Parinacota',	1),
(42,	901,	9,	'???',	0,	'?????????',	1),
(43,	902,	9,	'???',	0,	'?????????',	1),
(44,	903,	9,	'???',	0,	'?????????',	1),
(45,	904,	9,	'???',	0,	'?????????',	1),
(46,	905,	9,	'???',	0,	'?????????',	1),
(47,	906,	9,	'???',	0,	'?????????',	1),
(48,	907,	9,	'???',	0,	'?????????',	1),
(49,	908,	9,	'???',	0,	'?????????',	1),
(50,	909,	9,	'???',	0,	'????????????',	1),
(51,	910,	9,	'???',	0,	'?????????',	1),
(52,	911,	9,	'???',	0,	'?????????',	1),
(53,	912,	9,	'???',	0,	'?????????',	1),
(54,	913,	9,	'???',	0,	'?????????',	1),
(55,	914,	9,	'???',	0,	'?????????',	1),
(56,	915,	9,	'???',	0,	'?????????',	1),
(57,	916,	9,	'???',	0,	'?????????',	1),
(58,	917,	9,	'???',	0,	'?????????',	1),
(59,	918,	9,	'???',	0,	'?????????',	1),
(60,	919,	9,	'???',	0,	'?????????',	1),
(61,	920,	9,	'???',	0,	'?????????',	1),
(62,	921,	9,	'???',	0,	'?????????',	1),
(63,	922,	9,	'???',	0,	'?????????',	1),
(64,	923,	9,	'???',	0,	'?????????',	1),
(65,	924,	9,	'???',	0,	'?????????',	1),
(66,	925,	9,	'???',	0,	'?????????',	1),
(67,	926,	9,	'???',	0,	'?????????',	1),
(68,	927,	9,	'???',	0,	'?????????',	1),
(69,	928,	9,	'???',	0,	'??????????????????',	1),
(70,	929,	9,	'???',	0,	'?????????????????????',	1),
(71,	930,	9,	'???',	0,	'???????????????',	1),
(72,	931,	9,	'???',	0,	'?????????????????????',	1),
(73,	932,	9,	'???',	0,	'????????????????????????',	1),
(74,	933,	9,	'???',	0,	'?????????????????????',	1),
(75,	934,	9,	'???',	0,	'?????????????????????',	1),
(76,	7001,	70,	'',	0,	'Colombie',	1),
(77,	8001,	80,	'',	0,	'Nordjylland',	1),
(78,	8002,	80,	'',	0,	'Midtjylland',	1),
(79,	8003,	80,	'',	0,	'Syddanmark',	1),
(80,	8004,	80,	'',	0,	'Hovedstaden',	1),
(81,	8005,	80,	'',	0,	'Sj??lland',	1),
(82,	1,	1,	'97105',	3,	'Guadeloupe',	1),
(83,	2,	1,	'97209',	3,	'Martinique',	1),
(84,	3,	1,	'97302',	3,	'Guyane',	1),
(85,	4,	1,	'97411',	3,	'R??union',	1),
(86,	6,	1,	'97601',	3,	'Mayotte',	1),
(87,	11,	1,	'75056',	1,	'??le-de-France',	1),
(88,	24,	1,	'45234',	2,	'Centre-Val de Loire',	1),
(89,	27,	1,	'21231',	0,	'Bourgogne-Franche-Comt??',	1),
(90,	28,	1,	'76540',	0,	'Normandie',	1),
(91,	32,	1,	'59350',	4,	'Hauts-de-France',	1),
(92,	44,	1,	'67482',	2,	'Grand Est',	1),
(93,	52,	1,	'44109',	4,	'Pays de la Loire',	1),
(94,	53,	1,	'35238',	0,	'Bretagne',	1),
(95,	75,	1,	'33063',	0,	'Nouvelle-Aquitaine',	1),
(96,	76,	1,	'31355',	1,	'Occitanie',	1),
(97,	84,	1,	'69123',	1,	'Auvergne-Rh??ne-Alpes',	1),
(98,	93,	1,	'13055',	0,	'Provence-Alpes-C??te d\'Azur',	1),
(99,	94,	1,	'2A004',	0,	'Corse',	1),
(100,	501,	5,	'',	0,	'Deutschland',	1),
(101,	10201,	102,	NULL,	NULL,	'????????????',	1),
(102,	10202,	102,	NULL,	NULL,	'???????????? ????????????',	1),
(103,	10203,	102,	NULL,	NULL,	'???????????????? ??????????????????',	1),
(104,	10204,	102,	NULL,	NULL,	'??????????',	1),
(105,	10205,	102,	NULL,	NULL,	'?????????????????? ?????????????????? ?????? ??????????',	1),
(106,	10206,	102,	NULL,	NULL,	'??????????????',	1),
(107,	10207,	102,	NULL,	NULL,	'?????????? ??????????',	1),
(108,	10208,	102,	NULL,	NULL,	'???????????? ????????????',	1),
(109,	10209,	102,	NULL,	NULL,	'????????????????????????',	1),
(110,	10210,	102,	NULL,	NULL,	'?????????? ????????????',	1),
(111,	10211,	102,	NULL,	NULL,	'???????????? ????????????',	1),
(112,	10212,	102,	NULL,	NULL,	'????????????????',	1),
(113,	10213,	102,	NULL,	NULL,	'???????????? ??????????????????',	1),
(114,	11401,	114,	'',	0,	'Honduras',	1),
(115,	180100,	18,	'HU1',	NULL,	'K??z??p-Magyarorsz??g',	1),
(116,	182100,	18,	'HU21',	NULL,	'K??z??p-Dun??nt??l',	1),
(117,	182200,	18,	'HU22',	NULL,	'Nyugat-Dun??nt??l',	1),
(118,	182300,	18,	'HU23',	NULL,	'D??l-Dun??nt??l',	1),
(119,	183100,	18,	'HU31',	NULL,	'??szak-Magyarorsz??g',	1),
(120,	183200,	18,	'HU32',	NULL,	'??szak-Alf??ld',	1),
(121,	183300,	18,	'HU33',	NULL,	'D??l-Alf??ld',	1),
(122,	11701,	117,	'',	0,	'India',	1),
(123,	11801,	118,	'',	0,	'Indonesia',	1),
(124,	301,	3,	NULL,	1,	'Abruzzo',	1),
(125,	302,	3,	NULL,	1,	'Basilicata',	1),
(126,	303,	3,	NULL,	1,	'Calabria',	1),
(127,	304,	3,	NULL,	1,	'Campania',	1),
(128,	305,	3,	NULL,	1,	'Emilia-Romagna',	1),
(129,	306,	3,	NULL,	1,	'Friuli-Venezia Giulia',	1),
(130,	307,	3,	NULL,	1,	'Lazio',	1),
(131,	308,	3,	NULL,	1,	'Liguria',	1),
(132,	309,	3,	NULL,	1,	'Lombardia',	1),
(133,	310,	3,	NULL,	1,	'Marche',	1),
(134,	311,	3,	NULL,	1,	'Molise',	1),
(135,	312,	3,	NULL,	1,	'Piemonte',	1),
(136,	313,	3,	NULL,	1,	'Puglia',	1),
(137,	314,	3,	NULL,	1,	'Sardegna',	1),
(138,	315,	3,	NULL,	1,	'Sicilia',	1),
(139,	316,	3,	NULL,	1,	'Toscana',	1),
(140,	317,	3,	NULL,	1,	'Trentino-Alto Adige',	1),
(141,	318,	3,	NULL,	1,	'Umbria',	1),
(142,	319,	3,	NULL,	1,	'Valle d Aosta',	1),
(143,	320,	3,	NULL,	1,	'Veneto',	1),
(144,	14001,	140,	'',	0,	'Diekirch',	1),
(145,	14002,	140,	'',	0,	'Grevenmacher',	1),
(146,	14003,	140,	'',	0,	'Luxembourg',	1),
(147,	15201,	152,	'',	0,	'Rivi??re Noire',	1),
(148,	15202,	152,	'',	0,	'Flacq',	1),
(149,	15203,	152,	'',	0,	'Grand Port',	1),
(150,	15204,	152,	'',	0,	'Moka',	1),
(151,	15205,	152,	'',	0,	'Pamplemousses',	1),
(152,	15206,	152,	'',	0,	'Plaines Wilhems',	1),
(153,	15207,	152,	'',	0,	'Port-Louis',	1),
(154,	15208,	152,	'',	0,	'Rivi??re du Rempart',	1),
(155,	15209,	152,	'',	0,	'Savanne',	1),
(156,	15210,	152,	'',	0,	'Rodrigues',	1),
(157,	15211,	152,	'',	0,	'Les ??les Agal??ga',	1),
(158,	15212,	152,	'',	0,	'Les ??cueils des Cargados Carajos',	1),
(159,	15401,	154,	'',	0,	'Mexique',	1),
(160,	1201,	12,	'',	0,	'Tanger-T??touan',	1),
(161,	1202,	12,	'',	0,	'Gharb-Chrarda-Beni Hssen',	1),
(162,	1203,	12,	'',	0,	'Taza-Al Hoceima-Taounate',	1),
(163,	1204,	12,	'',	0,	'L\'Oriental',	1),
(164,	1205,	12,	'',	0,	'F??s-Boulemane',	1),
(165,	1206,	12,	'',	0,	'Mekn??s-Tafialet',	1),
(166,	1207,	12,	'',	0,	'Rabat-Sal??-Zemour-Za??r',	1),
(167,	1208,	12,	'',	0,	'Grand Cassablanca',	1),
(168,	1209,	12,	'',	0,	'Chaouia-Ouardigha',	1),
(169,	1210,	12,	'',	0,	'Doukahla-Adba',	1),
(170,	1211,	12,	'',	0,	'Marrakech-Tensift-Al Haouz',	1),
(171,	1212,	12,	'',	0,	'Tadla-Azilal',	1),
(172,	1213,	12,	'',	0,	'Sous-Massa-Dr??a',	1),
(173,	1214,	12,	'',	0,	'Guelmim-Es Smara',	1),
(174,	1215,	12,	'',	0,	'La??youne-Boujdour-Sakia el Hamra',	1),
(175,	1216,	12,	'',	0,	'Oued Ed-Dahab Lagouira',	1),
(176,	1701,	17,	'',	0,	'Provincies van Nederland ',	1),
(177,	17801,	178,	'',	0,	'Panama',	1),
(178,	18101,	181,	'',	0,	'Amazonas',	1),
(179,	18102,	181,	'',	0,	'Ancash',	1),
(180,	18103,	181,	'',	0,	'Apurimac',	1),
(181,	18104,	181,	'',	0,	'Arequipa',	1),
(182,	18105,	181,	'',	0,	'Ayacucho',	1),
(183,	18106,	181,	'',	0,	'Cajamarca',	1),
(184,	18107,	181,	'',	0,	'Callao',	1),
(185,	18108,	181,	'',	0,	'Cuzco',	1),
(186,	18109,	181,	'',	0,	'Huancavelica',	1),
(187,	18110,	181,	'',	0,	'Huanuco',	1),
(188,	18111,	181,	'',	0,	'Ica',	1),
(189,	18112,	181,	'',	0,	'Junin',	1),
(190,	18113,	181,	'',	0,	'La Libertad',	1),
(191,	18114,	181,	'',	0,	'Lambayeque',	1),
(192,	18115,	181,	'',	0,	'Lima Metropolitana',	1),
(193,	18116,	181,	'',	0,	'Lima',	1),
(194,	18117,	181,	'',	0,	'Loreto',	1),
(195,	18118,	181,	'',	0,	'Madre de Dios',	1),
(196,	18119,	181,	'',	0,	'Moquegua',	1),
(197,	18120,	181,	'',	0,	'Pasco',	1),
(198,	18121,	181,	'',	0,	'Piura',	1),
(199,	18122,	181,	'',	0,	'Puno',	1),
(200,	18123,	181,	'',	0,	'San Mart??n',	1),
(201,	18124,	181,	'',	0,	'Tacna',	1),
(202,	18125,	181,	'',	0,	'Tumbes',	1),
(203,	18126,	181,	'',	0,	'Ucayali',	1),
(204,	15001,	25,	'PT',	NULL,	'Portugal',	1),
(205,	15002,	25,	'PT9',	NULL,	'Azores-Madeira',	1),
(206,	18801,	188,	'',	0,	'Romania',	1),
(207,	8601,	86,	NULL,	NULL,	'Central',	1),
(208,	8602,	86,	NULL,	NULL,	'Oriental',	1),
(209,	8603,	86,	NULL,	NULL,	'Occidental',	1),
(210,	20203,	202,	'SI03',	NULL,	'East Slovenia',	1),
(211,	20204,	202,	'SI04',	NULL,	'West Slovenia',	1),
(212,	401,	4,	'',	0,	'Andalucia',	1),
(213,	402,	4,	'',	0,	'Arag??n',	1),
(214,	403,	4,	'',	0,	'Castilla y Le??n',	1),
(215,	404,	4,	'',	0,	'Castilla la Mancha',	1),
(216,	405,	4,	'',	0,	'Canarias',	1),
(217,	406,	4,	'',	0,	'Catalu??a',	1),
(218,	407,	4,	'',	0,	'Comunidad de Ceuta',	1),
(219,	408,	4,	'',	0,	'Comunidad Foral de Navarra',	1),
(220,	409,	4,	'',	0,	'Comunidad de Melilla',	1),
(221,	410,	4,	'',	0,	'Cantabria',	1),
(222,	411,	4,	'',	0,	'Comunidad Valenciana',	1),
(223,	412,	4,	'',	0,	'Extemadura',	1),
(224,	413,	4,	'',	0,	'Galicia',	1),
(225,	414,	4,	'',	0,	'Islas Baleares',	1),
(226,	415,	4,	'',	0,	'La Rioja',	1),
(227,	416,	4,	'',	0,	'Comunidad de Madrid',	1),
(228,	417,	4,	'',	0,	'Regi??n de Murcia',	1),
(229,	418,	4,	'',	0,	'Principado de Asturias',	1),
(230,	419,	4,	'',	0,	'Pais Vasco',	1),
(231,	420,	4,	'',	0,	'Otros',	1),
(232,	601,	6,	'',	1,	'Cantons',	1),
(233,	21301,	213,	'TW',	NULL,	'Taiwan',	1),
(234,	1001,	10,	'',	0,	'Ariana',	1),
(235,	1002,	10,	'',	0,	'B??ja',	1),
(236,	1003,	10,	'',	0,	'Ben Arous',	1),
(237,	1004,	10,	'',	0,	'Bizerte',	1),
(238,	1005,	10,	'',	0,	'Gab??s',	1),
(239,	1006,	10,	'',	0,	'Gafsa',	1),
(240,	1007,	10,	'',	0,	'Jendouba',	1),
(241,	1008,	10,	'',	0,	'Kairouan',	1),
(242,	1009,	10,	'',	0,	'Kasserine',	1),
(243,	1010,	10,	'',	0,	'K??bili',	1),
(244,	1011,	10,	'',	0,	'La Manouba',	1),
(245,	1012,	10,	'',	0,	'Le Kef',	1),
(246,	1013,	10,	'',	0,	'Mahdia',	1),
(247,	1014,	10,	'',	0,	'M??denine',	1),
(248,	1015,	10,	'',	0,	'Monastir',	1),
(249,	1016,	10,	'',	0,	'Nabeul',	1),
(250,	1017,	10,	'',	0,	'Sfax',	1),
(251,	1018,	10,	'',	0,	'Sidi Bouzid',	1),
(252,	1019,	10,	'',	0,	'Siliana',	1),
(253,	1020,	10,	'',	0,	'Sousse',	1),
(254,	1021,	10,	'',	0,	'Tataouine',	1),
(255,	1022,	10,	'',	0,	'Tozeur',	1),
(256,	1023,	10,	'',	0,	'Tunis',	1),
(257,	1024,	10,	'',	0,	'Zaghouan',	1),
(258,	22701,	227,	'',	0,	'United Arab Emirates',	1),
(259,	701,	7,	'',	0,	'England',	1),
(260,	702,	7,	'',	0,	'Wales',	1),
(261,	703,	7,	'',	0,	'Scotland',	1),
(262,	704,	7,	'',	0,	'Northern Ireland',	1),
(263,	1101,	11,	'',	0,	'United-States',	1),
(264,	23201,	232,	'',	0,	'Los Andes',	1),
(265,	23202,	232,	'',	0,	'Capital',	1),
(266,	23203,	232,	'',	0,	'Central',	1),
(267,	23204,	232,	'',	0,	'Cento Occidental',	1),
(268,	23205,	232,	'',	0,	'Guayana',	1),
(269,	23206,	232,	'',	0,	'Insular',	1),
(270,	23207,	232,	'',	0,	'Los Llanos',	1),
(271,	23208,	232,	'',	0,	'Nor-Oriental',	1),
(272,	23209,	232,	'',	0,	'Zuliana',	1);

DROP TABLE IF EXISTS `llx_c_revenuestamp`;
CREATE TABLE `llx_c_revenuestamp` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_pays` int(11) NOT NULL,
  `taux` double NOT NULL,
  `revenuestamp_type` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'fixed',
  `note` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `accountancy_code_sell` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `accountancy_code_buy` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_c_revenuestamp` (`rowid`, `fk_pays`, `taux`, `revenuestamp_type`, `note`, `active`, `accountancy_code_sell`, `accountancy_code_buy`) VALUES
(101,	10,	0.4,	'fixed',	'Revenue stamp tunisia',	1,	NULL,	NULL),
(1541,	154,	1.5,	'percent',	'Revenue stamp mexico',	1,	NULL,	NULL),
(1542,	154,	3,	'percent',	'Revenue stamp mexico',	1,	NULL,	NULL);

DROP TABLE IF EXISTS `llx_c_shipment_mode`;
CREATE TABLE `llx_c_shipment_mode` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `code` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `libelle` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `tracking` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` tinyint(4) DEFAULT '0',
  `module` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_c_shipment_mode` (`code`,`entity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_c_shipment_mode` (`rowid`, `entity`, `tms`, `code`, `libelle`, `description`, `tracking`, `active`, `module`) VALUES
(1,	1,	'2022-09-06 10:05:27',	'CATCH',	'In-Store Collection',	'In-store collection by the customer',	'',	1,	NULL),
(2,	1,	'2022-09-06 10:05:27',	'TRANS',	'Generic transport service',	'Generic transport service',	'',	1,	NULL),
(3,	1,	'2022-09-06 10:05:27',	'COLSUI',	'Colissimo Suivi',	'Colissimo Suivi',	'https://www.laposte.fr/outils/suivre-vos-envois?code={TRACKID}',	0,	NULL),
(4,	1,	'2022-09-06 10:05:27',	'LETTREMAX',	'Lettre Max',	'Courrier Suivi et Lettre Max',	'https://www.laposte.fr/outils/suivre-vos-envois?code={TRACKID}',	0,	NULL),
(5,	1,	'2022-09-06 10:05:27',	'UPS',	'UPS',	'United Parcel Service',	'http://wwwapps.ups.com/etracking/tracking.cgi?InquiryNumber2=&InquiryNumber3=&tracknums_displayed=3&loc=fr_FR&TypeOfInquiryNumber=T&HTMLVersion=4.0&InquiryNumber22=&InquiryNumber32=&track=Track&Suivi.x=64&Suivi.y=7&Suivi=Valider&InquiryNumber1={TRACKID}',	1,	NULL),
(6,	1,	'2022-09-06 10:05:27',	'KIALA',	'KIALA',	'Relais Kiala',	'http://www.kiala.fr/tnt/delivery/{TRACKID}',	0,	NULL),
(7,	1,	'2022-09-06 10:05:27',	'GLS',	'GLS',	'General Logistics Systems',	'https://gls-group.eu/FR/fr/suivi-colis?match={TRACKID}',	0,	NULL),
(8,	1,	'2022-09-06 10:05:27',	'CHRONO',	'Chronopost',	'Chronopost',	'http://www.chronopost.fr/expedier/inputLTNumbersNoJahia.do?listeNumeros={TRACKID}',	0,	NULL),
(9,	1,	'2022-09-06 10:05:27',	'INPERSON',	'In person at your site',	NULL,	NULL,	0,	NULL),
(10,	1,	'2022-09-06 10:05:27',	'FEDEX',	'Fedex',	NULL,	'https://www.fedex.com/apps/fedextrack/index.html?tracknumbers={TRACKID}',	0,	NULL),
(11,	1,	'2022-09-06 10:05:27',	'TNT',	'TNT',	NULL,	'https://www.tnt.com/express/fr_fr/site/outils-expedition/suivi.html?searchType=con&cons=={TRACKID}',	0,	NULL),
(12,	1,	'2022-09-06 10:05:27',	'DHL',	'DHL',	NULL,	'https://www.dhl.com/fr-fr/home/tracking/tracking-global-forwarding.html?submit=1&tracking-id={TRACKID}',	0,	NULL),
(13,	1,	'2022-09-06 10:05:27',	'DPD',	'DPD',	NULL,	'https://www.dpd.fr/trace/{TRACKID}',	0,	NULL),
(14,	1,	'2022-09-06 10:05:27',	'MAINFREIGHT',	'Mainfreight',	NULL,	'https://www.mainfreight.com/track?{TRACKID}',	0,	NULL);

DROP TABLE IF EXISTS `llx_c_shipment_package_type`;
CREATE TABLE `llx_c_shipment_package_type` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` int(11) NOT NULL DEFAULT '1',
  `entity` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_c_socialnetworks`;
CREATE TABLE `llx_c_socialnetworks` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `code` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `label` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `url` text COLLATE utf8_unicode_ci,
  `icon` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `idx_c_socialnetworks_code_entity` (`entity`,`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_c_socialnetworks` (`rowid`, `entity`, `code`, `label`, `url`, `icon`, `active`) VALUES
(1,	1,	'500px',	'500px',	'{socialid}',	'fa-500px',	0),
(2,	1,	'dailymotion',	'Dailymotion',	'{socialid}',	'',	0),
(3,	1,	'diaspora',	'Diaspora',	'{socialid}',	'',	0),
(4,	1,	'discord',	'Discord',	'{socialid}',	'fa-discord',	0),
(5,	1,	'facebook',	'Facebook',	'https://www.facebook.com/{socialid}',	'fa-facebook',	1),
(6,	1,	'flickr',	'Flickr',	'{socialid}',	'fa-flickr',	0),
(7,	1,	'gifycat',	'Gificat',	'{socialid}',	'',	0),
(8,	1,	'giphy',	'Giphy',	'{socialid}',	'',	0),
(9,	1,	'googleplus',	'GooglePlus',	'https://www.googleplus.com/{socialid}',	'fa-google-plus-g',	0),
(10,	1,	'instagram',	'Instagram',	'https://www.instagram.com/{socialid}',	'fa-instagram',	1),
(11,	1,	'linkedin',	'LinkedIn',	'https://www.linkedin.com/{socialid}',	'fa-linkedin',	1),
(12,	1,	'mastodon',	'Mastodon',	'{socialid}',	'',	0),
(13,	1,	'meetup',	'Meetup',	'{socialid}',	'fa-meetup',	0),
(14,	1,	'periscope',	'Periscope',	'{socialid}',	'',	0),
(15,	1,	'pinterest',	'Pinterest',	'{socialid}',	'fa-pinterest',	0),
(16,	1,	'quora',	'Quora',	'{socialid}',	'',	0),
(17,	1,	'reddit',	'Reddit',	'{socialid}',	'fa-reddit',	0),
(18,	1,	'slack',	'Slack',	'{socialid}',	'fa-slack',	0),
(19,	1,	'snapchat',	'Snapchat',	'{socialid}',	'fa-snapchat',	1),
(20,	1,	'skype',	'Skype',	'https://www.skype.com/{socialid}',	'fa-skype',	1),
(21,	1,	'tripadvisor',	'Tripadvisor',	'{socialid}',	'',	0),
(22,	1,	'tumblr',	'Tumblr',	'https://www.tumblr.com/{socialid}',	'fa-tumblr',	0),
(23,	1,	'twitch',	'Twitch',	'{socialid}',	'',	0),
(24,	1,	'twitter',	'Twitter',	'https://www.twitter.com/{socialid}',	'fa-twitter',	1),
(25,	1,	'vero',	'Vero',	'https://vero.co/{socialid}',	'',	0),
(26,	1,	'viadeo',	'Viadeo',	'https://fr.viadeo.com/fr/{socialid}',	'fa-viadeo',	0),
(27,	1,	'viber',	'Viber',	'{socialid}',	'',	0),
(28,	1,	'vimeo',	'Vimeo',	'{socialid}',	'',	0),
(29,	1,	'whatsapp',	'Whatsapp',	'{socialid}',	'fa-whatsapp',	1),
(30,	1,	'wikipedia',	'Wikipedia',	'{socialid}',	'',	0),
(31,	1,	'xing',	'Xing',	'{socialid}',	'fa-xing',	0),
(32,	1,	'youtube',	'Youtube',	'https://www.youtube.com/{socialid}',	'fa-youtube',	1);

DROP TABLE IF EXISTS `llx_c_stcomm`;
CREATE TABLE `llx_c_stcomm` (
  `id` int(11) NOT NULL,
  `code` varchar(12) COLLATE utf8_unicode_ci NOT NULL,
  `libelle` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `picto` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_c_stcomm` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_c_stcomm` (`id`, `code`, `libelle`, `picto`, `active`) VALUES
(-1,	'ST_NO',	'Do not contact',	NULL,	1),
(0,	'ST_NEVER',	'Never contacted',	NULL,	1),
(1,	'ST_TODO',	'To contact',	NULL,	1),
(2,	'ST_PEND',	'Contact in progress',	NULL,	1),
(3,	'ST_DONE',	'Contacted',	NULL,	1);

DROP TABLE IF EXISTS `llx_c_stcommcontact`;
CREATE TABLE `llx_c_stcommcontact` (
  `id` int(11) NOT NULL,
  `code` varchar(12) COLLATE utf8_unicode_ci NOT NULL,
  `libelle` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `picto` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_c_stcommcontact` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_c_stcommcontact` (`id`, `code`, `libelle`, `picto`, `active`) VALUES
(-1,	'ST_NO',	'Do not contact',	NULL,	1),
(0,	'ST_NEVER',	'Never contacted',	NULL,	1),
(1,	'ST_TODO',	'To contact',	NULL,	1),
(2,	'ST_PEND',	'Contact in progress',	NULL,	1),
(3,	'ST_DONE',	'Contacted',	NULL,	1);

DROP TABLE IF EXISTS `llx_c_subtotal_free_text`;
CREATE TABLE `llx_c_subtotal_free_text` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `content` text COLLATE utf8_unicode_ci,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `entity` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_c_ticket_category`;
CREATE TABLE `llx_c_ticket_category` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) DEFAULT '1',
  `code` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `label` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `public` int(11) DEFAULT '0',
  `use_default` int(11) DEFAULT '1',
  `fk_parent` int(11) NOT NULL DEFAULT '0',
  `force_severity` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pos` int(11) NOT NULL DEFAULT '0',
  `active` int(11) DEFAULT '1',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_code` (`code`,`entity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_c_ticket_category` (`rowid`, `entity`, `code`, `label`, `public`, `use_default`, `fk_parent`, `force_severity`, `description`, `pos`, `active`) VALUES
(1,	1,	'OTHER',	'Other',	0,	1,	0,	NULL,	NULL,	10,	1);

DROP TABLE IF EXISTS `llx_c_ticket_resolution`;
CREATE TABLE `llx_c_ticket_resolution` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) DEFAULT '1',
  `code` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `pos` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `label` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `active` int(11) DEFAULT '1',
  `use_default` int(11) DEFAULT '1',
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_code` (`code`,`entity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_c_ticket_resolution` (`rowid`, `entity`, `code`, `pos`, `label`, `active`, `use_default`, `description`) VALUES
(1,	1,	'SOLVED',	'10',	'Solved',	1,	0,	NULL),
(2,	1,	'CANCELED',	'50',	'Canceled',	1,	0,	NULL),
(3,	1,	'OTHER',	'90',	'Other',	1,	0,	NULL);

DROP TABLE IF EXISTS `llx_c_ticket_severity`;
CREATE TABLE `llx_c_ticket_severity` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) DEFAULT '1',
  `code` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `pos` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `label` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `color` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` int(11) DEFAULT '1',
  `use_default` int(11) DEFAULT '1',
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_code` (`code`,`entity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_c_ticket_severity` (`rowid`, `entity`, `code`, `pos`, `label`, `color`, `active`, `use_default`, `description`) VALUES
(1,	1,	'LOW',	'10',	'Low',	'',	1,	0,	NULL),
(2,	1,	'NORMAL',	'20',	'Normal',	'',	1,	1,	NULL),
(3,	1,	'HIGH',	'30',	'High',	'',	1,	0,	NULL),
(4,	1,	'BLOCKING',	'40',	'Critical / blocking',	'',	1,	0,	NULL);

DROP TABLE IF EXISTS `llx_c_ticket_type`;
CREATE TABLE `llx_c_ticket_type` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) DEFAULT '1',
  `code` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `pos` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `label` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `active` int(11) DEFAULT '1',
  `use_default` int(11) DEFAULT '1',
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_code` (`code`,`entity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_c_ticket_type` (`rowid`, `entity`, `code`, `pos`, `label`, `active`, `use_default`, `description`) VALUES
(1,	1,	'COM',	'10',	'Commercial question',	1,	0,	NULL),
(2,	1,	'HELP',	'15',	'Request for functionnal help',	1,	0,	NULL),
(3,	1,	'ISSUE',	'20',	'Issue or bug',	1,	0,	NULL),
(4,	1,	'PROBLEM',	'22',	'Problem',	0,	0,	NULL),
(5,	1,	'REQUEST',	'25',	'Change or enhancement request',	1,	0,	NULL),
(6,	1,	'PROJECT',	'30',	'Project',	0,	0,	NULL),
(7,	1,	'OTHER',	'40',	'Other',	1,	0,	NULL);

DROP TABLE IF EXISTS `llx_c_transport_mode`;
CREATE TABLE `llx_c_transport_mode` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `code` varchar(3) COLLATE utf8_unicode_ci NOT NULL,
  `label` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_c_transport_mode` (`code`,`entity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_c_transport_mode` (`rowid`, `entity`, `code`, `label`, `active`) VALUES
(1,	1,	'MAR',	'Transport maritime (y compris camions ou wagons sur bateau)',	1),
(2,	1,	'TRA',	'Transport par chemin de fer (y compris camions sur wagon)',	1),
(3,	1,	'ROU',	'Transport par route',	1),
(4,	1,	'AIR',	'Transport par air',	1),
(5,	1,	'POS',	'Envois postaux',	1),
(6,	1,	'OLE',	'Installations de transport fixe (ol??oduc)',	1),
(7,	1,	'NAV',	'Transport par navigation int??rieure',	1),
(8,	1,	'PRO',	'Propulsion propre',	1);

DROP TABLE IF EXISTS `llx_c_tva`;
CREATE TABLE `llx_c_tva` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_pays` int(11) NOT NULL,
  `code` varchar(10) COLLATE utf8_unicode_ci DEFAULT '',
  `taux` double NOT NULL,
  `localtax1` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `localtax1_type` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `localtax2` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `localtax2_type` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `recuperableonly` int(11) NOT NULL DEFAULT '0',
  `note` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `accountancy_code_sell` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `accountancy_code_buy` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_c_tva_id` (`fk_pays`,`code`,`taux`,`recuperableonly`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_c_tva` (`rowid`, `fk_pays`, `code`, `taux`, `localtax1`, `localtax1_type`, `localtax2`, `localtax2_type`, `recuperableonly`, `note`, `active`, `accountancy_code_sell`, `accountancy_code_buy`) VALUES
(11,	1,	'',	0,	'0',	'0',	'0',	'0',	0,	'VAT rate 0 ou non applicable',	1,	NULL,	NULL),
(12,	1,	'',	20,	'0',	'0',	'0',	'0',	0,	'VAT rate - standard (France hors DOM-TOM)',	1,	NULL,	NULL),
(13,	1,	'',	10,	'0',	'0',	'0',	'0',	0,	'VAT rate - reduced',	1,	NULL,	NULL),
(14,	1,	'',	5.5,	'0',	'0',	'0',	'0',	0,	'VAT rate - reduced (France hors DOM-TOM)',	1,	NULL,	NULL),
(15,	1,	'',	2.1,	'0',	'0',	'0',	'0',	0,	'VAT rate - super-reduced',	1,	NULL,	NULL),
(16,	1,	'85',	8.5,	'0',	'0',	'0',	'0',	0,	'VAT rate - standard (DOM sauf Guyane et Saint-Martin)',	0,	NULL,	NULL),
(17,	1,	'85NPR',	8.5,	'0',	'0',	'0',	'0',	1,	'VAT rate - standard (DOM sauf Guyane et Saint-Martin), non per??u par le vendeur mais r??cup??rable par acheteur',	0,	NULL,	NULL),
(18,	1,	'85NPROM',	8.5,	'2',	'3',	'0',	'0',	1,	'VAT rate - standard (DOM sauf Guyane et Saint-Martin), NPR, Octroi de Mer',	0,	NULL,	NULL),
(19,	1,	'85NPROMOMR',	8.5,	'2',	'3',	'2.5',	'3',	1,	'VAT rate - standard (DOM sauf Guyane et Saint-Martin), NPR, Octroi de Mer et Octroi de Mer Regional',	0,	NULL,	NULL),
(21,	2,	'',	0,	'0',	'0',	'0',	'0',	0,	'VAT rate 0 ou non applicable',	1,	NULL,	NULL),
(22,	2,	'',	6,	'0',	'0',	'0',	'0',	0,	'VAT rate - reduced',	1,	NULL,	NULL),
(23,	2,	'',	21,	'0',	'0',	'0',	'0',	0,	'VAT rate - standard',	1,	NULL,	NULL),
(24,	2,	'',	12,	'0',	'0',	'0',	'0',	0,	'VAT rate - reduced',	1,	NULL,	NULL),
(31,	3,	'',	0,	'0',	'0',	'0',	'0',	0,	'VAT rate 0',	1,	NULL,	NULL),
(32,	3,	'',	10,	'0',	'0',	'0',	'0',	0,	'VAT rate - reduced',	1,	NULL,	NULL),
(33,	3,	'',	4,	'0',	'0',	'0',	'0',	0,	'VAT rate - super-reduced',	1,	NULL,	NULL),
(34,	3,	'',	22,	'0',	'0',	'0',	'0',	0,	'VAT rate - standard',	1,	NULL,	NULL),
(41,	4,	'',	0,	'0',	'3',	'-19:-15:-9',	'5',	0,	'VAT rate 0',	1,	NULL,	NULL),
(42,	4,	'',	10,	'1.4',	'3',	'-19:-15:-9',	'5',	0,	'VAT rate - reduced',	1,	NULL,	NULL),
(43,	4,	'',	4,	'0.5',	'3',	'-19:-15:-9',	'5',	0,	'VAT rate - super-reduced',	1,	NULL,	NULL),
(44,	4,	'',	21,	'5.2',	'3',	'-19:-15:-9',	'5',	0,	'VAT rate - standard',	1,	NULL,	NULL),
(51,	5,	'',	0,	'0',	'0',	'0',	'0',	0,	'No VAT',	1,	NULL,	NULL),
(52,	5,	'',	7,	'0',	'0',	'0',	'0',	0,	'erm????igte USt.',	1,	NULL,	NULL),
(54,	5,	'',	5.5,	'0',	'0',	'0',	'0',	0,	'USt. Forst',	0,	NULL,	NULL),
(55,	5,	'',	10.7,	'0',	'0',	'0',	'0',	0,	'USt. Landwirtschaft',	0,	NULL,	NULL),
(56,	5,	'',	19,	'0',	'0',	'0',	'0',	0,	'allgemeine Ust.',	1,	NULL,	NULL),
(61,	6,	'',	0,	'0',	'0',	'0',	'0',	0,	'VAT rate 0',	1,	NULL,	NULL),
(62,	6,	'',	3.7,	'0',	'0',	'0',	'0',	0,	'VAT rate - reduced',	1,	NULL,	NULL),
(63,	6,	'',	2.5,	'0',	'0',	'0',	'0',	0,	'VAT rate - super-reduced',	1,	NULL,	NULL),
(64,	6,	'',	7.7,	'0',	'0',	'0',	'0',	0,	'VAT rate - standard',	1,	NULL,	NULL),
(71,	7,	'',	0,	'0',	'0',	'0',	'0',	0,	'VAT rate 0',	1,	NULL,	NULL),
(72,	7,	'',	17.5,	'0',	'0',	'0',	'0',	0,	'VAT rate - standard before 2011',	1,	NULL,	NULL),
(73,	7,	'',	5,	'0',	'0',	'0',	'0',	0,	'VAT rate - reduced',	1,	NULL,	NULL),
(74,	7,	'',	20,	'0',	'0',	'0',	'0',	0,	'VAT rate - standard',	1,	NULL,	NULL),
(81,	8,	'',	0,	'0',	'0',	'0',	'0',	0,	'VAT rate 0',	1,	NULL,	NULL),
(82,	8,	'',	23,	'0',	'0',	'0',	'0',	0,	'VAT rate - standard',	1,	NULL,	NULL),
(83,	8,	'',	13.5,	'0',	'0',	'0',	'0',	0,	'VAT rate - reduced',	1,	NULL,	NULL),
(84,	8,	'',	9,	'0',	'0',	'0',	'0',	0,	'VAT rate - reduced',	1,	NULL,	NULL),
(85,	8,	'',	4.8,	'0',	'0',	'0',	'0',	0,	'VAT rate - reduced',	1,	NULL,	NULL),
(91,	9,	'',	0,	'0',	'0',	'0',	'0',	0,	'VAT rate 0',	1,	NULL,	NULL),
(92,	9,	'',	13,	'0',	'0',	'0',	'0',	0,	'VAT rate - reduced 0',	1,	NULL,	NULL),
(93,	9,	'',	3,	'0',	'0',	'0',	'0',	0,	'VAT rate -  super-reduced 0',	1,	NULL,	NULL),
(94,	9,	'',	17,	'0',	'0',	'0',	'0',	0,	'VAT rate - standard',	1,	NULL,	NULL),
(101,	10,	'',	0,	'0',	'0',	'0',	'0',	0,	'VAT rate 0',	1,	NULL,	NULL),
(102,	10,	'',	12,	'0',	'0',	'0',	'0',	0,	'VAT 12%',	1,	NULL,	NULL),
(103,	10,	'',	18,	'0',	'0',	'0',	'0',	0,	'VAT 18%',	1,	NULL,	NULL),
(104,	10,	'',	7.5,	'0',	'0',	'0',	'0',	0,	'VAT 6% Major?? ?? 25% (7.5%)',	1,	NULL,	NULL),
(105,	10,	'',	15,	'0',	'0',	'0',	'0',	0,	'VAT 12% Major?? ?? 25% (15%)',	1,	NULL,	NULL),
(106,	10,	'',	22.5,	'0',	'0',	'0',	'0',	0,	'VAT 18% Major?? ?? 25% (22.5%)',	1,	NULL,	NULL),
(107,	10,	'',	6,	'0',	'0',	'0',	'0',	0,	'VAT 6%',	1,	NULL,	NULL),
(108,	10,	'',	18.18,	'1',	'4',	'0',	'0',	0,	'VAT 18%+FODEC',	1,	NULL,	NULL),
(111,	11,	'',	0,	'0',	'0',	'0',	'0',	0,	'No Sales Tax',	1,	NULL,	NULL),
(112,	11,	'',	4,	'0',	'0',	'0',	'0',	0,	'Sales Tax 4%',	1,	NULL,	NULL),
(113,	11,	'',	6,	'0',	'0',	'0',	'0',	0,	'Sales Tax 6%',	1,	NULL,	NULL),
(121,	12,	'',	0,	'0',	'0',	'0',	'0',	0,	'VAT rate 0',	1,	NULL,	NULL),
(122,	12,	'',	14,	'0',	'0',	'0',	'0',	0,	'VAT rate - reduced',	1,	NULL,	NULL),
(123,	12,	'',	10,	'0',	'0',	'0',	'0',	0,	'VAT rate - reduced',	1,	NULL,	NULL),
(124,	12,	'',	7,	'0',	'0',	'0',	'0',	0,	'VAT rate - super-reduced',	1,	NULL,	NULL),
(125,	12,	'',	20,	'0',	'0',	'0',	'0',	0,	'VAT rate - standard',	1,	NULL,	NULL),
(131,	13,	'',	0,	'0',	'0',	'0',	'0',	0,	'TVA 0%',	1,	NULL,	NULL),
(132,	13,	'',	9,	'0',	'0',	'0',	'0',	0,	'TVA 9%',	1,	NULL,	NULL),
(133,	13,	'',	19,	'0',	'0',	'0',	'0',	0,	'TVA 19%',	1,	NULL,	NULL),
(141,	14,	'',	0,	'0',	'0',	'0',	'0',	0,	'VAT rate 0',	1,	NULL,	NULL),
(142,	14,	'',	7,	'0',	'0',	'0',	'0',	0,	'VAT rate - standard',	1,	NULL,	NULL),
(143,	14,	'',	5,	'9.975',	'1',	'0',	'0',	0,	'GST/TPS and PST/TVQ rate for Province',	1,	NULL,	NULL),
(171,	17,	'',	0,	'0',	'0',	'0',	'0',	0,	'0 BTW tarief',	1,	NULL,	NULL),
(172,	17,	'',	6,	'0',	'0',	'0',	'0',	0,	'Verlaagd BTW tarief',	1,	NULL,	NULL),
(173,	17,	'',	19,	'0',	'0',	'0',	'0',	0,	'Algemeen BTW tarief',	1,	NULL,	NULL),
(174,	17,	'',	21,	'0',	'0',	'0',	'0',	0,	'Algemeen BTW tarief (vanaf 1 oktober 2012)',	0,	NULL,	NULL),
(201,	20,	'',	0,	'0',	'0',	'0',	'0',	0,	'VAT rate 0',	1,	NULL,	NULL),
(202,	20,	'',	12,	'0',	'0',	'0',	'0',	0,	'VAT rate - reduced',	1,	NULL,	NULL),
(203,	20,	'',	6,	'0',	'0',	'0',	'0',	0,	'VAT rate - super-reduced',	1,	NULL,	NULL),
(204,	20,	'',	25,	'0',	'0',	'0',	'0',	0,	'VAT rate - standard',	1,	NULL,	NULL),
(211,	21,	'',	0,	'0',	'0',	'0',	'0',	0,	'IVA Rate 0',	1,	NULL,	NULL),
(212,	21,	'',	18,	'7.5',	'2',	'0',	'0',	0,	'IVA standard rate',	1,	NULL,	NULL),
(221,	22,	'',	0,	'0',	'0',	'0',	'0',	0,	'VAT rate 0',	1,	NULL,	NULL),
(222,	22,	'',	10,	'0',	'0',	'0',	'0',	0,	'VAT rate - reduced',	1,	NULL,	NULL),
(223,	22,	'',	18,	'0',	'0',	'0',	'0',	0,	'VAT rate - standard',	1,	NULL,	NULL),
(231,	23,	'',	0,	'0',	'0',	'0',	'0',	0,	'IVA Rate 0',	1,	NULL,	NULL),
(232,	23,	'',	10.5,	'0',	'0',	'0',	'0',	0,	'IVA reduced rate',	1,	NULL,	NULL),
(233,	23,	'',	21,	'0',	'0',	'0',	'0',	0,	'IVA standard rate',	1,	NULL,	NULL),
(241,	24,	'',	0,	'0',	'0',	'0',	'0',	0,	'VAT rate 0',	1,	NULL,	NULL),
(242,	24,	'',	19.25,	'0',	'0',	'0',	'0',	0,	'VAT rate - standard',	1,	NULL,	NULL),
(251,	25,	'',	0,	'0',	'0',	'0',	'0',	0,	'VAT rate 0',	1,	NULL,	NULL),
(252,	25,	'',	13,	'0',	'0',	'0',	'0',	0,	'VAT rate - reduced',	1,	NULL,	NULL),
(253,	25,	'',	23,	'0',	'0',	'0',	'0',	0,	'VAT rate - standard',	1,	NULL,	NULL),
(254,	25,	'',	6,	'0',	'0',	'0',	'0',	0,	'VAT rate - reduced',	1,	NULL,	NULL),
(261,	26,	'',	0,	'0',	'0',	'0',	'0',	0,	'VAT rate 0',	1,	NULL,	NULL),
(262,	26,	'',	5,	'0',	'0',	'0',	'0',	0,	'VAT rate 5',	1,	NULL,	NULL),
(271,	27,	'',	0,	'0',	'0',	'0',	'0',	0,	'VAT rate 0 ou non applicable',	1,	NULL,	NULL),
(272,	27,	'',	8.5,	'0',	'0',	'0',	'0',	0,	'VAT rate - standard (DOM sauf Guyane et Saint-Martin)',	0,	NULL,	NULL),
(273,	27,	'',	8.5,	'0',	'0',	'0',	'0',	1,	'VAT rate - standard (DOM sauf Guyane et Saint-Martin), non per??u par le vendeur mais r??cup??rable par acheteur',	0,	NULL,	NULL),
(274,	27,	'',	5.5,	'0',	'0',	'0',	'0',	0,	'VAT rate - reduced (France hors DOM-TOM)',	0,	NULL,	NULL),
(275,	27,	'',	19.6,	'0',	'0',	'0',	'0',	0,	'VAT rate - standard (France hors DOM-TOM)',	1,	NULL,	NULL),
(276,	27,	'',	2.1,	'0',	'0',	'0',	'0',	0,	'VAT rate - super-reduced',	1,	NULL,	NULL),
(277,	27,	'',	7,	'0',	'0',	'0',	'0',	0,	'VAT rate - reduced',	1,	NULL,	NULL),
(281,	28,	'',	0,	'0',	'0',	'0',	'0',	0,	'VAT rate 0',	1,	NULL,	NULL),
(282,	28,	'',	10,	'0',	'0',	'0',	'0',	0,	'VAT rate - standard',	1,	NULL,	NULL),
(351,	35,	'',	0,	'0',	'0',	'0',	'0',	0,	'VAT rate 0',	1,	NULL,	NULL),
(352,	35,	'',	7,	'0',	'0',	'0',	'0',	0,	'VAT rate - reduced',	1,	NULL,	NULL),
(353,	35,	'',	14,	'0',	'0',	'0',	'0',	0,	'VAT rate - standard',	1,	NULL,	NULL),
(411,	41,	'',	0,	'0',	'0',	'0',	'0',	0,	'VAT rate 0',	1,	NULL,	NULL),
(412,	41,	'',	10,	'0',	'0',	'0',	'0',	0,	'VAT rate - reduced',	1,	NULL,	NULL),
(413,	41,	'',	20,	'0',	'0',	'0',	'0',	0,	'VAT rate - standard',	1,	NULL,	NULL),
(461,	46,	'',	0,	'0',	'0',	'0',	'0',	0,	'No VAT',	1,	NULL,	NULL),
(462,	46,	'',	15,	'0',	'0',	'0',	'0',	0,	'VAT 15%',	1,	NULL,	NULL),
(463,	46,	'',	7.5,	'0',	'0',	'0',	'0',	0,	'VAT 7.5%',	1,	NULL,	NULL),
(561,	56,	'',	0,	'0',	'0',	'0',	'0',	0,	'VAT rate - reduced',	1,	NULL,	NULL),
(591,	59,	'',	0,	'0',	'0',	'0',	'0',	0,	'VAT rate 0',	1,	NULL,	NULL),
(592,	59,	'',	7,	'0',	'0',	'0',	'0',	0,	'VAT rate - reduced',	1,	NULL,	NULL),
(593,	59,	'',	20,	'0',	'0',	'0',	'0',	0,	'VAT rate - standard',	1,	NULL,	NULL),
(671,	67,	'',	0,	'0',	'0',	'0',	'0',	0,	'VAT rate 0',	1,	NULL,	NULL),
(672,	67,	'',	19,	'0',	'0',	'0',	'0',	0,	'VAT rate - standard',	1,	NULL,	NULL),
(721,	72,	'',	0,	'0',	'0',	'0',	'0',	0,	'VAT rate 0',	1,	NULL,	NULL),
(722,	72,	'',	18,	'0.9',	'1',	'0',	'0',	0,	'VAT rate 18+0.9',	1,	NULL,	NULL),
(781,	78,	'',	0,	'0',	'0',	'0',	'0',	0,	'VAT rate 0',	1,	NULL,	NULL),
(782,	78,	'',	9,	'0',	'0',	'0',	'0',	0,	'VAT rate 9',	1,	NULL,	NULL),
(783,	78,	'',	5,	'0',	'0',	'0',	'0',	0,	'VAT rate 5',	1,	NULL,	NULL),
(784,	78,	'',	19,	'0',	'0',	'0',	'0',	0,	'VAT rate - standard',	1,	NULL,	NULL),
(801,	80,	'',	0,	'0',	'0',	'0',	'0',	0,	'VAT rate 0',	1,	NULL,	NULL),
(802,	80,	'',	25,	'0',	'0',	'0',	'0',	0,	'VAT rate - standard',	1,	NULL,	NULL),
(861,	86,	'',	0,	'0',	'0',	'0',	'0',	0,	'SIN IVA',	1,	NULL,	NULL),
(862,	86,	'',	13,	'0',	'0',	'0',	'0',	0,	'IVA 13',	1,	NULL,	NULL),
(1021,	102,	'',	0,	'0',	'0',	'0',	'0',	0,	'???????????????? ??.??.??.',	1,	NULL,	NULL),
(1022,	102,	'',	24,	'0',	'0',	'0',	'0',	0,	'?????????????????? ??.??.??.',	1,	NULL,	NULL),
(1023,	102,	'',	13,	'0',	'0',	'0',	'0',	0,	'?????????????????? ??.??.??.',	1,	NULL,	NULL),
(1024,	102,	'',	6,	'0',	'0',	'0',	'0',	0,	'?????????????????????????? ??.??.??.',	1,	NULL,	NULL),
(1025,	102,	'',	16,	'0',	'0',	'0',	'0',	0,	'?????????? ?????????????????? ??.??.??.',	1,	NULL,	NULL),
(1026,	102,	'',	9,	'0',	'0',	'0',	'0',	0,	'?????????? ?????????????????? ??.??.??.',	1,	NULL,	NULL),
(1027,	102,	'',	4,	'0',	'0',	'0',	'0',	0,	'?????????? ?????????????????????????? ??.??.??.',	1,	NULL,	NULL),
(1028,	102,	'',	17,	'0',	'0',	'0',	'0',	0,	'?????????? ?????????????????????????? ??.??.??.',	1,	NULL,	NULL),
(1141,	114,	'',	0,	'0',	'0',	'0',	'0',	0,	'No ISV',	1,	NULL,	NULL),
(1142,	114,	'',	12,	'0',	'0',	'0',	'0',	0,	'ISV 12%',	1,	NULL,	NULL),
(1161,	116,	'',	0,	'0',	'0',	'0',	'0',	0,	'VAT rate 0',	1,	NULL,	NULL),
(1162,	116,	'',	7,	'0',	'0',	'0',	'0',	0,	'VAT rate - reduced',	1,	NULL,	NULL),
(1163,	116,	'',	25.5,	'0',	'0',	'0',	'0',	0,	'VAT rate - standard',	1,	NULL,	NULL),
(1171,	117,	'',	0,	'0',	'0',	'0',	'0',	0,	'VAT rate 0',	0,	NULL,	NULL),
(1172,	117,	'C+S-5',	0,	'2.5',	'1',	'2.5',	'1',	0,	'CGST+SGST - Same state sales',	1,	NULL,	NULL),
(1173,	117,	'I-5',	5,	'0',	'0',	'0',	'0',	0,	'IGST',	1,	NULL,	NULL),
(1174,	117,	'C+S-12',	0,	'6',	'1',	'6',	'1',	0,	'CGST+SGST - Same state sales',	1,	NULL,	NULL),
(1175,	117,	'I-12',	12,	'0',	'0',	'0',	'0',	0,	'IGST',	1,	NULL,	NULL),
(1176,	117,	'C+S-18',	0,	'9',	'1',	'9',	'1',	0,	'CGST+SGST - Same state sales',	1,	NULL,	NULL),
(1177,	117,	'I-18',	18,	'0',	'0',	'0',	'0',	0,	'IGST',	1,	NULL,	NULL),
(1178,	117,	'C+S-28',	0,	'14',	'1',	'14',	'1',	0,	'CGST+SGST - Same state sales',	1,	NULL,	NULL),
(1179,	117,	'I-28',	28,	'0',	'0',	'0',	'0',	0,	'IGST',	1,	NULL,	NULL),
(1231,	123,	'',	0,	'0',	'0',	'0',	'0',	0,	'VAT rate 0',	1,	NULL,	NULL),
(1232,	123,	'',	5,	'0',	'0',	'0',	'0',	0,	'VAT rate 5',	1,	NULL,	NULL),
(1401,	140,	'',	0,	'0',	'0',	'0',	'0',	0,	'VAT rate 0',	1,	NULL,	NULL),
(1402,	140,	'',	14,	'0',	'0',	'0',	'0',	0,	'VAT rate - intermediary',	1,	NULL,	NULL),
(1403,	140,	'',	8,	'0',	'0',	'0',	'0',	0,	'VAT rate - reduced',	1,	NULL,	NULL),
(1404,	140,	'',	3,	'0',	'0',	'0',	'0',	0,	'VAT rate - super-reduced',	1,	NULL,	NULL),
(1405,	140,	'',	17,	'0',	'0',	'0',	'0',	0,	'VAT rate - standard',	1,	NULL,	NULL),
(1471,	147,	'',	0,	'0',	'0',	'0',	'0',	0,	'VAT rate 0',	1,	NULL,	NULL),
(1472,	147,	'',	18,	'0',	'0',	'0',	'0',	0,	'VAT rate - standard',	1,	NULL,	NULL),
(1481,	148,	'',	0,	'0',	'0',	'0',	'0',	0,	'VAT rate 0',	1,	NULL,	NULL),
(1482,	148,	'',	7,	'0',	'0',	'0',	'0',	0,	'VAT rate - reduced',	1,	NULL,	NULL),
(1483,	148,	'',	5,	'0',	'0',	'0',	'0',	0,	'VAT rate - super-reduced',	1,	NULL,	NULL),
(1484,	148,	'',	18,	'0',	'0',	'0',	'0',	0,	'VAT rate - standard',	1,	NULL,	NULL),
(1511,	151,	'',	0,	'0',	'0',	'0',	'0',	0,	'VAT rate 0',	1,	NULL,	NULL),
(1512,	151,	'',	14,	'0',	'0',	'0',	'0',	0,	'VAT rate 14',	1,	NULL,	NULL),
(1521,	152,	'',	0,	'0',	'0',	'0',	'0',	0,	'VAT rate 0',	1,	NULL,	NULL),
(1522,	152,	'',	15,	'0',	'0',	'0',	'0',	0,	'VAT rate 15',	1,	NULL,	NULL),
(1541,	154,	'',	0,	'0',	'0',	'0',	'0',	0,	'No VAT',	1,	NULL,	NULL),
(1542,	154,	'',	16,	'0',	'0',	'0',	'0',	0,	'VAT 16%',	1,	NULL,	NULL),
(1543,	154,	'',	10,	'0',	'0',	'0',	'0',	0,	'VAT Frontero',	1,	NULL,	NULL),
(1651,	165,	'',	0,	'0',	'0',	'0',	'0',	0,	'VAT rate 0',	1,	NULL,	NULL),
(1652,	165,	'',	3,	'0',	'0',	'0',	'0',	0,	'VAT standard 3',	1,	NULL,	NULL),
(1653,	165,	'',	6,	'0',	'0',	'0',	'0',	0,	'VAT standard 6',	1,	NULL,	NULL),
(1654,	165,	'',	11,	'0',	'0',	'0',	'0',	0,	'VAT rate - standard',	1,	NULL,	NULL),
(1655,	165,	'',	22,	'0',	'0',	'0',	'0',	0,	'VAT standard high',	1,	NULL,	NULL),
(1661,	166,	'',	0,	'0',	'0',	'0',	'0',	0,	'VAT rate 0',	1,	NULL,	NULL),
(1662,	166,	'',	15,	'0',	'0',	'0',	'0',	0,	'VAT rate - standard',	1,	NULL,	NULL),
(1691,	169,	'',	0,	'0',	'0',	'0',	'0',	0,	'VAT rate 0',	1,	NULL,	NULL),
(1692,	169,	'',	5,	'0',	'0',	'0',	'0',	0,	'VAT rate - standard',	1,	NULL,	NULL),
(1731,	173,	'',	0,	'0',	'0',	'0',	'0',	0,	'VAT rate 0',	1,	NULL,	NULL),
(1732,	173,	'',	14,	'0',	'0',	'0',	'0',	0,	'VAT rate - reduced',	1,	NULL,	NULL),
(1733,	173,	'',	8,	'0',	'0',	'0',	'0',	0,	'VAT rate - reduced',	1,	NULL,	NULL),
(1734,	173,	'',	25,	'0',	'0',	'0',	'0',	0,	'VAT rate - standard',	1,	NULL,	NULL),
(1781,	178,	'',	0,	'0',	'0',	'0',	'0',	0,	'ITBMS Rate 0',	1,	NULL,	NULL),
(1782,	178,	'',	7,	'0',	'0',	'0',	'0',	0,	'ITBMS standard rate',	1,	NULL,	NULL),
(1811,	181,	'',	0,	'0',	'0',	'0',	'0',	0,	'VAT rate 0',	1,	NULL,	NULL),
(1818,	181,	'',	18,	'0',	'0',	'0',	'0',	0,	'VAT rate - standard',	1,	NULL,	NULL),
(1841,	184,	'',	0,	'0',	'0',	'0',	'0',	0,	'VAT rate 0',	1,	NULL,	NULL),
(1842,	184,	'',	8,	'0',	'0',	'0',	'0',	0,	'VAT rate - reduced',	1,	NULL,	NULL),
(1843,	184,	'',	3,	'0',	'0',	'0',	'0',	0,	'VAT rate - reduced',	1,	NULL,	NULL),
(1844,	184,	'',	23,	'0',	'0',	'0',	'0',	0,	'VAT rate - standard',	1,	NULL,	NULL),
(1881,	188,	'',	0,	'0',	'0',	'0',	'0',	0,	'VAT rate 0',	1,	NULL,	NULL),
(1882,	188,	'',	9,	'0',	'0',	'0',	'0',	0,	'VAT rate - reduced',	1,	NULL,	NULL),
(1883,	188,	'',	19,	'0',	'0',	'0',	'0',	0,	'VAT rate - standard',	1,	NULL,	NULL),
(1884,	188,	'',	5,	'0',	'0',	'0',	'0',	0,	'VAT rate - reduced',	1,	NULL,	NULL),
(1931,	193,	'',	0,	'0',	'0',	'0',	'0',	0,	'No VAT in SPM',	1,	NULL,	NULL),
(2011,	201,	'',	0,	'0',	'0',	'0',	'0',	0,	'VAT rate 0',	1,	NULL,	NULL),
(2012,	201,	'',	10,	'0',	'0',	'0',	'0',	0,	'VAT rate - reduced',	1,	NULL,	NULL),
(2013,	201,	'',	19,	'0',	'0',	'0',	'0',	0,	'VAT rate - standard',	1,	NULL,	NULL),
(2021,	202,	'',	0,	'0',	'0',	'0',	'0',	0,	'VAT rate 0',	1,	NULL,	NULL),
(2022,	202,	'',	9.5,	'0',	'0',	'0',	'0',	0,	'VAT rate - reduced',	1,	NULL,	NULL),
(2023,	202,	'',	22,	'0',	'0',	'0',	'0',	0,	'VAT rate - standard',	1,	NULL,	NULL),
(2051,	205,	'',	0,	'0',	'0',	'0',	'0',	0,	'VAT rate 0',	1,	NULL,	NULL),
(2052,	205,	'',	15,	'0',	'0',	'0',	'0',	0,	'VAT rate - standard',	1,	NULL,	NULL),
(2071,	207,	'',	0,	'0',	'0',	'0',	'0',	0,	'VAT 0',	1,	NULL,	NULL),
(2072,	207,	'',	15,	'0',	'0',	'0',	'0',	0,	'VAT 15%',	1,	NULL,	NULL),
(2131,	213,	'',	0,	'0',	'0',	'0',	'0',	0,	'VAT 0',	1,	NULL,	NULL),
(2132,	213,	'',	5,	'0',	'0',	'0',	'0',	0,	'VAT 5%',	1,	NULL,	NULL),
(2261,	226,	'',	0,	'0',	'0',	'0',	'0',	0,	'VAT rate 0',	1,	NULL,	NULL),
(2262,	226,	'',	20,	'0',	'0',	'0',	'0',	0,	'VAT standart rate',	1,	NULL,	NULL),
(2321,	232,	'',	0,	'0',	'0',	'0',	'0',	0,	'No VAT',	1,	NULL,	NULL),
(2322,	232,	'',	12,	'0',	'0',	'0',	'0',	0,	'VAT 12%',	1,	NULL,	NULL),
(2323,	232,	'',	8,	'0',	'0',	'0',	'0',	0,	'VAT 8%',	1,	NULL,	NULL),
(2461,	246,	'',	0,	'0',	'0',	'0',	'0',	0,	'VAT rate 0',	1,	NULL,	NULL);

DROP TABLE IF EXISTS `llx_c_typent`;
CREATE TABLE `llx_c_typent` (
  `id` int(11) NOT NULL,
  `code` varchar(12) COLLATE utf8_unicode_ci NOT NULL,
  `libelle` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_country` int(11) DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `module` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `position` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_c_typent` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_c_typent` (`id`, `code`, `libelle`, `fk_country`, `active`, `module`, `position`) VALUES
(1,	'TE_STARTUP',	'Start-up',	NULL,	0,	NULL,	0),
(2,	'TE_GROUP',	'Grand groupe',	NULL,	1,	NULL,	0),
(3,	'TE_MEDIUM',	'PME/PMI',	NULL,	1,	NULL,	0),
(4,	'TE_SMALL',	'TPE',	NULL,	1,	NULL,	0),
(5,	'TE_ADMIN',	'Administration',	NULL,	1,	NULL,	0),
(6,	'TE_WHOLE',	'Grossiste',	NULL,	0,	NULL,	0),
(7,	'TE_RETAIL',	'Revendeur',	NULL,	0,	NULL,	0),
(8,	'TE_PRIVATE',	'Particulier',	NULL,	1,	NULL,	0),
(100,	'TE_OTHER',	'Autres',	NULL,	1,	NULL,	0),
(231,	'TE_A_RI',	'Responsable Inscripto (typo A)',	23,	0,	NULL,	0),
(232,	'TE_B_RNI',	'Responsable No Inscripto (typo B)',	23,	0,	NULL,	0),
(233,	'TE_C_FE',	'Consumidor Final/Exento (typo C)',	23,	0,	NULL,	0);

DROP TABLE IF EXISTS `llx_c_type_contact`;
CREATE TABLE `llx_c_type_contact` (
  `rowid` int(11) NOT NULL,
  `element` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `source` varchar(8) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'external',
  `code` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `libelle` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `module` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `position` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_c_type_contact_id` (`element`,`source`,`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_c_type_contact` (`rowid`, `element`, `source`, `code`, `libelle`, `active`, `module`, `position`) VALUES
(10,	'contrat',	'internal',	'SALESREPSIGN',	'Commercial signataire du contrat',	1,	NULL,	0),
(11,	'contrat',	'internal',	'SALESREPFOLL',	'Commercial suivi du contrat',	1,	NULL,	0),
(20,	'contrat',	'external',	'BILLING',	'Contact client facturation contrat',	1,	NULL,	0),
(21,	'contrat',	'external',	'CUSTOMER',	'Contact client suivi contrat',	1,	NULL,	0),
(22,	'contrat',	'external',	'SALESREPSIGN',	'Contact client signataire contrat',	1,	NULL,	0),
(31,	'propal',	'internal',	'SALESREPFOLL',	'Commercial ?? l\'origine de la propale',	1,	NULL,	0),
(40,	'propal',	'external',	'BILLING',	'Contact client facturation propale',	1,	NULL,	0),
(41,	'propal',	'external',	'CUSTOMER',	'Contact client suivi propale',	1,	NULL,	0),
(42,	'propal',	'external',	'SHIPPING',	'Contact client livraison propale',	1,	NULL,	0),
(50,	'facture',	'internal',	'SALESREPFOLL',	'Responsable suivi du paiement',	1,	NULL,	0),
(60,	'facture',	'external',	'BILLING',	'Contact client facturation',	1,	NULL,	0),
(61,	'facture',	'external',	'SHIPPING',	'Contact client livraison',	1,	NULL,	0),
(62,	'facture',	'external',	'SERVICE',	'Contact client prestation',	1,	NULL,	0),
(70,	'invoice_supplier',	'internal',	'SALESREPFOLL',	'Responsable suivi du paiement',	1,	NULL,	0),
(71,	'invoice_supplier',	'external',	'BILLING',	'Contact fournisseur facturation',	1,	NULL,	0),
(72,	'invoice_supplier',	'external',	'SHIPPING',	'Contact fournisseur livraison',	1,	NULL,	0),
(73,	'invoice_supplier',	'external',	'SERVICE',	'Contact fournisseur prestation',	1,	NULL,	0),
(80,	'agenda',	'internal',	'ACTOR',	'Responsable',	1,	NULL,	0),
(81,	'agenda',	'internal',	'GUEST',	'Guest',	1,	NULL,	0),
(85,	'agenda',	'external',	'ACTOR',	'Responsable',	1,	NULL,	0),
(86,	'agenda',	'external',	'GUEST',	'Guest',	1,	NULL,	0),
(91,	'commande',	'internal',	'SALESREPFOLL',	'Responsable suivi de la commande',	1,	NULL,	0),
(100,	'commande',	'external',	'BILLING',	'Contact client facturation commande',	1,	NULL,	0),
(101,	'commande',	'external',	'CUSTOMER',	'Contact client suivi commande',	1,	NULL,	0),
(102,	'commande',	'external',	'SHIPPING',	'Contact client livraison commande',	1,	NULL,	0),
(110,	'supplier_proposal',	'internal',	'SALESREPFOLL',	'Responsable suivi de la demande',	1,	NULL,	0),
(111,	'supplier_proposal',	'external',	'BILLING',	'Contact fournisseur facturation',	1,	NULL,	0),
(112,	'supplier_proposal',	'external',	'SHIPPING',	'Contact fournisseur livraison',	1,	NULL,	0),
(113,	'supplier_proposal',	'external',	'SERVICE',	'Contact fournisseur prestation',	1,	NULL,	0),
(120,	'fichinter',	'internal',	'INTERREPFOLL',	'Responsable suivi de l\'intervention',	1,	NULL,	0),
(121,	'fichinter',	'internal',	'INTERVENING',	'Intervenant',	1,	NULL,	0),
(130,	'fichinter',	'external',	'BILLING',	'Contact client facturation intervention',	1,	NULL,	0),
(131,	'fichinter',	'external',	'CUSTOMER',	'Contact client suivi de l\'intervention',	1,	NULL,	0),
(140,	'order_supplier',	'internal',	'SALESREPFOLL',	'Responsable suivi de la commande',	1,	NULL,	0),
(141,	'order_supplier',	'internal',	'SHIPPING',	'Responsable r??ception de la commande',	1,	NULL,	0),
(142,	'order_supplier',	'external',	'BILLING',	'Contact fournisseur facturation commande',	1,	NULL,	0),
(143,	'order_supplier',	'external',	'CUSTOMER',	'Contact fournisseur suivi commande',	1,	NULL,	0),
(145,	'order_supplier',	'external',	'SHIPPING',	'Contact fournisseur livraison commande',	1,	NULL,	0),
(150,	'dolresource',	'internal',	'USERINCHARGE',	'In charge of resource',	1,	NULL,	0),
(151,	'dolresource',	'external',	'THIRDINCHARGE',	'In charge of resource',	1,	NULL,	0),
(155,	'ticket',	'internal',	'SUPPORTTEC',	'Utilisateur contact support',	1,	NULL,	0),
(156,	'ticket',	'internal',	'CONTRIBUTOR',	'Intervenant',	1,	NULL,	0),
(157,	'ticket',	'external',	'SUPPORTCLI',	'Contact client suivi incident',	1,	NULL,	0),
(158,	'ticket',	'external',	'CONTRIBUTOR',	'Intervenant',	1,	NULL,	0),
(160,	'project',	'internal',	'PROJECTLEADER',	'Chef de Projet',	1,	NULL,	0),
(161,	'project',	'internal',	'PROJECTCONTRIBUTOR',	'Intervenant',	1,	NULL,	0),
(170,	'project',	'external',	'PROJECTLEADER',	'Chef de Projet',	1,	NULL,	0),
(171,	'project',	'external',	'PROJECTCONTRIBUTOR',	'Intervenant',	1,	NULL,	0),
(180,	'project_task',	'internal',	'TASKEXECUTIVE',	'Responsable',	1,	NULL,	0),
(181,	'project_task',	'internal',	'TASKCONTRIBUTOR',	'Intervenant',	1,	NULL,	0),
(190,	'project_task',	'external',	'TASKEXECUTIVE',	'Responsable',	1,	NULL,	0),
(191,	'project_task',	'external',	'TASKCONTRIBUTOR',	'Intervenant',	1,	NULL,	0),
(210,	'conferenceorbooth',	'internal',	'MANAGER',	'Conference or Booth manager',	1,	NULL,	0),
(211,	'conferenceorbooth',	'external',	'SPEAKER',	'Conference Speaker',	1,	NULL,	0),
(212,	'conferenceorbooth',	'external',	'RESPONSIBLE',	'Booth responsible',	1,	NULL,	0);

DROP TABLE IF EXISTS `llx_c_type_container`;
CREATE TABLE `llx_c_type_container` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `label` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `module` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_c_type_container_id` (`code`,`entity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_c_type_container` (`rowid`, `code`, `entity`, `label`, `module`, `active`) VALUES
(1,	'page',	1,	'Page',	'system',	1),
(2,	'banner',	1,	'Banner',	'system',	1),
(3,	'blogpost',	1,	'BlogPost',	'system',	1),
(4,	'menu',	1,	'Menu',	'system',	1),
(5,	'other',	1,	'Other',	'system',	1);

DROP TABLE IF EXISTS `llx_c_type_fees`;
CREATE TABLE `llx_c_type_fees` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(12) COLLATE utf8_unicode_ci NOT NULL,
  `label` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` int(11) DEFAULT '0',
  `accountancy_code` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `module` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `position` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_c_type_fees` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_c_type_fees` (`id`, `code`, `label`, `type`, `accountancy_code`, `active`, `module`, `position`) VALUES
(1,	'TF_OTHER',	'Other',	0,	NULL,	1,	NULL,	0),
(2,	'TF_TRIP',	'Transportation',	0,	NULL,	1,	NULL,	0),
(3,	'TF_LUNCH',	'Lunch',	0,	NULL,	1,	NULL,	0),
(4,	'EX_KME',	'ExpLabelKm',	0,	NULL,	1,	NULL,	0),
(5,	'EX_FUE',	'ExpLabelFuelCV',	0,	NULL,	0,	NULL,	0),
(6,	'EX_HOT',	'ExpLabelHotel',	0,	NULL,	0,	NULL,	0),
(7,	'EX_PAR',	'ExpLabelParkingCV',	0,	NULL,	0,	NULL,	0),
(8,	'EX_TOL',	'ExpLabelTollCV',	0,	NULL,	0,	NULL,	0),
(9,	'EX_TAX',	'ExpLabelVariousTaxes',	0,	NULL,	0,	NULL,	0),
(10,	'EX_IND',	'ExpLabelIndemnityTransSubscrip',	0,	NULL,	0,	NULL,	0),
(11,	'EX_SUM',	'ExpLabelMaintenanceSupply',	0,	NULL,	0,	NULL,	0),
(12,	'EX_SUO',	'ExpLabelOfficeSupplies',	0,	NULL,	0,	NULL,	0),
(13,	'EX_CAR',	'ExpLabelCarRental',	0,	NULL,	0,	NULL,	0),
(14,	'EX_DOC',	'ExpLabelDocumentation',	0,	NULL,	0,	NULL,	0),
(15,	'EX_CUR',	'ExpLabelCustomersReceiving',	0,	NULL,	0,	NULL,	0),
(16,	'EX_OTR',	'ExpLabelOtherReceiving',	0,	NULL,	0,	NULL,	0),
(17,	'EX_POS',	'ExpLabelPostage',	0,	NULL,	0,	NULL,	0),
(18,	'EX_CAM',	'ExpLabelMaintenanceRepairCV',	0,	NULL,	0,	NULL,	0),
(19,	'EX_EMM',	'ExpLabelEmployeesMeal',	0,	NULL,	0,	NULL,	0),
(20,	'EX_GUM',	'ExpLabelGuestsMeal',	0,	NULL,	0,	NULL,	0),
(21,	'EX_BRE',	'ExpLabelBreakfast',	0,	NULL,	0,	NULL,	0),
(22,	'EX_FUE_VP',	'ExpLabelFuelPV',	0,	NULL,	0,	NULL,	0),
(23,	'EX_TOL_VP',	'ExpLabelTollPV',	0,	NULL,	0,	NULL,	0),
(24,	'EX_PAR_VP',	'ExpLabelParkingPV',	0,	NULL,	0,	NULL,	0),
(25,	'EX_CAM_VP',	'ExpLabelMaintenanceRepairPV',	0,	NULL,	0,	NULL,	0);

DROP TABLE IF EXISTS `llx_c_type_resource`;
CREATE TABLE `llx_c_type_resource` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `label` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_c_type_resource_id` (`label`,`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_c_type_resource` (`rowid`, `code`, `label`, `active`) VALUES
(1,	'RES_ROOMS',	'Rooms',	1),
(2,	'RES_CARS',	'Cars',	1);

DROP TABLE IF EXISTS `llx_c_units`;
CREATE TABLE `llx_c_units` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sortorder` smallint(6) DEFAULT NULL,
  `scale` int(11) DEFAULT NULL,
  `label` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `short_label` varchar(5) COLLATE utf8_unicode_ci DEFAULT NULL,
  `unit_type` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_c_units_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_c_units` (`rowid`, `code`, `sortorder`, `scale`, `label`, `short_label`, `unit_type`, `active`) VALUES
(1,	'T',	100,	3,	'WeightUnitton',	'T',	'weight',	1),
(2,	'KG',	110,	0,	'WeightUnitkg',	'kg',	'weight',	1),
(3,	'G',	120,	-3,	'WeightUnitg',	'g',	'weight',	1),
(4,	'MG',	130,	-6,	'WeightUnitmg',	'mg',	'weight',	1),
(5,	'OZ',	140,	98,	'WeightUnitounce',	'Oz',	'weight',	1),
(6,	'LB',	150,	99,	'WeightUnitpound',	'lb',	'weight',	1),
(7,	'M',	200,	0,	'SizeUnitm',	'm',	'size',	1),
(8,	'DM',	210,	-1,	'SizeUnitdm',	'dm',	'size',	1),
(9,	'CM',	220,	-2,	'SizeUnitcm',	'cm',	'size',	1),
(10,	'MM',	230,	-3,	'SizeUnitmm',	'mm',	'size',	1),
(11,	'FT',	240,	98,	'SizeUnitfoot',	'ft',	'size',	1),
(12,	'IN',	250,	99,	'SizeUnitinch',	'in',	'size',	1),
(13,	'M2',	300,	0,	'SurfaceUnitm2',	'm2',	'surface',	1),
(14,	'DM2',	310,	-2,	'SurfaceUnitdm2',	'dm2',	'surface',	1),
(15,	'CM2',	320,	-4,	'SurfaceUnitcm2',	'cm2',	'surface',	1),
(16,	'MM2',	330,	-6,	'SurfaceUnitmm2',	'mm2',	'surface',	1),
(17,	'FT2',	340,	98,	'SurfaceUnitfoot2',	'ft2',	'surface',	1),
(18,	'IN2',	350,	99,	'SurfaceUnitinch2',	'in2',	'surface',	1),
(19,	'M3',	400,	0,	'VolumeUnitm3',	'm3',	'volume',	1),
(20,	'DM3',	410,	-3,	'VolumeUnitdm3',	'dm3',	'volume',	1),
(21,	'CM3',	420,	-6,	'VolumeUnitcm3',	'cm3',	'volume',	1),
(22,	'MM3',	430,	-9,	'VolumeUnitmm3',	'mm3',	'volume',	1),
(23,	'FT3',	440,	88,	'VolumeUnitfoot3',	'ft3',	'volume',	1),
(24,	'IN3',	450,	89,	'VolumeUnitinch3',	'in3',	'volume',	1),
(25,	'OZ3',	460,	97,	'VolumeUnitounce',	'Oz',	'volume',	1),
(26,	'L',	470,	98,	'VolumeUnitlitre',	'L',	'volume',	1),
(27,	'GAL',	480,	99,	'VolumeUnitgallon',	'gal',	'volume',	1),
(28,	'P',	500,	0,	'Piece',	'p',	'qty',	1),
(29,	'SET',	510,	0,	'Set',	'set',	'qty',	1),
(30,	'S',	600,	0,	'second',	's',	'time',	1),
(31,	'MI',	610,	60,	'minute',	'i',	'time',	1),
(32,	'H',	620,	3600,	'hour',	'h',	'time',	1),
(33,	'D',	630,	86400,	'day',	'd',	'time',	1),
(34,	'W',	640,	604800,	'week',	'w',	'time',	1),
(35,	'MO',	650,	2629800,	'month',	'm',	'time',	1),
(36,	'Y',	660,	31557600,	'year',	'y',	'time',	1);

DROP TABLE IF EXISTS `llx_c_ziptown`;
CREATE TABLE `llx_c_ziptown` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(5) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_county` int(11) DEFAULT NULL,
  `fk_pays` int(11) NOT NULL DEFAULT '0',
  `zip` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `town` varchar(180) COLLATE utf8_unicode_ci NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_ziptown_fk_pays` (`zip`,`town`,`fk_pays`),
  KEY `idx_c_ziptown_fk_county` (`fk_county`),
  KEY `idx_c_ziptown_fk_pays` (`fk_pays`),
  KEY `idx_c_ziptown_zip` (`zip`),
  CONSTRAINT `fk_c_ziptown_fk_county` FOREIGN KEY (`fk_county`) REFERENCES `llx_c_departements` (`rowid`),
  CONSTRAINT `fk_c_ziptown_fk_pays` FOREIGN KEY (`fk_pays`) REFERENCES `llx_c_country` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_default_values`;
CREATE TABLE `llx_default_values` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `type` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `page` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `param` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_default_values` (`type`,`entity`,`user_id`,`page`,`param`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_delivery`;
CREATE TABLE `llx_delivery` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ref` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `fk_soc` int(11) NOT NULL,
  `ref_ext` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ref_int` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ref_customer` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_creation` datetime DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `date_valid` datetime DEFAULT NULL,
  `fk_user_valid` int(11) DEFAULT NULL,
  `date_delivery` datetime DEFAULT NULL,
  `fk_address` int(11) DEFAULT NULL,
  `fk_statut` smallint(6) DEFAULT '0',
  `total_ht` double(24,8) DEFAULT '0.00000000',
  `note_private` text COLLATE utf8_unicode_ci,
  `note_public` text COLLATE utf8_unicode_ci,
  `model_pdf` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_main_doc` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_incoterms` int(11) DEFAULT NULL,
  `location_incoterms` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `extraparams` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `idx_delivery_uk_ref` (`ref`,`entity`),
  KEY `idx_delivery_fk_soc` (`fk_soc`),
  KEY `idx_delivery_fk_user_author` (`fk_user_author`),
  KEY `idx_delivery_fk_user_valid` (`fk_user_valid`),
  CONSTRAINT `fk_delivery_fk_soc` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`),
  CONSTRAINT `fk_delivery_fk_user_author` FOREIGN KEY (`fk_user_author`) REFERENCES `llx_user` (`rowid`),
  CONSTRAINT `fk_delivery_fk_user_valid` FOREIGN KEY (`fk_user_valid`) REFERENCES `llx_user` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_deliverydet`;
CREATE TABLE `llx_deliverydet` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_delivery` int(11) DEFAULT NULL,
  `fk_origin_line` int(11) DEFAULT NULL,
  `fk_product` int(11) DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `qty` double DEFAULT NULL,
  `subprice` double(24,8) DEFAULT '0.00000000',
  `total_ht` double(24,8) DEFAULT '0.00000000',
  `rang` int(11) DEFAULT '0',
  PRIMARY KEY (`rowid`),
  KEY `idx_deliverydet_fk_delivery` (`fk_delivery`),
  CONSTRAINT `fk_deliverydet_fk_delivery` FOREIGN KEY (`fk_delivery`) REFERENCES `llx_delivery` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_deliverydet_extrafields`;
CREATE TABLE `llx_deliverydet_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_deliverydet_extrafields` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_delivery_extrafields`;
CREATE TABLE `llx_delivery_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_delivery_extrafields` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_deplacement`;
CREATE TABLE `llx_deplacement` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `ref` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `datec` datetime NOT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `dated` datetime DEFAULT NULL,
  `fk_user` int(11) NOT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `type` varchar(12) COLLATE utf8_unicode_ci NOT NULL,
  `fk_statut` int(11) NOT NULL DEFAULT '1',
  `km` double DEFAULT NULL,
  `fk_soc` int(11) DEFAULT NULL,
  `fk_projet` int(11) DEFAULT '0',
  `note_private` text COLLATE utf8_unicode_ci,
  `note_public` text COLLATE utf8_unicode_ci,
  `extraparams` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_document_model`;
CREATE TABLE `llx_document_model` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `type` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `libelle` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_document_model` (`nom`,`type`,`entity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_document_model` (`rowid`, `nom`, `entity`, `type`, `libelle`, `description`) VALUES
(3,	'rouget',	1,	'shipping',	NULL,	NULL),
(4,	'typhon',	1,	'delivery',	NULL,	NULL),
(5,	'muscadet',	1,	'order_supplier',	NULL,	NULL),
(7,	'standard',	1,	'stock',	NULL,	NULL),
(8,	'stdmovement',	1,	'mouvement',	NULL,	NULL),
(9,	'aurore',	1,	'supplier_proposal',	NULL,	NULL),
(11,	'payplug',	1,	'invoice',	'payplug',	NULL),
(12,	'',	1,	'task',	NULL,	NULL),
(13,	'beluga',	1,	'project',	NULL,	NULL),
(14,	'baleine',	1,	'project',	NULL,	NULL),
(15,	'cyan',	1,	'propal',	'cyan',	NULL),
(16,	'eratosthene',	1,	'order',	'eratosthene',	NULL),
(17,	'sponge',	1,	'invoice',	'sponge',	NULL);

DROP TABLE IF EXISTS `llx_don`;
CREATE TABLE `llx_don` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `ref` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_statut` smallint(6) NOT NULL DEFAULT '0',
  `datedon` datetime DEFAULT NULL,
  `amount` double(24,8) DEFAULT '0.00000000',
  `fk_payment` int(11) DEFAULT NULL,
  `paid` smallint(6) NOT NULL DEFAULT '0',
  `fk_soc` int(11) DEFAULT NULL,
  `firstname` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lastname` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `societe` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8_unicode_ci,
  `zip` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `town` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_country` int(11) NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_mobile` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `public` smallint(6) NOT NULL DEFAULT '1',
  `fk_projet` int(11) DEFAULT NULL,
  `datec` datetime DEFAULT NULL,
  `fk_user_author` int(11) NOT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `date_valid` datetime DEFAULT NULL,
  `fk_user_valid` int(11) DEFAULT NULL,
  `note_private` text COLLATE utf8_unicode_ci,
  `note_public` text COLLATE utf8_unicode_ci,
  `model_pdf` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `extraparams` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_don_extrafields`;
CREATE TABLE `llx_don_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_don_extrafields` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_ecm_directories`;
CREATE TABLE `llx_ecm_directories` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `fk_parent` int(11) DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `cachenbofdoc` int(11) NOT NULL DEFAULT '0',
  `fullpath` varchar(750) COLLATE utf8_unicode_ci DEFAULT NULL,
  `extraparams` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_c` datetime DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_user_c` int(11) DEFAULT NULL,
  `fk_user_m` int(11) DEFAULT NULL,
  `note_private` text COLLATE utf8_unicode_ci,
  `note_public` text COLLATE utf8_unicode_ci,
  `acl` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_ecm_directories` (`label`,`fk_parent`,`entity`),
  KEY `idx_ecm_directories_fk_user_c` (`fk_user_c`),
  KEY `idx_ecm_directories_fk_user_m` (`fk_user_m`),
  CONSTRAINT `fk_ecm_directories_fk_user_c` FOREIGN KEY (`fk_user_c`) REFERENCES `llx_user` (`rowid`),
  CONSTRAINT `fk_ecm_directories_fk_user_m` FOREIGN KEY (`fk_user_m`) REFERENCES `llx_user` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_ecm_directories_extrafields`;
CREATE TABLE `llx_ecm_directories_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_ecm_directories_extrafields` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_ecm_files`;
CREATE TABLE `llx_ecm_files` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `ref` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `label` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `share` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `filepath` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `filename` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `src_object_type` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `src_object_id` int(11) DEFAULT NULL,
  `fullpath_orig` varchar(750) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `keywords` varchar(750) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cover` text COLLATE utf8_unicode_ci,
  `position` int(11) DEFAULT NULL,
  `gen_or_uploaded` varchar(12) COLLATE utf8_unicode_ci DEFAULT NULL,
  `extraparams` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_c` datetime DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_user_c` int(11) DEFAULT NULL,
  `fk_user_m` int(11) DEFAULT NULL,
  `note_private` text COLLATE utf8_unicode_ci,
  `note_public` text COLLATE utf8_unicode_ci,
  `acl` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_ecm_files` (`filepath`,`filename`,`entity`),
  KEY `idx_ecm_files_label` (`label`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_ecm_files` (`rowid`, `ref`, `label`, `share`, `entity`, `filepath`, `filename`, `src_object_type`, `src_object_id`, `fullpath_orig`, `description`, `keywords`, `cover`, `position`, `gen_or_uploaded`, `extraparams`, `date_c`, `tms`, `fk_user_c`, `fk_user_m`, `note_private`, `note_public`, `acl`) VALUES
(13,	'85e826fbf9e0b2609a497e22c684c944',	'2ae7219a21aea251d44c1624028eab41',	NULL,	1,	'users/1',	'produit_2.csv',	NULL,	NULL,	'D:/DevLoc/Stormatic/test/dolibarr/documents/users/1/produit_2.csv',	'',	'',	NULL,	1,	'unknown',	NULL,	'2022-09-29 16:41:46',	'2022-09-29 14:41:46',	1,	NULL,	NULL,	NULL,	NULL),
(41,	'b9f03abf7982ecd849a8da7836a5627d',	'f51665fd91e4c45720539eaf30a49fd8',	'FzgTRXvUtnu1O8f5JuOm7345E1Dc37Ex',	1,	'propale/(PROV20)',	'(PROV20).pdf',	'propal',	20,	'',	'',	'',	NULL,	1,	'generated',	NULL,	'2022-10-19 12:51:40',	'2022-10-19 12:17:17',	1,	1,	NULL,	NULL,	NULL);

DROP TABLE IF EXISTS `llx_ecm_files_extrafields`;
CREATE TABLE `llx_ecm_files_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_ecm_files_extrafields` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_element_contact`;
CREATE TABLE `llx_element_contact` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `datecreate` datetime DEFAULT NULL,
  `statut` smallint(6) DEFAULT '5',
  `element_id` int(11) NOT NULL,
  `fk_c_type_contact` int(11) NOT NULL,
  `fk_socpeople` int(11) NOT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `idx_element_contact_idx1` (`element_id`,`fk_c_type_contact`,`fk_socpeople`),
  KEY `fk_element_contact_fk_c_type_contact` (`fk_c_type_contact`),
  KEY `idx_element_contact_fk_socpeople` (`fk_socpeople`),
  CONSTRAINT `fk_element_contact_fk_c_type_contact` FOREIGN KEY (`fk_c_type_contact`) REFERENCES `llx_c_type_contact` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_element_contact` (`rowid`, `datecreate`, `statut`, `element_id`, `fk_c_type_contact`, `fk_socpeople`) VALUES
(1,	'2022-09-09 15:18:21',	4,	1,	160,	1),
(2,	'2022-09-09 15:43:53',	4,	2,	160,	1);

DROP TABLE IF EXISTS `llx_element_element`;
CREATE TABLE `llx_element_element` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_source` int(11) NOT NULL,
  `sourcetype` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `fk_target` int(11) NOT NULL,
  `targettype` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `idx_element_element_idx1` (`fk_source`,`sourcetype`,`fk_target`,`targettype`),
  KEY `idx_element_element_fk_target` (`fk_target`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_element_resources`;
CREATE TABLE `llx_element_resources` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `element_id` int(11) DEFAULT NULL,
  `element_type` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `resource_id` int(11) DEFAULT NULL,
  `resource_type` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `busy` int(11) DEFAULT NULL,
  `mandatory` int(11) DEFAULT NULL,
  `duree` double DEFAULT NULL,
  `fk_user_create` int(11) DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `idx_element_resources_idx1` (`resource_id`,`resource_type`,`element_id`,`element_type`),
  KEY `idx_element_element_element_id` (`element_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_element_tag`;
CREATE TABLE `llx_element_tag` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_categorie` int(11) NOT NULL,
  `fk_element` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `idx_element_tag_uk` (`fk_categorie`,`fk_element`),
  CONSTRAINT `fk_element_tag_categorie_rowid` FOREIGN KEY (`fk_categorie`) REFERENCES `llx_categorie` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_emailcollector_emailcollector`;
CREATE TABLE `llx_emailcollector_emailcollector` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `ref` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `label` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `host` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `hostcharset` varchar(16) COLLATE utf8_unicode_ci DEFAULT 'UTF-8',
  `login` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `source_directory` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `target_directory` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `maxemailpercollect` int(11) DEFAULT '100',
  `datelastresult` datetime DEFAULT NULL,
  `codelastresult` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lastresult` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `datelastok` datetime DEFAULT NULL,
  `note_public` text COLLATE utf8_unicode_ci,
  `note_private` text COLLATE utf8_unicode_ci,
  `date_creation` datetime NOT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_user_creat` int(11) NOT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_emailcollector_emailcollector_ref` (`ref`,`entity`),
  KEY `idx_emailcollector_entity` (`entity`),
  KEY `idx_emailcollector_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_emailcollector_emailcollectoraction`;
CREATE TABLE `llx_emailcollector_emailcollectoraction` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_emailcollector` int(11) NOT NULL,
  `type` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `actionparam` text COLLATE utf8_unicode_ci,
  `date_creation` datetime NOT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_user_creat` int(11) NOT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `position` int(11) DEFAULT '0',
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_emailcollector_emailcollectoraction` (`fk_emailcollector`,`type`),
  KEY `idx_emailcollector_fk_emailcollector` (`fk_emailcollector`),
  CONSTRAINT `fk_emailcollectoraction_fk_emailcollector` FOREIGN KEY (`fk_emailcollector`) REFERENCES `llx_emailcollector_emailcollector` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_emailcollector_emailcollectorfilter`;
CREATE TABLE `llx_emailcollector_emailcollectorfilter` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_emailcollector` int(11) NOT NULL,
  `type` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `rulevalue` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_creation` datetime NOT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_user_creat` int(11) NOT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_emailcollector_emailcollectorfilter` (`fk_emailcollector`,`type`,`rulevalue`),
  KEY `idx_emailcollector_fk_emailcollector` (`fk_emailcollector`),
  CONSTRAINT `fk_emailcollectorfilter_fk_emailcollector` FOREIGN KEY (`fk_emailcollector`) REFERENCES `llx_emailcollector_emailcollector` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_entrepot`;
CREATE TABLE `llx_entrepot` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `ref` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `entity` int(11) NOT NULL DEFAULT '1',
  `fk_project` int(11) DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `lieu` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `zip` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `town` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_departement` int(11) DEFAULT NULL,
  `fk_pays` int(11) DEFAULT '0',
  `phone` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fax` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `warehouse_usage` int(11) DEFAULT '1',
  `statut` tinyint(4) DEFAULT '1',
  `fk_user_author` int(11) DEFAULT NULL,
  `model_pdf` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_parent` int(11) DEFAULT '0',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_entrepot_label` (`ref`,`entity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_entrepot_extrafields`;
CREATE TABLE `llx_entrepot_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_entrepot_extrafields` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_establishment`;
CREATE TABLE `llx_establishment` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `ref` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `zip` varchar(25) COLLATE utf8_unicode_ci DEFAULT NULL,
  `town` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_state` int(11) DEFAULT '0',
  `fk_country` int(11) DEFAULT '0',
  `profid1` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `profid2` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `profid3` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_user_author` int(11) NOT NULL,
  `fk_user_mod` int(11) DEFAULT NULL,
  `datec` datetime NOT NULL,
  `tms` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` tinyint(4) DEFAULT '1',
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_eventorganization_conferenceorboothattendee`;
CREATE TABLE `llx_eventorganization_conferenceorboothattendee` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `ref` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `fk_soc` int(11) DEFAULT NULL,
  `fk_actioncomm` int(11) DEFAULT NULL,
  `fk_project` int(11) NOT NULL,
  `fk_invoice` int(11) DEFAULT NULL,
  `email` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_subscription` datetime DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `note_public` text COLLATE utf8_unicode_ci,
  `note_private` text COLLATE utf8_unicode_ci,
  `date_creation` datetime NOT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_user_creat` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `last_main_doc` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `model_pdf` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` smallint(6) NOT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_eventorganization_conferenceorboothattendee` (`fk_project`,`email`,`fk_actioncomm`),
  KEY `idx_eventorganization_conferenceorboothattendee_rowid` (`rowid`),
  KEY `idx_eventorganization_conferenceorboothattendee_ref` (`ref`),
  KEY `idx_eventorganization_conferenceorboothattendee_fk_soc` (`fk_soc`),
  KEY `idx_eventorganization_conferenceorboothattendee_fk_actioncomm` (`fk_actioncomm`),
  KEY `idx_eventorganization_conferenceorboothattendee_fk_project` (`fk_project`),
  KEY `idx_eventorganization_conferenceorboothattendee_email` (`email`),
  KEY `idx_eventorganization_conferenceorboothattendee_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_eventorganization_conferenceorboothattendee_extrafields`;
CREATE TABLE `llx_eventorganization_conferenceorboothattendee_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_conferenceorboothattendee_fk_object` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_events`;
CREATE TABLE `llx_events` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `type` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `prefix_session` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dateevent` datetime DEFAULT NULL,
  `fk_user` int(11) DEFAULT NULL,
  `description` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `ip` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `user_agent` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_object` int(11) DEFAULT NULL,
  `authentication_method` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_oauth_token` int(11) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_events_dateevent` (`dateevent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_event_element`;
CREATE TABLE `llx_event_element` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_source` int(11) NOT NULL,
  `fk_target` int(11) NOT NULL,
  `targettype` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_expedition`;
CREATE TABLE `llx_expedition` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ref` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `fk_soc` int(11) NOT NULL,
  `fk_projet` int(11) DEFAULT NULL,
  `ref_ext` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ref_int` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ref_customer` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_creation` datetime DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `date_valid` datetime DEFAULT NULL,
  `fk_user_valid` int(11) DEFAULT NULL,
  `date_delivery` datetime DEFAULT NULL,
  `date_expedition` datetime DEFAULT NULL,
  `fk_address` int(11) DEFAULT NULL,
  `fk_shipping_method` int(11) DEFAULT NULL,
  `tracking_number` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_statut` smallint(6) DEFAULT '0',
  `billed` smallint(6) DEFAULT '0',
  `height` float DEFAULT NULL,
  `width` float DEFAULT NULL,
  `size_units` int(11) DEFAULT NULL,
  `size` float DEFAULT NULL,
  `weight_units` int(11) DEFAULT NULL,
  `weight` float DEFAULT NULL,
  `note_private` text COLLATE utf8_unicode_ci,
  `note_public` text COLLATE utf8_unicode_ci,
  `model_pdf` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_main_doc` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_incoterms` int(11) DEFAULT NULL,
  `location_incoterms` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `extraparams` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `idx_expedition_uk_ref` (`ref`,`entity`),
  KEY `idx_expedition_fk_soc` (`fk_soc`),
  KEY `idx_expedition_fk_user_author` (`fk_user_author`),
  KEY `idx_expedition_fk_user_valid` (`fk_user_valid`),
  KEY `idx_expedition_fk_shipping_method` (`fk_shipping_method`),
  CONSTRAINT `fk_expedition_fk_shipping_method` FOREIGN KEY (`fk_shipping_method`) REFERENCES `llx_c_shipment_mode` (`rowid`),
  CONSTRAINT `fk_expedition_fk_soc` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`),
  CONSTRAINT `fk_expedition_fk_user_author` FOREIGN KEY (`fk_user_author`) REFERENCES `llx_user` (`rowid`),
  CONSTRAINT `fk_expedition_fk_user_valid` FOREIGN KEY (`fk_user_valid`) REFERENCES `llx_user` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_expeditiondet`;
CREATE TABLE `llx_expeditiondet` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_expedition` int(11) NOT NULL,
  `fk_origin_line` int(11) DEFAULT NULL,
  `fk_entrepot` int(11) DEFAULT NULL,
  `qty` double DEFAULT NULL,
  `rang` int(11) DEFAULT '0',
  PRIMARY KEY (`rowid`),
  KEY `idx_expeditiondet_fk_expedition` (`fk_expedition`),
  KEY `idx_expeditiondet_fk_origin_line` (`fk_origin_line`),
  CONSTRAINT `fk_expeditiondet_fk_expedition` FOREIGN KEY (`fk_expedition`) REFERENCES `llx_expedition` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_expeditiondet_batch`;
CREATE TABLE `llx_expeditiondet_batch` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_expeditiondet` int(11) NOT NULL,
  `eatby` date DEFAULT NULL,
  `sellby` date DEFAULT NULL,
  `batch` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `qty` double NOT NULL DEFAULT '0',
  `fk_origin_stock` int(11) NOT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_fk_expeditiondet` (`fk_expeditiondet`),
  CONSTRAINT `fk_expeditiondet_batch_fk_expeditiondet` FOREIGN KEY (`fk_expeditiondet`) REFERENCES `llx_expeditiondet` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_expeditiondet_extrafields`;
CREATE TABLE `llx_expeditiondet_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_expeditiondet_extrafields` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_expedition_extrafields`;
CREATE TABLE `llx_expedition_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_expedition_extrafields` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_expedition_package`;
CREATE TABLE `llx_expedition_package` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_expedition` int(11) NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value` double(24,8) DEFAULT '0.00000000',
  `fk_package_type` int(11) DEFAULT NULL,
  `height` float DEFAULT NULL,
  `width` float DEFAULT NULL,
  `size` float DEFAULT NULL,
  `size_units` int(11) DEFAULT NULL,
  `weight` float DEFAULT NULL,
  `weight_units` int(11) DEFAULT NULL,
  `dangerous_goods` smallint(6) DEFAULT '0',
  `tail_lift` smallint(6) DEFAULT '0',
  `rang` int(11) DEFAULT '0',
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_expensereport`;
CREATE TABLE `llx_expensereport` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `ref` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `ref_number_int` int(11) DEFAULT NULL,
  `ref_ext` int(11) DEFAULT NULL,
  `total_ht` double(24,8) DEFAULT '0.00000000',
  `total_tva` double(24,8) DEFAULT '0.00000000',
  `localtax1` double(24,8) DEFAULT '0.00000000',
  `localtax2` double(24,8) DEFAULT '0.00000000',
  `total_ttc` double(24,8) DEFAULT '0.00000000',
  `date_debut` date NOT NULL,
  `date_fin` date NOT NULL,
  `date_create` datetime NOT NULL,
  `date_valid` datetime DEFAULT NULL,
  `date_approve` datetime DEFAULT NULL,
  `date_refuse` datetime DEFAULT NULL,
  `date_cancel` datetime DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_user_author` int(11) NOT NULL,
  `fk_user_creat` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `fk_user_valid` int(11) DEFAULT NULL,
  `fk_user_validator` int(11) DEFAULT NULL,
  `fk_user_approve` int(11) DEFAULT NULL,
  `fk_user_refuse` int(11) DEFAULT NULL,
  `fk_user_cancel` int(11) DEFAULT NULL,
  `fk_statut` int(11) NOT NULL,
  `fk_c_paiement` int(11) DEFAULT NULL,
  `paid` smallint(6) NOT NULL DEFAULT '0',
  `note_public` text COLLATE utf8_unicode_ci,
  `note_private` text COLLATE utf8_unicode_ci,
  `detail_refuse` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `detail_cancel` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `integration_compta` int(11) DEFAULT NULL,
  `fk_bank_account` int(11) DEFAULT NULL,
  `model_pdf` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_main_doc` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_multicurrency` int(11) DEFAULT NULL,
  `multicurrency_code` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `multicurrency_tx` double(24,8) DEFAULT '1.00000000',
  `multicurrency_total_ht` double(24,8) DEFAULT '0.00000000',
  `multicurrency_total_tva` double(24,8) DEFAULT '0.00000000',
  `multicurrency_total_ttc` double(24,8) DEFAULT '0.00000000',
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `extraparams` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `idx_expensereport_uk_ref` (`ref`,`entity`),
  KEY `idx_expensereport_date_debut` (`date_debut`),
  KEY `idx_expensereport_date_fin` (`date_fin`),
  KEY `idx_expensereport_fk_statut` (`fk_statut`),
  KEY `idx_expensereport_fk_user_author` (`fk_user_author`),
  KEY `idx_expensereport_fk_user_valid` (`fk_user_valid`),
  KEY `idx_expensereport_fk_user_approve` (`fk_user_approve`),
  KEY `idx_expensereport_fk_refuse` (`fk_user_approve`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_expensereport_det`;
CREATE TABLE `llx_expensereport_det` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_expensereport` int(11) NOT NULL,
  `docnumber` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_c_type_fees` int(11) NOT NULL,
  `fk_c_exp_tax_cat` int(11) DEFAULT NULL,
  `fk_projet` int(11) DEFAULT NULL,
  `comments` text COLLATE utf8_unicode_ci NOT NULL,
  `product_type` int(11) DEFAULT '-1',
  `qty` double NOT NULL,
  `subprice` double(24,8) NOT NULL DEFAULT '0.00000000',
  `value_unit` double(24,8) NOT NULL,
  `remise_percent` double DEFAULT NULL,
  `vat_src_code` varchar(10) COLLATE utf8_unicode_ci DEFAULT '',
  `tva_tx` double(7,4) DEFAULT NULL,
  `localtax1_tx` double(7,4) DEFAULT '0.0000',
  `localtax1_type` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `localtax2_tx` double(7,4) DEFAULT '0.0000',
  `localtax2_type` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `total_ht` double(24,8) NOT NULL DEFAULT '0.00000000',
  `total_tva` double(24,8) NOT NULL DEFAULT '0.00000000',
  `total_localtax1` double(24,8) DEFAULT '0.00000000',
  `total_localtax2` double(24,8) DEFAULT '0.00000000',
  `total_ttc` double(24,8) NOT NULL DEFAULT '0.00000000',
  `date` date NOT NULL,
  `info_bits` int(11) DEFAULT '0',
  `special_code` int(11) DEFAULT '0',
  `fk_multicurrency` int(11) DEFAULT NULL,
  `multicurrency_code` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `multicurrency_subprice` double(24,8) DEFAULT '0.00000000',
  `multicurrency_total_ht` double(24,8) DEFAULT '0.00000000',
  `multicurrency_total_tva` double(24,8) DEFAULT '0.00000000',
  `multicurrency_total_ttc` double(24,8) DEFAULT '0.00000000',
  `fk_facture` int(11) DEFAULT '0',
  `fk_ecm_files` int(11) DEFAULT NULL,
  `fk_code_ventilation` int(11) DEFAULT '0',
  `rang` int(11) DEFAULT '0',
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `rule_warning_message` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_expensereport_extrafields`;
CREATE TABLE `llx_expensereport_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_expensereport_extrafields` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_expensereport_ik`;
CREATE TABLE `llx_expensereport_ik` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_c_exp_tax_cat` int(11) NOT NULL DEFAULT '0',
  `fk_range` int(11) NOT NULL DEFAULT '0',
  `coef` double NOT NULL DEFAULT '0',
  `ikoffset` double NOT NULL DEFAULT '0',
  `active` int(11) DEFAULT '1',
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_expensereport_ik` (`rowid`, `datec`, `tms`, `fk_c_exp_tax_cat`, `fk_range`, `coef`, `ikoffset`, `active`) VALUES
(1,	NULL,	'2022-09-06 10:05:28',	4,	1,	0.41,	0,	1),
(2,	NULL,	'2022-09-06 10:05:28',	4,	2,	0.244,	824,	1),
(3,	NULL,	'2022-09-06 10:05:28',	4,	3,	0.286,	0,	1),
(4,	NULL,	'2022-09-06 10:05:28',	5,	4,	0.493,	0,	1),
(5,	NULL,	'2022-09-06 10:05:28',	5,	5,	0.277,	1082,	1),
(6,	NULL,	'2022-09-06 10:05:28',	5,	6,	0.332,	0,	1),
(7,	NULL,	'2022-09-06 10:05:28',	6,	7,	0.543,	0,	1),
(8,	NULL,	'2022-09-06 10:05:28',	6,	8,	0.305,	1180,	1),
(9,	NULL,	'2022-09-06 10:05:28',	6,	9,	0.364,	0,	1),
(10,	NULL,	'2022-09-06 10:05:28',	7,	10,	0.568,	0,	1),
(11,	NULL,	'2022-09-06 10:05:28',	7,	11,	0.32,	1244,	1),
(12,	NULL,	'2022-09-06 10:05:28',	7,	12,	0.382,	0,	1),
(13,	NULL,	'2022-09-06 10:05:28',	8,	13,	0.595,	0,	1),
(14,	NULL,	'2022-09-06 10:05:28',	8,	14,	0.337,	1288,	1),
(15,	NULL,	'2022-09-06 10:05:28',	8,	15,	0.401,	0,	1);

DROP TABLE IF EXISTS `llx_expensereport_rules`;
CREATE TABLE `llx_expensereport_rules` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `dates` datetime NOT NULL,
  `datee` datetime NOT NULL,
  `amount` double(24,8) NOT NULL,
  `restrictive` tinyint(4) NOT NULL,
  `fk_user` int(11) DEFAULT NULL,
  `fk_usergroup` int(11) DEFAULT NULL,
  `fk_c_type_fees` int(11) NOT NULL,
  `code_expense_rules_type` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `is_for_all` tinyint(4) DEFAULT '0',
  `entity` int(11) DEFAULT '1',
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_export_compta`;
CREATE TABLE `llx_export_compta` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `ref` varchar(12) COLLATE utf8_unicode_ci NOT NULL,
  `date_export` datetime NOT NULL,
  `fk_user` int(11) NOT NULL,
  `note` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_export_model`;
CREATE TABLE `llx_export_model` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) DEFAULT '0',
  `fk_user` int(11) NOT NULL DEFAULT '0',
  `label` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `field` text COLLATE utf8_unicode_ci NOT NULL,
  `filter` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_export_model` (`label`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_extrafields`;
CREATE TABLE `llx_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `elementtype` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'member',
  `label` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `size` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fieldcomputed` text COLLATE utf8_unicode_ci,
  `fielddefault` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fieldunique` int(11) DEFAULT '0',
  `fieldrequired` int(11) DEFAULT '0',
  `perms` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `enabled` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pos` int(11) DEFAULT '0',
  `alwayseditable` int(11) DEFAULT '0',
  `param` text COLLATE utf8_unicode_ci,
  `list` varchar(255) COLLATE utf8_unicode_ci DEFAULT '1',
  `printable` int(11) DEFAULT '0',
  `totalizable` tinyint(1) DEFAULT '0',
  `langs` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `help` text COLLATE utf8_unicode_ci,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_extrafields_name` (`name`,`entity`,`elementtype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_extrafields` (`rowid`, `name`, `entity`, `elementtype`, `label`, `type`, `size`, `fieldcomputed`, `fielddefault`, `fieldunique`, `fieldrequired`, `perms`, `enabled`, `pos`, `alwayseditable`, `param`, `list`, `printable`, `totalizable`, `langs`, `help`, `fk_user_author`, `fk_user_modif`, `datec`, `tms`) VALUES
(10,	'show_total_ht',	1,	'supplier_proposaldet',	'Afficher le Total HT sur le sous-total',	'int',	'10',	NULL,	NULL,	0,	0,	NULL,	'1',	0,	0,	'a:1:{s:7:\"options\";a:1:{s:0:\"\";N;}}',	'0',	0,	0,	NULL,	'1',	1,	1,	'2022-09-07 14:02:04',	'2022-09-07 14:02:04'),
(11,	'show_reduc',	1,	'supplier_proposaldet',	'Afficher la r??duction sur le sous-total',	'int',	'10',	NULL,	NULL,	0,	0,	NULL,	'1',	0,	0,	'a:1:{s:7:\"options\";a:1:{s:0:\"\";N;}}',	'0',	0,	0,	NULL,	'1',	1,	1,	'2022-09-07 14:02:04',	'2022-09-07 14:02:04'),
(12,	'subtotal_show_qty',	1,	'supplier_proposaldet',	'Afficher la Quantit?? du Sous-Total',	'int',	'10',	NULL,	NULL,	0,	0,	NULL,	'1',	0,	0,	'a:1:{s:7:\"options\";a:1:{s:0:\"\";N;}}',	'0',	0,	0,	NULL,	'1',	1,	1,	'2022-09-07 14:02:04',	'2022-09-07 14:02:04'),
(13,	'show_total_ht',	1,	'commande_fournisseurdet',	'Afficher le Total HT sur le sous-total',	'int',	'10',	NULL,	NULL,	0,	0,	NULL,	'1',	0,	0,	'a:1:{s:7:\"options\";a:1:{s:0:\"\";N;}}',	'0',	0,	0,	NULL,	'1',	1,	1,	'2022-09-07 14:02:04',	'2022-09-07 14:02:04'),
(14,	'show_reduc',	1,	'commande_fournisseurdet',	'Afficher la r??duction sur le sous-total',	'int',	'10',	NULL,	NULL,	0,	0,	NULL,	'1',	0,	0,	'a:1:{s:7:\"options\";a:1:{s:0:\"\";N;}}',	'0',	0,	0,	NULL,	'1',	1,	1,	'2022-09-07 14:02:04',	'2022-09-07 14:02:04'),
(15,	'subtotal_show_qty',	1,	'commande_fournisseurdet',	'Afficher la Quantit?? du Sous-Total',	'int',	'10',	NULL,	NULL,	0,	0,	NULL,	'1',	0,	0,	'a:1:{s:7:\"options\";a:1:{s:0:\"\";N;}}',	'0',	0,	0,	NULL,	'1',	1,	1,	'2022-09-07 14:02:04',	'2022-09-07 14:02:04'),
(16,	'show_total_ht',	1,	'facture_fourn_det',	'Afficher le Total HT sur le sous-total',	'int',	'10',	NULL,	NULL,	0,	0,	NULL,	'1',	0,	0,	'a:1:{s:7:\"options\";a:1:{s:0:\"\";N;}}',	'0',	0,	0,	NULL,	'1',	1,	1,	'2022-09-07 14:02:04',	'2022-09-07 14:02:04'),
(17,	'show_reduc',	1,	'facture_fourn_det',	'Afficher la r??duction sur le sous-total',	'int',	'10',	NULL,	NULL,	0,	0,	NULL,	'1',	0,	0,	'a:1:{s:7:\"options\";a:1:{s:0:\"\";N;}}',	'0',	0,	0,	NULL,	'1',	1,	1,	'2022-09-07 14:02:04',	'2022-09-07 14:02:04'),
(18,	'subtotal_show_qty',	1,	'facture_fourn_det',	'Afficher la Quantit?? du Sous-Total',	'int',	'10',	NULL,	NULL,	0,	0,	NULL,	'1',	0,	0,	'a:1:{s:7:\"options\";a:1:{s:0:\"\";N;}}',	'0',	0,	0,	NULL,	'1',	1,	1,	'2022-09-07 14:02:04',	'2022-09-07 14:02:04'),
(19,	'chaine',	1,	'product',	'Largeur',	'varchar',	'255',	NULL,	NULL,	0,	0,	NULL,	'1',	100,	1,	'a:1:{s:7:\"options\";a:1:{s:0:\"\";N;}}',	'1',	0,	0,	NULL,	NULL,	1,	1,	'2022-09-28 12:47:59',	'2022-09-28 12:47:59'),
(105,	'prixtransport',	1,	'categorie',	'Co??t transport',	'double',	'5,2',	NULL,	NULL,	0,	0,	NULL,	'1',	100,	0,	'a:1:{s:7:\"options\";a:1:{s:0:\"\";N;}}',	'1',	1,	0,	NULL,	NULL,	1,	1,	'2022-10-06 09:20:24',	'2022-10-06 09:20:24'),
(107,	'tauxchange',	1,	'categorie',	'Taux de change',	'double',	'4,2',	NULL,	NULL,	0,	0,	NULL,	'1',	100,	0,	'a:1:{s:7:\"options\";a:1:{s:0:\"\";N;}}',	'1',	0,	0,	NULL,	NULL,	1,	1,	'2022-10-06 09:26:22',	'2022-10-06 09:26:22'),
(108,	'marge',	1,	'categorie',	'Marge',	'double',	'5,2',	NULL,	NULL,	0,	0,	NULL,	'1',	100,	0,	'a:1:{s:7:\"options\";a:1:{s:0:\"\";N;}}',	'1',	0,	0,	NULL,	NULL,	1,	1,	'2022-10-07 07:39:19',	'2022-10-07 07:39:19'),
(114,	'abaquesize',	1,	'propaldet',	'Size',	'sellist',	'',	NULL,	NULL,	0,	1,	NULL,	'1',	1,	1,	'a:1:{s:7:\"options\";a:1:{s:113:\"stormatic_csv:CONCAT(height,\' x \',width):rowid::fk_product=($SEL$ fk_product FROM llx_propaldet WHERE rowid=$ID$)\";N;}}',	'4',	1,	0,	NULL,	'Dimesion du produit au format : Longueur x Largeur',	1,	1,	'2022-10-17 11:32:59',	'2022-10-17 09:32:59'),
(119,	'abaquesize',	1,	'commandedet',	'Size',	'sellist',	'',	NULL,	NULL,	0,	0,	NULL,	'1',	1,	1,	'a:1:{s:7:\"options\";a:1:{s:115:\"stormatic_csv:CONCAT(height,\' x \',width):rowid::fk_product=($SEL$ fk_product FROM llx_commandedet WHERE rowid=$ID$)\";N;}}',	'4',	1,	0,	NULL,	'Dimension du produit au format : Longueur x Largeur',	1,	1,	'2022-10-17 16:50:30',	'2022-10-17 14:50:30'),
(120,	'abaquesize',	1,	'facturedet',	'Size',	'sellist',	'',	NULL,	NULL,	0,	0,	NULL,	'1',	1,	1,	'a:1:{s:7:\"options\";a:1:{s:114:\"stormatic_csv:CONCAT(height,\' x \',width):rowid::fk_product=($SEL$ fk_product FROM llx_facturedet WHERE rowid=$ID$)\";N;}}',	'4',	1,	0,	NULL,	'Dimension du produit au format : Longueur x Largeur',	1,	1,	'2022-10-17 16:51:11',	'2022-10-17 14:51:11'),
(121,	'abaquesize',	1,	'facturedet_rec',	'Size',	'sellist',	'',	NULL,	NULL,	0,	0,	NULL,	'1',	1,	1,	'a:1:{s:7:\"options\";a:1:{s:114:\"stormatic_csv:CONCAT(height,\' x \',width):rowid::fk_product=($SEL$ fk_product FROM llx_facturedet WHERE rowid=$ID$)\";N;}}',	'4',	1,	0,	NULL,	NULL,	1,	1,	'2022-10-17 16:51:32',	'2022-10-17 14:51:32');

DROP TABLE IF EXISTS `llx_facture`;
CREATE TABLE `llx_facture` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `ref` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `ref_ext` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ref_int` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ref_client` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` smallint(6) NOT NULL DEFAULT '0',
  `fk_soc` int(11) NOT NULL,
  `datec` datetime DEFAULT NULL,
  `datef` date DEFAULT NULL,
  `date_pointoftax` date DEFAULT NULL,
  `date_valid` date DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `date_closing` datetime DEFAULT NULL,
  `paye` smallint(6) NOT NULL DEFAULT '0',
  `remise_percent` double DEFAULT '0',
  `remise_absolue` double DEFAULT '0',
  `remise` double DEFAULT '0',
  `close_code` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  `close_note` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `total_tva` double(24,8) DEFAULT '0.00000000',
  `localtax1` double(24,8) DEFAULT '0.00000000',
  `localtax2` double(24,8) DEFAULT '0.00000000',
  `revenuestamp` double(24,8) DEFAULT '0.00000000',
  `total_ht` double(24,8) DEFAULT '0.00000000',
  `total_ttc` double(24,8) DEFAULT '0.00000000',
  `fk_statut` smallint(6) NOT NULL DEFAULT '0',
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `fk_user_valid` int(11) DEFAULT NULL,
  `fk_user_closing` int(11) DEFAULT NULL,
  `module_source` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pos_source` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_fac_rec_source` int(11) DEFAULT NULL,
  `fk_facture_source` int(11) DEFAULT NULL,
  `fk_projet` int(11) DEFAULT NULL,
  `increment` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_account` int(11) DEFAULT NULL,
  `fk_currency` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_cond_reglement` int(11) NOT NULL DEFAULT '1',
  `fk_mode_reglement` int(11) DEFAULT NULL,
  `date_lim_reglement` date DEFAULT NULL,
  `note_private` text COLLATE utf8_unicode_ci,
  `note_public` text COLLATE utf8_unicode_ci,
  `model_pdf` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_main_doc` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_incoterms` int(11) DEFAULT NULL,
  `location_incoterms` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_transport_mode` int(11) DEFAULT NULL,
  `situation_cycle_ref` smallint(6) DEFAULT NULL,
  `situation_counter` smallint(6) DEFAULT NULL,
  `situation_final` smallint(6) DEFAULT NULL,
  `retained_warranty` double DEFAULT NULL,
  `retained_warranty_date_limit` date DEFAULT NULL,
  `retained_warranty_fk_cond_reglement` int(11) DEFAULT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `extraparams` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_multicurrency` int(11) DEFAULT NULL,
  `multicurrency_code` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `multicurrency_tx` double(24,8) DEFAULT '1.00000000',
  `multicurrency_total_ht` double(24,8) DEFAULT '0.00000000',
  `multicurrency_total_tva` double(24,8) DEFAULT '0.00000000',
  `multicurrency_total_ttc` double(24,8) DEFAULT '0.00000000',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_facture_ref` (`ref`,`entity`),
  KEY `idx_facture_fk_soc` (`fk_soc`),
  KEY `idx_facture_fk_user_author` (`fk_user_author`),
  KEY `idx_facture_fk_user_valid` (`fk_user_valid`),
  KEY `idx_facture_fk_facture_source` (`fk_facture_source`),
  KEY `idx_facture_fk_projet` (`fk_projet`),
  KEY `idx_facture_fk_account` (`fk_account`),
  KEY `idx_facture_fk_currency` (`fk_currency`),
  KEY `idx_facture_fk_statut` (`fk_statut`),
  CONSTRAINT `fk_facture_fk_facture_source` FOREIGN KEY (`fk_facture_source`) REFERENCES `llx_facture` (`rowid`),
  CONSTRAINT `fk_facture_fk_projet` FOREIGN KEY (`fk_projet`) REFERENCES `llx_projet` (`rowid`),
  CONSTRAINT `fk_facture_fk_soc` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`),
  CONSTRAINT `fk_facture_fk_user_author` FOREIGN KEY (`fk_user_author`) REFERENCES `llx_user` (`rowid`),
  CONSTRAINT `fk_facture_fk_user_valid` FOREIGN KEY (`fk_user_valid`) REFERENCES `llx_user` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_facturedet`;
CREATE TABLE `llx_facturedet` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_facture` int(11) NOT NULL,
  `fk_parent_line` int(11) DEFAULT NULL,
  `fk_product` int(11) DEFAULT NULL,
  `label` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `vat_src_code` varchar(10) COLLATE utf8_unicode_ci DEFAULT '',
  `tva_tx` double(7,4) DEFAULT NULL,
  `localtax1_tx` double(7,4) DEFAULT '0.0000',
  `localtax1_type` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `localtax2_tx` double(7,4) DEFAULT '0.0000',
  `localtax2_type` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `qty` double DEFAULT NULL,
  `remise_percent` double DEFAULT '0',
  `remise` double DEFAULT '0',
  `fk_remise_except` int(11) DEFAULT NULL,
  `subprice` double(24,8) DEFAULT NULL,
  `price` double(24,8) DEFAULT NULL,
  `total_ht` double(24,8) DEFAULT NULL,
  `total_tva` double(24,8) DEFAULT NULL,
  `total_localtax1` double(24,8) DEFAULT '0.00000000',
  `total_localtax2` double(24,8) DEFAULT '0.00000000',
  `total_ttc` double(24,8) DEFAULT NULL,
  `product_type` int(11) DEFAULT '0',
  `date_start` datetime DEFAULT NULL,
  `date_end` datetime DEFAULT NULL,
  `info_bits` int(11) DEFAULT '0',
  `buy_price_ht` double(24,8) DEFAULT '0.00000000',
  `fk_product_fournisseur_price` int(11) DEFAULT NULL,
  `special_code` int(11) DEFAULT '0',
  `rang` int(11) DEFAULT '0',
  `fk_contract_line` int(11) DEFAULT NULL,
  `fk_unit` int(11) DEFAULT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_code_ventilation` int(11) NOT NULL DEFAULT '0',
  `situation_percent` double DEFAULT '100',
  `fk_prev_id` int(11) DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `fk_multicurrency` int(11) DEFAULT NULL,
  `multicurrency_code` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `multicurrency_subprice` double(24,8) DEFAULT '0.00000000',
  `multicurrency_total_ht` double(24,8) DEFAULT '0.00000000',
  `multicurrency_total_tva` double(24,8) DEFAULT '0.00000000',
  `multicurrency_total_ttc` double(24,8) DEFAULT '0.00000000',
  `ref_ext` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_fk_remise_except` (`fk_remise_except`,`fk_facture`),
  KEY `idx_facturedet_fk_facture` (`fk_facture`),
  KEY `idx_facturedet_fk_product` (`fk_product`),
  KEY `idx_facturedet_fk_code_ventilation` (`fk_code_ventilation`),
  KEY `fk_facturedet_fk_unit` (`fk_unit`),
  CONSTRAINT `fk_facturedet_fk_facture` FOREIGN KEY (`fk_facture`) REFERENCES `llx_facture` (`rowid`),
  CONSTRAINT `fk_facturedet_fk_unit` FOREIGN KEY (`fk_unit`) REFERENCES `llx_c_units` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_facturedet_extrafields`;
CREATE TABLE `llx_facturedet_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `abaquesize` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_facturedet_extrafields` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_facturedet_rec`;
CREATE TABLE `llx_facturedet_rec` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_facture` int(11) NOT NULL,
  `fk_parent_line` int(11) DEFAULT NULL,
  `fk_product` int(11) DEFAULT NULL,
  `product_type` int(11) DEFAULT '0',
  `label` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `vat_src_code` varchar(10) COLLATE utf8_unicode_ci DEFAULT '',
  `tva_tx` double(7,4) DEFAULT NULL,
  `localtax1_tx` double(7,4) DEFAULT '0.0000',
  `localtax1_type` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `localtax2_tx` double(7,4) DEFAULT '0.0000',
  `localtax2_type` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `qty` double DEFAULT NULL,
  `remise_percent` double DEFAULT '0',
  `remise` double DEFAULT '0',
  `subprice` double(24,8) DEFAULT NULL,
  `price` double(24,8) DEFAULT NULL,
  `total_ht` double(24,8) DEFAULT NULL,
  `total_tva` double(24,8) DEFAULT NULL,
  `total_localtax1` double(24,8) DEFAULT '0.00000000',
  `total_localtax2` double(24,8) DEFAULT '0.00000000',
  `total_ttc` double(24,8) DEFAULT NULL,
  `date_start_fill` int(11) DEFAULT '0',
  `date_end_fill` int(11) DEFAULT '0',
  `info_bits` int(11) DEFAULT '0',
  `buy_price_ht` double(24,8) DEFAULT '0.00000000',
  `fk_product_fournisseur_price` int(11) DEFAULT NULL,
  `special_code` int(10) unsigned DEFAULT '0',
  `rang` int(11) DEFAULT '0',
  `fk_contract_line` int(11) DEFAULT NULL,
  `fk_unit` int(11) DEFAULT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `fk_multicurrency` int(11) DEFAULT NULL,
  `multicurrency_code` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `multicurrency_subprice` double(24,8) DEFAULT '0.00000000',
  `multicurrency_total_ht` double(24,8) DEFAULT '0.00000000',
  `multicurrency_total_tva` double(24,8) DEFAULT '0.00000000',
  `multicurrency_total_ttc` double(24,8) DEFAULT '0.00000000',
  PRIMARY KEY (`rowid`),
  KEY `fk_facturedet_rec_fk_unit` (`fk_unit`),
  CONSTRAINT `fk_facturedet_rec_fk_unit` FOREIGN KEY (`fk_unit`) REFERENCES `llx_c_units` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_facturedet_rec_extrafields`;
CREATE TABLE `llx_facturedet_rec_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `abaquesize` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_facturedet_rec_extrafields` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_facture_extrafields`;
CREATE TABLE `llx_facture_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_facture_extrafields` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_facture_fourn`;
CREATE TABLE `llx_facture_fourn` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `ref` varchar(180) COLLATE utf8_unicode_ci NOT NULL,
  `ref_supplier` varchar(180) COLLATE utf8_unicode_ci NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `ref_ext` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` smallint(6) NOT NULL DEFAULT '0',
  `fk_soc` int(11) NOT NULL,
  `datec` datetime DEFAULT NULL,
  `datef` date DEFAULT NULL,
  `date_pointoftax` date DEFAULT NULL,
  `date_valid` date DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `date_closing` datetime DEFAULT NULL,
  `libelle` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `paye` smallint(6) NOT NULL DEFAULT '0',
  `amount` double(24,8) NOT NULL DEFAULT '0.00000000',
  `remise` double(24,8) DEFAULT '0.00000000',
  `close_code` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  `close_note` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tva` double(24,8) DEFAULT '0.00000000',
  `localtax1` double(24,8) DEFAULT '0.00000000',
  `localtax2` double(24,8) DEFAULT '0.00000000',
  `total` double(24,8) DEFAULT '0.00000000',
  `total_ht` double(24,8) DEFAULT '0.00000000',
  `total_tva` double(24,8) DEFAULT '0.00000000',
  `total_ttc` double(24,8) DEFAULT '0.00000000',
  `fk_statut` smallint(6) NOT NULL DEFAULT '0',
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `fk_user_valid` int(11) DEFAULT NULL,
  `fk_user_closing` int(11) DEFAULT NULL,
  `fk_facture_source` int(11) DEFAULT NULL,
  `fk_projet` int(11) DEFAULT NULL,
  `fk_account` int(11) DEFAULT NULL,
  `fk_cond_reglement` int(11) DEFAULT NULL,
  `fk_mode_reglement` int(11) DEFAULT NULL,
  `date_lim_reglement` date DEFAULT NULL,
  `note_private` text COLLATE utf8_unicode_ci,
  `note_public` text COLLATE utf8_unicode_ci,
  `fk_incoterms` int(11) DEFAULT NULL,
  `location_incoterms` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_transport_mode` int(11) DEFAULT NULL,
  `model_pdf` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_main_doc` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `extraparams` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_multicurrency` int(11) DEFAULT NULL,
  `multicurrency_code` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `multicurrency_tx` double(24,8) DEFAULT '1.00000000',
  `multicurrency_total_ht` double(24,8) DEFAULT '0.00000000',
  `multicurrency_total_tva` double(24,8) DEFAULT '0.00000000',
  `multicurrency_total_ttc` double(24,8) DEFAULT '0.00000000',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_facture_fourn_ref` (`ref`,`entity`),
  UNIQUE KEY `uk_facture_fourn_ref_supplier` (`ref_supplier`,`fk_soc`,`entity`),
  KEY `idx_facture_fourn_date_lim_reglement` (`date_lim_reglement`),
  KEY `idx_facture_fourn_fk_soc` (`fk_soc`),
  KEY `idx_facture_fourn_fk_user_author` (`fk_user_author`),
  KEY `idx_facture_fourn_fk_user_valid` (`fk_user_valid`),
  KEY `idx_facture_fourn_fk_projet` (`fk_projet`),
  CONSTRAINT `fk_facture_fourn_fk_projet` FOREIGN KEY (`fk_projet`) REFERENCES `llx_projet` (`rowid`),
  CONSTRAINT `fk_facture_fourn_fk_soc` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`),
  CONSTRAINT `fk_facture_fourn_fk_user_author` FOREIGN KEY (`fk_user_author`) REFERENCES `llx_user` (`rowid`),
  CONSTRAINT `fk_facture_fourn_fk_user_valid` FOREIGN KEY (`fk_user_valid`) REFERENCES `llx_user` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_facture_fourn_det`;
CREATE TABLE `llx_facture_fourn_det` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_facture_fourn` int(11) NOT NULL,
  `fk_parent_line` int(11) DEFAULT NULL,
  `fk_product` int(11) DEFAULT NULL,
  `ref` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `label` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `pu_ht` double(24,8) DEFAULT NULL,
  `pu_ttc` double(24,8) DEFAULT NULL,
  `qty` double DEFAULT NULL,
  `remise_percent` double DEFAULT '0',
  `fk_remise_except` int(11) DEFAULT NULL,
  `vat_src_code` varchar(10) COLLATE utf8_unicode_ci DEFAULT '',
  `tva_tx` double(7,4) DEFAULT NULL,
  `localtax1_tx` double(7,4) DEFAULT '0.0000',
  `localtax1_type` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `localtax2_tx` double(7,4) DEFAULT '0.0000',
  `localtax2_type` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `total_ht` double(24,8) DEFAULT NULL,
  `tva` double(24,8) DEFAULT NULL,
  `total_localtax1` double(24,8) DEFAULT '0.00000000',
  `total_localtax2` double(24,8) DEFAULT '0.00000000',
  `total_ttc` double(24,8) DEFAULT NULL,
  `product_type` int(11) DEFAULT '0',
  `date_start` datetime DEFAULT NULL,
  `date_end` datetime DEFAULT NULL,
  `info_bits` int(11) DEFAULT '0',
  `fk_code_ventilation` int(11) NOT NULL DEFAULT '0',
  `special_code` int(11) DEFAULT '0',
  `rang` int(11) DEFAULT '0',
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_unit` int(11) DEFAULT NULL,
  `fk_multicurrency` int(11) DEFAULT NULL,
  `multicurrency_code` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `multicurrency_subprice` double(24,8) DEFAULT '0.00000000',
  `multicurrency_total_ht` double(24,8) DEFAULT '0.00000000',
  `multicurrency_total_tva` double(24,8) DEFAULT '0.00000000',
  `multicurrency_total_ttc` double(24,8) DEFAULT '0.00000000',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_fk_remise_except` (`fk_remise_except`,`fk_facture_fourn`),
  KEY `idx_facture_fourn_det_fk_facture` (`fk_facture_fourn`),
  KEY `idx_facture_fourn_det_fk_product` (`fk_product`),
  KEY `idx_facture_fourn_det_fk_code_ventilation` (`fk_code_ventilation`),
  KEY `fk_facture_fourn_det_fk_unit` (`fk_unit`),
  CONSTRAINT `fk_facture_fourn_det_fk_facture` FOREIGN KEY (`fk_facture_fourn`) REFERENCES `llx_facture_fourn` (`rowid`),
  CONSTRAINT `fk_facture_fourn_det_fk_unit` FOREIGN KEY (`fk_unit`) REFERENCES `llx_c_units` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_facture_fourn_det_extrafields`;
CREATE TABLE `llx_facture_fourn_det_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `show_total_ht` int(10) DEFAULT NULL,
  `show_reduc` int(10) DEFAULT NULL,
  `subtotal_show_qty` int(10) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_facture_fourn_det_extrafields` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_facture_fourn_extrafields`;
CREATE TABLE `llx_facture_fourn_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_facture_fourn_extrafields` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_facture_rec`;
CREATE TABLE `llx_facture_rec` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `titre` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `fk_soc` int(11) NOT NULL,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `suspended` int(11) DEFAULT '0',
  `amount` double(24,8) NOT NULL DEFAULT '0.00000000',
  `remise` double DEFAULT '0',
  `remise_percent` double DEFAULT '0',
  `remise_absolue` double DEFAULT '0',
  `vat_src_code` varchar(10) COLLATE utf8_unicode_ci DEFAULT '',
  `total_tva` double(24,8) DEFAULT '0.00000000',
  `localtax1` double(24,8) DEFAULT '0.00000000',
  `localtax2` double(24,8) DEFAULT '0.00000000',
  `revenuestamp` double(24,8) DEFAULT '0.00000000',
  `total_ht` double(24,8) DEFAULT '0.00000000',
  `total_ttc` double(24,8) DEFAULT '0.00000000',
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `fk_projet` int(11) DEFAULT NULL,
  `fk_cond_reglement` int(11) NOT NULL DEFAULT '1',
  `fk_mode_reglement` int(11) DEFAULT '0',
  `date_lim_reglement` date DEFAULT NULL,
  `fk_account` int(11) DEFAULT NULL,
  `note_private` text COLLATE utf8_unicode_ci,
  `note_public` text COLLATE utf8_unicode_ci,
  `modelpdf` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_multicurrency` int(11) DEFAULT NULL,
  `multicurrency_code` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `multicurrency_tx` double(24,8) DEFAULT '1.00000000',
  `multicurrency_total_ht` double(24,8) DEFAULT '0.00000000',
  `multicurrency_total_tva` double(24,8) DEFAULT '0.00000000',
  `multicurrency_total_ttc` double(24,8) DEFAULT '0.00000000',
  `usenewprice` int(11) DEFAULT '0',
  `frequency` int(11) DEFAULT NULL,
  `unit_frequency` varchar(2) COLLATE utf8_unicode_ci DEFAULT 'm',
  `date_when` datetime DEFAULT NULL,
  `date_last_gen` datetime DEFAULT NULL,
  `nb_gen_done` int(11) DEFAULT NULL,
  `nb_gen_max` int(11) DEFAULT NULL,
  `auto_validate` int(11) DEFAULT '0',
  `generate_pdf` int(11) DEFAULT '1',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `idx_facture_rec_uk_titre` (`titre`,`entity`),
  KEY `idx_facture_rec_fk_soc` (`fk_soc`),
  KEY `idx_facture_rec_fk_user_author` (`fk_user_author`),
  KEY `idx_facture_rec_fk_projet` (`fk_projet`),
  CONSTRAINT `fk_facture_rec_fk_projet` FOREIGN KEY (`fk_projet`) REFERENCES `llx_projet` (`rowid`),
  CONSTRAINT `fk_facture_rec_fk_soc` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`),
  CONSTRAINT `fk_facture_rec_fk_user_author` FOREIGN KEY (`fk_user_author`) REFERENCES `llx_user` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_facture_rec_extrafields`;
CREATE TABLE `llx_facture_rec_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_facture_rec_extrafields` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_fichinter`;
CREATE TABLE `llx_fichinter` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_soc` int(11) NOT NULL,
  `fk_projet` int(11) DEFAULT '0',
  `fk_contrat` int(11) DEFAULT '0',
  `ref` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `ref_ext` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `datec` datetime DEFAULT NULL,
  `date_valid` datetime DEFAULT NULL,
  `datei` date DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `fk_user_valid` int(11) DEFAULT NULL,
  `fk_statut` smallint(6) DEFAULT '0',
  `dateo` date DEFAULT NULL,
  `datee` date DEFAULT NULL,
  `datet` date DEFAULT NULL,
  `duree` double DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `note_private` text COLLATE utf8_unicode_ci,
  `note_public` text COLLATE utf8_unicode_ci,
  `model_pdf` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_main_doc` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `extraparams` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_fichinter_ref` (`ref`,`entity`),
  KEY `idx_fichinter_fk_soc` (`fk_soc`),
  CONSTRAINT `fk_fichinter_fk_soc` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_fichinterdet`;
CREATE TABLE `llx_fichinterdet` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_fichinter` int(11) DEFAULT NULL,
  `fk_parent_line` int(11) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `duree` int(11) DEFAULT NULL,
  `rang` int(11) DEFAULT '0',
  PRIMARY KEY (`rowid`),
  KEY `idx_fichinterdet_fk_fichinter` (`fk_fichinter`),
  CONSTRAINT `fk_fichinterdet_fk_fichinter` FOREIGN KEY (`fk_fichinter`) REFERENCES `llx_fichinter` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_fichinterdet_extrafields`;
CREATE TABLE `llx_fichinterdet_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_ficheinterdet_extrafields` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_fichinterdet_rec`;
CREATE TABLE `llx_fichinterdet_rec` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_fichinter` int(11) NOT NULL,
  `date` datetime DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `duree` int(11) DEFAULT NULL,
  `rang` int(11) DEFAULT '0',
  `total_ht` double(24,8) DEFAULT NULL,
  `subprice` double(24,8) DEFAULT NULL,
  `fk_parent_line` int(11) DEFAULT NULL,
  `fk_product` int(11) DEFAULT NULL,
  `label` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tva_tx` double(6,3) DEFAULT NULL,
  `localtax1_tx` double(6,3) DEFAULT '0.000',
  `localtax1_type` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `localtax2_tx` double(6,3) DEFAULT '0.000',
  `localtax2_type` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `qty` double DEFAULT NULL,
  `remise_percent` double DEFAULT '0',
  `remise` double DEFAULT '0',
  `fk_remise_except` int(11) DEFAULT NULL,
  `price` double(24,8) DEFAULT NULL,
  `total_tva` double(24,8) DEFAULT NULL,
  `total_localtax1` double(24,8) DEFAULT '0.00000000',
  `total_localtax2` double(24,8) DEFAULT '0.00000000',
  `total_ttc` double(24,8) DEFAULT NULL,
  `product_type` int(11) DEFAULT '0',
  `date_start` datetime DEFAULT NULL,
  `date_end` datetime DEFAULT NULL,
  `info_bits` int(11) DEFAULT '0',
  `buy_price_ht` double(24,8) DEFAULT '0.00000000',
  `fk_product_fournisseur_price` int(11) DEFAULT NULL,
  `fk_code_ventilation` int(11) NOT NULL DEFAULT '0',
  `fk_export_commpta` int(11) NOT NULL DEFAULT '0',
  `special_code` int(10) unsigned DEFAULT '0',
  `fk_unit` int(11) DEFAULT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_fichinter_extrafields`;
CREATE TABLE `llx_fichinter_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_ficheinter_extrafields` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_fichinter_rec`;
CREATE TABLE `llx_fichinter_rec` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `titre` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `fk_soc` int(11) DEFAULT NULL,
  `datec` datetime DEFAULT NULL,
  `fk_contrat` int(11) DEFAULT '0',
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_projet` int(11) DEFAULT NULL,
  `duree` double DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `modelpdf` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `note_private` text COLLATE utf8_unicode_ci,
  `note_public` text COLLATE utf8_unicode_ci,
  `frequency` int(11) DEFAULT NULL,
  `unit_frequency` varchar(2) COLLATE utf8_unicode_ci DEFAULT 'm',
  `date_when` datetime DEFAULT NULL,
  `date_last_gen` datetime DEFAULT NULL,
  `nb_gen_done` int(11) DEFAULT NULL,
  `nb_gen_max` int(11) DEFAULT NULL,
  `auto_validate` int(11) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `idx_fichinter_rec_uk_titre` (`titre`,`entity`),
  KEY `idx_fichinter_rec_fk_soc` (`fk_soc`),
  KEY `idx_fichinter_rec_fk_user_author` (`fk_user_author`),
  KEY `idx_fichinter_rec_fk_projet` (`fk_projet`),
  CONSTRAINT `fk_fichinter_rec_fk_projet` FOREIGN KEY (`fk_projet`) REFERENCES `llx_projet` (`rowid`),
  CONSTRAINT `fk_fichinter_rec_fk_user_author` FOREIGN KEY (`fk_user_author`) REFERENCES `llx_user` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_holiday`;
CREATE TABLE `llx_holiday` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `ref` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `ref_ext` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `fk_user` int(11) NOT NULL,
  `fk_user_create` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `fk_type` int(11) NOT NULL,
  `date_create` datetime NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `date_debut` date NOT NULL,
  `date_fin` date NOT NULL,
  `halfday` int(11) DEFAULT '0',
  `statut` int(11) NOT NULL DEFAULT '1',
  `fk_validator` int(11) NOT NULL,
  `date_valid` datetime DEFAULT NULL,
  `fk_user_valid` int(11) DEFAULT NULL,
  `date_approve` datetime DEFAULT NULL,
  `fk_user_approve` int(11) DEFAULT NULL,
  `date_refuse` datetime DEFAULT NULL,
  `fk_user_refuse` int(11) DEFAULT NULL,
  `date_cancel` datetime DEFAULT NULL,
  `fk_user_cancel` int(11) DEFAULT NULL,
  `detail_refuse` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `note_private` text COLLATE utf8_unicode_ci,
  `note_public` text COLLATE utf8_unicode_ci,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `extraparams` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_holiday_entity` (`entity`),
  KEY `idx_holiday_fk_user` (`fk_user`),
  KEY `idx_holiday_fk_user_create` (`fk_user_create`),
  KEY `idx_holiday_date_create` (`date_create`),
  KEY `idx_holiday_date_debut` (`date_debut`),
  KEY `idx_holiday_date_fin` (`date_fin`),
  KEY `idx_holiday_fk_validator` (`fk_validator`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_holiday_config`;
CREATE TABLE `llx_holiday_config` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `value` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `idx_holiday_config` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_holiday_config` (`rowid`, `name`, `value`) VALUES
(1,	'lastUpdate',	NULL);

DROP TABLE IF EXISTS `llx_holiday_extrafields`;
CREATE TABLE `llx_holiday_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_holiday_extrafields` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_holiday_logs`;
CREATE TABLE `llx_holiday_logs` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `date_action` datetime NOT NULL,
  `fk_user_action` int(11) NOT NULL,
  `fk_user_update` int(11) NOT NULL,
  `fk_type` int(11) NOT NULL,
  `type_action` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `prev_solde` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `new_solde` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_holiday_users`;
CREATE TABLE `llx_holiday_users` (
  `fk_user` int(11) NOT NULL,
  `fk_type` int(11) NOT NULL,
  `nb_holiday` double NOT NULL DEFAULT '0',
  UNIQUE KEY `uk_holiday_users` (`fk_user`,`fk_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_importfilescsv_csv_extrafields`;
CREATE TABLE `llx_importfilescsv_csv_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT NULL,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_csv_fk_object` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_import_model`;
CREATE TABLE `llx_import_model` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '0',
  `fk_user` int(11) NOT NULL DEFAULT '0',
  `label` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `field` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_import_model` (`label`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_import_model` (`rowid`, `entity`, `fk_user`, `label`, `type`, `field`) VALUES
(1,	0,	1,	'custom',	'produit_1',	'1=p.ref,2=p.label,3=p.fk_product_type,4=p.tosell,5=p.tobuy,6=p.description,7=p.url'),
(2,	0,	0,	'Import Personnalis??',	'produit_1',	'1=p.ref,2=p.label,3=p.fk_product_type,4=p.tosell,5=p.tobuy,6=p.description,7=p.url'),
(3,	0,	0,	'Ref - Niveau Prix - Prix - Date',	'produit_multiprice',	'1=pr.fk_product,8=pr.price_base_type,2=pr.price_level,3=pr.price,6=pr.price_ttc,5=pr.price_min,7=pr.price_min_ttc,4=pr.date_price');

DROP TABLE IF EXISTS `llx_intracommreport`;
CREATE TABLE `llx_intracommreport` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `ref` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `type_declaration` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `periods` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mode` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `content_xml` text COLLATE utf8_unicode_ci,
  `type_export` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_inventory`;
CREATE TABLE `llx_inventory` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) DEFAULT '0',
  `ref` varchar(48) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_creation` datetime DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_user_creat` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `fk_user_valid` int(11) DEFAULT NULL,
  `fk_warehouse` int(11) DEFAULT NULL,
  `fk_product` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT '0',
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `date_inventory` datetime DEFAULT NULL,
  `date_validation` datetime DEFAULT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_inventory_ref` (`ref`,`entity`),
  KEY `idx_inventory_tms` (`tms`),
  KEY `idx_inventory_date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_inventorydet`;
CREATE TABLE `llx_inventorydet` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_inventory` int(11) DEFAULT '0',
  `fk_warehouse` int(11) DEFAULT '0',
  `fk_product` int(11) DEFAULT '0',
  `batch` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `qty_stock` double DEFAULT NULL,
  `qty_view` double DEFAULT NULL,
  `qty_regulated` double DEFAULT NULL,
  `fk_movement` int(11) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_inventorydet` (`fk_inventory`,`fk_warehouse`,`fk_product`,`batch`),
  KEY `idx_inventorydet_tms` (`tms`),
  KEY `idx_inventorydet_datec` (`datec`),
  KEY `idx_inventorydet_fk_inventory` (`fk_inventory`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_knowledgemanagement_knowledgerecord`;
CREATE TABLE `llx_knowledgemanagement_knowledgerecord` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `ref` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `date_creation` datetime NOT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_main_doc` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lang` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_user_creat` int(11) NOT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `fk_user_valid` int(11) DEFAULT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `model_pdf` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `question` text COLLATE utf8_unicode_ci NOT NULL,
  `answer` text COLLATE utf8_unicode_ci,
  `url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_ticket` int(11) DEFAULT NULL,
  `fk_c_ticket_category` int(11) DEFAULT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_knowledgemanagement_knowledgerecord_rowid` (`rowid`),
  KEY `idx_knowledgemanagement_knowledgerecord_ref` (`ref`),
  KEY `llx_knowledgemanagement_knowledgerecord_fk_user_creat` (`fk_user_creat`),
  KEY `idx_knowledgemanagement_knowledgerecord_status` (`status`),
  CONSTRAINT `llx_knowledgemanagement_knowledgerecord_fk_user_creat` FOREIGN KEY (`fk_user_creat`) REFERENCES `llx_user` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_knowledgemanagement_knowledgerecord_extrafields`;
CREATE TABLE `llx_knowledgemanagement_knowledgerecord_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_knowledgerecord_fk_object` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_links`;
CREATE TABLE `llx_links` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `datea` datetime NOT NULL,
  `url` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `label` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `objecttype` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `objectid` int(11) NOT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_links` (`objectid`,`label`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_loan`;
CREATE TABLE `llx_loan` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `label` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `fk_bank` int(11) DEFAULT NULL,
  `capital` double(24,8) NOT NULL DEFAULT '0.00000000',
  `insurance_amount` double(24,8) DEFAULT '0.00000000',
  `datestart` date DEFAULT NULL,
  `dateend` date DEFAULT NULL,
  `nbterm` double DEFAULT NULL,
  `rate` double NOT NULL,
  `note_private` text COLLATE utf8_unicode_ci,
  `note_public` text COLLATE utf8_unicode_ci,
  `capital_position` double(24,8) DEFAULT '0.00000000',
  `date_position` date DEFAULT NULL,
  `paid` smallint(6) NOT NULL DEFAULT '0',
  `accountancy_account_capital` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `accountancy_account_insurance` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `accountancy_account_interest` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_projet` int(11) DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_loan_schedule`;
CREATE TABLE `llx_loan_schedule` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_loan` int(11) DEFAULT NULL,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `datep` datetime DEFAULT NULL,
  `amount_capital` double(24,8) DEFAULT '0.00000000',
  `amount_insurance` double(24,8) DEFAULT '0.00000000',
  `amount_interest` double(24,8) DEFAULT '0.00000000',
  `fk_typepayment` int(11) NOT NULL,
  `num_payment` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `note_private` text COLLATE utf8_unicode_ci,
  `note_public` text COLLATE utf8_unicode_ci,
  `fk_bank` int(11) NOT NULL,
  `fk_payment_loan` int(11) DEFAULT NULL,
  `fk_user_creat` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_localtax`;
CREATE TABLE `llx_localtax` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `localtaxtype` tinyint(4) DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `datep` date DEFAULT NULL,
  `datev` date DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `label` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `note` text COLLATE utf8_unicode_ci,
  `fk_bank` int(11) DEFAULT NULL,
  `fk_user_creat` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_mailing`;
CREATE TABLE `llx_mailing` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `statut` smallint(6) DEFAULT '0',
  `titre` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `sujet` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `body` mediumtext COLLATE utf8_unicode_ci,
  `bgcolor` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `bgimage` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cible` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nbemail` int(11) DEFAULT NULL,
  `email_from` varchar(160) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email_replyto` varchar(160) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email_errorsto` varchar(160) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tag` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_creat` datetime DEFAULT NULL,
  `date_valid` datetime DEFAULT NULL,
  `date_appro` datetime DEFAULT NULL,
  `date_envoi` datetime DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_user_creat` int(11) DEFAULT NULL,
  `fk_user_valid` int(11) DEFAULT NULL,
  `fk_user_appro` int(11) DEFAULT NULL,
  `extraparams` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `joined_file1` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `joined_file2` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `joined_file3` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `joined_file4` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_mailing_cibles`;
CREATE TABLE `llx_mailing_cibles` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_mailing` int(11) NOT NULL,
  `fk_contact` int(11) NOT NULL,
  `lastname` varchar(160) COLLATE utf8_unicode_ci DEFAULT NULL,
  `firstname` varchar(160) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(160) COLLATE utf8_unicode_ci NOT NULL,
  `other` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tag` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `statut` smallint(6) NOT NULL DEFAULT '0',
  `source_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `source_id` int(11) DEFAULT NULL,
  `source_type` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_envoi` datetime DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `error_text` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_mailing_cibles` (`fk_mailing`,`email`),
  KEY `idx_mailing_cibles_email` (`email`),
  KEY `idx_mailing_cibles_tag` (`tag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_mailing_unsubscribe`;
CREATE TABLE `llx_mailing_unsubscribe` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `unsubscribegroup` varchar(128) COLLATE utf8_unicode_ci DEFAULT '',
  `ip` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_creat` datetime DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_mailing_unsubscribe` (`email`,`entity`,`unsubscribegroup`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_menu`;
CREATE TABLE `llx_menu` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `menu_handler` varchar(16) COLLATE utf8_unicode_ci NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `module` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` varchar(4) COLLATE utf8_unicode_ci NOT NULL,
  `mainmenu` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `leftmenu` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_menu` int(11) NOT NULL,
  `fk_mainmenu` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_leftmenu` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `position` int(11) NOT NULL,
  `url` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `target` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `titre` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `prefix` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `langs` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `level` smallint(6) DEFAULT NULL,
  `perms` text COLLATE utf8_unicode_ci,
  `enabled` text COLLATE utf8_unicode_ci,
  `usertype` int(11) NOT NULL DEFAULT '0',
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `idx_menu_uk_menu` (`menu_handler`,`fk_menu`,`position`,`url`,`entity`),
  KEY `idx_menu_menuhandler_type` (`menu_handler`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_menu` (`rowid`, `menu_handler`, `entity`, `module`, `type`, `mainmenu`, `leftmenu`, `fk_menu`, `fk_mainmenu`, `fk_leftmenu`, `position`, `url`, `target`, `titre`, `prefix`, `langs`, `level`, `perms`, `enabled`, `usertype`, `tms`) VALUES
(1,	'all',	1,	'margins',	'left',	'billing',	'margins',	-1,	'billing',	NULL,	100,	'/margin/index.php',	'',	'Margins',	'<span class=\"fas fa-calculator infobox-bank_account paddingright pictofixedwidth\" style=\"\"></span>',	'margins',	NULL,	'$user->rights->margins->liretous',	'$conf->margin->enabled',	2,	'2022-09-06 10:17:39'),
(2,	'all',	1,	'crmenhanced',	'top',	'crmenhanced',	NULL,	0,	NULL,	NULL,	1001,	'/crmenhanced/statistics.php',	'',	'crmenhanced',	'',	'crmenhanced@crmenhanced',	NULL,	'$user->rights->crmenhanced->read',	'$conf->crmenhanced->enabled',	2,	'2022-09-07 14:01:54'),
(3,	'all',	1,	'crmenhanced',	'left',	'crmenhanced',	'crmenhanced_campaigns',	-1,	'crmenhanced',	NULL,	1002,	'/crmenhanced/campaigncard.php',	'',	'Campaigns',	'',	'crmenhanced@crmenhanced',	NULL,	'$user->rights->crmenhanced->readcampaigns',	'$conf->crmenhanced->enabled',	2,	'2022-09-07 14:01:54'),
(4,	'all',	1,	'kanprospects',	'left',	'companies',	'prospects',	-1,	'companies',	'prospects',	100,	'/kanprospects/view/prospects_kb.php',	'',	'Kanprospects_LeftMenu_InOtherModules',	'',	'kanprospects@kanprospects',	NULL,	'',	'$conf->kanprospects->enabled && $conf->societe->enabled',	0,	'2022-09-07 14:01:59'),
(5,	'all',	1,	'modulebuilder',	'left',	'home',	'admintools_modulebuilder',	-1,	'home',	'admintools',	100,	'/modulebuilder/index.php?mainmenu=home&amp;leftmenu=admintools',	'_modulebuilder',	'ModuleBuilder',	'',	'modulebuilder',	NULL,	'1',	'$conf->modulebuilder->enabled && preg_match(\'/^(admintools|all)/\',$leftmenu) && ($user->admin || $conf->global->MODULEBUILDER_FOREVERYONE)',	0,	'2022-09-09 10:20:08'),
(672,	'all',	1,	'stormatic',	'top',	'stormatic',	NULL,	0,	NULL,	NULL,	1001,	'/stormatic/csv_list.php?step=last_import',	'',	'ModuleStormaticName',	'<span class=\"fas fa-file-import paddingright pictofixedwidth valignmiddle\" style=\"\"></span>',	'stormatic@stormatic',	NULL,	'1',	'$conf->stormatic->enabled',	2,	'2022-10-18 13:30:35'),
(673,	'all',	1,	'stormatic',	'left',	'stormatic',	'csv',	-1,	'stormatic',	NULL,	1002,	'/stormatic/index.php',	'',	'IMPORT ABAQUES',	'<span class=\"fas fa-file-import paddingright pictofixedwidth valignmiddle\" style=\"\"></span>',	'stormatic@stormatic',	NULL,	'$user->rights->stormatic->csv->read',	'$conf->stormatic->enabled',	0,	'2022-10-18 13:30:35'),
(674,	'all',	1,	'stormatic',	'left',	'stormatic',	'stormatic_csv_list',	-1,	'stormatic',	'csv',	1003,	'/stormatic/csv_list.php?step=last_import',	'',	'Liste des imports',	'',	'stormatic@stormatic',	NULL,	'$user->rights->stormatic->csv->read',	'$conf->stormatic->enabled',	0,	'2022-10-18 13:30:35'),
(675,	'all',	1,	'stormatic',	'left',	'stormatic',	'stormatic_csv_new',	-1,	'stormatic',	'csv',	1004,	'/stormatic/csv_card.php?step=import&datatoimport=stormatic_1',	'',	'Nouvel import',	'',	'stormatic@stormatic',	NULL,	'$user->rights->stormatic->csv->write',	'$conf->stormatic->enabled',	0,	'2022-10-18 13:30:35');

DROP TABLE IF EXISTS `llx_mrp_mo`;
CREATE TABLE `llx_mrp_mo` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `ref` varchar(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '(PROV)',
  `mrptype` int(11) DEFAULT '0',
  `label` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `qty` double NOT NULL,
  `fk_warehouse` int(11) DEFAULT NULL,
  `fk_soc` int(11) DEFAULT NULL,
  `note_public` text COLLATE utf8_unicode_ci,
  `note_private` text COLLATE utf8_unicode_ci,
  `date_creation` datetime NOT NULL,
  `date_valid` datetime DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_user_creat` int(11) NOT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `fk_user_valid` int(11) DEFAULT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `model_pdf` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` int(11) NOT NULL,
  `fk_product` int(11) NOT NULL,
  `date_start_planned` datetime DEFAULT NULL,
  `date_end_planned` datetime DEFAULT NULL,
  `fk_bom` int(11) DEFAULT NULL,
  `fk_project` int(11) DEFAULT NULL,
  `last_main_doc` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_mrp_mo_ref` (`ref`),
  KEY `idx_mrp_mo_entity` (`entity`),
  KEY `idx_mrp_mo_fk_soc` (`fk_soc`),
  KEY `fk_mrp_mo_fk_user_creat` (`fk_user_creat`),
  KEY `idx_mrp_mo_status` (`status`),
  KEY `idx_mrp_mo_fk_product` (`fk_product`),
  KEY `idx_mrp_mo_date_start_planned` (`date_start_planned`),
  KEY `idx_mrp_mo_date_end_planned` (`date_end_planned`),
  KEY `idx_mrp_mo_fk_bom` (`fk_bom`),
  KEY `idx_mrp_mo_fk_project` (`fk_project`),
  CONSTRAINT `fk_mrp_mo_fk_user_creat` FOREIGN KEY (`fk_user_creat`) REFERENCES `llx_user` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_mrp_mo_extrafields`;
CREATE TABLE `llx_mrp_mo_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_mrp_mo_fk_object` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_mrp_production`;
CREATE TABLE `llx_mrp_production` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_mo` int(11) NOT NULL,
  `origin_id` int(11) DEFAULT NULL,
  `origin_type` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `position` int(11) NOT NULL DEFAULT '0',
  `fk_product` int(11) NOT NULL,
  `fk_warehouse` int(11) DEFAULT NULL,
  `qty` double NOT NULL DEFAULT '1',
  `qty_frozen` smallint(6) DEFAULT '0',
  `disable_stock_change` smallint(6) DEFAULT '0',
  `batch` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `role` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_mrp_production` int(11) DEFAULT NULL,
  `fk_stock_movement` int(11) DEFAULT NULL,
  `date_creation` datetime NOT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_user_creat` int(11) NOT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `fk_mrp_production_product` (`fk_product`),
  KEY `fk_mrp_production_stock_movement` (`fk_stock_movement`),
  KEY `idx_mrp_production_fk_mo` (`fk_mo`),
  CONSTRAINT `fk_mrp_production_mo` FOREIGN KEY (`fk_mo`) REFERENCES `llx_mrp_mo` (`rowid`),
  CONSTRAINT `fk_mrp_production_product` FOREIGN KEY (`fk_product`) REFERENCES `llx_product` (`rowid`),
  CONSTRAINT `fk_mrp_production_stock_movement` FOREIGN KEY (`fk_stock_movement`) REFERENCES `llx_stock_mouvement` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_multicurrency`;
CREATE TABLE `llx_multicurrency` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `date_create` datetime DEFAULT NULL,
  `code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `entity` int(11) DEFAULT '1',
  `fk_user` int(11) DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_multicurrency_rate`;
CREATE TABLE `llx_multicurrency_rate` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `date_sync` datetime DEFAULT NULL,
  `rate` double NOT NULL DEFAULT '0',
  `fk_multicurrency` int(11) NOT NULL,
  `entity` int(11) DEFAULT '1',
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_notify`;
CREATE TABLE `llx_notify` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `daten` datetime DEFAULT NULL,
  `fk_action` int(11) NOT NULL,
  `fk_soc` int(11) DEFAULT NULL,
  `fk_contact` int(11) DEFAULT NULL,
  `fk_user` int(11) DEFAULT NULL,
  `type` varchar(16) COLLATE utf8_unicode_ci DEFAULT 'email',
  `type_target` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  `objet_type` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `objet_id` int(11) NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_notify_def`;
CREATE TABLE `llx_notify_def` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `datec` date DEFAULT NULL,
  `fk_action` int(11) NOT NULL,
  `fk_soc` int(11) DEFAULT NULL,
  `fk_contact` int(11) DEFAULT NULL,
  `fk_user` int(11) DEFAULT NULL,
  `type` varchar(16) COLLATE utf8_unicode_ci DEFAULT 'email',
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_notify_def_object`;
CREATE TABLE `llx_notify_def_object` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `objet_type` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  `objet_id` int(11) NOT NULL,
  `type_notif` varchar(16) COLLATE utf8_unicode_ci DEFAULT 'browser',
  `date_notif` datetime DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `moreparam` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_oauth_state`;
CREATE TABLE `llx_oauth_state` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `service` varchar(36) COLLATE utf8_unicode_ci DEFAULT NULL,
  `state` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_user` int(11) DEFAULT NULL,
  `fk_adherent` int(11) DEFAULT NULL,
  `entity` int(11) DEFAULT '1',
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_oauth_token`;
CREATE TABLE `llx_oauth_token` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `service` varchar(36) COLLATE utf8_unicode_ci DEFAULT NULL,
  `token` text COLLATE utf8_unicode_ci,
  `tokenstring` text COLLATE utf8_unicode_ci,
  `fk_soc` int(11) DEFAULT NULL,
  `fk_user` int(11) DEFAULT NULL,
  `fk_adherent` int(11) DEFAULT NULL,
  `restricted_ips` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `entity` int(11) DEFAULT '1',
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_object_lang`;
CREATE TABLE `llx_object_lang` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_object` int(11) NOT NULL DEFAULT '0',
  `type_object` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `property` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `lang` varchar(5) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `value` text COLLATE utf8_unicode_ci,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_object_lang` (`fk_object`,`type_object`,`property`,`lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_onlinesignature`;
CREATE TABLE `llx_onlinesignature` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `object_type` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `object_id` int(11) NOT NULL,
  `datec` datetime NOT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `ip` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pathoffile` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_opensurvey_comments`;
CREATE TABLE `llx_opensurvey_comments` (
  `id_comment` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_sondage` char(16) COLLATE utf8_unicode_ci NOT NULL,
  `comment` text COLLATE utf8_unicode_ci NOT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `usercomment` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id_comment`),
  KEY `idx_id_comment` (`id_comment`),
  KEY `idx_id_sondage` (`id_sondage`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_opensurvey_formquestions`;
CREATE TABLE `llx_opensurvey_formquestions` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `id_sondage` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  `question` text COLLATE utf8_unicode_ci,
  `available_answers` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_opensurvey_sondage`;
CREATE TABLE `llx_opensurvey_sondage` (
  `id_sondage` varchar(16) COLLATE utf8_unicode_ci NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `commentaires` text COLLATE utf8_unicode_ci,
  `mail_admin` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nom_admin` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_user_creat` int(11) NOT NULL,
  `titre` text COLLATE utf8_unicode_ci NOT NULL,
  `date_fin` datetime DEFAULT NULL,
  `status` int(11) DEFAULT '1',
  `format` varchar(2) COLLATE utf8_unicode_ci NOT NULL,
  `mailsonde` tinyint(4) NOT NULL DEFAULT '0',
  `allow_comments` tinyint(4) NOT NULL DEFAULT '1',
  `allow_spy` tinyint(4) NOT NULL DEFAULT '1',
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `sujet` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id_sondage`),
  KEY `idx_date_fin` (`date_fin`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_opensurvey_user_formanswers`;
CREATE TABLE `llx_opensurvey_user_formanswers` (
  `fk_user_survey` int(11) NOT NULL,
  `fk_question` int(11) NOT NULL,
  `reponses` text COLLATE utf8_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_opensurvey_user_studs`;
CREATE TABLE `llx_opensurvey_user_studs` (
  `id_users` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `id_sondage` varchar(16) COLLATE utf8_unicode_ci NOT NULL,
  `reponses` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_users`),
  KEY `idx_opensurvey_user_studs_id_users` (`id_users`),
  KEY `idx_opensurvey_user_studs_nom` (`nom`),
  KEY `idx_opensurvey_user_studs_id_sondage` (`id_sondage`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_overwrite_trans`;
CREATE TABLE `llx_overwrite_trans` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `lang` varchar(5) COLLATE utf8_unicode_ci DEFAULT NULL,
  `transkey` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `transvalue` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_overwrite_trans` (`lang`,`transkey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_paiement`;
CREATE TABLE `llx_paiement` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `ref` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ref_ext` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `datep` datetime DEFAULT NULL,
  `amount` double(24,8) DEFAULT '0.00000000',
  `multicurrency_amount` double(24,8) DEFAULT '0.00000000',
  `fk_paiement` int(11) NOT NULL,
  `num_paiement` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `note` text COLLATE utf8_unicode_ci,
  `ext_payment_id` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ext_payment_site` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_bank` int(11) NOT NULL DEFAULT '0',
  `fk_user_creat` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `statut` smallint(6) NOT NULL DEFAULT '0',
  `fk_export_compta` int(11) NOT NULL DEFAULT '0',
  `pos_change` double(24,8) DEFAULT '0.00000000',
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_paiementcharge`;
CREATE TABLE `llx_paiementcharge` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_charge` int(11) DEFAULT NULL,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `datep` datetime DEFAULT NULL,
  `amount` double(24,8) DEFAULT '0.00000000',
  `fk_typepaiement` int(11) NOT NULL,
  `num_paiement` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `note` text COLLATE utf8_unicode_ci,
  `fk_bank` int(11) NOT NULL,
  `fk_user_creat` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_paiementfourn`;
CREATE TABLE `llx_paiementfourn` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `ref` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `entity` int(11) DEFAULT '1',
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `datec` datetime DEFAULT NULL,
  `datep` datetime DEFAULT NULL,
  `amount` double(24,8) DEFAULT '0.00000000',
  `multicurrency_amount` double(24,8) DEFAULT '0.00000000',
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `fk_paiement` int(11) NOT NULL,
  `num_paiement` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `note` text COLLATE utf8_unicode_ci,
  `fk_bank` int(11) NOT NULL,
  `statut` smallint(6) NOT NULL DEFAULT '0',
  `model_pdf` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_paiementfourn_facturefourn`;
CREATE TABLE `llx_paiementfourn_facturefourn` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_paiementfourn` int(11) DEFAULT NULL,
  `fk_facturefourn` int(11) DEFAULT NULL,
  `amount` double(24,8) DEFAULT '0.00000000',
  `multicurrency_code` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `multicurrency_tx` double(24,8) DEFAULT '1.00000000',
  `multicurrency_amount` double(24,8) DEFAULT '0.00000000',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_paiementfourn_facturefourn` (`fk_paiementfourn`,`fk_facturefourn`),
  KEY `idx_paiementfourn_facturefourn_fk_facture` (`fk_facturefourn`),
  KEY `idx_paiementfourn_facturefourn_fk_paiement` (`fk_paiementfourn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_paiement_facture`;
CREATE TABLE `llx_paiement_facture` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_paiement` int(11) DEFAULT NULL,
  `fk_facture` int(11) DEFAULT NULL,
  `amount` double(24,8) DEFAULT '0.00000000',
  `multicurrency_code` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `multicurrency_tx` double(24,8) DEFAULT '1.00000000',
  `multicurrency_amount` double(24,8) DEFAULT '0.00000000',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_paiement_facture` (`fk_paiement`,`fk_facture`),
  KEY `idx_paiement_facture_fk_facture` (`fk_facture`),
  KEY `idx_paiement_facture_fk_paiement` (`fk_paiement`),
  CONSTRAINT `fk_paiement_facture_fk_facture` FOREIGN KEY (`fk_facture`) REFERENCES `llx_facture` (`rowid`),
  CONSTRAINT `fk_paiement_facture_fk_paiement` FOREIGN KEY (`fk_paiement`) REFERENCES `llx_paiement` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_partnership`;
CREATE TABLE `llx_partnership` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `ref` varchar(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '(PROV)',
  `status` smallint(6) NOT NULL DEFAULT '0',
  `fk_type` int(11) NOT NULL DEFAULT '0',
  `fk_soc` int(11) DEFAULT NULL,
  `fk_member` int(11) DEFAULT NULL,
  `date_partnership_start` date NOT NULL,
  `date_partnership_end` date DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `reason_decline_or_cancel` text COLLATE utf8_unicode_ci,
  `date_creation` datetime NOT NULL,
  `fk_user_creat` int(11) NOT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_user_modif` int(11) DEFAULT NULL,
  `note_private` text COLLATE utf8_unicode_ci,
  `note_public` text COLLATE utf8_unicode_ci,
  `last_main_doc` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `count_last_url_check_error` int(11) DEFAULT '0',
  `last_check_backlink` datetime DEFAULT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `model_pdf` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_partnership_ref` (`ref`,`entity`),
  UNIQUE KEY `uk_fk_type_fk_soc` (`fk_type`,`fk_soc`,`date_partnership_start`),
  UNIQUE KEY `uk_fk_type_fk_member` (`fk_type`,`fk_member`,`date_partnership_start`),
  KEY `idx_partnership_entity` (`entity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_partnership_extrafields`;
CREATE TABLE `llx_partnership_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_partnership_extrafields` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_payment_donation`;
CREATE TABLE `llx_payment_donation` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_donation` int(11) DEFAULT NULL,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `datep` datetime DEFAULT NULL,
  `amount` double(24,8) DEFAULT '0.00000000',
  `fk_typepayment` int(11) NOT NULL,
  `num_payment` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `note` text COLLATE utf8_unicode_ci,
  `ext_payment_id` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ext_payment_site` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_bank` int(11) NOT NULL,
  `fk_user_creat` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_payment_expensereport`;
CREATE TABLE `llx_payment_expensereport` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_expensereport` int(11) DEFAULT NULL,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `datep` datetime DEFAULT NULL,
  `amount` double(24,8) DEFAULT '0.00000000',
  `fk_typepayment` int(11) NOT NULL,
  `num_payment` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `note` text COLLATE utf8_unicode_ci,
  `fk_bank` int(11) NOT NULL,
  `fk_user_creat` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_payment_loan`;
CREATE TABLE `llx_payment_loan` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_loan` int(11) DEFAULT NULL,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `datep` datetime DEFAULT NULL,
  `amount_capital` double(24,8) DEFAULT '0.00000000',
  `amount_insurance` double(24,8) DEFAULT '0.00000000',
  `amount_interest` double(24,8) DEFAULT '0.00000000',
  `fk_typepayment` int(11) NOT NULL,
  `num_payment` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `note_private` text COLLATE utf8_unicode_ci,
  `note_public` text COLLATE utf8_unicode_ci,
  `fk_bank` int(11) NOT NULL,
  `fk_user_creat` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_payment_salary`;
CREATE TABLE `llx_payment_salary` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `ref` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `datec` datetime DEFAULT NULL,
  `fk_user` int(11) DEFAULT NULL,
  `datep` date DEFAULT NULL,
  `datev` date DEFAULT NULL,
  `salary` double(24,8) DEFAULT NULL,
  `amount` double(24,8) NOT NULL DEFAULT '0.00000000',
  `fk_projet` int(11) DEFAULT NULL,
  `fk_typepayment` int(11) NOT NULL,
  `num_payment` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `label` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `datesp` date DEFAULT NULL,
  `dateep` date DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `note` text COLLATE utf8_unicode_ci,
  `fk_bank` int(11) DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `fk_salary` int(11) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_payment_salary_ref` (`num_payment`),
  KEY `idx_payment_salary_user` (`fk_user`,`entity`),
  KEY `idx_payment_salary_datep` (`datep`),
  KEY `idx_payment_salary_datesp` (`datesp`),
  KEY `idx_payment_salary_dateep` (`dateep`),
  CONSTRAINT `fk_payment_salary_user` FOREIGN KEY (`fk_user`) REFERENCES `llx_user` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_payment_various`;
CREATE TABLE `llx_payment_various` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `ref` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `num_payment` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `label` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `datec` datetime DEFAULT NULL,
  `datep` date DEFAULT NULL,
  `datev` date DEFAULT NULL,
  `sens` smallint(6) NOT NULL DEFAULT '0',
  `amount` double(24,8) NOT NULL DEFAULT '0.00000000',
  `fk_typepayment` int(11) NOT NULL,
  `accountancy_code` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `subledger_account` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_projet` int(11) DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `note` text COLLATE utf8_unicode_ci,
  `fk_bank` int(11) DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_payment_vat`;
CREATE TABLE `llx_payment_vat` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_tva` int(11) DEFAULT NULL,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `datep` datetime DEFAULT NULL,
  `amount` double(24,8) DEFAULT '0.00000000',
  `fk_typepaiement` int(11) NOT NULL,
  `num_paiement` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `note` text COLLATE utf8_unicode_ci,
  `fk_bank` int(11) NOT NULL,
  `fk_user_creat` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_pos_cash_fence`;
CREATE TABLE `llx_pos_cash_fence` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `ref` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `label` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `opening` double(24,8) DEFAULT '0.00000000',
  `cash` double(24,8) DEFAULT '0.00000000',
  `card` double(24,8) DEFAULT '0.00000000',
  `cheque` double(24,8) DEFAULT '0.00000000',
  `status` int(11) DEFAULT NULL,
  `date_creation` datetime NOT NULL,
  `date_valid` datetime DEFAULT NULL,
  `day_close` int(11) DEFAULT NULL,
  `month_close` int(11) DEFAULT NULL,
  `year_close` int(11) DEFAULT NULL,
  `posmodule` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `posnumber` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_user_creat` int(11) DEFAULT NULL,
  `fk_user_valid` int(11) DEFAULT NULL,
  `tms` timestamp NULL DEFAULT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_prelevement_bons`;
CREATE TABLE `llx_prelevement_bons` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(16) COLLATE utf8_unicode_ci DEFAULT 'debit-order',
  `ref` varchar(12) COLLATE utf8_unicode_ci DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `datec` datetime DEFAULT NULL,
  `amount` double(24,8) DEFAULT '0.00000000',
  `statut` smallint(6) DEFAULT '0',
  `credite` smallint(6) DEFAULT '0',
  `note` text COLLATE utf8_unicode_ci,
  `date_trans` datetime DEFAULT NULL,
  `method_trans` smallint(6) DEFAULT NULL,
  `fk_user_trans` int(11) DEFAULT NULL,
  `date_credit` datetime DEFAULT NULL,
  `fk_user_credit` int(11) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_prelevement_bons_ref` (`ref`,`entity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_prelevement_facture`;
CREATE TABLE `llx_prelevement_facture` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_facture` int(11) DEFAULT NULL,
  `fk_facture_fourn` int(11) DEFAULT NULL,
  `fk_prelevement_lignes` int(11) NOT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_prelevement_facture_fk_prelevement_lignes` (`fk_prelevement_lignes`),
  CONSTRAINT `fk_prelevement_facture_fk_prelevement_lignes` FOREIGN KEY (`fk_prelevement_lignes`) REFERENCES `llx_prelevement_lignes` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_prelevement_facture_demande`;
CREATE TABLE `llx_prelevement_facture_demande` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `fk_facture` int(11) DEFAULT NULL,
  `fk_facture_fourn` int(11) DEFAULT NULL,
  `sourcetype` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `amount` double(24,8) NOT NULL,
  `date_demande` datetime NOT NULL,
  `traite` smallint(6) DEFAULT '0',
  `date_traite` datetime DEFAULT NULL,
  `fk_prelevement_bons` int(11) DEFAULT NULL,
  `fk_user_demande` int(11) NOT NULL,
  `code_banque` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `code_guichet` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cle_rib` varchar(5) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ext_payment_id` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ext_payment_site` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_prelevement_facture_demande_fk_facture` (`fk_facture`),
  KEY `idx_prelevement_facture_demande_fk_facture_fourn` (`fk_facture_fourn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_prelevement_lignes`;
CREATE TABLE `llx_prelevement_lignes` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_prelevement_bons` int(11) DEFAULT NULL,
  `fk_soc` int(11) NOT NULL,
  `statut` smallint(6) DEFAULT '0',
  `client_nom` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `amount` double(24,8) DEFAULT '0.00000000',
  `code_banque` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `code_guichet` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cle_rib` varchar(5) COLLATE utf8_unicode_ci DEFAULT NULL,
  `note` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`rowid`),
  KEY `idx_prelevement_lignes_fk_prelevement_bons` (`fk_prelevement_bons`),
  CONSTRAINT `fk_prelevement_lignes_fk_prelevement_bons` FOREIGN KEY (`fk_prelevement_bons`) REFERENCES `llx_prelevement_bons` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_prelevement_rejet`;
CREATE TABLE `llx_prelevement_rejet` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_prelevement_lignes` int(11) DEFAULT NULL,
  `date_rejet` datetime DEFAULT NULL,
  `motif` int(11) DEFAULT NULL,
  `date_creation` datetime DEFAULT NULL,
  `fk_user_creation` int(11) DEFAULT NULL,
  `note` text COLLATE utf8_unicode_ci,
  `afacturer` tinyint(4) DEFAULT '0',
  `fk_facture` int(11) DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_printing`;
CREATE TABLE `llx_printing` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `datec` datetime DEFAULT NULL,
  `printer_name` text COLLATE utf8_unicode_ci NOT NULL,
  `printer_location` text COLLATE utf8_unicode_ci NOT NULL,
  `printer_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `copy` int(11) NOT NULL DEFAULT '1',
  `module` varchar(16) COLLATE utf8_unicode_ci NOT NULL,
  `driver` varchar(16) COLLATE utf8_unicode_ci NOT NULL,
  `userid` int(11) DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_product`;
CREATE TABLE `llx_product` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `ref` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `ref_ext` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_parent` int(11) DEFAULT '0',
  `label` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `note_public` text COLLATE utf8_unicode_ci,
  `note` text COLLATE utf8_unicode_ci,
  `customcode` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_country` int(11) DEFAULT NULL,
  `fk_state` int(11) DEFAULT NULL,
  `price` double(24,8) DEFAULT '0.00000000',
  `price_ttc` double(24,8) DEFAULT '0.00000000',
  `price_min` double(24,8) DEFAULT '0.00000000',
  `price_min_ttc` double(24,8) DEFAULT '0.00000000',
  `price_base_type` varchar(3) COLLATE utf8_unicode_ci DEFAULT 'HT',
  `cost_price` double(24,8) DEFAULT NULL,
  `default_vat_code` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tva_tx` double(7,4) DEFAULT NULL,
  `recuperableonly` int(11) NOT NULL DEFAULT '0',
  `localtax1_tx` double(7,4) DEFAULT '0.0000',
  `localtax1_type` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `localtax2_tx` double(7,4) DEFAULT '0.0000',
  `localtax2_type` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `tosell` tinyint(4) DEFAULT '1',
  `tobuy` tinyint(4) DEFAULT '1',
  `onportal` tinyint(4) DEFAULT '0',
  `tobatch` tinyint(4) NOT NULL DEFAULT '0',
  `batch_mask` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_product_type` int(11) DEFAULT '0',
  `duration` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `seuil_stock_alerte` float DEFAULT NULL,
  `url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `barcode` varchar(180) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_barcode_type` int(11) DEFAULT NULL,
  `accountancy_code_sell` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `accountancy_code_sell_intra` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `accountancy_code_sell_export` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `accountancy_code_buy` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `accountancy_code_buy_intra` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `accountancy_code_buy_export` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `partnumber` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `net_measure` float DEFAULT NULL,
  `net_measure_units` tinyint(4) DEFAULT NULL,
  `weight` float DEFAULT NULL,
  `weight_units` tinyint(4) DEFAULT NULL,
  `length` float DEFAULT NULL,
  `length_units` tinyint(4) DEFAULT NULL,
  `width` float DEFAULT NULL,
  `width_units` tinyint(4) DEFAULT NULL,
  `height` float DEFAULT NULL,
  `height_units` tinyint(4) DEFAULT NULL,
  `surface` float DEFAULT NULL,
  `surface_units` tinyint(4) DEFAULT NULL,
  `volume` float DEFAULT NULL,
  `volume_units` tinyint(4) DEFAULT NULL,
  `stock` double DEFAULT NULL,
  `pmp` double(24,8) NOT NULL DEFAULT '0.00000000',
  `fifo` double(24,8) DEFAULT NULL,
  `lifo` double(24,8) DEFAULT NULL,
  `fk_default_warehouse` int(11) DEFAULT NULL,
  `canvas` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `finished` tinyint(4) DEFAULT NULL,
  `lifetime` int(11) DEFAULT NULL,
  `qc_frequency` int(11) DEFAULT NULL,
  `hidden` tinyint(4) DEFAULT '0',
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `model_pdf` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_price_expression` int(11) DEFAULT NULL,
  `desiredstock` float DEFAULT '0',
  `fk_unit` int(11) DEFAULT NULL,
  `price_autogen` tinyint(4) DEFAULT '0',
  `fk_project` int(11) DEFAULT NULL,
  `mandatory_period` tinyint(4) DEFAULT '0',
  `fk_default_bom` int(11) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_product_ref` (`ref`,`entity`),
  UNIQUE KEY `uk_product_barcode` (`barcode`,`fk_barcode_type`,`entity`),
  KEY `idx_product_label` (`label`),
  KEY `idx_product_barcode` (`barcode`),
  KEY `idx_product_import_key` (`import_key`),
  KEY `idx_product_seuil_stock_alerte` (`seuil_stock_alerte`),
  KEY `idx_product_fk_country` (`fk_country`),
  KEY `idx_product_fk_user_author` (`fk_user_author`),
  KEY `idx_product_fk_barcode_type` (`fk_barcode_type`),
  KEY `idx_product_fk_project` (`fk_project`),
  KEY `fk_product_fk_unit` (`fk_unit`),
  KEY `fk_product_finished` (`finished`),
  KEY `fk_product_default_warehouse` (`fk_default_warehouse`),
  CONSTRAINT `fk_product_barcode_type` FOREIGN KEY (`fk_barcode_type`) REFERENCES `llx_c_barcode_type` (`rowid`),
  CONSTRAINT `fk_product_default_warehouse` FOREIGN KEY (`fk_default_warehouse`) REFERENCES `llx_entrepot` (`rowid`),
  CONSTRAINT `fk_product_finished` FOREIGN KEY (`finished`) REFERENCES `llx_c_product_nature` (`code`),
  CONSTRAINT `fk_product_fk_country` FOREIGN KEY (`fk_country`) REFERENCES `llx_c_country` (`rowid`),
  CONSTRAINT `fk_product_fk_unit` FOREIGN KEY (`fk_unit`) REFERENCES `llx_c_units` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_product` (`rowid`, `ref`, `entity`, `ref_ext`, `datec`, `tms`, `fk_parent`, `label`, `description`, `note_public`, `note`, `customcode`, `fk_country`, `fk_state`, `price`, `price_ttc`, `price_min`, `price_min_ttc`, `price_base_type`, `cost_price`, `default_vat_code`, `tva_tx`, `recuperableonly`, `localtax1_tx`, `localtax1_type`, `localtax2_tx`, `localtax2_type`, `fk_user_author`, `fk_user_modif`, `tosell`, `tobuy`, `onportal`, `tobatch`, `batch_mask`, `fk_product_type`, `duration`, `seuil_stock_alerte`, `url`, `barcode`, `fk_barcode_type`, `accountancy_code_sell`, `accountancy_code_sell_intra`, `accountancy_code_sell_export`, `accountancy_code_buy`, `accountancy_code_buy_intra`, `accountancy_code_buy_export`, `partnumber`, `net_measure`, `net_measure_units`, `weight`, `weight_units`, `length`, `length_units`, `width`, `width_units`, `height`, `height_units`, `surface`, `surface_units`, `volume`, `volume_units`, `stock`, `pmp`, `fifo`, `lifo`, `fk_default_warehouse`, `canvas`, `finished`, `lifetime`, `qc_frequency`, `hidden`, `import_key`, `model_pdf`, `fk_price_expression`, `desiredstock`, `fk_unit`, `price_autogen`, `fk_project`, `mandatory_period`, `fk_default_bom`) VALUES
(355,	'Product1',	1,	NULL,	'2022-10-18 17:09:29',	'2022-10-18 15:09:29',	0,	'Produit1',	'',	NULL,	NULL,	'',	NULL,	NULL,	400.00000000,	400.00000000,	0.00000000,	0.00000000,	'HT',	NULL,	NULL,	0.0000,	0,	0.0000,	'0',	0.0000,	'0',	1,	1,	1,	1,	0,	0,	'',	0,	'',	0,	NULL,	NULL,	NULL,	'',	'',	'',	'',	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0.00000000,	NULL,	NULL,	NULL,	'',	NULL,	NULL,	NULL,	0,	NULL,	NULL,	NULL,	0,	NULL,	0,	NULL,	0,	NULL),
(356,	'test-produit',	1,	NULL,	'2022-10-18 17:09:29',	'2022-10-19 10:50:58',	0,	'Test Produit',	'',	NULL,	NULL,	'',	NULL,	NULL,	1500.00000000,	1500.00000000,	0.00000000,	0.00000000,	'HT',	NULL,	NULL,	0.0000,	0,	0.0000,	'0',	0.0000,	'0',	1,	1,	1,	1,	0,	0,	'',	0,	'',	0,	NULL,	NULL,	NULL,	'',	'',	'',	'',	'',	'',	NULL,	NULL,	NULL,	NULL,	3,	NULL,	0,	NULL,	0,	NULL,	0,	NULL,	0,	NULL,	0,	NULL,	0.00000000,	NULL,	NULL,	NULL,	'',	NULL,	NULL,	NULL,	0,	NULL,	NULL,	NULL,	0,	NULL,	0,	NULL,	0,	NULL);

DROP TABLE IF EXISTS `llx_product_association`;
CREATE TABLE `llx_product_association` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_product_pere` int(11) NOT NULL DEFAULT '0',
  `fk_product_fils` int(11) NOT NULL DEFAULT '0',
  `qty` double DEFAULT NULL,
  `incdec` int(11) DEFAULT '1',
  `rang` int(11) DEFAULT '0',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_product_association` (`fk_product_pere`,`fk_product_fils`),
  KEY `idx_product_association_fils` (`fk_product_fils`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_product_attribute`;
CREATE TABLE `llx_product_attribute` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `ref` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `ref_ext` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `label` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `rang` int(11) NOT NULL DEFAULT '0',
  `entity` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_product_attribute_ref` (`ref`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_product_attribute` (`rowid`, `ref`, `ref_ext`, `label`, `rang`, `entity`) VALUES
(1,	'COUL',	'',	'Taille',	0,	1);

DROP TABLE IF EXISTS `llx_product_attribute_combination`;
CREATE TABLE `llx_product_attribute_combination` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_product_parent` int(11) NOT NULL,
  `fk_product_child` int(11) NOT NULL,
  `variation_price` double(24,8) NOT NULL,
  `variation_price_percentage` int(11) DEFAULT NULL,
  `variation_weight` double NOT NULL,
  `variation_ref_ext` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`rowid`),
  KEY `idx_product_att_com_product_parent` (`fk_product_parent`),
  KEY `idx_product_att_com_product_child` (`fk_product_child`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_product_attribute_combination2val`;
CREATE TABLE `llx_product_attribute_combination2val` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_prod_combination` int(11) NOT NULL,
  `fk_prod_attr` int(11) NOT NULL,
  `fk_prod_attr_val` int(11) NOT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_product_attribute_combination_price_level`;
CREATE TABLE `llx_product_attribute_combination_price_level` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_product_attribute_combination` int(11) NOT NULL DEFAULT '1',
  `fk_price_level` int(11) NOT NULL DEFAULT '1',
  `variation_price` double(24,8) NOT NULL,
  `variation_price_percentage` int(11) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `fk_product_attribute_combination` (`fk_product_attribute_combination`,`fk_price_level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_product_attribute_value`;
CREATE TABLE `llx_product_attribute_value` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_product_attribute` int(11) NOT NULL,
  `ref` varchar(180) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_product_attribute_value` (`fk_product_attribute`,`ref`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_product_attribute_value` (`rowid`, `fk_product_attribute`, `ref`, `value`, `entity`) VALUES
(1,	1,	'10',	'10',	1),
(2,	1,	'S',	'Small',	1),
(3,	1,	'20',	'20',	1),
(4,	1,	'XL',	'Large',	1);

DROP TABLE IF EXISTS `llx_product_batch`;
CREATE TABLE `llx_product_batch` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_product_stock` int(11) NOT NULL,
  `eatby` datetime DEFAULT NULL,
  `sellby` datetime DEFAULT NULL,
  `batch` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `qty` double NOT NULL DEFAULT '0',
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_product_batch` (`fk_product_stock`,`batch`),
  KEY `idx_fk_product_stock` (`fk_product_stock`),
  KEY `idx_batch` (`batch`),
  CONSTRAINT `fk_product_batch_fk_product_stock` FOREIGN KEY (`fk_product_stock`) REFERENCES `llx_product_stock` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_product_customer_price`;
CREATE TABLE `llx_product_customer_price` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_product` int(11) NOT NULL,
  `fk_soc` int(11) NOT NULL,
  `ref_customer` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `price` double(24,8) DEFAULT '0.00000000',
  `price_ttc` double(24,8) DEFAULT '0.00000000',
  `price_min` double(24,8) DEFAULT '0.00000000',
  `price_min_ttc` double(24,8) DEFAULT '0.00000000',
  `price_base_type` varchar(3) COLLATE utf8_unicode_ci DEFAULT 'HT',
  `default_vat_code` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tva_tx` double(7,4) DEFAULT NULL,
  `recuperableonly` int(11) NOT NULL DEFAULT '0',
  `localtax1_tx` double(7,4) DEFAULT '0.0000',
  `localtax1_type` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `localtax2_tx` double(7,4) DEFAULT '0.0000',
  `localtax2_type` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `fk_user` int(11) DEFAULT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_customer_price_fk_product_fk_soc` (`fk_product`,`fk_soc`),
  KEY `idx_product_customer_price_fk_user` (`fk_user`),
  KEY `idx_product_customer_price_fk_soc` (`fk_soc`),
  CONSTRAINT `fk_product_customer_price_fk_product` FOREIGN KEY (`fk_product`) REFERENCES `llx_product` (`rowid`),
  CONSTRAINT `fk_product_customer_price_fk_soc` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`),
  CONSTRAINT `fk_product_customer_price_fk_user` FOREIGN KEY (`fk_user`) REFERENCES `llx_user` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_product_customer_price_log`;
CREATE TABLE `llx_product_customer_price_log` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `datec` datetime DEFAULT NULL,
  `fk_product` int(11) NOT NULL,
  `fk_soc` int(11) NOT NULL DEFAULT '0',
  `ref_customer` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `price` double(24,8) DEFAULT '0.00000000',
  `price_ttc` double(24,8) DEFAULT '0.00000000',
  `price_min` double(24,8) DEFAULT '0.00000000',
  `price_min_ttc` double(24,8) DEFAULT '0.00000000',
  `price_base_type` varchar(3) COLLATE utf8_unicode_ci DEFAULT 'HT',
  `default_vat_code` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tva_tx` double(7,4) DEFAULT NULL,
  `recuperableonly` int(11) NOT NULL DEFAULT '0',
  `localtax1_tx` double(7,4) DEFAULT '0.0000',
  `localtax1_type` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `localtax2_tx` double(7,4) DEFAULT '0.0000',
  `localtax2_type` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `fk_user` int(11) DEFAULT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_product_extrafields`;
CREATE TABLE `llx_product_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `chaine` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_product_extrafields` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_product_extrafields` (`rowid`, `tms`, `fk_object`, `import_key`, `chaine`) VALUES
(26,	'2022-10-19 11:19:23',	356,	NULL,	NULL);

DROP TABLE IF EXISTS `llx_product_fournisseur_price`;
CREATE TABLE `llx_product_fournisseur_price` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_product` int(11) DEFAULT NULL,
  `fk_soc` int(11) DEFAULT NULL,
  `ref_fourn` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `desc_fourn` text COLLATE utf8_unicode_ci,
  `fk_availability` int(11) DEFAULT NULL,
  `price` double(24,8) DEFAULT '0.00000000',
  `quantity` double DEFAULT NULL,
  `remise_percent` double NOT NULL DEFAULT '0',
  `remise` double NOT NULL DEFAULT '0',
  `unitprice` double(24,8) DEFAULT '0.00000000',
  `charges` double(24,8) DEFAULT '0.00000000',
  `default_vat_code` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `barcode` varchar(180) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_barcode_type` int(11) DEFAULT NULL,
  `tva_tx` double(7,4) NOT NULL,
  `localtax1_tx` double(7,4) DEFAULT '0.0000',
  `localtax1_type` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `localtax2_tx` double(7,4) DEFAULT '0.0000',
  `localtax2_type` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `info_bits` int(11) NOT NULL DEFAULT '0',
  `fk_user` int(11) DEFAULT NULL,
  `fk_supplier_price_expression` int(11) DEFAULT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `delivery_time_days` int(11) DEFAULT NULL,
  `supplier_reputation` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `packaging` double DEFAULT NULL,
  `fk_multicurrency` int(11) DEFAULT NULL,
  `multicurrency_code` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `multicurrency_tx` double(24,8) DEFAULT '1.00000000',
  `multicurrency_unitprice` double(24,8) DEFAULT NULL,
  `multicurrency_price` double(24,8) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_product_fournisseur_price_ref` (`ref_fourn`,`fk_soc`,`quantity`,`entity`),
  UNIQUE KEY `uk_product_barcode` (`barcode`,`fk_barcode_type`,`entity`),
  KEY `idx_product_fournisseur_price_fk_user` (`fk_user`),
  KEY `idx_product_fourn_price_fk_product` (`fk_product`,`entity`),
  KEY `idx_product_fourn_price_fk_soc` (`fk_soc`,`entity`),
  KEY `idx_product_barcode` (`barcode`),
  KEY `idx_product_fk_barcode_type` (`fk_barcode_type`),
  CONSTRAINT `fk_product_fournisseur_price_barcode_type` FOREIGN KEY (`fk_barcode_type`) REFERENCES `llx_c_barcode_type` (`rowid`),
  CONSTRAINT `fk_product_fournisseur_price_fk_product` FOREIGN KEY (`fk_product`) REFERENCES `llx_product` (`rowid`),
  CONSTRAINT `fk_product_fournisseur_price_fk_user` FOREIGN KEY (`fk_user`) REFERENCES `llx_user` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_product_fournisseur_price_extrafields`;
CREATE TABLE `llx_product_fournisseur_price_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_product_fournisseur_price_extrafields` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_product_fournisseur_price_log`;
CREATE TABLE `llx_product_fournisseur_price_log` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `datec` datetime DEFAULT NULL,
  `fk_product_fournisseur` int(11) NOT NULL,
  `price` double(24,8) DEFAULT '0.00000000',
  `quantity` double DEFAULT NULL,
  `fk_user` int(11) DEFAULT NULL,
  `fk_multicurrency` int(11) DEFAULT NULL,
  `multicurrency_code` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `multicurrency_tx` double(24,8) DEFAULT '1.00000000',
  `multicurrency_unitprice` double(24,8) DEFAULT NULL,
  `multicurrency_price` double(24,8) DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_product_fournisseur_price_log` (`rowid`, `datec`, `fk_product_fournisseur`, `price`, `quantity`, `fk_user`, `fk_multicurrency`, `multicurrency_code`, `multicurrency_tx`, `multicurrency_unitprice`, `multicurrency_price`) VALUES
(1,	'2022-10-11 17:54:20',	1,	15.00000000,	1,	1,	NULL,	'',	1.00000000,	NULL,	0.00000000),
(2,	'2022-10-11 17:55:14',	1,	15.00000000,	1,	1,	NULL,	'',	1.00000000,	NULL,	0.00000000);

DROP TABLE IF EXISTS `llx_product_lang`;
CREATE TABLE `llx_product_lang` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_product` int(11) NOT NULL DEFAULT '0',
  `lang` varchar(5) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `label` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `note` text COLLATE utf8_unicode_ci,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_product_lang` (`fk_product`,`lang`),
  CONSTRAINT `fk_product_lang_fk_product` FOREIGN KEY (`fk_product`) REFERENCES `llx_product` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_product_lot`;
CREATE TABLE `llx_product_lot` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) DEFAULT '1',
  `fk_product` int(11) NOT NULL,
  `batch` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `eatby` date DEFAULT NULL,
  `sellby` date DEFAULT NULL,
  `eol_date` datetime DEFAULT NULL,
  `manufacturing_date` datetime DEFAULT NULL,
  `scrapping_date` datetime DEFAULT NULL,
  `barcode` varchar(180) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_barcode_type` int(11) DEFAULT NULL,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_user_creat` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `import_key` int(11) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_product_lot` (`fk_product`,`batch`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_product_lot_extrafields`;
CREATE TABLE `llx_product_lot_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_product_lot_extrafields` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_product_perentity`;
CREATE TABLE `llx_product_perentity` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_product` int(11) DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `accountancy_code_sell` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `accountancy_code_sell_intra` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `accountancy_code_sell_export` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `accountancy_code_buy` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `accountancy_code_buy_intra` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `accountancy_code_buy_export` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pmp` double(24,8) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_product_perentity` (`fk_product`,`entity`),
  KEY `idx_product_perentity_fk_product` (`fk_product`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_product_price`;
CREATE TABLE `llx_product_price` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_product` int(11) NOT NULL,
  `date_price` datetime NOT NULL,
  `price_level` smallint(6) DEFAULT '1',
  `price` double(24,8) DEFAULT NULL,
  `price_ttc` double(24,8) DEFAULT NULL,
  `price_min` double(24,8) DEFAULT NULL,
  `price_min_ttc` double(24,8) DEFAULT NULL,
  `price_base_type` varchar(3) COLLATE utf8_unicode_ci DEFAULT 'HT',
  `default_vat_code` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tva_tx` double(7,4) NOT NULL DEFAULT '0.0000',
  `recuperableonly` int(11) NOT NULL DEFAULT '0',
  `localtax1_tx` double(7,4) DEFAULT '0.0000',
  `localtax1_type` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `localtax2_tx` double(7,4) DEFAULT '0.0000',
  `localtax2_type` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `fk_user_author` int(11) DEFAULT NULL,
  `tosell` tinyint(4) DEFAULT '1',
  `price_by_qty` int(11) NOT NULL DEFAULT '0',
  `fk_price_expression` int(11) DEFAULT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_multicurrency` int(11) DEFAULT NULL,
  `multicurrency_code` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `multicurrency_tx` double(24,8) DEFAULT '1.00000000',
  `multicurrency_price` double(24,8) DEFAULT NULL,
  `multicurrency_price_ttc` double(24,8) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_product_price_fk_user_author` (`fk_user_author`),
  KEY `idx_product_price_fk_product` (`fk_product`),
  CONSTRAINT `fk_product_price_product` FOREIGN KEY (`fk_user_author`) REFERENCES `llx_user` (`rowid`),
  CONSTRAINT `fk_product_price_user_author` FOREIGN KEY (`fk_product`) REFERENCES `llx_product` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_product_price` (`rowid`, `entity`, `tms`, `fk_product`, `date_price`, `price_level`, `price`, `price_ttc`, `price_min`, `price_min_ttc`, `price_base_type`, `default_vat_code`, `tva_tx`, `recuperableonly`, `localtax1_tx`, `localtax1_type`, `localtax2_tx`, `localtax2_type`, `fk_user_author`, `tosell`, `price_by_qty`, `fk_price_expression`, `import_key`, `fk_multicurrency`, `multicurrency_code`, `multicurrency_tx`, `multicurrency_price`, `multicurrency_price_ttc`) VALUES
(694,	1,	'2022-10-18 15:09:29',	355,	'2022-10-18 17:09:29',	1,	0.00000000,	0.00000000,	0.00000000,	0.00000000,	'',	NULL,	0.0000,	0,	0.0000,	'0',	0.0000,	'0',	1,	1,	0,	NULL,	NULL,	NULL,	NULL,	1.00000000,	NULL,	NULL),
(695,	1,	'2022-10-18 15:09:29',	356,	'2022-10-18 17:09:29',	1,	0.00000000,	0.00000000,	0.00000000,	0.00000000,	'',	NULL,	0.0000,	0,	0.0000,	'0',	0.0000,	'0',	1,	1,	0,	NULL,	NULL,	NULL,	NULL,	1.00000000,	NULL,	NULL),
(696,	1,	'2022-10-18 15:09:29',	355,	'2022-10-18 17:09:29',	1,	400.00000000,	400.00000000,	0.00000000,	0.00000000,	'HT',	NULL,	0.0000,	0,	0.0000,	'0',	0.0000,	'0',	1,	0,	0,	NULL,	NULL,	NULL,	NULL,	1.00000000,	NULL,	NULL),
(697,	1,	'2022-10-18 15:09:29',	355,	'2022-10-18 17:09:29',	1,	400.00000000,	400.00000000,	0.00000000,	0.00000000,	'HT',	NULL,	0.0000,	0,	0.0000,	'0',	0.0000,	'0',	1,	0,	0,	NULL,	NULL,	NULL,	NULL,	1.00000000,	NULL,	NULL),
(698,	1,	'2022-10-18 15:09:29',	355,	'2022-10-18 17:09:29',	1,	400.00000000,	400.00000000,	0.00000000,	0.00000000,	'HT',	NULL,	0.0000,	0,	0.0000,	'0',	0.0000,	'0',	1,	0,	0,	NULL,	NULL,	NULL,	NULL,	1.00000000,	NULL,	NULL),
(699,	1,	'2022-10-18 15:09:29',	355,	'2022-10-18 17:09:29',	1,	400.00000000,	400.00000000,	0.00000000,	0.00000000,	'HT',	NULL,	0.0000,	0,	0.0000,	'0',	0.0000,	'0',	1,	0,	0,	NULL,	NULL,	NULL,	NULL,	1.00000000,	NULL,	NULL),
(700,	1,	'2022-10-18 15:09:30',	355,	'2022-10-18 17:09:30',	1,	400.00000000,	400.00000000,	0.00000000,	0.00000000,	'HT',	NULL,	0.0000,	0,	0.0000,	'0',	0.0000,	'0',	1,	0,	0,	NULL,	NULL,	NULL,	NULL,	1.00000000,	NULL,	NULL),
(701,	1,	'2022-10-18 15:09:30',	356,	'2022-10-18 17:09:30',	1,	1500.00000000,	1500.00000000,	0.00000000,	0.00000000,	'HT',	NULL,	0.0000,	0,	0.0000,	'0',	0.0000,	'0',	1,	0,	0,	NULL,	NULL,	NULL,	NULL,	1.00000000,	NULL,	NULL),
(702,	1,	'2022-10-18 15:09:30',	356,	'2022-10-18 17:09:30',	1,	1500.00000000,	1500.00000000,	0.00000000,	0.00000000,	'HT',	NULL,	0.0000,	0,	0.0000,	'0',	0.0000,	'0',	1,	0,	0,	NULL,	NULL,	NULL,	NULL,	1.00000000,	NULL,	NULL),
(703,	1,	'2022-10-18 15:09:30',	356,	'2022-10-18 17:09:30',	1,	1500.00000000,	1500.00000000,	0.00000000,	0.00000000,	'HT',	NULL,	0.0000,	0,	0.0000,	'0',	0.0000,	'0',	1,	0,	0,	NULL,	NULL,	NULL,	NULL,	1.00000000,	NULL,	NULL);

DROP TABLE IF EXISTS `llx_product_pricerules`;
CREATE TABLE `llx_product_pricerules` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `level` int(11) NOT NULL,
  `fk_level` int(11) NOT NULL,
  `var_percent` double NOT NULL,
  `var_min_percent` double NOT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `unique_level` (`level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_product_price_by_qty`;
CREATE TABLE `llx_product_price_by_qty` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_product_price` int(11) NOT NULL,
  `price` double(24,8) DEFAULT '0.00000000',
  `price_base_type` varchar(3) COLLATE utf8_unicode_ci DEFAULT 'HT',
  `quantity` double DEFAULT NULL,
  `remise_percent` double NOT NULL DEFAULT '0',
  `remise` double NOT NULL DEFAULT '0',
  `unitprice` double(24,8) DEFAULT '0.00000000',
  `fk_user_creat` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `fk_multicurrency` int(11) DEFAULT NULL,
  `multicurrency_code` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `multicurrency_tx` double(24,8) DEFAULT '1.00000000',
  `multicurrency_price` double(24,8) DEFAULT NULL,
  `multicurrency_price_ttc` double(24,8) DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_product_price_by_qty_level` (`fk_product_price`,`quantity`),
  KEY `idx_product_price_by_qty_fk_product_price` (`fk_product_price`),
  CONSTRAINT `fk_product_price_by_qty_fk_product_price` FOREIGN KEY (`fk_product_price`) REFERENCES `llx_product_price` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_product_stock`;
CREATE TABLE `llx_product_stock` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_product` int(11) NOT NULL,
  `fk_entrepot` int(11) NOT NULL,
  `reel` double DEFAULT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_product_stock` (`fk_product`,`fk_entrepot`),
  KEY `idx_product_stock_fk_product` (`fk_product`),
  KEY `idx_product_stock_fk_entrepot` (`fk_entrepot`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_product_warehouse_properties`;
CREATE TABLE `llx_product_warehouse_properties` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_product` int(11) NOT NULL,
  `fk_entrepot` int(11) NOT NULL,
  `seuil_stock_alerte` float DEFAULT '0',
  `desiredstock` float DEFAULT '0',
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_projet`;
CREATE TABLE `llx_projet` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_soc` int(11) DEFAULT NULL,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `dateo` date DEFAULT NULL,
  `datee` date DEFAULT NULL,
  `ref` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `fk_user_creat` int(11) NOT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `public` int(11) DEFAULT NULL,
  `fk_statut` int(11) NOT NULL DEFAULT '0',
  `fk_opp_status` int(11) DEFAULT NULL,
  `opp_percent` double(5,2) DEFAULT NULL,
  `fk_opp_status_end` int(11) DEFAULT NULL,
  `date_close` datetime DEFAULT NULL,
  `fk_user_close` int(11) DEFAULT NULL,
  `note_private` text COLLATE utf8_unicode_ci,
  `note_public` text COLLATE utf8_unicode_ci,
  `email_msgid` varchar(175) COLLATE utf8_unicode_ci DEFAULT NULL,
  `opp_amount` double(24,8) DEFAULT NULL,
  `budget_amount` double(24,8) DEFAULT NULL,
  `usage_opportunity` int(11) DEFAULT '0',
  `usage_task` int(11) DEFAULT '1',
  `usage_bill_time` int(11) DEFAULT '0',
  `usage_organize_event` int(11) DEFAULT '0',
  `accept_conference_suggestions` int(11) DEFAULT '0',
  `accept_booth_suggestions` int(11) DEFAULT '0',
  `max_attendees` int(11) DEFAULT '0',
  `price_registration` double(24,8) DEFAULT NULL,
  `price_booth` double(24,8) DEFAULT NULL,
  `model_pdf` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_main_doc` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_projet_ref` (`ref`,`entity`),
  KEY `idx_projet_fk_soc` (`fk_soc`),
  CONSTRAINT `fk_projet_fk_soc` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_projet` (`rowid`, `fk_soc`, `datec`, `tms`, `dateo`, `datee`, `ref`, `entity`, `title`, `description`, `fk_user_creat`, `fk_user_modif`, `public`, `fk_statut`, `fk_opp_status`, `opp_percent`, `fk_opp_status_end`, `date_close`, `fk_user_close`, `note_private`, `note_public`, `email_msgid`, `opp_amount`, `budget_amount`, `usage_opportunity`, `usage_task`, `usage_bill_time`, `usage_organize_event`, `accept_conference_suggestions`, `accept_booth_suggestions`, `max_attendees`, `price_registration`, `price_booth`, `model_pdf`, `last_main_doc`, `import_key`) VALUES
(1,	NULL,	'2022-09-09 15:18:21',	'2022-09-09 15:42:31',	'2022-09-09',	'2022-09-30',	'PJ2209-0001',	1,	'Livraison de 1000 stores',	'Projet de test',	1,	1,	0,	1,	1,	0.00,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	100000.00000000,	1,	0,	0,	0,	0,	0,	0,	NULL,	NULL,	NULL,	NULL,	NULL),
(2,	NULL,	'2022-09-09 15:43:53',	'2022-09-09 15:44:02',	'2022-09-09',	'2022-09-21',	'PJ2209-0002',	1,	'Grosse livraison ?? l\'??tranger',	'',	1,	NULL,	0,	1,	6,	100.00,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	458000.00000000,	NULL,	1,	1,	0,	0,	0,	0,	0,	NULL,	NULL,	NULL,	NULL,	NULL);

DROP TABLE IF EXISTS `llx_projet_extrafields`;
CREATE TABLE `llx_projet_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_projet_extrafields` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_projet_task`;
CREATE TABLE `llx_projet_task` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `ref` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `fk_projet` int(11) NOT NULL,
  `fk_task_parent` int(11) NOT NULL DEFAULT '0',
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `dateo` datetime DEFAULT NULL,
  `datee` datetime DEFAULT NULL,
  `datev` datetime DEFAULT NULL,
  `label` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `duration_effective` double DEFAULT '0',
  `planned_workload` double DEFAULT '0',
  `progress` int(11) DEFAULT '0',
  `priority` int(11) DEFAULT '0',
  `budget_amount` double(24,8) DEFAULT NULL,
  `fk_user_creat` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `fk_user_valid` int(11) DEFAULT NULL,
  `fk_statut` smallint(6) NOT NULL DEFAULT '0',
  `note_private` text COLLATE utf8_unicode_ci,
  `note_public` text COLLATE utf8_unicode_ci,
  `rang` int(11) DEFAULT '0',
  `model_pdf` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_projet_task_ref` (`ref`,`entity`),
  KEY `idx_projet_task_fk_projet` (`fk_projet`),
  KEY `idx_projet_task_fk_user_creat` (`fk_user_creat`),
  KEY `idx_projet_task_fk_user_valid` (`fk_user_valid`),
  CONSTRAINT `fk_projet_task_fk_projet` FOREIGN KEY (`fk_projet`) REFERENCES `llx_projet` (`rowid`),
  CONSTRAINT `fk_projet_task_fk_user_creat` FOREIGN KEY (`fk_user_creat`) REFERENCES `llx_user` (`rowid`),
  CONSTRAINT `fk_projet_task_fk_user_valid` FOREIGN KEY (`fk_user_valid`) REFERENCES `llx_user` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_projet_task_extrafields`;
CREATE TABLE `llx_projet_task_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_projet_task_extrafields` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_projet_task_time`;
CREATE TABLE `llx_projet_task_time` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_task` int(11) NOT NULL,
  `task_date` date DEFAULT NULL,
  `task_datehour` datetime DEFAULT NULL,
  `task_date_withhour` int(11) DEFAULT '0',
  `task_duration` double DEFAULT NULL,
  `fk_user` int(11) DEFAULT NULL,
  `thm` double(24,8) DEFAULT NULL,
  `invoice_id` int(11) DEFAULT NULL,
  `invoice_line_id` int(11) DEFAULT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `note` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`rowid`),
  KEY `idx_projet_task_time_task` (`fk_task`),
  KEY `idx_projet_task_time_date` (`task_date`),
  KEY `idx_projet_task_time_datehour` (`task_datehour`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_propal`;
CREATE TABLE `llx_propal` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `ref` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `ref_ext` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ref_int` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ref_client` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_soc` int(11) DEFAULT NULL,
  `fk_projet` int(11) DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `datec` datetime DEFAULT NULL,
  `datep` date DEFAULT NULL,
  `fin_validite` datetime DEFAULT NULL,
  `date_valid` datetime DEFAULT NULL,
  `date_signature` datetime DEFAULT NULL,
  `date_cloture` datetime DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `fk_user_valid` int(11) DEFAULT NULL,
  `fk_user_signature` int(11) DEFAULT NULL,
  `fk_user_cloture` int(11) DEFAULT NULL,
  `fk_statut` smallint(6) NOT NULL DEFAULT '0',
  `price` double DEFAULT '0',
  `remise_percent` double DEFAULT '0',
  `remise_absolue` double DEFAULT '0',
  `remise` double DEFAULT '0',
  `total_ht` double(24,8) DEFAULT '0.00000000',
  `total_tva` double(24,8) DEFAULT '0.00000000',
  `localtax1` double(24,8) DEFAULT '0.00000000',
  `localtax2` double(24,8) DEFAULT '0.00000000',
  `total_ttc` double(24,8) DEFAULT '0.00000000',
  `fk_account` int(11) DEFAULT NULL,
  `fk_currency` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_cond_reglement` int(11) DEFAULT NULL,
  `fk_mode_reglement` int(11) DEFAULT NULL,
  `online_sign_ip` varchar(48) COLLATE utf8_unicode_ci DEFAULT NULL,
  `online_sign_name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `note_private` text COLLATE utf8_unicode_ci,
  `note_public` text COLLATE utf8_unicode_ci,
  `model_pdf` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_main_doc` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_livraison` date DEFAULT NULL,
  `fk_shipping_method` int(11) DEFAULT NULL,
  `fk_warehouse` int(11) DEFAULT NULL,
  `fk_availability` int(11) DEFAULT NULL,
  `fk_input_reason` int(11) DEFAULT NULL,
  `fk_incoterms` int(11) DEFAULT NULL,
  `location_incoterms` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `extraparams` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_delivery_address` int(11) DEFAULT NULL,
  `fk_multicurrency` int(11) DEFAULT NULL,
  `multicurrency_code` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `multicurrency_tx` double(24,8) DEFAULT '1.00000000',
  `multicurrency_total_ht` double(24,8) DEFAULT '0.00000000',
  `multicurrency_total_tva` double(24,8) DEFAULT '0.00000000',
  `multicurrency_total_ttc` double(24,8) DEFAULT '0.00000000',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_propal_ref` (`ref`,`entity`),
  KEY `idx_propal_fk_soc` (`fk_soc`),
  KEY `idx_propal_fk_user_author` (`fk_user_author`),
  KEY `idx_propal_fk_user_valid` (`fk_user_valid`),
  KEY `idx_propal_fk_user_signature` (`fk_user_signature`),
  KEY `idx_propal_fk_user_cloture` (`fk_user_cloture`),
  KEY `idx_propal_fk_projet` (`fk_projet`),
  KEY `idx_propal_fk_account` (`fk_account`),
  KEY `idx_propal_fk_currency` (`fk_currency`),
  KEY `idx_propal_fk_warehouse` (`fk_warehouse`),
  CONSTRAINT `fk_propal_fk_projet` FOREIGN KEY (`fk_projet`) REFERENCES `llx_projet` (`rowid`),
  CONSTRAINT `fk_propal_fk_soc` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`),
  CONSTRAINT `fk_propal_fk_user_author` FOREIGN KEY (`fk_user_author`) REFERENCES `llx_user` (`rowid`),
  CONSTRAINT `fk_propal_fk_user_cloture` FOREIGN KEY (`fk_user_cloture`) REFERENCES `llx_user` (`rowid`),
  CONSTRAINT `fk_propal_fk_user_signature` FOREIGN KEY (`fk_user_signature`) REFERENCES `llx_user` (`rowid`),
  CONSTRAINT `fk_propal_fk_user_valid` FOREIGN KEY (`fk_user_valid`) REFERENCES `llx_user` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_propal` (`rowid`, `ref`, `entity`, `ref_ext`, `ref_int`, `ref_client`, `fk_soc`, `fk_projet`, `tms`, `datec`, `datep`, `fin_validite`, `date_valid`, `date_signature`, `date_cloture`, `fk_user_author`, `fk_user_modif`, `fk_user_valid`, `fk_user_signature`, `fk_user_cloture`, `fk_statut`, `price`, `remise_percent`, `remise_absolue`, `remise`, `total_ht`, `total_tva`, `localtax1`, `localtax2`, `total_ttc`, `fk_account`, `fk_currency`, `fk_cond_reglement`, `fk_mode_reglement`, `online_sign_ip`, `online_sign_name`, `note_private`, `note_public`, `model_pdf`, `last_main_doc`, `date_livraison`, `fk_shipping_method`, `fk_warehouse`, `fk_availability`, `fk_input_reason`, `fk_incoterms`, `location_incoterms`, `import_key`, `extraparams`, `fk_delivery_address`, `fk_multicurrency`, `multicurrency_code`, `multicurrency_tx`, `multicurrency_total_ht`, `multicurrency_total_tva`, `multicurrency_total_ttc`) VALUES
(20,	'(PROV20)',	1,	NULL,	NULL,	'',	13,	NULL,	'2022-10-19 12:17:17',	'2022-10-19 12:51:39',	'2022-10-19',	'2022-11-03 11:00:00',	NULL,	NULL,	NULL,	1,	NULL,	NULL,	NULL,	NULL,	0,	0,	NULL,	NULL,	0,	2430.00000000,	94.71000000,	0.00000000,	0.00000000,	2524.71000000,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'',	'',	'cyan',	'propale/(PROV20)/(PROV20).pdf',	NULL,	NULL,	NULL,	0,	0,	0,	'',	NULL,	NULL,	NULL,	0,	'CHF',	1.00000000,	1200.00000000,	0.00000000,	1200.00000000);

DROP TABLE IF EXISTS `llx_propaldet`;
CREATE TABLE `llx_propaldet` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_propal` int(11) NOT NULL,
  `fk_parent_line` int(11) DEFAULT NULL,
  `fk_product` int(11) DEFAULT NULL,
  `label` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `fk_remise_except` int(11) DEFAULT NULL,
  `vat_src_code` varchar(10) COLLATE utf8_unicode_ci DEFAULT '',
  `tva_tx` double(7,4) DEFAULT '0.0000',
  `localtax1_tx` double(7,4) DEFAULT '0.0000',
  `localtax1_type` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `localtax2_tx` double(7,4) DEFAULT '0.0000',
  `localtax2_type` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `qty` double DEFAULT NULL,
  `remise_percent` double DEFAULT '0',
  `remise` double DEFAULT '0',
  `price` double DEFAULT NULL,
  `subprice` double(24,8) DEFAULT '0.00000000',
  `total_ht` double(24,8) DEFAULT '0.00000000',
  `total_tva` double(24,8) DEFAULT '0.00000000',
  `total_localtax1` double(24,8) DEFAULT '0.00000000',
  `total_localtax2` double(24,8) DEFAULT '0.00000000',
  `total_ttc` double(24,8) DEFAULT '0.00000000',
  `product_type` int(11) DEFAULT '0',
  `date_start` datetime DEFAULT NULL,
  `date_end` datetime DEFAULT NULL,
  `info_bits` int(11) DEFAULT '0',
  `buy_price_ht` double(24,8) DEFAULT '0.00000000',
  `fk_product_fournisseur_price` int(11) DEFAULT NULL,
  `special_code` int(11) DEFAULT '0',
  `rang` int(11) DEFAULT '0',
  `fk_unit` int(11) DEFAULT NULL,
  `fk_multicurrency` int(11) DEFAULT NULL,
  `multicurrency_code` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `multicurrency_subprice` double(24,8) DEFAULT '0.00000000',
  `multicurrency_total_ht` double(24,8) DEFAULT '0.00000000',
  `multicurrency_total_tva` double(24,8) DEFAULT '0.00000000',
  `multicurrency_total_ttc` double(24,8) DEFAULT '0.00000000',
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_propaldet_fk_propal` (`fk_propal`),
  KEY `idx_propaldet_fk_product` (`fk_product`),
  KEY `fk_propaldet_fk_unit` (`fk_unit`),
  CONSTRAINT `fk_propaldet_fk_propal` FOREIGN KEY (`fk_propal`) REFERENCES `llx_propal` (`rowid`),
  CONSTRAINT `fk_propaldet_fk_unit` FOREIGN KEY (`fk_unit`) REFERENCES `llx_c_units` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_propaldet` (`rowid`, `fk_propal`, `fk_parent_line`, `fk_product`, `label`, `description`, `fk_remise_except`, `vat_src_code`, `tva_tx`, `localtax1_tx`, `localtax1_type`, `localtax2_tx`, `localtax2_type`, `qty`, `remise_percent`, `remise`, `price`, `subprice`, `total_ht`, `total_tva`, `total_localtax1`, `total_localtax2`, `total_ttc`, `product_type`, `date_start`, `date_end`, `info_bits`, `buy_price_ht`, `fk_product_fournisseur_price`, `special_code`, `rang`, `fk_unit`, `fk_multicurrency`, `multicurrency_code`, `multicurrency_subprice`, `multicurrency_total_ht`, `multicurrency_total_tva`, `multicurrency_total_ttc`, `import_key`) VALUES
(64,	20,	NULL,	356,	NULL,	'',	NULL,	'',	7.7000,	0.0000,	'0',	0.0000,	'0',	1,	0,	0,	1230,	1230.00000000,	1230.00000000,	94.71000000,	0.00000000,	0.00000000,	1324.71000000,	0,	NULL,	NULL,	0,	0.00000000,	NULL,	0,	1,	NULL,	NULL,	'CHF',	0.00000000,	0.00000000,	0.00000000,	0.00000000,	NULL),
(65,	20,	NULL,	355,	NULL,	'',	NULL,	'',	0.0000,	0.0000,	'0',	0.0000,	'0',	1,	0,	0,	NULL,	400.00000000,	400.00000000,	0.00000000,	0.00000000,	0.00000000,	400.00000000,	0,	NULL,	NULL,	0,	0.00000000,	NULL,	0,	2,	NULL,	NULL,	'CHF',	400.00000000,	400.00000000,	0.00000000,	400.00000000,	NULL),
(66,	20,	NULL,	355,	NULL,	'',	NULL,	'',	0.0000,	0.0000,	'0',	0.0000,	'0',	1,	0,	0,	NULL,	400.00000000,	400.00000000,	0.00000000,	0.00000000,	0.00000000,	400.00000000,	0,	NULL,	NULL,	0,	0.00000000,	NULL,	0,	3,	NULL,	NULL,	'CHF',	400.00000000,	400.00000000,	0.00000000,	400.00000000,	NULL),
(67,	20,	NULL,	355,	NULL,	'',	NULL,	'',	0.0000,	0.0000,	'0',	0.0000,	'0',	1,	0,	0,	NULL,	400.00000000,	400.00000000,	0.00000000,	0.00000000,	0.00000000,	400.00000000,	0,	NULL,	NULL,	0,	0.00000000,	NULL,	0,	4,	NULL,	NULL,	'CHF',	400.00000000,	400.00000000,	0.00000000,	400.00000000,	NULL);

DROP TABLE IF EXISTS `llx_propaldet_extrafields`;
CREATE TABLE `llx_propaldet_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `abaquesize` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_propaldet_extrafields` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_propaldet_extrafields` (`rowid`, `tms`, `fk_object`, `import_key`, `abaquesize`) VALUES
(954,	'2022-10-19 12:17:17',	64,	NULL,	'23');

DROP TABLE IF EXISTS `llx_propal_extrafields`;
CREATE TABLE `llx_propal_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_propal_extrafields` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_propal_merge_pdf_product`;
CREATE TABLE `llx_propal_merge_pdf_product` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_product` int(11) NOT NULL,
  `file_name` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `lang` varchar(5) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_mod` int(11) NOT NULL,
  `datec` datetime NOT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_reception`;
CREATE TABLE `llx_reception` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ref` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `fk_soc` int(11) NOT NULL,
  `fk_projet` int(11) DEFAULT NULL,
  `ref_ext` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ref_int` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ref_supplier` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_creation` datetime DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `date_valid` datetime DEFAULT NULL,
  `fk_user_valid` int(11) DEFAULT NULL,
  `date_delivery` datetime DEFAULT NULL,
  `date_reception` datetime DEFAULT NULL,
  `fk_shipping_method` int(11) DEFAULT NULL,
  `tracking_number` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_statut` smallint(6) DEFAULT '0',
  `billed` smallint(6) DEFAULT '0',
  `height` float DEFAULT NULL,
  `width` float DEFAULT NULL,
  `size_units` int(11) DEFAULT NULL,
  `size` float DEFAULT NULL,
  `weight_units` int(11) DEFAULT NULL,
  `weight` float DEFAULT NULL,
  `note_private` text COLLATE utf8_unicode_ci,
  `note_public` text COLLATE utf8_unicode_ci,
  `model_pdf` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_incoterms` int(11) DEFAULT NULL,
  `location_incoterms` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `extraparams` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `idx_reception_uk_ref` (`ref`,`entity`),
  KEY `idx_reception_fk_soc` (`fk_soc`),
  KEY `idx_reception_fk_user_author` (`fk_user_author`),
  KEY `idx_reception_fk_user_valid` (`fk_user_valid`),
  KEY `idx_reception_fk_shipping_method` (`fk_shipping_method`),
  CONSTRAINT `fk_reception_fk_shipping_method` FOREIGN KEY (`fk_shipping_method`) REFERENCES `llx_c_shipment_mode` (`rowid`),
  CONSTRAINT `fk_reception_fk_soc` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`),
  CONSTRAINT `fk_reception_fk_user_author` FOREIGN KEY (`fk_user_author`) REFERENCES `llx_user` (`rowid`),
  CONSTRAINT `fk_reception_fk_user_valid` FOREIGN KEY (`fk_user_valid`) REFERENCES `llx_user` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_reception_extrafields`;
CREATE TABLE `llx_reception_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_reception_extrafields` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_recruitment_recruitmentcandidature`;
CREATE TABLE `llx_recruitment_recruitmentcandidature` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `ref` varchar(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '(PROV)',
  `fk_recruitmentjobposition` int(11) DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `note_public` text COLLATE utf8_unicode_ci,
  `note_private` text COLLATE utf8_unicode_ci,
  `date_creation` datetime NOT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_user_creat` int(11) NOT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `model_pdf` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` smallint(6) NOT NULL,
  `firstname` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lastname` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_birth` date DEFAULT NULL,
  `remuneration_requested` int(11) DEFAULT NULL,
  `remuneration_proposed` int(11) DEFAULT NULL,
  `email_msgid` varchar(175) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_recruitment_origin` int(11) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_recruitmentcandidature_email_msgid` (`email_msgid`),
  KEY `idx_recruitment_recruitmentcandidature_rowid` (`rowid`),
  KEY `idx_recruitment_recruitmentcandidature_ref` (`ref`),
  KEY `llx_recruitment_recruitmentcandidature_fk_user_creat` (`fk_user_creat`),
  KEY `idx_recruitment_recruitmentcandidature_status` (`status`),
  CONSTRAINT `llx_recruitment_recruitmentcandidature_fk_user_creat` FOREIGN KEY (`fk_user_creat`) REFERENCES `llx_user` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_recruitment_recruitmentcandidature_extrafields`;
CREATE TABLE `llx_recruitment_recruitmentcandidature_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_recruitmentcandidature_fk_object` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_recruitment_recruitmentjobposition`;
CREATE TABLE `llx_recruitment_recruitmentjobposition` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `ref` varchar(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '(PROV)',
  `entity` int(11) NOT NULL DEFAULT '1',
  `label` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `qty` int(11) NOT NULL DEFAULT '1',
  `fk_soc` int(11) DEFAULT NULL,
  `fk_project` int(11) DEFAULT NULL,
  `fk_user_recruiter` int(11) DEFAULT NULL,
  `email_recruiter` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_user_supervisor` int(11) DEFAULT NULL,
  `fk_establishment` int(11) DEFAULT NULL,
  `date_planned` date DEFAULT NULL,
  `remuneration_suggested` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `note_public` text COLLATE utf8_unicode_ci,
  `note_private` text COLLATE utf8_unicode_ci,
  `date_creation` datetime NOT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_user_creat` int(11) NOT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `last_main_doc` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `model_pdf` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` smallint(6) NOT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_recruitment_recruitmentjobposition_rowid` (`rowid`),
  KEY `idx_recruitment_recruitmentjobposition_ref` (`ref`),
  KEY `idx_recruitment_recruitmentjobposition_fk_soc` (`fk_soc`),
  KEY `idx_recruitment_recruitmentjobposition_fk_project` (`fk_project`),
  KEY `llx_recruitment_recruitmentjobposition_fk_user_recruiter` (`fk_user_recruiter`),
  KEY `llx_recruitment_recruitmentjobposition_fk_user_supervisor` (`fk_user_supervisor`),
  KEY `llx_recruitment_recruitmentjobposition_fk_establishment` (`fk_establishment`),
  KEY `llx_recruitment_recruitmentjobposition_fk_user_creat` (`fk_user_creat`),
  KEY `idx_recruitment_recruitmentjobposition_status` (`status`),
  CONSTRAINT `llx_recruitment_recruitmentjobposition_fk_establishment` FOREIGN KEY (`fk_establishment`) REFERENCES `llx_establishment` (`rowid`),
  CONSTRAINT `llx_recruitment_recruitmentjobposition_fk_user_creat` FOREIGN KEY (`fk_user_creat`) REFERENCES `llx_user` (`rowid`),
  CONSTRAINT `llx_recruitment_recruitmentjobposition_fk_user_recruiter` FOREIGN KEY (`fk_user_recruiter`) REFERENCES `llx_user` (`rowid`),
  CONSTRAINT `llx_recruitment_recruitmentjobposition_fk_user_supervisor` FOREIGN KEY (`fk_user_supervisor`) REFERENCES `llx_user` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_recruitment_recruitmentjobposition_extrafields`;
CREATE TABLE `llx_recruitment_recruitmentjobposition_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_recruitmentjobposition_fk_object` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_resource`;
CREATE TABLE `llx_resource` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `ref` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `asset_number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `fk_code_type_resource` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `datec` datetime DEFAULT NULL,
  `date_valid` datetime DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `fk_user_valid` int(11) DEFAULT NULL,
  `fk_statut` smallint(6) NOT NULL DEFAULT '0',
  `note_public` text COLLATE utf8_unicode_ci,
  `note_private` text COLLATE utf8_unicode_ci,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `extraparams` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_country` int(11) DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_resource_ref` (`ref`,`entity`),
  KEY `fk_code_type_resource_idx` (`fk_code_type_resource`),
  KEY `idx_resource_fk_country` (`fk_country`),
  CONSTRAINT `fk_resource_fk_country` FOREIGN KEY (`fk_country`) REFERENCES `llx_c_country` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_resource_extrafields`;
CREATE TABLE `llx_resource_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_resource_extrafields` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_rights_def`;
CREATE TABLE `llx_rights_def` (
  `id` int(11) NOT NULL,
  `libelle` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `module` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `module_position` int(11) NOT NULL DEFAULT '0',
  `family_position` int(11) NOT NULL DEFAULT '0',
  `entity` int(11) NOT NULL DEFAULT '1',
  `perms` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `subperms` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `bydefault` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`,`entity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_rights_def` (`id`, `libelle`, `module`, `module_position`, `family_position`, `entity`, `perms`, `subperms`, `type`, `bydefault`) VALUES
(11,	'Read invoices',	'facture',	11,	0,	1,	'lire',	NULL,	'a',	0),
(12,	'Create and update invoices',	'facture',	11,	0,	1,	'creer',	NULL,	'a',	0),
(13,	'Devalidate invoices',	'facture',	11,	0,	1,	'invoice_advance',	'unvalidate',	'a',	0),
(14,	'Validate invoices',	'facture',	11,	0,	1,	'invoice_advance',	'validate',	'a',	0),
(15,	'Send invoices by email',	'facture',	11,	0,	1,	'invoice_advance',	'send',	'a',	0),
(16,	'Issue payments on invoices',	'facture',	11,	0,	1,	'paiement',	NULL,	'a',	0),
(19,	'Delete invoices',	'facture',	11,	0,	1,	'supprimer',	NULL,	'a',	0),
(21,	'Read commercial proposals',	'propale',	10,	0,	1,	'lire',	NULL,	'r',	0),
(22,	'Create and update commercial proposals',	'propale',	10,	0,	1,	'creer',	NULL,	'w',	0),
(24,	'Validate commercial proposals',	'propale',	10,	0,	1,	'propal_advance',	'validate',	'd',	0),
(25,	'Send commercial proposals to customers',	'propale',	10,	0,	1,	'propal_advance',	'send',	'd',	0),
(26,	'Close commercial proposals',	'propale',	10,	0,	1,	'propal_advance',	'close',	'd',	0),
(27,	'Delete commercial proposals',	'propale',	10,	0,	1,	'supprimer',	NULL,	'd',	0),
(28,	'Exporting commercial proposals and attributes',	'propale',	10,	0,	1,	'export',	NULL,	'r',	0),
(31,	'Read products',	'produit',	26,	0,	1,	'lire',	NULL,	'r',	0),
(32,	'Create/modify products',	'produit',	26,	0,	1,	'creer',	NULL,	'w',	0),
(34,	'Delete products',	'produit',	26,	0,	1,	'supprimer',	NULL,	'd',	0),
(38,	'Export products',	'produit',	26,	0,	1,	'export',	NULL,	'r',	0),
(39,	'Ignore minimum price',	'produit',	26,	0,	1,	'ignore_price_min_advance',	NULL,	'r',	0),
(81,	'Read sales orders',	'commande',	11,	0,	1,	'lire',	NULL,	'r',	0),
(82,	'Creeat/modify sales orders',	'commande',	11,	0,	1,	'creer',	NULL,	'w',	0),
(84,	'Validate sales orders',	'commande',	11,	0,	1,	'order_advance',	'validate',	'd',	0),
(86,	'Send sale orders by email',	'commande',	11,	0,	1,	'order_advance',	'send',	'd',	0),
(87,	'Close sale orders',	'commande',	11,	0,	1,	'order_advance',	'close',	'd',	0),
(88,	'Cancel sale orders',	'commande',	11,	0,	1,	'order_advance',	'annuler',	'd',	0),
(89,	'Delete sales orders',	'commande',	11,	0,	1,	'supprimer',	NULL,	'd',	0),
(91,	'Lire les charges',	'tax',	50,	0,	1,	'charges',	'lire',	'r',	0),
(92,	'Creer/modifier les charges',	'tax',	50,	0,	1,	'charges',	'creer',	'w',	0),
(93,	'Supprimer les charges',	'tax',	50,	0,	1,	'charges',	'supprimer',	'd',	0),
(94,	'Exporter les charges',	'tax',	50,	0,	1,	'charges',	'export',	'r',	0),
(101,	'Lire les expeditions',	'expedition',	40,	0,	1,	'lire',	NULL,	'r',	0),
(102,	'Creer modifier les expeditions',	'expedition',	40,	0,	1,	'creer',	NULL,	'w',	0),
(104,	'Valider les expeditions',	'expedition',	40,	0,	1,	'shipping_advance',	'validate',	'd',	0),
(105,	'Envoyer les expeditions aux clients',	'expedition',	40,	0,	1,	'shipping_advance',	'send',	'd',	0),
(106,	'Exporter les expeditions',	'expedition',	40,	0,	1,	'shipment',	'export',	'r',	0),
(109,	'Supprimer les expeditions',	'expedition',	40,	0,	1,	'supprimer',	NULL,	'd',	0),
(121,	'Read third parties',	'societe',	9,	0,	1,	'lire',	NULL,	'r',	0),
(122,	'Create and update third parties',	'societe',	9,	0,	1,	'creer',	NULL,	'w',	0),
(125,	'Delete third parties',	'societe',	9,	0,	1,	'supprimer',	NULL,	'd',	0),
(126,	'Export third parties',	'societe',	9,	0,	1,	'export',	NULL,	'r',	0),
(130,	'Modify thirdparty information payment',	'societe',	9,	0,	1,	'thirdparty_paymentinformation_advance',	'write',	'w',	0),
(241,	'Lire les categories',	'categorie',	20,	0,	1,	'lire',	NULL,	'r',	0),
(242,	'Creer/modifier les categories',	'categorie',	20,	0,	1,	'creer',	NULL,	'w',	0),
(243,	'Supprimer les categories',	'categorie',	20,	0,	1,	'supprimer',	NULL,	'd',	0),
(251,	'Read information of other users, groups and permissions',	'user',	5,	0,	1,	'user',	'lire',	'r',	0),
(252,	'Read permissions of other users',	'user',	5,	0,	1,	'user_advance',	'readperms',	'r',	0),
(253,	'Create/modify internal and external users, groups and permissions',	'user',	5,	0,	1,	'user',	'creer',	'w',	0),
(254,	'Create/modify external users only',	'user',	5,	0,	1,	'user_advance',	'write',	'w',	0),
(255,	'Modify the password of other users',	'user',	5,	0,	1,	'user',	'password',	'w',	0),
(256,	'Delete or disable other users',	'user',	5,	0,	1,	'user',	'supprimer',	'd',	0),
(262,	'Read all third parties (and their objects) by internal users (otherwise only if commercial contact). Not effective for external users (limited to themselves).',	'societe',	9,	0,	1,	'client',	'voir',	'r',	0),
(281,	'Read contacts',	'societe',	9,	0,	1,	'contact',	'lire',	'r',	0),
(282,	'Create and update contact',	'societe',	9,	0,	1,	'contact',	'creer',	'w',	0),
(283,	'Delete contacts',	'societe',	9,	0,	1,	'contact',	'supprimer',	'd',	0),
(286,	'Export contacts',	'societe',	9,	0,	1,	'contact',	'export',	'd',	0),
(341,	'Read its own permissions',	'user',	5,	0,	1,	'self_advance',	'readperms',	'r',	0),
(342,	'Create/modify of its own user',	'user',	5,	0,	1,	'self',	'creer',	'w',	0),
(343,	'Modify its own password',	'user',	5,	0,	1,	'self',	'password',	'w',	0),
(344,	'Modify its own permissions',	'user',	5,	0,	1,	'self_advance',	'writeperms',	'w',	0),
(351,	'Read groups',	'user',	5,	0,	1,	'group_advance',	'read',	'r',	0),
(352,	'Read permissions of groups',	'user',	5,	0,	1,	'group_advance',	'readperms',	'r',	0),
(353,	'Create/modify groups and permissions',	'user',	5,	0,	1,	'group_advance',	'write',	'w',	0),
(354,	'Delete groups',	'user',	5,	0,	1,	'group_advance',	'delete',	'd',	0),
(358,	'Export all users',	'user',	5,	0,	1,	'user',	'export',	'r',	0),
(531,	'Read services',	'service',	29,	0,	1,	'lire',	NULL,	'r',	0),
(532,	'Create/modify services',	'service',	29,	0,	1,	'creer',	NULL,	'w',	0),
(534,	'Delete les services',	'service',	29,	0,	1,	'supprimer',	NULL,	'd',	0),
(538,	'Export services',	'service',	29,	0,	1,	'export',	NULL,	'r',	0),
(1001,	'Lire les stocks',	'stock',	39,	0,	1,	'lire',	NULL,	'r',	0),
(1002,	'Creer/Modifier les stocks',	'stock',	39,	0,	1,	'creer',	NULL,	'w',	0),
(1003,	'Supprimer les stocks',	'stock',	39,	0,	1,	'supprimer',	NULL,	'd',	0),
(1004,	'Lire mouvements de stocks',	'stock',	39,	0,	1,	'mouvement',	'lire',	'r',	0),
(1005,	'Creer/modifier mouvements de stocks',	'stock',	39,	0,	1,	'mouvement',	'creer',	'w',	0),
(1011,	'inventoryReadPermission',	'stock',	39,	0,	1,	'inventory_advance',	'read',	'w',	0),
(1012,	'inventoryCreatePermission',	'stock',	39,	0,	1,	'inventory_advance',	'write',	'w',	0),
(1101,	'Read delivery receipts',	'expedition',	40,	0,	1,	'delivery',	'lire',	'r',	0),
(1102,	'Create/modify delivery receipts',	'expedition',	40,	0,	1,	'delivery',	'creer',	'w',	0),
(1104,	'Validate delivery receipts',	'expedition',	40,	0,	1,	'delivery_advance',	'validate',	'd',	0),
(1109,	'Delete delivery receipts',	'expedition',	40,	0,	1,	'delivery',	'supprimer',	'd',	0),
(1121,	'Read supplier proposals',	'supplier_proposal',	35,	0,	1,	'lire',	NULL,	'w',	0),
(1122,	'Create/modify supplier proposals',	'supplier_proposal',	35,	0,	1,	'creer',	NULL,	'w',	0),
(1123,	'Validate supplier proposals',	'supplier_proposal',	35,	0,	1,	'validate_advance',	NULL,	'w',	0),
(1124,	'Envoyer les demandes fournisseurs',	'supplier_proposal',	35,	0,	1,	'send_advance',	NULL,	'w',	0),
(1125,	'Delete supplier proposals',	'supplier_proposal',	35,	0,	1,	'supprimer',	NULL,	'w',	0),
(1126,	'Close supplier price requests',	'supplier_proposal',	35,	0,	1,	'cloturer',	NULL,	'w',	0),
(1181,	'Consulter les fournisseurs',	'fournisseur',	12,	0,	1,	'lire',	NULL,	'r',	0),
(1182,	'Consulter les commandes fournisseur',	'fournisseur',	12,	0,	1,	'commande',	'lire',	'r',	0),
(1183,	'Creer une commande fournisseur',	'fournisseur',	12,	0,	1,	'commande',	'creer',	'w',	0),
(1184,	'Valider une commande fournisseur',	'fournisseur',	12,	0,	1,	'supplier_order_advance',	'validate',	'w',	0),
(1185,	'Approuver une commande fournisseur',	'fournisseur',	12,	0,	1,	'commande',	'approuver',	'w',	0),
(1186,	'Commander une commande fournisseur',	'fournisseur',	12,	0,	1,	'commande',	'commander',	'w',	0),
(1187,	'Receptionner une commande fournisseur',	'fournisseur',	12,	0,	1,	'commande',	'receptionner',	'd',	0),
(1188,	'Supprimer une commande fournisseur',	'fournisseur',	12,	0,	1,	'commande',	'supprimer',	'd',	0),
(1189,	'Check/Uncheck a supplier order reception',	'fournisseur',	12,	0,	1,	'commande_advance',	'check',	'w',	0),
(1191,	'Exporter les commande fournisseurs, attributs',	'fournisseur',	12,	0,	1,	'commande',	'export',	'r',	0),
(1201,	'Read exports',	'export',	72,	0,	1,	'lire',	NULL,	'r',	0),
(1202,	'Creeate/modify export',	'export',	72,	0,	1,	'creer',	NULL,	'w',	0),
(1231,	'Consulter les factures fournisseur',	'fournisseur',	12,	0,	1,	'facture',	'lire',	'r',	0),
(1232,	'Creer une facture fournisseur',	'fournisseur',	12,	0,	1,	'facture',	'creer',	'w',	0),
(1233,	'Valider une facture fournisseur',	'fournisseur',	12,	0,	1,	'supplier_invoice_advance',	'validate',	'w',	0),
(1234,	'Supprimer une facture fournisseur',	'fournisseur',	12,	0,	1,	'facture',	'supprimer',	'd',	0),
(1235,	'Envoyer les factures par mail',	'fournisseur',	12,	0,	1,	'supplier_invoice_advance',	'send',	'a',	0),
(1236,	'Exporter les factures fournisseurs, attributs et reglements',	'fournisseur',	12,	0,	1,	'facture',	'export',	'r',	0),
(1251,	'Run mass imports of external data (data load)',	'import',	70,	0,	1,	'run',	NULL,	'r',	0),
(1321,	'Export customer invoices, attributes and payments',	'facture',	11,	0,	1,	'facture',	'export',	'r',	0),
(1322,	'Re-open a fully paid invoice',	'facture',	11,	0,	1,	'invoice_advance',	'reopen',	'r',	0),
(1421,	'Export sales orders and attributes',	'commande',	11,	0,	1,	'commande',	'export',	'r',	0),
(2610,	'G??n??rer / modifier la cl?? API des utilisateurs',	'api',	24,	0,	1,	'apikey',	'generate',	'w',	0),
(3301,	'Generate new modules',	'modulebuilder',	90,	0,	1,	'run',	NULL,	'a',	0),
(59001,	'Visualiser les marges',	'margins',	55,	0,	1,	'liretous',	NULL,	'r',	0),
(59002,	'D??finir les marges',	'margins',	55,	0,	1,	'creer',	NULL,	'w',	0),
(59003,	'Read every user margin',	'margins',	55,	0,	1,	'read',	'all',	'r',	0),
(220810,	'Access/Read',	'crmenhanced',	100090,	0,	1,	'read',	NULL,	'a',	1),
(220811,	'View campaign',	'crmenhanced',	100090,	0,	1,	'readcampaigns',	NULL,	'w',	1),
(220812,	'Create campaign',	'crmenhanced',	100090,	0,	1,	'createcampaigns',	NULL,	'w',	1),
(220813,	'View activities',	'crmenhanced',	100090,	0,	1,	'readactivity',	NULL,	'a',	1),
(220814,	'Create activities',	'crmenhanced',	100090,	0,	1,	'writeactivity',	NULL,	'a',	1),
(220815,	'Delete activities',	'crmenhanced',	100090,	0,	1,	'deletectivity',	NULL,	'a',	1),
(50000001,	'Read objects of Stormatic',	'stormatic',	0,	0,	1,	'csv',	'read',	'w',	0),
(50000002,	'Create/Update objects of Stormatic',	'stormatic',	0,	0,	1,	'csv',	'write',	'w',	0),
(50000003,	'Delete objects of Stormatic',	'stormatic',	0,	0,	1,	'csv',	'delete',	'w',	0),
(50000004,	'Run objects of Stormatic',	'stormatic',	0,	0,	1,	'csv',	'run',	'w',	0),
(125033001,	'Rights_CanUseKanprospects',	'kanprospects',	100100,	0,	1,	'canuse',	NULL,	'w',	0);

DROP TABLE IF EXISTS `llx_salary`;
CREATE TABLE `llx_salary` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `ref` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `datec` datetime DEFAULT NULL,
  `fk_user` int(11) NOT NULL,
  `datep` date DEFAULT NULL,
  `datev` date DEFAULT NULL,
  `salary` double(24,8) DEFAULT NULL,
  `amount` double(24,8) NOT NULL DEFAULT '0.00000000',
  `fk_projet` int(11) DEFAULT NULL,
  `fk_typepayment` int(11) NOT NULL,
  `num_payment` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `label` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `datesp` date DEFAULT NULL,
  `dateep` date DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `note` text COLLATE utf8_unicode_ci,
  `fk_bank` int(11) DEFAULT NULL,
  `paye` smallint(6) NOT NULL DEFAULT '0',
  `fk_account` int(11) DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_salary_extrafields`;
CREATE TABLE `llx_salary_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_salary_extrafields` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_session`;
CREATE TABLE `llx_session` (
  `session_id` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `session_variable` text COLLATE utf8_unicode_ci,
  `last_accessed` datetime NOT NULL,
  `fk_user` int(11) NOT NULL,
  `remote_ip` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_agent` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_societe`;
CREATE TABLE `llx_societe` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name_alias` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `ref_ext` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ref_int` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `statut` tinyint(4) DEFAULT '0',
  `parent` int(11) DEFAULT NULL,
  `status` tinyint(4) DEFAULT '1',
  `code_client` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `code_fournisseur` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `code_compta` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `code_compta_fournisseur` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `zip` varchar(25) COLLATE utf8_unicode_ci DEFAULT NULL,
  `town` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_departement` int(11) DEFAULT '0',
  `fk_pays` int(11) DEFAULT '0',
  `fk_account` int(11) DEFAULT '0',
  `phone` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fax` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `socialnetworks` text COLLATE utf8_unicode_ci,
  `fk_effectif` int(11) DEFAULT '0',
  `fk_typent` int(11) DEFAULT NULL,
  `fk_forme_juridique` int(11) DEFAULT '0',
  `fk_currency` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `siren` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `siret` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ape` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `idprof4` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `idprof5` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `idprof6` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tva_intra` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `capital` double(24,8) DEFAULT NULL,
  `fk_stcomm` int(11) NOT NULL DEFAULT '0',
  `note_private` text COLLATE utf8_unicode_ci,
  `note_public` text COLLATE utf8_unicode_ci,
  `model_pdf` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `prefix_comm` varchar(5) COLLATE utf8_unicode_ci DEFAULT NULL,
  `client` tinyint(4) DEFAULT '0',
  `fournisseur` tinyint(4) DEFAULT '0',
  `supplier_account` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_prospectlevel` varchar(12) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_incoterms` int(11) DEFAULT NULL,
  `location_incoterms` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `customer_bad` tinyint(4) DEFAULT '0',
  `customer_rate` double DEFAULT '0',
  `supplier_rate` double DEFAULT '0',
  `remise_client` double DEFAULT '0',
  `remise_supplier` double DEFAULT '0',
  `mode_reglement` tinyint(4) DEFAULT NULL,
  `cond_reglement` tinyint(4) DEFAULT NULL,
  `transport_mode` tinyint(4) DEFAULT NULL,
  `mode_reglement_supplier` tinyint(4) DEFAULT NULL,
  `cond_reglement_supplier` tinyint(4) DEFAULT NULL,
  `transport_mode_supplier` tinyint(4) DEFAULT NULL,
  `fk_shipping_method` int(11) DEFAULT NULL,
  `tva_assuj` tinyint(4) DEFAULT '1',
  `localtax1_assuj` tinyint(4) DEFAULT '0',
  `localtax1_value` double(7,4) DEFAULT NULL,
  `localtax2_assuj` tinyint(4) DEFAULT '0',
  `localtax2_value` double(7,4) DEFAULT NULL,
  `barcode` varchar(180) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_barcode_type` int(11) DEFAULT '0',
  `price_level` int(11) DEFAULT NULL,
  `outstanding_limit` double(24,8) DEFAULT NULL,
  `order_min_amount` double(24,8) DEFAULT NULL,
  `supplier_order_min_amount` double(24,8) DEFAULT NULL,
  `default_lang` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `logo` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `logo_squarred` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `canvas` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_warehouse` int(11) DEFAULT NULL,
  `webservices_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `webservices_key` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `accountancy_code_sell` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `accountancy_code_buy` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `datec` datetime DEFAULT NULL,
  `fk_user_creat` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `fk_multicurrency` int(11) DEFAULT NULL,
  `multicurrency_code` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_societe_prefix_comm` (`prefix_comm`,`entity`),
  UNIQUE KEY `uk_societe_code_client` (`code_client`,`entity`),
  UNIQUE KEY `uk_societe_code_fournisseur` (`code_fournisseur`,`entity`),
  UNIQUE KEY `uk_societe_barcode` (`barcode`,`fk_barcode_type`,`entity`),
  KEY `idx_societe_user_creat` (`fk_user_creat`),
  KEY `idx_societe_user_modif` (`fk_user_modif`),
  KEY `idx_societe_stcomm` (`fk_stcomm`),
  KEY `idx_societe_pays` (`fk_pays`),
  KEY `idx_societe_account` (`fk_account`),
  KEY `idx_societe_prospectlevel` (`fk_prospectlevel`),
  KEY `idx_societe_typent` (`fk_typent`),
  KEY `idx_societe_forme_juridique` (`fk_forme_juridique`),
  KEY `idx_societe_shipping_method` (`fk_shipping_method`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_societe` (`rowid`, `nom`, `name_alias`, `entity`, `ref_ext`, `ref_int`, `statut`, `parent`, `status`, `code_client`, `code_fournisseur`, `code_compta`, `code_compta_fournisseur`, `address`, `zip`, `town`, `fk_departement`, `fk_pays`, `fk_account`, `phone`, `fax`, `url`, `email`, `socialnetworks`, `fk_effectif`, `fk_typent`, `fk_forme_juridique`, `fk_currency`, `siren`, `siret`, `ape`, `idprof4`, `idprof5`, `idprof6`, `tva_intra`, `capital`, `fk_stcomm`, `note_private`, `note_public`, `model_pdf`, `prefix_comm`, `client`, `fournisseur`, `supplier_account`, `fk_prospectlevel`, `fk_incoterms`, `location_incoterms`, `customer_bad`, `customer_rate`, `supplier_rate`, `remise_client`, `remise_supplier`, `mode_reglement`, `cond_reglement`, `transport_mode`, `mode_reglement_supplier`, `cond_reglement_supplier`, `transport_mode_supplier`, `fk_shipping_method`, `tva_assuj`, `localtax1_assuj`, `localtax1_value`, `localtax2_assuj`, `localtax2_value`, `barcode`, `fk_barcode_type`, `price_level`, `outstanding_limit`, `order_min_amount`, `supplier_order_min_amount`, `default_lang`, `logo`, `logo_squarred`, `canvas`, `fk_warehouse`, `webservices_url`, `webservices_key`, `accountancy_code_sell`, `accountancy_code_buy`, `tms`, `datec`, `fk_user_creat`, `fk_user_modif`, `fk_multicurrency`, `multicurrency_code`, `import_key`) VALUES
(1,	'client test',	'',	1,	NULL,	NULL,	0,	NULL,	1,	'CU2209-00001',	NULL,	NULL,	NULL,	'',	NULL,	NULL,	NULL,	6,	0,	NULL,	NULL,	NULL,	NULL,	'[]',	NULL,	8,	NULL,	NULL,	'',	'',	'',	'',	'',	'',	'',	NULL,	0,	NULL,	NULL,	'',	NULL,	1,	0,	NULL,	'',	0,	NULL,	0,	0,	0,	0,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	1,	NULL,	0.0000,	NULL,	0.0000,	NULL,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	'produit_1.csv',	NULL,	NULL,	NULL,	NULL,	NULL,	'',	'',	'2022-10-11 12:05:13',	'2022-09-09 15:13:43',	1,	1,	0,	'',	NULL),
(2,	'Fournisseur de stores abaques',	'',	1,	NULL,	NULL,	0,	NULL,	1,	NULL,	'SU2209-00001',	NULL,	NULL,	'',	NULL,	NULL,	NULL,	6,	0,	NULL,	NULL,	NULL,	NULL,	'[]',	NULL,	100,	NULL,	NULL,	'',	'',	'',	'',	'',	'',	'',	NULL,	0,	NULL,	NULL,	'',	NULL,	0,	1,	NULL,	'',	0,	NULL,	0,	0,	0,	0,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	1,	NULL,	0.0000,	NULL,	0.0000,	NULL,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'',	'',	'2022-10-11 14:27:57',	'2022-09-28 15:36:17',	1,	1,	0,	'',	NULL),
(13,	'Client particulier',	'',	1,	NULL,	NULL,	0,	NULL,	1,	'CU2210-00002',	NULL,	NULL,	NULL,	'',	NULL,	NULL,	NULL,	6,	0,	NULL,	NULL,	NULL,	NULL,	'[]',	NULL,	8,	NULL,	NULL,	'',	'',	'',	'',	'',	'',	'',	NULL,	0,	NULL,	NULL,	'',	NULL,	1,	0,	NULL,	'',	0,	NULL,	0,	0,	0,	0,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	1,	NULL,	0.0000,	NULL,	0.0000,	NULL,	0,	1,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'',	'',	'2022-10-11 14:26:25',	'2022-10-11 16:26:25',	1,	1,	0,	'',	NULL),
(14,	'Client Pro',	'',	1,	NULL,	NULL,	0,	NULL,	1,	'CU2210-00003',	NULL,	NULL,	NULL,	'',	NULL,	NULL,	NULL,	6,	0,	NULL,	NULL,	NULL,	NULL,	'[]',	NULL,	3,	NULL,	NULL,	'',	'',	'',	'',	'',	'',	'',	NULL,	0,	NULL,	NULL,	'',	NULL,	1,	0,	NULL,	'',	0,	NULL,	0,	0,	0,	0,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	1,	NULL,	0.0000,	NULL,	0.0000,	NULL,	0,	2,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'',	'',	'2022-10-11 14:27:10',	'2022-10-11 16:27:10',	1,	1,	0,	'',	NULL),
(15,	'Client Collectivit??',	'',	1,	NULL,	NULL,	0,	NULL,	1,	'CU2210-00004',	NULL,	NULL,	NULL,	'',	'94000',	'Maison-Alfort',	NULL,	6,	0,	'0606060606',	NULL,	NULL,	'facturation@stormatic.com',	'[]',	NULL,	5,	NULL,	NULL,	'',	'',	'',	'',	'',	'',	'',	NULL,	0,	NULL,	NULL,	'',	NULL,	1,	0,	NULL,	'',	0,	NULL,	0,	0,	0,	0,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	1,	NULL,	0.0000,	NULL,	0.0000,	NULL,	0,	3,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'',	'',	'2022-10-17 14:57:50',	'2022-10-11 16:29:16',	1,	1,	0,	'',	NULL);

DROP TABLE IF EXISTS `llx_societe_account`;
CREATE TABLE `llx_societe_account` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) DEFAULT '1',
  `login` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `pass_encoding` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pass_crypted` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pass_temp` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_soc` int(11) DEFAULT NULL,
  `fk_website` int(11) DEFAULT NULL,
  `site` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `site_account` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `key_account` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `note_private` text COLLATE utf8_unicode_ci,
  `date_last_login` datetime DEFAULT NULL,
  `date_previous_login` datetime DEFAULT NULL,
  `date_creation` datetime NOT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_user_creat` int(11) NOT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_societe_account_login_website_soc` (`entity`,`fk_soc`,`login`,`site`,`fk_website`),
  UNIQUE KEY `uk_societe_account_key_account_soc` (`entity`,`fk_soc`,`key_account`,`site`,`fk_website`),
  KEY `idx_societe_account_rowid` (`rowid`),
  KEY `idx_societe_account_login` (`login`),
  KEY `idx_societe_account_status` (`status`),
  KEY `idx_societe_account_fk_website` (`fk_website`),
  KEY `idx_societe_account_fk_soc` (`fk_soc`),
  CONSTRAINT `llx_societe_account_fk_societe` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`),
  CONSTRAINT `llx_societe_account_fk_website` FOREIGN KEY (`fk_website`) REFERENCES `llx_website` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_societe_address`;
CREATE TABLE `llx_societe_address` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `label` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_soc` int(11) DEFAULT '0',
  `name` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `zip` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `town` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_pays` int(11) DEFAULT '0',
  `phone` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fax` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `note` text COLLATE utf8_unicode_ci,
  `fk_user_creat` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_societe_commerciaux`;
CREATE TABLE `llx_societe_commerciaux` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_soc` int(11) DEFAULT NULL,
  `fk_user` int(11) DEFAULT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_societe_commerciaux` (`fk_soc`,`fk_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_societe_contacts`;
CREATE TABLE `llx_societe_contacts` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `date_creation` datetime NOT NULL,
  `fk_soc` int(11) NOT NULL,
  `fk_c_type_contact` int(11) NOT NULL,
  `fk_socpeople` int(11) NOT NULL,
  `tms` timestamp NULL DEFAULT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `idx_societe_contacts_idx1` (`entity`,`fk_soc`,`fk_c_type_contact`,`fk_socpeople`),
  KEY `fk_societe_contacts_fk_c_type_contact` (`fk_c_type_contact`),
  KEY `fk_societe_contacts_fk_soc` (`fk_soc`),
  KEY `fk_societe_contacts_fk_socpeople` (`fk_socpeople`),
  CONSTRAINT `fk_societe_contacts_fk_c_type_contact` FOREIGN KEY (`fk_c_type_contact`) REFERENCES `llx_c_type_contact` (`rowid`),
  CONSTRAINT `fk_societe_contacts_fk_soc` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`),
  CONSTRAINT `fk_societe_contacts_fk_socpeople` FOREIGN KEY (`fk_socpeople`) REFERENCES `llx_socpeople` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_societe_extrafields`;
CREATE TABLE `llx_societe_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_societe_extrafields` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_societe_perentity`;
CREATE TABLE `llx_societe_perentity` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_soc` int(11) DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `accountancy_code_customer` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `accountancy_code_supplier` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `accountancy_code_sell` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `accountancy_code_buy` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_societe_perentity` (`fk_soc`,`entity`),
  KEY `idx_societe_perentity_fk_soc` (`fk_soc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_societe_prices`;
CREATE TABLE `llx_societe_prices` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_soc` int(11) DEFAULT '0',
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `datec` datetime DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `price_level` tinyint(4) DEFAULT '1',
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_societe_prices` (`rowid`, `fk_soc`, `tms`, `datec`, `fk_user_author`, `price_level`) VALUES
(6,	13,	'2022-10-11 14:26:25',	'2022-10-11 16:26:25',	1,	1),
(7,	14,	'2022-10-11 14:27:10',	'2022-10-11 16:27:10',	1,	2),
(8,	15,	'2022-10-11 14:29:16',	'2022-10-11 16:29:16',	1,	3),
(9,	15,	'2022-10-11 15:38:26',	'2022-10-11 17:38:26',	1,	3);

DROP TABLE IF EXISTS `llx_societe_remise`;
CREATE TABLE `llx_societe_remise` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `fk_soc` int(11) NOT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `datec` datetime DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `remise_client` double(7,4) NOT NULL DEFAULT '0.0000',
  `note` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_societe_remise_except`;
CREATE TABLE `llx_societe_remise_except` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `fk_soc` int(11) NOT NULL,
  `discount_type` int(11) NOT NULL DEFAULT '0',
  `datec` datetime DEFAULT NULL,
  `amount_ht` double(24,8) NOT NULL,
  `amount_tva` double(24,8) NOT NULL DEFAULT '0.00000000',
  `amount_ttc` double(24,8) NOT NULL DEFAULT '0.00000000',
  `tva_tx` double(7,4) NOT NULL DEFAULT '0.0000',
  `vat_src_code` varchar(10) COLLATE utf8_unicode_ci DEFAULT '',
  `fk_user` int(11) NOT NULL,
  `fk_facture_line` int(11) DEFAULT NULL,
  `fk_facture` int(11) DEFAULT NULL,
  `fk_facture_source` int(11) DEFAULT NULL,
  `fk_invoice_supplier_line` int(11) DEFAULT NULL,
  `fk_invoice_supplier` int(11) DEFAULT NULL,
  `fk_invoice_supplier_source` int(11) DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `multicurrency_amount_ht` double(24,8) NOT NULL DEFAULT '0.00000000',
  `multicurrency_amount_tva` double(24,8) NOT NULL DEFAULT '0.00000000',
  `multicurrency_amount_ttc` double(24,8) NOT NULL DEFAULT '0.00000000',
  PRIMARY KEY (`rowid`),
  KEY `idx_societe_remise_except_fk_user` (`fk_user`),
  KEY `idx_societe_remise_except_fk_soc` (`fk_soc`),
  KEY `idx_societe_remise_except_fk_facture_line` (`fk_facture_line`),
  KEY `idx_societe_remise_except_fk_facture` (`fk_facture`),
  KEY `idx_societe_remise_except_fk_facture_source` (`fk_facture_source`),
  KEY `idx_societe_remise_except_discount_type` (`discount_type`),
  KEY `fk_soc_remise_fk_invoice_supplier_line` (`fk_invoice_supplier_line`),
  KEY `fk_societe_remise_fk_invoice_supplier_source` (`fk_invoice_supplier`),
  CONSTRAINT `fk_soc_remise_fk_facture_line` FOREIGN KEY (`fk_facture_line`) REFERENCES `llx_facturedet` (`rowid`),
  CONSTRAINT `fk_soc_remise_fk_invoice_supplier_line` FOREIGN KEY (`fk_invoice_supplier_line`) REFERENCES `llx_facture_fourn_det` (`rowid`),
  CONSTRAINT `fk_soc_remise_fk_soc` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`),
  CONSTRAINT `fk_societe_remise_fk_facture` FOREIGN KEY (`fk_facture`) REFERENCES `llx_facture` (`rowid`),
  CONSTRAINT `fk_societe_remise_fk_facture_source` FOREIGN KEY (`fk_facture_source`) REFERENCES `llx_facture` (`rowid`),
  CONSTRAINT `fk_societe_remise_fk_invoice_supplier` FOREIGN KEY (`fk_invoice_supplier`) REFERENCES `llx_facture_fourn` (`rowid`),
  CONSTRAINT `fk_societe_remise_fk_invoice_supplier_source` FOREIGN KEY (`fk_invoice_supplier`) REFERENCES `llx_facture_fourn` (`rowid`),
  CONSTRAINT `fk_societe_remise_fk_user` FOREIGN KEY (`fk_user`) REFERENCES `llx_user` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_societe_remise_supplier`;
CREATE TABLE `llx_societe_remise_supplier` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `fk_soc` int(11) NOT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `datec` datetime DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `remise_supplier` double(7,4) NOT NULL DEFAULT '0.0000',
  `note` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_societe_rib`;
CREATE TABLE `llx_societe_rib` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'ban',
  `label` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_soc` int(11) NOT NULL,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `bank` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `code_banque` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `code_guichet` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cle_rib` varchar(5) COLLATE utf8_unicode_ci DEFAULT NULL,
  `bic` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `iban_prefix` varchar(34) COLLATE utf8_unicode_ci DEFAULT NULL,
  `domiciliation` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `proprio` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL,
  `owner_address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `default_rib` smallint(6) NOT NULL DEFAULT '0',
  `rum` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_rum` date DEFAULT NULL,
  `frstrecur` varchar(16) COLLATE utf8_unicode_ci DEFAULT 'FRST',
  `last_four` varchar(4) COLLATE utf8_unicode_ci DEFAULT NULL,
  `card_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cvn` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `exp_date_month` int(11) DEFAULT NULL,
  `exp_date_year` int(11) DEFAULT NULL,
  `country_code` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `approved` int(11) DEFAULT '0',
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ending_date` date DEFAULT NULL,
  `max_total_amount_of_all_payments` double(24,8) DEFAULT NULL,
  `preapproval_key` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `starting_date` date DEFAULT NULL,
  `total_amount_of_all_payments` double(24,8) DEFAULT NULL,
  `stripe_card_ref` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `stripe_account` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `comment` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ipaddress` varchar(68) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT '1',
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_societe_rib` (`label`,`fk_soc`),
  KEY `llx_societe_rib_fk_societe` (`fk_soc`),
  CONSTRAINT `llx_societe_rib_fk_societe` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_socpeople`;
CREATE TABLE `llx_socpeople` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_soc` int(11) DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `ref_ext` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `civility` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lastname` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `firstname` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `zip` varchar(25) COLLATE utf8_unicode_ci DEFAULT NULL,
  `town` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_departement` int(11) DEFAULT NULL,
  `fk_pays` int(11) DEFAULT '0',
  `birthday` date DEFAULT NULL,
  `poste` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_perso` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_mobile` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fax` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `socialnetworks` text COLLATE utf8_unicode_ci,
  `photo` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `no_email` smallint(6) NOT NULL DEFAULT '0',
  `priv` smallint(6) NOT NULL DEFAULT '0',
  `fk_prospectcontactlevel` varchar(12) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_stcommcontact` int(11) NOT NULL DEFAULT '0',
  `fk_user_creat` int(11) DEFAULT '0',
  `fk_user_modif` int(11) DEFAULT NULL,
  `note_private` text COLLATE utf8_unicode_ci,
  `note_public` text COLLATE utf8_unicode_ci,
  `default_lang` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `canvas` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `statut` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`rowid`),
  KEY `idx_socpeople_fk_soc` (`fk_soc`),
  KEY `idx_socpeople_fk_user_creat` (`fk_user_creat`),
  CONSTRAINT `fk_socpeople_fk_soc` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`),
  CONSTRAINT `fk_socpeople_user_creat_user_rowid` FOREIGN KEY (`fk_user_creat`) REFERENCES `llx_user` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_socpeople` (`rowid`, `datec`, `tms`, `fk_soc`, `entity`, `ref_ext`, `civility`, `lastname`, `firstname`, `address`, `zip`, `town`, `fk_departement`, `fk_pays`, `birthday`, `poste`, `phone`, `phone_perso`, `phone_mobile`, `fax`, `email`, `socialnetworks`, `photo`, `no_email`, `priv`, `fk_prospectcontactlevel`, `fk_stcommcontact`, `fk_user_creat`, `fk_user_modif`, `note_private`, `note_public`, `default_lang`, `canvas`, `import_key`, `statut`) VALUES
(1,	'2022-10-17 16:53:08',	'2022-10-17 14:54:48',	15,	1,	NULL,	'MME',	'Client de facturation Collectivit??',	'Lisa',	'2 Rue Louis Pergaud\r\n94000 Maison-Alfort',	'',	'',	NULL,	6,	NULL,	'Comptable',	'',	'',	'',	'',	'',	'[]',	'',	0,	0,	'',	0,	1,	1,	'',	'',	NULL,	NULL,	NULL,	1);

DROP TABLE IF EXISTS `llx_socpeople_extrafields`;
CREATE TABLE `llx_socpeople_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_socpeople_extrafields` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_stock_mouvement`;
CREATE TABLE `llx_stock_mouvement` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `datem` datetime DEFAULT NULL,
  `fk_product` int(11) NOT NULL,
  `batch` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `eatby` date DEFAULT NULL,
  `sellby` date DEFAULT NULL,
  `fk_entrepot` int(11) NOT NULL,
  `value` double DEFAULT NULL,
  `price` double(24,8) DEFAULT '0.00000000',
  `type_mouvement` smallint(6) DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `label` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `inventorycode` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_project` int(11) DEFAULT NULL,
  `fk_origin` int(11) DEFAULT NULL,
  `origintype` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `model_pdf` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_projet` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`rowid`),
  KEY `idx_stock_mouvement_fk_product` (`fk_product`),
  KEY `idx_stock_mouvement_fk_entrepot` (`fk_entrepot`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_stormatic_csv`;
CREATE TABLE `llx_stormatic_csv` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `ref` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT '(PROV)',
  `price` double NOT NULL,
  `width` int(11) NOT NULL,
  `height` int(11) NOT NULL,
  `filepath` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `import_date` datetime NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci NOT NULL,
  `fk_product` int(11) NOT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_stormatic_csv_rowid` (`rowid`),
  KEY `idx_stormatic_csv_ref` (`ref`),
  KEY `idx_stormatic_csv_fk_product` (`fk_product`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_stormatic_csv` (`rowid`, `ref`, `price`, `width`, `height`, `filepath`, `import_date`, `import_key`, `fk_product`) VALUES
(18,	'Product1',	200,	300,	400,	'20221018152049-20221017225521-202210-AbaqueProduit.csv',	'2022-10-18 17:09:29',	'20221018170929',	355),
(19,	'Product1',	300,	300,	500,	'20221018152049-20221017225521-202210-AbaqueProduit.csv',	'2022-10-18 17:09:29',	'20221018170929',	355),
(20,	'Product1',	400,	400,	300,	'20221018152049-20221017225521-202210-AbaqueProduit.csv',	'2022-10-18 17:09:29',	'20221018170929',	355),
(21,	'Product1',	500,	400,	400,	'20221018152049-20221017225521-202210-AbaqueProduit.csv',	'2022-10-18 17:09:29',	'20221018170929',	355),
(22,	'Product1',	600,	400,	500,	'20221018152049-20221017225521-202210-AbaqueProduit.csv',	'2022-10-18 17:09:29',	'20221018170929',	355),
(23,	'test-produit',	1000,	600,	600,	'20221018152049-20221017225521-202210-AbaqueProduit.csv',	'2022-10-18 17:09:29',	'20221018170929',	356),
(24,	'test-produit',	1500,	600,	800,	'20221018152049-20221017225521-202210-AbaqueProduit.csv',	'2022-10-18 17:09:29',	'20221018170929',	356),
(25,	'test-produit',	2000,	600,	1000,	'20221018152049-20221017225521-202210-AbaqueProduit.csv',	'2022-10-18 17:09:29',	'20221018170929',	356);

DROP TABLE IF EXISTS `llx_stormatic_csv_extrafields`;
CREATE TABLE `llx_stormatic_csv_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT NULL,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_csv_fk_object` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_subscription`;
CREATE TABLE `llx_subscription` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `datec` datetime DEFAULT NULL,
  `fk_adherent` int(11) DEFAULT NULL,
  `fk_type` int(11) DEFAULT NULL,
  `dateadh` datetime DEFAULT NULL,
  `datef` datetime DEFAULT NULL,
  `subscription` double(24,8) DEFAULT NULL,
  `fk_bank` int(11) DEFAULT NULL,
  `fk_user_creat` int(11) DEFAULT NULL,
  `fk_user_valid` int(11) DEFAULT NULL,
  `note` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_subscription` (`fk_adherent`,`dateadh`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_supplier_proposal`;
CREATE TABLE `llx_supplier_proposal` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `ref` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `ref_ext` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ref_int` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_soc` int(11) DEFAULT NULL,
  `fk_projet` int(11) DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `datec` datetime DEFAULT NULL,
  `date_valid` datetime DEFAULT NULL,
  `date_cloture` datetime DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `fk_user_valid` int(11) DEFAULT NULL,
  `fk_user_cloture` int(11) DEFAULT NULL,
  `fk_statut` smallint(6) NOT NULL DEFAULT '0',
  `price` double DEFAULT '0',
  `remise_percent` double DEFAULT '0',
  `remise_absolue` double DEFAULT '0',
  `remise` double DEFAULT '0',
  `total_ht` double(24,8) DEFAULT '0.00000000',
  `total_tva` double(24,8) DEFAULT '0.00000000',
  `localtax1` double(24,8) DEFAULT '0.00000000',
  `localtax2` double(24,8) DEFAULT '0.00000000',
  `total_ttc` double(24,8) DEFAULT '0.00000000',
  `fk_account` int(11) DEFAULT NULL,
  `fk_currency` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_cond_reglement` int(11) DEFAULT NULL,
  `fk_mode_reglement` int(11) DEFAULT NULL,
  `note_private` text COLLATE utf8_unicode_ci,
  `note_public` text COLLATE utf8_unicode_ci,
  `model_pdf` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_main_doc` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_livraison` date DEFAULT NULL,
  `fk_shipping_method` int(11) DEFAULT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `extraparams` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_multicurrency` int(11) DEFAULT NULL,
  `multicurrency_code` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `multicurrency_tx` double(24,8) DEFAULT '1.00000000',
  `multicurrency_total_ht` double(24,8) DEFAULT '0.00000000',
  `multicurrency_total_tva` double(24,8) DEFAULT '0.00000000',
  `multicurrency_total_ttc` double(24,8) DEFAULT '0.00000000',
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_supplier_proposaldet`;
CREATE TABLE `llx_supplier_proposaldet` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_supplier_proposal` int(11) NOT NULL,
  `fk_parent_line` int(11) DEFAULT NULL,
  `fk_product` int(11) DEFAULT NULL,
  `label` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `fk_remise_except` int(11) DEFAULT NULL,
  `vat_src_code` varchar(10) COLLATE utf8_unicode_ci DEFAULT '',
  `tva_tx` double(7,4) DEFAULT '0.0000',
  `localtax1_tx` double(7,4) DEFAULT '0.0000',
  `localtax1_type` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `localtax2_tx` double(7,4) DEFAULT '0.0000',
  `localtax2_type` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `qty` double DEFAULT NULL,
  `remise_percent` double DEFAULT '0',
  `remise` double DEFAULT '0',
  `price` double DEFAULT NULL,
  `subprice` double(24,8) DEFAULT '0.00000000',
  `total_ht` double(24,8) DEFAULT '0.00000000',
  `total_tva` double(24,8) DEFAULT '0.00000000',
  `total_localtax1` double(24,8) DEFAULT '0.00000000',
  `total_localtax2` double(24,8) DEFAULT '0.00000000',
  `total_ttc` double(24,8) DEFAULT '0.00000000',
  `product_type` int(11) DEFAULT '0',
  `date_start` datetime DEFAULT NULL,
  `date_end` datetime DEFAULT NULL,
  `info_bits` int(11) DEFAULT '0',
  `buy_price_ht` double(24,8) DEFAULT '0.00000000',
  `fk_product_fournisseur_price` int(11) DEFAULT NULL,
  `special_code` int(11) DEFAULT '0',
  `rang` int(11) DEFAULT '0',
  `ref_fourn` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_multicurrency` int(11) DEFAULT NULL,
  `multicurrency_code` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `multicurrency_subprice` double(24,8) DEFAULT '0.00000000',
  `multicurrency_total_ht` double(24,8) DEFAULT '0.00000000',
  `multicurrency_total_tva` double(24,8) DEFAULT '0.00000000',
  `multicurrency_total_ttc` double(24,8) DEFAULT '0.00000000',
  `fk_unit` int(11) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_supplier_proposaldet_fk_supplier_proposal` (`fk_supplier_proposal`),
  KEY `idx_supplier_proposaldet_fk_product` (`fk_product`),
  KEY `fk_supplier_proposaldet_fk_unit` (`fk_unit`),
  CONSTRAINT `fk_supplier_proposaldet_fk_supplier_proposal` FOREIGN KEY (`fk_supplier_proposal`) REFERENCES `llx_supplier_proposal` (`rowid`),
  CONSTRAINT `fk_supplier_proposaldet_fk_unit` FOREIGN KEY (`fk_unit`) REFERENCES `llx_c_units` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_supplier_proposaldet_extrafields`;
CREATE TABLE `llx_supplier_proposaldet_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `show_total_ht` int(10) DEFAULT NULL,
  `show_reduc` int(10) DEFAULT NULL,
  `subtotal_show_qty` int(10) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_supplier_proposaldet_extrafields` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_supplier_proposal_extrafields`;
CREATE TABLE `llx_supplier_proposal_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_supplier_proposal_extrafields` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_takepos_floor_tables`;
CREATE TABLE `llx_takepos_floor_tables` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `label` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `leftpos` float DEFAULT NULL,
  `toppos` float DEFAULT NULL,
  `floor` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_ticket`;
CREATE TABLE `llx_ticket` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) DEFAULT '1',
  `ref` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `track_id` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `fk_soc` int(11) DEFAULT '0',
  `fk_project` int(11) DEFAULT '0',
  `origin_email` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_user_create` int(11) DEFAULT NULL,
  `fk_user_assign` int(11) DEFAULT NULL,
  `subject` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `message` text COLLATE utf8_unicode_ci,
  `fk_statut` int(11) DEFAULT NULL,
  `resolution` int(11) DEFAULT NULL,
  `progress` int(11) DEFAULT '0',
  `timing` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type_code` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `category_code` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `severity_code` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `datec` datetime DEFAULT NULL,
  `date_read` datetime DEFAULT NULL,
  `date_close` datetime DEFAULT NULL,
  `notify_tiers_at_create` tinyint(4) DEFAULT NULL,
  `email_msgid` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_ticket_track_id` (`track_id`),
  UNIQUE KEY `uk_ticket_ref` (`ref`,`entity`),
  KEY `idx_ticket_entity` (`entity`),
  KEY `idx_ticket_fk_soc` (`fk_soc`),
  KEY `idx_ticket_fk_user_assign` (`fk_user_assign`),
  KEY `idx_ticket_fk_project` (`fk_project`),
  KEY `idx_ticket_fk_statut` (`fk_statut`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_ticket_extrafields`;
CREATE TABLE `llx_ticket_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_ticket_extrafields` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_tva`;
CREATE TABLE `llx_tva` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `datec` datetime DEFAULT NULL,
  `datep` date DEFAULT NULL,
  `datev` date DEFAULT NULL,
  `amount` double(24,8) NOT NULL DEFAULT '0.00000000',
  `fk_typepayment` int(11) DEFAULT NULL,
  `num_payment` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `label` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `note` text COLLATE utf8_unicode_ci,
  `paye` smallint(6) NOT NULL DEFAULT '0',
  `fk_account` int(11) DEFAULT NULL,
  `fk_user_creat` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_user`;
CREATE TABLE `llx_user` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `ref_ext` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ref_int` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `admin` smallint(6) DEFAULT '0',
  `employee` tinyint(4) DEFAULT '1',
  `fk_establishment` int(11) DEFAULT '0',
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_user_creat` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `login` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `pass_encoding` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pass` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pass_crypted` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pass_temp` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `api_key` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gender` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `civility` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lastname` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `firstname` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `zip` varchar(25) COLLATE utf8_unicode_ci DEFAULT NULL,
  `town` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_state` int(11) DEFAULT '0',
  `fk_country` int(11) DEFAULT '0',
  `birth` date DEFAULT NULL,
  `job` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `office_phone` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `office_fax` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_mobile` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `personal_mobile` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `personal_email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `signature` text COLLATE utf8_unicode_ci,
  `socialnetworks` text COLLATE utf8_unicode_ci,
  `fk_soc` int(11) DEFAULT NULL,
  `fk_socpeople` int(11) DEFAULT NULL,
  `fk_member` int(11) DEFAULT NULL,
  `fk_user` int(11) DEFAULT NULL,
  `fk_user_expense_validator` int(11) DEFAULT NULL,
  `fk_user_holiday_validator` int(11) DEFAULT NULL,
  `idpers1` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `idpers2` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `idpers3` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `note_public` text COLLATE utf8_unicode_ci,
  `note` text COLLATE utf8_unicode_ci,
  `model_pdf` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `datelastlogin` datetime DEFAULT NULL,
  `datepreviouslogin` datetime DEFAULT NULL,
  `datelastpassvalidation` datetime DEFAULT NULL,
  `datestartvalidity` datetime DEFAULT NULL,
  `dateendvalidity` datetime DEFAULT NULL,
  `iplastlogin` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ippreviouslogin` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `egroupware_id` int(11) DEFAULT NULL,
  `ldap_sid` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `openid` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `statut` tinyint(4) DEFAULT '1',
  `photo` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lang` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `color` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `barcode` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_barcode_type` int(11) DEFAULT '0',
  `accountancy_code` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nb_holiday` int(11) DEFAULT '0',
  `thm` double(24,8) DEFAULT NULL,
  `tjm` double(24,8) DEFAULT NULL,
  `salary` double(24,8) DEFAULT NULL,
  `salaryextra` double(24,8) DEFAULT NULL,
  `dateemployment` date DEFAULT NULL,
  `dateemploymentend` date DEFAULT NULL,
  `weeklyhours` double(16,8) DEFAULT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `default_range` int(11) DEFAULT NULL,
  `default_c_exp_tax_cat` int(11) DEFAULT NULL,
  `fk_warehouse` int(11) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_user_login` (`login`,`entity`),
  UNIQUE KEY `uk_user_fk_socpeople` (`fk_socpeople`),
  UNIQUE KEY `uk_user_fk_member` (`fk_member`),
  UNIQUE KEY `uk_user_api_key` (`api_key`),
  KEY `idx_user_fk_societe` (`fk_soc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_user` (`rowid`, `entity`, `ref_ext`, `ref_int`, `admin`, `employee`, `fk_establishment`, `datec`, `tms`, `fk_user_creat`, `fk_user_modif`, `login`, `pass_encoding`, `pass`, `pass_crypted`, `pass_temp`, `api_key`, `gender`, `civility`, `lastname`, `firstname`, `address`, `zip`, `town`, `fk_state`, `fk_country`, `birth`, `job`, `office_phone`, `office_fax`, `user_mobile`, `personal_mobile`, `email`, `personal_email`, `signature`, `socialnetworks`, `fk_soc`, `fk_socpeople`, `fk_member`, `fk_user`, `fk_user_expense_validator`, `fk_user_holiday_validator`, `idpers1`, `idpers2`, `idpers3`, `note_public`, `note`, `model_pdf`, `datelastlogin`, `datepreviouslogin`, `datelastpassvalidation`, `datestartvalidity`, `dateendvalidity`, `iplastlogin`, `ippreviouslogin`, `egroupware_id`, `ldap_sid`, `openid`, `statut`, `photo`, `lang`, `color`, `barcode`, `fk_barcode_type`, `accountancy_code`, `nb_holiday`, `thm`, `tjm`, `salary`, `salaryextra`, `dateemployment`, `dateemploymentend`, `weeklyhours`, `import_key`, `default_range`, `default_c_exp_tax_cat`, `fk_warehouse`) VALUES
(1,	0,	NULL,	NULL,	1,	1,	0,	'2022-09-06 10:07:15',	'2023-01-20 10:26:36',	NULL,	NULL,	'valentino',	NULL,	NULL,	'$2y$10$aNLC/QT8p/awuWZr2m0Kf.bQdlp4I8IXaPo7iuAwmoGXZW3VPpyc2',	NULL,	'k07CGhhpMv9OzDFVmBqWZ4Q2h73h531k',	NULL,	'',	'SuperAdmin',	'',	'',	'',	'',	NULL,	NULL,	NULL,	'',	'',	'',	'',	'',	'',	'',	'',	'[]',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'',	'',	NULL,	'2023-01-20 10:26:45',	'2022-10-24 14:11:25',	NULL,	'2022-09-13 00:00:00',	'2023-10-30 00:00:00',	NULL,	NULL,	NULL,	'',	NULL,	1,	NULL,	NULL,	'',	NULL,	0,	'',	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);

DROP TABLE IF EXISTS `llx_usergroup`;
CREATE TABLE `llx_usergroup` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(180) COLLATE utf8_unicode_ci NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `note` text COLLATE utf8_unicode_ci,
  `model_pdf` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_usergroup_name` (`nom`,`entity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_usergroup_extrafields`;
CREATE TABLE `llx_usergroup_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_usergroup_extrafields` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_usergroup_rights`;
CREATE TABLE `llx_usergroup_rights` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `fk_usergroup` int(11) NOT NULL,
  `fk_id` int(11) NOT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_usergroup_rights` (`entity`,`fk_usergroup`,`fk_id`),
  KEY `fk_usergroup_rights_fk_usergroup` (`fk_usergroup`),
  CONSTRAINT `fk_usergroup_rights_fk_usergroup` FOREIGN KEY (`fk_usergroup`) REFERENCES `llx_usergroup` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_usergroup_user`;
CREATE TABLE `llx_usergroup_user` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `fk_user` int(11) NOT NULL,
  `fk_usergroup` int(11) NOT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_usergroup_user` (`entity`,`fk_user`,`fk_usergroup`),
  KEY `fk_usergroup_user_fk_user` (`fk_user`),
  KEY `fk_usergroup_user_fk_usergroup` (`fk_usergroup`),
  CONSTRAINT `fk_usergroup_user_fk_user` FOREIGN KEY (`fk_user`) REFERENCES `llx_user` (`rowid`),
  CONSTRAINT `fk_usergroup_user_fk_usergroup` FOREIGN KEY (`fk_usergroup`) REFERENCES `llx_usergroup` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_user_alert`;
CREATE TABLE `llx_user_alert` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) DEFAULT NULL,
  `fk_contact` int(11) DEFAULT NULL,
  `fk_user` int(11) DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_user_clicktodial`;
CREATE TABLE `llx_user_clicktodial` (
  `fk_user` int(11) NOT NULL,
  `url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `login` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pass` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `poste` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`fk_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_user_employment`;
CREATE TABLE `llx_user_employment` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `ref` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ref_ext` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_user` int(11) DEFAULT NULL,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_user_creat` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `job` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` int(11) NOT NULL,
  `salary` double(24,8) DEFAULT NULL,
  `salaryextra` double(24,8) DEFAULT NULL,
  `weeklyhours` double(16,8) DEFAULT NULL,
  `dateemployment` date DEFAULT NULL,
  `dateemploymentend` date DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_user_employment` (`ref`,`entity`),
  KEY `fk_user_employment_fk_user` (`fk_user`),
  CONSTRAINT `fk_user_employment_fk_user` FOREIGN KEY (`fk_user`) REFERENCES `llx_user` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_user_extrafields`;
CREATE TABLE `llx_user_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_user_extrafields` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_user_param`;
CREATE TABLE `llx_user_param` (
  `fk_user` int(11) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `param` varchar(180) COLLATE utf8_unicode_ci NOT NULL,
  `value` text COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `uk_user_param` (`fk_user`,`param`,`entity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_user_param` (`fk_user`, `entity`, `param`, `value`) VALUES
(1,	1,	'MAIN_SELECTEDFIELDS_csvlist',	't.filename,t.date_creation,'),
(1,	1,	'MAIN_SELECTEDFIELDS_residencelist',	't.status,t.fk_project,t.pseudo,t.fk_soc,');

DROP TABLE IF EXISTS `llx_user_rib`;
CREATE TABLE `llx_user_rib` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_user` int(11) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `label` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `bank` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `code_banque` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `code_guichet` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cle_rib` varchar(5) COLLATE utf8_unicode_ci DEFAULT NULL,
  `bic` varchar(11) COLLATE utf8_unicode_ci DEFAULT NULL,
  `iban_prefix` varchar(34) COLLATE utf8_unicode_ci DEFAULT NULL,
  `domiciliation` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `proprio` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL,
  `owner_address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_user_rights`;
CREATE TABLE `llx_user_rights` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `fk_user` int(11) NOT NULL,
  `fk_id` int(11) NOT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_user_rights` (`entity`,`fk_user`,`fk_id`),
  KEY `fk_user_rights_fk_user_user` (`fk_user`),
  CONSTRAINT `fk_user_rights_fk_user_user` FOREIGN KEY (`fk_user`) REFERENCES `llx_user` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `llx_user_rights` (`rowid`, `entity`, `fk_user`, `fk_id`) VALUES
(1632,	1,	1,	11),
(1633,	1,	1,	12),
(1634,	1,	1,	13),
(1635,	1,	1,	14),
(1636,	1,	1,	15),
(1637,	1,	1,	16),
(1638,	1,	1,	19),
(1639,	1,	1,	21),
(1640,	1,	1,	22),
(1641,	1,	1,	24),
(1642,	1,	1,	25),
(1643,	1,	1,	26),
(1644,	1,	1,	27),
(1645,	1,	1,	28),
(1646,	1,	1,	31),
(1647,	1,	1,	32),
(1648,	1,	1,	34),
(1649,	1,	1,	38),
(1650,	1,	1,	39),
(234,	1,	1,	41),
(231,	1,	1,	42),
(233,	1,	1,	44),
(235,	1,	1,	45),
(1651,	1,	1,	81),
(1652,	1,	1,	82),
(1653,	1,	1,	84),
(1654,	1,	1,	86),
(1655,	1,	1,	87),
(1656,	1,	1,	88),
(1657,	1,	1,	89),
(1658,	1,	1,	91),
(1659,	1,	1,	92),
(1660,	1,	1,	93),
(1661,	1,	1,	94),
(1662,	1,	1,	101),
(1663,	1,	1,	102),
(1664,	1,	1,	104),
(1665,	1,	1,	105),
(1666,	1,	1,	106),
(1667,	1,	1,	109),
(1668,	1,	1,	121),
(1669,	1,	1,	122),
(1670,	1,	1,	125),
(1671,	1,	1,	126),
(1672,	1,	1,	130),
(239,	1,	1,	141),
(238,	1,	1,	142),
(240,	1,	1,	144),
(1673,	1,	1,	241),
(1674,	1,	1,	242),
(1675,	1,	1,	243),
(1676,	1,	1,	251),
(1677,	1,	1,	252),
(1678,	1,	1,	253),
(1679,	1,	1,	254),
(1680,	1,	1,	255),
(1681,	1,	1,	256),
(1682,	1,	1,	262),
(1683,	1,	1,	281),
(1684,	1,	1,	282),
(1685,	1,	1,	283),
(1686,	1,	1,	286),
(1687,	1,	1,	341),
(1688,	1,	1,	342),
(1689,	1,	1,	343),
(1690,	1,	1,	344),
(1691,	1,	1,	351),
(1692,	1,	1,	352),
(1693,	1,	1,	353),
(1694,	1,	1,	354),
(1695,	1,	1,	358),
(1696,	1,	1,	531),
(1697,	1,	1,	532),
(1698,	1,	1,	534),
(1699,	1,	1,	538),
(1700,	1,	1,	1001),
(1701,	1,	1,	1002),
(1702,	1,	1,	1003),
(1703,	1,	1,	1004),
(1704,	1,	1,	1005),
(1705,	1,	1,	1011),
(1706,	1,	1,	1012),
(1707,	1,	1,	1101),
(1708,	1,	1,	1102),
(1709,	1,	1,	1104),
(1710,	1,	1,	1109),
(1711,	1,	1,	1121),
(1712,	1,	1,	1122),
(1713,	1,	1,	1123),
(1714,	1,	1,	1124),
(1715,	1,	1,	1125),
(1716,	1,	1,	1126),
(1717,	1,	1,	1181),
(1718,	1,	1,	1182),
(1719,	1,	1,	1183),
(1720,	1,	1,	1184),
(1721,	1,	1,	1185),
(1722,	1,	1,	1186),
(1723,	1,	1,	1187),
(1724,	1,	1,	1188),
(1725,	1,	1,	1189),
(1726,	1,	1,	1191),
(1727,	1,	1,	1201),
(1728,	1,	1,	1202),
(1729,	1,	1,	1231),
(1730,	1,	1,	1232),
(1731,	1,	1,	1233),
(1732,	1,	1,	1234),
(1733,	1,	1,	1235),
(1734,	1,	1,	1236),
(1735,	1,	1,	1251),
(1736,	1,	1,	1321),
(1737,	1,	1,	1322),
(1738,	1,	1,	1421),
(1739,	1,	1,	2610),
(1740,	1,	1,	3301),
(1741,	1,	1,	59001),
(1742,	1,	1,	59002),
(1743,	1,	1,	59003),
(157,	1,	1,	160310),
(156,	1,	1,	160311),
(158,	1,	1,	160312),
(1744,	1,	1,	220810),
(1745,	1,	1,	220811),
(1746,	1,	1,	220812),
(1747,	1,	1,	220813),
(1748,	1,	1,	220814),
(1749,	1,	1,	220815),
(1949,	1,	1,	50000001),
(1946,	1,	1,	50000002),
(1948,	1,	1,	50000003),
(1950,	1,	1,	50000004),
(1754,	1,	1,	125033001);

DROP TABLE IF EXISTS `llx_website`;
CREATE TABLE `llx_website` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `type_container` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'page',
  `entity` int(11) NOT NULL DEFAULT '1',
  `ref` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `maincolor` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  `maincolorbis` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lang` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `otherlang` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` int(11) DEFAULT '1',
  `fk_default_home` int(11) DEFAULT NULL,
  `use_manifest` int(11) DEFAULT NULL,
  `virtualhost` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_user_creat` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `date_creation` datetime DEFAULT NULL,
  `position` int(11) DEFAULT '0',
  `lastaccess` datetime DEFAULT NULL,
  `pageviews_month` bigint(20) unsigned DEFAULT '0',
  `pageviews_total` bigint(20) unsigned DEFAULT '0',
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_website_ref` (`ref`,`entity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_website_extrafields`;
CREATE TABLE `llx_website_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_website_extrafields` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_website_page`;
CREATE TABLE `llx_website_page` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_website` int(11) NOT NULL,
  `type_container` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'page',
  `pageurl` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `aliasalt` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `keywords` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lang` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_page` int(11) DEFAULT NULL,
  `allowed_in_frames` int(11) DEFAULT '0',
  `htmlheader` text COLLATE utf8_unicode_ci,
  `content` mediumtext COLLATE utf8_unicode_ci,
  `status` int(11) DEFAULT '1',
  `grabbed_from` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_user_creat` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `author_alias` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_creation` datetime DEFAULT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `object_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_object` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_website_page_url` (`fk_website`,`pageurl`),
  CONSTRAINT `fk_website_page_website` FOREIGN KEY (`fk_website`) REFERENCES `llx_website` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_workstation_workstation`;
CREATE TABLE `llx_workstation_workstation` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `ref` varchar(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '(PROV)',
  `label` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` varchar(7) COLLATE utf8_unicode_ci DEFAULT NULL,
  `note_public` text COLLATE utf8_unicode_ci,
  `entity` int(11) DEFAULT '1',
  `note_private` text COLLATE utf8_unicode_ci,
  `date_creation` datetime NOT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_user_creat` int(11) NOT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` smallint(6) NOT NULL,
  `nb_operators_required` int(11) DEFAULT NULL,
  `thm_operator_estimated` double DEFAULT NULL,
  `thm_machine_estimated` double DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_workstation_workstation_rowid` (`rowid`),
  KEY `idx_workstation_workstation_ref` (`ref`),
  KEY `fk_workstation_workstation_fk_user_creat` (`fk_user_creat`),
  KEY `idx_workstation_workstation_status` (`status`),
  CONSTRAINT `fk_workstation_workstation_fk_user_creat` FOREIGN KEY (`fk_user_creat`) REFERENCES `llx_user` (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_workstation_workstation_resource`;
CREATE TABLE `llx_workstation_workstation_resource` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_resource` int(11) DEFAULT NULL,
  `fk_workstation` int(11) DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_workstation_workstation_usergroup`;
CREATE TABLE `llx_workstation_workstation_usergroup` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_usergroup` int(11) DEFAULT NULL,
  `fk_workstation` int(11) DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `llx_zapier_hook`;
CREATE TABLE `llx_zapier_hook` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `event` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `module` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `action` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `date_creation` datetime NOT NULL,
  `fk_user` int(11) NOT NULL,
  `tms` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `import_key` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- 2023-01-27 17:17:05

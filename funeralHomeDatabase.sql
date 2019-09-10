DROP DATABASE IF EXISTS FuneralPolicy;
CREATE DATABASE FuneralPolicy;
USE FuneralPolicy;


CREATE TABLE `ci_customer_profile` (
	  `ID_number` int(13) NOT NULL,
	  `policy_number` int(11) NOT NULL,
	  `first_name` text NOT NULL,
	  `last_name` text NOT NULL,
	  `age` int(11) NOT NULL,
	  `date_of_birth` date NOT NULL,
	  `residential_address` text NOT NULL,
	  `date_customer_opened` date NOT NULL,
	  `customer_city` text NOT NULL,
	  `customer_country` text NOT NULL,
	  `customer_zip` int(11) NOT NULL,
	  `customer_phone` int(11) NOT NULL,
	  `customer_email` text NOT NULL,
	  `customer_sex` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


INSERT INTO `ci_customer_profile` (`ID_number`, `policy_number`, `first_name`, `last_name`, `age`, `date_of_birth`, `residential_address`, `date_customer_opened`, `customer_city`, `customer_country`, `customer_zip`, `customer_phone`, `customer_email`, `customer_sex`) VALUES
	(1130900012, 482604829, 'Jack', 'Black', 32, '1987-01-01', '1 11th Avenue, Boston, Bellville', '2008-02-15', 'Cape Town', 'South Africa', 7530, 0716037595, 'jblack@gmail.com', 'M'),
	(1130900015, 593715930, 'Jani', 'van Niekerk', 34, '1985-03-27', '16 17th Avenue, Boston, Bellville', '2005-06-19', 'Cape Town', 'South Africa', 7530, 0833269588, 'janivann@gmail.com', 'F'),
	(2112034063, 604826041, 'Jonathan ', 'Kay', 45, '1974-09-12', '12 Jono Rd, Paarl', '1996-03-13', 'Cape Town', 'South Africa', 7600, 0723829174, 'jonathankay45@gmail.com', 'M'),
	(2145675555, 715937152, 'Sarah', 'Feldman', 39, '1980-01-31', '12 Gardens Avenue, Woodstock', '2015-12-15', 'Cape Town', 'South Africa', 5650, 0716045396, 'sarahfeldman@yahoo.com', 'F');

CREATE TABLE `col_trans_log` (
	  `transaction_ref_number` int(11) NOT NULL,
	  `source_id` varchar(60) NOT NULL,
	  `policy_number` int(11) NOT NULL,
	  `payment_status` varchar(2) NOT NULL DEFAULT 'U',
	  `transaction_date` date NOT NULL,
	  `transaction_amount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `col_trans_log` (`transaction_ref_number`,  `source_id`, `policy_number`, `payment_status`, `transaction_date`, `transaction_amount`) VALUES
	(1607315, '306_065928_20180928_2218_1', 482604829, 'U', '2019-05-01', 250),
	(2756226, '310_085511_20181002_2218_1', 593715930, 'U', '2019-05-01', 550),
	(3895137, '310_085511_20181002_2218_1', 604826041, 'U', '2019-05-01', 4000),
	(4984048, '310_085511_20181002_2218_1', 715937152, 'U', '2019-05-01', 200);

CREATE TABLE `cover_product` (
	  `cover_number` int(11) NOT NULL,
	  `cover_description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `cover_product` (`cover_number`, `cover_description`) VALUES
(1, 'Cover for unexpected disability'),
(2, 'Death Cover');

CREATE TABLE `fn_policy_mast` (
  `policy_number` int(11) NOT NULL,
  `monthly_premium` int(11) NOT NULL,
  `policy_benefit` text NOT NULL,
  `payment_type` text NOT NULL,
  `tot_amount_paid` int(11) NOT NULL,
  `last_payment_type` text NOT NULL,
  `waiting_period` int(11) NOT NULL,
  `balance` int(11) NOT NULL,
  `total_accrued` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `fn_policy_mast` (`policy_number`, `monthly_premium`, `policy_benefit`, `payment_type`, `tot_amount_paid`, `last_payment_type`, `waiting_period`, `balance`, `total_accrued`) VALUES
(482604829, 250, 'Funeral Cover', 'Debit Order', 500, 'Credit', 10, 400, 0),
(593715930, 550, 'Funeral and Life Insurance', 'Cash', 1100, 'Credit', 26, 950, 0),
(604826041, 4000, 'Medical Insurance, Funeral Cover and Life Insurance', 'Debit Order', 40000, 'Credit', 6, 35000, 15000),
(715937152, 200, 'Funeral Cover', 'Cash', 2000, 'Credit', 19, 1700, 0);

CREATE TABLE `sys_notif_msg` (
  `message_ID` int(30) NULL,
  `policy_number` int(11) NULL,
  `ID_number` int(13) NULL,
  `customer_name` varchar(30) NULL,
  `customer_phone` int(11) NULL,
  `amount` int(11) NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `sys_notif_msg` (`message_ID`, `policy_number`, `ID_number`, `customer_name`,  `customer_phone`, `amount`) VALUES
(1, 482604829, 1130900012, 'Jack Black', 0716037595, 1600),
(2, 604826041, 2112034063, 'Jonathan Kay', 0723829174, 1250),
(3, 593715930, 1130900015, 'Jani van Niekerk', 0833269588, 4000),
(4, 715937152, 2145675555, 'Sarah Feldman', 0716045396, 2500);

ALTER TABLE `ci_customer_profile`
  ADD PRIMARY KEY (`ID_number`),
  ADD UNIQUE KEY `customer_phone` (`customer_phone`),
  ADD KEY `FK_policy_number` (`policy_number`);

ALTER TABLE `col_trans_log`
  ADD PRIMARY KEY (`transaction_ref_number`),
  ADD KEY `policy_number` (`policy_number`);

ALTER TABLE `cover_product`
  ADD PRIMARY KEY (`cover_number`);

ALTER TABLE `fn_policy_mast`
  ADD PRIMARY KEY (`policy_number`);

ALTER TABLE `sys_notif_msg`
  ADD PRIMARY KEY (`message_ID`),
  ADD KEY `policy_number` (`policy_number`),
  ADD KEY `ID_number` (`ID_number`),
  ADD KEY `customer_phone` (`customer_phone`);

ALTER TABLE `sys_notif_msg`
  MODIFY `message_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

ALTER TABLE `ci_customer_profile`
  ADD CONSTRAINT `FK_policy_number` FOREIGN KEY (`policy_number`) REFERENCES `fn_policy_mast` (`policy_number`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `col_trans_log`
  ADD CONSTRAINT `col_trans_log_ibfk_1` FOREIGN KEY (`policy_number`) REFERENCES `fn_policy_mast` (`policy_number`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `sys_notif_msg`
  ADD CONSTRAINT `sys_notif_msg_ibfk_1` FOREIGN KEY (`policy_number`) REFERENCES `fn_policy_mast` (`policy_number`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `sys_notif_msg_ibfk_2` FOREIGN KEY (`ID_number`) REFERENCES `ci_customer_profile` (`ID_number`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `sys_notif_msg_ibfk_3` FOREIGN KEY (`customer_phone`) REFERENCES `ci_customer_profile` (`customer_phone`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

DROP TABLE IF EXISTS `debit_order_incoming`;
CREATE TABLE `debit_order_incoming` (
  `src_ID` VARCHAR(20) NOT NULL  PRIMARY KEY,
  `payment_type` VARCHAR(30) NOT NULL,
  `amount` DOUBLE NOT NULL,
  `transaction_date` DATE NOT NULL,
  `policy_number` VARCHAR(10)
) ;

INSERT INTO `debit_order_incoming` 
VALUES 
("debit001", "debit order", 1250, "2019-09-12", "604826041"),
("debit002", "debit order", 1234, "2018-08-07", "593715930");

DROP TABLE IF EXISTS `easy_p_incoming`;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `easy_p_incoming` (
  `src_ID` VARCHAR(20) NOT NULL  PRIMARY KEY,
  `payment_type` VARCHAR(10) NOT NULL,
  `amount` DOUBLE NOT NULL,
  `transaction_date` DATE NOT NULL,
  `policy_number` VARCHAR(10)
) ENGINE=InnoDB AUTO_INCREMENT=1347688 DEFAULT CHARSET=utf8;

INSERT INTO `easy_p_incoming` 
VALUES 
("easy001", "easy pay", 1600, "2019-09-12", "482604829"),
("easy002", "easy pay", 4200, "2018-08-07", "715937152");

DROP TABLE IF EXISTS `mgr_payat_incoming`;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `mgr_payat_incoming` (
  `src_ID` VARCHAR(20) NOT NULL  PRIMARY KEY,
  `payment_type` VARCHAR(10) NOT NULL,
  `amount` DOUBLE NOT NULL,
  `transaction_date` DATE NOT NULL,
  `policy_number` VARCHAR(10)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `mgr_payat_incoming` 
VALUES 
("mgr001", "mgr payat", 4000, "2019-09-12", "593715930"),
("mgr002", "mgr payat", 2300, "2018-08-07", "604826041");

DROP TABLE IF EXISTS `payat_incoming`;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `payat_incoming` (
  `src_ID` VARCHAR(20) NOT NULL PRIMARY KEY,
  `payment_type` VARCHAR(10) NOT NULL,
  `amount` DOUBLE NOT NULL,
  `transaction_date` DATE NOT NULL,
  `policy_number` VARCHAR(10)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `payat_incoming` VALUES 
("payat001", "payat", 2150, "2019-09-12", "593715930"),
("payat002", "payat", 1600, "2018-08-07", "604826041");

DROP TABLE IF EXISTS `stop_order_incoming`;

 SET character_set_client = utf8mb4 ;
CREATE TABLE `stop_order_incoming` (
  `src_ID` VARCHAR(20) NOT NULL PRIMARY KEY,
  `payment_type` VARCHAR(10) NOT NULL,
  `amount` DOUBLE NOT NULL,
  `transaction_date` DATE NOT NULL,
  `policy_number` VARCHAR(10)
) ENGINE=InnoDB AUTO_INCREMENT=155 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `stop_order_incoming` VALUES 
("stop001", "stop", 2500, "2019-09-12", "715937152"),
("stop002", "stop", 1034, "2018-08-07", "482604829");
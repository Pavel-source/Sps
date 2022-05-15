CREATE TABLE `log_customers` (
	`ID` BIGINT(20) NOT NULL AUTO_INCREMENT,
	`Portion_Type` CHAR(1) NOT NULL DEFAULT '0' COLLATE 'utf8mb3_general_ci',
	`Portion_ID` BIGINT(20) NOT NULL DEFAULT '0',
	`Dt` DATETIME NOT NULL DEFAULT current_timestamp(),
	PRIMARY KEY (`ID`) USING BTREE
)
COLLATE='utf8mb3_general_ci'
ENGINE=InnoDB
;

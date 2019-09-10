DELIMITER $$

DROP PROCEDURE IF EXISTS `sys_msg_notify`;

CREATE DEFINER=`root`@`localhost` PROCEDURE `sys_msg_notify`()
BEGIN
	DECLARE customer_name_temp varchar(30);
	DECLARE  policy_number_temp int(11);
	DECLARE amount_temp int(11);
	DECLARE CURSOR_sys_msg CURSOR FOR 
		SELECT `policy_number`, `customer_name`, `amount`  FROM `sys_notif_msg`;

	OPEN CURSOR_sys_msg;
	LOOP
		FETCH CURSOR_sys_msg INTO policy_number_temp, customer_name_temp, amount_temp;
		SELECT CONCAT ('Good Day ', customer_name_temp , ', Policy number: ', policy_number_temp, 'We wish to thank you for your payment of R', amount_temp, ' today and wish you a great day.');
	END LOOP;
	CLOSE CURSOR_sys_msg;
END$$
DELIMITER ;

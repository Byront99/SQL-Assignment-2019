DELIMITER $$
DROP PROCEDURE IF EXISTS `mapping`;

CREATE DEFINER=`root`@`localhost` PROCEDURE `mapping`()
BEGIN
	DECLARE src_ID_Temp;
    DECLARE amount_Temp;
    DECLARE transaction_date_Temp;
    DECLARE policy_number_Temp;
    
    DECLARE  CURSOR_debit_order_incoming CURSOR FOR 
		SELECT src_ID, amount, transaction_date, policy_number FROM debit_order_incoming;
        
	DECLARE  CURSOR_easy_p_incoming CURSOR FOR 
		SELECT src_ID, amount, transaction_date, policy_number FROM easy_p_incoming;
        
	DECLARE  CURSOR_mgr_payat_incoming CURSOR FOR 
		SELECT src_ID, amount, transaction_date, policy_number FROM mgr_payat_incoming;
        
	DECLARE  CURSOR_payat_incoming CURSOR FOR 
		SELECT src_ID, amount, transaction_date, policy_number FROM payat_incoming;
        
	DECLARE  CURSOR_stop_order_incoming CURSOR FOR 
		SELECT src_ID, amount, transaction_date, policy_number FROM stop_order_incoming;
	
	OPEN CURSOR_debit_order_incoming;
    LOOP
		FETCH src_ID INTO src_ID_Temp;
        FETCH payment_type INTO payment_type_Temp;
        FETCH amount INTO amount_Temp;
        FETCH transaction_date INTO transaction_date_Temp;
        FETCH policy_number INTO policy_number_Temp;
        
        INSERT INTO `col_trans_log` (`src_ID`, `amount`, `transaction_date`, `policy_number`) VALUES (`src_ID_Temp`, `amount_Temp`, `transaction_date_Temp`, `policy_number_Temp`);
    END LOOP;
    CLOSE CURSOR_debit_order_incoming;
    
    
	OPEN CURSOR_easy_p_incoming;
    LOOP
		FETCH src_ID INTO src_ID_Temp;
        FETCH payment_type INTO payment_type_Temp;
        FETCH amount INTO amount_Temp;
        FETCH transaction_date INTO transaction_date_Temp;
        FETCH policy_number INTO policy_number_Temp;
        
        INSERT INTO `col_trans_log` (`src_ID`, `amount`, `transaction_date`, `policy_number`) VALUES (`src_ID_Temp`, `amount_Temp`, `transaction_date_Temp`, `policy_number_Temp`);
    END LOOP;
    CLOSE CURSOR_easy_p_incoming;

	OPEN CURSOR_mgr_payat_incoming;
    LOOP
		FETCH src_ID INTO src_ID_Temp;
        FETCH payment_type INTO payment_type_Temp;
        FETCH amount INTO amount_Temp;
        FETCH transaction_date INTO transaction_date_Temp;
        FETCH policy_number INTO policy_number_Temp;
        
        INSERT INTO `col_trans_log` (`src_ID`, `amount`, `transaction_date`, `policy_number`) VALUES (`src_ID_Temp`, `amount_Temp`, `transaction_date_Temp`, `policy_number_Temp`);
    END LOOP;
    CLOSE CURSOR_mgr_payat_incoming;

	OPEN CURSOR_payat_incoming;
    LOOP
		FETCH src_ID INTO src_ID_Temp;
        FETCH payment_type INTO payment_type_Temp;
        FETCH amount INTO amount_Temp;
        FETCH transaction_date INTO transaction_date_Temp;
        FETCH policy_number INTO policy_number_Temp;
        
        INSERT INTO `col_trans_log` (`src_ID`, `amount`, `transaction_date`, `policy_number`) VALUES (`src_ID_Temp`, `amount_Temp`, `transaction_date_Temp`, `policy_number_Temp`);
    END LOOP;
    CLOSE CURSOR_payat_incoming;
    
    OPEN CURSOR_stop_order_incoming;
    LOOP
		FETCH src_ID INTO src_ID_Temp;
        FETCH payment_type INTO payment_type_Temp;
        FETCH amount INTO amount_Temp;
        FETCH transaction_date INTO transaction_date_Temp;
        FETCH policy_number INTO policy_number_Temp;
        
        INSERT INTO `col_trans_log` (`src_ID`, `amount`, `transaction_date`, `policy_number`) VALUES (`src_ID_Temp`, `amount_Temp`, `transaction_date_Temp`, `policy_number_Temp`);
    END LOOP;
    CLOSE CURSOR_stop_order_incoming;

END$$
DELIMITER ;
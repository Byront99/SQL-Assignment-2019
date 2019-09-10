CREATE DEFINER=`root`@`localhost` PROCEDURE `calculate_payments`()
BEGIN

-- Variables
DECLARE count INT DEFAULT -1;
DECLARE numRows INT;
DECLARE transaction_ref_number_temp INT;
DECLARE policy_number_temp INT(11);
DECLARE amount_temp INT(11);
DECLARE total_amount_paid_temp INT(30);
DECLARE total_accrued_temp INT(30);
DECLARE last_payment_type_temp varchar(30);

-- Cursor
DECLARE transaction_cursor CURSOR
FOR
SELECT col_trans_log.transaction_ref_number, col_trans_log.policy_number, col_trans_log.transaction_amount, fn_policy_mast.tot_amount_paid, fn_policy_mast.total_accrued, fn_policy_mast.last_payment_type
FROM col_trans_log
INNER JOIN fn_policy_mast
	ON col_trans_log.policy_number = fn_policy_mast.policy_number
WHERE payment_status = 'U';

-- Continue handler
SELECT COUNT(*) INTO numRows FROM col_trans_log;

-- Cursor loop
OPEN transaction_cursor;

get_data: LOOP

SET count = count + 1;

IF count = numRows THEN
LEAVE get_data;
END IF;

FETCH transaction_cursor INTO transaction_ref_number_temp, policy_number_temp, amount_temp, total_amount_paid_temp, total_accrued_temp, last_payment_type_temp;
UPDATE fn_policy_mast SET
last_payment_type = last_payment_type_temp,
tot_amount_paid = total_amount_paid_temp + amount_temp,
total_accrued = total_accrued_temp + tot_amount_paid/amount_temp,
balance = total_amount_paid_temp + total_accrued_temp
WHERE policy_number_temp = policy_number;

UPDATE col_trans_log SET payment_status = 'A'
WHERE transaction_ref_number_temp = transaction_ref_number;
END LOOP get_data;

CLOSE transaction_cursor;

END
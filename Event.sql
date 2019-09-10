CREATE EVENT procedures
ON SCHEDULE
EVERY 1 DAY 
STARTS CURRENT_TIMESTAMP
DO 
CALL mapping();
CALL calculatePayment();
CALL smsnotif();
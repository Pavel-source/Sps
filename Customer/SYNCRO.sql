DELIMITER //
 
CREATE OR REPLACE PROCEDURE Customers_Sincro_All()
BEGIN

SET @date_begin = CURRENT_DATE() - INTERVAL 2 DAY;

UPDATE  customerregistered
SET LASTACTIVITYDATE = LASTLOGINDATE
WHERE LASTLOGINDATE > @date_begin
		AND LASTLOGINDATE > LASTACTIVITYDATE;


UPDATE  
	customerregistered cr
	JOIN
		(
			SELECT b.CUSTOMERID, MAX(i.db_updated) AS max_db_updated
			FROM productiteminbasket i			
			     JOIN shoppingbasket b ON b.UUID = i.SHOPPINGBASKETUUID	
			WHERE i.db_updated > @date_begin		 
			GROUP BY b.CUSTOMERID
		) sq				 
		 		ON cr.ID = sq.CUSTOMERID
SET cr.LASTACTIVITYDATE = sq.max_db_updated
WHERE cr.LASTACTIVITYDATE < sq.max_db_updated 
		OR cr.LASTACTIVITYDATE IS NULL;	
	
		
UPDATE  
	customerregistered cr
	JOIN
		(
		SELECT o.CUSTOMERID, MAX(o.CREATED) AS max_created
		FROM orders o 
		WHERE o.CREATED > @date_begin	
		GROUP BY o.CUSTOMERID
		) sq	
		 	ON cr.ID = sq.CUSTOMERID
SET cr.LASTACTIVITYDATE = sq.max_created
WHERE cr.LASTACTIVITYDATE < sq.max_created 
		OR cr.LASTACTIVITYDATE IS NULL;


UPDATE  
	customerregistered cr
	JOIN
		(
		SELECT ci.CUSTOMERID, MAX(ci.CREATED) AS max_created
		FROM calendaritem ci 
		WHERE ci.db_updated > @date_begin
				AND ci.CREATED > @date_begin
		GROUP BY ci.CUSTOMERID
		) sq	
		 	ON cr.ID = sq.CUSTOMERID
SET cr.LASTACTIVITYDATE = sq.max_created
WHERE cr.LASTACTIVITYDATE < sq.max_created 
		OR cr.LASTACTIVITYDATE IS NULL;
		
END; //
 
DELIMITER ;		
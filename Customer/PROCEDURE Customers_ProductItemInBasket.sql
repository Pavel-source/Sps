DELIMITER //
 
CREATE OR REPLACE PROCEDURE Customers_ProductItemInBasket()
BEGIN
  
     SET @Portion = 10000;
     SET @cur_id = (SELECT min(id) FROM customerregistered) - 1;
     SET @max_id = (SELECT max(id) FROM customerregistered);
     SET @i = 0;
   
     DELETE FROM log_customers WHERE Portion_Type = 'B';
    
   label1: LOOP 
	  
	 SET @i = @i + 1;
	 IF @i > 10000 THEN
			SET @i = 0;
	  		DELETE FROM log_customers WHERE Portion_Type = 'B';
	 END IF;
	  
	 IF @i%10 = 0 THEN
		INSERT INTO log_customers(Portion_Type, Portion_ID) VALUES('B', @cur_id);
	 END IF;
	  
     UPDATE  
        customerregistered cr
        JOIN
            (
             SELECT b.CUSTOMERID, MAX(i.db_updated) AS max_db_updated
             FROM shoppingbasket b
                    JOIN productiteminbasket i ON b.UUID = i.SHOPPINGBASKETUUID
             WHERE b.CUSTOMERID > @cur_id AND b.CUSTOMERID <= @cur_id + @Portion 		 
             GROUP BY b.CUSTOMERID
             ) sq	
                ON cr.ID = sq.CUSTOMERID
     SET cr.LASTACTIVITYDATE = sq.max_db_updated
     WHERE cr.LASTACTIVITYDATE < sq.max_db_updated 
            OR cr.LASTACTIVITYDATE IS NULL;
          
     IF @cur_id <= @max_id THEN
     	 SET @cur_id = @cur_id + @Portion;
       ITERATE label1;
     END IF;
     
     LEAVE label1;
   END LOOP label1;
 
END; //
 
DELIMITER ;
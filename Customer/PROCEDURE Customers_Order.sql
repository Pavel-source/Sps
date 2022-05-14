DELIMITER //
 
CREATE OR REPLACE PROCEDURE Customers_Order()
BEGIN
  
     SET @Portion = 20000;
     SET @cur_id = (SELECT min(id) FROM customerregistered) - 1;
     SET @max_id = (SELECT max(id) FROM customerregistered);
     SET @i = 0;
   
     DELETE FROM log_customers WHERE Portion_Type = 'O';
    
   label1: LOOP 
   
     SET @i = @i + 1;
	 IF @i > 10000 THEN
			SET @i = 0;
	  		DELETE FROM log_customers WHERE Portion_Type = 'O';
	 END IF;
	 
	 IF @i%10 = 0 THEN
		INSERT INTO log_customers(Portion_Type, Portion_ID) VALUES('O', @cur_id);
	 END IF;	  
	  
     UPDATE  
          customerregistered cr
          JOIN
              (
               SELECT o.CUSTOMERID, MAX(o.CREATED) AS max_created
               FROM orders o
               WHERE o.CUSTOMERID > @cur_id AND o.CUSTOMERID <= @cur_id + @Portion
               GROUP BY o.CUSTOMERID
               ) sq	
                  ON cr.ID = sq.CUSTOMERID
      SET cr.LASTACTIVITYDATE = sq.max_created
      WHERE cr.LASTACTIVITYDATE < sq.max_created 
              OR cr.LASTACTIVITYDATE IS NULL;
          
     IF @cur_id <= @max_id THEN
     	 SET @cur_id = @cur_id + @Portion;
       ITERATE label1;
     END IF;
     
     LEAVE label1;
   END LOOP label1;
 
END; //
 
DELIMITER ;
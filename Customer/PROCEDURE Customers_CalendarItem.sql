DELIMITER //
 
CREATE OR REPLACE PROCEDURE Customers_CalendarItem()
BEGIN
  
     SET @Portion = 50000;
     SET @cur_id = (SELECT min(id) FROM customerregistered) - 1;
     SET @max_id = (SELECT max(id) FROM customerregistered);
     SET @i = 0;
   
     DELETE FROM log_customers WHERE Portion_Type = 'I';
    
   label1: LOOP 
   
     SET @i = @i + 1;
	 IF @i > 10000 THEN
			SET @i = 0;
	  		DELETE FROM log_customers WHERE Portion_Type = 'I';
	 END IF;
	  
	 IF @i%10 = 0 THEN
		INSERT INTO log_customers(Portion_Type, Portion_ID) VALUES('I', @cur_id);
	 END IF;
	  
     UPDATE  
	       customerregistered cr
	       JOIN
	           (
	            SELECT ci.CUSTOMERID, MAX(ci.CREATED) AS max_created
	            FROM calendaritem ci 
	            WHERE ci.CUSTOMERID > @cur_id AND ci.CUSTOMERID <= @cur_id + @Portion
	            GROUP BY ci.CUSTOMERID
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
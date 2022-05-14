DELIMITER //
 
CREATE OR REPLACE PROCEDURE Customers_Customers()
BEGIN
  
     SET @Portion = 500000;
     SET @cur_id = (SELECT min(id) FROM customerregistered) - 1;
     SET @max_id = (SELECT max(id) FROM customerregistered);
     SET @i = 0;
   
     DELETE FROM log_customers WHERE Portion_Type = 'C';
    
   label1: LOOP 
   
      SET @i = @i + 1;
	  IF @i > 10000 THEN
			SET @i = 0;
	  		DELETE FROM log_customers WHERE Portion_Type = 'C';
	  END IF;
	  
	  IF @i%10 = 0 THEN
		INSERT INTO log_customers(Portion_Type, Portion_ID) VALUES('C', @cur_id);
	  END IF;
	  
      UPDATE  customerregistered
      SET LASTACTIVITYDATE = LASTLOGINDATE
      WHERE ID > @cur_id AND ID <= @cur_id + @Portion
              AND (LASTACTIVITYDATE < LASTLOGINDATE OR LASTACTIVITYDATE IS NULL);
          
     IF @cur_id <= @max_id THEN
     	 SET @cur_id = @cur_id + @Portion;
       ITERATE label1;
     END IF;
     
     LEAVE label1;
   END LOOP label1;
 
END; //
 
DELIMITER ;
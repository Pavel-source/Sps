qqq

SELECT * from log_customers ORDER BY ID DESC 

-- SELECT COUNT(*) FROM customerregistered WHERE lastactivitydate IS NOT NULL -- 4079476

CALL Customers_ProductItemInBasket_2
CALL Customers_Order
CALL Customers_CalendarItem
CALL Customers_Customers

DELETE FROM log_customers;

INSERT INTO log_customers(Portion_Type, Portion_ID) VALUES('B', 1)
SELECT ROW_COUNT();

SELECT * FROM productsfromsite WHERE href = ''


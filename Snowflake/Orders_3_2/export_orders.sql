SELECT o.ORDER_ID AS id, 
	o.ORDER_DATE_TIME AS Created,
	o.ORDER_ID AS orderReference,
	o.customer_id AS customerid,
	i.REPORTING_CURRENCY AS currencycode,
	i.SKU AS productKey

-- ?  email	
--	channelid
	
	
	
	
	
FROM orders o
	JOIN order_items i ON o.ORDER_ID = i.ORDER_ID
LIMIT 10	
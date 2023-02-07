WITH cte_Individualshipping 
AS
(
SELECT 
	o.ORDER_ID AS id, 
	o.ORDER_DATE_TIME AS createdAt,
	o.ORDER_STATE AS CURRENTORDERSTATE,
	o.ORDER_ID AS orderReference,
	o.customer_id AS customerid,
	'customerEmail' AS customerEmail,
	o.ORDER_CURRENCYCODE AS currencycode,
	o.ORDER_STORE,
	
	-- TOTALWITHVAT = (PRODUCT_UNIT_PRICE + PRODUCT_DISCOUNT_INC_TAX + PRODUCT_TOTAL_TAX (?))
	-- GRANDTOTALFORPAYMENT = SUM(PRODUCT_UNIT_PRICE + PRODUCT_DISCOUNT_INC_TAX + PRODUCT_TOTAL_TAX) ?
	-- DISCOUNTWITHVAT = PRODUCT_DISCOUNT_INC_TAX
	-- totalPrice = (PRODUCT_UNIT_PRICE + PRODUCT_DISCOUNT_INC_TAX + PRODUCT_TOTAL_TAX (?))
--	i.PRODUCT_UNIT_PRICE, 
--	i.PRODUCT_DISCOUNT_INC_TAX, 
--	i.PRODUCT_TOTAL_TAX,
	
	-- TOTALWITHOUTVAT = (PRODUCT_UNIT_PRICE + PRODUCT_DISCOUNT_EX_TAX ?)
--	i.PRODUCT_DISCOUNT_EX_TAX,
	-- totalShippingPrice: when o.productcode = 'shipment_generic' then o.WITHVAT + o.DISCOUNTWITHVAT
--	i.POSTAGE_SUBTOTAL, -- ?
	-- POSTAGE_DISCOUNT_INC_TAX,  -- POSTAGE_SUBTOTAL includes DISCOUNT
	
	-- deliveryDate (=PROPOSED_DELIVERY_DATE ?)
--	i.PROPOSED_DELIVERY_DATE,
	
--	i.ACTUAL_DESPATCH_DATE,
--	i.ESTIMATED_DESPATCH_DATE,
--	i.TRACKING_CODE,
	
--	i.SKU AS productKey,
--	i.PRODUCT_TYPE_NAME,	-- productTypeKey, product_type
--	i.SKU_VARIANT,		-- sku_id
--	i.PRODUCT_TITLE,		-- nl_product_name
--	i.ORDER_LINE_ITEM_ID,		-- ol_id
--	i.QUANTITY,		--  productamount
	
	
-- ?  email	
--	channelid
	
	CONCAT('{',
		'"id": ', CONCAT('"delivery_', o.ORDER_ID, '_', IFNULL(i.ADDRESS_ID, '0'), '"'),
		
		IFNULL(CONCAT(',"status": ', CONCAT('"', 
			case 
				 when i.SHIPMENT_STATE = 'Ready' then 'Ready'
                 when i.SHIPMENT_STATE = 'Pending' then 'Pending'
				 when i.SHIPMENT_STATE IS NULL then ''
			end
		, '"')), ''), 
		
		IFNULL(CONCAT(',"firstName": "', replace(replace('r.firstname', '\r\n', ' '),'\n', ' '), '"'), ''),
		IFNULL(CONCAT(',"lastName": "', replace(replace('r.lastname', '\r\n', ' '),'\n', ' '),'"'), ''),
		IFNULL(CONCAT(',"deliveryType": "', 'POSTAL', '"'), ''),

		',"address": ', 	IFNULL(CONCAT('{',
												CONCAT('"id": ', '"', CONCAT('fake-', UUID_STRING()), '"'),
												IFNULL(CONCAT(',"firstName": "', replace(replace('r.firstname', '\r\n', ' '),'\n', ' '), '"'), ''),
												IFNULL(CONCAT(',"lastName": "', replace(replace('r.lastname', '\r\n', ' '),'\n', ' '), '"'), ''),
                                                IFNULL(CONCAT(',"houseNumber": "', replace(replace('a.streetnumber', '\r\n', ' '),'\n', ' '), '"'), ''),
												IFNULL(CONCAT(',"houseNumberExtension": "', replace(replace('a.streetnumberextension', '\r\n', ' '),'\n', ' '), '"'), ''),
												IFNULL(CONCAT(',"extraAddressLine": "', replace(replace('a.extraaddressline', '\r\n', ' '),'\n', ' '), '"'), ''),
												IFNULL(CONCAT(',"streetName": "', replace(replace('a.street', '\r\n', ' '),'\n', ' '), '"'), ''),
                                                IFNULL(CONCAT(',"city": "', replace(replace(i.DELIVERY_CITY, '\r\n', ' '),'\n', ' '), '"'), ''),
												IFNULL(CONCAT(',"state": "', replace(replace(i.DELIVERY_US_STATE, '\r\n', ' '),'\n', ' '), '"'), ''),
                                                IFNULL(CONCAT(',"postcode": "', replace(replace('a.zippostalcode', '\r\n', ' '),'\n', ' '), '"'), ''),
												IFNULL(CONCAT(',"country": ', CONCAT('"', i.DELIVERY_COUNTY, '"')), ''),
												IFNULL(CONCAT(',"emailAddress": ', CONCAT('"', 'email', '"')), ''),
												IFNULL(CONCAT(',"isMyAddress": ',  IFF(i.ADDRESS_TYPE = 'Customer Address', 'true', 'false') ), ''),
												CONCAT(',"isScrubbed": ', case when 'a.ID' IS NOT NULL AND 'a.street' = 'SCRUBBED' then 'true' else 'false' end),
												'}'), 'null'),
			

-- "recipientAddress" is the same as "address"
		',"recipientAddress": ', 	IFNULL(CONCAT('{',
												CONCAT('"id": ', '"', CONCAT('fake-', UUID_STRING()), '"'),
												IFNULL(CONCAT(',"firstName": "', replace(replace('r.firstname', '\r\n', ' '),'\n', ' '), '"'), ''),
												IFNULL(CONCAT(',"lastName": "', replace(replace('r.lastname', '\r\n', ' '),'\n', ' '), '"'), ''),
                                                IFNULL(CONCAT(',"houseNumber": "', replace(replace('a.streetnumber', '\r\n', ' '),'\n', ' '), '"'), ''),
												IFNULL(CONCAT(',"houseNumberExtension": "', replace(replace('a.streetnumberextension', '\r\n', ' '),'\n', ' '), '"'), ''),
												IFNULL(CONCAT(',"extraAddressLine": "', replace(replace('a.extraaddressline', '\r\n', ' '),'\n', ' '), '"'), ''),
												IFNULL(CONCAT(',"streetName": "', replace(replace('a.street', '\r\n', ' '),'\n', ' '), '"'), ''),
                                                IFNULL(CONCAT(',"city": "', replace(replace(i.DELIVERY_CITY, '\r\n', ' '),'\n', ' '), '"'), ''),
												IFNULL(CONCAT(',"state": "', replace(replace(i.DELIVERY_US_STATE, '\r\n', ' '),'\n', ' '), '"'), ''),
                                                IFNULL(CONCAT(',"postcode": "', replace(replace('a.zippostalcode', '\r\n', ' '),'\n', ' '), '"'), ''),
												IFNULL(CONCAT(',"country": ', CONCAT('"', i.DELIVERY_COUNTY, '"')), ''),
												IFNULL(CONCAT(',"emailAddress": ', CONCAT('"', 'email', '"')), ''),
												IFNULL(CONCAT(',"isMyAddress": ',  IFF(i.ADDRESS_TYPE = 'Customer Address', 'true', 'false') ), ''),
												CONCAT(',"isScrubbed": ', case when 'a.ID' IS NOT NULL AND 'a.street' = 'SCRUBBED' then 'true' else 'false' end),
												'}'), 'null'),


		IFNULL(CONCAT(',"deliveryDate": ', CONCAT('"', cast(cast(i.PROPOSED_DELIVERY_DATE AS DATE) AS VARCHAR(50)), '"')), ''), 
		IFNULL(CONCAT(',"actualDispatchDate": ', CONCAT('"', cast(cast(i.ACTUAL_DESPATCH_DATE AS DATE) AS VARCHAR(50)), '"')), ''),  
		IFNULL(CONCAT(',"estimatedDispatchDate": ', CONCAT('"', cast(cast(i.ESTIMATED_DESPATCH_DATE AS DATE) AS VARCHAR(50)), '"')), ''),
		
		',"orderItems": ',	replace(replace(concat('[',
						LISTAGG(
							CONCAT('{',
							   '"id": "', i.ORDER_LINE_ITEM_ID, '"',
							    IFNULL(CONCAT(',"title": "', i.PRODUCT_TITLE, '"'), ''),  
							   ',"quantity": ', i.QUANTITY,
							   CONCAT(',"totalPrice": ', CONCAT('{"centAmount": ', '555', ', "currencyCode": "', i.REPORTING_CURRENCY, '"}')),  
							   CONCAT(',"unitPrice": ', CONCAT('{"centAmount": ', '555', ', "currencyCode": "', i.REPORTING_CURRENCY, '"}')), 
							   ',"productType": "', i.PRODUCT_TYPE_NAME, '"',						   
							   ',"sku": "',  i.SKU_VARIANT, '"',
							--   ',"productSlug": ""',  
							   ',"productKey": "', i.SKU, '"',
										'}'
									)
									
							, ',')
							, ']'), '{},', ''), ',{}', ''),
		 							
		',"deliveryInformation": ', 	CONCAT('{',
										IFNULL(CONCAT('"deliveryMethodId": "', IFNULL(i.DELIVERY_METHOD, 'NONE') , '"'), ''),
										IFNULL(CONCAT(',"deliveryMethodName": "', IFNULL(i.DELIVERY_METHOD, 'Standard') , '"'), ''),
										IFNULL(CONCAT(',"trackingNumber": "', i.TRACKING_CODE, '"'), ''),
									--	IFNULL(CONCAT(',"trackingUrl": ""'), ''),
									--	IFNULL(CONCAT(',"fullTrackingUrl": ""'), ''),
										',"fulfilmentCentre" : {',
										IFNULL(CONCAT('"id": "', i.FULFILMENT_CENTRE_ID, '"'), ''),
										IFNULL(CONCAT(',"countryCode": "', i.FULFILMENT_CENTRE_COUNTRY_CODE, '"'), ''),
										'}', '}'),
								   --		'deliveryType', dp.type,
		
		IFNULL(CONCAT(',"mobileNumber": "', 'mct.mobile_phone', '"'), ''),  
		'}'				
		)
	AS orderDelivery,
	
	/*
	sum(case when o.productcode != 'shipment_generic' then o.TOTALWITHVAT else 0 end) AS subTotalPrice,
	sum(case when o.productcode != 'shipment_generic' then o.TOTALWITHOUTVAT else 0 end) AS totalTaxExclusive,
	abs(sum(case when o.productcode != 'shipment_generic' then o.DISCOUNTWITHVAT else 0 end)) AS totalDiscount,
	sum(case when o.productcode != 'shipment_generic' then o.productamount else 0 end) AS totalItems,
	sum(case when o.productcode = 'shipment_generic' then o.WITHVAT + o.DISCOUNTWITHVAT else 0 end)  AS totalShippingPrice
	
	TOTALWITHVAT (PRODUCT_UNIT_PRICE + PRODUCT_DISCOUNT_INC_TAX + PRODUCT_TOTAL_TAX (?)), 
	TOTALWITHOUTVAT (PRODUCT_UNIT_PRICE + PRODUCT_DISCOUNT_EX_TAX ?),
	DISCOUNTWITHVAT (PRODUCT_DISCOUNT_INC_TAX)
	i.QUANTITY
	WITHVAT + DISCOUNTWITHVAT (POSTAGE_SUBTOTAL (?) +(?) POSTAGE_DISCOUNT_INC_TAX)
	*/
	
	SUM(i.PRODUCT_UNIT_PRICE + i.PRODUCT_DISCOUNT_INC_TAX + i.PRODUCT_TOTAL_TAX) AS subTotalPrice,
	SUM(i.PRODUCT_UNIT_PRICE + i.PRODUCT_DISCOUNT_EX_TAX) AS totalTaxExclusive,
	SUM(i.PRODUCT_DISCOUNT_INC_TAX) AS totalDiscount,
	SUM(i.QUANTITY) AS totalItems,
	SUM(i.POSTAGE_SUBTOTAL)  AS totalShippingPrice,
	
--	GRANDTOTALFORPAYMENT = SUM(PRODUCT_UNIT_PRICE + PRODUCT_DISCOUNT_INC_TAX + PRODUCT_TOTAL_TAX + POSTAGE_SUBTOTAL) ?
	SUM(i.PRODUCT_UNIT_PRICE + i.PRODUCT_DISCOUNT_INC_TAX + i.PRODUCT_TOTAL_TAX + i.POSTAGE_SUBTOTAL) AS GRANDTOTALFORPAYMENT,
	-- CreditsUsed = PREPAY + BONUS ?
	SUM(PREPAY + BONUS) AS CreditsUsed
		
FROM 
	-- (select * from orders where order_id IN ('1289250158', '1188099208', '482779521')) AS o
	(select * from orders limit 3) AS o
	-- orders o
	JOIN order_items i ON o.ORDER_ID = i.ORDER_ID
GROUP BY 
	o.ORDER_ID,
	i.ADDRESS_ID,
	i.SHIPMENT_STATE,
	
	o.ORDER_ID, 
	o.ORDER_DATE_TIME,
	o.ORDER_STATE,
	o.customer_id,
	o.ORDER_CURRENCYCODE,
	o.ORDER_STORE,
	i.ADDRESS_TYPE,
	i.DELIVERY_CITY, 
	i.DELIVERY_US_STATE,
	i.DELIVERY_COUNTY,
	i.DELIVERY_METHOD,
	i.TRACKING_CODE,
	i.FULFILMENT_CENTRE_ID,
	i.FULFILMENT_CENTRE_COUNTRY_CODE,
	i.PROPOSED_DELIVERY_DATE, 
	i.ACTUAL_DESPATCH_DATE,  
	i.ESTIMATED_DESPATCH_DATE
),

cte_order 
AS
(
SELECT
   i.id,
   i.createdAt,
   i.orderReference, 
   i.customerId,
   i.customerEmail,
   i.ORDER_STORE,
   -- subTotalPrice
   CONCAT('{"centAmount": ', cast(SUM(i.subTotalPrice) * 100 AS INT), ', "currencyCode": "', i.currencycode, '"}') AS subTotalPrice,
   -- totalPrice = subTotalPrice + totalShippingAmount
  -- CONCAT('{"centAmount": ', cast((i.subTotalPrice + i.totalShippingPrice) * 100 AS INT), ', "currencyCode": "', i.currencycode, '"}') AS totalPrice,
   CONCAT('{"centAmount": ', cast(i.GRANDTOTALFORPAYMENT * 100 AS INT), ', "currencyCode": "', i.currencycode, '"}') AS totalPrice,

  -- totalItemPrice = totalPrice + totalDiscount - totalShippingAmount
   CONCAT('{"centAmount": ', cast((i.GRANDTOTALFORPAYMENT + SUM(i.totalDiscount) - SUM(i.totalShippingPrice)) * 100 AS INT), ', "currencyCode": "', i.currencycode, '"}') AS totalItemPrice,
   -- subTotalIncTax = totalItemPrice + totalShippingPrice
   CONCAT('{"centAmount": ', cast((i.GRANDTOTALFORPAYMENT + SUM(i.totalDiscount) /* - i.totalShippingPrice + i.totalShippingPrice*/) * 100 AS INT), ', "currencyCode": "', i.currencycode, '"}') AS subTotalIncTax,
   -- totalShippingPrice
   CONCAT('{"centAmount": ', cast(SUM(i.totalShippingPrice) * 100 AS INT), ', "currencyCode": "', i.currencycode, '"}') AS totalShippingPrice,
   -- totalTaxExclusive
   CONCAT('{"centAmount": ', cast(SUM(i.totalTaxExclusive) * 100 AS INT), ', "currencyCode": "', i.currencycode, '"}') AS totalTaxExclusive,
  -- CONCAT('{"centAmount": ', cast(i.totalPriceGross * 100 AS INT), ', "currencyCode": "', i.currencycode, '"}') AS totalPriceGross,
   -- totalDiscount
   CONCAT('{"centAmount": ', cast(SUM(i.totalDiscount) * 100 AS INT), ', "currencyCode": "', i.currencycode, '"}') AS totalDiscount,
   -- creditsUsed (const)
   CONCAT('{"centAmount": ', cast(SUM(i.CreditsUsed) * 100 AS INT), ', "currencyCode": "', i.currencycode, '"}') AS creditsUsed,
   SUM(i.totalItems) AS totalItems,
   
	concat('[',
	LTRIM(LISTAGG(IFNULL(i.orderDelivery, ''), ','), ',')
		  , ']')
	AS deliveries,
	
   i.currentorderstate
		
FROM cte_Individualshipping i
GROUP BY
		 i.customerId,
		 i.id,
		 
		 i.currencycode,
		 i.currentorderstate,
		 i.GRANDTOTALFORPAYMENT,
		 i.createdAt,
		 i.orderReference, 
		 i.customerId,
		 i.customerEmail,
		 i.ORDER_STORE
)

SELECT
	   customerId AS entity_key,
			CONCAT('[',
				
				LISTAGG(
							CONCAT('{',
										 '"id": "', id, '"',
										  ',"state": ', '"', currentorderstate, '"',
										 ',"version": 0', 
										 ',"createdAt": ', '"', createdAt, '"',
										 ',"orderReference": ', '"', orderReference, '"',
										 ',"customerId": "', customerId, '"',
										  IFNULL(CONCAT(',"customerEmail": ', CONCAT('"', customerEmail, '"')), ''),
										  IFNULL(CONCAT(',"store": "', ORDER_STORE, '"'), ''),
										  IFNULL(CONCAT(',"subTotalPrice": ', subTotalPrice), ''),
										  IFNULL(CONCAT(',"totalItemPrice": ', totalItemPrice), ''),
										  IFNULL(CONCAT(',"totalShippingPrice": ', totalShippingPrice), ''),
										  IFNULL(CONCAT(',"postagePrice": ', totalShippingPrice), ''),			 -- postagePrice = totalShippingPrice
										  IFNULL(CONCAT(',"subTotalIncTax": ', subTotalIncTax), ''),
										  IFNULL(CONCAT(',"totalTaxExclusive": ', totalTaxExclusive), ''),
										  IFNULL(CONCAT(',"totalPrice": ', totalPrice), ''),
										  IFNULL(CONCAT(',"totalPriceGross": ', totalPrice), ''),			 	 -- totalPriceGross = totalPrice
										  IFNULL(CONCAT(',"totalDiscount": ', totalDiscount), ''),
										  ',"creditsUsed": ', creditsUsed, 
										  IFNULL(CONCAT(',"totalPaid": ', totalPrice), ''),						 -- totalPaid = totalPriceGross = totalPrice
										  IFNULL(CONCAT(',"totalItems": ', totalItems), ''),
										  ',"deliveries": ', deliveries,
										  ',"dataSource": "S3"', 
										  '}'
										 
										), ',')
								,']')

		AS orders
FROM cte_order
GROUP BY customerId
-- LIMIT :limit		 
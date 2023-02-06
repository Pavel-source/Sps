SELECT 
	o.ORDER_ID AS id, 
	o.ORDER_DATE_TIME AS Created,
	o.ORDER_STATE,
	o.ORDER_ID AS orderReference,
	o.customer_id AS customerid,
--	i.REPORTING_CURRENCY AS currencycode,
	
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
							   CONCAT(',"totalPrice": ', CONCAT('{"centAmount": ', 'o.totalwithvat', ', "currencyCode": "', i.REPORTING_CURRENCY, '"}')),  
							   CONCAT(',"unitPrice": ', CONCAT('{"centAmount": ', 'o.totalwithvat/o.productamount', ', "currencyCode": "', i.REPORTING_CURRENCY, '"}')), 
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
	AS orderDelivery
	
	
FROM 
	(select * from orders where order_id = '4898caa4-01eb-49de-8284-c23079b84436' order by ORDER_DATE desc limit 30) AS o
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
	
-- LIMIT 10	
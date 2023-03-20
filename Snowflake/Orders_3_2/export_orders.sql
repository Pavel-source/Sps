WITH cte_customers_0
AS
(
SELECT o.customer_id, 
	   IFNULL(c.MCD_CUSTOMER_ID, MAX(o.MCD_CUSTOMER_ID)) AS MCD_CUSTOMERID
FROM "PROD"."DW_CORE".orders o
	 LEFT JOIN "PROD"."DW_CORE".customers c ON o.customer_id = c.customer_id			-- 4568 customers from orders table don't exist in customers table; and they have orders for migration.
WHERE o.brand = 'mnpg'
	-- AND o.customer_id = 'b9278087-07ce-4c05-8d4d-a9a05c559782'
	/* AND o.customer_id  IN (
		'30683c84-d9f8-4195-85a3-a42d2ec7efb0',
		'5922e3e6-f9a7-46ec-8999-37584db07eb0',
		'b9278087-07ce-4c05-8d4d-a9a05c559782',
		'505606f7-1c26-4744-a89a-a8c02eeb7969',
		'9df7d77c-7100-499e-aee8-c46f449948b6')*/
GROUP BY o.customer_id, 
		 c.MCD_CUSTOMER_ID
HAVING 
	  (
		(CONCAT(:keys) IS NULL
			AND MCD_CUSTOMERID > :migrateFromId
			AND MCD_CUSTOMERID <= :migrateToId)
         OR MCD_CUSTOMERID IN (:keys)
	   )
	   AND	MCD_CUSTOMERID IS NOT NULL
	   AND  MAX(o.ORDER_DATE) > dateadd(month, -26, current_date())
),

cte_customers
AS
(
SELECT c.customer_id, c.MCD_CUSTOMERID AS MCD_CUSTOMER_ID, pc.EMAILADDRESS
FROM cte_customers_0 c
	LEFT JOIN PROD.RAW_MOONPIG_MCD_PERSONAL.customer pc 
		ON pc.customerid = c.MCD_CUSTOMERID
QUALIFY ROW_NUMBER() OVER (PARTITION BY pc.CUSTOMERID ORDER BY pc.EXTRACT_DATE DESC) = 1		
),

cte_Individualshipping
AS
(
SELECT
	IFF(o.mcd_order_id::STRING = o.order_id, concat('LEGO-', o.ORDER_NUMBER), o.ORDER_ID) AS id,
	o.ORDER_DATE_TIME AS createdAt,
	o.ORDER_STATE AS CURRENTORDERSTATE,
	o.ORDER_NUMBER AS orderReference,	-- ORDER_NUMBER: "The customer-facing order reference number for CT orders"
	o.customer_id AS customerid,
	cte.MCD_CUSTOMER_ID,
	replace(replace(replace(replace(cte.EMAILADDRESS, '\r', ''),'\n', ' '), '"', ''), '\\', '/') AS customerEmail,
	o.ORDER_CURRENCYCODE AS currencycode,
	o.ORDER_STORE,
	
	case i.DELIVERY_METHOD
				when 'Aus Post - Express' then 35
				when 'Aus Post - Standard' then 36
				when 'Australia Post Standard' then 36
				when 'DPD Courier' then 30
				when 'Email' then 4
				when 'Express 2nd Day' then 20
				when 'Express Overnight' then 21
				when 'Express Post' then 7
				when 'Fedex Saturday' then 25
				when 'Fedex Standard' then 23
				when 'First Class' then 1
				when 'First Class - Order by 7pm' then 33
				when 'First Class via USPS' then 18
				when 'Mother''s Day delivery' then 16
				when 'Mother''s Day Delivery' then 16
				when 'Mother''s Day Delivery - Sunday 27th March' then 16
				when 'None' then 5
				when 'RM Tracked' then 26
				when 'Saturday Courier' then 15
				when 'Second Class' then 2
				when 'Special Delivery' then 3
				when 'Special Delivery Saturday' then 13
				when 'Standard' then 19
				when 'Standard Courier' then 14
				when 'Standard Delivery' then 22
				when 'Standard Shipping' then 22
				when 'Telegram' then 17
				when 'Valentine''s Day Delivery' then 32
				when 'Yodel Courier' then 27 
				when 'Christmas Eve Delivery' then 47
				when 'Father''s Day Delivery' then 46
				when 'Father''s Day Delivery - Sunday 19th June' then 46
				when 'Royal Mail T24 Letterboxable' then 59
				when 'Royal Mail Tracked 24' then 44
				else 5	-- 'None'
			end	
	AS DELIVERY_METHOD_ID,

	CONCAT('{',
		'"id": ', CONCAT('"delivery_', o.mcd_order_id, '_', IFNULL(ab.ADDRESSBOOKID, '0'),
					--	 '_', case i.ITEM_STATE when 'Cancelled' then '2' else '1' end,
					--	 '_', DELIVERY_METHOD_ID,
							'_', ROW_NUMBER() OVER(PARTITION BY o.mcd_order_id, ab.ADDRESSBOOKID ORDER BY DELIVERY_METHOD_ID),
						 '"'),

		CONCAT(',"status": ', case i.ITEM_STATE when 'Cancelled' then 300 else 202 end),
		IFNULL(CONCAT(',"firstName": "', replace(replace(replace(replace(replace(ab.firstname, '\r', ''),'\n', ' '), '""',''''), '"',''''), '\\', '/'),  '"'), ''),
		IFNULL(CONCAT(',"lastName": "', replace(replace(replace(replace(replace(ab.lastname, '\r', ''),'\n', ' '), '""',''''), '"',''''), '\\', '/'),  '"'), ''),
		IFF(i.DELIVERY_METHOD = 'Email', ',"deliveryType": 1', ',"deliveryType": 0'),

		',"address": ', 	IFNULL(CONCAT('{',
												CONCAT('"id": ', '"', CONCAT('fake-', UUID_STRING()), '"'),
												IFNULL(CONCAT(',"firstName": "', replace(replace(replace(replace(replace(ab.firstname, '\r', ''),'\n', ' '), '""',''''), '"',''''), '\\', '/'),  '"'), ''),
												IFNULL(CONCAT(',"lastName": "', replace(replace(replace(replace(replace(ab.lastname, '\r', ''),'\n', ' '), '""',''''), '"',''''), '\\', '/'),  '"'), ''),
                                            --  IFNULL(CONCAT(',"houseNumber": "', 'streetnumber', '"'), ''),
											--	IFNULL(CONCAT(',"houseNumberExtension": "', 'streetnumberextension', '"'), ''),
											--	IFNULL(CONCAT(',"extraAddressLine": "', 'extraaddressline', '"'), ''),
											--	IFNULL(CONCAT(',"streetName": "', ab.ADDRESS, '"'), ''),
												IFNULL(CONCAT(',"addressFirstLine": "',  replace(replace(replace(replace(replace(ab.ADDRESS, '\r', ''),'\n', ' '), '"',''''), '	', ' '), '\\','/'),    '"'), ''),
                                                IFNULL(CONCAT(',"city": "', replace(replace(replace(replace(ab.TOWN, '\r', ''),'\n', ' '), '"', ''''), '\\', '/'),  '"'), ''),
												IFNULL(CONCAT(',"state": "', replace(replace(replace(replace(ab.COUNTY, '\r', ''),'\n', ' '), '"', ''''), '\\', '/'),  '"'), ''),
                                                IFNULL(CONCAT(',"postcode": "', replace(replace(replace(replace(ab.POSTCODE, '\r', ''),'\n', ' '), '"', ''''), '\\', '/'),  '"'), ''),
												IFNULL(CONCAT(',"country": ', CONCAT('"', replace(replace(cn.COUNTRY, '\r', ''),'\n', ' '), '"')), ''),
												IFNULL(CONCAT(',"emailAddress": ', CONCAT('"', replace(replace(replace(replace(ab.EMAILADDRESS, '\r', ''),'\n', ' '), '"', ''), '\\', '/'),  '"')), ''),
												IFNULL(CONCAT(',"isMyAddress": ',  IFF(i.ADDRESS_TYPE = 'Customer Address', 'true', 'false') ), ''),
											--	CONCAT(',"isScrubbed": ', case when 'a.ID' IS NOT NULL AND 'a.street' = 'SCRUBBED' then 'true' else 'false' end),
												'}'), 'null'),

-- "recipientAddress" is the same as "address"
		',"recipientAddress": ', 	IFNULL(CONCAT('{',
												CONCAT('"id": ', '"', CONCAT('fake-', UUID_STRING()), '"'),
												IFNULL(CONCAT(',"firstName": "', replace(replace(replace(replace(replace(ab.firstname, '\r', ''),'\n', ' '), '""',''''), '"',''''), '\\', '/'),  '"'), ''),
												IFNULL(CONCAT(',"lastName": "', replace(replace(replace(replace(replace(ab.lastname, '\r', ''),'\n', ' '), '""',''''), '"',''''), '\\', '/'),  '"'), ''),
                                            --  IFNULL(CONCAT(',"houseNumber": "', 'streetnumber', '"'), ''),
											--	IFNULL(CONCAT(',"houseNumberExtension": "', 'streetnumberextension', '"'), ''),
											--	IFNULL(CONCAT(',"extraAddressLine": "', 'extraaddressline', '"'), ''),
											--	IFNULL(CONCAT(',"streetName": "', ab.ADDRESS, '"'), ''),
												IFNULL(CONCAT(',"addressFirstLine": "',  replace(replace(replace(replace(replace(ab.ADDRESS, '\r', ''),'\n', ' '), '"',''''), '	', ' '), '\\','/'),    '"'), ''),
                                                IFNULL(CONCAT(',"city": "', replace(replace(replace(replace(ab.TOWN, '\r', ''),'\n', ' '), '"', ''''), '\\', '/'),  '"'), ''),
												IFNULL(CONCAT(',"state": "', replace(replace(replace(replace(ab.COUNTY, '\r', ''),'\n', ' '), '"', ''''), '\\', '/'),  '"'), ''),
                                                IFNULL(CONCAT(',"postcode": "', replace(replace(replace(replace(ab.POSTCODE, '\r', ''),'\n', ' '), '"', ''''), '\\', '/'),  '"'), ''),
												IFNULL(CONCAT(',"country": ', CONCAT('"', replace(replace(cn.COUNTRY, '\r', ''),'\n', ' '), '"')), ''),
												IFNULL(CONCAT(',"emailAddress": ', CONCAT('"', replace(replace(replace(replace(ab.EMAILADDRESS, '\r', ''),'\n', ' '), '"', ''), '\\', '/'),  '"')), ''),
												IFNULL(CONCAT(',"isMyAddress": ',  IFF(i.ADDRESS_TYPE = 'Customer Address', 'true', 'false') ), ''),
											--	CONCAT(',"isScrubbed": ', case when 'a.ID' IS NOT NULL AND 'a.street' = 'SCRUBBED' then 'true' else 'false' end),
												'}'), 'null'),

		IFNULL(CONCAT(',"deliveryDate": ', CONCAT('"', cast(cast(i.PROPOSED_DELIVERY_DATE AS DATE) AS VARCHAR(50)), '"')), ''),
		IFNULL(CONCAT(',"actualDispatchDate": ', CONCAT('"', cast(cast(i.ACTUAL_DESPATCH_DATE AS DATE) AS VARCHAR(50)), '"')), ''),
		IFNULL(CONCAT(',"estimatedDispatchDate": ', CONCAT('"', cast(cast(i.ESTIMATED_DESPATCH_DATE AS DATE) AS VARCHAR(50)), '"')), ''),

		',"orderItems": ',	replace(replace(concat('[',
						LISTAGG(
							CONCAT('{',
							   '"id": "', i.ORDER_LINE_ITEM_ID, '"',
							    IFNULL(CONCAT(',"title": "', replace(replace(replace(i.PRODUCT_TITLE, '"', ''''), '\r', ''),'\n', ' ')  , '"'), ''),
							   ',"quantity": ', i.QUANTITY,
							   CONCAT(',"totalPrice": ', CONCAT('{"centAmount": ', CAST(100 * i.ITEM_ESIV AS INT), ', "currencyCode": "', IFNULL(o.ORDER_CURRENCYCODE, ''), '"}')),
							   CONCAT(',"unitPrice": ', CONCAT('{"centAmount": ', IFF(i.QUANTITY = 0, 0, CAST(100 * i.ITEM_ESIV / i.QUANTITY AS INT)), ', "currencyCode": "', IFNULL(o.ORDER_CURRENCYCODE, ''), '"}')),
							   IFNULL(CONCAT(',"productType": "', i.PRODUCT_TYPE_NAME, '"'), ''),
							   IFNULL(CONCAT(',"sku": "', i.SKU_VARIANT, '"'), ''),
							--   ',"productSlug": ""',
							   IFNULL(CONCAT(',"productKey": "', i.SKU, '"'), ''),
										'}'
									)

							, ',')
							, ']'), '{},', ''), ',{}', ''),

		',"deliveryInformation": ', 	CONCAT('{',
		
		CONCAT('"postageType": ', DELIVERY_METHOD_ID),
		
										IFNULL(CONCAT(',"deliveryMethodId": "', DELIVERY_METHOD_ID , '"'), ''),
										IFNULL(CONCAT(',"deliveryMethodName": "', IFF(DELIVERY_METHOD_ID = 5, 'None', i.DELIVERY_METHOD) , '"'), ''),
										IFNULL(CONCAT(',"trackingNumber": "', replace(replace(replace(replace(i.TRACKING_CODE, '\r', ''),'\n', ' '), '\\', '/'), '"', ''''),  '"'), ''),
									--	IFNULL(CONCAT(',"trackingUrl": ""'), ''),
									--	IFNULL(CONCAT(',"fullTrackingUrl": ""'), ''),
										',"fulfilmentCentre" : {',
										IFNULL(CONCAT('"id": "', oia.PRINTSITEID, '"'), ''),
										IFNULL(CONCAT(',"countryCode": "', case when oia.PRINTSITEID = 2 then 'AU' when oia.PRINTSITEID = 4 then 'US' when oia.PRINTSITEID IS NOT NULL then 'GB' end, '"'), ''),
										'}', '}'),
								   --		'deliveryType', dp.type,

		IFNULL(CONCAT(',"mobileNumber": "', replace(replace(replace(ab.TELEPHONENO, '\r', ''),'\n', ' '), '"', ''),  '"'), ''),
		'}'
		)
	AS orderDelivery,

	/*
	Formulas from Greetz migration:
	sum(case when o.productcode != 'shipment_generic' then o.TOTALWITHVAT else 0 end) AS subTotalPrice,
	sum(case when o.productcode != 'shipment_generic' then o.TOTALWITHOUTVAT else 0 end) AS totalTaxExclusive,
	abs(sum(case when o.productcode != 'shipment_generic' then o.DISCOUNTWITHVAT else 0 end)) AS totalDiscount,
	sum(case when o.productcode != 'shipment_generic' then o.productamount else 0 end) AS totalItems,
	sum(case when o.productcode = 'shipment_generic' then o.WITHVAT + o.DISCOUNTWITHVAT else 0 end)  AS totalShippingPrice
	*/

	-- o.ORDER_ESIV AS subTotalPrice,
	-- o.ORDER_ESEV AS totalTaxExclusive,
	o.ORDER_CASH_PAID + SUM(IFNULL(i.PREPAY, 0) + IFNULL(i.BONUS, 0)) - o.POSTAGE_SUBTOTAL  AS subTotalPrice,
	o.ORDER_CASH_PAID + SUM(IFNULL(i.PREPAY, 0) + IFNULL(i.BONUS, 0)) AS totalTaxExclusive,
	
	o.PRODUCT_DISCOUNT_INC_TAX AS totalDiscount,
	SUM(i.QUANTITY) AS totalItems,
	o.POSTAGE_SUBTOTAL AS totalShippingPrice,
	o.ORDER_CASH_PAID + SUM(IFNULL(i.PREPAY, 0) + IFNULL(i.BONUS, 0))  AS GRANDTOTALFORPAYMENT,
	SUM(IFNULL(i.PREPAY, 0) + IFNULL(i.BONUS, 0)) AS CreditsUsed,
	IFF(o.mcd_order_id::STRING = o.order_id, 1, 0) AS NewOrder
		
FROM
	-- (select * from orders where order_id IN ('52a49175-60c6-439d-b7cf-6339b7ae3854', '44ecebf0-e208-4736-b850-c170aa1309ea') or order_number = 'YYHRYCE') AS o
	cte_customers cte
	JOIN 
	(
	SELECT  mcd_order_id, order_id, ORDER_NUMBER, ORDER_DATE_TIME, customer_id, MCD_CUSTOMER_ID,  ORDER_CURRENCYCODE, ORDER_STORE, 
			ORDER_STATE, ORDER_CASH_PAID, ORDER_ESIV, ORDER_ESEV, PRODUCT_DISCOUNT_INC_TAX, POSTAGE_SUBTOTAL, BRAND
	FROM "PROD"."DW_CORE".orders
	UNION ALL
	SELECT 
		ORDER_ID 			AS mcd_order_id, 
		commerce_tools_id 	AS order_id, 
		ENCRYPTED_ORDER_ID 	AS ORDER_NUMBER, 
		ORDER_DATE 			AS ORDER_DATE_TIME, 
		c.customer_id 		AS customer_id, 
		r.CUSTOMER_ID 		AS MCD_CUSTOMER_ID, 
		cr.ISO4217CURRENCY	AS ORDER_CURRENCYCODE,
		
		CASE
			WHEN r.cardshop = 'Moonpig' THEN 'UK'
			WHEN r.cardshop = 'Moonpig Australia' THEN 'AU'
			WHEN r.cardshop = 'Moonpig USA' THEN 'US'
		END 				AS ORDER_STORE,
		
		ORDER_STATUS		AS ORDER_STATE, 
		CASH_PAID			AS ORDER_CASH_PAID, 
		ORDER_ESIV			AS ORDER_ESIV, 
		ORDER_ESEV			AS ORDER_ESEV, 
		DISCOUNTGIVEN		AS PRODUCT_DISCOUNT_INC_TAX, 
		r.POSTAGE_EX_TAX_TOTAL + r.POSTAGE_TAX_TOTAL  AS POSTAGE_SUBTOTAL,
		'mnpg' 				AS BRAND
	FROM "PROD"."MCD_DW_CORE".mcd_orders_non_reportable r
		  JOIN "PROD"."DW_CORE".customers c ON r.customer_id = c.mcd_customer_id
		  LEFT JOIN "PROD"."RAW_MOONPIG_MCD"."CURRENCY" cr ON r.CURRENCY_ID = cr.CURRENCYID
	WHERE commerce_tools_id not in (SELECT order_id FROM "PROD"."DW_CORE".orders)
		  OR commerce_tools_id is null 
	)
	o ON cte.customer_id = o.customer_id
	JOIN 
	(
	SELECT  ORDER_ID, ORDER_LINE_ITEM_ID, MCD_ORDER_ID, MCD_ITEM_ID, DELIVERY_METHOD, ITEM_STATE, ADDRESS_TYPE, PROPOSED_DELIVERY_DATE, 
			ACTUAL_DESPATCH_DATE, ESTIMATED_DESPATCH_DATE, PRODUCT_TITLE, QUANTITY, ITEM_ESIV, PRODUCT_TYPE_NAME, SKU_VARIANT, 
			SKU, TRACKING_CODE, BRAND, PREPAY, BONUS
	FROM "PROD"."DW_CORE".order_items
	UNION ALL
	SELECT  
		commerce_tools_id				AS ORDER_ID,
		COMMERCETOOLS_LINE_ITEM_ID		AS ORDER_LINE_ITEM_ID,
		ORDER_ID						AS MCD_ORDER_ID,
		ITEM_ID							AS MCD_ITEM_ID,
		POSTAGE_TYPE					AS DELIVERY_METHOD,
		ITEM_STATUS						AS ITEM_STATE,
		ADDRESS_TYPE_NAME				AS ADDRESS_TYPE,
		NULL 							AS PROPOSED_DELIVERY_DATE, -- from events_lookup.ct_order_items_detailed
		DISPATCH_DATE					AS ACTUAL_DESPATCH_DATE,
		DISPATCH_DATE					AS ESTIMATED_DESPATCH_DATE,
		PRODUCT_TITLE					AS PRODUCT_TITLE,
		QUANTITY						AS QUANTITY,
		ITEM_ESIV						AS ITEM_ESIV,
		PRODUCTCATEGORY					AS PRODUCT_TYPE_NAME,
		NULL 							AS SKU_VARIANT,
		SKU								AS SKU,
		COURIER_TRACKING_CODE			AS TRACKING_CODE,
		'mnpg' 							AS BRAND,
		PREPAY							AS PREPAY, 
		BONUS							AS BONUS
	
	FROM "PROD"."MCD_DW_CORE".mcd_order_items_non_reportable
	WHERE commerce_tools_id not in (SELECT order_id FROM "PROD"."DW_CORE".orders)
		  OR commerce_tools_id is null 
	) i
	ON o.ORDER_ID = i.ORDER_ID
	LEFT JOIN (
				SELECT ORDERNO,
					  ITEMNO,
					  DELIVERYADDRESSBOOKID,
					  PRINTSITEID
				FROM PROD.RAW_MOONPIG_MCD.ORDERITEMADDRESS 
				QUALIFY ROW_NUMBER() OVER (PARTITION BY ORDERNO, ITEMNO ORDER BY EXTRACT_DATE DESC) = 1
			  ) oia
			ON i.MCD_ORDER_ID = oia.ORDERNO
				AND i.MCD_ITEM_ID = oia.ITEMNO
	LEFT JOIN (
				SELECT ADDRESSBOOKID
						, FIRSTNAME
						, LASTNAME
						, ADDRESS
						, EMAILADDRESS
						, town
						, COUNTY
						, POSTCODE
						, COUNTRYID
						, TELEPHONENO
				FROM PROD.RAW_MOONPIG_MCD_PERSONAL.ADDRESSBOOK
				QUALIFY ROW_NUMBER() OVER (PARTITION BY ADDRESSBOOKID ORDER BY EXTRACT_DATE DESC) = 1
				) ab
				ON oia.DELIVERYADDRESSBOOKID = ab.ADDRESSBOOKID
	LEFT JOIN "PROD"."RAW_MOONPIG_MCD"."COUNTRY" cn ON ab.COUNTRYID = cn.COUNTRYID
	LEFT JOIN "PROD"."RAW_CONSIGNMENT_SNAPSHOT"."MNPG_CONSIGNMENTS_API_PARSED" cs ON o.ORDER_ID = cs.ORDER_ID
WHERE 
      o.brand = 'mnpg'
	  AND i.BRAND = 'mnpg'
	  AND o.mcd_order_id IS NOT NULL
	  AND (
			o.mcd_order_id::STRING = o.order_id
			OR (cs.ORDER_ID IS NULL  AND o.ORDER_DATE_TIME < '2023-02-21')
		  )

GROUP BY
	o.ORDER_ID,
--	i.ADDRESS_ID,
	ab.ADDRESSBOOKID,
	i.ITEM_STATE,

	o.ORDER_DATE_TIME,
	o.ORDER_STATE,
	o.customer_id,
	o.ORDER_CURRENCYCODE,
	o.ORDER_STORE,
	i.ADDRESS_TYPE,
	i.DELIVERY_METHOD,
	i.TRACKING_CODE,
	i.PROPOSED_DELIVERY_DATE,
	i.ACTUAL_DESPATCH_DATE,
	i.ESTIMATED_DESPATCH_DATE,
	cte.mcd_customer_id,
	o.ORDER_NUMBER,
	o.mcd_order_id,
	o.postage_subtotal,
	o.ORDER_CASH_PAID,
	o.POSTAGE_SUBTOTAL,
	o.ORDER_ESIV,
	o.ORDER_ESEV,
	o.PRODUCT_DISCOUNT_INC_TAX,
	o.POSTAGE_SUBTOTAL,
	cte.EMAILADDRESS,
	AB.FIRSTNAME,
	AB.LASTNAME,
	AB.ADDRESS,
	AB.TOWN,
	AB.COUNTY,
	AB.POSTCODE,
	CN.COUNTRY,
	AB.EMAILADDRESS,
	AB.TELEPHONENO,
	oia.PRINTSITEID	
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
   i.MCD_CUSTOMER_ID,
   i.NewOrder,
   -- subTotalPrice
   CONCAT('{"centAmount": ', cast(i.subTotalPrice * 100 AS INT), ', "currencyCode": "', i.currencycode, '"}') AS subTotalPrice,
   -- totalPrice = subTotalPrice + totalShippingAmount
  -- CONCAT('{"centAmount": ', cast((i.subTotalPrice + i.totalShippingPrice) * 100 AS INT), ', "currencyCode": "', i.currencycode, '"}') AS totalPrice,
   CONCAT('{"centAmount": ', cast(i.GRANDTOTALFORPAYMENT * 100 AS INT), ', "currencyCode": "', i.currencycode, '"}') AS totalPrice,

  -- totalItemPrice = totalPrice + totalDiscount(?) - totalShippingAmount
   -- CONCAT('{"centAmount": ', cast((i.GRANDTOTALFORPAYMENT /*+ SUM(i.totalDiscount)*/ - SUM(i.totalShippingPrice)) * 100 AS INT), ', "currencyCode": "', i.currencycode, '"}') AS totalItemPrice,
   -- new: totalItemPrice = subTotalPrice = subTotalIncTax ?
   CONCAT('{"centAmount": ', cast(i.subTotalPrice * 100 AS INT), ', "currencyCode": "', i.currencycode, '"}') AS totalItemPrice,

   -- subTotalIncTax = totalItemPrice + totalShippingPrice
   -- CONCAT('{"centAmount": ', cast((i.GRANDTOTALFORPAYMENT + SUM(i.totalDiscount) /* - i.totalShippingPrice + i.totalShippingPrice*/) * 100 AS INT), ', "currencyCode": "', i.currencycode, '"}') AS subTotalIncTax,
   CONCAT('{"centAmount": ', cast(i.GRANDTOTALFORPAYMENT * 100 AS INT), ', "currencyCode": "', i.currencycode, '"}') AS subTotalIncTax,

   -- totalShippingPrice
   CONCAT('{"centAmount": ', cast(i.totalShippingPrice * 100 AS INT), ', "currencyCode": "', i.currencycode, '"}') AS totalShippingPrice,
   -- totalTaxExclusive
   CONCAT('{"centAmount": ', cast(i.totalTaxExclusive * 100 AS INT), ', "currencyCode": "', i.currencycode, '"}') AS totalTaxExclusive,
  -- CONCAT('{"centAmount": ', cast(i.totalPriceGross * 100 AS INT), ', "currencyCode": "', i.currencycode, '"}') AS totalPriceGross,
   -- totalDiscount
   CONCAT('{"centAmount": ', cast(i.totalDiscount * 100 AS INT), ', "currencyCode": "', i.currencycode, '"}') AS totalDiscount,
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
		 i.ORDER_STORE,
		 i.MCD_CUSTOMER_ID,
		 i.NewOrder,
		 i.subTotalPrice,
		 i.totalShippingPrice,
		 i.totalTaxExclusive,
		 i.totalDiscount
)

SELECT mcd_customer_id                       AS entity_key,
       o.customerid                          AS customer_id,
	   SUM(NewOrder)  						 AS mcd_orders_count,
	   COUNT(*) - SUM(NewOrder)  			 AS ct_orders_count,

			CONCAT('[',
				LISTAGG(
							CONCAT('{',
										 '"id": "', id, '"',
										 ',"customerId": "', o.customerId, '"',
										  IFNULL(CONCAT(',"state": ', '"', currentorderstate, '"'), ''),
										 ',"version": ', IFF(id like 'LEGO%', '0', '5'),
										 ',"createdAt": ', '"', createdAt, '"',
										  IFNULL(CONCAT(',"orderReference": ', '"', orderReference, '"'), ''),
										  IFNULL(CONCAT(',"customerEmail": "', customerEmail, '"'), ''),
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
FROM cte_order o
GROUP BY MCD_CUSTOMER_ID,
		 customer_id
ORDER BY MCD_CUSTOMER_ID
LIMIT :limit
WITH cte_customers_0
AS
(
SELECT o.customer_id, 
	   IFNULL(c.MCD_CUSTOMER_ID, MAX(o.MCD_CUSTOMER_ID)) AS MCD_CUSTOMERID
FROM "PROD"."DW_CORE".orders o
	 LEFT JOIN "PROD"."DW_CORE".customers c ON o.customer_id = c.customer_id			-- 4568 customers from orders table don't exist in customers table; and they have orders for migration.
WHERE o.brand = 'mnpg'
	  AND o.ORDER_DATE < '2023-04-01'	
GROUP BY o.customer_id, 
		 c.MCD_CUSTOMER_ID
HAVING MCD_CUSTOMERID IS NOT NULL
	   AND  MAX(o.ORDER_DATE) > dateadd(month, -26, '2023-04-01')
),

cte_customers_non_reportable_0
AS
(
SELECT DISTINCT o.customer_id  AS mcd_customer_id, 
		c.customer_id
FROM "PROD"."MCD_DW_CORE".mcd_orders_non_reportable o
	 LEFT JOIN "PROD"."DW_CORE".customers c 
        ON o.customer_id = c.mcd_customer_id	
	 LEFT JOIN "PROD"."RAW_CONSIGNMENT_SNAPSHOT"."MNPG_CONSIGNMENTS_API_PARSED" cs 
		ON o.commerce_tools_id = cs.ORDER_ID
WHERE (
	   o.commerce_tools_id NOT IN (SELECT order_id FROM "PROD"."DW_CORE".orders WHERE ORDER_DATE < '2023-04-01')
	   OR o.commerce_tools_id IS NULL 
	  )
	  AND o.ORDER_DATE < '2023-04-01'
	  AND (cs.ORDER_ID IS NULL  AND o.ORDER_DATE < '2023-02-21')
),

cte_customers_non_reportable_1
AS
(
SELECT  c.mcd_customer_id, 
		COALESCE(c.customer_id, p.CT_CUSTOMER_ID, c.mcd_customer_id::string) AS CUSTOMER_ID
FROM cte_customers_non_reportable_0 c
	LEFT JOIN events_lookup.mcd_ct_customer_profile_details p 
        ON c.mcd_customer_id = p.mcd_customer_id	
           AND p.CT_CUSTOMER_ID IS NOT NULL  
QUALIFY ROW_NUMBER() OVER (PARTITION BY 
	COALESCE(c.customer_id, p.CT_CUSTOMER_ID, c.mcd_customer_id::string), c.mcd_customer_id ORDER BY p.CT_MESSAGE_TIMESTAMP DESC) = 1  
),

cte_customers_non_reportable_2
AS
(
SELECT	CUSTOMER_ID, 
		MAX(mcd_customer_id) AS MCD_CUSTOMER_ID
FROM cte_customers_non_reportable_1
GROUP BY CUSTOMER_ID
),

cte_customers_non_reportable_3
AS
(
SELECT  c1.CUSTOMER_ID, 
		IFNULL(c2.MCD_CUSTOMERID, c1.MCD_CUSTOMER_ID) AS MCD_CUSTOMER_ID
FROM cte_customers_non_reportable_2 c1
	 LEFT JOIN cte_customers_0 c2 
		ON c1.CUSTOMER_ID = c2.CUSTOMER_ID
WHERE 
	(
	  CONCAT(:keys) IS NULL
	  AND IFNULL(c2.MCD_CUSTOMERID, c1.MCD_CUSTOMER_ID) > :migrateFromId
	  AND IFNULL(c2.MCD_CUSTOMERID, c1.MCD_CUSTOMER_ID) <= :migrateToId
	)
	 OR IFNULL(c2.MCD_CUSTOMERID, c1.MCD_CUSTOMER_ID) IN (:keys)
	/*  c1.customer_id  IN (
		'30683c84-d9f8-4195-85a3-a42d2ec7efb0',
		'5922e3e6-f9a7-46ec-8999-37584db07eb0',
		'b9278087-07ce-4c05-8d4d-a9a05c559782',
		'505606f7-1c26-4744-a89a-a8c02eeb7969',
		'9df7d77c-7100-499e-aee8-c46f449948b6')*/	 
),

cte_customers_non_reportable
AS
(
SELECT c.CUSTOMER_ID, MCD_CUSTOMER_ID, pc.EMAILADDRESS
FROM cte_customers_non_reportable_3 c
	LEFT JOIN PROD.RAW_MOONPIG_MCD_PERSONAL.customer pc 
		ON pc.customerid = c.mcd_customer_id
QUALIFY ROW_NUMBER() OVER (PARTITION BY c.CUSTOMER_ID, pc.CUSTOMERID ORDER BY pc.EXTRACT_DATE DESC) = 1		
),

cte_customers
AS
(
SELECT c.customer_id, c.MCD_CUSTOMERID AS MCD_CUSTOMER_ID, pc.EMAILADDRESS
FROM cte_customers_0 c
	LEFT JOIN PROD.RAW_MOONPIG_MCD_PERSONAL.customer pc 
		ON pc.customerid = c.MCD_CUSTOMERID
WHERE (
		(CONCAT(:keys) IS NULL
			AND MCD_CUSTOMERID > :migrateFromId
			AND MCD_CUSTOMERID <= :migrateToId)
         OR MCD_CUSTOMERID IN (:keys)
	   ) 
	   /*  c.customer_id  IN (
		'30683c84-d9f8-4195-85a3-a42d2ec7efb0',
		'5922e3e6-f9a7-46ec-8999-37584db07eb0',
		'b9278087-07ce-4c05-8d4d-a9a05c559782',
		'505606f7-1c26-4744-a89a-a8c02eeb7969',
		'9df7d77c-7100-499e-aee8-c46f449948b6')*/	 
QUALIFY ROW_NUMBER() OVER (PARTITION BY c.customer_id, pc.CUSTOMERID ORDER BY pc.EXTRACT_DATE DESC) = 1		
),

cte_GiftCards_Prices
AS
(
SELECT t1.order_id, 
	t1.order_line_item_id, 
  --  t1.product_unit_price - t1.product_discount_ex_tax  AS ITEM_ESEV,
	t2.item_esev_face_value  AS ITEM_ESEV,
  --  t1.product_unit_price - t1.product_discount_ex_tax + t2.O_ITEM_TAX_TOTAL AS ITEM_ESIV_NEW
	t2.item_esiv_face_value  AS ITEM_ESIV,
	t2.ITEM_DISCOUNT
	
FROM events_lookup.ct_order_items_detailed t1 
	JOIN order_items i ON t1.order_id = i.order_id AND i.order_line_item_id = t1.order_line_item_id
	JOIN orders o ON o.order_id = i.order_id
    JOIN mcd_dw_core.mcd_order_items t2 ON t1.mcd_order_id = t2.order_id AND t1.MCD_ITEM_ID = t2.item_id  AND t1.sku = t2.sku
    LEFT JOIN "PROD"."RAW_CONSIGNMENT_SNAPSHOT"."MNPG_CONSIGNMENTS_API_PARSED" cs ON o.ORDER_ID = cs.ORDER_ID  
WHERE t1.brand = 'mnpg'  
	 AND o.brand = 'mnpg'
     AND t1.PRODUCT_TYPE_NAME IN ('Gift Cards', 'Gift Experience')  
	 AND o.ORDER_DATE < '2023-04-01'
		  AND o.mcd_order_id IS NOT NULL
		  AND (
				o.mcd_order_id::STRING = o.order_id
				OR (cs.ORDER_ID IS NULL  AND o.ORDER_DATE < '2023-02-21')
			  ) 
),

cte_Order_Items
AS
(
	SELECT  -- Orders:
			o.mcd_order_id, o.order_id, o.ORDER_NUMBER, o.ORDER_DATE_TIME, o.customer_id, 
			c.MCD_CUSTOMER_ID, c.EMAILADDRESS, 
			o.ORDER_CURRENCYCODE, o.ORDER_STORE, o.ORDER_STATE, 
			o.POSTAGE_SUBTOTAL + o.POSTAGE_DISCOUNT_INC_TAX AS POSTAGE_PRICE, 
			o.MCD_CUSTOMER_ID AS MCD_CUSTOMER_ID_In_Order, 
			-- Order_Items:
			i.ORDER_LINE_ITEM_ID, i.MCD_ITEM_ID, i.DELIVERY_METHOD, i.ITEM_STATE, i.ADDRESS_TYPE, i.PROPOSED_DELIVERY_DATE, 
			i.ACTUAL_DESPATCH_DATE, i.ESTIMATED_DESPATCH_DATE, i.PRODUCT_TITLE, i.QUANTITY, 
			i.ITEM_ESIV AS ITEM_ESIV, 
			i.PRODUCT_TYPE_NAME, 
			i.SKU_VARIANT, i.SKU, i.TRACKING_CODE, i.PREPAY, i.BONUS, 
			i.item_esev AS item_esev,
			i.PRODUCT_DISCOUNT_INC_TAX AS ITEM_DISCOUNT
	FROM  cte_customers c
		  JOIN "PROD"."DW_CORE".orders o  ON c.customer_id = o.customer_id
		  JOIN "PROD"."DW_CORE".order_items i ON o.ORDER_ID = i.ORDER_ID
		  LEFT JOIN "PROD"."RAW_CONSIGNMENT_SNAPSHOT"."MNPG_CONSIGNMENTS_API_PARSED" cs ON o.ORDER_ID = cs.ORDER_ID
	WHERE o.brand = 'mnpg'
		  AND o.ORDER_DATE < '2023-04-01'
		  AND o.mcd_order_id IS NOT NULL
		  AND (
				o.mcd_order_id::STRING = o.order_id
				OR (cs.ORDER_ID IS NULL  AND o.ORDER_DATE < '2023-02-21')
			  ) 
	UNION ALL
	SELECT 
		-- Orders:
		r.ORDER_ID 			AS mcd_order_id, 
		IFNULL(r.commerce_tools_id, r.ORDER_ID::string) AS order_id, 
		r.ENCRYPTED_ORDER_ID AS ORDER_NUMBER, 
		r.ORDER_DATE 		AS ORDER_DATE_TIME, 
		c.customer_id 		AS customer_id, 
		c.MCD_CUSTOMER_ID	AS MCD_CUSTOMER_ID, 
		c.EMAILADDRESS		AS EMAILADDRESS,		
		cr.ISO4217CURRENCY	AS ORDER_CURRENCYCODE,
		
		CASE
			WHEN r.cardshop = 'Moonpig' THEN 'UK'
			WHEN r.cardshop = 'Moonpig Australia' THEN 'AU'
			WHEN r.cardshop = 'Moonpig USA' THEN 'US'
		END 				AS ORDER_STORE,
		
		IFF(r.ORDER_STATUS = 'Cancelled', 'Cancelled', 'Confirmed')  AS ORDER_STATE, 
	--	r.DISCOUNTGIVEN		AS PRODUCT_DISCOUNT_INC_TAX, 
		r.POSTAGE_EX_TAX_TOTAL + r.POSTAGE_TAX_TOTAL  AS POSTAGE_PRICE,
		r.customer_id		AS MCD_CUSTOMER_ID_In_Order,
		
		-- Order_Items:
		i.COMMERCETOOLS_LINE_ITEM_ID	AS ORDER_LINE_ITEM_ID,
		i.ITEM_ID						AS MCD_ITEM_ID,
		i.POSTAGE_TYPE					AS DELIVERY_METHOD,
		i.ITEM_STATUS					AS ITEM_STATE,
		i.ADDRESS_TYPE_NAME				AS ADDRESS_TYPE,
		NULL 							AS PROPOSED_DELIVERY_DATE, 
		i.DISPATCH_DATE					AS ACTUAL_DESPATCH_DATE,
		i.DISPATCH_DATE					AS ESTIMATED_DESPATCH_DATE,
		i.PRODUCT_TITLE					AS PRODUCT_TITLE,
		i.QUANTITY						AS QUANTITY,
		i.item_esiv_face_value 			AS ITEM_ESIV,
		i.PRODUCTCATEGORY				AS PRODUCT_TYPE_NAME,
		NULL 							AS SKU_VARIANT,
		i.SKU							AS SKU,
		i.COURIER_TRACKING_CODE			AS TRACKING_CODE,
		i.PREPAY						AS PREPAY, 
		i.BONUS							AS BONUS,
		i.item_esev_face_value 			AS item_esev,
		i.ITEM_DISCOUNT					AS ITEM_DISCOUNT
	FROM cte_customers_non_reportable c
		 JOIN cte_customers_non_reportable_1 c2 ON c.customer_id = c2.customer_id
		 JOIN "PROD"."MCD_DW_CORE".mcd_orders_non_reportable r ON r.customer_id = c2.mcd_customer_id
		 JOIN "PROD"."MCD_DW_CORE".mcd_order_items_non_reportable i ON r.ORDER_ID = i.ORDER_ID
		 LEFT JOIN "PROD"."RAW_CONSIGNMENT_SNAPSHOT"."MNPG_CONSIGNMENTS_API_PARSED" cs ON r.commerce_tools_id = cs.ORDER_ID
		 LEFT JOIN "PROD"."RAW_MOONPIG_MCD"."CURRENCY" cr ON r.CURRENCY_ID = cr.CURRENCYID
		-- LEFT JOIN cte_paidSum_nonreportable ps ON r.ORDER_ID = ps.ORDER_ID
	WHERE (
			r.commerce_tools_id NOT IN (SELECT order_id FROM "PROD"."DW_CORE".orders WHERE ORDER_DATE < '2023-04-01')
			OR r.commerce_tools_id IS NULL 
		  )
		  AND r.ORDER_DATE < '2023-04-01'
		  AND (cs.ORDER_ID IS NULL  AND r.ORDER_DATE < '2023-02-21')
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
	o.MCD_CUSTOMER_ID,
	o.MCD_CUSTOMER_ID_In_Order,
	TO_JSON(TO_VARIANT(replace(replace(replace(replace(o.EMAILADDRESS, '\r', ''),'\n', ' '), '"', ''), '\\', '/'))) AS customerEmail,
	o.ORDER_CURRENCYCODE AS currencycode,
	o.ORDER_STORE,
	
	case o.DELIVERY_METHOD
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
					--	 '_', case o.ITEM_STATE when 'Cancelled' then '2' else '1' end,
					--	 '_', DELIVERY_METHOD_ID,
							'_', ROW_NUMBER() OVER(PARTITION BY o.mcd_order_id, ab.ADDRESSBOOKID ORDER BY DELIVERY_METHOD_ID),
						 '"'),

		CONCAT(',"status": ', case o.ITEM_STATE when 'Cancelled' then 300 else 202 end),
		IFNULL(CONCAT(',"firstName": ', TO_JSON(TO_VARIANT(replace(replace(replace(replace(replace(ab.firstname, '\r', ''),'\n', ' '), '""',''''), '"',''''), '\\', '/')))  ), ''),
		IFNULL(CONCAT(',"lastName": ', TO_JSON(TO_VARIANT(replace(replace(replace(replace(replace(ab.lastname, '\r', ''),'\n', ' '), '""',''''), '"',''''), '\\', '/')))  ), ''),
		IFF(o.DELIVERY_METHOD = 'Email', ',"deliveryType": 1', ',"deliveryType": 0'),

		',"address": ', 	IFNULL(CONCAT('{',
												CONCAT('"id": ', '"', CONCAT('fake-', UUID_STRING()), '"'),
												IFNULL(CONCAT(',"firstName": ', TO_JSON(TO_VARIANT(replace(replace(replace(replace(replace(ab.firstname, '\r', ''),'\n', ' '), '""',''''), '"',''''), '\\', '/')))  ), ''),
												IFNULL(CONCAT(',"lastName": ', TO_JSON(TO_VARIANT(replace(replace(replace(replace(replace(ab.lastname, '\r', ''),'\n', ' '), '""',''''), '"',''''), '\\', '/')))  ), ''),
                                            --  IFNULL(CONCAT(',"houseNumber": "', 'streetnumber', '"'), ''),
											--	IFNULL(CONCAT(',"houseNumberExtension": "', 'streetnumberextension', '"'), ''),
											--	IFNULL(CONCAT(',"extraAddressLine": "', 'extraaddressline', '"'), ''),
											--	IFNULL(CONCAT(',"streetName": "', ab.ADDRESS, '"'), ''),
												IFNULL(CONCAT(',"addressFirstLine": ', TO_JSON(TO_VARIANT(replace(replace(replace(replace(replace(ab.ADDRESS, '\r', ''),'\n', ' '), '"',''''), '	', ' '), '\\','/')))    ), ''),
                                                IFNULL(CONCAT(',"city": ', TO_JSON(TO_VARIANT(replace(replace(replace(replace(ab.TOWN, '\r', ''),'\n', ' '), '"', ''''), '\\', '/')))), ''),
												IFNULL(CONCAT(',"state": ',  TO_JSON(TO_VARIANT(replace(replace(replace(replace(ab.COUNTY, '\r', ''),'\n', ' '), '"', ''''), '\\', '/')))), ''),
                                                IFNULL(CONCAT(',"postcode": ', TO_JSON(TO_VARIANT(replace(replace(replace(replace(ab.POSTCODE, '\r', ''),'\n', ' '), '"', ''''), '\\', '/')))  ), ''),
												IFNULL(CONCAT(',"country": ', CONCAT('"', replace(replace(trim(cn.COUNTRY), '\r', ''),'\n', ' '), '"')), ''),
												IFNULL(CONCAT(',"emailAddress": ', TO_JSON(TO_VARIANT(replace(replace(replace(replace(ab.EMAILADDRESS, '\r', ''),'\n', ' '), '"', ''), '\\', '/')))), ''),
												IFNULL(CONCAT(',"isMyAddress": ',  IFF(o.ADDRESS_TYPE = 'Customer Address', 'true', 'false') ), ''),
											--	CONCAT(',"isScrubbed": ', case when 'a.ID' IS NOT NULL AND 'a.street' = 'SCRUBBED' then 'true' else 'false' end),
												'}'), 'null'),

-- "recipientAddress" is the same as "address"
		',"recipientAddress": ', 	IFNULL(CONCAT('{',
												CONCAT('"id": ', '"', CONCAT('fake-', UUID_STRING()), '"'),
												IFNULL(CONCAT(',"firstName": ', TO_JSON(TO_VARIANT(replace(replace(replace(replace(replace(ab.firstname, '\r', ''),'\n', ' '), '""',''''), '"',''''), '\\', '/')))  ), ''),
												IFNULL(CONCAT(',"lastName": ', TO_JSON(TO_VARIANT(replace(replace(replace(replace(replace(ab.lastname, '\r', ''),'\n', ' '), '""',''''), '"',''''), '\\', '/')))  ), ''),
                                            --  IFNULL(CONCAT(',"houseNumber": "', 'streetnumber', '"'), ''),
											--	IFNULL(CONCAT(',"houseNumberExtension": "', 'streetnumberextension', '"'), ''),
											--	IFNULL(CONCAT(',"extraAddressLine": "', 'extraaddressline', '"'), ''),
											--	IFNULL(CONCAT(',"streetName": "', ab.ADDRESS, '"'), ''),
												IFNULL(CONCAT(',"addressFirstLine": ', TO_JSON(TO_VARIANT(replace(replace(replace(replace(replace(ab.ADDRESS, '\r', ''),'\n', ' '), '"',''''), '	', ' '), '\\','/')))    ), ''),
                                                IFNULL(CONCAT(',"city": ', TO_JSON(TO_VARIANT(replace(replace(replace(replace(ab.TOWN, '\r', ''),'\n', ' '), '"', ''''), '\\', '/')))), ''),
												IFNULL(CONCAT(',"state": ', TO_JSON(TO_VARIANT(replace(replace(replace(replace(ab.COUNTY, '\r', ''),'\n', ' '), '"', ''''), '\\', '/')))), ''),
                                                IFNULL(CONCAT(',"postcode": ', TO_JSON(TO_VARIANT(replace(replace(replace(replace(ab.POSTCODE, '\r', ''),'\n', ' '), '"', ''''), '\\', '/')))  ), ''),
												IFNULL(CONCAT(',"country": ', CONCAT('"', replace(replace(trim(cn.COUNTRY), '\r', ''),'\n', ' '), '"')), ''),
												IFNULL(CONCAT(',"emailAddress": ', TO_JSON(TO_VARIANT(replace(replace(replace(replace(ab.EMAILADDRESS, '\r', ''),'\n', ' '), '"', ''), '\\', '/')))), ''),
												IFNULL(CONCAT(',"isMyAddress": ',  IFF(o.ADDRESS_TYPE = 'Customer Address', 'true', 'false') ), ''),
											--	CONCAT(',"isScrubbed": ', case when 'a.ID' IS NOT NULL AND 'a.street' = 'SCRUBBED' then 'true' else 'false' end),
												'}'), 'null'),

		IFNULL(CONCAT(',"deliveryDate": ', CONCAT('"', cast(cast(o.PROPOSED_DELIVERY_DATE AS DATE) AS VARCHAR(50)), '"')), ''),
		IFNULL(CONCAT(',"actualDispatchDate": ', CONCAT('"', cast(cast(o.ACTUAL_DESPATCH_DATE AS DATE) AS VARCHAR(50)), '"')), ''),
		IFNULL(CONCAT(',"estimatedDispatchDate": ', CONCAT('"', cast(cast(o.ESTIMATED_DESPATCH_DATE AS DATE) AS VARCHAR(50)), '"')), ''),

		',"orderItems": ',	replace(replace(concat('[',
						LISTAGG(
							CONCAT('{',
							  --  '"id": "', IFNULL(o.ORDER_LINE_ITEM_ID, o.MCD_ITEM_ID::string), '"',
							    '"id": "', CONCAT('fake-', UUID_STRING()), '"',
							    IFNULL(CONCAT(',"title": ', TO_JSON(TO_VARIANT(replace(replace(replace(o.PRODUCT_TITLE, '"', ''''), '\r', ''),'\n', ' ')))), ''),
							   ',"quantity": ', o.QUANTITY,
							   CONCAT(',"totalPrice": ', CONCAT('{"centAmount": ', CAST(100 * 
											IFF(IFNULL(gc.ITEM_ESIV + IFNULL(gc.ITEM_DISCOUNT, 0), o.item_esiv + IFNULL(o.ITEM_DISCOUNT, 0)) 
												< 0, 0, IFNULL(gc.ITEM_ESIV + IFNULL(gc.ITEM_DISCOUNT, 0), o.item_esiv + IFNULL(o.ITEM_DISCOUNT, 0))) AS INT)
									, ', "currencyCode": "', IFNULL(o.ORDER_CURRENCYCODE, ''), '"}')),
							   CONCAT(',"unitPrice": ', CONCAT('{"centAmount": ', IFF(o.QUANTITY = 0, 0, CAST(100 * IFF(IFNULL(gc.ITEM_ESIV + IFNULL(gc.ITEM_DISCOUNT, 0), o.item_esiv + IFNULL(o.ITEM_DISCOUNT, 0)) < 0, 0, IFNULL(gc.ITEM_ESIV + IFNULL(gc.ITEM_DISCOUNT, 0), o.item_esiv + IFNULL(o.ITEM_DISCOUNT, 0))) / o.QUANTITY AS INT)), ', "currencyCode": "', IFNULL(o.ORDER_CURRENCYCODE, ''), '"}')),
							   IFNULL(CONCAT(',"productType": "', o.PRODUCT_TYPE_NAME, '"'), ''),
							   IFNULL(CONCAT(',"sku": "', o.SKU_VARIANT, '"'), ''),
							--   ',"productSlug": ""',
							   IFNULL(CONCAT(',"productKey": "', o.SKU, '"'), ''),
										'}'
									)

							, ',')
							, ']'), '{},', ''), ',{}', ''),

		',"deliveryInformation": ', 	CONCAT('{',
		
		CONCAT('"postageType": ', DELIVERY_METHOD_ID),
		
										IFNULL(CONCAT(',"deliveryMethodId": "', DELIVERY_METHOD_ID , '"'), ''),
										IFNULL(CONCAT(',"deliveryMethodName": "', IFF(DELIVERY_METHOD_ID = 5, 'None', o.DELIVERY_METHOD) , '"'), ''),
										IFNULL(CONCAT(',"trackingNumber": ', TO_JSON(TO_VARIANT(replace(replace(replace(replace(o.TRACKING_CODE, '\r', ''),'\n', ' '), '\\', '/'), '"', '''')))  ), ''),
									--	IFNULL(CONCAT(',"trackingUrl": ""'), ''),
									--	IFNULL(CONCAT(',"fullTrackingUrl": ""'), ''),
										',"fulfilmentCentre" : {',
										IFNULL(CONCAT('"id": "', oia.PRINTSITEID, '"'), ''),
										IFNULL(CONCAT(',"countryCode": "', case when oia.PRINTSITEID = 2 then 'AU' when oia.PRINTSITEID = 4 then 'US' when oia.PRINTSITEID IS NOT NULL then 'GB' end, '"'), ''),
										'}', '}'),
								   --		'deliveryType', dp.type,

		IFNULL(CONCAT(',"mobileNumber": ', TO_JSON(TO_VARIANT(replace(replace(replace(ab.TELEPHONENO, '\r', ''),'\n', ' '), '"', '')))  ), ''),
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

	SUM(IFNULL(o.PREPAY, 0) + IFNULL(o.BONUS, 0)) AS CreditsUsed,
--	o.ORDER_CASH_PAID AS GRANDTOTALFORPAYMENT,							-- will need + sum(CreditsUsed) in the next "group by"
--	GRANDTOTALFORPAYMENT - o.POSTAGE_SUBTOTAL	AS subTotalPrice,		-- will need + sum(CreditsUsed) in the next "group by"
	SUM(IFNULL(gc.ITEM_ESEV, o.item_esev))  AS totalTaxExclusive,
--	o.PRODUCT_DISCOUNT_INC_TAX AS totalDiscount,
	SUM(IFNULL(o.ITEM_DISCOUNT, 0)) AS totalDiscount,
	SUM(o.QUANTITY) AS totalItems,
	o.POSTAGE_PRICE AS totalShippingPrice,
	IFF(o.mcd_order_id::STRING = o.order_id, 1, 0) AS NewOrder,
	
	SUM(IFNULL(gc.ITEM_ESIV, o.item_esiv))  AS sum_Item_ESIV
		
FROM
	cte_Order_Items o	
	LEFT JOIN (
				SELECT ORDERNO,
					  ITEMNO,
					  DELIVERYADDRESSBOOKID,
					  PRINTSITEID
				FROM PROD.RAW_MOONPIG_MCD.ORDERITEMADDRESS 
				QUALIFY ROW_NUMBER() OVER (PARTITION BY ORDERNO, ITEMNO ORDER BY EXTRACT_DATE DESC, DELIVERYADDRESSBOOKID DESC) = 1
			  ) oia
			ON o.MCD_ORDER_ID = oia.ORDERNO
				AND o.MCD_ITEM_ID = oia.ITEMNO
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
	LEFT JOIN cte_GiftCards_Prices gc ON o.order_id = gc.order_id AND o.order_line_item_id = gc.order_line_item_id

GROUP BY
	o.ORDER_ID,
--	o.ADDRESS_ID,
	ab.ADDRESSBOOKID,
	case o.ITEM_STATE when 'Cancelled' then 300 else 202 end,

	o.ORDER_DATE_TIME,
	o.ORDER_STATE,
	o.customer_id,
	o.ORDER_CURRENCYCODE,
	o.ORDER_STORE,
	o.ADDRESS_TYPE,
	o.DELIVERY_METHOD,
	o.TRACKING_CODE,
	o.PROPOSED_DELIVERY_DATE,
	o.ACTUAL_DESPATCH_DATE,
	o.ESTIMATED_DESPATCH_DATE,
	o.mcd_customer_id,
	o.MCD_CUSTOMER_ID_In_Order,
	o.ORDER_NUMBER,
	o.mcd_order_id,
--	o.ORDER_CASH_PAID,
	o.POSTAGE_PRICE,
	--o.PRODUCT_DISCOUNT_INC_TAX,
	o.EMAILADDRESS,
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
   i.MCD_CUSTOMER_ID_In_Order,
   i.NewOrder,
   
   CONCAT('{"centAmount": ', cast((SUM(i.sum_Item_ESIV) + SUM(i.totalDiscount)) * 100 AS INT), ', "currencyCode": "', i.currencycode, '"}') 
   AS totalItemPrice,
   
-- subTotalPrice = totalItemPrice + ShippingPrice
   CONCAT('{"centAmount": ', cast((SUM(i.sum_Item_ESIV) + SUM(i.totalDiscount) + i.totalShippingPrice) * 100 AS INT), ', "currencyCode": "', i.currencycode, '"}') 
   AS subTotalPrice,
   
 /*  CONCAT('{"centAmount": ', cast(
								IFF(
									SUM(i.sum_Item_ESIV) - SUM(i.CreditsUsed) + i.totalShippingPrice < 0, 
									0,
									SUM(i.sum_Item_ESIV) - SUM(i.CreditsUsed) + i.totalShippingPrice
									)
								* 100 AS INT), ', "currencyCode": "', i.currencycode, '"}') 
   AS totalPaid,*/

   CONCAT('{"centAmount": ', cast(i.totalShippingPrice * 100 AS INT), ', "currencyCode": "', i.currencycode, '"}') 
   AS totalShippingPrice,

   CONCAT('{"centAmount": ', cast((SUM(i.totalTaxExclusive) + SUM(i.totalDiscount)) * 100 AS INT), ', "currencyCode": "', i.currencycode, '"}') 
   AS totalTaxExclusive,
   
   CONCAT('{"centAmount": ', cast(SUM(i.totalDiscount) * 100 AS INT), ', "currencyCode": "', i.currencycode, '"}') 
   AS totalDiscount,
   
   CONCAT('{"centAmount": ', cast(SUM(i.CreditsUsed) * 100 AS INT), ', "currencyCode": "', i.currencycode, '"}') 
   AS creditsUsed,
   
   SUM(i.totalItems) 
   AS totalItems,

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
	--	 i.GRANDTOTALFORPAYMENT,
		 i.createdAt,
		 i.orderReference,
		 i.customerId,
		 i.customerEmail,
		 i.ORDER_STORE,
		 i.MCD_CUSTOMER_ID,
		 i.MCD_CUSTOMER_ID_In_Order,
		 i.NewOrder,
	--	 i.subTotalPrice,
		 i.totalShippingPrice
	--	 i.totalDiscount
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
										  IFNULL(CONCAT(',"mcdCustomerId": ', '"', MCD_CUSTOMER_ID_In_Order, '"'), ''),
										  IFNULL(CONCAT(',"state": ', '"', currentorderstate, '"'), ''),
										 ',"version": ', IFF(id like 'LEGO%', '0', '5'),
										 ',"createdAt": ', '"', createdAt, '"',
										  IFNULL(CONCAT(',"orderReference": ', '"', orderReference, '"'), ''),
										  IFNULL(CONCAT(',"customerEmail":', customerEmail), ''),
										  IFNULL(CONCAT(',"store": "', ORDER_STORE, '"'), ''),
										  IFNULL(CONCAT(',"subTotalPrice": ', subTotalPrice), ''),
										  IFNULL(CONCAT(',"totalItemPrice": ', totalItemPrice), ''),
										  IFNULL(CONCAT(',"totalShippingPrice": ', totalShippingPrice), ''),
										  IFNULL(CONCAT(',"postagePrice": ', totalShippingPrice), ''),			 -- postagePrice = totalShippingPrice
										  IFNULL(CONCAT(',"subTotalIncTax": ', subTotalPrice), ''),
										  IFNULL(CONCAT(',"totalTaxExclusive": ', totalTaxExclusive), ''),
										  IFNULL(CONCAT(',"totalPrice": ', subTotalPrice), ''),
										  IFNULL(CONCAT(',"totalPriceGross": ', subTotalPrice), ''),			 	 -- totalPriceGross = totalPrice
										  IFNULL(CONCAT(',"totalDiscount": ', totalDiscount), ''),
										  ',"creditsUsed": ', creditsUsed,
										  IFNULL(CONCAT(',"totalPaid": ', subTotalPrice), ''),						 -- totalPaid = totalPriceGross = totalPrice
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
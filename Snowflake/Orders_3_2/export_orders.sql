WITH cte_customers_0
AS
(
SELECT o.customer_id, 
	   IFNULL(c.MCD_CUSTOMER_ID, MAX(o.MCD_CUSTOMER_ID)) AS MCD_CUSTOMERID
FROM orders o
	 LEFT JOIN customers c ON o.customer_id = c.customer_id			-- 16963 customers from orders not exist in customers; records with MCD_CUSTOMER_ID is null in "orders" but not null in "customers"
WHERE o.brand = 'mnpg'
	-- AND o.customer_id = 'b9278087-07ce-4c05-8d4d-a9a05c559782'
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
	--o.ORDER_ID AS id,
	IFF(o.mcd_order_id::STRING = o.order_id, concat('LEGO-', o.ORDER_NUMBER), o.ORDER_ID) AS id,
	o.ORDER_DATE_TIME AS createdAt,
	o.ORDER_STATE AS CURRENTORDERSTATE,
	o.ORDER_NUMBER AS orderReference,	-- ORDER_NUMBER: "The customer-facing order reference number for CT orders"
	o.customer_id AS customerid,
	cte.MCD_CUSTOMER_ID,
	cte.EMAILADDRESS AS customerEmail,
	o.ORDER_CURRENCYCODE AS currencycode,
	o.ORDER_STORE,

	CONCAT('{',
		'"id": ', CONCAT('"delivery_', o.ORDER_ID, '_', IFNULL(i.ADDRESS_ID, '0'), '_',
						 case i.ITEM_STATE when 'Cancelled' then '2' else '1' end,
						 '"'),

		CONCAT(',"status": ', case i.ITEM_STATE when 'Cancelled' then 300 else 202 end),
		IFNULL(CONCAT(',"firstName": "', ab.firstname, '"'), ''),
		IFNULL(CONCAT(',"lastName": "', ab.lastname,'"'), ''),
		IFF(i.DELIVERY_METHOD = 'Email', ',"deliveryType": 1', ',"deliveryType": 0'),

		',"address": ', 	IFNULL(CONCAT('{',
												CONCAT('"id": ', '"', CONCAT('fake-', UUID_STRING()), '"'),
												IFNULL(CONCAT(',"firstName": "', ab.firstname, '"'), ''),
												IFNULL(CONCAT(',"lastName": "', ab.lastname, '"'), ''),
                                            --  IFNULL(CONCAT(',"houseNumber": "', 'streetnumber', '"'), ''),
											--	IFNULL(CONCAT(',"houseNumberExtension": "', 'streetnumberextension', '"'), ''),
											--	IFNULL(CONCAT(',"extraAddressLine": "', 'extraaddressline', '"'), ''),
											--	IFNULL(CONCAT(',"streetName": "', ab.ADDRESS, '"'), ''),
												IFNULL(CONCAT(',"addressFirstLine": "', replace(replace(ab.ADDRESS, '\r\n', ' '),'\n', ' '), '"'), ''),
                                                IFNULL(CONCAT(',"city": "', ab.TOWN, '"'), ''),
												IFNULL(CONCAT(',"state": "', ab.COUNTY, '"'), ''),
                                                IFNULL(CONCAT(',"postcode": "', ab.POSTCODE, '"'), ''),
												IFNULL(CONCAT(',"country": ', CONCAT('"', cn.COUNTRY, '"')), ''),
												IFNULL(CONCAT(',"emailAddress": ', CONCAT('"', ab.EMAILADDRESS, '"')), ''),
												IFNULL(CONCAT(',"isMyAddress": ',  IFF(i.ADDRESS_TYPE = 'Customer Address', 'true', 'false') ), ''),
											--	CONCAT(',"isScrubbed": ', case when 'a.ID' IS NOT NULL AND 'a.street' = 'SCRUBBED' then 'true' else 'false' end),
												'}'), 'null'),

-- "recipientAddress" is the same as "address"
		',"recipientAddress": ', 	IFNULL(CONCAT('{',
												CONCAT('"id": ', '"', CONCAT('fake-', UUID_STRING()), '"'),
												IFNULL(CONCAT(',"firstName": "', ab.firstname, '"'), ''),
												IFNULL(CONCAT(',"lastName": "', ab.lastname, '"'), ''),
                                            --  IFNULL(CONCAT(',"houseNumber": "', 'streetnumber', '"'), ''),
											--	IFNULL(CONCAT(',"houseNumberExtension": "', 'streetnumberextension', '"'), ''),
											--	IFNULL(CONCAT(',"extraAddressLine": "', 'extraaddressline', '"'), ''),
											--	IFNULL(CONCAT(',"streetName": "', ab.ADDRESS, '"'), ''),
												IFNULL(CONCAT(',"addressFirstLine": "', replace(replace(ab.ADDRESS, '\r\n', ' '),'\n', ' '), '"'), ''),
                                                IFNULL(CONCAT(',"city": "', ab.TOWN, '"'), ''),
												IFNULL(CONCAT(',"state": "', ab.COUNTY, '"'), ''),
                                                IFNULL(CONCAT(',"postcode": "', ab.POSTCODE, '"'), ''),
												IFNULL(CONCAT(',"country": ', CONCAT('"', cn.COUNTRY, '"')), ''),
												IFNULL(CONCAT(',"emailAddress": ', CONCAT('"', ab.EMAILADDRESS, '"')), ''),
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
							    IFNULL(CONCAT(',"title": "', replace(replace(i.PRODUCT_TITLE, '''', '''' ), '"', ''''), '"'), ''),
							   ',"quantity": ', i.QUANTITY,
							   CONCAT(',"totalPrice": ', CONCAT('{"centAmount": ', CAST(100 * i.ITEM_ESIV AS INT), ', "currencyCode": "', o.ORDER_CURRENCYCODE, '"}')),
							   CONCAT(',"unitPrice": ', CONCAT('{"centAmount": ', IFF(i.QUANTITY = 0, 0, CAST(100 * i.ITEM_ESIV / i.QUANTITY AS INT)), ', "currencyCode": "', o.ORDER_CURRENCYCODE, '"}')),
							   IFNULL(CONCAT(',"productType": "', i.PRODUCT_TYPE_NAME, '"'), ''),
							   IFNULL(CONCAT(',"sku": "', i.SKU_VARIANT, '"'), ''),
							--   ',"productSlug": ""',
							   IFNULL(CONCAT(',"productKey": "', i.SKU, '"'), ''),
										'}'
									)

							, ',')
							, ']'), '{},', ''), ',{}', ''),

		',"deliveryInformation": ', 	CONCAT('{',
		
		CONCAT('"postageType": ', 
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
				else 5	-- 'None'
			end		
		),
		
										IFNULL(CONCAT(',"deliveryMethodId": "', IFNULL(i.DELIVERY_METHOD, 'NONE') , '"'), ''),
										IFNULL(CONCAT(',"deliveryMethodName": "', IFNULL(i.DELIVERY_METHOD, 'Standard') , '"'), ''),
										IFNULL(CONCAT(',"trackingNumber": "', i.TRACKING_CODE, '"'), ''),
									--	IFNULL(CONCAT(',"trackingUrl": ""'), ''),
									--	IFNULL(CONCAT(',"fullTrackingUrl": ""'), ''),
										',"fulfilmentCentre" : {',
										IFNULL(CONCAT('"id": "', i.FULFILMENT_CENTRE_ID, '"'), ''),
										IFNULL(CONCAT(',"countryCode": "', i.FULFILMENT_CENTRE_COUNTRY_CODE, '"'), ''),
										'}', '}'),
								   --		'deliveryType', dp.type,

		IFNULL(CONCAT(',"mobileNumber": "', ab.TELEPHONENO, '"'), ''),
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
	WITHVAT + DISCOUNTWITHVAT (POSTAGE_SUBTOTAL (?) +(?) POSTAGE_DISCOUNT_INC_TAX) -- answer: postage_subtotal
	*/

	o.ORDER_ESIV AS subTotalPrice,
	o.ORDER_ESEV AS totalTaxExclusive,
	o.PRODUCT_DISCOUNT_INC_TAX AS totalDiscount,
	SUM(i.QUANTITY) AS totalItems,
	--SUM(IFNULL(IFF(i.POSTAGE_SUBTOTAL > o.POSTAGE_SUBTOTAL AND o.POSTAGE_SUBTOTAL > 0, o.POSTAGE_SUBTOTAL, i.POSTAGE_SUBTOTAL), 0))  AS totalShippingPrice,
	o.POSTAGE_SUBTOTAL AS totalShippingPrice,

--	GRANDTOTALFORPAYMENT = SUM(PRODUCT_UNIT_PRICE + PRODUCT_DISCOUNT_INC_TAX + PRODUCT_TOTAL_TAX + POSTAGE_SUBTOTAL) ?
--	SUM(i.PRODUCT_UNIT_PRICE + i.PRODUCT_DISCOUNT_INC_TAX + i.PRODUCT_TOTAL_TAX + IFNULL(i.POSTAGE_SUBTOTAL, 0)) AS GRANDTOTALFORPAYMENT,
	o.ORDER_CASH_PAID  AS GRANDTOTALFORPAYMENT, -- from "Answers"
	-- CreditsUsed = PREPAY + BONUS ?
	SUM(IFNULL(PREPAY, 0) + IFNULL(BONUS, 0)) AS CreditsUsed,
	COUNT(*) AS orders_count

FROM
	-- (select * from orders where order_id IN ('52a49175-60c6-439d-b7cf-6339b7ae3854', '44ecebf0-e208-4736-b850-c170aa1309ea') or order_number = 'YYHRYCE') AS o
	-- (select * from cte_customers limit 3) cte
	cte_customers cte
	JOIN orders o ON cte.customer_id = o.customer_id
	JOIN order_items i ON o.ORDER_ID = i.ORDER_ID
	LEFT JOIN (
				SELECT ORDERNO,
					  ITEMNO,
					  DELIVERYADDRESSBOOKID
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

WHERE 
      o.brand = 'mnpg'
	  AND i.BRAND = 'mnpg'
--	  AND o.mcd_order_id::STRING = o.order_id

GROUP BY
	o.ORDER_ID,
	i.ADDRESS_ID,
	case i.ITEM_STATE when 'Cancelled' then 'CANCELLED' else 'SENT' end,

	case i.ITEM_STATE when 'Cancelled' then '2' else '1' end,
	o.ORDER_DATE_TIME,
	o.ORDER_STATE,
	o.customer_id,
	o.ORDER_CURRENCYCODE,
	o.ORDER_STORE,
	i.ADDRESS_TYPE,
	i.DELIVERY_METHOD,
	i.TRACKING_CODE,
	i.FULFILMENT_CENTRE_ID,
	i.FULFILMENT_CENTRE_COUNTRY_CODE,
	i.PROPOSED_DELIVERY_DATE,
	i.ACTUAL_DESPATCH_DATE,
	i.ESTIMATED_DESPATCH_DATE,
	i.ITEM_STATE,
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
	AB.TELEPHONENO	
),

cte_CT_order_cnt
AS
(
SELECT	o.customer_id AS customerid,
		COUNT(*) AS cnt
FROM orders o
	 JOIN cte_customers c ON o.customer_id = c.customer_id
WHERE o.BRAND = 'mnpg'
      AND o.mcd_order_id::STRING != o.order_id
GROUP BY o.customer_id
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
   -- subTotalPrice
   CONCAT('{"centAmount": ', cast(SUM(i.subTotalPrice) * 100 AS INT), ', "currencyCode": "', i.currencycode, '"}') AS subTotalPrice,
   -- totalPrice = subTotalPrice + totalShippingAmount
  -- CONCAT('{"centAmount": ', cast((i.subTotalPrice + i.totalShippingPrice) * 100 AS INT), ', "currencyCode": "', i.currencycode, '"}') AS totalPrice,
   CONCAT('{"centAmount": ', cast(i.GRANDTOTALFORPAYMENT * 100 AS INT), ', "currencyCode": "', i.currencycode, '"}') AS totalPrice,

  -- totalItemPrice = totalPrice + totalDiscount(?) - totalShippingAmount
   -- CONCAT('{"centAmount": ', cast((i.GRANDTOTALFORPAYMENT /*+ SUM(i.totalDiscount)*/ - SUM(i.totalShippingPrice)) * 100 AS INT), ', "currencyCode": "', i.currencycode, '"}') AS totalItemPrice,
   -- new: totalItemPrice = subTotalPrice = subTotalIncTax ?
   CONCAT('{"centAmount": ', cast(SUM(i.subTotalPrice) * 100 AS INT), ', "currencyCode": "', i.currencycode, '"}') AS totalItemPrice,

   -- subTotalIncTax = totalItemPrice + totalShippingPrice
   -- CONCAT('{"centAmount": ', cast((i.GRANDTOTALFORPAYMENT + SUM(i.totalDiscount) /* - i.totalShippingPrice + i.totalShippingPrice*/) * 100 AS INT), ', "currencyCode": "', i.currencycode, '"}') AS subTotalIncTax,
   CONCAT('{"centAmount": ', cast(i.GRANDTOTALFORPAYMENT * 100 AS INT), ', "currencyCode": "', i.currencycode, '"}') AS subTotalIncTax,

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

   i.currentorderstate,
   SUM(orders_count) AS orders_count

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
		 i.MCD_CUSTOMER_ID
)

SELECT mcd_customer_id                       AS entity_key,
       o.customerid                          AS customer_id,
       SUM(orders_count) - IFNULL(ct.cnt, 0) AS mcd_orders_count,
       IFNULL(ct.cnt, 0)                     AS ct_orders_count,

			CONCAT('[',

				LISTAGG(
							CONCAT('{',
										 '"id": "', id, '"',
										 ',"customerId": "', o.customerId, '"',
										 ',"state": ', '"', currentorderstate, '"',
										 ',"version": 0',
										 ',"createdAt": ', '"', createdAt, '"',
										 ',"orderReference": ', '"', orderReference, '"',
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
FROM cte_order o
	LEFT JOIN cte_CT_order_cnt AS ct ON o.customerid = ct.customerid
GROUP BY MCD_CUSTOMER_ID,
		 ct.cnt,
		 customer_id
ORDER BY MCD_CUSTOMER_ID
LIMIT :limit
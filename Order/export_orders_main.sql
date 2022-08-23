with cte_previwImages as (
SELECT
   o.id,
   o.currentorderstate,
   o.Created,
   o.ORDERCODE, 
   o.customerid,
   o.currencycode,
   o.channelid,
   cr.email,
   gpv.productKey,
   gpv.productTypeKey,
   gpv.sku_id,
   pn.nl_product_name,
   ol.id as  ol_id,
   ol.productamount,
   ol.totalwithvat,
   ol.individualshippingid,
   c.carddefinition,
 --  o.billingaddress,
	CASE
        WHEN prd.`TYPE` NOT IN ('gift_addon', 'cardpackaging') THEN 
		   concat('[', 
				 group_concat(
				   concat('{', 
						'"url": ', IFNULL(concat(case when c.carddefinition IS NULL then '"/images/static' else '"/images/custom' end, cct.BASEPREVIEWFILENAME, '"'), 'null'),
						  '}')
				  ) 
		   , ']')
	ELSE
		'[{"url": null}]'
	END  as S3ImagePrefix
   
FROM
--	(SELECT * FROM orders WHERE id = 1337079006 ORDER BY id DESC LIMIT 1000) o
    orders o
    JOIN orderline ol ON o.id = ol.orderid
    JOIN customerregistered cr ON o.customerid = cr.id
	LEFT JOIN productiteminbasket p ON p.ID = ol.PRODUCTITEMINBASKETID
	LEFT JOIN customercreatedcard c on p.CONTENTSELECTIONID = c.ID
    LEFT JOIN product prd on ol.productID = prd.id -- AND prd.`TYPE` NOT IN ('content', 'shipment') -- exists in WHERE
	LEFT JOIN customercreatedcardtemplate cct  ON c.ID = cct.CUSTOMERCREATEDCARD
	LEFT JOIN cardtemplate ct on ct.ID = cct.CARDSIDETEMPLATE
    LEFT JOIN tmp_dm_gift_product_variants gpv 
		ON (gpv.designId = c.carddefinition AND gpv.product_id = ol.productid AND prd.type = 'personalizedGift')
		   OR (gpv.product_id = ol.productid AND c.carddefinition  IS NULL)		-- "tmp_dm_gift_product_variants" has not unique product_id
		   OR (gpv.product_id = ol.productid AND c.carddefinition IS NOT NULL  AND gpv.designId  IS NULL)
	LEFT JOIN (SELECT DISTINCT product_id, nl_product_name FROM tmp_dm_gift_product_variants) pn
		ON pn.product_id = ol.productid
	
WHERE
   (
    o.customerid > :migrateFromId and o.customerid <= :migrateToId
	and IFNULL(cr.lastactivitydate, cr.REGISTRATIONDATE) > CURRENT_DATE() - INTERVAL 25 MONTH
	and o.channelid = 2
	and o.currentorderstate not in (
			'ADDED_BILLINGADDRES_INFORMATION',
			'CREATED_FOR_SHOPPINGBASKET',
			'CREATED_FOR_WALLETDEPOSIT',
			'PAYMENT_FAILED',
			'PAYMENT_FAILED_AFTER_PRINTING',
			'PAYMENT_STARTED_BIBIT_DIRECT',
			'PAYMENT_STARTED_BIBIT_REDIRECT',
			'PENDING_INVOICE',
			'UPDATED_BILLINGADDRES_INFORMATION',
			'PAID_ADYEN_PENDING_HELD',
			'CANCELLED')
	and gpv.productKey IS NOT null
	and concat(:keys) IS NULL
   )
   or o.customerid in (:keys)
GROUP BY
		 ol.id
),

cte_Individualshipping AS
(
SELECT
   o.id,
   concat('LEGO-', o.ORDERCODE) AS id_str,
   o.Created AS createdAt,
   o.ORDERCODE AS orderReference, 
   o.customerid AS customerId,
   o.email AS customerEmail,
   o.currencycode,
 --  CONCAT('{"centAmount": ', cast(o.grandtotalforpayment * 100 AS INT), ', "currencyCode": "', o.currencycode, '"}') AS totalPrice,
   IFNULL(sbp.priceWithVat, 0) + IFNULL(sbp.discountWithVat, 0) AS totalShippingPrice,
   
   CONCAT('{',
		'"id": ', CONCAT('"delivery_', 'LEGO-', o.ORDERCODE, '"'),
		
		IFNULL(CONCAT(',"status": ', CONCAT('"', 
			case 
				 when sds.currentState in ('AVAILABLE_AT_PICKUP_POINT', 'NOT_AT_HOME', 'UITLEVERING') then 'SENT'
				 when sds.currentState = 'DELETED' then 'CANCELLED'
				 when sds.currentState IS NOT NULL then 'RECEIVED'
			end
		, '"')), ''), 
		
		IFNULL(CONCAT(',"firstName": ', CONCAT('"', r.firstname, '"')), ''), 
		IFNULL(CONCAT(',"lastName": ', CONCAT('"', r.lastname, '"')), ''), 
		IFNULL(CONCAT(',"deliveryType": ', CONCAT('"', 'DeliveryType.STANDARD', '"')), ''), 
		
		',"address": ', 	IFNULL(CONCAT('{',
												CONCAT('"id": ', '"', CONCAT('fake-', UUID()), '"'),
												IFNULL(CONCAT(',"firstName": ', CONCAT('"', r.firstname, '"')), ''), 
												IFNULL(CONCAT(',"lastName": ', CONCAT('"', r.lastname, '"')), ''), 	
											--	',"title": null', 	
											--	',"addressFirstLine": null', 	
												IFNULL(CONCAT(',"houseNumber": ', CONCAT('"', case when a.ID IS NOT NULL then a.streetnumber else a2.streetnumber end, '"')), ''), 
												IFNULL(CONCAT(',"houseNumberExtension": ', CONCAT('"', case when a.ID IS NOT NULL then a.streetnumberextension else a2.streetnumberextension end, '"')), ''), 
												IFNULL(CONCAT(',"extraAddressLine": "', case when a.ID IS NOT NULL then 
																								case when COALESCE(a.extraaddressline1, a.extraaddressline2, a.extraaddressline3) IS NULL
																									then NULL
																								else
																									trim(concat(nvl(a.extraaddressline1, ''), ' ', nvl(a.extraaddressline2, ''), ' ', nvl(a.extraaddressline3, '')))
																								end
																						else 
																								case when COALESCE(a2.extraaddressline1, a2.extraaddressline2, a2.extraaddressline3) IS NULL
																									then NULL
																								else
																									trim(concat(nvl(a2.extraaddressline1, ''), ' ', nvl(a2.extraaddressline2, ''), ' ', nvl(a2.extraaddressline3, '')))
																								end
																						end, '"'
															 )
													, ''),												
												
												IFNULL(CONCAT(',"streetName": ', CONCAT('"', case when a.ID IS NOT NULL then a.street else a2.street end, '"')), ''), 
												IFNULL(CONCAT(',"city": ', CONCAT('"', case when a.ID IS NOT NULL then a.city else a2.city end, '"')), ''), 
												IFNULL(CONCAT(',"state": ', CONCAT('"', case when a.ID IS NOT NULL then a.STATEPROVINCECOUNTY else a2.STATEPROVINCECOUNTY end, '"')), ''), 												
												IFNULL(CONCAT(',"postcode": ', CONCAT('"', case when a.ID IS NOT NULL then a.zippostalcode else a2.zippostalcode end, '"')), ''),   
												IFNULL(CONCAT(',"country": ', CONCAT('"', case when a.ID IS NOT NULL then c.ENGLISHCOUNTRYNAME else c2.ENGLISHCOUNTRYNAME end, '"')), ''),   
												IFNULL(CONCAT(',"emailAddress": ', CONCAT('"', cea.email, '"')), ''),
												IFNULL(CONCAT(',"isMyAddress": ', case when a.ID IS NOT NULL then 'false' when a2.ID IS NOT NULL then 'true' end), ''),
												'}'), 'null'),
			

-- "recipientAddress" is the same as "address"
		',"recipientAddress": ', 	IFNULL(CONCAT('{',
												CONCAT('"id": ', '"', CONCAT('fake-', UUID()), '"'),
												IFNULL(CONCAT(',"firstName": ', CONCAT('"', r.firstname, '"')), ''), 
												IFNULL(CONCAT(',"lastName": ', CONCAT('"', r.lastname, '"')), ''), 	
											--	',"title": null', 	
											--	',"addressFirstLine": null', 	
												IFNULL(CONCAT(',"houseNumber": ', CONCAT('"', case when a.ID IS NOT NULL then a.streetnumber else a2.streetnumber end, '"')), ''), 
												IFNULL(CONCAT(',"houseNumberExtension": ', CONCAT('"', case when a.ID IS NOT NULL then a.streetnumberextension else a2.streetnumberextension end, '"')), ''), 
												IFNULL(CONCAT(',"extraAddressLine": "', case when a.ID IS NOT NULL then 
																								case when COALESCE(a.extraaddressline1, a.extraaddressline2, a.extraaddressline3) IS NULL
																									then NULL
																								else
																									trim(concat(nvl(a.extraaddressline1, ''), ' ', nvl(a.extraaddressline2, ''), ' ', nvl(a.extraaddressline3, '')))
																								end
																						else 
																								case when COALESCE(a2.extraaddressline1, a2.extraaddressline2, a2.extraaddressline3) IS NULL
																									then NULL
																								else
																									trim(concat(nvl(a2.extraaddressline1, ''), ' ', nvl(a2.extraaddressline2, ''), ' ', nvl(a2.extraaddressline3, '')))
																								end
																						end, '"'
															 )
													, ''),												
												
												IFNULL(CONCAT(',"streetName": ', CONCAT('"', case when a.ID IS NOT NULL then a.street else a2.street end, '"')), ''), 
												IFNULL(CONCAT(',"city": ', CONCAT('"', case when a.ID IS NOT NULL then a.city else a2.city end, '"')), ''), 
												IFNULL(CONCAT(',"state": ', CONCAT('"', case when a.ID IS NOT NULL then a.STATEPROVINCECOUNTY else a2.STATEPROVINCECOUNTY end, '"')), ''), 												
												IFNULL(CONCAT(',"postcode": ', CONCAT('"', case when a.ID IS NOT NULL then a.zippostalcode else a2.zippostalcode end, '"')), ''),   
												IFNULL(CONCAT(',"country": ', CONCAT('"', case when a.ID IS NOT NULL then c.ENGLISHCOUNTRYNAME else c2.ENGLISHCOUNTRYNAME end, '"')), ''),   
												IFNULL(CONCAT(',"emailAddress": ', CONCAT('"', cea.email, '"')), ''),
												IFNULL(CONCAT(',"isMyAddress": ', case when a.ID IS NOT NULL then 'false' when a2.ID IS NOT NULL then 'true' end), ''),
												'}'), 'null'),

		IFNULL(CONCAT(',"deliveryDate": ', CONCAT('"', cast(cast(sds.deliveredTime AS DATE) AS VARCHAR(50)), '"')), ''), 
		-- estimatedDispatchDate
		IFNULL(CONCAT(',"actualDispatchDate": ', CONCAT('"', cast(cast(dp.pickupDate AS DATE) AS VARCHAR(50)), '"')), ''),  
		IFNULL(CONCAT(',"promisedDeliveredDate": ', CONCAT('"', cast(cast(dp.deliveryDate AS DATE) AS VARCHAR(50)), '"')), ''), 
		
		',"orderItems": ',	concat('[',
						group_concat(
							CONCAT('{',
							   '"id": ', o.ol_id,
							    ',"previewImages": null',
							    ',"S3ImagePrefix": ', S3ImagePrefix, 
							--	   '"lineItemId": ', o.ORDERLINEIDX,
							    IFNULL(CONCAT(',"title": ', CONCAT('"', o.nl_product_name, '"')), ''),  
							--    IFNULL(CONCAT(',"titleEn": ', CONCAT('"', o.en_product_name, '"')), ''), 
							   ',"quantity": ', o.productamount,
							   CONCAT(',"totalPrice": ', CONCAT('{"centAmount": ', cast(100 * o.totalwithvat AS INT), ', "currencyCode": "', o.currencycode, '"}')),  
							   CONCAT(',"unitPrice": ', CONCAT('{"centAmount": ', cast(100 * o.totalwithvat/o.productamount as DECIMAL(10,2)), ', "currencyCode": "', o.currencycode, '"}')), 
							--   ',"taxCategory": ',  CONCAT('"', concat('vat', o.vatcode), '"'),
							   ',"productType": ', CONCAT('"', o.productTypeKey, '"'),
							   ',"skuId": ', CONCAT('"', case o.productTypeKey when 'greetingcard' then concat('GRTZ', o.carddefinition, '-STANDARDCARD') else o.sku_id end, '"'), 
							   ',"productSlug": ', CONCAT('"', case o.productTypeKey when 'greetingcard' then concat('GRTZ', o.carddefinition) else o.productKey end, '"'), 
							   ',"productKey": ', CONCAT('"', case o.productTypeKey when 'greetingcard' then concat('GRTZ', o.carddefinition) else o.productKey end, '"'), 
										'}')
									)
							, ']'),
		 							
		',"deliveryInformation": ', 	CONCAT('{',
										IFNULL(CONCAT('"deliveryMethodId": ', CONCAT('"', IFNULL(ct.id, 'NONE') , '"')), ''),
										IFNULL(CONCAT(',"deliveryMethodName": ', CONCAT('"', IFNULL(ct.type, 'Standard'), '"')), ''),
										IFNULL(CONCAT(',"trackingUrl": ', CONCAT('"', isp.TRACKANDTRACECODE, '"')), ''),
										',"fulfilmentCentre" : {"id" : "2", "countryCode": "NL"}',
										'}'),
								   --		'deliveryType', dp.type,
		
		IFNULL(CONCAT(',"mobileNumber": ', CONCAT('"', case when a.ID IS NOT NULL then mct.mobile_phone else mcm.mobile_phone end, '"')), ''),  
		'}'				
		)
	AS orderDelivery,
	o.currentorderstate

FROM
	cte_previwImages o
   /*orders o
   join orderline ol
      on o.id = ol.orderid
   join customerregistered cr
      on o.customerid = cr.id
   join tmp_dm_gift_product_variants gpv
      on gpv.product_id = ol.productid
   left join orderbillingaddress oba
      on oba.id = o.billingaddress*/
   left join individualshipping isp
       on o.individualshippingid = isp.id
   left join shipmentdeliverystatus sds
	   on isp.id = sds.individualshippingid
   left join shipmentinformation si
	   on isp.SHIPMENTINFORMATIONID = si.id
   left join deliverypromise dp
	   on si.deliverypromise_id = dp.id
   left join recipient r
       on isp.recipientid = r.id
   left join address a
       on r.addressid = a.id
   left join country c
       on a.countrycode = c.TWOLETTERCOUNTRYCODE
   left join contactemailaddress cea
	   on r.contactid = cea.contactid
		  and cea.emailidx = 0
   left join paazlshipmentinformation psi
	   on si.id = psi.id
   left join carriertype ct
       on psi.type = ct.type and psi.carrier = ct.carrier
   left join address a2
      on o.customerid = a2.customerid and a2.DEFAULTADDRESS = 'Y'
   left join country c2
       on a2.countrycode = c2.TWOLETTERCOUNTRYCODE
   left join channel ch
	  on o.channelid = ch.id
   left join shoppingbasketprice sbp
	  on isp.INDIVIDUALSHIPPINGPRICEID = sbp.id
   left join vat v
		on sbp.vatId = v.id
   left join tmp_dm_mobileByContact mct
		on mct.contactid = r.contactid
   left join tmp_dm_mobileByCustomer mcm
		on mcm.customerid = o.customerid

GROUP BY
		 o.customerId,
		 o.id,
		 o.individualshippingid
),

cte_Prices
AS
(
SELECT  o.id,
		o.id_str,
		sum(ol.WITHVAT) AS subTotalPrice,
		sum(ol.WITHOUTVAT) AS totalTaxExclusive,
		abs(sum(ol.DISCOUNTWITHVAT)) AS totalDiscount,
		sum(ol.productamount) AS totalItems
FROM
	(SELECT DISTINCT id, id_str FROM cte_Individualshipping) o 
	 JOIN orderline ol ON o.id = ol.orderid
GROUP BY o.id	 
),

cte_order 
AS
(
SELECT
   i.id,
   i.id_str,
   i.createdAt,
   i.orderReference, 
   i.customerId,
   i.customerEmail,
   -- subTotalPrice
   CONCAT('{"centAmount": ', cast(p.subTotalPrice * 100 AS INT), ', "currencyCode": "', i.currencycode, '"}') AS subTotalPrice,
   -- totalPrice = subTotalPrice + totalShippingAmount
   CONCAT('{"centAmount": ', cast((p.subTotalPrice + i.totalShippingPrice) * 100 AS INT), ', "currencyCode": "', i.currencycode, '"}') AS totalPrice,
   -- totalItemPrice = totalPrice + totalDiscount - totalShippingAmount
   CONCAT('{"centAmount": ', cast((p.subTotalPrice + i.totalShippingPrice + p.totalDiscount - i.totalShippingPrice) * 100 AS INT), ', "currencyCode": "', i.currencycode, '"}') AS totalItemPrice,
   -- subTotalIncTax = totalItemPrice + totalShippingPrice
   CONCAT('{"centAmount": ', cast((p.subTotalPrice + i.totalShippingPrice + p.totalDiscount /* - i.totalShippingPrice + i.totalShippingPrice*/) * 100 AS INT), ', "currencyCode": "', i.currencycode, '"}') AS subTotalIncTax,
   -- totalShippingPrice
   CONCAT('{"centAmount": ', cast(i.totalShippingPrice * 100 AS INT), ', "currencyCode": "', i.currencycode, '"}') AS totalShippingPrice,
   -- totalTaxExclusive
   CONCAT('{"centAmount": ', cast(p.totalTaxExclusive * 100 AS INT), ', "currencyCode": "', i.currencycode, '"}') AS totalTaxExclusive,
  -- CONCAT('{"centAmount": ', cast(p.totalPriceGross * 100 AS INT), ', "currencyCode": "', i.currencycode, '"}') AS totalPriceGross,
   -- totalDiscount
   CONCAT('{"centAmount": ', cast(p.totalDiscount * 100 AS INT), ', "currencyCode": "', i.currencycode, '"}') AS totalDiscount,
   -- creditsUsed (const)
   CONCAT('{"centAmount": 0, "currencyCode": "', i.currencycode, '"}') AS creditsUsed,
   p.totalItems,
   
	concat('[',
	TRIM(LEADING ',' FROM CONCAT(
		group_concat(IFNULL(i.orderDelivery, ''))
	))
			, ']')
	AS deliveries,
	
   i.currentorderstate
		
FROM cte_Individualshipping i
	 LEFT JOIN cte_Prices p ON i.id = p.id
GROUP BY
		 i.customerId,
		 i.id
)

SELECT
	   customerId AS entity_key,
			CONCAT('[',
				
				group_concat(
							CONCAT('{',
										 '"id": "', id_str, '"',
										  ',"state": ', '"', currentorderstate, '"',
										 ',"version": 0', 
										 ',"createdAt": ', '"', createdAt, '"',
										 ',"orderReference": ', '"', orderReference, '"',
										 ',"customerId": ', customerId,
										  IFNULL(CONCAT(',"customerEmail": ', CONCAT('"', customerEmail, '"')), ''),
										  ',"store": "NL"', 
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
										 
										))
								,']')

		AS orders
FROM cte_order
GROUP BY customerId
LIMIT :limit
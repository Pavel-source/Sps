WITH cte_productimage_0
AS
(
SELECT pi.PRODUCTID, pi.WIDTH, pi.HEIGHT, pi.EXTENSION,
	   ROW_NUMBER() OVER(PARTITION BY pi.PRODUCTID ORDER BY pi.WIDTH DESC) AS RN
FROM productimage pi
	 JOIN product p ON pi.productid = p.ID
WHERE `code` = 'greetz.detail.1' 
	and p.`TYPE` NOT IN ('personalizedGift', 'cardpackaging', 'productCardSingle')
),

cte_productimage
AS
(
SELECT * FROM cte_productimage_0 WHERE RN = 1
),

cte_previwImages AS (
SELECT
   o.id,
   o.currentorderstate,
   o.Created,
   o.ORDERCODE, 
   o.customerid,
   o.currencycode,
   o.channelid,
   o.GRANDTOTALFORPAYMENT,
   cr.email,
   gpv.productKey,
   gpv.productTypeKey,
   gpv.sku_id,
   gpv.PRODUCTCODE,
   gpv.type AS product_type,
   pn.nl_product_name,
   ol.id AS ol_id,
   ol.productamount,
   ol.totalwithvat,
   ol.TOTALWITHOUTVAT,
   ol.DISCOUNTWITHVAT,
   ol.WITHVAT,
   ol.individualshippingid,
   ol.PRODUCTITEMINBASKETID,
   c.carddefinition,   
 --  o.billingaddress,
	CASE
        WHEN gpv.`TYPE` NOT IN ('standardGift', 'gift_addon', 'cardpackaging', 'gift_surcharge', 'content',
								'shipment',	'outerCarton', 'sound',	'packetToSelfSurcharge', 'trimoption') 
		THEN 
		   concat('[', 
				IFNULL(
					 group_concat(
							concat(case when c.carddefinition IS NULL then '"/images/static' else '"/images/custom' end, cct.BASEPREVIEWFILENAME, '"')
					  ) 
				, '')  
		   , ']')
	END  as s3ImagePrefixes,
	
	CASE
		WHEN gpv.`TYPE` = 'cardpackaging' THEN  CONCAT('["/images/static/opt/greetz3/images/product/2/', gpv.productcode, '/','ENVELOPE.jpg"]')  
		WHEN gpv.`TYPE` IN ('gift_addon', 'standardGift') THEN CONCAT('["/images/static/opt/greetz3/images/product/2/', gpv.productcode, '/','greetz.detail.1_', im.HEIGHT,'_', im.WIDTH,EXTENSION, '"]') 
	ELSE
		'[]'
    END  as s3ImagePrefixes_2
	
	/*case when gpv.TYPE = 'productCardSingle'
	then
	  SUM(case gpv.TYPE in ('productCardSingle', 'content') then ol.TOTALWITHVAT else 0 end) 
	  OVER (PARTITION BY o.id 
	  ORDER BY case gpv.TYPE  when 'productCardSingle' then 1  when 'content' then 2 else 3 end 
	  ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) 
	else
		 ol.TOTALWITHVAT
	end  AS TOTALWITHVAT*/
	
	
FROM
--	(SELECT * FROM orders WHERE ordercode = '1-4RKXKMFYL1' /*id = 1337079006*/ ORDER BY id DESC LIMIT 1000) o
    orders o
    JOIN orderline ol ON o.id = ol.orderid
    JOIN customerregistered cr ON o.customerid = cr.id
	LEFT JOIN productiteminbasket p ON p.ID = ol.PRODUCTITEMINBASKETID
	LEFT JOIN customercreatedcard c on p.CONTENTSELECTIONID = c.ID
	LEFT JOIN customercreatedcardtemplate cct  ON c.ID = cct.CUSTOMERCREATEDCARD
	LEFT JOIN cardtemplate ct on ct.ID = cct.CARDSIDETEMPLATE
    JOIN tmp_dm_gift_product_variants gpv 
		ON (gpv.designId = c.carddefinition AND gpv.product_id = ol.productid AND gpv.type = 'personalizedGift')
		   OR (gpv.product_id = ol.productid AND c.carddefinition  IS NULL)		-- "tmp_dm_gift_product_variants" has not unique product_id
		   OR (gpv.product_id = ol.productid AND c.carddefinition IS NOT NULL  AND gpv.designId  IS NULL)
	LEFT JOIN (SELECT DISTINCT product_id, nl_product_name FROM tmp_dm_gift_product_variants) pn
		ON pn.product_id = ol.productid
	LEFT JOIN cte_productimage im 
		ON gpv.product_id = im.PRODUCTID
		
	/*LEFT JOIN orderline ol_2 
	JOIN tmp_dm_gift_product_variants gpv_2
		ON gpv_2.product_id = ol_2.PRODUCTID AND gpv_2.type = 'content'
		ON ol.orderid = ol_2.orderid AND gpv.type = 'productCardSingle' AND ol.PRODUCTITEMINBASKETID = ol_2.PRODUCTITEMINBASKETID*/
	
WHERE
   
    ((o.customerid > :migrateFromId and o.customerid <= :migrateToId  and  concat(:keys) IS NULL)
	OR o.customerid in (:keys))
    and IFNULL(IFNULL(lastactivitydate, LASTLOGINDATE), REGISTRATIONDATE) > '2022-08-27' - INTERVAL 25 MONTH
	and o.channelid = 2
	and cr.channelid = 2
    and cr.active = 'Y'
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
	and o.CONTRAFORORDERID IS NULL
	-- and gpv.type != 'content'
GROUP BY 
		ol.id
),

cte_content AS
(
SELECT id, PRODUCTITEMINBASKETID, totalwithvat
FROM cte_previwImages o
WHERE o.product_type = 'content'
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
   o.GRANDTOTALFORPAYMENT,
   o.currencycode,
 --  CONCAT('{"centAmount": ', cast(o.grandtotalforpayment * 100 AS INT), ', "currencyCode": "', o.currencycode, '"}') AS totalPrice,
  -- IFNULL(sbp.priceWithVat, 0) + IFNULL(sbp.discountWithVat, 0) AS totalShippingPrice,
   
   CONCAT('{',
		'"id": ', CONCAT('"delivery_', 'LEGO-', o.ORDERCODE, '-', IFNULL(o.individualshippingid, 0), '"'),
		
		IFNULL(CONCAT(',"status": ', CONCAT('"', 
			case 
				 when sds.currentState in ('AVAILABLE_AT_PICKUP_POINT', 'NOT_AT_HOME', 'UITLEVERING', 'DELIVERED', 'DELIVEREDBB') then 'SENT'
				 when sds.currentState = 'NEW' AND shipmentnotificationdate IS NOT NULL then 'SENT'
				 when sds.currentState = 'DELETED' then 'CANCELLED'
                 when isp.CANCELLATIONTYPE = 'REFUND' then 'CANCELLED'
				 else 'RECEIVED'
			end
		, '"')), ''), 
		
		IFNULL(CONCAT(',"firstName": ', CONCAT('"', r.firstname, '"')), ''), 
		IFNULL(CONCAT(',"lastName": ', CONCAT('"', r.lastname, '"')), ''), 
		IFNULL(CONCAT(',"deliveryType": ', CONCAT('"', 'POSTAL', '"')), ''),
		
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
												IFNULL(CONCAT(',"isMyAddress": ', case when a2.ID IS NOT NULL then 'true' else 'false' end), ''),
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
		IFNULL(CONCAT(',"actualDispatchDate": ', CONCAT('"', cast(cast(dp.pickupDate AS DATE) AS VARCHAR(50)), '"')), ''),  
		IFNULL(CONCAT(',"estimatedDispatchDate": ', CONCAT('"', cast(cast(
																	IFNULL(dp.deliveryDate, case when productcode like 'wallet%' then o.created + INTERVAL 1 day end) 
																AS DATE) AS VARCHAR(50)), '"')), ''),
		
		',"orderItems": ',	replace(concat('[',
						group_concat(
						
							CASE
							WHEN o.product_type NOT IN (
														'content',
														'shipment',
														'outerCarton',
														'sound',
														'packetToSelfSurcharge',
														'trimoption'
														)
							THEN
						
							CONCAT('{',
							   '"id": ', o.ol_id,
                                ',"previewImages": []',
							    ',"s3ImagePrefixes": ', IFNULL(s3ImagePrefixes, s3ImagePrefixes_2), 
							--	   '"lineItemId": ', o.ORDERLINEIDX,
							    IFNULL(CONCAT(',"title": ', CONCAT('"', case 
																		when o.productTypeKey = 'greetingcard' then 'Kaart' 
																		when env.code IS NOT NULL then env.name
																		else replace(o.nl_product_name, '"', '\\"')
																		end, '"')), ''),  
							--    IFNULL(CONCAT(',"titleEn": ', CONCAT('"', o.en_product_name, '"')), ''), 
							   ',"quantity": ', o.productamount,
							   CONCAT(',"totalPrice": ', CONCAT('{"centAmount": ', cast(100 * (o.totalwithvat + IFNULL(co.totalwithvat, 0)) AS INT), ', "currencyCode": "', o.currencycode, '"}')),  
							   CONCAT(',"unitPrice": ', CONCAT('{"centAmount": ', cast(100 * (o.totalwithvat + IFNULL(co.totalwithvat, 0))/o.productamount as DECIMAL(10,2)), ', "currencyCode": "', o.currencycode, '"}')), 
							--   ',"taxCategory": ',  CONCAT('"', concat('vat', o.vatcode), '"'),
							   ',"productType": ', CONCAT('"', o.productTypeKey, '"'),						   
							   
							   ',"sku": ', CONCAT('"',  case o.productTypeKey 
															when 'greetingcard' then 
																concat('GRTZ', 
																		o.carddefinition, 
																		'-',
																		case 
																			when lower(o.PRODUCTCODE) like '%standard%' then 'STANDARD'
																			when lower(o.PRODUCTCODE) like '%square%large%' then 'STANDARD'
																			when lower(o.PRODUCTCODE) like '%xxl%' then 'LARGE'
																			when lower(o.PRODUCTCODE) like '%supersize%' then 'GIANT'
																			else 'STANDARD'
																		end,	
																		case when lower(o.PRODUCTCODE) like '%square%' then 'SQUARE' else '' end,
																		'CARD') 
															else o.sku_id 
														end, '"'),
							   
							   
							   ',"productSlug": ', CONCAT('"', case o.productTypeKey when 'greetingcard' then concat('GRTZ', o.carddefinition) else o.productKey end, '"'), 
							   ',"productKey": ', CONCAT('"', case o.productTypeKey when 'greetingcard' then concat('GRTZ', o.carddefinition) else o.productKey end, '"'), 
										'}'
									)
									
							ELSE
								'{}'
							END
									
									
							)
							, ']'), ',{}', ''),
		 							
		',"deliveryInformation": ', 	CONCAT('{',
										IFNULL(CONCAT('"deliveryMethodId": ', CONCAT('"', IFNULL(ct.id, 'NONE') , '"')), ''),
										IFNULL(CONCAT(',"deliveryMethodName": ', CONCAT('"', IFNULL(ct.type, 'Standard'), '"')), ''),
										IFNULL(CONCAT(',"trackingUrl": ', CONCAT('"', isp.TRACKANDTRACECODE, '"')), ''),
										',"fulfilmentCentre" : {"id" : "NL-GRTZ-AMS", "countryCode": "NL"}',
										'}'),
								   --		'deliveryType', dp.type,
		
		IFNULL(CONCAT(',"mobileNumber": ', CONCAT('"', case when a.ID IS NOT NULL then mct.mobile_phone else mcm.mobile_phone end, '"')), ''),  
		'}'				
		)
	AS orderDelivery,
	o.currentorderstate,
	
	sum(case when o.productcode != 'shipment_generic' then o.TOTALWITHVAT else 0 end) AS subTotalPrice,
	sum(case when o.productcode != 'shipment_generic' then o.TOTALWITHOUTVAT else 0 end) AS totalTaxExclusive,
	abs(sum(case when o.productcode != 'shipment_generic' then o.DISCOUNTWITHVAT else 0 end)) AS totalDiscount,
	sum(case when o.productcode != 'shipment_generic' then o.productamount else 0 end) AS totalItems,
	sum(case when o.productcode = 'shipment_generic' then o.WITHVAT + o.DISCOUNTWITHVAT else 0 end)  AS totalShippingPrice

FROM
   cte_previwImages o
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
  /* left join shoppingbasketprice sbp
	  on isp.INDIVIDUALSHIPPINGPRICEID = sbp.id
   left join vat v
		on sbp.vatId = v.id*/
   left join tmp_dm_mobileByContact mct
		on mct.contactid = r.contactid
   left join tmp_dm_mobileByCustomer mcm
		on mcm.customerid = o.customerid
   left join tmp_dm_envelope_names env
		on env.code = o.PRODUCTCODE
   left join cte_content co
		on co.id = o.id
		   and o.product_type = 'productCardSingle'
		   and o.PRODUCTITEMINBASKETID = co.PRODUCTITEMINBASKETID				
GROUP BY
		 o.customerId,
		 o.id,
		 o.individualshippingid
),

/*cte_Prices
AS
(
SELECT  o.id,
		o.id_str,
		sum(case when ol.productcode != 'shipment_generic' then ol.TOTALWITHVAT else 0 end) AS subTotalPrice,
		sum(case when ol.productcode != 'shipment_generic' then ol.TOTALWITHOUTVAT else 0 end) AS totalTaxExclusive,
		abs(sum(case when ol.productcode != 'shipment_generic' then ol.DISCOUNTWITHVAT else 0 end)) AS totalDiscount,
		sum(case when ol.productcode != 'shipment_generic' then ol.productamount else 0 end) AS totalItems,
		sum(case when ol.productcode = 'shipment_generic' then ol.WITHVAT + ol.DISCOUNTWITHVAT else 0 end)  AS totalShippingPrice
FROM
	(SELECT DISTINCT id, id_str FROM cte_Individualshipping) o 
	 JOIN orderline ol ON o.id = ol.orderid
GROUP BY o.id	 
),*/

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
   CONCAT('{"centAmount": 0, "currencyCode": "', i.currencycode, '"}') AS creditsUsed,
   SUM(i.totalItems) AS totalItems,
   
	concat('[',
	TRIM(LEADING ',' FROM CONCAT(
		group_concat(IFNULL(i.orderDelivery, ''))
	))
			, ']')
	AS deliveries,
	
   i.currentorderstate
		
FROM cte_Individualshipping i
	-- LEFT JOIN cte_Prices p ON i.id = p.id
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
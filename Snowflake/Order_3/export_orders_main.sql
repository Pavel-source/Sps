WITH cte_previwImages 
AS (
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
   IFNULL(pv.SKU, pv2.SKU)  AS productKey,
   IFNULL(pv.PRODUCT_KEY, pv2.PRODUCT_KEY)  AS productTypeKey,
   IFNULL(pv.SKU_VARIANT, pv2.SKU_VARIANT)  AS sku_id,
   IFNULL(p.PRODUCTCODE, p2.PRODUCTCODE)  AS PRODUCTCODE,
   IFNULL(p.type, p2.type)  AS product_type,   
   IFNULL(pv.PRODUCT_TITLE, pv2.PRODUCT_TITLE)  AS nl_product_name,   
   ol.id AS ol_id,
   ol.productamount,
   ol.totalwithvat,
   ol.TOTALWITHOUTVAT,
   ol.DISCOUNTWITHVAT,
   ol.WITHVAT,
   ol.individualshippingid,
   ol.PRODUCTITEMINBASKETID,
   c.carddefinition  

FROM
	--(SELECT * FROM orders /*WHERE id = 1337079006*/ ORDER BY id DESC LIMIT 10) o
	 (SELECT * FROM orders WHERE ordercode in ('1-WLJVKG6BMT', '1-RLVTHHZH3V', '1-UVMT5RNXK5')) o
 --   orders o
    JOIN orderline ol ON o.id = ol.orderid
    JOIN customerregistered cr ON o.customerid = cr.id
	LEFT JOIN productiteminbasket pb ON pb.ID = ol.PRODUCTITEMINBASKETID
	LEFT JOIN customercreatedcard c ON pb.CONTENTSELECTIONID = c.ID		
	LEFT JOIN "PROD"."WORKSPACE_GREETZ_HISTORY_MIGRATION"."PRODUCT_VARIANTS_DETAILED" AS pv
		ON pv.GREETZ_PRODUCT_ID = ol.productid 
			AND pv.GREETZ_CARDDEFINITION_ID = c.carddefinition 
	LEFT JOIN "PROD"."WORKSPACE_GREETZ_HISTORY_MIGRATION"."PRODUCT_VARIANTS_DETAILED" AS pv2
		ON pv2.GREETZ_PRODUCT_ID = ol.productid 
			AND pv2.GREETZ_CARDDEFINITION_ID = 0	
	LEFT JOIN product AS p ON pv.GREETZ_PRODUCT_ID = p.ID
	LEFT JOIN product AS p2 ON pv2.GREETZ_PRODUCT_ID = p2.ID
			
WHERE
	 o.channelid = 2
	AND cr.channelid = 2
	AND o.currentorderstate not in (
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
			'CANCELLED',
			'REPRINT'
			)
	AND o.CONTRAFORORDERID IS NULL
--	-- AND gpv.type != 'content'
--	-- AND gpv.type != 'content'
-- GROUP BY 
--		ol.id
),

-- -------------- content ------------------------------
cte_content_0
AS
(
SELECT ol.orderid, 
	 ol.PRODUCTITEMINBASKETID,
	 ol.productId,
	 AVG(ol.totalwithvat) AS totalwithvat,
	 AVG(ol.totalwithoutvat) AS totalwithoutvat,
	 AVG(ol.withvat) AS withvat,
	 AVG(ol.withoutvat) AS withoutvat
FROM "RAW_GREETZ"."GREETZ3".orders o
	JOIN "RAW_GREETZ"."GREETZ3".orderline ol ON o.id = ol.orderid
	JOIN "RAW_GREETZ"."GREETZ3".product pn ON pn.id = ol.productid
	LEFT JOIN "PROD"."WORKSPACE_GREETZ_HISTORY_MIGRATION"."TMP_DIFF_ESIV" t  ON ol.orderid = t.order_id
WHERE o.channelid = 2
	  /* AND o.currentorderstate IN
		  ('EXPIRED_AFTER_PRINTED',
		   'PAID_ADYEN',
		   'PAID_ADYEN_PENDING',
		   'PAID_AFTERPAY',
		   'PAID_BIBIT',
		   'PAID_CS',
		   'PAID_GREETZ_INVOICE',
		   'PAID_INVOICE',
		   'PAID_RABOBANK_IDEAL',
		   'PAID_SHAREWIRE',
		   'PAID_VOUCHER',
		   'PAID_WALLET',
		   'PAYMENT_FAILED_AFTER_PRINTING',
		   'REFUNDED_CANCELLEDCARD_VOUCHER',
		   'REFUNDED_CANCELLEDCARD_WALLET')  */
     AND pn.type = 'content'  
--	 AND ol.PRODUCTITEMINBASKETID IS NOT NULL
	 AND t.order_id IS NULL
GROUP BY ol.orderid, ol.PRODUCTITEMINBASKETID, ol.productId

UNION ALL

SELECT ol.orderid, 
	 ol.PRODUCTITEMINBASKETID,
	 ol.productId,
	 sum(ol.totalwithvat) AS totalwithvat,
	 sum(ol.totalwithoutvat) AS totalwithoutvat,
	 sum(ol.withvat) AS withvat,
	 sum(ol.withoutvat) AS withoutvat
FROM "PROD"."WORKSPACE_GREETZ_HISTORY_MIGRATION"."TMP_DIFF_ESIV" e
    JOIN "RAW_GREETZ"."GREETZ3".orders o ON e.order_id = o.id
	JOIN "RAW_GREETZ"."GREETZ3".orderline ol ON o.id = ol.orderid
	JOIN "RAW_GREETZ"."GREETZ3".product pn ON pn.id = ol.productid
	LEFT JOIN "PROD"."WORKSPACE_GREETZ_HISTORY_MIGRATION"."TMP_DIFF_ESIV_2" t  ON ol.orderid = t.order_id
WHERE pn.type = 'content'  
	  AND t.order_id IS NULL
GROUP BY ol.orderid, ol.PRODUCTITEMINBASKETID, ol.productId

UNION ALL

SELECT ol.orderid, 
	 ol.PRODUCTITEMINBASKETID,
	 ol.productId,
	 avg(ol.totalwithvat) * IFF(ol.PRODUCTITEMINBASKETID IN (1168224549, 1174617016, 1176217375, 1176218740), 1, 2)  AS totalwithvat,
	 avg(ol.totalwithoutvat) * IFF(ol.PRODUCTITEMINBASKETID IN (1168224549, 1174617016, 1176217375, 1176218740), 1, 2)  AS totalwithoutvat,
	 avg(ol.withvat) * IFF(ol.PRODUCTITEMINBASKETID IN (1168224549, 1174617016, 1176217375, 1176218740), 1, 2)  AS withvat,
	 avg(ol.withoutvat) * IFF(ol.PRODUCTITEMINBASKETID IN (1168224549, 1174617016, 1176217375, 1176218740), 1, 2)  AS withoutvat
FROM "PROD"."WORKSPACE_GREETZ_HISTORY_MIGRATION"."TMP_DIFF_ESIV_3" e
    JOIN "RAW_GREETZ"."GREETZ3".orders o ON e.order_id = o.id
	JOIN "RAW_GREETZ"."GREETZ3".orderline ol ON o.id = ol.orderid
	JOIN "RAW_GREETZ"."GREETZ3".product pn ON pn.id = ol.productid
WHERE pn.type = 'content'  
      AND pn.ChannelID = 2
GROUP BY ol.orderid, ol.PRODUCTITEMINBASKETID , ol.productId
), 
 
 cte_content AS
(
SELECT  orderid, 
		PRODUCTITEMINBASKETID, 
		sum(totalwithvat) AS totalwithvat,
		sum(totalwithoutvat) AS totalwithoutvat,
		sum(withvat) AS withvat,
		sum(withoutvat) AS withoutvat
FROM cte_content_0
GROUP BY orderid, 
		 PRODUCTITEMINBASKETID
),

cte_content_2
AS
(
SELECT ol.orderid, 
	 ol.PRODUCTITEMINBASKETID,
--	 ol.productId,
	 totalwithvat,
	 totalwithoutvat,
	 withvat,
	 withoutvat,
     ROW_NUMBER() OVER (PARTITION BY ol.orderid, ol.PRODUCTITEMINBASKETID ORDER BY ol.ID)  AS RN
FROM "PROD"."WORKSPACE_GREETZ_HISTORY_MIGRATION"."TMP_DIFF_ESIV_2" e
    JOIN "RAW_GREETZ"."GREETZ3".orders o ON e.order_id = o.id
	JOIN "RAW_GREETZ"."GREETZ3".orderline ol ON o.id = ol.orderid
	JOIN "RAW_GREETZ"."GREETZ3".product pn ON pn.id = ol.productid
	LEFT JOIN "PROD"."WORKSPACE_GREETZ_HISTORY_MIGRATION"."TMP_DIFF_ESIV_3" t  ON ol.orderid = t.order_id
WHERE pn.type = 'content'  
	  AND t.order_id IS NULL
), 

cte_content_2_Cards AS
(   

SELECT  ol.ID, 
		ROW_NUMBER() OVER(PARTITION BY ol.orderid, ol.PRODUCTITEMINBASKETID ORDER BY ol.ID) AS RN
FROM "PROD"."WORKSPACE_GREETZ_HISTORY_MIGRATION"."TMP_DIFF_ESIV_2" e
    JOIN "RAW_GREETZ"."GREETZ3".orders o ON e.order_id = o.id
	JOIN "RAW_GREETZ"."GREETZ3".orderline ol ON o.id = ol.orderid
	JOIN "RAW_GREETZ"."GREETZ3".product pn ON pn.id = ol.productid 
WHERE pn.type = 'productCardSingle'  OR  pn.productcode LIKE 'card%'  
),
-- --------------------------------------------------------

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
				 when o.currentorderstate = 'REFUNDED_CANCELLEDCARD_VOUCHER' then 'CANCELLED'
                 when isp.CANCELLATIONTYPE IS NOT NULL then 'CANCELLED'
				 when sds.currentState = 'DELETED' then 'CANCELLED'
				 when sds.currentState in ('AVAILABLE_AT_PICKUP_POINT', 'NOT_AT_HOME', 'UITLEVERING', 'DELIVERED', 'DELIVEREDBB', 'READY_TO_POST') then 'SENT'
				 when sds.currentState = 'NEW' AND shipmentnotificationdate IS NOT NULL then 'SENT'
				 when o.created < '2022-09-01' /*CURRENT_DATE() - INTERVAL 3 MONTH*/  AND (sds.currentState = 'UNKNOWN' OR sds.currentState IS NULL) then 'SENT'
				 else 'RECEIVED'
			end
		, '"')), ''), 
		
		IFNULL(CONCAT(',"firstName": ', '"', replace(replace(r.firstname, '\r\n', ' '),'\n', ' '), '"'), ''),
		IFNULL(CONCAT(',"lastName": ', '"', replace(replace(r.lastname, '\r\n', ' '),'\n', ' '), '"'), ''),
		IFNULL(CONCAT(',"deliveryType": ', CONCAT('"', 'POSTAL', '"')), ''),

		',"address": ', 	IFNULL(CONCAT('{',
												CONCAT('"id": ', '"', CONCAT('fake-', UUID_STRING()), '"'),
												IFNULL(CONCAT(',"firstName": ', '"', replace(replace(r.firstname, '\r\n', ' '),'\n', ' '), '"'), ''),
												IFNULL(CONCAT(',"lastName": ', '"', replace(replace(r.lastname, '\r\n', ' '),'\n', ' '), '"'), ''),
											--	',"title": null',
											--	',"addressFirstLine": null',
                                                IFNULL(CONCAT(',"houseNumber": ', '"', replace(replace(case when a.ID IS NOT NULL then a.streetnumber else a2.streetnumber end, '\r\n', ' '),'\n', ' '), '"'), ''),
												IFNULL(CONCAT(',"houseNumberExtension": ', '"', replace(replace(case when a.ID IS NOT NULL then a.streetnumberextension else a2.streetnumberextension end, '\r\n', ' '),'\n', ' '), '"'), ''),
												IFNULL(CONCAT(',"extraAddressLine": ', '"', replace(replace(
												                                        case when a.ID IS NOT NULL then
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
																						end, '\r\n', ' '),'\n', ' '), '"'
															 )
													, ''),

												IFNULL(CONCAT(',"streetName": ', '"', replace(replace(case when a.ID IS NOT NULL then a.street else a2.street end, '\r\n', ' '),'\n', ' '), '"'), ''),
                                                IFNULL(CONCAT(',"city": ', '"', replace(replace(case when a.ID IS NOT NULL then a.city else a2.city end, '\r\n', ' '),'\n', ' '), '"'), ''),
												IFNULL(CONCAT(',"state": ', '"', replace(replace(case when a.ID IS NOT NULL then a.STATEPROVINCECOUNTY else a2.STATEPROVINCECOUNTY end, '\r\n', ' '),'\n', ' '), '"'), ''),
                                                IFNULL(CONCAT(',"postcode": ', '"', replace(replace(case when a.ID IS NOT NULL then a.zippostalcode else a2.zippostalcode end, '\r\n', ' '),'\n', ' '), '"'), ''),
												IFNULL(CONCAT(',"country": ', CONCAT('"', case when a.ID IS NOT NULL then c.ENGLISHCOUNTRYNAME else c2.ENGLISHCOUNTRYNAME end, '"')), ''),
												IFNULL(CONCAT(',"emailAddress": ', CONCAT('"', cea.email, '"')), ''),
												IFNULL(CONCAT(',"isMyAddress": ', case when a2.ID IS NOT NULL then 'true' else 'false' end), ''),
												CONCAT(',"isScrubbed": ', case when (a.ID IS NOT NULL AND a.street = 'SCRUBBED') OR (a.ID IS NULL AND a2.street = 'SCRUBBED') then 'true' else 'false' end),
												
												'}'), 'null'),
			

-- "recipientAddress" is the same as "address"
		',"recipientAddress": ', 	IFNULL(CONCAT('{',
												CONCAT('"id": ', '"', CONCAT('fake-', UUID_STRING()), '"'),
												IFNULL(CONCAT(',"firstName": ', '"', replace(replace(r.firstname, '\r\n', ' '),'\n', ' '), '"'), ''),
												IFNULL(CONCAT(',"lastName": ', '"', replace(replace(r.lastname, '\r\n', ' '),'\n', ' '), '"'), ''),
											--	',"title": null', 	
											--	',"addressFirstLine": null', 	
												IFNULL(CONCAT(',"houseNumber": ', '"', replace(replace(case when a.ID IS NOT NULL then a.streetnumber else a2.streetnumber end, '\r\n', ' '),'\n', ' '), '"'), ''),
												IFNULL(CONCAT(',"houseNumberExtension": ', '"', replace(replace(case when a.ID IS NOT NULL then a.streetnumberextension else a2.streetnumberextension end, '\r\n', ' '),'\n', ' '), '"'), ''),
												IFNULL(CONCAT(',"extraAddressLine": ', '"', replace(replace(
												                                        case when a.ID IS NOT NULL then
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
																						end, '\r\n', ' '),'\n', ' '), '"'
															 )
													, ''),												
												
												IFNULL(CONCAT(',"streetName": ', '"', replace(replace(case when a.ID IS NOT NULL then a.street else a2.street end, '\r\n', ' '),'\n', ' '), '"'), ''),
												IFNULL(CONCAT(',"city": ', '"', replace(replace(case when a.ID IS NOT NULL then a.city else a2.city end, '\r\n', ' '),'\n', ' '), '"'), ''),
												IFNULL(CONCAT(',"state": ', '"', replace(replace(case when a.ID IS NOT NULL then a.STATEPROVINCECOUNTY else a2.STATEPROVINCECOUNTY end, '\r\n', ' '),'\n', ' '), '"'), ''),
												IFNULL(CONCAT(',"postcode": ', '"', replace(replace(case when a.ID IS NOT NULL then a.zippostalcode else a2.zippostalcode end, '\r\n', ' '),'\n', ' '), '"'), ''),
												IFNULL(CONCAT(',"country": ', CONCAT('"', case when a.ID IS NOT NULL then c.ENGLISHCOUNTRYNAME else c2.ENGLISHCOUNTRYNAME end, '"')), ''),   
												IFNULL(CONCAT(',"emailAddress": ', CONCAT('"', cea.email, '"')), ''),
												IFNULL(CONCAT(',"isMyAddress": ', case when a.ID IS NOT NULL then 'false' when a2.ID IS NOT NULL then 'true' end), ''),
												CONCAT(',"isScrubbed": ', case when (a.ID IS NOT NULL AND a.street = 'SCRUBBED') OR (a.ID IS NULL AND a2.street = 'SCRUBBED') then 'true' else 'false' end),
												'}'), 'null'),

		IFNULL(CONCAT(',"deliveryDate": ', CONCAT('"', cast(cast(IFNULL(sds.deliveredTime, dateadd(day, 1, dp.pickupDate) /*INTERVAL 1 day*/) AS DATE) AS VARCHAR(50)), '"')), ''), 
		IFNULL(CONCAT(',"actualDispatchDate": ', CONCAT('"', cast(cast(dp.pickupDate AS DATE) AS VARCHAR(50)), '"')), ''),  
		IFNULL(CONCAT(',"estimatedDispatchDate": ', CONCAT('"', cast(cast(
																	IFNULL(dp.deliveryDate, case when MAX(productcode) like 'wallet%' then dateadd(day, 1, o.created) end) 
																AS DATE) AS VARCHAR(50)), '"')), ''),
		
		',"orderItems": ',	replace(replace(concat('[',
						LISTAGG(
						
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
                            --   ',"previewImages": []',
							--    ',"s3ImagePrefixes": ', IFNULL(s3ImagePrefixes, s3ImagePrefixes_2), 
							--	   '"lineItemId": ', o.ORDERLINEIDX,
							    IFNULL(CONCAT(',"title": ', CONCAT('"', case 
																		when o.productTypeKey = 'greetingcard' then 'Kaart' 
																		when env.code IS NOT NULL then env.name
																		else replace(replace(o.nl_product_name, '"', '\\"'), '	', ' ')
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
																		IFNULL(o.carddefinition, 0), 
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
							, ','	
									
							)
							, ']'), '{},', ''), ',{}', ''),
		 							
		',"deliveryInformation": ', 	CONCAT('{',
										IFNULL(CONCAT('"deliveryMethodId": ', CONCAT('"', IFNULL(cast(ct.id as varchar(50)), 'NONE') , '"')), ''),
										IFNULL(CONCAT(',"deliveryMethodName": ', CONCAT('"', IFNULL(
																					case ct.carrier 
																					when 'TNT' then 'PostNL'
																					when 'PACKS' then 'Packs'
																					when 'BLANK' then 'Bpost'
																					else ct.carrier 
																					end, 
																				'Standard'), '"')), ''),
										IFNULL(CONCAT(',"trackingNumber": ', CONCAT('"', case when dp.hastrackandtrace = 'Y' AND o.created > dateadd(year, -2, to_date('20220901')) /*- INTERVAL 2 YEAR*/ then sai.barcode end, '"')), ''),
										IFNULL(CONCAT(',"trackingUrl": ', CONCAT('"', case when dp.hastrackandtrace = 'Y' AND o.created > dateadd(year, -2, to_date('20220901')) /*INTERVAL 2 YEAR*/ then isp.TRACKANDTRACECODE end, '"')), ''),
										IFNULL(CONCAT(',"fullTrackingUrl": ', CONCAT('"', case when dp.hastrackandtrace = 'Y' AND o.created > dateadd(year, -2, to_date('20220901')) /*INTERVAL 2 YEAR*/ then isp.TRACKANDTRACECODE end, '"')), ''),
										',"fulfilmentCentre" : {"id" : "NL-GRTZ-AMS", "countryCode": "NL"}',
										'}'),
								   --		'deliveryType', dp.type,
		
		IFNULL(CONCAT(',"mobileNumber": ', CONCAT('"', case when a.ID IS NOT NULL then mct.mobile_phone else mcm.mobile_phone end, '"')), ''),  
		'}'				
		)
	AS orderDelivery,
	o.currentorderstate,
	
	sum(case when o.product_type != 'shipment' then o.TOTALWITHVAT else 0 end) AS subTotalPrice,
	sum(case when o.product_type != 'shipment' then o.TOTALWITHOUTVAT else 0 end) AS totalTaxExclusive,
	abs(sum(case when o.product_type != 'shipment' then o.DISCOUNTWITHVAT else 0 end)) AS totalDiscount,
	sum(case when o.product_type NOT IN (
										'content',
										'shipment',
										'outerCarton',
										'sound',
										'packetToSelfSurcharge',
										'trimoption'
										) 
			 then o.productamount else 0 
		end) AS totalItems,
	sum(case when o.product_type = 'shipment' then o.WITHVAT + o.DISCOUNTWITHVAT else 0 end)  AS totalShippingPrice

FROM
   cte_previwImages o
   LEFT JOIN individualshipping isp
       ON o.individualshippingid = isp.id
   LEFT JOIN shipmentdeliverystatus sds
	   ON isp.id = sds.individualshippingid
   LEFT JOIN shipmentinformation si
	   ON isp.SHIPMENTINFORMATIONID = si.id
   LEFT JOIN deliverypromise dp
	   ON si.deliverypromise_id = dp.id
   LEFT JOIN recipient r
       ON isp.recipientid = r.id
   LEFT JOIN address a
       ON r.addressid = a.id
   LEFT JOIN country c
       ON a.countrycode = c.TWOLETTERCOUNTRYCODE
   LEFT JOIN contactemailaddress cea
	   ON r.contactid = cea.contactid
		  AND cea.emailidx = 0
   LEFT JOIN paazlshipmentinformation psi
	   ON si.id = psi.id
   LEFT JOIN carriertype ct
       ON psi.type = ct.type AND psi.carrier = ct.carrier
   LEFT JOIN address a2
      ON o.customerid = a2.customerid AND a2.DEFAULTADDRESS = 'Y'
   LEFT JOIN country c2
       ON a2.countrycode = c2.TWOLETTERCOUNTRYCODE
   LEFT JOIN channel ch
	  ON o.channelid = ch.id
  /* LEFT JOIN shoppingbasketprice sbp
	  ON isp.INDIVIDUALSHIPPINGPRICEID = sbp.id
   LEFT JOIN vat v
		ON sbp.vatId = v.id*/
   LEFT JOIN "tmp_dm_mobileByContact" mct
		ON mct.contactid = r.contactid
   LEFT JOIN "tmp_dm_mobileByCustomer" mcm
		ON mcm.customerid = o.customerid
   LEFT JOIN "tmp_dm_envelope_names" env
		ON env.code = o.PRODUCTCODE
  /* LEFT JOIN cte_content co
		ON co.id = o.id
		   AND o.product_type = 'productCardSingle'
		   AND o.PRODUCTITEMINBASKETID = co.PRODUCTITEMINBASKETID	*/
	LEFT JOIN cte_content co
		ON co.orderid = o.id
		   AND (o.product_type = 'productCardSingle'  OR  o.productcode LIKE 'card%')
		   AND IFNULL(o.PRODUCTITEMINBASKETID, 0) = IFNULL(co.PRODUCTITEMINBASKETID, 0)
    LEFT JOIN cte_content_2_Cards AS cc
        ON cc.ID = o.ol_ID
    LEFT JOIN cte_content_2 AS co2
        ON co2.orderid = o.id
            AND IFNULL(co2.PRODUCTITEMINBASKETID, 0) = IFNULL(o.PRODUCTITEMINBASKETID, 0)
            AND co2.RN = cc.RN					
   LEFT JOIN shipmentadditionalinformation sai
		ON sai.individualshippingid = isp.id
GROUP BY
		 o.customerId,
		 o.id,
		 o.individualshippingid,
		 
		o.ORDERCODE,
		o.Created,
		o.ORDERCODE, 
		o.customerid,
		o.email,
		o.GRANDTOTALFORPAYMENT,
		o.currencycode,
        O.CURRENTORDERSTATE,
        ISP.CANCELLATIONTYPE,
        ISP.TRACKANDTRACECODE,
        SDS.CURRENTSTATE,
        SDS.SHIPMENTNOTIFICATIONDATE,
        R.FIRSTNAME,
        R.LASTNAME,
        A.ID,
        A2.ID,
        A.STREETNUMBER,
        A2.STREETNUMBER,
        A.STREETNUMBEREXTENSION,
        A2.STREETNUMBEREXTENSION,
        A.EXTRAADDRESSLINE1,
        A.EXTRAADDRESSLINE2,
        A.EXTRAADDRESSLINE3,
        A2.EXTRAADDRESSLINE1,
        A2.EXTRAADDRESSLINE2,
        A2.EXTRAADDRESSLINE3,
        A.STREET,
        A2.STREET,
        A.CITY,
        A2.CITY,
        A.STATEPROVINCECOUNTY,
        A2.STATEPROVINCECOUNTY,
        A.ZIPPOSTALCODE,
        A2.ZIPPOSTALCODE,
        C.ENGLISHCOUNTRYNAME,
        C2.ENGLISHCOUNTRYNAME,
        CEA.EMAIL,
        SDS.DELIVEREDTIME,
        DP.PICKUPDATE,
        DP.DELIVERYDATE,
        DP.HASTRACKANDTRACE,
        CT.ID,
        CT.CARRIER,
        SAI.BARCODE,
        MCT.MOBILE_PHONE,
        MCM.MOBILE_PHONE
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
	LTRIM(LISTAGG(IFNULL(i.orderDelivery, ''), ','), ',')
			, ']')
	AS deliveries,
	
   i.currentorderstate
		
FROM cte_Individualshipping i
	-- LEFT JOIN cte_Prices p ON i.id = p.id
GROUP BY
		 i.customerId,
		 i.id,
		 
	i.id_str,
	i.createdAt,
	i.orderReference, 
	i.customerId,
	i.customerEmail,
	i.currencycode,
	i.GRANDTOTALFORPAYMENT,
	i.currentorderstate
   
)

SELECT
	   customerId AS entity_key,
			CONCAT('[',
				
				LISTAGG(
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
										 
										), ',')
								,']')

		AS orders
FROM cte_order
GROUP BY customerId
-- LIMIT :limit
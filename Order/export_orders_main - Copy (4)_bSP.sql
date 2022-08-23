WITH /*MasterVariant_productStandardGift_0 AS
(
	SELECT pge.productGroupId, pge.productStandardGift,
			 ROW_NUMBER() OVER(PARTITION BY pge.productGroupId ORDER BY pge.showonstore DESC, pge.productStandardGift ASC) AS RN
	FROM productgroupentry pge
			JOIN product p ON p.ID = pge.productStandardGift
	WHERE pge.productStandardGift IS NOT NULL
		   AND p.channelid = '2'
		   AND p.removed IS NULL
		   AND p.endoflife != 'Y'

),
MasterVariant_productStandardGift AS
(
SELECT * FROM MasterVariant_productStandardGift_0 WHERE RN = 1
),*/

gift_product_variants AS
(
   SELECT
	  p.ID AS product_id,
      concat('GRTZ', case when z.designProductId IS NULL then cast(p.ID AS varchar(50)) else concat('D', cast(z.designProductId AS varchar(50))) end)
	  AS productKey,
	  IFNULL(cif_nl_title.text, replace(p.INTERNALNAME, '_', ' ')) AS nl_product_name,
   --   cif_en_title.text AS en_product_name,
   
	  case 
		  when pt.MPTypeCode like '%personalised%' OR z.designProductId IS NOT NULL 
			   then concat('GRTZD', cast(z.designProductId AS varchar(50)), '-STANDARD')
		  else p.PRODUCTCODE 
	  end AS sku_id,
						  
      concat('GRTZ', case when z.designProductId IS NULL then cast(p.ID AS varchar(50)) else concat('D', cast(z.designProductId AS varchar(50))) end)
	  AS variant_key,
   --   true                          AS ismastervariant,
	  IFNULL(pt.MPTypeCode, case p.type when 'productCardSingle' then 'greetingcard' else p.type end) AS productTypeKey,
	  z.designId
	  
   FROM
	  product p
      LEFT JOIN productgift pg
			ON pg.productid = p.id
	  LEFT JOIN (SELECT contentinformationid, text, db_updated
				 FROM contentinformationfield
				 WHERE type = 'TITLE'
					   AND locale = 'nl_NL') cif_nl_title
            ON cif_nl_title.contentinformationid = p.contentinformationid
	 /* LEFT JOIN (SELECT contentinformationid, text, db_updated
				 FROM contentinformationfield
				 WHERE type = 'TITLE'
                       AND locale = 'en_EN') cif_en_title
            ON cif_en_title.contentinformationid = p.contentinformationid*/
	  LEFT JOIN greetz_to_mnpg_product_types_view pt
              ON pt.GreetzTypeID = IFNULL(pg.productgiftcategoryid, pg.productgifttypeid)
	  LEFT JOIN 
			(
			 SELECT cd.ID AS designId, ppd.id AS designProductId, ppd.product
			  -- , cd.contentinformationid AS design_contentinformationid, cif_nl_title.TEXT AS nl_product_name_2
			 FROM productpersonalizedgiftdesign ppd 				
				 JOIN carddefinition cd 
						ON cd.ID = ppd.GIFTDEFINITION
						--	AND cd.ENABLED = 'Y'
						--	AND cd.APPROVALSTATUS = 'APPROVED'
						--	AND cd.CONTENTTYPE = 'STOCK'
				/* LEFT JOIN contentinformationfield cif_nl_title
					ON cif_nl_title.contentinformationid = cd.contentinformationid
						AND cif_nl_title.type = 'TITLE' AND cif_nl_title.locale = 'nl_NL'*/
			) z
				ON z.product = p.ID	
   WHERE
      p.channelid = '2'
	  and p.type not in (
			'content',
			'shipment',
			'outerCarton',
			'sound',
			'packetToSelfSurcharge',
			'trimoption')
  --    AND p.removed IS NULL
  --    AND p.endoflife != 'Y'
  --    AND productgiftcategoryid IS NOT NULL
      AND pg.productid NOT IN (1142811940, 1142813663, 1142813653, 1142813658, 1142811934, 1142811937, 1142811979, 1142811982, 1142811913, 1142811916) 
	  
   UNION ALL
   SELECT
		pge.productstandardgift AS product_id,
		concat('GRTZG', cast(ppg.ID AS varchar(50)))   AS productKey,
		ppg.title AS nl_product_name,
	--	null      AS en_product_name,		
		p.PRODUCTCODE AS sku_id,
		concat('GRTZ',  cast(p.ID AS varchar(50))) AS variant_key,
	--	CASE WHEN mv.productStandardGift IS NOT NULL THEN 1 ELSE 0 END AS ismastervariant,
		pt.MPTypeCode AS productTypeKey,
		NULL as	designId
	FROM
		productgift pg
		join product p on pg.productid = p.id
		join productgroupentry pge on pge.productstandardgift = pg.productid
		join productgroup ppg ON pge.productGroupId = ppg.id
	--	left join MasterVariant_productStandardGift mv
	--	   on pge.productstandardgift = mv.productstandardgift
		left join greetz_to_mnpg_product_types_view pt
           on pt.GreetzTypeID = IFNULL(pg.productgiftcategoryid, pg.productgifttypeid)
	WHERE
		p.channelid = '2'
	--	and p.removed is null
	--	and p.endoflife != 'Y'
	--	and pg.productgiftcategoryid is not null
		and pge.productstandardgift IN (1142811940, 1142813663, 1142813653, 1142813658, 1142811934, 1142811937, 1142811979, 1142811982, 1142811913, 1142811916) 
),

cte_mobileByContact as (
    select contactid,
           max(number_) mobile_phone
    from phonenumber pn
	where type = 'MOBILE_PHONE' AND number_ IS NOT NULL  AND number_ != ''
    group by contactid
),

cte_mobileByCustomer as (
    select customerid,
           max(number_) mobile_phone
    from phonenumber pn
	where type = 'MOBILE_PHONE' AND number_ IS NOT NULL  AND number_ != ''
    group by customerid
),

cte_previwImages0 as (
SELECT
   o.id,
   o.currentorderstate,
   o.Created,
   o.ORDERCODE, 
   o.customerid,
   o.currencycode,
   o.channelid,
   cr.email,
 /*  gpv.productKey,
   gpv.productTypeKey,
   gpv.sku_id,
   pn.nl_product_name,*/
   ol.id as  ol_id,
   ol.productamount,
   ol.totalwithvat,
   ol.individualshippingid,
   ol.PRODUCTITEMINBASKETID,
   ol.productID
 --  c.carddefinition,
 --  o.billingaddress,
/*	CASE
        WHEN prd.`TYPE` NOT IN ('gift_addon', 'cardpackaging') THEN 
		   concat('[', 
				 group_concat(
				   concat('{', 
									'"url": ', IFNULL(concat(case when c.carddefinition IS NULL then '"/images/static/' else '"/images/custom/' end, cct.BASEPREVIEWFILENAME, '"'), 'null'),
						  '}')
				  ) 
		   , ']')
	ELSE
		'[{"url": null}]'
	END  as previwImages*/
   
FROM
   (SELECT * FROM orders WHERE id = 1337079006 ORDER BY id DESC LIMIT 1000) o
 --   orders o
    JOIN orderline ol ON o.id = ol.orderid
    JOIN customerregistered cr ON o.customerid = cr.id
/*	LEFT JOIN productiteminbasket p ON p.ID = ol.PRODUCTITEMINBASKETID
	LEFT JOIN customercreatedcard c on p.CONTENTSELECTIONID = c.ID
    LEFT JOIN product prd on ol.productID = prd.id -- AND prd.`TYPE` NOT IN ('content', 'shipment') -- exists in WHERE
	LEFT JOIN customercreatedcardtemplate cct  ON c.ID = cct.CUSTOMERCREATEDCARD
	LEFT JOIN cardtemplate ct on ct.ID = cct.CARDSIDETEMPLATE
    LEFT JOIN gift_product_variants gpv 
		ON gpv.designId = c.carddefinition 
		   OR (gpv.product_id = ol.productid AND c.carddefinition  IS NULL)
	LEFT JOIN (SELECT DISTINCT product_id, nl_product_name FROM gift_product_variants) pn
		ON pn.product_id = ol.productid*/
	
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
/*	and gpv.type not in (
			'content',
			'shipment',
			'outerCarton',
			'sound',
			'packetToSelfSurcharge',
			'trimoption')*/
	and concat(:keys) IS NULL
   )
   or o.customerid in (:keys)

/*GROUP BY

		 ol.id*/
),

cte_previwImages as (
SELECT
   ol.id,
   ol.currentorderstate,
   ol.Created,
   ol.ORDERCODE, 
   ol.customerid,
   ol.currencycode,
   ol.channelid,
   ol.email,
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
									'"url": ', IFNULL(concat(case when c.carddefinition IS NULL then '"/images/static/' else '"/images/custom/' end, cct.BASEPREVIEWFILENAME, '"'), 'null'),
						  '}')
				  ) 
		   , ']')
	ELSE
		'[{"url": null}]'
	END  as S3ImagePrefix
   
FROM
   /*(SELECT * FROM orders WHERE id = 1337079006 ORDER BY id DESC LIMIT 1000) o
 --   orders o
    JOIN orderline ol ON o.id = ol.orderid
    JOIN customerregistered cr ON o.customerid = cr.id*/
    cte_previwImages0 ol
	LEFT JOIN productiteminbasket p ON p.ID = ol.PRODUCTITEMINBASKETID
	LEFT JOIN customercreatedcard c on p.CONTENTSELECTIONID = c.ID
    LEFT JOIN product prd on ol.productID = prd.id -- AND prd.`TYPE` NOT IN ('content', 'shipment') -- exists in WHERE
	LEFT JOIN customercreatedcardtemplate cct  ON c.ID = cct.CUSTOMERCREATEDCARD
	LEFT JOIN cardtemplate ct on ct.ID = cct.CARDSIDETEMPLATE
    LEFT JOIN gift_product_variants gpv 
		ON gpv.designId = c.carddefinition 
		   OR (gpv.product_id = ol.productid AND c.carddefinition  IS NULL)
	LEFT JOIN (SELECT DISTINCT product_id, nl_product_name FROM gift_product_variants) pn
		ON pn.product_id = ol.productid
	
WHERE
	c.carddefinition IS NOT NULL  
	OR gpv.product_id IS NOT NULL

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
							   ',"skuId": ', CONCAT('"', case o.productTypeKey when 'greetingcard' then concat('GRTZ', o.carddefinition) else o.sku_id end, '"'), 
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
   join gift_product_variants gpv
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
   left join cte_mobileByContact mct
		on mct.contactid = r.contactid
   left join cte_mobileByCustomer mcm
		on mcm.customerid = o.customerid

GROUP BY
		 o.customerId,
		 o.id,
		 o.individualshippingid
),

/*
cte_Individualshipping AS
(
SELECT
   o.id,
   concat('LEGO-', o.ORDERCODE) AS id_str,
   o.Created AS createdAt,
   o.ORDERCODE AS orderReference, 
   o.customerid AS customerId,
   cr.email AS customerEmail,
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
							   '"id": ', ol.id,
							   ',"previewImages": null', 
							--	   '"lineItemId": ', ol.ORDERLINEIDX,
							    IFNULL(CONCAT(',"title": ', CONCAT('"', gpv.nl_product_name, '"')), ''),  
							--    IFNULL(CONCAT(',"titleEn": ', CONCAT('"', gpv.en_product_name, '"')), ''), 
							   ',"quantity": ', ol.productamount,
							   CONCAT(',"totalPrice": ', CONCAT('{"centAmount": ', cast(100 * ol.totalwithvat AS INT), ', "currencyCode": "', o.currencycode, '"}')),  
							   CONCAT(',"unitPrice": ', CONCAT('{"centAmount": ', cast(100 * ol.totalwithvat/ol.productamount as DECIMAL(10,2)), ', "currencyCode": "', o.currencycode, '"}')), 
							--   ',"taxCategory": ',  CONCAT('"', concat('vat', ol.vatcode), '"'),
							   ',"productType": ', CONCAT('"', gpv.productTypeKey, '"'),
							   ',"skuId": ', CONCAT('"', gpv.sku_id, '"'), 
							   ',"productSlug": ', CONCAT('"', gpv.productKey, '"'),
							   ',"productKey": ', CONCAT('"', gpv.productKey, '"'),
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
  -- (SELECT * FROM orders ORDER BY id DESC LIMIT 1000) o
   orders o
   join orderline ol
      on o.id = ol.orderid
   join customerregistered cr
      on o.customerid = cr.id
   join gift_product_variants gpv
      on gpv.product_id = ol.productid
   left join orderbillingaddress oba
      on oba.id = o.billingaddress
   left join individualshipping isp
       on ol.individualshippingid = isp.id
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
      on cr.id = a2.customerid and a2.DEFAULTADDRESS = 'Y'
   left join country c2
       on a2.countrycode = c2.TWOLETTERCOUNTRYCODE
   left join channel ch
	  on o.channelid = ch.id
   left join shoppingbasketprice sbp
	  on isp.INDIVIDUALSHIPPINGPRICEID = sbp.id
   left join vat v
		on sbp.vatId = v.id
   left join cte_mobileByContact mct
		on mct.contactid = r.contactid
   left join cte_mobileByCustomer mcm
		on mcm.customerid = cr.id

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
	and gpv.type not in (
			'content',
			'shipment',
			'outerCarton',
			'sound',
			'packetToSelfSurcharge',
			'trimoption')
	and concat(:keys) IS NULL
   )
   or o.customerid in (:keys)
GROUP BY
		 o.customerId,
		 o.id,
		 ol.individualshippingid
),*/

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
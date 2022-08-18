-- ########################################################################################
-- # Query return all the orders made by registered customers, not registered customers and
-- # registered customers with individual shipping address. It filter out those that
-- # have not been fulfilled and marked AS either 'CANCELLED' or 'PAYMENT_FAILED'
-- #
-- # TODO:
-- # Orders should be imported at the end once all of the products are handled (gifts + cards). For now, this query
-- # is limited only to the gifts!
-- #
-- # Questions:
-- #
-- # 1) Order billing address vs shipping address?
-- # 2) Some customers are not registered? What about them? Because if some customer order something and did not register then we do not have neither email, contact address etc.
-- # 3) What about order that were not ordered by registered customers? - okay, checked. we can export order without email assigned. Perhaps we should separately import such orders?
-- #
-- # Other:
-- #
-- # Email uniqueness
-- # In commercetools, customers are identified by their email address. Email addresses must be unique. You can create customers globally for the project or create them in specific stores.
-- # Keep two things in mind about email uniqueness: case insensitivity and global versus store-specific customer accounts.
-- ########################################################################################

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
      p.PRODUCTCODE AS sku_id,
     -- 1                             AS variant_key,
      concat('GRTZ', case when z.designProductId IS NULL then cast(p.ID AS varchar(50)) else concat('D', cast(z.designProductId AS varchar(50))) end)
	  AS variant_key,
   --   true                          AS ismastervariant,
	  pt.MPTypeCode AS productTypeKey
   FROM
      productgift pg
	  JOIN product p
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
			 SELECT cd.ID AS designId, ppd.id AS designProductId, ppd.product, cd.contentinformationid AS design_contentinformationid,
					cif_nl_title.TEXT AS nl_product_name_2
			 FROM productpersonalizedgiftdesign ppd 				
				 JOIN carddefinition cd 
						ON cd.ID = ppd.GIFTDEFINITION
							AND cd.ENABLED = 'Y'
							AND cd.APPROVALSTATUS = 'APPROVED'
							AND cd.CONTENTTYPE = 'STOCK'
				 LEFT JOIN contentinformationfield cif_nl_title
					ON cif_nl_title.contentinformationid = cd.contentinformationid
						AND cif_nl_title.type = 'TITLE' AND cif_nl_title.locale = 'nl_NL'
			) z
				ON z.product = p.ID	
   WHERE
      p.channelid = '2'
  --    AND p.removed IS NULL
  --    AND p.endoflife != 'Y'
  --    AND productgiftcategoryid IS NOT NULL
      AND pg.productid NOT IN (1142811913, 1142811979, 1142811934, 1142813653, 1142811940) 
   UNION ALL
   SELECT
		pge.productstandardgift AS product_id,
		concat('GRTZG', cast(ppg.ID AS varchar(50)))   AS productKey,
		ppg.title AS nl_product_name,
	--	null      AS en_product_name,
		p.PRODUCTCODE AS sku_id,
		concat('GRTZ',  cast(p.ID AS varchar(50))) AS variant_key,
	--	CASE WHEN mv.productStandardGift IS NOT NULL THEN 1 ELSE 0 END AS ismastervariant,
		pt.MPTypeCode AS productTypeKey
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
		and pge.productstandardgift IN (1142811913, 1142811979, 1142811934, 1142813653, 1142811940) 
),

cte_mobileByContact as (
    select contactid,
           max(number_) mobile_phone
    from phonenumber pn
	where type = 'MOBILE_PHONE'
    group by contactid
),

cte_mobileByCustomer as (
    select customerid,
           max(number_) mobile_phone
    from phonenumber pn
	where type = 'MOBILE_PHONE'
    group by customerid
),

cte_Individualshipping AS
(
SELECT
   o.ORDERCODE AS id,
   o.Created AS createdAt,
   '0' AS orderReference, 
   o.customerid AS customerId,
   cr.email AS customerEmail,
   o.currencycode,
   CONCAT('{"centAmount": ', cast(o.grandtotalforpayment * 100 AS INT), ', "currencyCode": "', o.currencycode, '"}') AS totalPrice,
   CONCAT('{"centAmount": ', cast((sbp.priceWithVat + sbp.discountWithVat) * 100 AS INT), ', "currencyCode": "', o.currencycode, '"}') AS totalShippingPrice,
   
	CONCAT('{',
		'"id": ', CONCAT('"delivery_', o.ORDERCODE, '"'),
		IFNULL(CONCAT(',"status": ', CONCAT('"', sds.currentState, '"')), ''), 
		IFNULL(CONCAT(',"firstName": ', CONCAT('"', r.firstname, '"')), ''), 
		IFNULL(CONCAT(',"lastName": ', CONCAT('"', r.lastname, '"')), ''), 
		IFNULL(CONCAT(',"deliveryType": ', CONCAT('"', /*dp.type*/ 'DeliveryType.STANDARD', '"')), ''), 
		
		',"address": ', 	IFNULL(CONCAT('{',
												CONCAT('"id": ', '"', CONCAT('fake-', UUID()), '"'),
												IFNULL(CONCAT(',"firstName": ', CONCAT('"', r.firstname, '"')), ''), 
												IFNULL(CONCAT(',"lastName": ', CONCAT('"', r.lastname, '"')), ''), 	
												',"title": null', 	
												',"addressFirstLine": null', 	
												IFNULL(CONCAT(',"houseNumber": ', CONCAT('"', case when a.ID IS NOT NULL then a.streetnumber else a2.streetnumber end, '"')), ''), 
												IFNULL(CONCAT(',"houseNumberExtension": ', CONCAT('"', case when a.ID IS NOT NULL then a.streetnumberextension else a2.streetnumberextension end, '"')), ''), 
												IFNULL(CONCAT(',"extraAddressLine": ', case when a.ID IS NOT NULL then 
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
																						end
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
												IFNULL(CONCAT(',"extraAddressLine": ', case when a.ID IS NOT NULL then 
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
																						end
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
	--	IFNULL(CONCAT(',"promisedDeliveredDate": ', CONCAT('"', cast(cast(dp.deliveryDate AS DATE) AS VARCHAR(50)), '"')), ''), 
		
		',"orderItems": ',	concat('[',
						group_concat(
							CONCAT('{',
							   '"id": ', ol.id,
							   ',"previewImages": null', 
							--	   '"lineItemId": ', ol.ORDERLINEIDX,
							    IFNULL(CONCAT(',"title": ', CONCAT('"', gpv.nl_product_name, '"')), ''),  
							--    IFNULL(CONCAT(',"titleEn": ', CONCAT('"', gpv.en_product_name, '"')), ''), 
							   ',"quantity": ', ol.productamount,
							   ',"totalPrice": ', ol.totalwithvat,
							   ',"unitPrice": ', cast(ol.totalwithvat/ol.productamount as DECIMAL(10,2)),
							--   ',"taxCategory": ',  CONCAT('"', concat('vat', ol.vatcode), '"'),
							   ',"productType": ', CONCAT('"', gpv.productTypeKey, '"'),
							   ',"skuId": ', CONCAT('"', gpv.sku_id, '"'), 
							   ',"productSlug": ', CONCAT('"', gpv.productKey, '"'),
							   ',"productKey": ', CONCAT('"', gpv.productKey, '"'),
										'}')
									)
							, ']'),
		 							
		',"deliveryInformation": ', 	CONCAT('{',
										IFNULL(CONCAT('"deliveryMethodName": ', CONCAT('"', 'Standard', '"')), ''), 
										IFNULL(CONCAT(',"trackingUrl": ', CONCAT('"', isp.TRACKANDTRACECODE, '"')), ''),
										IFNULL(CONCAT(',"deliveryMethodId": ', CONCAT('"', ct.id, '"')), 'NONE'),
										IFNULL(CONCAT(',"deliveryMethodName": ', CONCAT('"', ct.type, '"')), ''),
										',"fulfilmentCentre" : {"id" : "2", "countryCode": "NL"}',
										'}'),
								   --		'deliveryType', dp.type,
		
		IFNULL(CONCAT(',"mobileNumber": ', CONCAT('"', case when a.ID IS NOT NULL then mct.mobile_phone else mcm.mobile_phone end, '"')), ''),  
		'}'				
		)
	AS orderDelivery

FROM
  -- (SELECT * FROM orders ORDER BY id DESC LIMIT 1000) o
   orders o
   join orderline ol
      on o.id = ol.orderid
   join customerregistered cr
      on o.customerid = cr.id
   join gift_product_variants gpv
      on gpv.product_id = ol.productid -- only gift type products. TODO: get back to this. Orders should be exported in the end. First cards should be added to Product.
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
	and o.currentorderstate not in ('CANCELLED', 'PAYMENT_FAILED')
	and concat(:keys) IS NULL
   )
   or o.customerid in (:keys)
GROUP BY
		 customerId,
		 o.id,
		 ol.individualshippingid
LIMIT :limit
),

cte_Prices
AS
(
SELECT  o.id,
		sum(WITHVAT) AS totalItemPrice,
		sum(WITHOUTVAT) AS totalTaxExclusive,
		sum(WITHVAT) AS totalPriceGross,
		abs(sum(DISCOUNTWITHVAT)) AS totalDiscount,
		sum(ol.productamount) AS totalItems
FROM
	(SELECT DISTINCT id FROM cte_Individualshipping) o 
	 JOIN orderline ol ON o.id = ol.orderid
GROUP BY o.id	 
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
   CONCAT('{"centAmount": ', cast(i.totalPrice * 100 AS INT), ', "currencyCode": "', i.currencycode, '"}') AS totalPrice,
   CONCAT('{"centAmount": ', cast(p.totalItemPrice * 100 AS INT), ', "currencyCode": "', i.currencycode, '"}') AS totalItemPrice,
   CONCAT('{"centAmount": ', cast(i.totalShippingPrice * 100 AS INT), ', "currencyCode": "', i.currencycode, '"}') AS totalShippingPrice,
   CONCAT('{"centAmount": ', cast(p.totalTaxExclusive * 100 AS INT), ', "currencyCode": "', i.currencycode, '"}') AS totalTaxExclusive,
   CONCAT('{"centAmount": ', cast(p.totalPriceGross * 100 AS INT), ', "currencyCode": "', i.currencycode, '"}') AS totalPriceGross,
   CONCAT('{"centAmount": ', cast(p.totalDiscount * 100 AS INT), ', "currencyCode": "', i.currencycode, '"}') AS totalDiscount,
   p.totalItems,
   
	concat('[',
	TRIM(LEADING ',' FROM CONCAT(
		group_concat(IFNULL(i.orderDelivery, ''))
	))
			, ']')
	AS orderDeliveries
		
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
										 '"id": "', id, '"',
										 ',"version": 0', 
										 ',"createdAt": ', '"', createdAt, '"',
										 ',"orderReference": ', '"', orderReference, '"',
										 ',"customerId": ', customerId,
										  IFNULL(CONCAT(',"customerEmail": ', CONCAT('"', customerEmail, '"')), ''),
										  ',"store": "NL"', 
										  IFNULL(CONCAT(',"totalPrice": ', totalPrice), ''),
										  IFNULL(CONCAT(',"totalItemPrice": ', totalItemPrice), ''),
										  IFNULL(CONCAT(',"totalShippingPrice": ', totalShippingPrice), ''),
										  IFNULL(CONCAT(',"totalTaxExclusive": ', totalTaxExclusive), ''),
										  IFNULL(CONCAT(',"totalPriceGross": ', totalPriceGross), ''),
										  IFNULL(CONCAT(',"totalDiscount": ', totalDiscount), ''),
										  IFNULL(CONCAT(',"totalItems": ', totalItems), ''),
										  ',"creditsUsed": 0', 
										  
										--  IFNULL(CONCAT(',"orderState": ', CONCAT('"', orderState, '"')), ''),
										--  IFNULL(CONCAT(',"paymentState": ', CONCAT('"', paymentState, '"')), ''),										 										 
										 ',"orderDeliveries": ', orderDeliveries,
										  ',"dataSource": "S3"', 
										 '}'
										 
										))
								,']')

		AS orders
FROM cte_order
GROUP BY customerId
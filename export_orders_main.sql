-- ########################################################################################
-- # Query return all the orders made by registered customers, not registered customers and
-- # registered customers with individual shipping address. It filter out those that
-- # have not been fulfilled and marked as either 'CANCELLED' or 'PAYMENT_FAILED'
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

WITH MasterVariant_productStandardGift_0 AS
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
),

gift_product_variants AS
(
   SELECT
	  p.ID as product_id,
      lower(replace(replace(replace(replace(replace(replace(replace(replace(case p.channelid when 2 then p.PRODUCTCODE else concat(p.PRODUCTCODE, '_', CAST(p.channelid AS VARCHAR(10))) end, ' - ' , '_'), ' ' , '_'), '&' , 'and'), '+' , 'plus'), '?' , ''), '''' , ''), '(' , ''), ')' , '')) AS productKey,
	  IFNULL(cif_nl_title.text, replace(p.INTERNALNAME, '_', ' ')) as nl_product_name,
      cif_en_title.text as en_product_name,
      concat(p.id, '-', 'STANDARD') as sku_id,
     -- 1                             as variant_key,
	  concat(p.id, '-', 'STANDARD') as variant_key,
      true                          as ismastervariant,
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
	  LEFT JOIN (SELECT contentinformationid, text, db_updated
				 FROM contentinformationfield
				 WHERE type = 'TITLE'
                       AND locale = 'en_EN') cif_en_title
            ON cif_en_title.contentinformationid = p.contentinformationid
	  LEFT JOIN greetz_to_mnpg_product_types_view pt
              ON pt.GreetzTypeID = case when pg.productgiftcategoryid is not null then pg.productgiftcategoryid
										else pg.productgifttypeid
								   end
   WHERE
      p.channelid = '2'
      AND p.removed IS NULL
      AND p.endoflife != 'Y'
      AND productgiftcategoryid IS NOT NULL
      AND pg.productid NOT IN
							(SELECT productstandardgift
							 FROM productgroupentry
							 WHERE productstandardgift IS NOT NULL)
   UNION ALL
   SELECT
		pge.productstandardgift as product_id,
		lower(replace(replace(replace(replace(replace(replace(replace(replace(case p.channelid when 2 then ppg.productGroupCode else concat(ppg.productGroupCode, '_', CAST(p.channelid AS VARCHAR(10))) end, ' - ' , '_'), ' ' , '_'), '&' , 'and'), '+' , 'plus'), '?' , ''), '''' , ''), '(' , ''), ')' , '')) AS productKey,
		ppg.title as nl_product_name,
		null      as en_product_name,
		concat(pge.productgroupid, '_', p.id) as sku_id,
		concat(pge.productgroupid, '_', p.id) as variant_key,
		CASE WHEN mv.productStandardGift IS NOT NULL THEN 1 ELSE 0 END as ismastervariant,
		pt.MPTypeCode AS productTypeKey
	FROM
		productgift pg
		join product p on pg.productid = p.id
		join productgroupentry pge on pge.productstandardgift = pg.productid
		join productgroup ppg ON pge.productGroupId = ppg.id
		left join MasterVariant_productStandardGift mv
		   on pge.productstandardgift = mv.productstandardgift
		left join greetz_to_mnpg_product_types_view pt
           on pt.GreetzTypeID = case when pg.productgiftcategoryid is not null then pg.productgiftcategoryid
									 else pg.productgifttypeid
								end
	WHERE
		p.channelid = '2'
		and p.removed is null
		and p.endoflife != 'Y'
		and pg.productgiftcategoryid is not null
		and pge.productstandardgift is not null
),

GroupedByCustomerAndOrder as
(
SELECT
   o.id as orderId,
   o.customerid as customerId,
   o.Created as createdAt,
   o.updatedOn as completedAt,
   cr.email as customerEmail,
   o.currentorderstate as orderState,
   o.ordercoststate as paymentState,
   
  	JSON_OBJECT( 
	   'centAmount', cast(o.grandtotalforpayment * 100 AS INT),    -- the smallest indivisible unit of the currency
	   'currencyCode', o.currencycode)		
	AS totalPrice,

	JSON_OBJECT(
	   'centAmount', (select sum(cast(WITHVAT * 100 AS INT)) from orderline where orderid = o.id),
	   'currencyCode', o.currencycode)
	AS PriceWithVat,

	JSON_OBJECT(
	   'centAmount', (select sum(cast(WITHOUTVAT * 100 AS INT)) from orderline where orderid = o.id),
	   'currencyCode', o.currencycode)
	AS PriceWithOutVat,

	JSON_OBJECT(
	   'centAmount', (select abs(sum(cast(DISCOUNTWITHVAT * 100 AS INT))) from orderline where orderid = o.id),
	   'currencyCode', o.currencycode)
	AS DiscountWithVat,

	JSON_OBJECT(
	   'centAmount', (select sum(cast(DISCOUNTWITHOUTVAT * 100 AS INT)) from orderline where orderid = o.id),
	   'currencyCode', o.currencycode)
	AS DiscountWithOutVat,

	JSON_OBJECT( 	   
	   'firstName', oba.firstname, 
	   'lastName', oba.lastname, 
	   'companyName', oba.companyname, 
	   'street', oba.street, 
	   'houseNumber', oba.housenumber, 
	   'city', oba.city, 
	   'zipCode', oba.zipcode, 
	   'state', oba.state,
	   'country', oba.country,
	   'emailAddress', oba.emailaddress,
	   'mobileNumber', oba.mobilenumber,
	   'faxNumber', oba.faxnumber,
	   'telephoneNumber', oba.telephonenumber,
	   'gender', oba.gender)
	AS billingAddress,

	JSON_OBJECT(
	   'zipPostalCode', IFNULL(a.zippostalcode, a2.zippostalcode),
	   'countryCode', IFNULL(a.countrycode, a2.countrycode),
	   'state', IFNULL(a.STATEPROVINCECOUNTY, a2.STATEPROVINCECOUNTY),
	   'street', IFNULL(a.street, a2.street),
	   'city', IFNULL(a.city, a2.city),
	   'streetNumber', IFNULL(a.streetnumber, a2.streetnumber),
	   'firstName', r.firstname,
	   'lastName', r.lastname,
	   'phone', r.phonenumber,
	   'email', cea.email)
	AS shippingAddress,

	JSON_OBJECT(
		'shipmentState', sds.currentState,
		'deliveredDate', cast(sds.deliveredTime AS DATE),
		'promisedDeliveredDate', cast(dp.deliveryDate AS DATE),
		'despatchDate', cast(dp.pickupDate AS DATE),
		'deliveryType', dp.type,
		'carrierType', JSON_OBJECT('type', ct.type, 'name', ct.name, 'carrier', ct.carrier),
		'taxCategory', concat('vat', v.vatcode),
		'price', JSON_OBJECT('centAmount', cast((sbp.priceWithVat + sbp.discountWithVat) * 100 AS INT), 'currencyCode', sbp.currency))
	AS shippingInfo,

	JSON_OBJECT(
		'distributionChannelId', o.channelId,
		'distributionChannelName', ch.name)
	AS distributionChannel,

    concat('[',
		group_concat(
			JSON_OBJECT(
			   'lineItemId', ol.ORDERLINEIDX,
			   'productKey', gpv.productKey,
			   'productNameEn', gpv.en_product_name,
			   'productNameNl', gpv.nl_product_name,
			   'skuId', gpv.sku_id,
			   'price', JSON_OBJECT('centAmount', cast(ol.totalwithvat * 100 AS INT), 'currencyCode', ol.currencycode),
			   'quantity', ol.productamount,
			   'taxCategory', concat('vat', ol.vatcode),
			   'productTypeKey', gpv.productTypeKey
						)
					)
			, ']')
	AS lineItems

FROM
   orders o
   join orderline ol
      on o.id = ol.orderid
   join customerregistered cr
      on o.customerid = cr.id
   join gift_product_variants gpv
      on gpv.product_id = ol.productid -- only gift type products. TODO: get back to this. Orders should be exported in the end. First cards should be added to Product.
   left join orderbillingaddress oba
      on oba.id = o.billingaddress
   join individualshipping isp
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
   left join contactemailaddress cea
	   on r.contactid = cea.contactid
		  and cea.emailidx = 0
   left join paazlshipmentinformation psi
	   on si.id = psi.id
   left join carriertype ct
       on psi.type = ct.type and psi.carrier = ct.carrier
   left join address a2
      on cr.id = a2.customerid and a2.DEFAULTADDRESS = 'Y'
   left join channel ch
	  on o.channelid = ch.id
   left join shoppingbasketprice sbp
	  on isp.INDIVIDUALSHIPPINGPRICEID = sbp.id
   left join vat v
		on sbp.vatId = v.id

WHERE
   (
    o.customerid > :migrateFromId and o.customerid <= :migrateToId
	and cr.REGISTRATIONDATE > '2020-01-01 00:00:00'						 -- last 2 years
	and o.channelid = 2
	and o.currentorderstate not in ('CANCELLED', 'PAYMENT_FAILED')
	and concat(:keys) IS NULL
   )
   or o.customerid in (:keys)
GROUP BY
		 customerId,
		 o.id
LIMIT :limit
)

SELECT
	   customerId AS entity_key,
	   replace(replace(replace(replace(replace(replace(
			concat('[',
				group_concat(
				--	JSON_INSERT(
							JSON_OBJECT(
										 'orderId', orderId,
										 'orderNumber', orderId,
										 'customerId', customerId,
										 'createdAt', createdAt,
										 'completedAt', completedAt,
										 'customerEmail', customerEmail,
										 'orderState', orderState,
										 'paymentState', paymentState,
										 'totalPrice', totalPrice,
										 'priceWithVat', PriceWithVat,
										 'priceWithOutVat', PriceWithOutVat,
										 'discountWithVat', DiscountWithVat,
										 'discountWithOutVat', DiscountWithOutVat,
										 'billingAddress', billingAddress,
										 'shippingAddress', shippingAddress,
										 'distributionChannel', distributionChannel,
										 'shippingInfo', shippingInfo,
										 'lineItems', lineItems
										)
				--			,
				--			'$.lineItems',
				--			lineItems
				--				)
							)
				, ']')
		, '"[', '['), ']"', ']'), '\\"', '"'), '"{', '{'), '}"', '}'), '\\\\', '\\')
		AS orders
FROM GroupedByCustomerAndOrder
GROUP BY customerId
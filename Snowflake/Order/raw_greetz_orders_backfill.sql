SELECT 
	o.ID AS ORDER_ID,
	CAST(o.CREATED AS DATE) AS ORDER_DATE,
	o.CREATED AS ORDER_DATE_TIME,
	HOUR(o.CREATED) AS ORDER_HOUR_ONLY,
	MINUTE(o.CREATED) AS ORDER_MINUTE_ONLY,
	o.CUSTOMERID AS CUSTOMER_ID,
	'NL' AS ORDER_COUNTRY_CODE	,
	'Netherlands' AS ORDER_COUNTRY	,
	'NL' AS ORDER_STORE	,
	NULL AS	PLATFORM	,										-- to do later
	concat('LEGO-', o.ORDERCODE) AS	ORDER_NUMBER	,
	IFF(o.currentorderstate = 'CANCELLED', 'Cancelled', 'Confirmed')  AS ORDER_STATE	,
	sum(IFF(ol.packettoselfid IS NULL, 1, 0))  AS not_toself_count	,
	sum(IFF(ol.packettoselfid IS NOT NULL, 1, 0))  AS toself_count	,
	
	sum(IFF(r.addressid IS NULL, 1, 0))  AS null_addresses_count	,
	sum(IFF(a2.customerid IS NOT NULL, 1, 0))  AS customer_addresses_count	, --  1 is max
	
	IFF(
		COUNT(DISTINCT r.addressid) - IFF(null_addresses_count > 0, 1, 0) = 0,
		IFF(customer_addresses_count > 0, 1, 0)
	    )	AS NUMBER_OF_ADDRESSES	,
		
	case 
		when not_toself_count > 0 AND toself_count = 0 then 'DIRECT'
		when not_toself_count = 0 AND toself_count > 0 then 'CUSTOMER'
		when not_toself_count > 0 AND toself_count > 0 then 'SPLIT'
	end 	AS ORDER_ADDRESS_TYPE	,
	
	IFF(NUMBER_OF_ADDRESSES = 1, True, False)  AS SINGLE_ADDRESS_FLAG	,
	'LineItemLevel' AS ORDER_TAX_CALCULATION	,
	True AS ORDER_TRANSACTION_FEE	,
	COUNT(*) ITEMS_IN_ORDER	,						-- ?
	o.currencycode AS ORDER_CURRENCYCODE	,
	ex.avg_rate AS TO_GBP_RATE,
	ex_2.avg_rate AS MNTH_GBP_TO_EUR_RATE,
	abs(sum(IFF(gpv.productcode != 'shipment_generic', ol.DISCOUNTWITHOUTVAT, 0)))  AS PRODUCT_DISCOUNT_EX_TAX	,
	abs(sum(IFF(gpv.productcode != 'shipment_generic', ol.DISCOUNTWITHVAT - ol.DISCOUNTWITHOUTVAT, 0)))  AS PRODUCT_DISCOUNT_TAX	,
	abs(sum(IFF(gpv.productcode != 'shipment_generic', ol.DISCOUNTWITHVAT, 0)))  AS PRODUCT_DISCOUNT_INC_TAX	,
	abs(sum(IFF(gpv.productcode = 'shipment_generic', ol.DISCOUNTWITHOUTVAT, 0)))  AS POSTAGE_DISCOUNT_EX_TAX	,
	abs(sum(IFF(gpv.productcode = 'shipment_generic', ol.DISCOUNTWITHVAT - ol.DISCOUNTWITHOUTVAT, 0)))  AS POSTAGE_DISCOUNT_TAX	,
	abs(sum(IFF(gpv.productcode = 'shipment_generic', ol.DISCOUNTWITHVAT, 0)))  AS POSTAGE_DISCOUNT_INC_TAX	,
	
	abs(sum(IFF(gpv.productcode != 'shipment_generic', ex.avg_rate * ol.DISCOUNTWITHOUTVAT, 0)))  AS PRODUCT_DISCOUNT_EX_TAX_GBP	,
	abs(sum(IFF(gpv.productcode != 'shipment_generic', ex.avg_rate * (ol.DISCOUNTWITHVAT - ol.DISCOUNTWITHOUTVAT), 0)))  AS PRODUCT_DISCOUNT_TAX_GBP	,
	abs(sum(IFF(gpv.productcode != 'shipment_generic', ex.avg_rate * ol.DISCOUNTWITHVAT, 0)))  AS PRODUCT_DISCOUNT_INC_TAX_GBP	,
	abs(sum(IFF(gpv.productcode = 'shipment_generic', ex.avg_rate * ol.DISCOUNTWITHOUTVAT, 0)))  AS POSTAGE_DISCOUNT_EX_TAX_GBP	,
	abs(sum(IFF(gpv.productcode = 'shipment_generic', ex.avg_rate * (ol.DISCOUNTWITHVAT - ol.DISCOUNTWITHOUTVAT), 0)))  AS POSTAGE_DISCOUNT_TAX_GBP	,
	abs(sum(IFF(gpv.productcode = 'shipment_generic', ex.avg_rate * ol.DISCOUNTWITHVAT, 0)))  AS POSTAGE_DISCOUNT_INC_TAX_GBP	,
	NULL AS	PRODUCT_UNIT_PRICE	,					-- to do later
	
	sum(IFF(gpv.productcode != 'shipment_generic', ol.TOTALWITHOUTVAT, 0)) AS ORDER_ESEV	,
	sum(IFF(o.productcode = 'shipment_generic', o.WITHVAT + o.DISCOUNTWITHVAT, 0))  AS POSTAGE_UNIT_PRICE	, 		-- ?
	abs(sum(IFF(gpv.productcode = 'shipment_generic', ol.TOTALWITHOUTVAT, 0)))  AS POSTAGE_EX_TAX	,
	-- PRODUCT_LINE_TAX = PRODUCT_TOTAL_TAX + PRODUCT_DISCOUNT_TAX
	sum(IFF(gpv.productcode != 'shipment_generic', ol.TOTALWITHOUTVAT - ol.TOTALWITHVAT + abs(ol.DISCOUNTWITHVAT - ol.DISCOUNTWITHOUTVAT), 0))  AS PRODUCT_LINE_TAX	,
	sum(IFF(gpv.productcode != 'shipment_generic', ol.TOTALWITHVAT - ol.TOTALWITHOUTVAT, 0)) AS PRODUCT_TOTAL_TAX	,
	sum(IFF(gpv.productcode != 'shipment_generic', ol.TOTALWITHVAT, 0)) AS ORDER_ESIV	,
	-- POSTAGE_LINE_TAX = POSTAGE_TOTAL_TAX + POSTAGE_DISCOUNT_TAX
	sum(IFF(gpv.productcode = 'shipment_generic', ol.TOTALWITHVAT - ol.TOTALWITHOUTVAT + abs(ol.DISCOUNTWITHVAT - ol.DISCOUNTWITHOUTVAT), 0)) AS POSTAGE_LINE_TAX	,
	sum(IFF(gpv.productcode = 'shipment_generic', ol.TOTALWITHVAT - ol.TOTALWITHOUTVAT, 0)) AS POSTAGE_TOTAL_TAX	,
	-- POSTAGE_SUBTOTAL = POSTAGE_EX_TAX + POSTAGE_TOTAL_TAX
	sum(IFF(gpv.productcode = 'shipment_generic', /*ol.TOTALWITHOUTVAT +*/ ol.TOTALWITHVAT /*- ol.TOTALWITHOUTVAT*/, 0)) AS POSTAGE_SUBTOTAL	,
	sum(ol.TOTALWITHOUTVAT) AS ORDER_ISEV	,
	abs(sum(IFF(gpv.productcode != 'shipment_generic', ol.DISCOUNTWITHVAT, 0))) AS TOTAL_DISCOUNT	,
	sum(ol.TOTALWITHVAT - ol.TOTALWITHOUTVAT) AS TOTAL_TAX	,
	sum(ol.TOTALWITHVAT) AS ORDER_ISIV	,
	sum(ol.TOTALWITHVAT) ORDER_CASH_PAID	,
--	PRODUCT_UNIT_PRICE_GBP	,
	sum(IFF(gpv.productcode != 'shipment_generic', ex.avg_rate * ol.TOTALWITHOUTVAT, 0))  AS ORDER_ESEV_GBP	,
--	POSTAGE_UNIT_PRICE_GBP	,
	abs(sum(IFF(gpv.productcode = 'shipment_generic', ex.avg_rate * ol.TOTALWITHOUTVAT, 0)))  AS POSTAGE_EX_TAX_GBP	,
	sum(IFF(gpv.productcode != 'shipment_generic', ex.avg_rate * (ol.TOTALWITHOUTVAT - ol.TOTALWITHVAT + abs(ol.DISCOUNTWITHVAT - ol.DISCOUNTWITHOUTVAT)), 0))  AS PRODUCT_LINE_TAX_GBP	,
	sum(IFF(gpv.productcode != 'shipment_generic', ex.avg_rate * (ol.TOTALWITHVAT - ol.TOTALWITHOUTVAT), 0))  AS PRODUCT_TOTAL_TAX_GBP	,
	sum(IFF(gpv.productcode != 'shipment_generic', ex.avg_rate * ol.TOTALWITHVAT, 0))  AS ORDER_ESIV_GBP	,
	sum(IFF(gpv.productcode = 'shipment_generic', ex.avg_rate * (ol.TOTALWITHVAT - ol.TOTALWITHOUTVAT + abs(ol.DISCOUNTWITHVAT - ol.DISCOUNTWITHOUTVAT)), 0))  AS POSTAGE_LINE_TAX_GBP	,
	sum(IFF(gpv.productcode = 'shipment_generic', ex.avg_rate * (ol.TOTALWITHVAT - ol.TOTALWITHOUTVAT), 0))  AS POSTAGE_TOTAL_TAX_GBP	,
	sum(IFF(gpv.productcode = 'shipment_generic', ex.avg_rate * ( /*ol.TOTALWITHOUTVAT +*/ ol.TOTALWITHVAT /*- ol.TOTALWITHOUTVAT*/), 0)) AS POSTAGE_SUBTOTAL_GBP	,
	sum(ex.avg_rate * ol.TOTALWITHOUTVAT)  AS ORDER_ISEV_GBP	,
	abs(sum(IFF(gpv.productcode != 'shipment_generic', ex.avg_rate * ol.DISCOUNTWITHVAT, 0)))  AS TOTAL_DISCOUNT_GBP	,
	sum(ex.avg_rate * (ol.TOTALWITHVAT - ol.TOTALWITHOUTVAT))  AS TOTAL_TAX_GBP	,
	sum(ex.avg_rate * ol.TOTALWITHVAT)  AS ORDER_ISIV_GBP	,
	sum(ex.avg_rate * ol.TOTALWITHVAT) AS ORDER_CASH_PAID_GBP	,
	sum(IFF(oce.subcell != 'SHIPMENT', ORDER_ESEV - oce.purchasecost - oce.externalcontentcost - oce.othermaterialcost - oce.directlaborcost - oce.packagingcost, 0)) AS GROSS_PRODUCT_MARGIN	,
	sum(IFF(oce.subcell = 'SHIPMENT', POSTAGE_EX_TAX - oce.purchasecost - oce.externalcontentcost - oce.othermaterialcost - oce.directlaborcost - oce.packagingcost, 0)) AS GROSS_SHIPPING_MARGIN	,
	sum(ORDER_ISEV - oce.purchasecost - oce.externalcontentcost - oce.othermaterialcost - oce.directlaborcost - oce.packagingcost) AS TOTAL_GROSS_MARGIN	,	
	sum(IFF(oce.subcell != 'SHIPMENT', ORDER_ESEV - oce.purchasecost, 0)) AS COMMERCIAL_PRODUCT_MARGIN	,
	GROSS_SHIPPING_MARGIN  AS COMMERCIAL_SHIPPING_MARGIN,	
	sum(ORDER_ISEV - oce.purchasecost)  AS TOTAL_COMMERCIAL_MARGIN	,
	
	ORDER_ISEV  AS TOTAL_SALES	,
	ORDER_ESEV  AS PRODUCT_SALES	,
	POSTAGE_EX_TAX  AS SHIPPING_SALES	,
	0  AS CUSTOMER_SERVICE	,
	0  AS CUSTOMER_SERVICE_GBP	,
	ORDER_ISIV  AS EVE_ORDER_TOTAL_AMOUNT	,
	ORDER_ISIV  AS EVE_ORDER_TOTAL_GROSS	,
	ORDER_ISIV  AS EVE_ORDER_TOTAL_NET	,
	POSTAGE_SUBTOTAL  AS EVE_TOTAL_POSTAGE	,
	ORDER_ESEV  AS EVE_TOTAL_LINE_ITEM	,
	
	-- total cardgiftback fee (incl tax)
	-- DIFF_TOTAL_GROSS	,							??
		
	-- DIFF_PRODUCT_SUBTOTAL	,					??
	0  AS DIFF_POSTAGE_SUBTOTAL	,
	
	SUM(IFF(p.TYPE = 'productCardSingle', 1, 0))  AS cards,
	SUM(IFF(p.TYPE IN ('standardGift', 'personalizedGift') AND gpv.productTypeKey != 'flower', 1, 0))  AS gifts,
	SUM(IFF(gpv.productTypeKey = 'flower', 1, 0))  AS flowers,
	SUM(IFF(p.TYPE = 'productCardSingle', ol.productamount, 0))  AS cards_total_amount,
	
	IFF(cards > 0, True, False)  AS IS_CARD_ORDER	,
	IFF(gifts > 0, True, False)  AS IS_GIFT_ORDER	,
	IFF(flowers > 0, True, False)  AS IS_FLOWER_ORDER	,
	
	SUM(IFF(IS_CARD_ORDER = True 
		AND 
		(
		 lower(gpv.productcode) like '%xl%' 
		 OR lower(gpv.productcode)  like '%large%' 
		 OR lower(gpv.productcode)  like '%supersize%'
		 )
	   , ol.productamount, 0)) AS sum_IS_CARD_UPSELL_ORDER	,
	
	IFF(sum_IS_CARD_UPSELL_ORDER > 0, True, False)  AS IS_CARD_UPSELL_ORDER,
	
	IFF(IS_FLOWER_ORDER = True 
	   AND 
	   (
	    lower(gpv.productcode) like '%large%' 
	    OR lower(gpv.productcode) like '%groot%'
	   )
	, ol.productamount, 0) AS sum_IS_FLOWER_UPSELL_ORDER	,
	
	IFF(sum_IS_FLOWER_UPSELL_ORDER > 0, True, False)  AS IS_FLOWER_UPSELL_ORDER,
	
	IFF(IS_CARD_UPSELL_ORDER = True OR IS_FLOWER_UPSELL_ORDER = True, True, False)  AS IS_UPSELL_ORDER	,
	False  AS IS_ECARD_ORDER	,
	IFF(cards > 0 AND flowers > 0, True, False)  AS IS_CARD_FLOWER_ORDER	,
	IFF(IS_CARD_ORDER = True AND (IS_FLOWER_ORDER = True OR IS_GIFT_ORDER = True), True, False) AS IS_ATTACH_ORDER	,
	IFF(gifts > 0 OR flowers > 0, True, False)  AS IS_GIFT_OR_FLOWER_ORDER	,
	IFF(cards > 0 AND gifts > 0, True, False)  AS IS_GIFT_ATTACH_ORDER	,
	IFF(cards > 0 AND flowers > 0, True, False)  AS IS_FLOWER_ATTACH_ORDER	,
	IFF(IS_CARD_ORDER = True AND IS_FLOWER_UPSELL_ORDER = True, True, False)  AS IS_LARGE_FLOWER_ATTACH_ORDER	,
	
	IFF(cards > 0 AND gifts = 0 AND flowers = 0, True, False)  AS IS_CARD_ONLY_ORDER	,
	IFF(cards = 0 AND gifts = 0 AND flowers > 0, True, False)  AS IS_FLOWER_ONLY_ORDER	,
	IFF(cards = 0 AND gifts > 0 AND flowers = 0, True, False)  AS IS_GIFT_ONLY_ORDER	,
	
	-- TRUE of order has IS_GIFT_ORDER = TRUE and IS_FLOWER_ORDER = TRUE (and not IS_CARD_ORDER)		??
	IFF(cards = 0 AND (gifts > 0 OR flowers > 0), True, False)  AS IS_FLOWER_OR_GIFT_ONLY_ORDER	,
	
	IFF(cards = 0 AND (gifts > 0 OR flowers > 0), True, False)  AS IS_NON_CARD_ORDER	,
	
	 
	IFF(cards_total_amount > 1, True, False)  AS IS_MULTI_CARD_ORDER	,
	 
	False  AS IS_XSELL_ORDER	,
	False  AS IS_FLOWER_XSELL_ORDER	,
	False  AS IS_GIFT_XSELL_ORDER	,
	IFF(TOTAL_DISCOUNT > 0, True, False)  AS IS_DISCOUNTED_ORDER	,
	IFF(TOTAL_DISCOUNT > 0 AND cards > 0, True, False)  AS IS_CARD_DISCOUNTED_ORDER	,
	IFF(TOTAL_DISCOUNT > 0 AND gifts > 0, True, False)  AS IS_GIFT_DISCOUNTED_ORDER	,
	IFF(TOTAL_DISCOUNT > 0 AND flowers > 0, True, False)  AS IS_FLOWER_DISCOUNTED_ORDER	,
	IFF(TOTAL_DISCOUNT > 0 AND IS_NON_CARD_ORDER = True, True, False)  AS IS_NON_CARD_DISCOUNTED_ORDER	,
	sum(IFF(cd.CONTENTTYPE IN ('PHOTO_TEMPLATE','PHOTO_SELF') OR gpv.productKey LIKE 'GRTZD%', 1, 0))  AS sum_IS_PHOTO_UPLOAD_ORDER	,
	IFF(sum_IS_PHOTO_UPLOAD_ORDER > 0, True, False)  AS IS_PHOTO_UPLOAD_ORDER	,
	IFF(IS_PHOTO_UPLOAD_ORDER = True, False, True)  AS IS_LOW_EFFORT_ORDER	,
	IS_PHOTO_UPLOAD_ORDER  AS IS_HIGH_EFFORT_ORDER	,
	sum(IFF(cd.CONTENTTYPE IN ('PHOTO_TEMPLATE','PHOTO_SELF'), 1, 0))  AS sum_IS_PHOTO_UPLOAD_ORDER_card_only	,
	IFF(sum_IS_PHOTO_UPLOAD_ORDER_card_only > 0, False, True)  AS IS_LOW_EFFORT_CARD_ORDER	,
	IFF(sum_IS_PHOTO_UPLOAD_ORDER_card_only > 0, True, False)  AS IS_HIGH_EFFORT_CARD_ORDER	,
	
	IFF(toself_count > 0 AND not_toself_count = 0, True, False)  AS IS_CUSTOMER_ADDRESS_TYPE_ORDER_ONLY	,
	IFF(toself_count = 0 AND not_toself_count > 0, True, False)  AS IS_DIRECT_ADDRESS_TYPE_ORDER_ONLY	,
	IS_EMAIL_ADDRESS_TYPE_ORDER_ONLY	,
	IFF(gifts > 0, True, False)  AS IS_SPLIT_ADDRESS_TYPE_ORDER	,
	False  AS IS_SPLIT_EMAIL_ADDRESS_TYPE_ORDER	,
	cards_total_amount AS CARD_QUANTITY	,
	SUM(IFF(p.TYPE IN ('standardGift', 'personalizedGift'), ol.productamount, 0))  AS GIFT_QUANTITY,
	SUM(IFF(gpv.productTypeKey = 'flower', ol.productamount, 0))  AS FLOWER_QUANTITY,
	CARD_QUANTITY + FLOWER_QUANTITY  AS CARD_FLOWER_QUANTITY	,
	
	CASE
        WHEN cards_total_amount = 0 THEN '0'
        WHEN cards_total_amount = 1 THEN '1'
        WHEN cards_total_amount BETWEEN 2 AND 4 THEN '2-4'
        WHEN cards_total_amount BETWEEN 5 AND 9 THEN '5-9'
        WHEN cards_total_amount BETWEEN 10 AND 19 THEN '10-19'
        WHEN cards_total_amount BETWEEN 20 AND 49 THEN '20-49'
        ELSE '50+'
    END AS CARD_QUANTITY_BANDS,
	
	sum_IS_CARD_UPSELL_ORDER  AS CARD_UPSELL_QUANTITY	,
	sum_IS_FLOWER_UPSELL_ORDER  AS FLOWER_UPSELL_QUANTITY	,
	sum_IS_CARD_UPSELL_ORDER + sum_IS_FLOWER_UPSELL_ORDER  AS TOTAL_UPSELL_QUANTITY	,
	0  AS ECARD_QUANTITY	,
	CARD_QUANTITY  AS PHYSICAL_CARD_QUANTITY	,
	
	SUM(IFF(IS_CARD_ORDER = True 
		AND 
		(
		 lower(gpv.productcode) like '%xl%' 
		 OR lower(gpv.productcode)  like '%supersize%'
		 )
	   , ol.productamount, 0)) AS GIANT_CARD_QUANTITY	,
	
	SUM(IFF(IS_CARD_ORDER = True 
		AND 
		(
		 lower(gpv.productcode) like '%large%' 
		 AND cd.cardratio = 'STANDARD'
		 )
	   , ol.productamount, 0)) AS LARGE_CARD_QUANTITY	,
	
	SUM(IFF(IS_CARD_ORDER = True 
		AND 
		(
		 lower(gpv.productcode) like '%large%' 
		 AND cd.cardratio = 'SQUARE'
		 )
	   , ol.productamount, 0)) AS LARGE_SQUARE_CARD_QUANTITY	,
	
	SUM(IFF(IS_CARD_ORDER = True 
		AND 
		(
		 lower(gpv.productcode) like '%medium%' 
		 AND cd.cardratio = 'SQUARE'
		 )
	   , ol.productamount, 0)) AS STANDARD_SQUARE_CARD_QUANTITY	,
	
	SUM(IFF(IS_CARD_ORDER = True 
		AND 
		(
		 lower(gpv.productcode) like '%medium%' 
		 AND cd.cardratio = 'STANDARD'
		 )
	   , ol.productamount, 0)) AS STANDARD_CARD_QUANTITY	,
	
	POSTCARD_QUANTITY	,
	NON_CARD_VOLUME	,
	NON_CARD_SALES	,
	CARD_ITEMS_ISEV_GBP	,
	GIFT_ITEMS_ISEV_GBP	,
	FLOWER_ITEMS_ISEV_GBP	,
	CARD_DISTINCT_PRODUCTS	,
	MULTI_CARD_SKU_ORDER	,
	MULTI_CARD_VOLUME	,
	MULTI_CARD_SALES	,
	CARD_ONLY_VOLUME	,
	CARD_ONLY_SALES	,
	GIFT_ONLY_VOLUME	,
	GIFT_ONLY_SALES	,
	FLOWER_ONLY_VOLUME	,
	FLOWER_ONLY_SALES	,
	ATTACH_VOLUME_TOTAL_ITEMS	,
	ATTACH_SALES_TOTAL_ITEMS	,
	ATTACH_VOLUME_ATTACHED_ITEMS	,
	ATTACH_SALES_ATTACHED_ITEMS	,
	CARD_ATTACH_VOLUME_CARD_ITEMS	,
	CARD_ATTACH_SALES_CARD_ITEMS	,
	GIFT_ATTACH_VOLUME_TOTAL_ITEMS	,
	GIFT_ATTACH_SALES_TOTAL_ITEMS	,
	GIFT_ATTACH_VOLUME_GIFT_ITEMS	,
	GIFT_ATTACH_SALES_GIFT_ITEMS	,
	FLOWER_ATTACH_VOLUME_TOTAL_ITEMS	,
	FLOWER_ATTACH_SALES_TOTAL_ITEMS	,
	FLOWER_ATTACH_VOLUME_FLOWER_ITEMS	,
	FLOWER_ATTACH_SALES_FLOWER_ITEMS	,
	XSELL_SALES_TOTAL_ITEMS	,
	XSELL_VOLUME_TOTAL_ITEMS	,
	FLOWER_XSELL_SALES	,
	GIFT_XSELL_SALES	,
	DISCOUNTED_VOLUME	,
	CARD_DISCOUNTED_VOLUME	,
	GIFT_DISCOUNTED_VOLUME	,
	FLOWER_DISCOUNTED_VOLUME	,
	NON_CARD_DISCOUNTED_VOLUME	,
	DISCOUNTED_SALES	,
	CARD_DISCOUNTED_SALES	,
	GIFT_DISCOUNTED_SALES	,
	FLOWER_DISCOUNTED_SALES	,
	NON_CARD_DISCOUNTED_SALES	,
	LOW_EFFORT_ITEMS	,
	HIGH_EFFORT_ITEMS	,
	LOW_EFFORT_CARD_ITEMS	,
	HIGH_EFFORT_CARD_ITEMS	,
	False  AS IS_MEMBERSHIP_ORDER	,
	False  AS IIS_MEMBERSHIP_SIGNUP_ORDER	,
	NULL  AS MEMBERSHIP_SIGNUP_DATETIME	,
	NULL  AS MEMBERSHIP_VERSION	,
	NULL  AS MCD_ORDER_ID	,
	NULL  AS MCD_ENCRYPTED_ORDER_ID	,
	NULL  AS MCD_CUSTOMER_ID	,
	'grtz'  AS BRAND	,
	MESSAGE_TIMESTAMP	,
	IMPORT_DATETIME	,
	SOURCE_DATA	,
	DBT_MODEL_NAME	,
	DBT_INVOCATION_ID	,
	DBT_JOB_STARTED_AT	

FROM
--	(SELECT * FROM orders WHERE ordercode = '1-4RKXKMFYL1' /*id = 1337079006*/ ORDER BY id DESC LIMIT 1000) o
    "RAW_GREETZ"."GREETZ3".orders o
    INNER JOIN "RAW_GREETZ"."GREETZ3".orderline AS ol 
		ON o.id = ol.orderid
	LEFT JOIN PROD.dw_lookup.exchange_rate_history AS ex
		ON ex.month = concat(year(o.CREATED), iff(month(o.CREATED) < 10, '0',''), month(o.CREATED))
			AND ex.local_currency = 'EUR'
			AND ex.destination_currency = 'GBP'
	LEFT JOIN PROD.dw_lookup.exchange_rate_history AS ex_2
		ON ex_2.month = concat(year(o.CREATED), iff(month(o.CREATED) < 10, '0',''), month(o.CREATED))
			AND ex_2.local_currency = 'GBP'
			AND ex_2.destination_currency = 'EUR'
	LEFT JOIN "RAW_GREETZ"."GREETZ3".productiteminbasket AS pib 
		ON pib.ID = ol.PRODUCTITEMINBASKETID
	LEFT JOIN "RAW_GREETZ"."GREETZ3".customercreatedcard AS c 
		ON pib.CONTENTSELECTIONID = c.ID
	LEFT JOIN "RAW_GREETZ"."GREETZ3".carddefinition AS cd
		ON cd.ID = c.carddefinition
	LEFT JOIN "RAW_GREETZ"."GREETZ3".tmp_dm_gift_product_variants AS gpv 
		ON (gpv.designId = c.carddefinition AND gpv.product_id = ol.productid AND gpv.type = 'personalizedGift')
		   OR (gpv.product_id = ol.productid AND c.carddefinition  IS NULL)		
		   OR (gpv.product_id = ol.productid AND c.carddefinition IS NOT NULL  AND gpv.designId  IS NULL)
	LEFT JOIN "RAW_GREETZ"."GREETZ3".product AS p
		ON ol.productid = p.ID
	LEFT JOIN "RAW_GREETZ"."GREETZ3".individualshipping AS isp
       ON ol.individualshippingid = isp.id	
	LEFT JOIN "RAW_GREETZ"."GREETZ3".recipient AS r
       ON isp.recipientid = r.id
	LEFT JOIN "RAW_GREETZ"."GREETZ3".address AS a2
	   ON o.customerid = a2.customerid 
		  AND a2.DEFAULTADDRESS = 'Y'
	LEFT JOIN "RAW_GREETZ"."GREETZ3".ordercostentry AS oce
		ON oce.ordercostid = ol.orderid
			AND oce.orderlineid = ol.ID
			
GROUP BY 
	o.ID,O.CREATED, O.CUSTOMERID, O.ORDERCODE, O.CURRENTORDERSTATE, O.CURRENCYCODE, EX.AVG_RATE, EX_2.AVG_RATE

/*
SELECT *, 

FROM cte_GrouppedByOrderLine gol
	 LEFT JOIN individualshipping isp
       ON gol.individualshippingid = isp.id	
	 LEFT JOIN recipient r
       ON isp.recipientid = r.id
	 LEFT JOIN address a2
	   ON gol.customerid = a2.customerid 
		  AND a2.DEFAULTADDRESS = 'Y'*/

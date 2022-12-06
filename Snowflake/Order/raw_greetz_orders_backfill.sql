 WITH cte_ISEV_groupped_0
 AS
 (
 SELECT 	ol.ORDERID, 
			ol.INDIVIDUALSHIPPINGID,
			SUM(IFF(p.TYPE = 'productCardSingle' OR p.productcode LIKE 'card%', ol.PRODUCTAMOUNT, 0)) AS cards_count,
			SUM(IFF(p.TYPE IN ('standardGift', 'personalizedGift') AND pt.MPTypeCode != 'flower', ol.PRODUCTAMOUNT, 0)) AS gifts_count,
			SUM(IFF(pt.MPTypeCode = 'flower', ol.PRODUCTAMOUNT, 0)) AS flowers_count,
			
			SUM(IFF(p.TYPE = 'productCardSingle' OR p.productcode LIKE 'card%', ol.TOTALWITHOUTVAT, 0)) AS cards_cost,
			SUM(IFF(p.TYPE IN ('standardGift', 'personalizedGift') AND pt.MPTypeCode != 'flower', ol.TOTALWITHOUTVAT, 0)) AS gifts_cost,
			SUM(IFF(pt.MPTypeCode = 'flower', ol.TOTALWITHOUTVAT, 0)) AS flowers_cost,

			SUM(IFF(p.PRODUCTCODE != 'shipment_generic', ol.productamount, 0))  AS total_amount,
			SUM(IFF(p.PRODUCTCODE = 'shipment_generic', ol.TOTALWITHVAT, 0))  AS postage_cost,
			
			IFF(cards_count = 0, 0, cards_cost + postage_cost * (cards_count / total_amount))  AS cards_ISEV,
			IFF(gifts_count = 0, 0, gifts_cost + postage_cost * (gifts_count / total_amount))  AS gifts_ISEV,
			IFF(flowers_count = 0, 0, flowers_cost + postage_cost * (flowers_count / total_amount))  AS flowers_ISEV
			
 FROM orderline ol 
    INNER JOIN product p ON ol.PRODUCTID = p.ID
    LEFT JOIN productgift pg ON p.ID = pg.PRODUCTID
    LEFT JOIN greetz_to_mnpg_product_types_view pt  ON pt.GreetzTypeID = IFNULL(pg.productgiftcategoryid, pg.productgifttypeid) 
 GROUP BY   ol.ORDERID, 
			ol.INDIVIDUALSHIPPINGID
 ),
 
 cte_ISEV_groupped
 AS
 (
 SELECT  ORDERID, 
 			SUM(cards_ISEV)  AS cards_ISEV,
 			SUM(gifts_ISEV)  AS gifts_ISEV,
 			SUM(flowers_ISEV)  AS flowers_ISEV
 FROM cte_ISEV_groupped_0
 GROUP BY ORDERID
 ),

cte_content AS
( 
SELECT PRODUCTITEMINBASKETID, sum(totalwithvat) AS totalwithvat
FROM orderline o JOIN product p ON o.productid = p.id
WHERE p.type = 'content'
GROUP BY PRODUCTITEMINBASKETID
),

cte_Fee_0 AS
(
SELECT ol.ID, KICK_BACK_FEE, ROW_NUMBER() OVER (PARTITION BY ol.ID ORDER BY DATE_START)  AS RN
FROM orderline ol 
    join orders o 
		ON ol.orderid = o.ID
    join RAW_GREETZ.GREETZDWH.INTEGRATION_GiftCardsKickBackFeeDateInterval fee 
        ON ol.productid = fee.PRODUCT_ID
            AND (to_date(IFNULL(IFF(fee.DATE_START = 'NULL', '01-01-1990', fee.DATE_START), '01-01-1990'), 'DD-MM-YYYY' ) < o.CREATED ) 
            AND (to_date(IFNULL(IFF(fee.DATE_END = 'NULL', '01-01-2030', fee.DATE_END), '01-01-2030'), 'DD-MM-YYYY' ) > o.CREATED )
),

cte_Fee AS
(
SELECT ID AS OrderLineID, KICK_BACK_FEE
FROM cte_Fee_0
WHERE RN = 1
),

cte_Main AS
(
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
	
	CASE WHEN rr.code ='hybridaiosapp' THEN 'iOS App'
		WHEN rr.code='hybridandroidapp' THEN 'Android App'
		WHEN s.devicetype='MOBILE' THEN 'Mobile Web'
		WHEN s.devicetype='NORMAL' OR s.devicetype='TABLET' THEN 'Desktop Web'
		ELSE devicetype
	END AS	PLATFORM	,										
	
	concat('LEGO-', o.ORDERCODE) AS	ORDER_NUMBER	,
	IFF(o.currentorderstate = 'CANCELLED', 'Cancelled', 'Confirmed')  AS ORDER_STATE	,
	sum(IFF(ol.packettoselfid IS NULL, 1, 0))  AS not_toself_count	,
	sum(IFF(ol.packettoselfid IS NOT NULL, 1, 0))  AS toself_count	,
	
	sum(IFF(r.addressid IS NULL, 1, 0))  AS null_addresses_count	,
	sum(IFF(a2.customerid IS NOT NULL, 1, 0))  AS customer_addresses_count	, --  1 is max
	
	IFF(
		COUNT(DISTINCT r.addressid) - IFF(null_addresses_count > 0, 1, 0) = 0,
		IFF(customer_addresses_count > 0, 1, 0),
		0
	    )	AS NUMBER_OF_ADDRESSES	,
		
	case 
		when not_toself_count > 0 AND toself_count = 0 then 'DIRECT'
		when not_toself_count = 0 AND toself_count > 0 then 'CUSTOMER'
		when not_toself_count > 0 AND toself_count > 0 then 'SPLIT'
	end 	AS ORDER_ADDRESS_TYPE	,
	
	IFF(NUMBER_OF_ADDRESSES = 1, True, False)  AS SINGLE_ADDRESS_FLAG	,
	'LineItemLevel' AS ORDER_TAX_CALCULATION	,
	True AS ORDER_TRANSACTION_FEE	,
	sum(IFF(p.productcode != 'shipment_generic', 1, 0)) ITEMS_IN_ORDER	,						
	o.currencycode AS ORDER_CURRENCYCODE	,
	ex.avg_rate AS TO_GBP_RATE,
	ex_2.avg_rate AS MNTH_GBP_TO_EUR_RATE,
	abs(sum(IFF(p.productcode != 'shipment_generic', ol.DISCOUNTWITHOUTVAT, 0)))  AS PRODUCT_DISCOUNT_EX_TAX	,
	abs(sum(IFF(p.productcode != 'shipment_generic', ol.DISCOUNTWITHVAT - ol.DISCOUNTWITHOUTVAT, 0)))  AS PRODUCT_DISCOUNT_TAX	,
	abs(sum(IFF(p.productcode != 'shipment_generic', ol.DISCOUNTWITHVAT, 0)))  AS PRODUCT_DISCOUNT_INC_TAX	,
	abs(sum(IFF(p.productcode = 'shipment_generic', ol.DISCOUNTWITHOUTVAT, 0)))  AS POSTAGE_DISCOUNT_EX_TAX	,
	abs(sum(IFF(p.productcode = 'shipment_generic', ol.DISCOUNTWITHVAT - ol.DISCOUNTWITHOUTVAT, 0)))  AS POSTAGE_DISCOUNT_TAX	,
	abs(sum(IFF(p.productcode = 'shipment_generic', ol.DISCOUNTWITHVAT, 0)))  AS POSTAGE_DISCOUNT_INC_TAX	,
	
	abs(sum(IFF(p.productcode != 'shipment_generic', ex.avg_rate * ol.DISCOUNTWITHOUTVAT, 0)))  AS PRODUCT_DISCOUNT_EX_TAX_GBP	,
	abs(sum(IFF(p.productcode != 'shipment_generic', ex.avg_rate * (ol.DISCOUNTWITHVAT - ol.DISCOUNTWITHOUTVAT), 0)))  AS PRODUCT_DISCOUNT_TAX_GBP	,
	abs(sum(IFF(p.productcode != 'shipment_generic', ex.avg_rate * ol.DISCOUNTWITHVAT, 0)))  AS PRODUCT_DISCOUNT_INC_TAX_GBP	,
	abs(sum(IFF(p.productcode = 'shipment_generic', ex.avg_rate * ol.DISCOUNTWITHOUTVAT, 0)))  AS POSTAGE_DISCOUNT_EX_TAX_GBP	,
	abs(sum(IFF(p.productcode = 'shipment_generic', ex.avg_rate * (ol.DISCOUNTWITHVAT - ol.DISCOUNTWITHOUTVAT), 0)))  AS POSTAGE_DISCOUNT_TAX_GBP	,
	abs(sum(IFF(p.productcode = 'shipment_generic', ex.avg_rate * ol.DISCOUNTWITHVAT, 0)))  AS POSTAGE_DISCOUNT_INC_TAX_GBP	,
	sum(IFF(p.productcode != 'shipment_generic', cast((ol.totalwithvat + IFNULL(co.totalwithvat, 0))/ol.productamount as DECIMAL(10,2)), 0)) AS	PRODUCT_UNIT_PRICE	,					-- to do later
	
	sum(IFF(p.productcode != 'shipment_generic', ol.TOTALWITHOUTVAT, 0)) AS ORDER_ESEV	,
	sum(IFF(p.productcode != 'shipment_generic', ol.productamount, 0))  AS total_amount,
	sum(IFF(p.productcode = 'shipment_generic', ol.WITHVAT + ol.DISCOUNTWITHVAT, 0)) / total_amount  AS POSTAGE_UNIT_PRICE	, 		-- ?
	abs(sum(IFF(p.productcode = 'shipment_generic', ol.TOTALWITHOUTVAT, 0)))  AS POSTAGE_EX_TAX	,
	-- PRODUCT_LINE_TAX = PRODUCT_TOTAL_TAX + PRODUCT_DISCOUNT_TAX
	sum(IFF(p.productcode != 'shipment_generic', ol.TOTALWITHOUTVAT - ol.TOTALWITHVAT + abs(ol.DISCOUNTWITHVAT - ol.DISCOUNTWITHOUTVAT), 0))  AS PRODUCT_LINE_TAX	,
	sum(IFF(p.productcode != 'shipment_generic', ol.TOTALWITHVAT - ol.TOTALWITHOUTVAT, 0)) AS PRODUCT_TOTAL_TAX	,
	sum(IFF(p.productcode != 'shipment_generic', ol.TOTALWITHVAT, 0)) AS ORDER_ESIV	,
	-- POSTAGE_LINE_TAX = POSTAGE_TOTAL_TAX + POSTAGE_DISCOUNT_TAX
	sum(IFF(p.productcode = 'shipment_generic', ol.TOTALWITHVAT - ol.TOTALWITHOUTVAT + abs(ol.DISCOUNTWITHVAT - ol.DISCOUNTWITHOUTVAT), 0)) AS POSTAGE_LINE_TAX	,
	sum(IFF(p.productcode = 'shipment_generic', ol.TOTALWITHVAT - ol.TOTALWITHOUTVAT, 0)) AS POSTAGE_TOTAL_TAX	,
	-- POSTAGE_SUBTOTAL = POSTAGE_EX_TAX + POSTAGE_TOTAL_TAX
	sum(IFF(p.productcode = 'shipment_generic', /*ol.TOTALWITHOUTVAT +*/ ol.TOTALWITHVAT /*- ol.TOTALWITHOUTVAT*/, 0)) AS POSTAGE_SUBTOTAL	,
	sum(ol.TOTALWITHOUTVAT) AS ORDER_ISEV	,
	abs(sum(ol.DISCOUNTWITHVAT)) AS TOTAL_DISCOUNT	,
	sum(ol.TOTALWITHVAT - ol.TOTALWITHOUTVAT) AS TOTAL_TAX	,
	sum(ol.TOTALWITHVAT) AS ORDER_ISIV	,
	sum(ol.TOTALWITHVAT) ORDER_CASH_PAID	,
	ex.avg_rate * PRODUCT_UNIT_PRICE  AS PRODUCT_UNIT_PRICE_GBP	,
	sum(IFF(p.productcode != 'shipment_generic', ex.avg_rate * ol.TOTALWITHOUTVAT, 0))  AS ORDER_ESEV_GBP	,
	ex.avg_rate * POSTAGE_UNIT_PRICE  AS POSTAGE_UNIT_PRICE_GBP	,
	abs(sum(IFF(p.productcode = 'shipment_generic', ex.avg_rate * ol.TOTALWITHOUTVAT, 0)))  AS POSTAGE_EX_TAX_GBP	,
	sum(IFF(p.productcode != 'shipment_generic', ex.avg_rate * (ol.TOTALWITHOUTVAT - ol.TOTALWITHVAT + abs(ol.DISCOUNTWITHVAT - ol.DISCOUNTWITHOUTVAT)), 0))  AS PRODUCT_LINE_TAX_GBP	,
	sum(IFF(p.productcode != 'shipment_generic', ex.avg_rate * (ol.TOTALWITHVAT - ol.TOTALWITHOUTVAT), 0))  AS PRODUCT_TOTAL_TAX_GBP	,
	sum(IFF(p.productcode != 'shipment_generic', ex.avg_rate * ol.TOTALWITHVAT, 0))  AS ORDER_ESIV_GBP	,
	sum(IFF(p.productcode = 'shipment_generic', ex.avg_rate * (ol.TOTALWITHVAT - ol.TOTALWITHOUTVAT + abs(ol.DISCOUNTWITHVAT - ol.DISCOUNTWITHOUTVAT)), 0))  AS POSTAGE_LINE_TAX_GBP	,
	sum(IFF(p.productcode = 'shipment_generic', ex.avg_rate * (ol.TOTALWITHVAT - ol.TOTALWITHOUTVAT), 0))  AS POSTAGE_TOTAL_TAX_GBP	,
	sum(IFF(p.productcode = 'shipment_generic', ex.avg_rate * ( /*ol.TOTALWITHOUTVAT +*/ ol.TOTALWITHVAT /*- ol.TOTALWITHOUTVAT*/), 0)) AS POSTAGE_SUBTOTAL_GBP	,
	sum(ex.avg_rate * ol.TOTALWITHOUTVAT)  AS ORDER_ISEV_GBP	,
	abs(sum(ex.avg_rate * ol.DISCOUNTWITHVAT))  AS TOTAL_DISCOUNT_GBP	,
	sum(ex.avg_rate * (ol.TOTALWITHVAT - ol.TOTALWITHOUTVAT))  AS TOTAL_TAX_GBP	,
	sum(ex.avg_rate * ol.TOTALWITHVAT)  AS ORDER_ISIV_GBP	,
	sum(ex.avg_rate * ol.TOTALWITHVAT) AS ORDER_CASH_PAID_GBP	,
	ORDER_ESEV - sum(IFF(oce.subcell != 'SHIPMENT', oce.purchasecost - oce.externalcontentcost - oce.othermaterialcost - oce.directlaborcost - oce.packagingcost, 0)) AS GROSS_PRODUCT_MARGIN	,
	POSTAGE_EX_TAX - sum(IFF(oce.subcell = 'SHIPMENT', oce.purchasecost - oce.externalcontentcost - oce.othermaterialcost - oce.directlaborcost - oce.packagingcost, 0)) AS GROSS_SHIPPING_MARGIN	,
	ORDER_ISEV - sum(oce.purchasecost - oce.externalcontentcost - oce.othermaterialcost - oce.directlaborcost - oce.packagingcost) AS TOTAL_GROSS_MARGIN	,	
	ORDER_ESEV - sum(IFF(oce.subcell != 'SHIPMENT', oce.purchasecost, 0)) AS COMMERCIAL_PRODUCT_MARGIN	,
	GROSS_SHIPPING_MARGIN  AS COMMERCIAL_SHIPPING_MARGIN,	
	ORDER_ISEV - IFNULL(sum(oce.purchasecost), 0)  AS TOTAL_COMMERCIAL_MARGIN	,
	
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
	SUM(ol.totalwithvat - 100 * IFNULL(fee.KICK_BACK_FEE, 0) * ol.totalwithvat/ol.productamount)  AS DIFF_TOTAL_GROSS,	-- ?
		
	DIFF_TOTAL_GROSS  AS DIFF_PRODUCT_SUBTOTAL	,					-- ?
	0  AS DIFF_POSTAGE_SUBTOTAL	,
	
	SUM(IFF(p.TYPE = 'productCardSingle' OR p.productcode LIKE 'card%', ol.productamount, 0))  AS cards,
	SUM(IFF(p.TYPE IN ('standardGift', 'personalizedGift') AND pt.MPTypeCode != 'flower', ol.productamount, 0))  AS gifts,
	SUM(IFF(pt.MPTypeCode = 'flower', ol.productamount, 0))  AS flowers,
	SUM(IFF(p.TYPE = 'productCardSingle' OR p.productcode LIKE 'card%', 1, 0))  AS cards_distinct,
	
	IFF(cards > 0, True, False)  AS IS_CARD_ORDER	,
	IFF(gifts > 0, True, False)  AS IS_GIFT_ORDER	,
	IFF(flowers > 0, True, False)  AS IS_FLOWER_ORDER	,
	
	SUM(IFF(p.TYPE = 'productCardSingle' OR p.productcode LIKE 'card%' 
		AND 
		(
		 lower(p.productcode) like '%xl%' 
		 OR lower(p.productcode)  like '%large%' 
		 OR lower(p.productcode)  like '%supersize%'
		 )
	   , ol.productamount, 0)) AS sum_IS_CARD_UPSELL_ORDER	,
	
	IFF(sum_IS_CARD_UPSELL_ORDER > 0, True, False)  AS IS_CARD_UPSELL_ORDER,
	
	SUM(IFF(pt.MPTypeCode = 'flower'
	   AND 
	   (
	    lower(p.productcode) like '%large%' 
	    OR lower(p.productcode) like '%groot%'
	   )
	, ol.productamount, 0)) AS sum_IS_FLOWER_UPSELL_ORDER	,
	
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
	IFF(cards > 1, True, False)  AS IS_MULTI_CARD_ORDER	,	 
	False  AS IS_XSELL_ORDER	,
	False  AS IS_FLOWER_XSELL_ORDER	,
	False  AS IS_GIFT_XSELL_ORDER	,
	IFF(TOTAL_DISCOUNT > 0, True, False)  AS IS_DISCOUNTED_ORDER	,
	IFF(TOTAL_DISCOUNT > 0 AND cards > 0, True, False)  AS IS_CARD_DISCOUNTED_ORDER	,
	IFF(TOTAL_DISCOUNT > 0 AND gifts > 0, True, False)  AS IS_GIFT_DISCOUNTED_ORDER	,
	IFF(TOTAL_DISCOUNT > 0 AND flowers > 0, True, False)  AS IS_FLOWER_DISCOUNTED_ORDER	,
	IFF(TOTAL_DISCOUNT > 0 AND IS_NON_CARD_ORDER = True, True, False)  AS IS_NON_CARD_DISCOUNTED_ORDER	,
	sum(IFF(cd.CONTENTTYPE IN ('PHOTO_TEMPLATE','PHOTO_SELF') OR p.productcode = 'personalizedGift', 1, 0))  AS HIGH_EFFORT_ITEMS	,
	sum(IFF(cd.CONTENTTYPE IN ('PHOTO_TEMPLATE','PHOTO_SELF') OR p.productcode = 'personalizedGift', 0, 1))  AS LOW_EFFORT_ITEMS	,
	sum(IFF(cd.CONTENTTYPE IN ('PHOTO_TEMPLATE','PHOTO_SELF'), 1, 0))  AS HIGH_EFFORT_CARD_ITEMS	,
	sum(IFF(cd.CONTENTTYPE IN ('PHOTO_TEMPLATE','PHOTO_SELF'), 0, 1))  AS LOW_EFFORT_CARD_ITEMS	,
	IFF(HIGH_EFFORT_ITEMS > 0, True, False)  AS IS_PHOTO_UPLOAD_ORDER	,
	IFF(IS_PHOTO_UPLOAD_ORDER = True, False, True)  AS IS_LOW_EFFORT_ORDER	,
	IS_PHOTO_UPLOAD_ORDER  AS IS_HIGH_EFFORT_ORDER	,
	sum(IFF(cd.CONTENTTYPE IN ('PHOTO_TEMPLATE','PHOTO_SELF'), 1, 0))  AS high_effort_items_card_only	,
	IFF(high_effort_items_card_only > 0, False, True)  AS IS_LOW_EFFORT_CARD_ORDER	,
	IFF(high_effort_items_card_only > 0, True, False)  AS IS_HIGH_EFFORT_CARD_ORDER	,
	
	IFF(toself_count > 0 AND not_toself_count = 0, True, False)  AS IS_CUSTOMER_ADDRESS_TYPE_ORDER_ONLY	,
	IFF(toself_count = 0 AND not_toself_count > 0, True, False)  AS IS_DIRECT_ADDRESS_TYPE_ORDER_ONLY	,
	False  AS IS_EMAIL_ADDRESS_TYPE_ORDER_ONLY	,
	IFF(gifts > 0, True, False)  AS IS_SPLIT_ADDRESS_TYPE_ORDER	,
	False  AS IS_SPLIT_EMAIL_ADDRESS_TYPE_ORDER	,
	cards AS CARD_QUANTITY	,
	SUM(IFF(p.TYPE IN ('standardGift', 'personalizedGift') AND pt.MPTypeCode != 'flower', ol.productamount, 0))  AS GIFT_QUANTITY,
	SUM(IFF(pt.MPTypeCode = 'flower', ol.productamount, 0))  AS FLOWER_QUANTITY,
	CARD_QUANTITY + FLOWER_QUANTITY  AS CARD_FLOWER_QUANTITY	,
	
	CASE
        WHEN cards = 0 THEN '0'
        WHEN cards = 1 THEN '1'
        WHEN cards BETWEEN 2 AND 4 THEN '2-4'
        WHEN cards BETWEEN 5 AND 9 THEN '5-9'
        WHEN cards BETWEEN 10 AND 19 THEN '10-19'
        WHEN cards BETWEEN 20 AND 49 THEN '20-49'
        ELSE '50+'
    END AS CARD_QUANTITY_BANDS,
	
	sum_IS_CARD_UPSELL_ORDER  AS CARD_UPSELL_QUANTITY	,
	sum_IS_FLOWER_UPSELL_ORDER  AS FLOWER_UPSELL_QUANTITY	,
	sum_IS_CARD_UPSELL_ORDER + sum_IS_FLOWER_UPSELL_ORDER  AS TOTAL_UPSELL_QUANTITY	,
	0  AS ECARD_QUANTITY	,
	CARD_QUANTITY  AS PHYSICAL_CARD_QUANTITY	,
	
	SUM(IFF(p.TYPE = 'productCardSingle' OR p.productcode LIKE 'card%' 
		AND 
		(
		 lower(p.productcode) like '%xl%' 
		 OR lower(p.productcode)  like '%supersize%'
		 )
	   , ol.productamount, 0)) AS GIANT_CARD_QUANTITY	,
	
	SUM(IFF(p.TYPE = 'productCardSingle' OR p.productcode LIKE 'card%' 
		AND 
		(
		 lower(p.productcode) like '%large%' 
		 AND cd.cardratio = 'STANDARD'
		 )
	   , ol.productamount, 0)) AS LARGE_CARD_QUANTITY	,
	
	SUM(IFF(p.TYPE = 'productCardSingle' OR p.productcode LIKE 'card%' 
		AND 
		(
		 lower(p.productcode) like '%large%' 
		 AND cd.cardratio = 'SQUARE'
		 )
	   , ol.productamount, 0)) AS LARGE_SQUARE_CARD_QUANTITY	,
	
	SUM(IFF(p.TYPE = 'productCardSingle' OR p.productcode LIKE 'card%'  
		AND 
		(
		 lower(p.productcode) like '%medium%' 
		 AND cd.cardratio = 'SQUARE'
		 )
	   , ol.productamount, 0)) AS STANDARD_SQUARE_CARD_QUANTITY	,
	
	SUM(IFF(p.TYPE = 'productCardSingle' OR p.productcode LIKE 'card%' 
		AND 
		(
		 lower(p.productcode) like '%medium%' 
		 AND cd.cardratio = 'STANDARD'
		 )
	   , ol.productamount, 0)) AS STANDARD_CARD_QUANTITY	,
	
	SUM(IFF(cd.NUMBEROFPANELS = 1, 1, 0))  AS POSTCARD_QUANTITY,
	gifts + flowers  AS NON_CARD_VOLUME,
		
-- moved down	GIFT_ITEMS_ISEV_GBP + FLOWER_ITEMS_ISEV_GBP  AS NON_CARD_SALES	,  
	
	IFNULL(ig.cards_ISEV, 0) * ex.avg_rate  AS CARD_ITEMS_ISEV_GBP,
	IFNULL(ig.gifts_ISEV, 0) * ex.avg_rate  AS GIFT_ITEMS_ISEV_GBP	,
	IFNULL(ig.flowers_ISEV, 0) * ex.avg_rate  AS FLOWER_ITEMS_ISEV_GBP	,
	
	GIFT_ITEMS_ISEV_GBP + FLOWER_ITEMS_ISEV_GBP  AS NON_CARD_SALES	,
	
	cards_distinct  AS CARD_DISTINCT_PRODUCTS	,
	IFF(CARD_DISTINCT_PRODUCTS > 1, 'Multi SKU', 'Single SKU')  AS MULTI_CARD_SKU_ORDER	,
	IFF(CARD_DISTINCT_PRODUCTS > 1, CARD_DISTINCT_PRODUCTS, 0)  AS MULTI_CARD_VOLUME,
	IFF(CARD_DISTINCT_PRODUCTS > 1, IFNULL(ig.cards_ISEV, 0), 0)  AS 	MULTI_CARD_SALES	,
	IFF(IS_CARD_ONLY_ORDER = True, CARD_QUANTITY, 0)  AS CARD_ONLY_VOLUME	,
	IFF(IS_CARD_ONLY_ORDER = True, IFNULL(ig.cards_ISEV, 0), 0)  AS CARD_ONLY_SALES	,
	IFF(IS_GIFT_ONLY_ORDER = True, GIFT_QUANTITY, 0)  AS GIFT_ONLY_VOLUME	,	
	IFF(IS_GIFT_ONLY_ORDER = True, GIFT_ITEMS_ISEV_GBP, 0)  AS GIFT_ONLY_SALES	,
	IFF(IS_FLOWER_ONLY_ORDER = True, FLOWER_QUANTITY, 0)  AS FLOWER_ONLY_VOLUME	,	
	IFF(IS_FLOWER_ONLY_ORDER = True, FLOWER_ITEMS_ISEV_GBP, 0)  AS FLOWER_ONLY_SALES	,
	IFF(IS_ATTACH_ORDER = True, total_amount /*CARD_QUANTITY + GIFT_QUANTITY + FLOWER_QUANTITY*/, 0)  AS ATTACH_VOLUME_TOTAL_ITEMS	,
	IFF(IS_ATTACH_ORDER = True, ORDER_ISEV, 0)  AS ATTACH_SALES_TOTAL_ITEMS	,	
	IFF(IS_ATTACH_ORDER = True, GIFT_QUANTITY + FLOWER_QUANTITY, 0)  AS ATTACH_VOLUME_ATTACHED_ITEMS	,
	IFF(IS_ATTACH_ORDER = True, GIFT_ITEMS_ISEV_GBP + FLOWER_ITEMS_ISEV_GBP, 0)  AS ATTACH_SALES_ATTACHED_ITEMS	,
	IFF(IS_ATTACH_ORDER = True, CARD_QUANTITY, 0)  AS CARD_ATTACH_VOLUME_CARD_ITEMS	,
	IFF(IS_ATTACH_ORDER = True, IFNULL(ig.cards_ISEV, 0), 0)  AS CARD_ATTACH_SALES_CARD_ITEMS	,
	
	IFF(IS_GIFT_ATTACH_ORDER = True, total_amount /*CARD_QUANTITY + GIFT_QUANTITY + FLOWER_QUANTITY*/, 0)  AS GIFT_ATTACH_VOLUME_TOTAL_ITEMS	,
	IFF(IS_GIFT_ATTACH_ORDER = True, ORDER_ISEV, 0)  AS GIFT_ATTACH_SALES_TOTAL_ITEMS	,
	IFF(IS_GIFT_ATTACH_ORDER = True, GIFT_QUANTITY, 0)  AS GIFT_ATTACH_VOLUME_GIFT_ITEMS	,
	IFF(IS_GIFT_ATTACH_ORDER = True, GIFT_ITEMS_ISEV_GBP, 0)  AS GIFT_ATTACH_SALES_GIFT_ITEMS	,

	IFF(IS_FLOWER_ATTACH_ORDER = True, total_amount /*CARD_QUANTITY + GIFT_QUANTITY + FLOWER_QUANTITY*/, 0)  AS FLOWER_ATTACH_VOLUME_TOTAL_ITEMS	,
	IFF(IS_FLOWER_ATTACH_ORDER = True, ORDER_ISEV, 0)  AS FLOWER_ATTACH_SALES_TOTAL_ITEMS	,
	IFF(IS_FLOWER_ATTACH_ORDER = True, FLOWER_QUANTITY, 0)  AS FLOWER_ATTACH_VOLUME_FLOWER_ITEMS	,
	IFF(IS_FLOWER_ATTACH_ORDER = True, FLOWER_ITEMS_ISEV_GBP, 0)  AS FLOWER_ATTACH_SALES_FLOWER_ITEMS	,
	
	0  AS XSELL_SALES_TOTAL_ITEMS	,
	0  AS XSELL_VOLUME_TOTAL_ITEMS	,
	0  AS FLOWER_XSELL_SALES	,
	0  AS GIFT_XSELL_SALES	,
	
	IFF(IS_DISCOUNTED_ORDER = True, total_amount /*CARD_QUANTITY + GIFT_QUANTITY + FLOWER_QUANTITY*/, 0)  AS DISCOUNTED_VOLUME	,
	IFF(IS_DISCOUNTED_ORDER = True, CARD_QUANTITY, 0)  AS CARD_DISCOUNTED_VOLUME	,
	IFF(IS_DISCOUNTED_ORDER = True, GIFT_QUANTITY, 0)  AS GIFT_DISCOUNTED_VOLUME	,
	IFF(IS_DISCOUNTED_ORDER = True, FLOWER_QUANTITY, 0)  AS FLOWER_DISCOUNTED_VOLUME	,
	IFF(IS_DISCOUNTED_ORDER = True AND IS_NON_CARD_ORDER = True, GIFT_QUANTITY + FLOWER_QUANTITY, 0)  AS NON_CARD_DISCOUNTED_VOLUME	,
	IFF(IS_DISCOUNTED_ORDER = True, ORDER_ISEV, 0)  AS DISCOUNTED_SALES	,
	IFF(IS_DISCOUNTED_ORDER = True, IFNULL(ig.cards_ISEV, 0), 0)  AS CARD_DISCOUNTED_SALES	,
	IFF(IS_DISCOUNTED_ORDER = True, IFNULL(ig.gifts_ISEV, 0), 0)  AS GIFT_DISCOUNTED_SALES	,
	IFF(IS_DISCOUNTED_ORDER = True, IFNULL(ig.flowers_ISEV, 0), 0)  AS FLOWER_DISCOUNTED_SALES	,
	IFF(IS_DISCOUNTED_ORDER = True AND IS_NON_CARD_ORDER = True, ORDER_ISEV, 0)  AS NON_CARD_DISCOUNTED_SALES	,
	
	-- calced above
	-- LOW_EFFORT_ITEMS	,
	-- HIGH_EFFORT_ITEMS	,
	-- LOW_EFFORT_CARD_ITEMS	,
	-- HIGH_EFFORT_CARD_ITEMS	,
	
	False  AS IS_MEMBERSHIP_ORDER	,
	False  AS IS_MEMBERSHIP_SIGNUP_ORDER	,
	NULL  AS MEMBERSHIP_SIGNUP_DATETIME	,
	NULL  AS MEMBERSHIP_VERSION	,
	NULL  AS MCD_ORDER_ID	,
	NULL  AS MCD_ENCRYPTED_ORDER_ID	,
	NULL  AS MCD_CUSTOMER_ID	,
	'grtz'  AS BRAND	,
	current_timestamp()  AS MESSAGE_TIMESTAMP	,
	current_timestamp()  AS IMPORT_DATETIME	,
	NULL  AS SOURCE_DATA	,
	NULL  AS DBT_MODEL_NAME	,
	NULL  AS DBT_INVOCATION_ID	,
	NULL  AS DBT_JOB_STARTED_AT	

FROM
	(SELECT * FROM orders WHERE created > '2022-06-01' /*ordercode = '1-4RKXKMFYL1' id = 1337079006*/ ORDER BY created LIMIT 1000) o
--    "RAW_GREETZ"."GREETZ3".orders o
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
	/*LEFT JOIN (select 1 as avg_rate) AS ex
	LEFT JOIN (select 1 as avg_rate) AS ex_2*/
	
	LEFT JOIN "RAW_GREETZ"."GREETZ3".productiteminbasket AS pib 
		ON pib.ID = ol.PRODUCTITEMINBASKETID
	LEFT JOIN "RAW_GREETZ"."GREETZ3".customercreatedcard AS c 
		ON pib.CONTENTSELECTIONID = c.ID
	LEFT JOIN "RAW_GREETZ"."GREETZ3".carddefinition AS cd
		ON cd.ID = c.carddefinition
	/*LEFT JOIN "RAW_GREETZ"."GREETZ3".tmp_dm_gift_product_variants AS gpv 
		ON (gpv.designId = c.carddefinition AND gpv.product_id = ol.productid AND gpv.type = 'personalizedGift')
		   OR (gpv.product_id = ol.productid AND c.carddefinition  IS NULL)		
		   OR (gpv.product_id = ol.productid AND c.carddefinition IS NOT NULL  AND gpv.designId  IS NULL)*/
	LEFT JOIN "RAW_GREETZ"."GREETZ3".product AS p
		ON ol.productid = p.ID
	LEFT JOIN productgift pg 
		ON p.ID = pg.PRODUCTID
    LEFT JOIN greetz_to_mnpg_product_types_view pt  
		ON pt.GreetzTypeID = IFNULL(pg.productgiftcategoryid, pg.productgifttypeid) 
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
	LEFT JOIN cte_ISEV_groupped AS ig
		ON o.id = ig.orderid
	LEFT JOIN cte_content AS co
		ON ol.PRODUCTITEMINBASKETID = co.PRODUCTITEMINBASKETID
		   AND (p.type = 'productCardSingle' OR p.productcode LIKE 'card%')
	LEFT JOIN cte_Fee AS fee   
		ON ol.ID = fee.OrderLineID
	LEFT JOIN referrer AS rr
		ON o.referrerid = rr.ID
	LEFT JOIN customersessioninfo AS s
		ON c.customersessioninfo = s.ID

GROUP BY 
	o.ID, 
	o.CREATED, o.CUSTOMERID, o.ORDERCODE, o.CURRENTORDERSTATE, o.CURRENCYCODE, ex.AVG_RATE, ex_2.AVG_RATE, ig.cards_ISEV, 
	ig.gifts_ISEV, ig.flowers_ISEV, rr.code, s.devicetype
)

SELECT 
	ORDER_ID	,
	ORDER_DATE	,
	ORDER_DATE_TIME	,
	ORDER_HOUR_ONLY	,
	ORDER_MINUTE_ONLY	,
	CUSTOMER_ID	,
	ORDER_COUNTRY_CODE	,
	ORDER_COUNTRY	,
	ORDER_STORE	,
	PLATFORM	,
	ORDER_NUMBER	,
	ORDER_STATE	,
	NUMBER_OF_ADDRESSES	,
	ORDER_ADDRESS_TYPE	,
	SINGLE_ADDRESS_FLAG	,
	ORDER_TAX_CALCULATION	,
	ORDER_TRANSACTION_FEE	,
	ITEMS_IN_ORDER	,
	ORDER_CURRENCYCODE	,
	TO_GBP_RATE	,
	MNTH_GBP_TO_EUR_RATE	,
	PRODUCT_DISCOUNT_EX_TAX	,
	PRODUCT_DISCOUNT_TAX	,
	PRODUCT_DISCOUNT_INC_TAX	,
	POSTAGE_DISCOUNT_EX_TAX	,
	POSTAGE_DISCOUNT_TAX	,
	POSTAGE_DISCOUNT_INC_TAX	,
	PRODUCT_DISCOUNT_EX_TAX_GBP	,
	PRODUCT_DISCOUNT_TAX_GBP	,
	PRODUCT_DISCOUNT_INC_TAX_GBP	,
	POSTAGE_DISCOUNT_EX_TAX_GBP	,
	POSTAGE_DISCOUNT_TAX_GBP	,
	POSTAGE_DISCOUNT_INC_TAX_GBP	,
	PRODUCT_UNIT_PRICE	,
	ORDER_ESEV	,
	POSTAGE_UNIT_PRICE	,
	POSTAGE_EX_TAX	,
	PRODUCT_LINE_TAX	,
	PRODUCT_TOTAL_TAX	,
	ORDER_ESIV	,
	POSTAGE_LINE_TAX	,
	POSTAGE_TOTAL_TAX	,
	POSTAGE_SUBTOTAL	,
	ORDER_ISEV	,
	TOTAL_DISCOUNT	,
	TOTAL_TAX	,
	ORDER_ISIV	,
	ORDER_CASH_PAID	,
	PRODUCT_UNIT_PRICE_GBP	,
	ORDER_ESEV_GBP	,
	POSTAGE_UNIT_PRICE_GBP	,
	POSTAGE_EX_TAX_GBP	,
	PRODUCT_LINE_TAX_GBP	,
	PRODUCT_TOTAL_TAX_GBP	,
	ORDER_ESIV_GBP	,
	POSTAGE_LINE_TAX_GBP	,
	POSTAGE_TOTAL_TAX_GBP	,
	POSTAGE_SUBTOTAL_GBP	,
	ORDER_ISEV_GBP	,
	TOTAL_DISCOUNT_GBP	,
	TOTAL_TAX_GBP	,
	ORDER_ISIV_GBP	,
	ORDER_CASH_PAID_GBP	,
	GROSS_PRODUCT_MARGIN	,
	GROSS_SHIPPING_MARGIN	,
	TOTAL_GROSS_MARGIN	,
	COMMERCIAL_PRODUCT_MARGIN	,
	COMMERCIAL_SHIPPING_MARGIN	,
	TOTAL_COMMERCIAL_MARGIN	,
	TOTAL_SALES	,
	PRODUCT_SALES	,
	SHIPPING_SALES	,
	CUSTOMER_SERVICE	,
	CUSTOMER_SERVICE_GBP	,
	EVE_ORDER_TOTAL_AMOUNT	,
	EVE_ORDER_TOTAL_GROSS	,
	EVE_ORDER_TOTAL_NET	,
	EVE_TOTAL_POSTAGE	,
	EVE_TOTAL_LINE_ITEM	,
	DIFF_TOTAL_GROSS	,
	DIFF_PRODUCT_SUBTOTAL	,
	DIFF_POSTAGE_SUBTOTAL	,
	IS_CARD_ORDER	,
	IS_GIFT_ORDER	,
	IS_FLOWER_ORDER	,
	IS_CARD_UPSELL_ORDER	,
	IS_FLOWER_UPSELL_ORDER	,
	IS_UPSELL_ORDER	,
	IS_ECARD_ORDER	,
	IS_CARD_FLOWER_ORDER	,
	IS_ATTACH_ORDER	,
	IS_GIFT_OR_FLOWER_ORDER	,
	IS_GIFT_ATTACH_ORDER	,
	IS_FLOWER_ATTACH_ORDER	,
	IS_LARGE_FLOWER_ATTACH_ORDER	,
	IS_CARD_ONLY_ORDER	,
	IS_FLOWER_ONLY_ORDER	,
	IS_GIFT_ONLY_ORDER	,
	IS_FLOWER_OR_GIFT_ONLY_ORDER	,
	IS_NON_CARD_ORDER	,
	IS_MULTI_CARD_ORDER	,
	IS_XSELL_ORDER	,
	IS_FLOWER_XSELL_ORDER	,
	IS_GIFT_XSELL_ORDER	,
	IS_DISCOUNTED_ORDER	,
	IS_CARD_DISCOUNTED_ORDER	,
	IS_GIFT_DISCOUNTED_ORDER	,
	IS_FLOWER_DISCOUNTED_ORDER	,
	IS_NON_CARD_DISCOUNTED_ORDER	,
	IS_PHOTO_UPLOAD_ORDER	,
	IS_LOW_EFFORT_ORDER	,
	IS_HIGH_EFFORT_ORDER	,
	IS_LOW_EFFORT_CARD_ORDER	,
	IS_HIGH_EFFORT_CARD_ORDER	,
	IS_CUSTOMER_ADDRESS_TYPE_ORDER_ONLY	,
	IS_DIRECT_ADDRESS_TYPE_ORDER_ONLY	,
	IS_EMAIL_ADDRESS_TYPE_ORDER_ONLY	,
	IS_SPLIT_ADDRESS_TYPE_ORDER	,
	IS_SPLIT_EMAIL_ADDRESS_TYPE_ORDER	,
	CARD_QUANTITY	,
	GIFT_QUANTITY	,
	FLOWER_QUANTITY	,
	CARD_FLOWER_QUANTITY	,
	CARD_QUANTITY_BANDS	,
	CARD_UPSELL_QUANTITY	,
	FLOWER_UPSELL_QUANTITY	,
	TOTAL_UPSELL_QUANTITY	,
	ECARD_QUANTITY	,
	PHYSICAL_CARD_QUANTITY	,
	GIANT_CARD_QUANTITY	,
	LARGE_CARD_QUANTITY	,
	LARGE_SQUARE_CARD_QUANTITY	,
	STANDARD_SQUARE_CARD_QUANTITY	,
	STANDARD_CARD_QUANTITY	,
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
	IS_MEMBERSHIP_ORDER	,
	IS_MEMBERSHIP_SIGNUP_ORDER	,
	MEMBERSHIP_SIGNUP_DATETIME	,
	MEMBERSHIP_VERSION	,
	MCD_ORDER_ID	,
	MCD_ENCRYPTED_ORDER_ID	,
	MCD_CUSTOMER_ID	,
	BRAND	,
	MESSAGE_TIMESTAMP	,
	IMPORT_DATETIME	,
	SOURCE_DATA	,
	DBT_MODEL_NAME	,
	DBT_INVOCATION_ID	,
	DBT_JOB_STARTED_AT	
FROM cte_Main
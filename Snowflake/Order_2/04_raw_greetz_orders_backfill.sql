CREATE OR REPLACE TABLE "PROD"."WORKSPACE_GREETZ_HISTORY_MIGRATION"."RAW_GREETZ_CT_ORDERS_STAGING_BACKFILL" AS (

WITH cte_Fee_0 
AS
(
SELECT ol.ID, fee.KICK_BACK_FEE, ROW_NUMBER() OVER (PARTITION BY ol.ID ORDER BY fee.DATE_START DESC)  AS RN
FROM "RAW_GREETZ"."GREETZ3".orderline ol 
    join "RAW_GREETZ"."GREETZ3".orders o 
		ON ol.orderid = o.ID
    join RAW_GREETZ.GREETZDWH.INTEGRATION_GiftCardsKickBackFeeDateInterval fee 
        ON ol.productid = fee.PRODUCT_ID
            AND (to_date(IFF(fee.DATE_START = 'NULL' OR fee.DATE_START IS NULL, '01-01-1990', fee.DATE_START), 'DD-MM-YYYY' ) < o.CREATED ) 
            AND (to_date(IFF(fee.DATE_END = 'NULL' OR fee.DATE_END IS NULL, '01-01-2030', fee.DATE_END), 'DD-MM-YYYY' ) + 1 > o.CREATED )
),

cte_Fee 
AS
(
SELECT ID AS OrderLineID, KICK_BACK_FEE
FROM cte_Fee_0
WHERE RN = 1
),

cte_distinct_InShipping
AS
(
SELECT 
  ol.orderid, 
  ol.INDIVIDUALSHIPPINGID,
  
	CASE
		WHEN p.type = 'productCardSingle' OR p.productcode LIKE 'card%' THEN 'card'
		WHEN pt.MPTypeCode = 'flower' THEN 'flower'
		ELSE p.type
	END  AS ptype,
  
  IFF(ptype IN ('card', 'personalizedGift'), COUNT(DISTINCT c.carddefinition), COUNT(DISTINCT ol.productid))  AS amount
 -- COUNT(DISTINCT c.carddefinition) OVER (PARTITION BY ol.orderid)  AS DistinctCardsInOrder
   
FROM
	"RAW_GREETZ"."GREETZ3".orders o
    INNER JOIN "RAW_GREETZ"."GREETZ3".orderline AS ol ON o.id = ol.orderid
    INNER JOIN "RAW_GREETZ"."GREETZ3".product p on p.id = ol.productid
    LEFT JOIN "RAW_GREETZ"."GREETZ3".productgift pg ON p.ID = pg.PRODUCTID
	LEFT JOIN "RAW_GREETZ"."GREETZ3".greetz_to_mnpg_product_types_view pt ON pt.GreetzTypeID = IFNULL(pg.productgiftcategoryid, pg.productgifttypeid) 
	LEFT JOIN "RAW_GREETZ"."GREETZ3".productiteminbasket AS pib ON pib.ID = ol.PRODUCTITEMINBASKETID
	LEFT JOIN "RAW_GREETZ"."GREETZ3".customercreatedcard AS c ON pib.CONTENTSELECTIONID = c.ID
WHERE (p.type IN ('productCardSingle', 'standardGift', 'personalizedGift') OR p.productcode LIKE 'card%') 
	  AND o.channelid = 2
	  AND o.currentorderstate IN
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
		   'REFUNDED_CANCELLEDCARD_WALLET')
GROUP BY ol.orderid, ol.INDIVIDUALSHIPPINGID, ptype
 ),
  
 cte_ISEV_groupped_0
 AS
 (
 SELECT 	ol.ORDERID, 
			ol.INDIVIDUALSHIPPINGID,
			SUM(IFF(p.TYPE = 'productCardSingle' OR p.productcode LIKE 'card%', ol.PRODUCTAMOUNT, 0)) AS cards_count,
			SUM(IFF(p.TYPE IN ('standardGift', 'personalizedGift') AND pt.MPTypeCode != 'flower', ol.PRODUCTAMOUNT, 0)) AS gifts_count,
			SUM(IFF(pt.MPTypeCode = 'flower', ol.PRODUCTAMOUNT, 0)) AS flowers_count,
			
			SUM(IFF(p.TYPE IN ('productCardSingle', 'content') OR p.productcode LIKE 'card%', ol.TOTALWITHOUTVAT, 0)) AS cards_cost,
			SUM(IFF(p.TYPE IN ('standardGift', 'personalizedGift') AND pt.MPTypeCode != 'flower', ol.TOTALWITHOUTVAT * IFNULL(fee.KICK_BACK_FEE, 1), 0)) AS gifts_cost,
			SUM(IFF(pt.MPTypeCode = 'flower', ol.TOTALWITHOUTVAT, 0)) AS flowers_cost,

			SUM(IFF(p.type = 'shipment', ol.TOTALWITHOUTVAT, 0))  AS postage_cost,
			
			case when cards_count + gifts_count + flowers_count > 0 then
			  IFF(cards_count = 0, 0, cards_cost + postage_cost * (cards_count / (cards_count + gifts_count + flowers_count)))  
			else 0
			end 	AS cards_ISEV,
			
			case when cards_count + gifts_count + flowers_count > 0 then
			  IFF(gifts_count = 0, 0, gifts_cost + postage_cost * (gifts_count / (cards_count + gifts_count + flowers_count)))  
			else 0
			end  	AS gifts_ISEV,
			 
			case when cards_count + gifts_count + flowers_count > 0 then
			  IFF(flowers_count = 0, 0, flowers_cost + postage_cost * (flowers_count / (cards_count + gifts_count + flowers_count))) 
			else 0
			end  	AS flowers_ISEV,
			
			SUM(IFF(p.type = 'shipment', ol.TOTALWITHVAT, 0))  AS postage_cost_wVat
						
 FROM "RAW_GREETZ"."GREETZ3".orders o
	INNER JOIN "RAW_GREETZ"."GREETZ3".orderline ol ON o.ID = ol.ORDERID
    INNER JOIN "RAW_GREETZ"."GREETZ3".product p ON ol.PRODUCTID = p.ID
    LEFT JOIN "RAW_GREETZ"."GREETZ3".productgift pg ON p.ID = pg.PRODUCTID
    LEFT JOIN "RAW_GREETZ"."GREETZ3".greetz_to_mnpg_product_types_view pt  ON pt.GreetzTypeID = IFNULL(pg.productgiftcategoryid, pg.productgifttypeid) 
	LEFT JOIN cte_Fee fee ON ol.ID = fee.OrderLineID
 WHERE o.channelid = 2
	   AND o.currentorderstate IN
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
		   'REFUNDED_CANCELLEDCARD_WALLET')
 GROUP BY   ol.ORDERID, 
			ol.INDIVIDUALSHIPPINGID
 ),
 
 cte_ISEV_groupped
 AS
 (
 SELECT  ol.ORDERID, 
 			SUM(ol.cards_ISEV)  AS cards_ISEV,
 			SUM(ol.gifts_ISEV)  AS gifts_ISEV,
 			SUM(ol.flowers_ISEV)  AS flowers_ISEV,
			
			----------- POSTAGE_UNIT_PRICE --------
			SUM(IFNULL(d_card.amount, 0))  AS cards_count_distinct,
			SUM(IFNULL(d_gift_standard.amount, 0) + IFNULL(d_gift_personalized.amount, 0))  AS gifts_count_distinct,
			SUM(IFNULL(d_flower.amount, 0))  AS flowers_count_distinct,
			
			case when SUM(cards_count + gifts_count + flowers_count) > 0 then
			SUM(postage_cost_wVat) * (cards_count_distinct + gifts_count_distinct + flowers_count_distinct) / SUM(cards_count + gifts_count + flowers_count)  
			else 0 end  AS postage_unit_price
			
 FROM cte_ISEV_groupped_0 ol
	LEFT JOIN cte_distinct_InShipping d_card 
		ON ol.ORDERID = d_card.ORDERID AND ol.INDIVIDUALSHIPPINGID = d_card.INDIVIDUALSHIPPINGID
			AND d_card.ptype = 'card'
	LEFT JOIN cte_distinct_InShipping d_gift_standard 
		ON ol.ORDERID = d_gift_standard.ORDERID AND ol.INDIVIDUALSHIPPINGID = d_gift_standard.INDIVIDUALSHIPPINGID
			AND d_gift_standard.ptype = 'standardGift' 
	LEFT JOIN cte_distinct_InShipping d_gift_personalized
		ON ol.ORDERID = d_gift_personalized.ORDERID AND ol.INDIVIDUALSHIPPINGID = d_gift_personalized.INDIVIDUALSHIPPINGID
			AND d_gift_personalized.ptype = 'personalizedGift' 			
	LEFT JOIN cte_distinct_InShipping d_flower 
		ON ol.ORDERID = d_flower.ORDERID AND ol.INDIVIDUALSHIPPINGID = d_flower.INDIVIDUALSHIPPINGID
			AND d_flower.ptype = 'flower'			
 GROUP BY ol.ORDERID
 ),

cte_Main 
AS
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
	
	MAX(
	CASE WHEN rr.code ='hybridaiosapp' THEN 'iOS App'
		WHEN rr.code='hybridandroidapp' THEN 'Android App'
		WHEN s.devicetype='MOBILE' THEN 'Mobile Web'
		WHEN s.devicetype='NORMAL' OR s.devicetype='TABLET' THEN 'Desktop Web'
		ELSE devicetype
	END 
	)
	AS	PLATFORM	,										
	
	concat('LEGO-', o.ORDERCODE) AS	ORDER_NUMBER	,
	IFF(o.currentorderstate = 'CANCELLED', 'Cancelled', 'Confirmed')  AS ORDER_STATE	,
	sum(IFF(ol.packettoselfid IS NULL, 1, 0))  AS not_toself_count	,
	sum(IFF(ol.packettoselfid IS NOT NULL, 1, 0))  AS toself_count	,
	
	sum(IFF(a2.customerid IS NOT NULL, 1, 0))  AS customer_addresses_count	, --  1 is max
	
	IFF(
		COUNT(DISTINCT r.addressid) = 0,
		IFF(customer_addresses_count > 0, 1, 0),
		COUNT(DISTINCT r.addressid)
	    )	
		AS NUMBER_OF_ADDRESSES	,
		
	case 
		when not_toself_count > 0 AND toself_count = 0 then 'DIRECT'
		when not_toself_count = 0 AND toself_count > 0 then 'CUSTOMER'
		when not_toself_count > 0 AND toself_count > 0 then 'SPLIT'
	end 	AS ORDER_ADDRESS_TYPE	,
	
	IFF(NUMBER_OF_ADDRESSES = 1, True, False)  AS SINGLE_ADDRESS_FLAG	,
	'LineItemLevel' AS ORDER_TAX_CALCULATION	,
	True AS ORDER_TRANSACTION_FEE	,
	sum(IFF(p.type IN ('productCardSingle', 'standardGift', 'personalizedGift', 'gift_addon') OR lower(p.productcode) LIKE '%envelop%', 1, 0))  AS ITEMS_IN_ORDER	,						
	o.currencycode AS ORDER_CURRENCYCODE	,
	ex.avg_rate AS TO_GBP_RATE,
	ex_2.avg_rate AS MNTH_GBP_TO_EUR_RATE,
	abs(sum(IFF(p.type != 'shipment', ol.DISCOUNTWITHOUTVAT, 0)))  AS PRODUCT_DISCOUNT_EX_TAX	,
	abs(sum(IFF(p.type != 'shipment', ol.DISCOUNTWITHVAT - ol.DISCOUNTWITHOUTVAT, 0)))  AS PRODUCT_DISCOUNT_TAX	,
	abs(sum(IFF(p.type != 'shipment', ol.DISCOUNTWITHVAT, 0)))  AS PRODUCT_DISCOUNT_INC_TAX	,
	abs(sum(IFF(p.type = 'shipment', ol.DISCOUNTWITHOUTVAT, 0)))  AS POSTAGE_DISCOUNT_EX_TAX	,
	abs(sum(IFF(p.type = 'shipment', ol.DISCOUNTWITHVAT - ol.DISCOUNTWITHOUTVAT, 0)))  AS POSTAGE_DISCOUNT_TAX	,
	abs(sum(IFF(p.type = 'shipment', ol.DISCOUNTWITHVAT, 0)))  AS POSTAGE_DISCOUNT_INC_TAX	,
	
	PRODUCT_DISCOUNT_EX_TAX * ex.avg_rate  AS PRODUCT_DISCOUNT_EX_TAX_GBP	,
	PRODUCT_DISCOUNT_TAX * ex.avg_rate  AS PRODUCT_DISCOUNT_TAX_GBP	,
	PRODUCT_DISCOUNT_INC_TAX * ex.avg_rate  AS PRODUCT_DISCOUNT_INC_TAX_GBP	,
	POSTAGE_DISCOUNT_EX_TAX * ex.avg_rate  AS POSTAGE_DISCOUNT_EX_TAX_GBP	,
	POSTAGE_DISCOUNT_TAX * ex.avg_rate  AS POSTAGE_DISCOUNT_TAX_GBP	,
	POSTAGE_DISCOUNT_INC_TAX * ex.avg_rate  AS POSTAGE_DISCOUNT_INC_TAX_GBP	,
	sum(IFF(p.type != 'shipment', cast(ol.totalwithvat/ol.productamount as DECIMAL(10,2)), 0)) AS	PRODUCT_UNIT_PRICE	,					-- to do later
	
	sum(IFF(p.type != 'shipment', ol.TOTALWITHOUTVAT * IFNULL(fee.KICK_BACK_FEE, 1), 0)) AS ORDER_ESEV	,
	sum(IFF(p.type IN ('productCardSingle', 'standardGift', 'personalizedGift', 'gift_addon') OR lower(p.productcode) LIKE '%envelop%', ol.productamount, 0))  AS total_amount,
	IFNULL(ig.postage_unit_price, 0)  AS POSTAGE_UNIT_PRICE	, 		
	abs(sum(IFF(p.type = 'shipment', ol.TOTALWITHOUTVAT, 0)))  AS POSTAGE_EX_TAX	,
	-- PRODUCT_LINE_TAX = PRODUCT_TOTAL_TAX + PRODUCT_DISCOUNT_TAX
	sum(IFF(p.type != 'shipment', ol.TOTALWITHVAT - ol.TOTALWITHOUTVAT + abs(ol.DISCOUNTWITHVAT - ol.DISCOUNTWITHOUTVAT), 0))  AS PRODUCT_LINE_TAX	,
	sum(IFF(p.type != 'shipment', ol.TOTALWITHVAT - ol.TOTALWITHOUTVAT, 0)) AS PRODUCT_TOTAL_TAX	,
	sum(IFF(p.type != 'shipment', ol.TOTALWITHVAT * IFNULL(fee.KICK_BACK_FEE, 1), 0)) AS ORDER_ESIV	,
	-- POSTAGE_LINE_TAX = POSTAGE_TOTAL_TAX + POSTAGE_DISCOUNT_TAX
	sum(IFF(p.type = 'shipment', ol.TOTALWITHVAT - ol.TOTALWITHOUTVAT + abs(ol.DISCOUNTWITHVAT - ol.DISCOUNTWITHOUTVAT), 0)) AS POSTAGE_LINE_TAX	,
	sum(IFF(p.type = 'shipment', ol.TOTALWITHVAT - ol.TOTALWITHOUTVAT, 0)) AS POSTAGE_TOTAL_TAX	,
	-- POSTAGE_SUBTOTAL = POSTAGE_EX_TAX + POSTAGE_TOTAL_TAX
	sum(IFF(p.type = 'shipment', /*ol.TOTALWITHOUTVAT +*/ ol.TOTALWITHVAT /*- ol.TOTALWITHOUTVAT*/, 0)) AS POSTAGE_SUBTOTAL	,
	sum(ol.TOTALWITHOUTVAT * IFNULL(fee.KICK_BACK_FEE, 1)) AS ORDER_ISEV	,
	abs(sum(ol.DISCOUNTWITHVAT)) AS TOTAL_DISCOUNT	,
	sum(ol.TOTALWITHVAT - ol.TOTALWITHOUTVAT) AS TOTAL_TAX	,
	sum(ol.TOTALWITHVAT * IFNULL(fee.KICK_BACK_FEE, 1)) AS ORDER_ISIV	,
	sum(ol.TOTALWITHVAT) AS ORDER_CASH_PAID	,		
	PRODUCT_UNIT_PRICE * ex.avg_rate  AS PRODUCT_UNIT_PRICE_GBP	,
	ORDER_ESEV * ex.avg_rate  AS ORDER_ESEV_GBP	,
	POSTAGE_UNIT_PRICE * ex.avg_rate  AS POSTAGE_UNIT_PRICE_GBP	,
	POSTAGE_EX_TAX * ex.avg_rate  AS POSTAGE_EX_TAX_GBP	,
	PRODUCT_LINE_TAX * ex.avg_rate  AS PRODUCT_LINE_TAX_GBP	,
	PRODUCT_TOTAL_TAX * ex.avg_rate  AS PRODUCT_TOTAL_TAX_GBP	,
	ORDER_ESIV * ex.avg_rate  AS ORDER_ESIV_GBP	,
	POSTAGE_LINE_TAX * ex.avg_rate  AS POSTAGE_LINE_TAX_GBP	,
	POSTAGE_TOTAL_TAX * ex.avg_rate  AS POSTAGE_TOTAL_TAX_GBP	,
	POSTAGE_SUBTOTAL * ex.avg_rate  AS POSTAGE_SUBTOTAL_GBP	,
	ORDER_ISEV * ex.avg_rate  AS ORDER_ISEV_GBP	,
	TOTAL_DISCOUNT * ex.avg_rate  AS TOTAL_DISCOUNT_GBP	,
	TOTAL_TAX * ex.avg_rate  AS TOTAL_TAX_GBP	,
	ORDER_ISIV * ex.avg_rate  AS ORDER_ISIV_GBP	,
	ORDER_CASH_PAID * ex.avg_rate  AS ORDER_CASH_PAID_GBP	,
	ORDER_ISEV - IFNULL(sum(IFF(oce.subcell != 'SHIPMENT', oce.purchasecost - oce.externalcontentcost - oce.othermaterialcost - oce.directlaborcost - oce.packagingcost, 0)), 0) AS GROSS_PRODUCT_MARGIN	,
	POSTAGE_EX_TAX - IFNULL(sum(IFF(oce.subcell = 'SHIPMENT', oce.purchasecost - oce.externalcontentcost - oce.othermaterialcost - oce.directlaborcost - oce.packagingcost, 0)), 0) AS GROSS_SHIPPING_MARGIN	,
	ORDER_ISEV - IFNULL(sum(oce.purchasecost - oce.externalcontentcost - oce.othermaterialcost - oce.directlaborcost - oce.packagingcost), 0) AS TOTAL_GROSS_MARGIN	,	
	ORDER_ESEV - IFNULL(sum(IFF(oce.subcell != 'SHIPMENT', oce.purchasecost, 0)), 0) AS COMMERCIAL_PRODUCT_MARGIN	,
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
	SUM(IFF(IFNULL(fee.KICK_BACK_FEE, 0) = 0, 0, ol.totalwithvat  - (ol.totalwithvat * fee.KICK_BACK_FEE * ol.productamount)))  AS DIFF_TOTAL_GROSS,
		
	DIFF_TOTAL_GROSS  AS DIFF_PRODUCT_SUBTOTAL	,					
	0  AS DIFF_POSTAGE_SUBTOTAL	,
	
	SUM(IFF(p.TYPE = 'productCardSingle' OR p.productcode LIKE 'card%', ol.productamount, 0))  AS cards,
	SUM(IFF(p.TYPE IN ('standardGift', 'personalizedGift') AND pt.MPTypeCode != 'flower', ol.productamount, 0))  AS gifts,
	SUM(IFF(pt.MPTypeCode = 'flower', ol.productamount, 0))  AS flowers,
--	SUM(IFF(p.TYPE = 'productCardSingle' OR p.productcode LIKE 'card%', 1, 0))  AS cards_distinct,
	
	IFF(cards > 0, True, False)  AS IS_CARD_ORDER	,
	IFF(gifts > 0, True, False)  AS IS_GIFT_ORDER	,
	IFF(flowers > 0, True, False)  AS IS_FLOWER_ORDER	,
	
	SUM(IFF((p.TYPE = 'productCardSingle' OR p.productcode LIKE 'card%')
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
	sum(IFF((cd.CONTENTTYPE IN ('PHOTO_TEMPLATE','PHOTO_SELF') OR p.TYPE = 'personalizedGift') AND (p.type IN ('productCardSingle', 'standardGift', 'personalizedGift', 'gift_addon') OR lower(p.productcode) LIKE '%envelop%'), 1, 0))  AS HIGH_EFFORT_ITEMS	,
	total_amount - HIGH_EFFORT_ITEMS  AS LOW_EFFORT_ITEMS	,	
	sum(IFF((p.TYPE = 'productCardSingle' OR p.productcode LIKE 'card%') AND cd.CONTENTTYPE IN ('PHOTO_TEMPLATE','PHOTO_SELF'), 1, 0))  AS HIGH_EFFORT_CARD_ITEMS	,
	cards - HIGH_EFFORT_CARD_ITEMS  AS LOW_EFFORT_CARD_ITEMS	,
	IFF(HIGH_EFFORT_ITEMS > 0, True, False)  AS IS_PHOTO_UPLOAD_ORDER	,
	IFF(IS_PHOTO_UPLOAD_ORDER = True, False, True)  AS IS_LOW_EFFORT_ORDER	,
	IS_PHOTO_UPLOAD_ORDER  AS IS_HIGH_EFFORT_ORDER	,
	IFF(HIGH_EFFORT_CARD_ITEMS > 0, False, True)  AS IS_LOW_EFFORT_CARD_ORDER	,
	IFF(HIGH_EFFORT_CARD_ITEMS > 0, True, False)  AS IS_HIGH_EFFORT_CARD_ORDER	,
	
	IFF(toself_count > 0 AND not_toself_count = 0, True, False)  AS IS_CUSTOMER_ADDRESS_TYPE_ORDER_ONLY	,
	IFF(toself_count = 0 AND not_toself_count > 0, True, False)  AS IS_DIRECT_ADDRESS_TYPE_ORDER_ONLY	,
	False  AS IS_EMAIL_ADDRESS_TYPE_ORDER_ONLY	,
	IFF(toself_count > 0  AND not_toself_count > 0, True, False)  AS IS_SPLIT_ADDRESS_TYPE_ORDER	,
	False  AS IS_SPLIT_EMAIL_ADDRESS_TYPE_ORDER	,
	cards  AS CARD_QUANTITY	,
	gifts  AS GIFT_QUANTITY,
	flowers  AS FLOWER_QUANTITY,
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
	
	SUM(IFF((p.TYPE = 'productCardSingle' OR p.productcode LIKE 'card%') 
		AND 
		(
		 lower(p.productcode) like '%xl%' 
		 OR lower(p.productcode)  like '%supersize%'
		 )
	   , ol.productamount, 0)) AS GIANT_CARD_QUANTITY	,
	
	SUM(IFF((p.TYPE = 'productCardSingle' OR p.productcode LIKE 'card%') 
		AND 
		(
		 lower(p.productcode) like '%large%' 
		 AND cd.cardratio = 'STANDARD'
		 )
	   , ol.productamount, 0)) AS LARGE_CARD_QUANTITY	,
	
	SUM(IFF((p.TYPE = 'productCardSingle' OR p.productcode LIKE 'card%') 
		AND 
		(
		 lower(p.productcode) like '%large%' 
		 AND cd.cardratio = 'SQUARE'
		 )
	   , ol.productamount, 0)) AS LARGE_SQUARE_CARD_QUANTITY	,
	
	SUM(IFF((p.TYPE = 'productCardSingle' OR p.productcode LIKE 'card%')  
		AND 
		(
		 lower(p.productcode) like '%medium%' 
		 AND cd.cardratio = 'SQUARE'
		 )
	   , ol.productamount, 0)) AS STANDARD_SQUARE_CARD_QUANTITY	,
	
	SUM(IFF((p.TYPE = 'productCardSingle' OR p.productcode LIKE 'card%') 
		AND 
		(
		 lower(p.productcode) like '%medium%' 
		 AND cd.cardratio = 'STANDARD'
		 )
	   , ol.productamount, 0)) AS STANDARD_CARD_QUANTITY	,
	
	SUM(IFF((p.TYPE = 'productCardSingle' OR p.productcode LIKE 'card%') AND cd.NUMBEROFPANELS = 1, ol.productamount, 0))  AS POSTCARD_QUANTITY,
	GIFT_QUANTITY + FLOWER_QUANTITY  AS NON_CARD_VOLUME,
			
	IFNULL(ig.cards_ISEV, 0) * ex.avg_rate  AS CARD_ITEMS_ISEV_GBP,
	IFNULL(ig.gifts_ISEV, 0) * ex.avg_rate  AS GIFT_ITEMS_ISEV_GBP	,
	IFNULL(ig.flowers_ISEV, 0) * ex.avg_rate  AS FLOWER_ITEMS_ISEV_GBP	,
	
	IFNULL(ig.gifts_ISEV, 0) + IFNULL(ig.flowers_ISEV, 0)  AS NON_CARD_SALES	,
	
	COUNT(DISTINCT c.carddefinition)  AS CARD_DISTINCT_PRODUCTS	,
	IFF(CARD_DISTINCT_PRODUCTS > 1, 'Multi SKU', 'Single SKU')  AS MULTI_CARD_SKU_ORDER	,
	IFF(CARD_DISTINCT_PRODUCTS > 1, CARD_DISTINCT_PRODUCTS, 0)  AS MULTI_CARD_VOLUME,
	IFF(CARD_DISTINCT_PRODUCTS > 1, IFNULL(ig.cards_ISEV, 0), 0)  AS 	MULTI_CARD_SALES	,
	IFF(IS_CARD_ONLY_ORDER = True, CARD_QUANTITY, 0)  AS CARD_ONLY_VOLUME	,
	IFF(IS_CARD_ONLY_ORDER = True, IFNULL(ig.cards_ISEV, 0), 0)  AS CARD_ONLY_SALES	,
	IFF(IS_GIFT_ONLY_ORDER = True, GIFT_QUANTITY, 0)  AS GIFT_ONLY_VOLUME	,	
	IFF(IS_GIFT_ONLY_ORDER = True, IFNULL(ig.gifts_ISEV, 0), 0)  AS GIFT_ONLY_SALES	,
	IFF(IS_FLOWER_ONLY_ORDER = True, FLOWER_QUANTITY, 0)  AS FLOWER_ONLY_VOLUME	,	
	IFF(IS_FLOWER_ONLY_ORDER = True, IFNULL(ig.flowers_ISEV, 0), 0)  AS FLOWER_ONLY_SALES	,
	IFF(IS_ATTACH_ORDER = True, total_amount /*CARD_QUANTITY + GIFT_QUANTITY + FLOWER_QUANTITY*/, 0)  AS ATTACH_VOLUME_TOTAL_ITEMS	,
	IFF(IS_ATTACH_ORDER = True, ORDER_ISEV, 0)  AS ATTACH_SALES_TOTAL_ITEMS	,	
	IFF(IS_ATTACH_ORDER = True, GIFT_QUANTITY + FLOWER_QUANTITY, 0)  AS ATTACH_VOLUME_ATTACHED_ITEMS	,
	IFF(IS_ATTACH_ORDER = True, IFNULL(ig.gifts_ISEV, 0) + IFNULL(ig.flowers_ISEV, 0), 0)  AS ATTACH_SALES_ATTACHED_ITEMS	,
	IFF(IS_ATTACH_ORDER = True, CARD_QUANTITY, 0)  AS CARD_ATTACH_VOLUME_CARD_ITEMS	,
	IFF(IS_ATTACH_ORDER = True, IFNULL(ig.cards_ISEV, 0), 0)  AS CARD_ATTACH_SALES_CARD_ITEMS	,
	
	IFF(IS_GIFT_ATTACH_ORDER = True, total_amount /*CARD_QUANTITY + GIFT_QUANTITY + FLOWER_QUANTITY*/, 0)  AS GIFT_ATTACH_VOLUME_TOTAL_ITEMS	,
	IFF(IS_GIFT_ATTACH_ORDER = True, ORDER_ISEV, 0)  AS GIFT_ATTACH_SALES_TOTAL_ITEMS	,
	IFF(IS_GIFT_ATTACH_ORDER = True, GIFT_QUANTITY, 0)  AS GIFT_ATTACH_VOLUME_GIFT_ITEMS	,
	IFF(IS_GIFT_ATTACH_ORDER = True, IFNULL(ig.gifts_ISEV, 0), 0)  AS GIFT_ATTACH_SALES_GIFT_ITEMS	,

	IFF(IS_FLOWER_ATTACH_ORDER = True, total_amount /*CARD_QUANTITY + GIFT_QUANTITY + FLOWER_QUANTITY*/, 0)  AS FLOWER_ATTACH_VOLUME_TOTAL_ITEMS	,
	IFF(IS_FLOWER_ATTACH_ORDER = True, ORDER_ISEV, 0)  AS FLOWER_ATTACH_SALES_TOTAL_ITEMS	,
	IFF(IS_FLOWER_ATTACH_ORDER = True, FLOWER_QUANTITY, 0)  AS FLOWER_ATTACH_VOLUME_FLOWER_ITEMS	,
	IFF(IS_FLOWER_ATTACH_ORDER = True, IFNULL(ig.flowers_ISEV, 0), 0)  AS FLOWER_ATTACH_SALES_FLOWER_ITEMS	,
	
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
--	 (SELECT * FROM "RAW_GREETZ"."GREETZ3".orders WHERE created > '2022-06-01' ORDER BY created LIMIT 1000) o
-- 	 (SELECT * FROM "RAW_GREETZ"."GREETZ3".orders WHERE id = 1266779435 /*1323191458 1347309071 1336681263*/) o
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
	LEFT JOIN "RAW_GREETZ"."GREETZ3".product AS p
		ON ol.productid = p.ID
	LEFT JOIN "RAW_GREETZ"."GREETZ3".productgift pg 
		ON p.ID = pg.PRODUCTID
    LEFT JOIN "RAW_GREETZ"."GREETZ3".greetz_to_mnpg_product_types_view pt  
		ON pt.GreetzTypeID = IFNULL(pg.productgiftcategoryid, pg.productgifttypeid) 
	LEFT JOIN "RAW_GREETZ"."GREETZ3".individualshipping AS isp
       ON ol.individualshippingid = isp.id	
	LEFT JOIN "RAW_GREETZ"."GREETZ3".recipient AS r
       ON isp.recipientid = r.id
	LEFT JOIN "RAW_GREETZ"."GREETZ3".address AS a2
	   ON o.customerid = a2.customerid 
		  AND a2.DEFAULTADDRESS = 'Y'
	LEFT JOIN "RAW_GREETZ"."GREETZ3".ordercost AS oc
		ON o.ordercostid = oc.ID
	LEFT JOIN "RAW_GREETZ"."GREETZ3".ordercostentry AS oce
		ON oce.ordercostid = oc.ID
			AND oce.orderlineid = ol.ID
	LEFT JOIN cte_ISEV_groupped AS ig
		ON o.id = ig.orderid
	LEFT JOIN cte_Fee AS fee   
		ON ol.ID = fee.OrderLineID
	LEFT JOIN "RAW_GREETZ"."GREETZ3".referrer AS rr
		ON o.referrerid = rr.ID
	LEFT JOIN "RAW_GREETZ"."GREETZ3".customersessioninfo AS s
		ON c.customersessioninfo = s.ID
WHERE		
	   o.channelid = 2
	   AND o.currentorderstate IN
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
		   'REFUNDED_CANCELLEDCARD_WALLET')

GROUP BY 
	o.ID, 
	o.CREATED, o.CUSTOMERID, o.ORDERCODE, o.CURRENTORDERSTATE, o.CURRENCYCODE, ex.AVG_RATE, ex_2.AVG_RATE, ig.cards_ISEV, ig.POSTAGE_UNIT_PRICE,
	ig.gifts_ISEV, ig.flowers_ISEV
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
)
-- CREATE OR REPLACE TABLE "PROD"."WORKSPACE_GREETZ_HISTORY_MIGRATION"."RAW_GREETZ_CT_ORDER_ITEMS_DETAILED_BACKFILL" AS (
WITH
cte_INDIVIDUALSHIPPING
 AS
 (
 SELECT 	
		ol.INDIVIDUALSHIPPINGID,
		SUM(IFF(p.PRODUCTCODE != 'shipment_generic', ol.PRODUCTAMOUNT, 0))  AS product_amount,
		SUM(IFF(p.PRODUCTCODE = 'shipment_generic', ol.TOTALWITHOUTVAT, 0))  AS postage_cost_wOutVat,
		SUM(IFF(p.PRODUCTCODE = 'shipment_generic', ol.TOTALWITHVAT, 0))  AS postage_cost_wVat,
		SUM(IFF(p.PRODUCTCODE = 'shipment_generic', ol.discountwithoutvat, 0))  AS postage_discount_wOutVat,
		SUM(IFF(p.PRODUCTCODE = 'shipment_generic', ol.discountwithvat, 0))  AS postage_discount_wVat
									
 FROM "RAW_GREETZ"."GREETZ3".orders o
	INNER JOIN "RAW_GREETZ"."GREETZ3".orderline ol ON o.ID = ol.ORDERID
    INNER JOIN "RAW_GREETZ"."GREETZ3".product p ON ol.PRODUCTID = p.ID
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
		AND (p.TYPE IN ('shipment_generic', 'productCardSingle', 'standardGift', 'personalizedGift')  OR  p.productcode LIKE 'card%')
 GROUP BY   
		ol.INDIVIDUALSHIPPINGID
 ),
  
cte_content_0
AS
(
SELECT ol.orderid, 
	 ol.PRODUCTITEMINBASKETID,
	 ol.productId,
	 AVG(totalwithvat) AS totalwithvat
FROM orders o
	JOIN orderline ol ON o.id = ol.orderid
	JOIN product pn ON pn.id = ol.productid
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
     AND pn.type = 'content'  
	 AND ol.PRODUCTITEMINBASKETID IS NOT NULL
GROUP BY ol.orderid, ol.PRODUCTITEMINBASKETID, ol.productId
), 
 
 cte_content AS
(
SELECT orderid, PRODUCTITEMINBASKETID, sum(totalwithvat) AS totalwithvat
FROM cte_content_0
GROUP BY orderid, PRODUCTITEMINBASKETID
)

SELECT 
	o.ID AS ORDER_ID,
	ol.ID  AS ORDER_LINE_ITEM_ID,
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
	END 
	AS	PLATFORM	,										
	
	concat('LEGO-', o.ORDERCODE) AS	ORDER_NUMBER	,
	'Confirmed'  AS ITEM_STATE	,
		
	case 
		when not_toself_count > 0 AND toself_count = 0 then 'DIRECT'
		when not_toself_count = 0 AND toself_count > 0 then 'CUSTOMER'
		when not_toself_count > 0 AND toself_count > 0 then 'SPLIT'
	end 	AS ORDER_ADDRESS_TYPE	,
	
	IFF(isp.CANCELLATIONTYPE IS NOT NULL, True, False)  AS IS_ITEM_CANCELLED,
	IFF(IS_ITEM_CANCELLED = True, SHIPMENTLASTUPDATED, NULL)  AS ITEM_CANCELLED_DATE,
	
	'LineItemLevel' AS ORDER_TAX_CALCULATION	,
	True AS ORDER_TRANSACTION_FEE	,
	o.currencycode AS LI_CURRENCYCODE	,
	ex.avg_rate AS TO_GBP_RATE,
	ex_2.avg_rate AS TO_EUR_RATE,
	ex_2.avg_rate AS TO_USD_RATE,
	
	CASE LI_CURRENCYCODE 
		WHEN 'EUR' THEN 'NL' 
		WHEN 'GBP' THEN 'GB' 
		WHEN 'USD' THEN 'US' 
	END  AS LI_TAX_COUNTRY,
	
	0  AS LI_TAX_AMOUNT,
	True  AS TAX_INCLUDED_IN_SUBTOTAL,
	'Default'  AS CT_TAX_NAME,
	'Paid'  AS PAYMENT_STATE,

	IFNULL(r.addressid, a2.id)  AS ADDRESS_ID,
	IFF(ol.packettoselfid IS NULL, 'to_them', 'to_me')  AS RECIPIENT_TYPE,
	
	IFF(RECIPIENT_TYPE = 'to_them', 'Send Direct Address', 'Customer Address')  AS ADDRESS_TYPE,	
	UPPER(REGEXP_SUBSTR(IFNULL(a.zippostalcode, a2.zippostalcode), '(^[a-zA-Z]+\\d\\d?[a-zA-Z]?)'))  AS DELIVERY_DISTRICT,
	UPPER(REGEXP_SUBSTR(IFNULL(a.zippostalcode, a2.zippostalcode), '(^[a-zA-Z][a-zA-Z]?)'))  AS DELIVERY_POSTAL_AREA,
	IFNULL(a.CITY, a2.CITY)  AS DELIVERY_CITY,
	IFNULL(a.stateprovincecounty, a2.stateprovincecounty)  AS ADDRESS_COUNTY,	
	IFNULL(a.countrycode, a2.countrycode)  AS DELIVERY_COUNTRY_CODE,
	ps.CLASSNAME  AS DELIVERY_METHOD,
	ps.postalcompany  AS DELIVERY_METHOD_ID,
	IFNULL(cn.ENGLISHCOUNTRYNAME, cn2.ENGLISHCOUNTRYNAME)  AS DELIVERY_COUNTRY,
	
	NULL  AS ROYAL_MAIL_AREA,
	NULL  AS ROYAL_MAIL_DISTRIBUTION_CENTRE,
	False  AS IS_MESSAGE_CARD,
	'Ready'  AS SHIPMENT_STATE,
	dp_EXPECTED.pickupdate  AS ESTIMATED_DESPATCH_DATE_ORDER,
	'Amsterdam'  AS PRINTSITE,
	'Amsterdam'  AS PRINTSITE_COUNTRY,
	CONCAT('GAP_Individual_shipping_id_', isp.id)  AS CONSIGNMENT_ID,
	'Greetz backfill'  AS CONSIGNMENT_SOURCE,
	NULL  AS CONSIGNMENT_ACCEPTED_DATETIME,
	NULL  AS CONSIGNMENT_PREPARED_DATETIME,
	ESTIMATED_DESPATCH_DATE_CONSIGNMENT = ESTIMATED_DESPATCH_DATE_ORDER,
	ESTIMATED_DESPATCH_DATE = ESTIMATED_DESPATCH_DATE_ORDER,
	NULL  AS PROPOSED_DELIVERY_DATE,
	NULL  AS CONSIGNMENT_SENT_DATETIME,
	NULL  AS CONSIGNMENT_ACKNOWLEDGED_DATETIME,
	NULL  AS FULFILMENT_CENTRE_RECEIVED_DATETIME,
	NULL  AS FULFILMENT_CENTRE_RECEIVED_DATE,
	dp_ACTUAL.pickupdate  AS ACTUAL_DESPATCH_DATETIME,
	CAST(dp_ACTUAL.pickupdate AS date)  AS ACTUAL_DESPATCH_DATE
	ACTUAL_DESPATCH_DATETIME  AS DESPATCH_DATETIME,
	ACTUAL_DESPATCH_DATE  AS DESPATCH_DATE,
	'NL-GRTZ-AMS'  AS FULFILMENT_CENTRE_ID,
	'NL'  AS FULFILMENT_CENTRE_COUNTRY_CODE,
	isp.trackandtracecode  AS TRACKING_CODE,
	NULL  AS DESPATCH_CARRIER,
	IFF(p.PRODUCTCODE != 'shipment_generic', ol.withvat, NULL)  AS LI_TOTAL_GROSS,
	IFF(p.PRODUCTCODE != 'shipment_generic', ol.totalwithvat, NULL)  AS LI_TOTAL_NET,
	LI_TOTAL_GROSS  AS LI_TOTAL_AMOUNT,
	ol.productamount * c_isp.postage_cost_wVat / c_isp.product_amount   AS POSTAGE_AMOUNT_INC_TAX_AFTER_DISCOUNT,
	IFF(ol.discountwithvat = 0 AND ol.discountwithoutvat = 0, False, True)  AS HAS_DISCOUNT,
	ol.discountwithoutvat  AS PRODUCT_DISCOUNT,
	ol.productamount * c_isp.postage_discount_wOutVat / c_isp.product_amount  AS POSTAGE_DISCOUNT,
	False  AS IS_EXISTING_MEMBERSHIP_ORDER,
	NULL  AS PRICE_MINUS_DISCOUNT_AMOUNT,
	ORDER_DATE  AS AVA_ORDER_DATE,
	totalwithvat - totalwithoutvat  AS AVA_PRODUCT_TAX, 
	NULL  AS TAX_CODE,
	NULL  AS TAX_CODE_ID,
	NULL  AS LINE_NUMBER,
	NULL  AS POSTAGE_GROUPING,
	ol.productamount * c_isp.postage_cost_wOutVat / c_isp.product_amount  AS AVA_POSTAGE,
	ol.productamount * (c_isp.postage_cost_wOutVat - c_isp.postage_cost_wOutVat) / c_isp.product_amount  AS AVA_POSTAGE_TAX,
	'NL'  AS TAX_COUNTRY,
	'NL'  AS TAX_REGION,
	ol.withoutvat  AS AVA_LINE_AMOUNT,
	
	CASE 
		WHEN ol.VATPERCENTAGE IN (19, 21) THEN 'Standard Rate'
		WHEN ol.VATPERCENTAGE = 0 THEN 'Zero Rate'
		ELSE 'Reduced R'
	END  AS TAX_NAME,

	ol.VATPERCENTAGE / 100  AS TAX_RATE,
	NULL  AS DISCOUNT_CODES,
	NULL  AS CUSTOM_LINE_ITEMS,
	NULL  AS TAX_GROUPING,

	CASE 
		WHEN ol.VATPERCENTAGE IN (19, 21) THEN 'STANDARD'
		WHEN ol.VATPERCENTAGE = 0 THEN 'ZERO RATED'
		ELSE 'REDUCED R'
	END  AS TAX_TYPE,
	
	ol.discountwithvat  AS PRODUCT_DISCOUNT_INC_TAX,
	ol.discountwithoutvat  AS PRODUCT_DISCOUNT_EX_TAX,
	ol.discountwithvat - ol.discountwithoutvat  AS PRODUCT_DISCOUNT_TAX,
	
	ol.productamount * c_isp.postage_discount_wVat / c_isp.product_amount  AS POSTAGE_DISCOUNT_INC_TAX,
	ol.productamount * c_isp.postage_discount_wOutVat / c_isp.product_amount  AS POSTAGE_DISCOUNT_EX_TAX,
	ol.productamount * (c_isp.postage_discount_wVat - c_isp.postage_discount_wOutVat) / c_isp.product_amount  AS POSTAGE_DISCOUNT_TAX,

	PRODUCT_DISCOUNT_INC_TAX * ex.avg_rate  AS PRODUCT_DISCOUNT_INC_TAX_GBP,
	PRODUCT_DISCOUNT_EX_TAX * ex.avg_rate  AS PRODUCT_DISCOUNT_EX_TAX_GBP,
	PRODUCT_DISCOUNT_TAX * ex.avg_rate  AS PRODUCT_DISCOUNT_TAX_GBP,
	POSTAGE_DISCOUNT_INC_TAX * ex.avg_rate  AS POSTAGE_DISCOUNT_INC_TAX_GBP,
	POSTAGE_DISCOUNT_EX_TAX * ex.avg_rate  AS POSTAGE_DISCOUNT_EX_TAX_GBP,
	POSTAGE_DISCOUNT_TAX * ex.avg_rate  AS POSTAGE_DISCOUNT_TAX_GBP,

	IFNULL(fee.KICK_BACK_FEE, 1)  AS COMMISSION_MARGIN,
	(ol.totalwithvat + IFNULL(co.totalwithvat, 0)) / ol.productamount AS PRODUCT_UNIT_PRICE,
	ol.TOTALWITHOUTVAT * IFNULL(fee.KICK_BACK_FEE, 1)  AS ITEM_ESEV,
	c_isp.postage_cost_wVat / c_isp.product_amount  AS POSTAGE_UNIT_PRICE,
	ol.productamount * c_isp.postage_cost_wOutVat / c_isp.product_amount  AS POSTAGE_EX_TAX,
ol.TOTALWITHVAT - ol.TOTALWITHOUTVAT + abs(ol.DISCOUNTWITHVAT - ol.DISCOUNTWITHOUTVAT), 0))  AS PRODUCT_LINE_TAX,
ol.TOTALWITHVAT - ol.TOTALWITHOUTVAT  AS PRODUCT_TOTAL_TAX,
ol.TOTALWITHVAT * IFNULL(fee.KICK_BACK_FEE, 1)  AS ITEM_ESIV,
ol.productamount * (c_isp.postage_cost_wVat - c_isp.postage_cost_wVat + abs(c_isp.postage_discount_wVat - c_isp.postage_discount_wOutVat)) / c_isp.product_amount  AS POSTAGE_LINE_TAX,
ol.productamount * (c_isp.postage_cost_wVat - c_isp.postage_cost_wVat) / c_isp.product_amount  AS POSTAGE_TOTAL_TAX,
ol.productamount * c_isp.postage_cost_wVat / c_isp.product_amount  AS POSTAGE_SUBTOTAL,
ol.TOTALWITHOUTVAT * IFNULL(fee.KICK_BACK_FEE, 1) + ol.productamount * c_isp.postage_cost_wOutVat / c_isp.product_amount  AS ITEM_ISEV,
ol.DISCOUNTWITHVAT + ol.productamount * c_isp.postage_discount_wVat / c_isp.product_amount  AS TOTAL_DISCOUNT,
ol.TOTALWITHVAT - ol.TOTALWITHOUTVAT + ol.productamount * (c_isp.postage_cost_wVat - c_isp.postage_cost_wOutVat) / c_isp.product_amount   AS TOTAL_TAX,
ol.TOTALWITHVAT + ol.productamount * c_isp.postage_cost_wVat / c_isp.product_amount  AS ITEM_ISIV,
o_st.ORDER_ISIV  AS ORDER_ISIV,
ORDER_ISIV  AS EVE_ORDER_TOTAL_GROSS	,
ORDER_ISIV - EVE_ORDER_TOTAL_GROSS  AS DIFF,	-- ??  = 0
IFF(DIFF > 0.02, TRUE, FALSE)  AS LARGE_DIFF,
PRODUCT_UNIT_PRICE * ex.avg_rate  AS PRODUCT_UNIT_PRICE_GBP,
ITEM_ESEV * ex.avg_rate  AS ITEM_ESEV_GBP,
POSTAGE_UNIT_PRICE * ex.avg_rate  AS POSTAGE_UNIT_PRICE_GBP,
POSTAGE_EX_TAX * ex.avg_rate  AS POSTAGE_EX_TAX_GBP,
PRODUCT_LINE_TAX * ex.avg_rate  AS PRODUCT_LINE_TAX_GBP,
PRODUCT_TOTAL_TAX * ex.avg_rate  AS PRODUCT_TOTAL_TAX_GBP,
ITEM_ESIV * ex.avg_rate  AS ITEM_ESIV_GBP,
POSTAGE_LINE_TAX * ex.avg_rate  AS POSTAGE_LINE_TAX_GBP,
POSTAGE_TOTAL_TAX * ex.avg_rate  AS POSTAGE_TOTAL_TAX_GBP,
POSTAGE_SUBTOTAL * ex.avg_rate  AS POSTAGE_SUBTOTAL_GBP,
ITEM_ISEV * ex.avg_rate  AS ITEM_ISEV_GBP,
TOTAL_DISCOUNT * ex.avg_rate  AS TOTAL_DISCOUNT_GBP,
TOTAL_TAX * ex.avg_rate  AS TOTAL_TAX_GBP,
ITEM_ISIV * ex.avg_rate  AS ITEM_ISIV_GBP,
	
	
	
	abs(sum(IFF(p.productcode != 'shipment_generic', ol.DISCOUNTWITHOUTVAT, 0)))  AS PRODUCT_DISCOUNT_EX_TAX	,
	abs(sum(IFF(p.productcode != 'shipment_generic', ol.DISCOUNTWITHVAT - ol.DISCOUNTWITHOUTVAT, 0)))  AS PRODUCT_DISCOUNT_TAX	,
	abs(sum(IFF(p.productcode != 'shipment_generic', ol.DISCOUNTWITHVAT, 0)))  AS PRODUCT_DISCOUNT_INC_TAX	,
	abs(sum(IFF(p.productcode = 'shipment_generic', ol.DISCOUNTWITHOUTVAT, 0)))  AS POSTAGE_DISCOUNT_EX_TAX	,
	abs(sum(IFF(p.productcode = 'shipment_generic', ol.DISCOUNTWITHVAT - ol.DISCOUNTWITHOUTVAT, 0)))  AS POSTAGE_DISCOUNT_TAX	,
	abs(sum(IFF(p.productcode = 'shipment_generic', ol.DISCOUNTWITHVAT, 0)))  AS POSTAGE_DISCOUNT_INC_TAX	,
	
	PRODUCT_DISCOUNT_EX_TAX * ex.avg_rate  AS PRODUCT_DISCOUNT_EX_TAX_GBP	,
	PRODUCT_DISCOUNT_TAX * ex.avg_rate  AS PRODUCT_DISCOUNT_TAX_GBP	,
	PRODUCT_DISCOUNT_INC_TAX * ex.avg_rate  AS PRODUCT_DISCOUNT_INC_TAX_GBP	,
	POSTAGE_DISCOUNT_EX_TAX * ex.avg_rate  AS POSTAGE_DISCOUNT_EX_TAX_GBP	,
	POSTAGE_DISCOUNT_TAX * ex.avg_rate  AS POSTAGE_DISCOUNT_TAX_GBP	,
	POSTAGE_DISCOUNT_INC_TAX * ex.avg_rate  AS POSTAGE_DISCOUNT_INC_TAX_GBP	,
	sum(IFF(p.productcode != 'shipment_generic', cast(ol.totalwithvat/ol.productamount as DECIMAL(10,2)), 0)) AS	PRODUCT_UNIT_PRICE	,					-- to do later
	
	sum(IFF(p.productcode != 'shipment_generic', ol.TOTALWITHOUTVAT * IFNULL(fee.KICK_BACK_FEE, 1), 0)) AS ORDER_ESEV	,
	sum(IFF(p.type IN ('productCardSingle', 'standardGift', 'personalizedGift', 'gift_addon') OR lower(p.productcode) LIKE '%envelop%', ol.productamount, 0))  AS total_amount,
	IFNULL(ig.postage_unit_price, 0)  AS POSTAGE_UNIT_PRICE	, 		
	abs(sum(IFF(p.productcode = 'shipment_generic', ol.TOTALWITHOUTVAT, 0)))  AS POSTAGE_EX_TAX	,
	-- PRODUCT_LINE_TAX = PRODUCT_TOTAL_TAX + PRODUCT_DISCOUNT_TAX
	sum(IFF(p.productcode != 'shipment_generic', ol.TOTALWITHVAT - ol.TOTALWITHOUTVAT + abs(ol.DISCOUNTWITHVAT - ol.DISCOUNTWITHOUTVAT), 0))  AS PRODUCT_LINE_TAX	,
	sum(IFF(p.productcode != 'shipment_generic', ol.TOTALWITHVAT - ol.TOTALWITHOUTVAT, 0)) AS PRODUCT_TOTAL_TAX	,
	sum(IFF(p.productcode != 'shipment_generic', ol.TOTALWITHVAT * IFNULL(fee.KICK_BACK_FEE, 1), 0)) AS ORDER_ESIV	,
	-- POSTAGE_LINE_TAX = POSTAGE_TOTAL_TAX + POSTAGE_DISCOUNT_TAX
	sum(IFF(p.productcode = 'shipment_generic', ol.TOTALWITHVAT - ol.TOTALWITHOUTVAT + abs(ol.DISCOUNTWITHVAT - ol.DISCOUNTWITHOUTVAT), 0)) AS POSTAGE_LINE_TAX	,
	sum(IFF(p.productcode = 'shipment_generic', ol.TOTALWITHVAT - ol.TOTALWITHOUTVAT, 0)) AS POSTAGE_TOTAL_TAX	,
	-- POSTAGE_SUBTOTAL = POSTAGE_EX_TAX + POSTAGE_TOTAL_TAX
	sum(IFF(p.productcode = 'shipment_generic', /*ol.TOTALWITHOUTVAT +*/ ol.TOTALWITHVAT /*- ol.TOTALWITHOUTVAT*/, 0)) AS POSTAGE_SUBTOTAL	,
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
	SUM(IFF(IFNULL(fee.KICK_BACK_FEE, 0) = 0, 0, ol.totalwithvat  - (ol.totalwithvat * fee.KICK_BACK_FEE * ol.productamount)))  AS DIFF_TOTAL_GROSS
		
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
	INNER JOIN "PROD"."WORKSPACE_GREETZ_HISTORY_MIGRATION"."RAW_GREETZ_CT_ORDERS_STAGING_BACKFILL"  AS o_st
		ON o.ID = o_st.ORDER_ID
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
	LEFT JOIN PROD.dw_lookup.exchange_rate_history AS ex_3
		ON ex_3.month = concat(year(o.CREATED), iff(month(o.CREATED) < 10, '0',''), month(o.CREATED))
			AND ex_3.local_currency = 'GBP'
			AND ex_3.destination_currency = 'USD'	
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
	LEFT JOIN address a
       on r.addressid = a.id
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
	LEFT JOIN RAW_GREETZ.GREETZDWH.INTEGRATION_GiftCardsKickBackFeeDateInterval fee 
        ON ol.productid = fee.PRODUCT_ID
            AND (to_date(IFF(fee.DATE_START = 'NULL' OR fee.DATE_START IS NULL, '01-01-1990', fee.DATE_START), 'DD-MM-YYYY' ) < o.CREATED ) 
            AND (to_date(IFF(fee.DATE_END = 'NULL' OR fee.DATE_END IS NULL, '01-01-2030', fee.DATE_END), 'DD-MM-YYYY' ) + 1 > o.CREATED )
			AND NOT (fee.DATE_START = 'NULL' and fee.DATE_END = 'NULL')
	LEFT JOIN "RAW_GREETZ"."GREETZ3".productshipment AS ps
		ON ol.productid = ps.productid
	LEFT JOIN "RAW_GREETZ"."GREETZ3".country  AS cn
       ON a.countrycode = cn.TWOLETTERCOUNTRYCODE
	LEFT JOIN "RAW_GREETZ"."GREETZ3".country  AS cn2
       ON a.countrycode = cn2.TWOLETTERCOUNTRYCODE
	LEFT JOIN "RAW_GREETZ"."GREETZ3".deliverypromise AS dp_ACTUAL
	   ON isp.ffshipmentinformationid = dp_ACTUAL.id 
	LEFT JOIN "RAW_GREETZ"."GREETZ3".deliverypromise AS dp_EXPECTED
	   ON isp.shipmentinformationid = dp_EXPECTED.id 
	LEFT JOIN cte_INDIVIDUALSHIPPING c_isp
		ON ol.individualshippingid = c_isp.individualshippingid
	LEFT JOIN cte_content co
		ON co.id = ol.orderid
		   AND (p.type = 'productCardSingle'  OR  p.productcode LIKE 'card%')
		   AND ol.PRODUCTITEMINBASKETID = co.PRODUCTITEMINBASKETID

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
		AND (
			p.type IN ('productCardSingle', 'standardGift', 'personalizedGift', 'gift_addon') 			
			OR lower(p.productcode) LIKE '%envelop%'
			OR p.productcode LIKE 'card%'
			)
			
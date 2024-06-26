CREATE OR REPLACE TABLE "PROD"."WORKSPACE_GREETZ_HISTORY_MIGRATION"."RAW_GREETZ_CT_ORDER_ITEMS_DETAILED_BACKFILL" AS (

WITH
cte_INDIVIDUALSHIPPING
 AS
 (
 SELECT 
		ol.ORDERID,
		ol.INDIVIDUALSHIPPINGID,
		SUM(IFF(p.type NOT IN ('shipment', 'content'), ol.PRODUCTAMOUNT, 0))  AS product_amount,
		SUM(IFF(p.type = 'shipment', ol.TOTALWITHOUTVAT, 0))  AS postage_cost_wOutVat,
		SUM(IFF(p.type = 'shipment', ol.TOTALWITHVAT, 0))  AS postage_cost_wVat,
		SUM(IFF(p.type = 'shipment', ol.discountwithoutvat, 0))  AS postage_discount_wOutVat,
		SUM(IFF(p.type = 'shipment', ol.discountwithvat, 0))  AS postage_discount_wVat,
		SUM(IFF(p.type = 'shipment', IFNULL(oce.purchasecost - oce.externalcontentcost - oce.othermaterialcost - oce.directlaborcost - oce.packagingcost, 0), 0))  AS ordercostentry_shipment,
		SUM(IFNULL(oce.purchasecost - oce.externalcontentcost - oce.othermaterialcost - oce.directlaborcost - oce.packagingcost, 0))  AS ordercostentry_total,
		SUM(IFF(p.type = 'shipment', IFNULL(oce.purchasecost, 0), 0))  AS ordercostentry_shipment_purchasecost
		
 FROM "RAW_GREETZ"."GREETZ3".orders o
	INNER JOIN "RAW_GREETZ"."GREETZ3".orderline ol ON o.ID = ol.ORDERID
    INNER JOIN "RAW_GREETZ"."GREETZ3".product p ON ol.PRODUCTID = p.ID
	LEFT JOIN "RAW_GREETZ"."GREETZ3".ordercost AS oc
		ON o.ordercostid = oc.ID
	LEFT JOIN "RAW_GREETZ"."GREETZ3".ordercostentry AS oce
		ON oce.ordercostid = oc.ID
			AND oce.orderlineid = ol.ID
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
		
 GROUP BY   
		ol.ORDERID,
		ol.INDIVIDUALSHIPPINGID
 ),
  
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
    JOIN "RAW_GREETZ"."GREETZ3".orders o on e.order_id = o.id
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
    JOIN "RAW_GREETZ"."GREETZ3".orders o on e.order_id = o.id
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
    JOIN "RAW_GREETZ"."GREETZ3".orders o on e.order_id = o.id
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
    JOIN "RAW_GREETZ"."GREETZ3".orders o on e.order_id = o.id
	JOIN "RAW_GREETZ"."GREETZ3".orderline ol ON o.id = ol.orderid
	JOIN "RAW_GREETZ"."GREETZ3".product pn ON pn.id = ol.productid 
WHERE pn.type = 'productCardSingle'  OR  pn.productcode LIKE 'card%'  
),

cte_res AS
(
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
	when ol.packettoselfid IS NULL  then 'DIRECT'
	else 'CUSTOMER'
end 	AS ORDER_ADDRESS_TYPE	,

IFF(isp.CANCELLATIONTYPE IS NOT NULL, True, False)  AS IS_ITEM_CANCELLED,
IFF(IS_ITEM_CANCELLED = True, SHIPMENTLASTUPDATED, NULL)  AS ITEM_CANCELLED_DATE,

'LineItemLevel' AS ORDER_TAX_CALCULATION	,
True AS ORDER_TRANSACTION_FEE	,
o.currencycode AS LI_CURRENCYCODE	,
ex.avg_rate AS TO_GBP_RATE,
ex_2.avg_rate AS TO_EUR_RATE,
ex_2.avg_rate AS MNTH_GBP_TO_EUR_RATE,
ex_3.avg_rate AS TO_USD_RATE,

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
UPPER(REGEXP_SUBSTR(IFF(a.id IS NOT NULL, a.zippostalcode, a2.zippostalcode), '(^[a-zA-Z]+\\d\\d?[a-zA-Z]?)'))  AS DELIVERY_DISTRICT,
UPPER(REGEXP_SUBSTR(IFF(a.id IS NOT NULL, a.zippostalcode, a2.zippostalcode), '(^[a-zA-Z][a-zA-Z]?)'))  AS DELIVERY_POSTAL_AREA,
IFF(a.id IS NOT NULL, a.CITY, a2.CITY)  AS DELIVERY_CITY,
IFF(a.id IS NOT NULL, a.stateprovincecounty, a2.stateprovincecounty)  AS DELIVERY_COUNTY,	
IFF(a.id IS NOT NULL, a.countrycode, a2.countrycode)  AS DELIVERY_COUNTRY_CODE,
ps.CLASSNAME  AS DELIVERY_METHOD,
ps.postalcompany  AS DELIVERY_METHOD_ID,
IFF(a.id IS NOT NULL, cn.ENGLISHCOUNTRYNAME, cn2.ENGLISHCOUNTRYNAME)  AS DELIVERY_COUNTRY,
IFF(a.id IS NOT NULL, zc1.STATE, zc2.STATE)  AS DELIVERY_US_STATE	,
IFF(a.id IS NOT NULL, zc1.STATE_ABBR, zc2.STATE_ABBR)  AS DELIVERY_US_STATE_ABBR	,
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
ESTIMATED_DESPATCH_DATE_ORDER  AS ESTIMATED_DESPATCH_DATE_CONSIGNMENT,
ESTIMATED_DESPATCH_DATE_ORDER  AS ESTIMATED_DESPATCH_DATE,
NULL  AS PROPOSED_DELIVERY_DATE,
NULL  AS CONSIGNMENT_SENT_DATETIME,
NULL  AS CONSIGNMENT_ACKNOWLEDGED_DATETIME,
NULL  AS FULFILMENT_CENTRE_RECEIVED_DATETIME,
NULL  AS FULFILMENT_CENTRE_RECEIVED_DATE,
dp_ACTUAL.pickupdate  AS ACTUAL_DESPATCH_DATETIME,
CAST(dp_ACTUAL.pickupdate AS date)  AS ACTUAL_DESPATCH_DATE,
ACTUAL_DESPATCH_DATETIME  AS DESPATCH_DATETIME,
ACTUAL_DESPATCH_DATE  AS DESPATCH_DATE,
'NL-GRTZ-AMS'  AS FULFILMENT_CENTRE_ID,
'NL'  AS FULFILMENT_CENTRE_COUNTRY_CODE,
isp.trackandtracecode  AS TRACKING_CODE,
NULL  AS DESPATCH_CARRIER,
ol.withvat + COALESCE(co.withvat, co2.withvat, 0)  AS LI_TOTAL_GROSS,
ol.totalwithvat + COALESCE(co.totalwithvat, co2.totalwithvat, 0)  AS LI_TOTAL_NET,
ol.withvat + COALESCE(co.withvat, co2.withvat, 0)  AS LI_TOTAL_AMOUNT,
ol.productamount * c_isp.postage_cost_wVat / c_isp.product_amount   AS POSTAGE_AMOUNT_INC_TAX_AFTER_DISCOUNT,
IFF(ol.discountwithvat = 0 AND ol.discountwithoutvat = 0 AND c_isp.postage_discount_wOutVat = 0, False, True)  AS HAS_DISCOUNT,
ABS(ol.discountwithoutvat)  AS PRODUCT_DISCOUNT,
ABS(ol.productamount * c_isp.postage_discount_wOutVat / c_isp.product_amount)  AS POSTAGE_DISCOUNT,
False  AS IS_EXISTING_MEMBERSHIP_ORDER,
NULL  AS PRICE_MINUS_DISCOUNT_AMOUNT,
ORDER_DATE  AS AVA_ORDER_DATE,
ol.totalwithvat + COALESCE(co.totalwithvat, co2.totalwithvat, 0) - ol.totalwithoutvat - COALESCE(co.totalwithoutvat, co2.totalwithoutvat, 0)  AS AVA_PRODUCT_TAX, 
NULL  AS TAX_CODE,
NULL  AS TAX_CODE_ID,
NULL  AS LINE_NUMBER,
NULL  AS POSTAGE_GROUPING,
ol.productamount * c_isp.postage_cost_wOutVat / c_isp.product_amount  AS AVA_POSTAGE,
ol.productamount * (c_isp.postage_cost_wVat - c_isp.postage_cost_wOutVat) / c_isp.product_amount  AS AVA_POSTAGE_TAX,
'NL'  AS TAX_COUNTRY,
'NL'  AS TAX_REGION,
ol.withoutvat + COALESCE(co.withoutvat, co2.withoutvat, 0)  AS AVA_LINE_AMOUNT,

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

ABS(ol.discountwithvat)  AS PRODUCT_DISCOUNT_INC_TAX,
ABS(ol.discountwithoutvat)  AS PRODUCT_DISCOUNT_EX_TAX,
ABS(ol.discountwithvat - ol.discountwithoutvat)  AS PRODUCT_DISCOUNT_TAX,

ABS(ol.productamount * c_isp.postage_discount_wVat / c_isp.product_amount)  AS POSTAGE_DISCOUNT_INC_TAX,
ABS(ol.productamount * c_isp.postage_discount_wOutVat / c_isp.product_amount)  AS POSTAGE_DISCOUNT_EX_TAX,
ABS(ol.productamount * (c_isp.postage_discount_wVat - c_isp.postage_discount_wOutVat) / c_isp.product_amount)  AS POSTAGE_DISCOUNT_TAX,

ABS(ol.discountwithvat) * ex.avg_rate  AS PRODUCT_DISCOUNT_INC_TAX_GBP,
ABS(ol.discountwithoutvat) * ex.avg_rate  AS PRODUCT_DISCOUNT_EX_TAX_GBP,
ABS(ol.discountwithvat - ol.discountwithoutvat) * ex.avg_rate  AS PRODUCT_DISCOUNT_TAX_GBP,
ABS(ol.productamount * c_isp.postage_discount_wVat / c_isp.product_amount) * ex.avg_rate  AS POSTAGE_DISCOUNT_INC_TAX_GBP,
ABS(ol.productamount * c_isp.postage_discount_wOutVat / c_isp.product_amount) * ex.avg_rate  AS POSTAGE_DISCOUNT_EX_TAX_GBP,
ABS(ol.productamount * (c_isp.postage_discount_wVat - c_isp.postage_discount_wOutVat) / c_isp.product_amount) * ex.avg_rate  AS POSTAGE_DISCOUNT_TAX_GBP,

IFNULL(fee.KICK_BACK_FEE, 1)  AS COMMISSION_MARGIN,
(ol.totalwithvat + COALESCE(co.totalwithvat, co2.totalwithvat, 0)) / ol.productamount AS PRODUCT_UNIT_PRICE,
(ol.TOTALWITHOUTVAT + COALESCE(co.totalwithoutvat, co2.totalwithoutvat, 0)) * IFNULL(fee.KICK_BACK_FEE, 1)  AS ITEM_ESEV,
c_isp.postage_cost_wVat / c_isp.product_amount  AS POSTAGE_UNIT_PRICE,
ol.productamount * c_isp.postage_cost_wOutVat / c_isp.product_amount  AS POSTAGE_EX_TAX,
ol.TOTALWITHVAT + COALESCE(co.totalwithvat, co2.totalwithvat, 0) - ol.TOTALWITHOUTVAT - COALESCE(co.totalwithoutvat, co2.totalwithoutvat, 0) + abs(ol.DISCOUNTWITHVAT - ol.DISCOUNTWITHOUTVAT)  AS PRODUCT_LINE_TAX,
ol.TOTALWITHVAT + COALESCE(co.totalwithvat, co2.totalwithvat, 0) - ol.TOTALWITHOUTVAT - COALESCE(co.totalwithoutvat, co2.totalwithoutvat, 0)  AS PRODUCT_TOTAL_TAX,
(ol.TOTALWITHVAT + COALESCE(co.totalwithvat, co2.totalwithvat, 0)) * IFNULL(fee.KICK_BACK_FEE, 1)  AS ITEM_ESIV,
ol.productamount * (c_isp.postage_cost_wVat - c_isp.postage_cost_wOutVat + abs(c_isp.postage_discount_wVat - c_isp.postage_discount_wOutVat)) / c_isp.product_amount  AS POSTAGE_LINE_TAX,
ol.productamount * (c_isp.postage_cost_wVat - c_isp.postage_cost_wOutVat) / c_isp.product_amount  AS POSTAGE_TOTAL_TAX,
ol.productamount * c_isp.postage_cost_wVat / c_isp.product_amount  AS POSTAGE_SUBTOTAL,
(ol.TOTALWITHOUTVAT + COALESCE(co.totalwithoutvat, co2.totalwithoutvat, 0)) * IFNULL(fee.KICK_BACK_FEE, 1) + IFNULL(ol.productamount * c_isp.postage_cost_wOutVat / c_isp.product_amount, 0)  AS ITEM_ISEV,
ABS(ol.DISCOUNTWITHVAT + IFNULL(ol.productamount * c_isp.postage_discount_wVat / c_isp.product_amount, 0))  AS TOTAL_DISCOUNT,
ol.TOTALWITHVAT + COALESCE(co.totalwithvat, co2.totalwithvat, 0) - ol.TOTALWITHOUTVAT - COALESCE(co.totalwithoutvat, co2.totalwithoutvat, 0) + ol.productamount * IFNULL((c_isp.postage_cost_wVat - c_isp.postage_cost_wOutVat) / c_isp.product_amount, 0)   AS TOTAL_TAX,
(ol.TOTALWITHVAT + COALESCE(co.totalwithvat, co2.totalwithvat, 0)) * IFNULL(fee.KICK_BACK_FEE, 1) + ol.productamount * IFNULL(c_isp.postage_cost_wVat / c_isp.product_amount, 0)  AS ITEM_ISIV,
o_st.ORDER_ISIV  AS ORDER_ISIV,
o_st.ORDER_CASH_PAID  AS EVE_ORDER_TOTAL_GROSS	,
o_st.ORDER_CASH_PAID - o_st.ORDER_ISIV  AS DIFF,
IFF(DIFF > 0.02, TRUE, FALSE)  AS LARGE_DIFF,
ex.avg_rate * (ol.totalwithvat + COALESCE(co.totalwithvat, co2.totalwithvat, 0)) / ol.productamount AS PRODUCT_UNIT_PRICE_GBP,
(ol.TOTALWITHOUTVAT + COALESCE(co.totalwithoutvat, co2.totalwithoutvat, 0)) * IFNULL(fee.KICK_BACK_FEE, 1) * ex.avg_rate  AS ITEM_ESEV_GBP,
ex.avg_rate * c_isp.postage_cost_wVat / c_isp.product_amount  AS POSTAGE_UNIT_PRICE_GBP,
ex.avg_rate * ol.productamount * c_isp.postage_cost_wOutVat / c_isp.product_amount  AS POSTAGE_EX_TAX_GBP,
ex.avg_rate * (ol.TOTALWITHVAT + COALESCE(co.totalwithvat, co2.totalwithvat, 0) - ol.TOTALWITHOUTVAT - COALESCE(co.totalwithoutvat, co2.totalwithoutvat, 0) + abs(ol.DISCOUNTWITHVAT - ol.DISCOUNTWITHOUTVAT))  AS PRODUCT_LINE_TAX_GBP,
ex.avg_rate * (ol.TOTALWITHVAT + COALESCE(co.totalwithvat, co2.totalwithvat, 0) - ol.TOTALWITHOUTVAT - COALESCE(co.totalwithoutvat, co2.totalwithoutvat, 0))  AS PRODUCT_TOTAL_TAX_GBP,
ex.avg_rate * (ol.TOTALWITHVAT + COALESCE(co.totalwithvat, co2.totalwithvat, 0)) * IFNULL(fee.KICK_BACK_FEE, 1)  AS ITEM_ESIV_GBP,
ex.avg_rate * (ol.productamount * (c_isp.postage_cost_wVat - c_isp.postage_cost_wOutVat + abs(c_isp.postage_discount_wVat - c_isp.postage_discount_wOutVat)) / c_isp.product_amount)  AS POSTAGE_LINE_TAX_GBP,
ex.avg_rate * (ol.productamount * (c_isp.postage_cost_wVat - c_isp.postage_cost_wOutVat) / c_isp.product_amount) AS POSTAGE_TOTAL_TAX_GBP,
ex.avg_rate * (ol.productamount * c_isp.postage_cost_wVat / c_isp.product_amount)  AS POSTAGE_SUBTOTAL_GBP,
ex.avg_rate * ITEM_ISEV  AS ITEM_ISEV_GBP,
ex.avg_rate * (ABS(ol.DISCOUNTWITHVAT + ol.productamount * IFNULL(c_isp.postage_discount_wVat / c_isp.product_amount, 0)))  AS TOTAL_DISCOUNT_GBP,
ex.avg_rate * (ol.TOTALWITHVAT + COALESCE(co.totalwithvat, co2.totalwithvat, 0) - ol.TOTALWITHOUTVAT - COALESCE(co.totalwithoutvat, co2.totalwithoutvat, 0) + ol.productamount * IFNULL((c_isp.postage_cost_wVat - c_isp.postage_cost_wOutVat) / c_isp.product_amount, 0))  AS TOTAL_TAX_GBP,
ex.avg_rate * ITEM_ISIV  AS ITEM_ISIV_GBP,

IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.SKU, pv2.SKU)  AS SKU,
IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.SKU_VARIANT, pv2.SKU_VARIANT)  AS SKU_VARIANT,
IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.SKU_VARIANT, pv2.SKU_VARIANT)  AS LI_SKU_VARIANT,	
IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.CARD_VARIANT, pv2.CARD_VARIANT)  AS CARD_VARIANT,
IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY)  AS PRODUCT_FAMILY,
IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.CATEGORY_NAME, pv2.CATEGORY_NAME)  AS CATEGORY_NAME,
IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.CATEGORY_PARENT, pv2.CATEGORY_PARENT)  AS CATEGORY_PARENT,
IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.HIERARCHY_RANK_1, pv2.HIERARCHY_RANK_1)  AS HIERARCHY_RANK_1,
IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.HIERARCHY_RANK_2, pv2.HIERARCHY_RANK_2)  AS HIERARCHY_RANK_2,
IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.HIERARCHY_RANK_3, pv2.HIERARCHY_RANK_3)  AS HIERARCHY_RANK_3,
IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.HIERARCHY_RANK_4, pv2.HIERARCHY_RANK_4)  AS HIERARCHY_RANK_4,
IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_TYPE_NAME, pv2.PRODUCT_TYPE_NAME)  AS PRODUCT_TYPE_NAME	,
IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_KEY, pv2.PRODUCT_KEY)  AS PRODUCT_KEY	,
IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.FINANCE_PRODUCT_HIERARCHY, pv2.FINANCE_PRODUCT_HIERARCHY)  AS FINANCE_PRODUCT_HIERARCHY,
False  AS IS_ECARD,
IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.SUPPLIER_NAME, pv2.SUPPLIER_NAME)  AS SUPPLIER_NAME,
NULL  AS SUPPLIER_NAME_SAP,
IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.LEGACY_SUPPLIER_ID, pv2.LEGACY_SUPPLIER_ID)  AS LEGACY_SUPPLIER_ID,
NULL  AS ROYALTY_RATE	,
NULL  AS ROYALTY_FLAT_FEE	,
NULL  AS ROYALTY_FLAT_FEE_EUR	,

CASE
	WHEN lower(IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.product_type_name, pv2.product_type_name)) in ('personalised mug', 'personalised t-shirt') THEN lower(IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.mcd_finance_subcategory, pv2.mcd_finance_subcategory))
	ELSE lower(IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY))
END  AS ROYALTY_PRODUCT_CATEGORY,

'NL'  AS ROYALTY_WEBSITE	,
NULL  AS CONTRACT_NO	,
IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.FIRST_PUBLISHED_DATE_TIME, pv2.FIRST_PUBLISHED_DATE_TIME)  AS FIRST_PUBLISHED_DATE_TIME,

IFF(p.type IN ('productCardSingle', 'standardGift', 'personalizedGift') OR p.productcode LIKE 'card%',
    TRIM(SPLIT_PART(IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.reporting_occasion, pv2.reporting_occasion), '>', 1)),
	NULL)	AS OCCASION_GROUP,  
	
CASE 
    WHEN OCCASION_GROUP IS NOT NULL AND LENGTH(SPLIT_PART(IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.reporting_occasion, pv2.reporting_occasion), '>', 2)) > 0 THEN TRIM(SPLIT_PART(IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.reporting_occasion, pv2.reporting_occasion), '>', 2))
    ELSE OCCASION_GROUP
END  AS OCCASION,
	
TRIM(SPLIT_PART(IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.reporting_style, pv2.reporting_style), '>', 1)) AS STYLE_GROUP,

CASE 
    WHEN LENGTH(SPLIT_PART(IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.reporting_style, pv2.reporting_style), '>', 2)) > 0 THEN TRIM(SPLIT_PART(IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.reporting_style, pv2.reporting_style), '>', 2))
    ELSE STYLE_GROUP
END  AS STYLE,
  
IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.MCD_FINANCE_CATEGORY, pv2.MCD_FINANCE_CATEGORY)  AS MCD_FINANCE_CATEGORY,
IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.MCD_FINANCE_SUBCATEGORY, pv2.MCD_FINANCE_SUBCATEGORY)  AS MCD_FINANCE_SUBCATEGORY,
IFNULL(IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_TITLE, pv2.PRODUCT_TITLE), ol.productcode)  AS PRODUCT_TITLE,
ol.productid  AS PRODUCT_ID,
ol.productamount  AS QUANTITY, 
IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.VARIANT_ID, pv2.VARIANT_ID)  AS VARIANT_ID,
NULL  AS DESIGN_ID	,
NULL  AS UPC	,	
IFF(cd.numberofphotos > 0, cd.numberofphotos, 0)  AS PHOTO_COUNT	,
IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.DELIVERY_TYPE, pv2.DELIVERY_TYPE)  AS DELIVERY_TYPE	,  -- NULL
IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.LETTERBOX_FRIENDLY, pv2.LETTERBOX_FRIENDLY)  AS LETTERBOX_FRIENDLY	,
IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.SHAPE, pv2.SHAPE)  AS SHAPE	,
IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_BRAND, pv2.PRODUCT_BRAND)  AS PRODUCT_BRAND	,
IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.RANGE, pv2.RANGE)  AS RANGE	,
IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.SIZE, pv2.SIZE)  AS SIZE	,
IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.SEARCH_KEYWORDS, pv2.SEARCH_KEYWORDS)  AS SEARCH_KEYWORDS	,

IFF((p.TYPE = 'productCardSingle' OR p.productcode LIKE 'card%')
		AND 
		(
		 lower(p.productcode) like '%xl%' 
		 OR lower(p.productcode)  like '%large%' 
		 OR lower(p.productcode)  like '%supersize%'
		 ),
	True, False)  AS IS_CARD_UPSELL,
	
	
IFF(pt.MPTypeCode = 'flower'
	   AND 
	   (
	    lower(p.productcode) like '%large%' 
	    OR lower(p.productcode) like '%groot%'
	   ),	
	True, False)  AS IS_FLOWER_UPSELL,

NULL  AS ADDED_XSELL	,
NULL  AS REMINDERS_SET	,
NULL  AS QUICK_VIEW_ITEMS	,
NULL  AS FLAG_SEARCH	,
NULL  AS GAHTS_HIT_TIME	,
NULL  AS SESSION_ID	,
NULL  AS FULL_VISITOR_ID	,
NULL  AS IS_REPORTABLE	,
NULL  AS TOTAL_ORDER_REFUND_AMOUNT	,
NULL  AS CURRENCY_CODE	,
0  AS LINE_ITEM_REFUND_AMOUNT	,
0  AS TOTAL_ORDER_REFUND_AMOUNT_GBP	,
0  AS LINE_ITEM_REFUND_AMOUNT_GBP	,
NULL  AS REFUND_TYPE	,
NULL  AS REFUND_TIMESTAMP	,
NULL  AS REFUND_PAYMENT_PROVIDER	,
False  AS IS_REFUNDED,
IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.mcd_finance_subcategory, pv2.mcd_finance_subcategory)  AS MARGIN_PRODUCT_CATEGORY,
0  AS ESTIMATED_REFUND_RATE	,
0  AS ESTIMATED_TOTAL_REFUND	,
0  AS ESTIMATED_PRODUCT_REFUND	,
0  AS ESTIMATED_SHIPPING_REFUND	,
ROUND(ITEM_ISEV, 4)  AS ESTIMATED_TOTAL_SALES	,
ROUND((ol.TOTALWITHOUTVAT + COALESCE(co.totalwithoutvat, co2.totalwithoutvat, 0)) * IFNULL(fee.KICK_BACK_FEE, 1),4)  AS ESTIMATED_PRODUCT_SALES	,
ROUND(ol.productamount * c_isp.postage_cost_wOutVat / c_isp.product_amount, 4)  AS ESTIMATED_SHIPPING_SALES	,
oce.purchasecost  AS PRODUCT_COST,
oce.directlaborcost  AS LABOUR_FULFILMENT_COST,
oce.packagingcost  AS PACKAGING_COST,
oce.othermaterialcost  AS RAW_MATERIAL_COST,
NULL  AS ROYALTIES_COST	,
oce.externalcontentcost  AS PRODUCTION_OVERHEADS_COST	,
NULL  AS SHIPPING_COST	,
NULL  AS REBATE_COST	,
NULL  AS WAREHOUSE_COST	,
ITEM_ISEV - IFNULL(oce.purchasecost - oce.externalcontentcost - oce.othermaterialcost - oce.directlaborcost - oce.packagingcost, 0)  AS GROSS_PRODUCT_MARGIN,
IFNULL((ol.productamount * c_isp.postage_cost_wOutVat / c_isp.product_amount), 0) - IFNULL((ol.productamount * c_isp.ordercostentry_shipment / c_isp.product_amount), 0)  AS GROSS_SHIPPING_MARGIN	,
ITEM_ISEV - IFNULL(oce.purchasecost - oce.externalcontentcost - oce.othermaterialcost - oce.directlaborcost - oce.packagingcost, 0) - (ol.productamount * IFNULL(c_isp.ordercostentry_shipment / c_isp.product_amount, 0))  AS TOTAL_GROSS_MARGIN,
ITEM_ESEV - IFNULL(oce.purchasecost, 0)  AS COMMERCIAL_PRODUCT_MARGIN,
(ol.productamount * IFNULL(c_isp.postage_cost_wOutVat / c_isp.product_amount, 0)) - (ol.productamount * IFNULL(c_isp.ordercostentry_shipment / c_isp.product_amount, 0))  AS COMMERCIAL_SHIPPING_MARGIN,	
ITEM_ISEV - IFNULL(oce.purchasecost, 0) - (ol.productamount * IFNULL(c_isp.ordercostentry_shipment_purchasecost / c_isp.product_amount, 0))  AS TOTAL_COMMERCIAL_MARGIN,
IFF(cd.CONTENTTYPE IN ('PHOTO_TEMPLATE','PHOTO_SELF') OR p.TYPE = 'personalizedGift', False, True)  AS IS_LOW_EFFORT_ITEM,
IFF(IS_LOW_EFFORT_ITEM = True, False, True)  AS IS_HIGH_EFFORT_ITEM	,
IFF((p.TYPE = 'productCardSingle' OR p.productcode LIKE 'card%') AND cd.CONTENTTYPE IN ('PHOTO_TEMPLATE','PHOTO_SELF'), False, True) AS IS_LOW_EFFORT_CARD_ITEM,
IFF(IS_LOW_EFFORT_CARD_ITEM = True, False, True)  AS IS_HIGH_EFFORT_CARD_ITEM,
NULL AS	PREPAY	,
NULL AS	PREPAY_GBP	,
NULL AS	BONUS	,
NULL AS	BONUS_GBP	,
NULL AS	CUSTOMER_SERVICE	,
NULL AS	CUSTOMER_SERVICE_GBP	,
NULL AS	CREDIT_USED_FLAG	,
NULL AS	MCD_ORDER_ID	,
NULL AS	MCD_ITEM_ID	,
NULL AS	MCD_ADDRESS_ID	,
NULL AS	MCD_ASSOCIATED_PRODUCT_ID	,
NULL AS	MCD_UNIQUE_KEY	,
NULL AS	MCD_ENCRYPTED_ORDER_ID	,
NULL AS	MCD_CUSTOMER_ID	,
NULL AS	MCD_PRODUCT_ID	,
NULL AS	ARENA_ORDER_NO	,
current_timestamp()  AS MESSAGE_TIMESTAMP	,
current_timestamp()  AS IMPORT_DATETIME	,
NULL AS	SOURCE_DATA	,
NULL AS	DBT_MODEL_NAME	,
NULL AS	DBT_INVOCATION_ID	,
NULL AS	DBT_JOB_STARTED_AT	,
'grtz'  AS BRAND,
NULL AS	BRAND_ROYALTY,
IFF(p.TYPE = 'productCardSingle' OR p.productcode LIKE 'card%', ol.productamount, 0)  AS ol_CARD_QUANTITY,
IFF(p.TYPE IN ('standardGift', 'personalizedGift') AND pt.MPTypeCode != 'flower', ol.productamount, 0)  AS ol_GIFT_QUANTITY	,
IFF(pt.MPTypeCode = 'flower', ol.productamount, 0)  AS ol_FLOWER_QUANTITY	,

ol_CARD_QUANTITY  AS CARD_QUANTITY,
ol_GIFT_QUANTITY  AS GIFT_QUANTITY,
ol_FLOWER_QUANTITY  AS FLOWER_QUANTITY,

IFF((p.TYPE = 'productCardSingle' OR p.productcode LIKE 'card%')
	AND 
	(
	 lower(p.productcode) like '%xl%' 
	 OR lower(p.productcode)  like '%large%' 
	 OR lower(p.productcode)  like '%supersize%'
	 ),
	ol.productamount, 0)  AS ol_CARD_UPSELL_QUANTITY	,
	
ol_CARD_UPSELL_QUANTITY  AS CARD_UPSELL_QUANTITY,	

IFF(pt.MPTypeCode = 'flower'
	   AND 
	   (
	    lower(p.productcode) like '%large%' 
	    OR lower(p.productcode) like '%groot%'
	   )
	, ol.productamount, 0)  AS ol_FLOWER_UPSELL_QUANTITY	,
	
ol_FLOWER_UPSELL_QUANTITY  AS FLOWER_UPSELL_QUANTITY,	

ol_CARD_UPSELL_QUANTITY + ol_FLOWER_UPSELL_QUANTITY  AS TOTAL_UPSELL_QUANTITY	,
0  AS ECARD_QUANTITY	,

IFF(IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.CATEGORY_NAME, pv2.CATEGORY_NAME) = 'Greeting Cards' 	-- not 'Postcards'
		AND
		(
		 lower(p.productcode) like '%xl%' 
		 OR lower(p.productcode)  like '%supersize%'
		 )
	   , ol.productamount, 0)  AS GIANT_CARD_QUANTITY	,
	   	   
IFF(IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.CATEGORY_NAME, pv2.CATEGORY_NAME) = 'Greeting Cards' 
		AND 
		(
		 lower(p.productcode) like '%large%' 
		 AND cd.cardratio = 'STANDARD'
		 )
	   , ol.productamount, 0) AS LARGE_CARD_QUANTITY	,
	   
IFF((p.TYPE = 'productCardSingle' OR p.productcode LIKE 'card%') 
		AND 
		(
		 lower(p.productcode) like '%large%' 
		 AND cd.cardratio = 'SQUARE'
		 )
	   , ol.productamount, 0) AS LARGE_SQUARE_CARD_QUANTITY	,
	
IFF(IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.CATEGORY_NAME, pv2.CATEGORY_NAME) = 'Greeting Cards'
		AND 
		(
		 lower(p.productcode) like '%medium%' 
		 AND cd.cardratio = 'SQUARE'
		 )
	   , ol.productamount, 0) AS STANDARD_SQUARE_CARD_QUANTITY	,
	
IFF(IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.CATEGORY_NAME, pv2.CATEGORY_NAME) = 'Greeting Cards'
		AND 
		(
		 lower(p.productcode) like '%medium%' 
		 AND cd.cardratio = 'STANDARD'
		 )
	   , ol.productamount, 0) AS STANDARD_CARD_QUANTITY	,
	
IFF(IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.CATEGORY_NAME, pv2.CATEGORY_NAME) = 'Postcards', ol.productamount, 0)  AS POSTCARD_QUANTITY,
IFF(p.TYPE = 'productCardSingle' OR p.productcode LIKE 'card%', ITEM_ISEV  * ex.avg_rate, 0)  AS CARD_ITEM_ISEV_GBP	,
IFF(p.TYPE IN ('standardGift', 'personalizedGift') AND pt.MPTypeCode != 'flower', ITEM_ISEV  * ex.avg_rate, 0)  AS GIFT_ITEM_ISEV_GBP	,
IFF(pt.MPTypeCode = 'flower', ITEM_ISEV * ex.avg_rate, 0)  AS FLOWER_ITEM_ISEV_GBP	,
ol_CARD_QUANTITY + ol_FLOWER_QUANTITY  AS CARD_FLOWER_QUANTITY	,
IFF(ol_CARD_QUANTITY > 0 OR ol_GIFT_QUANTITY > 0, ITEM_ISEV * ex.avg_rate, 0)  AS CARD_FLOWER_ISEV_GBP	,
IFF(ol_CARD_QUANTITY = 0 AND ol_GIFT_QUANTITY + ol_FLOWER_QUANTITY > 0, ol.productamount, 0)  AS NON_CARD_QUANTITY	,
IFF(ol_CARD_QUANTITY = 0 AND ol_GIFT_QUANTITY + ol_FLOWER_QUANTITY > 0, ITEM_ISEV * ex.avg_rate, 0)  AS NON_CARD_ISEV_GBP	,
IFF(cd.CONTENTTYPE IN ('PHOTO_TEMPLATE','PHOTO_SELF') OR p.TYPE = 'personalizedGift', ol.productamount, 0)  AS HIGH_EFFORT_ITEMS,
ol.productamount - (IFF(cd.CONTENTTYPE IN ('PHOTO_TEMPLATE','PHOTO_SELF') OR p.TYPE = 'personalizedGift', ol.productamount, 0))  AS LOW_EFFORT_ITEMS,
IFF((p.TYPE = 'productCardSingle' OR p.productcode LIKE 'card%') AND cd.CONTENTTYPE IN ('PHOTO_TEMPLATE','PHOTO_SELF'), ol.productamount, 0)  AS HIGH_EFFORT_CARD_ITEMS	,
IFF((p.TYPE = 'productCardSingle' OR p.productcode LIKE 'card%') AND IFNULL(cd.CONTENTTYPE, '') NOT IN ('PHOTO_TEMPLATE','PHOTO_SELF'), ol.productamount, 0)  AS LOW_EFFORT_CARD_ITEMS,
o_st.ITEMS_IN_ORDER	,
o_st.CARD_QUANTITY  AS CARD_ORDER_QUANTITY	,
o_st.FLOWER_QUANTITY  AS FLOWER_ORDER_QUANTITY	,
o_st.GIFT_QUANTITY  AS GIFT_ORDER_QUANTITY	,
IFF(o_st.IS_ATTACH_ORDER = True AND (ol_FLOWER_QUANTITY > 0 OR ol_GIFT_QUANTITY > 0), True, False)  AS IS_ATTACH_ITEM	,
IFF(o_st.IS_GIFT_ATTACH_ORDER = True AND ol_GIFT_QUANTITY > 0, True, False)  AS IS_GIFT_ATTACH_ITEM	,
IFF(o_st.IS_FLOWER_ATTACH_ORDER = True AND ol_FLOWER_QUANTITY > 0, True, False)  AS IS_FLOWER_ATTACH_ITEM	,
False  AS IS_ADDED_XSELL_ITEM	,
o_st.IS_CARD_ORDER,
o_st.IS_GIFT_ORDER,
o_st.IS_FLOWER_ORDER,
o_st.IS_CARD_UPSELL_ORDER,
o_st.IS_FLOWER_UPSELL_ORDER,
o_st.IS_UPSELL_ORDER,
o_st.IS_ECARD_ORDER,
o_st.IS_XSELL_ORDER,
o_st.IS_LOW_EFFORT_ORDER,
o_st.IS_HIGH_EFFORT_ORDER,
o_st.IS_LOW_EFFORT_CARD_ORDER,
o_st.IS_HIGH_EFFORT_CARD_ORDER,
o_st.IS_DISCOUNTED_ORDER,
o_st.IS_CARD_FLOWER_ORDER,
o_st.IS_GIFT_ATTACH_ORDER,
o_st.IS_FLOWER_ATTACH_ORDER,
o_st.IS_LARGE_FLOWER_ATTACH_ORDER,
o_st.IS_ATTACH_ORDER,
o_st.IS_CARD_ONLY_ORDER,
o_st.IS_FLOWER_ONLY_ORDER,
o_st.IS_GIFT_ONLY_ORDER,
o_st.IS_FLOWER_OR_GIFT_ONLY_ORDER,
o_st.IS_NON_CARD_ORDER,
o_st.IS_GIFT_OR_FLOWER_ORDER,
o_st.IS_MULTI_CARD_ORDER,
o_st.IS_PHOTO_UPLOAD_ORDER,
o_st.IS_FLOWER_XSELL_ORDER,
o_st.IS_GIFT_XSELL_ORDER,
o_st.IS_CARD_DISCOUNTED_ORDER,
o_st.IS_FLOWER_DISCOUNTED_ORDER,
o_st.IS_GIFT_DISCOUNTED_ORDER,
o_st.IS_NON_CARD_DISCOUNTED_ORDER,
o_st.IS_MEMBERSHIP_SIGNUP_ORDER,
o_st.IS_MEMBERSHIP_ORDER,
o_st.IS_CUSTOMER_ADDRESS_TYPE_ORDER_ONLY,
o_st.IS_DIRECT_ADDRESS_TYPE_ORDER_ONLY,
o_st.IS_EMAIL_ADDRESS_TYPE_ORDER_ONLY,
o_st.IS_SPLIT_ADDRESS_TYPE_ORDER,
o_st.IS_SPLIT_EMAIL_ADDRESS_TYPE_ORDER,
o_st.MULTI_CARD_VOLUME,
o_st.MULTI_CARD_SALES,
o_st.CARD_ONLY_VOLUME,
o_st.CARD_ONLY_SALES,
o_st.GIFT_ONLY_VOLUME,
o_st.GIFT_ONLY_SALES,
o_st.FLOWER_ONLY_VOLUME,
o_st.FLOWER_ONLY_SALES,
o_st.ATTACH_VOLUME_TOTAL_ITEMS,
o_st.ATTACH_SALES_TOTAL_ITEMS,
o_st.ATTACH_VOLUME_ATTACHED_ITEMS,
o_st.ATTACH_SALES_ATTACHED_ITEMS,
o_st.CARD_ATTACH_VOLUME_CARD_ITEMS,
o_st.CARD_ATTACH_SALES_CARD_ITEMS,
o_st.GIFT_ATTACH_VOLUME_TOTAL_ITEMS,
o_st.GIFT_ATTACH_SALES_TOTAL_ITEMS,
o_st.GIFT_ATTACH_VOLUME_GIFT_ITEMS,
o_st.GIFT_ATTACH_SALES_GIFT_ITEMS,
o_st.FLOWER_ATTACH_VOLUME_TOTAL_ITEMS,
o_st.FLOWER_ATTACH_SALES_TOTAL_ITEMS,
o_st.FLOWER_ATTACH_VOLUME_FLOWER_ITEMS,
o_st.FLOWER_ATTACH_SALES_FLOWER_ITEMS,
o_st.XSELL_VOLUME_TOTAL_ITEMS,
o_st.XSELL_SALES_TOTAL_ITEMS,
0  AS	XSELL_VOLUME_XSELL_ITEMS	,
0  AS	XSELL_SALES_XSELL_ITEMS	,
0  AS	FLOWER_XSELL_VOLUME	,
0  AS	FLOWER_XSELL_SALES	,
0  AS	GIFT_XSELL_VOLUME	,
0  AS	GIFT_XSELL_SALES	,
o_st.DISCOUNTED_VOLUME,
o_st.DISCOUNTED_SALES,
o_st.CARD_DISCOUNTED_VOLUME,
o_st.CARD_DISCOUNTED_SALES,
o_st.GIFT_DISCOUNTED_VOLUME,
o_st.GIFT_DISCOUNTED_SALES,
o_st.FLOWER_DISCOUNTED_VOLUME,
o_st.FLOWER_DISCOUNTED_SALES,
o_st.NON_CARD_DISCOUNTED_VOLUME,
o_st.NON_CARD_DISCOUNTED_SALES,
IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY)  AS MCD_PRODUCT_FAMILY,

CASE
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Cards' THEN 'Greeting Cards'
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Flowers' THEN 'Flowers'
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.product_type_name, pv2.product_type_name) IN ('Alcohol','Personalised Alcohol') THEN 'Alcohol Gift'
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.product_type_name, pv2.product_type_name) = 'Balloon' THEN 'Balloon'
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.product_type_name, pv2.product_type_name) = 'Beauty' THEN 'Beauty'
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.product_type_name, pv2.product_type_name) IN ('Biscuit','Chocolate','Hamper','Sweet') THEN 'Food Gifts'
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.product_type_name, pv2.product_type_name) = 'Gadget / Novelty' THEN 'Gadgets & Novelties'
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.product_type_name, pv2.product_type_name) = 'Gift Experience' THEN 'Gift Experiences'
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.product_type_name, pv2.product_type_name) = 'Gift for Home' THEN 'Gifts For Home'
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.product_type_name, pv2.product_type_name) = 'Jewellery' THEN 'Jewellery & Accessories'
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.product_type_name, pv2.product_type_name) = 'Arena Gift Set' THEN 'Letterbox Gifts'
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.product_type_name, pv2.product_type_name) = 'Personalised Mug' THEN 'Mugs'
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.product_type_name, pv2.product_type_name) = 'Soft Toy' THEN 'Soft Toys'
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.product_type_name, pv2.product_type_name) = 'Stationery / Craft' THEN 'Stationery & Craft'
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.product_type_name, pv2.product_type_name) = 'Personalised T-shirt' THEN 'T-Shirts'
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.product_type_name, pv2.product_type_name) = 'Toy / Game' THEN 'Toys & Games'
ELSE NULL
END  AS MCD_PRODUCT_CATEGORY,

CASE
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Cards' AND RIGHT(IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.size, pv2.size),4) = 'CARD' AND IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.size, pv2.size) NOT IN ('ECard', 'ECARD', 'POSTCARD') THEN CONCAT(INITCAP(LOWER(LEFT(IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.size, pv2.size),CHARINDEX('CARD',IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.size, pv2.size)) - 1))),' Card')
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Cards' AND RIGHT(IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.size, pv2.size),4) <> 'CARD' AND IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.size, pv2.size) NOT IN ('ECard', 'ECARD', 'POSTCARD') THEN CONCAT(IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.size, pv2.size),' Card')
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Cards' AND IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.size, pv2.size) IN ('ECard','ECARD') THEN 'eCard'
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Cards' AND IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.size, pv2.size) = 'POSTCARD' THEN 'Postcard'
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Flowers' AND LOWER(IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.size, pv2.size)) = 'large' THEN 'Flowers - Extra Stems'
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Flowers' AND LOWER(IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.size, pv2.size)) = 'letterbox' THEN 'Letterbox Flowers'
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Flowers' AND LOWER(IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.size, pv2.size)) NOT IN ('large', 'letterbox') THEN 'Flowers'
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.product_type_name, pv2.product_type_name) IN ('Alcohol','Personalised Alcohol') THEN 'Alcohol Gift'
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.product_type_name, pv2.product_type_name) = 'Balloon' THEN 'Balloon'
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.product_type_name, pv2.product_type_name) = 'Beauty' THEN 'Beauty'
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.product_type_name, pv2.product_type_name) IN ('Biscuit','Chocolate','Hamper','Sweet')  THEN 'Food Gifts'
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.product_type_name, pv2.product_type_name) = 'Gadget / Novelty' THEN 'Gadgets & Novelties'
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.product_type_name, pv2.product_type_name) = 'Gift Experience' THEN 'Gift Experiences'
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.product_type_name, pv2.product_type_name) = 'Gift for Home' THEN 'Gifts For Home'
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.product_type_name, pv2.product_type_name) = 'Jewellery' THEN 'Jewellery & Accessories'
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.product_type_name, pv2.product_type_name) = 'Arena Gift Set' THEN 'Letterbox Gifts'
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.product_type_name, pv2.product_type_name) = 'Personalised Mug' THEN 'Mugs'
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.product_type_name, pv2.product_type_name) = 'Soft Toy' THEN 'Soft Toys'
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.product_type_name, pv2.product_type_name) = 'Stationery / Craft' THEN 'Stationery & Craft'
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.product_type_name, pv2.product_type_name) = 'Personalised T-shirt' THEN 'T-Shirts'
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.product_type_name, pv2.product_type_name) = 'Toy / Game' THEN 'Toys & Games'
ELSE NULL
END  AS MCD_PRODUCT_SUBCATEGORY	,

CASE
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Cards' AND RIGHT(IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.size, pv2.size),4) = 'CARD' AND IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.size, pv2.size) NOT IN ('ECard', 'ECARD', 'POSTCARD') THEN CONCAT(INITCAP(LOWER(LEFT(IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.size, pv2.size),CHARINDEX('CARD',IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.size, pv2.size)) - 1))),' Card')
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Cards' AND RIGHT(IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.size, pv2.size),4) <> 'CARD' AND IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.size, pv2.size) NOT IN ('ECard', 'ECARD', 'POSTCARD') THEN CONCAT(IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.size, pv2.size),' Card')
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Cards' AND IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.size, pv2.size) IN ('ECard','ECARD') THEN 'eCard'
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Cards' AND IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.size, pv2.size) = 'POSTCARD' THEN 'Postcard'
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Flowers' AND LOWER(IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.size, pv2.size)) = 'large' THEN 'Flowers - Extra Stems'
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Flowers' AND LOWER(IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.size, pv2.size)) = 'letterbox' THEN 'Letterbox Flowers'
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Flowers' AND LOWER(IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.size, pv2.size)) NOT IN ('large', 'letterbox') THEN 'Flowers'
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.product_type_name, pv2.product_type_name) IN ('Alcohol','Personalised Alcohol') THEN 'Alcohol Gift'
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.product_type_name, pv2.product_type_name) = 'Balloon' THEN 'Balloon'
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.product_type_name, pv2.product_type_name) = 'Beauty' THEN 'Beauty'
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.product_type_name, pv2.product_type_name) IN ('Biscuit','Chocolate','Hamper','Sweet') THEN CONCAT(IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.product_type_name, pv2.product_type_name),'s')
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.product_type_name, pv2.product_type_name) = 'Gadget / Novelty' THEN 'Gadgets & Novelties'
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.product_type_name, pv2.product_type_name) = 'Gift Experience' THEN 'Gift Experiences'
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.product_type_name, pv2.product_type_name) = 'Gift for Home' THEN 'Gifts For Home'
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.product_type_name, pv2.product_type_name) = 'Jewellery' THEN 'Jewellery & Accessories'
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.product_type_name, pv2.product_type_name) = 'Arena Gift Set' THEN 'Letterbox Gifts'
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.product_type_name, pv2.product_type_name) = 'Personalised Mug' THEN 'Ceramic Mug'
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.product_type_name, pv2.product_type_name) = 'Soft Toy' THEN 'Soft Toy'
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.product_type_name, pv2.product_type_name) = 'Stationery / Craft' THEN 'Stationery & Craft'
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.product_type_name, pv2.product_type_name) = 'Personalised T-shirt' THEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.size, pv2.size)
        WHEN IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFF(pv.GREETZ_PRODUCT_ID IS NOT NULL, pv.product_type_name, pv2.product_type_name) = 'Toy / Game' THEN 'Toys & Games'
ELSE NULL
END  AS MCD_PRODUCT_TYPE

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
	LEFT JOIN "RAW_GREETZ"."GREETZ3".address a
       on r.addressid = a.id
	LEFT JOIN "RAW_GREETZ"."GREETZ3".address AS a2
	   ON o.customerid = a2.customerid 
		  AND a2.DEFAULTADDRESS = 'Y'
	LEFT JOIN "RAW_GREETZ"."GREETZ3".ordercost AS oc
		ON o.ordercostid = oc.ID
	LEFT JOIN "RAW_GREETZ"."GREETZ3".ordercostentry AS oce
		ON oce.ordercostid = oc.ID
			AND oce.orderlineid = ol.ID
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
		ON ol.orderid = c_isp.orderid
			AND IFNULL(ol.individualshippingid, 0) = IFNULL(c_isp.individualshippingid, 0)
	LEFT JOIN cte_content co
		ON co.orderid = ol.orderid
		   AND (p.type = 'productCardSingle'  OR  p.productcode LIKE 'card%')
		   AND IFNULL(ol.PRODUCTITEMINBASKETID, 0) = IFNULL(co.PRODUCTITEMINBASKETID, 0)
    LEFT JOIN cte_content_2_Cards AS cc
        ON cc.ID = ol.ID
    LEFT JOIN cte_content_2 AS co2
        ON co2.orderid = ol.orderid
            AND IFNULL(co2.PRODUCTITEMINBASKETID, 0) = IFNULL(ol.PRODUCTITEMINBASKETID, 0)
            AND co2.RN = cc.RN		   
	LEFT JOIN "PROD"."WORKSPACE_GREETZ_HISTORY_MIGRATION"."PRODUCT_VARIANTS_DETAILED" AS pv
		ON pv.GREETZ_PRODUCT_ID = ol.productid 
			AND pv.GREETZ_CARDDEFINITION_ID = c.carddefinition 
	LEFT JOIN "PROD"."WORKSPACE_GREETZ_HISTORY_MIGRATION"."PRODUCT_VARIANTS_DETAILED" AS pv2
		ON pv2.GREETZ_PRODUCT_ID = ol.productid 
			AND pv2.GREETZ_CARDDEFINITION_ID = 0	
	LEFT JOIN prod.raw_seeds.us_zipcodes AS zc1
		ON zc1.ZIPCODE = TRY_TO_NUMBER(a.ZIPPOSTALCODE)
			AND a.COUNTRYCODE = 'US'
	LEFT JOIN prod.raw_seeds.us_zipcodes AS zc2
		ON zc2.ZIPCODE = TRY_TO_NUMBER(a2.ZIPPOSTALCODE)
			AND a2.COUNTRYCODE = 'US'			
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
		AND p.type NOT IN ('shipment' , 'content')
)

SELECT 
ORDER_ID	,
ORDER_LINE_ITEM_ID	,
ORDER_DATE	,
ORDER_DATE_TIME	,
ORDER_HOUR_ONLY	,
ORDER_MINUTE_ONLY	,
CUSTOMER_ID	,
ORDER_COUNTRY_CODE	,
ORDER_COUNTRY	,
ORDER_STORE	,
ITEM_STATE	,
IS_ITEM_CANCELLED	,
ITEM_CANCELLED_DATE	,
ORDER_TAX_CALCULATION	,
ORDER_TRANSACTION_FEE	,
LI_CURRENCYCODE	,
TO_GBP_RATE	,
TO_USD_RATE	,
TO_EUR_RATE	,
MNTH_GBP_TO_EUR_RATE	,
LI_TAX_COUNTRY	,
LI_TAX_AMOUNT	,
TAX_INCLUDED_IN_SUBTOTAL	,
CT_TAX_NAME	,
PAYMENT_STATE	,
PLATFORM	,
ORDER_NUMBER	,
ADDRESS_ID	,
RECIPIENT_TYPE	,
ADDRESS_TYPE	,
DELIVERY_DISTRICT	,
DELIVERY_POSTAL_AREA	,
DELIVERY_CITY	,
DELIVERY_COUNTY	,
DELIVERY_COUNTRY_CODE	,
DELIVERY_METHOD	,
DELIVERY_METHOD_ID	,
DELIVERY_COUNTRY	,
DELIVERY_US_STATE	,
DELIVERY_US_STATE_ABBR	,
ROYAL_MAIL_AREA	,
ROYAL_MAIL_DISTRIBUTION_CENTRE	,
IS_MESSAGE_CARD	,
SHIPMENT_STATE	,
ESTIMATED_DESPATCH_DATE_ORDER	,
PRINTSITE	,
PRINTSITE_COUNTRY	,
CONSIGNMENT_ID	,
CONSIGNMENT_SOURCE	,
CONSIGNMENT_ACCEPTED_DATETIME	,
CONSIGNMENT_PREPARED_DATETIME	,
ESTIMATED_DESPATCH_DATE_CONSIGNMENT	,
ESTIMATED_DESPATCH_DATE	,
PROPOSED_DELIVERY_DATE	,
CONSIGNMENT_SENT_DATETIME	,
CONSIGNMENT_ACKNOWLEDGED_DATETIME	,
FULFILMENT_CENTRE_RECEIVED_DATETIME	,
FULFILMENT_CENTRE_RECEIVED_DATE	,
ACTUAL_DESPATCH_DATETIME	,
ACTUAL_DESPATCH_DATE	,
DESPATCH_DATETIME	,
DESPATCH_DATE	,
FULFILMENT_CENTRE_ID	,
FULFILMENT_CENTRE_COUNTRY_CODE	,
TRACKING_CODE	,
DESPATCH_CARRIER	,
LI_TOTAL_GROSS	,
LI_TOTAL_NET	,
LI_TOTAL_AMOUNT	,
POSTAGE_AMOUNT_INC_TAX_AFTER_DISCOUNT	,
HAS_DISCOUNT	,
PRODUCT_DISCOUNT	,
POSTAGE_DISCOUNT	,
IS_EXISTING_MEMBERSHIP_ORDER	,
PRICE_MINUS_DISCOUNT_AMOUNT	,
AVA_ORDER_DATE	,
AVA_PRODUCT_TAX	,
TAX_CODE	,
TAX_CODE_ID	,
LINE_NUMBER	,
POSTAGE_GROUPING	,
AVA_POSTAGE	,
AVA_POSTAGE_TAX	,
TAX_COUNTRY	,
TAX_REGION	,
AVA_LINE_AMOUNT	,
TAX_NAME	,
TAX_RATE	,
DISCOUNT_CODES	,
CUSTOM_LINE_ITEMS	,
TAX_GROUPING	,
TAX_TYPE	,
PRODUCT_DISCOUNT_INC_TAX	,
PRODUCT_DISCOUNT_EX_TAX	,
PRODUCT_DISCOUNT_TAX	,
POSTAGE_DISCOUNT_INC_TAX	,
POSTAGE_DISCOUNT_EX_TAX	,
POSTAGE_DISCOUNT_TAX	,
PRODUCT_DISCOUNT_INC_TAX_GBP	,
PRODUCT_DISCOUNT_EX_TAX_GBP	,
PRODUCT_DISCOUNT_TAX_GBP	,
POSTAGE_DISCOUNT_INC_TAX_GBP	,
POSTAGE_DISCOUNT_EX_TAX_GBP	,
POSTAGE_DISCOUNT_TAX_GBP	,
COMMISSION_MARGIN	,
PRODUCT_UNIT_PRICE	,
ITEM_ESEV	,
POSTAGE_UNIT_PRICE	,
POSTAGE_EX_TAX	,
PRODUCT_LINE_TAX	,
PRODUCT_TOTAL_TAX	,
ITEM_ESIV	,
POSTAGE_LINE_TAX	,
POSTAGE_TOTAL_TAX	,
POSTAGE_SUBTOTAL	,
ITEM_ISEV	,
TOTAL_DISCOUNT	,
TOTAL_TAX	,
ITEM_ISIV	,
ORDER_ISIV	,
EVE_ORDER_TOTAL_GROSS	,
DIFF	,
LARGE_DIFF	,
PRODUCT_UNIT_PRICE_GBP	,
ITEM_ESEV_GBP	,
POSTAGE_UNIT_PRICE_GBP	,
POSTAGE_EX_TAX_GBP	,
PRODUCT_LINE_TAX_GBP	,
PRODUCT_TOTAL_TAX_GBP	,
ITEM_ESIV_GBP	,
POSTAGE_LINE_TAX_GBP	,
POSTAGE_TOTAL_TAX_GBP	,
POSTAGE_SUBTOTAL_GBP	,
ITEM_ISEV_GBP	,
TOTAL_DISCOUNT_GBP	,
TOTAL_TAX_GBP	,
ITEM_ISIV_GBP	,
SKU	,
SKU_VARIANT	,
CARD_VARIANT	,
PRODUCT_FAMILY	,
CATEGORY_NAME	,
CATEGORY_PARENT	,
HIERARCHY_RANK_1	,
HIERARCHY_RANK_2	,
HIERARCHY_RANK_3	,
HIERARCHY_RANK_4	,
PRODUCT_TYPE_NAME	,
PRODUCT_KEY	,
FINANCE_PRODUCT_HIERARCHY	,
IS_ECARD	,
SUPPLIER_NAME	,
SUPPLIER_NAME_SAP	,
LEGACY_SUPPLIER_ID	,
ROYALTY_RATE	,
ROYALTY_FLAT_FEE	,
ROYALTY_FLAT_FEE_EUR	,
ROYALTY_PRODUCT_CATEGORY	,
ROYALTY_WEBSITE	,
CONTRACT_NO	,
FIRST_PUBLISHED_DATE_TIME	,
OCCASION_GROUP	,
OCCASION	,
STYLE_GROUP	,
STYLE	,
MCD_FINANCE_CATEGORY	,
MCD_FINANCE_SUBCATEGORY	,
LI_SKU_VARIANT	,
PRODUCT_TITLE	,
PRODUCT_ID	,
QUANTITY	,
VARIANT_ID	,
DESIGN_ID	,
UPC	,
PHOTO_COUNT	,
DELIVERY_TYPE	,
LETTERBOX_FRIENDLY	,
SHAPE	,
PRODUCT_BRAND	,
RANGE	,
SIZE	,
SEARCH_KEYWORDS	,
IS_CARD_UPSELL	,
IS_FLOWER_UPSELL	,
ADDED_XSELL	,
REMINDERS_SET	,
QUICK_VIEW_ITEMS	,
FLAG_SEARCH	,
GAHTS_HIT_TIME	,
SESSION_ID	,
FULL_VISITOR_ID	,
IS_REPORTABLE	,
TOTAL_ORDER_REFUND_AMOUNT	,
CURRENCY_CODE	,
LINE_ITEM_REFUND_AMOUNT	,
TOTAL_ORDER_REFUND_AMOUNT_GBP	,
LINE_ITEM_REFUND_AMOUNT_GBP	,
REFUND_TYPE	,
REFUND_TIMESTAMP	,
REFUND_PAYMENT_PROVIDER	,
IS_REFUNDED	,
MARGIN_PRODUCT_CATEGORY	,
ESTIMATED_REFUND_RATE	,
ESTIMATED_TOTAL_REFUND	,
ESTIMATED_PRODUCT_REFUND	,
ESTIMATED_SHIPPING_REFUND	,
ESTIMATED_TOTAL_SALES	,
ESTIMATED_PRODUCT_SALES	,
ESTIMATED_SHIPPING_SALES	,
PRODUCT_COST	,
LABOUR_FULFILMENT_COST	,
PACKAGING_COST	,
RAW_MATERIAL_COST	,
ROYALTIES_COST	,
PRODUCTION_OVERHEADS_COST	,
SHIPPING_COST	,
REBATE_COST	,
WAREHOUSE_COST	,
GROSS_PRODUCT_MARGIN	,
GROSS_SHIPPING_MARGIN	,
TOTAL_GROSS_MARGIN	,
COMMERCIAL_PRODUCT_MARGIN	,
COMMERCIAL_SHIPPING_MARGIN	,
TOTAL_COMMERCIAL_MARGIN	,
IS_LOW_EFFORT_ITEM	,
IS_HIGH_EFFORT_ITEM	,
IS_LOW_EFFORT_CARD_ITEM	,
IS_HIGH_EFFORT_CARD_ITEM	,
PREPAY	,
PREPAY_GBP	,
BONUS	,
BONUS_GBP	,
CUSTOMER_SERVICE	,
CUSTOMER_SERVICE_GBP	,
CREDIT_USED_FLAG	,
MCD_ORDER_ID	,
MCD_ITEM_ID	,
MCD_ADDRESS_ID	,
MCD_ASSOCIATED_PRODUCT_ID	,
MCD_UNIQUE_KEY	,
MCD_ENCRYPTED_ORDER_ID	,
MCD_CUSTOMER_ID	,
MCD_PRODUCT_ID	,
ARENA_ORDER_NO	,
MESSAGE_TIMESTAMP	,
IMPORT_DATETIME	,
SOURCE_DATA	,
DBT_MODEL_NAME	,
DBT_INVOCATION_ID	,
DBT_JOB_STARTED_AT	,
BRAND	,
BRAND_ROYALTY	,
CARD_QUANTITY	,
GIFT_QUANTITY	,
FLOWER_QUANTITY	,
CARD_UPSELL_QUANTITY	,
FLOWER_UPSELL_QUANTITY	,
TOTAL_UPSELL_QUANTITY	,
ECARD_QUANTITY	,
GIANT_CARD_QUANTITY	,
LARGE_CARD_QUANTITY	,
LARGE_SQUARE_CARD_QUANTITY	,
STANDARD_SQUARE_CARD_QUANTITY	,
STANDARD_CARD_QUANTITY	,
POSTCARD_QUANTITY	,
CARD_ITEM_ISEV_GBP	,
GIFT_ITEM_ISEV_GBP	,
FLOWER_ITEM_ISEV_GBP	,
CARD_FLOWER_QUANTITY	,
CARD_FLOWER_ISEV_GBP	,
NON_CARD_QUANTITY	,
NON_CARD_ISEV_GBP	,
LOW_EFFORT_ITEMS	,
HIGH_EFFORT_ITEMS	,
LOW_EFFORT_CARD_ITEMS	,
HIGH_EFFORT_CARD_ITEMS	,
ITEMS_IN_ORDER	,
CARD_ORDER_QUANTITY	,
FLOWER_ORDER_QUANTITY	,
GIFT_ORDER_QUANTITY	,
IS_ATTACH_ITEM	,
IS_GIFT_ATTACH_ITEM	,
IS_FLOWER_ATTACH_ITEM	,
IS_ADDED_XSELL_ITEM	,
IS_CARD_ORDER	,
IS_GIFT_ORDER	,
IS_FLOWER_ORDER	,
IS_CARD_UPSELL_ORDER	,
IS_FLOWER_UPSELL_ORDER	,
IS_UPSELL_ORDER	,
IS_ECARD_ORDER	,
IS_XSELL_ORDER	,
IS_LOW_EFFORT_ORDER	,
IS_HIGH_EFFORT_ORDER	,
IS_LOW_EFFORT_CARD_ORDER	,
IS_HIGH_EFFORT_CARD_ORDER	,
IS_DISCOUNTED_ORDER	,
IS_CARD_FLOWER_ORDER	,
IS_GIFT_ATTACH_ORDER	,
IS_FLOWER_ATTACH_ORDER	,
IS_LARGE_FLOWER_ATTACH_ORDER	,
IS_ATTACH_ORDER	,
IS_CARD_ONLY_ORDER	,
IS_FLOWER_ONLY_ORDER	,
IS_GIFT_ONLY_ORDER	,
IS_FLOWER_OR_GIFT_ONLY_ORDER	,
IS_NON_CARD_ORDER	,
IS_GIFT_OR_FLOWER_ORDER	,
IS_MULTI_CARD_ORDER	,
IS_PHOTO_UPLOAD_ORDER	,
IS_FLOWER_XSELL_ORDER	,
IS_GIFT_XSELL_ORDER	,
IS_CARD_DISCOUNTED_ORDER	,
IS_FLOWER_DISCOUNTED_ORDER	,
IS_GIFT_DISCOUNTED_ORDER	,
IS_NON_CARD_DISCOUNTED_ORDER	,
IS_MEMBERSHIP_SIGNUP_ORDER	,
IS_MEMBERSHIP_ORDER	,
IS_CUSTOMER_ADDRESS_TYPE_ORDER_ONLY	,
IS_DIRECT_ADDRESS_TYPE_ORDER_ONLY	,
IS_EMAIL_ADDRESS_TYPE_ORDER_ONLY	,
IS_SPLIT_ADDRESS_TYPE_ORDER	,
IS_SPLIT_EMAIL_ADDRESS_TYPE_ORDER	,
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
XSELL_VOLUME_TOTAL_ITEMS	,
XSELL_SALES_TOTAL_ITEMS	,
XSELL_VOLUME_XSELL_ITEMS	,
XSELL_SALES_XSELL_ITEMS	,
FLOWER_XSELL_VOLUME	,
FLOWER_XSELL_SALES	,
GIFT_XSELL_VOLUME	,
GIFT_XSELL_SALES	,
DISCOUNTED_VOLUME	,
DISCOUNTED_SALES	,
CARD_DISCOUNTED_VOLUME	,
CARD_DISCOUNTED_SALES	,
GIFT_DISCOUNTED_VOLUME	,
GIFT_DISCOUNTED_SALES	,
FLOWER_DISCOUNTED_VOLUME	,
FLOWER_DISCOUNTED_SALES	,
NON_CARD_DISCOUNTED_VOLUME	,
NON_CARD_DISCOUNTED_SALES	,
MCD_PRODUCT_FAMILY	,
MCD_PRODUCT_CATEGORY	,
MCD_PRODUCT_SUBCATEGORY	,
MCD_PRODUCT_TYPE	
FROM cte_Res
);		
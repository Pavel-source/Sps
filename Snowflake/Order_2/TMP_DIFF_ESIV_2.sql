 CREATE OR REPLACE TABLE  "PROD"."WORKSPACE_GREETZ_HISTORY_MIGRATION"."DIFF_ESIV_2" AS (

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
		
 FROM 
   "PROD"."WORKSPACE_GREETZ_HISTORY_MIGRATION"."DIFF_ESIV" e
    JOIN "RAW_GREETZ"."GREETZ3".orders o on e.order_id = o.id
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
	 sum(ol.totalwithvat) AS totalwithvat,
	 sum(ol.totalwithoutvat) AS totalwithoutvat,
	 sum(ol.withvat) AS withvat,
	 sum(ol.withoutvat) AS withoutvat
FROM "PROD"."WORKSPACE_GREETZ_HISTORY_MIGRATION"."DIFF_ESIV" e
    JOIN "RAW_GREETZ"."GREETZ3".orders o on e.order_id = o.id
 -- "RAW_GREETZ"."GREETZ3".orders o
	JOIN "RAW_GREETZ"."GREETZ3".orderline ol ON o.id = ol.orderid
	JOIN "RAW_GREETZ"."GREETZ3".product pn ON pn.id = ol.productid
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
GROUP BY ol.orderid, ol.PRODUCTITEMINBASKETID, ol.productId
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
UPPER(REGEXP_SUBSTR(IFNULL(a.zippostalcode, a2.zippostalcode), '(^[a-zA-Z]+\\d\\d?[a-zA-Z]?)'))  AS DELIVERY_DISTRICT,
UPPER(REGEXP_SUBSTR(IFNULL(a.zippostalcode, a2.zippostalcode), '(^[a-zA-Z][a-zA-Z]?)'))  AS DELIVERY_POSTAL_AREA,
IFNULL(a.CITY, a2.CITY)  AS DELIVERY_CITY,
IFNULL(a.stateprovincecounty, a2.stateprovincecounty)  AS DELIVERY_COUNTY,	
IFNULL(a.countrycode, a2.countrycode)  AS DELIVERY_COUNTRY_CODE,
ps.CLASSNAME  AS DELIVERY_METHOD,
ps.postalcompany  AS DELIVERY_METHOD_ID,
IFNULL(cn.ENGLISHCOUNTRYNAME, cn2.ENGLISHCOUNTRYNAME)  AS DELIVERY_COUNTRY,
zc.STATE  AS DELIVERY_US_STATE	,
zc.STATE_ABBR  AS DELIVERY_US_STATE_ABBR	,
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
ol.withvat + IFNULL(co.withvat, 0)  AS LI_TOTAL_GROSS,
ol.totalwithvat + IFNULL(co.totalwithvat, 0)  AS LI_TOTAL_NET,
ol.withvat + IFNULL(co.withvat, 0)  AS LI_TOTAL_AMOUNT,
ol.productamount * c_isp.postage_cost_wVat / c_isp.product_amount   AS POSTAGE_AMOUNT_INC_TAX_AFTER_DISCOUNT,
IFF(ol.discountwithvat = 0 AND ol.discountwithoutvat = 0 AND c_isp.postage_discount_wOutVat = 0, False, True)  AS HAS_DISCOUNT,
ABS(ol.discountwithoutvat)  AS PRODUCT_DISCOUNT,
ABS(ol.productamount * c_isp.postage_discount_wOutVat / c_isp.product_amount)  AS POSTAGE_DISCOUNT,
False  AS IS_EXISTING_MEMBERSHIP_ORDER,
NULL  AS PRICE_MINUS_DISCOUNT_AMOUNT,
ORDER_DATE  AS AVA_ORDER_DATE,
ol.totalwithvat + IFNULL(co.totalwithvat, 0) - ol.totalwithoutvat - IFNULL(co.totalwithoutvat, 0)  AS AVA_PRODUCT_TAX, 
NULL  AS TAX_CODE,
NULL  AS TAX_CODE_ID,
NULL  AS LINE_NUMBER,
NULL  AS POSTAGE_GROUPING,
ol.productamount * c_isp.postage_cost_wOutVat / c_isp.product_amount  AS AVA_POSTAGE,
ol.productamount * (c_isp.postage_cost_wVat - c_isp.postage_cost_wOutVat) / c_isp.product_amount  AS AVA_POSTAGE_TAX,
'NL'  AS TAX_COUNTRY,
'NL'  AS TAX_REGION,
ol.withoutvat + IFNULL(co.withoutvat, 0)  AS AVA_LINE_AMOUNT,

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
(ol.totalwithvat + IFNULL(co.totalwithvat, 0)) / ol.productamount AS PRODUCT_UNIT_PRICE,
(ol.TOTALWITHOUTVAT + IFNULL(co.totalwithoutvat, 0)) * IFNULL(fee.KICK_BACK_FEE, 1)  AS ITEM_ESEV,
c_isp.postage_cost_wVat / c_isp.product_amount  AS POSTAGE_UNIT_PRICE,
ol.productamount * c_isp.postage_cost_wOutVat / c_isp.product_amount  AS POSTAGE_EX_TAX,
ol.TOTALWITHVAT + IFNULL(co.totalwithvat, 0) - ol.TOTALWITHOUTVAT - IFNULL(co.totalwithoutvat, 0) + abs(ol.DISCOUNTWITHVAT - ol.DISCOUNTWITHOUTVAT)  AS PRODUCT_LINE_TAX,
ol.TOTALWITHVAT + IFNULL(co.totalwithvat, 0) - ol.TOTALWITHOUTVAT -  IFNULL(co.totalwithoutvat, 0)  AS PRODUCT_TOTAL_TAX,
(ol.TOTALWITHVAT + IFNULL(co.totalwithvat, 0)) * IFNULL(fee.KICK_BACK_FEE, 1)  AS ITEM_ESIV,
ol.productamount * (c_isp.postage_cost_wVat - c_isp.postage_cost_wOutVat + abs(c_isp.postage_discount_wVat - c_isp.postage_discount_wOutVat)) / c_isp.product_amount  AS POSTAGE_LINE_TAX,
ol.productamount * (c_isp.postage_cost_wVat - c_isp.postage_cost_wOutVat) / c_isp.product_amount  AS POSTAGE_TOTAL_TAX,
ol.productamount * c_isp.postage_cost_wVat / c_isp.product_amount  AS POSTAGE_SUBTOTAL,
(ol.TOTALWITHOUTVAT + IFNULL(co.totalwithoutvat, 0)) * IFNULL(fee.KICK_BACK_FEE, 1) + IFNULL(ol.productamount * c_isp.postage_cost_wOutVat / c_isp.product_amount, 0)  AS ITEM_ISEV,
ABS(ol.DISCOUNTWITHVAT + IFNULL(ol.productamount * c_isp.postage_discount_wVat / c_isp.product_amount, 0))  AS TOTAL_DISCOUNT,
ol.TOTALWITHVAT + IFNULL(co.totalwithvat, 0) - ol.TOTALWITHOUTVAT - IFNULL(co.totalwithoutvat, 0) + ol.productamount * IFNULL((c_isp.postage_cost_wVat - c_isp.postage_cost_wOutVat) / c_isp.product_amount, 0)   AS TOTAL_TAX,
(ol.TOTALWITHVAT + IFNULL(co.totalwithvat, 0)) * IFNULL(fee.KICK_BACK_FEE, 1) + ol.productamount * IFNULL(c_isp.postage_cost_wVat / c_isp.product_amount, 0)  AS ITEM_ISIV,
o_st.ORDER_ISIV  AS ORDER_ISIV,
o_st.ORDER_CASH_PAID  AS EVE_ORDER_TOTAL_GROSS	,
o_st.ORDER_CASH_PAID - o_st.ORDER_ISIV  AS DIFF,
IFF(DIFF > 0.02, TRUE, FALSE)  AS LARGE_DIFF,
ex.avg_rate * (ol.totalwithvat + IFNULL(co.totalwithvat, 0)) / ol.productamount AS PRODUCT_UNIT_PRICE_GBP,
(ol.TOTALWITHOUTVAT + IFNULL(co.totalwithoutvat, 0)) * IFNULL(fee.KICK_BACK_FEE, 1) * ex.avg_rate  AS ITEM_ESEV_GBP,
ex.avg_rate * c_isp.postage_cost_wVat / c_isp.product_amount  AS POSTAGE_UNIT_PRICE_GBP,
ex.avg_rate * ol.productamount * c_isp.postage_cost_wOutVat / c_isp.product_amount  AS POSTAGE_EX_TAX_GBP,
ex.avg_rate * (ol.TOTALWITHVAT + IFNULL(co.totalwithvat, 0) - ol.TOTALWITHOUTVAT - IFNULL(co.totalwithoutvat, 0) + abs(ol.DISCOUNTWITHVAT - ol.DISCOUNTWITHOUTVAT))  AS PRODUCT_LINE_TAX_GBP,
ex.avg_rate * (ol.TOTALWITHVAT + IFNULL(co.totalwithvat, 0) - ol.TOTALWITHOUTVAT - IFNULL(co.totalwithoutvat, 0))  AS PRODUCT_TOTAL_TAX_GBP,
ex.avg_rate * (ol.TOTALWITHVAT + IFNULL(co.totalwithvat, 0)) * IFNULL(fee.KICK_BACK_FEE, 1)  AS ITEM_ESIV_GBP,
ex.avg_rate * (ol.productamount * (c_isp.postage_cost_wVat - c_isp.postage_cost_wOutVat + abs(c_isp.postage_discount_wVat - c_isp.postage_discount_wOutVat)) / c_isp.product_amount)  AS POSTAGE_LINE_TAX_GBP,
ex.avg_rate * (ol.productamount * (c_isp.postage_cost_wVat - c_isp.postage_cost_wOutVat) / c_isp.product_amount) AS POSTAGE_TOTAL_TAX_GBP,
ex.avg_rate * (ol.productamount * c_isp.postage_cost_wVat / c_isp.product_amount)  AS POSTAGE_SUBTOTAL_GBP,
ex.avg_rate * ITEM_ISEV  AS ITEM_ISEV_GBP,
ex.avg_rate * (ABS(ol.DISCOUNTWITHVAT + ol.productamount * IFNULL(c_isp.postage_discount_wVat / c_isp.product_amount, 0)))  AS TOTAL_DISCOUNT_GBP,
ex.avg_rate * (ol.TOTALWITHVAT + IFNULL(co.totalwithvat, 0) - ol.TOTALWITHOUTVAT - IFNULL(co.totalwithoutvat, 0) + ol.productamount * IFNULL((c_isp.postage_cost_wVat - c_isp.postage_cost_wOutVat) / c_isp.product_amount, 0))  AS TOTAL_TAX_GBP,
ex.avg_rate * ITEM_ISIV  AS ITEM_ISIV_GBP,

IFNULL(pv.SKU, pv2.SKU)  AS SKU,
IFNULL(pv.SKU_VARIANT, pv2.SKU_VARIANT)  AS SKU_VARIANT,
IFNULL(pv.SKU_VARIANT, pv2.SKU_VARIANT)  AS LI_SKU_VARIANT,	
IFNULL(pv.CARD_VARIANT, pv2.CARD_VARIANT)  AS CARD_VARIANT,
IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY)  AS PRODUCT_FAMILY,
IFNULL(pv.CATEGORY_NAME, pv2.CATEGORY_NAME)  AS CATEGORY_NAME,
IFNULL(pv.CATEGORY_PARENT, pv2.CATEGORY_PARENT)  AS CATEGORY_PARENT,
IFNULL(pv.HIERARCHY_RANK_1, pv2.HIERARCHY_RANK_1)  AS HIERARCHY_RANK_1,
IFNULL(pv.HIERARCHY_RANK_2, pv2.HIERARCHY_RANK_2)  AS HIERARCHY_RANK_2,
IFNULL(pv.HIERARCHY_RANK_3, pv2.HIERARCHY_RANK_3)  AS HIERARCHY_RANK_3,
IFNULL(pv.HIERARCHY_RANK_4, pv2.HIERARCHY_RANK_4)  AS HIERARCHY_RANK_4,
IFNULL(pv.PRODUCT_TYPE_NAME, pv2.PRODUCT_TYPE_NAME)  AS PRODUCT_TYPE_NAME	,
IFNULL(pv.PRODUCT_KEY, pv2.PRODUCT_KEY)  AS PRODUCT_KEY	,
IFNULL(pv.FINANCE_PRODUCT_HIERARCHY, pv2.FINANCE_PRODUCT_HIERARCHY)  AS FINANCE_PRODUCT_HIERARCHY,
False  AS IS_ECARD,
IFNULL(pv.SUPPLIER_NAME, pv2.SUPPLIER_NAME)  AS SUPPLIER_NAME,
NULL  AS SUPPLIER_NAME_SAP,
IFNULL(pv.LEGACY_SUPPLIER_ID, pv2.LEGACY_SUPPLIER_ID)  AS LEGACY_SUPPLIER_ID,
NULL  AS ROYALTY_RATE	,
NULL  AS ROYALTY_FLAT_FEE	,
NULL  AS ROYALTY_FLAT_FEE_EUR	,

CASE
	WHEN lower(IFNULL(pv.product_type_name, pv2.product_type_name)) in ('personalised mug', 'personalised t-shirt') THEN lower(IFNULL(pv.mcd_finance_subcategory, pv2.mcd_finance_subcategory))
	ELSE lower(IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY))
END  AS ROYALTY_PRODUCT_CATEGORY,

'NL'  AS ROYALTY_WEBSITE	,
NULL  AS CONTRACT_NO	,
IFNULL(pv.FIRST_PUBLISHED_DATE_TIME, pv2.FIRST_PUBLISHED_DATE_TIME)  AS FIRST_PUBLISHED_DATE_TIME,

IFF(p.type IN ('productCardSingle', 'standardGift', 'personalizedGift') OR p.productcode LIKE 'card%',
    TRIM(SPLIT_PART(IFNULL(pv.reporting_occasion, pv2.reporting_occasion), '>', 1)),
	NULL)	AS OCCASION_GROUP,  
	
CASE 
    WHEN OCCASION_GROUP IS NOT NULL AND LENGTH(SPLIT_PART(IFNULL(pv.reporting_occasion, pv2.reporting_occasion), '>', 2)) > 0 THEN TRIM(SPLIT_PART(IFNULL(pv.reporting_occasion, pv2.reporting_occasion), '>', 2))
    ELSE OCCASION_GROUP
END  AS OCCASION,
	
TRIM(SPLIT_PART(IFNULL(pv.reporting_style, pv2.reporting_style), '>', 1)) AS STYLE_GROUP,

CASE 
    WHEN LENGTH(SPLIT_PART(IFNULL(pv.reporting_style, pv2.reporting_style), '>', 2)) > 0 THEN TRIM(SPLIT_PART(IFNULL(pv.reporting_style, pv2.reporting_style), '>', 2))
    ELSE STYLE_GROUP
END  AS STYLE,
  
IFNULL(pv.MCD_FINANCE_CATEGORY, pv2.MCD_FINANCE_CATEGORY)  AS MCD_FINANCE_CATEGORY,
IFNULL(pv.MCD_FINANCE_SUBCATEGORY, pv2.MCD_FINANCE_SUBCATEGORY)  AS MCD_FINANCE_SUBCATEGORY,
IFNULL(IFNULL(pv.PRODUCT_TITLE, pv2.PRODUCT_TITLE), ol.productcode)  AS PRODUCT_TITLE,
ol.productid  AS PRODUCT_ID,
ol.productamount  AS QUANTITY, 
IFNULL(pv.VARIANT_ID, pv2.VARIANT_ID)  AS VARIANT_ID,
NULL  AS DESIGN_ID	,
NULL  AS UPC	,	
IFF(cd.numberofphotos > 0, cd.numberofphotos, 0)  AS PHOTO_COUNT	,
IFNULL(pv.DELIVERY_TYPE, pv2.DELIVERY_TYPE)  AS DELIVERY_TYPE	,  -- NULL
IFNULL(pv.LETTERBOX_FRIENDLY, pv2.LETTERBOX_FRIENDLY)  AS LETTERBOX_FRIENDLY	,
IFNULL(IFNULL(pv.SHAPE, pv2.SHAPE), IFF(lower(p.PRODUCTCODE) like '%square%', 'Square', 'Rectangular'))  AS SHAPE	,
IFNULL(pv.PRODUCT_BRAND, pv2.PRODUCT_BRAND)  AS PRODUCT_BRAND	,
IFNULL(pv.RANGE, pv2.RANGE)  AS RANGE	,
IFNULL(pv.SIZE, pv2.SIZE)  AS SIZE	,
IFNULL(pv.SEARCH_KEYWORDS, pv2.SEARCH_KEYWORDS)  AS SEARCH_KEYWORDS	,

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
IFNULL(pv.mcd_finance_subcategory, pv2.mcd_finance_subcategory)  AS MARGIN_PRODUCT_CATEGORY,
0  AS ESTIMATED_REFUND_RATE	,
0  AS ESTIMATED_TOTAL_REFUND	,
0  AS ESTIMATED_PRODUCT_REFUND	,
0  AS ESTIMATED_SHIPPING_REFUND	,
ROUND(ITEM_ISEV, 4)  AS ESTIMATED_TOTAL_SALES	,
ROUND((ol.TOTALWITHOUTVAT + IFNULL(co.totalwithoutvat, 0)) * IFNULL(fee.KICK_BACK_FEE, 1),4)  AS ESTIMATED_PRODUCT_SALES	,
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

IFF(IFNULL(pv.CATEGORY_NAME, pv2.CATEGORY_NAME) = 'Greeting Cards' 	-- not 'Postcards'
		AND
		(
		 lower(p.productcode) like '%xl%' 
		 OR lower(p.productcode)  like '%supersize%'
		 )
	   , ol.productamount, 0)  AS GIANT_CARD_QUANTITY	,
	   	   
IFF(IFNULL(pv.CATEGORY_NAME, pv2.CATEGORY_NAME) = 'Greeting Cards' 
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
	
IFF(IFNULL(pv.CATEGORY_NAME, pv2.CATEGORY_NAME) = 'Greeting Cards'
		AND 
		(
		 lower(p.productcode) like '%medium%' 
		 AND cd.cardratio = 'SQUARE'
		 )
	   , ol.productamount, 0) AS STANDARD_SQUARE_CARD_QUANTITY	,
	
IFF(IFNULL(pv.CATEGORY_NAME, pv2.CATEGORY_NAME) = 'Greeting Cards'
		AND 
		(
		 lower(p.productcode) like '%medium%' 
		 AND cd.cardratio = 'STANDARD'
		 )
	   , ol.productamount, 0) AS STANDARD_CARD_QUANTITY	,
	
IFF(IFNULL(pv.CATEGORY_NAME, pv2.CATEGORY_NAME) = 'Postcards', ol.productamount, 0)  AS POSTCARD_QUANTITY,
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
IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY)  AS MCD_PRODUCT_FAMILY,

CASE
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Cards' THEN 'Greeting Cards'
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Flowers' THEN 'Flowers'
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFNULL(pv.product_type_name, pv2.product_type_name) IN ('Alcohol','Personalised Alcohol') THEN 'Alcohol Gift'
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFNULL(pv.product_type_name, pv2.product_type_name) = 'Balloon' THEN 'Balloon'
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFNULL(pv.product_type_name, pv2.product_type_name) = 'Beauty' THEN 'Beauty'
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFNULL(pv.product_type_name, pv2.product_type_name) IN ('Biscuit','Chocolate','Hamper','Sweet') THEN 'Food Gifts'
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFNULL(pv.product_type_name, pv2.product_type_name) = 'Gadget / Novelty' THEN 'Gadgets & Novelties'
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFNULL(pv.product_type_name, pv2.product_type_name) = 'Gift Experience' THEN 'Gift Experiences'
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFNULL(pv.product_type_name, pv2.product_type_name) = 'Gift for Home' THEN 'Gifts For Home'
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFNULL(pv.product_type_name, pv2.product_type_name) = 'Jewellery' THEN 'Jewellery & Accessories'
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFNULL(pv.product_type_name, pv2.product_type_name) = 'Arena Gift Set' THEN 'Letterbox Gifts'
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFNULL(pv.product_type_name, pv2.product_type_name) = 'Personalised Mug' THEN 'Mugs'
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFNULL(pv.product_type_name, pv2.product_type_name) = 'Soft Toy' THEN 'Soft Toys'
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFNULL(pv.product_type_name, pv2.product_type_name) = 'Stationery / Craft' THEN 'Stationery & Craft'
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFNULL(pv.product_type_name, pv2.product_type_name) = 'Personalised T-shirt' THEN 'T-Shirts'
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFNULL(pv.product_type_name, pv2.product_type_name) = 'Toy / Game' THEN 'Toys & Games'
ELSE NULL
END  AS MCD_PRODUCT_CATEGORY,

CASE
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Cards' AND RIGHT(IFNULL(pv.size, pv2.size),4) = 'CARD' AND IFNULL(pv.size, pv2.size) NOT IN ('ECard', 'ECARD', 'POSTCARD') THEN CONCAT(INITCAP(LOWER(LEFT(IFNULL(pv.size, pv2.size),CHARINDEX('CARD',IFNULL(pv.size, pv2.size)) - 1))),' Card')
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Cards' AND RIGHT(IFNULL(pv.size, pv2.size),4) <> 'CARD' AND IFNULL(pv.size, pv2.size) NOT IN ('ECard', 'ECARD', 'POSTCARD') THEN CONCAT(IFNULL(pv.size, pv2.size),' Card')
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Cards' AND IFNULL(pv.size, pv2.size) IN ('ECard','ECARD') THEN 'eCard'
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Cards' AND IFNULL(pv.size, pv2.size) = 'POSTCARD' THEN 'Postcard'
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Flowers' AND LOWER(IFNULL(pv.size, pv2.size)) = 'large' THEN 'Flowers - Extra Stems'
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Flowers' AND LOWER(IFNULL(pv.size, pv2.size)) = 'letterbox' THEN 'Letterbox Flowers'
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Flowers' AND LOWER(IFNULL(pv.size, pv2.size)) NOT IN ('large', 'letterbox') THEN 'Flowers'
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFNULL(pv.product_type_name, pv2.product_type_name) IN ('Alcohol','Personalised Alcohol') THEN 'Alcohol Gift'
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFNULL(pv.product_type_name, pv2.product_type_name) = 'Balloon' THEN 'Balloon'
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFNULL(pv.product_type_name, pv2.product_type_name) = 'Beauty' THEN 'Beauty'
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFNULL(pv.product_type_name, pv2.product_type_name) IN ('Biscuit','Chocolate','Hamper','Sweet')  THEN 'Food Gifts'
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFNULL(pv.product_type_name, pv2.product_type_name) = 'Gadget / Novelty' THEN 'Gadgets & Novelties'
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFNULL(pv.product_type_name, pv2.product_type_name) = 'Gift Experience' THEN 'Gift Experiences'
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFNULL(pv.product_type_name, pv2.product_type_name) = 'Gift for Home' THEN 'Gifts For Home'
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFNULL(pv.product_type_name, pv2.product_type_name) = 'Jewellery' THEN 'Jewellery & Accessories'
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFNULL(pv.product_type_name, pv2.product_type_name) = 'Arena Gift Set' THEN 'Letterbox Gifts'
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFNULL(pv.product_type_name, pv2.product_type_name) = 'Personalised Mug' THEN 'Mugs'
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFNULL(pv.product_type_name, pv2.product_type_name) = 'Soft Toy' THEN 'Soft Toys'
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFNULL(pv.product_type_name, pv2.product_type_name) = 'Stationery / Craft' THEN 'Stationery & Craft'
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFNULL(pv.product_type_name, pv2.product_type_name) = 'Personalised T-shirt' THEN 'T-Shirts'
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFNULL(pv.product_type_name, pv2.product_type_name) = 'Toy / Game' THEN 'Toys & Games'
ELSE NULL
END  AS MCD_PRODUCT_SUBCATEGORY	,

CASE
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Cards' AND RIGHT(IFNULL(pv.size, pv2.size),4) = 'CARD' AND IFNULL(pv.size, pv2.size) NOT IN ('ECard', 'ECARD', 'POSTCARD') THEN CONCAT(INITCAP(LOWER(LEFT(IFNULL(pv.size, pv2.size),CHARINDEX('CARD',IFNULL(pv.size, pv2.size)) - 1))),' Card')
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Cards' AND RIGHT(IFNULL(pv.size, pv2.size),4) <> 'CARD' AND IFNULL(pv.size, pv2.size) NOT IN ('ECard', 'ECARD', 'POSTCARD') THEN CONCAT(IFNULL(pv.size, pv2.size),' Card')
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Cards' AND IFNULL(pv.size, pv2.size) IN ('ECard','ECARD') THEN 'eCard'
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Cards' AND IFNULL(pv.size, pv2.size) = 'POSTCARD' THEN 'Postcard'
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Flowers' AND LOWER(IFNULL(pv.size, pv2.size)) = 'large' THEN 'Flowers - Extra Stems'
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Flowers' AND LOWER(IFNULL(pv.size, pv2.size)) = 'letterbox' THEN 'Letterbox Flowers'
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Flowers' AND LOWER(IFNULL(pv.size, pv2.size)) NOT IN ('large', 'letterbox') THEN 'Flowers'
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFNULL(pv.product_type_name, pv2.product_type_name) IN ('Alcohol','Personalised Alcohol') THEN 'Alcohol Gift'
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFNULL(pv.product_type_name, pv2.product_type_name) = 'Balloon' THEN 'Balloon'
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFNULL(pv.product_type_name, pv2.product_type_name) = 'Beauty' THEN 'Beauty'
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFNULL(pv.product_type_name, pv2.product_type_name) IN ('Biscuit','Chocolate','Hamper','Sweet') THEN CONCAT(IFNULL(pv.product_type_name, pv2.product_type_name),'s')
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFNULL(pv.product_type_name, pv2.product_type_name) = 'Gadget / Novelty' THEN 'Gadgets & Novelties'
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFNULL(pv.product_type_name, pv2.product_type_name) = 'Gift Experience' THEN 'Gift Experiences'
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFNULL(pv.product_type_name, pv2.product_type_name) = 'Gift for Home' THEN 'Gifts For Home'
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFNULL(pv.product_type_name, pv2.product_type_name) = 'Jewellery' THEN 'Jewellery & Accessories'
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFNULL(pv.product_type_name, pv2.product_type_name) = 'Arena Gift Set' THEN 'Letterbox Gifts'
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFNULL(pv.product_type_name, pv2.product_type_name) = 'Personalised Mug' THEN 'Ceramic Mug'
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFNULL(pv.product_type_name, pv2.product_type_name) = 'Soft Toy' THEN 'Soft Toy'
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFNULL(pv.product_type_name, pv2.product_type_name) = 'Stationery / Craft' THEN 'Stationery & Craft'
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFNULL(pv.product_type_name, pv2.product_type_name) = 'Personalised T-shirt' THEN IFNULL(pv.size, pv2.size)
        WHEN IFNULL(pv.PRODUCT_FAMILY, pv2.PRODUCT_FAMILY) = 'Gifts' AND IFNULL(pv.product_type_name, pv2.product_type_name) = 'Toy / Game' THEN 'Toys & Games'
ELSE NULL
END  AS MCD_PRODUCT_TYPE

FROM
--	 (SELECT * FROM "RAW_GREETZ"."GREETZ3".orders WHERE created > '2022-06-01' ORDER BY created LIMIT 1000) o
-- 	 (SELECT * FROM "RAW_GREETZ"."GREETZ3".orders WHERE id = 1266779435 /*1323191458 1347309071 1336681263*/) o
  "PROD"."WORKSPACE_GREETZ_HISTORY_MIGRATION"."DIFF_ESIV" e
    JOIN "RAW_GREETZ"."GREETZ3".orders o on e.order_id = o.id
  --  "RAW_GREETZ"."GREETZ3".orders o
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
	LEFT JOIN "PROD"."WORKSPACE_GREETZ_HISTORY_MIGRATION"."PRODUCT_VARIANTS_DETAILED" AS pv
		ON pv.GREETZ_PRODUCT_ID = ol.productid 
			AND pv.GREETZ_CARDDEFINITION_ID = c.carddefinition 
	LEFT JOIN "PROD"."WORKSPACE_GREETZ_HISTORY_MIGRATION"."PRODUCT_VARIANTS_DETAILED" AS pv2
		ON pv2.GREETZ_PRODUCT_ID = ol.productid 
			AND pv2.GREETZ_CARDDEFINITION_ID = 0	
	LEFT JOIN prod.raw_seeds.us_zipcodes AS zc
		ON zc.ZIPCODE = TRY_TO_NUMBER(IFNULL(a.ZIPPOSTALCODE, a2.ZIPPOSTALCODE))
			AND IFNULL(a.COUNTRYCODE, a2.COUNTRYCODE) = 'US'
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

SELECT od.order_id, SUM(od.item_esev) as item_esev , AVG(os.ORDER_ESEV) as ORDER_ESEV -- AVG(ORDER_ISIV)
, SUM(od.item_ISIV) as item_ISIV, AVG(os.ORDER_ISIV) as ORDER_ISIV
, SUM(od.item_ISEV) as item_ISEV, AVG(os.ORDER_ISEV) as ORDER_ISEV
, SUM(od.item_esiv) as item_esiv, AVG(os.ORDER_ESIV) as ORDER_ESIV
FROM  cte_Res od
    join  "PROD"."WORKSPACE_GREETZ_HISTORY_MIGRATION"."RAW_GREETZ_CT_ORDERS_STAGING_BACKFILL" os
        ON od.ORDER_ID = os.ORDER_ID
GROUP BY 1
/*having abs(SUM(od.item_isiv) -  AVG(os.ORDER_ISIV)) < 0.00001
and  abs(SUM(od.item_isev) - AVG(os.ORDER_ISEV)) < 0.00001
and  abs(SUM(od.item_esiv) - AVG(os.ORDER_ESIV)) < 0.00001
and  abs(SUM(od.item_esev) - AVG(os.ORDER_ESEV)) < 0.00001*/

having abs(SUM(od.item_isiv) -  AVG(os.ORDER_ISIV)) > 0.00001
or  abs(SUM(od.item_isev) - AVG(os.ORDER_ISEV)) > 0.00001
or  abs(SUM(od.item_esiv) - AVG(os.ORDER_ESIV)) > 0.00001
or  abs(SUM(od.item_esev) - AVG(os.ORDER_ESEV)) > 0.00001
)

/*SELECT order_id, SUM(item_esev) as item_esev , AVG(ORDER_ESEV) as ORDER_ESEV -- AVG(ORDER_ISIV)
, SUM(item_ISIV) as item_ISIV, AVG(ORDER_ISIV) as ORDER_ISIV
, SUM(item_ISEV) as item_ISEV, AVG(ORDER_ISEV) as ORDER_ISEV
, SUM(item_esiv) as item_esiv, AVG(ORDER_ESIV) as ORDER_ESIV
FROM  cte_Res
GROUP BY 1
having abs(SUM(item_isiv) -  AVG(ORDER_ISIV)) > 0.00001
or  abs(SUM(item_isev) - AVG(ORDER_ISEV)) > 0.00001
or  abs(SUM(item_esiv) - AVG(ORDER_ESIV)) > 0.00001
or  abs(SUM(item_esev) - AVG(ORDER_ESEV)) > 0.00001*/
  

;		
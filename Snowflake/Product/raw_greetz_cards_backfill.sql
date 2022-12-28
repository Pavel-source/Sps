CREATE OR REPLACE TABLE "PROD"."WORKSPACE_GREETZ_HISTORY_MIGRATION"."RAW_GREETZ_CARDS_BACKFILL" AS (

WITH ProductList
AS
(
SELECT DISTINCT 
				concat( case when pc.AMOUNTOFPANELS = 2 
							then concat('GRTZ', cast(cd.ID as varchar(50))) 
							else concat('GRTZ', cast(cd.ID as varchar(50)), '-P') 
						end,
						case pc.cardratio when 'SQUARE' 
							then '-SQ'
							else ''
						end)
				AS entity_key, 
				
				cd.ID AS carddefinitionid,
				cd.contentinformationid, pc.productid, 
				p.PRODUCTCODE, cd.showonstore, pc.CARDSIZE, pc.cardratio, cd.ORIENTATION, 
				cd.CONTENTCOLLECTIONID, numberofphotos,
				cif_nl_title.text  		AS nl_product_name,

				case pc.cardratio
					when 'STANDARD' then 'rectangular'
					when 'SQUARE'   then 'square'
				end  AS  Attribute_Shape,

				case 
					when pc.CARDSIZE = 'MEDIUM' /*AND pc.cardratio = 'STANDARD'*/ then 'standard'
					when pc.CARDSIZE = 'LARGE' AND pc.cardratio = 'SQUARE' then 'standard'
					when pc.CARDSIZE = 'XXL' then 'large'
					when pc.CARDSIZE = 'SUPERSIZE' then 'giant'
					
					when pc.CARDSIZE = 'XL' then 'xl'
					when pc.CARDSIZE = 'MINI' then 'mini'
					when pc.CARDSIZE = 'SMALL' then 'small'
					when pc.CARDSIZE = 'LARGE' then 'large'
				end  AS Attribute_Size,

                pc.AMOUNTOFPANELS                     
				
FROM RAW_GREETZ.GREETZ3.productcard pc
	 JOIN RAW_GREETZ.GREETZ3.carddefinition cd 
			ON cd.CARDRATIO = pc.CARDRATIO 
				AND cd.OBLONG = pc.OBLONG 
				AND (cd.NUMBEROFPANELS = pc.AMOUNTOFPANELS 
					 OR (pc.AMOUNTOFPANELS = 1 AND cd.NUMBEROFPANELS = 2 AND cd.allowsinglepanel = 'Y'))
     JOIN RAW_GREETZ.GREETZ3.product p 
		ON pc.PRODUCTID = p.ID 
			AND p.TYPE = 'productCardSingle' 
			AND p.CHANNELID = 2 
     JOIN RAW_GREETZ.GREETZ3.carddefinition_limitedcardsize cdl 
		ON cdl.CARDDEFINITIONID = cd.ID 
			AND pc.CARDSIZE = cdl.CARDSIZE
	 LEFT JOIN RAW_GREETZ.GREETZ3.contentinformationfield cif_nl_title
		  ON cif_nl_title.contentinformationid = cd.contentinformationid
			 AND cif_nl_title.type = 'TITLE' AND cif_nl_title.locale = 'nl_NL'

/*WHERE
	  cdc.channelID = '2'
	  AND (
			(pc.AMOUNTOFPANELS = 2 AND pc.cardratio = 'STANDARD'  AND pc.CARDSIZE IN ('MEDIUM', 'XXL', 'SUPERSIZE')) 
			OR (pc.AMOUNTOFPANELS = 2 AND pc.cardratio = 'SQUARE' AND pc.CARDSIZE IN ('LARGE', 'XXL', 'SUPERSIZE')) 
			OR (pc.AMOUNTOFPANELS = 1 AND pc.CARDSIZE = 'MEDIUM')
		  )	 */
	-- AND cif_nl_title.text IS NOT NULL
),

Carddefinition_Grouped AS
(
SELECT DISTINCT carddefinitionid, contentinformationid, CONTENTCOLLECTIONID
FROM ProductList
),

Brands AS
(
SELECT cd.carddefinitionid, MIN(ct.text) AS Brand	
FROM Carddefinition_Grouped cd
	JOIN RAW_GREETZ.GREETZ3.contentinformation_category ci 
		ON cd.contentinformationid = ci.contentinformationid
	JOIN RAW_GREETZ.GREETZ3.contentcategory cc
		ON cc.id = ci.contentcategoryid
	JOIN RAW_GREETZ.GREETZ3.contentcategorytype cct
		ON cct.ID = cc.categorytypeid
	JOIN RAW_GREETZ.GREETZ3.contentcategorytranslation ct
		ON ct.contentcategoryid = cc.id AND ct.locale = 'en_EN'
WHERE cct.INTERNALNAME = 'Brand/Designer'
GROUP BY cd.carddefinitionid
),

Ignore_AgeCategory
AS
(
SELECT DISTINCT pl.carddefinitionid
FROM Carddefinition_Grouped pl
	 JOIN RAW_GREETZ.GREETZ3.contentinformation_category ci
		ON ci.contentinformationid = pl.contentinformationid 
WHERE ci.contentcategoryid IN
								(
								1039192272,		-- Zusje
								1143733843,		-- vrouw
								1143750947,		-- Women
								1143750956,		-- Men
								1143754568,		-- Little sister
								1143754571,		-- Little brother
								1143758798,		-- Little niece
								1143758803,		-- Little nephew
								1143758818,		-- Little son
								1143758823,		-- Little daughter
								1143757863,		-- Little granddaughter
								1143757858		-- Little grandson
								)
),					 

-- -------------- attributes Occasion, Style, Relation   ---------------------------
attrs_0 AS
(
SELECT DISTINCT cct.INTERNALNAME, cd.carddefinitionid, cd.contentinformationid, ct.TEXT AS Val, ci.CONTENTCATEGORYID AS catID, cc.parentcategoryid
FROM Carddefinition_Grouped cd
	JOIN RAW_GREETZ.GREETZ3.contentinformation_category ci ON ci.CONTENTINFORMATIONID = cd.CONTENTINFORMATIONID
	JOIN RAW_GREETZ.GREETZ3.contentcategory cc ON cc.ID = ci.CONTENTCATEGORYID
	JOIN RAW_GREETZ.GREETZ3.contentcategorytype cct ON cct.ID = cc.categorytypeid 
	JOIN RAW_GREETZ.GREETZ3.contentcategorytranslation ct ON ct.CONTENTCATEGORYID = cc.ID  AND ct.LOCALE = 'en_EN'
WHERE cct.INTERNALNAME IN ('Occasion', 'Design Style', 'Target Group')
	 AND (cct.INTERNALNAME != 'Design Style' OR lower(ct.TEXT) NOT IN ('hip' ,'with flowers', 'cute', 'english cards', 'dutch cards'))
)

,
attr_Single_Val AS
(
SELECT INTERNALNAME, carddefinitionid, MIN(Val) AS Val
FROM attrs_0
GROUP BY INTERNALNAME, carddefinitionid
HAVING COUNT(*) = 1
),

attr_2 AS 
(
SELECT DISTINCT INTERNALNAME, carddefinitionid 
FROM attrs_0 AS cte1
WHERE EXISTS (SELECT 1 
			  FROM attrs_0 AS cte2 
			  WHERE cte1.INTERNALNAME = cte2.INTERNALNAME 
					AND cte1.carddefinitionid = cte2.carddefinitionid 
					AND cte1.parentcategoryid = cte2.catID)
),

attr_3 AS 
(
SELECT cte.INTERNALNAME, 
	cte.carddefinitionid, 
	
	-- GROUP_CONCAT(Val ORDER BY parentcategoryid, case when Val like '%years%' then 1 else 0 end, catID  SEPARATOR ' - ') AS Concat_1, 		-- just concatination	
	-- GROUP_CONCAT(DISTINCT case when parentcategoryid IS NOT NULL then '' else Val END  ORDER BY catID SEPARATOR '') AS Concat_2,  -- parents only
	-- GROUP_CONCAT(DISTINCT case when parentcategoryid IS NULL then '' else Val END  ORDER BY catID SEPARATOR '') AS Concat_3,  -- childs only 	
    LISTAGG(Val, ' - ') within group (ORDER BY parentcategoryid DESC, case when Val like '%years%' then 1 else 0 end, cte.catID) AS Concat_1, 		-- just concatination	
	LISTAGG(case when parentcategoryid IS NOT NULL then '' else Val END, '') within group (ORDER BY cte.catID) AS Concat_2,  -- parents only
	LISTAGG(case when parentcategoryid IS NULL then '' else Val END, '') within group(ORDER BY cte.catID) AS Concat_3,  -- childs only 
	
	SUM(case when parentcategoryid IS NULL then 1 ELSE 0 end) AS parents_cnt,		-- with out childs, amount
	COUNT(*) AS cnt
	-- ,COUNT(DISTINCT CatID) AS cnt_for_check
FROM attrs_0 AS cte 
	JOIN attr_2 AS cte_2 ON cte_2.INTERNALNAME = cte.INTERNALNAME AND cte_2.carddefinitionid = cte.carddefinitionid  
GROUP BY cte.INTERNALNAME,
		 cte.carddefinitionid 
),

attr_5 AS
(
SELECT INTERNALNAME,
	   carddefinitionid, 
	   case 
			when INTERNALNAME = 'Occasion' then Concat_1 
			else IFNULL(Concat_3, Concat_2)
	   end  AS Val
FROM attr_3 
WHERE parents_cnt = 1 AND (cnt = 2 OR INTERNALNAME = 'Occasion')
UNION ALL
SELECT INTERNALNAME, carddefinitionid, Val
FROM attr_Single_Val
),

attr AS
(
SELECT INTERNALNAME,
	   carddefinitionid,
	   MIN(lower(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(Val, ' - ' , '-'), ' ' , '-'), '&' , '-and-'), '+' , 'plus'), '?' , ''),     '''' , '_'), '(' , ''), ')' , ''), '%', ''), '.', ''), '/', ''), '!', ''), 'ë', 'e'), '’', '_'), '*', '')))	AS Val_Code,
	   MIN(concat(UPPER(LEFT(Val, 1)), SUBSTRING(Val ,2)))  AS Val_Name	   
FROM attr_5
GROUP BY INTERNALNAME,
	   carddefinitionid
)

-- ----------------------------------------------------------

SELECT 
pl.carddefinitionid	AS	PRODUCT_ID,
ROW_NUMBER() OVER(PARTITION BY pl.carddefinitionid ORDER BY pl.Attribute_Size DESC) 	AS	VARIANT_ID	,
CONCAT(pl.carddefinitionid, '-', ROW_NUMBER() OVER(PARTITION BY pl.carddefinitionid ORDER BY pl.Attribute_Size DESC))	AS	PRODUCT_VARIANT_ID	,
pl.entity_key	AS	SKU	,

concat(pl.entity_key, 
'-', 
upper(pl.Attribute_Size), 
case pl.Attribute_Shape when 'square' then 'SQUARE' else '' end, 
'CARD')	AS	SKU_VARIANT	,

current_timestamp()	AS	PRODUCT_CREATED_AT	,
current_timestamp()	AS	VARIANT_CREATED_AT	,
FALSE	AS	IS_PUBLISHED	,
NULL	AS	FIRST_PUBLISHED_DATE_TIME	,
nl_product_name	AS	PRODUCT_TITLE	,

case 
		when (cif_nl_descr.text IS NOT NULL  OR  cif_nl_descr_2.text IS NOT NULL)
		then concat(IFNULL(concat(cif_nl_descr_2.text, '\n\n'), ''), IFNULL(cif_nl_descr.text, '')) 
		else cif_nl_descr.text												           
end		AS	PRODUCT_DESCRIPTION	,
		
case pl.AMOUNTOFPANELS when 1 then 'Postcards'	 else 'Greeting Cards' end    AS	CATEGORY_NAME	,
'Cards'		AS	CATEGORY_PARENT	,
'Cards'     AS	HIERARCHY_RANK_1	,
case pl.AMOUNTOFPANELS when 1 then 'Postcards'	 else 'Greeting Cards' end    AS	HIERARCHY_RANK_2	,
NULL		AS	HIERARCHY_RANK_3	,
NULL		AS	HIERARCHY_RANK_4	,
NULL		AS	HIERARCHY_RANK_5	,
NULL		AS	UNIQUE_PRODUCT_CODE	,
case when pl.numberofphotos >= 0 then pl.numberofphotos else 0 end	AS	PHOTO_COUNT	,
NULL	AS	DELIVERY_TYPE	,
NULL	AS	LETTERBOX_FRIENDLY	,
case pl.Attribute_Shape when 'square' then 'Square' else 'Rectangular' end	AS	SHAPE	,
NULL	AS	IMAGE_HEIGHT	,
NULL	AS	IMAGE_WIDTH	,
case pl.Attribute_Shape when 'square' then 'square' else 'portrait' end	AS	ORIENTATION	,
CONCAT('{"en":"', IFF(b.Brand = 'Blank Cards', NULL, b.Brand), '"}')	AS	PRODUCT_BRAND	,
IFNULL(pr.product_range_text,'Tangled')	AS	RANGE	,
NULL	AS	ARENA_ID	,
IFNULL(pr.product_range_key,'range-tangled')	AS	PRODUCT_RANGE	,
NULL	AS	NOTES	,
COALESCE(a_oc.Val_Name, a_oc_2.occasion_name, 'General > General')	AS	REPORTING_OCCASION	,
IFNULL(a_des.Val_Name, 'Design > General')	AS	REPORTING_STYLE	,
IFNULL(a_rl_2.MP_Name, 'Non relations')	AS	REPORTING_RELATION	,
'Anonymous'	AS	REPORTING_ARTIST	,
NULL	AS	REPORTING_SUPPLIER	,
NULL	AS	REPORTING_SUPPLIER_NO	,
initcap(Attribute_Size)  AS	SIZE,	
concat(initcap(Attribute_Size), ' Card')  AS	MCD_SIZE	,

CONCAT('{"categories":[',
				IFNULL(
				(
					 SELECT CONCAT('"', LISTAGG(DISTINCT(mc.MPCategoryKey), '", "'), '"') -- within group (order by mc.MPCategoryKey)
					 FROM RAW_GREETZ.GREETZ3.contentinformation_category ci
						 JOIN RAW_GREETZ.GREETZ3.contentcategory cc
							ON cc.id = ci.contentcategoryid
						 JOIN RAW_GREETZ.GREETZ3.contentcategorytype c
							ON cc.categorytypeid = c.id	 
						 JOIN RAW_GREETZ.GREETZ3.greetz_to_mnpq_categories_cards_view_2 mc 
							ON mc.GreetzCategoryID = cc.id 
					 WHERE ci.contentinformationid = pl.contentinformationid  
							AND mc.MPCategoryKey IS NOT NULL
							AND (
								  ig.carddefinitionid IS NULL  
								  OR (mc.MPCategoryKey NOT LIKE '%years-old' AND mc.MPCategoryKey NOT IN ('all-kids', 'age-other', 'age-unspecified', 'age-groups'))
								)		
				--	ORDER BY mc.MPCategoryKey
								)  
			   , 'greeting-cards')
		, case when pl.numberofphotos > 0 then ', photo-cover-cards' else '' end,
		']}')
	   AS	CATEGORIES	,
	 
CONCAT('{',
IFNULL(
		CONCAT(
			'"en":[',
		  (  SELECT  CONCAT('"', LISTAGG(REPLACE(ct2.text, '"', ''''), '", "'), '"') -- within group (order by ct2.text)
			 FROM RAW_GREETZ.GREETZ3.contentinformation_category ci
				 JOIN RAW_GREETZ.GREETZ3.contentcategory cc
						   ON cc.id = ci.contentcategoryid
				 LEFT JOIN RAW_GREETZ.GREETZ3.contentcategorytranslation ct2
						   ON ct2.contentcategoryid = cc.id AND ct2.locale = 'en_EN'
			 WHERE ci.contentinformationid = pl.contentinformationid
			-- ORDER BY ct2.text
			 ),
			'],'
		)
, ''),	
IFNULL(
	CONCAT(
	 '"nl":[',
		(SELECT CONCAT('"', LISTAGG(REPLACE(IFNULL(ct.text, ct2.text), '"', ''''), '", "'), '"') -- within group (order by IFNULL(ct.text, ct2.text))
	     FROM RAW_GREETZ.GREETZ3.contentinformation_category ci
			 JOIN RAW_GREETZ.GREETZ3.contentcategory cc
					   ON cc.id = ci.contentcategoryid
			 LEFT JOIN RAW_GREETZ.GREETZ3.contentcategorytranslation ct
					   ON ct.contentcategoryid = cc.id AND ct.locale = 'nl_NL'
			 LEFT JOIN RAW_GREETZ.GREETZ3.contentcategorytranslation ct2
					   ON ct2.contentcategoryid = cc.id AND ct2.locale = 'en_EN'
		 WHERE ci.contentinformationid = pl.contentinformationid
		-- ORDER BY IFNULL(ct.text, ct2.text)
		 ),
	']'
	)
, ''),		 		 
'}')
AS	SEARCH_KEYWORDS	,
	
'Wenskaarten'	AS	PRODUCT_TYPE_NAME	,
'greetingcard'	AS	PRODUCT_KEY	,
'Cards'	AS	PRODUCT_FAMILY	,
FALSE	AS	IS_PRODUCT_VARIANT_DELETED	,
NULL	AS	PRODUCT_VARIANT_DELETED_TIMESTAMP	,
FALSE	AS	IS_PRODUCT_DELETED	,
NULL	AS	PRODUCT_DELETED_TIMESTAMP	,
spl.channel_key	AS	SUPPLIER_NAME	,
NULL	AS	LEGACY_SUPPLIER_ID	,
NULL	AS	SUPPLIER_CITY	,
NULL	AS	SUPPLIER_COUNTRY	,
NULL	AS	MCD_FINANCE_CATEGORY	,
NULL	AS	MCD_FINANCE_SUBCATEGORY	,
current_timestamp()	AS	MESSAGE_TIMESTAMP	,
'grtz'	AS	BRAND	,
IFNULL(pr.product_range_key,'range-tangled')	AS	RANGE_ID	,
NULL	AS	FINANCE_PRODUCT_HIERARCHY	,
'Greetz'	AS	BRAND_DESCRIPTION	,

pl.carddefinitionid	AS	GREETZ_PRODUCT_ID	

FROM ProductList pl	
	 LEFT JOIN RAW_GREETZ.GREETZ3.contentinformationfield cif_nl_descr
		  ON cif_nl_descr.contentinformationid = pl.contentinformationid
			 AND cif_nl_descr.type = 'DESCRIPTION' AND cif_nl_descr.locale = 'nl_NL'
	 LEFT JOIN RAW_GREETZ.GREETZ3.contentinformationfield cif_nl_descr_2
		  ON cif_nl_descr_2.contentinformationid = pl.contentinformationid
			 AND cif_nl_descr_2.type = 'PRODUCT_DESCRIPTION' AND cif_nl_descr_2.locale = 'nl_NL'	
	 LEFT JOIN attr a_oc	
		  ON a_oc.carddefinitionid = pl.carddefinitionid AND a_oc.INTERNALNAME = 'Occasion'
	 LEFT JOIN attr a_des	
		  ON a_des.carddefinitionid = pl.carddefinitionid AND a_des.INTERNALNAME = 'Design Style'			  
	 LEFT JOIN attr a_tgt	
		  ON a_tgt.carddefinitionid = pl.carddefinitionid AND a_tgt.INTERNALNAME = 'Target Group'			  
	 LEFT JOIN RAW_GREETZ.GREETZ3.greetz_to_mnpg_relations_view_2 a_rl_2
		  ON a_rl_2.Greetz_Name = a_tgt.Val_Name		  
	 LEFT JOIN RAW_GREETZ.GREETZ3.greetz_to_mnpg_ranges_map_view_2 pr
		  ON pr.content_collection_ID = pl.CONTENTCOLLECTIONID	
	 LEFT JOIN RAW_GREETZ.GREETZ3.greetz_to_mnpg_multioccasions_view_2 a_oc_2
		  ON a_oc_2.design_id = pl.carddefinitionid		
	 LEFT JOIN Ignore_AgeCategory ig
		  ON ig.carddefinitionid = pl.carddefinitionid	
	 LEFT JOIN RAW_GREETZ.GREETZ3.export_productranges_view_2 spl
			ON pr.product_range_key = spl.entity_key
	 LEFT JOIN Brands b 
			ON pl.carddefinitionid = b.carddefinitionid
-- WHERE
--		((inv.carddefinitionid IS NULL AND Attribute_Size IS NOT NULL) OR  Attribute_Size = 'standard')
--		AND (nl_product_name IS NOT NULL  OR cif_nl_descr.text IS NOT NULL  OR  cif_nl_descr_2.text IS NOT NULL  OR pl.contentinformationid IS NOT NULL)
GROUP BY 
	pl.entity_key,
	 pl.Attribute_Size,
	 pl.carddefinitionid,
	 pl.contentinformationid,
	 pl.Attribute_Shape,
	 nl_product_name,
	 cif_nl_descr.text,
	 cif_nl_descr_2.text,
	 pl.numberofphotos,
	pr.product_range_text,
	pr.product_range_key,
	a_oc.Val_Name, 
	a_des.Val_Name, 
	a_rl_2.MP_Name, 
	a_oc_2.occasion_name,
	ig.carddefinitionid,
	spl.channel_key,
	b.Brand,
	pl.AMOUNTOFPANELS
ORDER BY 
	pl.entity_key,
	pl.Attribute_Size	
)	
CREATE OR REPLACE TABLE "PROD"."WORKSPACE_GREETZ_HISTORY_MIGRATION"."RAW_GREETZ_GIFTS_BACKFILL" AS (

WITH 
productList_withAttributes AS
(
SELECT  pl.ID, 
		SUM(case when c.INTERNALNAME = 'Size' AND lower(ct.text) = 'large' then 1 else 0 end) as LargeAtr,	
		SUM(case when (ci.contentcategoryid in (1143763303, 1143763773, 1143731608, 1143732596, 1143737611, 1143735338, 1143730173, 1143730254) 
					   OR lower(ct.text) like '%letterbox%')
					AND pl.ID != 1142812037			
			then 1 else 0 end) as LetterboxAtr,
			
		SUM(case when lower(ct.text) = 'jewellery' then 1 else 0 end) as jewellery,
		SUM(case when lower(ct.text) LIKE '%gadget%' then 1 else 0 end) as gadget
FROM "RAW_GREETZ"."GREETZ3".product pl
	 JOIN "RAW_GREETZ"."GREETZ3".contentinformation_category ci
		  ON pl.contentinformationid = ci.contentinformationid
	 JOIN "RAW_GREETZ"."GREETZ3".contentcategory cc
		  ON cc.id = ci.contentcategoryid
	 JOIN "RAW_GREETZ"."GREETZ3".contentcategorytype c
	      ON cc.categorytypeid = c.id
	 LEFT JOIN "RAW_GREETZ"."GREETZ3".contentcategorytranslation ct
		  ON ct.contentcategoryid = cc.id
			AND ct.locale = 'en_EN'
WHERE -- pl.TYPE IN ('standardGift', 'personalizedGift', 'gift_addon')
	  pl.CHANNELID = '2'
	  AND c.INTERNALNAME != 'Keywords'   
GROUP BY pl.ID		  
),

Brands AS
(
SELECT p.id, MIN(ct.text) AS Brand	
FROM "RAW_GREETZ"."GREETZ3".product p
	 JOIN "RAW_GREETZ"."GREETZ3".contentinformation_category ci
		  ON p.contentinformationid = ci.contentinformationid
	 JOIN "RAW_GREETZ"."GREETZ3".contentcategory cc
		  ON cc.id = ci.contentcategoryid
	 JOIN "RAW_GREETZ"."GREETZ3".contentcategorytranslation ct
		  ON ct.contentcategoryid = cc.id
			AND ct.locale = 'en_EN'
	 JOIN "RAW_GREETZ"."GREETZ3".contentcategorytype c
	      ON cc.categorytypeid = c.id
WHERE c.INTERNALNAME = 'Brand/Designer' 
	  AND p.CHANNELID = '2'
GROUP BY p.id
),

productList_0 AS
(
SELECT DISTINCT p.ID, pt.entity_key, p.contentinformationid, pt.DefaultCategoryKey, pt.CategoryCode,
		p.removed, p.type,

		case 
			  when p.TYPE = 'gift_addon' then 'addon' 
			  when pgt.internalname = 'Personalised Beverage' then 'personalised-alcohol'
			  
when p.id IN (
1142781265,
1142814538,
1142818063,
1142811901,
1142815458	,
1142815453	,
1142815638	,
1142812815	,
1142812809	,
1142812824	,
1142815483	,
1142812818	,
1142815468	,
1142815473	,
1142815478	,
1142815463	,
1142812827	,
1142815548	,
1142815438  ,
1142818558  ,
1142818653  
					) then 'home-gift'			  
			  
			  when p.id IN (
1142812722,			  
1142811995,
1142811998,
1142812019,
1142812064,
1142812067,
1142812076,
1142812097,
1142812133,
1142812136,
1142812322,
1142812370,
1142812749,
1142812755,
1142815268,
1142815288,
1142815293,
1142815333,
1142815348,
1142815363,
1142815408,
1142815418,
1142812001,
1142812013,
1142812031,
1142812037,
1142812043,
1142812049,
1142812058,
1142812073,
1142812079,
1142812091,
1142812109,
1142812115,
1142812121,
1142812124,
1142812127,
1142813423,
1142813458,
1142813498,
1142813528,
1142813948,
1142813998,
1142816713,
1142816743,
1142816818,
1142816823,
1142816883,
1142816918,
1142816928,
1142816933,
1142818353,
1142818223,
1142818543)
					then 'alcohol'
					
when p.id IN (
1142817103,
1142817108,
1142817368				
			 ) then 'beauty'					
					
when p.id IN (1142809358) then 'personalised-sweets'		
					
when p.id IN (
422257661	,
422258704	,
422258732	,
1078909975	,
1078910660	,
1142780920	,
1142780923	,
1142780926	,
1142791311	,
1142791314	,
1142793957	,
1142793990	,
1142805791	,
1142809994	,
1142810951	,
1142812713	,
1142812716	,
1142812719	,
1142812785	,
1142812788	,	
1142812920	,
1142812932	,
1142814193	,
1142814198	,
1142814283	,
1142814288	,
1142814293	,
1142814298	,
1142814303	,
1142814308	,
1142814313	,
1142814318	,
1142814323	,
1142815518	,
1142815523	,
1142815528	,
1142815533	,
1142815538	,
1142815608	,
1142815613	,
1142815643	,
1142815648	,
1142815653	,
1142815658	,
1142815763	,
1142815818	,
1142815823	,
1142815828	,
1142815838	,
1142815843	,
1142815848	,
1142815853	,
1142815858	,
1142815863	,
1142815868	,
1142815873	,
1142815888	,
1142815893	,
1142815898	,
1142815903	,
1142815908	,
1142815913	,
1142815918	,
1142815923	,
1142815928	,
1142815933	,
1142815938	,
1142815943	,
1142815948	,
1142815953	,
1142816243	,
1142816563				
			 ) then 'soft-toy'	

when p.id IN (1142817533, 1142817818) then 'toy-game'
when p.id IN (1142816018) then 'jewellery'
when p.id IN (1142819226) then 'flower'
when p.id IN (1142810372, 1142810201, 1142810204, 1142810198, 439432719) then 'fruit'
when p.id IN (1142818268) then 'chocolate'

					
			  when pgt.internalname like 'Personalised%Merci%' OR pgt.internalname like 'Personalised_Australian%'  
					OR pgt.internalname like 'Personalised_Tonys%' OR pgt.internalname like 'Personalised_Leonidas%' then 'personalised-chocolate'
			  when lower(pgt.internalname) like '%balloon%' then 'balloon'
			  when lower(pgt.internalname) = 'mug' and z.designProductId IS NOT NULL then 'personalised-mug'
			  when pl_a.jewellery > 0 then 'jewellery'
			  when pl_a.gadget > 0 then 'gadget-novelty'			  
			  else pt.MPTypeCode 
		end  
		AS MPTypeCode, 
		
		pt.MPTypeCode AS MPTypeCode_ForCategories,
				
		p.channelid, p.PRODUCTCODE, p.INTERNALNAME, pg.showonstore, IFNULL(z.designId, 0) AS designId, z.design_contentinformationid, nl_product_name_2,
		
		concat('GRTZ', case when z.designProductId IS NULL then cast(p.ID as varchar(50)) else concat('D', cast(z.designProductId as varchar(50))) end)
		AS entityProduct_key,
		
		pt.GreetzTypeID, b.Brand

FROM "RAW_GREETZ"."GREETZ3".product p  
	LEFT JOIN "RAW_GREETZ"."GREETZ3".productgift pg 
		ON pg.productid = p.id
	LEFT JOIN 
		(
		 SELECT cd.ID AS designId, ppd.id AS designProductId, ppd.product, cd.contentinformationid AS design_contentinformationid,
				cif_nl_title.TEXT AS nl_product_name_2
		 FROM "RAW_GREETZ"."GREETZ3".productpersonalizedgiftdesign ppd 				
			 JOIN "RAW_GREETZ"."GREETZ3".carddefinition cd 
					ON cd.ID = ppd.GIFTDEFINITION
			 LEFT JOIN "RAW_GREETZ"."GREETZ3".contentinformationfield cif_nl_title
		  		ON cif_nl_title.contentinformationid = cd.contentinformationid
			 		AND cif_nl_title.type = 'TITLE' AND cif_nl_title.locale = 'nl_NL'
		) z
			ON z.product = p.ID	
			

	LEFT JOIN "RAW_GREETZ"."GREETZ3".productgifttype pgt ON pgt.ID = pg.productgifttypeid
	LEFT JOIN "RAW_GREETZ"."GREETZ3".greetz_to_mnpg_product_types_view_2 pt  ON pt.GreetzTypeID = IFNULL(pg.productgiftcategoryid, pg.productgifttypeid) 
	LEFT JOIN productList_withAttributes pl_a ON pl_a.ID = p.id
	LEFT JOIN Brands b ON p.ID = b.ID

WHERE -- p.TYPE IN ('standardGift', 'personalizedGift', 'gift_addon')  
	  p.channelid = '2'	
),

-- -------------- attributes Occasion, Style, Relation   ---------------------------
attrs_0 AS
(
SELECT DISTINCT cct.INTERNALNAME, p.ID, p.designId, p.contentinformationid, ct.TEXT AS Val, ci.CONTENTCATEGORYID AS catID, cc.parentcategoryid
FROM productList_0 p
	JOIN RAW_GREETZ.GREETZ3.contentinformation_category ci ON ci.CONTENTINFORMATIONID = IFNULL(p.design_contentinformationid, p.CONTENTINFORMATIONID)
	JOIN RAW_GREETZ.GREETZ3.contentcategory cc ON cc.ID = ci.CONTENTCATEGORYID
	JOIN RAW_GREETZ.GREETZ3.contentcategorytype cct ON cct.ID = cc.categorytypeid 
	JOIN RAW_GREETZ.GREETZ3.contentcategorytranslation ct ON ct.CONTENTCATEGORYID = cc.ID  AND ct.LOCALE = 'en_EN'
WHERE cct.INTERNALNAME IN ('Occasion', 'Target Group')
	 AND (cct.INTERNALNAME != 'Design Style' OR lower(ct.TEXT) NOT IN ('hip' ,'with flowers', 'cute', 'english cards', 'dutch cards'))
)

,
attr_Single_Val AS
(
SELECT INTERNALNAME, ID, designId, MIN(Val) AS Val
FROM attrs_0
GROUP BY INTERNALNAME, ID, designId
HAVING COUNT(*) = 1
),

attr_2 AS 
(
SELECT DISTINCT INTERNALNAME, ID, designId 
FROM attrs_0 AS cte1
WHERE EXISTS (SELECT 1 
			  FROM attrs_0 AS cte2 
			  WHERE cte1.INTERNALNAME = cte2.INTERNALNAME 
					AND cte1.ID = cte2.ID 
					AND cte1.designId = cte2.designId
					AND cte1.parentcategoryid = cte2.catID)
),

attr_3 AS 
(
SELECT  cte.INTERNALNAME, 
		cte.ID, 
		cte.designId, 
	
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
	JOIN attr_2 AS cte_2 
		ON cte_2.INTERNALNAME = cte.INTERNALNAME 
			AND cte_2.ID = cte.ID  
			AND cte_2.designId = cte.designId
GROUP BY cte.INTERNALNAME,
		 cte.ID,
		 cte.designId 
),

attr_5 AS
(
SELECT INTERNALNAME,
	   ID, 
	   designId, 
	   case 
			when INTERNALNAME = 'Occasion' then Concat_1 
			else IFNULL(Concat_3, Concat_2)
	   end  AS Val
FROM attr_3 
WHERE parents_cnt = 1 AND (cnt = 2 OR INTERNALNAME = 'Occasion')
UNION ALL
SELECT INTERNALNAME, ID, designId, Val
FROM attr_Single_Val
),

attr AS
(
SELECT INTERNALNAME,
	   ID, 
	   designId,
	   MIN(lower(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(Val, ' - ' , '-'), ' ' , '-'), '&' , '-and-'), '+' , 'plus'), '?' , ''),     '''' , '_'), '(' , ''), ')' , ''), '%', ''), '.', ''), '/', ''), '!', ''), 'ë', 'e'), '’', '_'), '*', '')))	AS Val_Code,
	   MIN(concat(UPPER(LEFT(Val, 1)), SUBSTRING(Val ,2)))  AS Val_Name	   
FROM attr_5
GROUP BY INTERNALNAME,
	   ID, 
	   designId
),

-- ----------------------------------------------------------

productList_CorrectedAttributesTemplate
AS
(
SELECT p.ID, p.entity_key, p.contentinformationid, p.MPTypeCode, p.MPTypeCode_ForCategories, p.channelid, p.PRODUCTCODE, 	p.INTERNALNAME, 
	   p.showonstore, p.designId, p.design_contentinformationid, p.entityProduct_key, p.nl_product_name_2, p.removed, p.GreetzTypeID, p.Brand, p.type,  
	   
	   case 
			when MPTypeCode = 'jewellery' then 'Jewellery-Accessories'
			when MPTypeCode like '%alcohol%' then 'Alcohol'
			when MPTypeCode = 'personalised-mug' then 'Mugs'
			when MPTypeCode = 'beauty' then 'Beauty'
			when MPTypeCode = 'toy-game' and CategoryCode IS NULL then 'Toys-Games'
			when MPTypeCode = 'cake' and CategoryCode IS NULL then 'Other-Confectionery'
			when MPTypeCode like '%chocolate%' then 'Chocolate'
			when MPTypeCode like '%balloon%' then 'Balloons'
			else CategoryCode
	   end
	   AS CategoryCode,	   
		
		case 
			when MPTypeCode = 'jewellery' then 'jewellery'
			when MPTypeCode = 'flower' then 'flowers-plants'	
			when MPTypeCode = 'alcohol' then 'alcohol'
			when MPTypeCode = 'home-gift' then 'home-garden'
			when MPTypeCode = 'chocolate' then 'chocolate'
			when MPTypeCode = 'cake' then 'food-drink'
			when MPTypeCode = 'balloon' then 'newia-balloons'
			when MPTypeCode = 'beauty' then 'beauty-face-body'
			when MPTypeCode = 'toy-game' then 'toys-kids-baby'
			when MPTypeCode = 'book' then 'books-stationery'
			when MPTypeCode = 'gift-card' then 'gift-cards'
			when MPTypeCode = 'sweet' then 'sweets'
			when MPTypeCode = 'personalised-mug' then 'mugs'
			when MPTypeCode = 'postcard' then 'newia-gift-sets-hampers-letterbox'
		end  as DefaultCategoryKey
												
FROM productList_0 p
),

productList AS
(
SELECT p.ID, p.entity_key, p.contentinformationid, p.DefaultCategoryKey, p.MPTypeCode, p.MPTypeCode_ForCategories, p.channelid, p.PRODUCTCODE, 	p.INTERNALNAME, 
	   p.showonstore, p.designId, p.design_contentinformationid, p.entityProduct_key, p.nl_product_name_2, p.Brand,
	   p.CategoryCode, p.removed, pc.Code AS ProductCategoryCode, pc.Level, p.type
	   
FROM productList_CorrectedAttributesTemplate p
	LEFT JOIN "RAW_GREETZ"."GREETZ3".type_to_category_view tc
		ON tc.GreetzTypeID = p.GreetzTypeID
	LEFT JOIN "RAW_GREETZ"."GREETZ3".Product_Category pc
		ON pc.Code = tc.CategoryCode
-- WHERE (p.entityProduct_key not like 'GRTZD%' OR p.MPTypeCode like '%personalised%') 
),

Ignore_AgeCategory
AS
(
SELECT DISTINCT pl.entityProduct_key
FROM productList pl
	 JOIN "RAW_GREETZ"."GREETZ3".contentinformation_category ci
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

Ignore_AgeCategory_ForDesigned
AS
(
SELECT DISTINCT pl.entityProduct_key
FROM productList pl
	 JOIN "RAW_GREETZ"."GREETZ3".contentinformation_category ci
		ON ci.contentinformationid = pl.design_contentinformationid 
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

productList_withSize AS
(
SELECT  pl.ID,
		MIN(ct.text) as Size
FROM productList pl
	 JOIN "RAW_GREETZ"."GREETZ3".contentinformation_category ci
		  ON pl.contentinformationid = ci.contentinformationid
	 JOIN "RAW_GREETZ"."GREETZ3".contentcategory cc
		  ON cc.id = ci.contentcategoryid
	 JOIN "RAW_GREETZ"."GREETZ3".contentcategorytranslation ct
		  ON ct.contentcategoryid = cc.id
			AND ct.locale = 'nl_NL'
	 JOIN "RAW_GREETZ"."GREETZ3".contentcategorytype c
	      ON cc.categorytypeid = c.id
WHERE c.INTERNALNAME = 'Size'  
GROUP BY pl.ID		  	  
),

grouped_products AS
( 
	SELECT  pge.productStandardGift, 
			pge.productGroupId,
			pge.showonstore,
			pl.contentinformationid,
			pl.productCode,
			pl.channelid,
			concat('GRTZG', cast(ppg.ID as varchar(50))) AS entityProduct_key
			
	FROM "RAW_GREETZ"."GREETZ3".productgroupentry AS pge
		JOIN "RAW_GREETZ"."GREETZ3".productgroup ppg ON pge.productGroupId = ppg.id 
	 	JOIN productList pl ON pl.ID = pge.productStandardGift		
	WHERE pge.productstandardgift IN (1142811940, 1142813663, 1142813653, 1142813658, 1142811934, 1142811937, 1142811979, 1142811982, 1142811913, 1142811916) 		
),

grouped_product_types_0 AS
(
	SELECT pge.productGroupId, pl.entity_key, pl.MPTypeCode, pl.MPTypeCode_ForCategories, pl.DefaultCategoryKey, 
		   ROW_NUMBER() OVER(PARTITION BY pge.productGroupId ORDER BY pge.productStandardGift) AS RN
	FROM grouped_products pge
		 JOIN productList pl ON pl.ID = pge.productStandardGift
),

grouped_product_types AS
(
SELECT * FROM grouped_product_types_0 WHERE RN = 1
),

cte_DescrForDesigns
AS
(
	SELECT p.ID, 
		   p.designId, 
		   
		   case 
				when p.MPTypeCode in ('alcohol','biscuit','cake','chocolate','personalised-alcohol','sweet')  
					 AND (cif_nl_descr_design.text IS NOT NULL  OR  cif_nl_descr_design_2.text IS NOT NULL)
				then concat(IFNULL(concat(cif_nl_descr_design.text, '\n\n'), ''), IFNULL(cif_nl_descr_design_2.text, '')) 
				else cif_nl_descr_design.text												           
		   end	AS product_nl_description,
		   
		   case 
				when p.MPTypeCode in ('alcohol','biscuit','cake','chocolate','personalised-alcohol','sweet') 
					 AND (cif_en_descr_design.text IS NOT NULL  OR  cif_en_descr_design_2.text IS NOT NULL)
				then concat(IFNULL(concat(cif_en_descr_design.text, '\n\n'), ''), IFNULL(cif_en_descr_design_2.text, '')) 
				else cif_en_descr_design.text												           
		   end	AS product_en_description																		   

	FROM
		(SELECT * FROM productList WHERE designId != 0) p
		 LEFT JOIN "RAW_GREETZ"."GREETZ3".contentinformationfield cif_nl_descr_design
			  ON cif_nl_descr_design.contentinformationid = p.design_contentinformationid
				 AND cif_nl_descr_design.type = 'DESCRIPTION' AND cif_nl_descr_design.locale = 'nl_NL'	
         LEFT JOIN "RAW_GREETZ"."GREETZ3".contentinformationfield cif_nl_descr_design_2
			  ON cif_nl_descr_design_2.contentinformationid = p.design_contentinformationid
				 AND cif_nl_descr_design_2.type = 'PRODUCT_DESCRIPTION' AND cif_nl_descr_design_2.locale = 'nl_NL'
         LEFT JOIN "RAW_GREETZ"."GREETZ3".contentinformationfield cif_en_descr_design
			  ON cif_en_descr_design.contentinformationid = p.design_contentinformationid
				 AND cif_en_descr_design.type = 'DESCRIPTION' AND cif_en_descr_design.locale = 'en_EN'	
         LEFT JOIN "RAW_GREETZ"."GREETZ3".contentinformationfield cif_en_descr_design_2
			  ON cif_en_descr_design_2.contentinformationid = p.design_contentinformationid
				 AND cif_en_descr_design_2.type = 'PRODUCT_DESCRIPTION' AND cif_en_descr_design_2.locale = 'en_EN'
		
),

cte_CategoriesForDesigns
AS
(
	SELECT 
		   p.ID, 
		   p.designId,
		   
		    CONCAT( IFNULL(CONCAT(p.CategoryCode, ', '), ''),
			   COALESCE(
					LISTAGG(DISTINCT IFNULL(mc.MPCategoryKey, p.DefaultCategoryKey) , ', ')   
			   , p.DefaultCategoryKey, ''))	
			AS category_keys
    FROM
		(SELECT * FROM productList WHERE designId != 0) p
		 JOIN "RAW_GREETZ"."GREETZ3".contentinformation_category ci
              ON p.design_contentinformationid = ci.contentinformationid OR p.contentinformationid = ci.contentinformationid
		 LEFT JOIN Ignore_AgeCategory_ForDesigned ig
			  ON ig.entityProduct_key = p.entityProduct_key	
		 LEFT JOIN Ignore_AgeCategory ig_2
			  ON ig_2.entityProduct_key = p.entityProduct_key	
         JOIN "RAW_GREETZ"."GREETZ3".greetz_to_mnpq_categories_view_2 mc 
			  ON mc.GreetzCategoryID = ci.contentcategoryid
				-- AND mc.MPTypeCode = p.MPTypeCode
				AND (
					 ig.entityProduct_key IS NULL  
					 OR (mc.MPCategoryKey NOT LIKE '%years-old' AND mc.MPCategoryKey NOT IN ('all-kids', 'age-other', 'age-unspecified', 'age-groups'))
					)
				AND (
					 ig_2.entityProduct_key IS NULL  
					 OR (mc.MPCategoryKey NOT LIKE '%years-old' AND mc.MPCategoryKey NOT IN ('all-kids', 'age-other', 'age-unspecified', 'age-groups'))
					)
	GROUP BY 
			p.ID, 
		    p.designId,
			p.CategoryCode,
			p.DefaultCategoryKey
)

SELECT  
		p.ID 	AS	PRODUCT_ID,
		1 	AS	VARIANT_ID	,
		CONCAT(p.ID, '-', '1')	AS	PRODUCT_VARIANT_ID	,
		p.entityProduct_key		AS	SKU	,
		
		Concat(case when p.MPTypeCode like '%personalised%' OR p.entityProduct_key like 'GRTZD%' then p.entityProduct_key else p.PRODUCTCODE end
			  ,case when p.MPTypeCode like '%personalised%' OR p.entityProduct_key like 'GRTZD%' then '-STANDARD' else '' end) 	
		AS	SKU_VARIANT,
		current_timestamp()	AS	PRODUCT_CREATED_AT	,
		current_timestamp()	AS	VARIANT_CREATED_AT	,
		FALSE	AS	IS_PUBLISHED	,
		NULL	AS	FIRST_PUBLISHED_DATE_TIME	,
		
		case 
			when lower(s.Size) LIKE '%personen%'  AND p.MPTypeCode IN ('cake', 'biscuit')
			then
				 case 
					  when lower(IFNULL(concat(cif_nl_title.text, IFNULL(concat(' ', p.nl_product_name_2), '')), replace(p.INTERNALNAME, '_', ' '))) NOT LIKE '%personen%'
					  then concat(IFNULL(concat(cif_nl_title.text, IFNULL(concat(' ', p.nl_product_name_2), '')), replace(p.INTERNALNAME, '_', ' ')), ' | ', s.Size)
					  else IFNULL(concat(cif_nl_title.text, IFNULL(concat(' ', p.nl_product_name_2), '')), replace(p.INTERNALNAME, '_', ' '))
				 end
		else IFNULL(concat(cif_nl_title.text, IFNULL(concat(' ', p.nl_product_name_2), '')), replace(p.INTERNALNAME, '_', ' '))
		end 	AS	PRODUCT_TITLE	,
		
		case when design_contentinformationid IS NULL then
		   case 
				when p.MPTypeCode in ('alcohol','biscuit','cake','chocolate','personalised-alcohol','sweet')  
					 AND (cif_nl_descr.text IS NOT NULL  OR  cif_nl_descr_2.text IS NOT NULL)
				then concat(IFNULL(concat(cif_nl_descr.text, '\n\n'), ''), IFNULL(cif_nl_descr_2.text, '')) 
				else cif_nl_descr.text												           
		   end																				   
	   else
		   IFNULL(dfd.product_nl_description,
					case 
					when p.MPTypeCode in ('alcohol','biscuit','cake','chocolate','personalised-alcohol','sweet')  
						 AND (cif_nl_descr.text IS NOT NULL  OR  cif_nl_descr_2.text IS NOT NULL)
					then concat(IFNULL(concat(cif_nl_descr.text, '\n\n'), ''), IFNULL(cif_nl_descr_2.text, '')) 
					else cif_nl_descr.text												           
					end	
				  )
	   end	 AS	PRODUCT_DESCRIPTION	,
		
		(SELECT MIN(Name) FROM "RAW_GREETZ"."GREETZ3".Product_Category WHERE Code = p.ProductCategoryCode)	AS	CATEGORY_NAME	
		,
		(SELECT MIN(t1.Name) 
		 FROM "RAW_GREETZ"."GREETZ3".Product_Category t1 JOIN "RAW_GREETZ"."GREETZ3".Product_Category t2 ON t1.CATEGORYID = t2.Parent 
		 WHERE t2.Code = p.ProductCategoryCode)	AS	CATEGORY_PARENT	,
		
		CASE p.Level
			WHEN 1 THEN (SELECT MIN(Name) FROM "RAW_GREETZ"."GREETZ3".Product_Category WHERE Code = p.ProductCategoryCode) 
			WHEN 2 THEN (SELECT MIN(t1.Name) 
						 FROM "RAW_GREETZ"."GREETZ3".Product_Category t1 JOIN "RAW_GREETZ"."GREETZ3".Product_Category t2 ON t1.CATEGORYID = t2.Parent 
						 WHERE t2.Code = p.ProductCategoryCode) 
			WHEN 3 THEN (SELECT MIN(t1.Name) 
						 FROM "RAW_GREETZ"."GREETZ3".Product_Category t1 
							JOIN "RAW_GREETZ"."GREETZ3".Product_Category t2 ON t1.CATEGORYID = t2.Parent 
							JOIN "RAW_GREETZ"."GREETZ3".Product_Category t3 ON t2.CATEGORYID = t3.Parent 
						 WHERE t3.Code = p.ProductCategoryCode) 				
			WHEN 4 THEN (SELECT MIN(t1.Name) 
						 FROM "RAW_GREETZ"."GREETZ3".Product_Category t1 
							JOIN "RAW_GREETZ"."GREETZ3".Product_Category t2 ON t1.CATEGORYID = t2.Parent 
							JOIN "RAW_GREETZ"."GREETZ3".Product_Category t3 ON t2.CATEGORYID = t3.Parent 
							JOIN "RAW_GREETZ"."GREETZ3".Product_Category t4 ON t3.CATEGORYID = t4.Parent 
						 WHERE t4.Code = p.ProductCategoryCode) 
			WHEN 5 THEN (SELECT MIN(t1.Name)  
						 FROM "RAW_GREETZ"."GREETZ3".Product_Category t1 
							JOIN "RAW_GREETZ"."GREETZ3".Product_Category t2 ON t1.CATEGORYID = t2.Parent 
							JOIN "RAW_GREETZ"."GREETZ3".Product_Category t3 ON t2.CATEGORYID = t3.Parent 
							JOIN "RAW_GREETZ"."GREETZ3".Product_Category t4 ON t3.CATEGORYID = t4.Parent 
							JOIN "RAW_GREETZ"."GREETZ3".Product_Category t5 ON t4.CATEGORYID = t5.Parent
						 WHERE t5.Code = p.ProductCategoryCode) 						 
		END  AS	HIERARCHY_RANK_1,
		
		CASE p.Level
			WHEN 2 THEN (SELECT MIN(Name) FROM "RAW_GREETZ"."GREETZ3".Product_Category WHERE Code = p.ProductCategoryCode) 
			WHEN 3 THEN (SELECT MIN(t1.Name) 
						 FROM "RAW_GREETZ"."GREETZ3".Product_Category t1 JOIN "RAW_GREETZ"."GREETZ3".Product_Category t2 ON t1.CATEGORYID = t2.Parent 
						 WHERE t2.Code = p.ProductCategoryCode) 
			WHEN 4 THEN (SELECT MIN(t1.Name) 
						 FROM "RAW_GREETZ"."GREETZ3".Product_Category t1 
							JOIN "RAW_GREETZ"."GREETZ3".Product_Category t2 ON t1.CATEGORYID = t2.Parent 
							JOIN "RAW_GREETZ"."GREETZ3".Product_Category t3 ON t2.CATEGORYID = t3.Parent 
						 WHERE t3.Code = p.ProductCategoryCode) 				
			WHEN 5 THEN (SELECT MIN(t1.Name) 
						 FROM "RAW_GREETZ"."GREETZ3".Product_Category t1 
							JOIN "RAW_GREETZ"."GREETZ3".Product_Category t2 ON t1.CATEGORYID = t2.Parent 
							JOIN "RAW_GREETZ"."GREETZ3".Product_Category t3 ON t2.CATEGORYID = t3.Parent 
							JOIN "RAW_GREETZ"."GREETZ3".Product_Category t4 ON t3.CATEGORYID = t4.Parent 
						 WHERE t4.Code = p.ProductCategoryCode)  						 
		END  AS	HIERARCHY_RANK_2,
		
		CASE p.Level
			WHEN 3 THEN (SELECT MIN(Name) FROM "RAW_GREETZ"."GREETZ3".Product_Category WHERE Code = p.ProductCategoryCode) 
			WHEN 4 THEN (SELECT MIN(t1.Name) 
						 FROM "RAW_GREETZ"."GREETZ3".Product_Category t1 JOIN "RAW_GREETZ"."GREETZ3".Product_Category t2 ON t1.CATEGORYID = t2.Parent 
						 WHERE t2.Code = p.ProductCategoryCode) 
			WHEN 5 THEN (SELECT MIN(t1.Name) 
						 FROM "RAW_GREETZ"."GREETZ3".Product_Category t1 
							JOIN "RAW_GREETZ"."GREETZ3".Product_Category t2 ON t1.CATEGORYID = t2.Parent 
							JOIN "RAW_GREETZ"."GREETZ3".Product_Category t3 ON t2.CATEGORYID = t3.Parent 
						 WHERE t3.Code = p.ProductCategoryCode) 				
		END  AS	HIERARCHY_RANK_3,
		
		CASE p.Level
			WHEN 4 THEN (SELECT MIN(Name) FROM "RAW_GREETZ"."GREETZ3".Product_Category WHERE Code = p.ProductCategoryCode) 
			WHEN 5 THEN (SELECT MIN(t1.Name) 
						 FROM "RAW_GREETZ"."GREETZ3".Product_Category t1 JOIN "RAW_GREETZ"."GREETZ3".Product_Category t2 ON t1.CATEGORYID = t2.Parent 
						 WHERE t2.Code = p.ProductCategoryCode) 				
		END  AS	HIERARCHY_RANK_4,
		
		CASE p.Level
			WHEN 5 THEN (SELECT MIN(Name) FROM "RAW_GREETZ"."GREETZ3".Product_Category WHERE Code = p.ProductCategoryCode) 				
		END  AS	HIERARCHY_RANK_5,
		
		NULL	AS	UNIQUE_PRODUCT_CODE	,
		NULL	AS	PHOTO_COUNT	,
		NULL	AS	DELIVERY_TYPE	,
		IFF(atr.LetterboxAtr > 0, True, False)	AS	LETTERBOX_FRIENDLY	,
		NULL	AS	SHAPE	,
		NULL	AS	IMAGE_HEIGHT	,
		NULL	AS	IMAGE_WIDTH	,
		NULL 	AS	ORIENTATION	,
		CONCAT('{"en":"', p.Brand, '"}')	AS	PRODUCT_BRAND	,
		NULL	AS	RANGE	,
		NULL	AS	ARENA_ID	,
		NULL	AS	PRODUCT_RANGE	,
		NULL	AS	NOTES	,
		IFNULL(a_oc.Val_Name, 'General > General')	AS	REPORTING_OCCASION	,
		NULL	AS	REPORTING_STYLE	,
		IFNULL(a_rl_2.MP_Name, 'Non relations')	AS	REPORTING_RELATION	,
		NULL	AS	REPORTING_ARTIST	,
		NULL	AS	REPORTING_SUPPLIER	,
		NULL	AS	REPORTING_SUPPLIER_NO	,
		IFF(atr.LetterboxAtr > 0, 'Letterbox', s.Size) 		AS	SIZE,	
		IFF(atr.LetterboxAtr > 0, 'Letterbox', s.Size)  	AS	MCD_SIZE	,
	   
	   CONCAT('{"categories":[',
	    IFNULL( cats_d.category_keys,		
				CONCAT( IFNULL(CONCAT(p.CategoryCode, ', '), ''),
					   COALESCE(
							LISTAGG(DISTINCT IFNULL(mc.MPCategoryKey, p.DefaultCategoryKey) , ', ')   
					   , p.DefaultCategoryKey, '')))	
		, ']}')
	    AS CATEGORIES,

	--	LISTAGG(DISTINCT(IFNULL(ct.text, ct2.text)) , ', ') 			--	AS SEARCH_KEYWORDS,
	
CONCAT('{',
IFNULL(
		CONCAT(
			'"en":[',
		LISTAGG(DISTINCT IFNULL(ct.text, ct2.text) , ', ') 					
 ,
			'],'
		)
, ''),	
IFNULL(
	CONCAT(
	 '"nl":[',		
		LISTAGG(DISTINCT ct2.text , ', ')
										
		
		,
	']'
	)
, ''),		 		 
'}')
AS	SEARCH_KEYWORDS	,

		CASE 	
			WHEN lower(p.productcode) LIKE '%envelop%' THEN 'Envelop'
			WHEN p.MPTypeCode = 'flower' THEN 'Flowers & Plants'
			WHEN p.MPTypeCode = 'gadget-novelty' THEN 'Gadget / Novelty'
			WHEN p.MPTypeCode = 'gift-card' THEN 'Gift Cards'
			WHEN p.MPTypeCode = 'home-gift' THEN 'Gift for Home'
			WHEN p.MPTypeCode = 'personalised-chocolate' THEN 'Gepersonaliseerde chocolade'
			WHEN p.MPTypeCode = 'personalised-sweets' THEN 'Gepersonaliseerd snoep'
			WHEN p.MPTypeCode = 'sweet' THEN 'Snoep'
			WHEN p.MPTypeCode = 'toy-game' THEN 'Toy / Game'
			WHEN p.MPTypeCode IS NOT NULL  THEN initcap(replace(p.MPTypeCode, '-', ' ')) 
			ELSE p.type
		END  AS PRODUCT_TYPE_NAME, 				
		
		IFNULL(p.MPTypeCode, p.type)  	AS	PRODUCT_KEY	,
		
		CASE 
			WHEN p.MPTypeCode = 'flower' THEN 'Flowers' 	
			WHEN p.MPTypeCode = 'addon' THEN 'Add-on' 
			WHEN p.TYPE IN ('standardGift', 'personalizedGift') THEN 'Gifts'
			WHEN lower(p.productcode) LIKE '%envelop%' THEN 'Envelope'
			ELSE 'Legacy'
		END	 AS	PRODUCT_FAMILY	,			 
		
		IFF(p.removed IS NULL, False, True) 	AS IS_PRODUCT_VARIANT_DELETED	,
		p.removed	AS	PRODUCT_VARIANT_DELETED_TIMESTAMP	,
		IFF(p.removed IS NULL, False, True)	AS	IS_PRODUCT_DELETED	,
		p.removed	AS	PRODUCT_DELETED_TIMESTAMP	,
		NULL	AS	SUPPLIER_NAME	,
		NULL	AS	LEGACY_SUPPLIER_ID	,
		NULL	AS	SUPPLIER_CITY	,
		NULL	AS	SUPPLIER_COUNTRY	,
		NULL	AS	MCD_FINANCE_CATEGORY	,
		NULL	AS	MCD_FINANCE_SUBCATEGORY	,
		current_timestamp()	AS	MESSAGE_TIMESTAMP	,
		'grtz'	AS	BRAND	,
		NULL	AS	RANGE_ID	,
		NULL	AS	FINANCE_PRODUCT_HIERARCHY	,
		'Greetz'	AS	BRAND_DESCRIPTION	

FROM 
         productList p		  
         LEFT JOIN "RAW_GREETZ"."GREETZ3".contentinformationfield cif_nl_title
			  ON cif_nl_title.contentinformationid = p.contentinformationid
				 AND cif_nl_title.type = 'TITLE' AND cif_nl_title.locale = 'nl_NL'
         LEFT JOIN "RAW_GREETZ"."GREETZ3".contentinformationfield cif_nl_descr
			  ON cif_nl_descr.contentinformationid = p.contentinformationid
				 AND cif_nl_descr.type = 'DESCRIPTION' AND cif_nl_descr.locale = 'nl_NL'
		 LEFT JOIN "RAW_GREETZ"."GREETZ3".contentinformationfield cif_nl_descr_2
			  ON cif_nl_descr_2.contentinformationid = p.contentinformationid
				 AND cif_nl_descr_2.type = 'PRODUCT_DESCRIPTION' AND cif_nl_descr_2.locale = 'nl_NL'
				 
		 LEFT JOIN cte_DescrForDesigns dfd 
			  ON p.ID = dfd.ID AND p.designId = dfd.designId
			  
         LEFT JOIN "RAW_GREETZ"."GREETZ3".contentinformation_category ci
              ON p.contentinformationid = ci.contentinformationid
         LEFT JOIN "RAW_GREETZ"."GREETZ3".contentcategory cc
              ON cc.id = ci.contentcategoryid
         LEFT JOIN "RAW_GREETZ"."GREETZ3".contentcategorytranslation ct
              ON ct.contentcategoryid = cc.id AND ct.locale = 'nl_NL'
		 LEFT JOIN "RAW_GREETZ"."GREETZ3".contentcategorytranslation ct2
              ON ct2.contentcategoryid = cc.id AND ct2.locale = 'en_EN'
		 LEFT JOIN Ignore_AgeCategory ig
			  ON ig.entityProduct_key = p.entityProduct_key			  
         LEFT JOIN "RAW_GREETZ"."GREETZ3".greetz_to_mnpq_categories_view_2 mc 
			  ON mc.GreetzCategoryID = cc.id
				 AND (
					  mc.MPTypeCode = p.MPTypeCode_ForCategories 
					  OR mc.MPTypeCode = 'ALL'
					  )
				 AND (
					  ig.entityProduct_key IS NULL  
					  OR (mc.MPCategoryKey NOT LIKE '%years-old' AND mc.MPCategoryKey NOT IN ('all-kids', 'age-other', 'age-unspecified', 'age-groups'))
					 )
		 LEFT JOIN productList_withAttributes atr
			  ON p.ID = atr.ID
		 LEFT JOIN productList_withSize s
			  ON p.ID = s.ID
		 LEFT JOIN cte_CategoriesForDesigns cats_d
			  ON p.ID = cats_d.ID AND p.designId = cats_d.designId	
			  
		 LEFT JOIN attr a_oc	
			  ON a_oc.ID = p.ID AND a_oc.designId = p.designId AND a_oc.INTERNALNAME = 'Occasion'			  
		 LEFT JOIN attr a_tgt	
			  ON a_tgt.ID = p.ID AND a_tgt.designId = p.designId AND a_tgt.INTERNALNAME = 'Target Group'			  
		 LEFT JOIN RAW_GREETZ.GREETZ3.greetz_to_mnpg_relations_view_2 a_rl_2
			  ON a_rl_2.Greetz_Name = a_tgt.Val_Name	
			
WHERE p.id NOT IN (1142811940, 1142813663, 1142813653, 1142813658, 1142811934, 1142811937, 1142811979, 1142811982, 1142811913, 1142811916) 
						   
GROUP BY p.ID,
		 p.entityProduct_key, 
		 p.PRODUCTCODE,
		 p.designId,
		 p.contentinformationid,
		 p.MPTypeCode,
		 p.MPTypeCode_ForCategories,
		 cif_nl_title.text, 
		 p.nl_product_name_2,
		 p.INTERNALNAME,
		 p.design_contentinformationid,
		 cif_nl_descr.text,
		 cif_nl_descr_2.text,
		 atr.LetterboxAtr,
		 cats_d.category_keys,
		 p.CategoryCode,
		 p.removed,
		 p.DefaultCategoryKey,
		 s.Size,
		 dfd.product_nl_description,
		 p.Level,
		 p.ProductCategoryCode,
		 a_oc.Val_Name,
		 a_rl_2.MP_Name,
		 p.Brand,
		 P.TYPE
		 
UNION ALL

SELECT 
		p.ID 	AS	PRODUCT_ID,
		ROW_NUMBER() OVER(PARTITION BY pge.entityProduct_key ORDER BY p.ID) 	AS	VARIANT_ID	,
		CONCAT(p.ID, '-', ROW_NUMBER() OVER(PARTITION BY pge.entityProduct_key ORDER BY p.ID))	AS	PRODUCT_VARIANT_ID	,
		pge.entityProduct_key	AS	SKU	, 
		p.PRODUCTCODE	AS	SKU_VARIANT	,
		current_timestamp()	AS	PRODUCT_CREATED_AT	,
		current_timestamp()	AS	VARIANT_CREATED_AT	,
		FALSE	AS	IS_PUBLISHED	,
		NULL	AS	FIRST_PUBLISHED_DATE_TIME	,
		
		case 
			when lower(s.Size) LIKE '%personen%'  AND p.MPTypeCode IN ('cake', 'biscuit')
			then
				 case 
					  when lower(COALESCE(ppg.title, replace(ppg.productGroupCode, '_', ' '))) NOT LIKE '%personen%'
					  then concat(COALESCE(ppg.title, replace(ppg.productGroupCode, '_', ' ')), ' | ', s.Size)
					  else COALESCE(ppg.title, replace(ppg.productGroupCode, '_', ' '))
				 end
		else COALESCE(ppg.title, replace(ppg.productGroupCode, '_', ' '))
		end 	AS	PRODUCT_TITLE	,
		
		cif_nl_descr.text AS	PRODUCT_DESCRIPTION	,
		
		(SELECT MIN(Name) FROM "RAW_GREETZ"."GREETZ3".Product_Category WHERE Code = p.ProductCategoryCode)	AS	CATEGORY_NAME,
		
		(SELECT MIN(t1.Name) 
		 FROM "RAW_GREETZ"."GREETZ3".Product_Category t1 JOIN "RAW_GREETZ"."GREETZ3".Product_Category t2 ON t1.CATEGORYID = t2.Parent 
		 WHERE t2.Code = p.ProductCategoryCode)	AS	CATEGORY_PARENT	,
		
		CASE p.Level
			WHEN 1 THEN (SELECT MIN(Name) FROM "RAW_GREETZ"."GREETZ3".Product_Category WHERE Code = p.ProductCategoryCode) 
			WHEN 2 THEN (SELECT MIN(t1.Name) 
						 FROM "RAW_GREETZ"."GREETZ3".Product_Category t1 JOIN "RAW_GREETZ"."GREETZ3".Product_Category t2 ON t1.CATEGORYID = t2.Parent 
						 WHERE t2.Code = p.ProductCategoryCode) 
			WHEN 3 THEN (SELECT MIN(t1.Name) 
						 FROM "RAW_GREETZ"."GREETZ3".Product_Category t1 
							JOIN "RAW_GREETZ"."GREETZ3".Product_Category t2 ON t1.CATEGORYID = t2.Parent 
							JOIN "RAW_GREETZ"."GREETZ3".Product_Category t3 ON t2.CATEGORYID = t3.Parent 
						 WHERE t3.Code = p.ProductCategoryCode) 				
			WHEN 4 THEN (SELECT MIN(t1.Name) 
						 FROM "RAW_GREETZ"."GREETZ3".Product_Category t1 
							JOIN "RAW_GREETZ"."GREETZ3".Product_Category t2 ON t1.CATEGORYID = t2.Parent 
							JOIN "RAW_GREETZ"."GREETZ3".Product_Category t3 ON t2.CATEGORYID = t3.Parent 
							JOIN "RAW_GREETZ"."GREETZ3".Product_Category t4 ON t3.CATEGORYID = t4.Parent 
						 WHERE t4.Code = p.ProductCategoryCode) 
			WHEN 5 THEN (SELECT MIN(t1.Name)  
						 FROM "RAW_GREETZ"."GREETZ3".Product_Category t1 
							JOIN "RAW_GREETZ"."GREETZ3".Product_Category t2 ON t1.CATEGORYID = t2.Parent 
							JOIN "RAW_GREETZ"."GREETZ3".Product_Category t3 ON t2.CATEGORYID = t3.Parent 
							JOIN "RAW_GREETZ"."GREETZ3".Product_Category t4 ON t3.CATEGORYID = t4.Parent 
							JOIN "RAW_GREETZ"."GREETZ3".Product_Category t5 ON t4.CATEGORYID = t5.Parent
						 WHERE t5.Code = p.ProductCategoryCode) 						 
		END  AS	HIERARCHY_RANK_1,
		
		CASE p.Level
			WHEN 2 THEN (SELECT MIN(Name) FROM "RAW_GREETZ"."GREETZ3".Product_Category WHERE Code = p.ProductCategoryCode) 
			WHEN 3 THEN (SELECT MIN(t1.Name) 
						 FROM "RAW_GREETZ"."GREETZ3".Product_Category t1 JOIN "RAW_GREETZ"."GREETZ3".Product_Category t2 ON t1.CATEGORYID = t2.Parent 
						 WHERE t2.Code = p.ProductCategoryCode) 
			WHEN 4 THEN (SELECT MIN(t1.Name) 
						 FROM "RAW_GREETZ"."GREETZ3".Product_Category t1 
							JOIN "RAW_GREETZ"."GREETZ3".Product_Category t2 ON t1.CATEGORYID = t2.Parent 
							JOIN "RAW_GREETZ"."GREETZ3".Product_Category t3 ON t2.CATEGORYID = t3.Parent 
						 WHERE t3.Code = p.ProductCategoryCode) 				
			WHEN 5 THEN (SELECT MIN(t1.Name) 
						 FROM "RAW_GREETZ"."GREETZ3".Product_Category t1 
							JOIN "RAW_GREETZ"."GREETZ3".Product_Category t2 ON t1.CATEGORYID = t2.Parent 
							JOIN "RAW_GREETZ"."GREETZ3".Product_Category t3 ON t2.CATEGORYID = t3.Parent 
							JOIN "RAW_GREETZ"."GREETZ3".Product_Category t4 ON t3.CATEGORYID = t4.Parent 
						 WHERE t4.Code = p.ProductCategoryCode)  						 
		END  AS	HIERARCHY_RANK_2,
		
		CASE p.Level
			WHEN 3 THEN (SELECT MIN(Name) FROM "RAW_GREETZ"."GREETZ3".Product_Category WHERE Code = p.ProductCategoryCode) 
			WHEN 4 THEN (SELECT MIN(t1.Name) 
						 FROM "RAW_GREETZ"."GREETZ3".Product_Category t1 JOIN "RAW_GREETZ"."GREETZ3".Product_Category t2 ON t1.CATEGORYID = t2.Parent 
						 WHERE t2.Code = p.ProductCategoryCode) 
			WHEN 5 THEN (SELECT MIN(t1.Name) 
						 FROM "RAW_GREETZ"."GREETZ3".Product_Category t1 
							JOIN "RAW_GREETZ"."GREETZ3".Product_Category t2 ON t1.CATEGORYID = t2.Parent 
							JOIN "RAW_GREETZ"."GREETZ3".Product_Category t3 ON t2.CATEGORYID = t3.Parent 
						 WHERE t3.Code = p.ProductCategoryCode) 				
		END  AS	HIERARCHY_RANK_3,
		
		CASE p.Level
			WHEN 4 THEN (SELECT MIN(Name) FROM "RAW_GREETZ"."GREETZ3".Product_Category WHERE Code = p.ProductCategoryCode) 
			WHEN 5 THEN (SELECT MIN(t1.Name) 
						 FROM "RAW_GREETZ"."GREETZ3".Product_Category t1 JOIN "RAW_GREETZ"."GREETZ3".Product_Category t2 ON t1.CATEGORYID = t2.Parent 
						 WHERE t2.Code = p.ProductCategoryCode) 				
		END  AS	HIERARCHY_RANK_4,
		
		CASE p.Level
			WHEN 5 THEN (SELECT MIN(Name) FROM "RAW_GREETZ"."GREETZ3".Product_Category WHERE Code = p.ProductCategoryCode) 				
		END  AS	HIERARCHY_RANK_5,
		
		NULL	AS	UNIQUE_PRODUCT_CODE	,
		NULL	AS	PHOTO_COUNT	,
		NULL	AS	DELIVERY_TYPE	,
		IFF(atr.LetterboxAtr > 0, True, False)	AS	LETTERBOX_FRIENDLY	,
		NULL	AS	SHAPE	,
		NULL	AS	IMAGE_HEIGHT	,
		NULL	AS	IMAGE_WIDTH	,
		NULL 	AS	ORIENTATION	,
		CONCAT('{"en":"', p.Brand, '"}')	AS	PRODUCT_BRAND	,		
		NULL	AS	RANGE	,
		NULL	AS	ARENA_ID	,
		NULL	AS	PRODUCT_RANGE	,
		NULL	AS	NOTES	,
		IFNULL(a_oc.Val_Name, 'General > General')	AS	REPORTING_OCCASION	,
		NULL	AS	REPORTING_STYLE	,
		IFNULL(a_rl_2.MP_Name, 'Non relations')	AS	REPORTING_RELATION	,
		NULL	AS	REPORTING_ARTIST	,
		NULL	AS	REPORTING_SUPPLIER	,
		NULL	AS	REPORTING_SUPPLIER_NO	,
		IFF(atr.LetterboxAtr > 0, 'Letterbox', s.Size) 		AS	SIZE,	
		IFF(atr.LetterboxAtr > 0, 'Letterbox', s.Size)  	AS	MCD_SIZE	,
			
		CONCAT('{"categories":[', 
			IFNULL(CONCAT(p.CategoryCode, ', '), ''),
			 COALESCE(
					(
					 SELECT LISTAGG(DISTINCT mc.MPCategoryKey , ', ')
					 FROM "RAW_GREETZ"."GREETZ3".contentinformation_category ci
						 JOIN "RAW_GREETZ"."GREETZ3".contentcategory cc
							ON cc.id = ci.contentcategoryid
						/* LEFT JOIN Ignore_AgeCategory ig
							ON ig.entityProduct_key = p.entityProduct_key	*/
						 JOIN "RAW_GREETZ"."GREETZ3".greetz_to_mnpq_categories_view_2 mc 
							 ON  (
								  mc.MPTypeCode =  pt.MPTypeCode_ForCategories
								  OR mc.MPTypeCode = 'ALL'
								  )
							 AND (								
                                ci.contentcategoryid NOT IN
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
								  OR (mc.MPCategoryKey NOT LIKE '%years-old' AND mc.MPCategoryKey NOT IN ('all-kids', 'age-other', 'age-unspecified', 'age-groups'))
								 )					 
                      WHERE ci.contentinformationid = p.contentinformationid  
					)  
		   , pt.DefaultCategoryKey, '' )
		   , ']}')	 
	   AS CATEGORIES,

CONCAT('{',
IFNULL(
		CONCAT(
			'"en":[',
  	  (  SELECT LISTAGG(IFNULL(ct.text, ct2.text) , ', ')
	     FROM "RAW_GREETZ"."GREETZ3".contentinformation_category ci
			 JOIN "RAW_GREETZ"."GREETZ3".contentcategory cc
					   ON cc.id = ci.contentcategoryid
			 LEFT JOIN "RAW_GREETZ"."GREETZ3".contentcategorytranslation ct
					   ON ct.contentcategoryid = cc.id AND ct.locale = 'nl_NL'
			 LEFT JOIN "RAW_GREETZ"."GREETZ3".contentcategorytranslation ct2
					   ON ct2.contentcategoryid = cc.id AND ct2.locale = 'en_EN'
		 WHERE ci.contentinformationid = p.contentinformationid  
	  ),
			'],'
		)
, ''),	
IFNULL(
	CONCAT(
	 '"nl":[',	

  	  (  SELECT LISTAGG(ct2.text , ', ')
	     FROM "RAW_GREETZ"."GREETZ3".contentinformation_category ci
			 JOIN "RAW_GREETZ"."GREETZ3".contentcategory cc
					   ON cc.id = ci.contentcategoryid
			 LEFT JOIN "RAW_GREETZ"."GREETZ3".contentcategorytranslation ct2
					   ON ct2.contentcategoryid = cc.id AND ct2.locale = 'en_EN'
		 WHERE ci.contentinformationid = p.contentinformationid  
	  ),
	']')
, ''),		 		 
'}')
AS	SEARCH_KEYWORDS	,
	 
		CASE 	
			WHEN lower(p.productcode) LIKE '%envelop%' THEN 'Envelop'
			WHEN p.MPTypeCode = 'flower' THEN 'Flowers & Plants'
			WHEN p.MPTypeCode = 'gadget-novelty' THEN 'Gadget / Novelty'
			WHEN p.MPTypeCode = 'gift-card' THEN 'Gift Cards'
			WHEN p.MPTypeCode = 'home-gift' THEN 'Gift for Home'
			WHEN p.MPTypeCode = 'personalised-chocolate' THEN 'Gepersonaliseerde chocolade'
			WHEN p.MPTypeCode = 'personalised-sweets' THEN 'Gepersonaliseerd snoep'
			WHEN p.MPTypeCode = 'sweet' THEN 'Snoep'
			WHEN p.MPTypeCode = 'toy-game' THEN 'Toy / Game'
			WHEN p.MPTypeCode IS NOT NULL  THEN initcap(replace(p.MPTypeCode, '-', ' ')) 
			ELSE p.type
		END  AS PRODUCT_TYPE_NAME, 				
		
		IFNULL(p.MPTypeCode, p.type)  	AS	PRODUCT_KEY	,
				
		CASE 
			WHEN p.MPTypeCode = 'flower' THEN 'Flowers' 	
			WHEN p.MPTypeCode = 'addon' THEN 'Add-on' 
			WHEN p.TYPE IN ('standardGift', 'personalizedGift') THEN 'Gifts'
			WHEN lower(p.productcode) LIKE '%envelop%' THEN 'Envelope'
			ELSE 'Legacy'
		END	 AS	PRODUCT_FAMILY	,			 
		
		IFF(p.removed IS NULL, False, True) 	AS IS_PRODUCT_VARIANT_DELETED	,
		p.removed	AS	PRODUCT_VARIANT_DELETED_TIMESTAMP	,
		IFF(p.removed IS NULL, False, True)	AS	IS_PRODUCT_DELETED	,
		p.removed	AS	PRODUCT_DELETED_TIMESTAMP	,
		NULL	AS	SUPPLIER_NAME	,
		NULL	AS	LEGACY_SUPPLIER_ID	,
		NULL	AS	SUPPLIER_CITY	,
		NULL	AS	SUPPLIER_COUNTRY	,
		NULL	AS	MCD_FINANCE_CATEGORY	,
		NULL	AS	MCD_FINANCE_SUBCATEGORY	,
		current_timestamp()	AS	MESSAGE_TIMESTAMP	,
		'grtz'	AS	BRAND	,
		NULL	AS	RANGE_ID	,
		NULL	AS	FINANCE_PRODUCT_HIERARCHY	,
		'Greetz'	AS	BRAND_DESCRIPTION	

FROM 
         productList p
         JOIN grouped_products pge 
			ON pge.productStandardGift = p.Id
         JOIN "RAW_GREETZ"."GREETZ3".productgroup ppg 
			ON pge.productGroupId = ppg.id
		 JOIN grouped_product_types pt 
			ON pt.productGroupId = pge.productGroupId 
		 LEFT JOIN productList_withAttributes atr 
			ON p.ID = atr.ID
         LEFT JOIN "RAW_GREETZ"."GREETZ3".contentinformationfield cif_nl_descr
			ON cif_nl_descr.contentinformationid = p.contentinformationid
				 AND cif_nl_descr.type = 'DESCRIPTION' 
				 AND cif_nl_descr.locale = 'nl_NL'
		 LEFT JOIN productList_withSize s
			ON p.ID = s.ID	

		 LEFT JOIN attr a_oc	
			  ON a_oc.ID = p.ID AND a_oc.designId = p.designId AND a_oc.INTERNALNAME = 'Occasion'			  
		 LEFT JOIN attr a_tgt	
			  ON a_tgt.ID = p.ID AND a_tgt.designId = p.designId AND a_tgt.INTERNALNAME = 'Target Group'			  
		 LEFT JOIN RAW_GREETZ.GREETZ3.greetz_to_mnpg_relations_view_2 a_rl_2
			  ON a_rl_2.Greetz_Name = a_tgt.Val_Name	
GROUP BY 
		 pge.entityProduct_key,
		 p.ID,
		 p.PRODUCTCODE,
		 p.entityProduct_key,
		 p.CategoryCode,
		 p.contentinformationid,
		 p.MPTypeCode,
		 pt.DefaultCategoryKey,
		 pt.MPTypeCode_ForCategories,
		 COALESCE(ppg.title, replace(ppg.productGroupCode, '_', ' '))	,
		cif_nl_descr.text,
		atr.LetterboxAtr,
		pt.MPTypeCode,
		p.removed,
		p.Level,
		p.ProductCategoryCode,
		s.Size,
		a_oc.Val_Name,
		a_rl_2.MP_Name,
		p.Brand,
		P.TYPE
)


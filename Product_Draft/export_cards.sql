WITH ProductList_0
AS
(
SELECT DISTINCT case when pc.AMOUNTOFPANELS = 2 then concat('GRTZ', cast(cd.ID as varchar(50))) else concat('GRTZ', cast(cd.ID as varchar(50)), '-P') end 
				AS entity_key, 
				cd.ID AS carddefinitionid,
				cd.contentinformationid, pc.productid, 
				p.PRODUCTCODE, cd.showonstore, pc.CARDSIZE, pcp.vatid, pc.cardratio, cd.ORIENTATION, 
				cd.CONTENTCOLLECTIONID, numberofphotos,
				cif_nl_title.text  		AS nl_product_name,
				cif_en_title.text  		AS en_product_name,

				case pc.cardratio
					when 'STANDARD' then 'rectangular'
					when 'SQUARE'   then 'square'
				end  									AS  Attribute_Shape,

				case pc.CARDSIZE
					when 'MEDIUM' then 1	
					when 'LARGE' then 2
					when 'XXL' then 3
					when 'XL' then 4
					when 'SUPERSIZE' then 5
					when 'XS' then 6		
					when 'SMALL' then 7 	
					when 'MINI' then 8
				end  									AS  NumberForSorting,
                pc.AMOUNTOFPANELS                     
				
FROM productcard pc
     JOIN product p 
		ON pc.PRODUCTID = p.ID 
			AND p.TYPE = 'productCardSingle' 
			AND p.CHANNELID = 2 
			AND p.onlyAvailableForFlow is null 
			AND pc.enabled = 'Y' 
			AND p.removed is null
			AND p.endoflife != 'Y'
   --  join productphysicalproperty ppp 
	--	ON p.PRODUCTPHYSICALPROPERTIESID = ppp.ID 
	--		AND ppp.PAPERTYPE in ('DEFAULT', 'InvercoteCreato300')
     JOIN productcardprice pcp 
		ON PRODUCTCARDID = p.ID 
			AND '2022-06-22' between pcp.availableFrom AND pcp.availableTill 
			AND pcp.amountFrom = 1
     JOIN carddefinition cd 
		ON cd.CARDRATIO = pc.CARDRATIO 
			AND cd.OBLONG = pc.OBLONG 
			AND (cd.NUMBEROFPANELS = pc.AMOUNTOFPANELS 
				 OR (pc.AMOUNTOFPANELS = 1 AND cd.NUMBEROFPANELS = 2 AND cd.allowsinglepanel = 'Y'))
     JOIN carddefinition_limitedcardsize cdl 
		ON cdl.CARDDEFINITIONID = cd.ID 
			AND pc.CARDSIZE = cdl.CARDSIZE
	 JOIN carddefinition_channel cdc
			ON cdc.CARDDEFINITIONID = cd.ID
				AND pc.CARDSIZE = cdl.CARDSIZE
	 LEFT JOIN productavailability pa ON p.ID = pa.productid
     LEFT JOIN productavailabilityrange r ON pa.id = r.productavailabilityid
	 LEFT JOIN contentinformationfield cif_nl_title
		  ON cif_nl_title.contentinformationid = cd.contentinformationid
			 AND cif_nl_title.type = 'TITLE' AND cif_nl_title.locale = 'nl_NL'
	 LEFT JOIN contentinformationfield cif_en_title
		  ON cif_en_title.contentinformationid = cd.contentinformationid
			 AND cif_en_title.type = 'TITLE' AND cif_en_title.locale = 'en_EN'
	 LEFT JOIN black_list_for_cards bl ON cd.ID = bl.carddefinitionid
WHERE
	  ((cd.APPROVALSTATUS = 'APPROVED' OR cd.APPROVALSTATUS IS NULL)
	  AND (cd.ENABLED = 'Y' OR cd.ENABLED IS NULL)
	  AND ((cd.EXCLUDEFROMSEARCHINDEX = 'N' AND cif_nl_title.TYPE IS NOT NULL) OR cd.EXCLUDEFROMSEARCHINDEX IS NULL)
	  AND (r.id is null OR (r.orderablefrom <= '2022-06-22' AND '2022-06-22' <= r.shippableto))	 
	  AND cdc.channelID = '2'
	  AND (
			(pc.AMOUNTOFPANELS = 2 AND pc.cardratio = 'STANDARD'  AND pc.CARDSIZE IN ('MEDIUM', 'XXL', 'SUPERSIZE')) 
			OR (pc.AMOUNTOFPANELS = 2 AND pc.cardratio = 'SQUARE' AND pc.CARDSIZE IN ('LARGE', 'XXL', 'SUPERSIZE')) 
			OR (pc.AMOUNTOFPANELS = 1 AND pc.CARDSIZE = 'MEDIUM')
		  )	  
	  AND bl.carddefinitionid IS NULL
	  AND (cif_nl_title.text IS NOT NULL  OR  cif_en_title.text IS NOT NULL)
	  AND concat(:designIds) IS NULL) 
	  OR case when pc.AMOUNTOFPANELS = 2 then cast(cd.ID as varchar(50)) else concat(cast(cd.ID as varchar(50)), '-P') end  IN (:designIds)
),

Carddefinition_Grouped AS
(
SELECT DISTINCT carddefinitionid, contentinformationid, CONTENTCOLLECTIONID
FROM ProductList_0
),

Invitations AS
(
SELECT cd.carddefinitionid
FROM Carddefinition_Grouped cd
	JOIN contentinformation_category ci 
		ON cd.contentinformationid = ci.contentinformationid
	JOIN contentcategory cc
		ON cc.id = ci.contentcategoryid
	JOIN contentcategorytype cct
		ON cct.ID = cc.categorytypeid
	JOIN contentcategorytranslation ct
		ON ct.contentcategoryid = cc.id AND ct.locale = 'en_EN'
WHERE cct.INTERNALNAME = 'Occasion'
		AND lower(ct.TEXT) LIKE '%invit%'
GROUP BY cd.carddefinitionid
),

-- -------------- attributes Occasion, Style, Relation   ---------------------------
attrs_0 AS
(
SELECT DISTINCT cct.INTERNALNAME, cd.carddefinitionid, cd.contentinformationid, ct.TEXT AS Val, ci.CONTENTCATEGORYID AS catID, cc.parentcategoryid
FROM Carddefinition_Grouped cd
	JOIN contentinformation_category ci ON ci.CONTENTINFORMATIONID = cd.CONTENTINFORMATIONID
	JOIN contentcategory cc ON cc.ID = ci.CONTENTCATEGORYID
	JOIN contentcategorytype cct ON cct.ID = cc.categorytypeid 
	JOIN contentcategorytranslation ct ON ct.CONTENTCATEGORYID = cc.ID  AND ct.LOCALE = 'en_EN'
WHERE cct.INTERNALNAME IN ('Occasion', 'Design Style', 'Target Group')
	 AND (cct.INTERNALNAME != 'Design Style' OR lower(ct.TEXT) NOT IN ('hip' ,'with flowers', 'cute', 'english cards', 'dutch cards'))
),

attr_Single_Val AS
(
SELECT INTERNALNAME, carddefinitionid, Val
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
	GROUP_CONCAT(Val ORDER BY parentcategoryid, case when Val like '%years%' then 1 else 0 end, catID  SEPARATOR ' - ') AS Concat_1, 		-- just concatination	
	GROUP_CONCAT(DISTINCT case when parentcategoryid IS NOT NULL then '' else Val END  ORDER BY catID SEPARATOR '') AS Concat_2,  -- parents only
	GROUP_CONCAT(DISTINCT case when parentcategoryid IS NULL then '' else Val END  ORDER BY catID SEPARATOR '') AS Concat_3,  -- childs only 
	SUM(case when parentcategoryid IS NULL then 1 ELSE 0 end) AS parents_cnt,		-- with out childs, amount
	COUNT(*) AS cnt
	-- ,COUNT(DISTINCT CatID) AS cnt_for_check
FROM attrs_0 AS cte 
	JOIN attr_2 AS cte_2 ON cte_2.INTERNALNAME = cte.INTERNALNAME AND cte_2.carddefinitionid = cte.carddefinitionid  
GROUP BY cte.INTERNALNAME,
		 cte.carddefinitionid 
),

/* attr_4 AS 
(
SELECT 	INTERNALNAME, carddefinitionid,	Concat_1, cnt, parents_cnt,
		case when cnt > 2 AND INTERNALNAME = 'Occasion' AND lower(Concat_2) LIKE '%newyearscards%'  then 'Newyears' ELSE Concat_2 END  AS Concat_2,
		Concat_3
FROM attr_3
),*/

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

attr_6 AS
(
SELECT INTERNALNAME,
	   carddefinitionid,
	   lower(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(Val, ' - ' , '-'), ' ' , '-'), '&' , '-and-'), '+' , 'plus'), '?' , ''),     '''' , '_'), '(' , ''), ')' , ''), '%', ''), '.', ''), '/', ''), '!', ''), 'ë', 'e'), '’', '_'), '*', ''))	AS Val_Code,
	   concat(ucase(LEFT(Val, 1)), SUBSTRING(Val ,2))  AS Val_Name
FROM attr_5
GROUP BY INTERNALNAME,
	   carddefinitionid,
	   lower(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(Val, ' - ' , '-'), ' ' , '-'), '&' , '-and-'), '+' , 'plus'), '?' , ''),     '''' , '_'), '(' , ''), ')' , ''), '%', ''), '.', ''), '/', ''), '!', ''), 'ë', 'e'), '’', '_'), '*', ''))
),

attr AS
(
SELECT INTERNALNAME, carddefinitionid, Val_Code, Val_Name
FROM attr_6
	 LEFT JOIN export_occasions_view e_oc ON attr_6.Val_Code = e_oc.entity_key AND attr_6.INTERNALNAME = 'Occasion'
	 LEFT JOIN export_styles_view e_st ON attr_6.Val_Code = e_st.entity_key AND attr_6.INTERNALNAME = 'Design Style'
WHERE (attr_6.INTERNALNAME != 'Occasion' OR e_oc.entity_key IS NOT NULL)
	   AND
	  (attr_6.INTERNALNAME != 'Design Style' OR e_st.entity_key IS NOT NULL)
),


-- ----------------------------------------------------------

ProductList
AS
(
SELECT *, 
		case 
			when CARDSIZE = 'MEDIUM' AND cardratio = 'STANDARD' then 'standard'
			when CARDSIZE = 'LARGE' AND cardratio = 'SQUARE' then 'standard'
			when CARDSIZE = 'XXL' then 'large'
			when CARDSIZE = 'SUPERSIZE' then 'giant'
		end  AS Attribute_Size,

		ROW_NUMBER() OVER(PARTITION BY entity_key ORDER BY NumberForSorting)  AS RN_MasterVariant
	
FROM ProductList_0
),

Image_BackSize
AS
(
SELECT carddefinitionid, MAX(i.WIDTH) AS WIDTH, MAX(i.HEIGHT) AS HEIGHT
FROM ProductList pl
	JOIN imagepreviewsetting i 
		ON i.CARDRATIOCODE = pl.cardratio AND i.ORIENTATION = pl.ORIENTATION
WHERE i.TYPE = 'DESIGN_DEFINITION' AND i.side = 'BACKSIDE' 
GROUP BY carddefinitionid
)

SELECT 
		pl.entity_key,
		nl_product_name,
		en_product_name,
		case when pl.AMOUNTOFPANELS = 2 then 'greetingcard' else 'postcard' end 		AS product_type_key,
		pl.carddefinitionid 	AS design_id,
		pl.Attribute_Shape		AS shape,
        IFNULL(pr.product_range_key,'range-tangled')	AS 'range',
		pl.entity_key	  AS slug,

		case 
			when (cif_nl_descr.text IS NOT NULL  OR  cif_nl_descr_2.text IS NOT NULL)
			then concat(IFNULL(concat(cif_nl_descr_2.text, '\n\n'), ''), IFNULL(cif_nl_descr.text, '')) 
			else cif_nl_descr.text												           
	    end				   AS product_nl_description,
		
	    case 
			when (cif_en_descr.text IS NOT NULL  OR  cif_en_descr_2.text IS NOT NULL)
			then concat(IFNULL(concat(cif_en_descr_2.text, '\n\n'), ''), IFNULL(cif_en_descr.text, '')) 
			else cif_en_descr.text												           
	    end				   AS product_en_description,
		
		concat('vat', v.vatcode)       AS tax_category_key,
		pl.showonstore				   AS show_on_store,
		null  						   AS meta_title_nl,
        null  						   AS meta_description_nl,
		
		 (SELECT group_concat(IFNULL(ct.text, ct2.text) separator ', ')
	     FROM contentinformation_category ci
			 JOIN contentcategory cc
					   ON cc.id = ci.contentcategoryid
			 LEFT JOIN contentcategorytranslation ct
					   ON ct.contentcategoryid = cc.id AND ct.locale = 'nl_NL'
			 LEFT JOIN contentcategorytranslation ct2
					   ON ct2.contentcategoryid = cc.id AND ct2.locale = 'en_EN'
		 WHERE ci.contentinformationid = pl.contentinformationid)					  AS keywords_nl,

  	  (  SELECT group_concat(ct2.text separator ', ')
	     FROM contentinformation_category ci
			 JOIN contentcategory cc
					   ON cc.id = ci.contentcategoryid
			 LEFT JOIN contentcategorytranslation ct2
					   ON ct2.contentcategoryid = cc.id AND ct2.locale = 'en_EN'
		 WHERE ci.contentinformationid = pl.contentinformationid)  					  AS keywords_en,
		
		 IFNULL(
		(
			 SELECT group_concat(DISTINCT(mc.MPCategoryKey) separator ', ')
			 FROM contentinformation_category ci
				 JOIN contentcategory cc
					ON cc.id = ci.contentcategoryid
				 JOIN greetz_to_mnpq_categories_cards_view mc 
					ON mc.GreetzCategoryID = cc.id 
			 WHERE ci.contentinformationid = pl.contentinformationid  
					AND mc.MPCategoryKey IS NOT NULL
		)  
	   , 'greeting-cards')	 AS category_keys,
		
		replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(concat('[', 
		group_concat(JSON_OBJECT(
		   'variantKey', concat(pl.entity_key, 
						   case pl.Attribute_Shape when 'square' then '-SQ' else '' end, 
						   '-', 
						   upper(pl.Attribute_Size), 
						--   case pl.Attribute_Shape when 'square' then 'SQUARE' else '' end, 
						   'CARD'),
		   'skuId', concat(pl.entity_key, 
						   case pl.Attribute_Shape when 'square' then '-SQ' else '' end, 
						   '-', 
						   upper(pl.Attribute_Size), 
						   case pl.Attribute_Shape when 'square' then 'SQUARE' else '' end, 
						   'CARD'),
		   'masterVariant', CASE WHEN pl.RN_MasterVariant = 1 THEN 1 ELSE 0 END,
           'productCode', replace(pl.entity_key, 'GRTZ', ''),
		   'images', CASE
						WHEN pl.RN_MasterVariant = 1 THEN concat('[',
                        concat(JSON_OBJECT('cardDefinitionId', pl.carddefinitionid, 'panels', pl.AMOUNTOFPANELS, 'imageCode', 'front.jpg'), ',' ,
                                     case when pl.AMOUNTOFPANELS = 2 then concat(JSON_OBJECT('cardDefinitionId', pl.carddefinitionid, 'panels', pl.AMOUNTOFPANELS, 'imageCode', 'inside_left.jpg'), ',') else '' end,
                                     case when pl.AMOUNTOFPANELS = 2 then concat(JSON_OBJECT('cardDefinitionId', pl.carddefinitionid, 'panels', pl.AMOUNTOFPANELS, 'imageCode', 'inside_right.jpg'), ',') else '' end,
                                     JSON_OBJECT('cardDefinitionId', pl.carddefinitionid, 'panels', pl.AMOUNTOFPANELS, 'width', IFNULL(i.WIDTH, 0), 'height', IFNULL(i.HEIGHT, 0), 'imageCode', 'backside.jpg'))
							, ']')
						ELSE '[]'
					 END,
		   'productPrices', (SELECT concat('[', group_concat(JSON_OBJECT('priceKey', cp.id, 'currency', cp.currency,
									'priceWithVat', cp.pricewithvatloggedin + IFNULL(pcp.pricewithvat, 0), 
									'validFrom', CAST(cp.availablefrom AS datetime(6)), 'validTo', CAST(cp.availabletill AS datetime(6)))
									 separator ','), ']')
							 FROM productcardprice cp
								  LEFT JOIN carddefinition_productcontent dpc
									ON dpc.CARDDEFINITIONID = pl.carddefinitionid 
										AND dpc.CHANNELID = 2
								  LEFT JOIN productcontentprice pcp
									ON pcp.PRODUCTCONTENTID = dpc.PRODUCTCONTENTID
									   AND pcp.amountfrom = 1
									   AND '2022-06-22' BETWEEN pcp.availablefrom AND pcp.availabletill
									   AND pcp.cardsize = pl.cardsize
									   AND cp.currency = pcp.currency
							 WHERE cp.productcardid = pl.productid
									AND '2022-06-22' between cp.availableFrom AND cp.availableTill 
									AND cp.amountFrom = 1
							 ),
							 
			'attributes', CONCAT('[', 
				case when pl.AMOUNTOFPANELS = 2 then CONCAT('{"attributeName": "size", "attributeValue": "', pl.Attribute_Size, 
				'", "attributeType": "enum"}, {"attributeName": "shape", "attributeValue": "', pl.Attribute_Shape, '", "attributeType": "enum"}, ') 
				else '' end,
				'{"attributeName": "range", "attributeValue": "', IFNULL(replace(pr.product_range_key, 'range-', ''),'tangled'),						
				'", "attributeType": "enum"}, {"attributeName": "product-range", "attributeValue": "', IFNULL(pr.product_range_key,'range-tangled'), '", "attributeType": "category-reference"},',
				'{"attributeName": "product-range-text", "attributeValue": "', IFNULL(pr.product_range_text,'Tangled'), '", "attributeType": "text"},',
				'{"attributeName": "photo-count", "attributeValue": "', case when pl.numberofphotos >= 0 then pl.numberofphotos else 0 end, '", "attributeType": "number"},',
				'{"attributeName": "reporting-artist", "attributeValue": "anonymous", "attributeType": "enum"},',
				'{"attributeName": "reporting-occasion", "attributeValue": "' , COALESCE(a_oc.Val_Code, a_oc_2.occasion_code, "general>general"), '", "attributeType": "enum"},',
				'{"attributeName": "reporting-relation", "attributeValue": "' , IFNULL(a_rl_2.MP_Code, "nonrelations"), '", "attributeType": "enum"},',
				'{"attributeName": "reporting-style", "attributeValue": "' , IFNULL(a_des.Val_Code, "design>general"), '", "attributeType": "enum"}]')
			
		   ) SEPARATOR ','), ']'), '"[{\\"', '[{"'), '\"}]"}', '"}]}'), '\\', ''), '}]",', '}],'), '"{"', '{"'), '"}"', '"}'), 'rntttt', ''), ']"}]', ']}]'), '}]"}', '}]}'), '"[]"', '[]')
	    AS product_variants	
	   
FROM ProductList pl	
	 LEFT JOIN vat v
		  ON pl.vatid = v.id AND v.countrycode = 'NL'
	 LEFT JOIN contentinformationfield cif_nl_descr
		  ON cif_nl_descr.contentinformationid = pl.contentinformationid
			 AND cif_nl_descr.type = 'DESCRIPTION' AND cif_nl_descr.locale = 'nl_NL'
	 LEFT JOIN contentinformationfield cif_nl_descr_2
		  ON cif_nl_descr_2.contentinformationid = pl.contentinformationid
			 AND cif_nl_descr_2.type = 'PRODUCT_DESCRIPTION' AND cif_nl_descr_2.locale = 'nl_NL'
	 LEFT JOIN contentinformationfield cif_en_descr
		  ON cif_en_descr.contentinformationid = pl.contentinformationid
			 AND cif_en_descr.type = 'DESCRIPTION' AND cif_en_descr.locale = 'en_EN'	
	 LEFT JOIN contentinformationfield cif_en_descr_2
		  ON cif_en_descr_2.contentinformationid = pl.contentinformationid
			 AND cif_en_descr_2.type = 'PRODUCT_DESCRIPTION' AND cif_en_descr_2.locale = 'en_EN'	
	 LEFT JOIN Image_BackSize i
		  ON i.carddefinitionid = pl.carddefinitionid	
	 LEFT JOIN attr a_oc	
		  ON a_oc.carddefinitionid = pl.carddefinitionid AND a_oc.INTERNALNAME = 'Occasion'
	/* LEFT JOIN export_occasions_view e_oc
		  ON a_oc.Val_Code = e_oc.entity_key*/
	 LEFT JOIN attr a_des	
		  ON a_des.carddefinitionid = pl.carddefinitionid AND a_des.INTERNALNAME = 'Design Style'	
	/* LEFT JOIN export_styles_view e_des
		  ON a_des.Val_Code = e_des.entity_key*/		  
	 LEFT JOIN attr a_tgt	
		  ON a_tgt.carddefinitionid = pl.carddefinitionid AND a_tgt.INTERNALNAME = 'Target Group'			  
	 LEFT JOIN greetz_to_mnpg_relations_view a_rl_2
		  ON a_rl_2.Greetz_Name = a_tgt.Val_Name		  
	 LEFT JOIN greetz_to_mnpg_ranges_map_view pr
		  ON pr.content_collection_ID = pl.CONTENTCOLLECTIONID	
	 LEFT JOIN greetz_to_mnpg_multioccasions_view a_oc_2
		  ON a_oc_2.design_id = pl.carddefinitionid		
	 LEFT JOIN Invitations inv
		  ON inv.carddefinitionid = pl.carddefinitionid	
WHERE
		(inv.carddefinitionid IS NULL  OR  Attribute_Size = 'standard')
	/*	AND e_oc.entity_key IS NOT NULL 
		AND e_des.entity_key IS NOT NULL */
		(pl.entity_key > :migrateFromId OR :migrateFromId IS NULL)
		AND	(pl.entity_key <= :migrateToId OR :migrateToId IS NULL)
		AND (concat(:keys) IS NULL  OR  pl.entity_key IN (:keys))
GROUP BY 
		pl.entity_key
LIMIT :limit		


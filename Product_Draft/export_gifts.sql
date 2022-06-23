WITH productList_0 AS
(
SELECT DISTINCT p.ID, pt.entity_key, pt.AttributesTemplate, pt.MPTypeCode, p.contentinformationid, pt.DefaultCategoryKey, 
		p.channelid, p.PRODUCTCODE, p.INTERNALNAME, pg.showonstore, z.designId, z.design_contentinformationid, pgp.vatid,
		
		concat('GRTZ', case when z.designProductId IS NULL then cast(p.ID as varchar(50)) else concat('D', cast(z.designProductId as varchar(50))) end)
		AS entityProduct_key
		
		/*lower(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(case p.channelid when 2 then p.PRODUCTCODE else 
		concat(p.PRODUCTCODE, '_', CAST(p.channelid AS VARCHAR(10))) end, ' - ' , '_'), ' ' , '_'), '&' , 'and'), '+' , 'plus'), '?' , ''), '''' , ''), '(' , ''), ')' , ''), '%', ''), 'ï', 'ii'))
		AS entityProduct_key*/

FROM product p  
	JOIN productgift pg 
		ON pg.productid = p.id
	LEFT JOIN productgiftprice pgp 
		ON pgp.productgiftid = p.id
		 --  AND pgp.AVAILABLETILL > '2022-06-03'
	LEFT JOIN greetz_to_mnpg_product_types_view pt
		ON pt.GreetzTypeID = IFNULL(pg.productgiftcategoryid, pg.productgifttypeid)
	LEFT JOIN 
		(
		 SELECT cd.ID AS designId, ppd.id AS designProductId, ppd.product, cd.contentinformationid AS design_contentinformationid
		 FROM productpersonalizedgiftdesign ppd 				
			 JOIN carddefinition cd 
					ON cd.ID = ppd.GIFTDEFINITION
						AND cd.ENABLED = 'Y'
						AND cd.APPROVALSTATUS = 'APPROVED'
						AND cd.CONTENTTYPE = 'STOCK'
		) z
			ON z.product = p.ID	
			
WHERE  p.id IN (:productIds) OR concat(:productIds) IS NULL
	  /*p.channelid = '2'
	   AND p.removed IS NULL
	   AND p.endoflife != 'Y'
	   AND pgp.AVAILABLETILL > '2022-04-15'
	   AND r.productavailabilityid IS NULL*/
	 --  AND pt.entity_key IN ('flower', 'alcohol', 'home-gift', 'chocolate', 'cake')
),

productList AS
(
SELECT * 
FROM productList_0
WHERE 
	 concat(:keys) IS NULL
	 OR (entityProduct_key in (:keys) 
		 OR ID IN 
		   (
			  SELECT pge.productstandardgift
			  FROM productgroup pg
				   JOIN productgroupentry pge ON pg.id = pge.productGroupId
				   JOIN product p ON p.ID = pge.productstandardgift
				   JOIN productList_0 pl 
						ON pl.ID = p.ID
							AND pl.MPTypeCode = 'flower'
			  WHERE -- lower(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(pg.productGroupCode, ' - ' , '_'), ' ' , '_'), '&' , 'and'), '+' , 'plus'), '?' , ''), '''' , ''), '(' , ''), ')' , ''), '%', ''), 'ï', 'ii'))
					 concat('GRTZG', cast(pg.ID as varchar(50))) IN (:keys) 
					 AND pg.approvalStatus != 'DEACTIVATED'
		   )
		)
),

productList_withAttributes AS
(
SELECT  pl.ID, 
		SUM(case when c.INTERNALNAME = 'Size' AND lower(ct.text) = 'large' then 1 else 0 end) as LargeAtr,		
		-- 'letterbox gifts', 'bloompost', 'brievenbuscadeau', 'Cardboxes L2', 'Cardboxes L3', 'Chocoladeletters', 'Chocolate telegram', 'Telegram'
		SUM(case when ci.contentcategoryid 
			in (1143763303, 1143763773, 1143731608, 1143732596, 1143737611, 1143735338, 1143730173, 1143730254) 
			then 1 else 0 end) as LetterboxAtr
FROM productList pl
	 JOIN contentinformation_category ci
		  ON pl.contentinformationid = ci.contentinformationid
	 JOIN contentcategory cc
		  ON cc.id = ci.contentcategoryid
	 JOIN contentcategorytranslation ct
		  ON ct.contentcategoryid = cc.id
			AND ct.locale = 'en_EN'
	 JOIN contentcategorytype c
	      ON cc.categorytypeid = c.id
WHERE c.INTERNALNAME != 'Keywords'   		  
GROUP BY pl.ID		  
),

productList_withAttributes_2 AS
(
SELECT  pl.ID,
		ct.text as BrandAttr
FROM productList pl
	 JOIN contentinformation_category ci
		  ON pl.contentinformationid = ci.contentinformationid
	 JOIN contentcategory cc
		  ON cc.id = ci.contentcategoryid
	 JOIN contentcategorytranslation ct
		  ON ct.contentcategoryid = cc.id
			AND ct.locale = 'en_EN'
	 JOIN contentcategorytype c
	      ON cc.categorytypeid = c.id
WHERE pl.MPTypeCode = 'gift-card'
	  AND c.INTERNALNAME = 'Brand/Designer'   		  	  
),

grouped_products_0 AS
( 
	SELECT  pge.productStandardGift, 
			pge.productGroupId,
			pge.showonstore,
			pl.contentinformationid,
			pl.productCode,
			pl.channelid,
			
		--	lower(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(ppg.productGroupCode, ' - ' , '_'), ' ' , '_'), '&' , 'and'), '+' , 'plus'), '?' , ''), '''' , ''), '(' , ''), ')' , ''), '%', ''), 'ï', 'ii'))
		--	AS entityProduct_key
			
			concat('GRTZG', cast(ppg.ID as varchar(50))) AS entityProduct_key
			
	FROM productgroupentry AS pge
		JOIN productgroup ppg ON pge.productGroupId = ppg.id 
	 	JOIN productList pl ON pl.ID = pge.productStandardGift		
	WHERE pl.MPTypeCode = 'flower' 
		  AND ppg.approvalStatus != 'DEACTIVATED'			
),

grouped_products AS
( 
SELECT *
FROM grouped_products_0
WHERE concat(:keys) IS NULL
	  OR entityProduct_key in (:keys)
),

grouped_product_types_0 AS
(
	SELECT pge.productGroupId, pl.entity_key, pl.AttributesTemplate, pl.MPTypeCode, pl.DefaultCategoryKey, 
		   ROW_NUMBER() OVER(PARTITION BY pge.productGroupId ORDER BY pge.productStandardGift) AS RN
	FROM grouped_products pge
		 JOIN productList pl ON pl.ID = pge.productStandardGift
),

grouped_product_types AS
(
SELECT * FROM grouped_product_types_0 WHERE RN = 1
),

MasterVariant_productStandardGift_0 AS
(
	SELECT pge.productGroupId, pge.productStandardGift,
			 ROW_NUMBER() OVER(
					PARTITION BY pge.productGroupId 
					ORDER BY case when a.LargeAtr > 0 then 2 when a.LetterboxAtr > 0 then 3 else 1 end,  -- flowers: priority for master: 1.Standart, 2.Large, 3.Letterbox
							 pge.productStandardGift) 
			 AS RN
	FROM grouped_products pge
		 JOIN productList pl ON pl.ID = pge.productStandardGift
		 LEFT JOIN productList_withAttributes a ON pl.ID = a.ID
),

MasterVariant_productStandardGift AS
(
SELECT * FROM MasterVariant_productStandardGift_0 WHERE RN = 1
),

cte_productimage_0
AS
(
SELECT pi.PRODUCTID, pi.CODE, pi.WIDTH, pi.HEIGHT, pi.db_updated, pi.EXTENSION, pi.giftdefinition as designId,
	   ROW_NUMBER() OVER(PARTITION BY pi.PRODUCTID, pi.CODE, pi.giftdefinition ORDER BY pi.WIDTH DESC) AS RN
FROM productimage pi
	 JOIN productList pl ON pi.productid = pl.ID
WHERE pi.WIDTH <= 2000 AND pi.HEIGHT <= 2000 AND EXTENSION IN ('.png', '.jpeg', '.jpg', '.gif')
),

cte_productimage
AS
(
SELECT * FROM cte_productimage_0 WHERE RN = 1
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
		(SELECT * FROM productList WHERE designId IS NOT NULL) p
		 LEFT JOIN contentinformationfield cif_nl_descr_design
			  ON cif_nl_descr_design.contentinformationid = p.design_contentinformationid
				 AND cif_nl_descr_design.type = 'DESCRIPTION' AND cif_nl_descr_design.locale = 'nl_NL'	
         LEFT JOIN contentinformationfield cif_nl_descr_design_2
			  ON cif_nl_descr_design_2.contentinformationid = p.design_contentinformationid
				 AND cif_nl_descr_design_2.type = 'PRODUCT_DESCRIPTION' AND cif_nl_descr_design_2.locale = 'nl_NL'
         LEFT JOIN contentinformationfield cif_en_descr_design
			  ON cif_en_descr_design.contentinformationid = p.design_contentinformationid
				 AND cif_en_descr_design.type = 'DESCRIPTION' AND cif_en_descr_design.locale = 'en_EN'	
         LEFT JOIN contentinformationfield cif_en_descr_design_2
			  ON cif_en_descr_design_2.contentinformationid = p.design_contentinformationid
				 AND cif_en_descr_design_2.type = 'PRODUCT_DESCRIPTION' AND cif_en_descr_design_2.locale = 'en_EN'
		
)

SELECT p.entityProduct_key  AS entity_key,
       IFNULL(cif_nl_title.text, replace(p.INTERNALNAME, '_', ' '))                        AS nl_product_name,
       cif_en_title.text                                                                   AS en_product_name,
       p.MPTypeCode                                                                        AS product_type_key,
	   p.designId,
       concat(SUBSTRING_INDEX(p.entity_key, '-', 1), '_', p.entityProduct_key)             AS slug,
       
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
	   end																				AS product_nl_description,

	   case when design_contentinformationid IS NULL then
		   case 
				when p.MPTypeCode in ('alcohol','biscuit','cake','chocolate','personalised-alcohol','sweet') 
					 AND (cif_en_descr.text IS NOT NULL  OR  cif_en_descr_2.text IS NOT NULL)
				then concat(IFNULL(concat(cif_en_descr.text, '\n\n'), ''), IFNULL(cif_en_descr_2.text, '')) 
				else cif_en_descr.text												           
		   end																				   
	   else   
		   IFNULL(dfd.product_en_description,
					case 
					when p.MPTypeCode in ('alcohol','biscuit','cake','chocolate','personalised-alcohol','sweet') 
						 AND (cif_en_descr.text IS NOT NULL  OR  cif_en_descr_2.text IS NOT NULL)
					then concat(IFNULL(concat(cif_en_descr.text, '\n\n'), ''), IFNULL(cif_en_descr_2.text, '')) 
					else cif_en_descr.text												           
					end	
				 )
	   end																				   AS product_en_description,   
	   
       concat('vat', v.vatcode)                                                            AS tax_category_key, 
       p.showonstore																	   AS show_on_store,
	   
	   	(SELECT Value 
		 FROM productmetadata pmd 
		 WHERE pmd.productid = p.id 
		 		 AND pmd.name IN ('greetz.name', 'greetz.name.long')
		 ORDER BY pmd.name DESC
		 LIMIT 1) 																			AS meta_title_nl,
		 
		(SELECT Value 
		 FROM productmetadata pmd 
		 WHERE pmd.productid = p.id 
		 		 AND pmd.name IN ('greetz.description.short', 'greetz.description.long')
		 ORDER BY pmd.name ASC
		 LIMIT 1) 																			AS meta_description_nl,
	   
	   group_concat(IFNULL(ct.text, ct2.text) separator ', ') 								AS keywords_nl,
	   group_concat(ct2.text separator ', ') 												AS keywords_en,
	   
	   IFNULL(
			group_concat(DISTINCT(IFNULL(mc.MPCategoryKey, p.DefaultCategoryKey)) separator ', ')   
	   , p.DefaultCategoryKey) 	AS category_keys,


	   replace(replace(replace(replace(replace(replace(replace(replace(replace(concat('[', JSON_OBJECT(
		   'variantKey', Concat(p.entityProduct_key, case when p.MPTypeCode = 'flower' AND atr.LargeAtr > 0 then '-LARGE' else '-STANDARD' end),
		   'skuId', Concat(p.entityProduct_key, case when p.MPTypeCode = 'flower' AND atr.LargeAtr > 0 then '-LARGE' else '-STANDARD' end),
		   'masterVariant', true,
           'productCode', p.PRODUCTCODE,
		   'images',   (SELECT concat('[', group_concat(
							JSON_OBJECT(
									'imageCode', pim.CODE,
									'designId', p.designId,
									'width', pim.WIDTH,
									'height', pim.HEIGHT)
						), ']')
						FROM cte_productimage pim
						WHERE pim.PRODUCTID = p.ID and (p.designId is null or p.designId = pim.designId)
						ORDER BY pim.CODE),
		   'productPrices', IFNULL((SELECT concat('[', group_concat(JSON_OBJECT('priceKey', pgp2.id, 'currency', pgp2.currency,
											'priceWithVat', pgp2.pricewithvat, 'validFrom', pgp2.availablefrom, 'validTo', pgp2.availabletill)
											 separator ','), ']')
									FROM productgiftprice pgp2
									WHERE pgp2.productgiftid = p.id), '[]'),
			'attributes', case 
							when p.MPTypeCode = 'flower' AND atr.LargeAtr > 0 then replace(p.AttributesTemplate, '"attributeValue": "standard"', '"attributeValue": "large"')
							when p.MPTypeCode = 'flower' AND  atr.LetterboxAtr > 0 then replace(p.AttributesTemplate, '"attributeValue": "standard"', '"attributeValue": "letterbox"')	
							when atr.LetterboxAtr > 0 AND p.MPTypeCode IN ('chocolate', 'alcohol', 'beauty', 'biscuit', 'gadget-novelty', 'sweet', 'toy-game') 
								then replace(p.AttributesTemplate, '"letterbox-friendly", "attributeValue": "false"',   '"letterbox-friendly", "attributeValue": "true"')
							when p.MPTypeCode = 'gift-card' then replace(
																	replace(p.AttributesTemplate, 'SKUNumber', Concat(p.id, IFNULL(concat('_', p.designId), ''), '-STANDARD')),
																	'unspecified',
																	IFNULL((SELECT replace(replace(lower(BrandAttr), ' ', '_'), '.', '_') FROM productList_withAttributes_2 WHERE ID = p.ID LIMIT 1), 'unspecified')
																	)
						    else  p.AttributesTemplate
						  end
						  )
		   , ']'), '"[{\\"', '[{"'), '\"}]"}', '"}]}'), '\\', ''), '}]",', '}],'), '"{"', '{"'), '"}"', '"}'), 'ntttttt', ''), ']"}]', ']}]')   , '"[]"', '[]') 
		AS product_variants,
		p.ID AS productId
FROM 
         productList p
         LEFT JOIN vat v
              ON p.vatid = v.id AND v.countrycode = 'NL'
			  
         LEFT JOIN contentinformationfield cif_nl_title
			  ON cif_nl_title.contentinformationid = p.contentinformationid
				 AND cif_nl_title.type = 'TITLE' AND cif_nl_title.locale = 'nl_NL'
         LEFT JOIN contentinformationfield cif_nl_descr
			  ON cif_nl_descr.contentinformationid = p.contentinformationid
				 AND cif_nl_descr.type = 'DESCRIPTION' AND cif_nl_descr.locale = 'nl_NL'
		 LEFT JOIN contentinformationfield cif_nl_descr_2
			  ON cif_nl_descr_2.contentinformationid = p.contentinformationid
				 AND cif_nl_descr_2.type = 'PRODUCT_DESCRIPTION' AND cif_nl_descr_2.locale = 'nl_NL'

         LEFT JOIN contentinformationfield cif_en_title
			  ON cif_en_title.contentinformationid = p.contentinformationid
				 AND cif_en_title.type = 'TITLE' AND cif_en_title.locale = 'en_EN'
         LEFT JOIN contentinformationfield cif_en_descr
			  ON cif_en_descr.contentinformationid = p.contentinformationid
				 AND cif_en_descr.type = 'DESCRIPTION' AND cif_en_descr.locale = 'en_EN'	
         LEFT JOIN contentinformationfield cif_en_descr_2
			  ON cif_en_descr_2.contentinformationid = p.contentinformationid
				 AND cif_en_descr_2.type = 'PRODUCT_DESCRIPTION' AND cif_en_descr_2.locale = 'en_EN'
				 
		 LEFT JOIN cte_DescrForDesigns dfd 
			  ON p.ID = dfd.ID AND p.designId = dfd.designId
			  
         LEFT JOIN contentinformation_category ci
              ON p.contentinformationid = ci.contentinformationid
         LEFT JOIN contentcategory cc
              ON cc.id = ci.contentcategoryid
         LEFT JOIN contentcategorytranslation ct
              ON ct.contentcategoryid = cc.id AND ct.locale = 'nl_NL'
		 LEFT JOIN contentcategorytranslation ct2
              ON ct2.contentcategoryid = cc.id AND ct2.locale = 'en_EN'
         LEFT JOIN greetz_to_mnpq_categories_view mc 
			  ON mc.GreetzCategoryID = cc.id
				 AND mc.MPTypeCode = p.MPTypeCode
		 LEFT JOIN productList_withAttributes atr
			  ON p.ID = atr.ID
			
WHERE p.id NOT IN 	(SELECT pge.productstandardgift
					 FROM productgroupentry pge
						  JOIN productgroup ppg ON pge.productGroupId = ppg.id 
						  JOIN productList pl ON pge.productstandardgift = pl.ID
					 WHERE pl.MPTypeCode = 'flower' 
						   AND ppg.approvalStatus != 'DEACTIVATED')  
						   
	  AND (concat(:keys) IS NULL  OR  entityProduct_key in (:keys))
--	AND pt.entity_key IN ('flower', 'alcohol', 'home-gift', 'chocolate', 'cake')
GROUP BY p.entityProduct_key, 
		 p.designId

UNION ALL

SELECT pge.entityProduct_key AS entity_key,
       COALESCE(ppg.title, replace(ppg.productGroupCode, '_', ' '))            AS nl_product_name,
       COALESCE(ppg.title, replace(ppg.productGroupCode, '_', ' '))            AS en_product_name,
       pt.MPTypeCode                                                           AS product_type_key,
	   NULL 																   AS designId,
       concat(SUBSTRING_INDEX(pt.entity_key, '-', 1), '_', pge.entityProduct_key) 	AS slug,
       cif_nl_descr.text                                                  	   AS product_nl_description,
       cif_nl_descr.text                                                  	   AS product_en_description,
       concat('vat', v.vatcode)                                                AS tax_category_key,
	   pge.showOnStore 													   	   AS show_on_store,
       null                                                                    AS meta_title,
       null                                                                    AS meta_description,

  	  (  SELECT group_concat(IFNULL(ct.text, ct2.text) separator ', ')
	     FROM contentinformation_category ci
			 JOIN contentcategory cc
					   ON cc.id = ci.contentcategoryid
			 LEFT JOIN contentcategorytranslation ct
					   ON ct.contentcategoryid = cc.id AND ct.locale = 'nl_NL'
			 LEFT JOIN contentcategorytranslation ct2
					   ON ct2.contentcategoryid = cc.id AND ct2.locale = 'en_EN'
		 WHERE ci.contentinformationid = p.contentinformationid  
	  )  AS keywords_nl,

  	  (  SELECT group_concat(ct2.text separator ', ')
	     FROM contentinformation_category ci
			 JOIN contentcategory cc
					   ON cc.id = ci.contentcategoryid
			 LEFT JOIN contentcategorytranslation ct2
					   ON ct2.contentcategoryid = cc.id AND ct2.locale = 'en_EN'
		 WHERE ci.contentinformationid = p.contentinformationid  
	  )  AS keywords_en,
	 
	 IFNULL(
			(
			 SELECT group_concat(DISTINCT(IFNULL(mc.MPCategoryKey, pt.DefaultCategoryKey )) separator ', ')
			 FROM contentinformation_category ci
				 JOIN contentcategory cc
					ON cc.id = ci.contentcategoryid
				 JOIN greetz_to_mnpq_categories_view mc 
					ON mc.GreetzCategoryID = cc.id 
					   AND mc.MPTypeCode = pt.MPTypeCode
			 WHERE ci.contentinformationid = p.contentinformationid  
			)  
	   , pt.DefaultCategoryKey )	 AS category_keys,

	   replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(concat('[', group_concat(JSON_OBJECT(
		  -- 'variantKey', Concat(pge.productgroupid, concat('_', pge.productStandardGift)),
		   'variantKey', Concat(p.entityProduct_key, case when p.MPTypeCode = 'flower' AND atr.LargeAtr > 0 then '-LARGE' else '-STANDARD' end),
		   -- 'skuId', Concat(pge.productgroupid, concat('_', pge.productStandardGift)),
		   'skuId', Concat(p.entityProduct_key, case when p.MPTypeCode = 'flower' AND atr.LargeAtr > 0 then '-LARGE' else '-STANDARD' end),
		   'masterVariant', CASE WHEN mv.productStandardGift IS NOT NULL THEN 1 ELSE 0 END,
           'productCode', p.PRODUCTCODE,
		   'images', (SELECT concat('[', group_concat(
						JSON_OBJECT('imageCode', pim.CODE,
									'designId', null,
									'width', pim.WIDTH,
									'height', pim.HEIGHT)
						), ']')
						FROM cte_productimage pim
						WHERE pim.PRODUCTID = p.ID
						ORDER BY pim.CODE),

		   'productPrices', IFNULL((SELECT concat('[', group_concat(JSON_OBJECT('priceKey', pgp2.id, 'currency', pgp2.currency,
											'priceWithVat', pgp2.pricewithvat, 'validFrom', pgp2.availablefrom, 'validTo', pgp2.availabletill)
											 separator ','), ']')
									FROM productgiftprice pgp2
									WHERE pgp2.productgiftid = p.id), '[]'),
							 
			'attributes', case 
							when pt.MPTypeCode = 'flower' AND atr.LargeAtr > 0 then replace(pt.AttributesTemplate, '"attributeValue": "standard"', '"attributeValue": "large"')
							when pt.MPTypeCode = 'flower' AND  atr.LetterboxAtr > 0 then replace(pt.AttributesTemplate, '"attributeValue": "standard"', '"attributeValue": "letterbox"')							
							when atr.LetterboxAtr > 0 AND pt.MPTypeCode IN ('chocolate', 'alcohol', 'beauty', 'biscuit', 'gadget-novelty', 'sweet', 'toy-game') 
								then replace(pt.AttributesTemplate, '"letterbox-friendly", "attributeValue": "false"',   '"letterbox-friendly", "attributeValue": "true"')
							when p.MPTypeCode = 'gift-card' then replace(
																	replace(pt.AttributesTemplate, 'SKUNumber', Concat(pge.productgroupid, IFNULL(concat('_', pge.productStandardGift), ''))),
																	'unspecified',
																	IFNULL((SELECT replace(replace(lower(BrandAttr), ' ', '_'), '.', '_') FROM productList_withAttributes_2 WHERE ID = p.ID LIMIT 1), 'unspecified')
																  )							
							else  pt.AttributesTemplate
						  end
			
		   ) SEPARATOR ','), ']'), '"[{\\"', '[{"'), '\"}]"}', '"}]}'), '\\', ''), '}]",', '}],'), '"{"', '{"'), '"}"', '"}'), 'ntttttt', ''), ']"}]', ']}]'), '}]"}', '}]}')  , '"[]"', '[]')
	   AS product_variants,
	   NULL AS productId

FROM 
         productList p
         JOIN grouped_products pge 
			ON pge.productStandardGift = p.Id
         JOIN productgroup ppg 
			ON pge.productGroupId = ppg.id
		 JOIN grouped_product_types pt 
			ON pt.productGroupId = pge.productGroupId 
         LEFT JOIN vat v 
			ON p.vatid = v.id 
				AND v.countrycode = 'NL'
	     LEFT JOIN MasterVariant_productStandardGift mv 
			ON pge.productGroupId = mv.productGroupId 
			   AND pge.productStandardGift = mv.productStandardGift
		 LEFT JOIN productList_withAttributes atr 
			ON p.ID = atr.ID
         LEFT JOIN contentinformationfield cif_nl_descr
			ON cif_nl_descr.contentinformationid = p.contentinformationid
				 AND cif_nl_descr.type = 'DESCRIPTION' 
				 AND cif_nl_descr.locale = 'nl_NL'
         LEFT JOIN contentinformationfield cif_en_descr
			ON cif_en_descr.contentinformationid = p.contentinformationid
				 AND cif_en_descr.type = 'DESCRIPTION' 
				 AND cif_en_descr.locale = 'en_EN'	
				 
GROUP BY pge.entityProduct_key
ORDER BY entity_key
LIMIT :limit
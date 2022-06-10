WITH productList AS
(
SELECT p.ID, pt.entity_key, pt.AttributesTemplate, pt.MPTypeCode, p.contentinformationid, pt.DefaultCategoryKey, 
		pgp.vatid, p.channelid, p.PRODUCTCODE, p.INTERNALNAME, pg.showonstore
FROM productgift pg 
	JOIN product p ON pg.productid = p.id
	JOIN productgiftprice pgp ON pgp.productgiftid = p.id
	LEFT JOIN contentinformationfield cif_en_title
	  ON cif_en_title.contentinformationid = p.contentinformationid
		 AND cif_en_title.type = 'TITLE' AND cif_en_title.locale = 'en_EN'
	LEFT JOIN contentinformationfield cif_nl_title
	  ON cif_nl_title.contentinformationid = p.contentinformationid
		 AND cif_nl_title.type = 'TITLE' AND cif_nl_title.locale = 'nl_NL'
	JOIN greetz_to_mnpg_product_types_view pt
	  ON pt.GreetzTypeID = case when pg.productgiftcategoryid is not null then pg.productgiftcategoryid
					  when cif_nl_title.contentinformationid is not null or cif_en_title.contentinformationid is not null then pg.productgifttypeid
				 end
	LEFT JOIN productavailability pa 
		ON pa.productid = p.ID
	LEFT JOIN productavailabilityrange r 
	  	ON pa.id = r.productavailabilityid AND r.removed IS NULL AND r.shippableto <= CURRENT_DATE()
WHERE  p.id IN (:productId)
	  /*p.channelid = '2'
	   AND p.removed IS NULL
	   AND p.endoflife != 'Y'
	   AND pgp.AVAILABLETILL > '2022-04-15'
	   AND r.productavailabilityid IS NULL*/
	 --  AND pt.entity_key IN ('flower', 'alcohol', 'home-gift', 'chocolate', 'cake')
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
grouped_products AS
( 
	SELECT  IFNULL(pge_s.productStandardGift, ppd.PRODUCT) AS productStandardGift, 
			pge_s.productGroupId,
			pge_s.showonstore,
			ppd.giftdefinition as designId,
			l.contentinformationid,
			ppd.contentinformationid_design,
			NULL AS nl_product_name, NULL AS en_product_name, NULL AS product_nl_description, NULL AS product_en_description  			
	FROM productgroupentry AS pge_s
		LEFT JOIN 
			(
				SELECT ppd_s.*, cd.contentinformationid AS contentinformationid_design
				FROM productpersonalizedgiftdesign AS ppd_s						
					 JOIN carddefinition AS cd		
						ON ppd_s.giftdefinition = cd.ID
				WHERE cd.ENABLED = 'Y'
			 ) AS ppd
			 ON pge_s.personalizedgiftdesign = ppd.ID	
	 	JOIN productList l ON l.ID = IFNULL(pge_s.productStandardGift, ppd.PRODUCT)
	UNION ALL
	SELECT DISTINCT productStandardGift, productGroupId, showonstore, designId,	z2.contentinformationid, contentinformationid_design,
		   cif_nl_title.text AS nl_product_name, 
		   cif_en_title.text AS en_product_name, 

		   case 
				when z2.MPTypeCode in ('alcohol','biscuit','cake','chocolate','personalised-alcohol','sweet') 
					 AND (cif_nl_descr.text IS NOT NULL  OR  cif_nl_descr_2.text IS NOT NULL)
				then concat(IFNULL(concat(cif_nl_descr.text, '\n\n'), ''), IFNULL(cif_nl_descr_2.text, '')) 
				else cif_nl_descr.text												           
		   end								AS product_nl_description,
		   
		   case 
				when z2.MPTypeCode in ('alcohol','biscuit','cake','chocolate','personalised-alcohol','sweet') 
					  AND (cif_en_descr.text IS NOT NULL  OR  cif_en_descr_2.text IS NOT NULL)
				then concat(IFNULL(concat(cif_en_descr.text, '\n\n'), ''), IFNULL(cif_en_descr_2.text, '')) 
				else cif_en_descr.text												           
		   end								AS product_en_description
		   
	FROM
		(
			SELECT  productStandardGift, productGroupId, showonstore, designId, z.contentinformationid, contentinformationid_design, MPTypeCode
			FROM
			(
			SELECT ppd_s.PRODUCT AS productStandardGift, 
				   ppd_s.PRODUCT AS productGroupId,
				   cd.showonstore,
				   ppd_s.GIFTDEFINITION AS designId,
				   l.contentinformationid,
				   cd.contentinformationid AS contentinformationid_design,
				   l.MPTypeCode,
				   COUNT(*) OVER(PARTITION BY ppd_s.PRODUCT) AS cnt
			FROM productpersonalizedgiftdesign ppd_s 
				JOIN productList l ON l.ID = ppd_s.PRODUCT
				JOIN carddefinition cd ON cd.ID = ppd_s.GIFTDEFINITION

			WHERE ppd_s.ID NOT IN (SELECT personalizedgiftdesign FROM productgroupentry WHERE personalizedgiftdesign IS NOT NULL)
				  AND cd.ENABLED = 'Y'
				  AND cd.APPROVALSTATUS = 'APPROVED'
				  AND cd.CONTENTTYPE = 'STOCK'
			) z
			WHERE cnt < 35
		) z2
		LEFT JOIN contentinformationfield cif_nl_title
			  ON cif_nl_title.contentinformationid = z2.contentinformationid
				 AND cif_nl_title.type = 'TITLE' AND cif_nl_title.locale = 'nl_NL'
		LEFT JOIN contentinformationfield cif_nl_descr
			  ON cif_nl_descr.contentinformationid = z2.contentinformationid
				 AND cif_nl_descr.type = 'DESCRIPTION' AND cif_nl_descr.locale = 'nl_NL'
		LEFT JOIN contentinformationfield cif_nl_descr_2
			  ON cif_nl_descr_2.contentinformationid = z2.contentinformationid
				 AND cif_nl_descr_2.type = 'PRODUCT_DESCRIPTION' AND cif_nl_descr_2.locale = 'nl_NL'
		LEFT JOIN contentinformationfield cif_en_title
			  ON cif_en_title.contentinformationid = z2.contentinformationid
				 AND cif_en_title.type = 'TITLE' AND cif_en_title.locale = 'en_EN'
		LEFT JOIN contentinformationfield cif_en_descr
			  ON cif_en_descr.contentinformationid = z2.contentinformationid
				 AND cif_en_descr.type = 'DESCRIPTION' AND cif_en_descr.locale = 'en_EN'
        LEFT JOIN contentinformationfield cif_en_descr_2
			  ON cif_en_descr_2.contentinformationid = z2.contentinformationid
				 AND cif_en_descr_2.type = 'PRODUCT_DESCRIPTION' AND cif_en_descr_2.locale = 'en_EN'	
			
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
	SELECT pge.productGroupId, pge.productStandardGift, designId,
			 ROW_NUMBER() OVER(PARTITION BY pge.productGroupId ORDER BY pge.showonstore DESC, pge.productStandardGift ASC, designId ASC) AS RN
	FROM grouped_products pge
		 JOIN productList pl ON pl.ID = pge.productStandardGift
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
)
SELECT lower(replace(replace(replace(replace(replace(replace(replace(replace(replace(case p.channelid when 2 then p.PRODUCTCODE else 
			concat(p.PRODUCTCODE, '_', CAST(p.channelid AS VARCHAR(10))) end, ' - ' , '_'), ' ' , '_'), '&' , 'and'), '+' , 'plus'), '?' , ''), '''' , ''), '(' , ''), ')' , ''), '%', '')) AS entity_key,
       IFNULL(cif_nl_title.text, replace(p.INTERNALNAME, '_', ' '))                        AS nl_product_name,
       cif_en_title.text                                                                   AS en_product_name,
       p.MPTypeCode                                                                       AS product_type_key,
       concat(SUBSTRING_INDEX(p.entity_key, '-', 1), '_', p.id)                           AS slug,
       
	   case 
			when p.MPTypeCode in ('alcohol','biscuit','cake','chocolate','personalised-alcohol','sweet')  
				 AND (cif_nl_descr.text IS NOT NULL  OR  cif_nl_descr_2.text IS NOT NULL)
			then concat(IFNULL(concat(cif_nl_descr.text, '\n\n'), ''), IFNULL(cif_nl_descr_2.text, '')) 
			else cif_nl_descr.text												           
	   end																				   AS product_nl_description,
	   
	   case 
			when p.MPTypeCode in ('alcohol','biscuit','cake','chocolate','personalised-alcohol','sweet') 
				 AND (cif_en_descr.text IS NOT NULL  OR  cif_en_descr_2.text IS NOT NULL)
			then concat(IFNULL(concat(cif_en_descr.text, '\n\n'), ''), IFNULL(cif_en_descr_2.text, '')) 
			else cif_en_descr.text												           
	   end																				   AS product_en_description,
	   
       concat('vat', v.vatcode)                                                            AS tax_category_key, -- todo: can we re-use Moonpiq tax categories?
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


	   replace(replace(replace(replace(replace(replace(replace(replace(concat('[', JSON_OBJECT('variantKey', Concat(p.id, '-', 'STANDARD'),
		   'skuId', Concat(p.id, '-', 'STANDARD'),
		   'masterVariant', true,
           'productCode', p.PRODUCTCODE,
		   'images',   (SELECT concat('[', group_concat(
							JSON_OBJECT(
									'imageCode', pim.CODE,
								--	'designId', pim.designId,
									'designId', null,
									'width', pim.WIDTH,
									'height', pim.HEIGHT)
						), ']')
						FROM cte_productimage pim
						WHERE pim.PRODUCTID = p.ID
						ORDER BY pim.CODE),
		   'productPrices', (SELECT concat('[', group_concat(JSON_OBJECT('priceKey', pgp2.id, 'currency', pgp2.currency,
									'priceWithVat', pgp2.pricewithvat, 'validFrom', pgp2.availablefrom, 'validTo', pgp2.availabletill)
									 separator ','), ']')
							 FROM productgiftprice pgp2
							 WHERE pgp2.productgiftid = p.id),
			'attributes', case 
							when p.MPTypeCode = 'flower' AND atr.LargeAtr > 0 then replace(p.AttributesTemplate, '"attributeValue": "standard"', '"attributeValue": "large"')
							when p.MPTypeCode = 'flower' AND  atr.LetterboxAtr > 0 then replace(p.AttributesTemplate, '"attributeValue": "standard"', '"attributeValue": "letterbox"')	
							when atr.LetterboxAtr > 0 AND p.MPTypeCode IN ('chocolate', 'alcohol', 'beauty', 'biscuit', 'gadget-novelty', 'sweet', 'toy-game') 
								then replace(p.AttributesTemplate, '"letterbox-friendly", "attributeValue": "false"',   '"letterbox-friendly", "attributeValue": "true"')
							when p.MPTypeCode = 'gift-card' then replace(
																	replace(p.AttributesTemplate, 'SKUNumber', Concat(p.id, '-', 'STANDARD')),
																	'unspecified',
																	IFNULL((SELECT replace(replace(lower(BrandAttr), ' ', '_'), '.', '_') FROM productList_withAttributes_2 WHERE ID = p.ID LIMIT 1), 'unspecified')
																	)
						    else  p.AttributesTemplate
						  end
						  )
		   , ']'), '"[{\\"', '[{"'), '\"}]"}', '"}]}'), '\\', ''), '}]",', '}],'), '"{"', '{"'), '"}"', '"}'), 'ntttttt', ''), ']"}]', ']}]') 
		AS product_variants
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
         LEFT JOIN contentinformation_category ci
              ON p.contentinformationid = ci.contentinformationid
         LEFT JOIN contentcategory cc
              ON cc.id = ci.contentcategoryid
         LEFT JOIN contentcategorytranslation ct
              ON ct.contentcategoryid = cc.id AND ct.locale = 'nl_NL'
		 LEFT JOIN contentcategorytranslation ct2
              ON ct2.contentcategoryid = cc.id AND ct2.locale = 'en_EN'
         LEFT JOIN contentinformationfield cif_en_title
			  ON cif_en_title.contentinformationid = p.contentinformationid
				 AND cif_en_title.type = 'TITLE' AND cif_en_title.locale = 'en_EN'
         LEFT JOIN contentinformationfield cif_en_descr
			  ON cif_en_descr.contentinformationid = p.contentinformationid
				 AND cif_en_descr.type = 'DESCRIPTION' AND cif_en_descr.locale = 'en_EN'	
         LEFT JOIN contentinformationfield cif_en_descr_2
			  ON cif_en_descr_2.contentinformationid = p.contentinformationid
				 AND cif_en_descr_2.type = 'PRODUCT_DESCRIPTION' AND cif_en_descr_2.locale = 'en_EN'	
         LEFT JOIN greetz_to_mnpq_categories_view mc 
			  ON mc.GreetzCategoryID = cc.id
				 AND mc.MPTypeCode = p.MPTypeCode
		 LEFT JOIN productList_withAttributes atr
			ON p.ID = atr.ID
			
WHERE (p.id NOT IN 	(SELECT productstandardgift
					 FROM productgroupentry
					 WHERE productstandardgift IS NOT NULL -- Only products that do not belong to grouped sku (logic for grouped sku's in second select)
					 UNION
					 SELECT PRODUCT
					 FROM productpersonalizedgiftdesign
					 )   
--	AND pt.entity_key IN ('flower', 'alcohol', 'home-gift', 'chocolate', 'cake')
	AND 
		(lower(replace(replace(replace(replace(replace(replace(replace(replace(replace(case p.channelid when 2 then p.PRODUCTCODE else 
				concat(p.PRODUCTCODE, '_', CAST(p.channelid AS VARCHAR(10))) end, ' - ' , '_'), ' ' , '_'), '&' , 'and'), '+' , 'plus'), '?' , ''), '''' , ''), '(' , ''), ')' , ''), '%', ''))
		 > :migrateFromId OR :migrateFromId IS NULL) 
	 AND 
		 (lower(replace(replace(replace(replace(replace(replace(replace(replace(replace(case p.channelid when 2 then p.PRODUCTCODE else 
				concat(p.PRODUCTCODE, '_', CAST(p.channelid AS VARCHAR(10))) end, ' - ' , '_'), ' ' , '_'), '&' , 'and'), '+' , 'plus'), '?' , ''), '''' , ''), '(' , ''), ')' , ''), '%', ''))
		 <= :migrateToId OR :migrateToId IS NULL)
        
    AND concat(:keys) IS NULL)
	
    OR lower(replace(replace(replace(replace(replace(replace(replace(replace(replace(case p.channelid when 2 then p.PRODUCTCODE else 
			concat(p.PRODUCTCODE, '_', CAST(p.channelid AS VARCHAR(10))) end, ' - ' , '_'), ' ' , '_'), '&' , 'and'), '+' , 'plus'), '?' , ''), '''' , ''), '(' , ''), ')' , ''), '%', '')) 
	   in (:keys)
GROUP BY lower(replace(replace(replace(replace(replace(replace(replace(replace(replace(case p.channelid when 2 then p.PRODUCTCODE else 
			concat(p.PRODUCTCODE, '_', CAST(p.channelid AS VARCHAR(10))) end, ' - ' , '_'), ' ' , '_'), '&' , 'and'), '+' , 'plus'), '?' , ''), '''' , ''), '(' , ''), ')' , ''), '%', ''))

UNION ALL

SELECT lower(replace(replace(replace(replace(replace(replace(replace(replace(replace(case p.channelid when 2 then IFNULL(ppg.productGroupCode, p.PRODUCTCODE) else 
								concat(IFNULL(ppg.productGroupCode, p.PRODUCTCODE), '_', CAST(p.channelid AS VARCHAR(10))) end, ' - ' , '_'), ' ' , '_'), '&' , 'and'), '+' , 'plus'), '?' , ''), '''' , ''), '(' , ''), ')' , ''), '%', '')) AS entity_key,
       COALESCE(ppg.title, pge.nl_product_name, replace(ppg.productGroupCode, '_', ' '))            AS nl_product_name,
       pge.en_product_name                                                     AS en_product_name,
       pt.MPTypeCode                                                           AS product_type_key,
       concat(SUBSTRING_INDEX(pt.entity_key, '-', 1), '_', pge.productGroupId) AS slug,
       product_nl_description                                                  AS product_nl_description,
       product_en_description                                                  AS product_en_description,
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
			   OR ci.contentinformationid = pge.contentinformationid_design
				-- AND (c.internalname = 'Keywords' OR lower(mc.MPParentName) = 'newia' OR mc.MPParentName IS NULL)		  
	  )  AS keywords_nl,

  	  (  SELECT group_concat(ct2.text separator ', ')
	     FROM contentinformation_category ci
			 JOIN contentcategory cc
					   ON cc.id = ci.contentcategoryid
			 LEFT JOIN contentcategorytranslation ct2
					   ON ct2.contentcategoryid = cc.id AND ct2.locale = 'en_EN'
		 WHERE ci.contentinformationid = p.contentinformationid  
			   OR ci.contentinformationid = pge.contentinformationid_design
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
				   OR ci.contentinformationid = pge.contentinformationid_design
			)  
	   , pt.DefaultCategoryKey )	 AS category_keys,

	   replace(replace(replace(replace(replace(replace(replace(replace(replace(concat('[', group_concat(JSON_OBJECT('variantKey', Concat(pge.productgroupid, IFNULL(concat('_', pge.productStandardGift), ''), IFNULL(concat('_', pge.designId), '')),
		 --  'skuId', Concat(pge.productgroupid, '_', IFNULL(concat('D', pge.designId), pge.productStandardGift)),
		   'skuId', Concat(pge.productgroupid, IFNULL(concat('_', pge.productStandardGift), ''), IFNULL(concat('_', pge.designId), '')),
		   'masterVariant', CASE WHEN mv.productStandardGift IS NOT NULL THEN 1 ELSE 0 END,
           'productCode', p.PRODUCTCODE,
		   'images', (SELECT concat('[', group_concat(
						JSON_OBJECT('imageCode', pim.CODE,
									'designId', pge.designId,
									'width', pim.WIDTH,
									'height', pim.HEIGHT)
						), ']')
						FROM cte_productimage pim
						WHERE pim.PRODUCTID = p.ID and (pge.designId is null or pge.designId = pim.designId)
						ORDER BY pim.CODE),

		   'productPrices', (SELECT concat('[', group_concat(JSON_OBJECT('priceKey', pgp2.id, 'currency', pgp2.currency,
									'priceWithVat', pgp2.pricewithvat, 'validFrom', pgp2.availablefrom, 'validTo', pgp2.availabletill)
									 separator ','), ']')
							 FROM productgiftprice pgp2
							 WHERE pgp2.productgiftid = p.id),
							 
			'attributes', case 
							when pt.MPTypeCode = 'flower' AND atr.LargeAtr > 0 then replace(pt.AttributesTemplate, '"attributeValue": "standard"', '"attributeValue": "large"')
							when pt.MPTypeCode = 'flower' AND  atr.LetterboxAtr > 0 then replace(pt.AttributesTemplate, '"attributeValue": "standard"', '"attributeValue": "letterbox"')							
							when atr.LetterboxAtr > 0 AND pt.MPTypeCode IN ('chocolate', 'alcohol', 'beauty', 'biscuit', 'gadget-novelty', 'sweet', 'toy-game') 
								then replace(pt.AttributesTemplate, '"letterbox-friendly", "attributeValue": "false"',   '"letterbox-friendly", "attributeValue": "true"')
							when p.MPTypeCode = 'gift-card' then replace(
																	replace(pt.AttributesTemplate, 'SKUNumber', Concat(pge.productgroupid, IFNULL(concat('_', pge.productStandardGift), ''), IFNULL(concat('_', pge.designId), ''))),
																	'unspecified',
																	IFNULL((SELECT replace(replace(lower(BrandAttr), ' ', '_'), '.', '_') FROM productList_withAttributes_2 WHERE ID = p.ID LIMIT 1), 'unspecified')
																  )							
							else  pt.AttributesTemplate
						  end
			
		   ) SEPARATOR ','), ']'), '"[{\\"', '[{"'), '\"}]"}', '"}]}'), '\\', ''), '}]",', '}],'), '"{"', '{"'), '"}"', '"}'), 'ntttttt', ''), ']"}]', ']}]'), '}]"}', '}]}')
	   AS product_variants

FROM 
         productList p
         LEFT JOIN vat v ON p.vatid = v.id AND v.countrycode = 'NL'
         JOIN grouped_products pge ON pge.productStandardGift = p.Id
         LEFT JOIN productgroup ppg ON pge.productGroupId = ppg.id
		 JOIN grouped_product_types pt ON pt.productGroupId = pge.productGroupId   -- todo: what with these with no category assigned?
	     LEFT JOIN MasterVariant_productStandardGift mv 
			ON pge.productGroupId = mv.productGroupId 
			   AND pge.productStandardGift = mv.productStandardGift
			   AND IFNULL(pge.designId, 0) = IFNULL(mv.designId, 0)	   
		 LEFT JOIN productList_withAttributes atr ON p.ID = atr.ID
WHERE              
	(lower(replace(replace(replace(replace(replace(replace(replace(replace(replace(case p.channelid when 2 then IFNULL(ppg.productGroupCode, p.PRODUCTCODE) else 
			concat(IFNULL(ppg.productGroupCode, p.PRODUCTCODE), '_', CAST(p.channelid AS VARCHAR(10))) end, ' - ' , '_'), ' ' , '_'), '&' , 'and'), '+' , 'plus'), '?' , ''), '''' , ''), '(' , ''), ')' , ''), '%', ''))
	 > :migrateFromId OR :migrateFromId IS NULL) 
	 AND 
	 (lower(replace(replace(replace(replace(replace(replace(replace(replace(replace(case p.channelid when 2 then IFNULL(ppg.productGroupCode, p.PRODUCTCODE) else 
			concat(IFNULL(ppg.productGroupCode, p.PRODUCTCODE), '_', CAST(p.channelid AS VARCHAR(10))) end, ' - ' , '_'), ' ' , '_'), '&' , 'and'), '+' , 'plus'), '?' , ''), '''' , ''), '(' , ''), ')' , ''), '%', ''))
	 <= :migrateToId OR :migrateToId IS NULL)
        
    AND concat(:keys) IS NULL
    OR lower(replace(replace(replace(replace(replace(replace(replace(replace(replace(case p.channelid when 2 then IFNULL(ppg.productGroupCode, p.PRODUCTCODE) else 
								concat(IFNULL(ppg.productGroupCode, p.PRODUCTCODE), '_', CAST(p.channelid AS VARCHAR(10))) end, ' - ' , '_'), ' ' , '_'), '&' , 'and'), '+' , 'plus'), '?' , ''), '''' , ''), '(' , ''), ')' , ''), '%', ''))
		in (:keys)
GROUP BY lower(replace(replace(replace(replace(replace(replace(replace(replace(replace(case p.channelid when 2 then IFNULL(ppg.productGroupCode, p.PRODUCTCODE) else 
								concat(IFNULL(ppg.productGroupCode, p.PRODUCTCODE), '_', CAST(p.channelid AS VARCHAR(10))) end, ' - ' , '_'), ' ' , '_'), '&' , 'and'), '+' , 'plus'), '?' , ''), '''' , ''), '(' , ''), ')' , ''), '%', ''))
ORDER BY entity_key
LIMIT :limit
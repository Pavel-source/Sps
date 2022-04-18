WITH productList AS
(
SELECT p.ID, pt.entity_key, pt.Attributes, pt.MPTypeCode, p.contentinformationid
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
WHERE  p.channelid = '2'
	   AND p.removed IS NULL
	   AND p.endoflife != 'Y'
	   AND pgp.AVAILABLETILL > '2022-04-15'
	   AND pt.entity_key = 'flower'
),
productList_withAttributes AS
(
SELECT  pl.ID, 
		SUM(case when c.INTERNALNAME = 'Size' AND lower(ct.text) = 'large' then 1 else 0 end) as LargeAtr,
		SUM(case when lower(ct.text) IN ('letterbox gifts', 'bloompost', 'brievenbuscadeau') then 1 else 0 end) as LetterboxAtr
FROM productList pl
	 JOIN contentinformation_category ci
		  ON pl.contentinformationid = ci.contentinformationid
	 JOIN contentcategory cc
		  ON cc.id = ci.contentcategoryid
	 JOIN contentcategorytranslation ct
		  ON ct.contentcategoryid = cc.id
	 JOIN contentcategorytype c
	      ON cc.categorytypeid = c.id
WHERE c.INTERNALNAME != 'Keywords'   		  
GROUP BY pl.ID		  
),
grouped_products AS
( 
	SELECT  IFNULL(pge_s.productStandardGift, ppd.PRODUCT) AS productStandardGift, 
			pge_s.productGroupId,
			pge_s.showonstore,
			ppd.giftdefinition as designId					
	FROM productgroupentry AS pge_s
		LEFT JOIN 
			(
				SELECT ppd_s.*
				FROM productpersonalizedgiftdesign AS ppd_s						
					 JOIN carddefinition AS cd		
						ON ppd_s.giftdefinition = cd.ID
				WHERE cd.ENABLED = 'Y'
			 ) AS ppd
			 ON pge_s.personalizedgiftdesign = ppd.ID	
	 	JOIN productList l ON l.ID = IFNULL(pge_s.productStandardGift, ppd.PRODUCT)
	UNION ALL
	SELECT productStandardGift, productGroupId, showonstore, designId
	FROM
	(
	SELECT ppd_s.PRODUCT AS productStandardGift, 
		   ppd_s.PRODUCT AS productGroupId,
		   1 AS showonstore,
		   ppd_s.GIFTDEFINITION as designId,
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
),
grouped_product_types_0 AS
(
	SELECT pge.productGroupId, pl.entity_key, pl.Attributes, pl.MPTypeCode, ROW_NUMBER() OVER(PARTITION BY pge.productGroupId ORDER BY pge.productStandardGift) AS RN
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
			 ROW_NUMBER() OVER(PARTITION BY pge.productGroupId ORDER BY pge.showonstore DESC, pge.productStandardGift ASC) AS RN
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
	   ROW_NUMBER() OVER(PARTITION BY pi.PRODUCTID, pi.CODE ORDER BY pi.WIDTH DESC) AS RN
FROM productimage pi
	 JOIN productList pl ON pi.productid = pl.ID
WHERE pi.WIDTH <= 2000 AND pi.HEIGHT <= 2000	 
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
       pt.MPTypeCode                                                                       AS product_type_key,
       -- pt.attribute_key																	   AS product_type_attribute_key,
       concat(SUBSTRING_INDEX(pt.entity_key, '-', 1), '_', p.id)                           AS slug,
       cif_nl_descr.text                                                                   AS product_nl_description,
       cif_en_descr.text                                                                   AS product_en_description,
       concat('vat', v.vatcode)                                                            AS tax_category_key, -- todo: can we re-use Moonpiq tax categories?
       pg.showonstore																	   AS show_on_store,
	   
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
	   
	   group_concat(case when c.internalname = 'Keywords' OR lower(mc.MPParentName) = 'newia' OR mc.MPParentName IS NULL then ct.text end separator ', ') AS keywords,
       group_concat(DISTINCT(IFNULL(mc.MPCategoryKey, concat('unspecified for contentcategory.id = ', cc.id) )) separator ', ')                                AS category_keys,

	   replace(replace(replace(replace(replace(replace(concat('[', JSON_OBJECT('variantKey', Concat(p.id, '-', 'STANDARD'),
		   'skuId', Concat(p.id, '-', 'STANDARD'),
		   'masterVariant', true,
           'productCode', p.PRODUCTCODE,
		   'images',   (SELECT concat('[', group_concat(
							JSON_OBJECT(
									'imageCode', pim.CODE,
									'extension', LOWER(REPLACE(pim.EXTENSION,'.', '')),
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
							when atr.LargeAtr > 0 then replace(pt.Attributes, '"attributeValue": "standard"', '"attributeValue": "large"')
							when atr.LetterboxAtr > 0 then replace(pt.Attributes, '"attributeValue": "standard"', '"attributeValue": "letterbox"')							
						    else pt.Attributes
						  end
						  )
							 
		   , ']'), '"[{\\"', '[{"'), '\"}]"}', '"}]}'), '\\', ''), '}]",', '}],'), '"{"', '{"'), '"}"', '"}') AS product_variants
FROM product p
         JOIN productgift pg
              ON pg.productid = p.id
         JOIN productgiftprice pgp
              ON pgp.productgiftid = p.id
         LEFT JOIN vat v
              ON pgp.vatid = v.id AND v.countrycode = 'NL'
         LEFT JOIN contentinformationfield cif_nl_title
			  ON cif_nl_title.contentinformationid = p.contentinformationid
				 AND cif_nl_title.type = 'TITLE' AND cif_nl_title.locale = 'nl_NL'
         LEFT JOIN contentinformationfield cif_nl_descr
			  ON cif_nl_descr.contentinformationid = p.contentinformationid
				 AND cif_nl_descr.type = 'DESCRIPTION' AND cif_nl_descr.locale = 'nl_NL'
         LEFT JOIN contentinformation_category ci
              ON p.contentinformationid = ci.contentinformationid
         LEFT JOIN contentcategory cc
              ON cc.id = ci.contentcategoryid
         LEFT JOIN contentcategorytranslation ct
              ON ct.contentcategoryid = cc.id AND ct.locale = 'en_EN'
         LEFT JOIN contentcategorytype c
              ON cc.categorytypeid = c.id
         LEFT JOIN contentinformationfield cif_en_title
			  ON cif_en_title.contentinformationid = p.contentinformationid
				 AND cif_en_title.type = 'TITLE' AND cif_en_title.locale = 'en_EN'
         LEFT JOIN contentinformationfield cif_en_descr
			  ON cif_en_descr.contentinformationid = p.contentinformationid
				 AND cif_en_descr.type = 'DESCRIPTION' AND cif_en_descr.locale = 'en_EN'			
         LEFT JOIN greetz_to_mnpq_categories_view mc ON mc.GreetzCategoryID = cc.id
         JOIN greetz_to_mnpg_product_types_view pt
              ON pt.GreetzTypeID = case when pg.productgiftcategoryid is not null then pg.productgiftcategoryid
							  when cif_nl_title.contentinformationid is not null or cif_en_title.contentinformationid is not null then pg.productgifttypeid
						 end
		 LEFT JOIN productList_withAttributes atr
			ON p.ID = atr.ID
WHERE (p.channelid = '2'
    AND p.removed IS NULL
    AND p.endoflife != 'Y'
    AND pg.productid NOT IN (SELECT productstandardgift
                             FROM productgroupentry
                             WHERE productstandardgift IS NOT NULL -- Only products that do not belong to grouped sku (logic for grouped sku's in second select)
							 UNION
							 SELECT PRODUCT
							 FROM productpersonalizedgiftdesign
							 )
    AND pgp.AVAILABLETILL > '2022-04-15'
	AND pt.entity_key = 'flower'
	AND (
               (
                   :synchronization = FALSE
				   AND ((lower(replace(replace(replace(replace(replace(replace(replace(replace(replace(case p.channelid when 2 then p.PRODUCTCODE else 
								concat(p.PRODUCTCODE, '_', CAST(p.channelid AS VARCHAR(10))) end, ' - ' , '_'), ' ' , '_'), '&' , 'and'), '+' , 'plus'), '?' , ''), '''' , ''), '(' , ''), ')' , ''), '%', ''))
						 > :migrateFromId OR :migrateFromId IS NULL) 
						 AND 
						 (lower(replace(replace(replace(replace(replace(replace(replace(replace(replace(case p.channelid when 2 then p.PRODUCTCODE else 
								concat(p.PRODUCTCODE, '_', CAST(p.channelid AS VARCHAR(10))) end, ' - ' , '_'), ' ' , '_'), '&' , 'and'), '+' , 'plus'), '?' , ''), '''' , ''), '(' , ''), ')' , ''), '%', ''))
						 <= :migrateToId OR :migrateToId IS NULL))
                )
               OR
               (
                           :synchronization = TRUE
                       AND
                           (
                                   (p.db_updated > :syncFrom AND p.db_updated <= :syncTo)
                                   OR (pg.db_updated > :syncFrom AND pg.db_updated <= :syncTo)
                                   OR (cif_nl_title.db_updated > :syncFrom AND cif_nl_title.db_updated <= :syncTo)
                                   OR (cif_nl_descr.db_updated > :syncFrom AND cif_nl_descr.db_updated <= :syncTo)
                                   OR (cif_en_title.db_updated > :syncFrom AND cif_en_title.db_updated <= :syncTo)
                                   OR (cif_en_descr.db_updated > :syncFrom AND cif_en_descr.db_updated <= :syncTo)
                                   OR (ci.db_updated > :syncFrom AND ci.db_updated <= :syncTo)
                                   OR (cc.db_updated > :syncFrom AND cc.db_updated <= :syncTo)
                                   OR (ct.db_updated > :syncFrom AND ct.db_updated <= :syncTo)
                                   OR (c.db_updated > :syncFrom AND c.db_updated <= :syncTo)
                                   OR (pgp.db_updated > :syncFrom AND pgp.db_updated <= :syncTo)
                                   OR (v.db_updated > :syncFrom AND v.db_updated <= :syncTo)
								   OR EXISTS (SELECT 1 FROM productimage pim2 WHERE pim2.productID = p.ID AND pim2.db_updated > :syncFrom AND pim2.db_updated <= :syncTo)
                            )
                )
        )
    AND concat(:keys) IS NULL)
	
    OR lower(replace(replace(replace(replace(replace(replace(replace(replace(replace(case p.channelid when 2 then p.PRODUCTCODE else 
			concat(p.PRODUCTCODE, '_', CAST(p.channelid AS VARCHAR(10))) end, ' - ' , '_'), ' ' , '_'), '&' , 'and'), '+' , 'plus'), '?' , ''), '''' , ''), '(' , ''), ')' , ''), '%', '')) 
	   in (:keys)
GROUP BY lower(replace(replace(replace(replace(replace(replace(replace(replace(replace(case p.channelid when 2 then p.PRODUCTCODE else 
			concat(p.PRODUCTCODE, '_', CAST(p.channelid AS VARCHAR(10))) end, ' - ' , '_'), ' ' , '_'), '&' , 'and'), '+' , 'plus'), '?' , ''), '''' , ''), '(' , ''), ')' , ''), '%', ''))

UNION ALL

SELECT lower(replace(replace(replace(replace(replace(replace(replace(replace(replace(case p.channelid when 2 then IFNULL(ppg.productGroupCode, p.PRODUCTCODE) else 
								concat(IFNULL(ppg.productGroupCode, p.PRODUCTCODE), '_', CAST(p.channelid AS VARCHAR(10))) end, ' - ' , '_'), ' ' , '_'), '&' , 'and'), '+' , 'plus'), '?' , ''), '''' , ''), '(' , ''), ')' , ''), '%', '')) AS entity_key,
       ppg.title                                                               AS nl_product_name,
       null                                                                    AS en_product_name,
       pt.MPTypeCode                                                           AS product_type_key,
    --   pt.attribute_key														   AS product_type_attribute_key,
       concat(SUBSTRING_INDEX(pt.entity_key, '-', 1), '_', pge.productGroupId) AS slug,
       null                                                                    AS product_nl_description,
       null                                                                    AS product_en_description,
       concat('vat', v.vatcode)                                                AS tax_category_key,
	   pge.showOnStore														   AS show_on_store,
       null                                                                    AS meta_title,
       null                                                                    AS meta_description,

	 --  group_concat(case when c.internalname = 'Keywords' then ct.text end separator ', ') AS keywords, -- !!! note, there are duplication. (intentional). To be removed before uploaded to commercetools. 

  	  (  SELECT group_concat(ct.text separator ', ')
	     FROM contentinformation_category ci
			 JOIN contentcategory cc
					   ON cc.id = ci.contentcategoryid
			 JOIN contentcategorytranslation ct
					   ON ct.contentcategoryid = cc.id AND ct.locale = 'en_EN'
			 JOIN contentcategorytype c
					   ON cc.categorytypeid = c.id
			 LEFT JOIN greetz_to_mnpq_categories_view mc 
						ON mc.GreetzCategoryID = cc.id
		 WHERE p.contentinformationid = ci.contentinformationid
				 AND (c.internalname = 'Keywords' OR lower(mc.MPParentName) = 'newia' OR mc.MPParentName IS NULL)		  
	  )  AS keywords,

     --  group_concat(mc.entity_key separator ', ')                              AS category_keys, -- !!! note, there are duplication. (intentional). To be removed before uploaded to commercetools.
	  (  SELECT group_concat(DISTINCT(IFNULL(mc.MPCategoryKey, concat('unspecified for contentcategory.id = ', cc.id) )) separator ', ')
	     FROM contentinformation_category ci
			 JOIN contentcategory cc
					   ON cc.id = ci.contentcategoryid
			 JOIN contentcategorytranslation ct
					   ON ct.contentcategoryid = cc.id AND ct.locale = 'en_EN'
			 JOIN contentcategorytype c
					   ON cc.categorytypeid = c.id
			 JOIN greetz_to_mnpq_categories_view mc ON mc.GreetzCategoryID = cc.id
		 WHERE p.contentinformationid = ci.contentinformationid)  AS category_keys,

	   replace(replace(replace(replace(replace(replace(concat('[', group_concat(JSON_OBJECT('variantKey', Concat(pge.productgroupid, '_', IFNULL(concat('D', pge.designId), pge.productStandardGift)),
		   'skuId', Concat(pge.productgroupid, '_', IFNULL(concat('D', pge.designId), pge.productStandardGift)),
		   'masterVariant', CASE WHEN mv.productStandardGift IS NOT NULL THEN 1 ELSE 0 END,
           'productCode', p.PRODUCTCODE,
		   'images', (SELECT concat('[', group_concat(
						JSON_OBJECT('imageCode', pim.CODE,
									'extension', LOWER(REPLACE(pim.EXTENSION,'.', '')),
								--	'designId', pim.designId,
									'designId', pge.designId,
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
							 
			'attributes', 
						case 
							when atr.LargeAtr > 0 then replace(pt.Attributes, '"attributeValue": "standard"', '"attributeValue": "large"')
							when atr.LetterboxAtr > 0 then replace(pt.Attributes, '"attributeValue": "standard"', '"attributeValue": "letterbox"')							
						    else pt.Attributes
						end
			
		   ) SEPARATOR ','), ']'), '"[{\\"', '[{"'), '\"}]"}', '"}]}'), '\\', ''), '}]",', '}],'), '"{"', '{"'), '"}"', '"}') AS product_variants

FROM product p
         JOIN productgift pg ON pg.productid = p.id
         JOIN productgiftprice pgp ON pgp.productgiftid = p.id
         LEFT JOIN vat v ON pgp.vatid = v.id AND v.countrycode = 'NL'
         JOIN grouped_products pge ON pge.productStandardGift = pg.productId
         LEFT JOIN productgroup ppg ON pge.productGroupId = ppg.id
		 JOIN grouped_product_types pt ON pt.productGroupId = pge.productGroupId   -- todo: what with these with no category assigned?
	     LEFT JOIN MasterVariant_productStandardGift mv ON pge.productGroupId = mv.productGroupId AND pge.productStandardGift = mv.productStandardGift
		 LEFT JOIN productList_withAttributes atr ON p.ID = atr.ID
     -- Note - only standard gift TODO: What about personalised ones?
WHERE (p.channelid = '2'
    AND p.removed IS NULL
    AND p.endoflife != 'Y'
	AND pgp.AVAILABLETILL > '2022-04-15'
	AND (
               (
                   :synchronization = FALSE
				   AND ((lower(replace(replace(replace(replace(replace(replace(replace(replace(replace(case p.channelid when 2 then IFNULL(ppg.productGroupCode, CAST(pge.productGroupId AS VARCHAR(30))) else 
								concat(IFNULL(ppg.productGroupCode, CAST(pge.productGroupId AS VARCHAR(30))), '_', CAST(p.channelid AS VARCHAR(10))) end, ' - ' , '_'), ' ' , '_'), '&' , 'and'), '+' , 'plus'), '?' , ''), '''' , ''), '(' , ''), ')' , ''), '%', ''))
						 > :migrateFromId OR :migrateFromId IS NULL) 
						 AND 
						 (lower(replace(replace(replace(replace(replace(replace(replace(replace(replace(case p.channelid when 2 then IFNULL(ppg.productGroupCode, CAST(pge.productGroupId AS VARCHAR(30))) else 
								concat(IFNULL(ppg.productGroupCode, CAST(pge.productGroupId AS VARCHAR(30))), '_', CAST(p.channelid AS VARCHAR(10))) end, ' - ' , '_'), ' ' , '_'), '&' , 'and'), '+' , 'plus'), '?' , ''), '''' , ''), '(' , ''), ')' , ''), '%', ''))
						 <= :migrateToId OR :migrateToId IS NULL))
                )
               OR
               (
                           :synchronization = TRUE
                       AND
                           (
								   EXISTS
								     (SELECT 1
									  FROM product p2
										 JOIN productgift pg2
											  ON pg2.productid = p2.id
										 LEFT JOIN productgiftprice pgp2
												   ON pgp2.productgiftid = p2.id
										 LEFT JOIN vat v2 ON pgp2.vatid = v2.id AND v2.countrycode = 'NL'
										 JOIN productgroupentry pge2 ON pge2.productStandardGift = pg2.productId
										 JOIN productgroup ppg2 ON pge2.productGroupId = ppg2.id
										 LEFT JOIN productimage pim2 ON pim2.productID = p2.id
									  WHERE pge2.productGroupId = pge.productGroupId
									 		AND
									 		(
												  (p2.db_updated > :syncFrom AND p2.db_updated <= :syncTo)
											   OR (pg2.db_updated > :syncFrom AND pg2.db_updated <= :syncTo)
											   OR (pgp2.db_updated > :syncFrom AND pgp2.db_updated <= :syncTo)
											   OR (v2.db_updated > :syncFrom AND v2.db_updated <= :syncTo)
											   OR (pge2.db_updated > :syncFrom AND pge2.db_updated <= :syncTo)
											   OR (ppg2.db_updated > :syncFrom AND ppg2.db_updated <= :syncTo)
											   OR (pim2.db_updated > :syncFrom AND pim2.db_updated <= :syncTo)
									 		)
									 )
                            )
                )
           )
    AND concat(:keys) IS NULL)
	
    OR lower(replace(replace(replace(replace(replace(replace(replace(replace(replace(case p.channelid when 2 then IFNULL(ppg.productGroupCode, CAST(pge.productGroupId AS VARCHAR(30))) else 
								concat(IFNULL(ppg.productGroupCode, CAST(pge.productGroupId AS VARCHAR(30))), '_', CAST(p.channelid AS VARCHAR(10))) end, ' - ' , '_'), ' ' , '_'), '&' , 'and'), '+' , 'plus'), '?' , ''), '''' , ''), '(' , ''), ')' , ''), '%', ''))
		in (:keys)
GROUP BY lower(replace(replace(replace(replace(replace(replace(replace(replace(replace(case p.channelid when 2 then IFNULL(ppg.productGroupCode, CAST(pge.productGroupId AS VARCHAR(30))) else 
								concat(IFNULL(ppg.productGroupCode, CAST(pge.productGroupId AS VARCHAR(30))), '_', CAST(p.channelid AS VARCHAR(10))) end, ' - ' , '_'), ' ' , '_'), '&' , 'and'), '+' , 'plus'), '?' , ''), '''' , ''), '(' , ''), ')' , ''), '%', ''))
ORDER BY entity_key
LIMIT :limit
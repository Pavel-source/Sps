WITH ProductList_0
AS
(
SELECT DISTINCT cd.ID AS carddefinitionid, cd.contentinformationid, pc.productid, 
				p.PRODUCTCODE, cd.showonstore, pc.CARDSIZE, pcp.vatid, pc.cardratio, cd.ORIENTATION, 
				cd.CONTENTCOLLECTIONID, numberofphotos,

				case pc.cardratio
					when 'STANDARD' then 'rectangular'
					when 'SQUARE'   then 'square'
				end  									AS  Attribute_Shape,

				case pc.CARDSIZE
					when 'MEDIUM' then 1
					when 'XXL' then 2
					when 'XL' then 3
					when 'LARGE' then 4
					when 'SUPERSIZE' then 5
					when 'XS' then 6		-- not used
					when 'SMALL' then 7 	-- not used
					when 'MINI' then 8
				end  									AS  NumberForSorting,
                cd.NUMBEROFPANELS                       AS  NumberOfPanels
				
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
			AND '2022-06-04' between pcp.availableFrom AND pcp.availableTill 
			AND pcp.amountFrom = 1
     JOIN carddefinition cd 
		ON cd.CARDRATIO = pc.CARDRATIO 
			AND cd.OBLONG = pc.OBLONG 
			AND cd.NUMBEROFPANELS = pc.AMOUNTOFPANELS
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
WHERE
	  ((cd.APPROVALSTATUS = 'APPROVED' OR cd.APPROVALSTATUS IS NULL)
	  AND (cd.ENABLED = 'Y' OR cd.ENABLED IS NULL)
	  AND ((cd.EXCLUDEFROMSEARCHINDEX = 'N' AND cif_nl_title.TYPE IS NOT NULL) OR cd.EXCLUDEFROMSEARCHINDEX IS NULL)
	  AND (r.id is null OR (r.orderablefrom <= '2022-06-04' AND '2022-06-04' <= r.shippableto))	 
	  AND cdc.channelID = '2'
	  and concat(:designIds) IS NULL) OR cd.ID IN (:designIds)
),

Carddefinition_Grouped AS
(
SELECT DISTINCT carddefinitionid, contentinformationid, CONTENTCOLLECTIONID
FROM ProductList_0
),

Carddefinition_With_AttributesByContent AS
(
SELECT cd.*, av.AttrCode, av.AttrValue
FROM Carddefinition_Grouped cd
	LEFT JOIN contentcollection ccn ON ccn.ID = cd.CONTENTCOLLECTIONID 
	LEFT JOIN greetz_to_mnpq_attr_range_by_content_view av ON ccn.NAME = av.ContentValue
),

attr_range_0 AS
(
SELECT cd.carddefinitionid, 
	   av.AttributeCode,
	   av.AttributeValue,
	   ROW_NUMBER() OVER(PARTITION BY carddefinitionid ORDER BY av.Priority, av.CategoryID) AS RN_AttributeByCategory
FROM Carddefinition_With_AttributesByContent cd
	 JOIN contentinformation_category ci  ON ci.contentinformationid = cd.contentinformationid
	 JOIN contentcategory cc  ON cc.id = ci.contentcategoryid
	 JOIN contentcategorytype c  ON cc.categorytypeid = c.id
	 JOIN greetz_to_mnpq_attr_range_by_category_view av  ON av.CategoryID = ci.contentcategoryid
WHERE cd.AttrCode IS NULL
	  AND c.INTERNALNAME != 'Keywords'
GROUP BY carddefinitionid	  
),

attr_range AS
(
SELECT cd.carddefinitionid, 
	   COALESCE(cd.AttrCode, ar.AttributeCode, 'tangled')   AS AttributeCode,
	   COALESCE(cd.AttrValue, ar.AttributeValue, 'Tangled') AS AttributeValue
FROM Carddefinition_With_AttributesByContent cd
	 LEFT JOIN attr_range_0 ar 
		ON cd.carddefinitionid = ar.carddefinitionid
			AND RN_AttributeByCategory = 1	 
),

attr_range_occasion_0 AS
(
SELECT cd.carddefinitionid, 
	   av.AttributeCode,
	   av.AttributeValue,
	   ROW_NUMBER() OVER(PARTITION BY carddefinitionid ORDER BY av.Priority, av.CategoryID) AS RN_AttributeByCategory
FROM Carddefinition_Grouped cd
	 JOIN contentinformation_category ci  ON ci.contentinformationid = cd.contentinformationid
	 JOIN contentcategory cc  ON cc.id = ci.contentcategoryid
	 JOIN contentcategorytype c  ON cc.categorytypeid = c.id
	 JOIN greetz_to_mnpq_attr_occasion_view av  ON av.CategoryID = ci.contentcategoryid
WHERE c.INTERNALNAME != 'Keywords'
GROUP BY carddefinitionid
),

attr_range_occasion AS
(
SELECT * FROM attr_range_occasion_0 WHERE RN_AttributeByCategory = 1
),

attr_range_style_0 AS
(
SELECT cd.carddefinitionid, 
	   av.AttributeCode,
	   av.AttributeValue,
	   ROW_NUMBER() OVER(PARTITION BY carddefinitionid ORDER BY av.Priority, av.CategoryID) AS RN_AttributeByCategory
FROM Carddefinition_Grouped cd
	 JOIN contentinformation_category ci  ON ci.contentinformationid = cd.contentinformationid
	 JOIN contentcategory cc  ON cc.id = ci.contentcategoryid
	 JOIN contentcategorytype c  ON cc.categorytypeid = c.id
	 JOIN greetz_to_mnpq_attr_style_view av  ON av.CategoryID = ci.contentcategoryid
WHERE c.INTERNALNAME != 'Keywords'
GROUP BY carddefinitionid
),

attr_range_style AS
(
SELECT * FROM attr_range_style_0 WHERE RN_AttributeByCategory = 1
),

attr_range_relation_0 AS
(
SELECT cd.carddefinitionid, 
	   av.AttributeCode,
	   av.AttributeValue,
	   ROW_NUMBER() OVER(PARTITION BY carddefinitionid ORDER BY av.Priority, av.CategoryID) AS RN_AttributeByCategory
FROM Carddefinition_Grouped cd
	 JOIN contentinformation_category ci  ON ci.contentinformationid = cd.contentinformationid
	 JOIN contentcategory cc  ON cc.id = ci.contentcategoryid
	 JOIN contentcategorytype c  ON cc.categorytypeid = c.id
	 JOIN greetz_to_mnpq_attr_relation_view av  ON av.CategoryID = ci.contentcategoryid
WHERE c.INTERNALNAME != 'Keywords'
GROUP BY carddefinitionid
),

attr_range_relation AS
(
SELECT * FROM attr_range_relation_0 WHERE RN_AttributeByCategory = 1
),

ProductList
AS
(
SELECT *, 
		case 
			when CARDSIZE = 'MEDIUM' then 'standard'
			when CARDSIZE = 'SUPERSIZE' then 'giant'
			when CARDSIZE IN ('LARGE', 'XL', 'XXL') then 'large'
			when CARDSIZE IN ('SMALL', 'XS', 'MINI') then 'small'
		end  AS Attribute_Size,
		
		ROW_NUMBER() OVER(PARTITION BY  
							carddefinitionid, 
							case 
								when CARDSIZE = 'MEDIUM' then 'standard'
								when CARDSIZE = 'SUPERSIZE' then 'giant'
								when CARDSIZE IN ('LARGE', 'XL', 'XXL') then 'large'
								when CARDSIZE IN ('SMALL', 'XS', 'MINI') then 'small'
							end
						  ORDER BY CARDSIZE DESC)  AS RN_Attribute_Size, 

		ROW_NUMBER() OVER(PARTITION BY carddefinitionid ORDER BY NumberForSorting)  AS RN_MasterVariant
	
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
		pl.carddefinitionid  	AS entity_key,
		cif_nl_title.text  		AS nl_product_name,
		cif_en_title.text  		AS en_product_name,
		'greetingcard'	   		AS product_type_key,
		pl.carddefinitionid 	AS designId,
		pl.Attribute_Shape		AS shape,
		a_r.AttributeCode		AS 'range',
		concat(pl.PRODUCTCODE, '_', pl.carddefinitionid, '_', pl.CARDSIZE)  AS slug,

		case 
			when (cif_nl_descr.text IS NOT NULL  OR  cif_nl_descr_2.text IS NOT NULL)
			then concat(IFNULL(concat(cif_nl_descr.text, '\n\n'), ''), IFNULL(cif_nl_descr_2.text, '')) 
			else cif_nl_descr.text												           
	    end				   AS product_nl_description,
		
	    case 
			when (cif_en_descr.text IS NOT NULL  OR  cif_en_descr_2.text IS NOT NULL)
			then concat(IFNULL(concat(cif_en_descr.text, '\n\n'), ''), IFNULL(cif_en_descr_2.text, '')) 
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
		   'variantKey', concat('GRTZ', 
						   pl.carddefinitionid, 
						   case pl.Attribute_Shape when 'square' then '-SQ' else '' end, 
						   '-', 
						   upper(pl.Attribute_Size), 
						--   case pl.Attribute_Shape when 'square' then 'SQUARE' else '' end, 
						   'CARD'),
		   'skuId', concat('GRTZ', 
						   pl.carddefinitionid, 
						   case pl.Attribute_Shape when 'square' then '-SQ' else '' end, 
						   '-', 
						   upper(pl.Attribute_Size), 
						--   case pl.Attribute_Shape when 'square' then 'SQUARE' else '' end, 
						   'CARD'),
		   'masterVariant', CASE WHEN pl.RN_MasterVariant = 1 THEN 1 ELSE 0 END,
           'productCode', CAST(pl.carddefinitionid AS VARCHAR(100)),
		   'images', CASE
						WHEN pl.RN_MasterVariant = 1 THEN concat('[',
                        concat(JSON_OBJECT('cardDefinitionId', pl.carddefinitionid, 'panels', pl.NumberOfPanels, 'imageCode', 'front.jpg'), ',' ,
                                     JSON_OBJECT('cardDefinitionId', pl.carddefinitionid, 'panels', pl.NumberOfPanels, 'imageCode', 'inside_left.jpg'), ',' ,
                                     JSON_OBJECT('cardDefinitionId', pl.carddefinitionid, 'panels', pl.NumberOfPanels, 'imageCode', 'inside_right.jpg'), ',' ,
                                     JSON_OBJECT('cardDefinitionId', pl.carddefinitionid, 'panels', pl.NumberOfPanels, 'width', IFNULL(i.WIDTH, 0), 'height', IFNULL(i.HEIGHT, 0), 'imageCode', 'backside.jpg'))
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
									   AND '2022-06-04' BETWEEN pcp.availablefrom AND pcp.availabletill
									   AND pcp.cardsize = pl.cardsize
									   AND cp.currency = pcp.currency
							 WHERE cp.productcardid = pl.productid
									AND '2022-06-04' between cp.availableFrom AND cp.availableTill 
									AND cp.amountFrom = 1
							 ),
							 
			'attributes', CONCAT('[{"attributeName": "size", "attributeValue": "', pl.Attribute_Size, 
				'", "attributeType": "enum"}, {"attributeName": "shape", "attributeValue": "', pl.Attribute_Shape,
				'", "attributeType": "enum"}, {"attributeName": "range", "attributeValue": "', a_r.AttributeCode,						
				'", "attributeType": "enum"}, {"attributeName": "product-range", "attributeValue": "', pr.RangeReferenceCode, '", "attributeType": "reference"},',
				'{"attributeName": "product-range-text", "attributeValue": "', a_r.AttributeValue, '", "attributeType": "text"},',
				'{"attributeName": "photo-count", "attributeValue": "', case when pl.numberofphotos >= 0 then pl.numberofphotos else 0 end, '", "attributeType": "number"},',
				'{"attributeName": "reporting-artist", "attributeValue": "anonymous", "attributeType": "enum"},',
				'{"attributeName": "reporting-occasion", "attributeValue": "' , IFNULL(a_oc.AttributeCode, "general>general"), '", "attributeType": "enum"},',
				'{"attributeName": "reporting-relation", "attributeValue": "' , IFNULL(a_rl.AttributeCode, "nonrelations"), '", "attributeType": "enum"},',
				'{"attributeName": "reporting-style", "attributeValue": "' , IFNULL(a_s.AttributeCode, "design>general"), '", "attributeType": "enum"}]')
			
		   ) SEPARATOR ','), ']'), '"[{\\"', '[{"'), '\"}]"}', '"}]}'), '\\', ''), '}]",', '}],'), '"{"', '{"'), '"}"', '"}'), 'rntttt', ''), ']"}]', ']}]'), '}]"}', '}]}'), '"[]"', '[]')
	    AS product_variants	
	   
FROM ProductList pl	
	 LEFT JOIN vat v
		  ON pl.vatid = v.id AND v.countrycode = 'NL'
	 LEFT JOIN contentinformationfield cif_nl_title
		  ON cif_nl_title.contentinformationid = pl.contentinformationid
			 AND cif_nl_title.type = 'TITLE' AND cif_nl_title.locale = 'nl_NL'
	 LEFT JOIN contentinformationfield cif_nl_descr
		  ON cif_nl_descr.contentinformationid = pl.contentinformationid
			 AND cif_nl_descr.type = 'DESCRIPTION' AND cif_nl_descr.locale = 'nl_NL'
	 LEFT JOIN contentinformationfield cif_nl_descr_2
		  ON cif_nl_descr_2.contentinformationid = pl.contentinformationid
			 AND cif_nl_descr_2.type = 'PRODUCT_DESCRIPTION' AND cif_nl_descr_2.locale = 'nl_NL'
	 LEFT JOIN contentinformationfield cif_en_title
		  ON cif_en_title.contentinformationid = pl.contentinformationid
			 AND cif_en_title.type = 'TITLE' AND cif_en_title.locale = 'en_EN'
	 LEFT JOIN contentinformationfield cif_en_descr
		  ON cif_en_descr.contentinformationid = pl.contentinformationid
			 AND cif_en_descr.type = 'DESCRIPTION' AND cif_en_descr.locale = 'en_EN'	
	 LEFT JOIN contentinformationfield cif_en_descr_2
		  ON cif_en_descr_2.contentinformationid = pl.contentinformationid
			 AND cif_en_descr_2.type = 'PRODUCT_DESCRIPTION' AND cif_en_descr_2.locale = 'en_EN'	
	 LEFT JOIN Image_BackSize i
		  ON i.carddefinitionid = pl.carddefinitionid	
	 LEFT JOIN attr_range a_r
		  ON a_r.carddefinitionid = pl.carddefinitionid
	 LEFT JOIN greetz_to_mnpq_attr_productrange_view pr
		  ON pr.RangeCode = a_r.AttributeCode
	 LEFT JOIN attr_range_occasion a_oc
	 	  ON a_oc.carddefinitionid = pl.carddefinitionid
	 LEFT JOIN attr_range_style a_s
	 	  ON a_s.carddefinitionid = pl.carddefinitionid	  
	 LEFT JOIN attr_range_relation a_rl
	 	  ON a_rl.carddefinitionid = pl.carddefinitionid	 	  
WHERE
		pl.RN_Attribute_Size = 1
		AND (pl.carddefinitionid > :migrateFromId OR :migrateFromId IS NULL)
		AND	(pl.carddefinitionid <= :migrateToId OR :migrateToId IS NULL)
		AND (concat(:keys) IS NULL  OR  pl.carddefinitionid IN (:keys))
GROUP BY 
		pl.carddefinitionid
LIMIT :limit		


WITH ProductList_0
AS
(
SELECT DISTINCT cd.ID AS carddefinitionid, cd.contentinformationid, pc.productid, 
				p.PRODUCTCODE, cd.showonstore, pc.CARDSIZE, pcp.vatid,
				
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
				end  									AS  NumberForSorting
				
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
			AND '2022-05-21' between pcp.availableFrom AND pcp.availableTill 
			AND pcp.amountFrom = 1
     JOIN carddefinition cd 
		ON cd.CARDRATIO = pc.CARDRATIO 
			AND cd.OBLONG = pc.OBLONG 
			AND cd.NUMBEROFPANELS = pc.AMOUNTOFPANELS
     JOIN carddefinition_limitedcardsize cdl 
		ON cdl.CARDDEFINITIONID = cd.ID 
			AND pc.CARDSIZE = cdl.CARDSIZE
	 LEFT JOIN productavailability pa ON p.ID = pa.productid
     LEFT JOIN productavailabilityrange r ON pa.id = r.productavailabilityid
	 LEFT JOIN contentinformationfield cif_nl_title
		  ON cif_nl_title.contentinformationid = cd.contentinformationid
			 AND cif_nl_title.type = 'TITLE' AND cif_nl_title.locale = 'nl_NL'
WHERE
	  (cd.APPROVALSTATUS = 'APPROVED' OR cd.APPROVALSTATUS IS NULL)
	  AND (cd.ENABLED = 'Y' OR cd.ENABLED IS NULL)
	  AND ((cd.EXCLUDEFROMSEARCHINDEX = 'N' AND cif_nl_title.TYPE IS NOT NULL) OR cd.EXCLUDEFROMSEARCHINDEX IS NULL)
	  AND (r.id is null OR (r.orderablefrom <= '2022-05-21' AND '2022-05-21' < r.shippableto))	 
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
)
SELECT 
		pl.carddefinitionid  	AS entity_key,
		cif_nl_title.text  		AS nl_product_name,
		cif_en_title.text  		AS en_product_name,
		'greetingcard'	   		AS product_type_key,
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
		''  						   AS meta_title_nl,
		''  						   AS meta_description_nl,
		
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
		
		'greeting-cards' 															  AS category_keys,

		replace(replace(replace(replace(replace(replace(replace(replace(replace(concat('[', 
		group_concat(JSON_OBJECT(
			'variantKey', concat(pl.carddefinitionid, '-', upper(pl.Attribute_Size), 'CARD'),
		   'skuId', concat(pl.carddefinitionid, '-', upper(pl.Attribute_Size), 'CARD'),
		   'masterVariant', CASE WHEN pl.RN_MasterVariant = 1 THEN 1 ELSE 0 END,
           'productCode', CAST(pl.carddefinitionid AS VARCHAR(100)),
		   'images', CASE 
						WHEN pl.RN_MasterVariant = 1 THEN concat('[', 
							JSON_OBJECT('Link', CONCAT('https://greetz.nl/service/api/cards/', pl.carddefinitionid, '/2/preview/FRONT'))
							, ']')
						ELSE ''
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
									   AND '2022-05-21' BETWEEN pcp.availablefrom AND pcp.availabletill
									   AND pcp.cardsize = pl.cardsize
									   AND cp.currency = pcp.currency
							 WHERE cp.productcardid = pl.productid
									AND '2022-05-21' between cp.availableFrom AND cp.availableTill 
									AND cp.amountFrom = 1
							 ),
							 
			'attributes', CONCAT('[{"attributeName": "size", "attributeValue": "', pl.Attribute_Size, 
				'", "attributeType": "enum"}, {"attributeName": "shape", "attributeValue": "', pl.Attribute_Shape,
				'", "attributeType": "enum"}, {"attributeName": "product-range", "attributeValue": "range-17202-tangled", "attributeType": "reference"},',
				'{"attributeName": "product-range-text", "attributeValue": "Tangled", "attributeType": "text"},',
				'{"attributeName": "reporting-artist", "attributeValue": "anonymous", "attributeType": "enum"},',
				'{"attributeName": "reporting-occasion", "attributeValue": "general>general", "attributeType": "enum"},',
				'{"attributeName": "reporting-relation", "attributeValue": "nonrelations", "attributeType": "enum"},',
				'{"attributeName": "reporting-style", "attributeValue": "design>general", "attributeType": "enum"}]')
			
		   ) SEPARATOR ','), ']'), '"[{\\"', '[{"'), '\"}]"}', '"}]}'), '\\', ''), '}]",', '}],'), '"{"', '{"'), '"}"', '"}'), 'rntttt', ''), ']"}]', ']}]'), '}]"}', '}]}')
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
	/* LEFT JOIN greetz_to_mnpq_categories_view mc 
		  ON mc.GreetzCategoryID = cc.id
			 AND mc.MPTypeCode = p.MPTypeCode*/
WHERE
		pl.RN_Attribute_Size = 1
		AND (pl.carddefinitionid > :migrateFromId OR :migrateFromId IS NULL)
		AND	(pl.carddefinitionid <= :migrateToId OR :migrateToId IS NULL)
		AND (concat(:keys) IS NULL  OR  pl.carddefinitionid IN (:keys))
GROUP BY 
		pl.carddefinitionid
LIMIT :limit		


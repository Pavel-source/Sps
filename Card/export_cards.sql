WITH ProductList_0
AS
(
SELECT DISTINCT cd.ID as carddefinitionid, cd.contentinformationid, pc.productid, 
				p.PRODUCTCODE, cd.showonstore, pc.CARDSIZE, pcp.vatid, 
				
				case pc.cardratio
					when 'STANDARD' then 'rectangular'
					when 'SQUARE'   then 'square'
				end  AS Attribute_Shape,
				
				case 
					when pc.CARDSIZE = 'MEDIUM' then 'standard'
					when pc.CARDSIZE = 'SUPERSIZE' then 'giant'
					when pc.CARDSIZE IN ('LARGE', 'XL', 'XXL') then 'large'
					when pc.CARDSIZE IN ('SMALL', 'XS', 'MINI') then 'small'
					else ''
				end AS Attribute_Size,
				
				case pc.CARDSIZE 
					when 'MEDIUM' then 1
					when 'LARGE' then 2
					when 'XXL' then 3
					when 'XL' then 4
					when 'SUPERSIZE' then 5
					when 'SMALL' then 6
					when 'MINI' then 7
				end  AS NumberForSorting
FROM productcard pc
     join product p 
		on pc.PRODUCTID = p.ID 
			and TYPE = 'productCardSingle' 
			and CHANNELID = 2 
			and p.onlyAvailableForFlow is null 
			and pc.enabled = 'Y' 
			and p.removed is null
			and p.endoflife != 'Y'
     join productphysicalproperty ppp 
		on p.PRODUCTPHYSICALPROPERTIESID = ppp.ID 
			and ppp.PAPERTYPE in ('DEFAULT', 'InvercoteCreato300')
     join productcardprice pcp 
		on PRODUCTCARDID = p.ID 
			and now() between pcp.availableFrom and pcp.availableTill 
			and pcp.amountFrom = 1
     join carddefinition cd 
		on cd.CARDRATIO = pc.CARDRATIO 
			and cd.OBLONG = pc.OBLONG 
			and cd.NUMBEROFPANELS = pc.AMOUNTOFPANELS
     join carddefinition_limitedcardsize cdl 
		on cdl.CARDDEFINITIONID = cd.ID 
			and pc.CARDSIZE = cdl.CARDSIZE
	 left JOIN productavailability pa on p.ID = pa.productid
     left JOIN productavailabilityrange r on pa.id = r.productavailabilityid
	 LEFT JOIN contentinformationfield cif_nl_title
		  ON cif_nl_title.contentinformationid = cd.contentinformationid
			 AND cif_nl_title.type = 'TITLE' AND cif_nl_title.locale = 'nl_NL'
WHERE
	  (cd.APPROVALSTATUS = 'APPROVED' OR cd.APPROVALSTATUS IS NULL)
	  AND (cd.ENABLED = 'Y' OR cd.ENABLED IS NULL)
	  AND ((cd.EXCLUDEFROMSEARCHINDEX = 'N' AND cif_nl_title.TYPE IS NOT NULL) OR cd.EXCLUDEFROMSEARCHINDEX IS NULL)
	  AND (r.id is null OR (r.orderablefrom <= CURRENT_DATE() and CURRENT_DATE() < r.shippableto))	 
),
ProductList
AS
(
SELECT *, ROW_NUMBER() OVER(PARTITION BY carddefinitionid ORDER BY NumberForSorting) AS RN
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
		   'masterVariant', CASE WHEN pl.RN = 1 THEN 1 ELSE 0 END,
           'productCode', pl.carddefinitionid,
		   'images', CASE 
						WHEN pl.RN = 1 THEN concat('[', 
							JSON_OBJECT('Link', CONCAT('https://st.greetz.nl/service/api/cards/', pl.carddefinitionid, '/2/preview/FRONT'))
							, ']')
						ELSE ''
					 END,
		   'productPrices', (SELECT concat('[', group_concat(JSON_OBJECT('priceKey', pgp2.id, 'currency', pgp2.currency,
									'priceWithVat', pgp2.pricewithvatloggedin, 'validFrom', pgp2.availablefrom, 'validTo', pgp2.availabletill)
									 separator ','), ']')
							 FROM productcardprice pgp2
							 WHERE pgp2.productcardid = pl.productid),
							 
			'attributes', CONCAT('[{"attributeName": "size", "attributeValue": "', pl.Attribute_Size, 
				'", "attributeType": "enum"}, {"attributeName": "shape", "attributeValue": "', pl.Attribute_Shape,
				'"}, {"attributeName": "product-range", "attributeValue": "range-17202-tangled", "attributeType": "reference"},
				{"attributeName": "product-range-text", "attributeValue": "Tangled", "attributeType": "text"},
				{"attributeName": "reporting-artist", "attributeValue": "anonymous", "attributeType": "enum"},
				{"attributeName": "reporting-occasion", "attributeValue": "general>general", "attributeType": "enum"},
				{"attributeName": "reporting-relation", "attributeValue": "nonrelations", "attributeType": "enum"},
				{"attributeName": "reporting-style", "attributeValue": "design>general", "attributeType": "enum"}
				]')
			
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

GROUP BY 
		pl.carddefinitionid


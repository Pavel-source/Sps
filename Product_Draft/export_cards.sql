WITH 
ListWithDefaultAttributes
AS
(

SELECT	3000096701 AS ID
UNION ALL SELECT	3000096711
UNION ALL SELECT	3000096721
UNION ALL SELECT	3000096726
UNION ALL SELECT	3000096731
UNION ALL SELECT	3000096746
UNION ALL SELECT	3000096751
UNION ALL SELECT	3000096256
UNION ALL SELECT	3000096276
UNION ALL SELECT	3000096281
UNION ALL SELECT	3000096286
UNION ALL SELECT	3000096291
UNION ALL SELECT	3000096296
UNION ALL SELECT	3000096301
UNION ALL SELECT	3000096306
UNION ALL SELECT	3000096311
UNION ALL SELECT	3000096316
UNION ALL SELECT	3000096321
UNION ALL SELECT	3000096326
UNION ALL SELECT	3000096331
UNION ALL SELECT	3000096336
UNION ALL SELECT	3000096341
UNION ALL SELECT	3000096346
UNION ALL SELECT	3000096351
UNION ALL SELECT	3000096356
UNION ALL SELECT	3000096361
UNION ALL SELECT	3000096366
UNION ALL SELECT	3000096371
UNION ALL SELECT	3000096261
UNION ALL SELECT	3000096266
UNION ALL SELECT	3000096376
UNION ALL SELECT	3000096161
UNION ALL SELECT	3000096181
UNION ALL SELECT	3000096191
UNION ALL SELECT	3000096196
UNION ALL SELECT	3000096201
UNION ALL SELECT	3000096206
UNION ALL SELECT	3000096211
UNION ALL SELECT	3000096216
UNION ALL SELECT	3000096221
UNION ALL SELECT	3000096226
UNION ALL SELECT	3000096231
UNION ALL SELECT	3000096236
UNION ALL SELECT	3000096241
UNION ALL SELECT	3000096246
UNION ALL SELECT	3000096251
UNION ALL SELECT	3000096381
UNION ALL SELECT	3000096386
UNION ALL SELECT	3000095911
UNION ALL SELECT	3000095931
UNION ALL SELECT	3000095936
UNION ALL SELECT	3000095941
UNION ALL SELECT	3000095951
UNION ALL SELECT	3000095956
UNION ALL SELECT	3000095966
UNION ALL SELECT	3000095976
UNION ALL SELECT	3000095986
UNION ALL SELECT	3000095996
UNION ALL SELECT	3000096006
UNION ALL SELECT	3000096011
UNION ALL SELECT	3000096016
UNION ALL SELECT	3000096021
UNION ALL SELECT	3000096061
UNION ALL SELECT	3000096071
UNION ALL SELECT	3000095921
UNION ALL SELECT	3000096026
UNION ALL SELECT	3000096036
UNION ALL SELECT	3000096076
UNION ALL SELECT	3000096601
UNION ALL SELECT	3000096606
UNION ALL SELECT	3000096611
UNION ALL SELECT	3000096616
UNION ALL SELECT	3000096621
UNION ALL SELECT	3000096626
UNION ALL SELECT	3000096631
UNION ALL SELECT	3000096636
UNION ALL SELECT	3000096641
UNION ALL SELECT	3000096646
UNION ALL SELECT	3000096651
UNION ALL SELECT	3000096656
UNION ALL SELECT	3000096661
UNION ALL SELECT	3000095631
UNION ALL SELECT	3000095636
UNION ALL SELECT	3000095641
UNION ALL SELECT	3000095646
UNION ALL SELECT	3000095651
UNION ALL SELECT	3000095656
UNION ALL SELECT	3000095661
UNION ALL SELECT	3000095666
UNION ALL SELECT	3000095671
UNION ALL SELECT	3000095676
UNION ALL SELECT	3000095681
UNION ALL SELECT	3000095686
UNION ALL SELECT	3000095691
UNION ALL SELECT	3000095696
UNION ALL SELECT	3000095701
UNION ALL SELECT	3000095706
UNION ALL SELECT	3000095711
UNION ALL SELECT	3000095716
UNION ALL SELECT	3000095721
UNION ALL SELECT	3000095726
UNION ALL SELECT	3000095731
UNION ALL SELECT	3000095736
UNION ALL SELECT	3000095741
UNION ALL SELECT	3000095746
UNION ALL SELECT	3000095751
UNION ALL SELECT	3000095756
UNION ALL SELECT	3000095761
UNION ALL SELECT	3000095766
UNION ALL SELECT	3000095771
UNION ALL SELECT	3000096666
UNION ALL SELECT	3000096671
UNION ALL SELECT	3000096771
UNION ALL SELECT	3000096776
UNION ALL SELECT	3000096781
UNION ALL SELECT	3000096786
UNION ALL SELECT	3000096791
UNION ALL SELECT	3000096796
UNION ALL SELECT	3000096801
UNION ALL SELECT	3000096806
UNION ALL SELECT	3000096811
UNION ALL SELECT	3000096816
UNION ALL SELECT	3000096821
UNION ALL SELECT	3000096826
UNION ALL SELECT	3000096831
UNION ALL SELECT	3000096836
UNION ALL SELECT	3000096841
UNION ALL SELECT	3000096846
UNION ALL SELECT	3000096851
UNION ALL SELECT	3000096856
UNION ALL SELECT	3000096861
UNION ALL SELECT	3000096866
UNION ALL SELECT	3000096871
UNION ALL SELECT	3000096876
UNION ALL SELECT	3000096881
UNION ALL SELECT	3000096926
UNION ALL SELECT	3000096931
UNION ALL SELECT	3000096936
UNION ALL SELECT	3000096941
UNION ALL SELECT	3000096946
UNION ALL SELECT	3000096951
UNION ALL SELECT	3000096956
UNION ALL SELECT	3000096961
UNION ALL SELECT	3000096966
UNION ALL SELECT	3000096971
UNION ALL SELECT	3000096976
UNION ALL SELECT	3000096986
UNION ALL SELECT	3000096991
UNION ALL SELECT	3000096996
UNION ALL SELECT	3000097001
UNION ALL SELECT	3000097006
UNION ALL SELECT	3000097011
UNION ALL SELECT	3000097016
UNION ALL SELECT	3000095856
UNION ALL SELECT	3000095861
UNION ALL SELECT	3000095866
UNION ALL SELECT	3000095871
UNION ALL SELECT	3000095876
UNION ALL SELECT	3000095881
UNION ALL SELECT	3000095891
UNION ALL SELECT	3000095896
UNION ALL SELECT	3000097026
),
greetz_to_mnpq_categories_cards_view AS
(
SELECT GreetzCategoryID, MPCategoryKey
FROM greetz_to_mnpq_categories_cards_view
UNION ALL SELECT 1143774336, 'teacher'
/*UNION ALL SELECT 1143735059, 'loesje-kerst'
UNION ALL SELECT 1143735104, 'cute-as-a-button-kerst'
UNION ALL SELECT 1143735113, 'blond-amsterdam-kerst'
UNION ALL SELECT 1143773516, 'sandysign'*/
),

Invitations
AS
(
SELECT DISTINCT cd.id as carddefinitionid
FROM carddefinition cd
	JOIN contentinformation_category ci 
		ON cd.contentinformationid = ci.contentinformationid
	JOIN contentcategory cc
		ON cc.id = ci.contentcategoryid
	JOIN contentcategorytype cct
		ON cct.ID = cc.categorytypeid
	JOIN contentcategorytranslation ct
		ON ct.contentcategoryid = cc.id AND ct.locale = 'en_EN'
WHERE  (cd.APPROVALSTATUS = 'APPROVED' OR cd.APPROVALSTATUS IS NULL)
	  AND (cd.ENABLED = 'Y' OR cd.ENABLED IS NULL)
	  AND cct.INTERNALNAME = 'Occasion'
	  AND lower(ct.TEXT) LIKE '%invit%'
),

ProductList_0
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
				p.PRODUCTCODE, cd.showonstore, pc.CARDSIZE, pcp.vatid, pc.cardratio, cd.ORIENTATION, 
				cd.CONTENTCOLLECTIONID, numberofphotos,
				case when RIGHT(cif_nl_title.text, 2) = ' |'  then trim(LEFT(cif_nl_title.text, LENGTH(cif_nl_title.text) - 2)) ELSE cif_nl_title.text end  AS nl_product_name,
				-- cif_nl_title.text  		AS nl_product_name,
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
	 JOIN carddefinition cd 
			ON cd.CARDRATIO = pc.CARDRATIO 
				AND cd.OBLONG = pc.OBLONG 
				AND (cd.NUMBEROFPANELS = pc.AMOUNTOFPANELS 
					 OR (pc.AMOUNTOFPANELS = 1 AND cd.NUMBEROFPANELS = 2 AND cd.allowsinglepanel = 'Y'))
	 LEFT JOIN Invitations i ON cd.ID = i.carddefinitionid
     JOIN product p 
		ON pc.PRODUCTID = p.ID 
			AND p.TYPE = 'productCardSingle' 
			AND p.CHANNELID = 2 
			AND ((i.carddefinitionid IS NULL  AND p.onlyAvailableForFlow IS NULL) OR (i.carddefinitionid IS NOT NULL  AND  p.ID IN (1142760910, 1142760911, 1142760912))) -- ('invite_card_Standard_Medium_1panel', 'invite_card_Standard_Medium_2panel', 'invite_card_Square_Large_2panel')) 
			AND pc.enabled = 'Y' 
			AND p.removed is null
			AND p.endoflife != 'Y'
   --  join productphysicalproperty ppp 
	--	ON p.PRODUCTPHYSICALPROPERTIESID = ppp.ID 
	--		AND ppp.PAPERTYPE in ('DEFAULT', 'InvercoteCreato300')
     JOIN productcardprice pcp 
		ON PRODUCTCARDID = p.ID 
			AND current_date() between pcp.availableFrom AND pcp.availableTill 
			AND pcp.amountFrom = 1
     
     JOIN carddefinition_limitedcardsize cdl 
		ON cdl.CARDDEFINITIONID = cd.ID 
			AND pc.CARDSIZE = cdl.CARDSIZE
	 JOIN carddefinition_channel cdc
			ON cdc.CARDDEFINITIONID = cd.ID
				AND pc.CARDSIZE = cdl.CARDSIZE
				AND (cd.ID IN (
3000087418,
3000087433,
3000090766,
3000092146,
3000092151,
3000092176,
3000092181,
3000093491
				) OR (i.carddefinitionid IS NULL  OR  cdc.CHANNELFLOWID = p.onlyAvailableForFlow)) 
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
	  cdc.channelID = '2'
	  AND (
			(pc.AMOUNTOFPANELS = 2 AND pc.cardratio = 'STANDARD'  AND pc.CARDSIZE IN ('MEDIUM', 'XXL', 'SUPERSIZE')) 
			OR (pc.AMOUNTOFPANELS = 2 AND pc.cardratio = 'SQUARE' AND pc.CARDSIZE IN ('LARGE', 'XXL', 'SUPERSIZE')) 
			OR (pc.AMOUNTOFPANELS = 1 AND pc.CARDSIZE = 'MEDIUM')
		  )	 
	  AND
	  (
		 /* ((cd.APPROVALSTATUS = 'APPROVED' OR cd.APPROVALSTATUS IS NULL)
		  AND (cd.ENABLED = 'Y' OR cd.ENABLED IS NULL)
		  AND ((cd.EXCLUDEFROMSEARCHINDEX = 'N' AND cif_nl_title.TYPE IS NOT NULL) OR cd.EXCLUDEFROMSEARCHINDEX IS NULL)
		  AND (r.id is null OR (r.orderablefrom <= current_date() AND current_date() <= r.shippableto))	 
		  AND bl.carddefinitionid IS NULL
		  AND (cif_nl_title.text IS NOT NULL  OR  cif_en_title.text IS NOT NULL)
		  AND concat(:designIds) IS NULL) */

		 cast(cd.ID as varchar(50)) IN (:designIds)
		 OR (concat(:designIds) IS NULL  AND  concat(:keys) IS NOT NULL)
	  )
),

Carddefinition_Grouped AS
(
SELECT DISTINCT carddefinitionid, contentinformationid, CONTENTCOLLECTIONID
FROM ProductList_0
),

Ignore_AgeCategory
AS
(
SELECT DISTINCT pl.carddefinitionid
FROM Carddefinition_Grouped pl
	 JOIN contentinformation_category ci
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
SELECT DISTINCT INTERNALNAME, carddefinitionid, Val_Code, Val_Name
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
		
		
		concat(
				IFNULL(
				
					IF(da.ID IS NOT NULL, NULL, 
					
					 (SELECT group_concat(DISTINCT(mc.MPCategoryKey) separator ', ')
					 FROM contentinformation_category ci
						 JOIN contentcategory cc
							ON cc.id = ci.contentcategoryid
						 JOIN contentcategorytype c
							ON cc.categorytypeid = c.id	 
						 JOIN greetz_to_mnpq_categories_cards_view mc 
							ON mc.GreetzCategoryID = cc.id 
					 WHERE ci.contentinformationid = pl.contentinformationid  
							AND mc.MPCategoryKey IS NOT NULL
							AND (
								  ig.carddefinitionid IS NULL  
								  OR (mc.MPCategoryKey NOT LIKE '%years-old' AND mc.MPCategoryKey NOT IN ('all-kids', 'age-other', 'age-unspecified', 'age-groups'))
								))									  
								
					 )		
			   , 'greeting-cards')
		, case when pl.numberofphotos > 0 then ', photo-cover-cards' else '' end
		)
	   AS category_keys,
	   
		
	/*	 IFNULL(
		(
			 SELECT group_concat(DISTINCT(s.MPCategoryKey) separator ', ')
			 FROM
			 (
			 SELECT mc.MPCategoryKey
			 FROM contentinformation_category ci
				 JOIN contentcategory cc
					ON cc.id = ci.contentcategoryid
				 JOIN greetz_to_mnpq_categories_cards_view mc 
					ON mc.GreetzCategoryID = cc.id 
			 WHERE ci.contentinformationid = pl.contentinformationid  
					AND mc.MPCategoryKey IS NOT NULL
			 UNION ALL
			 SELECT 'photo-cover-cards' AS MPCategoryKey
			 FROM product 
			 WHERE pl.numberofphotos >= 0
			 LIMIT 1
			 ) s
					
		)  
	   , 'greeting-cards')	 AS category_keys,*/
		
		replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(concat('[', 
		group_concat(JSON_OBJECT(
		   'variantKey', concat(pl.entity_key, 
						   '-', 
						   upper(pl.Attribute_Size), 
						--   case pl.Attribute_Shape when 'square' then 'SQUARE' else '' end, 
						   'CARD'),
		   'skuId', concat(pl.entity_key, 
						   '-', 
						   upper(pl.Attribute_Size), 
						   case pl.Attribute_Shape when 'square' then 'SQUARE' else '' end, 
						   'CARD'),
		   'masterVariant', CASE WHEN pl.RN_MasterVariant = 1 THEN 1 ELSE 0 END,
           'productCode', replace(replace(pl.entity_key, 'GRTZ', ''), '-SQ', ''),
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
									   AND current_date() BETWEEN pcp.availablefrom AND pcp.availabletill
									   AND pcp.cardsize = pl.cardsize
									   AND cp.currency = pcp.currency
							 WHERE cp.productcardid = pl.productid
									AND current_date() between cp.availableFrom AND cp.availableTill 
									AND cp.amountFrom = 1
							 ),
							 
			'attributes', CONCAT('[', 
				case when pl.AMOUNTOFPANELS = 2 then CONCAT('{"attributeName": "size", "attributeValue": "', pl.Attribute_Size, 
				'", "attributeType": "enum"}, {"attributeName": "shape", "attributeValue": "', pl.Attribute_Shape, '", "attributeType": "enum"}, ') 
				else '' end,
				'{"attributeName": "range", "attributeValue": "', IF(da.ID IS NOT NULL, 'tangled', IFNULL(replace(pr.product_range_key, 'range-', ''),'tangled')),						
				'", "attributeType": "enum"}, {"attributeName": "product-range", "attributeValue": "', IF(da.ID IS NOT NULL, 'range-tangled', IFNULL(pr.product_range_key,'range-tangled')), '", "attributeType": "category-reference"},',
				'{"attributeName": "product-range-text", "attributeValue": "', IF(da.ID IS NOT NULL, 'Tangled', IFNULL(pr.product_range_text,'Tangled')), '", "attributeType": "text"},',
				'{"attributeName": "photo-count", "attributeValue": "', case when pl.numberofphotos >= 0 then pl.numberofphotos else 0 end, '", "attributeType": "number"},',
				'{"attributeName": "reporting-artist", "attributeValue": "anonymous", "attributeType": "enum"},',
				'{"attributeName": "reporting-occasion", "attributeValue": "' , IF(da.ID IS NOT NULL, "general>general", COALESCE(a_oc.Val_Code, a_oc_2.occasion_code, "general>general")), '", "attributeType": "enum"},',
				'{"attributeName": "reporting-relation", "attributeValue": "' , IF(da.ID IS NOT NULL, "nonrelations", IFNULL(a_rl_2.MP_Code, "nonrelations")), '", "attributeType": "enum"},',
				'{"attributeName": "reporting-style", "attributeValue": "' , IF(da.ID IS NOT NULL, "design>general", IFNULL(a_des.Val_Code, "design>general")), '", "attributeType": "enum"}]')
			
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
	 LEFT JOIN Ignore_AgeCategory ig
		  ON ig.carddefinitionid = pl.carddefinitionid	
	 LEFT JOIN ListWithDefaultAttributes da
		  ON da.ID = pl.carddefinitionid	
WHERE
		((inv.carddefinitionid IS NULL AND Attribute_Size IS NOT NULL) OR  Attribute_Size = 'standard')
	/*	AND e_oc.entity_key IS NOT NULL 
		AND e_des.entity_key IS NOT NULL */
		AND (pl.entity_key > :migrateFromId OR :migrateFromId IS NULL)
		AND	(pl.entity_key <= :migrateToId OR :migrateToId IS NULL)
		AND (concat(:keys) IS NULL  OR  pl.entity_key IN (:keys))
GROUP BY 
		pl.entity_key
LIMIT :limit		


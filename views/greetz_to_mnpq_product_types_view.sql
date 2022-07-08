-- ########################################################################################
-- # This view creates mapped Greetz product types aligned with the product types in Moonpiq.
-- #
-- ########################################################################################

CREATE VIEW greetz_to_mnpg_product_types_view AS
with parent_category as (
    select id,
           name
    from productgiftcategory
    where PARENTCATEGORYITEMID is null
),
     product_type as (
         select 
                    
                lower(replace(replace(replace(MPTypeCode, '/', ' '), ' ', '-'), '&', 'and')) entity_key,
                MPTypeCode,
              --  name    as                                                     description,
                /*case
                    when name = 'Chocolate' then 'LETTERBOX'
                    when name = 'Toy / Game' then 'LETTERBOX'
                    when name = 'Candy' then 'LETTERBOX'
                    when name = 'Gadget / Novelty' then 'LETTERBOX'
                    when name = 'Alcohol' then 'LETTERBOX'
                    when name = 'Beauty' then 'LETTERBOX'
                    when name = 'Personalised Mugs' then 'BRAND'
                    end as                                                     attribute_key,*/
				
				case 
					when MPTypeCode = 'flower' then '[{"attributeName": "size", "attributeValue": "standard", "attributeType": "enum"}]'
					when MPTypeCode = 'gift-card' then '[{"attributeName": "delivery-type", "attributeValue": "physical", "attributeType": "lenum"}, 
						{"attributeName": "upc", "attributeValue": "SKUNumber", "attributeType": "text"},
						{"attributeName": "brand", "attributeValue": "unspecified", "attributeType": "lenum"}]'
					when MPTypeCode LIKE '%personalised%' then '[{"attributeName": "range", "attributeValue": "tangled", "attributeType": "enum"}, 
						{"attributeName": "product-range", "attributeValue": "range-17202-tangled", "attributeType": "reference"},
						{"attributeName": "product-range-text", "attributeValue": "Tangled", "attributeType": "text"},
						{"attributeName": "reporting-artist", "attributeValue": "anonymous", "attributeType": "enum"},
						{"attributeName": "reporting-occasion", "attributeValue": "general>general", "attributeType": "enum"},
						{"attributeName": "reporting-relation", "attributeValue": "nonrelations", "attributeType": "enum"},
						{"attributeName": "reporting-style", "attributeValue": "design>general", "attributeType": "enum"}
						]'		
					when MPTypeCode = 'postcard' then '[{"attributeName": "range", "attributeValue": "tangled", "attributeType": "enum"}, 
						{"attributeName": "product-range", "attributeValue": "range-17202-tangled", "attributeType": "reference"},
						{"attributeName": "product-range-text", "attributeValue": "Tangled", "attributeType": "text"},
						{"attributeName": "reporting-artist", "attributeValue": "anonymous", "attributeType": "enum"},
						{"attributeName": "reporting-occasion", "attributeValue": "general>general", "attributeType": "enum"},
						{"attributeName": "reporting-relation", "attributeValue": "nonrelations", "attributeType": "enum"},
						{"attributeName": "reporting-style", "attributeValue": "design>general", "attributeType": "enum"}
						]'		
					when MPTypeCode IN ('chocolate', 'alcohol', 'beauty', 'biscuit', 'gadget-novelty', 'sweet', 'toy-game') 
					then '[{"attributeName": "letterbox-friendly", "attributeValue": "false", "attributeType": "boolean"}]'
					-- Chocolate Telegram, Chocolate Letter
					when GreetzTypeID IN (398498540, 398498539) then '[{"attributeName": "letterbox-friendly", "attributeValue": "true", "attributeType": "boolean"}]'
						
				end  as AttributesTemplate,
				
				case 
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
				end  as DefaultCategoryKey,				
				
				GreetzTypeID,
				GreetzTypeName,
				GreetzSubTypeName
         from (
                  select distinct case
									  when lower(pgc2.name) = 'personalised chocolate' or lower(pgc2.name) LIKE 'personalised_tonys%' or lower(pgc2.child_name) = 'personalised chocolate'
                                          then 'personalised-chocolate'
									  when lower(pgc2.name) IN ('personalised beer','personalised beverage','personalised spirits','personalised wine','personalised_flavours_pack','personalised_uv_printing_parcel_beverage','personalised_winetubes')
                                          then 'personalised-alcohol'		
									  when lower(pgc2.name) IN ('personalisedmerci','personalised_australian','personalised_candy','personalised_leonidas','personalised_magic_cake','personalised_merci_675')
                                          then 'personalised-sweets'		
                                      when lower(pgc2.name) IN ('accessories', 'photogifts') and lower(pgc2.child_name) = 'personalised mugs'
                                          then 'personalised-mug'										 										  
                                      when lower(pgc2.name) = 'accessories' and lower(pgc2.child_name) = 'gadgets'
                                          then 'gadget-novelty'
                                      when lower(pgc2.name) IN ('accessories', 'kinderboekjes', 'blond amsterdam'
													, 'mug standaard', 'personalised_sublimation_parcel', 'photogifts') 
										  then 'home-gift'
									  when lower(pgc2.name) = 'photogifts' and lower(pgc2.child_name) != 'personalised chocolate' then 'home-gift'
									  when pgc2.name LIKE '%amsterdam%' then 'home-gift'
									  when lower(pgc2.name) LIKE 'accessoires%' then 'home-gift'
									  when lower(pgc2.name) LIKE 'baby%' AND lower(pgc2.child_name) = 'plush' then 'toy-game'
									  when lower(pgc2.name) LIKE 'baby%' then 'home-gift'
									  when lower(pgc2.name) LIKE 'bakmix%' then 'home-gift'
									  when lower(pgc2.name) LIKE 'games%' then 'toy-game'
									  when lower(pgc2.name) LIKE '%candle%' then 'home-gift'									
						
                                      when lower(pgc2.name) = 'speelgoed' then 'toy-game'
                                      when lower(pgc2.name) LIKE '%balloon%' then 'balloon'
									  when lower(pgc2.name) LIKE '%ballon%' then 'balloon'
                                      when lower(pgc2.name) = 'beverage' and lower(IFNULL(pgc2.child_name, '')) NOT IN ('tea') then 'alcohol'
									  when lower(pgc2.name) = 'personalised beverage' then 'alcohol'
                                      when lower(pgc2.name) = 'flowers' then 'flower'
                                      when lower(pgc2.name) = 'toys' then 'toy-game'
                                      when lower(pgc2.name) = 'knuffels' then 'toy-game'
                                      when lower(pgc2.name) = 'thuis' then 'home-gift'
                                      when lower(pgc2.name) = 'eten & drinken' /*AND lower(pgc2.child_name) = 'kinderservies'*/ then 'home-gift'
                                      when lower(pgc2.name) = 'kleding' then 'home-gift'
                                      when lower(pgc2.child_name) = 'clothing' then 'home-gift'
									  when lower(pgc2.name) = 'book' then 'book'
                                      when lower(pgc2.name) LIKE '%books%' then 'book'
                                     -- when lower(pgc2.child_name) = 'bubble' then 'Bubbles'                                   
                                      when lower(pgc2.name) = 'food' AND lower(pgc2.child_name) IS NULL then 'sweet'
									  when lower(pgc2.name) = 'food' AND lower(pgc2.child_name) = 'fruit' then 'sweet'
									  when lower(pgc2.name) LIKE '%chocolate%' then 'chocolate'
									  when lower(pgc2.child_name) LIKE '%chocolate%' then 'chocolate'
									  when lower(pgc2.name) LIKE '%candy%' then 'sweet'
									  when lower(pgc2.child_name) LIKE '%candy%' then 'sweet'
                                      when lower(pgc2.name) IN ('fruit', 'personalised_australian', 'personalised_leonidas', 'personalisedmerci') 
										then 'sweet'
									  when lower(pgc2.name) LIKE '%donut%' then 'sweet'
                                      when lower(pgc2.name) IN ('cake', 'layer cakes', 'personalised_cake') then 'cake'
									  when lower(pgc2.child_name) = 'cakes' then 'cake'
									  when lower(pgc2.name) LIKE '%giftcard%' then 'gift-card'
									  when lower(pgc2.name) LIKE 'beauty%' then 'beauty'
									  when lower(pgc2.name) LIKE 'beer%' then 'alcohol'
									  when lower(pgc2.name) LIKE '%winetube%' then 'alcohol'
									  when lower(pgc2.name) IN ('wine', 'spirits', 'personalised_flavours_pack') then 'alcohol'
									  when lower(pgc2.name) LIKE 'cardboxes%' then 'postcard'
									  
		-- Added 2022-04-09 - for old products:
										when lower(pgc2.name) IN ('ball', 'bambam parcel', 'bambam post', 'puzzle') then 'toy-game'
										when lower(pgc2.name) LIKE ('toys%') then 'toy-game'
										when lower(pgc2.name) IN ('bloom post', 'flowers mourning') then 'flower'
										when lower(pgc2.name) IN ('book_cardboard', 'book_post', 'book_parcel') then 'book'
										when lower(pgc2.name) = 'brownies postal' then 'biscuit'
										when lower(pgc2.name) IN ('burlington', 'canvas', 'gadgets_parcel', 'gadgets_post', 'home_parcel'
											, 'magazines', 'mousepad', 'mug', 'peas', 'personalised_flowers', 'personalised_uv_printing_postal'
											,'plush', 'plush postal', 'samsung', 'ipad', 'iphone', 'tile', 'thee_parcel', 'thee_postal') then 'home-gift'
										when lower(pgc2.child_name) = 'tea' then 'home-gift'
										when lower(pgc2.name) LIKE 'personalised_baby%' then 'home-gift'
										when lower(pgc2.name) LIKE 'tableware%' then 'home-gift'
										when lower(pgc2.name) IN ('dove personalised', 'lief', 'lief_cardboard') then 'beauty'									
										when lower(pgc2.name) = 'fruitz' then 'sweet'
										when lower(pgc2.name) = 'cake_ongekoeld' then 'cake'
										when lower(pgc2.name) = 'spirits_postal' then 'alcohol'

-- 		this categories have never been used:
-- 		begin of the list:
										when lower(pgc2.name) = lower('Bag') then 'home-gift'
										when lower(pgc2.name) = lower('Bambam') then 'home-gift'
										when lower(pgc2.name) = lower('Brownies parcel') then 'home-gift'
										when lower(pgc2.name) = lower('Button') then 'home-gift'
										when lower(pgc2.name) = lower('Cake_2 lead days') then 'cake'
										when lower(pgc2.name) = lower('Coasters') then 'home-gift'
										when lower(pgc2.name) = lower('Combi flowers/beverage') then 'flower'
										when lower(pgc2.name) = lower('Dvd') then 'home-gift'
										when lower(pgc2.name) = lower('Gadgets') then 'gadget-novelty'
										when lower(pgc2.name) = lower('Home') then 'home-gift'
										when lower(pgc2.name) = lower('Home_post') then 'home-gift'
										when lower(pgc2.name) = lower('Homeware parcel') then 'home-gift'
										when lower(pgc2.name) = lower('Homeware postal') then 'home-gift'
										when lower(pgc2.name) = lower('Keychain') then 'home-gift'
										when lower(pgc2.name) = lower('Lidl') then 'home-gift'
										when lower(pgc2.name) = lower('Muffins') then 'biscuit'
										when lower(pgc2.name) = lower('Non alcohol') then 'home-gift'
										when lower(pgc2.name) = lower('Personalised beer') then 'alcohol'
										when lower(pgc2.name) = lower('Personalised spirits') then 'alcohol'
										when lower(pgc2.name) = lower('Personalised wine') then 'alcohol'
										when lower(pgc2.name) = lower('Personalised_baby_sleeve_postal') then 'home-gift'
										when lower(pgc2.name) = lower('Personalised_magic_cake') then 'sweet'
										when lower(pgc2.name) = lower('Personalised_merci_675') then 'sweet'
										when lower(pgc2.name) = lower('Personalised_tableware_postal') then 'home-gift'
										when lower(pgc2.name) = lower('Personalised_tea') then 'home-gift'
										when lower(pgc2.name) = lower('Personalised_tonys_parcel') then 'home-gift'
										when lower(pgc2.name) = lower('Personalised_tonys_postal') then 'home-gift'
										when lower(pgc2.name) = lower('Personalised_uv_printing_parcel_beverage') then 'alcohol'
										when lower(pgc2.name) = lower('Photoframe') then 'home-gift'
										when lower(pgc2.name) = lower('Photoframe_parcel') then 'home-gift'
										when lower(pgc2.name) = lower('Phrame it') then 'home-gift'
										when lower(pgc2.name) = lower('Speakingrose') then 'home-gift'
										when lower(pgc2.name) = lower('Welness') then 'home-gift'
-- 		end of the list of never used categories
									
                                      else CONCAT('NotMapped_', UPPER(SUBSTRING(pgc2.name,1,1)),LOWER(SUBSTRING(pgc2.name,2)))
                                      end as MPTypeCode,
                                      pgc2.id as GreetzTypeID,
									  pgc2.name as GreetzTypeName,
									  pgc2.child_name as GreetzSubTypeName
                  from 
						(
						SELECT pgc2.name, pgc.id, pgc.name as child_name
						FROM productgiftcategory pgc
                           JOIN parent_category pgc2 on pgc.PARENTCATEGORYITEMID = pgc2.id
						WHERE pgc2.name NOT IN ('Welness') -- decommissioned
						UNION ALL
						SELECT pgc.name, pgc.id, NULL as child_name
						FROM productgiftcategory pgc
						WHERE pgc.parentcategoryitemid IS NULL
						UNION ALL
						SELECT internalname, ID, NULL as child_name 
						FROM productgifttype
						) pgc2
              ) a
     )

select entity_key, GreetzTypeID, GreetzTypeName, GreetzSubTypeName, MPTypeCode, AttributesTemplate, DefaultCategoryKey				
from product_type

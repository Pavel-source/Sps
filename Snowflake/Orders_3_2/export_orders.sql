SELECT 
	o.ORDER_ID AS id, 
	o.ORDER_DATE_TIME AS Created,
	o.ORDER_STATE,
	o.ORDER_ID AS orderReference,
	o.customer_id AS customerid,
	i.REPORTING_CURRENCY AS currencycode,
	
	-- TOTALWITHVAT = (PRODUCT_UNIT_PRICE + PRODUCT_DISCOUNT_INC_TAX + PRODUCT_TOTAL_TAX (?))
	-- GRANDTOTALFORPAYMENT = SUM(PRODUCT_UNIT_PRICE + PRODUCT_DISCOUNT_INC_TAX + PRODUCT_TOTAL_TAX) ?
	-- DISCOUNTWITHVAT = PRODUCT_DISCOUNT_INC_TAX
	-- totalPrice = (PRODUCT_UNIT_PRICE + PRODUCT_DISCOUNT_INC_TAX + PRODUCT_TOTAL_TAX (?))
	i.PRODUCT_UNIT_PRICE, 
	i.PRODUCT_DISCOUNT_INC_TAX, 
	i.PRODUCT_TOTAL_TAX,
	
	-- TOTALWITHOUTVAT = (PRODUCT_UNIT_PRICE + PRODUCT_DISCOUNT_EX_TAX ?)
	i.PRODUCT_DISCOUNT_EX_TAX,
	-- totalShippingPrice: when o.productcode = 'shipment_generic' then o.WITHVAT + o.DISCOUNTWITHVAT
	i.POSTAGE_SUBTOTAL, -- ?
	-- POSTAGE_DISCOUNT_INC_TAX,  -- POSTAGE_SUBTOTAL includes DISCOUNT
	
	-- deliveryDate (=PROPOSED_DELIVERY_DATE ?)
	i.PROPOSED_DELIVERY_DATE,
	
	i.ACTUAL_DESPATCH_DATE,
	i.ESTIMATED_DESPATCH_DATE,
	i.TRACKING_CODE,
	
	i.SKU AS productKey,
	i.PRODUCT_TYPE_NAME,	-- productTypeKey, product_type
	i.SKU_VARIANT,		-- sku_id
	i.PRODUCT_TITLE,		-- nl_product_name
	i.ORDER_LINE_ID,		-- ol_id
	i.QUANTITY,		--  productamount
	
	
-- ?  email	
--	channelid
	
	CONCAT('{',
		'"id": ', CONCAT('"delivery_', o.ORDER_ID, '_', IFNULL(i.ADDRESS_ID, 0), '"'),
		
		IFNULL(CONCAT(',"status": ', CONCAT('"', 
			case 
				 when i.SHIPMENT_STATE = 'Ready' then 'Ready'
                 when i.SHIPMENT_STATE = 'Pending' then 'Pending'
				 when i.SHIPMENT_STATE IS NULL then ''
			end
		, '"')), ''), 
		
		IFNULL(CONCAT(',"firstName": ', JSON_QUOTE(replace(replace(r.firstname, '\r\n', ' '),'\n', ' '))), ''),
		IFNULL(CONCAT(',"lastName": ', JSON_QUOTE(replace(replace(r.lastname, '\r\n', ' '),'\n', ' '))), ''),
		IFNULL(CONCAT(',"deliveryType": ', CONCAT('"', 'POSTAL', '"')), ''),

		',"address": ', 	IFNULL(CONCAT('{',
												CONCAT('"id": ', '"', CONCAT('fake-', UUID()), '"'),
												IFNULL(CONCAT(',"firstName": ', JSON_QUOTE(replace(replace(r.firstname, '\r\n', ' '),'\n', ' '))), ''),
												IFNULL(CONCAT(',"lastName": ', JSON_QUOTE(replace(replace(r.lastname, '\r\n', ' '),'\n', ' '))), ''),
											--	',"title": null',
											--	',"addressFirstLine": null',
                                                IFNULL(CONCAT(',"houseNumber": ', JSON_QUOTE(replace(replace(case when a.ID IS NOT NULL then a.streetnumber else a2.streetnumber end, '\r\n', ' '),'\n', ' '))), ''),
												IFNULL(CONCAT(',"houseNumberExtension": ', JSON_QUOTE(replace(replace(case when a.ID IS NOT NULL then a.streetnumberextension else a2.streetnumberextension end, '\r\n', ' '),'\n', ' '))), ''),
												IFNULL(CONCAT(',"extraAddressLine": ', JSON_QUOTE(replace(replace(
												                                        case when a.ID IS NOT NULL then
																								case when COALESCE(a.extraaddressline1, a.extraaddressline2, a.extraaddressline3) IS NULL
																									then NULL
																								else
																									trim(concat(nvl(a.extraaddressline1, ''), ' ', nvl(a.extraaddressline2, ''), ' ', nvl(a.extraaddressline3, '')))
																								end
																						else
																								case when COALESCE(a2.extraaddressline1, a2.extraaddressline2, a2.extraaddressline3) IS NULL
																									then NULL
																								else
																									trim(concat(nvl(a2.extraaddressline1, ''), ' ', nvl(a2.extraaddressline2, ''), ' ', nvl(a2.extraaddressline3, '')))
																								end
																						end, '\r\n', ' '),'\n', ' '))
															 )
													, ''),

												IFNULL(CONCAT(',"streetName": ', JSON_QUOTE(replace(replace(case when a.ID IS NOT NULL then a.street else a2.street end, '\r\n', ' '),'\n', ' '))), ''),
                                                IFNULL(CONCAT(',"city": ', JSON_QUOTE(replace(replace(case when a.ID IS NOT NULL then a.city else a2.city end, '\r\n', ' '),'\n', ' '))), ''),
												IFNULL(CONCAT(',"state": ', JSON_QUOTE(replace(replace(case when a.ID IS NOT NULL then a.STATEPROVINCECOUNTY else a2.STATEPROVINCECOUNTY end, '\r\n', ' '),'\n', ' '))), ''),
                                                IFNULL(CONCAT(',"postcode": ', JSON_QUOTE(replace(replace(case when a.ID IS NOT NULL then a.zippostalcode else a2.zippostalcode end, '\r\n', ' '),'\n', ' '))), ''),
												IFNULL(CONCAT(',"country": ', CONCAT('"', case when a.ID IS NOT NULL then c.ENGLISHCOUNTRYNAME else c2.ENGLISHCOUNTRYNAME end, '"')), ''),
												IFNULL(CONCAT(',"emailAddress": ', CONCAT('"', cea.email, '"')), ''),
												IFNULL(CONCAT(',"isMyAddress": ', case when a2.ID IS NOT NULL then 'true' else 'false' end), ''),
												CONCAT(',"isScrubbed": ', case when (a.ID IS NOT NULL AND a.street = 'SCRUBBED') OR (a.ID IS NULL AND a2.street = 'SCRUBBED') then 'true' else 'false' end),
												
												'}'), 'null'),
			

-- "recipientAddress" is the same as "address"
		',"recipientAddress": ', 	IFNULL(CONCAT('{',
												CONCAT('"id": ', '"', CONCAT('fake-', UUID()), '"'),
												IFNULL(CONCAT(',"firstName": ', JSON_QUOTE(replace(replace(r.firstname, '\r\n', ' '),'\n', ' '))), ''),
												IFNULL(CONCAT(',"lastName": ', JSON_QUOTE(replace(replace(r.lastname, '\r\n', ' '),'\n', ' '))), ''),
											--	',"title": null', 	
											--	',"addressFirstLine": null', 	
												IFNULL(CONCAT(',"houseNumber": ', JSON_QUOTE(replace(replace(case when a.ID IS NOT NULL then a.streetnumber else a2.streetnumber end, '\r\n', ' '),'\n', ' '))), ''),
												IFNULL(CONCAT(',"houseNumberExtension": ', JSON_QUOTE(replace(replace(case when a.ID IS NOT NULL then a.streetnumberextension else a2.streetnumberextension end, '\r\n', ' '),'\n', ' '))), ''),
												IFNULL(CONCAT(',"extraAddressLine": ', JSON_QUOTE(replace(replace(
												                                        case when a.ID IS NOT NULL then
																								case when COALESCE(a.extraaddressline1, a.extraaddressline2, a.extraaddressline3) IS NULL
																									then NULL
																								else
																									trim(concat(nvl(a.extraaddressline1, ''), ' ', nvl(a.extraaddressline2, ''), ' ', nvl(a.extraaddressline3, '')))
																								end
																						else 
																								case when COALESCE(a2.extraaddressline1, a2.extraaddressline2, a2.extraaddressline3) IS NULL
																									then NULL
																								else
																									trim(concat(nvl(a2.extraaddressline1, ''), ' ', nvl(a2.extraaddressline2, ''), ' ', nvl(a2.extraaddressline3, '')))
																								end
																						end, '\r\n', ' '),'\n', ' '))
															 )
													, ''),												
												
												IFNULL(CONCAT(',"streetName": ', JSON_QUOTE(replace(replace(case when a.ID IS NOT NULL then a.street else a2.street end, '\r\n', ' '),'\n', ' '))), ''),
												IFNULL(CONCAT(',"city": ', JSON_QUOTE(replace(replace(case when a.ID IS NOT NULL then a.city else a2.city end, '\r\n', ' '),'\n', ' '))), ''),
												IFNULL(CONCAT(',"state": ', JSON_QUOTE(replace(replace(case when a.ID IS NOT NULL then a.STATEPROVINCECOUNTY else a2.STATEPROVINCECOUNTY end, '\r\n', ' '),'\n', ' '))), ''),
												IFNULL(CONCAT(',"postcode": ', JSON_QUOTE(replace(replace(case when a.ID IS NOT NULL then a.zippostalcode else a2.zippostalcode end, '\r\n', ' '),'\n', ' '))), ''),
												IFNULL(CONCAT(',"country": ', CONCAT('"', case when a.ID IS NOT NULL then c.ENGLISHCOUNTRYNAME else c2.ENGLISHCOUNTRYNAME end, '"')), ''),   
												IFNULL(CONCAT(',"emailAddress": ', CONCAT('"', cea.email, '"')), ''),
												IFNULL(CONCAT(',"isMyAddress": ', case when a.ID IS NOT NULL then 'false' when a2.ID IS NOT NULL then 'true' end), ''),
												CONCAT(',"isScrubbed": ', case when (a.ID IS NOT NULL AND a.street = 'SCRUBBED') OR (a.ID IS NULL AND a2.street = 'SCRUBBED') then 'true' else 'false' end),
												'}'), 'null'),

		IFNULL(CONCAT(',"deliveryDate": ', CONCAT('"', cast(cast(IFNULL(sds.deliveredTime, dp.pickupDate + INTERVAL 1 day) AS DATE) AS VARCHAR(50)), '"')), ''), 
		IFNULL(CONCAT(',"actualDispatchDate": ', CONCAT('"', cast(cast(dp.pickupDate AS DATE) AS VARCHAR(50)), '"')), ''),  
		IFNULL(CONCAT(',"estimatedDispatchDate": ', CONCAT('"', cast(cast(
																	IFNULL(dp.deliveryDate, case when productcode like 'wallet%' then o.created + INTERVAL 1 day end) 
																AS DATE) AS VARCHAR(50)), '"')), ''),
		
		',"orderItems": ',	replace(replace(concat('[',
						group_concat(
						
							CASE
							WHEN o.product_type NOT IN (
														'content',
														'shipment',
														'outerCarton',
														'sound',
														'packetToSelfSurcharge',
														'trimoption'
														)
							THEN
						
							CONCAT('{',
							   '"id": ', o.ol_id,
                                ',"previewImages": []',
							    ',"s3ImagePrefixes": ', IFNULL(s3ImagePrefixes, s3ImagePrefixes_2), 
							--	   '"lineItemId": ', o.ORDERLINEIDX,
							    IFNULL(CONCAT(',"title": ', CONCAT('"', case 
																		when o.productTypeKey = 'greetingcard' then 'Kaart' 
																		when env.code IS NOT NULL then env.name
																		else replace(replace(o.nl_product_name, '"', '\\"'), '	', ' ')
																		end, '"')), ''),  
							--    IFNULL(CONCAT(',"titleEn": ', CONCAT('"', o.en_product_name, '"')), ''), 
							   ',"quantity": ', o.productamount,
							   CONCAT(',"totalPrice": ', CONCAT('{"centAmount": ', cast(100 * (o.totalwithvat + IFNULL(co.totalwithvat, 0)) AS INT), ', "currencyCode": "', o.currencycode, '"}')),  
							   CONCAT(',"unitPrice": ', CONCAT('{"centAmount": ', cast(100 * (o.totalwithvat + IFNULL(co.totalwithvat, 0))/o.productamount as DECIMAL(10,2)), ', "currencyCode": "', o.currencycode, '"}')), 
							--   ',"taxCategory": ',  CONCAT('"', concat('vat', o.vatcode), '"'),
							   ',"productType": ', CONCAT('"', o.productTypeKey, '"'),						   
							   
							   ',"sku": ', CONCAT('"',  case o.productTypeKey 
															when 'greetingcard' then 
																concat('GRTZ', 
																		IFNULL(o.carddefinition, 0), 
																		'-',
																		case 
																			when lower(o.PRODUCTCODE) like '%standard%' then 'STANDARD'
																			when lower(o.PRODUCTCODE) like '%square%large%' then 'STANDARD'
																			when lower(o.PRODUCTCODE) like '%xxl%' then 'LARGE'
																			when lower(o.PRODUCTCODE) like '%supersize%' then 'GIANT'
																			else 'STANDARD'
																		end,	
																		case when lower(o.PRODUCTCODE) like '%square%' then 'SQUARE' else '' end,
																		'CARD') 
															else o.sku_id 
														end, '"'),
							   
							   
							   ',"productSlug": ', CONCAT('"', case o.productTypeKey when 'greetingcard' then concat('GRTZ', o.carddefinition) else o.productKey end, '"'), 
							   ',"productKey": ', CONCAT('"', case o.productTypeKey when 'greetingcard' then concat('GRTZ', o.carddefinition) else o.productKey end, '"'), 
										'}'
									)
									
							ELSE
								'{}'
							END
									
									
							)
							, ']'), '{},', ''), ',{}', ''),
		 							
		',"deliveryInformation": ', 	CONCAT('{',
										IFNULL(CONCAT('"deliveryMethodId": ', CONCAT('"', IFNULL(ct.id, 'NONE') , '"')), ''),
										IFNULL(CONCAT(',"deliveryMethodName": ', CONCAT('"', IFNULL(
																					case ct.carrier 
																					when 'TNT' then 'PostNL'
																					when 'PACKS' then 'Packs'
																					when 'BLANK' then 'Bpost'
																					else ct.carrier 
																					end, 
																				'Standard'), '"')), ''),
										IFNULL(CONCAT(',"trackingNumber": ', CONCAT('"', case when dp.hastrackandtrace = 'Y' and o.created > CURRENT_DATE() - INTERVAL 2 YEAR then sai.barcode end, '"')), ''),
										IFNULL(CONCAT(',"trackingUrl": ', CONCAT('"', case when dp.hastrackandtrace = 'Y' and o.created > CURRENT_DATE() - INTERVAL 2 YEAR then isp.TRACKANDTRACECODE end, '"')), ''),
										IFNULL(CONCAT(',"fullTrackingUrl": ', CONCAT('"', case when dp.hastrackandtrace = 'Y' and o.created > CURRENT_DATE() - INTERVAL 2 YEAR then isp.TRACKANDTRACECODE end, '"')), ''),
										',"fulfilmentCentre" : {"id" : "NL-GRTZ-AMS", "countryCode": "NL"}',
										'}'),
								   --		'deliveryType', dp.type,
		
		IFNULL(CONCAT(',"mobileNumber": ', CONCAT('"', case when a.ID IS NOT NULL then mct.mobile_phone else mcm.mobile_phone end, '"')), ''),  
		'}'				
		)
	AS orderDelivery
	
	
FROM orders o
	JOIN order_items i ON o.ORDER_ID = i.ORDER_ID
GROUP BY 
	o.ORDER_ID,
	i.ADDRESS_ID
LIMIT 10	
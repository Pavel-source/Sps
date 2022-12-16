

CREATE OR REPLACE TABLE "RAW_GREETZ"."GREETZ3".tmp_dm_gift_product_variants (

	id_auto BIGINT NOT NULL,
	product_id BIGINT NOT NULL,
	productKey VARCHAR(50) NOT NULL,
	nl_product_name VARCHAR(150) NULL,
	sku_id VARCHAR(300) NOT NULL,
	variant_key VARCHAR(50) NOT NULL,
	productTypeKey VARCHAR(100) NOT NULL,
	designId BIGINT NULL,
	PRODUCTCODE VARCHAR(300) NOT NULL,
	type	 VARCHAR(100) NOT NULL,
	
	PRIMARY KEY (id_auto)
)
;



INSERT INTO tmp_dm_gift_product_variants(product_id, productKey, nl_product_name, sku_id, variant_key, productTypeKey, designId, PRODUCTCODE, type)

SELECT
	  p.ID AS product_id,
      concat('GRTZ', case when z.designProductId IS NULL then cast(p.ID AS varchar(50)) else concat('D', cast(z.designProductId AS varchar(50))) end)
	  AS productKey,
	  IFNULL(cif_nl_title.text, replace(p.INTERNALNAME, '_', ' ')) AS nl_product_name,
   --   cif_en_title.text AS en_product_name,
   
	  case 
		  when /*pt.MPTypeCode like '%personalised%' OR*/ z.designProductId IS NOT NULL 
			   then concat('GRTZD', cast(z.designProductId AS varchar(50)), '-STANDARD')
		  else p.PRODUCTCODE 
	  end AS sku_id,
						  
      concat('GRTZ', case when z.designProductId IS NULL then cast(p.ID AS varchar(50)) else concat('D', cast(z.designProductId AS varchar(50))) end)
	  AS variant_key,
   --   true                          AS ismastervariant,
	  IFNULL(pt.MPTypeCode, case p.type when 'productCardSingle' then 'greetingcard' else p.type end) AS productTypeKey,
	  z.designId,
	  p.PRODUCTCODE,
	  p.type
	  
   FROM
	  product p
      LEFT JOIN productgift pg
			ON pg.productid = p.id
	  LEFT JOIN (SELECT contentinformationid, text, db_updated
				 FROM contentinformationfield
				 WHERE type = 'TITLE'
					   AND locale = 'nl_NL') cif_nl_title
            ON cif_nl_title.contentinformationid = p.contentinformationid
	 /* LEFT JOIN (SELECT contentinformationid, text, db_updated
				 FROM contentinformationfield
				 WHERE type = 'TITLE'
                       AND locale = 'en_EN') cif_en_title
            ON cif_en_title.contentinformationid = p.contentinformationid*/
	  LEFT JOIN greetz_to_mnpg_product_types_view pt
              ON pt.GreetzTypeID = IFNULL(pg.productgiftcategoryid, pg.productgifttypeid)
	  LEFT JOIN 
			(
			 SELECT cd.ID AS designId, ppd.id AS designProductId, ppd.product
			  -- , cd.contentinformationid AS design_contentinformationid, cif_nl_title.TEXT AS nl_product_name_2
			 FROM productpersonalizedgiftdesign ppd 				
				 JOIN carddefinition cd 
						ON cd.ID = ppd.GIFTDEFINITION
						--	AND cd.ENABLED = 'Y'
						--	AND cd.APPROVALSTATUS = 'APPROVED'
						--	AND cd.CONTENTTYPE = 'STOCK'
				/* LEFT JOIN contentinformationfield cif_nl_title
					ON cif_nl_title.contentinformationid = cd.contentinformationid
						AND cif_nl_title.type = 'TITLE' AND cif_nl_title.locale = 'nl_NL'*/
			) z
				ON z.product = p.ID	
   WHERE
      p.channelid = '2'
      AND p.id NOT IN (SELECT pge.productstandardgift
					   FROM "RAW_GREETZ"."GREETZ3".productgroupentry pge
						  JOIN "RAW_GREETZ"."GREETZ3".productgroup ppg ON pge.productGroupId = ppg.id 
					   ) 
	  
   UNION ALL
   SELECT
		pge.productstandardgift AS product_id,
		concat('GRTZG', cast(ppg.ID AS varchar(50)))   AS productKey,
		ppg.title AS nl_product_name,
	--	null      AS en_product_name,		
		p.PRODUCTCODE AS sku_id,
		concat('GRTZ',  cast(p.ID AS varchar(50))) AS variant_key,
		pt.MPTypeCode AS productTypeKey,
		NULL as	designId,
		p.PRODUCTCODE,
		p.type
	FROM
		product p 
		left join productgift pg on pg.productid = p.id
		join productgroupentry pge on pge.productstandardgift = p.id
		join productgroup ppg ON pge.productGroupId = ppg.id
		left join greetz_to_mnpg_product_types_view pt
           on pt.GreetzTypeID = IFNULL(pg.productgiftcategoryid, pg.productgifttypeid)
	WHERE p.channelid = 2	
;
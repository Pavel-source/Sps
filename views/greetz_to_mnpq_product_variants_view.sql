-- This view creates mapped Greetz product variants

CREATE VIEW greetz_to_mnpg_product_variants_view AS

SELECT p.id                          AS product_id, -- The Product to which this Product Variant belongs.
       Concat(p.id, '-', 'STANDARD') AS sku_id,
       1                             AS variant_key,
       true                          AS isMasterVariant
FROM   productgift pg
       JOIN product p
         ON pg.productid = p.id
WHERE  p.channelid = '2'
       AND p.removed IS NULL
       AND p.endoflife != 'Y'
       AND productgiftcategoryid IS NOT NULL
       AND pg.productid NOT IN (SELECT productstandardgift
                                FROM   productgroupentry
                                WHERE  productstandardgift IS NOT NULL)
UNION ALL
SELECT product_id,
       sku_id,
       ismastervariant,
       Row_number()
         OVER (
           partition BY product_id
           ORDER BY 1) AS variant_key
FROM   (SELECT pge.productgroupid                    AS product_id, -- The Product to which this Product Variant belongs.
               Concat(pge.productgroupid, '_', p.id) AS sku_id,
               CASE
                 WHEN pge.showonstore = 'Y' THEN 1
                 ELSE 0
               END                                   AS isMasterVariant
        FROM   productgift pg
               JOIN product p
                 ON pg.productid = p.id
               JOIN productgroupentry pge
                 ON pge.productstandardgift = pg.productid
        WHERE  p.channelid = '2'
               AND p.removed IS NULL
               AND p.endoflife != 'Y'
               AND productgiftcategoryid IS NOT NULL
               AND productstandardgift IS NOT NULL) v
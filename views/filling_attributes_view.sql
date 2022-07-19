CREATE VIEW fill_attributes_view 
AS
SELECT CONCAT('oc_', entity_key) AS ENTITY_KEY, False AS LOCALIZED_ENUM, 'greetingcard' AS PRODUCT_TYPE_KEY,'reporting-occasion' AS ATTRIBUTE_NAME, entity_key AS VALUE_KEY, NAME AS VALUE_LABEL
FROM export_occasions_view
UNION ALL
SELECT CONCAT('st_', entity_key), False, 'greetingcard', 'reporting-style', entity_key, name
FROM export_styles_view
UNION ALL
SELECT CONCAT('rl_', entity_key), False, 'greetingcard', 'reporting-relation', entity_key, name
FROM export_relations_view
UNION ALL
SELECT CONCAT('rl_', entity_key), False, 'greetingcard', 'reporting-relation', entity_key, name
FROM export_relations_view
UNION ALL
SELECT CONCAT('br_', entity_key), True, 'gift-card', 'brand', entity_key, name
FROM export_brands_view
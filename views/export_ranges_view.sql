CREATE OR REPLACE VIEW export_ranges_view 
AS
SELECT substring(entity_key, 7) AS entity_key, name
FROM export_productranges_view
WHERE entity_key != 'range-tangled'
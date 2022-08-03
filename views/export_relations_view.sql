CREATE OR REPLACE VIEW export_relations_view 
AS
SELECT DISTINCT MP_Code AS entity_key, MP_Name AS name
FROM greetz_to_mnpg_relations_view
WHERE ToAdd = 1
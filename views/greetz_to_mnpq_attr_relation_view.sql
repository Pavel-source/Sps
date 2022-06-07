CREATE VIEW greetz_to_mnpq_attr_relation_view
AS
-- Aunt --> Auntie & Uncle
SELECT 1143753146 AS CategoryID, "auntie&uncle" AS AttributeCode, "Auntie & Uncle" AS AttributeValue, 0 AS Priority
-- Brother --> Brother
UNION ALL SELECT 1143742571, "brother", "Brother", 0
-- Bonus dad --> dad
UNION ALL SELECT 1143749726, "dad", "dad", 0
-- Daddy to be --> dad
UNION ALL SELECT 1143749750, "dad", "dad", 0
-- Father --> dad
UNION ALL SELECT 1143739704, "dad", "dad", 0
-- Fathers --> dad
UNION ALL SELECT 1143764753, "dad", "dad", 0
-- Daughter --> Daughter
UNION ALL SELECT 1143750944, "daughter", "Daughter", 0
-- Boy and girl --> Family
UNION ALL SELECT 1143764788, "family", "Family", 0
-- Uniseks --> Family
UNION ALL SELECT 1143739122, "family", "Family", 0
-- Woman general --> Female Friend
UNION ALL SELECT 1143755250, "femalefriend", "Female Friend", 0
-- Friend woman --> Female Friend
UNION ALL SELECT 1143750953, "femalefriend", "Female Friend", 0
-- Girl --> Female Friend
UNION ALL SELECT 886507052, "femalefriend", "Female Friend", 0
-- Girl general --> Female Friend
UNION ALL SELECT 1143758718, "femalefriend", "Female Friend", 0
-- Girls --> Female Friend
UNION ALL SELECT 1143742985, "femalefriend", "Female Friend", 0
-- Women --> Female Friend
UNION ALL SELECT 1143750947, "femalefriend", "Female Friend", 0
-- Other half woman --> Female Friend
UNION ALL SELECT 1143750950, "femalefriend", "Female Friend", 0
-- Grandfather --> Grandad
UNION ALL SELECT 1143742565, "grandad", "Grandad", 0
-- Granddaughter --> Granddaughter
UNION ALL SELECT 1143759003, "granddaughter", "Granddaughter", 0
-- Grandson --> Grandson
UNION ALL SELECT 1143758998, "grandson", "Grandson", 0
-- Grandmother --> Granny
UNION ALL SELECT 1143742568, "granny", "Granny", 0
-- Grandparents (Card only) --> Granny & Grandad
UNION ALL SELECT 1143729717, "granny&grandad", "Granny & Grandad", 0
-- Employee --> Male Colleague
UNION ALL SELECT 1143751274, "malecolleague", "Male Colleague", 0
-- B2B --> Male Colleague
UNION ALL SELECT 1143751277, "malecolleague", "Male Colleague", 0
-- Colleague --> Male Colleague
UNION ALL SELECT 1143742085, "malecolleague", "Male Colleague", 0
-- Zakelijk1 (cards missions) --> Male Colleague
UNION ALL SELECT 1143732725, "malecolleague", "Male Colleague", 0
-- Boys --> Male Friend
UNION ALL SELECT 1143742982, "malefriend", "Male Friend", 0
-- Boy --> Male Friend
UNION ALL SELECT 886506339, "malefriend", "Male Friend", 0
-- Other half man --> Male Friend
UNION ALL SELECT 1143750968, "malefriend", "Male Friend", 0
-- Boy general --> Male Friend
UNION ALL SELECT 1143758723, "malefriend", "Male Friend", 0
-- Men general --> Male Friend
UNION ALL SELECT 1143755253, "malefriend", "Male Friend", 0
-- Men --> Male Friend
UNION ALL SELECT 1143750956, "malefriend", "Male Friend", 0
-- Friend man --> Male Friend
UNION ALL SELECT 1143750971, "malefriend", "Male Friend", 0
-- Father and mother --> Married Couple
UNION ALL SELECT 1143764763, "marriedcouple", "Married Couple", 0
-- Mommy to be --> Mum
UNION ALL SELECT 1143749546, "mum", "Mum", 0
-- Mother --> Mum
UNION ALL SELECT 1143739125, "mum", "Mum", 0
-- Mothers --> Mum
UNION ALL SELECT 1143764758, "mum", "Mum", 0
-- Parents --> Mum & Dad
UNION ALL SELECT 1143754622, "mum&dad", "Mum & Dad", 0
-- Neutral Adult --> Non relations
UNION ALL SELECT 1143766578, "nonrelations", "Non relations", 0
-- Neutral --> Non relations
UNION ALL SELECT 1143755247, "nonrelations", "Non relations", 0
-- Neutral Child --> Non relations
UNION ALL SELECT 1143766583, "nonrelations", "Non relations", 0
-- Sister --> Sister
UNION ALL SELECT 1143742574, "sister", "Sister", 0
-- Son --> Son
UNION ALL SELECT 1143750959, "son", "Son", 0
-- Nephew --> Uncle/Nephew
UNION ALL SELECT 1143758208, "uncle/nephew", "Uncle/Nephew", 0
-- Uncle --> Uncle/Nephew
UNION ALL SELECT 1143753107, "uncle/nephew", "Uncle/Nephew", 0

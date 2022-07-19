CREATE VIEW greetz_to_mnpg_relations_view 
AS
SELECT 'B2B' AS Greetz_Name, 'b2b' AS MP_Code, 'B2B' AS MP_Name, 1 AS ToAdd
UNION ALL SELECT 'Aunt', 'auntie', 'Auntie', 1
UNION ALL SELECT 'Bonus dad', 'step-dad', 'Step Dad', 1
UNION ALL SELECT 'Boy', 'for-boys', 'For Boys', 1
UNION ALL SELECT 'Boy and girl', 'family', 'Family', 0
UNION ALL SELECT 'Boy general', 'for-boys', 'For Boys', 1
UNION ALL SELECT 'Boys', 'for-boys', 'For Boys', 1
UNION ALL SELECT 'Brother', 'brother', 'Brother', 0
UNION ALL SELECT 'Colleague', 'colleague', 'Colleague', 1
UNION ALL SELECT 'Daddy to be', 'daddy-to-be', 'Daddy To Be', 1
UNION ALL SELECT 'Daughter', 'daughter', 'Daughter', 0
UNION ALL SELECT 'Employee', 'colleague', 'Colleague', 1
UNION ALL SELECT 'Father', 'dad', 'Dad', 0
UNION ALL SELECT 'Father and mother', 'mum&dad', 'Mum And Dad', 0
UNION ALL SELECT 'Fathers', 'dad', 'Dad', 0
UNION ALL SELECT 'Friend man', 'friend', 'Friend', 1
UNION ALL SELECT 'Friend woman', 'friend', 'Friend', 1
UNION ALL SELECT 'Girl', 'for-girls', 'For Girls', 1
UNION ALL SELECT 'Girl general', 'for-girls', 'For Girls', 1
UNION ALL SELECT 'Girls', 'for-girls', 'For Girls', 1
UNION ALL SELECT 'Granddaughter', 'granddaughter', 'Granddaughter', 0
UNION ALL SELECT 'Grandfather', 'grandad', 'Grandad', 0
UNION ALL SELECT 'Grandmother', 'granny', 'Granny', 0
UNION ALL SELECT 'Grandparents (Card only)', 'grandparents', 'Grandparents', 1
UNION ALL SELECT 'Grandson', 'grandson', 'Grandson', 0
UNION ALL SELECT 'Men', 'for-him', 'For Him', 1
UNION ALL SELECT 'Men general', 'friend', 'Friend', 1
UNION ALL SELECT 'Mommy to be', 'mum-to-be', 'Mum To Be', 1
UNION ALL SELECT 'Mother', 'mum', 'Mum', 0
UNION ALL SELECT 'Mothers', 'mum', 'Mum', 0
UNION ALL SELECT 'Nephew', 'nephew', 'Nephew', 1
UNION ALL SELECT 'Neutral', 'nonrelations', 'Non Relations', 0
UNION ALL SELECT 'Neutral Adult', 'nonrelations', 'Non Relations', 0
UNION ALL SELECT 'Neutral Child', 'nonrelations', 'Non Relations', 0
UNION ALL SELECT 'Other half man', 'partner', 'Partner', 1
UNION ALL SELECT 'Other half woman', 'partner', 'Partner', 1
UNION ALL SELECT 'Parents', 'parents', 'Parents', 1
UNION ALL SELECT 'Sister', 'sister', 'Sister', 0
UNION ALL SELECT 'Son', 'son', 'Son', 0
UNION ALL SELECT 'Uncle', 'uncle', 'Uncle', 1
UNION ALL SELECT 'Uniseks', 'uniseks', 'Uniseks', 1
UNION ALL SELECT 'Woman general', 'for-her', 'For Her', 1
UNION ALL SELECT 'Women', 'for-her', 'For Her', 1
UNION ALL SELECT 'Zakelijk1 (cards missions)', 'colleague', 'Colleague', 1

UNION ALL SELECT 'Animal dad', 'animal-dad', 'Animal dad', 1
UNION ALL SELECT 'Animal mom', 'animal-mom', 'Animal mom', 1
UNION ALL SELECT 'Bonus mother', 'bonus-mother', 'Bonus mother', 1
UNION ALL SELECT 'Brand new dad', 'brand-new-dad', 'Brand new dad', 1
UNION ALL SELECT 'Brand new mom', 'brand-new-mom', 'Brand new mom', 1
UNION ALL SELECT 'Godfather', 'godfather', 'Godfather', 1
UNION ALL SELECT 'Godmother', 'godmother', 'Godmother', 1
UNION ALL SELECT 'LHBTIQ+', 'lhbtiqplus', 'LHBTIQ+', 1
UNION ALL SELECT 'Little brother', 'little-brother', 'Little brother', 1
UNION ALL SELECT 'Little daughter', 'little-daughter', 'Little daughter', 1
UNION ALL SELECT 'Little granddaughter', 'little-granddaughter', 'Little granddaughter', 1
UNION ALL SELECT 'Little grandson', 'little-grandson', 'Little grandson', 1
UNION ALL SELECT 'Little nephew', 'little-nephew', 'Little nephew', 1
UNION ALL SELECT 'Little niece', 'little-niece', 'Little niece', 1
UNION ALL SELECT 'Little sister', 'little-sister', 'Little sister', 1
UNION ALL SELECT 'Little son', 'little-son', 'Little son', 1
UNION ALL SELECT 'Niece', 'niece', 'Niece', 1
UNION ALL SELECT 'Twins and Multiple (Birth)', 'twins-and-multiple-birth', 'Twins and Multiple (Birth)', 1

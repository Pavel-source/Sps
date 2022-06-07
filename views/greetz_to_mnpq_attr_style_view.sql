CREATE VIEW greetz_to_mnpq_attr_style_view
AS
-- Chocolate with flowers --> Art > Floral
SELECT 1143749624 AS CategoryID, "art>floral" AS AttributeCode, "Art > Floral" AS AttributeValue, 1 AS Priority
-- Drinks with flowers --> Art > Floral
UNION ALL SELECT 1143746501, "art>floral", "Art > Floral", 1
-- Dry Flowers --> Art > Floral
UNION ALL SELECT 1143750422, "art>floral", "Art > Floral", 1
-- Fall (Flowers --> Art > Floral
UNION ALL SELECT 1143732590, "art>floral", "Art > Floral", 1
-- Flowers and abloom (cards missions) --> Art > Floral
UNION ALL SELECT 1143751184, "art>floral", "Art > Floral", 1
-- Flowers and plants --> Art > Floral
UNION ALL SELECT 800471607, "art>floral", "Art > Floral", 1
-- Flowers and plantsL2 --> Art > Floral
UNION ALL SELECT 726933058, "art>floral", "Art > Floral", 1
-- Flowers with gift --> Art > Floral
UNION ALL SELECT 1143731557, "art>floral", "Art > Floral", 1
-- Flowers with vase --> Art > Floral
UNION ALL SELECT 1143740563, "art>floral", "Art > Floral", 1
-- Flowers3 --> Art > Floral
UNION ALL SELECT 1143727951, "art>floral", "Art > Floral", 1
-- Kerst (flowers) --> Art > Floral
UNION ALL SELECT 1143735354, "art>floral", "Art > Floral", 1
-- Spring (flowers) --> Art > Floral
UNION ALL SELECT 1143731093, "art>floral", "Art > Floral", 1
-- Summer (flowers) --> Art > Floral
UNION ALL SELECT 1143731809, "art>floral", "Art > Floral", 1
-- The power of flower --> Art > Floral
UNION ALL SELECT 1143755115, "art>floral", "Art > Floral", 1
-- With flowers --> Art > Floral
UNION ALL SELECT 1143730770, "art>floral", "Art > Floral", 1
-- Landscape and air (condoleance) --> Art > Landscapes
UNION ALL SELECT 1143730850, "art>landscapes", "Art > Landscapes", 1
-- Modern sparkle --> Design > Modern
UNION ALL SELECT 1143750491, "design>modern", "Design > Modern", 2
-- Retro and vintage --> Design > Retro
UNION ALL SELECT 1143762763, "design>retro", "Design > Retro", 1
-- Mothersday --> From The Kids > From The Kids
UNION ALL SELECT 726331722, "fromthekids>fromthekids", "From The Kids > From The Kids", 1
-- Mothersday thinking of you --> From The Kids > From The Kids
UNION ALL SELECT 1143749471, "fromthekids>fromthekids", "From The Kids > From The Kids", 1
-- Christmas humor --> Humour > Art Cards
UNION ALL SELECT 1143750638, "humour>artcards", "Humour > Art Cards", 1
-- Funny Side Up --> Humour > Art Cards
UNION ALL SELECT 1143764423, "humour>artcards", "Humour > Art Cards", 1
-- Humor (cards missions) --> Humour > Art Cards
UNION ALL SELECT 1143751232, "humour>artcards", "Humour > Art Cards", 1
-- Baby and kids --> Kids > General
UNION ALL SELECT 1143739056, "kids>general", "Kids > General", 1
-- Baby and kids L2 --> Kids > General
UNION ALL SELECT 1143739053, "kids>general", "Kids > General", 1
-- Changeable age kids --> Kids > General
UNION ALL SELECT 1143736089, "kids>general", "Kids > General", 1
-- Kids 6 tot 12 years --> Kids > General
UNION ALL SELECT 742758311, "kids>general", "Kids > General", 1
-- Kids cadeau --> Kids > General
UNION ALL SELECT 1143745743, "kids>general", "Kids > General", 1
-- New Kids --> Kids > General
UNION ALL SELECT 1143766833, "kids>general", "Kids > General", 1
-- Cute --> Sentimental > Cute
UNION ALL SELECT 726295836, "sentimental>cute", "Sentimental > Cute", 2
-- Cards text/poems/quotes typography --> Sentimental > Verse
UNION ALL SELECT 1143765493, "sentimental>verse", "Sentimental > Verse", 2

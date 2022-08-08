-- ########################################################################################
-- # This view creates mapped Greetz categories aligned with the categories in Moonpiq.
-- #
-- ########################################################################################

CREATE OR REPLACE VIEW greetz_to_mnpq_categories_view AS
-- Target Group, Women -->Age, Senior over 65 years old
SELECT 1143750947 AS GreetzCategoryID, 'senior-over-65-years-old' AS MPCategoryKey, 'Age' AS MPParentName, 'alcohol' AS MPTypeCode
-- Target Group, Men -->Age, Adult 25 64 years old
UNION ALL SELECT 1143750956, 'adult-25-64-years-old', 'Age', 'alcohol'
-- Target Group, Women -->Age, Adult 25 64 years old
UNION ALL SELECT 1143750947, 'adult-25-64-years-old', 'Age', 'alcohol'
-- Age, 18 years and older -->Age, Adult 25 64 years old
UNION ALL SELECT 880438645, 'adult-25-64-years-old', 'Age', 'alcohol'
-- Target Group, Men -->Age, Senior over 65 years old
UNION ALL SELECT 1143750956, 'senior-over-65-years-old', 'Age', 'alcohol'
-- Age, 18 years and older -->Age, Senior over 65 years old
UNION ALL SELECT 880438645, 'senior-over-65-years-old', 'Age', 'alcohol'
-- Age, 18 years and older -->Age, Young Adult 18 24 years old
UNION ALL SELECT 880438645, 'young-adult-18-24-years-old', 'Age', 'alcohol'
-- Highlighted, Wijn met eigen etiket -->Alcohol, Champagne Prosecco & Wine
UNION ALL SELECT 1143742496, 'champagne-prosecco-wine', 'Alcohol', 'alcohol'
-- Product Family, Wine package -->Alcohol, Gift Sets Letterbox
UNION ALL SELECT 1143733025, 'alcohol-gift-sets-letterbox', 'Alcohol', 'alcohol'
-- Product Family, Wine -->Alcohol, Champagne Prosecco & Wine
UNION ALL SELECT 899226515, 'champagne-prosecco-wine', 'Alcohol', 'alcohol'
-- Product Family, Wijncocktail -->Alcohol, Other Spirits
UNION ALL SELECT 1143741187, 'other-spirits', 'Alcohol', 'alcohol'
-- Product Family, Whisky -->Alcohol, Whiskey
UNION ALL SELECT 1143738070, 'whiskey', 'Alcohol', 'alcohol'
-- Product Family, Spirits -->Alcohol, Other Spirits
UNION ALL SELECT 1143737164, 'other-spirits', 'Alcohol', 'alcohol'
-- Product Family, Gin -->Alcohol, Gin
UNION ALL SELECT 1143738079, 'gin', 'Alcohol', 'alcohol'
-- Highlighted, Giftbox: Beverage with chocolate -->Alcohol, Gift Sets Letterbox
UNION ALL SELECT 1143747968, 'alcohol-gift-sets-letterbox', 'Alcohol', 'alcohol'
-- Highlighted, Personalised wineboxes -->Alcohol, Champagne Prosecco & Wine
UNION ALL SELECT 1143744696, 'champagne-prosecco-wine', 'Alcohol', 'alcohol'
-- Product Family, Mousserend pakket -->Alcohol, Gift Sets Letterbox
UNION ALL SELECT 1143733129, 'alcohol-gift-sets-letterbox', 'Alcohol', 'alcohol'
-- Product Family, Magnum wijnfles -->Alcohol, Champagne Prosecco & Wine
UNION ALL SELECT 1143742013, 'champagne-prosecco-wine', 'Alcohol', 'alcohol'
-- Product Family, Magnum -->Alcohol, Champagne Prosecco & Wine
UNION ALL SELECT 1143747428, 'champagne-prosecco-wine', 'Alcohol', 'alcohol'
-- Product Family, Beer -->Alcohol, Beer & Cider
UNION ALL SELECT 784098536, 'beer-cider', 'Alcohol', 'alcohol'
-- Product Family, Jenever -->Alcohol, Other Spirits
UNION ALL SELECT 1143738076, 'other-spirits', 'Alcohol', 'alcohol'
-- Product Family, Beer package -->Alcohol, Beer & Cider
UNION ALL SELECT 1143731725, 'beer-cider', 'Alcohol', 'alcohol'
-- Product Family, Cognac -->Alcohol, Other Spirits
UNION ALL SELECT 1143749675, 'other-spirits', 'Alcohol', 'alcohol'
-- Product Family, Borrelpakketten -->Alcohol, Gift Sets Letterbox
UNION ALL SELECT 1143764328, 'alcohol-gift-sets-letterbox', 'Alcohol', 'alcohol'
-- Highlighted, OTS Wines -->Alcohol, Champagne Prosecco & Wine
UNION ALL SELECT 1143748139, 'champagne-prosecco-wine', 'Alcohol', 'alcohol'
-- Product Family, Rum -->Alcohol, Other Spirits
UNION ALL SELECT 1143738082, 'other-spirits', 'Alcohol', 'alcohol'
-- Product Family, Blond beer -->Beer & Cider, Lager
UNION ALL SELECT 1143732235, 'lager', 'Beer & Cider', 'alcohol'
-- Product Family, Brown beer -->Beer & Cider, Bitter
UNION ALL SELECT 1143732238, 'bitter', 'Beer & Cider', 'alcohol'
-- Brand/Designer, Maria Casanovas -->Brands, Maria Casanovas
UNION ALL SELECT 1143751811, 'maria-casanovas', 'Brands', 'alcohol'
-- Brand/Designer, Duc de la For괠-->Brands, Duc de la For괍
UNION ALL SELECT 1143751808, 'duc-de-la-foret', 'Brands', 'alcohol'
-- Brand/Designer, Duvel -->Brands, Duvel
UNION ALL SELECT 1143736021, 'duvel', 'Brands', 'alcohol'
-- Brand/Designer, Greetz -->Brands, Greetz
UNION ALL SELECT 726316072, 'greetz', 'Brands', 'alcohol'
-- Brand/Designer, Hertog Jan -->Brands, Hertog Jan
UNION ALL SELECT 1143737074, 'hertog-jan', 'Brands', 'alcohol'
-- Brand/Designer, Il Miogusto -->Brands, Il Miogusto
UNION ALL SELECT 1143747145, 'il-miogusto', 'Brands', 'alcohol'
-- Brand/Designer, Kompaan -->Brands, Kompaan
UNION ALL SELECT 1143765563, 'kompaan', 'Brands', 'alcohol'
-- Brand/Designer, La Chouffe -->Brands, La Chouffe
UNION ALL SELECT 1143730644, 'la-chouffe', 'Brands', 'alcohol'
-- Brand/Designer, Licor 43 -->Brands, Licor 43
UNION ALL SELECT 1143741208, 'licor-43', 'Brands', 'alcohol'
-- Brand/Designer, Maluni -->Brands, Maluni
UNION ALL SELECT 1143747142, 'maluni', 'Brands', 'alcohol'
-- Brand/Designer, Brouwerij 't IJ -->Brands, Brouwerij 't IJ
UNION ALL SELECT 1143741992, 'brouwerij-t-ij', 'Brands', 'alcohol'
-- Brand/Designer, St. Bernardus -->Brands, St. Bernardus
UNION ALL SELECT 1143747266, 'st-bernardus', 'Brands', 'alcohol'
-- Brand/Designer, Mo봠en Chandon -->Brands, Mo봠en Chandon
UNION ALL SELECT 1143732743, 'moet-en-chandon', 'Brands', 'alcohol'
-- Brand/Designer, Oedipus -->Brands, Oedipus
UNION ALL SELECT 1143747602, 'oedipus', 'Brands', 'alcohol'
-- Brand/Designer, Pineut -->Brands, Pineut
UNION ALL SELECT 1143761123, 'pineut', 'Brands', 'alcohol'
-- Brand/Designer, Bols -->Brands, Bols
UNION ALL SELECT 1143767868, 'bols', 'Brands', 'alcohol'
-- Brand/Designer, Villa Massa -->Brands, Villa Massa
UNION ALL SELECT 1143741202, 'villa-massa', 'Brands', 'alcohol'
-- Brand/Designer, Piper Heidsieck -->Brands, Piper Heidsieck
UNION ALL SELECT 1143732777, 'piper-heidsieck', 'Brands', 'alcohol'
-- Brand/Designer, The Flavour Company -->Brands, The Flavour Company
UNION ALL SELECT 1143750139, 'the-flavour-company', 'Brands', 'alcohol'
-- Brand/Designer, Tubes -->Brands, Tubes
UNION ALL SELECT 1143745881, 'tubes', 'Brands', 'alcohol'
-- Brand/Designer, Lolea -->Brands, Lolea
UNION ALL SELECT 1143767863, 'lolea', 'Brands', 'alcohol'
-- Product Family, Prosecco -->Champagne Prosecco & Wine, Prosecco
UNION ALL SELECT 1143732226, 'prosecco', 'Champagne Prosecco & Wine', 'alcohol'
-- Product Family, White wine -->Champagne Prosecco & Wine, White wine
UNION ALL SELECT 784100994, 'white-wine', 'Champagne Prosecco & Wine', 'alcohol'
-- Product Family, Sparkling wine -->Champagne Prosecco & Wine, Sparkling Wine
UNION ALL SELECT 1143747022, 'sparkling-wine', 'Champagne Prosecco & Wine', 'alcohol'
-- Product Family, Rose wine -->Champagne Prosecco & Wine, Rose wine
UNION ALL SELECT 784102414, 'rose-wine', 'Champagne Prosecco & Wine', 'alcohol'
-- Product Family, Red wine -->Champagne Prosecco & Wine, Red wine
UNION ALL SELECT 784103211, 'red-wine', 'Champagne Prosecco & Wine', 'alcohol'
-- Product Family, Cava -->Champagne Prosecco & Wine, Sparkling Wine
UNION ALL SELECT 1143732232, 'sparkling-wine', 'Champagne Prosecco & Wine', 'alcohol'
-- Product Family, Port -->Champagne Prosecco & Wine, Port & Sherry
UNION ALL SELECT 1143731156, 'port-sherry', 'Champagne Prosecco & Wine', 'alcohol'
-- Product Family, Champaign and bubbles -->Champagne Prosecco & Wine, Champagne
UNION ALL SELECT 1143727957, 'champagne', 'Champagne Prosecco & Wine', 'alcohol'
-- Product Family, Champagne -->Champagne Prosecco & Wine, Champagne
UNION ALL SELECT 1143732229, 'champagne', 'Champagne Prosecco & Wine', 'alcohol'
-- Highlighted, Giftbox: Beverage with chocolate -->Food & Drink, Chocolate
UNION ALL SELECT 1143747968, 'chocolate', 'Food & Drink', 'alcohol'
-- Type, Giftset -->Gift Sets Hampers Letterbox, Gift Sets
UNION ALL SELECT 1143739698, 'gift-sets-hampers-letterbox-gift-sets', 'Gift Sets Hampers Letterbox', 'alcohol'
-- Product Family, Likeur -->Gin, Gin Liqueurs
UNION ALL SELECT 1143738067, 'gin-liqueurs', 'Gin', 'alcohol'
-- Highlighted, Wijn met eigen etiket -->NewIa, Personalised Gifts
UNION ALL SELECT 1143742496, 'personalised-gifts', 'NewIa', 'alcohol'
-- Product Family, Eating and drinkingl2 -->NewIa, Food & Drink
UNION ALL SELECT 726930780, 'food-drink', 'NewIa', 'alcohol'
-- Product Family, Big bottles -->NewIa, Alcohol
UNION ALL SELECT 1143738085, 'alcohol', 'NewIa', 'alcohol'
-- Product Family, Drinks -->NewIa, Food & Drink
UNION ALL SELECT 1143727296, 'food-drink', 'NewIa', 'alcohol'
-- Highlighted, Giftbox: Beverage with chocolate -->NewIa, Gift Sets Hampers Letterbox
UNION ALL SELECT 1143747968, 'newia-gift-sets-hampers-letterbox', 'NewIa', 'alcohol'
-- Type, Photo and text gifts -->NewIa, Personalised Gifts
UNION ALL SELECT 1143735781, 'personalised-gifts', 'NewIa', 'alcohol'
-- Type, Tasting -->NewIa, Food & Drink
UNION ALL SELECT 1143741766, 'food-drink', 'NewIa', 'alcohol'
-- Highlighted, personalised wrapping -->NewIa, Personalised Gifts
UNION ALL SELECT 1143743139, 'personalised-gifts', 'NewIa', 'alcohol'
-- Product Family, Gifts -->NewIa, Personalised Gifts
UNION ALL SELECT 727212959, 'personalised-gifts', 'NewIa', 'alcohol'
-- Occasion, Sorry -->Occasion, Sorry
UNION ALL SELECT 726966325, 'occasion-sorry', 'Occasion', 'alcohol'
-- Occasion, Just because -->Occasion, Just to say
UNION ALL SELECT 726347430, 'just-to-say', 'Occasion', 'alcohol'
-- Occasion, Living together -->Occasion, Other
UNION ALL SELECT 1143727835, 'occasion-other', 'Occasion', 'alcohol'
-- Occasion, Love -->Occasion, Other
UNION ALL SELECT 1143727832, 'occasion-other', 'Occasion', 'alcohol'
-- Occasion, Mothersday -->Occasion, Mothers' Day
UNION ALL SELECT 726331722, 'mothers-day', 'Occasion', 'alcohol'
-- Occasion, New home -->Occasion, New Home
UNION ALL SELECT 726342840, 'occasion-new-home', 'Occasion', 'alcohol'
-- Occasion, New Job -->Occasion, New Job
UNION ALL SELECT 735872747, 'occasion-new-job', 'Occasion', 'alcohol'
-- Occasion, NewYear (gifts) -->Occasion, New Year
UNION ALL SELECT 1143732695, 'occasion-new-year', 'Occasion', 'alcohol'
-- Occasion, Opening new business -->Occasion, Well Done
UNION ALL SELECT 1143744579, 'occasion-well-done', 'Occasion', 'alcohol'
-- Occasion, Retirement -->Occasion, Retirement
UNION ALL SELECT 735873966, 'occasion-retirement', 'Occasion', 'alcohol'
-- Occasion, International boss day -->Occasion, Other
UNION ALL SELECT 1143746905, 'occasion-other', 'Occasion', 'alcohol'
-- Occasion, Sinterklaas -->Occasion, Sinterklaas
UNION ALL SELECT 726330911, 'saint-nicholas', 'Occasion', 'alcohol'
-- Occasion, Thank you -->Occasion, Thank You
UNION ALL SELECT 726347103, 'occasion-thank-you', 'Occasion', 'alcohol'
-- Occasion, Spring (flowers) -->Occasion, Other
UNION ALL SELECT 1143731093, 'occasion-other', 'Occasion', 'alcohol'
-- Occasion, Summer (flowers) -->Occasion, Other
UNION ALL SELECT 1143731809, 'occasion-other', 'Occasion', 'alcohol'
-- Occasion, Thank you teacher -->Occasion, Thank You
UNION ALL SELECT 1143742415, 'occasion-thank-you', 'Occasion', 'alcohol'
-- Occasion, Thinking of you -->Occasion, Thinking of you
UNION ALL SELECT 748511930, 'occasion-thinking-of-you', 'Occasion', 'alcohol'
-- Occasion, Vacation -->Occasion, Bon Voyage
UNION ALL SELECT 1143729435, 'occasion-bon-voyage', 'Occasion', 'alcohol'
-- Occasion, Valentine -->Occasion, Valentines' Day
UNION ALL SELECT 726324647, 'valentines-day', 'Occasion', 'alcohol'
-- Occasion, Wedding -->Occasion, Wedding
UNION ALL SELECT 726342081, 'occasion-wedding', 'Occasion', 'alcohol'
-- Occasion, Zakelijke kerstgeschenken -->Occasion, Christmas
UNION ALL SELECT 1143747560, 'occasion-christmas', 'Occasion', 'alcohol'
-- Occasion, Secretaryday -->Occasion, Other
UNION ALL SELECT 1143731240, 'occasion-other', 'Occasion', 'alcohol'
-- Occasion, Congratulations (card and gift) -->Occasion, Congratulations
UNION ALL SELECT 1143729948, 'occasion-congratulations', 'Occasion', 'alcohol'
-- Occasion, Thanks teacher -->Occasion, Thank You
UNION ALL SELECT 1143757148, 'occasion-thank-you', 'Occasion', 'alcohol'
-- Occasion, Goodbye colleague -->Occasion, Goodbye
UNION ALL SELECT 1143736110, 'goodbye', 'Occasion', 'alcohol'
-- Occasion, AOC think -->Occasion, Thinking of you
UNION ALL SELECT 1143742160, 'occasion-thinking-of-you', 'Occasion', 'alcohol'
-- Occasion, Brother and Sister day -->Occasion, Other
UNION ALL SELECT 1143732527, 'occasion-other', 'Occasion', 'alcohol'
-- Occasion, Anniversary -->Occasion, Anniversaries
UNION ALL SELECT 1143740082, 'anniversaries', 'Occasion', 'alcohol'
-- Occasion, Easter/Pasen -->Occasion, Easter
UNION ALL SELECT 726343205, 'occasion-easter', 'Occasion', 'alcohol'
-- Occasion, Failed -->Occasion, Empathy
UNION ALL SELECT 748506030, 'empathy', 'Occasion', 'alcohol'
-- Occasion, Fathersday -->Occasion, Father's Day
UNION ALL SELECT 726332069, 'fathers-day', 'Occasion', 'alcohol'
-- Occasion, Friendship2 -->Occasion, Friendship
UNION ALL SELECT 893069562, 'occasion-friendship', 'Occasion', 'alcohol'
-- Occasion, Get well -->Occasion, Get Well
UNION ALL SELECT 726345521, 'occasion-get-well', 'Occasion', 'alcohol'
-- Occasion, Good luck -->Occasion, Good Luck
UNION ALL SELECT 726345736, 'occasion-good-luck', 'Occasion', 'alcohol'
-- Occasion, Birthday -->Occasion, Birthday
UNION ALL SELECT 726324105, 'occasion-birthday', 'Occasion', 'alcohol'
-- Target Group, Sister -->Who's it for?, Sister
UNION ALL SELECT 1143742574, 'whos-it-for-sister', 'Who''s it for?', 'alcohol'
-- Target Group, Zakelijk1 (cards missions) -->Who's it For?, Colleague
UNION ALL SELECT 1143732725, 'colleague', 'Who''s it For?', 'alcohol'
-- Target Group, Colleague -->Who's it for?, Colleague
UNION ALL SELECT 1143742085, 'colleague', 'Who''s it for?', 'alcohol'
-- Occasion, Zakelijke kerstgeschenken -->Who's it for?, Colleague
UNION ALL SELECT 1143747560, 'colleague', 'Who''s it for?', 'alcohol'
-- Target Group, Men -->Who's it for?, For Him
UNION ALL SELECT 1143750956, 'for-him', 'Who''s it for?', 'alcohol'
-- Target Group, Women -->Who's it for?, For Her
UNION ALL SELECT 1143750947, 'for-her', 'Who''s it for?', 'alcohol'
-- Age, Kids 6 tot 12 years -->Age, Tween 9 12 years old
UNION ALL SELECT 742758311, 'tween-9-12-years-old', 'Age', 'balloon'
-- Age, Kleuter 4 to 6 years -->Age, Kids 2 5 years old
UNION ALL SELECT 742755895, 'kids-2-5-years-old', 'Age', 'balloon'
-- Age, Jongeren 12 to 18 years -->Age, Teen 13 17 years old
UNION ALL SELECT 748494248, 'teen-13-17-years-old', 'Age', 'balloon'
-- Age, Dreumes 1 to 2 years -->Age, Baby 0 1 years old
UNION ALL SELECT 880444402, 'baby-0-1-years-old', 'Age', 'balloon'
-- Age, Peuter 2 to 4 years -->Age, Kids 2 5 years old
UNION ALL SELECT 742755383, 'kids-2-5-years-old', 'Age', 'balloon'
-- Age, 18 years and older -->Age, Senior over 65 years old
UNION ALL SELECT 880438645, 'senior-over-65-years-old', 'Age', 'balloon'
-- Target Group, Women -->Age, Senior over 65 years old
UNION ALL SELECT 1143750947, 'senior-over-65-years-old', 'Age', 'balloon'
-- Target Group, Women -->Age, Adult 25 64 years old
UNION ALL SELECT 1143750947, 'adult-25-64-years-old', 'Age', 'balloon'
-- Target Group, Men -->Age, Senior over 65 years old
UNION ALL SELECT 1143750956, 'senior-over-65-years-old', 'Age', 'balloon'
-- Target Group, Men -->Age, Adult 25 64 years old
UNION ALL SELECT 1143750956, 'adult-25-64-years-old', 'Age', 'balloon'
-- Age, 18 years and older -->Age, Young Adult 18 24 years old
UNION ALL SELECT 880438645, 'young-adult-18-24-years-old', 'Age', 'balloon'
-- Age, Kids 6 tot 12 years -->Age, Kids 6 9 years old
UNION ALL SELECT 742758311, 'kids-6-9-years-old', 'Age', 'balloon'
-- Age, Baby 0 tot 1 year -->Age, Baby 0 1 years old
UNION ALL SELECT 880440481, 'baby-0-1-years-old', 'Age', 'balloon'
-- Age, 18 years and older -->Age, Adult 25 64 years old
UNION ALL SELECT 880438645, 'adult-25-64-years-old', 'Age', 'balloon'
-- Product Family, Number balloons -->Balloons, Number Balloons
UNION ALL SELECT 1081751054, 'number-balloons', 'Balloons', 'balloon'
-- Product Family, XXL balloons -->Balloons, Giant Balloons
UNION ALL SELECT 1143735432, 'giant-balloons', 'Balloons', 'balloon'
-- Product Family, Balloon bouquets -->Balloons, Balloons Bouquets
UNION ALL SELECT 1143734369, 'balloons-bouquets', 'Balloons', 'balloon'
-- Brand/Designer, Paw Patrol -->Balloons, Branded Balloons
UNION ALL SELECT 1143741767, 'branded-balloons', 'Balloons', 'balloon'
-- Brand/Designer, Greetz -->Brands, Greetz
UNION ALL SELECT 726316072, 'greetz', 'Brands', 'balloon'
-- Brand/Designer, Paw Patrol -->Brands, Paw Patrol
UNION ALL SELECT 1143741767, 'brands-paw-patrol', 'Brands', 'balloon'
-- Color, Gold -->Colour, Coloured
UNION ALL SELECT 1143728161, 'coloured', 'Colour', 'balloon'
-- Color, Black -->Colour, Black
UNION ALL SELECT 1143728198, 'black', 'Colour', 'balloon'
-- Color, Blue -->Colour, Blue
UNION ALL SELECT 1143728186, 'colour-blue', 'Colour', 'balloon'
-- Color, PaleTurquoise -->Colour, Blue
UNION ALL SELECT 1143728180, 'colour-blue', 'Colour', 'balloon'
-- Color, Brown -->Colour, Coloured
UNION ALL SELECT 727095669, 'coloured', 'Colour', 'balloon'
-- Color, DeepSkyBlue -->Colour, Blue
UNION ALL SELECT 1143728183, 'colour-blue', 'Colour', 'balloon'
-- Color, Gray -->Colour, Coloured
UNION ALL SELECT 727096150, 'coloured', 'Colour', 'balloon'
-- Color, Hibiscus -->Colour, Coloured
UNION ALL SELECT 1143738552, 'coloured', 'Colour', 'balloon'
-- Color, HotPink -->Colour, Pink
UNION ALL SELECT 1143728149, 'pink', 'Colour', 'balloon'
-- Color, LightSkyBlue -->Colour, Blue
UNION ALL SELECT 1143728182, 'colour-blue', 'Colour', 'balloon'
-- Color, Mix of colors -->Colour, Multicolour
UNION ALL SELECT 729235298, 'multicolour', 'Colour', 'balloon'
-- Color, Pink -->Colour, Pink
UNION ALL SELECT 1143728148, 'pink', 'Colour', 'balloon'
-- Color, Raffia -->Colour, Coloured
UNION ALL SELECT 1143738555, 'coloured', 'Colour', 'balloon'
-- Color, Red -->Colour, Coloured
UNION ALL SELECT 1143728144, 'coloured', 'Colour', 'balloon'
-- Color, White -->Colour, White
UNION ALL SELECT 1143728193, 'colour-white', 'Colour', 'balloon'
-- Color, Yellow -->Colour, Coloured
UNION ALL SELECT 1143728162, 'coloured', 'Colour', 'balloon'
-- Color, MidnightBlue -->Colour, Blue
UNION ALL SELECT 1143728187, 'colour-blue', 'Colour', 'balloon'
-- Product Family, Balloons -->NewIa, Balloons
UNION ALL SELECT 726962862, 'newia-balloons', 'NewIa', 'balloon'
-- Product Family, Gifts -->NewIa, Personalised Gifts
UNION ALL SELECT 727212959, 'personalised-gifts', 'NewIa', 'balloon'
-- Product Family, BalloonsL2 -->NewIa, Balloons
UNION ALL SELECT 855728876, 'newia-balloons', 'NewIa', 'balloon'
-- Product Family, Animal balloons -->NewIa, Balloons
UNION ALL SELECT 1133689324, 'newia-balloons', 'NewIa', 'balloon'
-- Product Family, Foil balloons -->NewIa, Balloons
UNION ALL SELECT 1143732506, 'newia-balloons', 'NewIa', 'balloon'
-- Occasion, Zakelijke kerstgeschenken -->Occasion, Christmas
UNION ALL SELECT 1143747560, 'occasion-christmas', 'Occasion', 'balloon'
-- Occasion, Registered partnership -->Occasion, Other
UNION ALL SELECT 1143754619, 'occasion-other', 'Occasion', 'balloon'
-- Occasion, Secretaryday -->Occasion, Other
UNION ALL SELECT 1143731240, 'occasion-other', 'Occasion', 'balloon'
-- Occasion, Thanks teacher -->Occasion, Thank You
UNION ALL SELECT 1143757148, 'occasion-thank-you', 'Occasion', 'balloon'
-- Occasion, Sinterklaas -->Occasion, Sinterklaas
UNION ALL SELECT 726330911, 'saint-nicholas', 'Occasion', 'balloon'
-- Occasion, Sorry -->Occasion, Sorry
UNION ALL SELECT 726966325, 'occasion-sorry', 'Occasion', 'balloon'
-- Occasion, Thank you -->Occasion, Thank You
UNION ALL SELECT 726347103, 'occasion-thank-you', 'Occasion', 'balloon'
-- Occasion, Wedding -->Occasion, Wedding
UNION ALL SELECT 726342081, 'occasion-wedding', 'Occasion', 'balloon'
-- Occasion, Thinking of you -->Occasion, Thinking of you
UNION ALL SELECT 748511930, 'occasion-thinking-of-you', 'Occasion', 'balloon'
-- Occasion, Thank you teacher -->Occasion, Thank You
UNION ALL SELECT 1143742415, 'occasion-thank-you', 'Occasion', 'balloon'
-- Occasion, Just because -->Occasion, Just to say
UNION ALL SELECT 726347430, 'just-to-say', 'Occasion', 'balloon'
-- Occasion, Valentine -->Occasion, Valentines' Day
UNION ALL SELECT 726324647, 'valentines-day', 'Occasion', 'balloon'
-- Occasion, Pregnant -->Occasion, Pregnancy
UNION ALL SELECT 726344253, 'occasion-pregnancy', 'Occasion', 'balloon'
-- Occasion, Wedding Anniversary -->Occasion, Anniversaries
UNION ALL SELECT 735870898, 'anniversaries', 'Occasion', 'balloon'
-- Occasion, Swimming diploma -->Occasion, Well Done
UNION ALL SELECT 1143742376, 'occasion-well-done', 'Occasion', 'balloon'
-- Occasion, Babyshower -->Occasion, Baby Shower
UNION ALL SELECT 1143739143, 'baby-shower', 'Occasion', 'balloon'
-- Occasion, Failed -->Occasion, Other
UNION ALL SELECT 748506030, 'occasion-other', 'Occasion', 'balloon'
-- Occasion, Friendship2 -->Occasion, Friendship
UNION ALL SELECT 893069562, 'occasion-friendship', 'Occasion', 'balloon'
-- Occasion, Engaged -->Occasion, Engagement
UNION ALL SELECT 735870409, 'occasion-engagement', 'Occasion', 'balloon'
-- Occasion, Congratulations (card and gift) -->Occasion, Congratulations
UNION ALL SELECT 1143729948, 'occasion-congratulations', 'Occasion', 'balloon'
-- Occasion, Christmas -->Occasion, Christmas
UNION ALL SELECT 726331358, 'occasion-christmas', 'Occasion', 'balloon'
-- Occasion, Brother and Sister day -->Occasion, Other
UNION ALL SELECT 1143732527, 'occasion-other', 'Occasion', 'balloon'
-- Occasion, Birthday -->Occasion, Birthday
UNION ALL SELECT 726324105, 'occasion-birthday', 'Occasion', 'balloon'
-- Occasion, Birth visite -->Occasion, New Baby
UNION ALL SELECT 1143739134, 'occasion-new-baby', 'Occasion', 'balloon'
-- Occasion, Birth -->Occasion, New Baby
UNION ALL SELECT 726324202, 'occasion-new-baby', 'Occasion', 'balloon'
-- Occasion, Fathersday -->Occasion, Father's Day
UNION ALL SELECT 726332069, 'fathers-day', 'Occasion', 'balloon'
-- Occasion, Babyshower -->Occasion, Baby Shower
UNION ALL SELECT 1143739143, 'baby-shower', 'Occasion', 'balloon'
-- Occasion, Babyshower -->Occasion, Baby Shower
UNION ALL SELECT 1143739143, 'baby-shower', 'Occasion', 'balloon'
-- Occasion, Graduation -->Occasion, Graduation
UNION ALL SELECT 1143729906, 'occasion-graduation', 'Occasion', 'balloon'
-- Occasion, New Job -->Occasion, New Job
UNION ALL SELECT 735872747, 'occasion-new-job', 'Occasion', 'balloon'
-- Occasion, New home -->Occasion, New Home
UNION ALL SELECT 726342840, 'occasion-new-home', 'Occasion', 'balloon'
-- Occasion, Mothersday -->Occasion, Mothers' Day
UNION ALL SELECT 726331722, 'mothers-day', 'Occasion', 'balloon'
-- Occasion, Get well -->Occasion, Get Well
UNION ALL SELECT 726345521, 'occasion-get-well', 'Occasion', 'balloon'
-- Occasion, Babyshower -->Occasion, Baby Shower
UNION ALL SELECT 1143739143, 'baby-shower', 'Occasion', 'balloon'
-- Occasion, Good luck -->Occasion, Good Luck
UNION ALL SELECT 726345736, 'occasion-good-luck', 'Occasion', 'balloon'
-- Occasion, Love -->Occasion, Other
UNION ALL SELECT 1143727832, 'occasion-other', 'Occasion', 'balloon'
-- Occasion, NewYear (gifts) -->Occasion, New Year
UNION ALL SELECT 1143732695, 'occasion-new-year', 'Occasion', 'balloon'
-- Occasion, Anniversary -->Occasion, Anniversaries
UNION ALL SELECT 1143740082, 'anniversaries', 'Occasion', 'balloon'
-- Occasion, AOC think -->Occasion, Thinking of you
UNION ALL SELECT 1143742160, 'occasion-thinking-of-you', 'Occasion', 'balloon'
-- Occasion, Just Married -->Occasion, Wedding
UNION ALL SELECT 1143732220, 'occasion-wedding', 'Occasion', 'balloon'
-- Occasion, Gay marriage -->Sentiment & Style, LGBTQ+
UNION ALL SELECT 1143732593, 'lgbtq', 'Sentiment & Style', 'balloon'
-- Occasion, Gay marriage -->Who's it for?, LGBTQ+
UNION ALL SELECT 1143732593, 'whos-it-for-lgbtq', 'Who''s it for?', 'balloon'
-- Target Group, Zakelijk1 (cards missions) -->Who's it For?, Colleague
UNION ALL SELECT 1143732725, 'colleague', 'Who''s it For?', 'balloon'
-- Target Group, Women -->Who's it for?, For Her
UNION ALL SELECT 1143750947, 'for-her', 'Who''s it for?', 'balloon'
-- Target Group, Boy -->Who's it for?, For Boys
UNION ALL SELECT 886506339, 'for-boys', 'Who''s it for?', 'balloon'
-- Occasion, Zakelijke kerstgeschenken -->Who's it for?, Colleague
UNION ALL SELECT 1143747560, 'colleague', 'Who''s it for?', 'balloon'
-- Target Group, Men -->Who's it for?, For Him
UNION ALL SELECT 1143750956, 'for-him', 'Who''s it for?', 'balloon'
-- Target Group, Brother -->Who's it for?, Brother
UNION ALL SELECT 1143742571, 'whos-it-for-brother', 'Who''s it for?', 'balloon'
-- Target Group, Girl -->Who's it for?, For Girls
UNION ALL SELECT 886507052, 'for-girls', 'Who''s it for?', 'balloon'
-- Target Group, Sister -->Who's it for?, Sister
UNION ALL SELECT 1143742574, 'whos-it-for-sister', 'Who''s it for?', 'balloon'
-- Target Group, Men -->Age, Adult 25 64 years old
UNION ALL SELECT 1143750956, 'adult-25-64-years-old', 'Age', 'beauty'
-- Target Group, Men -->Age, Senior over 65 years old
UNION ALL SELECT 1143750956, 'senior-over-65-years-old', 'Age', 'beauty'
-- Target Group, Women -->Age, Adult 25 64 years old
UNION ALL SELECT 1143750947, 'adult-25-64-years-old', 'Age', 'beauty'
-- Age, Jongeren 12 to 18 years -->Age, Teen 13 17 years old
UNION ALL SELECT 748494248, 'teen-13-17-years-old', 'Age', 'beauty'
-- Age, 18 years and older -->Age, Young Adult 18 24 years old
UNION ALL SELECT 880438645, 'young-adult-18-24-years-old', 'Age', 'beauty'
-- Age, 18 years and older -->Age, Senior over 65 years old
UNION ALL SELECT 880438645, 'senior-over-65-years-old', 'Age', 'beauty'
-- Age, 18 years and older -->Age, Adult 25 64 years old
UNION ALL SELECT 880438645, 'adult-25-64-years-old', 'Age', 'beauty'
-- Target Group, Women -->Age, Senior over 65 years old
UNION ALL SELECT 1143750947, 'senior-over-65-years-old', 'Age', 'beauty'
-- Brand/Designer, The Gift Label -->Beauty, Face & Body>Brands, The Gift Label
UNION ALL SELECT 1143744837, 'the-gift-label', 'Beauty, Face & Body>Brands', 'beauty'
-- Brand/Designer, Chopard -->Brands, Chopard
UNION ALL SELECT 1143768363, 'chopard', 'Brands', 'beauty'
-- Brand/Designer, Source Balance -->Brands, Source Balance
UNION ALL SELECT 1143767928, 'source-balance', 'Brands', 'beauty'
-- Brand/Designer, Kocostar -->Brands, Kocostar
UNION ALL SELECT 1143747178, 'kocostar', 'Brands', 'beauty'
-- Brand/Designer, Riverdale -->Brands, Riverdale
UNION ALL SELECT 1143755877, 'brands-riverdale', 'Brands', 'beauty'
-- Brand/Designer, Naif -->Brands, Naif
UNION ALL SELECT 1143739110, 'naif', 'Brands', 'beauty'
-- Brand/Designer, My Jewellery -->Brands, My Jewellery
UNION ALL SELECT 1143766933, 'my-jewellery', 'Brands', 'beauty'
-- Brand/Designer, Cacharel -->Brands, Cacharel
UNION ALL SELECT 1143768358, 'cacharel', 'Brands', 'beauty'
-- Brand/Designer, Joop! -->Brands, Joop!
UNION ALL SELECT 1143768373, 'joop', 'Brands', 'beauty'
-- Brand/Designer, Janzen -->Brands, Janzen
UNION ALL SELECT 1143756595, 'janzen', 'Brands', 'beauty'
-- Brand/Designer, Hugo Boss -->Brands, Hugo Boss
UNION ALL SELECT 1143768343, 'hugo-boss', 'Brands', 'beauty'
-- Brand/Designer, HappySoaps -->Brands, HappySoaps
UNION ALL SELECT 1143769283, 'happysoaps', 'Brands', 'beauty'
-- Brand/Designer, Davidoff -->Brands, Davidoff
UNION ALL SELECT 1143768368, 'davidoff', 'Brands', 'beauty'
-- Brand/Designer, Casuelle -->Brands, Casuelle
UNION ALL SELECT 1143767893, 'casuelle', 'Brands', 'beauty'
-- Brand/Designer, Calvin Klein -->Brands, Calvin Klein
UNION ALL SELECT 1143768348, 'calvin-klein', 'Brands', 'beauty'
-- Brand/Designer, Dolce and Gabbana -->Brands, Dolce and Gabbana
UNION ALL SELECT 1143768353, 'dolce-and-gabbana', 'Brands', 'beauty'
-- Brand/Designer, Kneipp -->Brands, Kneipp
UNION ALL SELECT 1143733099, 'kneipp', 'Brands', 'beauty'
-- Brand/Designer, 100 procent Leuk -->Brands, 100 procent Leuk
UNION ALL SELECT 1143748292, '100-procent-leuk', 'Brands', 'beauty'
-- Product Family, Giftsets -->Gift Sets Hampers Letterbox, Gift Sets
UNION ALL SELECT 1143751673, 'gift-sets-hampers-letterbox-gift-sets', 'Gift Sets Hampers Letterbox', 'beauty'
-- Type, Letterbox gifts -->Gift Sets Hampers Letterbox, Letterbox
UNION ALL SELECT 1143737611, 'gift-sets-hampers-letterbox-letterbox', 'Gift Sets Hampers Letterbox', 'beauty'
-- Type, Giftset -->Gift Sets Hampers Letterbox, Gift Sets
UNION ALL SELECT 1143739698, 'gift-sets-hampers-letterbox-gift-sets', 'Gift Sets Hampers Letterbox', 'beauty'
-- Product Family, Candles -->Home & Garden, Fragrance & Candles
UNION ALL SELECT 1143744900, 'fragrance-candles', 'Home & Garden', 'beauty'
-- Product Family, Fragrance sticks -->Home & Garden, Fragrance & Candles
UNION ALL SELECT 1143742439, 'fragrance-candles', 'Home & Garden', 'beauty'
-- Product Family, Living -->Home & Garden, Home Accessories
UNION ALL SELECT 1143766938, 'home-garden-home-accessories', 'Home & Garden', 'beauty'
-- Product Family, Living -->Home & Garden, Home Accessories
UNION ALL SELECT 1143766938, 'home-accessories', 'Home & Garden', 'beauty'
-- Product Family, Roomspray -->Home & Garden, Fragrance & Candles
UNION ALL SELECT 1143755889, 'fragrance-candles', 'Home & Garden', 'beauty'
-- Product Family, Body cream -->NewIa, Beauty Face & Body
UNION ALL SELECT 1143746896, 'beauty-face-body', 'NewIa', 'beauty'
-- Product Family, Make up -->NewIa, Beauty Face & Body
UNION ALL SELECT 1143767268, 'beauty-face-body', 'NewIa', 'beauty'
-- Product Family, Beauty and careL2 -->NewIa, Beauty Face & Body
UNION ALL SELECT 726960191, 'beauty-face-body', 'NewIa', 'beauty'
-- Product Family, Parfum -->NewIa, Beauty Face & Body
UNION ALL SELECT 1143767273, 'beauty-face-body', 'NewIa', 'beauty'
-- Product Family, Body lotion -->NewIa, Beauty Face & Body
UNION ALL SELECT 1143744894, 'beauty-face-body', 'NewIa', 'beauty'
-- Product Family, Gifts -->NewIa, Personalised Gifts
UNION ALL SELECT 727212959, 'personalised-gifts', 'NewIa', 'beauty'
-- Product Family, Skincare masks -->NewIa, Beauty Face & Body
UNION ALL SELECT 1143747175, 'beauty-face-body', 'NewIa', 'beauty'
-- Product Family, Handsoap -->NewIa, Beauty Face & Body
UNION ALL SELECT 1143744897, 'beauty-face-body', 'NewIa', 'beauty'
-- Product Family, Shower gel -->NewIa, Beauty Face & Body
UNION ALL SELECT 1143742442, 'beauty-face-body', 'NewIa', 'beauty'
-- Product Family, Beauty -->NewIa, Beauty Face & Body
UNION ALL SELECT 1143727993, 'beauty-face-body', 'NewIa', 'beauty'
-- Occasion, Thank you -->Occasion, Thank You
UNION ALL SELECT 726347103, 'occasion-thank-you', 'Occasion', 'beauty'
-- Occasion, Maternity Leave -->Occasion, Pregnancy
UNION ALL SELECT 1143733399, 'occasion-pregnancy', 'Occasion', 'beauty'
-- Occasion, Zakelijke kerstgeschenken -->Occasion, Christmas
UNION ALL SELECT 1143747560, 'occasion-christmas', 'Occasion', 'beauty'
-- Occasion, Wedding -->Occasion, Wedding
UNION ALL SELECT 726342081, 'occasion-wedding', 'Occasion', 'beauty'
-- Occasion, Valentine -->Occasion, Valentines' Day
UNION ALL SELECT 726324647, 'valentines-day', 'Occasion', 'beauty'
-- Occasion, Vacation welcome home -->Occasion, Welcome Home
UNION ALL SELECT 726965369, 'welcome-home', 'Occasion', 'beauty'
-- Occasion, Vacation -->Occasion, Bon Voyage
UNION ALL SELECT 1143729435, 'occasion-bon-voyage', 'Occasion', 'beauty'
-- Occasion, Travelling -->Occasion, Bon Voyage
UNION ALL SELECT 1143731911, 'occasion-bon-voyage', 'Occasion', 'beauty'
-- Occasion, Thinking of you -->Occasion, Thinking of you
UNION ALL SELECT 748511930, 'occasion-thinking-of-you', 'Occasion', 'beauty'
-- Occasion, Thank you teacher -->Occasion, Thank You
UNION ALL SELECT 1143742415, 'occasion-thank-you', 'Occasion', 'beauty'
-- Occasion, Birth -->Occasion, New Baby
UNION ALL SELECT 726324202, 'occasion-new-baby', 'Occasion', 'beauty'
-- Occasion, Exams (gifts) -->Occasion, Exams
UNION ALL SELECT 726344432, 'occasion-exams', 'Occasion', 'beauty'
-- Occasion, Driving License graduated -->Occasion, Driving Test
UNION ALL SELECT 735934096, 'occasion-driving-test', 'Occasion', 'beauty'
-- Occasion, Congratulations (card and gift) -->Occasion, Congratulations
UNION ALL SELECT 1143729948, 'occasion-congratulations', 'Occasion', 'beauty'
-- Occasion, Condolence -->Occasion, Sympathy
UNION ALL SELECT 726345401, 'occasion-sympathy', 'Occasion', 'beauty'
-- Occasion, Christmas -->Occasion, Christmas
UNION ALL SELECT 726331358, 'occasion-christmas', 'Occasion', 'beauty'
-- Occasion, Fathersday -->Occasion, Father's Day
UNION ALL SELECT 726332069, 'fathers-day', 'Occasion', 'beauty'
-- Occasion, Birthday -->Occasion, Birthday
UNION ALL SELECT 726324105, 'occasion-birthday', 'Occasion', 'beauty'
-- Occasion, Babyshower -->Occasion, Baby Shower
UNION ALL SELECT 1143739143, 'baby-shower', 'Occasion', 'beauty'
-- Occasion, Babyshower -->Occasion, Baby Shower
UNION ALL SELECT 1143739143, 'baby-shower', 'Occasion', 'beauty'
-- Occasion, Babyshower -->Occasion, Baby Shower
UNION ALL SELECT 1143739143, 'baby-shower', 'Occasion', 'beauty'
-- Occasion, Babyshower -->Occasion, Baby Shower
UNION ALL SELECT 1143739143, 'baby-shower', 'Occasion', 'beauty'
-- Occasion, Anniversary -->Occasion, Anniversaries
UNION ALL SELECT 1143740082, 'anniversaries', 'Occasion', 'beauty'
-- Occasion, New home -->Occasion, New Home
UNION ALL SELECT 726342840, 'occasion-new-home', 'Occasion', 'beauty'
-- Occasion, Sorry -->Occasion, Sorry
UNION ALL SELECT 726966325, 'occasion-sorry', 'Occasion', 'beauty'
-- Occasion, Birthday invitation (invitations) -->Occasion, Birthday
UNION ALL SELECT 1143728925, 'occasion-birthday', 'Occasion', 'beauty'
-- Occasion, Mothersday -->Occasion, Mothers' Day
UNION ALL SELECT 726331722, 'mothers-day', 'Occasion', 'beauty'
-- Occasion, Get well -->Occasion, Get Well
UNION ALL SELECT 726345521, 'occasion-get-well', 'Occasion', 'beauty'
-- Occasion, Get well welcome home -->Occasion, Get Well
UNION ALL SELECT 1143742088, 'occasion-get-well', 'Occasion', 'beauty'
-- Occasion, Good luck -->Occasion, Good Luck
UNION ALL SELECT 726345736, 'occasion-good-luck', 'Occasion', 'beauty'
-- Occasion, Goodbye colleague -->Occasion, Leaving
UNION ALL SELECT 1143736110, 'occasion-leaving', 'Occasion', 'beauty'
-- Occasion, Graduated high school -->Occasion, Graduation
UNION ALL SELECT 748505918, 'occasion-graduation', 'Occasion', 'beauty'
-- Occasion, Graduation -->Occasion, Graduation
UNION ALL SELECT 1143729906, 'occasion-graduation', 'Occasion', 'beauty'
-- Occasion, Just because -->Occasion, Just to say
UNION ALL SELECT 726347430, 'just-to-say', 'Occasion', 'beauty'
-- Occasion, Living together -->Occasion, New Home
UNION ALL SELECT 1143727835, 'occasion-new-home', 'Occasion', 'beauty'
-- Occasion, re exam -->Occasion, Exams
UNION ALL SELECT 1143742355, 'occasion-exams', 'Occasion', 'beauty'
-- Occasion, New Job -->Occasion, New Job
UNION ALL SELECT 735872747, 'occasion-new-job', 'Occasion', 'beauty'
-- Occasion, Sinterklaas -->Occasion, Sinterklaas
UNION ALL SELECT 726330911, 'saint-nicholas', 'Occasion', 'beauty'
-- Occasion, Friendship2 -->Occasion, Friendship
UNION ALL SELECT 893069562, 'occasion-friendship', 'Occasion', 'beauty'
-- Occasion, AOC think -->Occasion, Thinking of you
UNION ALL SELECT 1143742160, 'occasion-thinking-of-you', 'Occasion', 'beauty'
-- Occasion, Pregnant -->Occasion, Pregnancy
UNION ALL SELECT 726344253, 'occasion-pregnancy', 'Occasion', 'beauty'
-- Target Group, Women -->Who's it for?, For Her
UNION ALL SELECT 1143750947, 'for-her', 'Who''s it for?', 'beauty'
-- Target Group, Uniseks -->Who's it for?, Other
UNION ALL SELECT 1143739122, 'whos-it-for-other', 'Who''s it for?', 'beauty'
-- Target Group, Men -->Who's it for?, For Him
UNION ALL SELECT 1143750956, 'for-him', 'Who''s it for?', 'beauty'
-- Target Group, Girl -->Who's it for?, For Girls
UNION ALL SELECT 886507052, 'for-girls', 'Who''s it for?', 'beauty'
-- Age, Kleuter 4 to 6 years -->Age, Kids 2 5 years old
UNION ALL SELECT 742755895, 'kids-2-5-years-old', 'Age', 'book'
-- Age, Kids 6 tot 12 years -->Age, Tween 9 12 years old
UNION ALL SELECT 742758311, 'tween-9-12-years-old', 'Age', 'book'
-- Age, Kids 6 tot 12 years -->Age, Kids 6 9 years old
UNION ALL SELECT 742758311, 'kids-6-9-years-old', 'Age', 'book'
-- Age, Peuter 2 to 4 years -->Age, Kids 2 5 years old
UNION ALL SELECT 742755383, 'kids-2-5-years-old', 'Age', 'book'
-- Age, 18 years and older -->Age, Young Adult 18 24 years old
UNION ALL SELECT 880438645, 'young-adult-18-24-years-old', 'Age', 'book'
-- Age, 18 years and older -->Age, Senior over 65 years old
UNION ALL SELECT 880438645, 'senior-over-65-years-old', 'Age', 'book'
-- Age, 18 years and older -->Age, Adult 25 64 years old
UNION ALL SELECT 880438645, 'adult-25-64-years-old', 'Age', 'book'
-- Target Group, Men -->Age, Adult 25 64 years old
UNION ALL SELECT 1143750956, 'adult-25-64-years-old', 'Age', 'book'
-- Target Group, Women -->Age, Adult 25 64 years old
UNION ALL SELECT 1143750947, 'adult-25-64-years-old', 'Age', 'book'
-- Target Group, Men -->Age, Senior over 65 years old
UNION ALL SELECT 1143750956, 'senior-over-65-years-old', 'Age', 'book'
-- Target Group, Women -->Age, Senior over 65 years old
UNION ALL SELECT 1143750947, 'senior-over-65-years-old', 'Age', 'book'
-- Product Family, Pregnancy and birth -->Books & Stationery, For Adults
UNION ALL SELECT 1143743538, 'for-adults', 'Books & Stationery', 'book'
-- Product Family, Cooking books -->Books & Stationery, For Adults
UNION ALL SELECT 808797401, 'for-adults', 'Books & Stationery', 'book'
-- Product Family, Travelbooks -->Books & Stationery, For Adults
UNION ALL SELECT 1143743406, 'for-adults', 'Books & Stationery', 'book'
-- Product Family, Children Books -->Books & Stationery, For Kids
UNION ALL SELECT 808799282, 'for-kids', 'Books & Stationery', 'book'
-- Product Family, Biographies and current affairs -->Books & Stationery, For Adults
UNION ALL SELECT 1143743535, 'for-adults', 'Books & Stationery', 'book'
-- Product Family, Information books -->Books & Stationery, For Adults
UNION ALL SELECT 1143747980, 'for-adults', 'Books & Stationery', 'book'
-- Product Family, Hobby books -->Books & Stationery, For Adults
UNION ALL SELECT 1143743409, 'for-adults', 'Books & Stationery', 'book'
-- Product Family, Do books -->Books & Stationery, For Adults
UNION ALL SELECT 1143744045, 'for-adults', 'Books & Stationery', 'book'
-- Product Family, Other -->Books & Stationery, Other
UNION ALL SELECT 1143747986, 'books-stationery-other', 'Books & Stationery', 'book'
-- Brand/Designer, Hip en Mama Box -->Brands, Hip en Mama Box
UNION ALL SELECT 1143764103, 'hip-en-mama-box', 'Brands', 'book'
-- Brand/Designer, Greetz -->Brands, Greetz
UNION ALL SELECT 726316072, 'greetz', 'Brands', 'book'
-- Type, Letterbox gifts -->Gift Sets Hampers Letterbox, Letterbox
UNION ALL SELECT 1143737611, 'gift-sets-hampers-letterbox-letterbox', 'Gift Sets Hampers Letterbox', 'book'
-- Product Family, Baby and kids -->NewIa, Toys Kids & Baby
UNION ALL SELECT 1143739056, 'toys-kids-baby', 'NewIa', 'book'
-- Occasion, Babyshower (gifts) -->NewIa, Personalised Gifts
UNION ALL SELECT 1143742373, 'personalised-gifts', 'NewIa', 'book'
-- Product Family, Body and mind -->NewIa, Books & Stationery
UNION ALL SELECT 808793556, 'books-stationery', 'NewIa', 'book'
-- Product Family, Books -->NewIa, Books & Stationery
UNION ALL SELECT 735097316, 'books-stationery', 'NewIa', 'book'
-- Product Family, Gifts -->NewIa, Personalised Gifts
UNION ALL SELECT 727212959, 'personalised-gifts', 'NewIa', 'book'
-- Product Family, Books L2 -->NewIa, Books & Stationery
UNION ALL SELECT 726958013, 'books-stationery', 'NewIa', 'book'
-- Product Family, Baby and kids L2 -->NewIa, Toys Kids & Baby
UNION ALL SELECT 1143739053, 'toys-kids-baby', 'NewIa', 'book'
-- Product Family, Notebook and diaries -->NewIa, Books & Stationery
UNION ALL SELECT 1143743565, 'books-stationery', 'NewIa', 'book'
-- Product Family, Books and cards -->NewIa, Books & Stationery
UNION ALL SELECT 1143739215, 'books-stationery', 'NewIa', 'book'
-- Occasion, Valentine -->Occasion, Valentines' Day
UNION ALL SELECT 726324647, 'valentines-day', 'Occasion', 'book'
-- Occasion, Friendship2 -->Occasion, Friendship
UNION ALL SELECT 893069562, 'occasion-friendship', 'Occasion', 'book'
-- Occasion, Fathersday -->Occasion, Father's Day
UNION ALL SELECT 726332069, 'fathers-day', 'Occasion', 'book'
-- Occasion, Engaged -->Occasion, Engagement
UNION ALL SELECT 735870409, 'occasion-engagement', 'Occasion', 'book'
-- Occasion, Congratulations (card and gift) -->Occasion, Congratulations
UNION ALL SELECT 1143729948, 'occasion-congratulations', 'Occasion', 'book'
-- Occasion, Condolence -->Occasion, Sympathy
UNION ALL SELECT 726345401, 'occasion-sympathy', 'Occasion', 'book'
-- Occasion, Christmas -->Occasion, Christmas
UNION ALL SELECT 726331358, 'occasion-christmas', 'Occasion', 'book'
-- Occasion, Babyshower (gifts) -->Occasion, Baby Shower
UNION ALL SELECT 1143742373, 'baby-shower', 'Occasion', 'book'
-- Occasion, Birth visite -->Occasion, New Baby
UNION ALL SELECT 1143739134, 'occasion-new-baby', 'Occasion', 'book'
-- Occasion, Anniversary -->Occasion, Anniversaries
UNION ALL SELECT 1143740082, 'anniversaries', 'Occasion', 'book'
-- Occasion, Birth -->Occasion, New Baby
UNION ALL SELECT 726324202, 'occasion-new-baby', 'Occasion', 'book'
-- Occasion, Babyshower -->Occasion, Baby Shower
UNION ALL SELECT 1143739143, 'baby-shower', 'Occasion', 'book'
-- Occasion, Babyshower -->Occasion, Baby Shower
UNION ALL SELECT 1143739143, 'baby-shower', 'Occasion', 'book'
-- Occasion, Babyshower -->Occasion, Baby Shower
UNION ALL SELECT 1143739143, 'baby-shower', 'Occasion', 'book'
-- Occasion, Babyshower -->Occasion, Baby Shower
UNION ALL SELECT 1143739143, 'baby-shower', 'Occasion', 'book'
-- Occasion, AOC think -->Occasion, Thinking of you
UNION ALL SELECT 1143742160, 'occasion-thinking-of-you', 'Occasion', 'book'
-- Occasion, Birthday -->Occasion, Birthday
UNION ALL SELECT 726324105, 'occasion-birthday', 'Occasion', 'book'
-- Occasion, Pregnant -->Occasion, Pregnancy
UNION ALL SELECT 726344253, 'occasion-pregnancy', 'Occasion', 'book'
-- Occasion, Love -->Occasion, Other
UNION ALL SELECT 1143727832, 'occasion-other', 'Occasion', 'book'
-- Occasion, Maternity Leave -->Occasion, Pregnancy
UNION ALL SELECT 1143733399, 'occasion-pregnancy', 'Occasion', 'book'
-- Occasion, Living together -->Occasion, Other
UNION ALL SELECT 1143727835, 'occasion-other', 'Occasion', 'book'
-- Occasion, Valentine In love -->Occasion, Valentines' Day
UNION ALL SELECT 748508746, 'valentines-day', 'Occasion', 'book'
-- Occasion, Just Married -->Occasion, Wedding
UNION ALL SELECT 1143732220, 'occasion-wedding', 'Occasion', 'book'
-- Occasion, Just because -->Occasion, Just to say
UNION ALL SELECT 726347430, 'just-to-say', 'Occasion', 'book'
-- Occasion, Goodbye colleague -->Occasion, Goodbye
UNION ALL SELECT 1143736110, 'goodbye', 'Occasion', 'book'
-- Occasion, Mothersday -->Occasion, Mothers' Day
UNION ALL SELECT 726331722, 'mothers-day', 'Occasion', 'book'
-- Occasion, Neutral (gifts) -->Occasion, Other
UNION ALL SELECT 1143742553, 'occasion-other', 'Occasion', 'book'
-- Occasion, New home -->Occasion, New Home
UNION ALL SELECT 726342840, 'occasion-new-home', 'Occasion', 'book'
-- Occasion, New Job -->Occasion, New Job
UNION ALL SELECT 735872747, 'occasion-new-job', 'Occasion', 'book'
-- Occasion, Retirement -->Occasion, Retirement
UNION ALL SELECT 735873966, 'occasion-retirement', 'Occasion', 'book'
-- Occasion, Sinterklaas -->Occasion, Sinterklaas
UNION ALL SELECT 726330911, 'saint-nicholas', 'Occasion', 'book'
-- Occasion, Vacation -->Occasion, Bon Voyage
UNION ALL SELECT 1143729435, 'occasion-bon-voyage', 'Occasion', 'book'
-- Occasion, Wedding -->Occasion, Wedding
UNION ALL SELECT 726342081, 'occasion-wedding', 'Occasion', 'book'
-- Occasion, Valentine loving -->Occasion, Valentines' Day
UNION ALL SELECT 748510085, 'valentines-day', 'Occasion', 'book'
-- Occasion, Get well -->Occasion, Get Well
UNION ALL SELECT 726345521, 'occasion-get-well', 'Occasion', 'book'
-- Occasion, Valentine best sold -->Occasion, Valentines' Day
UNION ALL SELECT 1143735065, 'valentines-day', 'Occasion', 'book'
-- Occasion, Zakelijke kerstgeschenken -->Occasion, Christmas
UNION ALL SELECT 1143747560, 'occasion-christmas', 'Occasion', 'book'
-- Occasion, Swimming diploma -->Occasion, Well Done
UNION ALL SELECT 1143742376, 'occasion-well-done', 'Occasion', 'book'
-- Occasion, Wedding Anniversary -->Occasion, Anniversary
UNION ALL SELECT 735870898, 'anniversaries', 'Occasion', 'book'
-- Occasion, Good luck -->Occasion, Good Luck
UNION ALL SELECT 726345736, 'occasion-good-luck', 'Occasion', 'book'
-- Occasion, Travelling -->Occasion, Bon Voyage
UNION ALL SELECT 1143731911, 'occasion-bon-voyage', 'Occasion', 'book'
-- Occasion, Thinking of you -->Occasion, Thinking of you
UNION ALL SELECT 748511930, 'occasion-thinking-of-you', 'Occasion', 'book'
-- Occasion, Thank you -->Occasion, Thank You
UNION ALL SELECT 726347103, 'occasion-thank-you', 'Occasion', 'book'
-- Product Family, Children Books -->Toys Kids & Baby, Books Stationery
UNION ALL SELECT 808799282, 'toys-kids-baby-books-stationery', 'Toys Kids & Baby', 'book'
-- Target Group, Men -->Who's it for?, For Him
UNION ALL SELECT 1143750956, 'for-him', 'Who''s it for?', 'book'
-- Target Group, Women -->Who's it for?, For Her
UNION ALL SELECT 1143750947, 'for-her', 'Who''s it for?', 'book'
-- Target Group, Girl -->Who's it for?, For Girls
UNION ALL SELECT 886507052, 'for-girls', 'Who''s it for?', 'book'
-- Occasion, Zakelijke kerstgeschenken -->Who's it for?, Colleague
UNION ALL SELECT 1143747560, 'colleague', 'Who''s it for?', 'book'
-- Target Group, Boy -->Who's it for?, For Boys
UNION ALL SELECT 886506339, 'for-boys', 'Who''s it for?', 'book'
-- Product Family, Love and friendship -->Who's it for?, Friend
UNION ALL SELECT 1143743544, 'friend', 'Who''s it for?', 'book'
-- Age, 18 years and older -->Age, Senior over 65 years old
UNION ALL SELECT 880438645, 'senior-over-65-years-old', 'Age', 'cake'
-- Target Group, Women -->Age, Adult 25 64 years old
UNION ALL SELECT 1143750947, 'adult-25-64-years-old', 'Age', 'cake'
-- Target Group, Men -->Age, Senior over 65 years old
UNION ALL SELECT 1143750956, 'senior-over-65-years-old', 'Age', 'cake'
-- Target Group, Women -->Age, Senior over 65 years old
UNION ALL SELECT 1143750947, 'senior-over-65-years-old', 'Age', 'cake'
-- Age, 18 years and older -->Age, Young Adult 18 24 years old
UNION ALL SELECT 880438645, 'young-adult-18-24-years-old', 'Age', 'cake'
-- Age, 18 years and older -->Age, Adult 25 64 years old
UNION ALL SELECT 880438645, 'adult-25-64-years-old', 'Age', 'cake'
-- Target Group, Men -->Age, Adult 25 64 years old
UNION ALL SELECT 1143750956, 'adult-25-64-years-old', 'Age', 'cake'
-- Age, Jongeren 12 to 18 years -->Age, Teen 13 17 years old
UNION ALL SELECT 748494248, 'teen-13-17-years-old', 'Age', 'cake'
-- Brand/Designer, Greetz cakes -->Brands, Greetz cakes
UNION ALL SELECT 1143749276, 'greetz-cakes', 'Brands', 'cake'
-- Brand/Designer, Andere Koek voor thuis -->Brands, Andere Koek voor thuis
UNION ALL SELECT 1143741115, 'andere-koek-voor-thuis', 'Brands', 'cake'
-- Brand/Designer, Greetz -->Brands, Greetz
UNION ALL SELECT 726316072, 'greetz', 'Brands', 'cake'
-- Brand/Designer, Pineut -->Brands, Pineut
UNION ALL SELECT 1143761123, 'pineut', 'Brands', 'cake'
-- Cake, Small cake -->Food & Drink, Cakes & Pastry
UNION ALL SELECT 1143736563, 'cakes-pastry', 'Food & Drink', 'cake'
-- Theme, Luxe cakes -->Food & Drink, Cakes & Pastry
UNION ALL SELECT 1143747869, 'cakes-pastry', 'Food & Drink', 'cake'
-- Theme, Birthday cakes -->Food & Drink, Cakes & Pastry
UNION ALL SELECT 1143747872, 'cakes-pastry', 'Food & Drink', 'cake'
-- Cake, Cake with own photo or name -->Food & Drink, Cakes & Pastry
UNION ALL SELECT 1143736536, 'cakes-pastry', 'Food & Drink', 'cake'
-- Cake, Dripcake -->Food & Drink, Cakes & Pastry
UNION ALL SELECT 1143747569, 'cakes-pastry', 'Food & Drink', 'cake'
-- Cake, Cream cake -->Food & Drink, Cakes & Pastry
UNION ALL SELECT 1143736539, 'cakes-pastry', 'Food & Drink', 'cake'
-- Cake, Layercake -->Food & Drink, Cakes & Pastry
UNION ALL SELECT 1143736560, 'cakes-pastry', 'Food & Drink', 'cake'
-- Cake, Fruit and nuts cake -->Food & Drink, Cakes & Pastry
UNION ALL SELECT 1143736554, 'cakes-pastry', 'Food & Drink', 'cake'
-- Cake, Red velvet -->Food & Drink, Cakes & Pastry
UNION ALL SELECT 1143747563, 'cakes-pastry', 'Food & Drink', 'cake'
-- Cake, Sparkle cake -->Food & Drink, Cakes & Pastry
UNION ALL SELECT 1143747572, 'cakes-pastry', 'Food & Drink', 'cake'
-- Product Family, Cake and Pastry -->Food & Drink, Cakes & Pastry
UNION ALL SELECT 1143736644, 'cakes-pastry', 'Food & Drink', 'cake'
-- Pastry, Tompoucen -->Food & Drink, Cakes & Pastry
UNION ALL SELECT 1143736587, 'cakes-pastry', 'Food & Drink', 'cake'
-- Pastry, Self bake -->Food & Drink, Baking Kits
UNION ALL SELECT 1143741121, 'baking-kits', 'Food & Drink', 'cake'
-- Pastry, Petit fours -->Food & Drink, Snacks Treats Savoury
UNION ALL SELECT 1143738303, 'snacks-treats-savoury', 'Food & Drink', 'cake'
-- Pastry, Pastry with own photo or name -->Food & Drink, Cakes & Pastry
UNION ALL SELECT 1143736575, 'cakes-pastry', 'Food & Drink', 'cake'
-- Pastry, Donuts -->Food & Drink, Cakes & Pastry
UNION ALL SELECT 1143736824, 'cakes-pastry', 'Food & Drink', 'cake'
-- Pastry, Cupcakes -->Food & Drink, Cakes & Pastry
UNION ALL SELECT 1143736581, 'cakes-pastry', 'Food & Drink', 'cake'
-- Pastry, Brownies -->Food & Drink, Cakes & Pastry
UNION ALL SELECT 1143736578, 'cakes-pastry', 'Food & Drink', 'cake'
-- Pastry, Assorted pastry -->Food & Drink, Cakes & Pastry
UNION ALL SELECT 1143736590, 'cakes-pastry', 'Food & Drink', 'cake'
-- Pastry, All pastry -->Food & Drink, Cakes & Pastry
UNION ALL SELECT 1143736593, 'cakes-pastry', 'Food & Drink', 'cake'
-- Cake, Marzipan cake -->Food & Drink, Cakes & Pastry
UNION ALL SELECT 1143736542, 'cakes-pastry', 'Food & Drink', 'cake'
-- Cake, Carrot cake -->Food & Drink, Cakes & Pastry
UNION ALL SELECT 1143747566, 'cakes-pastry', 'Food & Drink', 'cake'
-- Cake, Apple pie -->Food & Drink, Cakes & Pastry
UNION ALL SELECT 1143736545, 'cakes-pastry', 'Food & Drink', 'cake'
-- Cake, All cakes -->Food & Drink, Cakes & Pastry
UNION ALL SELECT 1143736572, 'cakes-pastry', 'Food & Drink', 'cake'
-- Cake, Cheesecake -->Food & Drink, Cakes & Pastry
UNION ALL SELECT 1143736557, 'cakes-pastry', 'Food & Drink', 'cake'
-- Cake, Chocolate cake -->Food & Drink, Cakes & Pastry
UNION ALL SELECT 1143736548, 'cakes-pastry', 'Food & Drink', 'cake'
-- Type, Letterbox gifts -->Gift Sets Hampers Letterbox, Letterbox
UNION ALL SELECT 1143737611, 'gift-sets-hampers-letterbox-letterbox', 'Gift Sets Hampers Letterbox', 'cake'
-- Product Family, Gifts -->NewIa, Personalised Gifts
UNION ALL SELECT 727212959, 'personalised-gifts', 'NewIa', 'cake'
-- Product Family, Eating and drinkingl2 -->NewIa, Food & Drink
UNION ALL SELECT 726930780, 'food-drink', 'NewIa', 'cake'
-- Type, Photo and text gifts -->NewIa, Personalised Gifts
UNION ALL SELECT 1143735781, 'personalised-gifts', 'NewIa', 'cake'
-- Pastry, Pastry with own photo or name -->NewIa, Personalised Gifts
UNION ALL SELECT 1143736575, 'personalised-gifts', 'NewIa', 'cake'
-- Occasion, Mothersday -->Occasion, Mothers' Day
UNION ALL SELECT 726331722, 'mothers-day', 'Occasion', 'cake'
-- Occasion, Secretaryday -->Occasion, Other
UNION ALL SELECT 1143731240, 'occasion-other', 'Occasion', 'cake'
-- Occasion, New home -->Occasion, New Home
UNION ALL SELECT 726342840, 'occasion-new-home', 'Occasion', 'cake'
-- Occasion, New Job -->Occasion, New Job
UNION ALL SELECT 735872747, 'occasion-new-job', 'Occasion', 'cake'
-- Occasion, Opening new business -->Occasion, Well Done
UNION ALL SELECT 1143744579, 'occasion-well-done', 'Occasion', 'cake'
-- Occasion, Retirement -->Occasion, Retirement
UNION ALL SELECT 735873966, 'occasion-retirement', 'Occasion', 'cake'
-- Occasion, Thank you -->Occasion, Thank You
UNION ALL SELECT 726347103, 'occasion-thank-you', 'Occasion', 'cake'
-- Occasion, Thank you teacher -->Occasion, Thank You
UNION ALL SELECT 1143742415, 'occasion-thank-you', 'Occasion', 'cake'
-- Occasion, Thanks teacher -->Occasion, Thank You
UNION ALL SELECT 1143757148, 'occasion-thank-you', 'Occasion', 'cake'
-- Occasion, Love -->Occasion, Other
UNION ALL SELECT 1143727832, 'occasion-other', 'Occasion', 'cake'
-- Occasion, Wedding -->Occasion, Wedding
UNION ALL SELECT 726342081, 'occasion-wedding', 'Occasion', 'cake'
-- Occasion, Valentine -->Occasion, Valentines' Day
UNION ALL SELECT 726324647, 'valentines-day', 'Occasion', 'cake'
-- Theme, Birthday cakes -->Occasion, Birthday
UNION ALL SELECT 1143747872, 'occasion-birthday', 'Occasion', 'cake'
-- Occasion, Thinking of you -->Occasion, Thinking of you
UNION ALL SELECT 748511930, 'occasion-thinking-of-you', 'Occasion', 'cake'
-- Occasion, Christmas -->Occasion, Christmas
UNION ALL SELECT 726331358, 'occasion-christmas', 'Occasion', 'cake'
-- Occasion, Living together -->Occasion, Other
UNION ALL SELECT 1143727835, 'occasion-other', 'Occasion', 'cake'
-- Occasion, Anniversary -->Occasion, Anniversaries
UNION ALL SELECT 1143740082, 'anniversaries', 'Occasion', 'cake'
-- Occasion, Brother and Sister day -->Occasion, Other
UNION ALL SELECT 1143732527, 'occasion-other', 'Occasion', 'cake'
-- Occasion, Congratulations (card and gift) -->Occasion, Congratulations
UNION ALL SELECT 1143729948, 'occasion-congratulations', 'Occasion', 'cake'
-- Occasion, Easter/Pasen -->Occasion, Easter
UNION ALL SELECT 726343205, 'occasion-easter', 'Occasion', 'cake'
-- Occasion, Fathersday -->Occasion, Father's Day
UNION ALL SELECT 726332069, 'fathers-day', 'Occasion', 'cake'
-- Occasion, Goodbye colleague -->Occasion, Goodbye
UNION ALL SELECT 1143736110, 'goodbye', 'Occasion', 'cake'
-- Occasion, Get well -->Occasion, Get Well
UNION ALL SELECT 726345521, 'occasion-get-well', 'Occasion', 'cake'
-- Occasion, Birthday -->Occasion, Birthday
UNION ALL SELECT 726324105, 'occasion-birthday', 'Occasion', 'cake'
-- Occasion, Good luck -->Occasion, Good Luck
UNION ALL SELECT 726345736, 'occasion-good-luck', 'Occasion', 'cake'
-- Occasion, Friendship2 -->Occasion, Friendship
UNION ALL SELECT 893069562, 'occasion-friendship', 'Occasion', 'cake'
-- Occasion, Just because -->Occasion, Just to say
UNION ALL SELECT 726347430, 'just-to-say', 'Occasion', 'cake'
-- Occasion, Graduation -->Occasion, Graduation
UNION ALL SELECT 1143729906, 'occasion-graduation', 'Occasion', 'cake'
-- Occasion, Kingsday -->Occasion, Kingsday
UNION ALL SELECT 726972775, 'kingsday', 'Occasion', 'cake'
-- Occasion, Eid Mubarak * Suikerfeest -->Religious Occasions, Eid Mubarak
UNION ALL SELECT 1143746767, 'eid-mubarak', 'Religious Occasions', 'cake'
-- Target Group, Girl -->Who's it for?, For Girls
UNION ALL SELECT 886507052, 'for-girls', 'Who''s it for?', 'cake'
-- Target Group, Zakelijk1 (cards missions) -->Who's it For?, Colleague
UNION ALL SELECT 1143732725, 'colleague', 'Who''s it For?', 'cake'
-- Target Group, Women -->Who's it for?, For Her
UNION ALL SELECT 1143750947, 'for-her', 'Who''s it for?', 'cake'
-- Target Group, Men -->Who's it for?, For Him
UNION ALL SELECT 1143750956, 'for-him', 'Who''s it for?', 'cake'
-- Target Group, Boy -->Who's it for?, For Boys
UNION ALL SELECT 886506339, 'for-boys', 'Who''s it for?', 'cake'
-- Age, Jongeren 12 to 18 years -->Age, Teen 13 17 years old
UNION ALL SELECT 748494248, 'teen-13-17-years-old', 'Age', 'chocolate'
-- Target Group, Men -->Age, Adult 25 64 years old
UNION ALL SELECT 1143750956, 'adult-25-64-years-old', 'Age', 'chocolate'
-- Target Group, Women -->Age, Adult 25 64 years old
UNION ALL SELECT 1143750947, 'adult-25-64-years-old', 'Age', 'chocolate'
-- Target Group, Women -->Age, Senior over 65 years old
UNION ALL SELECT 1143750947, 'senior-over-65-years-old', 'Age', 'chocolate'
-- Age, 18 years and older -->Age, Young Adult 18 24 years old
UNION ALL SELECT 880438645, 'young-adult-18-24-years-old', 'Age', 'chocolate'
-- Age, 18 years and older -->Age, Senior over 65 years old
UNION ALL SELECT 880438645, 'senior-over-65-years-old', 'Age', 'chocolate'
-- Age, 18 years and older -->Age, Adult 25 64 years old
UNION ALL SELECT 880438645, 'adult-25-64-years-old', 'Age', 'chocolate'
-- Target Group, Men -->Age, Senior over 65 years old
UNION ALL SELECT 1143750956, 'senior-over-65-years-old', 'Age', 'chocolate'
-- Highlighted, Giftbox: Beverage with chocolate -->Alcohol, Gift Sets Letterbox
UNION ALL SELECT 1143747968, 'alcohol-gift-sets-letterbox', 'Alcohol', 'chocolate'
-- Brand/Designer, Australian chocolate -->Brands, Australian chocolate
UNION ALL SELECT 1143732878, 'australian-chocolate', 'Brands', 'chocolate'
-- Brand/Designer, Urban Cacao -->Brands, Urban Cacao
UNION ALL SELECT 1143750830, 'urban-cacao', 'Brands', 'chocolate'
-- Brand/Designer, Tubes -->Brands, Tubes
UNION ALL SELECT 1143745881, 'tubes', 'Brands', 'chocolate'
-- Brand/Designer, Tony's -->Brands, Tony's
UNION ALL SELECT 1143735281, 'tonys', 'Brands', 'chocolate'
-- Brand/Designer, Chocolate by Greetz -->Brands, Chocolate by Greetz
UNION ALL SELECT 1143749225, 'chocolate-by-greetz', 'Brands', 'chocolate'
-- Brand/Designer, Pralibel -->Brands, Pralibel
UNION ALL SELECT 1143741163, 'pralibel', 'Brands', 'chocolate'
-- Brand/Designer, Milka -->Brands, Milka
UNION ALL SELECT 726985241, 'milka', 'Brands', 'chocolate'
-- Brand/Designer, Chocolate telegram -->Brands, Chocolate telegram
UNION ALL SELECT 1143730173, 'chocolate-telegram', 'Brands', 'chocolate'
-- Brand/Designer, Dragee -->Brands, Dragee
UNION ALL SELECT 1143749285, 'dragee', 'Brands', 'chocolate'
-- Brand/Designer, Happy Truffel -->Brands, Happy Truffel
UNION ALL SELECT 1143747605, 'happy-truffel', 'Brands', 'chocolate'
-- Brand/Designer, Leonidas -->Brands, Leonidas
UNION ALL SELECT 1143733923, 'leonidas', 'Brands', 'chocolate'
-- Brand/Designer, Merci -->Brands, Merci
UNION ALL SELECT 726982880, 'merci', 'Brands', 'chocolate'
-- Product Family, Chocolade repen -->Food & Drink, Chocolate
UNION ALL SELECT 1143742991, 'chocolate', 'Food & Drink', 'chocolate'
-- Highlighted, Giftbox: Beverage with chocolate -->Food & Drink, Chocolate
UNION ALL SELECT 1143747968, 'chocolate', 'Food & Drink', 'chocolate'
-- Type, Chocolate with a message -->Food & Drink, Chocolate
UNION ALL SELECT 1143749573, 'chocolate', 'Food & Drink', 'chocolate'
-- Product Family, Bonbons -->Food & Drink, Sweets
UNION ALL SELECT 1143735384, 'sweets', 'Food & Drink', 'chocolate'
-- Product Family, Chocolade met eigen foto of tekst -->Food & Drink, Chocolate
UNION ALL SELECT 1143735399, 'chocolate', 'Food & Drink', 'chocolate'
-- Product Family, Chocoladeletters -->Food & Drink, Chocolate
UNION ALL SELECT 1143735338, 'chocolate', 'Food & Drink', 'chocolate'
-- Product Family, Chocolate -->Food & Drink, Chocolate
UNION ALL SELECT 726930909, 'chocolate', 'Food & Drink', 'chocolate'
-- Product Family, Chocolate hearts -->Food & Drink, Chocolate
UNION ALL SELECT 1143735387, 'chocolate', 'Food & Drink', 'chocolate'
-- Product Family, Chocolate truffels -->Food & Drink, Chocolate
UNION ALL SELECT 1143747590, 'chocolate', 'Food & Drink', 'chocolate'
-- Product Family, Telegram -->Food & Drink, Chocolate
UNION ALL SELECT 1143730254, 'chocolate', 'Food & Drink', 'chocolate'
-- Product Family, All chocolate -->Food & Drink, Chocolate
UNION ALL SELECT 1143738429, 'chocolate', 'Food & Drink', 'chocolate'
-- Type, Letterbox gifts -->Gift Sets Hampers Letterbox, Letterbox
UNION ALL SELECT 1143737611, 'gift-sets-hampers-letterbox-letterbox', 'Gift Sets Hampers Letterbox', 'chocolate'
-- Type, Giftset -->Gift Sets Hampers Letterbox, Gift Sets
UNION ALL SELECT 1143739698, 'gift-sets-hampers-letterbox-gift-sets', 'Gift Sets Hampers Letterbox', 'chocolate'
-- Highlighted, Giftbox: Beverage with chocolate -->Gift Sets Hampers Letterbox, Gift Sets
UNION ALL SELECT 1143747968, 'gift-sets-hampers-letterbox-gift-sets', 'Gift Sets Hampers Letterbox', 'chocolate'
-- Product Family, Giftboxen -->Gift Sets Hampers Letterbox, Gift Sets
UNION ALL SELECT 1143735393, 'gift-sets-hampers-letterbox-gift-sets', 'Gift Sets Hampers Letterbox', 'chocolate'
-- Product Family, Gifts -->NewIa, Personalised Gifts
UNION ALL SELECT 727212959, 'personalised-gifts', 'NewIa', 'chocolate'
-- Product Family, Chocolade met eigen foto of tekst -->NewIa, Personalised Gifts
UNION ALL SELECT 1143735399, 'personalised-gifts', 'NewIa', 'chocolate'
-- Highlighted, personalised wrapping -->NewIa, Personalised Gifts
UNION ALL SELECT 1143743139, 'personalised-gifts', 'NewIa', 'chocolate'
-- Type, Chocolate with a message -->NewIa, Personalised Gifts
UNION ALL SELECT 1143749573, 'personalised-gifts', 'NewIa', 'chocolate'
-- Product Family, Eating and drinkingl2 -->NewIa, Food & Drink
UNION ALL SELECT 726930780, 'food-drink', 'NewIa', 'chocolate'
-- Type, Photo and text gifts -->NewIa, Personalised Gifts
UNION ALL SELECT 1143735781, 'personalised-gifts', 'NewIa', 'chocolate'
-- Product Family, Telegram -->NewIa, Personalised Gifts
UNION ALL SELECT 1143730254, 'personalised-gifts', 'NewIa', 'chocolate'
-- Occasion, Sorry -->Occasion, Sorry
UNION ALL SELECT 726966325, 'occasion-sorry', 'Occasion', 'chocolate'
-- Occasion, Easter/Pasen -->Occasion, Easter
UNION ALL SELECT 726343205, 'occasion-easter', 'Occasion', 'chocolate'
-- Occasion, Brother and Sister day -->Occasion, Other
UNION ALL SELECT 1143732527, 'occasion-other', 'Occasion', 'chocolate'
-- Occasion, Christmas -->Occasion, Christmas
UNION ALL SELECT 726331358, 'occasion-christmas', 'Occasion', 'chocolate'
-- Occasion, Congratulations (card and gift) -->Occasion, Congratulations
UNION ALL SELECT 1143729948, 'occasion-congratulations', 'Occasion', 'chocolate'
-- Occasion, Wedding -->Occasion, Wedding
UNION ALL SELECT 726342081, 'occasion-wedding', 'Occasion', 'chocolate'
-- Occasion, Pregnant -->Occasion, Pregnancy
UNION ALL SELECT 726344253, 'occasion-pregnancy', 'Occasion', 'chocolate'
-- Occasion, Retirement -->Occasion, Retirement
UNION ALL SELECT 735873966, 'occasion-retirement', 'Occasion', 'chocolate'
-- Occasion, Sinterklaas -->Occasion, Sinterklaas
UNION ALL SELECT 726330911, 'saint-nicholas', 'Occasion', 'chocolate'
-- Occasion, Thank you teacher -->Occasion, Thank You
UNION ALL SELECT 1143742415, 'occasion-thank-you', 'Occasion', 'chocolate'
-- Occasion, Thanks teacher -->Occasion, Thank You
UNION ALL SELECT 1143757148, 'occasion-thank-you', 'Occasion', 'chocolate'
-- Occasion, NewYear (gifts) -->Occasion, New Year
UNION ALL SELECT 1143732695, 'occasion-new-year', 'Occasion', 'chocolate'
-- Occasion, Valentine -->Occasion, Valentines' Day
UNION ALL SELECT 726324647, 'valentines-day', 'Occasion', 'chocolate'
-- Occasion, Thank you -->Occasion, Thank You
UNION ALL SELECT 726347103, 'occasion-thank-you', 'Occasion', 'chocolate'
-- Occasion, Zakelijke kerstgeschenken -->Occasion, Christmas
UNION ALL SELECT 1143747560, 'occasion-christmas', 'Occasion', 'chocolate'
-- Occasion, Anniversary -->Occasion, Anniversaries
UNION ALL SELECT 1143740082, 'anniversaries', 'Occasion', 'chocolate'
-- Occasion, AOC think -->Occasion, Thinking of you
UNION ALL SELECT 1143742160, 'occasion-thinking-of-you', 'Occasion', 'chocolate'
-- Occasion, Birth -->Occasion, New Baby
UNION ALL SELECT 726324202, 'occasion-new-baby', 'Occasion', 'chocolate'
-- Occasion, Secretaryday -->Occasion, Other
UNION ALL SELECT 1143731240, 'occasion-other', 'Occasion', 'chocolate'
-- Occasion, Birthday -->Occasion, Birthday
UNION ALL SELECT 726324105, 'occasion-birthday', 'Occasion', 'chocolate'
-- Occasion, Thinking of you -->Occasion, Thinking of you
UNION ALL SELECT 748511930, 'occasion-thinking-of-you', 'Occasion', 'chocolate'
-- Occasion, Graduation -->Occasion, Graduation
UNION ALL SELECT 1143729906, 'occasion-graduation', 'Occasion', 'chocolate'
-- Occasion, Get well -->Occasion, Get Well
UNION ALL SELECT 726345521, 'occasion-get-well', 'Occasion', 'chocolate'
-- Occasion, Friendship2 -->Occasion, Friendship
UNION ALL SELECT 893069562, 'occasion-friendship', 'Occasion', 'chocolate'
-- Occasion, New Job -->Occasion, New Job
UNION ALL SELECT 735872747, 'occasion-new-job', 'Occasion', 'chocolate'
-- Occasion, Get well welcome home -->Occasion, Get Well
UNION ALL SELECT 1143742088, 'occasion-get-well', 'Occasion', 'chocolate'
-- Occasion, Good luck -->Occasion, Good Luck
UNION ALL SELECT 726345736, 'occasion-good-luck', 'Occasion', 'chocolate'
-- Occasion, Fathersday -->Occasion, Father's Day
UNION ALL SELECT 726332069, 'fathers-day', 'Occasion', 'chocolate'
-- Occasion, Fall (Flowers -->Occasion, Other
UNION ALL SELECT 1143732590, 'occasion-other', 'Occasion', 'chocolate'
-- Occasion, Just because -->Occasion, Just to say
UNION ALL SELECT 726347430, 'just-to-say', 'Occasion', 'chocolate'
-- Occasion, Failed -->Occasion, Empathy
UNION ALL SELECT 748506030, 'empathy', 'Occasion', 'chocolate'
-- Occasion, Living together -->Occasion, New Home
UNION ALL SELECT 1143727835, 'occasion-new-home', 'Occasion', 'chocolate'
-- Occasion, Love -->Occasion, Missing You
UNION ALL SELECT 1143727832, 'missing-you', 'Occasion', 'chocolate'
-- Occasion, Mothersday -->Occasion, Mothers' Day
UNION ALL SELECT 726331722, 'mothers-day', 'Occasion', 'chocolate'
-- Occasion, New home -->Occasion, New Home
UNION ALL SELECT 726342840, 'occasion-new-home', 'Occasion', 'chocolate'
-- Occasion, Goodbye colleague -->Occasion, Goodbye
UNION ALL SELECT 1143736110, 'goodbye', 'Occasion', 'chocolate'
-- Occasion, Eid Mubarak * Suikerfeest -->Religious Occasions, Eid Mubarak
UNION ALL SELECT 1143746767, 'eid-mubarak', 'Religious Occasions', 'chocolate'
-- Occasion, Zakelijke kerstgeschenken -->Who's it for?, Colleague
UNION ALL SELECT 1143747560, 'colleague', 'Who''s it for?', 'chocolate'
-- Target Group, Zakelijk1 (cards missions) -->Who's it For?, Colleague
UNION ALL SELECT 1143732725, 'colleague', 'Who''s it For?', 'chocolate'
-- Target Group, Women -->Who's it for?, For Her
UNION ALL SELECT 1143750947, 'for-her', 'Who''s it for?', 'chocolate'
-- Target Group, Men -->Who's it for?, For Him
UNION ALL SELECT 1143750956, 'for-him', 'Who''s it for?', 'chocolate'
-- Target Group, Boy -->Who's it for?, For Boys
UNION ALL SELECT 886506339, 'for-boys', 'Who''s it for?', 'chocolate'
-- Occasion, Goodbye colleague -->Who's it for?, Colleague
UNION ALL SELECT 1143736110, 'colleague', 'Who''s it for?', 'chocolate'
-- Target Group, Girl -->Who's it for?, For Girls
UNION ALL SELECT 886507052, 'for-girls', 'Who''s it for?', 'chocolate'
-- Product Family, Socks -->Accessories, Socks
UNION ALL SELECT 1143765383, 'socks', 'Accessories', 'flower'
-- Target Group, Men -->Age, Adult 25 64 years old
UNION ALL SELECT 1143750956, 'adult-25-64-years-old', 'Age', 'flower'
-- Age, 18 years and older -->Age, Adult 25 64 years old
UNION ALL SELECT 880438645, 'adult-25-64-years-old', 'Age', 'flower'
-- Age, 18 years and older -->Age, Senior over 65 years old
UNION ALL SELECT 880438645, 'senior-over-65-years-old', 'Age', 'flower'
-- Target Group, Women -->Age, Senior over 65 years old
UNION ALL SELECT 1143750947, 'senior-over-65-years-old', 'Age', 'flower'
-- Target Group, Women -->Age, Adult 25 64 years old
UNION ALL SELECT 1143750947, 'adult-25-64-years-old', 'Age', 'flower'
-- Age, 18 years and older -->Age, Young Adult 18 24 years old
UNION ALL SELECT 880438645, 'young-adult-18-24-years-old', 'Age', 'flower'
-- Target Group, Men -->Age, Senior over 65 years old
UNION ALL SELECT 1143750956, 'senior-over-65-years-old', 'Age', 'flower'
-- Age, Baby 0 tot 1 year -->Age, Baby 0 1 years old
UNION ALL SELECT 880440481, 'baby-0-1-years-old', 'Age', 'flower'
-- Product Family, Beer package -->Alcohol, Beer & Cider
UNION ALL SELECT 1143731725, 'beer-cider', 'Alcohol', 'flower'
-- Product Family, Wine -->Alcohol, Champagne Prosecco & Wine
UNION ALL SELECT 899226515, 'champagne-prosecco-wine', 'Alcohol', 'flower'
-- Product Family, Beer -->Alcohol, Beer & Cider
UNION ALL SELECT 784098536, 'beer-cider', 'Alcohol', 'flower'
-- Product Family, Blond beer -->Beer & Cider, Lager
UNION ALL SELECT 1143732235, 'lager', 'Beer & Cider', 'flower'
-- Brand/Designer, Nijntje -->Brands, Nijntje
UNION ALL SELECT 825334736, 'nijntje', 'Brands', 'flower'
-- Brand/Designer, Little Dutch -->Brands, Little Dutch
UNION ALL SELECT 1143740088, 'little-dutch', 'Brands', 'flower'
-- Brand/Designer, Merci -->Brands, Merci
UNION ALL SELECT 726982880, 'merci', 'Brands', 'flower'
-- Brand/Designer, Milka -->Brands, Milka
UNION ALL SELECT 726985241, 'milka', 'Brands', 'flower'
-- Brand/Designer, Happy Truffel -->Brands, Happy Truffel
UNION ALL SELECT 1143747605, 'happy-truffel', 'Brands', 'flower'
-- Brand/Designer, Greetz -->Brands, Greetz
UNION ALL SELECT 726316072, 'greetz', 'Brands', 'flower'
-- Brand/Designer, The Gift Label -->Brands, The Gift Label
UNION ALL SELECT 1143744837, 'the-gift-label', 'Brands', 'flower'
-- Brand/Designer, Happy Socks -->Brands, Happy Socks
UNION ALL SELECT 1143738180, 'happy-socks', 'Brands', 'flower'
-- Brand/Designer, Kneipp -->Brands, Kneipp
UNION ALL SELECT 1143733099, 'kneipp', 'Brands', 'flower'
-- Brand/Designer, Noia Jewellery -->Brands, Noia Jewellery
UNION ALL SELECT 1143765583, 'noia-jewellery', 'Brands', 'flower'
-- Brand/Designer, La Chouffe -->Brands, La Chouffe
UNION ALL SELECT 1143730644, 'la-chouffe', 'Brands', 'flower'
-- Brand/Designer, Il Miogusto -->Brands, Il Miogusto
UNION ALL SELECT 1143747145, 'il-miogusto', 'Brands', 'flower'
-- Brand/Designer, Janzen -->Brands, Janzen
UNION ALL SELECT 1143756595, 'janzen', 'Brands', 'flower'
-- Brand/Designer, Tony's -->Brands, Tony's
UNION ALL SELECT 1143735281, 'tonys', 'Brands', 'flower'
-- Brand/Designer, 100 procent Leuk -->Brands, 100 procent Leuk
UNION ALL SELECT 1143748292, '100-procent-leuk', 'Brands', 'flower'
-- Product Family, Red wine -->Champagne Prosecco & Wine, Red wine
UNION ALL SELECT 784103211, 'red-wine', 'Champagne Prosecco & Wine', 'flower'
-- Product Family, Sparkling wine -->Champagne Prosecco & Wine, Sparkling Wine
UNION ALL SELECT 1143747022, 'sparkling-wine', 'Champagne Prosecco & Wine', 'flower'
-- Product Family, White wine -->Champagne Prosecco & Wine, White wine
UNION ALL SELECT 784100994, 'white-wine', 'Champagne Prosecco & Wine', 'flower'
-- Color, Black -->Flower Colour, Other
UNION ALL SELECT 1143728198, 'flower-colour-other', 'Flower Colour', 'flower'
-- Color, PastelPink -->Flower Colour, Pink
UNION ALL SELECT 1143738546, 'flower-colour-pink', 'Flower Colour', 'flower'
-- Color, OrangeRed -->Flower Colour, Orange
UNION ALL SELECT 1143728156, 'orange', 'Flower Colour', 'flower'
-- Color, Blue -->Flower Colour, Blue
UNION ALL SELECT 1143728186, 'blue', 'Flower Colour', 'flower'
-- Color, Cardinal -->Flower Colour, Red
UNION ALL SELECT 1143738519, 'red', 'Flower Colour', 'flower'
-- Color, DarkGreen -->Flower Colour, Green
UNION ALL SELECT 1143728176, 'green', 'Flower Colour', 'flower'
-- Color, DarkOrange -->Flower Colour, Orange
UNION ALL SELECT 1143728157, 'orange', 'Flower Colour', 'flower'
-- Color, DarkRed -->Flower Colour, Red
UNION ALL SELECT 1143728147, 'red', 'Flower Colour', 'flower'
-- Color, DeepPink -->Flower Colour, Pink
UNION ALL SELECT 1143728150, 'flower-colour-pink', 'Flower Colour', 'flower'
-- Color, Gold -->Flower Colour, Yellow
UNION ALL SELECT 1143728161, 'yellow', 'Flower Colour', 'flower'
-- Color, Green -->Flower Colour, Green
UNION ALL SELECT 727095708, 'green', 'Flower Colour', 'flower'
-- Color, HotPink -->Flower Colour, Pink
UNION ALL SELECT 1143728149, 'flower-colour-pink', 'Flower Colour', 'flower'
-- Color, Lavender -->Flower Colour, Purple
UNION ALL SELECT 1143728164, 'purple', 'Flower Colour', 'flower'
-- Color, Pink -->Flower Colour, Pink
UNION ALL SELECT 1143728148, 'flower-colour-pink', 'Flower Colour', 'flower'
-- Color, Mix of colors -->Flower Colour, Multi Colour
UNION ALL SELECT 729235298, 'multi-colour', 'Flower Colour', 'flower'
-- Color, PeachPuff -->Flower Colour, Peach
UNION ALL SELECT 1143728159, 'peach', 'Flower Colour', 'flower'
-- Color, Purple -->Flower Colour, Purple
UNION ALL SELECT 727096014, 'purple', 'Flower Colour', 'flower'
-- Color, Raffia -->Flower Colour, Pink
UNION ALL SELECT 1143738555, 'flower-colour-pink', 'Flower Colour', 'flower'
-- Color, Red -->Flower Colour, Red
UNION ALL SELECT 1143728144, 'red', 'Flower Colour', 'flower'
-- Color, Salmon -->Flower Colour, Pink
UNION ALL SELECT 1143728142, 'flower-colour-pink', 'Flower Colour', 'flower'
-- Color, SteelBlue -->Flower Colour, Blue
UNION ALL SELECT 1143728181, 'blue', 'Flower Colour', 'flower'
-- Color, White -->Flower Colour, White
UNION ALL SELECT 1143728193, 'white', 'Flower Colour', 'flower'
-- Color, Yellow -->Flower Colour, Yellow
UNION ALL SELECT 1143728162, 'yellow', 'Flower Colour', 'flower'
-- Color, LightSalmon -->Flower Colour, Pink
UNION ALL SELECT 1143728154, 'flower-colour-pink', 'Flower Colour', 'flower'
-- Product Family, Field Bouquets -->Flowers & Plants, Bouquets
UNION ALL SELECT 1143749222, 'bouquets', 'Flowers & Plants', 'flower'
-- Flower Type, Gerbera -->Flowers & Plants, Gerbera
UNION ALL SELECT 1143730305, 'gerbera', 'Flowers & Plants', 'flower'
-- Product Family, Dry Flowers -->Flowers & Plants, Dried Flowers
UNION ALL SELECT 1143750422, 'dried-flowers', 'Flowers & Plants', 'flower'
-- Product Family, Extra Large Bouquets -->Flowers & Plants, Bouquets
UNION ALL SELECT 1143747422, 'bouquets', 'Flowers & Plants', 'flower'
-- Flower Type, Peony -->Flowers & Plants, Peonies
UNION ALL SELECT 1143746788, 'peonies', 'Flowers & Plants', 'flower'
-- Flower Type, Anjer -->Flowers & Plants, Carnations
UNION ALL SELECT 1143734331, 'carnations', 'Flowers & Plants', 'flower'
-- Flower Type, Chrysant -->Flowers & Plants, Chrysanthemums
UNION ALL SELECT 1143730302, 'chrysanthemums', 'Flowers & Plants', 'flower'
-- Flower Type, Leeuwenbek -->Flowers & Plants, Other
UNION ALL SELECT 1143734328, 'flowers-plants-other', 'Flowers & Plants', 'flower'
-- Flower Type, Lisianthus -->Flowers & Plants, Lisianthus
UNION ALL SELECT 1143740557, 'lisianthus', 'Flowers & Plants', 'flower'
-- Flower Type, Lilies -->Flowers & Plants, Lilies
UNION ALL SELECT 1143731312, 'lilies', 'Flowers & Plants', 'flower'
-- Flower Type, Orchids -->Flowers & Plants, Orchid
UNION ALL SELECT 1143730311, 'orchid', 'Flowers & Plants', 'flower'
-- Flower Type, Roses -->Flowers & Plants, Roses
UNION ALL SELECT 1143730299, 'roses', 'Flowers & Plants', 'flower'
-- Highlighted, Boeket van de maand (bloemen) -->Flowers & Plants, Bouquets
UNION ALL SELECT 1143737617, 'bouquets', 'Flowers & Plants', 'flower'
-- Product Family, Mourning (bouquet) -->Flowers & Plants, Bouquets
UNION ALL SELECT 1143730245, 'bouquets', 'Flowers & Plants', 'flower'
-- Flower Type, Tulips -->Flowers & Plants, Tulips
UNION ALL SELECT 1143731309, 'tulips', 'Flowers & Plants', 'flower'
-- Product Family, Bloompost -->Flowers Gift Sets & Letterbox, Letterbox
UNION ALL SELECT 1143731608, 'letterbox', 'Flowers Gift Sets & Letterbox', 'flower'
-- Product Family, Flowers with vase -->Flowers Gift Sets & Letterbox, With vase
UNION ALL SELECT 1143740563, 'with-vase', 'Flowers Gift Sets & Letterbox', 'flower'
-- Theme, Brievenbuscadeau -->Flowers Gift Sets & Letterbox, Letterbox
UNION ALL SELECT 1143732596, 'letterbox', 'Flowers Gift Sets & Letterbox', 'flower'
-- Product Family, Plants with gift -->Flowers Gift Sets & Letterbox, Gift Sets
UNION ALL SELECT 1143765353, 'flowers-gift-sets-letterbox-gift-sets', 'Flowers Gift Sets & Letterbox', 'flower'
-- Type, Chocolate with flowers -->Flowers Gift Sets & Letterbox, Gift Sets
UNION ALL SELECT 1143749624, 'flowers-gift-sets-letterbox-gift-sets', 'Flowers Gift Sets & Letterbox', 'flower'
-- Type, Drinks with flowers -->Flowers Gift Sets & Letterbox, Gift Sets
UNION ALL SELECT 1143746501, 'flowers-gift-sets-letterbox-gift-sets', 'Flowers Gift Sets & Letterbox', 'flower'
-- Product Family, Flowers with gift -->Flowers Gift Sets & Letterbox, Gift Sets
UNION ALL SELECT 1143731557, 'flowers-gift-sets-letterbox-gift-sets', 'Flowers Gift Sets & Letterbox', 'flower'
-- Product Family, Chocolade repen -->Food & Drink, Chocolate
UNION ALL SELECT 1143742991, 'chocolate', 'Food & Drink', 'flower'
-- Product Family, Chocolate -->Food & Drink, Chocolate
UNION ALL SELECT 726930909, 'chocolate', 'Food & Drink', 'flower'
-- Product Family, Chocolate truffels -->Food & Drink, Chocolate
UNION ALL SELECT 1143747590, 'chocolate', 'Food & Drink', 'flower'
-- Product Family, All chocolate -->Food & Drink, Chocolate
UNION ALL SELECT 1143738429, 'chocolate', 'Food & Drink', 'flower'
-- Product Family, Giftboxen -->Gift Sets Hampers Letterbox, Gift Sets
UNION ALL SELECT 1143735393, 'gift-sets-hampers-letterbox-gift-sets', 'Gift Sets Hampers Letterbox', 'flower'
-- Product Family, Giftsets -->Gift Sets Hampers Letterbox, Gift Sets
UNION ALL SELECT 1143751673, 'gift-sets-hampers-letterbox-gift-sets', 'Gift Sets Hampers Letterbox', 'flower'
-- Type, Letterbox gifts -->Gift Sets Hampers Letterbox, Letterbox
UNION ALL SELECT 1143737611, 'gift-sets-hampers-letterbox-letterbox', 'Gift Sets Hampers Letterbox', 'flower'
-- Type, Giftset -->Gift Sets Hampers Letterbox, Gift Sets
UNION ALL SELECT 1143739698, 'gift-sets-hampers-letterbox-gift-sets', 'Gift Sets Hampers Letterbox', 'flower'
-- Product Family, Flowers and plants -->NewIa, Flowers & Plants
UNION ALL SELECT 800471607, 'flowers-plants', 'NewIa', 'flower'
-- Highlighted, Seizoenstoppers (bloemen) -->NewIa, Flowers & Plants
UNION ALL SELECT 1143737620, 'flowers-plants', 'NewIa', 'flower'
-- Product Family, Handsoap -->NewIa, Beauty Face & Body
UNION ALL SELECT 1143744897, 'beauty-face-body', 'NewIa', 'flower'
-- Product Family, Gifts -->NewIa, Personalised Gifts
UNION ALL SELECT 727212959, 'personalised-gifts', 'NewIa', 'flower'
-- Product Family, Plants3 -->NewIa, Flowers & Plants
UNION ALL SELECT 1143727954, 'flowers-plants', 'NewIa', 'flower'
-- Product Family, Flowers3 -->NewIa, Flowers & Plants
UNION ALL SELECT 1143727951, 'flowers-plants', 'NewIa', 'flower'
-- Product Family, Shower gel -->NewIa, Beauty Face & Body
UNION ALL SELECT 1143742442, 'beauty-face-body', 'NewIa', 'flower'
-- Product Family, Flowers and plantsL2 -->NewIa, Flowers & Plants
UNION ALL SELECT 726933058, 'flowers-plants', 'NewIa', 'flower'
-- Product Family, Box and bed toys -->NewIa, Toys Kids & Baby
UNION ALL SELECT 1143739206, 'toys-kids-baby', 'NewIa', 'flower'
-- Product Family, AccessoriesL2 -->NewIa, Accessories
UNION ALL SELECT 950102332, 'accessories', 'NewIa', 'flower'
-- Product Family, Baby and kids -->NewIa, Toys Kids & Baby
UNION ALL SELECT 1143739056, 'toys-kids-baby', 'NewIa', 'flower'
-- Product Family, Eating and drinkingl2 -->NewIa, Food & Drink
UNION ALL SELECT 726930780, 'food-drink', 'NewIa', 'flower'
-- Product Family, Baby and kids L2 -->NewIa, Toys Kids & Baby
UNION ALL SELECT 1143739053, 'toys-kids-baby', 'NewIa', 'flower'
-- Product Family, Drinks -->NewIa, Food & Drink
UNION ALL SELECT 1143727296, 'food-drink', 'NewIa', 'flower'
-- Product Family, Baby toys -->NewIa, Toys Kids & Baby
UNION ALL SELECT 1143739059, 'toys-kids-baby', 'NewIa', 'flower'
-- Product Family, Beauty -->NewIa, Beauty Face & Body
UNION ALL SELECT 1143727993, 'beauty-face-body', 'NewIa', 'flower'
-- Product Family, Beauty and careL2 -->NewIa, Beauty Face & Body
UNION ALL SELECT 726960191, 'beauty-face-body', 'NewIa', 'flower'
-- Product Family, Seeds -->NewIa, Home & Garden
UNION ALL SELECT 1143740284, 'home-garden', 'NewIa', 'flower'
-- Occasion, Thank you -->Occasion, Thank You
UNION ALL SELECT 726347103, 'occasion-thank-you', 'Occasion', 'flower'
-- Occasion, Condolence -->Occasion, Sympathy
UNION ALL SELECT 726345401, 'occasion-sympathy', 'Occasion', 'flower'
-- Occasion, Mothersday -->Occasion, Mothers' Day
UNION ALL SELECT 726331722, 'mothers-day', 'Occasion', 'flower'
-- Occasion, Love -->Occasion, Other
UNION ALL SELECT 1143727832, 'occasion-other', 'Occasion', 'flower'
-- Occasion, Living together -->Occasion, Other
UNION ALL SELECT 1143727835, 'occasion-other', 'Occasion', 'flower'
-- Occasion, Kerst (flowers) -->Occasion, Christmas
UNION ALL SELECT 1143735354, 'occasion-christmas', 'Occasion', 'flower'
-- Occasion, Just because -->Occasion, Just to say
UNION ALL SELECT 726347430, 'just-to-say', 'Occasion', 'flower'
-- Occasion, Good luck -->Occasion, Good Luck
UNION ALL SELECT 726345736, 'occasion-good-luck', 'Occasion', 'flower'
-- Occasion, Friendship2 -->Occasion, Friendship
UNION ALL SELECT 893069562, 'occasion-friendship', 'Occasion', 'flower'
-- Occasion, Fathersday -->Occasion, Father's Day
UNION ALL SELECT 726332069, 'fathers-day', 'Occasion', 'flower'
-- Occasion, New home -->Occasion, New Home
UNION ALL SELECT 726342840, 'occasion-new-home', 'Occasion', 'flower'
-- Occasion, Congratulations (card and gift) -->Occasion, Congratulations
UNION ALL SELECT 1143729948, 'occasion-congratulations', 'Occasion', 'flower'
-- Occasion, Graduation -->Occasion, Graduation
UNION ALL SELECT 1143729906, 'occasion-graduation', 'Occasion', 'flower'
-- Occasion, Birthday -->Occasion, Birthday
UNION ALL SELECT 726324105, 'occasion-birthday', 'Occasion', 'flower'
-- Occasion, Birth visite -->Occasion, New Baby
UNION ALL SELECT 1143739134, 'occasion-new-baby', 'Occasion', 'flower'
-- Occasion, Birth -->Occasion, New Baby
UNION ALL SELECT 726324202, 'occasion-new-baby', 'Occasion', 'flower'
-- Occasion, Babyshower -->Occasion, Baby Shower
UNION ALL SELECT 1143739143, 'baby-shower', 'Occasion', 'flower'
-- Occasion, Babyshower -->Occasion, Baby Shower
UNION ALL SELECT 1143739143, 'baby-shower', 'Occasion', 'flower'
-- Occasion, Babyshower -->Occasion, Baby Shower
UNION ALL SELECT 1143739143, 'baby-shower', 'Occasion', 'flower'
-- Occasion, Babyshower -->Occasion, Baby Shower
UNION ALL SELECT 1143739143, 'baby-shower', 'Occasion', 'flower'
-- Occasion, AOC think -->Occasion, Thinking of you
UNION ALL SELECT 1143742160, 'occasion-thinking-of-you', 'Occasion', 'flower'
-- Occasion, Anniversary -->Occasion, Anniversaries
UNION ALL SELECT 1143740082, 'anniversaries', 'Occasion', 'flower'
-- Occasion, Easter/Pasen -->Occasion, Easter
UNION ALL SELECT 726343205, 'occasion-easter', 'Occasion', 'flower'
-- Occasion, Thinking of you -->Occasion, Thinking of you
UNION ALL SELECT 748511930, 'occasion-thinking-of-you', 'Occasion', 'flower'
-- Occasion, Zakelijke kerstgeschenken -->Occasion, Christmas
UNION ALL SELECT 1143747560, 'occasion-christmas', 'Occasion', 'flower'
-- Occasion, Wedding -->Occasion, Wedding
UNION ALL SELECT 726342081, 'occasion-wedding', 'Occasion', 'flower'
-- Occasion, Valentine -->Occasion, Valentines' Day
UNION ALL SELECT 726324647, 'valentines-day', 'Occasion', 'flower'
-- Occasion, Get well -->Occasion, Get Well
UNION ALL SELECT 726345521, 'occasion-get-well', 'Occasion', 'flower'
-- Occasion, Vacation -->Occasion, Bon Voyage
UNION ALL SELECT 1143729435, 'occasion-bon-voyage', 'Occasion', 'flower'
-- Occasion, New Job -->Occasion, New Job
UNION ALL SELECT 735872747, 'occasion-new-job', 'Occasion', 'flower'
-- Occasion, Thanks teacher -->Occasion, Thank You
UNION ALL SELECT 1143757148, 'occasion-thank-you', 'Occasion', 'flower'
-- Occasion, Secretaryday -->Occasion, Other
UNION ALL SELECT 1143731240, 'occasion-other', 'Occasion', 'flower'
-- Occasion, Retirement -->Occasion, Retirement
UNION ALL SELECT 735873966, 'occasion-retirement', 'Occasion', 'flower'
-- Occasion, Thank you teacher -->Occasion, Thank You
UNION ALL SELECT 1143742415, 'occasion-thank-you', 'Occasion', 'flower'
-- Occasion, Sorry -->Occasion, Sorry
UNION ALL SELECT 726966325, 'occasion-sorry', 'Occasion', 'flower'
-- Occasion, Spring (flowers) -->Occasion, Other
UNION ALL SELECT 1143731093, 'occasion-other', 'Occasion', 'flower'
-- Occasion, Pregnant -->Occasion, Pregnancy
UNION ALL SELECT 726344253, 'occasion-pregnancy', 'Occasion', 'flower'
-- Occasion, Eid Mubarak * Suikerfeest -->Religious Occasions, Eid Mubarak
UNION ALL SELECT 1143746767, 'eid-mubarak', 'Religious Occasions', 'flower'
-- Product Family, Rattles -->Toys Kids & Baby, Baby
UNION ALL SELECT 1143748052, 'toys-kids-baby-baby', 'Toys Kids & Baby', 'flower'
-- Product Family, Plush toys -->Toys Kids & Baby, Soft Toys
UNION ALL SELECT 1143739200, 'soft-toys', 'Toys Kids & Baby', 'flower'
-- Product Family, Soft plush -->Toys Kids & Baby, Soft Toys
UNION ALL SELECT 1143741583, 'soft-toys', 'Toys Kids & Baby', 'flower'
-- Target Group, Zakelijk1 (cards missions) -->Who's it For?, Colleague
UNION ALL SELECT 1143732725, 'colleague', 'Who''s it For?', 'flower'
-- Occasion, Zakelijke kerstgeschenken -->Who's it For?, Colleague
UNION ALL SELECT 1143747560, 'colleague', 'Who''s it For?', 'flower'
-- Target Group, Men -->Who's it for?, For Him
UNION ALL SELECT 1143750956, 'for-him', 'Who''s it for?', 'flower'
-- Occasion, Thank you teacher -->Who's it For?, Teacher
UNION ALL SELECT 1143742415, 'teacher', 'Who''s it For?', 'flower'
-- Target Group, Girl -->Who's it for?, For Girls
UNION ALL SELECT 886507052, 'for-girls', 'Who''s it for?', 'flower'
-- Target Group, Women -->Who's it for?, For Her
UNION ALL SELECT 1143750947, 'for-her', 'Who''s it for?', 'flower'
-- Occasion, Thanks teacher -->Who's it For?, Teacher
UNION ALL SELECT 1143757148, 'teacher', 'Who''s it For?', 'flower'
-- Target Group, Boy -->Who's it for?, For Boys
UNION ALL SELECT 886506339, 'for-boys', 'Who''s it for?', 'flower'
-- Target Group, Men -->Age, Adult 25 64 years old
UNION ALL SELECT 1143750956, 'adult-25-64-years-old', 'Age', 'gift-card'
-- Target Group, Women -->Age, Adult 25 64 years old
UNION ALL SELECT 1143750947, 'adult-25-64-years-old', 'Age', 'gift-card'
-- Target Group, Men -->Age, Senior over 65 years old
UNION ALL SELECT 1143750956, 'senior-over-65-years-old', 'Age', 'gift-card'
-- Target Group, Women -->Age, Senior over 65 years old
UNION ALL SELECT 1143750947, 'senior-over-65-years-old', 'Age', 'gift-card'
-- Product Family, Wellness and beauty -->Gift Cards, Home Fashion
UNION ALL SELECT 1143745599, 'home-fashion', 'Gift Cards', 'gift-card'
-- Product Family, Fashion and shopping -->Gift Cards, Home Fashion
UNION ALL SELECT 1143745608, 'home-fashion', 'Gift Cards', 'gift-card'
-- Product Family, Living and garden -->Gift Cards, Home Fashion
UNION ALL SELECT 1143745596, 'home-fashion', 'Gift Cards', 'gift-card'
-- Type, Letterbox gifts -->Gift Sets Hampers Letterbox, Letterbox
UNION ALL SELECT 1143737611, 'gift-sets-hampers-letterbox-letterbox', 'Gift Sets Hampers Letterbox', 'gift-card'
-- Product Family, Drinking and eating -->Interests & Hobbies, Food and Drink
UNION ALL SELECT 1143745605, 'food-and-drink', 'Interests & Hobbies', 'gift-card'
-- Product Family, Gifts -->NewIa, Personalised Gifts
UNION ALL SELECT 727212959, 'personalised-gifts', 'NewIa', 'gift-card'
-- Product Family, Gift Cards -->NewIa, Gift Cards
UNION ALL SELECT 787982115, 'gift-cards', 'NewIa', 'gift-card'
-- Product Family, Experiences -->NewIa, Gift Experiences
UNION ALL SELECT 1143745602, 'gift-experiences', 'NewIa', 'gift-card'
-- Product Family, GiftcardsL2 -->NewIa, Gift Cards
UNION ALL SELECT 899676844, 'gift-cards', 'NewIa', 'gift-card'
-- Occasion, Babyshower -->Occasion, Baby Shower
UNION ALL SELECT 1143739143, 'baby-shower', 'Occasion', 'gift-card'
-- Occasion, Wedding -->Occasion, Wedding
UNION ALL SELECT 726342081, 'occasion-wedding', 'Occasion', 'gift-card'
-- Occasion, Zakelijke kerstgeschenken -->Occasion, Christmas
UNION ALL SELECT 1143747560, 'occasion-christmas', 'Occasion', 'gift-card'
-- Occasion, Friendship2 -->Occasion, Friendship
UNION ALL SELECT 893069562, 'occasion-friendship', 'Occasion', 'gift-card'
-- Occasion, Fathersday -->Occasion, Father's Day
UNION ALL SELECT 726332069, 'fathers-day', 'Occasion', 'gift-card'
-- Occasion, Congratulations (card and gift) -->Occasion, Congratulations
UNION ALL SELECT 1143729948, 'occasion-congratulations', 'Occasion', 'gift-card'
-- Occasion, Christmas -->Occasion, Christmas
UNION ALL SELECT 726331358, 'occasion-christmas', 'Occasion', 'gift-card'
-- Occasion, Valentine -->Occasion, Valentines' Day
UNION ALL SELECT 726324647, 'valentines-day', 'Occasion', 'gift-card'
-- Occasion, Birthday -->Occasion, Birthday
UNION ALL SELECT 726324105, 'occasion-birthday', 'Occasion', 'gift-card'
-- Occasion, AOC think -->Occasion, Thinking of you
UNION ALL SELECT 1143742160, 'occasion-thinking-of-you', 'Occasion', 'gift-card'
-- Occasion, Babyshower -->Occasion, Baby Shower
UNION ALL SELECT 1143739143, 'baby-shower', 'Occasion', 'gift-card'
-- Occasion, Babyshower -->Occasion, Baby Shower
UNION ALL SELECT 1143739143, 'baby-shower', 'Occasion', 'gift-card'
-- Occasion, Babyshower -->Occasion, Baby Shower
UNION ALL SELECT 1143739143, 'baby-shower', 'Occasion', 'gift-card'
-- Occasion, Anniversary -->Occasion, Anniversaries
UNION ALL SELECT 1143740082, 'anniversaries', 'Occasion', 'gift-card'
-- Occasion, Get well -->Occasion, Get Well
UNION ALL SELECT 726345521, 'occasion-get-well', 'Occasion', 'gift-card'
-- Occasion, Brother and Sister day -->Occasion, Other
UNION ALL SELECT 1143732527, 'occasion-other', 'Occasion', 'gift-card'
-- Occasion, New Job -->Occasion, New Job
UNION ALL SELECT 735872747, 'occasion-new-job', 'Occasion', 'gift-card'
-- Occasion, Just because -->Occasion, Just to say
UNION ALL SELECT 726347430, 'just-to-say', 'Occasion', 'gift-card'
-- Occasion, Goodbye colleague -->Occasion, Goodbye
UNION ALL SELECT 1143736110, 'goodbye', 'Occasion', 'gift-card'
-- Occasion, Living together -->Occasion, Other
UNION ALL SELECT 1143727835, 'occasion-other', 'Occasion', 'gift-card'
-- Occasion, Love -->Occasion, Other
UNION ALL SELECT 1143727832, 'occasion-other', 'Occasion', 'gift-card'
-- Occasion, Graduation -->Occasion, Graduation
UNION ALL SELECT 1143729906, 'occasion-graduation', 'Occasion', 'gift-card'
-- Occasion, New home -->Occasion, New Home
UNION ALL SELECT 726342840, 'occasion-new-home', 'Occasion', 'gift-card'
-- Occasion, Opening new business -->Occasion, Other
UNION ALL SELECT 1143744579, 'occasion-other', 'Occasion', 'gift-card'
-- Occasion, Retirement -->Occasion, Retirement
UNION ALL SELECT 735873966, 'occasion-retirement', 'Occasion', 'gift-card'
-- Occasion, Sorry -->Occasion, Sorry
UNION ALL SELECT 726966325, 'occasion-sorry', 'Occasion', 'gift-card'
-- Occasion, Good luck -->Occasion, Good Luck
UNION ALL SELECT 726345736, 'occasion-good-luck', 'Occasion', 'gift-card'
-- Occasion, Thank you -->Occasion, Thank You
UNION ALL SELECT 726347103, 'occasion-thank-you', 'Occasion', 'gift-card'
-- Occasion, Thank you teacher -->Occasion, Thank You
UNION ALL SELECT 1143742415, 'occasion-thank-you', 'Occasion', 'gift-card'
-- Occasion, Thinking of you -->Occasion, Thinking of you
UNION ALL SELECT 748511930, 'occasion-thinking-of-you', 'Occasion', 'gift-card'
-- Occasion, Mothersday -->Occasion, Mothers' Day
UNION ALL SELECT 726331722, 'mothers-day', 'Occasion', 'gift-card'
-- Target Group, Boy -->Who's it for?, For Boys
UNION ALL SELECT 886506339, 'for-boys', 'Who''s it for?', 'gift-card'
-- Target Group, Zakelijk1 (cards missions) -->Who's it For?, Colleague
UNION ALL SELECT 1143732725, 'colleague', 'Who''s it For?', 'gift-card'
-- Occasion, Goodbye colleague -->Who's it for?, Colleague
UNION ALL SELECT 1143736110, 'colleague', 'Who''s it for?', 'gift-card'
-- Target Group, Women -->Who's it for?, For Her
UNION ALL SELECT 1143750947, 'for-her', 'Who''s it for?', 'gift-card'
-- Target Group, Girl -->Who's it for?, For Girls
UNION ALL SELECT 886507052, 'for-girls', 'Who''s it for?', 'gift-card'
-- Occasion, Zakelijke kerstgeschenken -->Who's it for?, Colleague
UNION ALL SELECT 1143747560, 'colleague', 'Who''s it for?', 'gift-card'
-- Occasion, Thank you teacher -->Who's it for?, Teacher
UNION ALL SELECT 1143742415, 'teacher', 'Who''s it for?', 'gift-card'
-- Target Group, Men -->Who's it for?, For Him
UNION ALL SELECT 1143750956, 'for-him', 'Who''s it for?', 'gift-card'
-- Target Group, Men -->Age, Adult 25 64 years old
UNION ALL SELECT 1143750956, 'adult-25-64-years-old', 'Age', 'personalised-mug'
-- Target Group, Men -->Age, Senior over 65 years old
UNION ALL SELECT 1143750956, 'senior-over-65-years-old', 'Age', 'personalised-mug'
-- Age, Jongeren 12 to 18 years -->Age, Teen 13 17 years old
UNION ALL SELECT 748494248, 'teen-13-17-years-old', 'Age', 'personalised-mug'
-- Target Group, Women -->Age, Adult 25 64 years old
UNION ALL SELECT 1143750947, 'adult-25-64-years-old', 'Age', 'personalised-mug'
-- Target Group, Women -->Age, Senior over 65 years old
UNION ALL SELECT 1143750947, 'senior-over-65-years-old', 'Age', 'personalised-mug'
-- Age, Kleuter 4 to 6 years -->Age, Kids 2 5 years old
UNION ALL SELECT 742755895, 'kids-2-5-years-old', 'Age', 'personalised-mug'
-- Age, 18 years and older -->Age, Adult 25 64 years old
UNION ALL SELECT 880438645, 'adult-25-64-years-old', 'Age', 'personalised-mug'
-- Age, 18 years and older -->Age, Senior over 65 years old
UNION ALL SELECT 880438645, 'senior-over-65-years-old', 'Age', 'personalised-mug'
-- Age, Peuter 2 to 4 years -->Age, Kids 2 5 years old
UNION ALL SELECT 742755383, 'kids-2-5-years-old', 'Age', 'personalised-mug'
-- Age, 18 years and older -->Age, Young Adult 18 24 years old
UNION ALL SELECT 880438645, 'young-adult-18-24-years-old', 'Age', 'personalised-mug'
-- Brand/Designer, Greetz -->Brands, Greetz
UNION ALL SELECT 726316072, 'greetz', 'Brands', 'personalised-mug'
-- Color, White -->Colour, White
UNION ALL SELECT 1143728193, 'colour-white', 'Colour', 'personalised-mug'
-- Color, Silver -->Colour, Coloured
UNION ALL SELECT 1143728196, 'coloured', 'Colour', 'personalised-mug'
-- Color, Silver -->Colour, Coloured
UNION ALL SELECT 1143728196, 'coloured', 'Colour', 'personalised-mug'
-- Color, Salmon -->Colour, Pink
UNION ALL SELECT 1143728142, 'pink', 'Colour', 'personalised-mug'
-- Color, Pink -->Colour, Pink
UNION ALL SELECT 1143728148, 'pink', 'Colour', 'personalised-mug'
-- Color, Gold -->Colour, Coloured
UNION ALL SELECT 1143728161, 'coloured', 'Colour', 'personalised-mug'
-- Color, Gold -->Colour, Coloured
UNION ALL SELECT 1143728161, 'coloured', 'Colour', 'personalised-mug'
-- Color, Black -->Colour, Black
UNION ALL SELECT 1143728198, 'black', 'Colour', 'personalised-mug'
-- Color, Black -->Colour, Black
UNION ALL SELECT 1143728198, 'black', 'Colour', 'personalised-mug'
-- Color, White -->Colour, White
UNION ALL SELECT 1143728193, 'colour-white', 'Colour', 'personalised-mug'
-- Product Family, MugsL2 -->Home & Garden, Mugs
UNION ALL SELECT 1143730236, 'mugs', 'Home & Garden', 'personalised-mug'
-- Product Family, MugsL2 -->Home & Garden, Mugs
UNION ALL SELECT 1143730236, 'mugs', 'Home & Garden', 'personalised-mug'
-- Product Family, MugsL3 -->Home & Garden, Mugs
UNION ALL SELECT 1143730239, 'mugs', 'Home & Garden', 'personalised-mug'
-- Product Family, MugsL3 -->Home & Garden, Mugs
UNION ALL SELECT 1143730239, 'mugs', 'Home & Garden', 'personalised-mug'
-- Product Family, Gifts -->NewIa, Personalised Gifts
UNION ALL SELECT 727212959, 'personalised-gifts', 'NewIa', 'personalised-mug'
-- Product Family, Gifts -->NewIa, Personalised Gifts
UNION ALL SELECT 727212959, 'personalised-gifts', 'NewIa', 'personalised-mug'
-- Type, Photo and text gifts -->NewIa, Personalised Gifts
UNION ALL SELECT 1143735781, 'personalised-gifts', 'NewIa', 'personalised-mug'
-- Type, Photo and text gifts -->NewIa, Personalised Gifts
UNION ALL SELECT 1143735781, 'personalised-gifts', 'NewIa', 'personalised-mug'
-- Occasion, Thank you teacher -->Occasion, Thank You
UNION ALL SELECT 1143742415, 'occasion-thank-you', 'Occasion', 'personalised-mug'
-- Occasion, Thank you -->Occasion, Thank You
UNION ALL SELECT 726347103, 'occasion-thank-you', 'Occasion', 'personalised-mug'
-- Occasion, Thanks teacher -->Occasion, Thank You
UNION ALL SELECT 1143757148, 'occasion-thank-you', 'Occasion', 'personalised-mug'
-- Occasion, Birth visite -->Occasion, New Baby
UNION ALL SELECT 1143739134, 'occasion-new-baby', 'Occasion', 'personalised-mug'
-- Occasion, Sinterklaas -->Occasion, Sinterklaas
UNION ALL SELECT 726330911, 'saint-nicholas', 'Occasion', 'personalised-mug'
-- Occasion, AOC think -->Occasion, Thinking of you
UNION ALL SELECT 1143742160, 'occasion-thinking-of-you', 'Occasion', 'personalised-mug'
-- Occasion, Valentine -->Occasion, Valentines' Day
UNION ALL SELECT 726324647, 'valentines-day', 'Occasion', 'personalised-mug'
-- Occasion, Birth -->Occasion, New Baby
UNION ALL SELECT 726324202, 'occasion-new-baby', 'Occasion', 'personalised-mug'
-- Occasion, Birthday -->Occasion, Birthday
UNION ALL SELECT 726324105, 'occasion-birthday', 'Occasion', 'personalised-mug'
-- Occasion, Congratulations (card and gift) -->Occasion, Congratulations
UNION ALL SELECT 1143729948, 'occasion-congratulations', 'Occasion', 'personalised-mug'
-- Occasion, Fathersday -->Occasion, Father's Day
UNION ALL SELECT 726332069, 'fathers-day', 'Occasion', 'personalised-mug'
-- Occasion, Friendship2 -->Occasion, Friendship
UNION ALL SELECT 893069562, 'occasion-friendship', 'Occasion', 'personalised-mug'
-- Occasion, Get well -->Occasion, Get Well
UNION ALL SELECT 726345521, 'occasion-get-well', 'Occasion', 'personalised-mug'
-- Occasion, Graduation -->Occasion, Graduation
UNION ALL SELECT 1143729906, 'occasion-graduation', 'Occasion', 'personalised-mug'
-- Occasion, Just because -->Occasion, Just to say
UNION ALL SELECT 726347430, 'just-to-say', 'Occasion', 'personalised-mug'
-- Occasion, Love -->Occasion, Other
UNION ALL SELECT 1143727832, 'occasion-other', 'Occasion', 'personalised-mug'
-- Occasion, Mothersday -->Occasion, Mothers' Day
UNION ALL SELECT 726331722, 'mothers-day', 'Occasion', 'personalised-mug'
-- Occasion, Pregnant -->Occasion, Pregnancy
UNION ALL SELECT 726344253, 'occasion-pregnancy', 'Occasion', 'personalised-mug'
-- Occasion, New home -->Occasion, New Home
UNION ALL SELECT 726342840, 'occasion-new-home', 'Occasion', 'personalised-mug'
-- Occasion, Graduated high school -->Occasion, Graduation
UNION ALL SELECT 748505918, 'occasion-graduation', 'Occasion', 'personalised-mug'
-- Target Group, Boy -->Who's it for?, For Boys
UNION ALL SELECT 886506339, 'for-boys', 'Who''s it for?', 'personalised-mug'
-- Target Group, Girl -->Who's it for?, For Girls
UNION ALL SELECT 886507052, 'for-girls', 'Who''s it for?', 'personalised-mug'
-- Target Group, Men -->Who's it for?, For Him
UNION ALL SELECT 1143750956, 'for-him', 'Who''s it for?', 'personalised-mug'
-- Target Group, Women -->Who's it for?, For Her
UNION ALL SELECT 1143750947, 'for-her', 'Who''s it for?', 'personalised-mug'
-- Target Group, Zakelijk1 (cards missions) -->Who's it For?, Colleague
UNION ALL SELECT 1143732725, 'colleague', 'Who''s it For?', 'personalised-mug'
-- Brand/Designer, Greetz -->Brands, Greetz
UNION ALL SELECT 726316072, 'greetz', 'Brands', 'postcard'
-- Product Family, Cardboxes L3 -->Gift Sets Hampers Letterbox, Letterbox
UNION ALL SELECT 1143763773, 'gift-sets-hampers-letterbox-letterbox', 'Gift Sets Hampers Letterbox', 'postcard'
-- Product Family, Cardboxes L2 -->Gift Sets Hampers Letterbox, Letterbox
UNION ALL SELECT 1143763303, 'gift-sets-hampers-letterbox-letterbox', 'Gift Sets Hampers Letterbox', 'postcard'
-- Product Family, Gifts -->NewIa, Personalised Gifts
UNION ALL SELECT 727212959, 'personalised-gifts', 'NewIa', 'postcard'
-- Occasion, Christmas -->Occasion, Christmas
UNION ALL SELECT 726331358, 'occasion-christmas', 'Occasion', 'postcard'
-- Target Group, Women -->Age, Adult 25 64 years old
UNION ALL SELECT 1143750947, 'adult-25-64-years-old', 'Age', 'sweet'
-- Target Group, Men -->Age, Senior over 65 years old
UNION ALL SELECT 1143750956, 'senior-over-65-years-old', 'Age', 'sweet'
-- Target Group, Women -->Age, Senior over 65 years old
UNION ALL SELECT 1143750947, 'senior-over-65-years-old', 'Age', 'sweet'
-- Target Group, Men -->Age, Adult 25 64 years old
UNION ALL SELECT 1143750956, 'adult-25-64-years-old', 'Age', 'sweet'
-- Brand/Designer, Venco -->Brands, Venco
UNION ALL SELECT 1143754733, 'venco', 'Brands', 'sweet'
-- Brand/Designer, Red Band -->Brands, Red Band
UNION ALL SELECT 1143754730, 'red-band', 'Brands', 'sweet'
-- Brand/Designer, HARIBO -->Brands, HARIBO
UNION ALL SELECT 1143765028, 'haribo', 'Brands', 'sweet'
-- Brand/Designer, Greetz -->Brands, Greetz
UNION ALL SELECT 726316072, 'greetz', 'Brands', 'sweet'
-- Taste, Mix (chocolate) -->Food & Drink, Chocolate
UNION ALL SELECT 1143733285, 'chocolate', 'Food & Drink', 'sweet'
-- Product Family, Chocolate hearts -->Food & Drink, Chocolate
UNION ALL SELECT 1143735387, 'chocolate', 'Food & Drink', 'sweet'
-- Product Family, Chocolate -->Food & Drink, Chocolate
UNION ALL SELECT 726930909, 'chocolate', 'Food & Drink', 'sweet'
-- Product Family, Chocolade met eigen foto of tekst -->Food & Drink, Chocolate
UNION ALL SELECT 1143735399, 'chocolate', 'Food & Drink', 'sweet'
-- Pastry, Donuts -->Food & Drink, Snacks, Treats & Savoury
UNION ALL SELECT 1143736824, 'snacks-treats-savoury', 'Food & Drink', 'sweet'
-- Product Family, Candyjars -->Food & Drink, Sweets
UNION ALL SELECT 1143741739, 'sweets', 'Food & Drink', 'sweet'
-- Product Family, All chocolate -->Food & Drink, Chocolate
UNION ALL SELECT 1143738429, 'chocolate', 'Food & Drink', 'sweet'
-- Pastry, Donuts -->Food & Drink, Cakes & Pastry
UNION ALL SELECT 1143736824, 'cakes-pastry', 'Food & Drink', 'sweet'
-- Product Family, Bonbons -->Food & Drink, Sweets
UNION ALL SELECT 1143735384, 'sweets', 'Food & Drink', 'sweet'
-- Pastry, All pastry -->Food & Drink, Cakes & Pastry
UNION ALL SELECT 1143736593, 'cakes-pastry', 'Food & Drink', 'sweet'
-- Product Family, Cake and Pastry -->Food & Drink, Caskes & Pastry
UNION ALL SELECT 1143736644, 'cakes-pastry', 'Food & Drink', 'sweet'
-- Product Family, Giftboxen -->Gift Sets Hampers Letterbox, Gift Sets
UNION ALL SELECT 1143735393, 'gift-sets-hampers-letterbox-gift-sets', 'Gift Sets Hampers Letterbox', 'sweet'
-- Type, Giftset -->Gift Sets Hampers Letterbox, Gift Sets
UNION ALL SELECT 1143739698, 'gift-sets-hampers-letterbox-gift-sets', 'Gift Sets Hampers Letterbox', 'sweet'
-- Type, Letterbox gifts -->Gift Sets Hampers Letterbox, Letterbox
UNION ALL SELECT 1143737611, 'gift-sets-hampers-letterbox-letterbox', 'Gift Sets Hampers Letterbox', 'sweet'
-- Product Family, Fruit -->NewIa, Food & Drink
UNION ALL SELECT 1143727293, 'food-drink', 'NewIa', 'sweet'
-- Product Family, Eating and drinkingl2 -->NewIa, Food & Drink
UNION ALL SELECT 726930780, 'food-drink', 'NewIa', 'sweet'
-- Type, Photo and text gifts -->NewIa, Personalised Gifts
UNION ALL SELECT 1143735781, 'personalised-gifts', 'NewIa', 'sweet'
-- Product Family, Chocolade met eigen foto of tekst -->NewIa, Personalised Gifts
UNION ALL SELECT 1143735399, 'personalised-gifts', 'NewIa', 'sweet'
-- Product Family, Gifts -->NewIa, Personalised Gifts
UNION ALL SELECT 727212959, 'personalised-gifts', 'NewIa', 'sweet'
-- Occasion, Living together -->Occasion, Other
UNION ALL SELECT 1143727835, 'occasion-other', 'Occasion', 'sweet'
-- Occasion, AOC think -->Occasion, Thinking of you
UNION ALL SELECT 1143742160, 'occasion-thinking-of-you', 'Occasion', 'sweet'
-- Occasion, Anniversary -->Occasion, Anniversaries
UNION ALL SELECT 1143740082, 'anniversaries', 'Occasion', 'sweet'
-- Occasion, Secretaryday -->Occasion, Other
UNION ALL SELECT 1143731240, 'occasion-other', 'Occasion', 'sweet'
-- Occasion, New Job -->Occasion, New Job
UNION ALL SELECT 735872747, 'occasion-new-job', 'Occasion', 'sweet'
-- Occasion, New home -->Occasion, New Home
UNION ALL SELECT 726342840, 'occasion-new-home', 'Occasion', 'sweet'
-- Occasion, Birthday -->Occasion, Birthday
UNION ALL SELECT 726324105, 'occasion-birthday', 'Occasion', 'sweet'
-- Occasion, Love -->Occasion, Other
UNION ALL SELECT 1143727832, 'occasion-other', 'Occasion', 'sweet'
-- Occasion, Thank you teacher -->Occasion, Thank You
UNION ALL SELECT 1143742415, 'occasion-thank-you', 'Occasion', 'sweet'
-- Occasion, Just because -->Occasion, Just to say
UNION ALL SELECT 726347430, 'just-to-say', 'Occasion', 'sweet'
-- Occasion, Graduation -->Occasion, Graduation
UNION ALL SELECT 1143729906, 'occasion-graduation', 'Occasion', 'sweet'
-- Occasion, Mothersday -->Occasion, Mothers' Day
UNION ALL SELECT 726331722, 'mothers-day', 'Occasion', 'sweet'
-- Occasion, Congratulations (card and gift) -->Occasion, Congratulations
UNION ALL SELECT 1143729948, 'occasion-congratulations', 'Occasion', 'sweet'
-- Occasion, Sorry -->Occasion, Sorry
UNION ALL SELECT 726966325, 'occasion-sorry', 'Occasion', 'sweet'
-- Occasion, Thank you -->Occasion, Thank You
UNION ALL SELECT 726347103, 'occasion-thank-you', 'Occasion', 'sweet'
-- Occasion, Fall (Flowers -->Occasion, Other
UNION ALL SELECT 1143732590, 'occasion-other', 'Occasion', 'sweet'
-- Occasion, Thanks teacher -->Occasion, Thank You
UNION ALL SELECT 1143757148, 'occasion-thank-you', 'Occasion', 'sweet'
-- Occasion, Friendship2 -->Occasion, Friendship
UNION ALL SELECT 893069562, 'occasion-friendship', 'Occasion', 'sweet'
-- Occasion, Thinking of you -->Occasion, Thinking of you
UNION ALL SELECT 748511930, 'occasion-thinking-of-you', 'Occasion', 'sweet'
-- Occasion, Get well -->Occasion, Get Well
UNION ALL SELECT 726345521, 'occasion-get-well', 'Occasion', 'sweet'
-- Occasion, Goodbye colleague -->Occasion, Goodbye
UNION ALL SELECT 1143736110, 'goodbye', 'Occasion', 'sweet'
-- Occasion, Wedding -->Occasion, Wedding
UNION ALL SELECT 726342081, 'occasion-wedding', 'Occasion', 'sweet'
-- Occasion, Exams (gifts) -->Occasion, Exams
UNION ALL SELECT 726344432, 'occasion-exams', 'Occasion', 'sweet'
-- Occasion, Goodbye colleague -->Who's it for?, Colleague
UNION ALL SELECT 1143736110, 'colleague', 'Who''s it for?', 'sweet'
-- Target Group, Men -->Who's it for?, For Him
UNION ALL SELECT 1143750956, 'for-him', 'Who''s it for?', 'sweet'
-- Target Group, Father -->Who's it for?, Dad
UNION ALL SELECT 1143739704, 'whos-it-for-dad', 'Who''s it for?', 'sweet'
-- Target Group, Women -->Who's it for?, For Her
UNION ALL SELECT 1143750947, 'for-her', 'Who''s it for?', 'sweet'
-- Target Group, Zakelijk1 (cards missions) -->Who's it For?, Colleague
UNION ALL SELECT 1143732725, 'colleague', 'Who''s it For?', 'sweet'
-- Target Group, Boy -->Who's it for?, For Boys
UNION ALL SELECT 886506339, 'for-boys', 'Who''s it for?', 'sweet'
-- Target Group, Girl -->Who's it for?, For Girls
UNION ALL SELECT 886507052, 'for-girls', 'Who''s it for?', 'sweet'
-- Age, Jongeren 12 to 18 years -->Age, Teen 13 17 years old
UNION ALL SELECT 748494248, 'teen-13-17-years-old', 'Age', 'toy-game'
-- Age, Baby 0 tot 1 year -->Age, Baby 0 1 years old
UNION ALL SELECT 880440481, 'baby-0-1-years-old', 'Age', 'toy-game'
-- Age, Peuter 2 to 4 years -->Age, Kids 2 5 years old
UNION ALL SELECT 742755383, 'kids-2-5-years-old', 'Age', 'toy-game'
-- Age, Kleuter 4 to 6 years -->Age, Kids 2 5 years old
UNION ALL SELECT 742755895, 'kids-2-5-years-old', 'Age', 'toy-game'
-- Age, Kids 6 tot 12 years -->Age, Kids 6 9 years old
UNION ALL SELECT 742758311, 'kids-6-9-years-old', 'Age', 'toy-game'
-- Target Group, Women -->Age, Senior over 65 years old
UNION ALL SELECT 1143750947, 'senior-over-65-years-old', 'Age', 'toy-game'
-- Target Group, Women -->Age, Adult 25 64 years old
UNION ALL SELECT 1143750947, 'adult-25-64-years-old', 'Age', 'toy-game'
-- Target Group, Men -->Age, Senior over 65 years old
UNION ALL SELECT 1143750956, 'senior-over-65-years-old', 'Age', 'toy-game'
-- Target Group, Men -->Age, Adult 25 64 years old
UNION ALL SELECT 1143750956, 'adult-25-64-years-old', 'Age', 'toy-game'
-- Age, Dreumes 1 to 2 years -->Age, Baby 0 1 years old
UNION ALL SELECT 880444402, 'baby-0-1-years-old', 'Age', 'toy-game'
-- Age, Kids 6 tot 12 years -->Age, Tween 9 12 years old
UNION ALL SELECT 742758311, 'tween-9-12-years-old', 'Age', 'toy-game'
-- Brand/Designer, SES -->Brands, SES
UNION ALL SELECT 1143761823, 'ses', 'Brands', 'toy-game'
-- Brand/Designer, Nijntje -->Brands, Nijntje
UNION ALL SELECT 825334736, 'nijntje', 'Brands', 'toy-game'
-- Brand/Designer, Spin Master -->Brands, Spin Master
UNION ALL SELECT 1143769008, 'spin-master', 'Brands', 'toy-game'
-- Brand/Designer, SportX -->Brands, SportX
UNION ALL SELECT 1143769023, 'sportx', 'Brands', 'toy-game'
-- Brand/Designer, TY -->Brands, TY
UNION ALL SELECT 1143734513, 'ty', 'Brands', 'toy-game'
-- Brand/Designer, Van der Meulen -->Brands, Van der Meulen
UNION ALL SELECT 1143768993, 'van-der-meulen', 'Brands', 'toy-game'
-- Brand/Designer, Woezel en Pip -->Brands, Woezel en Pip
UNION ALL SELECT 726305507, 'woezel-en-pip', 'Brands', 'toy-game'
-- Brand/Designer, Done by Deer -->Brands, Done by Deer
UNION ALL SELECT 1143739107, 'done-by-deer', 'Brands', 'toy-game'
-- Brand/Designer, Outdoor Play -->Brands, Outdoor Play
UNION ALL SELECT 1143769028, 'outdoor-play', 'Brands', 'toy-game'
-- Brand/Designer, Janod -->Brands, Janod
UNION ALL SELECT 1143740001, 'janod', 'Brands', 'toy-game'
-- Brand/Designer, Dutch Farm -->Brands, Dutch Farm
UNION ALL SELECT 1143769018, 'dutch-farm', 'Brands', 'toy-game'
-- Brand/Designer, Greetz -->Brands, Greetz
UNION ALL SELECT 726316072, 'greetz', 'Brands', 'toy-game'
-- Brand/Designer, Happy Horse -->Brands, Happy Horse
UNION ALL SELECT 796228368, 'happy-horse', 'Brands', 'toy-game'
-- Brand/Designer, Hasbro Gaming -->Brands, Hasbro Gaming
UNION ALL SELECT 1143742277, 'hasbro-gaming', 'Brands', 'toy-game'
-- Brand/Designer, Paw Patrol -->Brands, Paw Patrol
UNION ALL SELECT 1143741767, 'brands-paw-patrol', 'Brands', 'toy-game'
-- Brand/Designer, Identity Games -->Brands, Identity Games
UNION ALL SELECT 1143742274, 'identity-games', 'Brands', 'toy-game'
-- Brand/Designer, 999 Games -->Brands, 999 Games
UNION ALL SELECT 1143760253, '999-games', 'Brands', 'toy-game'
-- Brand/Designer, Just Formats -->Brands, Just Formats
UNION ALL SELECT 1143769013, 'just-formats', 'Brands', 'toy-game'
-- Brand/Designer, Kikkerland -->Brands, Kikkerland
UNION ALL SELECT 1143767298, 'kikkerland', 'Brands', 'toy-game'
-- Brand/Designer, L.O.L. Surprise -->Brands, L.O.L. Surprise
UNION ALL SELECT 1143761833, 'lol-surprise', 'Brands', 'toy-game'
-- Brand/Designer, Canenco -->Brands, Canenco
UNION ALL SELECT 1143769003, 'canenco', 'Brands', 'toy-game'
-- Brand/Designer, BAMBAM -->Brands, BAMBAM
UNION ALL SELECT 726982765, 'bambam', 'Brands', 'toy-game'
-- Brand/Designer, LEGO -->Brands, Lego
UNION ALL SELECT 1143741803, 'lego', 'Brands', 'toy-game'
-- Brand/Designer, Clementoni -->Brands, Clementoni
UNION ALL SELECT 1143742268, 'clementoni', 'Brands', 'toy-game'
-- Brand/Designer, Clown Games -->Brands, Clown Games
UNION ALL SELECT 1143761828, 'clown-games', 'Brands', 'toy-game'
-- Brand/Designer, Create It! -->Brands, Create It!
UNION ALL SELECT 1143769103, 'create-it', 'Brands', 'toy-game'
-- Brand/Designer, Mattel -->Brands, Mattel
UNION ALL SELECT 1143742319, 'mattel', 'Brands', 'toy-game'
-- Brand/Designer, Little Dutch -->Brands, Little Dutch
UNION ALL SELECT 1143740088, 'little-dutch', 'Brands', 'toy-game'
-- Color, White -->Colour, White
UNION ALL SELECT 1143728193, 'colour-white', 'Colour', 'toy-game'
-- Color, PaleTurquoise -->Colour, Blue
UNION ALL SELECT 1143728180, 'colour-blue', 'Colour', 'toy-game'
-- Color, DeepSkyBlue -->Colour, Blue
UNION ALL SELECT 1143728183, 'colour-blue', 'Colour', 'toy-game'
-- Color, Pink -->Colour, Pink
UNION ALL SELECT 1143728148, 'pink', 'Colour', 'toy-game'
-- Product Family, Gadgets2 -->Games Gadgets & Novelty, Gadgets
UNION ALL SELECT 918645962, 'gadgets', 'Games Gadgets & Novelty', 'toy-game'
-- Product Family, Baby package -->Gift Sets Hampers Letterbox, Gift Sets
UNION ALL SELECT 1143748004, 'gift-sets-hampers-letterbox-gift-sets', 'Gift Sets Hampers Letterbox', 'toy-game'
-- Type, Letterbox gifts -->Gift Sets Hampers Letterbox, Letterbox
UNION ALL SELECT 1143737611, 'gift-sets-hampers-letterbox-letterbox', 'Gift Sets Hampers Letterbox', 'toy-game'
-- Type, Giftset -->Gift Sets Hampers Letterbox, Gift Sets
UNION ALL SELECT 1143739698, 'gift-sets-hampers-letterbox-gift-sets', 'Gift Sets Hampers Letterbox', 'toy-game'
-- Product Family, Living -->Home & Garden, Home Accessories
UNION ALL SELECT 1143766938, 'home-garden-home-accessories', 'Home & Garden', 'toy-game'
-- Product Family, Living -->Home & Garden, Home Accessories
UNION ALL SELECT 1143766938, 'home-accessories', 'Home & Garden', 'toy-game'
-- Product Family, Toys -->NewIa, Toys Kids & Baby
UNION ALL SELECT 1143760248, 'toys-kids-baby', 'NewIa', 'toy-game'
-- Product Family, Books and cards -->NewIa, Books & Stationery
UNION ALL SELECT 1143739215, 'books-stationery', 'NewIa', 'toy-game'
-- Product Family, Baby toys -->NewIa, Toys Kids & Baby
UNION ALL SELECT 1143739059, 'toys-kids-baby', 'NewIa', 'toy-game'
-- Product Family, Baby and kids L2 -->NewIa, Toys Kids & Baby
UNION ALL SELECT 1143739053, 'toys-kids-baby', 'NewIa', 'toy-game'
-- Product Family, Baby and kids -->NewIa, Toys Kids & Baby
UNION ALL SELECT 1143739056, 'toys-kids-baby', 'NewIa', 'toy-game'
-- Product Family, Gifts -->NewIa, Personalised Gifts
UNION ALL SELECT 727212959, 'personalised-gifts', 'NewIa', 'toy-game'
-- Occasion, Sinterklaas -->Occasion, Sinterklaas
UNION ALL SELECT 726330911, 'saint-nicholas', 'Occasion', 'toy-game'
-- Occasion, Babyshower (gifts) -->Occasion, Baby Shower
UNION ALL SELECT 1143742373, 'baby-shower', 'Occasion', 'toy-game'
-- Occasion, Zakelijke kerstgeschenken -->Occasion, Christmas
UNION ALL SELECT 1143747560, 'occasion-christmas', 'Occasion', 'toy-game'
-- Occasion, Valentine -->Occasion, Valentines' Day
UNION ALL SELECT 726324647, 'valentines-day', 'Occasion', 'toy-game'
-- Occasion, Vacation -->Occasion, Bon Voyage
UNION ALL SELECT 1143729435, 'occasion-bon-voyage', 'Occasion', 'toy-game'
-- Occasion, Birth visite -->Occasion, New Baby
UNION ALL SELECT 1143739134, 'occasion-new-baby', 'Occasion', 'toy-game'
-- Occasion, Anniversary -->Occasion, Anniversaries
UNION ALL SELECT 1143740082, 'anniversaries', 'Occasion', 'toy-game'
-- Occasion, Babyshower -->Occasion, Baby Shower
UNION ALL SELECT 1143739143, 'baby-shower', 'Occasion', 'toy-game'
-- Occasion, Babyshower -->Occasion, Baby Shower
UNION ALL SELECT 1143739143, 'baby-shower', 'Occasion', 'toy-game'
-- Occasion, Babyshower -->Occasion, Baby Shower
UNION ALL SELECT 1143739143, 'baby-shower', 'Occasion', 'toy-game'
-- Occasion, Babyshower -->Occasion, Baby Shower
UNION ALL SELECT 1143739143, 'baby-shower', 'Occasion', 'toy-game'
-- Occasion, Baptism and communion (invitations) -->Occasion, Christening
UNION ALL SELECT 1143728949, 'christening', 'Occasion', 'toy-game'
-- Occasion, Baptism and communion (invitations) -->Occasion, Communion
UNION ALL SELECT 1143728949, 'communion', 'Occasion', 'toy-game'
-- Occasion, Birth -->Occasion, New Baby
UNION ALL SELECT 726324202, 'occasion-new-baby', 'Occasion', 'toy-game'
-- Occasion, Retirement -->Occasion, Retirement
UNION ALL SELECT 735873966, 'occasion-retirement', 'Occasion', 'toy-game'
-- Occasion, Birthday -->Occasion, Birthday
UNION ALL SELECT 726324105, 'occasion-birthday', 'Occasion', 'toy-game'
-- Occasion, Brother and Sister day -->Occasion, Other
UNION ALL SELECT 1143732527, 'occasion-other', 'Occasion', 'toy-game'
-- Occasion, Christmas -->Occasion, Christmas
UNION ALL SELECT 726331358, 'occasion-christmas', 'Occasion', 'toy-game'
-- Occasion, Pregnant -->Occasion, Pregnancy
UNION ALL SELECT 726344253, 'occasion-pregnancy', 'Occasion', 'toy-game'
-- Occasion, NewYear (gifts) -->Occasion, New Year
UNION ALL SELECT 1143732695, 'occasion-new-year', 'Occasion', 'toy-game'
-- Occasion, Congratulations (card and gift) -->Occasion, Congratulations
UNION ALL SELECT 1143729948, 'occasion-congratulations', 'Occasion', 'toy-game'
-- Occasion, Day of the animals -->Occasion, Other
UNION ALL SELECT 735910080, 'occasion-other', 'Occasion', 'toy-game'
-- Occasion, New home -->Occasion, New Home
UNION ALL SELECT 726342840, 'occasion-new-home', 'Occasion', 'toy-game'
-- Occasion, Fathersday -->Occasion, Father's Day
UNION ALL SELECT 726332069, 'fathers-day', 'Occasion', 'toy-game'
-- Occasion, Maternity Leave -->Occasion, Pregnancy
UNION ALL SELECT 1143733399, 'occasion-pregnancy', 'Occasion', 'toy-game'
-- Occasion, Get well -->Occasion, Get Well
UNION ALL SELECT 726345521, 'occasion-get-well', 'Occasion', 'toy-game'
-- Product Family, Vehicles -->Toys Kids & Baby, Action Toys
UNION ALL SELECT 1143741559, 'action-toys', 'Toys Kids & Baby', 'toy-game'
-- Product Family, Wooden toy -->Toys Kids & Baby, Wooden Toys
UNION ALL SELECT 1143739065, 'wooden-toys', 'Toys Kids & Baby', 'toy-game'
-- Product Family, Plush toys -->Toys Kids & Baby, Soft Toys
UNION ALL SELECT 1143739200, 'soft-toys', 'Toys Kids & Baby', 'toy-game'
-- Product Family, Wooden puzzels -->Toys Kids & Baby, Games Board games Puzzles
UNION ALL SELECT 1143741571, 'games-board-games-puzzles', 'Toys Kids & Baby', 'toy-game'
-- Product Family, Cuddle clothes -->Toys Kids & Baby, Baby
UNION ALL SELECT 1143740247, 'toys-kids-baby-baby', 'Toys Kids & Baby', 'toy-game'
-- Product Family, Soft plush -->Toys Kids & Baby, Soft Toys
UNION ALL SELECT 1143741583, 'soft-toys', 'Toys Kids & Baby', 'toy-game'
-- Product Family, Rattles -->Toys Kids & Baby, Baby
UNION ALL SELECT 1143748052, 'toys-kids-baby-baby', 'Toys Kids & Baby', 'toy-game'
-- Product Family, Baby package -->Toys Kids & Baby, Baby
UNION ALL SELECT 1143748004, 'toys-kids-baby-baby', 'Toys Kids & Baby', 'toy-game'
-- Product Family, Games and Toys -->Toys Kids & Baby, Games Board games Puzzles
UNION ALL SELECT 1143760233, 'games-board-games-puzzles', 'Toys Kids & Baby', 'toy-game'
-- Product Family, Games -->Toys Kids & Baby, Games Board games Puzzles
UNION ALL SELECT 1143760243, 'games-board-games-puzzles', 'Toys Kids & Baby', 'toy-game'
-- Product Family, Wooden puzzels -->Toys Kids & Baby, Wooden Toys
UNION ALL SELECT 1143741571, 'wooden-toys', 'Toys Kids & Baby', 'toy-game'
-- Target Group, Boy -->Who's it for?, For Boys
UNION ALL SELECT 886506339, 'for-boys', 'Who''s it for?', 'toy-game'
-- Target Group, Girl -->Who's it for?, For Girls
UNION ALL SELECT 886507052, 'for-girls', 'Who''s it for?', 'toy-game'
-- Target Group, Men -->Who's it for?, For Him
UNION ALL SELECT 1143750956, 'for-him', 'Who''s it for?', 'toy-game'
-- Occasion, Zakelijke kerstgeschenken -->Who's it for?, Colleague
UNION ALL SELECT 1143747560, 'colleague', 'Who''s it for?', 'toy-game'
-- Target Group, Women -->Who's it for?, For Her
UNION ALL SELECT 1143750947, 'for-her', 'Who''s it for?', 'toy-game'

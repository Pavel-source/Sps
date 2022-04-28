-- ########################################################################################
-- # This view creates mapped Greetz categories aligned with the categories in Moonpiq.
-- #
-- ########################################################################################

CREATE VIEW greetz_to_mnpq_categories_view AS
-- Age, 18 years and older --> Age, Young Adult 18 24 years old
SELECT 880438645 AS GreetzCategoryID, 'young-adult-18-24-years-old' AS MPCategoryKey, 'Age' AS MPParentName, 'alcohol' AS MPTypeCode
-- Age, 18 years and older --> Age, Senior over 65 years old
UNION ALL SELECT 880438645, 'senior-over-65-years-old', 'Age', 'alcohol'
-- Age, 18 years and older --> Age, Adult 25 64 years old
UNION ALL SELECT 880438645, 'adult-25-64-years-old', 'Age', 'alcohol'
-- Brand/Designer, Boisset --> NULL, NULL
UNION ALL SELECT 1143744948, NULL, NULL, 'alcohol'
-- Brand/Designer, Bokma --> NULL, NULL
UNION ALL SELECT 1143741205, NULL, NULL, 'alcohol'
-- Brand/Designer, Bols --> NULL, NULL
UNION ALL SELECT 1143767868, NULL, NULL, 'alcohol'
-- Brand/Designer, Brouwerij 't IJ --> NULL, NULL
UNION ALL SELECT 1143741992, NULL, NULL, 'alcohol'
-- Brand/Designer, Cornet --> NULL, NULL
UNION ALL SELECT 1143757398, NULL, NULL, 'alcohol'
-- Brand/Designer, Dare To Drink Different --> NULL, NULL
UNION ALL SELECT 1143763468, NULL, NULL, 'alcohol'
-- Brand/Designer, Duc de la Forêt --> NULL, NULL
UNION ALL SELECT 1143751808, NULL, NULL, 'alcohol'
-- Brand/Designer, Duvel --> NULL, NULL
UNION ALL SELECT 1143736021, NULL, NULL, 'alcohol'
-- Brand/Designer, Greetz --> NULL, NULL
UNION ALL SELECT 726316072, NULL, NULL, 'alcohol'
-- Brand/Designer, Hertog Jan --> NULL, NULL
UNION ALL SELECT 1143737074, NULL, NULL, 'alcohol'
-- Brand/Designer, Il Miogusto --> NULL, NULL
UNION ALL SELECT 1143747145, NULL, NULL, 'alcohol'
-- Brand/Designer, Kompaan --> NULL, NULL
UNION ALL SELECT 1143765563, NULL, NULL, 'alcohol'
-- Brand/Designer, La Chouffe --> NULL, NULL
UNION ALL SELECT 1143730644, NULL, NULL, 'alcohol'
-- Brand/Designer, Licor 43 --> NULL, NULL
UNION ALL SELECT 1143741208, NULL, NULL, 'alcohol'
-- Brand/Designer, Lolea --> NULL, NULL
UNION ALL SELECT 1143767863, NULL, NULL, 'alcohol'
-- Brand/Designer, Maluni --> NULL, NULL
UNION ALL SELECT 1143747142, NULL, NULL, 'alcohol'
-- Brand/Designer, Maria Casanovas --> NULL, NULL
UNION ALL SELECT 1143751811, NULL, NULL, 'alcohol'
-- Brand/Designer, Moët en Chandon --> NULL, NULL
UNION ALL SELECT 1143732743, NULL, NULL, 'alcohol'
-- Brand/Designer, Oedipus --> NULL, NULL
UNION ALL SELECT 1143747602, NULL, NULL, 'alcohol'
-- Brand/Designer, Palm --> NULL, NULL
UNION ALL SELECT 1143736024, NULL, NULL, 'alcohol'
-- Brand/Designer, Petit DUC --> NULL, NULL
UNION ALL SELECT 1143747148, NULL, NULL, 'alcohol'
-- Brand/Designer, Pineut --> NULL, NULL
UNION ALL SELECT 1143761123, NULL, NULL, 'alcohol'
-- Brand/Designer, Piper Heidsieck --> Brands, Piper Heidsieck
UNION ALL SELECT 1143732777, 'piper-heidsieck', 'Brands', 'alcohol'
-- Brand/Designer, St. Bernardus --> NULL, NULL
UNION ALL SELECT 1143747266, NULL, NULL, 'alcohol'
-- Brand/Designer, The Flavour Company --> NULL, NULL
UNION ALL SELECT 1143750139, NULL, NULL, 'alcohol'
-- Brand/Designer, Tubes --> NULL, NULL
UNION ALL SELECT 1143745881, NULL, NULL, 'alcohol'
-- Brand/Designer, Villa Massa --> NULL, NULL
UNION ALL SELECT 1143741202, NULL, NULL, 'alcohol'
-- Color, Black --> NULL, NULL
UNION ALL SELECT 1143728198, NULL, NULL, 'alcohol'
-- Color, Brown --> NULL, NULL
UNION ALL SELECT 727095669, NULL, NULL, 'alcohol'
-- Color, Cardinal --> NULL, NULL
UNION ALL SELECT 1143738519, NULL, NULL, 'alcohol'
-- Color, Gray --> NULL, NULL
UNION ALL SELECT 727096150, NULL, NULL, 'alcohol'
-- Color, Mix of colors --> NULL, NULL
UNION ALL SELECT 729235298, NULL, NULL, 'alcohol'
-- Color, PastelPink --> NULL, NULL
UNION ALL SELECT 1143738546, NULL, NULL, 'alcohol'
-- Color, Red --> NULL, NULL
UNION ALL SELECT 1143728144, NULL, NULL, 'alcohol'
-- Color, White --> NULL, NULL
UNION ALL SELECT 1143728193, NULL, NULL, 'alcohol'
-- Grape, Cabernet Sauvignon --> NULL, NULL
UNION ALL SELECT 1143734615, NULL, NULL, 'alcohol'
-- Grape, Carignan --> NULL, NULL
UNION ALL SELECT 1143735916, NULL, NULL, 'alcohol'
-- Grape, Chardonnay --> NULL, NULL
UNION ALL SELECT 1143732860, NULL, NULL, 'alcohol'
-- Grape, Cinsault --> NULL, NULL
UNION ALL SELECT 1143734612, NULL, NULL, 'alcohol'
-- Grape, Garnacha --> NULL, NULL
UNION ALL SELECT 1143737905, NULL, NULL, 'alcohol'
-- Grape, Grenache --> NULL, NULL
UNION ALL SELECT 1143732875, NULL, NULL, 'alcohol'
-- Grape, Macabeo --> NULL, NULL
UNION ALL SELECT 1143737959, NULL, NULL, 'alcohol'
-- Grape, Merlot --> NULL, NULL
UNION ALL SELECT 1143732863, NULL, NULL, 'alcohol'
-- Grape, Parellada --> NULL, NULL
UNION ALL SELECT 1143737953, NULL, NULL, 'alcohol'
-- Grape, Pinot Noir --> NULL, NULL
UNION ALL SELECT 1143732869, NULL, NULL, 'alcohol'
-- Grape, Primitivo --> NULL, NULL
UNION ALL SELECT 1143737935, NULL, NULL, 'alcohol'
-- Grape, Prosecco (grape) --> NULL, NULL
UNION ALL SELECT 1143732872, NULL, NULL, 'alcohol'
-- Grape, Sauvignon Blanc --> NULL, NULL
UNION ALL SELECT 1143732866, NULL, NULL, 'alcohol'
-- Grape, Syrah --> NULL, NULL
UNION ALL SELECT 1143734609, NULL, NULL, 'alcohol'
-- Grape, Tempranillo --> NULL, NULL
UNION ALL SELECT 1143735913, NULL, NULL, 'alcohol'
-- Grape, Verdejo --> NULL, NULL
UNION ALL SELECT 1143737857, NULL, NULL, 'alcohol'
-- Grape, Xarel Lo --> NULL, NULL
UNION ALL SELECT 1143737956, NULL, NULL, 'alcohol'
-- Highlighted, Giftbox: Beverage with chocolate --> NewIa, Gift Sets Hampers Letterbox
UNION ALL SELECT 1143747968, 'newia-gift-sets-hampers-letterbox', 'NewIa', 'alcohol'
-- Highlighted, Giftbox: Beverage with chocolate --> Alcohol, Gift Sets Letterbox
UNION ALL SELECT 1143747968, 'alcohol-gift-sets-letterbox', 'Alcohol', 'alcohol'
-- Highlighted, Giftbox: Beverage with chocolate --> Food & Drink, Chocolate
UNION ALL SELECT 1143747968, 'chocolate', 'Food & Drink', 'alcohol'
-- Highlighted, OTS Wines --> Alcohol, Champagne Prosecco & Wine
UNION ALL SELECT 1143748139, 'champagne-prosecco-wine', 'Alcohol', 'alcohol'
-- Highlighted, Personalised wineboxes --> Alcohol, Champagne Prosecco & Wine
UNION ALL SELECT 1143744696, 'champagne-prosecco-wine', 'Alcohol', 'alcohol'
-- Highlighted, personalised wrapping --> NewIa, Personalised Gifts
UNION ALL SELECT 1143743139, 'personalised-gifts', 'NewIa', 'alcohol'
-- Highlighted, Wijn met eigen etiket --> NewIa, Personalised Gifts
UNION ALL SELECT 1143742496, 'personalised-gifts', 'NewIa', 'alcohol'
-- Highlighted, Wijn met eigen etiket --> Alcohol, Champagne Prosecco & Wine
UNION ALL SELECT 1143742496, 'champagne-prosecco-wine', 'Alcohol', 'alcohol'
-- Occasion, Anniversary --> Occasion, Anniversaries
UNION ALL SELECT 1143740082, 'anniversaries', 'Occasion', 'alcohol'
-- Occasion, AOC think --> Occasion, Thinking of you
UNION ALL SELECT 1143742160, 'occasion-thinking-of-you', 'Occasion', 'alcohol'
-- Occasion, Birthday --> Occasion, Birthday
UNION ALL SELECT 726324105, 'occasion-birthday', 'Occasion', 'alcohol'
-- Occasion, Brother and Sister day --> Occasion, Friendship
UNION ALL SELECT 1143732527, 'occasion-friendship', 'Occasion', 'alcohol'
-- Occasion, Congratulations (card and gift) --> Occasion, Congratulations
UNION ALL SELECT 1143729948, 'occasion-congratulations', 'Occasion', 'alcohol'
-- Occasion, Easter/Pasen --> Occasion, Easter
UNION ALL SELECT 726343205, 'occasion-easter', 'Occasion', 'alcohol'
-- Occasion, Failed --> Occasion, Empathy
UNION ALL SELECT 748506030, 'empathy', 'Occasion', 'alcohol'
-- Occasion, Fathersday --> Occasion, Fathers Day
UNION ALL SELECT 726332069, 'fathers-day', 'Occasion', 'alcohol'
-- Occasion, Friendship2 --> Occasion, Friendship
UNION ALL SELECT 893069562, 'occasion-friendship', 'Occasion', 'alcohol'
-- Occasion, Get well --> Occasion, Get Well
UNION ALL SELECT 726345521, 'occasion-get-well', 'Occasion', 'alcohol'
-- Occasion, Good luck --> Occasion, Good Luck
UNION ALL SELECT 726345736, 'occasion-good-luck', 'Occasion', 'alcohol'
-- Occasion, Goodbye colleague --> Occasion, Goodbye
UNION ALL SELECT 1143736110, 'goodbye', 'Occasion', 'alcohol'
-- Occasion, International boss day --> Occasion, Other
UNION ALL SELECT 1143746905, 'occasion-other', 'Occasion', 'alcohol'
-- Occasion, Just because --> Occasion, Just to say
UNION ALL SELECT 726347430, 'just-to-say', 'Occasion', 'alcohol'
-- Occasion, Living together --> Occasion, New Home
UNION ALL SELECT 1143727835, 'occasion-new-home', 'Occasion', 'alcohol'
-- Occasion, Love --> Occasion, Missing You
UNION ALL SELECT 1143727832, 'missing-you', 'Occasion', 'alcohol'
-- Occasion, Mothersday --> Occasion, Mothers Day
UNION ALL SELECT 726331722, 'mothers-day', 'Occasion', 'alcohol'
-- Occasion, New home --> Occasion, New Home
UNION ALL SELECT 726342840, 'occasion-new-home', 'Occasion', 'alcohol'
-- Occasion, New Job --> Occasion, New Job
UNION ALL SELECT 735872747, 'occasion-new-job', 'Occasion', 'alcohol'
-- Occasion, NewYear (gifts) --> Occasion, New Year
UNION ALL SELECT 1143732695, 'occasion-new-year', 'Occasion', 'alcohol'
-- Occasion, Opening new business --> Occasion, Well Done
UNION ALL SELECT 1143744579, 'occasion-well-done', 'Occasion', 'alcohol'
-- Occasion, Retirement --> Occasion, Retirement
UNION ALL SELECT 735873966, 'occasion-retirement', 'Occasion', 'alcohol'
-- Occasion, Secretaryday --> Occasion, Other
UNION ALL SELECT 1143731240, 'occasion-other', 'Occasion', 'alcohol'
-- Occasion, Sinterklaas --> Occasion, Other
UNION ALL SELECT 726330911, 'occasion-other', 'Occasion', 'alcohol'
-- Occasion, Sorry --> Occasion, Sorry
UNION ALL SELECT 726966325, 'occasion-sorry', 'Occasion', 'alcohol'
-- Occasion, Spring (flowers) --> Occasion, Other
UNION ALL SELECT 1143731093, 'occasion-other', 'Occasion', 'alcohol'
-- Occasion, Summer (flowers) --> Occasion, Other
UNION ALL SELECT 1143731809, 'occasion-other', 'Occasion', 'alcohol'
-- Occasion, Thank you --> Occasion, Thank You
UNION ALL SELECT 726347103, 'occasion-thank-you', 'Occasion', 'alcohol'
-- Occasion, Thank you teacher --> Occasion, Thank You
UNION ALL SELECT 1143742415, 'occasion-thank-you', 'Occasion', 'alcohol'
-- Occasion, Thanks teacher --> Occasion, Thank You
UNION ALL SELECT 1143757148, 'occasion-thank-you', 'Occasion', 'alcohol'
-- Occasion, Thinking of you --> Occasion, Thinking of you
UNION ALL SELECT 748511930, 'occasion-thinking-of-you', 'Occasion', 'alcohol'
-- Occasion, Vacation --> Occasion, Bon Voyage
UNION ALL SELECT 1143729435, 'occasion-bon-voyage', 'Occasion', 'alcohol'
-- Occasion, Valentine --> Occasion, Valentines Day
UNION ALL SELECT 726324647, 'valentines-day', 'Occasion', 'alcohol'
-- Occasion, Wedding --> Occasion, Wedding
UNION ALL SELECT 726342081, 'occasion-wedding', 'Occasion', 'alcohol'
-- Occasion, Work anniversary --> Occasion, Anniversaries
UNION ALL SELECT 1143733543, 'anniversaries', 'Occasion', 'alcohol'
-- Occasion, Zakelijke kerstgeschenken --> Occasion, Christmas
UNION ALL SELECT 1143747560, 'occasion-christmas', 'Occasion', 'alcohol'
-- Origin, Austria --> NULL, NULL
UNION ALL SELECT 1143732836, NULL, NULL, 'alcohol'
-- Origin, Belgium --> NULL, NULL
UNION ALL SELECT 1143747269, NULL, NULL, 'alcohol'
-- Origin, France --> NULL, NULL
UNION ALL SELECT 1143732842, NULL, NULL, 'alcohol'
-- Origin, Italy --> NULL, NULL
UNION ALL SELECT 1143732839, NULL, NULL, 'alcohol'
-- Origin, South Africa --> NULL, NULL
UNION ALL SELECT 1143735134, NULL, NULL, 'alcohol'
-- Origin, Spain --> NULL, NULL
UNION ALL SELECT 1143732833, NULL, NULL, 'alcohol'
-- Origin, The Netherlands --> NULL, NULL
UNION ALL SELECT 1143741223, NULL, NULL, 'alcohol'
-- Product Family, Beer --> Alcohol, Beer & Cider
UNION ALL SELECT 784098536, 'beer-cider', 'Alcohol', 'alcohol'
-- Product Family, Beer package --> Alcohol, Beer & Cider
UNION ALL SELECT 1143731725, 'beer-cider', 'Alcohol', 'alcohol'
-- Product Family, Big bottles --> NULL, NULL
UNION ALL SELECT 1143738085, NULL, NULL, 'alcohol'
-- Product Family, Blond beer --> Beer & Cider, Lager
UNION ALL SELECT 1143732235, 'lager', 'Beer & Cider', 'alcohol'
-- Product Family, Borrelpakketten --> Alcohol, Gift Sets Letterbox
UNION ALL SELECT 1143764328, 'alcohol-gift-sets-letterbox', 'Alcohol', 'alcohol'
-- Product Family, Brown beer --> Beer & Cider, Bitter
UNION ALL SELECT 1143732238, 'bitter', 'Beer & Cider', 'alcohol'
-- Product Family, Cava --> Champagne Prosecco & Wine, Sparkling Wine
UNION ALL SELECT 1143732232, 'sparkling-wine', 'Champagne Prosecco & Wine', 'alcohol'
-- Product Family, Champagne --> Champagne Prosecco & Wine, Champagne
UNION ALL SELECT 1143732229, 'champagne', 'Champagne Prosecco & Wine', 'alcohol'
-- Product Family, Champaign and bubbles --> Champagne Prosecco & Wine, Champagne
UNION ALL SELECT 1143727957, 'champagne', 'Champagne Prosecco & Wine', 'alcohol'
-- Product Family, Cognac --> Alcohol, Other Spirits
UNION ALL SELECT 1143749675, 'other-spirits', 'Alcohol', 'alcohol'
-- Product Family, Drinks --> NewIa, Food & Drink
UNION ALL SELECT 1143727296, 'food-drink', 'NewIa', 'alcohol'
-- Product Family, Eating and drinkingl2 --> NewIa, Food & Drink
UNION ALL SELECT 726930780, 'food-drink', 'NewIa', 'alcohol'
-- Product Family, Gifts --> NewIa, Personalised Gifts
UNION ALL SELECT 727212959, 'personalised-gifts', 'NewIa', 'alcohol'
-- Product Family, Gin --> Alcohol, Gin
UNION ALL SELECT 1143738079, 'gin', 'Alcohol', 'alcohol'
-- Product Family, Jenever --> Alcohol, Other Spirits
UNION ALL SELECT 1143738076, 'other-spirits', 'Alcohol', 'alcohol'
-- Product Family, Likeur --> Gin, Gin Liqueurs
UNION ALL SELECT 1143738067, 'gin-liqueurs', 'Gin', 'alcohol'
-- Product Family, Magnum --> Alcohol, Champagne Prosecco & Wine
UNION ALL SELECT 1143747428, 'champagne-prosecco-wine', 'Alcohol', 'alcohol'
-- Product Family, Magnum wijnfles --> Alcohol, Champagne Prosecco & Wine
UNION ALL SELECT 1143742013, 'champagne-prosecco-wine', 'Alcohol', 'alcohol'
-- Product Family, Mousserend pakket --> Alcohol, Gift Sets Letterbox
UNION ALL SELECT 1143733129, 'alcohol-gift-sets-letterbox', 'Alcohol', 'alcohol'
-- Product Family, Port --> Alcohol, Other Spirits
UNION ALL SELECT 1143731156, 'other-spirits', 'Alcohol', 'alcohol'
-- Product Family, Prosecco --> Champagne Prosecco & Wine, Prosecco
UNION ALL SELECT 1143732226, 'prosecco', 'Champagne Prosecco & Wine', 'alcohol'
-- Product Family, Red wine --> Champagne Prosecco & Wine, Red wine
UNION ALL SELECT 784103211, 'red-wine', 'Champagne Prosecco & Wine', 'alcohol'
-- Product Family, Rose wine --> Champagne Prosecco & Wine, Rose wine
UNION ALL SELECT 784102414, 'rose-wine', 'Champagne Prosecco & Wine', 'alcohol'
-- Product Family, Rum --> Alcohol, Other Spirits
UNION ALL SELECT 1143738082, 'other-spirits', 'Alcohol', 'alcohol'
-- Product Family, Sparkling wine --> Champagne Prosecco & Wine, Sparkling Wine
UNION ALL SELECT 1143747022, 'sparkling-wine', 'Champagne Prosecco & Wine', 'alcohol'
-- Product Family, Spirits --> Alcohol, Other Spirits
UNION ALL SELECT 1143737164, 'other-spirits', 'Alcohol', 'alcohol'
-- Product Family, Whisky --> Alcohol, Whiskey
UNION ALL SELECT 1143738070, 'whiskey', 'Alcohol', 'alcohol'
-- Product Family, White wine --> Champagne Prosecco & Wine, White wine
UNION ALL SELECT 784100994, 'white-wine', 'Champagne Prosecco & Wine', 'alcohol'
-- Product Family, Wijncocktail --> Alcohol, Other Spirits
UNION ALL SELECT 1143741187, 'other-spirits', 'Alcohol', 'alcohol'
-- Product Family, Wine --> Alcohol, Champagne Prosecco & Wine
UNION ALL SELECT 899226515, 'champagne-prosecco-wine', 'Alcohol', 'alcohol'
-- Product Family, Wine package --> Alcohol, Gift Sets Letterbox
UNION ALL SELECT 1143733025, 'alcohol-gift-sets-letterbox', 'Alcohol', 'alcohol'
-- Size, 80 --> NULL, NULL
UNION ALL SELECT 1143728278, NULL, NULL, 'alcohol'
-- Target Group, Colleague --> Who's it for?, Colleague
UNION ALL SELECT 1143742085, 'colleague', 'Whos it for?', 'alcohol'
-- Target Group, Men --> Who's it for?, For Him
UNION ALL SELECT 1143750956, 'for-him', 'Whos it for?', 'alcohol'
-- Target Group, Sister --> Who's it for?, Sister
UNION ALL SELECT 1143742574, 'whos-it-for-sister', 'Whos it for?', 'alcohol'
-- Target Group, Women --> Who's it for?, For Her
UNION ALL SELECT 1143750947, 'for-her', 'Whos it for?', 'alcohol'
-- Target Group, Zakelijk1 (cards missions) --> Who's it For?, Other
UNION ALL SELECT 1143732725, 'newia-gift-experiences-whos-it-for-other', 'Whos it For?', 'alcohol'
-- Taste, Almond --> NULL, NULL
UNION ALL SELECT 1143734639, NULL, NULL, 'alcohol'
-- Taste, Fris --> NULL, NULL
UNION ALL SELECT 1143732845, NULL, NULL, 'alcohol'
-- Taste, Red: full and power --> NULL, NULL
UNION ALL SELECT 1143738046, NULL, NULL, 'alcohol'
-- Taste, Red: light and fruity --> NULL, NULL
UNION ALL SELECT 1143738043, NULL, NULL, 'alcohol'
-- Taste, Red: spicy --> NULL, NULL
UNION ALL SELECT 1143738049, NULL, NULL, 'alcohol'
-- Taste, Red: supple and round --> NULL, NULL
UNION ALL SELECT 1143738040, NULL, NULL, 'alcohol'
-- Taste, Rosé: fresh and fruity --> NULL, NULL
UNION ALL SELECT 1143738052, NULL, NULL, 'alcohol'
-- Taste, White: dry --> NULL, NULL
UNION ALL SELECT 1143738037, NULL, NULL, 'alcohol'
-- Taste, White: Fresh and fruity --> NULL, NULL
UNION ALL SELECT 1143738025, NULL, NULL, 'alcohol'
-- Taste, White: full and round --> NULL, NULL
UNION ALL SELECT 1143738028, NULL, NULL, 'alcohol'
-- Taste, White: sweet --> NULL, NULL
UNION ALL SELECT 1143738031, NULL, NULL, 'alcohol'
-- Taste, Zoet --> NULL, NULL
UNION ALL SELECT 1143732854, NULL, NULL, 'alcohol'
-- Theme, Autumn wines --> NULL, NULL
UNION ALL SELECT 1143738061, NULL, NULL, 'alcohol'
-- Theme, Spring drinks --> NULL, NULL
UNION ALL SELECT 1143734337, NULL, NULL, 'alcohol'
-- Theme, Summer Drinks --> NULL, NULL
UNION ALL SELECT 1143734867, NULL, NULL, 'alcohol'
-- Theme, Winter wines --> NULL, NULL
UNION ALL SELECT 1143738504, NULL, NULL, 'alcohol'
-- Type, Giftset --> Gift Sets Hampers Letterbox, Gift Sets
UNION ALL SELECT 1143739698, 'gift-sets-hampers-letterbox-gift-sets', 'Gift Sets Hampers Letterbox', 'alcohol'
-- Type, nonalcohol --> NULL, NULL
UNION ALL SELECT 1143765348, NULL, NULL, 'alcohol'
-- Type, Photo and text gifts --> NewIa, Personalised Gifts
UNION ALL SELECT 1143735781, 'personalised-gifts', 'NewIa', 'alcohol'
-- Type, Tasting --> NewIa, Food & Drink
UNION ALL SELECT 1143741766, 'food-drink', 'NewIa', 'alcohol'
-- Age, 18 years and older --> Age, Young Adult 18 24 years old
UNION ALL SELECT 880438645, 'young-adult-18-24-years-old', 'Age', 'balloon'
-- Age, 18 years and older --> Age, Adult 25 64 years old
UNION ALL SELECT 880438645, 'adult-25-64-years-old', 'Age', 'balloon'
-- Age, 18 years and older --> Age, Senior over 65 years old
UNION ALL SELECT 880438645, 'senior-over-65-years-old', 'Age', 'balloon'
-- Age, Baby 0 tot 1 year --> Age, Baby 0 1 years old
UNION ALL SELECT 880440481, 'baby-0-1-years-old', 'Age', 'balloon'
-- Age, Dreumes 1 to 2 years --> Age, Baby 0 1 years old
UNION ALL SELECT 880444402, 'baby-0-1-years-old', 'Age', 'balloon'
-- Age, Jongeren 12 to 18 years --> Age, Teen 13 17 years old
UNION ALL SELECT 748494248, 'teen-13-17-years-old', 'Age', 'balloon'
-- Age, Kids 6 tot 12 years --> Age, Kids 6 9 years old
UNION ALL SELECT 742758311, 'kids-6-9-years-old', 'Age', 'balloon'
-- Age, Kids 6 tot 12 years --> Age, Tween 9 12 years old
UNION ALL SELECT 742758311, 'tween-9-12-years-old', 'Age', 'balloon'
-- Age, Kleuter 4 to 6 years --> Age, Kids 2 5 years old
UNION ALL SELECT 742755895, 'kids-2-5-years-old', 'Age', 'balloon'
-- Age, Peuter 2 to 4 years --> Age, Kids 2 5 years old
UNION ALL SELECT 742755383, 'kids-2-5-years-old', 'Age', 'balloon'
-- Brand/Designer, Greetz --> NULL, NULL
UNION ALL SELECT 726316072, NULL, NULL, 'balloon'
-- Brand/Designer, Paw Patrol --> Brands, Paw Patrol
UNION ALL SELECT 1143741767, 'brands-paw-patrol', 'Brands', 'balloon'
-- Color, Black --> Colour, Black
UNION ALL SELECT 1143728198, 'black', 'Colour', 'balloon'
-- Color, Blue --> Colour, Blue
UNION ALL SELECT 1143728186, 'colour-blue', 'Colour', 'balloon'
-- Color, Brown --> Colour, Coloured
UNION ALL SELECT 727095669, 'coloured', 'Colour', 'balloon'
-- Color, DeepSkyBlue --> Colour, Blue
UNION ALL SELECT 1143728183, 'colour-blue', 'Colour', 'balloon'
-- Color, Gold --> Colour, Coloured
UNION ALL SELECT 1143728161, 'coloured', 'Colour', 'balloon'
-- Color, Gray --> Colour, Coloured
UNION ALL SELECT 727096150, 'coloured', 'Colour', 'balloon'
-- Color, Hibiscus --> Colour, Coloured
UNION ALL SELECT 1143738552, 'coloured', 'Colour', 'balloon'
-- Color, HotPink --> Colour, Pink
UNION ALL SELECT 1143728149, 'pink', 'Colour', 'balloon'
-- Color, LightSkyBlue --> Colour, Blue
UNION ALL SELECT 1143728182, 'colour-blue', 'Colour', 'balloon'
-- Color, MidnightBlue --> Colour, Blue
UNION ALL SELECT 1143728187, 'colour-blue', 'Colour', 'balloon'
-- Color, Mix of colors --> Colour, Multicolour
UNION ALL SELECT 729235298, 'multicolour', 'Colour', 'balloon'
-- Color, PaleTurquoise --> Colour, Blue
UNION ALL SELECT 1143728180, 'colour-blue', 'Colour', 'balloon'
-- Color, Pink --> Colour, Pink
UNION ALL SELECT 1143728148, 'pink', 'Colour', 'balloon'
-- Color, Raffia --> Colour, Coloured
UNION ALL SELECT 1143738555, 'coloured', 'Colour', 'balloon'
-- Color, Red --> Colour, Coloured
UNION ALL SELECT 1143728144, 'coloured', 'Colour', 'balloon'
-- Color, White --> Colour, White
UNION ALL SELECT 1143728193, 'colour-white', 'Colour', 'balloon'
-- Color, Yellow --> Colour, Coloured
UNION ALL SELECT 1143728162, 'coloured', 'Colour', 'balloon'
-- Occasion, Anniversary --> Occasion, Anniversaries
UNION ALL SELECT 1143740082, 'anniversaries', 'Occasion', 'balloon'
-- Occasion, AOC think --> Occasion, Thinking of you
UNION ALL SELECT 1143742160, 'occasion-thinking-of-you', 'Occasion', 'balloon'
-- Occasion, Babyshower --> Occasion, Baby Shower
UNION ALL SELECT 1143739143, 'baby-shower', 'Occasion', 'balloon'
-- Occasion, Birth --> Occasion, New Baby
UNION ALL SELECT 726324202, 'occasion-new-baby', 'Occasion', 'balloon'
-- Occasion, Birth visite --> Occasion, New Baby
UNION ALL SELECT 1143739134, 'occasion-new-baby', 'Occasion', 'balloon'
-- Occasion, Birthday --> Occasion, Birthday
UNION ALL SELECT 726324105, 'occasion-birthday', 'Occasion', 'balloon'
-- Occasion, Brother and Sister day --> Occasion, Friendship
UNION ALL SELECT 1143732527, 'occasion-friendship', 'Occasion', 'balloon'
-- Occasion, Christmas --> Occasion, Christmas
UNION ALL SELECT 726331358, 'occasion-christmas', 'Occasion', 'balloon'
-- Occasion, Congratulations (card and gift) --> Occasion, Congratulations
UNION ALL SELECT 1143729948, 'occasion-congratulations', 'Occasion', 'balloon'
-- Occasion, Engaged --> Occasion, Engagement
UNION ALL SELECT 735870409, 'occasion-engagement', 'Occasion', 'balloon'
-- Occasion, Failed --> Occasion, Empathy
UNION ALL SELECT 748506030, 'empathy', 'Occasion', 'balloon'
-- Occasion, Fathersday --> Occasion, Fathers Day
UNION ALL SELECT 726332069, 'fathers-day', 'Occasion', 'balloon'
-- Occasion, Friendship2 --> Occasion, Friendship
UNION ALL SELECT 893069562, 'occasion-friendship', 'Occasion', 'balloon'
-- Occasion, Gay marriage --> Who's it for?, LGBTQ+
UNION ALL SELECT 1143732593, 'whos-it-for-lgbtq', 'Whos it for?', 'balloon'
-- Occasion, Gay marriage --> Sentiment & Style, LGBTQ+
UNION ALL SELECT 1143732593, 'lgbtq', 'Sentiment & Style', 'balloon'
-- Occasion, Get well --> Occasion, Get Well
UNION ALL SELECT 726345521, 'occasion-get-well', 'Occasion', 'balloon'
-- Occasion, Good luck --> Occasion, Good Luck
UNION ALL SELECT 726345736, 'occasion-good-luck', 'Occasion', 'balloon'
-- Occasion, Graduation --> Occasion, Graduation
UNION ALL SELECT 1143729906, 'occasion-graduation', 'Occasion', 'balloon'
-- Occasion, Just because --> Occasion, Just to say
UNION ALL SELECT 726347430, 'just-to-say', 'Occasion', 'balloon'
-- Occasion, Just Married --> Occasion, Wedding
UNION ALL SELECT 1143732220, 'occasion-wedding', 'Occasion', 'balloon'
-- Occasion, Love --> Occasion, Missing You
UNION ALL SELECT 1143727832, 'missing-you', 'Occasion', 'balloon'
-- Occasion, Mothersday --> Occasion, Mothers Day
UNION ALL SELECT 726331722, 'mothers-day', 'Occasion', 'balloon'
-- Occasion, New home --> Occasion, New Home
UNION ALL SELECT 726342840, 'occasion-new-home', 'Occasion', 'balloon'
-- Occasion, New Job --> Occasion, New Job
UNION ALL SELECT 735872747, 'occasion-new-job', 'Occasion', 'balloon'
-- Occasion, NewYear (gifts) --> Occasion, New Year
UNION ALL SELECT 1143732695, 'occasion-new-year', 'Occasion', 'balloon'
-- Occasion, Pregnant --> Occasion, Pregnancy
UNION ALL SELECT 726344253, 'occasion-pregnancy', 'Occasion', 'balloon'
-- Occasion, Registered partnership --> Occasion, Congratulations
UNION ALL SELECT 1143754619, 'occasion-congratulations', 'Occasion', 'balloon'
-- Occasion, Secretaryday --> Occasion, Other
UNION ALL SELECT 1143731240, 'occasion-other', 'Occasion', 'balloon'
-- Occasion, Sinterklaas --> Occasion, Other
UNION ALL SELECT 726330911, 'occasion-other', 'Occasion', 'balloon'
-- Occasion, Sorry --> Occasion, Sorry
UNION ALL SELECT 726966325, 'occasion-sorry', 'Occasion', 'balloon'
-- Occasion, Swimming diploma --> Occasion, Well Done
UNION ALL SELECT 1143742376, 'occasion-well-done', 'Occasion', 'balloon'
-- Occasion, Thank you --> Occasion, Thank You
UNION ALL SELECT 726347103, 'occasion-thank-you', 'Occasion', 'balloon'
-- Occasion, Thank you teacher --> Occasion, Thank You
UNION ALL SELECT 1143742415, 'occasion-thank-you', 'Occasion', 'balloon'
-- Occasion, Thanks teacher --> Occasion, Thank You
UNION ALL SELECT 1143757148, 'occasion-thank-you', 'Occasion', 'balloon'
-- Occasion, Thinking of you --> Occasion, Thinking of you
UNION ALL SELECT 748511930, 'occasion-thinking-of-you', 'Occasion', 'balloon'
-- Occasion, Valentine --> Occasion, Valentines Day
UNION ALL SELECT 726324647, 'valentines-day', 'Occasion', 'balloon'
-- Occasion, Wedding --> Occasion, Wedding
UNION ALL SELECT 726342081, 'occasion-wedding', 'Occasion', 'balloon'
-- Occasion, Wedding Anniversary --> Occasion, Anniversaries
UNION ALL SELECT 735870898, 'anniversaries', 'Occasion', 'balloon'
-- Occasion, Zakelijke kerstgeschenken --> Occasion, Christmas
UNION ALL SELECT 1143747560, 'occasion-christmas', 'Occasion', 'balloon'
-- Product Family, Animal balloons --> NULL, NULL
UNION ALL SELECT 1133689324, NULL, NULL, 'balloon'
-- Product Family, Balloon bouquets --> Balloons, Balloons Bouquets
UNION ALL SELECT 1143734369, 'balloons-bouquets', 'Balloons', 'balloon'
-- Product Family, Balloons --> NewIa, Balloons
UNION ALL SELECT 726962862, 'newia-balloons', 'NewIa', 'balloon'
-- Product Family, BalloonsL2 --> NewIa, Balloons
UNION ALL SELECT 855728876, 'newia-balloons', 'NewIa', 'balloon'
-- Product Family, Foil balloons --> NULL, NULL
UNION ALL SELECT 1143732506, NULL, NULL, 'balloon'
-- Product Family, Gifts --> NewIa, Personalised Gifts
UNION ALL SELECT 727212959, 'personalised-gifts', 'NewIa', 'balloon'
-- Product Family, Number balloons --> Balloons, Number Balloons
UNION ALL SELECT 1081751054, 'number-balloons', 'Balloons', 'balloon'
-- Product Family, Standard balloons --> Balloons, Plain Balloons
UNION ALL SELECT 1143742076, 'plain-balloons', 'Balloons', 'balloon'
-- Product Family, XXL balloons --> Balloons, Giant Balloons
UNION ALL SELECT 1143735432, 'giant-balloons', 'Balloons', 'balloon'
-- Ratio, Cubeshape --> NULL, NULL
UNION ALL SELECT 1143728320, NULL, NULL, 'balloon'
-- Ratio, Heartshaped --> NULL, NULL
UNION ALL SELECT 1143735832, NULL, NULL, 'balloon'
-- Ratio, Round --> NULL, NULL
UNION ALL SELECT 1143735835, NULL, NULL, 'balloon'
-- Ratio, Special shapes --> NULL, NULL
UNION ALL SELECT 1143735838, NULL, NULL, 'balloon'
-- Size, 80 --> NULL, NULL
UNION ALL SELECT 1143728278, NULL, NULL, 'balloon'
-- Size, Enkele ballon --> NULL, NULL
UNION ALL SELECT 1143761153, NULL, NULL, 'balloon'
-- Size, Medium --> NULL, NULL
UNION ALL SELECT 1143728308, NULL, NULL, 'balloon'
-- Size, Tros --> NULL, NULL
UNION ALL SELECT 1143761148, NULL, NULL, 'balloon'
-- Target Group, Boy --> Who's it for?, For Boys
UNION ALL SELECT 886506339, 'for-boys', 'Whos it for?', 'balloon'
-- Target Group, Brother --> Who's it for?, Brother
UNION ALL SELECT 1143742571, 'whos-it-for-brother', 'Whos it for?', 'balloon'
-- Target Group, Girl --> Who's it for?, For Girls
UNION ALL SELECT 886507052, 'for-girls', 'Whos it for?', 'balloon'
-- Target Group, Men --> Who's it for?, For Him
UNION ALL SELECT 1143750956, 'for-him', 'Whos it for?', 'balloon'
-- Target Group, Sister --> Who's it for?, Sister
UNION ALL SELECT 1143742574, 'whos-it-for-sister', 'Whos it for?', 'balloon'
-- Target Group, Women --> Who's it for?, For Her
UNION ALL SELECT 1143750947, 'for-her', 'Whos it for?', 'balloon'
-- Target Group, Zakelijk1 (cards missions) --> Who's it For?, Other
UNION ALL SELECT 1143732725, 'newia-gift-experiences-whos-it-for-other', 'Whos it For?', 'balloon'
-- Theme, Age balloons --> NULL, NULL
UNION ALL SELECT 1143742247, NULL, NULL, 'balloon'
-- Theme, Animals (cards missions) --> NULL, NULL
UNION ALL SELECT 1143727287, NULL, NULL, 'balloon'
-- Theme, Disney (balloons) --> NULL, NULL
UNION ALL SELECT 1143742208, NULL, NULL, 'balloon'
-- Theme, Dutch (balloons) --> NULL, NULL
UNION ALL SELECT 1143742223, NULL, NULL, 'balloon'
-- Theme, Smileys (balloons) --> NULL, NULL
UNION ALL SELECT 1143742205, NULL, NULL, 'balloon'
-- Age, 18 years and older --> Age, Adult 25 64 years old
UNION ALL SELECT 880438645, 'adult-25-64-years-old', 'Age', 'beauty'
-- Age, 18 years and older --> Age, Senior over 65 years old
UNION ALL SELECT 880438645, 'senior-over-65-years-old', 'Age', 'beauty'
-- Age, 18 years and older --> Age, Young Adult 18 24 years old
UNION ALL SELECT 880438645, 'young-adult-18-24-years-old', 'Age', 'beauty'
-- Age, Jongeren 12 to 18 years --> Age, Teen 13 17 years old
UNION ALL SELECT 748494248, 'teen-13-17-years-old', 'Age', 'beauty'
-- Brand/Designer, 100 procent Leuk --> NULL, NULL
UNION ALL SELECT 1143748292, NULL, NULL, 'beauty'
-- Brand/Designer, Cacharel --> NULL, NULL
UNION ALL SELECT 1143768358, NULL, NULL, 'beauty'
-- Brand/Designer, Calvin Klein --> Brands, Calvin Klein
UNION ALL SELECT 1143768348, 'calvin-klein', 'Brands', 'beauty'
-- Brand/Designer, Casuelle --> NULL, NULL
UNION ALL SELECT 1143767893, NULL, NULL, 'beauty'
-- Brand/Designer, Chopard --> NULL, NULL
UNION ALL SELECT 1143768363, NULL, NULL, 'beauty'
-- Brand/Designer, Davidoff --> Brands, Davidoff
UNION ALL SELECT 1143768368, 'davidoff', 'Brands', 'beauty'
-- Brand/Designer, Dolce and Gabbana --> NULL, NULL
UNION ALL SELECT 1143768353, NULL, NULL, 'beauty'
-- Brand/Designer, HappySoaps --> NULL, NULL
UNION ALL SELECT 1143769283, NULL, NULL, 'beauty'
-- Brand/Designer, Hugo Boss --> Brands, Hugo Boss
UNION ALL SELECT 1143768343, 'hugo-boss', 'Brands', 'beauty'
-- Brand/Designer, Janzen --> NULL, NULL
UNION ALL SELECT 1143756595, NULL, NULL, 'beauty'
-- Brand/Designer, Joop! --> NULL, NULL
UNION ALL SELECT 1143768373, NULL, NULL, 'beauty'
-- Brand/Designer, Kneipp --> NULL, NULL
UNION ALL SELECT 1143733099, NULL, NULL, 'beauty'
-- Brand/Designer, Kocostar --> NULL, NULL
UNION ALL SELECT 1143747178, NULL, NULL, 'beauty'
-- Brand/Designer, My Jewellery --> NULL, NULL
UNION ALL SELECT 1143766933, NULL, NULL, 'beauty'
-- Brand/Designer, Naif --> NULL, NULL
UNION ALL SELECT 1143739110, NULL, NULL, 'beauty'
-- Brand/Designer, Riverdale --> NULL, NULL
UNION ALL SELECT 1143755877, NULL, NULL, 'beauty'
-- Brand/Designer, Source Balance --> NULL, NULL
UNION ALL SELECT 1143767928, NULL, NULL, 'beauty'
-- Brand/Designer, The Gift Label --> NULL, NULL
UNION ALL SELECT 1143744837, NULL, NULL, 'beauty'
-- Color, Mix of colors --> Colour, Multicolour
UNION ALL SELECT 729235298, 'multicolour', 'Colour', 'beauty'
-- Occasion, Anniversary --> Occasion, Anniversaries
UNION ALL SELECT 1143740082, 'anniversaries', 'Occasion', 'beauty'
-- Occasion, AOC think --> Occasion, Thinking of you
UNION ALL SELECT 1143742160, 'occasion-thinking-of-you', 'Occasion', 'beauty'
-- Occasion, Babyshower --> Occasion, Baby Shower
UNION ALL SELECT 1143739143, 'baby-shower', 'Occasion', 'beauty'
-- Occasion, Birth --> Occasion, New Baby
UNION ALL SELECT 726324202, 'occasion-new-baby', 'Occasion', 'beauty'
-- Occasion, Birthday --> Occasion, Birthday
UNION ALL SELECT 726324105, 'occasion-birthday', 'Occasion', 'beauty'
-- Occasion, Birthday invitation (invitations) --> Occasion, Birthday
UNION ALL SELECT 1143728925, 'occasion-birthday', 'Occasion', 'beauty'
-- Occasion, Brother and Sister day --> Occasion, Friendship
UNION ALL SELECT 1143732527, 'occasion-friendship', 'Occasion', 'beauty'
-- Occasion, Christmas --> Occasion, Christmas
UNION ALL SELECT 726331358, 'occasion-christmas', 'Occasion', 'beauty'
-- Occasion, Condolence --> Occasion, Sympathy
UNION ALL SELECT 726345401, 'occasion-sympathy', 'Occasion', 'beauty'
-- Occasion, Congratulations (card and gift) --> Occasion, Congratulations
UNION ALL SELECT 1143729948, 'occasion-congratulations', 'Occasion', 'beauty'
-- Occasion, Driving License graduated --> Occasion, Driving Test
UNION ALL SELECT 735934096, 'occasion-driving-test', 'Occasion', 'beauty'
-- Occasion, Exams (gifts) --> Occasion, Exams
UNION ALL SELECT 726344432, 'occasion-exams', 'Occasion', 'beauty'
-- Occasion, Failed --> Occasion, Empathy
UNION ALL SELECT 748506030, 'empathy', 'Occasion', 'beauty'
-- Occasion, Fathersday --> Occasion, Fathers Day
UNION ALL SELECT 726332069, 'fathers-day', 'Occasion', 'beauty'
-- Occasion, Friendship2 --> Occasion, Friendship
UNION ALL SELECT 893069562, 'occasion-friendship', 'Occasion', 'beauty'
-- Occasion, Get well --> Occasion, Get Well
UNION ALL SELECT 726345521, 'occasion-get-well', 'Occasion', 'beauty'
-- Occasion, Get well welcome home --> Occasion, Get Well
UNION ALL SELECT 1143742088, 'occasion-get-well', 'Occasion', 'beauty'
-- Occasion, Good luck --> Occasion, Good Luck
UNION ALL SELECT 726345736, 'occasion-good-luck', 'Occasion', 'beauty'
-- Occasion, Goodbye colleague --> Occasion, Goodbye
UNION ALL SELECT 1143736110, 'goodbye', 'Occasion', 'beauty'
-- Occasion, Graduated high school --> Occasion, Graduation
UNION ALL SELECT 748505918, 'occasion-graduation', 'Occasion', 'beauty'
-- Occasion, Graduation --> Occasion, Graduation
UNION ALL SELECT 1143729906, 'occasion-graduation', 'Occasion', 'beauty'
-- Occasion, Just because --> Occasion, Just to say
UNION ALL SELECT 726347430, 'just-to-say', 'Occasion', 'beauty'
-- Occasion, Living together --> Occasion, New Home
UNION ALL SELECT 1143727835, 'occasion-new-home', 'Occasion', 'beauty'
-- Occasion, Love --> Occasion, Missing You
UNION ALL SELECT 1143727832, 'missing-you', 'Occasion', 'beauty'
-- Occasion, Maternity Leave --> Occasion, Pregnancy
UNION ALL SELECT 1143733399, 'occasion-pregnancy', 'Occasion', 'beauty'
-- Occasion, Mothersday --> Occasion, Mothers Day
UNION ALL SELECT 726331722, 'mothers-day', 'Occasion', 'beauty'
-- Occasion, New home --> Occasion, New Home
UNION ALL SELECT 726342840, 'occasion-new-home', 'Occasion', 'beauty'
-- Occasion, New Job --> Occasion, New Job
UNION ALL SELECT 735872747, 'occasion-new-job', 'Occasion', 'beauty'
-- Occasion, Pregnant --> Occasion, Pregnancy
UNION ALL SELECT 726344253, 'occasion-pregnancy', 'Occasion', 'beauty'
-- Occasion, re exam --> Occasion, Exams
UNION ALL SELECT 1143742355, 'occasion-exams', 'Occasion', 'beauty'
-- Occasion, Sinterklaas --> Occasion, Other
UNION ALL SELECT 726330911, 'occasion-other', 'Occasion', 'beauty'
-- Occasion, Sorry --> Occasion, Sorry
UNION ALL SELECT 726966325, 'occasion-sorry', 'Occasion', 'beauty'
-- Occasion, Thank you --> Occasion, Thank You
UNION ALL SELECT 726347103, 'occasion-thank-you', 'Occasion', 'beauty'
-- Occasion, Thank you teacher --> Occasion, Thank You
UNION ALL SELECT 1143742415, 'occasion-thank-you', 'Occasion', 'beauty'
-- Occasion, Thinking of you --> Occasion, Thinking of you
UNION ALL SELECT 748511930, 'occasion-thinking-of-you', 'Occasion', 'beauty'
-- Occasion, Travelling --> Occasion, Bon Voyage
UNION ALL SELECT 1143731911, 'occasion-bon-voyage', 'Occasion', 'beauty'
-- Occasion, Vacation --> Occasion, Bon Voyage
UNION ALL SELECT 1143729435, 'occasion-bon-voyage', 'Occasion', 'beauty'
-- Occasion, Vacation welcome home --> Occasion, Welcome Home
UNION ALL SELECT 726965369, 'welcome-home', 'Occasion', 'beauty'
-- Occasion, Valentine --> Occasion, Valentines Day
UNION ALL SELECT 726324647, 'valentines-day', 'Occasion', 'beauty'
-- Occasion, Wedding --> Occasion, Wedding
UNION ALL SELECT 726342081, 'occasion-wedding', 'Occasion', 'beauty'
-- Occasion, Zakelijke kerstgeschenken --> Occasion, Christmas
UNION ALL SELECT 1143747560, 'occasion-christmas', 'Occasion', 'beauty'
-- Product Family, Beauty --> NewIa, Beauty Face & Body
UNION ALL SELECT 1143727993, 'beauty-face-body', 'NewIa', 'beauty'
-- Product Family, Beauty and careL2 --> NewIa, Beauty Face & Body
UNION ALL SELECT 726960191, 'beauty-face-body', 'NewIa', 'beauty'
-- Product Family, Body cream --> NULL, NULL
UNION ALL SELECT 1143746896, NULL, NULL, 'beauty'
-- Product Family, Body lotion --> NULL, NULL
UNION ALL SELECT 1143744894, NULL, NULL, 'beauty'
-- Product Family, Candles --> Home & Garden, Fragrance & Candles
UNION ALL SELECT 1143744900, 'fragrance-candles', 'Home & Garden', 'beauty'
-- Product Family, Fragrance sticks --> Home & Garden, Fragrance & Candles
UNION ALL SELECT 1143742439, 'fragrance-candles', 'Home & Garden', 'beauty'
-- Product Family, Gifts --> NewIa, Personalised Gifts
UNION ALL SELECT 727212959, 'personalised-gifts', 'NewIa', 'beauty'
-- Product Family, Giftsets --> Gift Sets Hampers Letterbox, Gift Sets
UNION ALL SELECT 1143751673, 'gift-sets-hampers-letterbox-gift-sets', 'Gift Sets Hampers Letterbox', 'beauty'
-- Product Family, Handsoap --> NewIa, Beauty Face & Body
UNION ALL SELECT 1143744897, 'beauty-face-body', 'NewIa', 'beauty'
-- Product Family, Living --> Home & Garden, Home Accessories
UNION ALL SELECT 1143766938, 'home-accessories', 'Home & Garden', 'beauty'
-- Product Family, Make up --> NULL, NULL
UNION ALL SELECT 1143767268, NULL, NULL, 'beauty'
-- Product Family, Parfum --> NULL, NULL
UNION ALL SELECT 1143767273, NULL, NULL, 'beauty'
-- Product Family, Roomspray --> NULL, NULL
UNION ALL SELECT 1143755889, NULL, NULL, 'beauty'
-- Product Family, Shower gel --> NewIa, Beauty Face & Body
UNION ALL SELECT 1143742442, 'beauty-face-body', 'NewIa', 'beauty'
-- Product Family, Skincare masks --> NULL, NULL
UNION ALL SELECT 1143747175, NULL, NULL, 'beauty'
-- Size, 80 --> NULL, NULL
UNION ALL SELECT 1143728278, NULL, NULL, 'beauty'
-- Size, Medium --> NULL, NULL
UNION ALL SELECT 1143728308, NULL, NULL, 'beauty'
-- Target Group, Girl --> Who's it for?, For Girls
UNION ALL SELECT 886507052, 'for-girls', 'Whos it for?', 'beauty'
-- Target Group, Men --> Who's it for?, For Him
UNION ALL SELECT 1143750956, 'for-him', 'Whos it for?', 'beauty'
-- Target Group, Uniseks --> Who's it for?, Other
UNION ALL SELECT 1143739122, 'whos-it-for-other', 'Whos it for?', 'beauty'
-- Target Group, Women --> Who's it for?, For Her
UNION ALL SELECT 1143750947, 'for-her', 'Whos it for?', 'beauty'
-- Type, Giftset --> Gift Sets Hampers Letterbox, Gift Sets
UNION ALL SELECT 1143739698, 'gift-sets-hampers-letterbox-gift-sets', 'Gift Sets Hampers Letterbox', 'beauty'
-- Type, Letterbox gifts --> Gift Sets Hampers Letterbox, Letterbox
UNION ALL SELECT 1143737611, 'gift-sets-hampers-letterbox-letterbox', 'Gift Sets Hampers Letterbox', 'beauty'
-- Age, 18 years and older --> Age, Adult 25 64 years old
UNION ALL SELECT 880438645, 'adult-25-64-years-old', 'Age', 'book'
-- Age, 18 years and older --> Age, Senior over 65 years old
UNION ALL SELECT 880438645, 'senior-over-65-years-old', 'Age', 'book'
-- Age, 18 years and older --> Age, Young Adult 18 24 years old
UNION ALL SELECT 880438645, 'young-adult-18-24-years-old', 'Age', 'book'
-- Age, Kids 6 tot 12 years --> Age, Kids 6 9 years old
UNION ALL SELECT 742758311, 'kids-6-9-years-old', 'Age', 'book'
-- Age, Kids 6 tot 12 years --> Age, Tween 9 12 years old
UNION ALL SELECT 742758311, 'tween-9-12-years-old', 'Age', 'book'
-- Age, Kleuter 4 to 6 years --> Age, Kids 2 5 years old
UNION ALL SELECT 742755895, 'kids-2-5-years-old', 'Age', 'book'
-- Age, Peuter 2 to 4 years --> Age, Kids 2 5 years old
UNION ALL SELECT 742755383, 'kids-2-5-years-old', 'Age', 'book'
-- Brand/Designer, Greetz --> NULL, NULL
UNION ALL SELECT 726316072, NULL, NULL, 'book'
-- Brand/Designer, Hip en Mama Box --> NULL, NULL
UNION ALL SELECT 1143764103, NULL, NULL, 'book'
-- Color, Black --> NULL, NULL
UNION ALL SELECT 1143728198, 'black', NULL, 'book'
-- Color, LightSkyBlue --> NULL, NULL
UNION ALL SELECT 1143728182, 'colour-blue', NULL, 'book'
-- Color, Red --> NULL, NULL
UNION ALL SELECT 1143728144, 'coloured', NULL, 'book'
-- Highlighted, Bucketlist books --> NULL, NULL
UNION ALL SELECT 1143746908, NULL, NULL, 'book'
-- Highlighted, Mostly given books --> NULL, NULL
UNION ALL SELECT 1143746462, NULL, NULL, 'book'
-- Highlighted, New Book Releases --> NULL, NULL
UNION ALL SELECT 1143765358, NULL, NULL, 'book'
-- Highlighted, Notebooks --> NULL, NULL
UNION ALL SELECT 1143747875, NULL, NULL, 'book'
-- Highlighted, personalised wrapping --> NewIa, Personalised Gifts
UNION ALL SELECT 1143743139, 'personalised-gifts', 'NewIa', 'book'
-- Occasion, Anniversary --> Occasion, Anniversaries
UNION ALL SELECT 1143740082, 'anniversaries', 'Occasion', 'book'
-- Occasion, AOC think --> Occasion, Thinking of you
UNION ALL SELECT 1143742160, 'occasion-thinking-of-you', 'Occasion', 'book'
-- Occasion, Babyshower --> Occasion, Baby Shower
UNION ALL SELECT 1143739143, 'baby-shower', 'Occasion', 'book'
-- Occasion, Babyshower (gifts) --> Occasion, Baby Shower
UNION ALL SELECT 1143742373, 'baby-shower', 'Occasion', 'book'
-- Occasion, Birth --> Occasion, New Baby
UNION ALL SELECT 726324202, 'occasion-new-baby', 'Occasion', 'book'
-- Occasion, Birth visite --> Occasion, New Baby
UNION ALL SELECT 1143739134, 'occasion-new-baby', 'Occasion', 'book'
-- Occasion, Birthday --> Occasion, Birthday
UNION ALL SELECT 726324105, 'occasion-birthday', 'Occasion', 'book'
-- Occasion, Christmas --> Occasion, Christmas
UNION ALL SELECT 726331358, 'occasion-christmas', 'Occasion', 'book'
-- Occasion, Condolence --> Occasion, Sympathy
UNION ALL SELECT 726345401, 'occasion-sympathy', 'Occasion', 'book'
-- Occasion, Congratulations (card and gift) --> Occasion, Congratulations
UNION ALL SELECT 1143729948, 'occasion-congratulations', 'Occasion', 'book'
-- Occasion, Engaged --> Occasion, Engagement
UNION ALL SELECT 735870409, 'occasion-engagement', 'Occasion', 'book'
-- Occasion, Fathersday --> Occasion, Fathers Day
UNION ALL SELECT 726332069, 'fathers-day', 'Occasion', 'book'
-- Occasion, Friendship2 --> Occasion, Friendship
UNION ALL SELECT 893069562, 'occasion-friendship', 'Occasion', 'book'
-- Occasion, Get well --> Occasion, Get Well
UNION ALL SELECT 726345521, 'occasion-get-well', 'Occasion', 'book'
-- Occasion, Good luck --> Occasion, Good Luck
UNION ALL SELECT 726345736, 'occasion-good-luck', 'Occasion', 'book'
-- Occasion, Goodbye colleague --> Occasion, Goodbye
UNION ALL SELECT 1143736110, 'goodbye', 'Occasion', 'book'
-- Occasion, Just because --> Occasion, Just to say
UNION ALL SELECT 726347430, 'just-to-say', 'Occasion', 'book'
-- Occasion, Just Married --> Occasion, Wedding
UNION ALL SELECT 1143732220, 'occasion-wedding', 'Occasion', 'book'
-- Occasion, Living together --> Occasion, New Home
UNION ALL SELECT 1143727835, 'occasion-new-home', 'Occasion', 'book'
-- Occasion, Love --> Occasion, Missing You
UNION ALL SELECT 1143727832, 'missing-you', 'Occasion', 'book'
-- Occasion, Maternity Leave --> Occasion, Pregnancy
UNION ALL SELECT 1143733399, 'occasion-pregnancy', 'Occasion', 'book'
-- Occasion, Mothersday --> Occasion, Mothers Day
UNION ALL SELECT 726331722, 'mothers-day', 'Occasion', 'book'
-- Occasion, Neutral (gifts) --> Occasion, Other
UNION ALL SELECT 1143742553, 'occasion-other', 'Occasion', 'book'
-- Occasion, New home --> Occasion, New Home
UNION ALL SELECT 726342840, 'occasion-new-home', 'Occasion', 'book'
-- Occasion, New Job --> Occasion, New Job
UNION ALL SELECT 735872747, 'occasion-new-job', 'Occasion', 'book'
-- Occasion, Pregnant --> Occasion, Pregnancy
UNION ALL SELECT 726344253, 'occasion-pregnancy', 'Occasion', 'book'
-- Occasion, Retirement --> Occasion, Retirement
UNION ALL SELECT 735873966, 'occasion-retirement', 'Occasion', 'book'
-- Occasion, Sinterklaas --> Occasion, Other
UNION ALL SELECT 726330911, 'occasion-other', 'Occasion', 'book'
-- Occasion, Swimming diploma --> Occasion, Well Done
UNION ALL SELECT 1143742376, 'occasion-well-done', 'Occasion', 'book'
-- Occasion, Thank you --> Occasion, Thank You
UNION ALL SELECT 726347103, 'occasion-thank-you', 'Occasion', 'book'
-- Occasion, Thinking of you --> Occasion, Thinking of you
UNION ALL SELECT 748511930, 'occasion-thinking-of-you', 'Occasion', 'book'
-- Occasion, Travelling --> Occasion, Bon Voyage
UNION ALL SELECT 1143731911, 'occasion-bon-voyage', 'Occasion', 'book'
-- Occasion, Vacation --> Occasion, Bon Voyage
UNION ALL SELECT 1143729435, 'occasion-bon-voyage', 'Occasion', 'book'
-- Occasion, Valentine --> Occasion, Valentines Day
UNION ALL SELECT 726324647, 'valentines-day', 'Occasion', 'book'
-- Occasion, Valentine best sold --> Occasion, Valentines Day
UNION ALL SELECT 1143735065, 'valentines-day', 'Occasion', 'book'
-- Occasion, Valentine In love --> Occasion, Valentines Day
UNION ALL SELECT 748508746, 'valentines-day', 'Occasion', 'book'
-- Occasion, Valentine loving --> Occasion, Valentines Day
UNION ALL SELECT 748510085, 'valentines-day', 'Occasion', 'book'
-- Occasion, Wedding --> Occasion, Wedding
UNION ALL SELECT 726342081, 'occasion-wedding', 'Occasion', 'book'
-- Occasion, Wedding Anniversary --> Occasion, Anniversaries
UNION ALL SELECT 735870898, 'anniversaries', 'Occasion', 'book'
-- Occasion, Zakelijke kerstgeschenken --> Occasion, Christmas
UNION ALL SELECT 1143747560, 'occasion-christmas', 'Occasion', 'book'
-- Product Family, Baby and kids --> NewIa, Toys Kids & Baby
UNION ALL SELECT 1143739056, 'toys-kids-baby', 'NewIa', 'book'
-- Product Family, Baby and kids L2 --> NewIa, Toys Kids & Baby
UNION ALL SELECT 1143739053, 'toys-kids-baby', 'NewIa', 'book'
-- Product Family, Biographies and current affairs --> Books & Stationery, For Adults
UNION ALL SELECT 1143743535, 'for-adults', 'Books & Stationery', 'book'
-- Product Family, Body and mind --> NULL, NULL
UNION ALL SELECT 808793556, NULL, NULL, 'book'
-- Product Family, Books --> NULL, NULL
UNION ALL SELECT 735097316, NULL, NULL, 'book'
-- Product Family, Books and cards --> NewIa, Books & Stationery
UNION ALL SELECT 1143739215, 'books-stationery', 'NewIa', 'book'
-- Product Family, Books L2 --> NULL, NULL
UNION ALL SELECT 726958013, NULL, NULL, 'book'
-- Product Family, Children Books --> Books & Stationery, For Kids
UNION ALL SELECT 808799282, 'for-kids', 'Books & Stationery', 'book'
-- Product Family, Children Books --> Toys Kids & Baby, Books Stationery
UNION ALL SELECT 808799282, 'toys-kids-baby-books-stationery', 'Toys Kids & Baby', 'book'
-- Product Family, Cooking books --> Books & Stationery, For Adults
UNION ALL SELECT 808797401, 'for-adults', 'Books & Stationery', 'book'
-- Product Family, Do books --> NULL, NULL
UNION ALL SELECT 1143744045, NULL, NULL, 'book'
-- Product Family, Gifts --> NewIa, Personalised Gifts
UNION ALL SELECT 727212959, 'personalised-gifts', 'NewIa', 'book'
-- Product Family, Hobby books --> NULL, NULL
UNION ALL SELECT 1143743409, NULL, NULL, 'book'
-- Product Family, Information books --> NULL, NULL
UNION ALL SELECT 1143747980, NULL, NULL, 'book'
-- Product Family, Love and friendship --> Who's it for?, Friend
UNION ALL SELECT 1143743544, 'friend', 'Whos it for?', 'book'
-- Product Family, Notebook and diaries --> NULL, NULL
UNION ALL SELECT 1143743565, NULL, NULL, 'book'
-- Product Family, Other --> Books & Stationery, Other
UNION ALL SELECT 1143747986, 'books-stationery-other', 'Books & Stationery', 'book'
-- Product Family, Pregnancy and birth --> Books & Stationery, For Adults
UNION ALL SELECT 1143743538, 'for-adults', 'Books & Stationery', 'book'
-- Product Family, Travelbooks --> NULL, NULL
UNION ALL SELECT 1143743406, NULL, NULL, 'book'
-- Size, 80 --> NULL, NULL
UNION ALL SELECT 1143728278, NULL, NULL, 'book'
-- Size, Large --> NULL, NULL
UNION ALL SELECT 1143728311, NULL, NULL, 'book'
-- Size, Small (klein) --> NULL, NULL
UNION ALL SELECT 1143739950, NULL, NULL, 'book'
-- Target Group, Boy --> Who's it for?, For Boys
UNION ALL SELECT 886506339, 'for-boys', 'Whos it for?', 'book'
-- Target Group, Girl --> Who's it for?, For Girls
UNION ALL SELECT 886507052, 'for-girls', 'Whos it for?', 'book'
-- Target Group, Men --> Who's it for?, For Him
UNION ALL SELECT 1143750956, 'for-him', 'Whos it for?', 'book'
-- Target Group, Women --> Who's it for?, For Her
UNION ALL SELECT 1143750947, 'for-her', 'Whos it for?', 'book'
-- Type, Letterbox gifts --> Gift Sets Hampers Letterbox, Letterbox
UNION ALL SELECT 1143737611, 'gift-sets-hampers-letterbox-letterbox', 'Gift Sets Hampers Letterbox', 'book'
-- Age, 18 years and older --> Age, Adult 25 64 years old
UNION ALL SELECT 880438645, 'adult-25-64-years-old', 'Age', 'cake'
-- Age, 18 years and older --> Age, Young Adult 18 24 years old
UNION ALL SELECT 880438645, 'young-adult-18-24-years-old', 'Age', 'cake'
-- Age, 18 years and older --> Age, Senior over 65 years old
UNION ALL SELECT 880438645, 'senior-over-65-years-old', 'Age', 'cake'
-- Age, Jongeren 12 to 18 years --> Age, Teen 13 17 years old
UNION ALL SELECT 748494248, 'teen-13-17-years-old', 'Age', 'cake'
-- Brand/Designer, Andere Koek voor thuis --> NULL, NULL
UNION ALL SELECT 1143741115, NULL, NULL, 'cake'
-- Brand/Designer, Greetz --> NULL, NULL
UNION ALL SELECT 726316072, NULL, NULL, 'cake'
-- Brand/Designer, Greetz cakes --> NULL, NULL
UNION ALL SELECT 1143749276, NULL, NULL, 'cake'
-- Brand/Designer, Pineut --> NULL, NULL
UNION ALL SELECT 1143761123, NULL, NULL, 'cake'
-- Cake, All cakes --> NULL, NULL
UNION ALL SELECT 1143736572, NULL, NULL, 'cake'
-- Cake, Apple pie --> NULL, NULL
UNION ALL SELECT 1143736545, NULL, NULL, 'cake'
-- Cake, Cake with own photo or name --> NULL, NULL
UNION ALL SELECT 1143736536, NULL, NULL, 'cake'
-- Cake, Carrot cake --> NULL, NULL
UNION ALL SELECT 1143747566, NULL, NULL, 'cake'
-- Cake, Cheesecake --> NULL, NULL
UNION ALL SELECT 1143736557, NULL, NULL, 'cake'
-- Cake, Chocolate cake --> NULL, NULL
UNION ALL SELECT 1143736548, NULL, NULL, 'cake'
-- Cake, Cream cake --> NULL, NULL
UNION ALL SELECT 1143736539, NULL, NULL, 'cake'
-- Cake, Dripcake --> NULL, NULL
UNION ALL SELECT 1143747569, NULL, NULL, 'cake'
-- Cake, Fruit and nuts cake --> NULL, NULL
UNION ALL SELECT 1143736554, NULL, NULL, 'cake'
-- Cake, Layercake --> NULL, NULL
UNION ALL SELECT 1143736560, NULL, NULL, 'cake'
-- Cake, Marzipan cake --> NULL, NULL
UNION ALL SELECT 1143736542, NULL, NULL, 'cake'
-- Cake, Red velvet --> NULL, NULL
UNION ALL SELECT 1143747563, NULL, NULL, 'cake'
-- Cake, Small cake --> NULL, NULL
UNION ALL SELECT 1143736563, NULL, NULL, 'cake'
-- Cake, Sparkle cake --> NULL, NULL
UNION ALL SELECT 1143747572, NULL, NULL, 'cake'
-- Color, Brown --> NULL, NULL
UNION ALL SELECT 727095669, 'coloured', NULL, 'cake'
-- Color, HotPink --> NULL, NULL
UNION ALL SELECT 1143728149, 'pink', NULL, 'cake'
-- Color, Mix of colors --> NULL, NULL
UNION ALL SELECT 729235298, 'multicolour', NULL, 'cake'
-- Color, Pink --> NULL, NULL
UNION ALL SELECT 1143728148, 'pink', NULL, 'cake'
-- Color, Red --> NULL, NULL
UNION ALL SELECT 1143728144, 'coloured', NULL, 'cake'
-- Color, White --> NULL, NULL
UNION ALL SELECT 1143728193, 'colour-white', NULL, 'cake'
-- Occasion, Anniversary --> Occasion, Anniversaries
UNION ALL SELECT 1143740082, 'anniversaries', 'Occasion', 'cake'
-- Occasion, Birthday --> Occasion, Birthday
UNION ALL SELECT 726324105, 'occasion-birthday', 'Occasion', 'cake'
-- Occasion, Brother and Sister day --> Occasion, Friendship
UNION ALL SELECT 1143732527, 'occasion-friendship', 'Occasion', 'cake'
-- Occasion, Christmas --> Occasion, Christmas
UNION ALL SELECT 726331358, 'occasion-christmas', 'Occasion', 'cake'
-- Occasion, Congratulations (card and gift) --> Occasion, Congratulations
UNION ALL SELECT 1143729948, 'occasion-congratulations', 'Occasion', 'cake'
-- Occasion, Easter/Pasen --> Occasion, Easter
UNION ALL SELECT 726343205, 'occasion-easter', 'Occasion', 'cake'
-- Occasion, Eid Mubarak --> Religious Occasions, Eid Mubarak
UNION ALL SELECT 1143746767, 'eid-mubarak', 'Religious Occasions', 'cake'
-- Occasion, Fathersday --> Occasion, Fathers Day
UNION ALL SELECT 726332069, 'fathers-day', 'Occasion', 'cake'
-- Occasion, Friendship2 --> Occasion, Friendship
UNION ALL SELECT 893069562, 'occasion-friendship', 'Occasion', 'cake'
-- Occasion, Get well --> Occasion, Get Well
UNION ALL SELECT 726345521, 'occasion-get-well', 'Occasion', 'cake'
-- Occasion, Good luck --> Occasion, Good Luck
UNION ALL SELECT 726345736, 'occasion-good-luck', 'Occasion', 'cake'
-- Occasion, Goodbye colleague --> Occasion, Goodbye
UNION ALL SELECT 1143736110, 'goodbye', 'Occasion', 'cake'
-- Occasion, Graduation --> Occasion, Graduation
UNION ALL SELECT 1143729906, 'occasion-graduation', 'Occasion', 'cake'
-- Occasion, Just because --> Occasion, Just to say
UNION ALL SELECT 726347430, 'just-to-say', 'Occasion', 'cake'
-- Occasion, Kingsday --> NULL, NULL
UNION ALL SELECT 726972775, NULL, NULL, 'cake'
-- Occasion, Living together --> Occasion, New Home
UNION ALL SELECT 1143727835, 'occasion-new-home', 'Occasion', 'cake'
-- Occasion, Love --> Occasion, Missing You
UNION ALL SELECT 1143727832, 'missing-you', 'Occasion', 'cake'
-- Occasion, Mothersday --> Occasion, Mothers Day
UNION ALL SELECT 726331722, 'mothers-day', 'Occasion', 'cake'
-- Occasion, New home --> Occasion, New Home
UNION ALL SELECT 726342840, 'occasion-new-home', 'Occasion', 'cake'
-- Occasion, New Job --> Occasion, New Job
UNION ALL SELECT 735872747, 'occasion-new-job', 'Occasion', 'cake'
-- Occasion, Opening new business --> Occasion, Well Done
UNION ALL SELECT 1143744579, 'occasion-well-done', 'Occasion', 'cake'
-- Occasion, photoself --> NULL, NULL
UNION ALL SELECT 1143731878, NULL, NULL, 'cake'
-- Occasion, Retirement --> Occasion, Retirement
UNION ALL SELECT 735873966, 'occasion-retirement', 'Occasion', 'cake'
-- Occasion, Secretaryday --> Occasion, Other
UNION ALL SELECT 1143731240, 'occasion-other', 'Occasion', 'cake'
-- Occasion, Thank you --> Occasion, Thank You
UNION ALL SELECT 726347103, 'occasion-thank-you', 'Occasion', 'cake'
-- Occasion, Thank you teacher --> Occasion, Thank You
UNION ALL SELECT 1143742415, 'occasion-thank-you', 'Occasion', 'cake'
-- Occasion, Thanks teacher --> Occasion, Thank You
UNION ALL SELECT 1143757148, 'occasion-thank-you', 'Occasion', 'cake'
-- Occasion, Thinking of you --> Occasion, Thinking of you
UNION ALL SELECT 748511930, 'occasion-thinking-of-you', 'Occasion', 'cake'
-- Occasion, Valentine --> Occasion, Valentines Day
UNION ALL SELECT 726324647, 'valentines-day', 'Occasion', 'cake'
-- Occasion, Wedding --> Occasion, Wedding
UNION ALL SELECT 726342081, 'occasion-wedding', 'Occasion', 'cake'
-- Pastry, All pastry --> Food & Drink, Snacks Treats Savoury
UNION ALL SELECT 1143736593, 'snacks-treats-savoury', 'Food & Drink', 'cake'
-- Pastry, Assorted pastry --> Food & Drink, Snacks Treats Savoury
UNION ALL SELECT 1143736590, 'snacks-treats-savoury', 'Food & Drink', 'cake'
-- Pastry, Brownies --> Food & Drink, Snacks Treats Savoury
UNION ALL SELECT 1143736578, 'snacks-treats-savoury', 'Food & Drink', 'cake'
-- Pastry, Cupcakes --> Food & Drink, Snacks Treats Savoury
UNION ALL SELECT 1143736581, 'snacks-treats-savoury', 'Food & Drink', 'cake'
-- Pastry, Donuts --> Food & Drink, Snacks Treats Savoury
UNION ALL SELECT 1143736824, 'snacks-treats-savoury', 'Food & Drink', 'cake'
-- Pastry, Pastry with own photo or name --> Food & Drink, Snacks Treats Savoury
UNION ALL SELECT 1143736575, 'snacks-treats-savoury', 'Food & Drink', 'cake'
-- Pastry, Pastry with own photo or name --> NewIa, Personalised Gifts
UNION ALL SELECT 1143736575, 'personalised-gifts', 'NewIa', 'cake'
-- Pastry, Petit fours --> Food & Drink, Snacks Treats Savoury
UNION ALL SELECT 1143738303, 'snacks-treats-savoury', 'Food & Drink', 'cake'
-- Pastry, Self bake --> Food & Drink, Baking Kits
UNION ALL SELECT 1143741121, 'baking-kits', 'Food & Drink', 'cake'
-- Pastry, Tompoucen --> NULL, NULL
UNION ALL SELECT 1143736587, NULL, NULL, 'cake'
-- Product Family, Cake and Pastry --> Food & Drink, Snacks Treats Savoury
UNION ALL SELECT 1143736644, 'snacks-treats-savoury', 'Food & Drink', 'cake'
-- Product Family, Eating and drinkingl2 --> NewIa, Food & Drink
UNION ALL SELECT 726930780, 'food-drink', 'NewIa', 'cake'
-- Product Family, Gifts --> NewIa, Personalised Gifts
UNION ALL SELECT 727212959, 'personalised-gifts', 'NewIa', 'cake'
-- Ratio, Round --> NULL, NULL
UNION ALL SELECT 1143735835, NULL, NULL, 'cake'
-- Size, 10 persons --> NULL, NULL
UNION ALL SELECT 1143736611, NULL, NULL, 'cake'
-- Size, 10 pieces --> NULL, NULL
UNION ALL SELECT 1143738939, NULL, NULL, 'cake'
-- Size, 12 persons --> NULL, NULL
UNION ALL SELECT 1143736614, NULL, NULL, 'cake'
-- Size, 12 pieces --> NULL, NULL
UNION ALL SELECT 1143736827, NULL, NULL, 'cake'
-- Size, 14 pieces --> NULL, NULL
UNION ALL SELECT 1143738933, NULL, NULL, 'cake'
-- Size, 16 persons --> NULL, NULL
UNION ALL SELECT 1143736617, NULL, NULL, 'cake'
-- Size, 20 persons --> NULL, NULL
UNION ALL SELECT 1143736620, NULL, NULL, 'cake'
-- Size, 20 pieces --> NULL, NULL
UNION ALL SELECT 1143738942, NULL, NULL, 'cake'
-- Size, 25 persons --> NULL, NULL
UNION ALL SELECT 1143736632, NULL, NULL, 'cake'
-- Size, 30 persons --> NULL, NULL
UNION ALL SELECT 1143736635, NULL, NULL, 'cake'
-- Size, 30 pieces --> NULL, NULL
UNION ALL SELECT 1143738945, NULL, NULL, 'cake'
-- Size, 40 persons --> NULL, NULL
UNION ALL SELECT 1143736638, NULL, NULL, 'cake'
-- Size, 40 pieces --> NULL, NULL
UNION ALL SELECT 1143738948, NULL, NULL, 'cake'
-- Size, 6 persons --> NULL, NULL
UNION ALL SELECT 1143738912, NULL, NULL, 'cake'
-- Size, 6 pieces --> NULL, NULL
UNION ALL SELECT 1143736602, NULL, NULL, 'cake'
-- Size, 8 persons --> NULL, NULL
UNION ALL SELECT 1143736605, NULL, NULL, 'cake'
-- Size, 9 persons --> NULL, NULL
UNION ALL SELECT 1143740112, NULL, NULL, 'cake'
-- Size, Small (klein) --> NULL, NULL
UNION ALL SELECT 1143739950, NULL, NULL, 'cake'
-- Target Group, Boy --> Who's it for?, For Boys
UNION ALL SELECT 886506339, 'for-boys', 'Whos it for?', 'cake'
-- Target Group, Girl --> Who's it for?, For Girls
UNION ALL SELECT 886507052, 'for-girls', 'Whos it for?', 'cake'
-- Target Group, Men --> Who's it for?, For Him
UNION ALL SELECT 1143750956, 'for-him', 'Whos it for?', 'cake'
-- Target Group, Women --> Who's it for?, For Her
UNION ALL SELECT 1143750947, 'for-her', 'Whos it for?', 'cake'
-- Target Group, Zakelijk1 (cards missions) --> Who's it For?, Other
UNION ALL SELECT 1143732725, 'newia-gift-experiences-whos-it-for-other', 'Whos it For?', 'cake'
-- Theme, Birthday cakes --> Occasion, Birthday
UNION ALL SELECT 1143747872, 'occasion-birthday', 'Occasion', 'cake'
-- Theme, Luxe cakes --> NULL, NULL
UNION ALL SELECT 1143747869, NULL, NULL, 'cake'
-- Type, Letterbox gifts --> Gift Sets Hampers Letterbox, Letterbox
UNION ALL SELECT 1143737611, 'gift-sets-hampers-letterbox-letterbox', 'Gift Sets Hampers Letterbox', 'cake'
-- Type, Photo and text gifts --> NewIa, Personalised Gifts
UNION ALL SELECT 1143735781, 'personalised-gifts', 'NewIa', 'cake'
-- Age, 18 years and older --> Age, Young Adult 18 24 years old
UNION ALL SELECT 880438645, 'young-adult-18-24-years-old', 'Age', 'chocolate'
-- Age, 18 years and older --> Age, Adult 25 64 years old
UNION ALL SELECT 880438645, 'adult-25-64-years-old', 'Age', 'chocolate'
-- Age, 18 years and older --> Age, Senior over 65 years old
UNION ALL SELECT 880438645, 'senior-over-65-years-old', 'Age', 'chocolate'
-- Age, Jongeren 12 to 18 years --> Age, Teen 13 17 years old
UNION ALL SELECT 748494248, 'teen-13-17-years-old', 'Age', 'chocolate'
-- Brand/Designer, Australian chocolate --> NULL, NULL
UNION ALL SELECT 1143732878, NULL, NULL, 'chocolate'
-- Brand/Designer, Chocolate by Greetz --> NULL, NULL
UNION ALL SELECT 1143749225, NULL, NULL, 'chocolate'
-- Brand/Designer, Chocolate telegram --> NULL, NULL
UNION ALL SELECT 1143730173, NULL, NULL, 'chocolate'
-- Brand/Designer, Dragee --> NULL, NULL
UNION ALL SELECT 1143749285, NULL, NULL, 'chocolate'
-- Brand/Designer, Happy Truffel --> NULL, NULL
UNION ALL SELECT 1143747605, NULL, NULL, 'chocolate'
-- Brand/Designer, Leonidas --> NULL, NULL
UNION ALL SELECT 1143733923, NULL, NULL, 'chocolate'
-- Brand/Designer, Merci --> NULL, NULL
UNION ALL SELECT 726982880, NULL, NULL, 'chocolate'
-- Brand/Designer, Milka --> NULL, NULL
UNION ALL SELECT 726985241, NULL, NULL, 'chocolate'
-- Brand/Designer, Pralibel --> NULL, NULL
UNION ALL SELECT 1143741163, NULL, NULL, 'chocolate'
-- Brand/Designer, Tony's --> NULL, NULL
UNION ALL SELECT 1143735281, NULL, NULL, 'chocolate'
-- Brand/Designer, Tubes --> NULL, NULL
UNION ALL SELECT 1143745881, NULL, NULL, 'chocolate'
-- Brand/Designer, Urban Cacao --> NULL, NULL
UNION ALL SELECT 1143750830, NULL, NULL, 'chocolate'
-- Color, Blue --> NULL, NULL
UNION ALL SELECT 1143728186, 'colour-blue', NULL, 'chocolate'
-- Color, DarkOrange --> NULL, NULL
UNION ALL SELECT 1143728157, 'coloured', NULL, 'chocolate'
-- Color, DeepSkyBlue --> NULL, NULL
UNION ALL SELECT 1143728183, 'colour-blue', NULL, 'chocolate'
-- Color, Green --> NULL, NULL
UNION ALL SELECT 727095708, 'coloured', NULL, 'chocolate'
-- Color, Purple --> NULL, NULL
UNION ALL SELECT 727096014, 'coloured', NULL, 'chocolate'
-- Color, Red --> NULL, NULL
UNION ALL SELECT 1143728144, 'coloured', NULL, 'chocolate'
-- Color, Yellow --> NULL, NULL
UNION ALL SELECT 1143728162, 'coloured', NULL, 'chocolate'
-- Highlighted, Giftbox: Beverage with chocolate --> NewIa, Gift Sets Hampers Letterbox
UNION ALL SELECT 1143747968, 'newia-gift-sets-hampers-letterbox', 'NewIa', 'chocolate'
-- Highlighted, Giftbox: Beverage with chocolate --> Food & Drink, Chocolate
UNION ALL SELECT 1143747968, 'chocolate', 'Food & Drink', 'chocolate'
-- Highlighted, Giftbox: Beverage with chocolate --> Alcohol, Gift Sets Letterbox
UNION ALL SELECT 1143747968, 'alcohol-gift-sets-letterbox', 'Alcohol', 'chocolate'
-- Highlighted, personalised wrapping --> NewIa, Personalised Gifts
UNION ALL SELECT 1143743139, 'personalised-gifts', 'NewIa', 'chocolate'
-- Occasion, Anniversary --> Occasion, Anniversaries
UNION ALL SELECT 1143740082, 'anniversaries', 'Occasion', 'chocolate'
-- Occasion, AOC think --> Occasion, Thinking of you
UNION ALL SELECT 1143742160, 'occasion-thinking-of-you', 'Occasion', 'chocolate'
-- Occasion, Birth --> Occasion, New Baby
UNION ALL SELECT 726324202, 'occasion-new-baby', 'Occasion', 'chocolate'
-- Occasion, Birthday --> Occasion, Birthday
UNION ALL SELECT 726324105, 'occasion-birthday', 'Occasion', 'chocolate'
-- Occasion, Brother and Sister day --> Occasion, Friendship
UNION ALL SELECT 1143732527, 'occasion-friendship', 'Occasion', 'chocolate'
-- Occasion, Christmas --> Occasion, Christmas
UNION ALL SELECT 726331358, 'occasion-christmas', 'Occasion', 'chocolate'
-- Occasion, Congratulations (card and gift) --> Occasion, Congratulations
UNION ALL SELECT 1143729948, 'occasion-congratulations', 'Occasion', 'chocolate'
-- Occasion, Easter/Pasen --> Occasion, Easter
UNION ALL SELECT 726343205, 'occasion-easter', 'Occasion', 'chocolate'
-- Occasion, Eid Mubarak --> Religious Occasions, Eid Mubarak
UNION ALL SELECT 1143746767, 'eid-mubarak', 'Religious Occasions', 'chocolate'
-- Occasion, Failed --> Occasion, Empathy
UNION ALL SELECT 748506030, 'empathy', 'Occasion', 'chocolate'
-- Occasion, Fall (Flowers --> Occasion, Other
UNION ALL SELECT 1143732590, 'occasion-other', 'Occasion', 'chocolate'
-- Occasion, Fathersday --> Occasion, Fathers Day
UNION ALL SELECT 726332069, 'fathers-day', 'Occasion', 'chocolate'
-- Occasion, Friendship2 --> Occasion, Friendship
UNION ALL SELECT 893069562, 'occasion-friendship', 'Occasion', 'chocolate'
-- Occasion, Get well --> Occasion, Get Well
UNION ALL SELECT 726345521, 'occasion-get-well', 'Occasion', 'chocolate'
-- Occasion, Get well welcome home --> Occasion, Get Well
UNION ALL SELECT 1143742088, 'occasion-get-well', 'Occasion', 'chocolate'
-- Occasion, Good luck --> Occasion, Good Luck
UNION ALL SELECT 726345736, 'occasion-good-luck', 'Occasion', 'chocolate'
-- Occasion, Goodbye colleague --> Occasion, Goodbye
UNION ALL SELECT 1143736110, 'goodbye', 'Occasion', 'chocolate'
-- Occasion, Graduation --> Occasion, Graduation
UNION ALL SELECT 1143729906, 'occasion-graduation', 'Occasion', 'chocolate'
-- Occasion, Just because --> Occasion, Just to say
UNION ALL SELECT 726347430, 'just-to-say', 'Occasion', 'chocolate'
-- Occasion, Living together --> Occasion, New Home
UNION ALL SELECT 1143727835, 'occasion-new-home', 'Occasion', 'chocolate'
-- Occasion, Love --> Occasion, Missing You
UNION ALL SELECT 1143727832, 'missing-you', 'Occasion', 'chocolate'
-- Occasion, Mothersday --> Occasion, Mothers Day
UNION ALL SELECT 726331722, 'mothers-day', 'Occasion', 'chocolate'
-- Occasion, New home --> Occasion, New Home
UNION ALL SELECT 726342840, 'occasion-new-home', 'Occasion', 'chocolate'
-- Occasion, New Job --> Occasion, New Job
UNION ALL SELECT 735872747, 'occasion-new-job', 'Occasion', 'chocolate'
-- Occasion, NewYear (gifts) --> Occasion, New Year
UNION ALL SELECT 1143732695, 'occasion-new-year', 'Occasion', 'chocolate'
-- Occasion, Pregnant --> Occasion, Pregnancy
UNION ALL SELECT 726344253, 'occasion-pregnancy', 'Occasion', 'chocolate'
-- Occasion, Retirement --> Occasion, Retirement
UNION ALL SELECT 735873966, 'occasion-retirement', 'Occasion', 'chocolate'
-- Occasion, Secretaryday --> Occasion, Other
UNION ALL SELECT 1143731240, 'occasion-other', 'Occasion', 'chocolate'
-- Occasion, Sinterklaas --> Occasion, Other
UNION ALL SELECT 726330911, 'occasion-other', 'Occasion', 'chocolate'
-- Occasion, Sorry --> Occasion, Sorry
UNION ALL SELECT 726966325, 'occasion-sorry', 'Occasion', 'chocolate'
-- Occasion, Thank you --> Occasion, Thank You
UNION ALL SELECT 726347103, 'occasion-thank-you', 'Occasion', 'chocolate'
-- Occasion, Thank you teacher --> Occasion, Thank You
UNION ALL SELECT 1143742415, 'occasion-thank-you', 'Occasion', 'chocolate'
-- Occasion, Thanks teacher --> Occasion, Thank You
UNION ALL SELECT 1143757148, 'occasion-thank-you', 'Occasion', 'chocolate'
-- Occasion, Thinking of you --> Occasion, Thinking of you
UNION ALL SELECT 748511930, 'occasion-thinking-of-you', 'Occasion', 'chocolate'
-- Occasion, Valentine --> Occasion, Valentines Day
UNION ALL SELECT 726324647, 'valentines-day', 'Occasion', 'chocolate'
-- Occasion, Wedding --> Occasion, Wedding
UNION ALL SELECT 726342081, 'occasion-wedding', 'Occasion', 'chocolate'
-- Occasion, Zakelijke kerstgeschenken --> Occasion, Christmas
UNION ALL SELECT 1143747560, 'occasion-christmas', 'Occasion', 'chocolate'
-- Product Family, All chocolate --> Food & Drink, Chocolate
UNION ALL SELECT 1143738429, 'chocolate', 'Food & Drink', 'chocolate'
-- Product Family, Bonbons --> Food & Drink, Sweets
UNION ALL SELECT 1143735384, 'sweets', 'Food & Drink', 'chocolate'
-- Product Family, Chocolade met eigen foto of tekst --> NewIa, Personalised Gifts
UNION ALL SELECT 1143735399, 'personalised-gifts', 'NewIa', 'chocolate'
-- Product Family, Chocolade met eigen foto of tekst --> Food & Drink, Chocolate
UNION ALL SELECT 1143735399, 'chocolate', 'Food & Drink', 'chocolate'
-- Product Family, Chocolade repen --> Food & Drink, Chocolate
UNION ALL SELECT 1143742991, 'chocolate', 'Food & Drink', 'chocolate'
-- Product Family, Chocoladeletters --> Food & Drink, Chocolate
UNION ALL SELECT 1143735338, 'chocolate', 'Food & Drink', 'chocolate'
-- Product Family, Chocolate --> Food & Drink, Chocolate
UNION ALL SELECT 726930909, 'chocolate', 'Food & Drink', 'chocolate'
-- Product Family, Chocolate hearts --> Food & Drink, Chocolate
UNION ALL SELECT 1143735387, 'chocolate', 'Food & Drink', 'chocolate'
-- Product Family, Chocolate truffels --> Food & Drink, Chocolate
UNION ALL SELECT 1143747590, 'chocolate', 'Food & Drink', 'chocolate'
-- Product Family, Eating and drinkingl2 --> NewIa, Food & Drink
UNION ALL SELECT 726930780, 'food-drink', 'NewIa', 'chocolate'
-- Product Family, Giftboxen --> Gift Sets Hampers Letterbox, Gift Sets
UNION ALL SELECT 1143735393, 'gift-sets-hampers-letterbox-gift-sets', 'Gift Sets Hampers Letterbox', 'chocolate'
-- Product Family, Gifts --> NewIa, Personalised Gifts
UNION ALL SELECT 727212959, 'personalised-gifts', 'NewIa', 'chocolate'
-- Product Family, Telegram --> NewIa, Personalised Gifts
UNION ALL SELECT 1143730254, 'personalised-gifts', 'NewIa', 'chocolate'
-- Product Family, Telegram --> Food & Drink, Chocolate
UNION ALL SELECT 1143730254, 'chocolate', 'Food & Drink', 'chocolate'
-- Size, 100 pieces --> NULL, NULL
UNION ALL SELECT 1143762823, NULL, NULL, 'chocolate'
-- Size, 16 chocolates --> NULL, NULL
UNION ALL SELECT 1143760468, NULL, NULL, 'chocolate'
-- Size, 22 pieces --> NULL, NULL
UNION ALL SELECT 1143762818, NULL, NULL, 'chocolate'
-- Size, 25 chocolates --> NULL, NULL
UNION ALL SELECT 1143760473, NULL, NULL, 'chocolate'
-- Size, 250 gram --> NULL, NULL
UNION ALL SELECT 1143747067, NULL, NULL, 'chocolate'
-- Size, 32 chocolates --> NULL, NULL
UNION ALL SELECT 1143760478, NULL, NULL, 'chocolate'
-- Size, 375 gram --> NULL, NULL
UNION ALL SELECT 1143760458, NULL, NULL, 'chocolate'
-- Size, 400 gram --> NULL, NULL
UNION ALL SELECT 1143747070, NULL, NULL, 'chocolate'
-- Size, 675 gram --> NULL, NULL
UNION ALL SELECT 1143747073, NULL, NULL, 'chocolate'
-- Size, 750 gram --> NULL, NULL
UNION ALL SELECT 1143760463, NULL, NULL, 'chocolate'
-- Size, 80 --> NULL, NULL
UNION ALL SELECT 1143728278, NULL, NULL, 'chocolate'
-- Size, Large --> NULL, NULL
UNION ALL SELECT 1143728311, NULL, NULL, 'chocolate'
-- Size, Medium --> NULL, NULL
UNION ALL SELECT 1143728308, NULL, NULL, 'chocolate'
-- Target Group, Boy --> Who's it for?, For Boys
UNION ALL SELECT 886506339, 'for-boys', 'Whos it for?', 'chocolate'
-- Target Group, Girl --> Who's it for?, For Girls
UNION ALL SELECT 886507052, 'for-girls', 'Whos it for?', 'chocolate'
-- Target Group, Men --> Who's it for?, For Him
UNION ALL SELECT 1143750956, 'for-him', 'Whos it for?', 'chocolate'
-- Target Group, Women --> Who's it for?, For Her
UNION ALL SELECT 1143750947, 'for-her', 'Whos it for?', 'chocolate'
-- Target Group, Zakelijk1 (cards missions) --> Who's it For?, Other
UNION ALL SELECT 1143732725, 'newia-gift-experiences-whos-it-for-other', 'Whos it For?', 'chocolate'
-- Taste, Almond --> NULL, NULL
UNION ALL SELECT 1143734639, NULL, NULL, 'chocolate'
-- Taste, Milk --> NULL, NULL
UNION ALL SELECT 1143733276, NULL, NULL, 'chocolate'
-- Taste, Mix (chocolate) --> Food & Drink, Chocolate
UNION ALL SELECT 1143733285, 'chocolate', 'Food & Drink', 'chocolate'
-- Taste, Pure (chocolate) --> Food & Drink, Chocolate
UNION ALL SELECT 1143733279, 'chocolate', 'Food & Drink', 'chocolate'
-- Taste, Ruby (chocolate) --> NULL, NULL
UNION ALL SELECT 1143759763, NULL, NULL, 'chocolate'
-- Taste, White (chocolate) --> Food & Drink, Chocolate
UNION ALL SELECT 1143733282, 'chocolate', 'Food & Drink', 'chocolate'
-- Type, Chocolate with a message --> NewIa, Personalised Gifts
UNION ALL SELECT 1143749573, 'personalised-gifts', 'NewIa', 'chocolate'
-- Type, Chocolate with a message --> Food & Drink, Chocolate
UNION ALL SELECT 1143749573, 'chocolate', 'Food & Drink', 'chocolate'
-- Type, Giftset --> Gift Sets Hampers Letterbox, Gift Sets
UNION ALL SELECT 1143739698, 'gift-sets-hampers-letterbox-gift-sets', 'Gift Sets Hampers Letterbox', 'chocolate'
-- Type, Letterbox gifts --> Gift Sets Hampers Letterbox, Letterbox
UNION ALL SELECT 1143737611, 'gift-sets-hampers-letterbox-letterbox', 'Gift Sets Hampers Letterbox', 'chocolate'
-- Type, Photo and text gifts --> NewIa, Personalised Gifts
UNION ALL SELECT 1143735781, 'personalised-gifts', 'NewIa', 'chocolate'
-- Age, 18 years and older --> Age, Young Adult 18 24 years old
UNION ALL SELECT 880438645, 'young-adult-18-24-years-old', 'Age', 'flower'
-- Age, 18 years and older --> Age, Adult 25 64 years old
UNION ALL SELECT 880438645, 'adult-25-64-years-old', 'Age', 'flower'
-- Age, 18 years and older --> Age, Senior over 65 years old
UNION ALL SELECT 880438645, 'senior-over-65-years-old', 'Age', 'flower'
-- Age, Baby 0 tot 1 year --> Age, Baby 0 1 years old
UNION ALL SELECT 880440481, 'baby-0-1-years-old', 'Age', 'flower'
-- Brand/Designer, 100 procent Leuk --> NULL, NULL
UNION ALL SELECT 1143748292, NULL, NULL, 'flower'
-- Brand/Designer, Greetz --> NULL, NULL
UNION ALL SELECT 726316072, NULL, NULL, 'flower'
-- Brand/Designer, Happy Socks --> Brands, Happy Socks
UNION ALL SELECT 1143738180, 'happy-socks', 'Brands', 'flower'
-- Brand/Designer, Happy Truffel --> NULL, NULL
UNION ALL SELECT 1143747605, NULL, NULL, 'flower'
-- Brand/Designer, Il Miogusto --> NULL, NULL
UNION ALL SELECT 1143747145, NULL, NULL, 'flower'
-- Brand/Designer, Janzen --> NULL, NULL
UNION ALL SELECT 1143756595, NULL, NULL, 'flower'
-- Brand/Designer, Kneipp --> NULL, NULL
UNION ALL SELECT 1143733099, NULL, NULL, 'flower'
-- Brand/Designer, La Chouffe --> NULL, NULL
UNION ALL SELECT 1143730644, NULL, NULL, 'flower'
-- Brand/Designer, Little Dutch --> NULL, NULL
UNION ALL SELECT 1143740088, NULL, NULL, 'flower'
-- Brand/Designer, Merci --> NULL, NULL
UNION ALL SELECT 726982880, NULL, NULL, 'flower'
-- Brand/Designer, Milka --> NULL, NULL
UNION ALL SELECT 726985241, NULL, NULL, 'flower'
-- Brand/Designer, Nijntje --> NULL, NULL
UNION ALL SELECT 825334736, NULL, NULL, 'flower'
-- Brand/Designer, Noia Jewellery --> NULL, NULL
UNION ALL SELECT 1143765583, NULL, NULL, 'flower'
-- Brand/Designer, The Gift Label --> NULL, NULL
UNION ALL SELECT 1143744837, NULL, NULL, 'flower'
-- Brand/Designer, Tony's --> NULL, NULL
UNION ALL SELECT 1143735281, NULL, NULL, 'flower'
-- Color, Black --> Flower Colour, Other
UNION ALL SELECT 1143728198, 'flower-colour-other', 'Flower Colour', 'flower'
-- Color, Blue --> Flower Colour, Blue
UNION ALL SELECT 1143728186, 'blue', 'Flower Colour', 'flower'
-- Color, Cardinal --> Flower Colour, Red
UNION ALL SELECT 1143738519, 'red', 'Flower Colour', 'flower'
-- Color, DarkGreen --> Flower Colour, Green
UNION ALL SELECT 1143728176, 'green', 'Flower Colour', 'flower'
-- Color, DarkOrange --> Flower Colour, Orange
UNION ALL SELECT 1143728157, 'orange', 'Flower Colour', 'flower'
-- Color, DarkRed --> Flower Colour, Red
UNION ALL SELECT 1143728147, 'red', 'Flower Colour', 'flower'
-- Color, DeepPink --> Flower Colour, Pink
UNION ALL SELECT 1143728150, 'flower-colour-pink', 'Flower Colour', 'flower'
-- Color, Gold --> Flower Colour, Yellow
UNION ALL SELECT 1143728161, 'yellow', 'Flower Colour', 'flower'
-- Color, Green --> Flower Colour, Green
UNION ALL SELECT 727095708, 'green', 'Flower Colour', 'flower'
-- Color, HotPink --> Flower Colour, Pink
UNION ALL SELECT 1143728149, 'flower-colour-pink', 'Flower Colour', 'flower'
-- Color, Lavender --> Flower Colour, Purple
UNION ALL SELECT 1143728164, 'purple', 'Flower Colour', 'flower'
-- Color, LightSalmon --> Flower Colour, Pink
UNION ALL SELECT 1143728154, 'flower-colour-pink', 'Flower Colour', 'flower'
-- Color, Mix of colors --> Flower Colour, Multi Colour
UNION ALL SELECT 729235298, 'multi-colour', 'Flower Colour', 'flower'
-- Color, OrangeRed --> Flower Colour, Orange
UNION ALL SELECT 1143728156, 'orange', 'Flower Colour', 'flower'
-- Color, PastelPink --> Flower Colour, Pink
UNION ALL SELECT 1143738546, 'flower-colour-pink', 'Flower Colour', 'flower'
-- Color, PeachPuff --> Flower Colour, Peach
UNION ALL SELECT 1143728159, 'peach', 'Flower Colour', 'flower'
-- Color, Pink --> Flower Colour, Pink
UNION ALL SELECT 1143728148, 'flower-colour-pink', 'Flower Colour', 'flower'
-- Color, Purple --> Flower Colour, Purple
UNION ALL SELECT 727096014, 'purple', 'Flower Colour', 'flower'
-- Color, Raffia --> Flower Colour, Pink
UNION ALL SELECT 1143738555, 'flower-colour-pink', 'Flower Colour', 'flower'
-- Color, Red --> Flower Colour, Red
UNION ALL SELECT 1143728144, 'red', 'Flower Colour', 'flower'
-- Color, Salmon --> Flower Colour, Pink
UNION ALL SELECT 1143728142, 'flower-colour-pink', 'Flower Colour', 'flower'
-- Color, SteelBlue --> Flower Colour, Blue
UNION ALL SELECT 1143728181, 'blue', 'Flower Colour', 'flower'
-- Color, White --> Flower Colour, White
UNION ALL SELECT 1143728193, 'white', 'Flower Colour', 'flower'
-- Color, Yellow --> Flower Colour, Yellow
UNION ALL SELECT 1143728162, 'yellow', 'Flower Colour', 'flower'
-- Flower Type, Anjer --> Flowers & Plants, Carnations
UNION ALL SELECT 1143734331, 'carnations', 'Flowers & Plants', 'flower'
-- Flower Type, Chrysant --> Flowers & Plants, Chrysanthemums
UNION ALL SELECT 1143730302, 'chrysanthemums', 'Flowers & Plants', 'flower'
-- Flower Type, Gerbera --> Flowers & Plants, Gerbera
UNION ALL SELECT 1143730305, 'gerbera', 'Flowers & Plants', 'flower'
-- Flower Type, Leeuwenbek --> Flowers & Plants, Other
UNION ALL SELECT 1143734328, 'flowers-plants-other', 'Flowers & Plants', 'flower'
-- Flower Type, Lilies --> Flowers & Plants, Lilies
UNION ALL SELECT 1143731312, 'lilies', 'Flowers & Plants', 'flower'
-- Flower Type, Lisianthus --> Flowers & Plants, Lisianthus
UNION ALL SELECT 1143740557, 'lisianthus', 'Flowers & Plants', 'flower'
-- Flower Type, Orchids --> Flowers & Plants, Orchid
UNION ALL SELECT 1143730311, 'orchid', 'Flowers & Plants', 'flower'
-- Flower Type, Peony --> Flowers & Plants, Peonies
UNION ALL SELECT 1143746788, 'peonies', 'Flowers & Plants', 'flower'
-- Flower Type, Roses --> Flowers & Plants, Roses
UNION ALL SELECT 1143730299, 'roses', 'Flowers & Plants', 'flower'
-- Flower Type, Tulips --> Flowers & Plants, Tulips
UNION ALL SELECT 1143731309, 'tulips', 'Flowers & Plants', 'flower'
-- Highlighted, Boeket van de maand (bloemen) --> Flowers & Plants, Bouquets
UNION ALL SELECT 1143737617, 'bouquets', 'Flowers & Plants', 'flower'
-- Highlighted, Seizoenstoppers (bloemen) --> NewIa, Flowers & Plants
UNION ALL SELECT 1143737620, 'flowers-plants', 'NewIa', 'flower'
-- Occasion, Anniversary --> Occasion, Anniversaries
UNION ALL SELECT 1143740082, 'anniversaries', 'Occasion', 'flower'
-- Occasion, AOC think --> Occasion, Thinking of you
UNION ALL SELECT 1143742160, 'occasion-thinking-of-you', 'Occasion', 'flower'
-- Occasion, Babyshower --> Occasion, Baby Shower
UNION ALL SELECT 1143739143, 'baby-shower', 'Occasion', 'flower'
-- Occasion, Birth --> Occasion, New Baby
UNION ALL SELECT 726324202, 'occasion-new-baby', 'Occasion', 'flower'
-- Occasion, Birth visite --> Occasion, New Baby
UNION ALL SELECT 1143739134, 'occasion-new-baby', 'Occasion', 'flower'
-- Occasion, Birthday --> Occasion, Birthday
UNION ALL SELECT 726324105, 'occasion-birthday', 'Occasion', 'flower'
-- Occasion, Condolence --> Occasion, Sympathy
UNION ALL SELECT 726345401, 'occasion-sympathy', 'Occasion', 'flower'
-- Occasion, Congratulations (card and gift) --> Occasion, Congratulations
UNION ALL SELECT 1143729948, 'occasion-congratulations', 'Occasion', 'flower'
-- Occasion, Easter/Pasen --> Occasion, Easter
UNION ALL SELECT 726343205, 'occasion-easter', 'Occasion', 'flower'
-- Occasion, Eid Mubarak --> Religious Occasions, Eid Mubarak
UNION ALL SELECT 1143746767, 'eid-mubarak', 'Religious Occasions', 'flower'
-- Occasion, Fathersday --> Occasion, Fathers Day
UNION ALL SELECT 726332069, 'fathers-day', 'Occasion', 'flower'
-- Occasion, Friendship2 --> Occasion, Friendship
UNION ALL SELECT 893069562, 'occasion-friendship', 'Occasion', 'flower'
-- Occasion, Get well --> Occasion, Get Well
UNION ALL SELECT 726345521, 'occasion-get-well', 'Occasion', 'flower'
-- Occasion, Good luck --> Occasion, Good Luck
UNION ALL SELECT 726345736, 'occasion-good-luck', 'Occasion', 'flower'
-- Occasion, Graduation --> Occasion, Graduation
UNION ALL SELECT 1143729906, 'occasion-graduation', 'Occasion', 'flower'
-- Occasion, Just because --> Occasion, Just to say
UNION ALL SELECT 726347430, 'just-to-say', 'Occasion', 'flower'
-- Occasion, Kerst (flowers) --> Occasion, Christmas
UNION ALL SELECT 1143735354, 'occasion-christmas', 'Occasion', 'flower'
-- Occasion, Living together --> Occasion, New Home
UNION ALL SELECT 1143727835, 'occasion-new-home', 'Occasion', 'flower'
-- Occasion, Love --> Occasion, Missing You
UNION ALL SELECT 1143727832, 'missing-you', 'Occasion', 'flower'
-- Occasion, Mothersday --> Occasion, Mothers Day
UNION ALL SELECT 726331722, 'mothers-day', 'Occasion', 'flower'
-- Occasion, New home --> Occasion, New Home
UNION ALL SELECT 726342840, 'occasion-new-home', 'Occasion', 'flower'
-- Occasion, New Job --> Occasion, New Job
UNION ALL SELECT 735872747, 'occasion-new-job', 'Occasion', 'flower'
-- Occasion, Pregnant --> Occasion, Pregnancy
UNION ALL SELECT 726344253, 'occasion-pregnancy', 'Occasion', 'flower'
-- Occasion, Retirement --> Occasion, Retirement
UNION ALL SELECT 735873966, 'occasion-retirement', 'Occasion', 'flower'
-- Occasion, Secretaryday --> Occasion, Other
UNION ALL SELECT 1143731240, 'occasion-other', 'Occasion', 'flower'
-- Occasion, Sorry --> Occasion, Sorry
UNION ALL SELECT 726966325, 'occasion-sorry', 'Occasion', 'flower'
-- Occasion, Spring (flowers) --> Occasion, Other
UNION ALL SELECT 1143731093, 'occasion-other', 'Occasion', 'flower'
-- Occasion, Thank you --> Occasion, Thank You
UNION ALL SELECT 726347103, 'occasion-thank-you', 'Occasion', 'flower'
-- Occasion, Thank you teacher --> Occasion, Thank You
UNION ALL SELECT 1143742415, 'occasion-thank-you', 'Occasion', 'flower'
-- Occasion, Thanks teacher --> Occasion, Thank You
UNION ALL SELECT 1143757148, 'occasion-thank-you', 'Occasion', 'flower'
-- Occasion, Thinking of you --> Occasion, Thinking of you
UNION ALL SELECT 748511930, 'occasion-thinking-of-you', 'Occasion', 'flower'
-- Occasion, Vacation --> Occasion, Bon Voyage
UNION ALL SELECT 1143729435, 'occasion-bon-voyage', 'Occasion', 'flower'
-- Occasion, Valentine --> Occasion, Valentines Day
UNION ALL SELECT 726324647, 'valentines-day', 'Occasion', 'flower'
-- Occasion, Wedding --> Occasion, Wedding
UNION ALL SELECT 726342081, 'occasion-wedding', 'Occasion', 'flower'
-- Occasion, Zakelijke kerstgeschenken --> Occasion, Christmas
UNION ALL SELECT 1143747560, 'occasion-christmas', 'Occasion', 'flower'
-- Product Family, AccessoriesL2 --> NewIa, Accessories
UNION ALL SELECT 950102332, 'accessories', 'NewIa', 'flower'
-- Product Family, All chocolate --> Food & Drink, Chocolate
UNION ALL SELECT 1143738429, 'chocolate', 'Food & Drink', 'flower'
-- Product Family, Baby and kids --> NewIa, Toys Kids & Baby
UNION ALL SELECT 1143739056, 'toys-kids-baby', 'NewIa', 'flower'
-- Product Family, Baby and kids L2 --> NewIa, Toys Kids & Baby
UNION ALL SELECT 1143739053, 'toys-kids-baby', 'NewIa', 'flower'
-- Product Family, Baby toys --> NewIa, Toys Kids & Baby
UNION ALL SELECT 1143739059, 'toys-kids-baby', 'NewIa', 'flower'
-- Product Family, Beauty --> NewIa, Beauty Face & Body
UNION ALL SELECT 1143727993, 'beauty-face-body', 'NewIa', 'flower'
-- Product Family, Beauty and careL2 --> NewIa, Beauty Face & Body
UNION ALL SELECT 726960191, 'beauty-face-body', 'NewIa', 'flower'
-- Product Family, Beer --> Alcohol, Beer & Cider
UNION ALL SELECT 784098536, 'beer-cider', 'Alcohol', 'flower'
-- Product Family, Beer package --> Alcohol, Beer & Cider
UNION ALL SELECT 1143731725, 'beer-cider', 'Alcohol', 'flower'
-- Product Family, Blond beer --> Beer & Cider, Lager
UNION ALL SELECT 1143732235, 'lager', 'Beer & Cider', 'flower'
-- Product Family, Bloompost --> Flowers Gift Sets & Letterbox, Letterbox
UNION ALL SELECT 1143731608, 'letterbox', 'Flowers Gift Sets & Letterbox', 'flower'
-- Product Family, Box and bed toys --> NewIa, Toys Kids & Baby
UNION ALL SELECT 1143739206, 'toys-kids-baby', 'NewIa', 'flower'
-- Product Family, Chocolade repen --> Food & Drink, Chocolate
UNION ALL SELECT 1143742991, 'chocolate', 'Food & Drink', 'flower'
-- Product Family, Chocolate --> Food & Drink, Chocolate
UNION ALL SELECT 726930909, 'chocolate', 'Food & Drink', 'flower'
-- Product Family, Chocolate truffels --> Food & Drink, Chocolate
UNION ALL SELECT 1143747590, 'chocolate', 'Food & Drink', 'flower'
-- Product Family, Drinks --> NewIa, Food & Drink
UNION ALL SELECT 1143727296, 'food-drink', 'NewIa', 'flower'
-- Product Family, Dry Flowers --> Flowers & Plants, Dried Flowers
UNION ALL SELECT 1143750422, 'dried-flowers', 'Flowers & Plants', 'flower'
-- Product Family, Eating and drinkingl2 --> NewIa, Food & Drink
UNION ALL SELECT 726930780, 'food-drink', 'NewIa', 'flower'
-- Product Family, Extra Large Bouquets --> Flowers & Plants, Bouquets
UNION ALL SELECT 1143747422, 'bouquets', 'Flowers & Plants', 'flower'
-- Product Family, Field Bouquets --> Flowers & Plants, Bouquets
UNION ALL SELECT 1143749222, 'bouquets', 'Flowers & Plants', 'flower'
-- Product Family, Flowers and plants --> NewIa, Flowers & Plants
UNION ALL SELECT 800471607, 'flowers-plants', 'NewIa', 'flower'
-- Product Family, Flowers and plantsL2 --> NewIa, Flowers & Plants
UNION ALL SELECT 726933058, 'flowers-plants', 'NewIa', 'flower'
-- Product Family, Flowers with gift --> Flowers Gift Sets & Letterbox, Gift Sets
UNION ALL SELECT 1143731557, 'flowers-gift-sets-letterbox-gift-sets', 'Flowers Gift Sets & Letterbox', 'flower'
-- Product Family, Flowers with vase --> Flowers Gift Sets & Letterbox, With vase
UNION ALL SELECT 1143740563, 'with-vase', 'Flowers Gift Sets & Letterbox', 'flower'
-- Product Family, Flowers3 --> NewIa, Flowers & Plants
UNION ALL SELECT 1143727951, 'flowers-plants', 'NewIa', 'flower'
-- Product Family, Giftboxen --> Gift Sets Hampers Letterbox, Gift Sets
UNION ALL SELECT 1143735393, 'gift-sets-hampers-letterbox-gift-sets', 'Gift Sets Hampers Letterbox', 'flower'
-- Product Family, Gifts --> NewIa, Personalised Gifts
UNION ALL SELECT 727212959, 'personalised-gifts', 'NewIa', 'flower'
-- Product Family, Giftsets --> Gift Sets Hampers Letterbox, Gift Sets
UNION ALL SELECT 1143751673, 'gift-sets-hampers-letterbox-gift-sets', 'Gift Sets Hampers Letterbox', 'flower'
-- Product Family, Handsoap --> NewIa, Beauty Face & Body
UNION ALL SELECT 1143744897, 'beauty-face-body', 'NewIa', 'flower'
-- Product Family, Mourning (bouquet) --> Flowers & Plants, Bouquets
UNION ALL SELECT 1143730245, 'bouquets', 'Flowers & Plants', 'flower'
-- Product Family, Plants with gift --> Flowers Gift Sets & Letterbox, Gift Sets
UNION ALL SELECT 1143765353, 'flowers-gift-sets-letterbox-gift-sets', 'Flowers Gift Sets & Letterbox', 'flower'
-- Product Family, Plants3 --> NewIa, Flowers & Plants
UNION ALL SELECT 1143727954, 'flowers-plants', 'NewIa', 'flower'
-- Product Family, Plush toys --> Toys Kids & Baby, Soft Toys
UNION ALL SELECT 1143739200, 'soft-toys', 'Toys Kids & Baby', 'flower'
-- Product Family, Rattles --> Toys Kids & Baby, Baby
UNION ALL SELECT 1143748052, 'toys-kids-baby-baby', 'Toys Kids & Baby', 'flower'
-- Product Family, Red wine --> Champagne Prosecco & Wine, Red wine
UNION ALL SELECT 784103211, 'red-wine', 'Champagne Prosecco & Wine', 'flower'
-- Product Family, Seeds --> NewIa, Home & Garden
UNION ALL SELECT 1143740284, 'home-garden', 'NewIa', 'flower'
-- Product Family, Shower gel --> NewIa, Beauty Face & Body
UNION ALL SELECT 1143742442, 'beauty-face-body', 'NewIa', 'flower'
-- Product Family, Socks --> Accessories, Socks
UNION ALL SELECT 1143765383, 'socks', 'Accessories', 'flower'
-- Product Family, Soft plush --> Toys Kids & Baby, Soft Toys
UNION ALL SELECT 1143741583, 'soft-toys', 'Toys Kids & Baby', 'flower'
-- Product Family, Sparkling wine --> Champagne Prosecco & Wine, Sparkling Wine
UNION ALL SELECT 1143747022, 'sparkling-wine', 'Champagne Prosecco & Wine', 'flower'
-- Product Family, White wine --> Champagne Prosecco & Wine, White wine
UNION ALL SELECT 784100994, 'white-wine', 'Champagne Prosecco & Wine', 'flower'
-- Product Family, Wine --> Alcohol, Champagne Prosecco & Wine
UNION ALL SELECT 899226515, 'champagne-prosecco-wine', 'Alcohol', 'flower'
-- Size, Large --> NULL, NULL
UNION ALL SELECT 1143728311, NULL, NULL, 'flower'
-- Size, Medium --> NULL, NULL
UNION ALL SELECT 1143728308, NULL, NULL, 'flower'
-- Target Group, Boy --> Who's it for?, For Boys
UNION ALL SELECT 886506339, 'for-boys', 'Whos it for?', 'flower'
-- Target Group, Girl --> Who's it for?, For Girls
UNION ALL SELECT 886507052, 'for-girls', 'Whos it for?', 'flower'
-- Target Group, Men --> Who's it for?, For Him
UNION ALL SELECT 1143750956, 'for-him', 'Whos it for?', 'flower'
-- Target Group, Women --> Who's it for?, For Her
UNION ALL SELECT 1143750947, 'for-her', 'Whos it for?', 'flower'
-- Target Group, Zakelijk1 (cards missions) --> Who's it For?, Other
UNION ALL SELECT 1143732725, 'newia-gift-experiences-whos-it-for-other', 'Whos it For?', 'flower'
-- Theme, Brievenbuscadeau --> Flowers Gift Sets & Letterbox, Letterbox
UNION ALL SELECT 1143732596, 'letterbox', 'Flowers Gift Sets & Letterbox', 'flower'
-- Type, Chocolate with flowers --> Flowers Gift Sets & Letterbox, Gift Sets
UNION ALL SELECT 1143749624, 'flowers-gift-sets-letterbox-gift-sets', 'Flowers Gift Sets & Letterbox', 'flower'
-- Type, Drinks with flowers --> Flowers Gift Sets & Letterbox, Gift Sets
UNION ALL SELECT 1143746501, 'flowers-gift-sets-letterbox-gift-sets', 'Flowers Gift Sets & Letterbox', 'flower'
-- Type, Giftset --> Gift Sets Hampers Letterbox, Gift Sets
UNION ALL SELECT 1143739698, 'gift-sets-hampers-letterbox-gift-sets', 'Gift Sets Hampers Letterbox', 'flower'
-- Type, Letterbox gifts --> Gift Sets Hampers Letterbox, Letterbox
UNION ALL SELECT 1143737611, 'gift-sets-hampers-letterbox-letterbox', 'Gift Sets Hampers Letterbox', 'flower'
-- Brand/Designer, Beauty cadeau --> NULL, NULL
UNION ALL SELECT 1143745734, NULL, NULL, 'gift-card'
-- Brand/Designer, Bol.com --> NULL, NULL
UNION ALL SELECT 1143745590, NULL, NULL, 'gift-card'
-- Brand/Designer, De Nederlandse Sauna --> NULL, NULL
UNION ALL SELECT 1143745740, NULL, NULL, 'gift-card'
-- Brand/Designer, Gift for you --> NULL, NULL
UNION ALL SELECT 1143746078, NULL, NULL, 'gift-card'
-- Brand/Designer, Greetz --> NULL, NULL
UNION ALL SELECT 726316072, NULL, NULL, 'gift-card'
-- Brand/Designer, Hema --> NULL, NULL
UNION ALL SELECT 1143745581, NULL, NULL, 'gift-card'
-- Brand/Designer, Huis en tuin cadeau --> NULL, NULL
UNION ALL SELECT 1143746791, NULL, NULL, 'gift-card'
-- Brand/Designer, Karwei --> NULL, NULL
UNION ALL SELECT 1143745587, NULL, NULL, 'gift-card'
-- Brand/Designer, Kids cadeau --> NULL, NULL
UNION ALL SELECT 1143745743, NULL, NULL, 'gift-card'
-- Brand/Designer, Klus Cadeau --> NULL, NULL
UNION ALL SELECT 1143746602, NULL, NULL, 'gift-card'
-- Brand/Designer, Momento --> NULL, NULL
UNION ALL SELECT 1143745776, NULL, NULL, 'gift-card'
-- Brand/Designer, Pathe --> NULL, NULL
UNION ALL SELECT 1143745584, NULL, NULL, 'gift-card'
-- Brand/Designer, Restaurant cadeau --> NULL, NULL
UNION ALL SELECT 1143745737, NULL, NULL, 'gift-card'
-- Brand/Designer, VVV --> NULL, NULL
UNION ALL SELECT 1143745593, NULL, NULL, 'gift-card'
-- Occasion, Anniversary --> Occasion, Anniversaries
UNION ALL SELECT 1143740082, 'anniversaries', 'Occasion', 'gift-card'
-- Occasion, AOC think --> Occasion, Thinking of you
UNION ALL SELECT 1143742160, 'occasion-thinking-of-you', 'Occasion', 'gift-card'
-- Occasion, Babyshower --> Occasion, Baby Shower
UNION ALL SELECT 1143739143, 'baby-shower', 'Occasion', 'gift-card'
-- Occasion, Birthday --> Occasion, Birthday
UNION ALL SELECT 726324105, 'occasion-birthday', 'Occasion', 'gift-card'
-- Occasion, Brother and Sister day --> Occasion, Friendship
UNION ALL SELECT 1143732527, 'occasion-friendship', 'Occasion', 'gift-card'
-- Occasion, Christmas --> Occasion, Christmas
UNION ALL SELECT 726331358, 'occasion-christmas', 'Occasion', 'gift-card'
-- Occasion, Congratulations (card and gift) --> Occasion, Congratulations
UNION ALL SELECT 1143729948, 'occasion-congratulations', 'Occasion', 'gift-card'
-- Occasion, Fathersday --> Occasion, Fathers Day
UNION ALL SELECT 726332069, 'fathers-day', 'Occasion', 'gift-card'
-- Occasion, Friendship2 --> Occasion, Friendship
UNION ALL SELECT 893069562, 'occasion-friendship', 'Occasion', 'gift-card'
-- Occasion, Get well --> Occasion, Get Well
UNION ALL SELECT 726345521, 'occasion-get-well', 'Occasion', 'gift-card'
-- Occasion, Good luck --> Occasion, Good Luck
UNION ALL SELECT 726345736, 'occasion-good-luck', 'Occasion', 'gift-card'
-- Occasion, Goodbye colleague --> Occasion, Goodbye
UNION ALL SELECT 1143736110, 'goodbye', 'Occasion', 'gift-card'
-- Occasion, Graduation --> Occasion, Graduation
UNION ALL SELECT 1143729906, 'occasion-graduation', 'Occasion', 'gift-card'
-- Occasion, Just because --> Occasion, Just to say
UNION ALL SELECT 726347430, 'just-to-say', 'Occasion', 'gift-card'
-- Occasion, Living together --> Occasion, New Home
UNION ALL SELECT 1143727835, 'occasion-new-home', 'Occasion', 'gift-card'
-- Occasion, Love --> Occasion, Missing You
UNION ALL SELECT 1143727832, 'missing-you', 'Occasion', 'gift-card'
-- Occasion, Mothersday --> Occasion, Mothers Day
UNION ALL SELECT 726331722, 'mothers-day', 'Occasion', 'gift-card'
-- Occasion, New home --> Occasion, New Home
UNION ALL SELECT 726342840, 'occasion-new-home', 'Occasion', 'gift-card'
-- Occasion, New Job --> Occasion, New Job
UNION ALL SELECT 735872747, 'occasion-new-job', 'Occasion', 'gift-card'
-- Occasion, Opening new business --> Occasion, Well Done
UNION ALL SELECT 1143744579, 'occasion-well-done', 'Occasion', 'gift-card'
-- Occasion, Retirement --> Occasion, Retirement
UNION ALL SELECT 735873966, 'occasion-retirement', 'Occasion', 'gift-card'
-- Occasion, Sorry --> Occasion, Sorry
UNION ALL SELECT 726966325, 'occasion-sorry', 'Occasion', 'gift-card'
-- Occasion, Thank you --> Occasion, Thank You
UNION ALL SELECT 726347103, 'occasion-thank-you', 'Occasion', 'gift-card'
-- Occasion, Thank you teacher --> Occasion, Thank You
UNION ALL SELECT 1143742415, 'occasion-thank-you', 'Occasion', 'gift-card'
-- Occasion, Thinking of you --> Occasion, Thinking of you
UNION ALL SELECT 748511930, 'occasion-thinking-of-you', 'Occasion', 'gift-card'
-- Occasion, Valentine --> Occasion, Valentines Day
UNION ALL SELECT 726324647, 'valentines-day', 'Occasion', 'gift-card'
-- Occasion, Wedding --> Occasion, Wedding
UNION ALL SELECT 726342081, 'occasion-wedding', 'Occasion', 'gift-card'
-- Occasion, Zakelijke kerstgeschenken --> Occasion, Christmas
UNION ALL SELECT 1143747560, 'occasion-christmas', 'Occasion', 'gift-card'
-- Product Family, Drinking and eating --> Interests & Hobbies, Food and Drink
UNION ALL SELECT 1143745605, 'food-and-drink', 'Interests & Hobbies', 'gift-card'
-- Product Family, Experiences --> NewIa, Gift Experiences
UNION ALL SELECT 1143745602, 'gift-experiences', 'NewIa', 'gift-card'
-- Product Family, Fashion and shopping --> Gift Cards, Home Fashion
UNION ALL SELECT 1143745608, 'home-fashion', 'Gift Cards', 'gift-card'
-- Product Family, Gift Cards --> NULL, NULL
UNION ALL SELECT 787982115, NULL, NULL, 'gift-card'
-- Product Family, GiftcardsL2 --> NULL, NULL
UNION ALL SELECT 899676844, NULL, NULL, 'gift-card'
-- Product Family, Gifts --> NewIa, Personalised Gifts
UNION ALL SELECT 727212959, 'personalised-gifts', 'NewIa', 'gift-card'
-- Product Family, Living and garden --> Gift Cards, Home Fashion
UNION ALL SELECT 1143745596, 'home-fashion', 'Gift Cards', 'gift-card'
-- Product Family, Wellness and beauty --> Gift Cards, Home Fashion
UNION ALL SELECT 1143745599, 'home-fashion', 'Gift Cards', 'gift-card'
-- Size, €100 --> NULL, NULL
UNION ALL SELECT 1143745314, NULL, NULL, 'gift-card'
-- Size, €125 --> NULL, NULL
UNION ALL SELECT 1143749770, NULL, NULL, 'gift-card'
-- Size, €150 --> NULL, NULL
UNION ALL SELECT 1143749773, NULL, NULL, 'gift-card'
-- Size, €25 --> NULL, NULL
UNION ALL SELECT 1143745302, NULL, NULL, 'gift-card'
-- Size, €35 --> NULL, NULL
UNION ALL SELECT 1143745305, NULL, NULL, 'gift-card'
-- Size, €50 --> NULL, NULL
UNION ALL SELECT 1143745308, NULL, NULL, 'gift-card'
-- Size, €75 --> NULL, NULL
UNION ALL SELECT 1143745311, NULL, NULL, 'gift-card'
-- Size, 10 x 10 cm --> NULL, NULL
UNION ALL SELECT 1143728296, NULL, NULL, 'gift-card'
-- Size, 14 pieces --> NULL, NULL
UNION ALL SELECT 1143738933, NULL, NULL, 'gift-card'
-- Size, 15 --> NULL, NULL
UNION ALL SELECT 1143745296, NULL, NULL, 'gift-card'
-- Size, 20 --> NULL, NULL
UNION ALL SELECT 1143745299, NULL, NULL, 'gift-card'
-- Size, 25 persons --> NULL, NULL
UNION ALL SELECT 1143736632, NULL, NULL, 'gift-card'
-- Target Group, Boy --> Who's it for?, For Boys
UNION ALL SELECT 886506339, 'for-boys', 'Whos it for?', 'gift-card'
-- Target Group, Girl --> Who's it for?, For Girls
UNION ALL SELECT 886507052, 'for-girls', 'Whos it for?', 'gift-card'
-- Target Group, Men --> Who's it for?, For Him
UNION ALL SELECT 1143750956, 'for-him', 'Whos it for?', 'gift-card'
-- Target Group, Women --> Who's it for?, For Her
UNION ALL SELECT 1143750947, 'for-her', 'Whos it for?', 'gift-card'
-- Target Group, Zakelijk1 (cards missions) --> Who's it For?, Other
UNION ALL SELECT 1143732725, 'newia-gift-experiences-whos-it-for-other', 'Whos it For?', 'gift-card'
-- Type, Letterbox gifts --> Gift Sets Hampers Letterbox, Letterbox
UNION ALL SELECT 1143737611, 'gift-sets-hampers-letterbox-letterbox', 'Gift Sets Hampers Letterbox', 'gift-card'
-- Age, 18 years and older --> Age, Young Adult 18 24 years old
UNION ALL SELECT 880438645, 'young-adult-18-24-years-old', 'Age', 'home-gift'
-- Age, 18 years and older --> Age, Senior over 65 years old
UNION ALL SELECT 880438645, 'senior-over-65-years-old', 'Age', 'home-gift'
-- Age, 18 years and older --> Age, Adult 25 64 years old
UNION ALL SELECT 880438645, 'adult-25-64-years-old', 'Age', 'home-gift'
-- Age, Baby 0 tot 1 year --> Age, Baby 0 1 years old
UNION ALL SELECT 880440481, 'baby-0-1-years-old', 'Age', 'home-gift'
-- Age, Dreumes 1 to 2 years --> Age, Baby 0 1 years old
UNION ALL SELECT 880444402, 'baby-0-1-years-old', 'Age', 'home-gift'
-- Age, Jongeren 12 to 18 years --> Age, Teen 13 17 years old
UNION ALL SELECT 748494248, 'teen-13-17-years-old', 'Age', 'home-gift'
-- Age, Kids 6 tot 12 years --> Age, Kids 6 9 years old
UNION ALL SELECT 742758311, 'kids-6-9-years-old', 'Age', 'home-gift'
-- Age, Kids 6 tot 12 years --> Age, Tween 9 12 years old
UNION ALL SELECT 742758311, 'tween-9-12-years-old', 'Age', 'home-gift'
-- Age, Kleuter 4 to 6 years --> Age, Kids 2 5 years old
UNION ALL SELECT 742755895, 'kids-2-5-years-old', 'Age', 'home-gift'
-- Age, Peuter 2 to 4 years --> Age, Kids 2 5 years old
UNION ALL SELECT 742755383, 'kids-2-5-years-old', 'Age', 'home-gift'
-- Brand/Designer, Andere Koek voor thuis --> NULL, NULL
UNION ALL SELECT 1143741115, NULL, NULL, 'home-gift'
-- Brand/Designer, BAMBAM --> NULL, NULL
UNION ALL SELECT 726982765, NULL, NULL, 'home-gift'
-- Brand/Designer, Blond Amsterdam --> NULL, NULL
UNION ALL SELECT 726304426, NULL, NULL, 'home-gift'
-- Brand/Designer, Blond Noir --> NULL, NULL
UNION ALL SELECT 1143750274, NULL, NULL, 'home-gift'
-- Brand/Designer, Done by Deer --> NULL, NULL
UNION ALL SELECT 1143739107, NULL, NULL, 'home-gift'
-- Brand/Designer, Dopper --> NULL, NULL
UNION ALL SELECT 1143766928, NULL, NULL, 'home-gift'
-- Brand/Designer, Duc de la Forêt --> NULL, NULL
UNION ALL SELECT 1143751808, NULL, NULL, 'home-gift'
-- Brand/Designer, Duvel --> NULL, NULL
UNION ALL SELECT 1143736021, NULL, NULL, 'home-gift'
-- Brand/Designer, Greetz --> NULL, NULL
UNION ALL SELECT 726316072, NULL, NULL, 'home-gift'
-- Brand/Designer, Happy Socks --> Brands, Happy Socks
UNION ALL SELECT 1143738180, 'happy-socks', 'Brands', 'home-gift'
-- Brand/Designer, Hip en Mama Box --> NULL, NULL
UNION ALL SELECT 1143764103, NULL, NULL, 'home-gift'
-- Brand/Designer, Kikkerland --> NULL, NULL
UNION ALL SELECT 1143767298, NULL, NULL, 'home-gift'
-- Brand/Designer, Koeka --> NULL, NULL
UNION ALL SELECT 1143739092, NULL, NULL, 'home-gift'
-- Brand/Designer, La Chouffe --> NULL, NULL
UNION ALL SELECT 1143730644, NULL, NULL, 'home-gift'
-- Brand/Designer, La Gioiosa --> NULL, NULL
UNION ALL SELECT 1143751814, NULL, NULL, 'home-gift'
-- Brand/Designer, Laguiole Style de Vie --> NULL, NULL
UNION ALL SELECT 1143768653, NULL, NULL, 'home-gift'
-- Brand/Designer, Leopold Vienna --> NULL, NULL
UNION ALL SELECT 1143766408, NULL, NULL, 'home-gift'
-- Brand/Designer, Mepal --> NULL, NULL
UNION ALL SELECT 1143766988, NULL, NULL, 'home-gift'
-- Brand/Designer, Milestone --> NULL, NULL
UNION ALL SELECT 1143739098, NULL, NULL, 'home-gift'
-- Brand/Designer, My Jewellery --> NULL, NULL
UNION ALL SELECT 1143766933, NULL, NULL, 'home-gift'
-- Brand/Designer, Naif --> NULL, NULL
UNION ALL SELECT 1143739110, NULL, NULL, 'home-gift'
-- Brand/Designer, Nijntje --> NULL, NULL
UNION ALL SELECT 825334736, NULL, NULL, 'home-gift'
-- Brand/Designer, Noia Jewellery --> NULL, NULL
UNION ALL SELECT 1143765583, NULL, NULL, 'home-gift'
-- Brand/Designer, One Message Spoon --> NULL, NULL
UNION ALL SELECT 1143768648, NULL, NULL, 'home-gift'
-- Brand/Designer, Snor --> NULL, NULL
UNION ALL SELECT 1143739095, NULL, NULL, 'home-gift'
-- Brand/Designer, Style de Vie --> NULL, NULL
UNION ALL SELECT 1143768643, NULL, NULL, 'home-gift'
-- Brand/Designer, The Flavour Company --> NULL, NULL
UNION ALL SELECT 1143750139, NULL, NULL, 'home-gift'
-- Brand/Designer, vtwonen --> NULL, NULL
UNION ALL SELECT 1143768678, NULL, NULL, 'home-gift'
-- Brand/Designer, Woezel en Pip --> NULL, NULL
UNION ALL SELECT 726305507, NULL, NULL, 'home-gift'
-- Brand/Designer, Zilverstad --> NULL, NULL
UNION ALL SELECT 1143766403, NULL, NULL, 'home-gift'
-- Brand/Designer, Zowy Jewellery --> NULL, NULL
UNION ALL SELECT 1143760508, NULL, NULL, 'home-gift'
-- Color, Black --> NULL, NULL
UNION ALL SELECT 1143728198, 'black', NULL, 'home-gift'
-- Color, Blue --> NULL, NULL
UNION ALL SELECT 1143728186, 'colour-blue', NULL, 'home-gift'
-- Color, Brown --> NULL, NULL
UNION ALL SELECT 727095669, 'coloured', NULL, 'home-gift'
-- Color, Chocolate --> NULL, NULL
UNION ALL SELECT 1143728189, 'coloured', NULL, 'home-gift'
-- Color, DarkGreen --> NULL, NULL
UNION ALL SELECT 1143728176, 'coloured', NULL, 'home-gift'
-- Color, DeepPink --> NULL, NULL
UNION ALL SELECT 1143728150, 'pink', NULL, 'home-gift'
-- Color, EasternBlue --> NULL, NULL
UNION ALL SELECT 1143738531, 'colour-blue', NULL, 'home-gift'
-- Color, Gold --> NULL, NULL
UNION ALL SELECT 1143728161, 'coloured', NULL, 'home-gift'
-- Color, Gray --> NULL, NULL
UNION ALL SELECT 727096150, 'coloured', NULL, 'home-gift'
-- Color, LemonChiffon --> NULL, NULL
UNION ALL SELECT 1143728163, 'coloured', NULL, 'home-gift'
-- Color, Mix of colors --> NULL, NULL
UNION ALL SELECT 729235298, 'multicolour', NULL, 'home-gift'
-- Color, OliveDrab --> NULL, NULL
UNION ALL SELECT 1143728177, 'coloured', NULL, 'home-gift'
-- Color, Pink --> NULL, NULL
UNION ALL SELECT 1143728148, 'pink', NULL, 'home-gift'
-- Color, Red --> NULL, NULL
UNION ALL SELECT 1143728144, 'coloured', NULL, 'home-gift'
-- Color, Silver --> NULL, NULL
UNION ALL SELECT 1143728196, 'colour-white', NULL, 'home-gift'
-- Color, White --> NULL, NULL
UNION ALL SELECT 1143728193, 'colour-white', NULL, 'home-gift'
-- Design Style, Hip --> NULL, NULL
UNION ALL SELECT 726296336, NULL, NULL, 'home-gift'
-- Highlighted, beer with personalised label --> NewIa, Personalised Gifts
UNION ALL SELECT 1143748475, 'personalised-gifts', 'NewIa', 'home-gift'
-- Highlighted, beer with personalised label --> Alcohol, Beer & Cider
UNION ALL SELECT 1143748475, 'beer-cider', 'Alcohol', 'home-gift'
-- Highlighted, Wijn met eigen etiket --> NewIa, Personalised Gifts
UNION ALL SELECT 1143742496, 'personalised-gifts', 'NewIa', 'home-gift'
-- Highlighted, Wijn met eigen etiket --> Alcohol, Champagne Prosecco & Wine
UNION ALL SELECT 1143742496, 'champagne-prosecco-wine', 'Alcohol', 'home-gift'
-- Occasion, Anniversary --> Occasion, Anniversaries
UNION ALL SELECT 1143740082, 'anniversaries', 'Occasion', 'home-gift'
-- Occasion, AOC think --> Occasion, Thinking of you
UNION ALL SELECT 1143742160, 'occasion-thinking-of-you', 'Occasion', 'home-gift'
-- Occasion, Babyshower --> Occasion, Baby Shower
UNION ALL SELECT 1143739143, 'baby-shower', 'Occasion', 'home-gift'
-- Occasion, Babyshower (gifts) --> Occasion, Baby Shower
UNION ALL SELECT 1143742373, 'baby-shower', 'Occasion', 'home-gift'
-- Occasion, Birth --> Occasion, New Baby
UNION ALL SELECT 726324202, 'occasion-new-baby', 'Occasion', 'home-gift'
-- Occasion, Birth visite --> Occasion, New Baby
UNION ALL SELECT 1143739134, 'occasion-new-baby', 'Occasion', 'home-gift'
-- Occasion, Birthday --> Occasion, Birthday
UNION ALL SELECT 726324105, 'occasion-birthday', 'Occasion', 'home-gift'
-- Occasion, Brother and Sister day --> Occasion, Friendship
UNION ALL SELECT 1143732527, 'occasion-friendship', 'Occasion', 'home-gift'
-- Occasion, Christmas --> Occasion, Christmas
UNION ALL SELECT 726331358, 'occasion-christmas', 'Occasion', 'home-gift'
-- Occasion, Condolence --> Occasion, Sympathy
UNION ALL SELECT 726345401, 'occasion-sympathy', 'Occasion', 'home-gift'
-- Occasion, Congratulations (card and gift) --> Occasion, Congratulations
UNION ALL SELECT 1143729948, 'occasion-congratulations', 'Occasion', 'home-gift'
-- Occasion, Day of the animals --> Occasion, Other
UNION ALL SELECT 735910080, 'occasion-other', 'Occasion', 'home-gift'
-- Occasion, Eid Mubarak --> Religious Occasions, Eid Mubarak
UNION ALL SELECT 1143746767, 'eid-mubarak', 'Religious Occasions', 'home-gift'
-- Occasion, Exams (gifts) --> Occasion, Exams
UNION ALL SELECT 726344432, 'occasion-exams', 'Occasion', 'home-gift'
-- Occasion, Fall (Flowers --> Occasion, Other
UNION ALL SELECT 1143732590, 'occasion-other', 'Occasion', 'home-gift'
-- Occasion, Fathersday --> Occasion, Fathers Day
UNION ALL SELECT 726332069, 'fathers-day', 'Occasion', 'home-gift'
-- Occasion, Friendship2 --> Occasion, Friendship
UNION ALL SELECT 893069562, 'occasion-friendship', 'Occasion', 'home-gift'
-- Occasion, Get well --> Occasion, Get Well
UNION ALL SELECT 726345521, 'occasion-get-well', 'Occasion', 'home-gift'
-- Occasion, Good luck --> Occasion, Good Luck
UNION ALL SELECT 726345736, 'occasion-good-luck', 'Occasion', 'home-gift'
-- Occasion, Graduation --> Occasion, Graduation
UNION ALL SELECT 1143729906, 'occasion-graduation', 'Occasion', 'home-gift'
-- Occasion, Halloween --> Occasion, Halloween
UNION ALL SELECT 1143731177, 'occasion-halloween', 'Occasion', 'home-gift'
-- Occasion, Just because --> Occasion, Just to say
UNION ALL SELECT 726347430, 'just-to-say', 'Occasion', 'home-gift'
-- Occasion, Living together --> Occasion, New Home
UNION ALL SELECT 1143727835, 'occasion-new-home', 'Occasion', 'home-gift'
-- Occasion, Love --> Occasion, Missing You
UNION ALL SELECT 1143727832, 'missing-you', 'Occasion', 'home-gift'
-- Occasion, Maternity Leave --> Occasion, Pregnancy
UNION ALL SELECT 1143733399, 'occasion-pregnancy', 'Occasion', 'home-gift'
-- Occasion, Milestones --> Occasion, Congratulations
UNION ALL SELECT 1143749857, 'occasion-congratulations', 'Occasion', 'home-gift'
-- Occasion, Mothersday --> Occasion, Mothers Day
UNION ALL SELECT 726331722, 'mothers-day', 'Occasion', 'home-gift'
-- Occasion, New home --> Occasion, New Home
UNION ALL SELECT 726342840, 'occasion-new-home', 'Occasion', 'home-gift'
-- Occasion, New Job --> Occasion, New Job
UNION ALL SELECT 735872747, 'occasion-new-job', 'Occasion', 'home-gift'
-- Occasion, Pregnant --> Occasion, Pregnancy
UNION ALL SELECT 726344253, 'occasion-pregnancy', 'Occasion', 'home-gift'
-- Occasion, Proud of you --> Occasion, Proud of You
UNION ALL SELECT 1143766298, 'proud-of-you', 'Occasion', 'home-gift'
-- Occasion, Retirement --> Occasion, Retirement
UNION ALL SELECT 735873966, 'occasion-retirement', 'Occasion', 'home-gift'
-- Occasion, Sinterklaas --> Occasion, Other
UNION ALL SELECT 726330911, 'occasion-other', 'Occasion', 'home-gift'
-- Occasion, Swimming diploma --> Occasion, Well Done
UNION ALL SELECT 1143742376, 'occasion-well-done', 'Occasion', 'home-gift'
-- Occasion, Thank you --> Occasion, Thank You
UNION ALL SELECT 726347103, 'occasion-thank-you', 'Occasion', 'home-gift'
-- Occasion, Thinking of you --> Occasion, Thinking of you
UNION ALL SELECT 748511930, 'occasion-thinking-of-you', 'Occasion', 'home-gift'
-- Occasion, Vacation --> Occasion, Bon Voyage
UNION ALL SELECT 1143729435, 'occasion-bon-voyage', 'Occasion', 'home-gift'
-- Occasion, Valentine --> Occasion, Valentines Day
UNION ALL SELECT 726324647, 'valentines-day', 'Occasion', 'home-gift'
-- Occasion, Wedding --> Occasion, Wedding
UNION ALL SELECT 726342081, 'occasion-wedding', 'Occasion', 'home-gift'
-- Pastry, All pastry --> Food & Drink, Snacks Treats Savoury
UNION ALL SELECT 1143736593, 'snacks-treats-savoury', 'Food & Drink', 'home-gift'
-- Pastry, Self bake --> Food & Drink, Baking Kits
UNION ALL SELECT 1143741121, 'baking-kits', 'Food & Drink', 'home-gift'
-- Product Family, AccessoriesL2 --> NewIa, Accessories
UNION ALL SELECT 950102332, 'accessories', 'NewIa', 'home-gift'
-- Product Family, All chocolate --> Food & Drink, Chocolate
UNION ALL SELECT 1143738429, 'chocolate', 'Food & Drink', 'home-gift'
-- Product Family, Baby and kids --> NewIa, Toys Kids & Baby
UNION ALL SELECT 1143739056, 'toys-kids-baby', 'NewIa', 'home-gift'
-- Product Family, Baby and kids L2 --> NewIa, Toys Kids & Baby
UNION ALL SELECT 1143739053, 'toys-kids-baby', 'NewIa', 'home-gift'
-- Product Family, Baby care --> Toys Kids & Baby, Baby
UNION ALL SELECT 1143745617, 'toys-kids-baby-baby', 'Toys Kids & Baby', 'home-gift'
-- Product Family, Baby oil --> Toys Kids & Baby, Baby
UNION ALL SELECT 1143748028, 'toys-kids-baby-baby', 'Toys Kids & Baby', 'home-gift'
-- Product Family, Baby package --> Toys Kids & Baby, Baby
UNION ALL SELECT 1143748004, 'toys-kids-baby-baby', 'Toys Kids & Baby', 'home-gift'
-- Product Family, Baby toys --> NewIa, Toys Kids & Baby
UNION ALL SELECT 1143739059, 'toys-kids-baby', 'NewIa', 'home-gift'
-- Product Family, Baby wash --> Toys Kids & Baby, Baby
UNION ALL SELECT 1143748031, 'toys-kids-baby-baby', 'Toys Kids & Baby', 'home-gift'
-- Product Family, Balloons --> NewIa, Balloons
UNION ALL SELECT 726962862, 'newia-balloons', 'NewIa', 'home-gift'
-- Product Family, Balloons with photo and text --> NewIa, Personalised Gifts
UNION ALL SELECT 1143736119, 'personalised-gifts', 'NewIa', 'home-gift'
-- Product Family, Balloons with photo and text --> NewIa, Balloons
UNION ALL SELECT 1143736119, 'newia-balloons', 'NewIa', 'home-gift'
-- Product Family, BalloonsL2 --> NewIa, Balloons
UNION ALL SELECT 855728876, 'newia-balloons', 'NewIa', 'home-gift'
-- Product Family, Bath textile --> Home & Garden, Home Accessories
UNION ALL SELECT 1143746866, 'home-accessories', 'Home & Garden', 'home-gift'
-- Product Family, Beauty --> NewIa, Beauty Face & Body
UNION ALL SELECT 1143727993, 'beauty-face-body', 'NewIa', 'home-gift'
-- Product Family, Beauty and careL2 --> NewIa, Beauty Face & Body
UNION ALL SELECT 726960191, 'beauty-face-body', 'NewIa', 'home-gift'
-- Product Family, Beer --> Alcohol, Beer & Cider
UNION ALL SELECT 784098536, 'beer-cider', 'Alcohol', 'home-gift'
-- Product Family, Big bottles --> NULL, NULL
UNION ALL SELECT 1143738085, NULL, NULL, 'home-gift'
-- Product Family, Blond beer --> Beer & Cider, Lager
UNION ALL SELECT 1143732235, 'lager', 'Beer & Cider', 'home-gift'
-- Product Family, Bonbons --> Food & Drink, Sweets
UNION ALL SELECT 1143735384, 'sweets', 'Food & Drink', 'home-gift'
-- Product Family, Books and cards --> NewIa, Books & Stationery
UNION ALL SELECT 1143739215, 'books-stationery', 'NewIa', 'home-gift'
-- Product Family, Brown beer --> Beer & Cider, Bitter
UNION ALL SELECT 1143732238, 'bitter', 'Beer & Cider', 'home-gift'
-- Product Family, Cake and Pastry --> Food & Drink, Snacks Treats Savoury
UNION ALL SELECT 1143736644, 'snacks-treats-savoury', 'Food & Drink', 'home-gift'
-- Product Family, Care --> NewIa, Beauty Face & Body
UNION ALL SELECT 1143748025, 'beauty-face-body', 'NewIa', 'home-gift'
-- Product Family, Champagne --> Champagne Prosecco & Wine, Champagne
UNION ALL SELECT 1143732229, 'champagne', 'Champagne Prosecco & Wine', 'home-gift'
-- Product Family, Champaign and bubbles --> Champagne Prosecco & Wine, Champagne
UNION ALL SELECT 1143727957, 'champagne', 'Champagne Prosecco & Wine', 'home-gift'
-- Product Family, Childrens tableware --> Home & Garden, Home Accessories
UNION ALL SELECT 1143739071, 'home-accessories', 'Home & Garden', 'home-gift'
-- Product Family, Chocolade met eigen foto of tekst --> NewIa, Personalised Gifts
UNION ALL SELECT 1143735399, 'personalised-gifts', 'NewIa', 'home-gift'
-- Product Family, Chocolade met eigen foto of tekst --> Food & Drink, Chocolate
UNION ALL SELECT 1143735399, 'chocolate', 'Food & Drink', 'home-gift'
-- Product Family, Chocolate --> Food & Drink, Chocolate
UNION ALL SELECT 726930909, 'chocolate', 'Food & Drink', 'home-gift'
-- Product Family, Clothes and textile --> NewIa, Accessories
UNION ALL SELECT 1143739062, 'accessories', 'NewIa', 'home-gift'
-- Product Family, Cooking --> Home & Garden, Home Accessories
UNION ALL SELECT 1143766943, 'home-accessories', 'Home & Garden', 'home-gift'
-- Product Family, Cutlery --> Home & Garden, Home Accessories
UNION ALL SELECT 1143747962, 'home-accessories', 'Home & Garden', 'home-gift'
-- Product Family, Decoration and accessories --> Home & Garden, Home Accessories
UNION ALL SELECT 1143748013, 'home-accessories', 'Home & Garden', 'home-gift'
-- Product Family, Drinks --> NewIa, Food & Drink
UNION ALL SELECT 1143727296, 'food-drink', 'NewIa', 'home-gift'
-- Product Family, Eating and drinkingl2 --> NewIa, Food & Drink
UNION ALL SELECT 726930780, 'food-drink', 'NewIa', 'home-gift'
-- Product Family, Gadgets2 --> Games Gadgets & Novelty, Gadgets
UNION ALL SELECT 918645962, 'gadgets', 'Games Gadgets & Novelty', 'home-gift'
-- Product Family, Giftboxen --> Gift Sets Hampers Letterbox, Gift Sets
UNION ALL SELECT 1143735393, 'gift-sets-hampers-letterbox-gift-sets', 'Gift Sets Hampers Letterbox', 'home-gift'
-- Product Family, Gifts --> NewIa, Personalised Gifts
UNION ALL SELECT 727212959, 'personalised-gifts', 'NewIa', 'home-gift'
-- Product Family, Gips item --> Toys Kids & Baby, Baby
UNION ALL SELECT 1143748043, 'toys-kids-baby-baby', 'Toys Kids & Baby', 'home-gift'
-- Product Family, Invitations (IA) --> NULL, NULL
UNION ALL SELECT 726926716, NULL, NULL, 'home-gift'
-- Product Family, Jewellery --> Accessories, Jewellery
UNION ALL SELECT 1143765388, 'jewellery', 'Accessories', 'home-gift'
-- Product Family, Keep memories --> Home & Garden, Home Accessories
UNION ALL SELECT 1143748040, 'home-accessories', 'Home & Garden', 'home-gift'
-- Product Family, Living --> Home & Garden, Home Accessories
UNION ALL SELECT 1143766938, 'home-accessories', 'Home & Garden', 'home-gift'
-- Product Family, Milestone books and cards --> NewIa, Books & Stationery
UNION ALL SELECT 1143747974, 'books-stationery', 'NewIa', 'home-gift'
-- Product Family, Money boxes --> Home & Garden, Home Accessories
UNION ALL SELECT 1143748172, 'home-accessories', 'Home & Garden', 'home-gift'
-- Product Family, MugsL2 --> Home & Garden, Mugs
UNION ALL SELECT 1143730236, 'mugs', 'Home & Garden', 'home-gift'
-- Product Family, MugsL3 --> Home & Garden, Mugs
UNION ALL SELECT 1143730239, 'mugs', 'Home & Garden', 'home-gift'
-- Product Family, Pacifier and accessories --> Toys Kids & Baby, Baby
UNION ALL SELECT 1143747971, 'toys-kids-baby-baby', 'Toys Kids & Baby', 'home-gift'
-- Product Family, Pacifier cord --> Toys Kids & Baby, Baby
UNION ALL SELECT 1143747995, 'toys-kids-baby-baby', 'Toys Kids & Baby', 'home-gift'
-- Product Family, Port --> Alcohol, Other Spirits
UNION ALL SELECT 1143731156, 'other-spirits', 'Alcohol', 'home-gift'
-- Product Family, Prosecco --> Champagne Prosecco & Wine, Prosecco
UNION ALL SELECT 1143732226, 'prosecco', 'Champagne Prosecco & Wine', 'home-gift'
-- Product Family, Rattles --> Toys Kids & Baby, Baby
UNION ALL SELECT 1143748052, 'toys-kids-baby-baby', 'Toys Kids & Baby', 'home-gift'
-- Product Family, Reading books --> NewIa, Books & Stationery
UNION ALL SELECT 1143747977, 'books-stationery', 'NewIa', 'home-gift'
-- Product Family, Red wine --> Champagne Prosecco & Wine, Red wine
UNION ALL SELECT 784103211, 'red-wine', 'Champagne Prosecco & Wine', 'home-gift'
-- Product Family, Socks --> Accessories, Socks
UNION ALL SELECT 1143765383, 'socks', 'Accessories', 'home-gift'
-- Product Family, Socks and hats --> NewIa, Accessories
UNION ALL SELECT 1143739689, 'accessories', 'NewIa', 'home-gift'
-- Product Family, Tableware sets --> Home & Garden, Home Accessories
UNION ALL SELECT 1143739194, 'home-accessories', 'Home & Garden', 'home-gift'
-- Product Family, Tea --> NewIa, Food & Drink
UNION ALL SELECT 1143745731, 'food-drink', 'NewIa', 'home-gift'
-- Product Family, White wine --> Champagne Prosecco & Wine, White wine
UNION ALL SELECT 784100994, 'white-wine', 'Champagne Prosecco & Wine', 'home-gift'
-- Product Family, Wine --> Alcohol, Champagne Prosecco & Wine
UNION ALL SELECT 899226515, 'champagne-prosecco-wine', 'Alcohol', 'home-gift'
-- Size, 250 gram --> NULL, NULL
UNION ALL SELECT 1143747067, NULL, NULL, 'home-gift'
-- Size, 400 gram --> NULL, NULL
UNION ALL SELECT 1143747070, NULL, NULL, 'home-gift'
-- Size, 675 gram --> NULL, NULL
UNION ALL SELECT 1143747073, NULL, NULL, 'home-gift'
-- Size, 80 --> NULL, NULL
UNION ALL SELECT 1143728278, NULL, NULL, 'home-gift'
-- Size, Earl Grey --> NULL, NULL
UNION ALL SELECT 1143748229, NULL, NULL, 'home-gift'
-- Size, Large --> NULL, NULL
UNION ALL SELECT 1143728311, NULL, NULL, 'home-gift'
-- Size, Medium --> NULL, NULL
UNION ALL SELECT 1143728308, NULL, NULL, 'home-gift'
-- Target Group, Boy --> Who's it for?, For Boys
UNION ALL SELECT 886506339, 'for-boys', 'Whos it for?', 'home-gift'
-- Target Group, Brother --> Who's it for?, Brother
UNION ALL SELECT 1143742571, 'whos-it-for-brother', 'Whos it for?', 'home-gift'
-- Target Group, Girl --> Who's it for?, For Girls
UNION ALL SELECT 886507052, 'for-girls', 'Whos it for?', 'home-gift'
-- Target Group, Men --> Who's it for?, For Him
UNION ALL SELECT 1143750956, 'for-him', 'Whos it for?', 'home-gift'
-- Target Group, Sister --> Who's it for?, Sister
UNION ALL SELECT 1143742574, 'whos-it-for-sister', 'Whos it for?', 'home-gift'
-- Target Group, Uniseks --> Who's it for?, Other
UNION ALL SELECT 1143739122, 'whos-it-for-other', 'Whos it for?', 'home-gift'
-- Target Group, Women --> Who's it for?, For Her
UNION ALL SELECT 1143750947, 'for-her', 'Whos it for?', 'home-gift'
-- Target Group, Zakelijk1 (cards missions) --> Who's it For?, Other
UNION ALL SELECT 1143732725, 'newia-gift-experiences-whos-it-for-other', 'Whos it For?', 'home-gift'
-- Theme, Brievenbuscadeau --> Flowers Gift Sets & Letterbox, Letterbox
UNION ALL SELECT 1143732596, 'letterbox', 'Flowers Gift Sets & Letterbox', 'home-gift'
-- Type, Giftset --> Gift Sets Hampers Letterbox, Gift Sets
UNION ALL SELECT 1143739698, 'gift-sets-hampers-letterbox-gift-sets', 'Gift Sets Hampers Letterbox', 'home-gift'
-- Type, Letterbox gifts --> Gift Sets Hampers Letterbox, Letterbox
UNION ALL SELECT 1143737611, 'gift-sets-hampers-letterbox-letterbox', 'Gift Sets Hampers Letterbox', 'home-gift'
-- Type, Met foto --> NewIa, Personalised Gifts
UNION ALL SELECT 1143742910, 'personalised-gifts', 'NewIa', 'home-gift'
-- Type, Met tekst --> NewIa, Personalised Gifts
UNION ALL SELECT 1143742907, 'personalised-gifts', 'NewIa', 'home-gift'
-- Type, Photo and text gifts --> NewIa, Personalised Gifts
UNION ALL SELECT 1143735781, 'personalised-gifts', 'NewIa', 'home-gift'
-- Type, Tasting --> NewIa, Food & Drink
UNION ALL SELECT 1143741766, 'food-drink', 'NewIa', 'home-gift'
-- Brand/Designer, Greetz --> NULL, NULL
UNION ALL SELECT 726316072, NULL, NULL, 'postcard'
-- Occasion, Christmas --> Occasion, Christmas
UNION ALL SELECT 726331358, 'occasion-christmas', 'Occasion', 'postcard'
-- Product Family, Cardboxes L2 --> Gift Sets Hampers Letterbox, Letterbox
UNION ALL SELECT 1143763303, 'gift-sets-hampers-letterbox-letterbox', 'Gift Sets Hampers Letterbox', 'postcard'
-- Product Family, Cardboxes L3 --> Gift Sets Hampers Letterbox, Letterbox
UNION ALL SELECT 1143763773, 'gift-sets-hampers-letterbox-letterbox', 'Gift Sets Hampers Letterbox', 'postcard'
-- Product Family, Gifts --> NewIa, Personalised Gifts
UNION ALL SELECT 727212959, 'personalised-gifts', 'NewIa', 'postcard'
-- Brand/Designer, Greetz --> NULL, NULL
UNION ALL SELECT 726316072, NULL, NULL, 'sweet'
-- Brand/Designer, HARIBO --> NULL, NULL
UNION ALL SELECT 1143765028, NULL, NULL, 'sweet'
-- Brand/Designer, Red Band --> NULL, NULL
UNION ALL SELECT 1143754730, NULL, NULL, 'sweet'
-- Brand/Designer, Venco --> NULL, NULL
UNION ALL SELECT 1143754733, NULL, NULL, 'sweet'
-- Color, Black --> NULL, NULL
UNION ALL SELECT 1143728198, 'black', NULL, 'sweet'
-- Color, Chocolate --> NULL, NULL
UNION ALL SELECT 1143728189, 'coloured', NULL, 'sweet'
-- Color, Mix of colors --> NULL, NULL
UNION ALL SELECT 729235298, 'multicolour', NULL, 'sweet'
-- Color, Red --> NULL, NULL
UNION ALL SELECT 1143728144, 'coloured', NULL, 'sweet'
-- Occasion, Anniversary --> Occasion, Anniversaries
UNION ALL SELECT 1143740082, 'anniversaries', 'Occasion', 'sweet'
-- Occasion, AOC think --> Occasion, Thinking of you
UNION ALL SELECT 1143742160, 'occasion-thinking-of-you', 'Occasion', 'sweet'
-- Occasion, Birthday --> Occasion, Birthday
UNION ALL SELECT 726324105, 'occasion-birthday', 'Occasion', 'sweet'
-- Occasion, Congratulations (card and gift) --> Occasion, Congratulations
UNION ALL SELECT 1143729948, 'occasion-congratulations', 'Occasion', 'sweet'
-- Occasion, Exams (gifts) --> Occasion, Exams
UNION ALL SELECT 726344432, 'occasion-exams', 'Occasion', 'sweet'
-- Occasion, Fall (Flowers --> Occasion, Other
UNION ALL SELECT 1143732590, 'occasion-other', 'Occasion', 'sweet'
-- Occasion, Friendship2 --> Occasion, Friendship
UNION ALL SELECT 893069562, 'occasion-friendship', 'Occasion', 'sweet'
-- Occasion, Get well --> Occasion, Get Well
UNION ALL SELECT 726345521, 'occasion-get-well', 'Occasion', 'sweet'
-- Occasion, Goodbye colleague --> Occasion, Goodbye
UNION ALL SELECT 1143736110, 'goodbye', 'Occasion', 'sweet'
-- Occasion, Graduation --> Occasion, Graduation
UNION ALL SELECT 1143729906, 'occasion-graduation', 'Occasion', 'sweet'
-- Occasion, Just because --> Occasion, Just to say
UNION ALL SELECT 726347430, 'just-to-say', 'Occasion', 'sweet'
-- Occasion, Living together --> Occasion, New Home
UNION ALL SELECT 1143727835, 'occasion-new-home', 'Occasion', 'sweet'
-- Occasion, Love --> Occasion, Missing You
UNION ALL SELECT 1143727832, 'missing-you', 'Occasion', 'sweet'
-- Occasion, Mothersday --> Occasion, Mothers Day
UNION ALL SELECT 726331722, 'mothers-day', 'Occasion', 'sweet'
-- Occasion, New home --> Occasion, New Home
UNION ALL SELECT 726342840, 'occasion-new-home', 'Occasion', 'sweet'
-- Occasion, New Job --> Occasion, New Job
UNION ALL SELECT 735872747, 'occasion-new-job', 'Occasion', 'sweet'
-- Occasion, Secretaryday --> Occasion, Other
UNION ALL SELECT 1143731240, 'occasion-other', 'Occasion', 'sweet'
-- Occasion, Sorry --> Occasion, Sorry
UNION ALL SELECT 726966325, 'occasion-sorry', 'Occasion', 'sweet'
-- Occasion, Thank you --> Occasion, Thank You
UNION ALL SELECT 726347103, 'occasion-thank-you', 'Occasion', 'sweet'
-- Occasion, Thank you teacher --> Occasion, Thank You
UNION ALL SELECT 1143742415, 'occasion-thank-you', 'Occasion', 'sweet'
-- Occasion, Thanks teacher --> Occasion, Thank You
UNION ALL SELECT 1143757148, 'occasion-thank-you', 'Occasion', 'sweet'
-- Occasion, Thinking of you --> Occasion, Thinking of you
UNION ALL SELECT 748511930, 'occasion-thinking-of-you', 'Occasion', 'sweet'
-- Occasion, Wedding --> Occasion, Wedding
UNION ALL SELECT 726342081, 'occasion-wedding', 'Occasion', 'sweet'
-- Pastry, All pastry --> Food & Drink, Snacks Treats Savoury
UNION ALL SELECT 1143736593, 'snacks-treats-savoury', 'Food & Drink', 'sweet'
-- Pastry, Donuts --> Food & Drink, Snacks Treats Savoury
UNION ALL SELECT 1143736824, 'snacks-treats-savoury', 'Food & Drink', 'sweet'
-- Product Family, All chocolate --> Food & Drink, Chocolate
UNION ALL SELECT 1143738429, 'chocolate', 'Food & Drink', 'sweet'
-- Product Family, Bonbons --> Food & Drink, Sweets
UNION ALL SELECT 1143735384, 'sweets', 'Food & Drink', 'sweet'
-- Product Family, Cake and Pastry --> Food & Drink, Snacks Treats Savoury
UNION ALL SELECT 1143736644, 'snacks-treats-savoury', 'Food & Drink', 'sweet'
-- Product Family, Candyjars --> NULL, NULL
UNION ALL SELECT 1143741739, NULL, NULL, 'sweet'
-- Product Family, Chocolade met eigen foto of tekst --> Food & Drink, Chocolate
UNION ALL SELECT 1143735399, 'chocolate', 'Food & Drink', 'sweet'
-- Product Family, Chocolade met eigen foto of tekst --> NewIa, Personalised Gifts
UNION ALL SELECT 1143735399, 'personalised-gifts', 'NewIa', 'sweet'
-- Product Family, Chocolate --> Food & Drink, Chocolate
UNION ALL SELECT 726930909, 'chocolate', 'Food & Drink', 'sweet'
-- Product Family, Chocolate hearts --> Food & Drink, Chocolate
UNION ALL SELECT 1143735387, 'chocolate', 'Food & Drink', 'sweet'
-- Product Family, Eating and drinkingl2 --> NewIa, Food & Drink
UNION ALL SELECT 726930780, 'food-drink', 'NewIa', 'sweet'
-- Product Family, Fruit --> NewIa, Food & Drink
UNION ALL SELECT 1143727293, 'food-drink', 'NewIa', 'sweet'
-- Product Family, Giftboxen --> Gift Sets Hampers Letterbox, Gift Sets
UNION ALL SELECT 1143735393, 'gift-sets-hampers-letterbox-gift-sets', 'Gift Sets Hampers Letterbox', 'sweet'
-- Product Family, Gifts --> NewIa, Personalised Gifts
UNION ALL SELECT 727212959, 'personalised-gifts', 'NewIa', 'sweet'
-- Size, 12 pieces --> NULL, NULL
UNION ALL SELECT 1143736827, NULL, NULL, 'sweet'
-- Size, 16 pieces --> NULL, NULL
UNION ALL SELECT 1143748946, NULL, NULL, 'sweet'
-- Size, 32 pieces --> NULL, NULL
UNION ALL SELECT 1143748943, NULL, NULL, 'sweet'
-- Size, 6 pieces --> NULL, NULL
UNION ALL SELECT 1143736602, NULL, NULL, 'sweet'
-- Size, 80 --> NULL, NULL
UNION ALL SELECT 1143728278, NULL, NULL, 'sweet'
-- Size, Assorted --> NULL, NULL
UNION ALL SELECT 1143741334, NULL, NULL, 'sweet'
-- Target Group, Boy --> Who's it for?, For Boys
UNION ALL SELECT 886506339, 'for-boys', 'Whos it for?', 'sweet'
-- Target Group, Father --> Who's it for?, Dad
UNION ALL SELECT 1143739704, 'whos-it-for-dad', 'Whos it for?', 'sweet'
-- Target Group, Girl --> Who's it for?, For Girls
UNION ALL SELECT 886507052, 'for-girls', 'Whos it for?', 'sweet'
-- Target Group, Men --> Who's it for?, For Him
UNION ALL SELECT 1143750956, 'for-him', 'Whos it for?', 'sweet'
-- Target Group, Women --> Who's it for?, For Her
UNION ALL SELECT 1143750947, 'for-her', 'Whos it for?', 'sweet'
-- Target Group, Zakelijk1 (cards missions) --> Who's it For?, Other
UNION ALL SELECT 1143732725, 'newia-gift-experiences-whos-it-for-other', 'Whos it For?', 'sweet'
-- Taste, Mix (chocolate) --> Food & Drink, Chocolate
UNION ALL SELECT 1143733285, 'chocolate', 'Food & Drink', 'sweet'
-- Type, Giftset --> Gift Sets Hampers Letterbox, Gift Sets
UNION ALL SELECT 1143739698, 'gift-sets-hampers-letterbox-gift-sets', 'Gift Sets Hampers Letterbox', 'sweet'
-- Type, Letterbox gifts --> Gift Sets Hampers Letterbox, Letterbox
UNION ALL SELECT 1143737611, 'gift-sets-hampers-letterbox-letterbox', 'Gift Sets Hampers Letterbox', 'sweet'
-- Type, Photo and text gifts --> NewIa, Personalised Gifts
UNION ALL SELECT 1143735781, 'personalised-gifts', 'NewIa', 'sweet'
-- Age, Baby 0 tot 1 year --> Age, Baby 0 1 years old
UNION ALL SELECT 880440481, 'baby-0-1-years-old', 'Age', 'toy-game'
-- Age, Dreumes 1 to 2 years --> Age, Baby 0 1 years old
UNION ALL SELECT 880444402, 'baby-0-1-years-old', 'Age', 'toy-game'
-- Age, Jongeren 12 to 18 years --> Age, Teen 13 17 years old
UNION ALL SELECT 748494248, 'teen-13-17-years-old', 'Age', 'toy-game'
-- Age, Kids 6 tot 12 years --> Age, Tween 9 12 years old
UNION ALL SELECT 742758311, 'tween-9-12-years-old', 'Age', 'toy-game'
-- Age, Kids 6 tot 12 years --> Age, Kids 6 9 years old
UNION ALL SELECT 742758311, 'kids-6-9-years-old', 'Age', 'toy-game'
-- Age, Kleuter 4 to 6 years --> Age, Kids 2 5 years old
UNION ALL SELECT 742755895, 'kids-2-5-years-old', 'Age', 'toy-game'
-- Age, Peuter 2 to 4 years --> Age, Kids 2 5 years old
UNION ALL SELECT 742755383, 'kids-2-5-years-old', 'Age', 'toy-game'
-- Brand/Designer, 999 Games --> NULL, NULL
UNION ALL SELECT 1143760253, NULL, NULL, 'toy-game'
-- Brand/Designer, BAMBAM --> NULL, NULL
UNION ALL SELECT 726982765, NULL, NULL, 'toy-game'
-- Brand/Designer, Canenco --> NULL, NULL
UNION ALL SELECT 1143769003, NULL, NULL, 'toy-game'
-- Brand/Designer, Clementoni --> NULL, NULL
UNION ALL SELECT 1143742268, NULL, NULL, 'toy-game'
-- Brand/Designer, Clown Games --> NULL, NULL
UNION ALL SELECT 1143761828, NULL, NULL, 'toy-game'
-- Brand/Designer, Create It! --> NULL, NULL
UNION ALL SELECT 1143769103, NULL, NULL, 'toy-game'
-- Brand/Designer, Done by Deer --> NULL, NULL
UNION ALL SELECT 1143739107, NULL, NULL, 'toy-game'
-- Brand/Designer, Dutch Farm --> NULL, NULL
UNION ALL SELECT 1143769018, NULL, NULL, 'toy-game'
-- Brand/Designer, Greetz --> NULL, NULL
UNION ALL SELECT 726316072, NULL, NULL, 'toy-game'
-- Brand/Designer, Happy Horse --> NULL, NULL
UNION ALL SELECT 796228368, NULL, NULL, 'toy-game'
-- Brand/Designer, Hasbro Gaming --> NULL, NULL
UNION ALL SELECT 1143742277, NULL, NULL, 'toy-game'
-- Brand/Designer, Identity Games --> NULL, NULL
UNION ALL SELECT 1143742274, NULL, NULL, 'toy-game'
-- Brand/Designer, Janod --> NULL, NULL
UNION ALL SELECT 1143740001, NULL, NULL, 'toy-game'
-- Brand/Designer, Just Formats --> NULL, NULL
UNION ALL SELECT 1143769013, NULL, NULL, 'toy-game'
-- Brand/Designer, Kikkerland --> NULL, NULL
UNION ALL SELECT 1143767298, NULL, NULL, 'toy-game'
-- Brand/Designer, L.O.L. Surprise --> NULL, NULL
UNION ALL SELECT 1143761833, NULL, NULL, 'toy-game'
-- Brand/Designer, LEGO --> Brands, Lego
UNION ALL SELECT 1143741803, 'lego', 'Brands', 'toy-game'
-- Brand/Designer, Little Dutch --> NULL, NULL
UNION ALL SELECT 1143740088, NULL, NULL, 'toy-game'
-- Brand/Designer, Mattel --> NULL, NULL
UNION ALL SELECT 1143742319, NULL, NULL, 'toy-game'
-- Brand/Designer, Nijntje --> NULL, NULL
UNION ALL SELECT 825334736, NULL, NULL, 'toy-game'
-- Brand/Designer, Outdoor Play --> NULL, NULL
UNION ALL SELECT 1143769028, NULL, NULL, 'toy-game'
-- Brand/Designer, Paw Patrol --> Brands, Paw Patrol
UNION ALL SELECT 1143741767, 'brands-paw-patrol', 'Brands', 'toy-game'
-- Brand/Designer, SES --> NULL, NULL
UNION ALL SELECT 1143761823, NULL, NULL, 'toy-game'
-- Brand/Designer, Spin Master --> NULL, NULL
UNION ALL SELECT 1143769008, NULL, NULL, 'toy-game'
-- Brand/Designer, SportX --> NULL, NULL
UNION ALL SELECT 1143769023, NULL, NULL, 'toy-game'
-- Brand/Designer, TY --> NULL, NULL
UNION ALL SELECT 1143734513, NULL, NULL, 'toy-game'
-- Brand/Designer, Van der Meulen --> NULL, NULL
UNION ALL SELECT 1143768993, NULL, NULL, 'toy-game'
-- Brand/Designer, Woezel en Pip --> NULL, NULL
UNION ALL SELECT 726305507, NULL, NULL, 'toy-game'
-- Color, DeepSkyBlue --> Colour, Blue
UNION ALL SELECT 1143728183, 'colour-blue', 'Colour', 'toy-game'
-- Color, PaleTurquoise --> Colour, Blue
UNION ALL SELECT 1143728180, 'colour-blue', 'Colour', 'toy-game'
-- Color, Pink --> Colour, Pink
UNION ALL SELECT 1143728148, 'pink', 'Colour', 'toy-game'
-- Color, White --> Colour, White
UNION ALL SELECT 1143728193, 'colour-white', 'Colour', 'toy-game'
-- Occasion, Anniversary --> Occasion, Anniversaries
UNION ALL SELECT 1143740082, 'anniversaries', 'Occasion', 'toy-game'
-- Occasion, Babyshower --> Occasion, Baby Shower
UNION ALL SELECT 1143739143, 'baby-shower', 'Occasion', 'toy-game'
-- Occasion, Babyshower (gifts) --> Occasion, Baby Shower
UNION ALL SELECT 1143742373, 'baby-shower', 'Occasion', 'toy-game'
-- Occasion, Baptism and communion (invitations) --> Occasion, Christening
UNION ALL SELECT 1143728949, 'christening', 'Occasion', 'toy-game'
-- Occasion, Birth --> Occasion, New Baby
UNION ALL SELECT 726324202, 'occasion-new-baby', 'Occasion', 'toy-game'
-- Occasion, Birth visite --> Occasion, New Baby
UNION ALL SELECT 1143739134, 'occasion-new-baby', 'Occasion', 'toy-game'
-- Occasion, Birthday --> Occasion, Birthday
UNION ALL SELECT 726324105, 'occasion-birthday', 'Occasion', 'toy-game'
-- Occasion, Brother and Sister day --> Occasion, Friendship
UNION ALL SELECT 1143732527, 'occasion-friendship', 'Occasion', 'toy-game'
-- Occasion, Christmas --> Occasion, Christmas
UNION ALL SELECT 726331358, 'occasion-christmas', 'Occasion', 'toy-game'
-- Occasion, Congratulations (card and gift) --> Occasion, Congratulations
UNION ALL SELECT 1143729948, 'occasion-congratulations', 'Occasion', 'toy-game'
-- Occasion, Day of the animals --> Occasion, Other
UNION ALL SELECT 735910080, 'occasion-other', 'Occasion', 'toy-game'
-- Occasion, Fathersday --> Occasion, Fathers Day
UNION ALL SELECT 726332069, 'fathers-day', 'Occasion', 'toy-game'
-- Occasion, Get well --> Occasion, Get Well
UNION ALL SELECT 726345521, 'occasion-get-well', 'Occasion', 'toy-game'
-- Occasion, Maternity Leave --> Occasion, Pregnancy
UNION ALL SELECT 1143733399, 'occasion-pregnancy', 'Occasion', 'toy-game'
-- Occasion, New home --> Occasion, New Home
UNION ALL SELECT 726342840, 'occasion-new-home', 'Occasion', 'toy-game'
-- Occasion, NewYear (gifts) --> Occasion, New Year
UNION ALL SELECT 1143732695, 'occasion-new-year', 'Occasion', 'toy-game'
-- Occasion, Pregnant --> Occasion, Pregnancy
UNION ALL SELECT 726344253, 'occasion-pregnancy', 'Occasion', 'toy-game'
-- Occasion, Retirement --> Occasion, Retirement
UNION ALL SELECT 735873966, 'occasion-retirement', 'Occasion', 'toy-game'
-- Occasion, Sinterklaas --> Occasion, Other
UNION ALL SELECT 726330911, 'occasion-other', 'Occasion', 'toy-game'
-- Occasion, Vacation --> Occasion, Bon Voyage
UNION ALL SELECT 1143729435, 'occasion-bon-voyage', 'Occasion', 'toy-game'
-- Occasion, Valentine --> Occasion, Valentines Day
UNION ALL SELECT 726324647, 'valentines-day', 'Occasion', 'toy-game'
-- Occasion, Zakelijke kerstgeschenken --> Occasion, Christmas
UNION ALL SELECT 1143747560, 'occasion-christmas', 'Occasion', 'toy-game'
-- Product Family, Baby and kids --> NewIa, Toys Kids & Baby
UNION ALL SELECT 1143739056, 'toys-kids-baby', 'NewIa', 'toy-game'
-- Product Family, Baby and kids L2 --> NewIa, Toys Kids & Baby
UNION ALL SELECT 1143739053, 'toys-kids-baby', 'NewIa', 'toy-game'
-- Product Family, Baby package --> Toys Kids & Baby, Baby
UNION ALL SELECT 1143748004, 'toys-kids-baby-baby', 'Toys Kids & Baby', 'toy-game'
-- Product Family, Baby toys --> NewIa, Toys Kids & Baby
UNION ALL SELECT 1143739059, 'toys-kids-baby', 'NewIa', 'toy-game'
-- Product Family, Books and cards --> NewIa, Books & Stationery
UNION ALL SELECT 1143739215, 'books-stationery', 'NewIa', 'toy-game'
-- Product Family, Cuddle clothes --> Toys Kids & Baby, Baby
UNION ALL SELECT 1143740247, 'toys-kids-baby-baby', 'Toys Kids & Baby', 'toy-game'
-- Product Family, Gadgets2 --> Games Gadgets & Novelty, Gadgets
UNION ALL SELECT 918645962, 'gadgets', 'Games Gadgets & Novelty', 'toy-game'
-- Product Family, Games --> Toys Kids & Baby, Games Board games Puzzles
UNION ALL SELECT 1143760243, 'games-board-games-puzzles', 'Toys Kids & Baby', 'toy-game'
-- Product Family, Games and Toys --> Toys Kids & Baby, Games Board games Puzzles
UNION ALL SELECT 1143760233, 'games-board-games-puzzles', 'Toys Kids & Baby', 'toy-game'
-- Product Family, Gifts --> NewIa, Personalised Gifts
UNION ALL SELECT 727212959, 'personalised-gifts', 'NewIa', 'toy-game'
-- Product Family, Living --> Home & Garden, Home Accessories
UNION ALL SELECT 1143766938, 'home-accessories', 'Home & Garden', 'toy-game'
-- Product Family, Plush toys --> Toys Kids & Baby, Soft Toys
UNION ALL SELECT 1143739200, 'soft-toys', 'Toys Kids & Baby', 'toy-game'
-- Product Family, Rattles --> Toys Kids & Baby, Baby
UNION ALL SELECT 1143748052, 'toys-kids-baby-baby', 'Toys Kids & Baby', 'toy-game'
-- Product Family, Soft plush --> Toys Kids & Baby, Soft Toys
UNION ALL SELECT 1143741583, 'soft-toys', 'Toys Kids & Baby', 'toy-game'
-- Product Family, Toys --> NewIa, Toys Kids & Baby
UNION ALL SELECT 1143760248, 'toys-kids-baby', 'NewIa', 'toy-game'
-- Product Family, Vehicles --> Toys Kids & Baby, Action Toys
UNION ALL SELECT 1143741559, 'action-toys', 'Toys Kids & Baby', 'toy-game'
-- Product Family, Wooden puzzels --> Toys Kids & Baby, Wooden Toys
UNION ALL SELECT 1143741571, 'wooden-toys', 'Toys Kids & Baby', 'toy-game'
-- Product Family, Wooden puzzels --> Toys Kids & Baby, Games Board games Puzzles
UNION ALL SELECT 1143741571, 'games-board-games-puzzles', 'Toys Kids & Baby', 'toy-game'
-- Product Family, Wooden toy --> Toys Kids & Baby, Wooden Toys
UNION ALL SELECT 1143739065, 'wooden-toys', 'Toys Kids & Baby', 'toy-game'
-- Target Group, Boy --> Who's it for?, For Boys
UNION ALL SELECT 886506339, 'for-boys', 'Whos it for?', 'toy-game'
-- Target Group, Girl --> Who's it for?, For Girls
UNION ALL SELECT 886507052, 'for-girls', 'Whos it for?', 'toy-game'
-- Target Group, Men --> Who's it for?, For Him
UNION ALL SELECT 1143750956, 'for-him', 'Whos it for?', 'toy-game'
-- Target Group, Women --> Who's it for?, For Her
UNION ALL SELECT 1143750947, 'for-her', 'Whos it for?', 'toy-game'
-- Type, Giftset --> Gift Sets Hampers Letterbox, Gift Sets
UNION ALL SELECT 1143739698, 'gift-sets-hampers-letterbox-gift-sets', 'Gift Sets Hampers Letterbox', 'toy-game'
-- Type, Letterbox gifts --> Gift Sets Hampers Letterbox, Letterbox
UNION ALL SELECT 1143737611, 'gift-sets-hampers-letterbox-letterbox', 'Gift Sets Hampers Letterbox', 'toy-game'

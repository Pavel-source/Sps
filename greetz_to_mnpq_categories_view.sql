-- ########################################################################################
-- # This view creates mapped Greetz categories aligned with the categories in Moonpiq.
-- #
-- ########################################################################################

CREATE VIEW greetz_to_mnpq_categories_view AS
-- Age, 'flower'8 years and older --> Age, Young Adult 18 24 years old
SELECT 880438645 AS GreetzCategoryID, 'young-adult-18-24-years-old' AS MPCategoryKey, 'Age' AS MPParentName, 'flower' AS MPTypeCode
-- Age, Baby 0 tot 1 year --> Age, Baby 0 1 years old
UNION ALL SELECT 880440481, 'baby-0-1-years-old', 'Age', 'flower'
-- Brand/Designer, 'flower'00 procent Leuk --> NULL, NULL
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
-- Occasion, Living together --> Occasion, Friendship
UNION ALL SELECT 1143727835, 'occasion-friendship', 'Occasion', 'flower'
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
-- Product Family, AccessoriesL2 --> Home & Garden, Home Accessories
UNION ALL SELECT 950102332, 'home-accessories', 'Home & Garden', 'flower'
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
-- Product Family, Gifts --> Flowers Gift Sets & Letterbox, Gift Sets
UNION ALL SELECT 727212959, 'flowers-gift-sets-letterbox-gift-sets', 'Flowers Gift Sets & Letterbox', 'flower'
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
-- Product Family, Rattles --> Flowers Gift Sets & Letterbox, Gift Sets
UNION ALL SELECT 1143748052, 'flowers-gift-sets-letterbox-gift-sets', 'Flowers Gift Sets & Letterbox', 'flower'
-- Product Family, Red wine --> Champagne Prosecco & Wine, Red wine
UNION ALL SELECT 784103211, 'red-wine', 'Champagne Prosecco & Wine', 'flower'
-- Product Family, Seeds --> NewIa, Home & Garden
UNION ALL SELECT 1143740284, 'home-garden', 'NewIa', 'flower'
-- Product Family, Shower gel --> NewIa, Beauty Face & Body
UNION ALL SELECT 1143742442, 'beauty-face-body', 'NewIa', 'flower'
-- Product Family, Socks --> Accessories, Socks
UNION ALL SELECT 1143765383, 'socks', 'Accessories', 'flower'
-- Product Family, Soft plush --> Flowers Gift Sets & Letterbox, Gift Sets
UNION ALL SELECT 1143741583, 'flowers-gift-sets-letterbox-gift-sets', 'Flowers Gift Sets & Letterbox', 'flower'
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
-- Age, 'flower'8 years and older --> NULL, NULL
UNION ALL SELECT 880438645, NULL, NULL, 'alcohol'
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
-- Highlighted, Giftbox: Beverage with chocolate --> Alcohol, Gift Sets Letterbox
UNION ALL SELECT 1143747968, 'alcohol-gift-sets-letterbox', 'Alcohol', 'alcohol'
-- Highlighted, OTS Wines --> Alcohol, Champagne Prosecco & Wine
UNION ALL SELECT 1143748139, 'champagne-prosecco-wine', 'Alcohol', 'alcohol'
-- Highlighted, Personalised wineboxes --> Alcohol, Champagne Prosecco & Wine
UNION ALL SELECT 1143744696, 'champagne-prosecco-wine', 'Alcohol', 'alcohol'
-- Highlighted, personalised wrapping --> NULL, NULL
UNION ALL SELECT 1143743139, NULL, NULL, 'alcohol'
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
-- Occasion, Living together --> Occasion, Friendship
UNION ALL SELECT 1143727835, 'occasion-friendship', 'Occasion', 'alcohol'
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
-- Product Family, Gifts --> Flowers Gift Sets & Letterbox, Gift Sets
UNION ALL SELECT 727212959, 'flowers-gift-sets-letterbox-gift-sets', 'Flowers Gift Sets & Letterbox', 'alcohol'
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
-- Type, Photo and text gifts --> NULL, NULL
UNION ALL SELECT 1143735781, NULL, NULL, 'alcohol'
-- Type, Tasting --> NULL, NULL
UNION ALL SELECT 1143741766, NULL, NULL, 'alcohol'

CREATE VIEW greetz_to_mnpq_categories_cards_view AS
-- Age, 1 year --> Age, Baby (0-18m)
SELECT 1143751079 AS GreetzCategoryID, 'baby-0-1-years-old' AS MPCategoryKey, 'Age' AS MPParentName
-- Age, 10 year --> Age, Tween (9-12) years old
UNION ALL SELECT 1143751124, 'tween-9-12-years-old', 'Age'
-- Age, 100 year --> Age, Senior (over 65)
UNION ALL SELECT 1143751151, 'senior-over-65-years-old', 'Age'
-- Age, 11 year --> Age, Tween (9-12) years old
UNION ALL SELECT 1143751127, 'tween-9-12-years-old', 'Age'
-- Age, 12 year --> Age, Tween (9-12) years old
UNION ALL SELECT 1143751130, 'tween-9-12-years-old', 'Age'
-- Age, 13 year --> Age, Teen (13-17) years old
UNION ALL SELECT 1143751133, 'teen-13-17-years-old', 'Age'
-- Age, 14 year --> Age, Teen (13-17) years old
UNION ALL SELECT 1143751136, 'teen-13-17-years-old', 'Age'
-- Age, 15 year --> Age, Teen (13-17) years old
UNION ALL SELECT 1143751139, 'teen-13-17-years-old', 'Age'
-- Age, 16 year --> Age, Teen (13-17) years old
UNION ALL SELECT 1143751142, 'teen-13-17-years-old', 'Age'
-- Age, 17 year --> Age, Teen (13-17) years old
UNION ALL SELECT 1143758133, 'teen-13-17-years-old', 'Age'
-- Age, 18 year --> Age, Young Adult (18-24) years old
UNION ALL SELECT 1143751145, 'young-adult-18-24-years-old', 'Age'
-- Age, 18 years and older --> Age, Adult 25 64 years old
UNION ALL SELECT 880438645, 'adult-25-64-years-old', 'Age'
-- Age, 18 years and older --> Age, Senior over 65 years old
UNION ALL SELECT 880438645, 'senior-over-65-years-old', 'Age'
-- Age, 18 years and older --> Age, Young Adult 18 24 years old
UNION ALL SELECT 880438645, 'young-adult-18-24-years-old', 'Age'
-- Age, 19 year --> Age, Young Adult (18-24) years old
UNION ALL SELECT 1143751259, 'young-adult-18-24-years-old', 'Age'
-- Age, 2 year --> Age, Kids (2-5) years old
UNION ALL SELECT 1143751082, 'kids-2-5-years-old', 'Age'
-- Age, 20 year --> Age, Young Adult (18-24) years old
UNION ALL SELECT 1143751265, 'young-adult-18-24-years-old', 'Age'
-- Age, 21 year --> Age, Young Adult (18-24) years old
UNION ALL SELECT 1143751208, 'young-adult-18-24-years-old', 'Age'
-- Age, 25 year --> Age, Adult (25-64) years old
UNION ALL SELECT 1143751211, 'adult-25-64-years-old', 'Age'
-- Age, 3 year --> Age, Kids (2-5) years old
UNION ALL SELECT 1143751103, 'kids-2-5-years-old', 'Age'
-- Age, 30 year --> Age, Adult (25-64) years old
UNION ALL SELECT 1143751169, 'adult-25-64-years-old', 'Age'
-- Age, 4 year --> Age, Kids (2-5) years old
UNION ALL SELECT 1143751106, 'kids-2-5-years-old', 'Age'
-- Age, 40 year --> Age, Adult (25-64) years old
UNION ALL SELECT 1143751166, 'adult-25-64-years-old', 'Age'
-- Age, 5 year --> Age, Kids (2-5) years old
UNION ALL SELECT 1143751109, 'kids-2-5-years-old', 'Age'
-- Age, 50 year --> Age, Adult (25-64) years old
UNION ALL SELECT 1143751163, 'adult-25-64-years-old', 'Age'
-- Age, 6 year --> Age, Kids (6-9) years old
UNION ALL SELECT 1143751112, 'kids-6-9-years-old', 'Age'
-- Age, 60 year --> Age, Adult (25-64) years old
UNION ALL SELECT 1143751148, 'adult-25-64-years-old', 'Age'
-- Age, 7 year --> Age, Kids (6-9) years old
UNION ALL SELECT 1143751115, 'kids-6-9-years-old', 'Age'
-- Age, 70 year --> Age, Senior (over 65)
UNION ALL SELECT 1143751160, 'senior-over-65-years-old', 'Age'
-- Age, 8 year --> Age, Kids (6-9) years old
UNION ALL SELECT 1143751118, 'kids-6-9-years-old', 'Age'
-- Age, 80 year --> Age, Senior (over 65)
UNION ALL SELECT 1143751157, 'senior-over-65-years-old', 'Age'
-- Age, 9 year --> Age, Tween (9-12) years old
UNION ALL SELECT 1143751121, 'tween-9-12-years-old', 'Age'
-- Age, 90 year --> Age, Senior (over 65)
UNION ALL SELECT 1143751154, 'senior-over-65-years-old', 'Age'
-- Age, Adult (cards missions only) --> Age, Adult (25-64) years old
UNION ALL SELECT 1143751262, 'adult-25-64-years-old', 'Age'
-- Age, Baby (cards missions only) --> Age, Baby (0-18m)
UNION ALL SELECT 1143751247, 'baby-0-1-years-old', 'Age'
-- Age, Child (cards missions only) --> Age, Baby (0-18m)
UNION ALL SELECT 1143751253, 'baby-0-1-years-old', 'Age'
-- Age, Senior (cards missions only) --> Age, Senior (over 65)
UNION ALL SELECT 1143751268, 'senior-over-65-years-old', 'Age'
-- Age, Teenager (cards missions only) --> Age, Teen (13-17) years old
UNION ALL SELECT 1143751256, 'teen-13-17-years-old', 'Age'
-- Age, Teenager (cards missions only) --> Age, Tween (9-12) years old
UNION ALL SELECT 1143751256, 'tween-9-12-years-old', 'Age'
-- Age, Toddler (cards missions only) --> Age, Baby (0-18m)
UNION ALL SELECT 1143751250, 'baby-0-1-years-old', 'Age'
-- Brand/Designer, A doodle a day --> NULL, NULL
UNION ALL SELECT 1143746614, NULL, NULL
-- Brand/Designer, Abacus Cards --> NULL, NULL
UNION ALL SELECT 1143767813, NULL, NULL
-- Brand/Designer, Alex Sharp Photography --> NULL, NULL
UNION ALL SELECT 1143761453, NULL, NULL
-- Brand/Designer, Alfabet cards --> NULL, NULL
UNION ALL SELECT 1143731716, NULL, NULL
-- Brand/Designer, All in one --> NULL, NULL
UNION ALL SELECT 1143766638, NULL, NULL
-- Brand/Designer, All the best cards --> NULL, NULL
UNION ALL SELECT 1143762453, NULL, NULL
-- Brand/Designer, All things banter --> Brands, All Things Banter
UNION ALL SELECT 1143762268, 'all-things-banter', 'Brands'
-- Brand/Designer, Alzheimer Nederland --> NULL, NULL
UNION ALL SELECT 1143749291, NULL, NULL
-- Brand/Designer, Angela Chick --> NULL, NULL
UNION ALL SELECT 1143761448, NULL, NULL
-- Brand/Designer, Animal Party --> NULL, NULL
UNION ALL SELECT 1143766848, NULL, NULL
-- Brand/Designer, Anoela Cards --> NULL, NULL
UNION ALL SELECT 1143762093, NULL, NULL
-- Brand/Designer, Aquarell color --> NULL, NULL
UNION ALL SELECT 1143760748, NULL, NULL
-- Brand/Designer, Baby Dreams --> NULL, NULL
UNION ALL SELECT 1143766838, NULL, NULL
-- Brand/Designer, Back 2 School --> NULL, NULL
UNION ALL SELECT 1143766878, NULL, NULL
-- Brand/Designer, Banter King --> Brands, Banter King
UNION ALL SELECT 1143762923, 'banter-king', 'Brands'
-- Brand/Designer, BBQ Salsa --> NULL, NULL
UNION ALL SELECT 1143754532, NULL, NULL
-- Brand/Designer, Becel --> NULL, NULL
UNION ALL SELECT 1143756743, NULL, NULL
-- Brand/Designer, Beth Fletcher Illustration --> NULL, NULL
UNION ALL SELECT 1143762603, NULL, NULL
-- Brand/Designer, Birdy Bees --> NULL, NULL
UNION ALL SELECT 737235213, NULL, NULL
-- Brand/Designer, Black and White (Christmas) --> NULL, NULL
UNION ALL SELECT 1143735041, NULL, NULL
-- Brand/Designer, Blond Amsterdam --> NULL, NULL
UNION ALL SELECT 726304426, NULL, NULL
-- Brand/Designer, Blond Noir --> NULL, NULL
UNION ALL SELECT 1143750274, NULL, NULL
-- Brand/Designer, Blossom and Bloom --> NULL, NULL
UNION ALL SELECT 1143766868, NULL, NULL
-- Brand/Designer, BohoHolidays --> NULL, NULL
UNION ALL SELECT 1143750455, NULL, NULL
-- Brand/Designer, Boijmans Van Beuningen Museum --> NULL, NULL
UNION ALL SELECT 1143735922, NULL, NULL
-- Brand/Designer, Bold and Beyond --> NULL, NULL
UNION ALL SELECT 1143766423, NULL, NULL
-- Brand/Designer, Bold and Bright --> NULL, NULL
UNION ALL SELECT 1143767798, NULL, NULL
-- Brand/Designer, Bouffants and Broken Hearts --> NULL, NULL
UNION ALL SELECT 1143767808, NULL, NULL
-- Brand/Designer, Brainbox candy --> Brands, Brainbox Candy
UNION ALL SELECT 1143762743, 'brainbox-candy', 'Brands'
-- Brand/Designer, Bright Spot --> NULL, NULL
UNION ALL SELECT 1143750271, NULL, NULL
-- Brand/Designer, Bubbly fun --> NULL, NULL
UNION ALL SELECT 1143760743, NULL, NULL
-- Brand/Designer, Bundle of Joy --> NULL, NULL
UNION ALL SELECT 1143767693, NULL, NULL
-- Brand/Designer, Card House --> NULL, NULL
UNION ALL SELECT 1143733534, NULL, NULL
-- Brand/Designer, Catchy Images --> NULL, NULL
UNION ALL SELECT 1143767088, NULL, NULL
-- Brand/Designer, Characterful --> NULL, NULL
UNION ALL SELECT 1143753786, NULL, NULL
-- Brand/Designer, Charly Clements --> NULL, NULL
UNION ALL SELECT 1143762098, NULL, NULL
-- Brand/Designer, Cheeky Chops --> NULL, NULL
UNION ALL SELECT 1143762928, NULL, NULL
-- Brand/Designer, Christmas Blond Amsterdam --> NULL, NULL
UNION ALL SELECT 1143735113, NULL, NULL
-- Brand/Designer, Christmas Doodles --> NULL, NULL
UNION ALL SELECT 1143735206, NULL, NULL
-- Brand/Designer, Christmas Feelings (Christmas) --> NULL, NULL
UNION ALL SELECT 1143735182, NULL, NULL
-- Brand/Designer, Christmas Jan van Haast --> NULL, NULL
UNION ALL SELECT 1143735089, NULL, NULL
-- Brand/Designer, Christmas Loesje --> NULL, NULL
UNION ALL SELECT 1143735059, NULL, NULL
-- Brand/Designer, Christmas Old Dutch --> NULL, NULL
UNION ALL SELECT 1143735083, NULL, NULL
-- Brand/Designer, Citrus Bunn --> NULL, NULL
UNION ALL SELECT 1143761438, NULL, NULL
-- Brand/Designer, Colorful Sportsman --> NULL, NULL
UNION ALL SELECT 1143766223, NULL, NULL
-- Brand/Designer, Colorfulmadness --> NULL, NULL
UNION ALL SELECT 1143760848, NULL, NULL
-- Brand/Designer, Corrin Strain --> NULL, NULL
UNION ALL SELECT 1143762938, NULL, NULL
-- Brand/Designer, Cut it out --> NULL, NULL
UNION ALL SELECT 1143760858, NULL, NULL
-- Brand/Designer, Cute as a button Christmas --> NULL, NULL
UNION ALL SELECT 1143735104, NULL, NULL
-- Brand/Designer, Dalia Clark Design --> NULL, NULL
UNION ALL SELECT 1143762103, NULL, NULL
-- Brand/Designer, Dami Draws --> NULL, NULL
UNION ALL SELECT 1143750458, NULL, NULL
-- Brand/Designer, Dean Morris --> NULL, NULL
UNION ALL SELECT 1143762698, NULL, NULL
-- Brand/Designer, Deckled edge --> NULL, NULL
UNION ALL SELECT 1143762953, NULL, NULL
-- Brand/Designer, DELA --> NULL, NULL
UNION ALL SELECT 1143747545, NULL, NULL
-- Brand/Designer, Dierenpark Oliemeulen --> NULL, NULL
UNION ALL SELECT 1143740785, NULL, NULL
-- Brand/Designer, Dikkie Dik --> NULL, NULL
UNION ALL SELECT 1143730011, NULL, NULL
-- Brand/Designer, Dinky Rouge --> NULL, NULL
UNION ALL SELECT 1143770028, NULL, NULL
-- Brand/Designer, Domino's --> NULL, NULL
UNION ALL SELECT 1143758148, NULL, NULL
-- Brand/Designer, Doodles --> NULL, NULL
UNION ALL SELECT 726317874, NULL, NULL
-- Brand/Designer, Doodles by Ini --> NULL, NULL
UNION ALL SELECT 1143763253, NULL, NULL
-- Brand/Designer, Dotty Black --> NULL, NULL
UNION ALL SELECT 1143762113, NULL, NULL
-- Brand/Designer, Duotone Fun --> NULL, NULL
UNION ALL SELECT 1143763753, NULL, NULL
-- Brand/Designer, Emma Proctor --> NULL, NULL
UNION ALL SELECT 1143762773, NULL, NULL
-- Brand/Designer, Fabriekshuys Tekenstudio --> NULL, NULL
UNION ALL SELECT 1143771363, NULL, NULL
-- Brand/Designer, Felt Studios --> NULL, NULL
UNION ALL SELECT 1143762888, NULL, NULL
-- Brand/Designer, Fiep Westendorp --> NULL, NULL
UNION ALL SELECT 1143728886, NULL, NULL
-- Brand/Designer, Filthy Sentiments --> Brands, Filthy Sentiments
UNION ALL SELECT 1143762788, 'filthy-sentiments', 'Brands'
-- Brand/Designer, Floral Holidays --> NULL, NULL
UNION ALL SELECT 1143751478, NULL, NULL
-- Brand/Designer, Focus on blue --> NULL, NULL
UNION ALL SELECT 1143766653, NULL, NULL
-- Brand/Designer, Funny Side Up --> NULL, NULL
UNION ALL SELECT 1143764423, NULL, NULL
-- Brand/Designer, Geofort Museum --> NULL, NULL
UNION ALL SELECT 1143740007, NULL, NULL
-- Brand/Designer, Go La La --> Brands, Go La la
UNION ALL SELECT 1143763188, 'go-la-la', 'Brands'
-- Brand/Designer, Go with the flow --> NULL, NULL
UNION ALL SELECT 1143750464, NULL, NULL
-- Brand/Designer, Gold Christmas --> NULL, NULL
UNION ALL SELECT 1143761673, NULL, NULL
-- Brand/Designer, Greetz --> NULL, NULL
UNION ALL SELECT 726316072, NULL, NULL
-- Brand/Designer, Greetz partnerships --> NULL, NULL
UNION ALL SELECT 1143732431, NULL, NULL
-- Brand/Designer, Groene Huis --> NULL, NULL
UNION ALL SELECT 1143740043, NULL, NULL
-- Brand/Designer, Groovy Greetings --> NULL, NULL
UNION ALL SELECT 1143766658, NULL, NULL
-- Brand/Designer, Haarlemmermeer en Cruquius --> NULL, NULL
UNION ALL SELECT 1143738783, NULL, NULL
-- Brand/Designer, Happy dicks --> NULL, NULL
UNION ALL SELECT 1143750461, NULL, NULL
-- Brand/Designer, Happy Jackson --> Brands, Happy Jackson
UNION ALL SELECT 1143762643, 'happy-jackson', 'Brands'
-- Brand/Designer, Happy Letters --> NULL, NULL
UNION ALL SELECT 1143767658, NULL, NULL
-- Brand/Designer, Happy tits --> NULL, NULL
UNION ALL SELECT 1143750467, NULL, NULL
-- Brand/Designer, Hello Betty --> NULL, NULL
UNION ALL SELECT 1143746647, NULL, NULL
-- Brand/Designer, Hello December --> NULL, NULL
UNION ALL SELECT 1143750470, NULL, NULL
-- Brand/Designer, Hello Munki --> NULL, NULL
UNION ALL SELECT 1143762958, NULL, NULL
-- Brand/Designer, Holiday after hours --> NULL, NULL
UNION ALL SELECT 1143750473, NULL, NULL
-- Brand/Designer, Holiday blues --> NULL, NULL
UNION ALL SELECT 1143750476, NULL, NULL
-- Brand/Designer, Hollandse Meesters --> NULL, NULL
UNION ALL SELECT 1143761633, NULL, NULL
-- Brand/Designer, Home Sweet Home --> NULL, NULL
UNION ALL SELECT 1143766843, NULL, NULL
-- Brand/Designer, Hotchpotch --> NULL, NULL
UNION ALL SELECT 1143737752, NULL, NULL
-- Brand/Designer, I Like Your Smiley --> NULL, NULL
UNION ALL SELECT 1143763758, NULL, NULL
-- Brand/Designer, I see patterns --> NULL, NULL
UNION ALL SELECT 1143746665, NULL, NULL
-- Brand/Designer, iDrew Illustrations --> NULL, NULL
UNION ALL SELECT 1143768203, NULL, NULL
-- Brand/Designer, IKPAKJEIN --> NULL, NULL
UNION ALL SELECT 1143737026, NULL, NULL
-- Brand/Designer, Izzy Likes to Doodle --> NULL, NULL
UNION ALL SELECT 1143768198, NULL, NULL
-- Brand/Designer, Jan van Haasteren --> NULL, NULL
UNION ALL SELECT 1143730797, NULL, NULL
-- Brand/Designer, Janneke Brinkman --> NULL, NULL
UNION ALL SELECT 726305063, NULL, NULL
-- Brand/Designer, Jenny Seddon --> NULL, NULL
UNION ALL SELECT 1143762593, NULL, NULL
-- Brand/Designer, Jerry Tapscott --> NULL, NULL
UNION ALL SELECT 1143762768, NULL, NULL
-- Brand/Designer, Jess Rose Illustration --> NULL, NULL
UNION ALL SELECT 1143764273, NULL, NULL
-- Brand/Designer, Jewel Branding --> NULL, NULL
UNION ALL SELECT 1143764153, NULL, NULL
-- Brand/Designer, Jolly and bright --> NULL, NULL
UNION ALL SELECT 1143750479, NULL, NULL
-- Brand/Designer, Jolly Awesome --> Brands, Jolly Awesome
UNION ALL SELECT 1143761443, 'jolly-awesome', 'Brands'
-- Brand/Designer, Jolly Happy Joy --> NULL, NULL
UNION ALL SELECT 1143761628, NULL, NULL
-- Brand/Designer, Joyful --> NULL, NULL
UNION ALL SELECT 1143766828, NULL, NULL
-- Brand/Designer, Karmuka --> NULL, NULL
UNION ALL SELECT 1143764303, NULL, NULL
-- Brand/Designer, Kasteel Haar --> NULL, NULL
UNION ALL SELECT 1143736107, NULL, NULL
-- Brand/Designer, Katie Abey Design --> NULL, NULL
UNION ALL SELECT 1143762623, NULL, NULL
-- Brand/Designer, Katt Jones --> NULL, NULL
UNION ALL SELECT 1143764193, NULL, NULL
-- Brand/Designer, Kinship --> NULL, NULL
UNION ALL SELECT 1143753780, NULL, NULL
-- Brand/Designer, Kitchen of smiles --> NULL, NULL
UNION ALL SELECT 1143771193, NULL, NULL
-- Brand/Designer, Kitsch Noir --> NULL, NULL
UNION ALL SELECT 1143762963, NULL, NULL
-- Brand/Designer, Klaas de Jong --> NULL, NULL
UNION ALL SELECT 1143735381, NULL, NULL
-- Brand/Designer, Klara Hawkins --> NULL, NULL
UNION ALL SELECT 1143762228, NULL, NULL
-- Brand/Designer, Klein blue --> NULL, NULL
UNION ALL SELECT 1143750482, NULL, NULL
-- Brand/Designer, Kleine Twinkeltjes --> NULL, NULL
UNION ALL SELECT 1143754286, NULL, NULL
-- Brand/Designer, Kleine Vlindervoetjes --> NULL, NULL
UNION ALL SELECT 1143754283, NULL, NULL
-- Brand/Designer, Koopmans --> NULL, NULL
UNION ALL SELECT 1143756746, NULL, NULL
-- Brand/Designer, KPN --> NULL, NULL
UNION ALL SELECT 1143757198, NULL, NULL
-- Brand/Designer, Last Lemon Productions --> NULL, NULL
UNION ALL SELECT 1143762633, NULL, NULL
-- Brand/Designer, Legs talk about it --> NULL, NULL
UNION ALL SELECT 1143766413, NULL, NULL
-- Brand/Designer, Letters By Julia --> NULL, NULL
UNION ALL SELECT 1143762613, NULL, NULL
-- Brand/Designer, Lief Leven --> NULL, NULL
UNION ALL SELECT 1143737023, NULL, NULL
-- Brand/Designer, Lieve herfst --> NULL, NULL
UNION ALL SELECT 1143760498, NULL, NULL
-- Brand/Designer, Ling Design --> Brands, Ling Design
UNION ALL SELECT 1143762598, 'ling-design', 'Brands'
-- Brand/Designer, Loesje --> NULL, NULL
UNION ALL SELECT 1143732899, NULL, NULL
-- Brand/Designer, Love Brush --> NULL, NULL
UNION ALL SELECT 1143756722, NULL, NULL
-- Brand/Designer, Love is all you need --> NULL, NULL
UNION ALL SELECT 1143766433, NULL, NULL
-- Brand/Designer, Love letters --> NULL, NULL
UNION ALL SELECT 1143750449, NULL, NULL
-- Brand/Designer, Love Notes --> NULL, NULL
UNION ALL SELECT 1143766428, NULL, NULL
-- Brand/Designer, Love Repeat --> NULL, NULL
UNION ALL SELECT 1143757538, NULL, NULL
-- Brand/Designer, Love wins --> NULL, NULL
UNION ALL SELECT 1143754962, NULL, NULL
-- Brand/Designer, Lovepost --> NULL, NULL
UNION ALL SELECT 1143766863, NULL, NULL
-- Brand/Designer, Luckz --> NULL, NULL
UNION ALL SELECT 1143736251, NULL, NULL
-- Brand/Designer, Lucy Maggie --> NULL, NULL
UNION ALL SELECT 1143762118, NULL, NULL
-- Brand/Designer, Lucy Pearce designs --> NULL, NULL
UNION ALL SELECT 1143762968, NULL, NULL
-- Brand/Designer, Marble Christmas --> NULL, NULL
UNION ALL SELECT 1143761623, NULL, NULL
-- Brand/Designer, Marie Bodié --> NULL, NULL
UNION ALL SELECT 1143748370, NULL, NULL
-- Brand/Designer, Marieke Witke --> NULL, NULL
UNION ALL SELECT 1143753750, NULL, NULL
-- Brand/Designer, Mariniers Museum --> NULL, NULL
UNION ALL SELECT 1143735302, NULL, NULL
-- Brand/Designer, Mark my words --> NULL, NULL
UNION ALL SELECT 1143766438, NULL, NULL
-- Brand/Designer, Melolelo --> NULL, NULL
UNION ALL SELECT 1143751943, NULL, NULL
-- Brand/Designer, Memelou --> NULL, NULL
UNION ALL SELECT 1143763543, NULL, NULL
-- Brand/Designer, Merry and cherry --> NULL, NULL
UNION ALL SELECT 1143750485, NULL, NULL
-- Brand/Designer, Merry more --> NULL, NULL
UNION ALL SELECT 1143750488, NULL, NULL
-- Brand/Designer, Mia Whittemore --> NULL, NULL
UNION ALL SELECT 1143767793, NULL, NULL
-- Brand/Designer, Michelle Dujardin --> NULL, NULL
UNION ALL SELECT 1143742493, NULL, NULL
-- Brand/Designer, Milestone --> NULL, NULL
UNION ALL SELECT 1143739098, NULL, NULL
-- Brand/Designer, Millicent Venton --> NULL, NULL
UNION ALL SELECT 1143761433, NULL, NULL
-- Brand/Designer, Modern sparkle --> NULL, NULL
UNION ALL SELECT 1143750491, NULL, NULL
-- Brand/Designer, Museum Het Grachtenhuis --> NULL, NULL
UNION ALL SELECT 1143735272, NULL, NULL
-- Brand/Designer, Natalie Alex --> NULL, NULL
UNION ALL SELECT 1143761428, NULL, NULL
-- Brand/Designer, Natural shapes --> NULL, NULL
UNION ALL SELECT 1143746668, NULL, NULL
-- Brand/Designer, Natuur Historisch Museum --> NULL, NULL
UNION ALL SELECT 1143739926, NULL, NULL
-- Brand/Designer, Neil Clark Design --> NULL, NULL
UNION ALL SELECT 1143762258, NULL, NULL
-- Brand/Designer, New Kids --> NULL, NULL
UNION ALL SELECT 1143766833, NULL, NULL
-- Brand/Designer, Noelle Smit --> NULL, NULL
UNION ALL SELECT 1143766473, NULL, NULL
-- Brand/Designer, Oh happy days --> NULL, NULL
UNION ALL SELECT 1143750494, NULL, NULL
-- Brand/Designer, Okey Dokey Design --> Brands, Okey Dokey Design
UNION ALL SELECT 1143762608, 'okey-dokey-design', 'Brands'
-- Brand/Designer, Old Dutch --> NULL, NULL
UNION ALL SELECT 1143730689, NULL, NULL
-- Brand/Designer, Old Timer --> NULL, NULL
UNION ALL SELECT 1143766853, NULL, NULL
-- Brand/Designer, Papagrazi --> NULL, NULL
UNION ALL SELECT 1143762108, NULL, NULL
-- Brand/Designer, Paper Trails --> NULL, NULL
UNION ALL SELECT 1143763748, NULL, NULL
-- Brand/Designer, Paperclip 1974 --> NULL, NULL
UNION ALL SELECT 1143750349, NULL, NULL
-- Brand/Designer, Paperclip Business (Christmas) --> NULL, NULL
UNION ALL SELECT 1143734972, NULL, NULL
-- Brand/Designer, Paperclip collections --> NULL, NULL
UNION ALL SELECT 1143750446, NULL, NULL
-- Brand/Designer, Paperclip Communion --> NULL, NULL
UNION ALL SELECT 1143735751, NULL, NULL
-- Brand/Designer, Paperclip Focus --> NULL, NULL
UNION ALL SELECT 1143735363, NULL, NULL
-- Brand/Designer, Paperclip heart and soul --> NULL, NULL
UNION ALL SELECT 1143747251, NULL, NULL
-- Brand/Designer, Paperclip Highline --> NULL, NULL
UNION ALL SELECT 1143735167, NULL, NULL
-- Brand/Designer, Paperclip Indie --> NULL, NULL
UNION ALL SELECT 1143744984, NULL, NULL
-- Brand/Designer, Paperclip Kerst (Christmas) --> NULL, NULL
UNION ALL SELECT 1143735185, NULL, NULL
-- Brand/Designer, Paperclip Levels --> NULL, NULL
UNION ALL SELECT 1143750352, NULL, NULL
-- Brand/Designer, Paperclip Lifetimes --> NULL, NULL
UNION ALL SELECT 1143735158, NULL, NULL
-- Brand/Designer, Paperclip Mingface --> NULL, NULL
UNION ALL SELECT 1143734774, NULL, NULL
-- Brand/Designer, Paperclip OMG --> NULL, NULL
UNION ALL SELECT 1143741454, NULL, NULL
-- Brand/Designer, Paperclip on the dot --> NULL, NULL
UNION ALL SELECT 1143746372, NULL, NULL
-- Brand/Designer, Paperclip Partybus --> NULL, NULL
UNION ALL SELECT 1143735369, NULL, NULL
-- Brand/Designer, Paperclip Petit Doodle --> NULL, NULL
UNION ALL SELECT 1143745020, NULL, NULL
-- Brand/Designer, Paperclip Photography --> NULL, NULL
UNION ALL SELECT 1143749630, NULL, NULL
-- Brand/Designer, Paperclip PopCard --> NULL, NULL
UNION ALL SELECT 1143734771, NULL, NULL
-- Brand/Designer, Paperclip Sooo Happy --> NULL, NULL
UNION ALL SELECT 1143749627, NULL, NULL
-- Brand/Designer, Paperclip Sports --> NULL, NULL
UNION ALL SELECT 1143734768, NULL, NULL
-- Brand/Designer, Paperclip The Zoo --> NULL, NULL
UNION ALL SELECT 1143735763, NULL, NULL
-- Brand/Designer, Paperclip together --> NULL, NULL
UNION ALL SELECT 1143746378, NULL, NULL
-- Brand/Designer, Paperclip Tralala --> NULL, NULL
UNION ALL SELECT 1143747163, NULL, NULL
-- Brand/Designer, Paperclip Valentijn --> NULL, NULL
UNION ALL SELECT 1143735314, NULL, NULL
-- Brand/Designer, Paperclip vintage vibes --> NULL, NULL
UNION ALL SELECT 1143746375, NULL, NULL
-- Brand/Designer, Paperlink --> NULL, NULL
UNION ALL SELECT 1143762638, NULL, NULL
-- Brand/Designer, Pastel dreams --> NULL, NULL
UNION ALL SELECT 1143750497, NULL, NULL
-- Brand/Designer, Pawsome cats --> NULL, NULL
UNION ALL SELECT 1143754959, NULL, NULL
-- Brand/Designer, Pearl Ivy --> NULL, NULL
UNION ALL SELECT 1143763553, NULL, NULL
-- Brand/Designer, Petit Konijn --> NULL, NULL
UNION ALL SELECT 1143759203, NULL, NULL
-- Brand/Designer, Photoflash --> NULL, NULL
UNION ALL SELECT 1143767153, NULL, NULL
-- Brand/Designer, Picture Perfect --> NULL, NULL
UNION ALL SELECT 1143734930, NULL, NULL
-- Brand/Designer, Pigment --> NULL, NULL
UNION ALL SELECT 1143764313, NULL, NULL
-- Brand/Designer, Pinch of Salt --> NULL, NULL
UNION ALL SELECT 1143766858, NULL, NULL
-- Brand/Designer, Pixel Perfect --> NULL, NULL
UNION ALL SELECT 1143764063, NULL, NULL
-- Brand/Designer, Playful Indian --> NULL, NULL
UNION ALL SELECT 1143768903, NULL, NULL
-- Brand/Designer, Poet and Painter --> NULL, NULL
UNION ALL SELECT 1143762918, NULL, NULL
-- Brand/Designer, Poppy Field --> NULL, NULL
UNION ALL SELECT 1143766873, NULL, NULL
-- Brand/Designer, Portraits --> NULL, NULL
UNION ALL SELECT 1143760863, NULL, NULL
-- Brand/Designer, Positivitea --> NULL, NULL
UNION ALL SELECT 1143752543, NULL, NULL
-- Brand/Designer, Quitting Hollywood --> NULL, NULL
UNION ALL SELECT 1143763558, NULL, NULL
-- Brand/Designer, Rainbows and stars --> NULL, NULL
UNION ALL SELECT 1143750500, NULL, NULL
-- Brand/Designer, Redback Cards Limited --> Brands, Redback Cards Limited
UNION ALL SELECT 1143763568, 'redback-cards-limited', 'Brands'
-- Brand/Designer, Revelation halftone --> NULL, NULL
UNION ALL SELECT 1143750503, NULL, NULL
-- Brand/Designer, Rumble Cards --> Brands, Rumble Cards
UNION ALL SELECT 1143762223, 'rumble-cards', 'Brands'
-- Brand/Designer, Sadler Jones --> Brands, Sadler Jones
UNION ALL SELECT 1143762628, 'sadler-jones', 'Brands'
-- Brand/Designer, Say It Out Loud --> NULL, NULL
UNION ALL SELECT 1143752540, NULL, NULL
-- Brand/Designer, Showtime --> NULL, NULL
UNION ALL SELECT 1143766643, NULL, NULL
-- Brand/Designer, Sissy Boy --> NULL, NULL
UNION ALL SELECT 1143750701, NULL, NULL
-- Brand/Designer, Sketchy Characters --> NULL, NULL
UNION ALL SELECT 1143753783, NULL, NULL
-- Brand/Designer, Sooshichacha Limited --> NULL, NULL
UNION ALL SELECT 1143764253, NULL, NULL
-- Brand/Designer, Spring Fling --> NULL, NULL
UNION ALL SELECT 1143767688, NULL, NULL
-- Brand/Designer, Stay wild --> NULL, NULL
UNION ALL SELECT 1143760708, NULL, NULL
-- Brand/Designer, Stella Isaac Illustrations --> NULL, NULL
UNION ALL SELECT 1143763108, NULL, NULL
-- Brand/Designer, Stichting Jarige Job --> NULL, NULL
UNION ALL SELECT 1143749288, NULL, NULL
-- Brand/Designer, Storylines --> NULL, NULL
UNION ALL SELECT 1143766648, NULL, NULL
-- Brand/Designer, Studio Pets ByMyrna --> NULL, NULL
UNION ALL SELECT 737301625, NULL, NULL
-- Brand/Designer, Studio Sundae --> NULL, NULL
UNION ALL SELECT 1143762618, NULL, NULL
-- Brand/Designer, Summer nights --> NULL, NULL
UNION ALL SELECT 1143750506, NULL, NULL
-- Brand/Designer, Summer romance --> NULL, NULL
UNION ALL SELECT 1143750509, NULL, NULL
-- Brand/Designer, Sweet Little Note --> NULL, NULL
UNION ALL SELECT 1143764068, NULL, NULL
-- Brand/Designer, Sweetheart hero --> NULL, NULL
UNION ALL SELECT 1143750512, NULL, NULL
-- Brand/Designer, Takkenfeest --> NULL, NULL
UNION ALL SELECT 1143750515, NULL, NULL
-- Brand/Designer, Tante Kaartje --> NULL, NULL
UNION ALL SELECT 1143767278, NULL, NULL
-- Brand/Designer, Teylers museum --> NULL, NULL
UNION ALL SELECT 1143734037, NULL, NULL
-- Brand/Designer, That doesn't bug me --> NULL, NULL
UNION ALL SELECT 1143760853, NULL, NULL
-- Brand/Designer, The Cardy Club --> NULL, NULL
UNION ALL SELECT 1143762658, NULL, NULL
-- Brand/Designer, The dogs doo dahs --> NULL, NULL
UNION ALL SELECT 1143763583, NULL, NULL
-- Brand/Designer, The London Studio --> NULL, NULL
UNION ALL SELECT 1143762648, NULL, NULL
-- Brand/Designer, The power of flower --> NULL, NULL
UNION ALL SELECT 1143755115, NULL, NULL
-- Brand/Designer, The Studio of Mr en Mrs Downing --> NULL, NULL
UNION ALL SELECT 1143762653, NULL, NULL
-- Brand/Designer, Thialf Museum --> NULL, NULL
UNION ALL SELECT 1143738786, NULL, NULL
-- Brand/Designer, Tillovision Ltd --> NULL, NULL
UNION ALL SELECT 1143762263, NULL, NULL
-- Brand/Designer, TMS --> NULL, NULL
UNION ALL SELECT 726316940, NULL, NULL
-- Brand/Designer, TMS Close Up --> NULL, NULL
UNION ALL SELECT 1143736653, NULL, NULL
-- Brand/Designer, TMS Confetti --> NULL, NULL
UNION ALL SELECT 1143735739, NULL, NULL
-- Brand/Designer, TMS Humour --> NULL, NULL
UNION ALL SELECT 1143734954, NULL, NULL
-- Brand/Designer, TMS Monsters --> NULL, NULL
UNION ALL SELECT 1143734765, NULL, NULL
-- Brand/Designer, TMS Mylo and Twinny --> NULL, NULL
UNION ALL SELECT 1143732443, NULL, NULL
-- Brand/Designer, TMS Splash Colour --> NULL, NULL
UNION ALL SELECT 1143735736, NULL, NULL
-- Brand/Designer, Tsjip --> NULL, NULL
UNION ALL SELECT 726311596, NULL, NULL
-- Brand/Designer, Twinkle little star --> NULL, NULL
UNION ALL SELECT 1143750518, NULL, NULL
-- Brand/Designer, Uddle --> NULL, NULL
UNION ALL SELECT 1143767803, NULL, NULL
-- Brand/Designer, UK Greetings --> NULL, NULL
UNION ALL SELECT 1143746594, NULL, NULL
-- Brand/Designer, Voxelville --> NULL, NULL
UNION ALL SELECT 1143766663, NULL, NULL
-- Brand/Designer, Vrolijke vriendjes --> NULL, NULL
UNION ALL SELECT 1143754418, NULL, NULL
-- Brand/Designer, Whambam --> NULL, NULL
UNION ALL SELECT 1143766418, NULL, NULL
-- Brand/Designer, Wildfire --> NULL, NULL
UNION ALL SELECT 1143760443, NULL, NULL
-- Brand/Designer, Woezel en Pip --> NULL, NULL
UNION ALL SELECT 726305507, NULL, NULL
-- Brand/Designer, YH Tekent --> NULL, NULL
UNION ALL SELECT 1143767708, NULL, NULL
-- Brand/Designer, Your Typical Chaos --> NULL, NULL
UNION ALL SELECT 1143763763, NULL, NULL
-- Brand/Designer, You're my type --> NULL, NULL
UNION ALL SELECT 1143750521, NULL, NULL
-- Brand/Designer, Zilveren Kruis --> NULL, NULL
UNION ALL SELECT 1143756552, NULL, NULL
-- Color, Black --> Colour, Black
UNION ALL SELECT 1143728198, 'black', 'Colour'
-- Color, Blue --> Colour, Blue
UNION ALL SELECT 1143728186, 'colour-blue', 'Colour'
-- Color, Brown --> Colour, Coloured
UNION ALL SELECT 727095669, 'coloured', 'Colour'
-- Color, Cardinal --> Colour, Coloured
UNION ALL SELECT 1143738519, 'coloured', 'Colour'
-- Color, Chocolate --> Colour, Coloured
UNION ALL SELECT 1143728189, 'coloured', 'Colour'
-- Color, DarkGreen --> Colour, Coloured
UNION ALL SELECT 1143728176, 'coloured', 'Colour'
-- Color, DarkOrange --> Colour, Coloured
UNION ALL SELECT 1143728157, 'coloured', 'Colour'
-- Color, DarkRed --> Colour, Coloured
UNION ALL SELECT 1143728147, 'coloured', 'Colour'
-- Color, DeepPink --> Colour, Pink
UNION ALL SELECT 1143728150, 'pink', 'Colour'
-- Color, DeepSkyBlue --> Colour, Blue
UNION ALL SELECT 1143728183, 'colour-blue', 'Colour'
-- Color, EasternBlue --> Colour, Blue
UNION ALL SELECT 1143738531, 'colour-blue', 'Colour'
-- Color, Gainsboro --> Colour, Coloured
UNION ALL SELECT 1143728195, 'coloured', 'Colour'
-- Color, Gold --> Colour, Coloured
UNION ALL SELECT 1143728161, 'coloured', 'Colour'
-- Color, Goldenrod --> Colour, Coloured
UNION ALL SELECT 1143728192, 'coloured', 'Colour'
-- Color, Gray --> Colour, Coloured
UNION ALL SELECT 727096150, 'coloured', 'Colour'
-- Color, Green --> Colour, Coloured
UNION ALL SELECT 727095708, 'coloured', 'Colour'
-- Color, GreenYellow --> Colour, Coloured
UNION ALL SELECT 1143728171, 'coloured', 'Colour'
-- Color, HotPink --> Colour, Pink
UNION ALL SELECT 1143728149, 'pink', 'Colour'
-- Color, Illusion --> Colour, Coloured
UNION ALL SELECT 1143738549, 'coloured', 'Colour'
-- Color, Indigo --> Colour, Blue
UNION ALL SELECT 1143728169, 'colour-blue', 'Colour'
-- Color, IslandSpice --> Colour, Coloured
UNION ALL SELECT 1143738510, 'coloured', 'Colour'
-- Color, Kournikova --> Colour, Coloured
UNION ALL SELECT 1143738513, 'coloured', 'Colour'
-- Color, Lavender --> Colour, Blue
UNION ALL SELECT 1143728164, 'colour-blue', 'Colour'
-- Color, LemonChiffon --> Colour, Coloured
UNION ALL SELECT 1143728163, 'coloured', 'Colour'
-- Color, LightSalmon --> Colour, Coloured
UNION ALL SELECT 1143728154, 'coloured', 'Colour'
-- Color, LightSkyBlue --> Colour, Blue
UNION ALL SELECT 1143728182, 'colour-blue', 'Colour'
-- Color, Magenta --> Colour, Coloured
UNION ALL SELECT 1143728151, 'coloured', 'Colour'
-- Color, Mandy --> Colour, Coloured
UNION ALL SELECT 1143738516, 'coloured', 'Colour'
-- Color, MediumSlateBlue --> Colour, Blue
UNION ALL SELECT 1143728170, 'colour-blue', 'Colour'
-- Color, MidnightBlue --> Colour, Blue
UNION ALL SELECT 1143728187, 'colour-blue', 'Colour'
-- Color, Mix of colors --> Colour, Multicolour
UNION ALL SELECT 729235298, 'multicolour', 'Colour'
-- Color, OliveDrab --> Colour, Coloured
UNION ALL SELECT 1143728177, 'coloured', 'Colour'
-- Color, Onahau --> Colour, Blue
UNION ALL SELECT 1143738525, 'colour-blue', 'Colour'
-- Color, Orchid --> Colour, Coloured
UNION ALL SELECT 1143728166, 'coloured', 'Colour'
-- Color, PaleGreen --> Colour, Coloured
UNION ALL SELECT 1143728173, 'coloured', 'Colour'
-- Color, PaleTurquoise --> Colour, Blue
UNION ALL SELECT 1143728180, 'colour-blue', 'Colour'
-- Color, PastelPink --> Colour, Pink
UNION ALL SELECT 1143738546, 'pink', 'Colour'
-- Color, PeachPuff --> Colour, Coloured
UNION ALL SELECT 1143728159, 'coloured', 'Colour'
-- Color, Peru --> Colour, Coloured
UNION ALL SELECT 1143728188, 'coloured', 'Colour'
-- Color, PineGlade --> Colour, Coloured
UNION ALL SELECT 1143738540, 'coloured', 'Colour'
-- Color, Pink --> Colour, Pink
UNION ALL SELECT 1143728148, 'pink', 'Colour'
-- Color, Polar --> Colour, Coloured
UNION ALL SELECT 1143738522, 'coloured', 'Colour'
-- Color, Purple --> Colour, Blue
UNION ALL SELECT 727096014, 'colour-blue', 'Colour'
-- Color, Raffia --> Colour, Coloured
UNION ALL SELECT 1143738555, 'coloured', 'Colour'
-- Color, Red --> Colour, Coloured
UNION ALL SELECT 1143728144, 'coloured', 'Colour'
-- Color, Salmon --> Colour, Pink
UNION ALL SELECT 1143728142, 'pink', 'Colour'
-- Color, Silver --> Colour, White
UNION ALL SELECT 1143728196, 'colour-white', 'Colour'
-- Color, SteelBlue --> Colour, Blue
UNION ALL SELECT 1143728181, 'colour-blue', 'Colour'
-- Color, Tiara --> Colour, Coloured
UNION ALL SELECT 1143738528, 'coloured', 'Colour'
-- Color, Violet --> Colour, Blue
UNION ALL SELECT 1143728153, 'colour-blue', 'Colour'
-- Color, White --> Colour, White
UNION ALL SELECT 1143728193, 'colour-white', 'Colour'
-- Color, WildRice --> Colour, Coloured
UNION ALL SELECT 1143738534, 'coloured', 'Colour'
-- Color, Yellow --> Colour, Coloured
UNION ALL SELECT 1143728162, 'coloured', 'Colour'
-- Design Style, Cards 3D illustration --> NULL, NULL
UNION ALL SELECT 1143765513, NULL, NULL
-- Design Style, Cards 3D typography --> NULL, NULL
UNION ALL SELECT 1143765488, NULL, NULL
-- Design Style, Cards edited photography --> NULL, NULL
UNION ALL SELECT 1143765468, NULL, NULL
-- Design Style, Cards illustration --> NULL, NULL
UNION ALL SELECT 1143765498, NULL, NULL
-- Design Style, Cards minimalistic illustration --> NULL, NULL
UNION ALL SELECT 1143765508, NULL, NULL
-- Design Style, Cards minimalistic typography --> NULL, NULL
UNION ALL SELECT 1143765483, NULL, NULL
-- Design Style, Cards photoframes --> Home & Garden, Photo Frames
UNION ALL SELECT 1143765518, 'photo-frames', 'Home & Garden'
-- Design Style, Cards photoframes --> Home & Garden, Pictures, Art & Frames
UNION ALL SELECT 1143765518, 'pictures-art-frames', 'Home & Garden'
-- Design Style, Cards photography --> Format Layout & Size, Photo Cover Cards
UNION ALL SELECT 1143765458, 'photo-cover-cards', 'Format Layout & Size'
-- Design Style, Cards regular illustration --> NULL, NULL
UNION ALL SELECT 1143765503, NULL, NULL
-- Design Style, Cards regular photography --> Format Layout & Size, Photo Cover Cards
UNION ALL SELECT 1143765463, 'photo-cover-cards', 'Format Layout & Size'
-- Design Style, Cards regular typography --> NULL, NULL
UNION ALL SELECT 1143765478, NULL, NULL
-- Design Style, Cards text/poems/quotes typography --> Sentiment & Style, Verse
UNION ALL SELECT 1143765493, 'verse', 'Sentiment & Style'
-- Design Style, Cards typography --> NULL, NULL
UNION ALL SELECT 1143765473, NULL, NULL
-- Design Style, Coloring page cards --> Who's It for?, For Kids
UNION ALL SELECT 1143749678, 'whos-it-for-for-kids', 'Whos It for?'
-- Design Style, Cute --> Sentiment & Style, Cute
UNION ALL SELECT 726295836, 'sentiment-style-cute', 'Sentiment & Style'
-- Design Style, Dutch cards --> NULL, NULL
UNION ALL SELECT 1143766728, NULL, NULL
-- Design Style, English cards --> NULL, NULL
UNION ALL SELECT 1143766733, NULL, NULL
-- Design Style, Hip --> NULL, NULL
UNION ALL SELECT 726296336, NULL, NULL
-- Design Style, With flowers --> Sentiment & Style, Floral
UNION ALL SELECT 1143730770, 'sentiment-style-floral', 'Sentiment & Style'
-- Highlighted, Back to school --> Occasion, School
UNION ALL SELECT 1143742895, 'school', 'Occasion'
-- Number of photos, 1 photo --> NULL, NULL
UNION ALL SELECT 1143727417, NULL, NULL
-- Number of photos, 10+ photos --> NULL, NULL
UNION ALL SELECT 1143766513, NULL, NULL
-- Number of photos, 2 t/m 4 photos --> NULL, NULL
UNION ALL SELECT 1143727418, NULL, NULL
-- Number of photos, 5 t/m 9 photos --> NULL, NULL
UNION ALL SELECT 1143766058, NULL, NULL
-- Number of photos, No photos --> NULL, NULL
UNION ALL SELECT 1143766043, NULL, NULL
-- Occasion, 16 years --> Birthday Milestones, 16th Birthday
UNION ALL SELECT 1143736074, '16th-birthday', 'Birthday Milestones'
-- Occasion, 18 years --> Birthday Milestones, 18th Birthday
UNION ALL SELECT 1143736069, '18th-birthday', 'Birthday Milestones'
-- Occasion, 21 years --> Birthday Milestones, 21st Birthday
UNION ALL SELECT 1143746028, '21st-birthday', 'Birthday Milestones'
-- Occasion, 25 years --> Birthday Milestones, 25th Birthday
UNION ALL SELECT 1143746031, '25th-birthday', 'Birthday Milestones'
-- Occasion, 30 years --> Birthday Milestones, 30th Birthday
UNION ALL SELECT 1143736051, '30th-birthday', 'Birthday Milestones'
-- Occasion, 40 years --> Birthday Milestones, 40th Birthday
UNION ALL SELECT 1143736048, '40th-birthday', 'Birthday Milestones'
-- Occasion, 50 years --> Birthday Milestones, 50th Birthday
UNION ALL SELECT 1143736054, '50th-birthday', 'Birthday Milestones'
-- Occasion, 60 years --> Birthday Milestones, 60th Birthday
UNION ALL SELECT 1143736063, '60th-birthday', 'Birthday Milestones'
-- Occasion, 70 years --> Birthday Milestones, 70th Birthday
UNION ALL SELECT 1143736066, '70th-birthday', 'Birthday Milestones'
-- Occasion, 80 years --> Birthday Milestones, 80th Birthday
UNION ALL SELECT 1143736060, '80th-birthday', 'Birthday Milestones'
-- Occasion, Adoption --> Occasion, Adoption
UNION ALL SELECT 1143760393, 'adoption', 'Occasion'
-- Occasion, Age invitations --> Format Layout & Size, Invitations
UNION ALL SELECT 1143737827, 'invitations', 'Format Layout & Size'
-- Occasion, Anniversary --> Occasion, Anniversaries
UNION ALL SELECT 1143740082, 'anniversaries', 'Occasion'
-- Occasion, Anniversary 1 year working from home --> Occasion, Anniversaries
UNION ALL SELECT 1143754239, 'anniversaries', 'Occasion'
-- Occasion, Anniversary relationship --> Occasion, Anniversaries
UNION ALL SELECT 1143761508, 'anniversaries', 'Occasion'
-- Occasion, AOC think --> Occasion, Thinking of you
UNION ALL SELECT 1143742160, 'occasion-thinking-of-you', 'Occasion'
-- Occasion, Baby party (invitations) --> Format Layout & Size, Invitations
UNION ALL SELECT 1143728943, 'invitations', 'Format Layout & Size'
-- Occasion, Baby party (invitations) --> Occasion, New Baby
UNION ALL SELECT 1143728943, 'occasion-new-baby', 'Occasion'
-- Occasion, Baby shower (invitations) --> Format Layout & Size, Invitations
UNION ALL SELECT 1143729372, 'invitations', 'Format Layout & Size'
-- Occasion, Baby shower (invitations) --> Occasion, Baby Shower
UNION ALL SELECT 1143729372, 'baby-shower', 'Occasion'
-- Occasion, Babyshower --> Occasion, Baby Shower
UNION ALL SELECT 1143739143, 'baby-shower', 'Occasion'
-- Occasion, Babyshower (invitations cardhouse) --> Format Layout & Size, Invitations
UNION ALL SELECT 1143734414, 'invitations', 'Format Layout & Size'
-- Occasion, Babyshower (invitations cardhouse) --> Occasion, Baby Shower
UNION ALL SELECT 1143734414, 'baby-shower', 'Occasion'
-- Occasion, Bachelor party (invitations) --> Format Layout & Size, Invitations
UNION ALL SELECT 1143729366, 'invitations', 'Format Layout & Size'
-- Occasion, Bachelor party (invitations) --> Occasion, Congratulations
UNION ALL SELECT 1143729366, 'occasion-congratulations', 'Occasion'
-- Occasion, Back to school cards --> Occasion, School
UNION ALL SELECT 1143754649, 'school', 'Occasion'
-- Occasion, Baptism and communion (invitations) --> Occasion, Christening
UNION ALL SELECT 1143728949, 'christening', 'Occasion'
-- Occasion, Beautiful moments --> Occasion, Holiday
UNION ALL SELECT 1143766253, 'holiday', 'Occasion'
-- Occasion, Birth --> Occasion, New Baby
UNION ALL SELECT 726324202, 'occasion-new-baby', 'Occasion'
-- Occasion, Birth cards (Birth) --> Occasion, New Baby
UNION ALL SELECT 1143736045, 'occasion-new-baby', 'Occasion'
-- Occasion, Birth cards (boy) --> Occasion, New Baby
UNION ALL SELECT 1143737029, 'occasion-new-baby', 'Occasion'
-- Occasion, Birth premature --> NULL, NULL
UNION ALL SELECT 1143754595, NULL, NULL
-- Occasion, Birth rainbow child --> NULL, NULL
UNION ALL SELECT 1143754601, NULL, NULL
-- Occasion, Birth with handicap --> NULL, NULL
UNION ALL SELECT 1143754598, NULL, NULL
-- Occasion, Birthday --> Occasion, Birthday
UNION ALL SELECT 726324105, 'occasion-birthday', 'Occasion'
-- Occasion, Birthday belated Wishes --> Occasion, Belated Birthday
UNION ALL SELECT 735869180, 'belated-birthday', 'Occasion'
-- Occasion, Birthday belated Wishes --> Sentiment & Style, Belated
UNION ALL SELECT 735869180, 'belated', 'Sentiment & Style'
-- Occasion, Birthday from distance --> Occasion, Birthday
UNION ALL SELECT 1143749585, 'occasion-birthday', 'Occasion'
-- Occasion, Birthday in dialect --> Occasion, Birthday
UNION ALL SELECT 1143752651, 'occasion-birthday', 'Occasion'
-- Occasion, Birthday invitation (invitations) --> Format Layout & Size, Invitations
UNION ALL SELECT 1143728925, 'invitations', 'Format Layout & Size'
-- Occasion, Birthday invitation (invitations) --> Occasion, Birthday
UNION ALL SELECT 1143728925, 'occasion-birthday', 'Occasion'
-- Occasion, Birthday leap year --> Occasion, Birthday
UNION ALL SELECT 1143733516, 'occasion-birthday', 'Occasion'
-- Occasion, Birthday with age --> NewIa, Birthday Milestones
UNION ALL SELECT 1082531404, 'birthday-milestones', 'NewIa'
-- Occasion, Birthday with star sign --> Occasion, Birthday
UNION ALL SELECT 1143749327, 'occasion-birthday', 'Occasion'
-- Occasion, Blue Monday --> Occasion, Other
UNION ALL SELECT 1143765398, 'occasion-other', 'Occasion'
-- Occasion, Borrel (invitation) --> Format Layout & Size, Invitations
UNION ALL SELECT 1143735320, 'invitations', 'Format Layout & Size'
-- Occasion, Broken bones --> Occasion, Get Well
UNION ALL SELECT 1143754613, 'occasion-get-well', 'Occasion'
-- Occasion, Brother and Sister day --> Occasion, Friendship
UNION ALL SELECT 1143732527, 'occasion-friendship', 'Occasion'
-- Occasion, Business invitations (invitations) --> Format Layout & Size, Invitations
UNION ALL SELECT 1143729480, 'invitations', 'Format Layout & Size'
-- Occasion, Carnaval --> Occasion, Holiday
UNION ALL SELECT 1143766238, 'holiday', 'Occasion'
-- Occasion, Change number --> NULL, NULL
UNION ALL SELECT 1143736758, NULL, NULL
-- Occasion, Changeable age --> NULL, NULL
UNION ALL SELECT 1143736083, NULL, NULL
-- Occasion, Changeable age kids --> NULL, NULL
UNION ALL SELECT 1143736089, NULL, NULL
-- Occasion, Childrens party (invitations) --> Format Layout & Size, Invitations
UNION ALL SELECT 1143728928, 'invitations', 'Format Layout & Size'
-- Occasion, Childrens party (invitations) --> Who's It for?, For Kids
UNION ALL SELECT 1143728928, 'whos-it-for-for-kids', 'Whos It for?'
-- Occasion, Chinese New Year --> Occasion, Chinese new year
UNION ALL SELECT 1143765953, 'occasion-chinese-new-year', 'Occasion'
-- Occasion, Christmas --> Occasion, Christmas
UNION ALL SELECT 726331358, 'occasion-christmas', 'Occasion'
-- Occasion, Christmas (cardhouse) --> Occasion, Christmas
UNION ALL SELECT 1143734963, 'occasion-christmas', 'Occasion'
-- Occasion, Christmas (invitations) --> Format Layout & Size, Invitations
UNION ALL SELECT 1143734987, 'invitations', 'Format Layout & Size'
-- Occasion, Christmas (invitations) --> Occasion, Christmas
UNION ALL SELECT 1143734987, 'occasion-christmas', 'Occasion'
-- Occasion, Christmas birth --> Occasion, New Baby
UNION ALL SELECT 1143744030, 'occasion-new-baby', 'Occasion'
-- Occasion, Christmas birthday --> Occasion, Birthday
UNION ALL SELECT 1143750641, 'occasion-birthday', 'Occasion'
-- Occasion, Christmas Business (IA) --> Occasion, Christmas
UNION ALL SELECT 1143734990, 'occasion-christmas', 'Occasion'
-- Occasion, Christmas humor --> Occasion, Christmas
UNION ALL SELECT 1143750638, 'occasion-christmas', 'Occasion'
-- Occasion, Christmas humor --> Sentiment & Style, Funny
UNION ALL SELECT 1143750638, 'sentiment-style-funny', 'Sentiment & Style'
-- Occasion, Christmas in the weekend --> Occasion, Christmas
UNION ALL SELECT 1143764653, 'occasion-christmas', 'Occasion'
-- Occasion, Christmas most sold --> Occasion, Christmas
UNION ALL SELECT 1143737233, 'occasion-christmas', 'Occasion'
-- Occasion, Christmas new home --> Occasion, New Home
UNION ALL SELECT 1143744027, 'occasion-new-home', 'Occasion'
-- Occasion, Christmas party (invitations Cardhouse) --> Format Layout & Size, Invitations
UNION ALL SELECT 1143742829, 'invitations', 'Format Layout & Size'
-- Occasion, Christmas party (invitations Cardhouse) --> Occasion, Christmas
UNION ALL SELECT 1143742829, 'occasion-christmas', 'Occasion'
-- Occasion, Christmas thank you --> Occasion, Christmas
UNION ALL SELECT 1143762663, 'occasion-christmas', 'Occasion'
-- Occasion, Christmas thinking of you --> Occasion, Christmas
UNION ALL SELECT 1143743997, 'occasion-christmas', 'Occasion'
-- Occasion, Chronically or seriously ill --> Occasion, Get Well
UNION ALL SELECT 1143754616, 'occasion-get-well', 'Occasion'
-- Occasion, Commumion (invitations cardhouse) --> Format Layout & Size, Invitations
UNION ALL SELECT 1143733885, 'invitations', 'Format Layout & Size'
-- Occasion, Communion --> NULL, NULL
UNION ALL SELECT 735930784, NULL, NULL
-- Occasion, Condolence --> Occasion, Empathy
UNION ALL SELECT 726345401, 'empathy', 'Occasion'
-- Occasion, Condolence pet --> Occasion, Empathy
UNION ALL SELECT 1143754053, 'empathy', 'Occasion'
-- Occasion, Condolence with text --> Occasion, Empathy
UNION ALL SELECT 1143743715, 'empathy', 'Occasion'
-- Occasion, Condolence without text --> Occasion, Empathy
UNION ALL SELECT 1143743712, 'empathy', 'Occasion'
-- Occasion, Confirmation --> Occasion, Well Done
UNION ALL SELECT 727249045, 'occasion-well-done', 'Occasion'
-- Occasion, Congratulations (card and gift) --> Occasion, Congratulations
UNION ALL SELECT 1143729948, 'occasion-congratulations', 'Occasion'
-- Occasion, Congratulations (card and gift) --> Sentiment & Style, Congratulations
UNION ALL SELECT 1143729948, 'sentiment-style-congratulations', 'Sentiment & Style'
-- Occasion, Course completed --> Occasion, Congratulations
UNION ALL SELECT 1143754866, 'occasion-congratulations', 'Occasion'
-- Occasion, Course completed --> Sentiment & Style, Congratulations
UNION ALL SELECT 1143754866, 'sentiment-style-congratulations', 'Sentiment & Style'
-- Occasion, Day of caregiving --> Occasion, Other
UNION ALL SELECT 1143763418, 'occasion-other', 'Occasion'
-- Occasion, Day of the animals --> Occasion, Other
UNION ALL SELECT 735910080, 'occasion-other', 'Occasion'
-- Occasion, Day of the daycare --> Occasion, Other
UNION ALL SELECT 1143750698, 'occasion-other', 'Occasion'
-- Occasion, Dinner party en drinks (invitations) --> Format Layout & Size, Invitations
UNION ALL SELECT 1143728937, 'invitations', 'Format Layout & Size'
-- Occasion, Divorce --> Occasion, Other
UNION ALL SELECT 1143754400, 'occasion-other', 'Occasion'
-- Occasion, Driving License extended --> Occasion, Driving Test
UNION ALL SELECT 1143754863, 'occasion-driving-test', 'Occasion'
-- Occasion, Driving License graduated --> Occasion, Driving Test
UNION ALL SELECT 735934096, 'occasion-driving-test', 'Occasion'
-- Occasion, Easter/Pasen --> Occasion, Easter
UNION ALL SELECT 726343205, 'occasion-easter', 'Occasion'
-- Occasion, Eid al Adha > Offerfeest --> Religious Occasions, Eid al Adha
UNION ALL SELECT 1143769648, 'eid-al-adha', 'Religious Occasions'
-- Occasion, Eid Mubarak --> Religious Occasions, Eid Mubarak
UNION ALL SELECT 1143746767, 'eid-mubarak', 'Religious Occasions'
-- Occasion, Engaged --> Occasion, Engagement
UNION ALL SELECT 735870409, 'occasion-engagement', 'Occasion'
-- Occasion, Exam party (invitations) --> Format Layout & Size, Invitations
UNION ALL SELECT 1143728946, 'invitations', 'Format Layout & Size'
-- Occasion, Exam party (invitations) --> Occasion, Exams
UNION ALL SELECT 1143728946, 'occasion-exams', 'Occasion'
-- Occasion, Extra special --> Occasion, Other
UNION ALL SELECT 1143761028, 'occasion-other', 'Occasion'
-- Occasion, Failed --> Occasion, Empathy
UNION ALL SELECT 748506030, 'empathy', 'Occasion'
-- Occasion, Fathersday --> Occasion, Fathers Day
UNION ALL SELECT 726332069, 'fathers-day', 'Occasion'
-- Occasion, Fathersday beercards --> Occasion, Father's Day
UNION ALL SELECT 1143746600, 'fathers-day', 'Occasion'
-- Occasion, Fathersday best sold --> Occasion, Father's Day
UNION ALL SELECT 1143735068, 'fathers-day', 'Occasion'
-- Occasion, Fathersday thinking of you --> Occasion, Father's Day
UNION ALL SELECT 1143749723, 'fathers-day', 'Occasion'
-- Occasion, First childrensbirthday --> Birthday Milestones, 1st Birthday
UNION ALL SELECT 1143736077, '1st-birthday', 'Birthday Milestones'
-- Occasion, First Father's day --> Occasion, Father's Day
UNION ALL SELECT 1143737236, 'fathers-day', 'Occasion'
-- Occasion, First mothersday --> Occasion, Mothers' Day
UNION ALL SELECT 1143749468, 'mothers-day', 'Occasion'
-- Occasion, Friendship2 --> Occasion, Friendship
UNION ALL SELECT 893069562, 'occasion-friendship', 'Occasion'
-- Occasion, Garden party (invitations) --> Format Layout & Size, Invitations
UNION ALL SELECT 1143728952, 'invitations', 'Format Layout & Size'
-- Occasion, Gardenparty (invitations cardhouse) --> Format Layout & Size, Invitations
UNION ALL SELECT 1143734411, 'invitations', 'Format Layout & Size'
-- Occasion, Gay marriage --> Sentiment & Style, LGBTQ+
UNION ALL SELECT 1143732593, 'lgbtq', 'Sentiment & Style'
-- Occasion, Gay marriage --> Who's it for?, LGBTQ+
UNION ALL SELECT 1143732593, 'whos-it-for-lgbtq', 'Whos it for?'
-- Occasion, Gender reveal party (invitations) --> Format Layout & Size, Invitations
UNION ALL SELECT 1143739140, 'invitations', 'Format Layout & Size'
-- Occasion, Gender reveal party (invitations) --> Occasion, New Baby
UNION ALL SELECT 1143739140, 'occasion-new-baby', 'Occasion'
-- Occasion, Get well --> Occasion, Get Well
UNION ALL SELECT 726345521, 'occasion-get-well', 'Occasion'
-- Occasion, Get well welcome home --> Occasion, Get Well
UNION ALL SELECT 1143742088, 'occasion-get-well', 'Occasion'
-- Occasion, Good luck --> Occasion, Good Luck
UNION ALL SELECT 726345736, 'occasion-good-luck', 'Occasion'
-- Occasion, Graduated afgestudeerd --> Occasion, Graduation
UNION ALL SELECT 1143754869, 'occasion-graduation', 'Occasion'
-- Occasion, Graduated high school --> Occasion, Graduation
UNION ALL SELECT 748505918, 'occasion-graduation', 'Occasion'
-- Occasion, Graduated Propaedeutic certificate --> Occasion, Congratulations
UNION ALL SELECT 1143754872, 'occasion-congratulations', 'Occasion'
-- Occasion, Graduated Propaedeutic certificate --> Sentiment & Style, Congratulations
UNION ALL SELECT 1143754872, 'sentiment-style-congratulations', 'Sentiment & Style'
-- Occasion, Graduation --> Occasion, Graduation
UNION ALL SELECT 1143729906, 'occasion-graduation', 'Occasion'
-- Occasion, Grandparents day --> Who's It for?, Grandparents
UNION ALL SELECT 1143732211, 'grandparents', 'Whos It for?'
-- Occasion, Greetings from --> NULL, NULL
UNION ALL SELECT 1143731914, NULL, NULL
-- Occasion, Halloween --> Occasion, Halloween
UNION ALL SELECT 1143731177, 'occasion-halloween', 'Occasion'
-- Occasion, Hanukkah --> Religious Occasions, Hanukkah
UNION ALL SELECT 1143764508, 'hanukkah', 'Religious Occasions'
-- Occasion, Happy Pride --> Occasion, Pride
UNION ALL SELECT 1143747064, 'pride', 'Occasion'
-- Occasion, Highschool --> Occasion, School
UNION ALL SELECT 1143754655, 'school', 'Occasion'
-- Occasion, Honeymoon --> Occasion, Wedding
UNION ALL SELECT 1143754640, 'occasion-wedding', 'Occasion'
-- Occasion, Honeymoon --> Sentiment & Style, Love
UNION ALL SELECT 1143754640, 'sentiment-style-love', 'Sentiment & Style'
-- Occasion, Housewarming (invitations Cardhouse) --> Format Layout & Size, Invitations
UNION ALL SELECT 1143733891, 'invitations', 'Format Layout & Size'
-- Occasion, Housewarming (invitations) --> Format Layout & Size, Invitations
UNION ALL SELECT 1143728958, 'invitations', 'Format Layout & Size'
-- Occasion, International boss day --> Occasion, Other
UNION ALL SELECT 1143746905, 'occasion-other', 'Occasion'
-- Occasion, International Women's Day --> Occasion, International Women's Day
UNION ALL SELECT 1143766488, 'international-womens-day', 'Occasion'
-- Occasion, Just because --> Occasion, Just to say
UNION ALL SELECT 726347430, 'just-to-say', 'Occasion'
-- Occasion, Just Married --> Occasion, Wedding
UNION ALL SELECT 1143732220, 'occasion-wedding', 'Occasion'
-- Occasion, Just Married --> Sentiment & Style, Love
UNION ALL SELECT 1143732220, 'sentiment-style-love', 'Sentiment & Style'
-- Occasion, Kingsday --> NULL, NULL
UNION ALL SELECT 726972775, NULL, NULL
-- Occasion, Kingsday birthday --> NULL, NULL
UNION ALL SELECT 1143755892, NULL, NULL
-- Occasion, Living together --> Occasion, New Home
UNION ALL SELECT 1143727835, 'occasion-new-home', 'Occasion'
-- Occasion, Love --> Occasion, Missing You
UNION ALL SELECT 1143727832, 'missing-you', 'Occasion'
-- Occasion, Love --> Sentiment & Style, Love
UNION ALL SELECT 1143727832, 'sentiment-style-love', 'Sentiment & Style'
-- Occasion, Marriage anniversary (invitations) --> Format Layout & Size, Invitations
UNION ALL SELECT 1143729369, 'invitations', 'Format Layout & Size'
-- Occasion, Marriage anniversary (invitations) --> Occasion, Anniversaries
UNION ALL SELECT 1143729369, 'anniversaries', 'Occasion'
-- Occasion, married 10 years --> Occasion, Anniversaries
UNION ALL SELECT 1143735023, 'anniversaries', 'Occasion'
-- Occasion, married 12.5 years --> Occasion, Anniversaries
UNION ALL SELECT 1143735008, 'anniversaries', 'Occasion'
-- Occasion, married 25 years --> Occasion, Anniversaries
UNION ALL SELECT 1143735011, 'anniversaries', 'Occasion'
-- Occasion, married 30 years --> Occasion, Anniversaries
UNION ALL SELECT 1143735020, 'anniversaries', 'Occasion'
-- Occasion, married 35 years --> Occasion, Anniversaries
UNION ALL SELECT 1143735038, 'anniversaries', 'Occasion'
-- Occasion, married 40 years --> Occasion, Anniversaries
UNION ALL SELECT 1143735014, 'anniversaries', 'Occasion'
-- Occasion, married 5 years --> Occasion, Anniversaries
UNION ALL SELECT 1143735026, 'anniversaries', 'Occasion'
-- Occasion, married 50 years --> Occasion, Anniversaries
UNION ALL SELECT 1143735017, 'anniversaries', 'Occasion'
-- Occasion, Maternity Leave --> Occasion, Pregnancy
UNION ALL SELECT 1143733399, 'occasion-pregnancy', 'Occasion'
-- Occasion, Milestones --> Occasion, Congratulations
UNION ALL SELECT 1143749857, 'occasion-congratulations', 'Occasion'
-- Occasion, Milestones --> Sentiment & Style, Congratulations
UNION ALL SELECT 1143749857, 'sentiment-style-congratulations', 'Sentiment & Style'
-- Occasion, Miscarriage --> NULL, NULL
UNION ALL SELECT 1143754610, NULL, NULL
-- Occasion, Mothersday --> Occasion, Mothers Day
UNION ALL SELECT 726331722, 'mothers-day', 'Occasion'
-- Occasion, Mothersday best sold --> Occasion, Mothers' Day
UNION ALL SELECT 1143736647, 'mothers-day', 'Occasion'
-- Occasion, Mothersday distance --> Occasion, Mothers' Day
UNION ALL SELECT 1143749639, 'mothers-day', 'Occasion'
-- Occasion, Mothersday thinking of you --> Occasion, Mothers' Day
UNION ALL SELECT 1143749471, 'mothers-day', 'Occasion'
-- Occasion, Moving (invitations) --> Format Layout & Size, Invitations
UNION ALL SELECT 1143728961, 'invitations', 'Format Layout & Size'
-- Occasion, Moving announcement (invitations) --> Format Layout & Size, Invitations
UNION ALL SELECT 1143728934, 'invitations', 'Format Layout & Size'
-- Occasion, Moving announcement christmas --> Occasion, Christmas
UNION ALL SELECT 1143744489, 'occasion-christmas', 'Occasion'
-- Occasion, New home --> Occasion, New Home
UNION ALL SELECT 726342840, 'occasion-new-home', 'Occasion'
-- Occasion, New Job --> Occasion, New Job
UNION ALL SELECT 735872747, 'occasion-new-job', 'Occasion'
-- Occasion, New schoolyear --> Occasion, School
UNION ALL SELECT 1143754652, 'school', 'Occasion'
-- Occasion, New year party (invitations cardhouse) --> Format Layout & Size, Invitations
UNION ALL SELECT 1143742832, 'invitations', 'Format Layout & Size'
-- Occasion, New year party (invitations cardhouse) --> Occasion, New Year
UNION ALL SELECT 1143742832, 'occasion-new-year', 'Occasion'
-- Occasion, New Years Party (invitations) --> Format Layout & Size, Invitations
UNION ALL SELECT 1143731548, 'invitations', 'Format Layout & Size'
-- Occasion, New Years Party (invitations) --> Occasion, New Year
UNION ALL SELECT 1143731548, 'occasion-new-year', 'Occasion'
-- Occasion, New Year's reception business --> Occasion, New Year
UNION ALL SELECT 1143743079, 'occasion-new-year', 'Occasion'
-- Occasion, Newyear (cardhouse) --> Occasion, New Year
UNION ALL SELECT 1143734456, 'occasion-new-year', 'Occasion'
-- Occasion, NewYear (cards) --> Occasion, New Year
UNION ALL SELECT 726331444, 'occasion-new-year', 'Occasion'
-- Occasion, NewYear Birth --> NULL, NULL
UNION ALL SELECT 1143765733, NULL, NULL
-- Occasion, NewYear Birthday --> Occasion, Birthday
UNION ALL SELECT 1143765723, 'occasion-birthday', 'Occasion'
-- Occasion, NewYear New home --> Occasion, New Home
UNION ALL SELECT 1143765738, 'occasion-new-home', 'Occasion'
-- Occasion, NewYearsCards --> Occasion, New Year
UNION ALL SELECT 1143748523, 'occasion-new-year', 'Occasion'
-- Occasion, Notice of marriage --> Occasion, Wedding
UNION ALL SELECT 1143754397, 'occasion-wedding', 'Occasion'
-- Occasion, Notice of marriage --> Sentiment & Style, Love
UNION ALL SELECT 1143754397, 'sentiment-style-love', 'Sentiment & Style'
-- Occasion, Opening new business --> Occasion, Congratulations
UNION ALL SELECT 1143744579, 'occasion-congratulations', 'Occasion'
-- Occasion, Opening new business --> Sentiment & Style, Congratulations
UNION ALL SELECT 1143744579, 'sentiment-style-congratulations', 'Sentiment & Style'
-- Occasion, Opening new business (invitations) --> Format Layout & Size, Invitations
UNION ALL SELECT 1143745104, 'invitations', 'Format Layout & Size'
-- Occasion, Opening new business (invitations) --> Occasion, Congratulations
UNION ALL SELECT 1143745104, 'occasion-congratulations', 'Occasion'
-- Occasion, Partnerships --> Occasion, Congratulations
UNION ALL SELECT 1143750262, 'occasion-congratulations', 'Occasion'
-- Occasion, photoself --> NULL, NULL
UNION ALL SELECT 1143731878, NULL, NULL
-- Occasion, Pregnant --> Occasion, Pregnancy
UNION ALL SELECT 726344253, 'occasion-pregnancy', 'Occasion'
-- Occasion, Proud of you --> Occasion, Proud of You
UNION ALL SELECT 1143766298, 'proud-of-you', 'Occasion'
-- Occasion, re exam --> Occasion, Exams
UNION ALL SELECT 1143742355, 'occasion-exams', 'Occasion'
-- Occasion, Registered partnership --> Occasion, Congratulations
UNION ALL SELECT 1143754619, 'occasion-congratulations', 'Occasion'
-- Occasion, Registered partnership --> Sentiment & Style, Congratulations
UNION ALL SELECT 1143754619, 'sentiment-style-congratulations', 'Sentiment & Style'
-- Occasion, Renovate --> Occasion, New Home
UNION ALL SELECT 1143754634, 'occasion-new-home', 'Occasion'
-- Occasion, Retirement --> Occasion, Retirement
UNION ALL SELECT 735873966, 'occasion-retirement', 'Occasion'
-- Occasion, Save our date --> Occasion, Missing You
UNION ALL SELECT 1143745167, 'missing-you', 'Occasion'
-- Occasion, Save our date --> Sentiment & Style, Love
UNION ALL SELECT 1143745167, 'sentiment-style-love', 'Sentiment & Style'
-- Occasion, Save the date (Wedding cards only) --> Occasion, Missing You
UNION ALL SELECT 1143729708, 'missing-you', 'Occasion'
-- Occasion, Save the date (Wedding cards only) --> Occasion, Wedding
UNION ALL SELECT 1143729708, 'occasion-wedding', 'Occasion'
-- Occasion, Save the date (Wedding cards only) --> Sentiment & Style, Love
UNION ALL SELECT 1143729708, 'sentiment-style-love', 'Sentiment & Style'
-- Occasion, Say goodbye --> Occasion, Goodbye
UNION ALL SELECT 1143736125, 'goodbye', 'Occasion'
-- Occasion, Secretaryday --> Occasion, Other
UNION ALL SELECT 1143731240, 'occasion-other', 'Occasion'
-- Occasion, Sinterklaas --> Occasion, Other
UNION ALL SELECT 726330911, 'occasion-other', 'Occasion'
-- Occasion, Sorry --> Occasion, Sorry
UNION ALL SELECT 726966325, 'occasion-sorry', 'Occasion'
-- Occasion, Spring party (BE) --> NULL, NULL
UNION ALL SELECT 1143735985, NULL, NULL
-- Occasion, Summer pictures --> NULL, NULL
UNION ALL SELECT 1143737512, NULL, NULL
-- Occasion, Surprise party --> NULL, NULL
UNION ALL SELECT 1143735665, NULL, NULL
-- Occasion, Swimming diploma --> Occasion, Congratulations
UNION ALL SELECT 1143742376, 'occasion-congratulations', 'Occasion'
-- Occasion, Swimming diploma --> Sentiment & Style, Congratulations
UNION ALL SELECT 1143742376, 'sentiment-style-congratulations', 'Sentiment & Style'
-- Occasion, Thank you --> Occasion, Thank You
UNION ALL SELECT 726347103, 'occasion-thank-you', 'Occasion'
-- Occasion, Thank you cards (invitations) --> Format Layout & Size, Invitations
UNION ALL SELECT 1143728940, 'invitations', 'Format Layout & Size'
-- Occasion, Thank you cards (invitations) --> Occasion, Thank You
UNION ALL SELECT 1143728940, 'occasion-thank-you', 'Occasion'
-- Occasion, Thank you caretakers --> Occasion, Thank You
UNION ALL SELECT 1143749321, 'occasion-thank-you', 'Occasion'
-- Occasion, Thank you teacher --> Occasion, Thank You
UNION ALL SELECT 1143742415, 'occasion-thank-you', 'Occasion'
-- Occasion, Thanksgiving --> NULL, NULL
UNION ALL SELECT 1143764443, NULL, NULL
-- Occasion, Thinking of you --> Occasion, Thinking of you
UNION ALL SELECT 748511930, 'occasion-thinking-of-you', 'Occasion'
-- Occasion, To welcome --> Occasion, Welcome Home
UNION ALL SELECT 1143754631, 'welcome-home', 'Occasion'
-- Occasion, Travelling --> Occasion, Bon Voyage
UNION ALL SELECT 1143731911, 'occasion-bon-voyage', 'Occasion'
-- Occasion, Vacation --> Occasion, Bon Voyage
UNION ALL SELECT 1143729435, 'occasion-bon-voyage', 'Occasion'
-- Occasion, Vacation welcome home --> Occasion, Welcome Home
UNION ALL SELECT 726965369, 'welcome-home', 'Occasion'
-- Occasion, Valentine --> Occasion, Valentines Day
UNION ALL SELECT 726324647, 'valentines-day', 'Occasion'
-- Occasion, Valentine best sold --> Occasion, Valentines Day
UNION ALL SELECT 1143735065, 'valentines-day', 'Occasion'
-- Occasion, Valentine In love --> Occasion, Valentines Day
UNION ALL SELECT 748508746, 'valentines-day', 'Occasion'
-- Occasion, Valentine loving --> Occasion, Valentines Day
UNION ALL SELECT 748510085, 'valentines-day', 'Occasion'
-- Occasion, Valentine online dating --> NULL, NULL
UNION ALL SELECT 1143748919, NULL, NULL
-- Occasion, Valentine secret love --> Occasion, Valentines' Day
UNION ALL SELECT 748508147, 'valentines-day', 'Occasion'
-- Occasion, Valentine single --> Occasion, Valentines' Day
UNION ALL SELECT 1143765443, 'valentines-day', 'Occasion'
-- Occasion, Valentine thinking of you --> Occasion, Valentines' Day
UNION ALL SELECT 1143748916, 'valentines-day', 'Occasion'
-- Occasion, Wedding --> Occasion, Wedding
UNION ALL SELECT 726342081, 'occasion-wedding', 'Occasion'
-- Occasion, Wedding --> Sentiment & Style, Love
UNION ALL SELECT 726342081, 'sentiment-style-love', 'Sentiment & Style'
-- Occasion, Wedding Anniversary --> Occasion, Anniversaries
UNION ALL SELECT 735870898, 'anniversaries', 'Occasion'
-- Occasion, Wedding invitation (Wedding) --> Occasion, Wedding
UNION ALL SELECT 1143728795, 'occasion-wedding', 'Occasion'
-- Occasion, Wedding invitation (Wedding) --> Sentiment & Style, Love
UNION ALL SELECT 1143728795, 'sentiment-style-love', 'Sentiment & Style'
-- Occasion, Witness --> NULL, NULL
UNION ALL SELECT 1143740590, NULL, NULL
-- Occasion, Work anniversary --> Occasion, Anniversaries
UNION ALL SELECT 1143733543, 'anniversaries', 'Occasion'
-- Product Family, Drinks --> NewIa, Food & Drink
UNION ALL SELECT 1143727296, 'food-drink', 'NewIa'
-- Product Family, Gifts --> NULL, NULL
UNION ALL SELECT 727212959, NULL, NULL
-- Product Family, Greeting Cards --> Format Layout & Size, Greeting Cards
UNION ALL SELECT 726928674, 'greeting-cards', 'Format Layout & Size'
-- Product Family, Invitations (IA) --> Format Layout & Size, Invitations
UNION ALL SELECT 726926716, 'invitations', 'Format Layout & Size'
-- Target Group, Abraham --> NULL, NULL
UNION ALL SELECT 1143750965, NULL, NULL
-- Target Group, Animal dad --> Animals, Pet
UNION ALL SELECT 1143749732, 'animals-pet', 'Animals'
-- Target Group, Animal mom --> Animals, Pet
UNION ALL SELECT 1143749729, 'animals-pet', 'Animals'
-- Target Group, Aunt --> Who's It for?, Auntie
UNION ALL SELECT 1143753146, 'whos-it-for-auntie', 'Whos It for?'
-- Target Group, B2B --> Who's It for?, Partner
UNION ALL SELECT 1143751277, 'partner', 'Whos It for?'
-- Target Group, Bonus dad --> Who's It for?, Dad
UNION ALL SELECT 1143749726, 'whos-it-for-dad', 'Whos It for?'
-- Target Group, Bonus mother --> Who's It for?, Mum
UNION ALL SELECT 1143749543, 'whos-it-for-mum', 'Whos It for?'
-- Target Group, Boy --> Who's it for?, For Boys
UNION ALL SELECT 886506339, 'for-boys', 'Whos it for?'
-- Target Group, Boy and girl --> Who's It for?, For Boys
UNION ALL SELECT 1143764788, 'for-boys', 'Whos It for?'
-- Target Group, Boy and girl --> Who's It for?, For Girls
UNION ALL SELECT 1143764788, 'for-girls', 'Whos It for?'
-- Target Group, Boy and girl --> Who's It for?, For Her
UNION ALL SELECT 1143764788, 'for-her', 'Whos It for?'
-- Target Group, Boy and girl --> Who's It for?, For Him
UNION ALL SELECT 1143764788, 'for-him', 'Whos It for?'
-- Target Group, Boy general --> Who's It for?, For Boys
UNION ALL SELECT 1143758723, 'for-boys', 'Whos It for?'
-- Target Group, Boy general --> Who's It for?, For Him
UNION ALL SELECT 1143758723, 'for-him', 'Whos It for?'
-- Target Group, Boys --> Who's It for?, For Boys
UNION ALL SELECT 1143742982, 'for-boys', 'Whos It for?'
-- Target Group, Boys --> Who's It for?, For Him
UNION ALL SELECT 1143742982, 'for-him', 'Whos It for?'
-- Target Group, Brand new dad --> Who's It for?, Dad
UNION ALL SELECT 1143749747, 'whos-it-for-dad', 'Whos It for?'
-- Target Group, Brand new mom --> Who's It for?, Mum
UNION ALL SELECT 1143749549, 'whos-it-for-mum', 'Whos It for?'
-- Target Group, Brother --> Who's it for?, Brother
UNION ALL SELECT 1143742571, 'whos-it-for-brother', 'Whos it for?'
-- Target Group, Colleague --> Who's it for?, Colleague
UNION ALL SELECT 1143742085, 'colleague', 'Whos it for?'
-- Target Group, Daddy to be --> Who's It for?, Daddy To Be
UNION ALL SELECT 1143749750, 'daddy-to-be', 'Whos It for?'
-- Target Group, Daughter --> Who's It for?, Daughter
UNION ALL SELECT 1143750944, 'whos-it-for-daughter', 'Whos It for?'
-- Target Group, Employee --> Who's It for?, Colleague
UNION ALL SELECT 1143751274, 'colleague', 'Whos It for?'
-- Target Group, Father --> Who's it for?, Dad
UNION ALL SELECT 1143739704, 'whos-it-for-dad', 'Whos it for?'
-- Target Group, Father and mother --> Who's It for?, Mum and Dad
UNION ALL SELECT 1143764763, 'mum-and-dad', 'Whos It for?'
-- Target Group, Father and mother --> Who's It for?, Parents
UNION ALL SELECT 1143764763, 'parents', 'Whos It for?'
-- Target Group, Fathers --> Who's It for?, Dad
UNION ALL SELECT 1143764753, 'whos-it-for-dad', 'Whos It for?'
-- Target Group, Friend man --> Who's It for?, For Him
UNION ALL SELECT 1143750971, 'for-him', 'Whos It for?'
-- Target Group, Friend man --> Who's It for?, Friend
UNION ALL SELECT 1143750971, 'friend', 'Whos It for?'
-- Target Group, Friend woman --> Who's It for?, For Her
UNION ALL SELECT 1143750953, 'for-her', 'Whos It for?'
-- Target Group, Friend woman --> Who's It for?, Friend
UNION ALL SELECT 1143750953, 'friend', 'Whos It for?'
-- Target Group, Girl --> Who's it for?, For Girls
UNION ALL SELECT 886507052, 'for-girls', 'Whos it for?'
-- Target Group, Girl general --> Who's It for?, For Girls
UNION ALL SELECT 1143758718, 'for-girls', 'Whos It for?'
-- Target Group, Girl general --> Who's It for?, For Her
UNION ALL SELECT 1143758718, 'for-her', 'Whos It for?'
-- Target Group, Girls --> Who's It for?, For Her
UNION ALL SELECT 1143742985, 'for-her', 'Whos It for?'
-- Target Group, Godfather --> Who's It for?, Godfather
UNION ALL SELECT 1143764733, 'godfather', 'Whos It for?'
-- Target Group, Godmother --> Who's It for?, Godmother
UNION ALL SELECT 1143764728, 'godmother', 'Whos It for?'
-- Target Group, Granddaughter --> Who's It for?, Granddaughter
UNION ALL SELECT 1143759003, 'whos-it-for-granddaughter', 'Whos It for?'
-- Target Group, Grandfather --> Who's It for?, Grandad
UNION ALL SELECT 1143742565, 'whos-it-for-grandad', 'Whos It for?'
-- Target Group, Grandmother --> Who's It for?, Grandma
UNION ALL SELECT 1143742568, 'grandma', 'Whos It for?'
-- Target Group, Grandparents (Card only) --> Who's It for?, Grandparents
UNION ALL SELECT 1143729717, 'grandparents', 'Whos It for?'
-- Target Group, Grandson --> Who's It for?, Grandson
UNION ALL SELECT 1143758998, 'whos-it-for-grandson', 'Whos It for?'
-- Target Group, LHBTIQ+ --> Who's It for?, LGBTQ+
UNION ALL SELECT 1143765418, 'whos-it-for-lgbtq', 'Whos It for?'
-- Target Group, Little brother --> Who's It for?, Brother
UNION ALL SELECT 1143754571, 'whos-it-for-brother', 'Whos It for?'
-- Target Group, Little daughter --> Who's It for?, Daughter
UNION ALL SELECT 1143758823, 'whos-it-for-daughter', 'Whos It for?'
-- Target Group, Little daughter --> Who's It for?, Daughter in Law
UNION ALL SELECT 1143758823, 'daughter-in-law', 'Whos It for?'
-- Target Group, Little granddaughter --> Who's It for?, Granddaughter
UNION ALL SELECT 1143757863, 'whos-it-for-granddaughter', 'Whos It for?'
-- Target Group, Little granddaughter --> Who's It for?, Great Granddaughter
UNION ALL SELECT 1143757863, 'great-granddaughter', 'Whos It for?'
-- Target Group, Little grandson --> Who's It for?, Grandson
UNION ALL SELECT 1143757858, 'whos-it-for-grandson', 'Whos It for?'
-- Target Group, Little grandson --> Who's It for?, Great Grandson
UNION ALL SELECT 1143757858, 'great-grandson', 'Whos It for?'
-- Target Group, Little nephew --> Who's It for?, Nephew
UNION ALL SELECT 1143758803, 'whos-it-for-nephew', 'Whos It for?'
-- Target Group, Little niece --> Who's It for?, Niece
UNION ALL SELECT 1143758798, 'whos-it-for-niece', 'Whos It for?'
-- Target Group, Little sister --> Who's It for?, Sister
UNION ALL SELECT 1143754568, 'whos-it-for-sister', 'Whos It for?'
-- Target Group, Little sister --> Who's It for?, Sister In Law
UNION ALL SELECT 1143754568, 'whos-it-for-sister-in-law', 'Whos It for?'
-- Target Group, Little son --> Who's It for?, Son
UNION ALL SELECT 1143758818, 'whos-it-for-son', 'Whos It for?'
-- Target Group, Little son --> Who's It for?, Son in Law
UNION ALL SELECT 1143758818, 'son-in-law', 'Whos It for?'
-- Target Group, Men --> Who's it for?, For Him
UNION ALL SELECT 1143750956, 'for-him', 'Whos it for?'
-- Target Group, Men general --> Who's It for?, For Him
UNION ALL SELECT 1143755253, 'for-him', 'Whos It for?'
-- Target Group, Mommy to be --> Who's It for?, Mum
UNION ALL SELECT 1143749546, 'whos-it-for-mum', 'Whos It for?'
-- Target Group, Mother --> Who's It for?, Mother in Law
UNION ALL SELECT 1143739125, 'mother-in-law', 'Whos It for?'
-- Target Group, Mother --> Who's It for?, Mum
UNION ALL SELECT 1143739125, 'whos-it-for-mum', 'Whos It for?'
-- Target Group, Mothers --> Who's It for?, Mum
UNION ALL SELECT 1143764758, 'whos-it-for-mum', 'Whos It for?'
-- Target Group, Nephew --> Who's It for?, Nephew
UNION ALL SELECT 1143758208, 'whos-it-for-nephew', 'Whos It for?'
-- Target Group, Neutral --> Who's It for?, Friend
UNION ALL SELECT 1143755247, 'friend', 'Whos It for?'
-- Target Group, Neutral Adult --> Who's It for?, Friend
UNION ALL SELECT 1143766578, 'friend', 'Whos It for?'
-- Target Group, Neutral Child --> Who's It for?, For Kids
UNION ALL SELECT 1143766583, 'whos-it-for-for-kids', 'Whos It for?'
-- Target Group, Niece --> Who's It for?, Niece
UNION ALL SELECT 1143758188, 'whos-it-for-niece', 'Whos It for?'
-- Target Group, Other half man --> Who's It for?, For Him
UNION ALL SELECT 1143750968, 'for-him', 'Whos It for?'
-- Target Group, Other half woman --> Who's It for?, For Her
UNION ALL SELECT 1143750950, 'for-her', 'Whos It for?'
-- Target Group, Parents --> Who's It for?, Parents
UNION ALL SELECT 1143754622, 'parents', 'Whos It for?'
-- Target Group, Sarah --> NULL, NULL
UNION ALL SELECT 1143750962, NULL, NULL
-- Target Group, Sister --> Who's it for?, Sister
UNION ALL SELECT 1143742574, 'whos-it-for-sister', 'Whos it for?'
-- Target Group, Son --> Who's It for?, Son
UNION ALL SELECT 1143750959, 'whos-it-for-son', 'Whos It for?'
-- Target Group, Twins and Multiple (Birth) --> Who's It for?, Twins
UNION ALL SELECT 886602868, 'whos-it-for-twins', 'Whos It for?'
-- Target Group, Uncle --> Who's It for?, Uncle
UNION ALL SELECT 1143753107, 'whos-it-for-uncle', 'Whos It for?'
-- Target Group, Woman general --> Who's It for?, For Her
UNION ALL SELECT 1143755250, 'for-her', 'Whos It for?'
-- Target Group, Women --> Who's it for?, For Her
UNION ALL SELECT 1143750947, 'for-her', 'Whos it for?'
-- Target Group, Zakelijk1 (cards missions) --> Who's it For?, Other
UNION ALL SELECT 1143732725, 'newia-gift-experiences-whos-it-for-other', 'Whos it For?'
-- Theme, Abstract (cards missions) --> NULL, NULL
UNION ALL SELECT 1143754271, NULL, NULL
-- Theme, Animals (cards missions) --> Topic, Animals
UNION ALL SELECT 1143727287, 'topic-animals', 'Topic'
-- Theme, Aquarel (cards missions) --> NULL, NULL
UNION ALL SELECT 1143751220, NULL, NULL
-- Theme, Art (cards missions) --> NULL, NULL
UNION ALL SELECT 1143751229, NULL, NULL
-- Theme, Artistic (cards missions) --> Sentiment & Style, Artistic
UNION ALL SELECT 1143754265, 'artistic', 'Sentiment & Style'
-- Theme, Charities (cards missions) --> NULL, NULL
UNION ALL SELECT 1143731189, NULL, NULL
-- Theme, Cheerful and colorful (cards missions) --> NULL, NULL
UNION ALL SELECT 1143751202, NULL, NULL
-- Theme, Christelijk --> NULL, NULL
UNION ALL SELECT 1143735408, NULL, NULL
-- Theme, Cool (cards missions) --> Sentiment & Style, Rude
UNION ALL SELECT 1143751172, 'rude', 'Sentiment & Style'
-- Theme, Corona (cards missions) --> NULL, NULL
UNION ALL SELECT 1143751217, NULL, NULL
-- Theme, Fashion (cards missions) --> NULL, NULL
UNION ALL SELECT 1143751193, NULL, NULL
-- Theme, Flowers and abloom (cards missions) --> Sentiment & Style, Floral
UNION ALL SELECT 1143751184, 'sentiment-style-floral', 'Sentiment & Style'
-- Theme, Food en drinks (cards missions) --> Interests & Hobbies, Food and Drink
UNION ALL SELECT 1143751178, 'food-and-drink', 'Interests & Hobbies'
-- Theme, Games (cards missions) --> Interests & Hobbies, Gaming
UNION ALL SELECT 1143753639, 'interests-hobbies-gaming', 'Interests & Hobbies'
-- Theme, Glitter and glamour (cards missions) --> NULL, NULL
UNION ALL SELECT 1143751214, NULL, NULL
-- Theme, Horoscopes and universe (cards missions) --> NULL, NULL
UNION ALL SELECT 1143751223, NULL, NULL
-- Theme, House and garden (cards missions) --> Interests & Hobbies, Gardening
UNION ALL SELECT 1143751187, 'gardening', 'Interests & Hobbies'
-- Theme, Humor (cards missions) --> Sentiment & Style, Funny
UNION ALL SELECT 1143751232, 'sentiment-style-funny', 'Sentiment & Style'
-- Theme, Illustrations (cards missions) --> NULL, NULL
UNION ALL SELECT 1143751235, NULL, NULL
-- Theme, Landscape and air (condoleance) --> NULL, NULL
UNION ALL SELECT 1143730850, NULL, NULL
-- Theme, Minimalistic (cards missions) --> NULL, NULL
UNION ALL SELECT 1143751076, NULL, NULL
-- Theme, Music (cards missions) --> Interests & Hobbies, Music
UNION ALL SELECT 1143751244, 'interests-hobbies-music', 'Interests & Hobbies'
-- Theme, Pastel (cards missions) --> NULL, NULL
UNION ALL SELECT 1143751205, NULL, NULL
-- Theme, Patterns (cards missions) --> NULL, NULL
UNION ALL SELECT 1143751199, NULL, NULL
-- Theme, Photograpic (cards missions) --> Format Layout & Size, Photo Cover Cards
UNION ALL SELECT 1143751226, 'photo-cover-cards', 'Format Layout & Size'
-- Theme, Retro and vintage --> Sentiment & Style, Retro
UNION ALL SELECT 1143762763, 'sentiment-style-retro', 'Sentiment & Style'
-- Theme, Retro and vintage --> Sentiment & Style, Vintage
UNION ALL SELECT 1143762763, 'vintage', 'Sentiment & Style'
-- Theme, Sport (cards missions) --> Interests & Hobbies, Fitness
UNION ALL SELECT 902926598, 'fitness', 'Interests & Hobbies'
-- Theme, Summer --> NULL, NULL
UNION ALL SELECT 796202568, NULL, NULL
-- Theme, Sweet (cards missions) --> NULL, NULL
UNION ALL SELECT 1143751175, NULL, NULL
-- Theme, Text and poems (cards missions) --> NULL, NULL
UNION ALL SELECT 1143751073, NULL, NULL
-- Theme, Travel (cards missions) --> Interests & Hobbies, Travel
UNION ALL SELECT 1143751190, 'interests-hobbies-travel', 'Interests & Hobbies'
-- Theme, Tropical and jungle (cards missions) --> Interests & Hobbies, Travel
UNION ALL SELECT 1143751181, 'interests-hobbies-travel', 'Interests & Hobbies'
-- Theme, Typographic (cards missions) --> NULL, NULL
UNION ALL SELECT 1143757778, NULL, NULL
-- Theme, Vehicles (cards missions) --> Interests & Hobbies, Cars and Bikes
UNION ALL SELECT 1143751241, 'cars-and-bikes', 'Interests & Hobbies'

CREATE OR REPLACE VIEW greetz_to_mnpq_categories_cards_view AS
-- Target Group, Little niece -->Age, Kids 2-5 years old
SELECT 1143758798 AS GreetzCategoryID, 'kids-2-5-years-old' AS MPCategoryKey, 'Age' AS MPParentName
-- Target Group, Little granddaughter -->Age, Tween 9-12 years old
UNION ALL SELECT 1143757863, 'tween-9-12-years-old', 'Age'
-- Target Group, Little grandson -->Age, Baby (0-18m)
UNION ALL SELECT 1143757858, 'baby-0-1-years-old', 'Age'
-- Target Group, Little grandson -->Age, Kids 2-5 years old
UNION ALL SELECT 1143757858, 'kids-2-5-years-old', 'Age'
-- Target Group, Little grandson -->Age, Kids 6-9 years old
UNION ALL SELECT 1143757858, 'kids-6-9-years-old', 'Age'
-- Target Group, Little grandson -->Age, Tween 9-12 years old
UNION ALL SELECT 1143757858, 'tween-9-12-years-old', 'Age'
-- Age, 7 year -->Age, Kids 6-9 years old
UNION ALL SELECT 1143751115, 'kids-6-9-years-old', 'Age'
-- Target Group, Little nephew -->Age, Baby (0-18m)
UNION ALL SELECT 1143758803, 'baby-0-1-years-old', 'Age'
-- Target Group, Little nephew -->Age, Kids 2-5 years old
UNION ALL SELECT 1143758803, 'kids-2-5-years-old', 'Age'
-- Target Group, Little nephew -->Age, Kids 6-9 years old
UNION ALL SELECT 1143758803, 'kids-6-9-years-old', 'Age'
-- Age, 6 year -->Age, Kids 6-9 years old
UNION ALL SELECT 1143751112, 'kids-6-9-years-old', 'Age'
-- Target Group, Little niece -->Age, Baby (0-18m)
UNION ALL SELECT 1143758798, 'baby-0-1-years-old', 'Age'
-- Target Group, Little granddaughter -->Age, Baby (0-18m)
UNION ALL SELECT 1143757863, 'baby-0-1-years-old', 'Age'
-- Target Group, Little niece -->Age, Tween 9-12 years old
UNION ALL SELECT 1143758798, 'tween-9-12-years-old', 'Age'
-- Target Group, Little sister -->Age, Baby (0-18m)
UNION ALL SELECT 1143754568, 'baby-0-1-years-old', 'Age'
-- Target Group, Little sister -->Age, Kids 2-5 years old
UNION ALL SELECT 1143754568, 'kids-2-5-years-old', 'Age'
-- Target Group, Little sister -->Age, Kids 6-9 years old
UNION ALL SELECT 1143754568, 'kids-6-9-years-old', 'Age'
-- Target Group, Little sister -->Age, Tween 9-12 years old
UNION ALL SELECT 1143754568, 'tween-9-12-years-old', 'Age'
-- Target Group, Little son -->Age, Baby (0-18m)
UNION ALL SELECT 1143758818, 'baby-0-1-years-old', 'Age'
-- Target Group, Little son -->Age, Kids 2-5 years old
UNION ALL SELECT 1143758818, 'kids-2-5-years-old', 'Age'
-- Target Group, Little son -->Age, Kids 6-9 years old
UNION ALL SELECT 1143758818, 'kids-6-9-years-old', 'Age'
-- Target Group, Little son -->Age, Tween 9-12 years old
UNION ALL SELECT 1143758818, 'tween-9-12-years-old', 'Age'
-- Target Group, Little nephew -->Age, Tween 9-12 years old
UNION ALL SELECT 1143758803, 'tween-9-12-years-old', 'Age'
-- Age, 8 year -->Age, Kids 6-9 years old
UNION ALL SELECT 1143751118, 'kids-6-9-years-old', 'Age'
-- Age, 1 year -->Age, Baby (0-18m)
UNION ALL SELECT 1143751079, 'baby-0-1-years-old', 'Age'
-- Age, Toddler (cards missions only) -->Age, Kids 2-5 years old
UNION ALL SELECT 1143751250, 'kids-2-5-years-old', 'Age'
-- Age, Teenager (cards missions only) -->Age, Teen 13-17 years old
UNION ALL SELECT 1143751256, 'teen-13-17-years-old', 'Age'
-- Age, Senior (cards missions only) -->Age, Senior (over 65)
UNION ALL SELECT 1143751268, 'senior-over-65-years-old', 'Age'
-- Age, Child (cards missions only) -->Age, Kids 6-9 years old
UNION ALL SELECT 1143751253, 'kids-6-9-years-old', 'Age'
-- Age, Baby (cards missions only) -->Age, Baby (0-18m)
UNION ALL SELECT 1143751247, 'baby-0-1-years-old', 'Age'
-- Age, Adult (cards missions only) -->Age, Adult 25-64 years old
UNION ALL SELECT 1143751262, 'adult-25-64-years-old', 'Age'
-- Age, 65 year -->Age, Senior (over 65)
UNION ALL SELECT 1143774016, 'senior-over-65-years-old', 'Age'
-- Age, 90 year -->Age, Senior (over 65)
UNION ALL SELECT 1143751154, 'senior-over-65-years-old', 'Age'
-- Target Group, Little granddaughter -->Age, Kids 6-9 years old
UNION ALL SELECT 1143757863, 'kids-6-9-years-old', 'Age'
-- Age, 80 year -->Age, Senior (over 65)
UNION ALL SELECT 1143751157, 'senior-over-65-years-old', 'Age'
-- Target Group, Little granddaughter -->Age, Kids 2-5 years old
UNION ALL SELECT 1143757863, 'kids-2-5-years-old', 'Age'
-- Target Group, Little brother -->Age, Baby (0-18m)
UNION ALL SELECT 1143754571, 'baby-0-1-years-old', 'Age'
-- Target Group, Little brother -->Age, Kids 2-5 years old
UNION ALL SELECT 1143754571, 'kids-2-5-years-old', 'Age'
-- Target Group, Little brother -->Age, Kids 6-9 years old
UNION ALL SELECT 1143754571, 'kids-6-9-years-old', 'Age'
-- Target Group, Little brother -->Age, Tween 9-12 years old
UNION ALL SELECT 1143754571, 'tween-9-12-years-old', 'Age'
-- Target Group, Little daughter -->Age, Baby (0-18m)
UNION ALL SELECT 1143758823, 'baby-0-1-years-old', 'Age'
-- Target Group, Little daughter -->Age, Kids 2-5 years old
UNION ALL SELECT 1143758823, 'kids-2-5-years-old', 'Age'
-- Target Group, Little daughter -->Age, Kids 6-9 years old
UNION ALL SELECT 1143758823, 'kids-6-9-years-old', 'Age'
-- Target Group, Little daughter -->Age, Tween 9-12 years old
UNION ALL SELECT 1143758823, 'tween-9-12-years-old', 'Age'
-- Age, 70 year -->Age, Senior (over 65)
UNION ALL SELECT 1143751160, 'senior-over-65-years-old', 'Age'
-- Age, 60 year -->Age, Adult 25-64 years old
UNION ALL SELECT 1143751148, 'adult-25-64-years-old', 'Age'
-- Age, 9 year -->Age, Kids 6-9 years old
UNION ALL SELECT 1143751121, 'kids-6-9-years-old', 'Age'
-- Target Group, Men -->Age, Adult 25 64 years old
UNION ALL SELECT 1143750956, 'adult-25-64-years-old', 'Age'
-- Age, 18 year -->Age, Young Adult 18-24 years old
UNION ALL SELECT 1143751145, 'young-adult-18-24-years-old', 'Age'
-- Age, 16 year -->Age, Teen 13-17 years old
UNION ALL SELECT 1143751142, 'teen-13-17-years-old', 'Age'
-- Age, 25 year -->Age, Adult 25-64 years old
UNION ALL SELECT 1143751211, 'adult-25-64-years-old', 'Age'
-- Target Group, Little niece -->Age, Kids 6-9 years old
UNION ALL SELECT 1143758798, 'kids-6-9-years-old', 'Age'
-- Age, 21 year -->Age, Young Adult 18-24 years old
UNION ALL SELECT 1143751208, 'young-adult-18-24-years-old', 'Age'
-- Age, 10 year -->Age, Tween 9-12 years old
UNION ALL SELECT 1143751124, 'tween-9-12-years-old', 'Age'
-- Age, 13 year -->Age, Teen 13-17 years old
UNION ALL SELECT 1143751133, 'teen-13-17-years-old', 'Age'
-- Age, 11 year -->Age, Tween 9-12 years old
UNION ALL SELECT 1143751127, 'tween-9-12-years-old', 'Age'
-- Age, 2 year -->Age, Kids 2-5 years old
UNION ALL SELECT 1143751082, 'kids-2-5-years-old', 'Age'
-- Age, 100 year -->Age, Senior (over 65)
UNION ALL SELECT 1143751151, 'senior-over-65-years-old', 'Age'
-- Age, 19 year -->Age, Young Adult 18-24 years old
UNION ALL SELECT 1143751259, 'young-adult-18-24-years-old', 'Age'
-- Age, 18 year -->Age, 18th Birthday
UNION ALL SELECT 1143751145, '18th-birthday', 'Age'
-- Target Group, Women -->Age, Adult 25 64 years old
UNION ALL SELECT 1143750947, 'adult-25-64-years-old', 'Age'
-- Target Group, Women -->Age, Senior over 65 years old
UNION ALL SELECT 1143750947, 'senior-over-65-years-old', 'Age'
-- Age, 17 year -->Age, Teen 13-17 years old
UNION ALL SELECT 1143758133, 'teen-13-17-years-old', 'Age'
-- Age, 40 year -->Age, Adult 25-64 years old
UNION ALL SELECT 1143751166, 'adult-25-64-years-old', 'Age'
-- Target Group, Men -->Age, Senior over 65 years old
UNION ALL SELECT 1143750956, 'senior-over-65-years-old', 'Age'
-- Age, 50 year -->Age, Adult 25-64 years old
UNION ALL SELECT 1143751163, 'adult-25-64-years-old', 'Age'
-- Age, 5 year -->Age, Kids 2-5 years old
UNION ALL SELECT 1143751109, 'kids-2-5-years-old', 'Age'
-- Age, 3 year -->Age, Kids 2-5 years old
UNION ALL SELECT 1143751103, 'kids-2-5-years-old', 'Age'
-- Age, 14 year -->Age, Teen 13-17 years old
UNION ALL SELECT 1143751136, 'teen-13-17-years-old', 'Age'
-- Age, 20 year -->Age, Young Adult 18-24 years old
UNION ALL SELECT 1143751265, 'young-adult-18-24-years-old', 'Age'
-- Age, 12 year -->Age, Tween 9-12 years old
UNION ALL SELECT 1143751130, 'tween-9-12-years-old', 'Age'
-- Age, 4 year -->Age, Kids 2-5 years old
UNION ALL SELECT 1143751106, 'kids-2-5-years-old', 'Age'
-- Age, 15 year -->Age, Teen 13-17 years old
UNION ALL SELECT 1143751139, 'teen-13-17-years-old', 'Age'
-- Age, 30 year -->Age, Adult 25-64 years old
UNION ALL SELECT 1143751169, 'adult-25-64-years-old', 'Age'
-- Target Group, Animal mom -->Animals, Pet
UNION ALL SELECT 1143749729, 'animals-pet', 'Animals'
-- Target Group, Animal dad -->Animals, Pet
UNION ALL SELECT 1143749732, 'animals-pet', 'Animals'
-- Age, 11 year -->Birthday Milestones, 11th Birthday
UNION ALL SELECT 1143751127, '11th-birthday', 'Birthday Milestones'
-- Age, 12 year -->Birthday Milestones, 12th Birthday
UNION ALL SELECT 1143751130, '12th-birthday', 'Birthday Milestones'
-- Age, 90 year -->Birthday Milestones, 90th Birthday
UNION ALL SELECT 1143751154, '90th-birthday', 'Birthday Milestones'
-- Age, 100 year -->Birthday Milestones, 100th Birthday
UNION ALL SELECT 1143751151, '100th-birthday', 'Birthday Milestones'
-- Age, 10 year -->Birthday Milestones, 10th Birthday
UNION ALL SELECT 1143751124, '10th-birthday', 'Birthday Milestones'
-- Occasion, 16 years -->Birthday Milestones, 16th Birthday
UNION ALL SELECT 1143736074, '16th-birthday', 'Birthday Milestones'
-- Occasion, 21 years -->Birthday Milestones, 21st Birthday
UNION ALL SELECT 1143746028, '21st-birthday', 'Birthday Milestones'
-- Age, 1 year -->Birthday Milestones, 1st Birthday
UNION ALL SELECT 1143751079, '1st-birthday', 'Birthday Milestones'
-- Occasion, 30 years -->Birthday Milestones, 30th Birthday
UNION ALL SELECT 1143736051, '30th-birthday', 'Birthday Milestones'
-- Occasion, 50 years -->Birthday Milestones, 50th Birthday
UNION ALL SELECT 1143736054, '50th-birthday', 'Birthday Milestones'
-- Occasion, 60 years -->Birthday Milestones, 60th Birthday
UNION ALL SELECT 1143736063, '60th-birthday', 'Birthday Milestones'
-- Occasion, 70 years -->Birthday Milestones, 70th Birthday
UNION ALL SELECT 1143736066, '70th-birthday', 'Birthday Milestones'
-- Occasion, 80 years -->Birthday Milestones, 80th Birthday
UNION ALL SELECT 1143736060, '80th-birthday', 'Birthday Milestones'
-- Occasion, First childrensbirthday -->Birthday Milestones, 1st Birthday
UNION ALL SELECT 1143736077, '1st-birthday', 'Birthday Milestones'
-- Target Group, Abraham -->Birthday Milestones, 50th Birthday
UNION ALL SELECT 1143750965, '50th-birthday', 'Birthday Milestones'
-- Target Group, Abraham -->Birthday Milestones, For Him
UNION ALL SELECT 1143750965, 'for-him', 'Birthday Milestones'
-- Occasion, 18 years -->Birthday Milestones, 18th Birthday
UNION ALL SELECT 1143736069, '18th-birthday', 'Birthday Milestones'
-- Age, 20 year -->Birthday Milestones, 20th Birthday
UNION ALL SELECT 1143751265, '20th-birthday', 'Birthday Milestones'
-- Age, 50 year -->Birthday Milestones, 50th Birthday
UNION ALL SELECT 1143751163, '50th-birthday', 'Birthday Milestones'
-- Age, 5 year -->Birthday Milestones, 5th Birthday
UNION ALL SELECT 1143751109, '5th-birthday', 'Birthday Milestones'
-- Age, 6 year -->Birthday Milestones, 6th Birthday
UNION ALL SELECT 1143751112, '6th-birthday', 'Birthday Milestones'
-- Age, 40 year -->Birthday Milestones, 40th Birthday
UNION ALL SELECT 1143751166, '40th-birthday', 'Birthday Milestones'
-- Age, 4 year -->Birthday Milestones, 4th Birthday
UNION ALL SELECT 1143751106, '4th-birthday', 'Birthday Milestones'
-- Occasion, 40 years -->Birthday Milestones, 40th Birthday
UNION ALL SELECT 1143736048, '40th-birthday', 'Birthday Milestones'
-- Age, 30 year -->Birthday Milestones, 30th Birthday
UNION ALL SELECT 1143751169, '30th-birthday', 'Birthday Milestones'
-- Age, 60 year -->Birthday Milestones, 60th Birthday
UNION ALL SELECT 1143751148, '60th-birthday', 'Birthday Milestones'
-- Age, 3 year -->Birthday Milestones, 3rd Birthday
UNION ALL SELECT 1143751103, '3rd-birthday', 'Birthday Milestones'
-- Age, 16 year -->Birthday Milestones, 16th Birthday
UNION ALL SELECT 1143751142, '16th-birthday', 'Birthday Milestones'
-- Age, 21 year -->Birthday Milestones, 21st Birthday
UNION ALL SELECT 1143751208, '21st-birthday', 'Birthday Milestones'
-- Age, 9 year -->Birthday Milestones, 9th Birthday
UNION ALL SELECT 1143751121, '9th-birthday', 'Birthday Milestones'
-- Age, 2 year -->Birthday Milestones, 2nd Birthday
UNION ALL SELECT 1143751082, '2nd-birthday', 'Birthday Milestones'
-- Age, 7 year -->Birthday Milestones, 7th Birthday
UNION ALL SELECT 1143751115, '7th-birthday', 'Birthday Milestones'
-- Age, 19 year -->Birthday Milestones, 19th Birthday
UNION ALL SELECT 1143751259, '19th-birthday', 'Birthday Milestones'
-- Age, 17 year -->Birthday Milestones, 17th Birthday
UNION ALL SELECT 1143758133, '17th-birthday', 'Birthday Milestones'
-- Age, 70 year -->Birthday Milestones, 70th Birthday
UNION ALL SELECT 1143751160, '70th-birthday', 'Birthday Milestones'
-- Age, 15 year -->Birthday Milestones, 15th Birthday
UNION ALL SELECT 1143751139, '15th-birthday', 'Birthday Milestones'
-- Age, 14 year -->Birthday Milestones, 14th Birthday
UNION ALL SELECT 1143751136, '14th-birthday', 'Birthday Milestones'
-- Age, 8 year -->Birthday Milestones, 8th Birthday
UNION ALL SELECT 1143751118, '8th-birthday', 'Birthday Milestones'
-- Age, 80 year -->Birthday Milestones, 80th Birthday
UNION ALL SELECT 1143751157, '80th-birthday', 'Birthday Milestones'
-- Age, 13 year -->Birthday Milestones, 13th Birthday
UNION ALL SELECT 1143751133, '13th-birthday', 'Birthday Milestones'
-- Age, 25 year -->Birthday Milestones, 25th Birthday
UNION ALL SELECT 1143751211, '25th-birthday', 'Birthday Milestones'
-- Target Group, Sarah -->Birthday Milestones, 50th Birthday
UNION ALL SELECT 1143750962, '50th-birthday', 'Birthday Milestones'
-- Occasion, 25 years -->Birthday Milestones, 25th Birthday
UNION ALL SELECT 1143746031, '25th-birthday', 'Birthday Milestones'
-- Brand/Designer, Paperclip Valentijn -->Brands, Paperclip
UNION ALL SELECT 1143735314, 'paperclip', 'Brands'
-- Brand/Designer, Photoflash -->Brands, Photoflash
UNION ALL SELECT 1143767153, 'photoflash', 'Brands'
-- Brand/Designer, Petit Konijn -->Brands, Petit Konijn
UNION ALL SELECT 1143759203, 'petit-konijn', 'Brands'
-- Brand/Designer, Pearl Ivy -->Brands, Pearl Ivy
UNION ALL SELECT 1143763553, 'pearl-ivy', 'Brands'
-- Brand/Designer, Pawsome cats -->Brands, Greetz
UNION ALL SELECT 1143754959, 'greetz', 'Brands'
-- Brand/Designer, Pastel dreams -->Brands, Greetz
UNION ALL SELECT 1143750497, 'greetz', 'Brands'
-- Brand/Designer, Showtime -->Brands, Greetz
UNION ALL SELECT 1143766643, 'greetz', 'Brands'
-- Brand/Designer, Paperclip vintage vibes -->Brands, Paperclip
UNION ALL SELECT 1143746375, 'paperclip', 'Brands'
-- Brand/Designer, Pinch of Salt -->Brands, Greetz
UNION ALL SELECT 1143766858, 'greetz', 'Brands'
-- Brand/Designer, Paperclip Tralala -->Brands, Paperclip
UNION ALL SELECT 1143747163, 'paperclip', 'Brands'
-- Brand/Designer, Paperclip together -->Brands, Paperclip
UNION ALL SELECT 1143746378, 'paperclip', 'Brands'
-- Brand/Designer, Paperclip The Zoo -->Brands, Paperclip
UNION ALL SELECT 1143735763, 'paperclip', 'Brands'
-- Brand/Designer, Paperclip Sports -->Brands, Paperclip
UNION ALL SELECT 1143734768, 'paperclip', 'Brands'
-- Brand/Designer, Paperclip Sooo Happy -->Brands, Paperclip
UNION ALL SELECT 1143749627, 'paperclip', 'Brands'
-- Brand/Designer, Paperclip PopCard -->Brands, Paperclip
UNION ALL SELECT 1143734771, 'paperclip', 'Brands'
-- Brand/Designer, Paperlink -->Brands, Paperlink
UNION ALL SELECT 1143762638, 'paperlink', 'Brands'
-- Brand/Designer, Quitting Hollywood -->Brands, Quitting Hollywood
UNION ALL SELECT 1143763558, 'quitting-hollywood', 'Brands'
-- Brand/Designer, Say cheese -->Brands, Greetz
UNION ALL SELECT 1143772703, 'greetz', 'Brands'
-- Brand/Designer, Say It Out Loud -->Brands, Greetz
UNION ALL SELECT 1143752540, 'greetz', 'Brands'
-- Brand/Designer, Sadler Jones -->Brands, Sadler Jones
UNION ALL SELECT 1143762628, 'sadler-jones', 'Brands'
-- Brand/Designer, Rumble Cards -->Brands, Rumble Cards
UNION ALL SELECT 1143762223, 'rumble-cards', 'Brands'
-- Brand/Designer, Revelation halftone -->Brands, Greetz
UNION ALL SELECT 1143750503, 'greetz', 'Brands'
-- Brand/Designer, Picture Perfect -->Brands, Greetz
UNION ALL SELECT 1143734930, 'greetz', 'Brands'
-- Brand/Designer, Rainbows and stars -->Brands, Greetz
UNION ALL SELECT 1143750500, 'greetz', 'Brands'
-- Brand/Designer, Pigment -->Brands, Pigment
UNION ALL SELECT 1143764313, 'pigment', 'Brands'
-- Brand/Designer, Positivitea -->Brands, Greetz
UNION ALL SELECT 1143752543, 'greetz', 'Brands'
-- Brand/Designer, Portraits -->Brands, Greetz
UNION ALL SELECT 1143760863, 'greetz', 'Brands'
-- Brand/Designer, Poppy Field -->Brands, Greetz
UNION ALL SELECT 1143766873, 'greetz', 'Brands'
-- Brand/Designer, Poet and Painter -->Brands, Poet and Painter
UNION ALL SELECT 1143762918, 'poet-and-painter', 'Brands'
-- Brand/Designer, Playful Indian -->Brands, Playful Indian
UNION ALL SELECT 1143768903, 'playful-indian', 'Brands'
-- Brand/Designer, Pixel Perfect -->Brands, Greetz
UNION ALL SELECT 1143764063, 'greetz', 'Brands'
-- Brand/Designer, Redback Cards Limited -->Brands, Redback Cards Limited
UNION ALL SELECT 1143763568, 'redback-cards-limited', 'Brands'
-- Brand/Designer, Noelle Smit -->Brands, Noëlle Smit
UNION ALL SELECT 1143766473, 'noelle-smit', 'Brands'
-- Brand/Designer, Papagrazi -->Brands, Papagrazi
UNION ALL SELECT 1143762108, 'papagrazi', 'Brands'
-- Brand/Designer, Our stories -->Brands, Greetz
UNION ALL SELECT 1143772783, 'greetz', 'Brands'
-- Brand/Designer, Only kind words -->Brands, Greetz
UNION ALL SELECT 1143773476, 'greetz', 'Brands'
-- Brand/Designer, Old Timer -->Brands, Greetz
UNION ALL SELECT 1143766853, 'greetz', 'Brands'
-- Brand/Designer, Old Dutch -->Brands, Old Dutch
UNION ALL SELECT 1143730689, 'old-dutch', 'Brands'
-- Brand/Designer, Paperclip Photography -->Brands, Paperclip
UNION ALL SELECT 1143749630, 'paperclip', 'Brands'
-- Brand/Designer, Oh happy days -->Brands, Greetz
UNION ALL SELECT 1143750494, 'greetz', 'Brands'
-- Brand/Designer, Paperclip Business (Christmas) -->Brands, Paperclip
UNION ALL SELECT 1143734972, 'paperclip', 'Brands'
-- Brand/Designer, New Kids -->Brands, Greetz
UNION ALL SELECT 1143766833, 'greetz', 'Brands'
-- Brand/Designer, Neil Clark Design -->Brands, Neil Clark Design
UNION ALL SELECT 1143762258, 'neil-clark-design', 'Brands'
-- Brand/Designer, Natural shapes -->Brands, Greetz
UNION ALL SELECT 1143746668, 'greetz', 'Brands'
-- Brand/Designer, Natalie Alex -->Brands, Natalie Alex
UNION ALL SELECT 1143761428, 'brands-natalie-alex', 'Brands'
-- Brand/Designer, Modern sparkle -->Brands, Greetz
UNION ALL SELECT 1143750491, 'greetz', 'Brands'
-- Brand/Designer, Millicent Venton -->Brands, Millicent Venton
UNION ALL SELECT 1143761433, 'millicent-venton', 'Brands'
-- Brand/Designer, Okey Dokey Design -->Brands, Okey Dokey Design
UNION ALL SELECT 1143762608, 'okey-dokey-design', 'Brands'
-- Brand/Designer, Paperclip Indie -->Brands, Paperclip
UNION ALL SELECT 1143744984, 'paperclip', 'Brands'
-- Brand/Designer, Spring Fling -->Brands, Greetz
UNION ALL SELECT 1143767688, 'greetz', 'Brands'
-- Brand/Designer, Paperclip Partybus -->Brands, Paperclip
UNION ALL SELECT 1143735369, 'paperclip', 'Brands'
-- Brand/Designer, Paperclip on the dot -->Brands, Paperclip
UNION ALL SELECT 1143746372, 'paperclip', 'Brands'
-- Brand/Designer, Paperclip OMG -->Brands, Paperclip
UNION ALL SELECT 1143741454, 'paperclip', 'Brands'
-- Brand/Designer, Paperclip Mingface -->Brands, Paperclip
UNION ALL SELECT 1143734774, 'paperclip', 'Brands'
-- Brand/Designer, Paperclip Lifetimes -->Brands, Paperclip
UNION ALL SELECT 1143735158, 'paperclip', 'Brands'
-- Brand/Designer, Paper Trails -->Brands, Greetz
UNION ALL SELECT 1143763748, 'greetz', 'Brands'
-- Brand/Designer, Paperclip Kerst (Christmas) -->Brands, Paperclip
UNION ALL SELECT 1143735185, 'paperclip', 'Brands'
-- Brand/Designer, Paperclip 1974 -->Brands, Paperclip
UNION ALL SELECT 1143750349, 'paperclip', 'Brands'
-- Brand/Designer, Paperclip Highline -->Brands, Paperclip
UNION ALL SELECT 1143735167, 'paperclip', 'Brands'
-- Brand/Designer, Paperclip heart and soul -->Brands, Paperclip
UNION ALL SELECT 1143747251, 'paperclip', 'Brands'
-- Brand/Designer, Paperclip Focus -->Brands, Paperclip
UNION ALL SELECT 1143735363, 'paperclip', 'Brands'
-- Brand/Designer, Paperclip Communion -->Brands, Paperclip
UNION ALL SELECT 1143735751, 'paperclip', 'Brands'
-- Brand/Designer, Paperclip collections -->Brands, Paperclip
UNION ALL SELECT 1143750446, 'paperclip', 'Brands'
-- Brand/Designer, Paperclip Petit Doodle -->Brands, Paperclip
UNION ALL SELECT 1143745020, 'paperclip', 'Brands'
-- Brand/Designer, Paperclip Levels -->Brands, Paperclip
UNION ALL SELECT 1143750352, 'paperclip', 'Brands'
-- Brand/Designer, Your Typical Chaos -->Brands, Greetz
UNION ALL SELECT 1143763763, 'greetz', 'Brands'
-- Brand/Designer, Cheers to you -->Brands, Greetz
UNION ALL SELECT 1143773741, 'greetz', 'Brands'
-- Brand/Designer, Magic Monday -->Brands, Greetz
UNION ALL SELECT 1143773736, 'greetz', 'Brands'
-- Brand/Designer, Fiesta -->Brands, Greetz
UNION ALL SELECT 1143773731, 'greetz', 'Brands'
-- Brand/Designer, Let’s go crazy -->Brands, Greetz
UNION ALL SELECT 1143773726, 'greetz', 'Brands'
-- Brand/Designer, Sweet and Salty -->Brands, Greetz
UNION ALL SELECT 1143773721, 'greetz', 'Brands'
-- Brand/Designer, Twinkle little star -->Brands, Greetz
UNION ALL SELECT 1143750518, 'greetz', 'Brands'
-- Brand/Designer, You're my type -->Brands, Greetz
UNION ALL SELECT 1143750521, 'greetz', 'Brands'
-- Brand/Designer, Ooh Lala -->Brands, Greetz
UNION ALL SELECT 1143773756, 'greetz', 'Brands'
-- Brand/Designer, YH Tekent -->Brands, YH Tekent
UNION ALL SELECT 1143767708, 'yh-tekent', 'Brands'
-- Brand/Designer, Woezel en Pip -->Brands, Woezel en Pip
UNION ALL SELECT 726305507, 'woezel-en-pip', 'Brands'
-- Brand/Designer, Wildfire -->Brands, Greetz
UNION ALL SELECT 1143760443, 'greetz', 'Brands'
-- Brand/Designer, Whambam -->Brands, Greetz
UNION ALL SELECT 1143766418, 'greetz', 'Brands'
-- Brand/Designer, Vrolijke vriendjes -->Brands, Greetz
UNION ALL SELECT 1143754418, 'greetz', 'Brands'
-- Brand/Designer, Sketchy Characters -->Brands, Greetz
UNION ALL SELECT 1143753783, 'greetz', 'Brands'
-- Brand/Designer, Later Alligator -->Brands, Greetz
UNION ALL SELECT 1143773716, 'greetz', 'Brands'
-- Brand/Designer, Fresh Start -->Brands, Greetz
UNION ALL SELECT 1143773786, 'greetz', 'Brands'
-- Brand/Designer, Sweet Lollipop -->Brands, Greetz
UNION ALL SELECT 1143773826, 'greetz', 'Brands'
-- Brand/Designer, Size matters -->Brands, Greetz
UNION ALL SELECT 1143773821, 'greetz', 'Brands'
-- Brand/Designer, Cherry on top -->Brands, Greetz
UNION ALL SELECT 1143773816, 'greetz', 'Brands'
-- Brand/Designer, Sweet sunrise -->Brands, Greetz
UNION ALL SELECT 1143773811, 'greetz', 'Brands'
-- Brand/Designer, Dance it out -->Brands, Greetz
UNION ALL SELECT 1143773806, 'greetz', 'Brands'
-- Brand/Designer, The Good gets Better -->Brands, Greetz
UNION ALL SELECT 1143773801, 'greetz', 'Brands'
-- Brand/Designer, Funky Vibes -->Brands, Greetz
UNION ALL SELECT 1143773746, 'greetz', 'Brands'
-- Brand/Designer, Self Love Club -->Brands, Greetz
UNION ALL SELECT 1143773791, 'greetz', 'Brands'
-- Brand/Designer, Hello Gorgeous -->Brands, Greetz
UNION ALL SELECT 1143773751, 'greetz', 'Brands'
-- Brand/Designer, Rain and Sunshine -->Brands, Greetz
UNION ALL SELECT 1143773781, 'greetz', 'Brands'
-- Brand/Designer, Tequila -->Brands, Greetz
UNION ALL SELECT 1143773776, 'greetz', 'Brands'
-- Brand/Designer, Dreams come true -->Brands, Greetz
UNION ALL SELECT 1143773771, 'greetz', 'Brands'
-- Brand/Designer, You’ve Got This -->Brands, Greetz
UNION ALL SELECT 1143773766, 'greetz', 'Brands'
-- Brand/Designer, Unconditional Fun -->Brands, Greetz
UNION ALL SELECT 1143773761, 'greetz', 'Brands'
-- Brand/Designer, Tsjip -->Brands, Tsjip
UNION ALL SELECT 726311596, 'tsjip', 'Brands'
-- Brand/Designer, Embrace the Magic -->Brands, Greetz
UNION ALL SELECT 1143773796, 'greetz', 'Brands'
-- Brand/Designer, Storylines -->Brands, Greetz
UNION ALL SELECT 1143766648, 'greetz', 'Brands'
-- Brand/Designer, Sweet Little Note -->Brands, Greetz
UNION ALL SELECT 1143764068, 'greetz', 'Brands'
-- Brand/Designer, Sunny side up -->Brands, Greetz
UNION ALL SELECT 1143772788, 'greetz', 'Brands'
-- Brand/Designer, Summer romance -->Brands, Greetz
UNION ALL SELECT 1143750509, 'greetz', 'Brands'
-- Brand/Designer, Summer nights -->Brands, Greetz
UNION ALL SELECT 1143750506, 'greetz', 'Brands'
-- Brand/Designer, Studio Sundae -->Brands, Studio Sundae
UNION ALL SELECT 1143762618, 'studio-sundae', 'Brands'
-- Brand/Designer, UK Greetings -->Brands, UK Greetings
UNION ALL SELECT 1143746594, 'uk-greetings', 'Brands'
-- Brand/Designer, Studio Pets -->Brands, Studio Pets
UNION ALL SELECT 737301625, 'studio-pets', 'Brands'
-- Brand/Designer, Tante Kaartje -->Brands, Tante Kaartje
UNION ALL SELECT 1143767278, 'tante-kaartje', 'Brands'
-- Brand/Designer, Stella Isaac Illustrations -->Brands, Stella Isaac Illustrations
UNION ALL SELECT 1143763108, 'stella-isaac-illustrations', 'Brands'
-- Brand/Designer, Stardust -->Brands, Greetz
UNION ALL SELECT 1143772693, 'greetz', 'Brands'
-- Brand/Designer, Stay wild -->Brands, Greetz
UNION ALL SELECT 1143760708, 'greetz', 'Brands'
-- Brand/Designer, Speak out -->Brands, Greetz
UNION ALL SELECT 1143772683, 'greetz', 'Brands'
-- Brand/Designer, Michelle Dujardin -->Brands, Michelle Dujardin
UNION ALL SELECT 1143742493, 'michelle-dujardin', 'Brands'
-- Brand/Designer, Sooshichacha Limited -->Brands, Sooshichacha Limited
UNION ALL SELECT 1143764253, 'sooshichacha-limited', 'Brands'
-- Brand/Designer, Studio Pets -->Brands, Studio Pets
UNION ALL SELECT 737301625, 'studio-pets', 'Brands'
-- Brand/Designer, The Studio of Mr en Mrs Downing -->Brands, The Studio of Mr & Mrs Downing
UNION ALL SELECT 1143762653, 'the-studio-of-mr-mrs-downing', 'Brands'
-- Brand/Designer, TMS Splash Colour -->Brands, TMS
UNION ALL SELECT 1143735736, 'tms', 'Brands'
-- Brand/Designer, TMS Mylo and Twinny -->Brands, TMS
UNION ALL SELECT 1143732443, 'tms', 'Brands'
-- Brand/Designer, TMS Monsters -->Brands, TMS
UNION ALL SELECT 1143734765, 'tms', 'Brands'
-- Brand/Designer, TMS Humour -->Brands, TMS
UNION ALL SELECT 1143734954, 'tms', 'Brands'
-- Brand/Designer, TMS Confetti -->Brands, TMS
UNION ALL SELECT 1143735739, 'tms', 'Brands'
-- Brand/Designer, TMS Close Up -->Brands, TMS
UNION ALL SELECT 1143736653, 'tms', 'Brands'
-- Brand/Designer, Sweetheart hero -->Brands, Greetz
UNION ALL SELECT 1143750512, 'greetz', 'Brands'
-- Brand/Designer, Tillovision Ltd -->Brands, Tillovision Ltd
UNION ALL SELECT 1143762263, 'tillovision-ltd', 'Brands'
-- Brand/Designer, Takkenfeest -->Brands, Greetz
UNION ALL SELECT 1143750515, 'greetz', 'Brands'
-- Brand/Designer, The power of flower -->Brands, Greetz
UNION ALL SELECT 1143755115, 'greetz', 'Brands'
-- Brand/Designer, The London Studio -->Brands, The London Studio
UNION ALL SELECT 1143762648, 'the-london-studio', 'Brands'
-- Brand/Designer, The dogs doo dahs -->Brands, The dogs doo-dahs
UNION ALL SELECT 1143763583, 'the-dogs-doodahs', 'Brands'
-- Brand/Designer, The Cardy Club -->Brands, The Cardy Club
UNION ALL SELECT 1143762658, 'the-cardy-club', 'Brands'
-- Brand/Designer, That doesn't bug me -->Brands, Greetz
UNION ALL SELECT 1143760853, 'greetz', 'Brands'
-- Brand/Designer, Under my Umbrella -->Brands, Greetz
UNION ALL SELECT 1143773831, 'greetz', 'Brands'
-- Brand/Designer, TMS -->Brands, TMS
UNION ALL SELECT 726316940, 'tms', 'Brands'
-- Brand/Designer, Deckled edge -->Brands, Deckled edge
UNION ALL SELECT 1143762953, 'deckled-edge', 'Brands'
-- Brand/Designer, Dream with me -->Brands, Greetz
UNION ALL SELECT 1143773471, 'greetz', 'Brands'
-- Brand/Designer, Dotty Black -->Brands, Dotty Black
UNION ALL SELECT 1143762113, 'dotty-black', 'Brands'
-- Brand/Designer, Doodles by Ini -->Brands, Doodles by Ini
UNION ALL SELECT 1143763253, 'doodles-by-ini', 'Brands'
-- Brand/Designer, Doodles -->Brands, Doodles
UNION ALL SELECT 726317874, 'doodles', 'Brands'
-- Brand/Designer, Dinky Rouge -->Brands, Dinky Rouge
UNION ALL SELECT 1143770028, 'dinky-rouge', 'Brands'
-- Brand/Designer, Colorful Sportsman -->Brands, Greetz
UNION ALL SELECT 1143766223, 'greetz', 'Brands'
-- Brand/Designer, Desert wind -->Brands, Greetz
UNION ALL SELECT 1143772778, 'greetz', 'Brands'
-- Brand/Designer, Fabriekshuys Tekenstudio -->Brands, Fabriekshuys
UNION ALL SELECT 1143771363, 'fabriekshuys', 'Brands'
-- Brand/Designer, Dean Morris -->Brands, Dean Morris
UNION ALL SELECT 1143762698, 'brands-dean-morris', 'Brands'
-- Brand/Designer, Dami Draws -->Brands, Greetz
UNION ALL SELECT 1143750458, 'greetz', 'Brands'
-- Brand/Designer, Dalia Clark Design -->Brands, Dalia Clark Design
UNION ALL SELECT 1143762103, 'dalia-clark-design', 'Brands'
-- Brand/Designer, Cut it out -->Brands, Greetz
UNION ALL SELECT 1143760858, 'greetz', 'Brands'
-- Brand/Designer, Corrin Strain -->Brands, Corrin Strain
UNION ALL SELECT 1143762938, 'brands-corrin-strain', 'Brands'
-- Brand/Designer, MILA -->Brands, MILA
UNION ALL SELECT 1143773248, 'mila', 'Brands'
-- Brand/Designer, Dikkie Dik -->Brands, Dikkie Dik
UNION ALL SELECT 1143730011, 'dikkie-dik', 'Brands'
-- Brand/Designer, Funny Side Up -->Brands, Funny Side Up
UNION ALL SELECT 1143764423, 'funny-side-up', 'Brands'
-- Brand/Designer, Happy Letters -->Brands, Greetz
UNION ALL SELECT 1143767658, 'greetz', 'Brands'
-- Brand/Designer, Happy Jackson -->Brands, Happy Jackson
UNION ALL SELECT 1143762643, 'happy-jackson', 'Brands'
-- Brand/Designer, Happy dicks -->Brands, Greetz
UNION ALL SELECT 1143750461, 'greetz', 'Brands'
-- Brand/Designer, Groovy Greetings -->Brands, Greetz
UNION ALL SELECT 1143766658, 'greetz', 'Brands'
-- Brand/Designer, Greetz -->Brands, Greetz
UNION ALL SELECT 726316072, 'greetz', 'Brands'
-- Brand/Designer, Gold Christmas -->Brands, Greetz
UNION ALL SELECT 1143761673, 'greetz', 'Brands'
-- Brand/Designer, Duotone Fun -->Brands, Greetz
UNION ALL SELECT 1143763753, 'greetz', 'Brands'
-- Brand/Designer, Go La La -->Brands, Go La la
UNION ALL SELECT 1143763188, 'go-la-la', 'Brands'
-- Brand/Designer, Emma Proctor -->Brands, Emma Proctor
UNION ALL SELECT 1143762773, 'brands-emma-proctor', 'Brands'
-- Brand/Designer, Focus on blue -->Brands, Greetz
UNION ALL SELECT 1143766653, 'greetz', 'Brands'
-- Brand/Designer, Floral Holidays -->Brands, Greetz
UNION ALL SELECT 1143751478, 'greetz', 'Brands'
-- Brand/Designer, Filthy Sentiments -->Brands, Filthy Sentiments
UNION ALL SELECT 1143762788, 'filthy-sentiments', 'Brands'
-- Brand/Designer, Fiep Westendorp -->Brands, Fiep Westendorp
UNION ALL SELECT 1143728886, 'fiep-westendorp', 'Brands'
-- Brand/Designer, Felt Studios -->Brands, Felt Studios
UNION ALL SELECT 1143762888, 'felt-studios', 'Brands'
-- Brand/Designer, Citrus Bunn -->Brands, Citrus Bunn
UNION ALL SELECT 1143761438, 'citrus-bunn', 'Brands'
-- Brand/Designer, Go with the flow -->Brands, Greetz
UNION ALL SELECT 1143750464, 'greetz', 'Brands'
-- Brand/Designer, Angela Chick -->Brands, Angela Chick
UNION ALL SELECT 1143761448, 'brands-angela-chick', 'Brands'
-- Brand/Designer, BBQ Salsa -->Brands, Greetz
UNION ALL SELECT 1143754532, 'greetz', 'Brands'
-- Brand/Designer, Banter King -->Brands, Banter King
UNION ALL SELECT 1143762923, 'banter-king', 'Brands'
-- Brand/Designer, Back 2 School -->Brands, Greetz
UNION ALL SELECT 1143766878, 'greetz', 'Brands'
-- Brand/Designer, Baby Dreams -->Brands, Greetz
UNION ALL SELECT 1143766838, 'greetz', 'Brands'
-- Brand/Designer, Aquarell color -->Brands, Greetz
UNION ALL SELECT 1143760748, 'greetz', 'Brands'
-- Brand/Designer, Colorfulmadness -->Brands, Greetz
UNION ALL SELECT 1143760848, 'greetz', 'Brands'
-- Brand/Designer, Animal Party -->Brands, Greetz
UNION ALL SELECT 1143766848, 'greetz', 'Brands'
-- Brand/Designer, Blond Noir -->Brands, Blond Noir
UNION ALL SELECT 1143750274, 'blond-noir', 'Brands'
-- Brand/Designer, All things banter -->Brands, All Things Banter
UNION ALL SELECT 1143762268, 'all-things-banter', 'Brands'
-- Brand/Designer, All the best cards -->Brands, All the best cards
UNION ALL SELECT 1143762453, 'all-the-best-cards', 'Brands'
-- Brand/Designer, All in one -->Brands, Greetz
UNION ALL SELECT 1143766638, 'greetz', 'Brands'
-- Brand/Designer, Alex Sharp Photography -->Brands, Alex Sharp Photography
UNION ALL SELECT 1143761453, 'alex-sharp-photography', 'Brands'
-- Brand/Designer, Abacus Cards -->Brands, Abacus Cards
UNION ALL SELECT 1143767813, 'abacus-cards', 'Brands'
-- Brand/Designer, A doodle a day -->Brands, Greetz
UNION ALL SELECT 1143746614, 'greetz', 'Brands'
-- Brand/Designer, Anoela Cards -->Brands, Anoela cards
UNION ALL SELECT 1143762093, 'anoela-cards', 'Brands'
-- Brand/Designer, Brainbox candy -->Brands, Brainbox Candy
UNION ALL SELECT 1143762743, 'brainbox-candy', 'Brands'
-- Brand/Designer, Cheeky Chops -->Brands, Cheeky chops
UNION ALL SELECT 1143762928, 'cheeky-chops', 'Brands'
-- Brand/Designer, Charly Clements -->Brands, MP- Charly Clements
UNION ALL SELECT 1143762098, 'mp-charly-clements', 'Brands'
-- Brand/Designer, Characterful -->Brands, Greetz
UNION ALL SELECT 1143753786, 'greetz', 'Brands'
-- Brand/Designer, Cats don't lie -->Brands, Greetz
UNION ALL SELECT 1143772688, 'greetz', 'Brands'
-- Brand/Designer, Catchy Images -->Brands, Catchy Images
UNION ALL SELECT 1143767088, 'catchy-images', 'Brands'
-- Brand/Designer, Bundle of Joy -->Brands, Greetz
UNION ALL SELECT 1143767693, 'greetz', 'Brands'
-- Brand/Designer, Beth Fletcher Illustration -->Brands, Beth Fletcher Illustration
UNION ALL SELECT 1143762603, 'beth-fletcher-illustration', 'Brands'
-- Brand/Designer, Bright Spot -->Brands, Bright Spot
UNION ALL SELECT 1143750271, 'bright-spot', 'Brands'
-- Brand/Designer, Blond Amsterdam -->Brands, Blond Amsterdam
UNION ALL SELECT 726304426, 'blond-amsterdam', 'Brands'
-- Brand/Designer, Bouffants and Broken Hearts -->Brands, Bouffants and Broken Hearts
UNION ALL SELECT 1143767808, 'bouffants-and-broken-hearts', 'Brands'
-- Brand/Designer, Bold and Bright -->Brands, Bold and Bright
UNION ALL SELECT 1143767798, 'bold-and-bright', 'Brands'
-- Brand/Designer, Bold and Beyond -->Brands, Greetz
UNION ALL SELECT 1143766423, 'greetz', 'Brands'
-- Brand/Designer, BohoHolidays -->Brands, Greetz
UNION ALL SELECT 1143750455, 'greetz', 'Brands'
-- Brand/Designer, Blossom and Bloom -->Brands, Greetz
UNION ALL SELECT 1143766868, 'greetz', 'Brands'
-- Brand/Designer, Hello December -->Brands, Greetz
UNION ALL SELECT 1143750470, 'greetz', 'Brands'
-- Brand/Designer, Bubbly fun -->Brands, Greetz
UNION ALL SELECT 1143760743, 'greetz', 'Brands'
-- Brand/Designer, Lieve herfst -->Brands, Greetz
UNION ALL SELECT 1143760498, 'greetz', 'Brands'
-- Brand/Designer, Love Notes -->Brands, Greetz
UNION ALL SELECT 1143766428, 'greetz', 'Brands'
-- Brand/Designer, Love letters -->Brands, Greetz
UNION ALL SELECT 1143750449, 'greetz', 'Brands'
-- Brand/Designer, Love is all you need -->Brands, Greetz
UNION ALL SELECT 1143766433, 'greetz', 'Brands'
-- Brand/Designer, Love Brush -->Brands, Greetz
UNION ALL SELECT 1143756722, 'greetz', 'Brands'
-- Brand/Designer, Loesje -->Brands, Loesje
UNION ALL SELECT 1143732899, 'loesje', 'Brands'
-- Brand/Designer, Happy tits -->Brands, Greetz
UNION ALL SELECT 1143750467, 'greetz', 'Brands'
-- Brand/Designer, Lifeline -->Brands, Greetz
UNION ALL SELECT 1143774011, 'greetz', 'Brands'
-- Brand/Designer, Lovepost -->Brands, Greetz
UNION ALL SELECT 1143766863, 'greetz', 'Brands'
-- Brand/Designer, Lief Leven -->Brands, Lief Leven
UNION ALL SELECT 1143737023, 'lief-leven', 'Brands'
-- Brand/Designer, Letters By Julia -->Brands, Letters By Julia
UNION ALL SELECT 1143762613, 'letters-by-julia', 'Brands'
-- Brand/Designer, Legs talk about it -->Brands, Greetz
UNION ALL SELECT 1143766413, 'greetz', 'Brands'
-- Brand/Designer, Last Lemon Productions -->Brands, Last Lemon Productions
UNION ALL SELECT 1143762633, 'last-lemon-productions', 'Brands'
-- Brand/Designer, Kleine Vlindervoetjes -->Brands, Kleine Vlindervoetjes
UNION ALL SELECT 1143754283, 'kleine-vlindervoetjes', 'Brands'
-- Brand/Designer, Kleine Twinkeltjes -->Brands, Kleine Twinkeltjes
UNION ALL SELECT 1143754286, 'kleine-twinkeltjes', 'Brands'
-- Brand/Designer, Ling Design -->Brands, Ling Design
UNION ALL SELECT 1143762598, 'ling-design', 'Brands'
-- Brand/Designer, Marieke Witke -->Brands, Marieke Witke
UNION ALL SELECT 1143753750, 'marieke-witke', 'Brands'
-- Brand/Designer, Voxelville -->Brands, Greetz
UNION ALL SELECT 1143766663, 'greetz', 'Brands'
-- Brand/Designer, Mia Whittemore -->Brands, Mia Whittemore
UNION ALL SELECT 1143767793, 'mia-whittemore', 'Brands'
-- Brand/Designer, Merry more -->Brands, Greetz
UNION ALL SELECT 1143750488, 'greetz', 'Brands'
-- Brand/Designer, Merry and cherry -->Brands, Greetz
UNION ALL SELECT 1143750485, 'greetz', 'Brands'
-- Brand/Designer, Memelou -->Brands, Memelou
UNION ALL SELECT 1143763543, 'memelou', 'Brands'
-- Brand/Designer, Melolelo -->Brands, Melolelo
UNION ALL SELECT 1143751943, 'melolelo', 'Brands'
-- Brand/Designer, Love Repeat -->Brands, Love Repeat
UNION ALL SELECT 1143757538, 'love-repeat', 'Brands'
-- Brand/Designer, Mark my words -->Brands, Greetz
UNION ALL SELECT 1143766438, 'greetz', 'Brands'
-- Brand/Designer, Love wins -->Brands, Greetz
UNION ALL SELECT 1143754962, 'greetz', 'Brands'
-- Brand/Designer, Marie Bodié -->Brands, Marie Bodié
UNION ALL SELECT 1143748370, 'marie-bodie', 'Brands'
-- Brand/Designer, Marble Christmas -->Brands, Greetz
UNION ALL SELECT 1143761623, 'greetz', 'Brands'
-- Brand/Designer, Lucy Pearce designs -->Brands, Lucy Pearce designs
UNION ALL SELECT 1143762968, 'lucy-pearce-designs', 'Brands'
-- Brand/Designer, Lucy Maggie -->Brands, Lucy Maggie
UNION ALL SELECT 1143762118, 'brands-lucy-maggie', 'Brands'
-- Brand/Designer, Luckz -->Brands, Luckz
UNION ALL SELECT 1143736251, 'luckz', 'Brands'
-- Brand/Designer, Klaas de Jong -->Brands, Klaas de Jong
UNION ALL SELECT 1143735381, 'klaas-de-jong', 'Brands'
-- Brand/Designer, Meet Harry -->Brands, Greetz
UNION ALL SELECT 1143773481, 'greetz', 'Brands'
-- Brand/Designer, Home Sweet Home -->Brands, Greetz
UNION ALL SELECT 1143766843, 'greetz', 'Brands'
-- Brand/Designer, Klein blue -->Brands, Greetz
UNION ALL SELECT 1143750482, 'greetz', 'Brands'
-- Brand/Designer, Izzy Likes to Doodle -->Brands, Izzy Likes to Doodle
UNION ALL SELECT 1143768198, 'izzy-likes-to-doodle', 'Brands'
-- Brand/Designer, IKPAKJEIN -->Brands, IKPAKJEIN
UNION ALL SELECT 1143737026, 'ikpakjein', 'Brands'
-- Brand/Designer, iDrew Illustrations -->Brands, iDrew Illustrations
UNION ALL SELECT 1143768203, 'idrew-illustrations', 'Brands'
-- Brand/Designer, I saw the sign -->Brands, Greetz
UNION ALL SELECT 1143772808, 'greetz', 'Brands'
-- Brand/Designer, I see patterns -->Brands, Greetz
UNION ALL SELECT 1143746665, 'greetz', 'Brands'
-- Brand/Designer, Jan van Haasteren Junior -->Brands, Jan van Haasteren
UNION ALL SELECT 1143774146, 'jan-van-haasteren', 'Brands'
-- Brand/Designer, Hotchpotch -->Brands, Hotchpotch
UNION ALL SELECT 1143737752, 'hotchpotch', 'Brands'
-- Brand/Designer, Janneke Brinkman -->Brands, Janneke Brinkman
UNION ALL SELECT 726305063, 'janneke-brinkman', 'Brands'
-- Brand/Designer, Hollandse Meesters -->Brands, Greetz
UNION ALL SELECT 1143761633, 'greetz', 'Brands'
-- Brand/Designer, Holiday blues -->Brands, Greetz
UNION ALL SELECT 1143750476, 'greetz', 'Brands'
-- Brand/Designer, Happy moments -->Brands, Greetz
UNION ALL SELECT 1143772698, 'greetz', 'Brands'
-- Brand/Designer, Holiday after hours -->Brands, Greetz
UNION ALL SELECT 1143750473, 'greetz', 'Brands'
-- Brand/Designer, Hello Munki -->Brands, Hello Munki
UNION ALL SELECT 1143762958, 'hello-munki', 'Brands'
-- Brand/Designer, Milestone -->Brands, Milestone
UNION ALL SELECT 1143739098, 'milestone', 'Brands'
-- Brand/Designer, I Like Your Smiley -->Brands, Greetz
UNION ALL SELECT 1143763758, 'greetz', 'Brands'
-- Brand/Designer, Jolly Happy Joy -->Brands, Greetz
UNION ALL SELECT 1143761628, 'greetz', 'Brands'
-- Brand/Designer, Hello Betty -->Brands, Greetz
UNION ALL SELECT 1143746647, 'greetz', 'Brands'
-- Brand/Designer, Kitsch Noir -->Brands, Kitsch Noir
UNION ALL SELECT 1143762963, 'kitsch-noir', 'Brands'
-- Brand/Designer, Kitchen of smiles -->Brands, Kitchen of smiles
UNION ALL SELECT 1143771193, 'kitchen-of-smiles', 'Brands'
-- Brand/Designer, Kinship -->Brands, Greetz
UNION ALL SELECT 1143753780, 'greetz', 'Brands'
-- Brand/Designer, Katt Jones -->Brands, Katt Jones Hulafig
UNION ALL SELECT 1143764193, 'katt-jones-hulafig', 'Brands'
-- Brand/Designer, Katie Abey Design -->Brands, Katie Abey Design
UNION ALL SELECT 1143762623, 'katie-abey-design', 'Brands'
-- Brand/Designer, Jan van Haasteren -->Brands, Jan van Haasteren
UNION ALL SELECT 1143730797, 'jan-van-haasteren', 'Brands'
-- Brand/Designer, Joyful -->Brands, Greetz
UNION ALL SELECT 1143766828, 'greetz', 'Brands'
-- Brand/Designer, Klara Hawkins -->Brands, Klara Hawkins
UNION ALL SELECT 1143762228, 'brands-klara-hawkins', 'Brands'
-- Brand/Designer, Jolly Awesome -->Brands, Jolly Awesome
UNION ALL SELECT 1143761443, 'jolly-awesome', 'Brands'
-- Brand/Designer, Jolly and bright -->Brands, Greetz
UNION ALL SELECT 1143750479, 'greetz', 'Brands'
-- Brand/Designer, Jewel Branding -->Brands, Jewel Branding
UNION ALL SELECT 1143764153, 'jewel-branding', 'Brands'
-- Brand/Designer, Jess Rose Illustration -->Brands, Jess Rose Illustration
UNION ALL SELECT 1143764273, 'jess-rose-illustration', 'Brands'
-- Brand/Designer, Jerry Tapscott -->Brands, Jerry Tapscott
UNION ALL SELECT 1143762768, 'brands-jerry-tapscott', 'Brands'
-- Brand/Designer, Jenny Seddon -->Brands, Jenny Seddon
UNION ALL SELECT 1143762593, 'jenny-seddon', 'Brands'
-- Brand/Designer, Karmuka -->Brands, Karmuka
UNION ALL SELECT 1143764303, 'karmuka', 'Brands'
-- Brand/Designer, Joy to the world -->Brands, Greetz
UNION ALL SELECT 1143773706, 'greetz', 'Brands'
-- Brand/Designer, Uddle -->Brands, Uddle
UNION ALL SELECT 1143767803, 'uddle', 'Brands'
-- Brand/Designer, Nijntje -->Brands, Nijntje
UNION ALL SELECT 825334736, 'nijntje', 'Brands'
-- Brand/Designer, Naughty or nice -->Brands, Greetz
UNION ALL SELECT 1143773711, 'greetz', 'Brands'
-- Brand/Designer, Oh baby -->Brands, Greetz
UNION ALL SELECT 1143773836, 'greetz', 'Brands'
-- Brand/Designer, Falalala -->Brands, Greetz
UNION ALL SELECT 1143773701, 'greetz', 'Brands'
-- Brand/Designer, Shine bright -->Brands, Greetz
UNION ALL SELECT 1143773696, 'greetz', 'Brands'
-- Brand/Designer, Wonderful wishes -->Brands, Greetz
UNION ALL SELECT 1143773691, 'greetz', 'Brands'
-- Brand/Designer, Happy always -->Brands, Greetz
UNION ALL SELECT 1143773686, 'greetz', 'Brands'
-- Brand/Designer, Merry everything -->Brands, Greetz
UNION ALL SELECT 1143773681, 'greetz', 'Brands'
-- Brand/Designer, Very good very nice -->Brands, Greetz
UNION ALL SELECT 1143773846, 'greetz', 'Brands'
-- Brand/Designer, It's a zoo out there -->Brands, Greetz
UNION ALL SELECT 1143773871, 'greetz', 'Brands'
-- Brand/Designer, Animal party -->Brands, Greetz
UNION ALL SELECT 1143766848, 'greetz', 'Brands'
-- Brand/Designer, Flip side -->Brands, Greetz
UNION ALL SELECT 1143773866, 'greetz', 'Brands'
-- Brand/Designer, True blue -->Brands, Greetz
UNION ALL SELECT 1143773861, 'greetz', 'Brands'
-- Brand/Designer, It's a wrap -->Brands, Greetz
UNION ALL SELECT 1143773856, 'greetz', 'Brands'
-- Brand/Designer, Dogs don't lie -->Brands, Greetz
UNION ALL SELECT 1143773851, 'greetz', 'Brands'
-- Brand/Designer, Lucky star -->Brands, Greetz
UNION ALL SELECT 1143773841, 'greetz', 'Brands'
-- Brand/Designer, Snowflake -->Brands, Greetz
UNION ALL SELECT 1143773676, 'greetz', 'Brands'
-- Brand/Designer, Little Dutch -->Brands, Little Dutch
UNION ALL SELECT 1143740088, 'little-dutch', 'Brands'
-- Occasion, Christmas (invitations) -->Format Layout & Size, Invitations
UNION ALL SELECT 1143734987, 'invitations', 'Format Layout & Size'
-- Occasion, Opening new business (invitations) -->Format Layout & Size, Invitations
UNION ALL SELECT 1143745104, 'invitations', 'Format Layout & Size'
-- Occasion, Newyear (cardhouse) -->Format Layout & Size, Invitations
UNION ALL SELECT 1143734456, 'invitations', 'Format Layout & Size'
-- Occasion, New Year's reception business -->Format Layout & Size, Invitations
UNION ALL SELECT 1143743079, 'invitations', 'Format Layout & Size'
-- Occasion, Birth cards (boy) -->Format Layout & Size, Invitations
UNION ALL SELECT 1143737029, 'invitations', 'Format Layout & Size'
-- Occasion, Christmas party (invitations Cardhouse) -->Format Layout & Size, Invitations
UNION ALL SELECT 1143742829, 'invitations', 'Format Layout & Size'
-- Occasion, Childrens party (invitations) -->Format Layout & Size, Invitations
UNION ALL SELECT 1143728928, 'invitations', 'Format Layout & Size'
-- Occasion, Business invitations (invitations) -->Format Layout & Size, Invitations
UNION ALL SELECT 1143729480, 'invitations', 'Format Layout & Size'
-- Occasion, Borrel (invitation) -->Format Layout & Size, Invitations
UNION ALL SELECT 1143735320, 'invitations', 'Format Layout & Size'
-- Occasion, Thank you cards (invitations) -->Format Layout & Size, Invitations
UNION ALL SELECT 1143728940, 'invitations', 'Format Layout & Size'
-- Occasion, Birth cards (Birth) -->Format Layout & Size, Invitations
UNION ALL SELECT 1143736045, 'invitations', 'Format Layout & Size'
-- Occasion, New Years Party (invitations) -->Format Layout & Size, Invitations
UNION ALL SELECT 1143731548, 'invitations', 'Format Layout & Size'
-- Occasion, Birthday invitation (invitations) -->Format Layout & Size, Invitations
UNION ALL SELECT 1143728925, 'invitations', 'Format Layout & Size'
-- Occasion, New year party (invitations cardhouse) -->Format Layout & Size, Invitations
UNION ALL SELECT 1143742832, 'invitations', 'Format Layout & Size'
-- Occasion, Commumion (invitations cardhouse) -->Format Layout & Size, Invitations
UNION ALL SELECT 1143733885, 'invitations', 'Format Layout & Size'
-- Occasion, Moving announcement (invitations) -->Format Layout & Size, Invitations
UNION ALL SELECT 1143728934, 'invitations', 'Format Layout & Size'
-- Occasion, Moving (invitations) -->Format Layout & Size, Invitations
UNION ALL SELECT 1143728961, 'invitations', 'Format Layout & Size'
-- Occasion, Dinner party en drinks (invitations) -->Format Layout & Size, Invitations
UNION ALL SELECT 1143728937, 'invitations', 'Format Layout & Size'
-- Occasion, Marriage anniversary (invitations) -->Format Layout & Size, Invitations
UNION ALL SELECT 1143729369, 'invitations', 'Format Layout & Size'
-- Occasion, Exam party (invitations) -->Format Layout & Size, Invitations
UNION ALL SELECT 1143728946, 'invitations', 'Format Layout & Size'
-- Occasion, Bachelor party (invitations) -->Format Layout & Size, Invitations
UNION ALL SELECT 1143729366, 'invitations', 'Format Layout & Size'
-- Occasion, Housewarming (invitations Cardhouse) -->Format Layout & Size, Invitations
UNION ALL SELECT 1143733891, 'invitations', 'Format Layout & Size'
-- Occasion, Save our date -->Format Layout & Size, Invitations
UNION ALL SELECT 1143745167, 'invitations', 'Format Layout & Size'
-- Occasion, Garden party (invitations) -->Format Layout & Size, Invitations
UNION ALL SELECT 1143728952, 'invitations', 'Format Layout & Size'
-- Occasion, Gardenparty (invitations cardhouse) -->Format Layout & Size, Invitations
UNION ALL SELECT 1143734411, 'invitations', 'Format Layout & Size'
-- Occasion, Gender reveal party (invitations) -->Format Layout & Size, Invitations
UNION ALL SELECT 1143739140, 'invitations', 'Format Layout & Size'
-- Occasion, Housewarming (invitations) -->Format Layout & Size, Invitations
UNION ALL SELECT 1143728958, 'invitations', 'Format Layout & Size'
-- Occasion, Baby shower (invitations) -->Format Layout & Size, Invitations
UNION ALL SELECT 1143729372, 'invitations', 'Format Layout & Size'
-- Product Family, Greeting Cards -->Format Layout & Size, Greeting Cards
UNION ALL SELECT 726928674, 'greeting-cards', 'Format Layout & Size'
-- Occasion, Wedding invitation (Wedding) -->Format Layout & Size, Invitations
UNION ALL SELECT 1143728795, 'invitations', 'Format Layout & Size'
-- Occasion, Age invitations -->Format Layout & Size, Invitations
UNION ALL SELECT 1143737827, 'invitations', 'Format Layout & Size'
-- Occasion, Babyshower (invitations cardhouse) -->Format Layout & Size, Invitations
UNION ALL SELECT 1143734414, 'invitations', 'Format Layout & Size'
-- Product Family, Invitations (IA) -->Format Layout & Size, Invitations
UNION ALL SELECT 726926716, 'invitations', 'Format Layout & Size'
-- Occasion, Baby party (invitations) -->Format Layout & Size, Invitations
UNION ALL SELECT 1143728943, 'invitations', 'Format Layout & Size'
-- Theme, Vehicles (cards missions) -->Interests & Hobbies, Cars and Bikes
UNION ALL SELECT 1143751241, 'cars-and-bikes', 'Interests & Hobbies'
-- Theme, Music (cards missions) -->Interests & Hobbies, Music
UNION ALL SELECT 1143751244, 'interests-hobbies-music', 'Interests & Hobbies'
-- Theme, House and garden (cards missions) -->Interests & Hobbies, Gardening
UNION ALL SELECT 1143751187, 'gardening', 'Interests & Hobbies'
-- Theme, Sport (cards missions) -->Interests & Hobbies, Fitness
UNION ALL SELECT 902926598, 'fitness', 'Interests & Hobbies'
-- Theme, Food en drinks (cards missions) -->Interests & Hobbies, Food and Drink
UNION ALL SELECT 1143751178, 'food-and-drink', 'Interests & Hobbies'
-- Theme, Games (cards missions) -->Interests & Hobbies, Gaming
UNION ALL SELECT 1143753639, 'interests-hobbies-gaming', 'Interests & Hobbies'
-- Theme, Travel (cards missions) -->Interests & Hobbies, Travel
UNION ALL SELECT 1143751190, 'interests-hobbies-travel', 'Interests & Hobbies'
-- Theme, Tropical and jungle (cards missions) -->Interests & Hobbies, Travel
UNION ALL SELECT 1143751181, 'interests-hobbies-travel', 'Interests & Hobbies'
-- Design Style, English cards -->Language, English
UNION ALL SELECT 1143766733, 'english', 'Language'
-- Design Style, Dutch cards -->Language, Dutch
UNION ALL SELECT 1143766728, 'dutch', 'Language'
-- Occasion, Birthday with age -->NewIa, Birthday Milestones
UNION ALL SELECT 1082531404, 'birthday-milestones', 'NewIa'
-- Age, 65 year -->NewIa, Birthday Milestones
UNION ALL SELECT 1143774016, 'birthday-milestones', 'NewIa'
-- Occasion, Mothersday distance -->Occasion, Mothers' Day
UNION ALL SELECT 1143749639, 'mothers-day', 'Occasion'
-- Occasion, Mothersday -->Occasion, Mothers' Day
UNION ALL SELECT 726331722, 'mothers-day', 'Occasion'
-- Occasion, Miscarriage -->Occasion, Sympathy
UNION ALL SELECT 1143754610, 'occasion-sympathy', 'Occasion'
-- Occasion, Mothersday best sold -->Occasion, Mothers' Day
UNION ALL SELECT 1143736647, 'mothers-day', 'Occasion'
-- Occasion, Mothersday thinking of you -->Occasion, Mothers' Day
UNION ALL SELECT 1143749471, 'mothers-day', 'Occasion'
-- Occasion, Moving announcement (invitations) -->Occasion, New Home
UNION ALL SELECT 1143728934, 'occasion-new-home', 'Occasion'
-- Occasion, Moving announcement christmas -->Occasion, Christmas
UNION ALL SELECT 1143744489, 'occasion-christmas', 'Occasion'
-- Occasion, New home -->Occasion, New Home
UNION ALL SELECT 726342840, 'occasion-new-home', 'Occasion'
-- Occasion, New Job -->Occasion, New Job
UNION ALL SELECT 735872747, 'occasion-new-job', 'Occasion'
-- Occasion, New schoolyear -->Occasion, School
UNION ALL SELECT 1143754652, 'school', 'Occasion'
-- Occasion, Work anniversary -->Occasion, Anniversaries
UNION ALL SELECT 1143733543, 'anniversaries', 'Occasion'
-- Occasion, New year party (invitations cardhouse) -->Occasion, New Year
UNION ALL SELECT 1143742832, 'occasion-new-year', 'Occasion'
-- Occasion, Moving (invitations) -->Occasion, New Home
UNION ALL SELECT 1143728961, 'occasion-new-home', 'Occasion'
-- Occasion, International Women's Day -->Occasion, International Women's Day
UNION ALL SELECT 1143766488, 'international-womens-day', 'Occasion'
-- Occasion, Graduated Propaedeutic certificate -->Occasion, Graduation
UNION ALL SELECT 1143754872, 'occasion-graduation', 'Occasion'
-- Occasion, Graduation -->Occasion, Graduation
UNION ALL SELECT 1143729906, 'occasion-graduation', 'Occasion'
-- Occasion, Halloween -->Occasion, Halloween
UNION ALL SELECT 1143731177, 'occasion-halloween', 'Occasion'
-- Occasion, Happy Pride -->Occasion, Pride
UNION ALL SELECT 1143747064, 'pride', 'Occasion'
-- Occasion, Highschool -->Occasion, School
UNION ALL SELECT 1143754655, 'school', 'Occasion'
-- Occasion, Honeymoon -->Occasion, Wedding
UNION ALL SELECT 1143754640, 'occasion-wedding', 'Occasion'
-- Occasion, Housewarming (invitations Cardhouse) -->Occasion, New Home
UNION ALL SELECT 1143733891, 'occasion-new-home', 'Occasion'
-- Occasion, Love -->Occasion, Other
UNION ALL SELECT 1143727832, 'occasion-other', 'Occasion'
-- Occasion, International boss day -->Occasion, Other
UNION ALL SELECT 1143746905, 'occasion-other', 'Occasion'
-- Occasion, Milestones -->Occasion, Other
UNION ALL SELECT 1143749857, 'occasion-other', 'Occasion'
-- Occasion, Just because -->Occasion, Just to say
UNION ALL SELECT 726347430, 'just-to-say', 'Occasion'
-- Occasion, Just Married -->Occasion, Wedding
UNION ALL SELECT 1143732220, 'occasion-wedding', 'Occasion'
-- Occasion, Kingsday birthday -->Occasion, Kingsday
UNION ALL SELECT 1143755892, 'kingsday', 'Occasion'
-- Occasion, Kingsday birthday -->Occasion, Birthday
UNION ALL SELECT 1143755892, 'occasion-birthday', 'Occasion'
-- Occasion, Witness -->Occasion, Wedding
UNION ALL SELECT 1143740590, 'occasion-wedding', 'Occasion'
-- Occasion, Living together -->Occasion, New Home
UNION ALL SELECT 1143727835, 'occasion-new-home', 'Occasion'
-- Occasion, Marriage anniversary (invitations) -->Occasion, Anniversaries
UNION ALL SELECT 1143729369, 'anniversaries', 'Occasion'
-- Occasion, Maternity Leave -->Occasion, Pregnancy
UNION ALL SELECT 1143733399, 'occasion-pregnancy', 'Occasion'
-- Occasion, Housewarming (invitations) -->Occasion, New Home
UNION ALL SELECT 1143728958, 'occasion-new-home', 'Occasion'
-- Occasion, Thank you teacher -->Occasion, Thank You
UNION ALL SELECT 1143742415, 'occasion-thank-you', 'Occasion'
-- Occasion, New Years Party (invitations) -->Occasion, New Year
UNION ALL SELECT 1143731548, 'occasion-new-year', 'Occasion'
-- Occasion, Say goodbye -->Occasion, Goodbye
UNION ALL SELECT 1143736125, 'goodbye', 'Occasion'
-- Occasion, Secretaryday -->Occasion, Other
UNION ALL SELECT 1143731240, 'occasion-other', 'Occasion'
-- Occasion, Valentine single -->Occasion, Valentines' Day
UNION ALL SELECT 1143765443, 'valentines-day', 'Occasion'
-- Occasion, Sinterklaas -->Occasion, Sinterklaas
UNION ALL SELECT 726330911, 'saint-nicholas', 'Occasion'
-- Occasion, Sorry -->Occasion, Sorry
UNION ALL SELECT 726966325, 'occasion-sorry', 'Occasion'
-- Occasion, Swimming diploma -->Occasion, Congratulations
UNION ALL SELECT 1143742376, 'occasion-congratulations', 'Occasion'
-- Occasion, Thank you -->Occasion, Thank You
UNION ALL SELECT 726347103, 'occasion-thank-you', 'Occasion'
-- Occasion, Valentine secret love -->Occasion, Valentines' Day
UNION ALL SELECT 748508147, 'valentines-day', 'Occasion'
-- Occasion, Kingsday -->Occasion, Kingsday
UNION ALL SELECT 726972775, 'kingsday', 'Occasion'
-- Occasion, Thank you caretakers -->Occasion, Thank You
UNION ALL SELECT 1143749321, 'occasion-thank-you', 'Occasion'
-- Occasion, Valentine thinking of you -->Occasion, Valentines' Day
UNION ALL SELECT 1143748916, 'valentines-day', 'Occasion'
-- Occasion, Valentine online dating -->Occasion, Valentines' Day
UNION ALL SELECT 1143748919, 'valentines-day', 'Occasion'
-- Occasion, Thanksgiving -->Occasion, Thanksgiving
UNION ALL SELECT 1143764443, 'newia-occasion-thanksgiving', 'Occasion'
-- Occasion, Thinking of you -->Occasion, Empathy
UNION ALL SELECT 748511930, 'empathy', 'Occasion'
-- Occasion, Travelling -->Occasion, Holiday
UNION ALL SELECT 1143731911, 'holiday', 'Occasion'
-- Occasion, Vacation -->Occasion, Holiday
UNION ALL SELECT 1143729435, 'holiday', 'Occasion'
-- Occasion, Vacation welcome home -->Occasion, Welcome Home
UNION ALL SELECT 726965369, 'welcome-home', 'Occasion'
-- Occasion, Valentine -->Occasion, Valentines' Day
UNION ALL SELECT 726324647, 'valentines-day', 'Occasion'
-- Occasion, Valentine best sold -->Occasion, Valentines' Day
UNION ALL SELECT 1143735065, 'valentines-day', 'Occasion'
-- Occasion, Valentine In love -->Occasion, Valentines' Day
UNION ALL SELECT 748508746, 'valentines-day', 'Occasion'
-- Occasion, Thank you cards (invitations) -->Occasion, Thank You
UNION ALL SELECT 1143728940, 'occasion-thank-you', 'Occasion'
-- Occasion, Wedding Anniversary -->Occasion, Anniversaries
UNION ALL SELECT 735870898, 'anniversaries', 'Occasion'
-- Occasion, New Year's reception business -->Occasion, New Year
UNION ALL SELECT 1143743079, 'occasion-new-year', 'Occasion'
-- Occasion, Valentine loving -->Occasion, Valentines' Day
UNION ALL SELECT 748510085, 'valentines-day', 'Occasion'
-- Occasion, Newyear (cardhouse) -->Occasion, New Year
UNION ALL SELECT 1143734456, 'occasion-new-year', 'Occasion'
-- Occasion, Wedding invitation (Wedding) -->Occasion, Wedding
UNION ALL SELECT 1143728795, 'occasion-wedding', 'Occasion'
-- Occasion, NewYear (cards) -->Occasion, New Year
UNION ALL SELECT 726331444, 'occasion-new-year', 'Occasion'
-- Occasion, NewYear Birth -->Occasion, New Year
UNION ALL SELECT 1143765733, 'occasion-new-year', 'Occasion'
-- Occasion, NewYear Birthday -->Occasion, New Year
UNION ALL SELECT 1143765723, 'occasion-new-year', 'Occasion'
-- Occasion, NewYear New home -->Occasion, New Year
UNION ALL SELECT 1143765738, 'occasion-new-year', 'Occasion'
-- Occasion, NewYearsCards -->Occasion, New Year
UNION ALL SELECT 1143748523, 'occasion-new-year', 'Occasion'
-- Occasion, Save the date (Wedding cards only) -->Occasion, Wedding
UNION ALL SELECT 1143729708, 'occasion-wedding', 'Occasion'
-- Occasion, Opening new business -->Occasion, Other
UNION ALL SELECT 1143744579, 'occasion-other', 'Occasion'
-- Occasion, Save our date -->Occasion, Wedding
UNION ALL SELECT 1143745167, 'occasion-wedding', 'Occasion'
-- Occasion, Opening new business (invitations) -->Occasion, Other
UNION ALL SELECT 1143745104, 'occasion-other', 'Occasion'
-- Occasion, Pregnant -->Occasion, Pregnancy
UNION ALL SELECT 726344253, 'occasion-pregnancy', 'Occasion'
-- Occasion, Proud of you -->Occasion, Proud of You
UNION ALL SELECT 1143766298, 'proud-of-you', 'Occasion'
-- Occasion, re exam -->Occasion, Exams
UNION ALL SELECT 1143742355, 'occasion-exams', 'Occasion'
-- Occasion, Registered partnership -->Occasion, Wedding
UNION ALL SELECT 1143754619, 'occasion-wedding', 'Occasion'
-- Occasion, Renovate -->Occasion, New Home
UNION ALL SELECT 1143754634, 'occasion-new-home', 'Occasion'
-- Occasion, Wedding -->Occasion, Wedding
UNION ALL SELECT 726342081, 'occasion-wedding', 'Occasion'
-- Occasion, Retirement -->Occasion, Retirement
UNION ALL SELECT 735873966, 'occasion-retirement', 'Occasion'
-- Occasion, Graduated high school -->Occasion, Graduation
UNION ALL SELECT 748505918, 'occasion-graduation', 'Occasion'
-- Occasion, Notice of marriage -->Occasion, Wedding
UNION ALL SELECT 1143754397, 'occasion-wedding', 'Occasion'
-- Occasion, Christmas birthday -->Occasion, Birthday
UNION ALL SELECT 1143750641, 'occasion-birthday', 'Occasion'
-- Occasion, Birthday leap year -->Occasion, Birthday
UNION ALL SELECT 1143733516, 'occasion-birthday', 'Occasion'
-- Occasion, Birthday with star sign -->Occasion, Birthday
UNION ALL SELECT 1143749327, 'occasion-birthday', 'Occasion'
-- Occasion, Blue Monday -->Occasion, Other
UNION ALL SELECT 1143765398, 'occasion-other', 'Occasion'
-- Occasion, Broken bones -->Occasion, Get Well
UNION ALL SELECT 1143754613, 'occasion-get-well', 'Occasion'
-- Occasion, Brother and Sister day -->Occasion, Other
UNION ALL SELECT 1143732527, 'occasion-other', 'Occasion'
-- Occasion, Carnaval -->Occasion, Other
UNION ALL SELECT 1143766238, 'occasion-other', 'Occasion'
-- Occasion, Childrens party (invitations) -->Occasion, Birthday
UNION ALL SELECT 1143728928, 'occasion-birthday', 'Occasion'
-- Occasion, Chinese New Year -->Occasion, Chinese new year
UNION ALL SELECT 1143765953, 'occasion-chinese-new-year', 'Occasion'
-- Occasion, Christmas -->Occasion, Christmas
UNION ALL SELECT 726331358, 'occasion-christmas', 'Occasion'
-- Occasion, Christmas (cardhouse) -->Occasion, Christmas
UNION ALL SELECT 1143734963, 'occasion-christmas', 'Occasion'
-- Occasion, Chronically or seriously ill -->Occasion, Get Well
UNION ALL SELECT 1143754616, 'occasion-get-well', 'Occasion'
-- Occasion, Christmas birth -->Occasion, New Baby
UNION ALL SELECT 1143744030, 'occasion-new-baby', 'Occasion'
-- Occasion, Birthday from distance -->Occasion, Birthday
UNION ALL SELECT 1143749585, 'occasion-birthday', 'Occasion'
-- Occasion, Christmas Business (IA) -->Occasion, Christmas
UNION ALL SELECT 1143734990, 'occasion-christmas', 'Occasion'
-- Occasion, Christmas humor -->Occasion, Christmas
UNION ALL SELECT 1143750638, 'occasion-christmas', 'Occasion'
-- Occasion, Christmas in the weekend -->Occasion, Christmas
UNION ALL SELECT 1143764653, 'occasion-christmas', 'Occasion'
-- Occasion, Christmas most sold -->Occasion, Christmas
UNION ALL SELECT 1143737233, 'occasion-christmas', 'Occasion'
-- Occasion, Christmas new home -->Occasion, New Home
UNION ALL SELECT 1143744027, 'occasion-new-home', 'Occasion'
-- Occasion, Christmas party (invitations Cardhouse) -->Occasion, Christmas
UNION ALL SELECT 1143742829, 'occasion-christmas', 'Occasion'
-- Occasion, Christmas thank you -->Occasion, Christmas
UNION ALL SELECT 1143762663, 'occasion-christmas', 'Occasion'
-- Occasion, Christmas thank you -->Occasion, Thank You
UNION ALL SELECT 1143762663, 'occasion-thank-you', 'Occasion'
-- Occasion, Christmas thinking of you -->Occasion, Christmas
UNION ALL SELECT 1143743997, 'occasion-christmas', 'Occasion'
-- Occasion, Christmas thinking of you -->Occasion, Thinking of You
UNION ALL SELECT 1143743997, 'occasion-thinking-of-you', 'Occasion'
-- Occasion, Christmas (invitations) -->Occasion, Christmas
UNION ALL SELECT 1143734987, 'occasion-christmas', 'Occasion'
-- Occasion, Back to school cards -->Occasion, School
UNION ALL SELECT 1143754649, 'school', 'Occasion'
-- Occasion, Adoption -->Occasion, Adoption
UNION ALL SELECT 1143760393, 'adoption', 'Occasion'
-- Occasion, Anniversary -->Occasion, Anniversaries
UNION ALL SELECT 1143740082, 'anniversaries', 'Occasion'
-- Occasion, Anniversary relationship -->Occasion, Anniversaries
UNION ALL SELECT 1143761508, 'anniversaries', 'Occasion'
-- Occasion, AOC think -->Occasion, Thinking of you
UNION ALL SELECT 1143742160, 'occasion-thinking-of-you', 'Occasion'
-- Occasion, Baby party (invitations) -->Occasion, New Baby
UNION ALL SELECT 1143728943, 'occasion-new-baby', 'Occasion'
-- Occasion, Baby shower (invitations) -->Occasion, Baby Shower
UNION ALL SELECT 1143729372, 'baby-shower', 'Occasion'
-- Occasion, Babyshower -->Occasion, Baby Shower
UNION ALL SELECT 1143739143, 'baby-shower', 'Occasion'
-- Occasion, Babyshower -->Occasion, Baby Shower
UNION ALL SELECT 1143739143, 'baby-shower', 'Occasion'
-- Occasion, Babyshower -->Occasion, Baby Shower
UNION ALL SELECT 1143739143, 'baby-shower', 'Occasion'
-- Occasion, Babyshower -->Occasion, Baby Shower
UNION ALL SELECT 1143739143, 'baby-shower', 'Occasion'
-- Occasion, Birthday invitation (invitations) -->Occasion, Birthday
UNION ALL SELECT 1143728925, 'occasion-birthday', 'Occasion'
-- Occasion, Bachelor party (invitations) -->Occasion, Stag Do
UNION ALL SELECT 1143729366, 'stag-do', 'Occasion'
-- Occasion, Birthday in dialect -->Occasion, Birthday
UNION ALL SELECT 1143752651, 'occasion-birthday', 'Occasion'
-- Occasion, Baptism and communion (invitations) -->Occasion, Communion
UNION ALL SELECT 1143728949, 'communion', 'Occasion'
-- Occasion, Graduated afgestudeerd -->Occasion, Graduation
UNION ALL SELECT 1143754869, 'occasion-graduation', 'Occasion'
-- Occasion, Birth -->Occasion, New Baby
UNION ALL SELECT 726324202, 'occasion-new-baby', 'Occasion'
-- Occasion, Birth cards (Birth) -->Occasion, New Baby
UNION ALL SELECT 1143736045, 'occasion-new-baby', 'Occasion'
-- Occasion, Birth cards (boy) -->Occasion, New Baby
UNION ALL SELECT 1143737029, 'occasion-new-baby', 'Occasion'
-- Occasion, Birth premature -->Occasion, New Baby
UNION ALL SELECT 1143754595, 'occasion-new-baby', 'Occasion'
-- Occasion, Birth rainbow child -->Occasion, New Baby
UNION ALL SELECT 1143754601, 'occasion-new-baby', 'Occasion'
-- Occasion, Birth with handicap -->Occasion, New Baby
UNION ALL SELECT 1143754598, 'occasion-new-baby', 'Occasion'
-- Occasion, Birthday -->Occasion, Birthday
UNION ALL SELECT 726324105, 'occasion-birthday', 'Occasion'
-- Occasion, Birthday belated Wishes -->Occasion, Belated Birthday
UNION ALL SELECT 735869180, 'belated-birthday', 'Occasion'
-- Occasion, Beautiful moments -->Occasion, Just to Say
UNION ALL SELECT 1143766253, 'just-to-say', 'Occasion'
-- Occasion, Babyshower (invitations cardhouse) -->Occasion, Baby Shower
UNION ALL SELECT 1143734414, 'baby-shower', 'Occasion'
-- Occasion, Fathersday beercards -->Occasion, Father's Day
UNION ALL SELECT 1143746600, 'fathers-day', 'Occasion'
-- Occasion, Easter/Pasen -->Occasion, Easter
UNION ALL SELECT 726343205, 'occasion-easter', 'Occasion'
-- Occasion, Good luck -->Occasion, Good Luck
UNION ALL SELECT 726345736, 'occasion-good-luck', 'Occasion'
-- Occasion, Engaged -->Occasion, Engagement
UNION ALL SELECT 735870409, 'occasion-engagement', 'Occasion'
-- Occasion, Exam party (invitations) -->Occasion, Exams
UNION ALL SELECT 1143728946, 'occasion-exams', 'Occasion'
-- Occasion, Extra special -->Occasion, Pregnancy
UNION ALL SELECT 1143761028, 'occasion-pregnancy', 'Occasion'
-- Occasion, Failed -->Occasion, Empathy
UNION ALL SELECT 748506030, 'empathy', 'Occasion'
-- Occasion, Friendship2 -->Occasion, Friendship
UNION ALL SELECT 893069562, 'occasion-friendship', 'Occasion'
-- Occasion, Get well welcome home -->Occasion, Get Well
UNION ALL SELECT 1143742088, 'occasion-get-well', 'Occasion'
-- Occasion, Driving License graduated -->Occasion, Driving Test
UNION ALL SELECT 735934096, 'occasion-driving-test', 'Occasion'
-- Occasion, Fathersday best sold -->Occasion, Father's Day
UNION ALL SELECT 1143735068, 'fathers-day', 'Occasion'
-- Occasion, Fathersday thinking of you -->Occasion, Father's Day
UNION ALL SELECT 1143749723, 'fathers-day', 'Occasion'
-- Occasion, First Father's day -->Occasion, Father's Day
UNION ALL SELECT 1143737236, 'fathers-day', 'Occasion'
-- Occasion, Get well -->Occasion, Get Well
UNION ALL SELECT 726345521, 'occasion-get-well', 'Occasion'
-- Occasion, First mothersday -->Occasion, Mothers' Day
UNION ALL SELECT 1143749468, 'mothers-day', 'Occasion'
-- Occasion, Gender reveal party (invitations) -->Occasion, Pregnancy
UNION ALL SELECT 1143739140, 'occasion-pregnancy', 'Occasion'
-- Occasion, Gay marriage -->Occasion, Wedding
UNION ALL SELECT 1143732593, 'occasion-wedding', 'Occasion'
-- Occasion, Fathersday -->Occasion, Father's Day
UNION ALL SELECT 726332069, 'fathers-day', 'Occasion'
-- Occasion, Day of the animals -->Occasion, Other
UNION ALL SELECT 735910080, 'occasion-other', 'Occasion'
-- Occasion, Condolence -->Occasion, Sympathy
UNION ALL SELECT 726345401, 'occasion-sympathy', 'Occasion'
-- Occasion, Condolence pet -->Occasion, Sympathy
UNION ALL SELECT 1143754053, 'occasion-sympathy', 'Occasion'
-- Occasion, Condolence with text -->Occasion, Sympathy
UNION ALL SELECT 1143743715, 'occasion-sympathy', 'Occasion'
-- Occasion, Condolence without text -->Occasion, Sympathy
UNION ALL SELECT 1143743712, 'occasion-sympathy', 'Occasion'
-- Occasion, Confirmation -->Occasion, Confirmation
UNION ALL SELECT 727249045, 'newia-occasion-confirmation', 'Occasion'
-- Occasion, Congratulations (card and gift) -->Occasion, Congratulations
UNION ALL SELECT 1143729948, 'occasion-congratulations', 'Occasion'
-- Occasion, Course completed -->Occasion, Graduation
UNION ALL SELECT 1143754866, 'occasion-graduation', 'Occasion'
-- Occasion, Baptism and communion (invitations) -->Occasion, Christening
UNION ALL SELECT 1143728949, 'christening', 'Occasion'
-- Occasion, Communion -->Occasion, Communion
UNION ALL SELECT 735930784, 'communion', 'Occasion'
-- Occasion, Day of the daycare -->Occasion, Other
UNION ALL SELECT 1143750698, 'occasion-other', 'Occasion'
-- Occasion, Divorce -->Occasion, Empathy
UNION ALL SELECT 1143754400, 'empathy', 'Occasion'
-- Occasion, Driving License extended -->Occasion, Driving Test
UNION ALL SELECT 1143754863, 'occasion-driving-test', 'Occasion'
-- Occasion, Day of caregiving -->Occasion, Other
UNION ALL SELECT 1143763418, 'occasion-other', 'Occasion'
-- Occasion, married 30 years -->Occasion>Anniversaries, 30th Pearl
UNION ALL SELECT 1143735020, '30th-pearl', 'Occasion>Anniversaries'
-- Occasion, married 25 years -->Occasion>Anniversaries, 25th Silver
UNION ALL SELECT 1143735011, '25th-silver', 'Occasion>Anniversaries'
-- Occasion, married 35 years -->Occasion>Anniversaries, All Anniversaries
UNION ALL SELECT 1143735038, 'all-anniversaries', 'Occasion>Anniversaries'
-- Occasion, married 50 years -->Occasion>Anniversaries, 50th Gold
UNION ALL SELECT 1143735017, '50th-gold', 'Occasion>Anniversaries'
-- Occasion, married 12.5 years -->Occasion>Anniversaries, 12th Silk
UNION ALL SELECT 1143735008, '12th-silk', 'Occasion>Anniversaries'
-- Occasion, married 10 years -->Occasion>Anniversaries, 10th Tin
UNION ALL SELECT 1143735023, '10th-tin', 'Occasion>Anniversaries'
-- Occasion, married 5 years -->Occasion>Anniversaries, 5th Wood
UNION ALL SELECT 1143735026, '5th-wood', 'Occasion>Anniversaries'
-- Occasion, married 40 years -->Occasion>Anniversaries, 40th Ruby
UNION ALL SELECT 1143735014, '40th-ruby', 'Occasion>Anniversaries'
-- Occasion, Hanukkah -->Religious Occasions, Hanukkah
UNION ALL SELECT 1143764508, 'hanukkah', 'Religious Occasions'
-- Occasion, Eid Mubarak * Suikerfeest -->Religious Occasions, Eid Mubarak
UNION ALL SELECT 1143746767, 'eid-mubarak', 'Religious Occasions'
-- Occasion, Eid al Adha * Offerfeest -->Religious Occasions, Eid al Adha
UNION ALL SELECT 1143769648, 'eid-al-adha', 'Religious Occasions'
-- Theme, Retro and vintage -->Sentiment & Style, Vintage
UNION ALL SELECT 1143762763, 'vintage', 'Sentiment & Style'
-- Theme, Flowers and abloom (cards missions) -->Sentiment & Style, Floral
UNION ALL SELECT 1143751184, 'sentiment-style-floral', 'Sentiment & Style'
-- Occasion, Wedding -->Sentiment & Style, Love
UNION ALL SELECT 726342081, 'sentiment-style-love', 'Sentiment & Style'
-- Theme, Retro and vintage -->Sentiment & Style, Retro
UNION ALL SELECT 1143762763, 'sentiment-style-retro', 'Sentiment & Style'
-- Theme, Art (cards missions) -->Sentiment & Style, Artistic
UNION ALL SELECT 1143751229, 'artistic', 'Sentiment & Style'
-- Theme, Artistic (cards missions) -->Sentiment & Style, Artistic
UNION ALL SELECT 1143754265, 'artistic', 'Sentiment & Style'
-- Theme, Humor (cards missions) -->Sentiment & Style, Funny
UNION ALL SELECT 1143751232, 'sentiment-style-funny', 'Sentiment & Style'
-- Theme, Illustrations (cards missions) -->Sentiment & Style, Illustration
UNION ALL SELECT 1143751235, 'illustration', 'Sentiment & Style'
-- Occasion, Wedding invitation (Wedding) -->Sentiment & Style, Love
UNION ALL SELECT 1143728795, 'sentiment-style-love', 'Sentiment & Style'
-- Occasion, Swimming diploma -->Sentiment & Style, Congratulations
UNION ALL SELECT 1143742376, 'sentiment-style-congratulations', 'Sentiment & Style'
-- Occasion, Course completed -->Sentiment & Style, Congratulations
UNION ALL SELECT 1143754866, 'sentiment-style-congratulations', 'Sentiment & Style'
-- Occasion, Congratulations (card and gift) -->Sentiment & Style, Congratulations
UNION ALL SELECT 1143729948, 'sentiment-style-congratulations', 'Sentiment & Style'
-- Occasion, Christmas humor -->Sentiment & Style, Funny
UNION ALL SELECT 1143750638, 'sentiment-style-funny', 'Sentiment & Style'
-- Occasion, Birthday belated Wishes -->Sentiment & Style, Belated
UNION ALL SELECT 735869180, 'belated', 'Sentiment & Style'
-- Occasion, Gay marriage -->Sentiment & Style, LGBTQ+
UNION ALL SELECT 1143732593, 'lgbtq', 'Sentiment & Style'
-- Theme, Text and poems (cards missions) -->Sentiment & Style, Verse
UNION ALL SELECT 1143751073, 'verse', 'Sentiment & Style'
-- Occasion, Just Married -->Sentiment & Style, Love
UNION ALL SELECT 1143732220, 'sentiment-style-love', 'Sentiment & Style'
-- Occasion, Honeymoon -->Sentiment & Style, Love
UNION ALL SELECT 1143754640, 'sentiment-style-love', 'Sentiment & Style'
-- Occasion, Love -->Sentiment & Style, Love
UNION ALL SELECT 1143727832, 'sentiment-style-love', 'Sentiment & Style'
-- Theme, Animals (cards missions) -->Topic, Animals
UNION ALL SELECT 1143727287, 'topic-animals', 'Topic'
-- Theme, Corona (cards missions) -->Trending Topics & Celebs, Covid 
UNION ALL SELECT 1143751217, 'covid', 'Trending Topics & Celebs'
-- Target Group, Parents -->Who's It for?, Parents
UNION ALL SELECT 1143754622, 'parents', 'Who''s It for?'
-- Target Group, Neutral Adult -->Who's It for?, For Him
UNION ALL SELECT 1143766578, 'for-him', 'Who''s It for?'
-- Target Group, Boy and girl -->Who's it for?, Twins
UNION ALL SELECT 1143764788, 'whos-it-for-twins', 'Who''s it for?'
-- Target Group, Other half woman -->Who's It for?, Wife
UNION ALL SELECT 1143750950, 'whos-it-for-wife', 'Who''s It for?'
-- Target Group, Other half man -->Who's It for?, Husband
UNION ALL SELECT 1143750968, 'whos-it-for-husband', 'Who''s It for?'
-- Target Group, Sarah -->Who's It for?, For Her
UNION ALL SELECT 1143750962, 'for-her', 'Who''s It for?'
-- Target Group, Niece -->Who's It for?, Niece
UNION ALL SELECT 1143758188, 'whos-it-for-niece', 'Who''s It for?'
-- Target Group, Sister -->Who's it for?, Sister
UNION ALL SELECT 1143742574, 'whos-it-for-sister', 'Who''s it for?'
-- Target Group, Neutral Adult -->Who's It for?, For Her
UNION ALL SELECT 1143766578, 'for-her', 'Who''s It for?'
-- Target Group, Neutral -->Who's It for?, For Her
UNION ALL SELECT 1143755247, 'for-her', 'Who''s It for?'
-- Target Group, Neutral -->Who's It for?, For Him
UNION ALL SELECT 1143755247, 'for-him', 'Who''s It for?'
-- Target Group, Nephew -->Who's It for?, Nephew
UNION ALL SELECT 1143758208, 'whos-it-for-nephew', 'Who''s It for?'
-- Target Group, Mothers -->Who's It for?, LGBTQ+
UNION ALL SELECT 1143764758, 'whos-it-for-lgbtq', 'Who''s It for?'
-- Target Group, Mothers -->Who's It for?, Parents
UNION ALL SELECT 1143764758, 'parents', 'Who''s It for?'
-- Target Group, Neutral Child -->Who's It for?, For Kids
UNION ALL SELECT 1143766583, 'whos-it-for-for-kids', 'Who''s It for?'
-- Target Group, Fathers -->Who's It for?, LGBTQ+
UNION ALL SELECT 1143764753, 'whos-it-for-lgbtq', 'Who''s It for?'
-- Target Group, Mother -->Who's It for?, Mum
UNION ALL SELECT 1143739125, 'whos-it-for-mum', 'Who''s It for?'
-- Target Group, Bonus dad -->Who's It for?, Step Dad
UNION ALL SELECT 1143749726, 'step-dad', 'Who''s It for?'
-- Target Group, Fathers -->Who's It for?, Parents
UNION ALL SELECT 1143764753, 'parents', 'Who''s It for?'
-- Target Group, Father and mother -->Who's It for?, Mum and Dad
UNION ALL SELECT 1143764763, 'mum-and-dad', 'Who''s It for?'
-- Target Group, Father -->Who's it for?, Dad
UNION ALL SELECT 1143739704, 'whos-it-for-dad', 'Who''s it for?'
-- Target Group, Women -->Who's it for?, For Her
UNION ALL SELECT 1143750947, 'for-her', 'Who''s it for?'
-- Target Group, Daughter -->Who's It for?, Daughter
UNION ALL SELECT 1143750944, 'whos-it-for-daughter', 'Who''s It for?'
-- Target Group, Son -->Who's It for?, Son
UNION ALL SELECT 1143750959, 'whos-it-for-son', 'Who''s It for?'
-- Target Group, Friend man -->Who's It for?, For Him
UNION ALL SELECT 1143750971, 'for-him', 'Who''s It for?'
-- Target Group, Father and mother -->Who's It for?, Parents
UNION ALL SELECT 1143764763, 'parents', 'Who''s It for?'
-- Target Group, Zakelijk1 (cards missions) -->Who's it For?, Other
UNION ALL SELECT 1143732725, 'whos-it-for-other', 'Who''s it For?'
-- Target Group, Woman general -->Who's It for?, For Her
UNION ALL SELECT 1143755250, 'for-her', 'Who''s It for?'
-- Target Group, Uncle -->Who's It for?, Uncle
UNION ALL SELECT 1143753107, 'whos-it-for-uncle', 'Who''s It for?'
-- Target Group, Twins and Multiple (Birth) -->Who's It for?, Twins
UNION ALL SELECT 886602868, 'whos-it-for-twins', 'Who''s It for?'
-- Target Group, Employee -->Who's It for?, Colleague
UNION ALL SELECT 1143751274, 'colleague', 'Who''s It for?'
-- Target Group, Colleague -->Who's it for?, Colleague
UNION ALL SELECT 1143742085, 'colleague', 'Who''s it for?'
-- Target Group, Boy -->Who's it for?, For Boys
UNION ALL SELECT 886506339, 'for-boys', 'Who''s it for?'
-- Target Group, Friend woman -->Who's It for?, Friend
UNION ALL SELECT 1143750953, 'friend', 'Who''s It for?'
-- Target Group, Friend woman -->Who's It for?, For Her
UNION ALL SELECT 1143750953, 'for-her', 'Who''s It for?'
-- Target Group, Friend man -->Who's It for?, Friend
UNION ALL SELECT 1143750971, 'friend', 'Who''s It for?'
-- Target Group, Bonus mother -->Who's It for?, Step Mum
UNION ALL SELECT 1143749543, 'step-mum', 'Who''s It for?'
-- Target Group, Aunt -->Who's It for?, Auntie
UNION ALL SELECT 1143753146, 'whos-it-for-auntie', 'Who''s It for?'
-- Target Group, Boys -->Who's It for?, For Boys
UNION ALL SELECT 1143742982, 'for-boys', 'Who''s It for?'
-- Target Group, Boys -->Who's It for?, Twins
UNION ALL SELECT 1143742982, 'whos-it-for-twins', 'Who''s It for?'
-- Target Group, Girl general -->Who's It for?, For Girls
UNION ALL SELECT 1143758718, 'for-girls', 'Who''s It for?'
-- Target Group, Brand new mom -->Who's It for?, Mum
UNION ALL SELECT 1143749549, 'whos-it-for-mum', 'Who''s It for?'
-- Target Group, Girls -->Who's It for?, Twins
UNION ALL SELECT 1143742985, 'whos-it-for-twins', 'Who''s It for?'
-- Target Group, Boy general -->Who's It for?, For Boys
UNION ALL SELECT 1143758723, 'for-boys', 'Who''s It for?'
-- Occasion, Grandparents day -->Who's It for?, Other
UNION ALL SELECT 1143732211, 'whos-it-for-other', 'Who''s It for?'
-- Occasion, Grandparents day -->Who's It for?, Grandparents
UNION ALL SELECT 1143732211, 'grandparents', 'Who''s It for?'
-- Occasion, Gay marriage -->Who's it for?, LGBTQ+
UNION ALL SELECT 1143732593, 'whos-it-for-lgbtq', 'Who''s it for?'
-- Target Group, Brother -->Who's it for?, Brother
UNION ALL SELECT 1143742571, 'whos-it-for-brother', 'Who''s it for?'
-- Occasion, Thank you teacher -->Who's It for?, Teacher
UNION ALL SELECT 1143742415, 'teacher', 'Who''s It for?'
-- Occasion, Childrens party (invitations) -->Who's It for?, For Kids
UNION ALL SELECT 1143728928, 'whos-it-for-for-kids', 'Who''s It for?'
-- Occasion, Christmas Business (IA) -->Who's It for?, Colleague
UNION ALL SELECT 1143734990, 'colleague', 'Who''s It for?'
-- Target Group, Brand new dad -->Who's It for?, Dad
UNION ALL SELECT 1143749747, 'whos-it-for-dad', 'Who''s It for?'
-- Target Group, LHBTIQ+ -->Who's It for?, LGBTQ+
UNION ALL SELECT 1143765418, 'whos-it-for-lgbtq', 'Who''s It for?'
-- Target Group, Men general -->Who's It for?, For Him
UNION ALL SELECT 1143755253, 'for-him', 'Who''s It for?'
-- Target Group, Men -->Who's it for?, For Him
UNION ALL SELECT 1143750956, 'for-him', 'Who''s it for?'
-- Target Group, Little son -->Who's It for?, Son
UNION ALL SELECT 1143758818, 'whos-it-for-son', 'Who''s It for?'
-- Target Group, Little sister -->Who's It for?, Sister
UNION ALL SELECT 1143754568, 'whos-it-for-sister', 'Who''s It for?'
-- Target Group, Little niece -->Who's It for?, Niece
UNION ALL SELECT 1143758798, 'whos-it-for-niece', 'Who''s It for?'
-- Target Group, Little nephew -->Who's It for?, Nephew
UNION ALL SELECT 1143758803, 'whos-it-for-nephew', 'Who''s It for?'
-- Target Group, Little grandson -->Who's It for?, Grandson
UNION ALL SELECT 1143757858, 'whos-it-for-grandson', 'Who''s It for?'
-- Target Group, Little granddaughter -->Who's It for?, Granddaughter
UNION ALL SELECT 1143757863, 'whos-it-for-granddaughter', 'Who''s It for?'
-- Target Group, Girl -->Who's it for?, For Girls
UNION ALL SELECT 886507052, 'for-girls', 'Who''s it for?'
-- Target Group, Little brother -->Who's It for?, Brother
UNION ALL SELECT 1143754571, 'whos-it-for-brother', 'Who''s It for?'
-- Target Group, Mommy to be -->Who's It for?, Mum to be
UNION ALL SELECT 1143749546, 'mum-to-be', 'Who''s It for?'
-- Target Group, Grandson -->Who's It for?, Grandson
UNION ALL SELECT 1143758998, 'whos-it-for-grandson', 'Who''s It for?'
-- Target Group, Grandparents (Card only) -->Who's It for?, Grandparents
UNION ALL SELECT 1143729717, 'grandparents', 'Who''s It for?'
-- Target Group, Grandmother -->Who's It for?, Grandma
UNION ALL SELECT 1143742568, 'grandma', 'Who''s It for?'
-- Target Group, Grandfather -->Who's It for?, Grandad
UNION ALL SELECT 1143742565, 'whos-it-for-grandad', 'Who''s It for?'
-- Target Group, Granddaughter -->Who's It for?, Granddaughter
UNION ALL SELECT 1143759003, 'whos-it-for-granddaughter', 'Who''s It for?'
-- Target Group, Godmother -->Who's It for?, Godmother
UNION ALL SELECT 1143764728, 'godmother', 'Who''s It for?'
-- Target Group, Godfather -->Who's It for?, Godfather
UNION ALL SELECT 1143764733, 'godfather', 'Who''s It for?'
-- Target Group, Daddy to be -->Who's It for?, Daddy To Be
UNION ALL SELECT 1143749750, 'daddy-to-be', 'Who''s It for?'
-- Target Group, Little daughter -->Who's It for?, Daughter
UNION ALL SELECT 1143758823, 'whos-it-for-daughter', 'Who''s It for?'

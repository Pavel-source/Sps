CREATE OR REPLACE VIEW type_to_category_view 
AS
-- Beer, No  ->  Gifts & Flowers>Food & Drinks>Alcohol>Beer & Cider
SELECT 539691144 AS GreetzTypeID, 'Beer-Cider' AS CategoryCode
-- Beverage, No  ->  Gifts & Flowers>Food & Drinks>Alcohol
UNION ALL SELECT 5, 'Alcohol'
-- Beverage, Beer  ->  Gifts & Flowers>Food & Drinks>Alcohol>Beer & Cider
UNION ALL SELECT 34, 'Beer-Cider'
-- Beverage, Bubbles  ->  Gifts & Flowers>Food & Drinks>Alcohol>Prosecco
UNION ALL SELECT 77, 'Prosecco'
-- Beverage, Wine  ->  Gifts & Flowers>Food & Drinks>Alcohol>Wine
UNION ALL SELECT 80, 'Wine'
-- Beverage, Wine and Champagne  ->  Gifts & Flowers>Food & Drinks>Alcohol>Champagne
UNION ALL SELECT 36, 'Champagne'
-- Spirits, No  ->  Gifts & Flowers>Food & Drinks>Alcohol>Spirits
UNION ALL SELECT 1019297473, 'Spirits'
-- Wine, No  ->  Gifts & Flowers>Food & Drinks>Alcohol>Wine
UNION ALL SELECT 398498546, 'Wine'
-- Ballon, No  ->  Gifts & Flowers>Home & Lifestyle>Balloons
UNION ALL SELECT 398498543, 'Balloons'
-- Balloons, No  ->  Gifts & Flowers>Home & Lifestyle>Balloons
UNION ALL SELECT 3, 'Balloons'
-- Balloons, Bubble  ->  Gifts & Flowers>Home & Lifestyle>Balloons
UNION ALL SELECT 28, 'Balloons'
-- Balloons, Foil  ->  Gifts & Flowers>Home & Lifestyle>Balloons
UNION ALL SELECT 29, 'Balloons'
-- Balloons, Juniorshape  ->  Gifts & Flowers>Home & Lifestyle>Balloons
UNION ALL SELECT 30, 'Balloons'
-- Balloons, Number  ->  Gifts & Flowers>Home & Lifestyle>Balloons
UNION ALL SELECT 31, 'Balloons'
-- Balloons, Supershape  ->  Gifts & Flowers>Home & Lifestyle>Balloons
UNION ALL SELECT 32, 'Balloons'
-- Personalised_Balloon, No  ->  Gifts & Flowers>Home & Lifestyle>Balloons
UNION ALL SELECT 1019297406, 'Balloons'
-- Beauty_Parcel, No  ->  Gifts & Flowers>Home & Lifestyle>Jewellery, Beauty & Accessories>Beauty
UNION ALL SELECT 977853097, 'Beauty'
-- Beauty_Post, No  ->  Gifts & Flowers>Home & Lifestyle>Jewellery, Beauty & Accessories>Beauty
UNION ALL SELECT 398498547, 'Beauty'
-- Brownies Postal, No  ->  Gifts & Flowers>Food & Drinks>Confectionery>Other Confectionery
UNION ALL SELECT 1019297454, 'Other-Confectionery'
-- Books, No  ->  Gifts & Flowers>Home & Lifestyle>Books>Adult Books
UNION ALL SELECT 6, 'Adults-Books'
-- Books, Bioact  ->  Gifts & Flowers>Home & Lifestyle>Books>Adult Books
UNION ALL SELECT 126, 'Adults-Books'
-- Books, Body en mind  ->  Gifts & Flowers>Home & Lifestyle>Books>Adult Books
UNION ALL SELECT 129, 'Adults-Books'
-- Books, Hobbyboeken  ->  Gifts & Flowers>Home & Lifestyle>Books>Adult Books
UNION ALL SELECT 153, 'Adults-Books'
-- Books, Kinderboeken  ->  Gifts & Flowers>Home & Lifestyle>Books>Kids Books
UNION ALL SELECT 135, 'Kids-Books'
-- Books, Koffietafelboeken  ->  Gifts & Flowers>Home & Lifestyle>Books>Adult Books
UNION ALL SELECT 138, 'Adults-Books'
-- Books, Kookboeken  ->  Gifts & Flowers>Home & Lifestyle>Books>Adult Books
UNION ALL SELECT 132, 'Adults-Books'
-- Books, Liefde en vriendschap  ->  Gifts & Flowers>Home & Lifestyle>Books>Adult Books
UNION ALL SELECT 141, 'Adults-Books'
-- Books, Managementboeken  ->  Gifts & Flowers>Home & Lifestyle>Books>Adult Books
UNION ALL SELECT 144, 'Adults-Books'
-- Books, Reizen  ->  Gifts & Flowers>Home & Lifestyle>Books>Adult Books
UNION ALL SELECT 147, 'Adults-Books'
-- Books, Roman  ->  Gifts & Flowers>Home & Lifestyle>Books>Adult Books
UNION ALL SELECT 150, 'Adults-Books'
-- Books, Thriller  ->  Gifts & Flowers>Home & Lifestyle>Books>Adult Books
UNION ALL SELECT 43, 'Adults-Books'
-- Books, VERWIJDERD  ->  Gifts & Flowers>Home & Lifestyle>Books>Adult Books
UNION ALL SELECT 41, 'Adults-Books'
-- Books, VERWIJDERD  ->  Gifts & Flowers>Home & Lifestyle>Books>Adult Books
UNION ALL SELECT 40, 'Adults-Books'
-- Books, VERWIJDERD  ->  Gifts & Flowers>Home & Lifestyle>Books>Adult Books
UNION ALL SELECT 39, 'Adults-Books'
-- Books, VERWIJDERD  ->  Gifts & Flowers>Home & Lifestyle>Books>Adult Books
UNION ALL SELECT 38, 'Adults-Books'
-- Books, VERWIJDERD  ->  Gifts & Flowers>Home & Lifestyle>Books>Adult Books
UNION ALL SELECT 42, 'Adults-Books'
-- Books, Youngadult  ->  Gifts & Flowers>Home & Lifestyle>Books>Adult Books
UNION ALL SELECT 156, 'Adults-Books'
-- Books, Zwangerschap  ->  Gifts & Flowers>Home & Lifestyle>Books>Adult Books
UNION ALL SELECT 123, 'Adults-Books'
-- Books_Parcel, No  ->  Gifts & Flowers>Home & Lifestyle>Books>Adult Books
UNION ALL SELECT 1019297568, 'Adults-Books'
-- Books_Postal, No  ->  Gifts & Flowers>Home & Lifestyle>Books>Adult Books
UNION ALL SELECT 1019297565, 'Adults-Books'
-- Cake, No  ->  Gifts & Flowers>Food & Drinks>Confectionery>Other Confectionery
UNION ALL SELECT 1019297448, 'Other-Confectionery'
-- cake_ongekoeld, No  ->  Gifts & Flowers>Food & Drinks>Confectionery>Other Confectionery
UNION ALL SELECT 1019297487, 'Other-Confectionery'
-- Food, Cakes  ->  Gifts & Flowers>Food & Drinks>Confectionery>Other Confectionery
UNION ALL SELECT 117, 'Other-Confectionery'
-- Personalised_Cake, No  ->  Gifts & Flowers>Food & Drinks>Confectionery>Other Confectionery
UNION ALL SELECT 1019297463, 'Other-Confectionery'
-- Chocolate, No  ->  Gifts & Flowers>Food & Drinks>Confectionery>Chocolate
UNION ALL SELECT 398498538, 'Chocolate'
-- Chocolate Telegram, No  ->  Gifts & Flowers>Food & Drinks>Confectionery>Chocolate
UNION ALL SELECT 398498540, 'Chocolate'
-- Chocolate_Parcel, No  ->  Gifts & Flowers>Food & Drinks>Confectionery>Chocolate
UNION ALL SELECT 1019297423, 'Chocolate'
-- Food, Chocolate  ->  Gifts & Flowers>Food & Drinks>Confectionery>Chocolate
UNION ALL SELECT 46, 'Chocolate'
-- Bloom post, No  ->  Gifts & Flowers>Flowers & Plants>Flowers
UNION ALL SELECT 1019297407, 'Flowers'
-- Combi Flowers/Beverage, No  ->  Gifts & Flowers>Flowers & Plants>Flowers
UNION ALL SELECT 1019297633, 'Flowers'
-- Flowers, No  ->  Gifts & Flowers>Flowers & Plants>Flowers
UNION ALL SELECT 7, 'Flowers'
-- Flowers, No  ->  Gifts & Flowers>Flowers & Plants>Flowers
UNION ALL SELECT 398498541, 'Flowers'
-- Flowers, Bouquet  ->  Gifts & Flowers>Flowers & Plants>Flowers
UNION ALL SELECT 44, 'Flowers'
-- Flowers, Mono  ->  Gifts & Flowers>Flowers & Plants>Flowers
UNION ALL SELECT 45, 'Flowers'
-- Flowers, Plant  ->  Gifts & Flowers>Flowers & Plants>Plants
UNION ALL SELECT 83, 'Plants'
-- Accessories, Gadgets  ->  Gifts & Flowers>Home & Lifestyle>Gadgets>Novelty
UNION ALL SELECT 13, 'Novelty'
-- Giftcards, No  ->  Gifts & Flowers>Home & Lifestyle>Gift Cards
UNION ALL SELECT 291, 'Gift-Cards'
-- Giftcards, No  ->  Gifts & Flowers>Home & Lifestyle>Gift Cards
UNION ALL SELECT 698660314, 'Gift-Cards'
-- accessoires parcel, No  ->  Gifts & Flowers>Home & Lifestyle>Jewellery, Beauty & Accessories>Jewellery & Accessories
UNION ALL SELECT 1019297625, 'Jewellery-Accessories'
-- accessoires postal, No  ->  Gifts & Flowers>Home & Lifestyle>Jewellery, Beauty & Accessories>Jewellery & Accessories
UNION ALL SELECT 1019297628, 'Jewellery-Accessories'
-- Accessories, No  ->  Gifts & Flowers>Home & Lifestyle>Jewellery, Beauty & Accessories>Jewellery & Accessories
UNION ALL SELECT 1, 'Jewellery-Accessories'
-- Accessories, Baking  ->  Gifts & Flowers>Home & Lifestyle>Home & Garden>Home
UNION ALL SELECT 9, 'Home'
-- Accessories, Candles and candlesticks  ->  Gifts & Flowers>Home & Lifestyle>Home & Garden>Home
UNION ALL SELECT 10, 'Home'
-- Accessories, Cutlery  ->  Gifts & Flowers>Home & Lifestyle>Home & Garden>Home
UNION ALL SELECT 11, 'Home'
-- Accessories, Fashion accessories  ->  Gifts & Flowers>Home & Lifestyle>Jewellery, Beauty & Accessories>Jewellery & Accessories
UNION ALL SELECT 12, 'Jewellery-Accessories'
-- Accessories, Glasses and mugs  ->  Gifts & Flowers>Home & Lifestyle>Home & Garden>Home
UNION ALL SELECT 14, 'Home'
-- Accessories, Home fragrance  ->  Gifts & Flowers>Home & Lifestyle>Home & Garden>Home
UNION ALL SELECT 15, 'Home'
-- Accessories, Kitchen accessories  ->  Gifts & Flowers>Home & Lifestyle>Home & Garden>Home
UNION ALL SELECT 16, 'Home'
-- Accessories, Kitchen and table textile  ->  Gifts & Flowers>Home & Lifestyle>Home & Garden>Home
UNION ALL SELECT 17, 'Home'
-- Accessories, Living accessories  ->  Gifts & Flowers>Home & Lifestyle>Home & Garden>Home
UNION ALL SELECT 18, 'Home'
-- Accessories, Office accessories  ->  Gifts & Flowers>Home & Lifestyle>Home & Garden>Home
UNION ALL SELECT 19, 'Home'
-- Accessories, Personalised Covers  ->  Gifts & Flowers>Home & Lifestyle>Home & Garden>Home
UNION ALL SELECT 20, 'Home'
-- Accessories, Personalised Photoframes  ->  Gifts & Flowers>Home & Lifestyle>Home & Garden>Home
UNION ALL SELECT 50, 'Home'
-- Accessories, Table Accessories  ->  Gifts & Flowers>Home & Lifestyle>Home & Garden>Home
UNION ALL SELECT 22, 'Home'
-- Accessories, Travel accessories  ->  Gifts & Flowers>Home & Lifestyle>Home & Garden>Home
UNION ALL SELECT 23, 'Home'
-- Accessories, Wine accessories  ->  Gifts & Flowers>Home & Lifestyle>Home & Garden>Home
UNION ALL SELECT 24, 'Home'
-- Baby shower gifts, No  ->  Gifts & Flowers>Home & Lifestyle>Toys & Games>Soft Toys
UNION ALL SELECT 56, 'Soft-Toys'
-- Baby shower gifts, Baby shower gifts  ->  Gifts & Flowers>Home & Lifestyle>Toys & Games>Soft Toys
UNION ALL SELECT 68, 'Soft-Toys'
-- Baby shower gifts, Clothing  ->  Gifts & Flowers>Home & Lifestyle>Apparel
UNION ALL SELECT 74, 'Apparel'
-- Baby_Parcel, No  ->  Gifts & Flowers>Home & Lifestyle>Toys & Games>Soft Toys
UNION ALL SELECT 1019297505, 'Soft-Toys'
-- Baby_Postal, No  ->  Gifts & Flowers>Home & Lifestyle>Toys & Games>Soft Toys
UNION ALL SELECT 1019297499, 'Soft-Toys'
-- Bakmix Postal, No  ->  Gifts & Flowers>Food & Drinks>Confectionery>Other Confectionery
UNION ALL SELECT 1019297559, 'Other-Confectionery'
-- Bakmix_Parcel, No  ->  Gifts & Flowers>Food & Drinks>Confectionery>Other Confectionery
UNION ALL SELECT 1019297551, 'Other-Confectionery'
-- Beverage, Tea  ->  Gifts & Flowers>Food & Drinks
UNION ALL SELECT 35, 'Food-Drinks'
-- Blond Amsterdam, No  ->  Gifts & Flowers>Home & Lifestyle>Home & Garden>Home
UNION ALL SELECT 614889575, 'Home'
-- Eten & Drinken, No  ->  Gifts & Flowers>Food & Drinks
UNION ALL SELECT 201, 'Food-Drinks'
-- Eten & Drinken, Kinderservies  ->  Gifts & Flowers>Food & Drinks
UNION ALL SELECT 285, 'Food-Drinks'
-- Eten & Drinken, Lunchboxen & drinkbekers  ->  Gifts & Flowers>Food & Drinks
UNION ALL SELECT 288, 'Food-Drinks'
-- Homeware parcel, No  ->  Gifts & Flowers>Home & Lifestyle>Home & Garden>Home
UNION ALL SELECT 1019297653, 'Home'
-- Homeware postal, No  ->  Gifts & Flowers>Home & Lifestyle>Home & Garden>Home
UNION ALL SELECT 1019297658, 'Home'
-- Kinderboekjes, No  ->  Gifts & Flowers>Home & Lifestyle>Books>Kids Books
UNION ALL SELECT 192, 'Kids-Books'
-- Kleding, No  ->  Gifts & Flowers>Home & Lifestyle>Apparel
UNION ALL SELECT 264, 'Apparel'
-- Kleding, Broekjes  ->  Gifts & Flowers>Home & Lifestyle>Apparel
UNION ALL SELECT 267, 'Apparel'
-- Kleding, Jurkjes  ->  Gifts & Flowers>Home & Lifestyle>Apparel
UNION ALL SELECT 270, 'Apparel'
-- Kleding, Mutsjes  ->  Gifts & Flowers>Home & Lifestyle>Apparel
UNION ALL SELECT 297, 'Apparel'
-- Kleding, Rompertjes  ->  Gifts & Flowers>Home & Lifestyle>Apparel
UNION ALL SELECT 279, 'Apparel'
-- Kleding, Shirtjes  ->  Gifts & Flowers>Home & Lifestyle>Apparel
UNION ALL SELECT 273, 'Apparel'
-- Kleding, Slabbetjes  ->  Gifts & Flowers>Home & Lifestyle>Apparel
UNION ALL SELECT 276, 'Apparel'
-- Kleding, Sokjes & Schoentjes  ->  Gifts & Flowers>Home & Lifestyle>Apparel
UNION ALL SELECT 282, 'Apparel'
-- Mug, No  ->  Gifts & Flowers>Home & Lifestyle>Home & Garden>Mugs
UNION ALL SELECT 618219530, 'Mugs'
-- Mug standaard, No  ->  Gifts & Flowers>Home & Lifestyle>Home & Garden>Mugs
UNION ALL SELECT 1019297594, 'Mugs'
-- Non alcohol, No  ->  Gifts & Flowers>Food & Drinks
UNION ALL SELECT 1019297479, 'Food-Drinks'
-- Personalised_Baby_Embroidery_Parcel, No  ->  Gifts & Flowers>Home & Lifestyle>Toys & Games>Soft Toys
UNION ALL SELECT 1019297511, 'Soft-Toys'
-- Personalised_Baby_Embroidery_Postal, No  ->  Gifts & Flowers>Home & Lifestyle>Toys & Games>Soft Toys
UNION ALL SELECT 1019297508, 'Soft-Toys'
-- Personalised_Baby_Embroidery_Postal_Packs, No  ->  Gifts & Flowers>Home & Lifestyle>Toys & Games>Soft Toys
UNION ALL SELECT 1019297621, 'Soft-Toys'
-- Personalised_Baby_Sleeve_Parcel, No  ->  Gifts & Flowers>Home & Lifestyle>Toys & Games>Soft Toys
UNION ALL SELECT 1019297532, 'Soft-Toys'
-- Personalised_Baby_Sleeve_Postal, No  ->  Gifts & Flowers>Home & Lifestyle>Toys & Games>Soft Toys
UNION ALL SELECT 1019297529, 'Soft-Toys'
-- Personalised_Sublimation_Parcel, No  ->  Gifts & Flowers>Home & Lifestyle>Home & Garden>Home
UNION ALL SELECT 1019297618, 'Home'
-- Personalised_Tableware_Postal, No  ->  Gifts & Flowers>Home & Lifestyle>Home & Garden>Home
UNION ALL SELECT 1019297545, 'Home'
-- Personalised_UV_Printing_Postal, No  ->  Gifts & Flowers>Home & Lifestyle>Home & Garden>Home
UNION ALL SELECT 1019297555, 'Home'
-- Photogifts, No  ->  Gifts & Flowers>Home & Lifestyle>Home & Garden>Home
UNION ALL SELECT 62, 'Home'
-- Photogifts, Personalised Covers  ->  Gifts & Flowers>Home & Lifestyle>Home & Garden>Home
UNION ALL SELECT 92, 'Home'
-- Photogifts, Phrame it  ->  Gifts & Flowers>Home & Lifestyle>Home & Garden>Home
UNION ALL SELECT 115, 'Home'
-- Phrame it, No  ->  Gifts & Flowers>Home & Lifestyle>Home & Garden>Home
UNION ALL SELECT 59, 'Home'
-- Thee_Parcel, No  ->  Gifts & Flowers>Food & Drinks
UNION ALL SELECT 1019297586, 'Food-Drinks'
-- Thee_Postal, No  ->  Gifts & Flowers>Food & Drinks
UNION ALL SELECT 1019297615, 'Food-Drinks'
-- Thuis, No  ->  Gifts & Flowers>Home & Lifestyle>Home & Garden>Home
UNION ALL SELECT 195, 'Home'
-- Thuis, Accessoires  ->  Gifts & Flowers>Home & Lifestyle>Home & Garden>Home
UNION ALL SELECT 219, 'Home'
-- Thuis, Bad & Verzorging  ->  Gifts & Flowers>Home & Lifestyle>Home & Garden>Home
UNION ALL SELECT 225, 'Home'
-- Thuis, Box en Kinderwagen  ->  Gifts & Flowers>Home & Lifestyle>Home & Garden>Home
UNION ALL SELECT 216, 'Home'
-- Thuis, Slapen  ->  Gifts & Flowers>Home & Lifestyle>Home & Garden>Home
UNION ALL SELECT 222, 'Home'
-- Personalised Beverage, No  ->  Gifts & Flowers>Food & Drinks>Alcohol
UNION ALL SELECT 1019297404, 'Alcohol'
-- Personalised_Flavours_Pack, No  ->  Gifts & Flowers>Food & Drinks>Alcohol>Spirits
UNION ALL SELECT 1019297538, 'Spirits'
-- Personalised_UV_Printing_Parcel_Beverage, No  ->  Gifts & Flowers>Food & Drinks
UNION ALL SELECT 1019297603, 'Food-Drinks'
-- Personalised_WineTubes, No  ->  Gifts & Flowers>Food & Drinks>Alcohol>Wine
UNION ALL SELECT 1019297481, 'Wine'
-- Food, Personalised Chocolate  ->  Gifts & Flowers>Food & Drinks>Confectionery>Chocolate
UNION ALL SELECT 48, 'Chocolate'
-- Personalised_Tonys_Parcel, No  ->  Gifts & Flowers>Food & Drinks>Confectionery>Chocolate
UNION ALL SELECT 1019297608, 'Chocolate'
-- Personalised_Tonys_Postal, No  ->  Gifts & Flowers>Food & Drinks>Confectionery>Chocolate
UNION ALL SELECT 1019297605, 'Chocolate'
-- Photogifts, Personalised Chocolate  ->  Gifts & Flowers>Food & Drinks>Confectionery>Chocolate
UNION ALL SELECT 89, 'Chocolate'
-- Accessories, Personalised Mugs  ->  Gifts & Flowers>Home & Lifestyle>Home & Garden>Mugs
UNION ALL SELECT 21, 'Mugs'
-- Photogifts, Personalised Mugs  ->  Gifts & Flowers>Home & Lifestyle>Home & Garden>Mugs
UNION ALL SELECT 95, 'Mugs'
-- Personalised_Australian, No  ->  Gifts & Flowers>Food & Drinks>Confectionery>Chocolate
UNION ALL SELECT 1019297427, 'Chocolate'
-- Personalised_Candy, No  ->  Gifts & Flowers>Food & Drinks>Confectionery>Sweets
UNION ALL SELECT 1019297541, 'Sweets'
-- Personalised_Leonidas, No  ->  Gifts & Flowers>Food & Drinks>Confectionery>Chocolate
UNION ALL SELECT 1019297432, 'Chocolate'
-- Personalised_Merci_675, No  ->  Gifts & Flowers>Food & Drinks>Confectionery>Chocolate
UNION ALL SELECT 1019297574, 'Chocolate'
-- PersonalisedMerci, No  ->  Gifts & Flowers>Food & Drinks>Confectionery>Chocolate
UNION ALL SELECT 1019297401, 'Chocolate'
-- cardboxes, No  ->  Cards>Postcards
UNION ALL SELECT 1019297648, 'Postcards'
-- Candy, No  ->  Gifts & Flowers>Food & Drinks>Confectionery>Sweets
UNION ALL SELECT 446399647, 'Sweets'
-- Candy Postal, No  ->  Gifts & Flowers>Food & Drinks>Confectionery>Sweets
UNION ALL SELECT 1019297624, 'Sweets'
-- Donuts, No  ->  Gifts & Flowers>Food & Drinks>Confectionery>Other Confectionery
UNION ALL SELECT 1019297451, 'Other-Confectionery'
-- Food, No  ->  Gifts & Flowers>Food & Drinks
UNION ALL SELECT 8, 'Food-Drinks'
-- Food, Candy  ->  Gifts & Flowers>Food & Drinks>Confectionery>Sweets
UNION ALL SELECT 86, 'Sweets'
-- Food, Fruit  ->  Gifts & Flowers>Food & Drinks
UNION ALL SELECT 47, 'Food-Drinks'
-- Fruitz, No  ->  Gifts & Flowers>Food & Drinks
UNION ALL SELECT 439432660, 'Food-Drinks'
-- Baby shower gifts, Plush  ->  Gifts & Flowers>Home & Lifestyle>Toys & Games>Soft Toys
UNION ALL SELECT 71, 'Soft-Toys'
-- GAMES&TOYS_PARCEL, No  ->  Gifts & Flowers>Home & Lifestyle>Toys & Games
UNION ALL SELECT 1019297643, 'Toys-Games'
-- GAMES&TOYS_POSTAL, No  ->  Gifts & Flowers>Home & Lifestyle>Toys & Games
UNION ALL SELECT 1019297638, 'Toys-Games'
-- Knuffels, No  ->  Gifts & Flowers>Home & Lifestyle>Toys & Games>Soft Toys
UNION ALL SELECT 183, 'Soft-Toys'
-- Knuffels, Knuffeldieren  ->  Gifts & Flowers>Home & Lifestyle>Toys & Games>Soft Toys
UNION ALL SELECT 207, 'Soft-Toys'
-- Knuffels, Knuffeldoekjes  ->  Gifts & Flowers>Home & Lifestyle>Toys & Games>Soft Toys
UNION ALL SELECT 189, 'Soft-Toys'
-- Knuffels, Muziekknuffels  ->  Gifts & Flowers>Home & Lifestyle>Toys & Games>Soft Toys
UNION ALL SELECT 210, 'Soft-Toys'
-- Knuffels, Speendoekjes  ->  Gifts & Flowers>Home & Lifestyle>Toys & Games>Soft Toys
UNION ALL SELECT 213, 'Soft-Toys'
-- Speelgoed, No  ->  Gifts & Flowers>Home & Lifestyle>Toys & Games>Toys
UNION ALL SELECT 2, 'Toys'
-- Speelgoed, Baby Shower gifts  ->  Gifts & Flowers>Home & Lifestyle>Toys & Games>Toys
UNION ALL SELECT 25, 'Toys'
-- Speelgoed, Buiten spelen  ->  Gifts & Flowers>Home & Lifestyle>Toys & Games>Toys
UNION ALL SELECT 252, 'Toys'
-- Speelgoed, Educatief  ->  Gifts & Flowers>Home & Lifestyle>Toys & Games>Toys
UNION ALL SELECT 234, 'Toys'
-- Speelgoed, Houten speelgoed  ->  Gifts & Flowers>Home & Lifestyle>Toys & Games>Toys
UNION ALL SELECT 249, 'Toys'
-- Speelgoed, Knutselen & kleuren  ->  Gifts & Flowers>Home & Lifestyle>Toys & Games>Toys
UNION ALL SELECT 255, 'Toys'
-- Speelgoed, Make-up & Sieraden  ->  Gifts & Flowers>Home & Lifestyle>Toys & Games>Toys
UNION ALL SELECT 228, 'Toys'
-- Speelgoed, Plush  ->  Gifts & Flowers>Home & Lifestyle>Toys & Games>Toys
UNION ALL SELECT 26, 'Toys'
-- Speelgoed, Poppen  ->  Gifts & Flowers>Home & Lifestyle>Toys & Games>Toys
UNION ALL SELECT 261, 'Toys'
-- Speelgoed, Puzzels  ->  Gifts & Flowers>Home & Lifestyle>Toys & Games>Toys
UNION ALL SELECT 237, 'Toys'
-- Speelgoed, Rammelaars & Bijtringen  ->  Gifts & Flowers>Home & Lifestyle>Toys & Games>Toys
UNION ALL SELECT 246, 'Toys'
-- Speelgoed, Rollenspel & Verkleden  ->  Gifts & Flowers>Home & Lifestyle>Toys & Games>Toys
UNION ALL SELECT 231, 'Toys'
-- Speelgoed, Spelletjes  ->  Gifts & Flowers>Home & Lifestyle>Toys & Games>Toys
UNION ALL SELECT 240, 'Toys'
-- Speelgoed, Tasjes & koffertjes  ->  Gifts & Flowers>Home & Lifestyle>Toys & Games>Toys
UNION ALL SELECT 258, 'Toys'
-- Speelgoed, Toys  ->  Gifts & Flowers>Home & Lifestyle>Toys & Games>Toys
UNION ALL SELECT 27, 'Toys'
-- Speelgoed, Voertuigen  ->  Gifts & Flowers>Home & Lifestyle>Toys & Games>Toys
UNION ALL SELECT 243, 'Toys'

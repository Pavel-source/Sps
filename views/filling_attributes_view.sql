CREATE OR REPLACE filling_attributes_view 
AS
SELECT DISTINCT CONCAT('oc_', entity_key) AS ENTITY_KEY, False AS LOCALIZED_ENUM, 'greetingcard' AS PRODUCT_TYPE_KEY,'reporting-occasion' AS ATTRIBUTE_NAME, entity_key AS VALUE_KEY, NAME AS VALUE_LABEL
FROM export_occasions_view
UNION ALL
SELECT DISTINCT CONCAT('st_', entity_key), False, 'greetingcard', 'reporting-style', entity_key, name
FROM export_styles_view
UNION ALL
SELECT DISTINCT CONCAT('rl_', entity_key), False, 'greetingcard', 'reporting-relation', entity_key, name
FROM export_relations_view
UNION ALL
SELECT DISTINCT CONCAT('oc_p_', entity_key) AS ENTITY_KEY, False AS LOCALIZED_ENUM, 'postcard' AS PRODUCT_TYPE_KEY,'reporting-occasion' AS ATTRIBUTE_NAME, entity_key AS VALUE_KEY, NAME AS VALUE_LABEL
FROM export_occasions_view
UNION ALL
SELECT DISTINCT CONCAT('st_p_', entity_key), False, 'postcard', 'reporting-style', entity_key, name
FROM export_styles_view
UNION ALL
SELECT DISTINCT CONCAT('rl_p_', entity_key), False, 'postcard', 'reporting-relation', entity_key, name
FROM export_relations_view


UNION ALL
SELECT DISTINCT CONCAT('br_', entity_key), True, 'gift-card', 'brand', entity_key, name
FROM export_brands_view
UNION ALL
SELECT DISTINCT CONCAT('rn_', entity_key), False, 'greetingcard', 'range', entity_key, name
FROM export_ranges_view
WHERE entity_key NOT IN
(
'ukg',
'axel',
'boom',
'onyx',
'idrew',
'etched',
'say-it',
'karmuka',
'kinship',
'memelou',
'pigment',
'skylark',
'amaretto',
'go-la-la',
'anonsense',
'moonbeams',
'papagrazi',
'paperlink',
'cardy-club',
'choose-joy',
'hola-happy',
'ideal-type',
'banter-king',
'citrus-bunn',
'dean-morris',
'dinky-rouge',
'dotty-black',
'hello-petal',
'kitsch-noir',
'letterpress',
'ling-design',
'lucy-maggie',
'pina-colada',
'abacus-cards',
'all-the-best',
'angela-chick',
'anoela-cards',
'characterful',
'deckled-edge',
'jenny-seddon',
'rumble-cards',
'sadler-jones',
'sooshichacha',
'corrin-strain',
'funny-side-up',
'gift-delivery',
'happy-jackson',
'jam-and-toast',
'jolly-awesome',
'klara-hawkins',
'little-acorns',
'pearl-and-ivy',
'studio-sundae',
'the-wild-life',
'brainbox-candy',
'creativeingrid',
'doodles-by-ini',
'jerry-tapscott',
'me-without-you',
'mia-whittemore',
'the-happy-news',
'bold-and-bright',
'broken-biscuits',
'charly-clements',
'beautiful-planet',
'letters-by-julia',
'menagerie-a-deux',
'millicent-venton',
'poet-and-painter',
'talking-pictures',
'bangers-and-flash',
'filthy-sentiments',
'katie-abey-design',
'neil-clark-design',
'okey-dokey-design',
'the-london-studio',
'dalia-clark-design',
'quitting-hollywood',
'sketchy-characters',
'lucy-pearce-designs',
'emma-proctor-designs',
'natalie-alex-designs',
'the-corrigan-sisters',
'the-curious-inksmith',
'redback-cards-limited',
'a-peculiar-publication',
'alex-sharp-photography',
'jess-rose-illustration',
'lemon-sorbet-christmas',
'cheeky-chops-marketplace',
'stella-isaac-illustration',
'beth-fletcher-illustration',
'bouffants-and-broken-hearts'
)
UNION ALL
SELECT DISTINCT CONCAT('rn_p_', entity_key), False, 'postcard', 'range', entity_key, name
FROM export_ranges_view
WHERE entity_key NOT IN
(
'ukg',
'axel',
'boom',
'onyx',
'idrew',
'etched',
'say-it',
'karmuka',
'kinship',
'memelou',
'pigment',
'skylark',
'amaretto',
'go-la-la',
'anonsense',
'moonbeams',
'papagrazi',
'paperlink',
'cardy-club',
'choose-joy',
'hola-happy',
'ideal-type',
'banter-king',
'citrus-bunn',
'dean-morris',
'dinky-rouge',
'dotty-black',
'hello-petal',
'kitsch-noir',
'letterpress',
'ling-design',
'lucy-maggie',
'pina-colada',
'abacus-cards',
'all-the-best',
'angela-chick',
'anoela-cards',
'characterful',
'deckled-edge',
'jenny-seddon',
'rumble-cards',
'sadler-jones',
'sooshichacha',
'corrin-strain',
'funny-side-up',
'gift-delivery',
'happy-jackson',
'jam-and-toast',
'jolly-awesome',
'klara-hawkins',
'little-acorns',
'pearl-and-ivy',
'studio-sundae',
'the-wild-life',
'brainbox-candy',
'creativeingrid',
'doodles-by-ini',
'jerry-tapscott',
'me-without-you',
'mia-whittemore',
'the-happy-news',
'bold-and-bright',
'broken-biscuits',
'charly-clements',
'beautiful-planet',
'letters-by-julia',
'menagerie-a-deux',
'millicent-venton',
'poet-and-painter',
'talking-pictures',
'bangers-and-flash',
'filthy-sentiments',
'katie-abey-design',
'neil-clark-design',
-- 'okey-dokey-design',
'the-london-studio',
'dalia-clark-design',
'quitting-hollywood',
'sketchy-characters',
'lucy-pearce-designs',
'emma-proctor-designs',
'natalie-alex-designs',
'the-corrigan-sisters',
'the-curious-inksmith',
'redback-cards-limited',
'a-peculiar-publication',
'alex-sharp-photography',
'jess-rose-illustration',
'lemon-sorbet-christmas',
'cheeky-chops-marketplace',
'stella-isaac-illustration',
'beth-fletcher-illustration',
'bouffants-and-broken-hearts'
)
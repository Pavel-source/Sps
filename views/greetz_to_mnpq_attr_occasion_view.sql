CREATE VIEW greetz_to_mnpq_attr_occasion_view
AS
-- Adoption --> New Baby > Adoption
SELECT 1143760393 AS CategoryID, "newbaby>adoption" AS AttributeCode, "New Baby > Adoption" AS AttributeValue, 1 AS Priority
-- Anniversary --> Anniversary > Anniversary
UNION ALL SELECT 1143740082, "anniversary>anniversary", "Anniversary > Anniversary", 2
-- Anniversary 1 year working from home --> Job Anniversary > Job Anniversary
UNION ALL SELECT 1143754239, "jobanniversary>jobanniversary", "Job Anniversary > Job Anniversary", 1
-- AOC think --> Thinking of you > Thinking of you
UNION ALL SELECT 1143742160, "thinkingofyou>thinkingofyou", "Thinking of you > Thinking of you", 2
-- Babyshower --> Baby Shower > Baby Shower
UNION ALL SELECT 1143739143, "babyshower>babyshower", "Baby Shower > Baby Shower", 1
-- Bachelor party (invitations) --> Dinner Party > Dinner Party
UNION ALL SELECT 1143729366, "dinnerparty>dinnerparty", "Dinner Party > Dinner Party", 2
-- Baptism and communion (invitations) --> Christening > Christening
UNION ALL SELECT 1143728949, "christening>christening", "Christening > Christening", 1
-- Birth --> New Baby > New Baby
UNION ALL SELECT 726324202, "newbaby>newbaby", "New Baby > New Baby", 1
-- Birth cards (Birth) --> New Baby > New Baby
UNION ALL SELECT 1143736045, "newbaby>newbaby", "New Baby > New Baby", 1
-- Birthday --> Birthdays > General and Blank
UNION ALL SELECT 726324105, "birthdays>generalandblank", "Birthdays > General and Blank", 1
-- Black and White (Christmas) --> Christmas > Christmas
UNION ALL SELECT 1143735041, "christmas>christmas", "Christmas > Christmas", 1
-- Chinese New Year --> New Year > Chinese New Year
UNION ALL SELECT 1143765953, "newyear>chinesenewyear", "New Year > Chinese New Year", 1
-- Christelijk --> Christmas > Christmas
UNION ALL SELECT 1143735408, "christmas>christmas", "Christmas > Christmas", 1
-- Christmas --> Christmas > Christmas
UNION ALL SELECT 726331358, "christmas>christmas", "Christmas > Christmas", 1
-- Christmas (cardhouse) --> Christmas > Christmas
UNION ALL SELECT 1143734963, "christmas>christmas", "Christmas > Christmas", 1
-- Christmas (invitations) --> Christmas > Christmas
UNION ALL SELECT 1143734987, "christmas>christmas", "Christmas > Christmas", 1
-- Christmas birth --> Christmas > Christmas
UNION ALL SELECT 1143744030, "christmas>christmas", "Christmas > Christmas", 1
-- Christmas birthday --> Christmas > Christmas
UNION ALL SELECT 1143750641, "christmas>christmas", "Christmas > Christmas", 1
-- Christmas Blond Amsterdam --> Christmas > Christmas
UNION ALL SELECT 1143735113, "christmas>christmas", "Christmas > Christmas", 1
-- Christmas Business (IA) --> Christmas > Christmas
UNION ALL SELECT 1143734990, "christmas>christmas", "Christmas > Christmas", 1
-- Christmas Doodles --> Christmas > Christmas
UNION ALL SELECT 1143735206, "christmas>christmas", "Christmas > Christmas", 1
-- Christmas Feelings (Christmas) --> Christmas > Christmas
UNION ALL SELECT 1143735182, "christmas>christmas", "Christmas > Christmas", 1
-- Christmas humor --> Christmas > Christmas
UNION ALL SELECT 1143750638, "christmas>christmas", "Christmas > Christmas", 1
-- Christmas in the weekend --> Christmas > Christmas
UNION ALL SELECT 1143764653, "christmas>christmas", "Christmas > Christmas", 1
-- Christmas Jan van Haast --> Christmas > Christmas
UNION ALL SELECT 1143735089, "christmas>christmas", "Christmas > Christmas", 1
-- Christmas Loesje --> Christmas > Christmas
UNION ALL SELECT 1143735059, "christmas>christmas", "Christmas > Christmas", 1
-- Christmas most sold --> Christmas > Christmas
UNION ALL SELECT 1143737233, "christmas>christmas", "Christmas > Christmas", 1
-- Christmas new home --> Christmas > Christmas
UNION ALL SELECT 1143744027, "christmas>christmas", "Christmas > Christmas", 1
-- Christmas Old Dutch --> Christmas > Christmas
UNION ALL SELECT 1143735083, "christmas>christmas", "Christmas > Christmas", 1
-- Christmas party (invitations Cardhouse) --> Christmas > Christmas
UNION ALL SELECT 1143742829, "christmas>christmas", "Christmas > Christmas", 1
-- Christmas thank you --> Christmas > Christmas
UNION ALL SELECT 1143762663, "christmas>christmas", "Christmas > Christmas", 1
-- Christmas thinking of you --> Christmas > Christmas
UNION ALL SELECT 1143743997, "christmas>christmas", "Christmas > Christmas", 1
-- Confirmation --> Confirmation > Confirmation
UNION ALL SELECT 727249045, "confirmation>confirmation", "Confirmation > Confirmation", 2
-- Congratulations (card and gift) --> Congratulations > Congratulations
UNION ALL SELECT 1143729948, "congratulations>congratulations", "Congratulations > Congratulations", 2
-- Cute as a button Christmas --> Christmas > Christmas
UNION ALL SELECT 1143735104, "christmas>christmas", "Christmas > Christmas", 1
-- Dinner party en drinks (invitations) --> Dinner Party > Dinner Party
UNION ALL SELECT 1143728937, "dinnerparty>dinnerparty", "Dinner Party > Dinner Party", 2
-- Driving License extended --> Driving Test > Driving Test
UNION ALL SELECT 1143754863, "drivingtest>drivingtest", "Driving Test > Driving Test", 1
-- Driving License graduated --> Driving Test > Driving Test
UNION ALL SELECT 735934096, "drivingtest>drivingtest", "Driving Test > Driving Test", 1
-- Easter/Pasen --> Easter > Easter
UNION ALL SELECT 726343205, "easter>easter", "Easter > Easter", 1
-- Eid Mubarak --> Eid > Eid
UNION ALL SELECT 1143746767, "eid>eid", "Eid > Eid", 1
-- Engaged --> Engagement > Engagement
UNION ALL SELECT 735870409, "engagement>engagement", "Engagement > Engagement", 2
-- Exam party (invitations) --> Exams > Congratulations
UNION ALL SELECT 1143728946, "exams>congratulations", "Exams > Congratulations", 2
-- Fathersday --> Father's Day > Father's Day
UNION ALL SELECT 726332069, "father'sday>father'sday", "Father's Day > Father's Day", 1
-- Fathersday beercards --> Father's Day > Father's Day
UNION ALL SELECT 1143746600, "father'sday>father'sday", "Father's Day > Father's Day", 1
-- Fathersday best sold --> Father's Day > Father's Day
UNION ALL SELECT 1143735068, "father'sday>father'sday", "Father's Day > Father's Day", 1
-- Fathersday thinking of you --> Father's Day > Father's Day
UNION ALL SELECT 1143749723, "father'sday>father'sday", "Father's Day > Father's Day", 1
-- First Father's day --> Father's Day > Father's Day
UNION ALL SELECT 1143737236, "father'sday>father'sday", "Father's Day > Father's Day", 1
-- First mothersday --> Mother's Day > Mother's Day
UNION ALL SELECT 1143749468, "mother'sday>mother'sday", "Mother's Day > Mother's Day", 1
-- Friendship2 --> Love and Friendship > Love and Friendship
UNION ALL SELECT 893069562, "loveandfriendship>loveandfriendship", "Love and Friendship > Love and Friendship", 1
-- Garden party (invitations) --> Dinner Party > Dinner Party
UNION ALL SELECT 1143728952, "dinnerparty>dinnerparty", "Dinner Party > Dinner Party", 2
-- Gardenparty (invitations cardhouse) --> Dinner Party > Dinner Party
UNION ALL SELECT 1143734411, "dinnerparty>dinnerparty", "Dinner Party > Dinner Party", 2
-- Get well --> Get Well > Get Well
UNION ALL SELECT 726345521, "getwell>getwell", "Get Well > Get Well", 1
-- Get well welcome home --> Get Well > Get Well
UNION ALL SELECT 1143742088, "getwell>getwell", "Get Well > Get Well", 1
-- Gold Christmas --> Christmas > Christmas
UNION ALL SELECT 1143761673, "christmas>christmas", "Christmas > Christmas", 1
-- Good luck --> Good Luck > Good Luck
UNION ALL SELECT 726345736, "goodluck>goodluck", "Good Luck > Good Luck", 2
-- Graduated afgestudeerd --> Graduation > Graduation
UNION ALL SELECT 1143754869, "graduation>graduation", "Graduation > Graduation", 1
-- Graduated high school --> Graduation > Graduation
UNION ALL SELECT 748505918, "graduation>graduation", "Graduation > Graduation", 1
-- Graduated Propaedeutic certificate --> Congratulations > Congratulations
UNION ALL SELECT 1143754872, "congratulations>congratulations", "Congratulations > Congratulations", 2
-- Graduation --> Graduation > Graduation
UNION ALL SELECT 1143729906, "graduation>graduation", "Graduation > Graduation", 1
-- Halloween --> Halloween > Halloween
UNION ALL SELECT 1143731177, "halloween>halloween", "Halloween > Halloween", 1
-- Hanukkah --> Jewish Celebrations > Hanukkah
UNION ALL SELECT 1143764508, "jewishcelebrations>hanukkah", "Jewish Celebrations > Hanukkah", 1
-- Just because --> Just a note > Just a note
UNION ALL SELECT 726347430, "justanote>justanote", "Just a note > Just a note", 3
-- Love --> Love and Friendship > Love and Friendship
UNION ALL SELECT 1143727832, "loveandfriendship>loveandfriendship", "Love and Friendship > Love and Friendship", 1
-- Love and friendship --> Love and Friendship > Love and Friendship
UNION ALL SELECT 1143743544, "loveandfriendship>loveandfriendship", "Love and Friendship > Love and Friendship", 1
-- Love Brush --> Love and Friendship > Love and Friendship
UNION ALL SELECT 1143756722, "loveandfriendship>loveandfriendship", "Love and Friendship > Love and Friendship", 1
-- Love is all you need --> Love and Friendship > Love and Friendship
UNION ALL SELECT 1143766433, "loveandfriendship>loveandfriendship", "Love and Friendship > Love and Friendship", 1
-- Love letters --> Love and Friendship > Love and Friendship
UNION ALL SELECT 1143750449, "loveandfriendship>loveandfriendship", "Love and Friendship > Love and Friendship", 1
-- Love Notes --> Love and Friendship > Love and Friendship
UNION ALL SELECT 1143766428, "loveandfriendship>loveandfriendship", "Love and Friendship > Love and Friendship", 1
-- Love Repeat --> Love and Friendship > Love and Friendship
UNION ALL SELECT 1143757538, "loveandfriendship>loveandfriendship", "Love and Friendship > Love and Friendship", 1
-- Love wins --> Love and Friendship > Love and Friendship
UNION ALL SELECT 1143754962, "loveandfriendship>loveandfriendship", "Love and Friendship > Love and Friendship", 1
-- Lovepost --> Love and Friendship > Love and Friendship
UNION ALL SELECT 1143766863, "loveandfriendship>loveandfriendship", "Love and Friendship > Love and Friendship", 1
-- Marble Christmas --> Christmas > Christmas
UNION ALL SELECT 1143761623, "christmas>christmas", "Christmas > Christmas", 1
-- Mothersday --> Mother's Day > Mother's Day
UNION ALL SELECT 726331722, "mother'sday>mother'sday", "Mother's Day > Mother's Day", 1
-- Mothersday best sold --> Mother's Day > Mother's Day
UNION ALL SELECT 1143736647, "mother'sday>mother'sday", "Mother's Day > Mother's Day", 1
-- Mothersday distance --> Mother's Day > Mother's Day
UNION ALL SELECT 1143749639, "mother'sday>mother'sday", "Mother's Day > Mother's Day", 1
-- Mothersday thinking of you --> Mother's Day > Mother's Day
UNION ALL SELECT 1143749471, "mother'sday>mother'sday", "Mother's Day > Mother's Day", 1
-- Moving announcement (invitations) --> Announcements > General
UNION ALL SELECT 1143728934, "announcements>general", "Announcements > General", 2
-- Moving announcement christmas --> Christmas > Christmas
UNION ALL SELECT 1143744489, "christmas>christmas", "Christmas > Christmas", 1
-- New home --> New Home > New Home
UNION ALL SELECT 726342840, "newhome>newhome", "New Home > New Home", 1
-- New Job --> New Job or Promotion > New Job or Promotion
UNION ALL SELECT 735872747, "newjoborpromotion>newjoborpromotion", "New Job or Promotion > New Job or Promotion", 1
-- New schoolyear --> New School > New School
UNION ALL SELECT 1143754652, "newschool>newschool", "New School > New School", 1
-- New year party (invitations cardhouse) --> New Year > New Year
UNION ALL SELECT 1143742832, "newyear>newyear", "New Year > New Year", 1
-- Paperclip Business (Christmas) --> Christmas > Christmas
UNION ALL SELECT 1143734972, "christmas>christmas", "Christmas > Christmas", 1
-- Paperclip Kerst (Christmas) --> Christmas > Christmas
UNION ALL SELECT 1143735185, "christmas>christmas", "Christmas > Christmas", 1
-- Paperclip Valentijn --> Valentine's > Valentine's Day
UNION ALL SELECT 1143735314, "valentine's>valentine'sday", "Valentine's > Valentine's Day", 1
-- Pregnancy and birth --> New Baby > New Baby
UNION ALL SELECT 1143743538, "newbaby>newbaby", "New Baby > New Baby", 1
-- Pregnant --> Pregnancy > Pregnancy
UNION ALL SELECT 726344253, "pregnancy>pregnancy", "Pregnancy > Pregnancy", 1
-- re exam --> Exams > Good Luck
UNION ALL SELECT 1143742355, "exams>goodluck", "Exams > Good Luck", 1
-- Retirement --> Retirement > Retirement
UNION ALL SELECT 735873966, "retirement>retirement", "Retirement > Retirement", 1
-- Save the date (Wedding cards only) --> Wedding > Save the date
UNION ALL SELECT 1143729708, "wedding>savethedate", "Wedding > Save the date", 1
-- Sorry --> Sorry > Sorry
UNION ALL SELECT 726966325, "sorry>sorry", "Sorry > Sorry", 1
-- Spring party (BE) --> Dinner Party > Dinner Party
UNION ALL SELECT 1143735985, "dinnerparty>dinnerparty", "Dinner Party > Dinner Party", 2
-- Surprise party --> Dinner Party > Dinner Party
UNION ALL SELECT 1143735665, "dinnerparty>dinnerparty", "Dinner Party > Dinner Party", 2
-- Swimming diploma --> Congratulations > Congratulations
UNION ALL SELECT 1143742376, "congratulations>congratulations", "Congratulations > Congratulations", 1
-- Thank you --> Thank You > Thank You
UNION ALL SELECT 726347103, "thankyou>thankyou", "Thank You > Thank You", 2
-- Thank you cards (invitations) --> Thank You > Thank You
UNION ALL SELECT 1143728940, "thankyou>thankyou", "Thank You > Thank You", 2
-- Thank you caretakers --> Thank You > Thank You
UNION ALL SELECT 1143749321, "thankyou>thankyou", "Thank You > Thank You", 2
-- Thank you teacher --> Thank You > Thank You - Teacher
UNION ALL SELECT 1143742415, "thankyou>thankyou-teacher", "Thank You > Thank You - Teacher", 2
-- Thanks teacher --> Thank You > Thank You - Teacher
UNION ALL SELECT 1143757148, "thankyou>thankyou-teacher", "Thank You > Thank You - Teacher", 2
-- Thanksgiving --> Thanksgiving > Thanksgiving
UNION ALL SELECT 1143764443, "thanksgiving>thanksgiving", "Thanksgiving > Thanksgiving", 2
-- Thinking of you --> Thinking of you > Thinking of you
UNION ALL SELECT 748511930, "thinkingofyou>thinkingofyou", "Thinking of you > Thinking of you", 2
-- Travelling --> Bon Voyage > Bon Voyage
UNION ALL SELECT 1143731911, "bonvoyage>bonvoyage", "Bon Voyage > Bon Voyage", 1
-- Twins and Multiple (Birth) --> New Baby > New Baby
UNION ALL SELECT 886602868, "newbaby>newbaby", "New Baby > New Baby", 1
-- Vacation --> Bon Voyage > Bon Voyage
UNION ALL SELECT 1143729435, "bonvoyage>bonvoyage", "Bon Voyage > Bon Voyage", 2
-- Vacation welcome home --> Bon Voyage > Bon Voyage
UNION ALL SELECT 726965369, "bonvoyage>bonvoyage", "Bon Voyage > Bon Voyage", 2
-- Valentine --> Valentine's > Valentine's Day
UNION ALL SELECT 726324647, "valentine's>valentine'sday", "Valentine's > Valentine's Day", 1
-- Valentine best sold --> Valentine's > Valentine's Day
UNION ALL SELECT 1143735065, "valentine's>valentine'sday", "Valentine's > Valentine's Day", 1
-- Valentine In love --> Valentine's > Valentine's Day
UNION ALL SELECT 748508746, "valentine's>valentine'sday", "Valentine's > Valentine's Day", 1
-- Valentine loving --> Valentine's > Valentine's Day
UNION ALL SELECT 748510085, "valentine's>valentine'sday", "Valentine's > Valentine's Day", 1
-- Valentine online dating --> Valentine's > Valentine's Day
UNION ALL SELECT 1143748919, "valentine's>valentine'sday", "Valentine's > Valentine's Day", 1
-- Valentine secret love --> Valentine's > Valentine's Day
UNION ALL SELECT 748508147, "valentine's>valentine'sday", "Valentine's > Valentine's Day", 1
-- Valentine single --> Valentine's > Valentine's Day
UNION ALL SELECT 1143765443, "valentine's>valentine'sday", "Valentine's > Valentine's Day", 1
-- Valentine thinking of you --> Valentine's > Valentine's Day
UNION ALL SELECT 1143748916, "valentine's>valentine'sday", "Valentine's > Valentine's Day", 1
-- Wedding --> Staff > Wedding
UNION ALL SELECT 726342081, "staff>wedding", "Staff > Wedding", 1
-- Wedding invitation (Wedding) --> Wedding > Invitations
UNION ALL SELECT 1143728795, "wedding>invitations", "Wedding > Invitations", 1
-- Work anniversary --> Job Anniversary > Job Anniversary
UNION ALL SELECT 1143733543, "jobanniversary>jobanniversary", "Job Anniversary > Job Anniversary", 1

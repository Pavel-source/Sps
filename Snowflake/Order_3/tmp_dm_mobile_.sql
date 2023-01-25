  CREATE OR REPLACE TABLE "tmp_dm_mobileByContact" (
	contactid BIGINT NOT NULL,
	mobile_phone VARCHAR(50) NOT NULL,
	PRIMARY KEY (contactid)
)
--COLLATE='utf8_bin'
;
-- select * from tmp_dm_mobileByContact
-- drop table "tmp_dm_mobileByContact"
-- drop table "tmp_dm_mobileByCustomer"

CREATE OR REPLACE TABLE "tmp_dm_mobileByCustomer" (
	customerid BIGINT NOT NULL,
	mobile_phone VARCHAR(50) NOT NULL,
	PRIMARY KEY (customerid)
)
--COLLATE='utf8_bin'
;
-- select * from "tmp_dm_mobileByContact"
-- select * from "tmp_dm_mobileByCustomer"

INSERT INTO "tmp_dm_mobileByContact"
    select contactid,
           max(left(number_, 50)) mobile_phone
    from phonenumber pn
	where type = 'MOBILE_PHONE' AND number_ IS NOT NULL  AND number_ != '' AND contactid IS NOT NULL
    group by contactid;

INSERT INTO "tmp_dm_mobileByCustomer"
    select customerid,
           max(left(number_, 50)) mobile_phone
    from phonenumber pn
	where type = 'MOBILE_PHONE' AND number_ IS NOT NULL  AND number_ != '' AND customerid IS NOT NULL
    group by customerid;
    


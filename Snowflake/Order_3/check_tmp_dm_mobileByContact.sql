
SELECT s.*
FROM
(
    select contactid,
           max(left(number_, 50)) mobile_phone
    from phonenumber pn
	where type = 'MOBILE_PHONE' AND number_ IS NOT NULL  AND number_ != '' AND contactid IS NOT NULL
    group by contactid
) s
LEFT JOIN tmp_dm_mobilebycontact t ON s.contactid = t.contactid
WHERE t.contactid IS null


SELECT s.*
FROM
(
    select customerid,
           max(left(number_, 50)) mobile_phone
    from phonenumber pn
	where type = 'MOBILE_PHONE' AND number_ IS NOT NULL  AND number_ != '' AND customerid IS NOT NULL
    group by customerid
) s
LEFT JOIN tmp_dm_mobileByCustomer t ON s.customerid = t.customerid
WHERE t.customerid IS null




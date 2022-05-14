-- ########################################################################################
-- # Query return customers for migration in sinchro mode.
-- ########################################################################################

with phonenumber as (
    select contactid,
           max(case
                   when type = 'BUSINESS_PHONE'
                       then number_ end) home_phone,
           max(case
                   when type = 'MOBILE_PHONE'
                       then number_ end) mobile_phone,
           max(case
                   when type = 'BUSINESS_FAX'
                       then number_ end) home_fax,
           max(db_updated)               max_db_updated
    from phonenumber pn
    group by contactid
)

select id                                                         as entity_key,
       password                                                   as password,
       passwordsalt                                               as salt,
       email                                                      as email,
       NULLIF(firstname, '')                                      as firstname,
       NULLIF(lastname, '')                                       as lastname,
       nvl(birthdate, '0001-01-01')                               as birthdate, -- commercetools does not allow non-date values.
       NULLIF(companyname, '')                                    as company_name,
       NULLIF(vatid, '')                                          as vat_id,
       lastlogindate                                              as last_login_date,
       registrationdate                                           as registration_date,
       case when emailverified = 'N' then 'false' else 'true' end as email_verified,
       concat('[', group_concat(
               case
                   when address_id is not null then JSON_OBJECT(
                           'key', address_id,
                           'streetName', NULLIF(replace(replace(street, '\r', ''), '\n', ''), ''),
                           'streetNumber', NULLIF(streetnumber, ''),
                           'firstName', NULLIF(cp_firstname, ''),
                           'lastName', NULLIF(cp_lastname, ''),
                           'additionalAddressInfo',
                           NULLIF(trim(concat(nvl(extraaddressline1, ''), ' ', nvl(extraaddressline2, ''), ' ',
                                              nvl(extraaddressline3, ''))), ''),
                           'postalCode', NULLIF(ZIPPOSTALCODE, ''),
                           'city', NULLIF(CITY, ''),
                           'state', NULLIF(stateprovincecounty, ''),
                           'countryCode', nvl(NULLIF(case when countrycode = 'KO' then 'XK' else countrycode end, ''), 'NL'),
                           'phone', NULLIF(home_phone, ''),
                           'mobile', NULLIF(mobile_phone, ''),
                           'fax', NULLIF(home_fax, '')
                       ) end
               separator
               ','), ']')                                            as addresses
                             
FROM 
(
-- customerregistered changes
SELECT cr.id, cr.password, cr.passwordsalt, cr.email, cr.firstname, cr.lastname, cr.birthdate, 
	cr.companyname, cr.vatid, cr.lastlogindate, cr.registrationdate, cr.emailverified, 
	a.id AS address_id, a.street, a.streetnumber, 
	a.extraaddressline1, a.extraaddressline2,	a.extraaddressline3, a.ZIPPOSTALCODE, 
	a.CITY, a.stateprovincecounty, a.countrycode, 
	cp.firstname AS cp_firstname, cp.lastname AS cp_lastname, 
	pn.home_phone, pn.mobile_phone, pn.home_fax		
FROM 
		(
		 SELECT  cr.id, cr.password, cr.passwordsalt, cr.email, cr.firstname, cr.lastname, cr.birthdate, 
					cr.companyname, cr.vatid, cr.lastlogindate, cr.registrationdate, cr.emailverified, 
					cr.lastactivitydate, cr.channelid, cr.active
		 FROM customerregistered cr
		 WHERE cr.db_updated > :syncFrom and cr.db_updated <= :syncTo
		) cr
      left join contact ct on cr.id = ct.customerid
      left join address a on ct.id = a.contactid and a.type = 'OTHER'
      left join phonenumber pn on ct.id = pn.contactid
      left join contactperson cp on cp.contactid = ct.id
WHERE 
		 IFNULL(cr.lastactivitydate, cr.REGISTRATIONDATE) > CURRENT_DATE() - INTERVAL 25 MONTH
		 AND cr.channelid = 2
	     AND cr.active = 'Y'                     
		 AND (concat(:keys) IS NULL OR cr.id in (:keys))
		 AND (:syncFromKey IS NULL OR cr.ID > :syncFromKey)
				 
UNION
-- address changes

SELECT cr.id, cr.password, cr.passwordsalt, cr.email, cr.firstname, cr.lastname, cr.birthdate, 
	cr.companyname, cr.vatid, cr.lastlogindate, cr.registrationdate, cr.emailverified, 
	a.id AS address_id, a.street, a.streetnumber, 
	a.extraaddressline1, a.extraaddressline2,	a.extraaddressline3, a.ZIPPOSTALCODE, 
	a.CITY, a.stateprovincecounty, a.countrycode, 
	cp.firstname AS cp_firstname, cp.lastname AS cp_lastname, 
	pn.home_phone, pn.mobile_phone, pn.home_fax
FROM 
	  customerregistered cr		 
      INNER JOIN contact ct on cr.id = ct.customerid
      INNER JOIN 
		(
		 SELECT a.id, a.street, a.streetnumber, a.extraaddressline1, a.extraaddressline2,
				  a.extraaddressline3, a.ZIPPOSTALCODE, a.CITY, a.stateprovincecounty, a.countrycode, 
				  a.contactid, a.type
		 FROM address a 
		 WHERE a.db_updated > :syncFrom and a.db_updated <= :syncTo
		) a	
			ON ct.id = a.contactid and a.type = 'OTHER'
      left join phonenumber pn on ct.id = pn.contactid
      left join contactperson cp on cp.contactid = ct.id
 WHERE 
 		 IFNULL(cr.lastactivitydate, cr.REGISTRATIONDATE) > CURRENT_DATE() - INTERVAL 25 MONTH
		 AND cr.channelid = 2
         AND cr.active = 'Y'                     
   	 	 AND (concat(:keys) IS NULL OR cr.id in (:keys))
		 AND (:syncFromKey IS NULL OR cr.ID > :syncFromKey)  
				 
UNION
-- phonenumber changes

SELECT cr.id, cr.password, cr.passwordsalt, cr.email, cr.firstname, cr.lastname, cr.birthdate, 
	cr.companyname, cr.vatid, cr.lastlogindate, cr.registrationdate, cr.emailverified, 
	a.id AS address_id, a.street, a.streetnumber, 
	a.extraaddressline1, a.extraaddressline2,	a.extraaddressline3, a.ZIPPOSTALCODE, 
	a.CITY, a.stateprovincecounty, a.countrycode, 
	cp.firstname AS cp_firstname, cp.lastname AS cp_lastname, 
	pn.home_phone, pn.mobile_phone, pn.home_fax
FROM 
	  customerregistered cr		 
      INNER JOIN contact ct on cr.id = ct.customerid
      left join address a ON ct.id = a.contactid and a.type = 'OTHER'
      INNER JOIN 
		(
		 SELECT pn.contactid, pn.home_phone, pn.mobile_phone, pn.home_fax
		 FROM phonenumber pn 
		 WHERE pn.max_db_updated > :syncFrom and pn.max_db_updated <= :syncTo
		) pn	
      	 on ct.id = pn.contactid
      left join contactperson cp on cp.contactid = ct.id
 WHERE 
 		 IFNULL(cr.lastactivitydate, cr.REGISTRATIONDATE) > CURRENT_DATE() - INTERVAL 25 MONTH
		 AND cr.channelid = 2
         AND cr.active = 'Y'                     
   	 	 AND (concat(:keys) IS NULL OR cr.id in (:keys))
		 AND (:syncFromKey IS NULL OR cr.ID > :syncFromKey)  
		 
UNION
-- contactperson changes

SELECT cr.id, cr.password, cr.passwordsalt, cr.email, cr.firstname, cr.lastname, cr.birthdate, 
	cr.companyname, cr.vatid, cr.lastlogindate, cr.registrationdate, cr.emailverified, 
	a.id AS address_id, a.street, a.streetnumber, 
	a.extraaddressline1, a.extraaddressline2,	a.extraaddressline3, a.ZIPPOSTALCODE, 
	a.CITY, a.stateprovincecounty, a.countrycode, 
	cp.firstname AS cp_firstname, cp.lastname AS cp_lastname, 
	pn.home_phone, pn.mobile_phone, pn.home_fax
FROM 
	  customerregistered cr		 
      INNER JOIN contact ct on cr.id = ct.customerid
      left join address a ON ct.id = a.contactid and a.type = 'OTHER'
      left join phonenumber pn on ct.id = pn.contactid
      INNER JOIN 
		(
		 SELECT cp.contactid, cp.firstname, cp.lastname
		 FROM contactperson cp 
		 WHERE cp.db_updated > :syncFrom and cp.db_updated <= :syncTo
		) cp	
      	 on cp.contactid = ct.id
 WHERE 
 		 IFNULL(cr.lastactivitydate, cr.REGISTRATIONDATE) > CURRENT_DATE() - INTERVAL 25 MONTH
		 AND cr.channelid = 2
         AND cr.active = 'Y'                     
   	 	 AND (concat(:keys) IS NULL OR cr.id in (:keys))
		 AND (:syncFromKey IS NULL OR cr.ID > :syncFromKey)  
) sq
   	 	
GROUP BY entity_key
LIMIT :limit;


 


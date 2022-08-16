-- ########################################################################################
-- # Query return active customers for the 1-st migration.
-- ########################################################################################

with phonenumber_cn as (
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
    from phonenumber
	where contactid is not null
    group by contactid
),

phonenumber_cs as (
    select customerid,
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
    from phonenumber
	where customerid is not null
    group by customerid
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
       corporatecustomer                                          as corporate_customer,
       lastlogindate                                              as last_login_date,
       registrationdate                                           as registration_date,
       case when emailverified = 'N' then 'false' else 'true' end as email_verified,
       concat('[', group_concat(
               case
                   when a_id is not null then JSON_OBJECT(
                           'key', a_id,
                           'streetName', NULLIF(replace(replace(street, '\r', ''), '\n', ''), ''),
                           'streetNumber', NULLIF(streetnumber, ''),
                           'apartment', NULLIF(streetnumberextension, ''),
                           'firstName', NULLIF(cp_firstname, ''),
                           'lastName', NULLIF(cp_lastname, ''),
                           'additionalStreetInfo',
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

from

(
select cr.id, cr.password, cr.passwordsalt, cr.email, cr.firstname, cr.lastname, cr.birthdate, cr.companyname, cr.vatid, 
	cr.corporatecustomer, cr.lastlogindate, cr.registrationdate, cr.emailverified, a.id as a_id, a.street, a.streetnumber,
	a.streetnumberextension, a.extraaddressline1, a.extraaddressline2, a.extraaddressline3, a.ZIPPOSTALCODE, a.CITY, a.stateprovincecounty,
	a.countrycode, cp.firstname as cp_firstname, cp.lastname as cp_lastname, pn.home_phone, pn.mobile_phone, pn.home_fax 
			   
from customerregistered cr
         left join contact ct on cr.id = ct.customerid
         left join address a 
			on ct.id = a.contactid 
				and a.type = 'OTHER'
				and 
					(
					  a.countrycode NOT IN ('BY','CF','CD','CI','CU','IR','IQ','KP','LB','LR','LY','MM','RU','SO','SS','SD','SY','UA','VE','YE','ZW')
					  OR a.countrycode IS NULL
					)
         left join phonenumber_cn pn on ct.id = pn.contactid
         left join contactperson cp on cp.contactid = ct.id
where (
		cr.ID > :migrateFromId and cr.ID <= :migrateToId
		and IFNULL(cr.lastactivitydate, cr.REGISTRATIONDATE) > current_date() - INTERVAL 25 MONTH
        and cr.channelid = 2
        and cr.active = 'Y'
        and concat(:keys) IS NULL
      )
	or cr.id in (:keys)

UNION

select cr.id, cr.password, cr.passwordsalt, cr.email, cr.firstname, cr.lastname, cr.birthdate, cr.companyname, cr.vatid, 
	cr.corporatecustomer, cr.lastlogindate, cr.registrationdate, cr.emailverified, a.id as a_id, a.street, a.streetnumber,
	a.streetnumberextension, a.extraaddressline1, a.extraaddressline2, a.extraaddressline3, a.ZIPPOSTALCODE, a.CITY, a.stateprovincecounty,
	a.countrycode, cr.firstname as cp_firstname, cr.lastname as cp_lastname, pn.home_phone, pn.mobile_phone, pn.home_fax 
			   
from customerregistered cr
         join address a 
			on cr.id = a.customerid 
				and a.type = 'OTHER'
				and 
					(
					  a.countrycode NOT IN ('BY','CF','CD','CI','CU','IR','IQ','KP','LB','LR','LY','MM','RU','SO','SS','SD','SY','UA','VE','YE','ZW')
					  OR a.countrycode IS NULL
					)
         left join phonenumber_cs pn on cr.id = pn.customerid
where (
		cr.ID > :migrateFromId and cr.ID <= :migrateToId
		and IFNULL(cr.lastactivitydate, cr.REGISTRATIONDATE) > current_date() - INTERVAL 25 MONTH
        and cr.channelid = 2
        and cr.active = 'Y'
        and concat(:keys) IS NULL
      )
	or cr.id in (:keys)
) AS s
	
group by entity_key
LIMIT :limit

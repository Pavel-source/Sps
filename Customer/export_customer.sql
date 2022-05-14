-- ########################################################################################
-- # Query return active customers for the 1-st migration.
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

select cr.id                                                         as entity_key,
       cr.password                                                   as password,
       cr.passwordsalt                                               as salt,
       cr.email                                                      as email,
       NULLIF(cr.firstname, '')                                      as firstname,
       NULLIF(cr.lastname, '')                                       as lastname,
       nvl(cr.birthdate, '0001-01-01')                               as birthdate, -- commercetools does not allow non-date values.
       NULLIF(cr.companyname, '')                                    as company_name,
       NULLIF(cr.vatid, '')                                          as vat_id,
       cr.lastlogindate                                              as last_login_date,
       cr.registrationdate                                           as registration_date,
       case when cr.emailverified = 'N' then 'false' else 'true' end as email_verified,
       concat('[', group_concat(
               case
                   when a.id is not null then JSON_OBJECT(
                           'key', a.id,
                           'streetName', NULLIF(replace(replace(a.street, '\r', ''), '\n', ''), ''),
                           'streetNumber', NULLIF(a.streetnumber, ''),
                           'firstName', NULLIF(cp.firstname, ''),
                           'lastName', NULLIF(cp.lastname, ''),
                           'additionalAddressInfo',
                           NULLIF(trim(concat(nvl(a.extraaddressline1, ''), ' ', nvl(a.extraaddressline2, ''), ' ',
                                              nvl(a.extraaddressline3, ''))), ''),
                           'postalCode', NULLIF(a.ZIPPOSTALCODE, ''),
                           'city', NULLIF(a.CITY, ''),
                           'state', NULLIF(a.stateprovincecounty, ''),
                           'countryCode', nvl(NULLIF(case when countrycode = 'KO' then 'XK' else countrycode end, ''), 'NL'),
                           'phone', NULLIF(pn.home_phone, ''),
                           'mobile', NULLIF(pn.mobile_phone, ''),
                           'fax', NULLIF(pn.home_fax, '')
                       ) end
               separator
               ','), ']')                                            as addresses
from customerregistered cr
         left join contact ct on cr.id = ct.customerid
         left join address a on ct.id = a.contactid and a.type = 'OTHER'
         left join phonenumber pn on ct.id = pn.contactid
         left join contactperson cp on cp.contactid = ct.id
where (
		cr.ID > :migrateFromId and cr.ID <= :migrateToId
		and IFNULL(cr.lastactivitydate, cr.REGISTRATIONDATE) > CURRENT_DATE() - INTERVAL 25 MONTH
        and cr.channelid = 2
        and cr.active = 'Y'
        and concat(:keys) IS NULL
      )
	or cr.id in (:keys)
group by entity_key
LIMIT :limit

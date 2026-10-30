with merchants as (

    select *
    from {{ ref('stg_banking__merchants') }}

)

select

    merchant_id,
    merchant_name,
    merchant_category,
    country as merchant_country

from merchants
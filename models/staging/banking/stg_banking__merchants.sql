with source as (

    select *
    from {{ source('banking_raw', 'merchants') }}

),

renamed as (

    select

        cast(merchant_id as string) as merchant_id,

        initcap(trim(merchant_name)) as merchant_name,

        upper(trim(merchant_category)) as merchant_category,

        initcap(trim(country)) as country

    from source

)

select *
from renamed
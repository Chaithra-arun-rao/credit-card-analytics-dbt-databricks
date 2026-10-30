with source as (
    select * from {{ source('banking_raw', 'customers') }}
),

renamed as (
    select
        cast(customer_id as string) as customer_id,
        initcap(trim(first_name)) as first_name,
        initcap(trim(last_name)) as last_name,
        cast(date_of_birth as date) as date_of_birth,
        initcap(trim(country)) as country,
        upper(trim(risk_rating)) as risk_rating,
        cast(customer_since as date) as customer_since
    from source
)

select * from renamed
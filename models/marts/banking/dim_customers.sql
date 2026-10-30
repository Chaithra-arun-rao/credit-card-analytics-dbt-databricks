with customers as (

    select *
    from {{ ref('stg_banking__customers') }}

)

select

    customer_id,
    first_name,
    last_name,

    concat(first_name, ' ', last_name) as customer_name,

    date_of_birth,
    country,
    risk_rating,
    customer_since

from customers
with transactions as (

    select *
    from {{ ref('stg_banking__transactions') }}

),

cards as (

    select *
    from {{ ref('stg_banking__credit_cards') }}

),

customers as (

    select *
    from {{ ref('stg_banking__customers') }}

),

merchants as (

    select *
    from {{ ref('stg_banking__merchants') }}

),

joined as (

    select

        t.transaction_id,
        t.card_id,
        c.customer_id,

        t.merchant_id,
        m.merchant_name,
        m.merchant_category,

        t.transaction_timestamp,
        t.transaction_amount,
        t.currency_code,
        t.transaction_status,

        c.card_type,
        c.card_status,
        c.credit_limit,

        cu.country as customer_country,
        m.country as merchant_country,

        case
            when t.transaction_amount >= 50000
                then true
            else false
        end as is_high_value,

        case
            when hour(t.transaction_timestamp) between 0 and 4
                then true
            else false
        end as is_unusual_time,

        case
            when upper(trim(cu.country)) <> upper(trim(m.country))
                then true
            else false
        end as is_international

    from transactions t

    inner join cards c
        on t.card_id = c.card_id

    inner join customers cu
        on c.customer_id = cu.customer_id

    left join merchants m
        on t.merchant_id = m.merchant_id

)

select *
from joined
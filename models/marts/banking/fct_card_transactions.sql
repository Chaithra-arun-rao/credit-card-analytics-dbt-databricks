with transactions as (

    select *
    from {{ ref('int_banking__card_transactions') }}

)

select

    transaction_id,
    card_id,
    customer_id,
    merchant_id,

    transaction_timestamp,
    transaction_amount,
    currency_code,
    transaction_status,

    merchant_name,
    merchant_category,

    customer_country,
    merchant_country,

    is_high_value,
    is_unusual_time,
    is_international

from transactions
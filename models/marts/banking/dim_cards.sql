with cards as (

    select *
    from {{ ref('stg_banking__credit_cards') }}

)

select

    card_id,
    customer_id,
    card_type,
    card_status,
    credit_limit,
    issue_date,
    expiry_date

from cards
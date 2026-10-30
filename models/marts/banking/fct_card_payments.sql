with payments as (

    select *
    from {{ ref('int_banking__card_payment_status') }}

)

select

    payment_id,
    card_id,
    billing_month,

    billed_amount,
    payment_amount,
    outstanding_amount,

    payment_date,
    payment_status

from payments
with payments as (

    select *
    from {{ ref('stg_banking__card_payments') }}

),

payment_status as (

    select

        payment_id,
        card_id,
        billing_month,
        billed_amount,
        payment_amount,
        payment_date,

        greatest(
            billed_amount - payment_amount,
            0
        ) as outstanding_amount,

        case

            when payment_amount >= billed_amount
                then 'PAID'

            when payment_amount > 0
                 and payment_amount < billed_amount
                then 'PARTIALLY_PAID'

            when payment_amount = 0
                then 'UNPAID'

            else 'UNKNOWN'

        end as payment_status

    from payments

)

select *
from payment_status
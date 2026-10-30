with source as (
    select *
    from {{ source('banking_raw', 'card_payments') }}
),

renamed as (
    select
        cast(payment_id as string) as payment_id,
        cast(card_id as string) as card_id,
        cast(billing_month as string) as billing_month,
        cast(billed_amount as decimal(18, 2)) as billed_amount,
        cast(payment_amount as decimal(18, 2)) as payment_amount,
        cast(payment_date as date) as payment_date
    from source

)

select *
from renamed
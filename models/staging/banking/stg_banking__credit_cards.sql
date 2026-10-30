with source as (
    select * from {{ source('banking_raw', 'credit_cards') }}
),

renamed as (
    select
        cast(card_id as string) as card_id,
        cast(customer_id as string) as customer_id,
        upper(trim(card_type)) as card_type,
        upper(trim(card_status)) as card_status,
        cast(credit_limit as decimal(18, 2)) as credit_limit,
        cast(issue_date as date) as issue_date,
        cast(expiry_date as date) as expiry_date
    from source
)

select * 
from renamed
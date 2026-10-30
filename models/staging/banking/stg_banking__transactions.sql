with source as (

    select *
    from {{ source('banking_raw', 'transactions') }}

),

renamed as (
    select
        cast(transaction_id as string) as transaction_id,
        cast(card_id as string) as card_id,
        cast(merchant_id as string) as merchant_id,
        cast(transaction_ts as timestamp) as transaction_timestamp,
        cast(amount as decimal(18, 2)) as transaction_amount,
        upper(trim(currency)) as currency_code,
        upper(trim(transaction_status)) as transaction_status
    from source

)

select *
from renamed
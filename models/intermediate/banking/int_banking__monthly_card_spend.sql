with transactions as (

    select *
    from {{ ref('int_banking__card_transactions') }}

),

monthly_spend as (

    select

        card_id,
        customer_id,

        date_trunc(
            'month',
            transaction_timestamp
        ) as transaction_month,

        count(*) as total_transaction_count,

        sum(
            case
                when transaction_status = 'SUCCESS'
                    then transaction_amount
                else 0
            end
        ) as total_successful_spend,

        sum(
            case
                when is_high_value = true
                    then 1
                else 0
            end
        ) as high_value_transaction_count,

        sum(
            case
                when is_international = true
                    then 1
                else 0
            end
        ) as international_transaction_count,

        sum(
            case
                when is_unusual_time = true
                    then 1
                else 0
            end
        ) as unusual_time_transaction_count

    from transactions

    group by
        card_id,
        customer_id,
        date_trunc('month', transaction_timestamp)

)

select *
from monthly_spend
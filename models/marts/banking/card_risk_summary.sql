with cards as (

    select *
    from {{ ref('dim_cards') }}

),

customers as (

    select *
    from {{ ref('dim_customers') }}

),

monthly_spend as (

    select *
    from {{ ref('int_banking__monthly_card_spend') }}

),

payments as (

    select *
    from {{ ref('fct_card_payments') }}

),

final as (

    select

        c.card_id,
        c.customer_id,

        cu.customer_name,
        cu.country as customer_country,
        cu.risk_rating as customer_risk_rating,

        c.card_type,
        c.card_status,
        c.credit_limit,

        s.transaction_month,

        s.total_transaction_count,
        s.total_successful_spend,

        s.high_value_transaction_count,
        s.international_transaction_count,
        s.unusual_time_transaction_count,

        round(
            (
                s.total_successful_spend
                / nullif(c.credit_limit, 0)
            ) * 100,
            2
        ) as utilization_percentage,

        coalesce(
            p.billed_amount,
            0
        ) as billed_amount,

        coalesce(
            p.payment_amount,
            0
        ) as payment_amount,

        coalesce(
            p.outstanding_amount,
            0
        ) as outstanding_amount,

        p.payment_status,

        case

            when (
                s.total_successful_spend
                / nullif(c.credit_limit, 0)
            ) * 100 >= 80

                then true

            else false

        end as is_high_utilization

    from cards c

    inner join customers cu
        on c.customer_id = cu.customer_id

    left join monthly_spend s
        on c.card_id = s.card_id

    left join payments p
        on c.card_id = p.card_id

)

select *
from final
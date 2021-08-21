with all_transactions as (
    select *
    from `analytics-engineers-club.coffee_shop.orders` as o 
    left join `analytics-engineers-club.coffee_shop.customers` as c
    on o.customer_id = c.id
),

first_order as (
    select 
    customer_id
    , min(created_at) as first_order_at
    from all_transactions
    group by 1
),

number_of_orders as (
    select 
    customer_id
    , count(*) as number_of_orders
    from all_transactions 
    group by 1
)

select 
    t.customer_id
    , t.name
    , t.email
    , fo.first_order_at 
    , nor.number_of_orders 
from all_transactions t
left join first_order fo 
on t.customer_id = fo.customer_id
left join number_of_orders nor 
on t.customer_id = nor.customer_id
group by 1, 2, 3, 4, 5
order by 4
limit 5
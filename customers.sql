with customers as (
    select * from `analytics-engineers-club.coffee_shop.customers`
),

orders as (
    select * from `analytics-engineers-club.coffee_shop.orders`
),

final as (
    select 
        customers.id as customer_id
        , customers.name
        , customers.email
        , MIN(orders.created_at) AS first_order_at
        , COUNT(*) AS number_of_orders 
    from customers 
    left join orders on customers.id = orders.customer_id
    group by 1, 2, 3
    order by 4
    LIMIT 5
)

select * from final
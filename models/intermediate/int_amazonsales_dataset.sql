{{ config(materialized = 'view') }}

with int_amazonsales_dataset as
(
    select
        a.region,
        a.country,
        a.item_type,
        a.sales_channel,
        a.orderr as orders,
        to_date(a.order_date, 'MM/dd/yyyy') as order_date,
        a.order_id,
        to_date(a.ship_date, 'MM/dd/yyyy') as ship_date,
        try_cast(a.units_sold as int) as units_sold,
        try_cast(a.unit_price as double) as unit_price,
        try_cast(a.unit_cost as double) as unit_cost,
        try_cast(a.total_revenue as double) as total_revenue,
        try_cast(a.total_cost as double) as total_cost,
        try_cast(a.total_profit as double) as total_profit
    from {{ref('lan_amazonsales_dataset')}} a
    order by order_id asc
)

select * from int_amazonsales_dataset
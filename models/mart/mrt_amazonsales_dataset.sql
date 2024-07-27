{{ config(materialized='table') }}

with mrt_amazonsales_dataset as
(
    select 
        a.region,
        a.country,
        a.item_type,
        a.sales_channel,
        coalesce(round(avg(a.units_sold),3),0) as units_sold,
        coalesce(round(avg(a.unit_price),3),0) as unit_price,
        coalesce(round(avg(a.unit_cost),3),0) as unit_cost,
        coalesce(round(sum(a.total_revenue),3),0) as total_revenue,
        coalesce(round(sum(a.total_cost),3),0) as total_cost,
        coalesce(round(sum(a.total_profit),3),0) as total_profit
    from {{ ref("int_amazonsales_dataset") }} a
    group by all
)

select * from mrt_amazonsales_dataset
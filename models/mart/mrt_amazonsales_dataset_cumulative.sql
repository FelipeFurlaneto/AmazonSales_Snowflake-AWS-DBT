{{ config(materialized='table') }}

with mrt_amazonsales_dataset_cumulative as
(
    select 
        *,
        sum(a.total_revenue) over(order by order_date asc) as cumulative_revenue,
        sum(a.total_cost) over(order by order_date asc) as cumulative_cost,
        sum(a.total_profit) over(order by order_date asc) as cumulative_profit
    from {{ ref("int_amazonsales_dataset") }} a
)

select * from mrt_amazonsales_dataset_cumulative
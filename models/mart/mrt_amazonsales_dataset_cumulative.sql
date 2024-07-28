{{ config(materialized='table') }}

with mrt_amazonsales_dataset_cumulative as
(
    select 
        a.*,
        sum(a.total_revenue) over(order by order_date asc) as cumulative_revenue,
        sum(a.total_cost) over(order by order_date asc) as cumulative_cost,
        sum(a.total_profit) over(order by order_date asc) as cumulative_profit,
        b.previous_day as order_previous_day,
        b.next_day as order_next_day,
        b.semester as order_semester,
        b.quarter as order_quarter,
        b.month as order_month,
        b.year as order_year,
        b.day as order_day
    from {{ ref("int_amazonsales_dataset") }} a
    left join {{ ref('int_dimdate') }} b
        on a.order_date = b.date
)

select * from mrt_amazonsales_dataset_cumulative
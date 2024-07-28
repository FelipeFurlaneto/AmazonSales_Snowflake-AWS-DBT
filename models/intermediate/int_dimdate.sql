{{ config(materialized='view') }}

with int_dimdate as
(
    select
        date,
        year(date) as year,
        month(date) as month,
        day(date) as day,
        quarter(date) as quarter,
        case 
            when quarter(date) in (1,2) then 1
            when quarter(date) in (3,4) then 2 
        end as semester,
        lead(date) over(order by date asc) as next_day,
        lead(date) over(order by date desc) as previous_day
    from
        (
            select
                to_date(dateadd('day', SEQ4(), '2010-01-01')) AS date
            from
            table(generator(rowcount => 9000))
        )
)

select * from int_dimdate
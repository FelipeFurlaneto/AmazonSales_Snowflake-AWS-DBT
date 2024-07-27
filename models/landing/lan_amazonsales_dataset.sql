{{ config(materialized = 'ephemeral') }}

with lan_amazonsales_dataset as
(
    select * from amazon.sales.sales_dataset
)

select * from lan_amazonsales_dataset
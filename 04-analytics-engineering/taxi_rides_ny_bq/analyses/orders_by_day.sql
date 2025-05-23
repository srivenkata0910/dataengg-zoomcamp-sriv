with orders as(
select * from {{ ref('stg_jaffle_shop__orders') }}
),
daily as (

  select order_date,
  count(*) as order_cnt
  from orders
  group by order_date
),
compared as(
   select *,
   lag(order_cnt) over(order by order_date) as prev_day_orders
   from daily

)
select * from compared

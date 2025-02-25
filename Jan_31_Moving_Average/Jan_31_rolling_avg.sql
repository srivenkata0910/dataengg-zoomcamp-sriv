/* Using this dataset, show the SQL query to find the rolling 3 day average transaction amount for each day in January 2021. */
with daily_sum as(
select 
       transaction_time::date as transaction_date,
       sum(transaction_amount) as daily_trans_amt
       from transactions 
       group by transaction_time::date
       order by transaction_time::date
  ),
moving_avgs as(
  select transaction_date,
  avg(daily_trans_amt) over(order by transaction_date rows 2 preceding) as moving_avg
  from daily_sum
  )
  select moving_avg
  from moving_avgs
  where transaction_date=to_date('2021-01-31','yyyy-mm-dd')
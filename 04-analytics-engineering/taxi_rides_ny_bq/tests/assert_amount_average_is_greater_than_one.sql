{{ config(enabled = false) }}

select
    customer_id, 
    avg(amount) as average_amount
from {{ ref('orders') }}
group by 1
having  average_amount < 1
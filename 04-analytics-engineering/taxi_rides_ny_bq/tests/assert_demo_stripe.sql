select
  order_id,
  sum(amount) as total_amount
from {{ ref('demo_strip') }}
group by 1
having (total_amount < 0)
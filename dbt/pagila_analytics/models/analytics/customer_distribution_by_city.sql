select
    country,
    city,
    count(customer_id) as customer_count
from {{ ref('dim_customer') }}
group by country, city
order by customer_count desc
limit 20
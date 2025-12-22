select
    f.category_name,
    sum(r.payment_amount) as total_revenue
from {{ ref('fact_rental') }} r
join {{ ref('dim_film') }} f on r.film_id = f.film_id
group by f.category_name
order by total_revenue desc
limit 5
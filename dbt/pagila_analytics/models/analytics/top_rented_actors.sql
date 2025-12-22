select
    a.first_name,
    a.last_name,
    count(r.rental_id) as total_rentals
from {{ ref('fact_rental') }} r
join {{ ref('int_film_actor_bridge') }} fab on r.film_id = fab.film_id
join {{ ref('dim_actor') }} a on fab.actor_id = a.actor_id
group by a.first_name, a.last_name
order by total_rentals desc
limit 10
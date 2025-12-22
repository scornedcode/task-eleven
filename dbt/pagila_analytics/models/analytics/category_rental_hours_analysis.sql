select
    f.category_name,
    count(r.rental_id) as total_rentals,
    sum(r.rental_duration_days) * 24 as total_rental_hours,
    avg(r.rental_duration_days) * 24 as avg_rental_hours
from {{ ref('fact_rental') }} r
join {{ ref('dim_film') }} f on r.film_id = f.film_id
where r.rental_duration_days is not null
group by f.category_name
order by total_rental_hours desc
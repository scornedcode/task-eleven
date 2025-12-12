select
    a.first_name,
    a.last_name,
    count(f.film_id) as children_films_count
from {{ ref('dim_film') }} f
join {{ ref('int_film_actor_bridge') }} fab on f.film_id = fab.film_id
join {{ ref('dim_actor') }} a on fab.actor_id = a.actor_id
where f.category_name = 'Children'
group by a.first_name, a.last_name
order by children_films_count desc
limit 10
select
    category_name,
    count(film_id) as total_films
from {{ ref('dim_film') }}
group by category_name
order by total_films desc
with film_actor as (
    select * from {{ ref('stg_film_actor') }}
),
actor as (
    select * from {{ ref('stg_actor') }}
)

select
    fa.film_id,
    fa.actor_id,
    a.first_name,
    a.last_name
from film_actor fa
join actor a on fa.actor_id = a.actor_id
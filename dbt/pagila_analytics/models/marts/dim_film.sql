with films as (
    select * from {{ ref('stg_film') }}
),
film_category as (
    select * from {{ ref('stg_film_category') }}
),
categories as (
    select * from {{ ref('stg_category') }}
),
joined as (
    select
        f.film_id,
        f.title,
        f.description,
        f.release_year,
        f.duration,
        f.rating,
        c.category_name
    from films f
    left join film_category fc on f.film_id = fc.film_id
    left join categories c on fc.category_id = c.category_id
)

select * from joined
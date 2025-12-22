with source as (
    select * from {{ source('pagila_source', 'film_category') }}
),
renamed as (
    select
        film_id,
        category_id,
        last_update as updated_at
    from source
)
select * from renamed
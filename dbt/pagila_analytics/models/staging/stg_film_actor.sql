with source as (
    select * from {{ source('pagila_source', 'film_actor') }}
),
renamed as (
    select
        actor_id,
        film_id,
        last_update as updated_at
    from source
)
select * from renamed
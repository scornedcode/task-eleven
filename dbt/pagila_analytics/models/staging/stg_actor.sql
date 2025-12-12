with source as (
    select * from {{ source('pagila_source', 'actor') }}
),
renamed as (
    select
        actor_id,
        first_name,
        last_name,
        last_update as updated_at
    from source
)
select * from renamed
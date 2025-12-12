with source as (
    select * from {{ source('pagila_source', 'inventory') }}
),
renamed as (
    select
        inventory_id,
        film_id,
        store_id,
        last_update as updated_at
    from source
)
select * from renamed
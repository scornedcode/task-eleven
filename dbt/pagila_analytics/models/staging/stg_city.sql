with source as (
    select * from {{ source('pagila_source', 'city') }}
),
renamed as (
    select
        city_id,
        city,
        country_id,
        last_update as updated_at
    from source
)
select * from renamed
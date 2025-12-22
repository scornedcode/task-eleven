with source as (
    select * from {{ source('pagila_source', 'country') }}
),
renamed as (
    select
        country_id,
        country,
        last_update as updated_at
    from source
)
select * from renamed
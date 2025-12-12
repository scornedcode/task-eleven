with source as (
    select * from {{ source('pagila_source', 'address') }}
),
renamed as (
    select
        address_id,
        address,
        address2,
        district,
        city_id,
        postal_code,
        phone,
        last_update as updated_at
    from source
)
select * from renamed


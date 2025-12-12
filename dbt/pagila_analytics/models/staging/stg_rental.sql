with source as (
    select * from {{ source('pagila_source', 'rental') }}
),
renamed as (
    select
        rental_id,
        rental_date,
        inventory_id,
        customer_id,
        return_date,
        staff_id,
        last_update as updated_at
    from source
)
select * from renamed
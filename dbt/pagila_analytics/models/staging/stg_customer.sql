with source as (
    select * from {{ source('pagila_source', 'customer') }}
),
renamed as (
    select
        customer_id,
        store_id,
        first_name,
        last_name,
        email,
        address_id,
        activebool as is_active,  
        active as active_flag,
        create_date as created_at,
        last_update as updated_at
    from source
)
select * from renamed
with source as (
    select * from {{ source('pagila_source', 'category') }}
),
renamed as (
    select
        category_id,
        name as category_name,
        last_update as updated_at
    from source
)
select * from renamed
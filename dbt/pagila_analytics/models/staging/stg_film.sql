with source as (
    select * from {{ source('pagila_source', 'film') }}
),
renamed as (
    select
        film_id,
        title,
        description,
        release_year,
        language_id,
        original_language_id,
        rental_duration,
        rental_rate,
        length as duration,
        replacement_cost,
        rating,
        special_features,
        last_update as updated_at
    from source
)
select * from renamed
select
    rental_id,
    customer_id,
    film_id,
    staff_id,
    rental_date,
    return_date,
    rental_duration_days,
    is_returned,
    amount as payment_amount 
from {{ ref('int_rental_facts') }}
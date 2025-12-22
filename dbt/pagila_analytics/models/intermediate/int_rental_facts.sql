with rental as (
    select * from {{ ref('stg_rental') }}
),
inventory as (
    select * from {{ ref('stg_inventory') }}
),
payment as (
    select * from {{ ref('stg_payment') }}
)

select
    r.rental_id,
    r.customer_id,
    i.film_id,
    r.staff_id,
    r.rental_date,
    r.return_date,
    p.amount,
    p.payment_date,
    datediff('day', r.rental_date, r.return_date) as rental_duration_days,
    case
        when r.return_date is null then false
        else true
    end as is_returned

from rental r
join inventory i on r.inventory_id = i.inventory_id
left join payment p on r.rental_id = p.rental_id
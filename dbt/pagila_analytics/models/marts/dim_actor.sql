with actors as (
    select * from {{ ref('stg_actor') }}
)
select
    actor_id,
    first_name,
    last_name,
    updated_at
from actors
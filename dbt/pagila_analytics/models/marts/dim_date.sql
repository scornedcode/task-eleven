with date_spine as (
  select
    dateadd(day, row_number() over (order by null) - 1, '2000-01-01') as date_day
  from table(generator(rowcount => 11000)) 
)

select
    date_day,
    year(date_day) as year,
    month(date_day) as month,
    monthname(date_day) as month_name,
    day(date_day) as day,
    quarter(date_day) as quarter,
    dayofweek(date_day) as day_of_week
from date_spine
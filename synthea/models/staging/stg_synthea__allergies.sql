with source as (
    select *
    from {{source('synthea','allergies')}}
)

select *
from source
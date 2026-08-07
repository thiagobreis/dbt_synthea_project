with source as (
    select *
    from {{source('synthea','observations')}}
)

select *
from source
with source as (
    select *
    from {{source('synthea','supplies')}}
)

select *
from source
with source as (
    select *
    from {{source('synthea','encounters')}}
)

select *
from source
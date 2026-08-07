with source as (
    select *
    from {{source('synthea','devices')}}
)

select *
from source
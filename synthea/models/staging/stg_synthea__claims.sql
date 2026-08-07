with source as (
    select *
    from {{source('synthea','claims')}}
)

select *
from source
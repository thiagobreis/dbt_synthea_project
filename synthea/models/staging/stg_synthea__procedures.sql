with source as (
    select *
    from {{source('synthea','procedures')}}
)

select *
from source
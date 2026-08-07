with source as (
    select *
    from {{source('synthea','careplans')}}
)

select *
from source
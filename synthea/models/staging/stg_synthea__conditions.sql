with source as (
    select *
    from {{source('synthea','conditions')}}
)

select *
from source
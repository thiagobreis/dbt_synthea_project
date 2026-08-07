with source as (
    select *
    from {{source('synthea','providers')}}
)

select *
from source
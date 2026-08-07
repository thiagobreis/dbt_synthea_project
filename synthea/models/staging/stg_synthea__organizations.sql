with source as (
    select *
    from {{source('synthea','organizations')}}
)

select *
from source
with source as (
    select *
    from {{source('synthea','patients')}}
)

select *
from source
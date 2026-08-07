with source as (
    select *
    from {{source('synthea','payers')}}
)

select *
from source
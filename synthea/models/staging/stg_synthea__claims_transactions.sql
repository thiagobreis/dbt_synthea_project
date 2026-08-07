with source as (
    select *
    from {{source('synthea','claims_transactions')}}
)

select *
from source
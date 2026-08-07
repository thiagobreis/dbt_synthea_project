with source as (
    select *
    from {{source('synthea','payer_transitions')}}
)

select *
from source
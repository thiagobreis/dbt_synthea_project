with source as (
    select *
    from {{source('synthea','medications')}}
)

select *
from source
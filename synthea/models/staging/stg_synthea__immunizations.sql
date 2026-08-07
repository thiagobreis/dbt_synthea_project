with source as (
    select *
    from {{source('synthea','immunizations')}}
)

select *
from source
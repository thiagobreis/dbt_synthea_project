with source as (
    select *
    from {{source('synthea','imaging_studies')}}
)

select *
from source
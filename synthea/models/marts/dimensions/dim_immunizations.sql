select 
    {{ dbt_utils.generate_surrogate_key([-1]) }} as immunization_id,
    -1 as immunization_source_id,
    'Not Specified' as immunization_description

union all

select distinct
    {{ dbt_utils.generate_surrogate_key(['code']) }} as immunization_id,
	code as immunization_source_id,
	description as immunization_description
from {{ ref('stg_synthea__immunizations') }}
where code is not null
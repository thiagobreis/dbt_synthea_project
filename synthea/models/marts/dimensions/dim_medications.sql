select 
    {{ dbt_utils.generate_surrogate_key([-1]) }} as medication_id,
    -1 as medication_source_id,
    'Not Specified' as medication_description

union all

select distinct
    {{ dbt_utils.generate_surrogate_key(['code']) }} as medication_id,
	code as medication_source_id,
	upper(description)	 as medication_description
from {{ ref('stg_synthea__medications') }}
where code is not null
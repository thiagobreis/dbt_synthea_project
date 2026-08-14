select 
    {{ dbt_utils.generate_surrogate_key([-1]) }} as encounter_id,
    '-1' as encounter_unique_id,
    -1 as encounter_source_id,
    'Not Specified' as encounter_description

union all

select distinct
    {{ dbt_utils.generate_surrogate_key(["concat_ws('-',code,description)"]) }} as encounter_id,
	concat_ws('-',code,description) as encounter_unique_id,
	code as encounter_source_id,
	description as encounter_description
from {{ ref('stg_synthea__encounters') }}
where code is not null
select 
    {{ dbt_utils.generate_surrogate_key([-1]) }} as procedure_id,
    '-1' procedure_unique_id,
    -1 as procedure_source_id,
    'Not Specified' as procedure_description

union all

select distinct
    {{ dbt_utils.generate_surrogate_key(["concat_ws('-',code,description)"]) }} as procedure_id,
    concat_ws('-',code,description) as procedure_unique_id, 
	code as procedure_source_id,
	upper(description) as procedure_description
from {{ ref('stg_synthea__procedures') }}
where code is not null
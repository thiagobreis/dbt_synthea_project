select 
    {{ dbt_utils.generate_surrogate_key([-1]) }} as organization_id,
    -1 as organization_source_id,
    'Not Specified' as organization_name,
    'Not Specified' as address,
	'Not Specified' as city,
	'XX' as state,
	'00000' as zip,
	'00000' as phone

union all

select distinct
    {{ dbt_utils.generate_surrogate_key(['id']) }} as organization_id,
	id as organization_source_id,
	name as organization_name,
    address,
	city,
	state,
	zip,
	phone
from {{ ref('stg_synthea__organizations') }}
where id is not null
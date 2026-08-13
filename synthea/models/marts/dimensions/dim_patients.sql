select 
    {{ dbt_utils.generate_surrogate_key(['id']) }} as patient_id,
	id as patient_source_id,
	birthdate as birth_date,
	deathdate as death_date,
	replace(ssn,'-','') as ssn,
	prefix,
	regexp_replace(first,'[0-9]+','') as first_name,
	regexp_replace(last,'[0-9]+','') as last_name,
	concat_ws(' ',regexp_replace(first,'[0-9]+',''),regexp_replace(last,'[0-9]+','')) as full_name,
	upper(race) as race,
	upper(ethnicity) as ethnicity,
	gender,
	city,
	state,
	county,
	address,
	healthcare_coverage
from {{ ref('stg_synthea__patients') }}

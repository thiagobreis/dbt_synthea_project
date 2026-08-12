select distinct
	{{ dbt_utils.generate_surrogate_key(['code']) }} as allergy_id,
	code as allergy_source_id,
	description  as allergy_description,
	type as allergy_type,
	category as allergy_category

from {{ ref('stg_synthea__allergies') }}
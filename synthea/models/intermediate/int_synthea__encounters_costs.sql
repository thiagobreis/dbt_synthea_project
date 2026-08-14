with	
medications as (
	select 
		encounter as encounter_source_id,
		code as medication_source_id,
		-1 as procedure_unique_id,
		-1 as immunization_source_id,
		-1 as encounter_unique_id,
		base_cost as base_cost,
		dispenses as quantity,
		totalcost as total_cost
	from {{ ref('stg_synthea__medications') }}
),

procedures as (
	select 
		encounter as encounter_source_id,
		-1 as medication_source_id,
		concat_ws('-',code,description) as procedure_unique_id,
		-1 as immunization_source_id,
		-1 as encounter_unique_id,
		base_cost as base_cost,
		1 as quantity, 
		base_cost as total_cost
	from {{ ref('stg_synthea__procedures') }}
),

immunizations as (
	select
		encounter as encounter_source_id,
		-1 as medication_source_id,
		-1 as procedure_unique_id,
		code as immunization_source_id,
		-1 as encounter_unique_id,
		base_cost as base_cost,
		1 as quantity, 
		base_cost as total_cost
	from {{ ref('stg_synthea__immunizations') }}
),

encounters AS (
	select 
		id as encounter_source_id,
		-1 as medication_source_id,
		-1 as procedure_unique_id,
		-1 as immunization_source_id,
		concat_ws('-',code,description) as encounter_unique_id,
		base_encounter_cost as base_cost,
		1 as quantity, 
		base_encounter_cost as total_cost
	from {{ ref('stg_synthea__encounters') }}
)

select 
	medications.*
from medications

union all

select
	procedures.*
from procedures

union all

select 
	immunizations.*
from immunizations

union all

select
	encounters.*
from encounters
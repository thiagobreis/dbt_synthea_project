with encounters as (
	select 
		id as encounter_source_id,
		start as dt_start,
		stop as dt_end,
		patient as patient_source_id,
		organization as organization_source_id,
		concat_ws('-',code,description) as encounter_unique_id,
		encounterclass as encounter_class	
	from {{ ref('stg_synthea__encounters') }}),
	
costs as (
	select *
	from {{ ref('int_synthea__encounters_costs') }}
)
	
SELECT 
	encounters.encounter_source_id,
	encounters.dt_start,
	encounters.dt_end,
	encounters.encounter_class,	
	dim_patients.patient_id,
	dim_organizations.organization_id,
	dim_immunizations.immunization_id,
	dim_medications.medication_id,
	costs.base_cost,
	costs.quantity,
	costs.total_cost

from encounters
    left join costs
        on encounters.encounter_source_id = costs.encounter_source_id
	left join {{ ref('dim_patients') }} dim_patients
		on encounters.patient_source_id = dim_patients.patient_source_id
	left join {{ ref('dim_organizations') }} dim_organizations
		on encounters.organization_source_id = dim_organizations.organization_source_id
	left join {{ ref('dim_encounters') }} dim_encounters
		on costs.encounter_unique_id = dim_encounters.encounter_unique_id
	left join {{ ref('dim_immunizations') }} dim_immunizations
		on costs.immunization_source_id = dim_immunizations.immunization_source_id
	left join {{ ref('dim_medications') }} dim_medications
		on costs.medication_source_id = dim_medications.medication_source_id
    
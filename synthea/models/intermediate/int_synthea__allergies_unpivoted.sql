with unpivoted as (
select 
	patient as id_patient,
	encounter as id_encounter,
	1 as reaction_slot,
	code as id_allergie,
	coalesce(REACTION1,-1)  AS ID_REACTION,
	coalesce(DESCRIPTION1,'Not Specified') AS DS_REACTION,
	CASE
		UPPER(SEVERITY1) 
		WHEN 'MILD' THEN 1
		WHEN 'MODERATE' THEN 2
		WHEN 'SEVERE' THEN 3
		ELSE -1
	END AS LVL_SEVERITY,
	coalesce(SEVERITY1,'Not Specified') AS DS_SEVERITY
	
FROM {{ref('stg_synthea__allergies')}}
where REACTION1 is not null
	
union all

select 
	patient as id_patient,
	encounter as id_encounter,
	2 as reaction_slot,
	code as id_allergie,
	coalesce(REACTION2,-1)  AS ID_REACTION,
	coalesce(DESCRIPTION2,'Not Specified') AS DS_REACTION,
	CASE
		UPPER(SEVERITY2) 
		WHEN 'MILD' THEN 1
		WHEN 'MODERATE' THEN 2
		WHEN 'SEVERE' THEN 3
		ELSE -1
	END AS LVL_SEVERITY,
	coalesce(SEVERITY2,'Not Specified') AS DS_SEVERITY
	
FROM {{ref('stg_synthea__allergies')}}
where REACTION2 is not null)

select *
from unpivoted
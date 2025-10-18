-- INIT inset for this query 
-- DELETE FROM production.dataImports.stg_lat 
INSERT INTO production.dataImports.stg_lat
select
distinct
si.import_id,
sli.id,
sli.employer,
sli.laborOrganization,
sli.local,
sli.industry,
sli.bargainingUnitSize,
sli.numberOfLocations,
sli.address,
sli.city,
sli.state,
sli.zipCode,
sli.latitudeLongitude,
sli.approximateNumberOfParticipants,
sli.startDate,
sli.endDate,
sli.durationAmount,
sli.durationUnit,
sli.strikeOrProtest,
sli.authorized,
sli.workerDemands,
sli.source,
sli.notes 
from production.dataImports.stg_lat_imports sli 
LEFT JOIN production.dataImports.stg_imports si 
ON sli.import_dt = si.import_dt
where 
sli.id NOT IN(
select id from production.dataImports.stg_lat
)
and si.import_id = 12650
;
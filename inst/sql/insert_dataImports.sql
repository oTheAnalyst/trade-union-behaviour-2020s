-- INIT inset for this query 
-- DELETE FROM dev.dataImports.stg_lat 
INSERT INTO dev.dataImports.stg_lat
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
from dev.dataImports.stg_lat_imports sli 
LEFT JOIN dev.dataImports.stg_imports si 
ON sli.import_dt = si.import_dt
where
sli.id NOT IN(
select id from dev.dataImports.stg_lat
)
;

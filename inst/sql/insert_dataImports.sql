-- INIT inset for this query 
-- DELETE FROM stg_lat 
INSERT INTO stg_lat
select
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
from stg_csv sli 
LEFT JOIN stg_imports si 
ON sli.import_dt = si.import_dt
where 
sli.id NOT IN(
select id from stg_lat
) 
GROUP BY 
  ALL
;

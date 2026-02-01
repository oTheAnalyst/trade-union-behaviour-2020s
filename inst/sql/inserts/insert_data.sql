-- insert excel into log excel
INSERT INTO stg_imports 
 SELECT 
 nextval('serial'),
 import_dt,
 'email',
'/home/pretender/R/x86_64-pc-linux-gnu-library/4.4/dsa/extdata'
 'NA',
 'NA',
 'NA'
 FROM stg_excel
 WHERE 
 import_dt
 NOT IN(
select import_dt from stg_imports 
 )
 GROUP BY import_dt;


-- insert data from excel excel to 
--    stg_lat_imports setup for stagging
insert into stg_lat
SELECT
log.import_id,
excel.id,
excel.employer,
excel.laborOrganization,
excel.local,
excel.industry,
excel.bargainingUnitSize,
excel.numberOfLocations,
excel.address,
excel.city,
excel.state,
excel.zipCode,
excel.latitudeLongitude,
excel.approximateNumberOfParticipants,
excel.startDate,
excel.endDate,
excel.durationAmount,
excel.durationUnit,
excel.strikeOrProtest,
excel.authorized,
excel.workerDemands,
excel.source,
excel.notes 
FROM stg_excel excel 
JOIN stg_imports log 
ON excel.import_dt = log.import_dt
WHERE 
excel.id NOT IN(
select id from stg_lat 
   where id is not null 
   group by id 
) 
;

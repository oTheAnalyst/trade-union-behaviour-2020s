DELETE FROM production.dataImports.stg_lat
where startDate IS NULL;



INSERT INTO production.main.date_key
select
startDate,
endDate,
id
from production.dataImports.stg_lat
WHERE 
id NOT IN(
select id from production.main.date_key
)
;

INSERT INTO production.main.trade_union 
select
id,
STRING_SPLIT(laborOrganization,';').UNNEST() as t2,
bargainingUnitSize,
STRING_SPLIT(workerDemands,';').UNNEST() as t1
from production.dataImports.stg_lat
WHERE 
id NOT IN(
select id from production.main.trade_union
)
;


INSERT INTO production.main.strike  
select
approximateNumberOfParticipants,
startDate,
endDate,
durationUnit,
durationAmount,
strikeOrProtest,
authorized,
numberOfLocations,
STRING_SPLIT(source,';').UNNEST() as s,
notes,
id
from production.dataImports.stg_lat
WHERE startDate IS NOT NULL
and
id NOT IN(
select id from production.main.strike
)
;


INSERT INTO production.main.employer
select
id,
STRING_SPLIT(local, ';').UNNEST() as local,
industry,
STRING_SPLIT(employer, ';').UNNEST() Employer,
from production.dataImports.stg_lat
WHERE
id NOT IN(
select id from production.main.employer
)

;

INSERT INTO production.main.lat_lon
select 
id,
STRING_SPLIT(latitudeLongitude, ';').UNNEST() latitudeLongitude
from production.dataImports.stg_lat
WHERE
id NOT IN(
select id from production.main.lat_lon
)
;


INSERT INTO production.main.location
select
id,
STRING_SPLIT(state, ';').UNNEST() State,
STRING_SPLIT(address, ';').UNNEST() Address,
STRING_SPLIT(city, ';').UNNEST() City,
STRING_SPLIT(zipCode, ';').UNNEST() zipcode
from production.dataImports.stg_lat
WHERE
id NOT IN(
select id from production.main.location
)
;


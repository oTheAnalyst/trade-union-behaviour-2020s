INSERT INTO main.strikeOrProtest
select
id,
approximateNumberOfParticipants,
startDate,
endDate,
durationUnit,
durationAmount,
strikeOrProtest,
authorized,
numberOfLocations
from stg_lat
WHERE startDate IS NOT NULL
and
id NOT IN(
select id from main.strikeOrProtest
)
;



INSERT INTO main.workerDemands 
select
id,
STRING_SPLIT(workerDemands,';').UNNEST() as t1
from stg_lat
WHERE 
id NOT IN(
select id from main.workerDemands
)
;


INSERT INTO main.trade_union 
select
id,
STRING_SPLIT(laborOrganization,';').UNNEST() as t2,
bargainingUnitSize
from stg_lat
WHERE 
id NOT IN(
select id from main.trade_union
)
;



INSERT INTO main.citations
select
id,
STRING_SPLIT(source,';').UNNEST() as s,
notes,
from stg_lat
WHERE startDate IS NOT NULL
and
id NOT IN(
select id from main.citations
)
;


INSERT INTO main.employer
select
id,
STRING_SPLIT(local, ';').UNNEST() as local,
industry,
STRING_SPLIT(employer, ';').UNNEST() Employer,
from stg_lat
WHERE
id NOT IN(
select id from main.employer
)

;

INSERT INTO main.lat_lon
select 
id,
STRING_SPLIT(latitudeLongitude, ';').UNNEST() latitudeLongitude
from stg_lat
WHERE
id NOT IN(
select id from main.lat_lon
)
;


INSERT INTO main.location
select
id,
STRING_SPLIT(state, ';').UNNEST() State,
STRING_SPLIT(address, ';').UNNEST() Address,
STRING_SPLIT(city, ';').UNNEST() City,
STRING_SPLIT(zipCode, ';').UNNEST() zipcode
from stg_lat
WHERE
id NOT IN(
select id from main.location
)
;


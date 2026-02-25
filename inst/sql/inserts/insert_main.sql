INSERT INTO main.strikeOrProtest
select
nextval('strikeOrProtest_id'),
id,
startDate,
endDate,
durationUnit,
strikeOrProtest,
authorized,
STRING_SPLIT(workerDemands,';').UNNEST()
from stg_lat
WHERE startDate IS NOT NULL
and
id NOT IN(
select id from main.strikeOrProtest
)
;




INSERT INTO main.tradeUnion 
select
nextval('trade_union_id'),
id,
STRING_SPLIT(laborOrganization,';').UNNEST() as t2,
bargainingUnitSize
from stg_lat
WHERE 
id NOT IN(
select id from main.tradeUnion
)
;



INSERT INTO main.citations
select
nextval('citation_id'),
id,
STRING_SPLIT(source,';').UNNEST() as s,
notes
from stg_lat
WHERE startDate IS NOT NULL
and
id NOT IN(
select id from main.citations
)
;


INSERT INTO main.employer
select
nextval('employer_id'),
id,
STRING_SPLIT(local, ';').UNNEST() as local,
STRING_SPLIT(industry, ';').UNNEST() as industry,
STRING_SPLIT(employer, ';').UNNEST() as employer
from stg_lat
WHERE
id NOT IN(
select id from main.employer
)

;


LOAD spatial;
INSERT INTO main.location
select
nextval('location_id'),
l1.id,
STRING_SPLIT(l1.state, ';').UNNEST() State,
STRING_SPLIT(l1.address, ';').UNNEST() Address,
STRING_SPLIT(l1.city, ';').UNNEST() City,
STRING_SPLIT(l1.zipCode, ';').UNNEST() zipcode,
  st_point(
  split_part(STRING_SPLIT(l1.latitudeLongitude, ';').UNNEST(), ',',2)::double,
  split_part(STRING_SPLIT(l2.latitudeLongitude, ';').UNNEST(), ',', 1)::double
  ) as point
from stg_lat as l1
join stg_lat as l2
on l1.id = l2.id
WHERE
l1.id NOT IN(
select id from main.location
)
;


INSERT INTO starLat.strikeOrProtest
with cte as(
  select distinct
stg_lat.id,
stg_lat.strikeOrProtest,
stg_lat.authorized,
(stg_lat.workerDemands).STRING_SPLIT(';').UNNEST(),
NULL,
'current'
FROM stg_backup.stg_lat as stg_lat
JOIN stg_backup.stg_imports as stg_imports
on stg_lat.import_id = stg_imports.import_id
WHERE 
 stg_lat.import_id = 105

) 
select 
('strikeOrProtest_id').nextval(),
    * 
  from cte
   group by all
    order by id desc
  





INSERT INTO starLat.tradeUnion 
select
nextval('trade_union_id'),
id,
STRING_SPLIT(laborOrganization,';').UNNEST() as t2,
bargainingUnitSize,
NULL,
'current'
from stg_backup.stg_lat
WHERE 
(startDate IS NOT NULL
and import_id = 105)
;



INSERT INTO starLat.citations
select
nextval('citation_id'),
id,
STRING_SPLIT(source,';').UNNEST() as s,
notes,
NULL,
'current'
from stg_backup.stg_lat
WHERE 
(startDate IS NOT NULL
and import_id = 105)
;


INSERT INTO starLat.employer
select
nextval('employer_id'),
id,
STRING_SPLIT(local, ';').UNNEST() as local,
STRING_SPLIT(industry, ';').UNNEST() as industry,
STRING_SPLIT(employer, ';').UNNEST() as employer,
NULL,
'current'
from stg_backup.stg_lat
WHERE
(startDate IS NOT NULL
and import_id = 105)
;


LOAD spatial;
INSERT INTO starLat.location
  with cte as(
select
nextval('location_id') internal_id,
l1.id,
STRING_SPLIT(l1.state, ';').UNNEST() State,
STRING_SPLIT(l1.address, ';').UNNEST() Address,
STRING_SPLIT(l1.city, ';').UNNEST() City,
STRING_SPLIT(l1.zipCode, ';').UNNEST() zipcode,
  st_point(
  split_part(STRING_SPLIT(l1.latitudeLongitude, ';').UNNEST(), ',',2)::double,
  split_part(STRING_SPLIT(l2.latitudeLongitude, ';').UNNEST(), ',', 1)::double
  ) as point
from stg_backup.stg_lat as l1
join stg_backup.stg_lat as l2
on l1.id = l2.id
where l1.import_id = 105
  ) 
  select 
     internal_id,
      id,
      State,
     split_part(Address,',', 1) as Address,
      lower(trim(City,', \n . ')) as City,
      zipcode,
      point,
      NULL,
      'current'
  from cte
;


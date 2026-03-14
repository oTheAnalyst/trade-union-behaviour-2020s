-- run update to add expired rows
WITH src AS (
			select
				distinct id,
				strikeOrProtest,
				authorized,
				(workerDemands).STRING_SPLIT(';').UNNEST() as workerDemands
			from
				stg_lat
			where
				import_id = 107
)
UPDATE strikeOrProtest
SET
    rowExpirationDate = current_localtimestamp(),
    rowIndicator = 'expired'
FROM strikeOrProtest AS tgt
WHERE tgt.rowIndicator = 'current'
  AND NOT EXISTS (
      SELECT 1
      FROM src
      WHERE src.id = tgt.id
        AND IFNULL(src.strikeOrProtest, '') = IFNULL(tgt.strikeOrProtest, '')
        AND IFNULL(src.authorized, '')      = IFNULL(tgt.authorized, '')
        AND IFNULL(src.workerDemands, '')   = IFNULL(tgt.workerDemands, '')
  );

-- run insert to add new data
WITH src AS (
			select
				distinct id,
				strikeOrProtest,
				authorized,
				(workerDemands).STRING_SPLIT(';').UNNEST() as workerDemands
			from
				stg_lat
			where
				import_id = 107
)
INSERT INTO local.strikeOrProtest (
    id,
    strikeOrProtest,
    authorized,
    workerDemands,
    rowExpirationDate,
    rowIndicator
)
SELECT
    src.id,
    src.strikeOrProtest,
    src.authorized,
    src.workerDemands,
    NULL,
    'current'
FROM src
WHERE NOT EXISTS (
    SELECT 1
    FROM strikeOrProtest AS tgt
    WHERE tgt.rowIndicator = 'current'
      AND tgt.id = src.id
      AND IFNULL(tgt.strikeOrProtest, '') = IFNULL(src.strikeOrProtest, '')
      AND IFNULL(tgt.authorized, '')      = IFNULL(src.authorized, '')
      AND IFNULL(tgt.workerDemands, '')   = IFNULL(src.workerDemands, '')
);



with cte as(
  INSERT INTO starLat.tradeUnion 
  select
    nextval('trade_union_id'),
    id,
    STRING_SPLIT(laborOrganization,';').UNNEST() as laborOrganization,
    bargainingUnitSize,
    NULL,
    'current'
  from stg_backup.stg_lat
  WHERE 
  (startDate IS NOT NULL
  and import_id = 107)
) 
UPDATE strikeOrProtest
SET
    rowExpirationDate = current_localtimestamp(),
    rowIndicator = 'expired'
FROM strikeOrProtest AS tgt
WHERE tgt.rowIndicator = 'current'
  AND NOT EXISTS (
      SELECT 1
      FROM src
      WHERE src.id = tgt.id
        AND IFNULL(src.laborOrganization, '') = IFNULL(tgt.laborOrganization, '')
        AND IFNULL(src.bargainingUnitSize, '')      = IFNULL(tgt.bargainingUnitSize, '')
  );



WITH src AS (
			select distinct
              nextval('trade_union_id'),
              id,
              STRING_SPLIT(laborOrganization,';').UNNEST() as laborOrganization,
              bargainingUnitSize,
			from
				stg_lat
			where
				import_id = 107
)
INSERT INTO tradeUnion (
    id,
     laborOrganization,
     bargainingUnitSize,
     rowExpirationDate,
     rowIndicator
)
SELECT
    src.id,
    src.laborOrganization,
    src.bargainingUnitSize,
    src.rowExpirationDate,
    NULL,
    'current'
FROM src
WHERE NOT EXISTS (
    SELECT 1
    FROM tradeUnion AS tgt
    WHERE tgt.rowIndicator = 'current'
      AND tgt.id = src.id
      AND IFNULL(tgt.laborOrganization, '') = IFNULL(src.laborOrganization, '')
      AND IFNULL(tgt.bargainingUnitSize, '')      = IFNULL(src.bargainingUnitSize, '')
);










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


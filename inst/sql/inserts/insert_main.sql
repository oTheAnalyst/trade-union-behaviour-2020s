-- run update to add expired rows
WITH strikecte AS (
			select
				distinct id,
				strikeOrProtest,
				authorized,
				(workerDemands).STRING_SPLIT(';').UNNEST() as workerDemands
			from
				stg_backup.stg_lat
			where
				import_id = 133
)
UPDATE starLat.strikeOrProtest
SET
    rowExpirationDate = current_localtimestamp(),
    rowIndicator = 'expired'
FROM starLat.strikeOrProtest AS tgt
WHERE tgt.rowIndicator = 'current'
  AND NOT EXISTS (
      SELECT 1
      FROM strikecte
      WHERE strikecte.id = tgt.id
        AND IFNULL(strikecte.strikeOrProtest, '') = IFNULL(tgt.strikeOrProtest, '')
        AND IFNULL(strikecte.authorized, '')      = IFNULL(tgt.authorized, '')
        AND IFNULL(strikecte.workerDemands, '')   = IFNULL(tgt.workerDemands, '')
  );

-- run insert to add new data
WITH strikecte AS (
			select
				distinct id,
				strikeOrProtest,
				authorized,
				(workerDemands).STRING_SPLIT(';').UNNEST() as workerDemands
			from
				stg_backup.stg_lat
			where
				import_id = 133
)
INSERT INTO starLat.strikeOrProtest (
    id,
    strikeOrProtest,
    authorized,
    workerDemands,
    rowExpirationDate,
    rowIndicator
)
SELECT
    strikecte.id,
    strikecte.strikeOrProtest,
    strikecte.authorized,
    strikecte.workerDemands,
    NULL,
    'current'
FROM strikecte
WHERE NOT EXISTS (
    SELECT 1
    FROM starLat.strikeOrProtest AS tgt
    WHERE tgt.rowIndicator = 'current'
      AND tgt.id = strikecte.id
      AND IFNULL(tgt.strikeOrProtest, '') = IFNULL(strikecte.strikeOrProtest, '')
      AND IFNULL(tgt.authorized, '')      = IFNULL(strikecte.authorized, '')
      AND IFNULL(tgt.workerDemands, '')   = IFNULL(strikecte.workerDemands, '')
);



WITH unioncte AS(
  SELECT
    nextval('trade_union_id'),
    id,
    STRING_SPLIT(laborOrganization,';').UNNEST() as laborOrganization,
    bargainingUnitSize,
    NULL,
   'current'
FROM stg_backup.stg_lat
WHERE 
  import_id = 133
) 
UPDATE starLat.tradeUnion
SET
    rowExpirationDate = current_localtimestamp(),
    rowIndicator = 'expired'
FROM starLat.tradeUnion AS tgt
WHERE tgt.rowIndicator = 'current'
  AND NOT EXISTS (
        SELECT 1
        FROM unioncte
        WHERE unioncte.id = tgt.id
          AND 
          (
          unioncte.laborOrganization = tgt.laborOrganization
          OR (unioncte.laborOrganization IS NULL AND tgt.laborOrganization IS NULL)
          ) 
          AND
          (
          unioncte.bargainingUnitSize = tgt.bargainingUnitSize
          OR (unioncte.bargainingUnitSize IS NULL AND tgt.bargainingUnitSize  IS NULL)
          )
  );



WITH unioncte AS (
			select distinct
              nextval('trade_union_id'),
              id,
              STRING_SPLIT(laborOrganization,';').UNNEST() as laborOrganization,
              bargainingUnitSize,
			from
				stg_backup.stg_lat
			where
				import_id = 133
)
INSERT INTO starLat.tradeUnion (
    id,
     laborOrganization,
     bargainingUnitSize,
     rowExpirationDate,
     rowIndicator
)
SELECT
    unioncte.id,
    unioncte.laborOrganization,
    unioncte.bargainingUnitSize,
    NULL,
    'current'
FROM unioncte 
WHERE NOT EXISTS (
        SELECT 1
        FROM unioncte as tgt
        WHERE unioncte.id = tgt.id
          AND 
          (
              unioncte.laborOrganization = tgt.laborOrganization
          OR (unioncte.laborOrganization IS NULL AND tgt.laborOrganization IS NULL)
          ) 
          AND
          (
              unioncte.bargainingUnitSize = tgt.bargainingUnitSize
          OR (unioncte.bargainingUnitSize IS NULL AND tgt.bargainingUnitSize  IS NULL)
          )
);


-- citations table
with src as(
      select
        nextval('citation_id'),
        id,
        STRING_SPLIT(source,';').UNNEST() as source,
        notes,
        NULL,
        'current'
      FROM stg_backup.stg_lat
      WHERE 
        import_id = 133
  )
UPDATE starLat.citations 
SET 
    rowExpirationDate = current_localtimestamp(),
    rowIndicator = 'expired'
FROM starLat.citations AS tgt
WHERE tgt.rowIndicator = 'current'
  AND NOT EXISTS (
      SELECT 1
      FROM src
      WHERE src.id = tgt.id
        AND IFNULL(src.notes, '') = IFNULL(tgt.notes, '')
        AND IFNULL(src.source, '') = IFNULL(tgt.source, '')
  );


WITH src AS (
			SELECT DISTINCT
        id,
        nextval('citation_id') as internal_id,
        STRING_SPLIT(source,';').UNNEST() as source,
        notes,
			FROM
				stg_backup.stg_lat
			WHERE
				import_id = 133
)
INSERT INTO starLat.citations (
    id,
    source,
    notes,
    rowExpirationDate,
    rowIndicator
)
SELECT
    src.id,
    src.source,
    src.notes,
    NULL,
    'current'
FROM src
WHERE NOT EXISTS (
    SELECT 1
    FROM starLat.citations AS tgt
    WHERE tgt.rowIndicator = 'current'
      AND tgt.id = src.id
      AND IFNULL(tgt.source, '') = IFNULL(src.source, '')
      AND IFNULL(tgt.notes, '')      = IFNULL(src.notes, '')
);


WITH employercte AS(
    select
        nextval('employer_id'),
        id,
        STRING_SPLIT(local, ';').UNNEST() as local,
        STRING_SPLIT(industry, ';').UNNEST() as industry,
        STRING_SPLIT(employer, ';').UNNEST() as employer,
    from stg_backup.stg_lat
    WHERE
        import_id = 133
    )
UPDATE starLat.employer
SET
    rowExpirationDate = current_localtimestamp(),
    rowIndicator = 'expired'
FROM starLat.employer AS tgt
WHERE tgt.rowIndicator = 'current'
  AND NOT EXISTS (
      SELECT 1
      FROM employercte
      WHERE employercte.id = tgt.id
        AND IFNULL(employercte.local, '') = IFNULL(tgt.local, '')
        AND IFNULL(employercte.industry, '')      = IFNULL(tgt.industry, '')
        AND IFNULL(employercte.employer, '')   = IFNULL(tgt.employer, '')
  );



-- run insert to add new data
WITH employercte AS (
			SELECT DISTINCT
            id,
            STRING_SPLIT(local, ';').UNNEST() as local,
            STRING_SPLIT(industry, ';').UNNEST() as industry,
            STRING_SPLIT(employer, ';').UNNEST() as employer,
			from
			stg_backup.	stg_lat
			where
				import_id = 133
)
INSERT INTO starLat.employer (
    id,
    local,
    industry,
    employer,
    rowExpirationDate,
    rowIndicator
)
SELECT
    employercte.id,
    employercte.local,
    employercte.industry,
    employercte.employer,
    NULL,
    'current'
FROM employercte
WHERE NOT EXISTS (
    SELECT 1
    FROM starLat.employer AS tgt
    WHERE tgt.rowIndicator = 'current'
        AND tgt.id = employercte.id
        AND IFNULL(employercte.local, '') = IFNULL(tgt.local, '')
        AND IFNULL(employercte.industry, '')      = IFNULL(tgt.industry, '')
        AND IFNULL(employercte.employer, '')   = IFNULL(tgt.employer, '')
);




LOAD spatial;
  with cte as(
  select
    nextval('location_id') internal_id,
    l1.id,
    (l1.state).STRING_SPLIT(';').UNNEST() as State,
    (l1.address).STRING_SPLIT(';').UNNEST() as Address,
    (l1.city).STRING_SPLIT(';').UNNEST() as City,
    (l1.zipCode).STRING_SPLIT(';').UNNEST() as zipcode,
    st_point(
    (l1.latitudeLongitude).STRING_SPLIT(';').UNNEST().SPLIT_PART(',',1)::double,
    (l2.latitudeLongitude).STRING_SPLIT(';').UNNEST().SPLIT_PART(',',2)::double
          ) as point
from stg_backup.stg_lat as l1
join stg_backup.stg_lat as l2
on l1.id = l2.id
where l1.import_id = 133
  ), locationcte as( 
  select
     internal_id,
      id,
      State,
     (Address).split_part(',', 1) as Address,
     (City).trim(', \n . ').lower() as City,
      zipcode,
      point,
  from cte
  )
UPDATE starLat.location
SET
    rowExpirationDate = current_localtimestamp(),
    rowIndicator = 'expired'
FROM starLat.location AS tgt
WHERE tgt.rowIndicator = 'current'
  AND NOT EXISTS (
      SELECT 1
      FROM locationcte
      WHERE locationcte.id = tgt.id
        AND IFNULL(locationcte.State, '') = IFNULL(tgt.state, '')
        AND IFNULL(locationcte.Address, '')      = IFNULL(tgt.address, '')
        AND IFNULL(locationcte.City, '')   = IFNULL(tgt.city, '')
        AND IFNULL(locationcte.zipCode, '')   = IFNULL(tgt.zipCode, '')
        AND IFNULL(locationcte.point, '')   = IFNULL(tgt.point, '')
  );



load spatial;
WITH cte AS(
  SELECT
    nextval('location_id') AS internal_id,
    l1.id,
    (l1.state).STRING_SPLIT(';').UNNEST() AS State,
    (l1.address).STRING_SPLIT(';').UNNEST() AS Address,
    (l1.city).STRING_SPLIT(';').UNNEST() AS City,
    (l1.zipCode).STRING_SPLIT(';').UNNEST() AS zipcode,
      st_point(
      (l1.latitudeLongitude).STRING_SPLIT(';').UNNEST().SPLIT_PART(',',1)::double,
      (l2.latitudeLongitude).STRING_SPLIT(';').UNNEST().SPLIT_PART(',',2)::double
      ) AS point
    FROM stg_backup.stg_lat AS l1
    JOIN stg_backup.stg_lat AS l2
    ON l1.id = l2.id
    WHERE l1.import_id = 133
  ), locationcte as( 
  SELECT
      DISTINCT
     internal_id,
      id,
      State,
     (Address).split_part(',', 1) AS Address,
     (City).trim(', \n . ').lower() AS City,
      zipcode,
      point,
   FROM cte
  )
INSERT INTO 
starLat."location" (
    id,
    state,
    address,
    city,
    zipCode,
    point,
    rowExpirationDate,
    rowIndicator
)
SELECT
    locationcte.id,
    locationcte.state,
    locationcte.address,
    locationcte.city,
    locationcte.zipCode,
    locationcte.point,
    NULL,
    'current'
FROM locationcte
WHERE NOT EXISTS (
    SELECT 1
    FROM starLat.location AS tgt
    WHERE tgt.rowIndicator = 'current'
      AND tgt.id = locationcte.id
      AND IFNULL(tgt.State, '') = IFNULL(locationcte.State, '')
      AND IFNULL(tgt.Address, '')      = IFNULL(locationcte.Address, '')
      AND IFNULL(tgt.City, '')   = IFNULL(locationcte.City, '')
      AND IFNULL(tgt.zipcode, '')   = IFNULL(locationcte.zipcode, '')
      AND IFNULL(tgt.point, '')   = IFNULL(locationcte.point, '')
);





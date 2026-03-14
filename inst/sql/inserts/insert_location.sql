SET memory_limit = '5GB';

LOAD spatial;
CREATE TEMP TABLE locationtmp AS
with cte as(
  SELECT
    DISTINCT
    l1.id,
    (l1.state).STRING_SPLIT(';').UNNEST() as State,
    (l1.address).STRING_SPLIT(';').UNNEST() as Address,
    (l1.city).STRING_SPLIT(';').UNNEST() as City,
    (l1.zipCode).STRING_SPLIT(';').UNNEST() as zipcode,
    CASE WHEN 
      (l1.latitudeLongitude).STRING_SPLIT(';').UNNEST().SPLIT_PART(',',1) = 'null'
      THEN NULL
      ELSE (l1.latitudeLongitude).STRING_SPLIT(';').UNNEST().SPLIT_PART(',',1)::double
      END as ls1,
    CASE WHEN
      (l2.latitudeLongitude).STRING_SPLIT(';').UNNEST().SPLIT_PART(',',2) = 'null'
      THEN NULL::double
      ELSE (l2.latitudeLongitude).STRING_SPLIT(';').UNNEST().SPLIT_PART(',',2)::double
      END as ls2
FROM stg_backup.stg_lat as l1
JOIN stg_backup.stg_lat as l2
ON l1.id = l2.id
WHERE l1.import_id = 133
  )
  SELECT
    DISTINCT
      id,
      State,
     (Address).split_part(',', 1) as Address,
     (City).trim(', \n . ').lower() as City,
      zipcode,
      st_point(ls1,ls2) as point
  FROM cte

;


UPDATE starLat.location
SET
    rowExpirationDate = current_localtimestamp(),
    rowIndicator = 'expired'
FROM starLat.location AS tgt
WHERE tgt.rowIndicator = 'current'
  AND NOT EXISTS (
      SELECT 1
      FROM locationtmp
        WHERE locationtmp.id = tgt.id
          AND (locationtmp.State = tgt.State OR (locationtmp.State IS NULL AND tgt.State IS NULL))
          AND (locationtmp.Address = tgt.Address OR (locationtmp.Address IS NULL AND tgt.Address  IS NULL))
          AND (locationtmp.City = tgt.City OR (locationtmp.City IS NULL AND tgt.City IS NULL))
          AND (locationtmp.zipCode = tgt.zipCode OR (locationtmp.zipCode IS NULL AND tgt.zipCode  IS NULL))
          AND (locationtmp.point = tgt.point OR (locationtmp.point IS NULL AND tgt.point  IS NULL))
     );


load spatial;
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
    locationtmp.id,
    locationtmp.state,
    locationtmp.address,
    locationtmp.city,
    locationtmp.zipCode,
    locationtmp.point,
    NULL,
    'current'
FROM locationtmp
WHERE 
NOT EXISTS (
    SELECT 1
    FROM starLat.location AS tgt
    WHERE tgt.rowIndicator = 'current'
          AND (locationtmp.State = tgt.State OR (locationtmp.State IS NULL AND tgt.State IS NULL))
          AND (locationtmp.Address = tgt.Address OR (locationtmp.Address IS NULL AND tgt.Address  IS NULL))
          AND (locationtmp.City = tgt.City OR (locationtmp.City IS NULL AND tgt.City IS NULL))
          AND (locationtmp.zipCode = tgt.zipCode OR (locationtmp.zipCode IS NULL AND tgt.zipCode  IS NULL))
          AND (locationtmp.point = tgt.point OR (locationtmp.point IS NULL AND tgt.point  IS NULL))
      );





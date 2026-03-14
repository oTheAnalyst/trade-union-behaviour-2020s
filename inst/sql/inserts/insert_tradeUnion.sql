SET memory_limit = '4GB';

CREATE TEMP TABLE uniontmp as
  SELECT DISTINCT
      id,
      STRING_SPLIT(laborOrganization,';').UNNEST().TRIM() as laborOrganization,
      CASE WHEN 
      bargainingUnitSize = 0 THEN NULL
      ELSE bargainingUnitSize END
      as bargainingUnitSize
  FROM stg_backup.stg_lat
  WHERE 
    import_id = 133
;


--tradeUnion update
UPDATE starLat.tradeUnion
SET
    rowExpirationDate = current_localtimestamp(),
    rowIndicator = 'expired'
FROM starLat.tradeUnion AS tgt
WHERE tgt.rowIndicator = 'current'
  AND NOT EXISTS (
        SELECT 1
        FROM uniontmp
        WHERE uniontmp.id = tgt.id
          AND ( uniontmp.laborOrganization = tgt.laborOrganization
            OR (uniontmp.laborOrganization IS NULL AND tgt.laborOrganization IS NULL)) 
          AND
            ( uniontmp.bargainingUnitSize = tgt.bargainingUnitSize
            OR (uniontmp.bargainingUnitSize IS NULL AND tgt.bargainingUnitSize  IS NULL))
  );


--tradeUnion insert
INSERT INTO starLat.tradeUnion (
      id,
     laborOrganization,
     bargainingUnitSize,
     rowExpirationDate,
     rowIndicator
)
SELECT
    uniontmp.id,
    uniontmp.laborOrganization,
    uniontmp.bargainingUnitSize,
    NULL,
    'current'
FROM uniontmp 
WHERE NOT EXISTS (
        SELECT 1
        FROM starLat.tradeUnion as tgt
        WHERE tgt.rowIndicator = 'current' 
          AND 
          ( uniontmp.laborOrganization = tgt.laborOrganization
          OR (uniontmp.laborOrganization IS NULL AND tgt.laborOrganization IS NULL)
          ) 
          AND ( uniontmp.bargainingUnitSize = tgt.bargainingUnitSize
          OR (uniontmp.bargainingUnitSize IS NULL AND tgt.bargainingUnitSize  IS NULL)
          )
);


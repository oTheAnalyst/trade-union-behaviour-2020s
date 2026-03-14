SET memory_limit = '4GB';

UPDATE starLat.employer
SET
    rowExpirationDate = current_localtimestamp(),
    rowIndicator = 'expired'
FROM starLat.employer AS tgt
WHERE tgt.rowIndicator = 'current'
  AND NOT EXISTS (
      SELECT 1
      FROM stg_backup.employertmp as employertmp
      WHERE employertmp.id = tgt.id
        AND IFNULL(employertmp.local, '') = IFNULL(tgt.local, '')
        AND IFNULL(employertmp.industry, '')      = IFNULL(tgt.industry, '')
        AND IFNULL(employertmp.employer, '')   = IFNULL(tgt.employer, '')
  );


-- run insert to add new data
INSERT INTO starLat.employer (
    id,
    local,
    industry,
    employer,
    rowExpirationDate,
    rowIndicator
)
SELECT
    employertmp.id,
    employertmp.local,
    employertmp.industry,
    employertmp.employer,
    NULL,
    'current'
FROM stg_backup.employertmp
WHERE NOT EXISTS (
    SELECT 1
    FROM starLat.employer AS tgt
    WHERE tgt.rowIndicator = 'current'
        AND tgt.id = employertmp.id
        AND IFNULL(employertmp.local, '') = IFNULL(tgt.local, '')
        AND IFNULL(employertmp.industry, '')      = IFNULL(tgt.industry, '')
        AND IFNULL(employertmp.employer, '')   = IFNULL(tgt.employer, '')
);



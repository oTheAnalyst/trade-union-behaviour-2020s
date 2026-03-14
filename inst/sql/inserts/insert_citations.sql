SET memory_limit = '4GB';

UPDATE starLat.citations 
SET 
    rowExpirationDate = current_localtimestamp(),
    rowIndicator = 'expired'
;
SELECT * FROM
FROM starLat.citations AS tgt
WHERE 
NOT EXISTS (
    SELECT DISTINCT citationtmp.source
    FROM stg_backup.citationtmp AS citationtmp
    LEFT JOIN star_lat.citations as citationtmp
    ON citationtmp.id = citationtmp.id
    and citationtmp.import_id = 113 AND tgt.rowIndicator = 'current'
    WHERE ((citationtmp.id = tgt.id
           AND ( citationtmp.source = tgt.source OR tgt.source IS NULL) 
           AND ( citationtmp.notes = tgt.notes OR tgt.notes IS NULL)) ) 
  )
;

INSERT INTO starLat.citations (
    id,
    source,
    notes,
    rowExpirationDate,
    rowIndicator
)
SELECT 
    DISTINCT
    citationtmp.id,
    citationtmp.source,
    citationtmp.notes,
    NULL,
    'current'
FROM stg_backup.citationtmp as citationtmp
WHERE  citationtmp.import_id = 113 AND
  NOT EXISTS (
    SELECT tgt.id
    FROM starLat.citations AS tgt
    LEFT JOIN stg_backup.citationtmp as citationtmp
    ON citationtmp.source = citationtmp.source 
    and citationtmp.id = 113 AND tgt.rowIndicator = 'current'
    WHERE ((citationtmp.id = tgt.id
           AND ( citationtmp.source = tgt.source OR tgt.source IS NULL) 
           AND ( citationtmp.notes = tgt.notes OR tgt.notes IS NULL)) ) 
  )
;



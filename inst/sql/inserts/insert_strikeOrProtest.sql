SET memory_limit = '4GB';

-- run update to add expired rows
create temp table striketmp as
			select
				distinct 
        id,
				strikeOrProtest,
				authorized,
				(workerDemands).STRING_SPLIT(';').UNNEST() as workerDemands
			from
				stg_backup.stg_lat
			where
				import_id = 133;


--strikeOrProtest UPDATE
UPDATE starLat.strikeOrProtest
SET
    rowExpirationDate = current_localtimestamp(),
    rowIndicator = 'expired'
FROM starLat.strikeOrProtest AS tgt
WHERE tgt.rowIndicator = 'current'
  AND NOT EXISTS (
      SELECT 1
      FROM striketmp
      WHERE striketmp.id = tgt.id
        AND IFNULL(striketmp.strikeOrProtest, '') = IFNULL(tgt.strikeOrProtest, '')
        AND IFNULL(striketmp.authorized, '')      = IFNULL(tgt.authorized, '')
        AND IFNULL(striketmp.workerDemands, '')   = IFNULL(tgt.workerDemands, '')
  );

-- strikeOrProtest insert
INSERT INTO starLat.strikeOrProtest (
    id,
    strikeOrProtest,
    authorized,
    workerDemands,
    rowExpirationDate,
    rowIndicator
)
SELECT
    striketmp.id,
    striketmp.strikeOrProtest,
    striketmp.authorized,
    striketmp.workerDemands,
    NULL,
    'current'
FROM striketmp
WHERE NOT EXISTS (
    SELECT 1
    FROM starLat.strikeOrProtest AS tgt
    WHERE tgt.rowIndicator = 'current'
      AND tgt.id = striketmp.id
      AND IFNULL(tgt.strikeOrProtest, '') = IFNULL(striketmp.strikeOrProtest, '')
      AND IFNULL(tgt.authorized, '')      = IFNULL(striketmp.authorized, '')
      AND IFNULL(tgt.workerDemands, '')   = IFNULL(striketmp.workerDemands, '')
);



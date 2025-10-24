--SET temp_directory = '~/temp_dir/';
--drop table sop
CREATE TEMP TABLE sop AS
    SELECT
    d.*,
    s.*,
    e.*
    FROM production.main.date_key d
    left join production.main.strikeOrProtest s
    on d.id = s.id 
    left join production.main.location e
    on e.id = d.id 
    where s.id is not null
;


-- past 5 year protest
SELECT
distinct
count(*) as NumberofProtestIn_maryland_InThePast5years
FROM
sop
where
strikeOrProtest ILIKE 'protest'
and state ILIKE 'maryland'
;

-- strikes in maryland 
SELECT
DISTINCT
count(*) as numberofprotest2021,
monthname(startDate) as monthname,
FROM sop
WHERE
strikeOrProtest ILIKE 'protest'
and state ILIKE 'maryland'
and startDate in(
    SELECT
    startDate
    FROM production.main.strikeOrProtest
    WHERE year(startDate) = 2021
)
GROUP BY monthname, month(startDate)
ORDER BY
month(startDate)
ASC
;


SELECT
DISTINCT
count(*) as numberofprotest2022,
monthname(startDate) as monthname
FROM sop
WHERE
strikeOrProtest ILIKE 'protest'
and state ILIKE 'maryland'
and startDate in(
    SELECT
    startDate
    FROM production.main.strikeOrProtest
    WHERE year(startDate) = 2022
)
GROUP BY monthname, month(startDate)
ORDER BY
month(startDate)
ASC
;

SELECT
DISTINCT
count(*) as numberofprotest2023,
monthname(startDate) as monthname
FROM sop
WHERE
strikeOrProtest ILIKE 'protest'
and state ILIKE 'maryland'
and startDate in(
    SELECT
    startDate
    FROM production.main.strikeOrProtest
    WHERE year(startDate) = 2023
)
GROUP BY monthname, month(startDate)
ORDER BY
month(startDate)
ASC
;

SELECT
DISTINCT
count(*) as numberofprotest2024,
monthname(startDate) as monthname
FROM sop
WHERE
strikeOrProtest ILIKE 'protest'
and state ILIKE 'maryland'
and startDate in(
    SELECT
    startDate
    FROM production.main.strikeOrProtest
    WHERE year(startDate) = 2024
)
GROUP BY monthname, month(startDate)
ORDER BY
month(startDate)
ASC
;

SELECT
DISTINCT
count(*) as numberofprotest2025,
monthname(startDate) as monthname
FROM sop
WHERE
strikeOrProtest ILIKE 'protest'
and state ILIKE 'maryland'
and startDate in(
    SELECT
    startDate
    FROM production.main.strikeOrProtest
    WHERE year(startDate) = 2025
)
GROUP BY monthname, month(startDate)
ORDER BY
month(startDate)
ASC
;



-- past 5 year strike
SELECT
distinct
count(*) as Numberof_strikes_In_maryland_InThePast5years
FROM
sop
where
strikeOrProtest ILIKE 'strike'
and state ILIKE 'maryland'
;


SELECT
DISTINCT
count(*) as numberofstrike2021,
monthname(startDate) as monthname
FROM sop
WHERE
strikeOrProtest ILIKE 'strike'
and state ILIKE 'maryland'
and startDate in(
    SELECT
    startDate
    FROM production.main.strikeOrProtest
    WHERE year(startDate) = 2021
)
GROUP BY monthname, month(startDate)
ORDER BY
month(startDate)
ASC
;


SELECT
DISTINCT
count(*) as numberofstrike2022,
monthname(startDate) as monthname
FROM sop
WHERE
strikeOrProtest ILIKE 'strike'
and state ILIKE 'maryland'
and startDate in(
    SELECT
    startDate
    FROM production.main.strikeOrProtest
    WHERE year(startDate) = 2022
)
GROUP BY monthname, month(startDate)
ORDER BY
month(startDate)
ASC
;

SELECT
DISTINCT
count(*) as numberofstrike2023,
monthname(startDate) as monthname
FROM sop
WHERE
strikeOrProtest ILIKE 'strike'
and state ILIKE 'maryland'
and startDate in(
    SELECT
    startDate
    FROM production.main.strikeOrProtest
    WHERE year(startDate) = 2023
)
GROUP BY monthname, month(startDate)
ORDER BY
month(startDate)
ASC
;

SELECT
DISTINCT
count(*) as numberofstrike2024,
monthname(startDate) as monthname
FROM sop
WHERE
strikeOrProtest ILIKE 'strike'
and state ILIKE 'maryland'
and startDate in(
    SELECT
    startDate
    FROM production.main.strikeOrProtest
    WHERE year(startDate) = 2024
)
GROUP BY monthname, month(startDate)
ORDER BY
month(startDate)
ASC
;

SELECT
DISTINCT
count(*) as numberofstrike2025,
monthname(startDate) as monthname
FROM sop
WHERE
strikeOrProtest ILIKE 'strike'
and state ILIKE 'maryland'
and startDate in(
    SELECT
    startDate
    FROM production.main.strikeOrProtest
    WHERE year(startDate) = 2025
)
GROUP BY monthname, month(startDate)
ORDER BY
month(startDate)
ASC
;


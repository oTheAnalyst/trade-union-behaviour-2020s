
-- past 5 year protest
SELECT 
distinct
count(s.*) as NumberofProtestInMarylandInThePast5years
FROM production.main.date_key d
left join production.main.strikeOrProtest s
on d.id = s.id 
left join production.main.location e 
on e.id = d.id 
where s.id is not null
and s.strikeOrProtest ILIKE 'protest'
and e.state ILIKE 'maryland'
;

-- past 5 year strike
SELECT
distinct
count(s.*) as NumberofstrikestInMarylandInThePast5years
FROM production.main.date_key d
left join production.main.strikeOrProtest s
on d.id = s.id 
left join production.main.location e 
on e.id = d.id 
where s.id is not null
and s.strikeOrProtest ILIKE 'strike'
and e.state ILIKE 'maryland'
;


-- strikes in maryland 
SELECT
distinct
count(s.*) as numberofstrikes2021,
month(s.startDate) as month
FROM production.main.date_key d
left join production.main.strikeOrProtest s
on d.id = s.id
left join production.main.location e
on e.id = d.id
where s.id is not null
and s.strikeOrProtest ILIKE 'strike'
and e.state ILIKE 'maryland'
and s.startDate in(
    SELECT
    startDate
    FROM production.main.strikeOrProtest
    WHERE year(startDate) = 2021
)
GROUP BY month
ORDER BY month asc
;


-- strikes in maryland 
SELECT
count(s.*) as numberofstrikes2022,
month(s.startDate) as month
FROM production.main.date_key d
left join production.main.strikeOrProtest s
on d.id = s.id
left join production.main.location e
on e.id = d.id
where s.id is not null
and s.strikeOrProtest ILIKE 'strike'
and e.state ILIKE 'maryland'
and s.startDate in(
    SELECT
    startDate
    FROM production.main.strikeOrProtest
    WHERE year(startDate) = 2022
)
GROUP BY  s.startDate
ORDER BY month asc
;

-- strikes in maryland 
SELECT 
distinct
count(s.*) as numberofstrikes2023,
month(s.startDate) as month
FROM production.main.date_key d
left join production.main.strikeOrProtest s
on d.id = s.id
left join production.main.location e
on e.id = d.id
where s.id is not null
and s.strikeOrProtest ILIKE 'strike'
and e.state ILIKE 'maryland'
and s.startDate in(
    SELECT
    startDate
    FROM production.main.strikeOrProtest
    WHERE year(startDate) = 2023
)
GROUP BY month
ORDER BY month asc
;

-- strikes in maryland 
SELECT 
distinct
count(s.*) as numberofstrikes2024,
month(s.startDate) as month
FROM production.main.date_key d
left join production.main.strikeOrProtest s
on d.id = s.id
left join production.main.location e
on e.id = d.id
where s.id is not null
and s.strikeOrProtest ILIKE 'strike'
and e.state ILIKE 'maryland'
and s.startDate in(
    SELECT
    startDate
    FROM production.main.strikeOrProtest
    WHERE year(startDate) = 2024
)
GROUP BY month
ORDER BY month asc
;

SELECT 
distinct
count(s.*) as numberofstrikes2025,
month(s.startDate) as month
FROM production.main.date_key d
left join production.main.strikeOrProtest s
on d.id = s.id
left join production.main.location e
on e.id = d.id
where s.id is not null
and s.strikeOrProtest ILIKE 'strike'
and e.state ILIKE 'maryland'
and s.startDate in(
    SELECT
    startDate
    FROM production.main.strikeOrProtest
    WHERE year(startDate) = 2025
)
GROUP BY month
ORDER BY month asc
;


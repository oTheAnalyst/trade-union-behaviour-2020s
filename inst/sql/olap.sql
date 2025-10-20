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


PREPARE protestyear AS 
SELECT
distinct
count(s.*) as numberofprotestinayear,
monthname(s.startDate) as monthname,
month(s.startDate) numMonth
FROM production.main.date_key d
left join production.main.strikeOrProtest s
on d.id = s.id
left join production.main.location e
on e.id = d.id
where s.id is not null
and s.strikeOrProtest ILIKE $strikeorprotest 
and e.state ILIKE 'maryland'
and s.startDate in(
    SELECT
    startDate
    FROM production.main.strikeOrProtest
    WHERE year(startDate) = $year
)
GROUP BY monthname, numMonth
ORDER BY numMonth ASC
;


EXECUTE protestyear(strikeorprotest := 'protest', year := 2021);

SELECT
distinct
count(s.*) as numberofprotest2022,
monthname(s.startDate) as monthname,
month(s.startDate) numMonth
FROM production.main.date_key d
left join production.main.strikeOrProtest s
on d.id = s.id
left join production.main.location e
on e.id = d.id
where s.id is not null
and s.strikeOrProtest ILIKE 'protest'
and e.state ILIKE 'maryland'
and s.startDate in(
    SELECT
    startDate
    FROM production.main.strikeOrProtest
    WHERE year(startDate) = 2022
)
GROUP BY monthname, numMonth
ORDER BY numMonth ASC
;


-- strikes in maryland 
SELECT
distinct
count(s.*) as numberofprotest2023,
monthname(s.startDate) as monthname,
month(s.startDate) numMonth
FROM production.main.date_key d
left join production.main.strikeOrProtest s
on d.id = s.id
left join production.main.location e
on e.id = d.id
where s.id is not null
and s.strikeOrProtest ILIKE 'protest'
and e.state ILIKE 'maryland'
and s.startDate in(
    SELECT
    startDate
    FROM production.main.strikeOrProtest
    WHERE year(startDate) = 2023
)
GROUP BY monthname, numMonth
ORDER BY numMonth ASC
;

-- strikes in maryland 
SELECT
distinct
count(s.*) as numberofprotest2024,
monthname(s.startDate) as monthname,
month(s.startDate) numMonth
FROM production.main.date_key d
left join production.main.strikeOrProtest s
on d.id = s.id
left join production.main.location e
on e.id = d.id
where s.id is not null
and s.strikeOrProtest ILIKE 'protest'
and e.state ILIKE 'maryland'
and s.startDate in(
    SELECT
    startDate
    FROM production.main.strikeOrProtest
    WHERE year(startDate) = 2024
)
GROUP BY monthname, numMonth
ORDER BY numMonth ASC
;

SELECT
distinct
count(s.*) as numberofprotest2025,
monthname(s.startDate) as monthname,
month(s.startDate) numMonth
FROM production.main.date_key d
left join production.main.strikeOrProtest s
on d.id = s.id
left join production.main.location e
on e.id = d.id
where s.id is not null
and s.strikeOrProtest ILIKE 'protest'
and e.state ILIKE 'maryland'
and s.startDate in(
    SELECT
    startDate
    FROM production.main.strikeOrProtest
    WHERE year(startDate) = 2025
)
GROUP BY monthname, numMonth
ORDER BY numMonth ASC
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
monthname(s.startDate) as monthname,
month(s.startDate) numMonth
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
GROUP BY monthname, numMonth
ORDER BY numMonth ASC
;


-- strikes in maryland 
SELECT
distinct
count(s.*) as numberofstrikes2022,
monthname(s.startDate) as monthname,
month(s.startDate) numMonth
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
GROUP BY monthname, numMonth
ORDER BY numMonth ASC
;

-- strikes in maryland 
SELECT
distinct
count(s.*) as numberofstrikes2023,
monthname(s.startDate) as monthname,
month(s.startDate) numMonth
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
GROUP BY monthname, numMonth
ORDER BY numMonth ASC
;

-- strikes in maryland 
SELECT
distinct
count(s.*) as numberofstrikes2024,
monthname(s.startDate) as monthname,
month(s.startDate) numMonth
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
GROUP BY monthname, numMonth
ORDER BY numMonth ASC
;

SELECT
distinct
count(s.*) as numberofstrikes2025,
monthname(s.startDate) as monthname,
month(s.startDate) numMonth
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
GROUP BY monthname, numMonth
ORDER BY numMonth ASC
;


-- Most active trade_unions in the country
SELECT
count(t.laborOrganization) as Union_Strike_Leaderboard,
t.laborOrganization
FROM production.main.date_key d
LEFT JOIN production.main.strikeOrProtest s
ON d.id = s.id
LEFT JOIN production.main.location e
ON e.id = d.id
LEFT JOIN production.main.trade_union t
ON d.id = t.id
WHERE
s.strikeOrProtest ILIKE 'strike'
AND t.laborOrganization is not null
AND s.startDate
IN(
    SELECT
    startDate
    FROM production.main.strikeOrProtest
    WHERE year(startDate) = 2025
)
GROUP BY t.laborOrganization
ORDER BY Union_Strike_Leaderboard DESC
;



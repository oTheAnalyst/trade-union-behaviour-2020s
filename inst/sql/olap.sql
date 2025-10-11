

-- strikes in maryland 
SELECT 
distinct
count(s.*) as numberofstrikes
FROM production.main.date_key d
left join production.main.strike s 
on d.id = s.id 
left join production.main.location e 
on e.id = d.id 
where s.id is not null
and s.strikeOrProtest ILIKE 'strike'
and e.state ILIKE 'maryland';


-- protest in maryland
SELECT 
distinct
count(s.*) as numberofprotest
FROM production.main.date_key d
left join production.main.strike s 
on d.id = s.id 
left join production.main.location e 
on e.id = d.id 
where s.id is not null
and s.strikeOrProtest ILIKE 'protest'
and e.state ILIKE 'maryland';

-- attempt to split a column
select str_split(latitudeLongitude, ',') as split
from production.main.lat_lon;

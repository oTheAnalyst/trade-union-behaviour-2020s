desc strikeOrProtest;
desc trade_union;

SELECT
  CASE WHEN strikeOrProtest = 'Protest' then 'Protest' else 'Strike' END as test
from strikeOrProtest 
where strikeOrProtest = 'Protest'
limit 10;

SELECT count(numberOfLocations) as number_of_records_with_locations_greater_than_one 
from strikeOrProtest 
where numberOfLocations > 1;

with union_activity as (
SELECT 
    trade_union.id,
    trade_union.laborOrganization,
    strikeOrProtest.durationAmount,
    strikeOrProtest.numberOfLocations
FROM date_key 
JOIN trade_union
on date_key.id = trade_union.id
JOIN strikeOrProtest
  on date_key.id = strikeOrProtest.id
),
rankings as (
  SELECT 
      laborOrganization,
      sum(numberOfLocations) as location_affected,
      dense_rank() over(order by sum(numberOfLocations) desc) as rank
  FROM 
   union_activity
  GROUP by laborOrganization
)
SELECT * 
FROM rankings
ORDER by rank asc
LIMIT 3
;


WITH union_activity AS (
SELECT 
    date_key.id,
    trade_union.laborOrganization,
    strikeOrProtest.durationAmount,
    strikeOrProtest.numberOfLocations,
    location.state
FROM date_key
JOIN strikeOrProtest
on date_key.id = strikeOrProtest.id
JOIN trade_union
on date_key.id = trade_union.id
JOIN location
on date_key.id = location.id
)
SELECT 
  state, 
  sum(numberOfLocations) location_affected,
  dense_rank() over(order by sum(numberOfLocations) desc) as rank
FROM union_activity
WHERE laborOrganization is null
GROUP by state
ORDER by rank asc
LIMIT 10
;




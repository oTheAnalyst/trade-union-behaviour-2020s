with cte1 as (
SELECT 
    strikeOrProtest.id,
    trade_union.laborOrganization,
    strikeOrProtest.durationAmount,
    strikeOrProtest.numberOfLocations,
    location.state
from strikeOrProtest
JOIN trade_union
on strikeOrProtest.id = trade_union.id
JOIN location
on strikeOrProtest.id = location.id
) 
select 
    laborOrganization,
    sum(numberOfLocations) as locations_affected,
    dense_rank() over(order by sum(numberOfLocations) desc) as rank
  from cte1
  group by laborOrganization
  order by locations_affected desc
  limit 3



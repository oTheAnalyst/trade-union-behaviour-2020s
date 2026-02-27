/*
I'm analyst studying patterns and I would like to understand 
what sort of material conditions cause multistrike patterns to occur

In order to do this I need to create a power bi dashboard with 3 charts and 2 kpi numbers.

create views to supliment the charts.

- data cleaning
Investigate the messed up location table, try and fix the address attribute.
workerDemands needs to be cleaned up. cases needs to be standardized and symbols need to be removed.
*/


-- barchart for every year
-- showcasing mulistrikes vs single strikes
-- hypothesis more multistrikes in 2025 than in 2021 and 2022 during covid
-- false more strikes in 2022 than 2025
create or replace view pbi_multi_vs_single as
with cte1 as(
select distinct
     strikeOrProtest.id,
     year(factStrike.startDate) as year,
     factStrike.numberOfLocations
     from factStrike
     inner join strikeOrProtest 
     on factStrike.strikeOrProtest_id = strikeOrProtest.internal_id
      where strikeOrProtest.strikeOrProtest like 'Strike'
)
  select 
  year,
  count(numberOfLocations) filter(numberOfLocations > 1) as multi_strikes,
  count(numberOfLocations) filter(numberOfLocations = 1) as single_strikes
  from cte1
   group by year
   order by year asc;
 

-- which States have the greatest percentages of mulistrikes total? top ten
create view pbi_multi_strike_state_percentage_top_10 as
with cte as(
select distinct
    location.state,
    count(factStrike.numberOfLocations) filter(factStrike.numberOfLocations > 1) as multi_strikes,
    count(factStrike.numberOfLocations) filter(factStrike.numberOfLocations = 1) as single_strikes
     from factStrike
     inner join strikeOrProtest 
     on factStrike.strikeOrProtest_id = strikeOrProtest.internal_id
     inner join location 
     on factStrike.location_id = location.internal_id
      where strikeOrProtest.strikeOrProtest like 'Strike'
     group by location.state 
     order by multi_strikes desc
), cte2 as(
select  
  state,
  round(sum(multi_strikes) * 100/sum(multi_strikes + single_strikes),4) as multi_strike_percentage,
  round(sum(single_strikes) * 100/sum(multi_strikes + single_strikes),4) as single_strike_percentage
  from cte
group by state
)
select * 
from cte2 
where (multi_strike_percentage <> 0 and
multi_strike_percentage <> 100)
order by multi_strike_percentage desc
limit 10

;






-- do multistrikes and top 20 reasons have a relationship what reason is more likely to have a mulistrike?
with cte as(
select distinct
     strikeOrProtest.id,
     strikeOrProtest.workerDemands,
     factStrike.numberOfLocations
     from factStrike
     inner join strikeOrProtest 
     on factStrike.strikeOrProtest_id = strikeOrProtest.internal_id
      where strikeOrProtest.strikeOrProtest like 'Strike'
), cte2 as(
select  
  workerDemands,
  count(workerDemands) demands,
  sum(numberOfLocations) filter(numberOfLocations > 1)  as multi_strike,
  sum(numberOfLocations) filter(numberOfLocations = 1)  as single_location
  from cte
group by workerDemands
having count(workerDemands) > 3
order by demands desc
)
select  
  workerDemands,
  round(sum(multi_strike) * 100/sum(multi_strike + single_location),4) as multi_strike_percentage,
  round(sum(single_location) * 100/sum(multi_strike + single_location),4) as single_strike_percentage
  from cte2
  group by workerDemands
  order by multi_strike_percentage desc


-- 3 kpi
--- multistrikes make up percentage of strikes
---  total amount of strikes 

/*
I'm analyst studying patterns and I would like to understand 
what sort of material conditions cause multistrike patterns to occur

In order to do this I need to create a power bi dashboard with 3 charts and 2 kpi numbers.

create views to supliment the charts.
*/


-- barchart for every year
-- showcasing mulistrikes vs single strikes
-- hypothesis more multistrikes in 2025 than in 2021 and 2022 during covid
-- false more strikes in 2022 than 2025

create view pbi_multi_vs_single as
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
   order by year asc
 




--with cte1 as(
--SELECT 
--  CAST(startDate AS DATE) startDate,
--  numberOfLocations,
--  CASE WHEN numberOfLocations >1 THEN 1
--      WHEN numberOfLocations <=1 THEN 0
--  END AS more_than_one_location
--FROM strikeOrProtest
--WHERE = 'Strike'
--AND startDate >= '2025-01-01'
--AND startDate < '2025-02-01';
--) select * from cte1

-- 2 kpi's numbers
-- total number of multistrikes vs total number 
-- of single strikes since the data started


-- do multistrike and state density have a relationship?
-- do multistrikes and reasons have a relationship?




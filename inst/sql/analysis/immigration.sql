
--select 
--  *
--from fact_lat
--join employer
--on fact_lat.strikeOrProtest_id = employer.internal_id
--join trade_union
--on fact_lat.trade_union_id = trade_union.internal_id 
--join "strikeOrProtest" as s
--on fact_lat.strikeOrProtest_id = s.internal_id
--
--  ;

select 
  trade_union."laborOrganization", 
  employer.employer,
  strike."strikeOrProtest",
  location.state
from fact_lat
join trade_union
on trade_union.internal_id =  fact_lat.trade_union_id
join employer
on employer.internal_id = fact_lat.employer_id
join "strikeOrProtest" as strike
on strike.internal_id = fact_lat.strikeOrProtest_id
join location
on location.internal_id = fact_lat.location_id
where (employer.employer ilike '%immigr%'
or employer.industry ilike '%immigr%')
and strike."strikeOrProtest" = 'Strike'
limit 10
;

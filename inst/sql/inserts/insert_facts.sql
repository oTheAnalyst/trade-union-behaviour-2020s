insert into fact_lat 
select 
  "strikeOrProtest".internal_id as strikeOrProtest_id,
  trade_union.internal_id as trade_uion_id,
  employer.internal_id as employer_id,
  "location".internal_id
from "strikeOrProtest"
join trade_union
on "strikeOrProtest".id = trade_union.id
join employer
on "strikeOrProtest".id = employer.id
join "location" 
on "strikeOrProtest".id = "location".id
order by "strikeOrProtest".id desc

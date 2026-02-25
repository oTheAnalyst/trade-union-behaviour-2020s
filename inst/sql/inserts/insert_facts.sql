insert into strike_fact 
select 
  "strikeOrProtest".internal_id as strike_or_protest_id,
  "location".internal_id as location_id,
  tradeUnion.internal_id as trade_union_id,
  workerDemands.internal_id as workerDemands_id,
  citations.internal_id as citations_id,
  employer.internal_id as employer_id
from "strikeOrProtest"
join tradeUnion
on "strikeOrProtest".id = tradeUnion.id
join employer
on "strikeOrProtest".id = employer.id
join "location" 
on "strikeOrProtest".id = "location".id
join workerDemands
on "strikeOrProtest".id = "workerDemands".id
join citations
on "strikeOrProtest".id = "citations".id
order by "strikeOrProtest".id desc

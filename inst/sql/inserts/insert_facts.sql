insert into factStrike 
select 
  "strikeOrProtest".internal_id as strike_or_protest_id,
  "location".internal_id as location_id,
  tradeUnion.internal_id as trade_union_id,
  citations.internal_id as citations_id,
  employer.internal_id as employer_id,
  stg_lat.durationAmount,
  stg_lat.numberOfLocations,
  stg_lat.approximateNumberOfParticipants
from "strikeOrProtest"
join tradeUnion
on "strikeOrProtest".id = tradeUnion.id
join employer
on "strikeOrProtest".id = employer.id
join "location" 
on "strikeOrProtest".id = "location".id
join citations
on "strikeOrProtest".id = "citations".id
join stg_lat
on "strikeOrProtest".id = stg_lat.id
order by "strikeOrProtest".id desc

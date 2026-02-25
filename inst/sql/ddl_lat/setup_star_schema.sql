CREATE TABLE factStrike(
  strikeOrProtest_id bigint,
  location_id bigint, 
  trade_union_id bigint, 
  citations_id bigint,
  employer_id bigint,
  durationAmount INTEGER,
  numberOfLocations INTEGER,
  approximateNumberOfParticipants INTEGER,
  endDate date,
  startDate date,
  FOREIGN KEY (strikeOrProtest_id) REFERENCES strikeOrProtest(internal_id), 
  FOREIGN KEY (employer_id) REFERENCES employer(internal_id), 
  FOREIGN KEY (location_id) REFERENCES location(internal_id), 
  FOREIGN KEY (trade_union_id) REFERENCES tradeUnion(internal_id), 
  FOREIGN KEY (citations_id) REFERENCES citations(internal_id)
);

insert into factStrike 
select 
  "strikeOrProtest".internal_id as strike_or_protest_id,
  "location".internal_id as location_id,
  tradeUnion.internal_id as trade_union_id,
  citations.internal_id as citations_id,
  employer.internal_id as employer_id,
  stg_lat.durationAmount,
  stg_lat.numberOfLocations,
  stg_lat.approximateNumberOfParticipants,
  stg_lat.endDate,
  stg_lat.startDate
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
order by "strikeOrProtest".id desc;

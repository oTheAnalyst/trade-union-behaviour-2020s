SET memory_limit = '4GB';

CREATE OR REPLACE TABLE starLat.factStrike(
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
  FOREIGN KEY (strikeOrProtest_id) REFERENCES starLat.strikeOrProtest(internal_id), 
  FOREIGN KEY (employer_id) REFERENCES starLat.employer(internal_id), 
  FOREIGN KEY (location_id) REFERENCES starLat.location(internal_id), 
  FOREIGN KEY (trade_union_id) REFERENCES starLat.tradeUnion(internal_id), 
  FOREIGN KEY (citations_id) REFERENCES starLat.citations(internal_id)
);

insert into starLat.factStrike 
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
from starLat."strikeOrProtest" as "strikeOrProtest"
join starLat.tradeUnion as tradeUnion
on "strikeOrProtest".id = tradeUnion.id
join starLat.employer as employer
on "strikeOrProtest".id = employer.id
join starLat."location" as "location"
on "strikeOrProtest".id = "location".id
join starLat.citations as citations
on "strikeOrProtest".id = "citations".id
join stg_backup.stg_lat as stg_lat
on "strikeOrProtest".id = stg_lat.id
order by "strikeOrProtest".id desc;


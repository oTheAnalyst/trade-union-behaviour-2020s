load spatial;
create sequence strikeOrProtest_id;
create sequence workerDemands_id;
create sequence citations_id;
create sequence location_id; 
create sequence employer_id;
create sequence trade_union_id;



--DROP TABLE strike;
CREATE OR REPLACE TABLE  strikeOrProtest(
internal_id bigint primary key default nextval('strikeOrProtest_id'),
id INTEGER,
approximateNumberOfParticipants INTEGER,
startDate DATE,
endDate DATE,
durationUnit varchar,
durationAmount INTEGER,
strikeOrProtest VARCHAR,
authorized VARCHAR,
numberOfLocations INTEGER,
FOREIGN KEY (internal_id) REFERENCES fact_lat (strikeOrProtest_id)
);

DROP TABLE lat_lon

CREATE OR REPLACE TABLE workerDemands (
internal_id bigint primary key default nextval('workerDemands_id'),
id INTEGER,
workerDemands VARCHAR,
FOREIGN KEY (internal_id) REFERENCES fact_lat (workerDemands_id)

)

--DROP TABLE trade_union;
CREATE OR REPLACE TABLE tradeUnion(
internal_id bigint primary key default nextval('trade_union_id'),
id INTEGER,
laborOrganization varchar,
bargainingUnitSize integer,
FOREIGN KEY (internal_id) REFERENCES fact_lat (trade_union_id)
);

CREATE OR REPLACE TABLE citations(
internal_id bigint primary key default nextval('citations_id'),
id INTEGER,
source VARCHAR,
notes VARCHAR,
FOREIGN KEY (internal_id) REFERENCES fact_lat (citations_id)
);

--DROP TABLE employer 
CREATE OR REPLACE TABLE employer(
internal_id bigint primary key default nextval('employer_id'),
id INTEGER,
local VARCHAR,
industry VARCHAR,
employer VARCHAR,
FOREIGN KEY (internal_id) REFERENCES fact_lat (employer_id)
);

--DROP TABLE location
CREATE OR REPLACE TABLE location(
internal_id bigint primary key default nextval('location_id'),
id INTEGER,
state VARCHAR,
address VARCHAR,
city VARCHAR,
zipCode VARCHAR,
point GEOMETRY,
FOREIGN KEY (internal_id) REFERENCES fact_lat (location_id)
);

CREATE TABLE strike_fact(
  strikeOrProtest_id bigint,
  location_id bigint, 
  trade_union_id bigint, 
  workerDemands_id bigint,
  citations_id bigint,
  employer_id bigint, 
  FOREIGN KEY (strikeOrProtest_id) REFERENCES strikeOrProtest(internal_id), 
  FOREIGN KEY (trade_union_id) REFERENCES trade_union(internal_id), 
  FOREIGN KEY (citations_id) REFERENCES trade_union(internal_id), 
  FOREIGN KEY (workerDemands_id) REFERENCES trade_union(internal_id), 
  FOREIGN KEY (employer_id) REFERENCES employer(internal_id)
);

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
startDate DATE,
endDate DATE,
strikeOrProtest VARCHAR,
authorized VARCHAR,
numberOfLocations INTEGER,
workerDemands VARCHAR
);

DROP TABLE lat_lon

--DROP TABLE trade_union;
CREATE OR REPLACE TABLE tradeUnion(
internal_id bigint primary key default nextval('trade_union_id'),
id INTEGER,
laborOrganization varchar,
bargainingUnitSize integer
);

CREATE OR REPLACE TABLE citations(
internal_id bigint primary key default nextval('citations_id'),
id INTEGER,
source VARCHAR,
notes VARCHAR
);

--DROP TABLE employer 
CREATE OR REPLACE TABLE employer(
internal_id bigint primary key default nextval('employer_id'),
id INTEGER,
local VARCHAR,
industry VARCHAR,
employer VARCHAR
);

--DROP TABLE location
CREATE OR REPLACE TABLE location(
internal_id bigint primary key default nextval('location_id'),
id INTEGER,
state VARCHAR,
address VARCHAR,
city VARCHAR,
zipCode VARCHAR,
point GEOMETRY
);


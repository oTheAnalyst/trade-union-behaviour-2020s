create sequence citations_id;
create sequence location_id; 
create sequence employer_id;
create sequence trade_union_id;
create sequence strikeOrProtest_id;



--DROP TABLE strike;
CREATE OR REPLACE TABLE  starLat.strikeOrProtest(
internal_id bigint primary key default nextval('strikeOrProtest_id'),
id INTEGER,
strikeOrProtest VARCHAR,
authorized VARCHAR,
workerDemands VARCHAR,
rowExpirationDate TIMESTAMP DEFAULT NULL,
rowIndicator VARCHAR
);


--DROP TABLE trade_union;
CREATE OR REPLACE TABLE starLat.tradeUnion (
internal_id bigint primary key default nextval('trade_union_id'),
id INTEGER,
laborOrganization varchar,
bargainingUnitSize integer,
rowExpirationDate TIMESTAMP DEFAULT NULL,
rowIndicator VARCHAR
);

CREATE OR REPLACE TABLE starLat.citations(
internal_id bigint primary key default nextval('citations_id'),
id INTEGER,
source VARCHAR,
notes VARCHAR,
rowExpirationDate TIMESTAMP DEFAULT NULL,
rowIndicator VARCHAR
);

--DROP TABLE employer 
CREATE OR REPLACE TABLE starLat.employer(
internal_id bigint primary key default nextval('employer_id'),
id INTEGER,
local VARCHAR,
industry VARCHAR,
employer VARCHAR,
rowExpirationDate TIMESTAMP DEFAULT NULL,
rowIndicator VARCHAR
);


load spatial;
--DROP TABLE location
CREATE OR REPLACE TABLE starLat.location(
internal_id bigint primary key default nextval('location_id'),
id INTEGER,
state VARCHAR,
address VARCHAR,
city VARCHAR,
zipCode VARCHAR,
point GEOMETRY,
rowExpirationDate TIMESTAMP DEFAULT NULL,
rowIndicator VARCHAR
);


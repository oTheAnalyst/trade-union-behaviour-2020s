create sequence citations_id;
create sequence location_id; 
create sequence employer_id;
create sequence trade_union_id;
create sequence strikeOrProtest_id;
create sequence tradeUnion_id;
create sequence trade_union_id;



--DROP TABLE strike;
CREATE TABLE  strikeOrProtest(
internal_id bigint primary key default nextval('strikeOrProtest_id'),
id INTEGER,
strikeOrProtest VARCHAR,
authorized VARCHAR,
workerDemands VARCHAR
);

DROP TABLE lat_lon

--DROP TABLE trade_union;
CREATE TABLE tradeUnion(
internal_id bigint primary key default nextval('trade_union_id'),
id INTEGER,
laborOrganization varchar,
bargainingUnitSize integer
);

CREATE TABLE citations(
internal_id bigint primary key default nextval('citations_id'),
id INTEGER,
source VARCHAR,
notes VARCHAR
);

--DROP TABLE employer 
CREATE TABLE employer(
internal_id bigint primary key default nextval('employer_id'),
id INTEGER,
local VARCHAR,
industry VARCHAR,
employer VARCHAR
);

create sequence stacked_D;

create table bridge_location(
location_id_internal BIGINT,
id INTEGER,
stacked_id BIGINT default nextval('stacked_D')
);

load spatial;
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


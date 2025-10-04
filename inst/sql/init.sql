-- production.main.labor_stagging_table definition
CREATE TABLE labor_stagging_table(
id INTEGER,
employer VARCHAR,
laborOrganization VARCHAR,
"local" VARCHAR ,
industry VARCHAR,
bargainingUnitSize DOUBLE,
numberOfLocations INTEGER,
address VARCHAR,
city VARCHAR,
state VARCHAR,
zipCode VARCHAR,
latitudeLongitude VARCHAR,
approximateNumberOfParticipants INTEGER,
startDate TIMESTAMP,
endDate TIMESTAMP,
durationAmount INTEGER,
durationUnit VARCHAR,
strikeOrProtest VARCHAR,
authorized VARCHAR,
workerDemands VARCHAR,
"source" VARCHAR,
notes VARCHAR,
"year" INTEGER,
"month" INTEGER
);

drop table date_location
CREATE TABLE date_location(
startDate TIMESTAMP,
endDate	TIMESTAMP,
id INTEGER PRIMARY KEY,
latitudeLongitude VARCHAR
);

CREATE TABLE trade_union(
id integer,
laborOrganization varchar,
bargainingUnitSize integer,
workerDemands varchar
);

CREATE TABLE strike(
approximateNumberOfParticipants INTEGER,
durationUnit varchar,
durationAmount INTEGER,
strikeOrProtest VARCHAR,
authorized VARCHAR,
numberOfLocations INTEGER,
source VARCHAR,
notes VARCHAR,
id INTEGER
);

CREATE TABLE employer(
id INTEGER,
local VARCHAR,
industry VARCHAR,
employer VARCHAR,
address VARCHAR,
city VARCHAR,
zipCode VARCHAR,
);

-- insert statement
insert into production.main.employer
select
id,
local,
industry,
employer,
address,
city,
zipcode
from labor_stagging_table 


insert into production.main.date_location 
select 
startDate,
endDate,
id,
latitudeLongitude 
from labor_stagging_table;

insert into production.main.trade_union 
select 
id,
laborOrganization,
bargainingUnitSize,
latitudeLongitude,
from labor_stagging_table;

insert into production.main.strike  
select 
approximateNumberOfParticipants,
durationUnit,
durationAmount,
strikeOrProtest,
authorized,
numberOfLocations,
source,
notes,
id
from labor_stagging_table 







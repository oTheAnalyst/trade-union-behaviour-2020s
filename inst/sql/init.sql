CREATE SEQUENCE serial START 101 INCREMENT BY 3; 
CREATE SCHEMA dataImports
--DROP TABLE production.dataImports.stg_lat ;
CREATE TABLE production.dataImports.stg_lat(
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

--DROP TABLE  production.dataImports.stg_lat_imports
CREATE TABLE production.dataImports.stg_lat_imports(
import_id TIMESTAMP NOT NULL DEFAULT current_timestamp , 
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

CREATE TABLE production.main.stg_lat_imports(
import_id TIMESTAMP NOT NULL DEFAULT current_timestamp , 
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

--DROP TABLE date_key;
CREATE TABLE date_key(
startDate TIMESTAMP,
endDate	TIMESTAMP,
id INTEGER PRIMARY KEY,
);

--DROP TABLE lat_lon
CREATE TABLE lat_lon(
id INTEGER,
latitudeLongitude VARCHAR,
FOREIGN KEY (id) REFERENCES date_key (id)
)

--DROP TABLE trade_union;
CREATE TABLE trade_union(
id INTEGER,
laborOrganization varchar,
bargainingUnitSize integer,
workerDemands varchar,
FOREIGN KEY (id) REFERENCES date_key (id)
);

--DROP TABLE strike;
CREATE TABLE strike(
approximateNumberOfParticipants INTEGER,
durationUnit varchar,
durationAmount INTEGER,
strikeOrProtest VARCHAR,
authorized VARCHAR,
numberOfLocations INTEGER,
source VARCHAR,
notes VARCHAR,
id INTEGER,
FOREIGN KEY (id) REFERENCES date_key (id)
);

--DROP TABLE employer 
CREATE TABLE employer(
id INTEGER,
local VARCHAR,
industry VARCHAR,
employer VARCHAR,
FOREIGN KEY (id) REFERENCES date_key (id)
);

--DROP TABLE location
CREATE TABLE location(
id INTEGER,
state VARCHAR,
address VARCHAR,
city VARCHAR,
zipCode VARCHAR,
FOREIGN KEY (id) REFERENCES date_key (id)
);


--import table
--psuedo sql, not tested :)
--DROP TABLE production.dataImports.stg_imports
CREATE TABLE production.dataImports.stg_imports (
   import_id INTEGER PRIMARY KEY DEFAULT nextval('serial'),
   import_dt TIMESTAMP,
   source_name VARCHAR,
   original_file_path VARCHAR,
   bucket_uri VARCHAR,
   md5_checksum VARCHAR
);

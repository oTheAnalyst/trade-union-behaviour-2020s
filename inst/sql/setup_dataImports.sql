-- import table
-- psuedo sql, not tested :)
-- DROP TABLE dataImports.stg_imports
CREATE TABLE dataImports.stg_imports (
   import_id BIGINT NOT NULL DEFAULT nextval('dataImports.serial'),
   import_dt TIMESTAMP PRIMARY KEY,
   source_name VARCHAR,
   original_file_path VARCHAR,
   bucket_uri VARCHAR,
   md5_checksum VARCHAR
);


-- DROP TABLE dataImports.stg_lat_imports
CREATE TABLE dataImports.stg_lat_imports(
import_dt TIMESTAMP NOT NULL DEFAULT current_timestamp, 
id INTEGER,   
employer VARCHAR,
laborOrganization VARCHAR,
local VARCHAR ,
industry VARCHAR,
bargainingUnitSize DOUBLE,
numberOfLocations INTEGER,
address VARCHAR,
city VARCHAR,
state VARCHAR,
zipCode VARCHAR,
latitudeLongitude VARCHAR,
approximateNumberOfParticipants INTEGER,
startDate DATE,
endDate DATE,
durationAmount INTEGER,
durationUnit VARCHAR,
strikeOrProtest VARCHAR,
authorized VARCHAR,
workerDemands VARCHAR,
source VARCHAR,
notes VARCHAR
);
CREATE INDEX idx on dataImports.stg_lat_imports (import_dt);

-- DROP TABLE dataImports.stg_lat ;
CREATE TABLE dataImports.stg_lat(
import_id BIGINT,
id INTEGER PRIMARY KEY,   
employer VARCHAR,
laborOrganization VARCHAR,
local VARCHAR ,
industry VARCHAR,
bargainingUnitSize DOUBLE,
numberOfLocations INTEGER,
address VARCHAR,
city VARCHAR,
state VARCHAR,
zipCode VARCHAR,
latitudeLongitude VARCHAR,
approximateNumberOfParticipants INTEGER,
startDate DATE ,
endDate DATE,
durationAmount INTEGER,
durationUnit VARCHAR,
strikeOrProtest VARCHAR,
authorized VARCHAR,
workerDemands VARCHAR,
source VARCHAR,
notes VARCHAR
);

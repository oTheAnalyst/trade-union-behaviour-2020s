
-- DELETE FROM  production.dataImports.stg_imports 
-- INSERT INTO production.dataImports.stg_imports 
-- SELECT 
-- nextval('serial'),
-- sli.import_id,
-- 'email',
-- '/home/pretender/R/x86_64-pc-linux-gnu-library/4.4/dsa/extdata',
-- 'NA',
-- 'NA'
-- FROM production.dataImports.stg_lat_imports sli 
-- GROUP BY sli.import_id;
-- select * from production.dataImports.stg_imports

INSERT INTO production.main.date_key 
select
startDate,
endDate,
id
from production.dataImports.stg_lat;


INSERT INTO production.main.trade_union 
select
id,
STRING_SPLIT(laborOrganization,';').UNNEST() as t2,
bargainingUnitSize,
STRING_SPLIT(workerDemands,';').UNNEST() as t1
from production.dataImports.stg_lat;


INSERT INTO production.main.strike  
select
approximateNumberOfParticipants,
durationUnit,
durationAmount,
strikeOrProtest,
authorized,
numberOfLocations,
STRING_SPLIT(source,';').UNNEST() as s,
notes,
id
from production.dataImports.stg_lat;


INSERT INTO production.main.employer
select
id,
STRING_SPLIT(local, ';').UNNEST() as local,
industry,
STRING_SPLIT(employer, ';').UNNEST() Employer,
from production.dataImports.stg_lat;

INSERT INTO production.main.lat_lon 
select 
id,
STRING_SPLIT(latitudeLongitude, ';').UNNEST() latitudeLongitude
from production.dataImports.stg_lat;


INSERT INTO production.main.location 
select 
id,
STRING_SPLIT(state, ';').UNNEST() State,
STRING_SPLIT(address, ';').UNNEST() Address,
STRING_SPLIT(city, ';').UNNEST() City,
STRING_SPLIT(zipCode, ';').UNNEST() zipcode
from production.dataImports.stg_lat;

INSERT production.dataImports.stg_lat_imports 
select * from 
production.dataImports.stg_lat  



INSERT production.dataImports.stg_lat_imports 
select * from 
production.main.stg_lat_imports;




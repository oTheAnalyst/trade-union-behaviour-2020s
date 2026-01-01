load excel;

INSERT INTO stg_csv (startDate, endDate) 
  SELECT 
COALESCE(
        TRY_CAST("Start Date" AS DATE), 
        DATE '1899-12-30' + CAST("Start Date" AS INTEGER)
    ) AS "Start Date",
COALESCE(
        TRY_CAST("End Date" AS DATE), 
        DATE '1899-12-30' + CAST("End Date" AS INTEGER)
    ) AS "End Date"  
FROM read_xlsx('./inst/extdata/12.1.25.xlsx', 
                  all_varchar = true);

INSERT INTO stg_csv (local) 
  SELECT local 
  FROM read_xlsx('./inst/extdata/12.1.25.xlsx', 
                            all_varchar = true);

INSERT INTO stg_csv (
import_dt,
id,
employer,                        
laborOrganization,               
industry,                         
bargainingUnitSize,
numberOfLocations,
address,
city,
state,
zipCode,                         
latitudeLongitude,               
approximateNumberOfParticipants, 
durationAmount,
durationUnit,                    
strikeOrProtest,                 
authorized,                      
workerDemands,
source,
notes                           
) 
SELECT 
current_localtimestamp() as import_dt,
ID,
Employer,                        
"Labor Organization",               
Industry,                         
"Bargaining Unit Size",
"Number Of Locations",
Address,
City,
State,
"Zip Code",
"Latitude, Longitude",               
"Approximate Number Of Participants", 
"Duration Amount",
"Duration Unit",                    
"Strike Or Protest",                 
"Authorized",                      
"Worker Demands",
Source,
Notes
FROM
read_xlsx('./inst/extdata/12.1.25.xlsx', 
  ignore_errors = true);


delete from stg_csv where import_dt is null;

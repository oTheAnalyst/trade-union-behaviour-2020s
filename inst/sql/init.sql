SELECT id, 
employer, 
laborOrganization, 
"local", 
industry, 
bargainingUnitSize, 
numberOfLocations, address, 
city, 
state, 
zipCode, 
latitudeLongitude, 
approximateNumberOfParticipants, 
startDate, 
endDate, durationAmount, 
durationUnit, 
strikeOrProtest, 
authorized, 
workerDemands, 
"source", 
notes, 
"year", 
"month"
FROM production.main.labor_stagging_table;




-- production.main.labor_stagging_table definition

CREATE 
TABLE labor_stagging_table(
id INTEGER,
employer VARCHAR,
laborOrganization VARCHAR,
"local" VARCHAR,
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

CREATE 
TABLE date_location(
startDate timestamp,
endDate	timestamp,
id	integer,
latitudeLongitude VARCHAR
)


INSERT INTO production.main.date_location
SELECT
startDate,
endDate,
id,
latitudeLongitude
FROM production.main.labor_stagging_table
where id is not NULL;

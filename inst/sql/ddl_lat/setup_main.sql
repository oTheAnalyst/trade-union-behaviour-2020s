--DROP TABLE strike;
CREATE OR REPLACE TABLE  strikeOrProtest(
id INTEGER PRIMARY KEY,
approximateNumberOfParticipants INTEGER,
startDate DATE,
endDate DATE,
durationUnit varchar,
durationAmount INTEGER,
strikeOrProtest VARCHAR,
authorized VARCHAR,
numberOfLocations INTEGER,
);

--DROP TABLE lat_lon
CREATE OR REPLACE TABLE lat_lon(
id INTEGER,
latitudeLongitude VARCHAR,
FOREIGN KEY (id) REFERENCES strikeOrProtest (id)
);

CREATE OR REPLACE TABLE workerDemands (
id INTEGER,
workerDemands VARCHAR,
)

--DROP TABLE trade_union;
CREATE OR REPLACE TABLE trade_union(
id INTEGER,
laborOrganization varchar,
bargainingUnitSize integer,
FOREIGN KEY (id) REFERENCES strikeOrProtest (id)
);

CREATE OR REPLACE TABLE citations(
id INTEGER,
source VARCHAR,
notes VARCHAR,
FOREIGN KEY (id) REFERENCES strikeOrProtest (id)
);

--DROP TABLE employer 
CREATE OR REPLACE TABLE employer(
id INTEGER,
local VARCHAR,
industry VARCHAR,
employer VARCHAR,
FOREIGN KEY (id) REFERENCES strikeOrProtest (id)
);

--DROP TABLE location
CREATE OR REPLACE TABLE location(
id INTEGER,
state VARCHAR,
address VARCHAR,
city VARCHAR,
zipCode VARCHAR,
FOREIGN KEY (id) REFERENCES strikeOrProtest (id)
);

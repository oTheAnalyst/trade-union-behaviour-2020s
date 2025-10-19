-- DROP TABLE date_key;
CREATE TABLE date_key(
startDate DATE NOT NULL,
endDate DATE,
id INTEGER PRIMARY KEY,
);

--DROP TABLE lat_lon
CREATE TABLE lat_lon(
id INTEGER,
latitudeLongitude VARCHAR,
FOREIGN KEY (id) REFERENCES date_key (id)
);

--DROP TABLE trade_union;
CREATE TABLE trade_union(
id INTEGER,
laborOrganization varchar,
bargainingUnitSize integer,
workerDemands varchar,
FOREIGN KEY (id) REFERENCES date_key (id)
);

--DROP TABLE strike;
CREATE TABLE strikeOrProtest(
approximateNumberOfParticipants INTEGER,
startDate DATE,
endDate DATE,
durationUnit varchar,
durationAmount INTEGER,
strikeOrProtest VARCHAR,
authorized VARCHAR,
numberOfLocations INTEGER,
id INTEGER,
FOREIGN KEY (id) REFERENCES date_key (id)
);

CREATE TABLE citations(
id INTEGER,
source VARCHAR,
notes VARCHAR,
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

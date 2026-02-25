load spatial;
CREATE TABLE uscities(
  city VARCHAR, 
  city_ascii VARCHAR, 
  state_id VARCHAR, 
  state_name VARCHAR, 
  county_fips VARCHAR, 
  county_name VARCHAR, 
  point GEOMETRY,
  population BIGINT, 
  density DOUBLE, 
  "source" VARCHAR, 
  military BOOLEAN, 
  incorporated BOOLEAN, 
  timezone VARCHAR, 
  ranking BIGINT, 
  id BIGINT);

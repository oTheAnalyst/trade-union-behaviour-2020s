load postgres;
attach 'dbname=nixcloud users=postgres host=localhost' as ncloud (type postgres);

CREATE table Public.stg_excel  select * FROM dev_lat.stg_imports;
CREATE table Public.citations as select * FROM dev_lat.citations;
CREATE table Public.employer as select *  FROM dev_lat.employer;
CREATE table Public.fact_lat as select *  FROM dev_lat.fact_lat;
CREATE table Public.job_tracker as select *  FROM dev_lat.job_tracker;
CREATE table Public.location as select *  FROM dev_lat.location;
CREATE table Public.stg_census_density as select *  FROM dev_lat.stg_census_density;
CREATE table Public.stg_date_dimension as select *  FROM dev_lat.stg_date_dimension;
CREATE table Public.stg_excel as select *  FROM dev_lat.stg_excel;
CREATE table Public.stg_imports as select *  FROM dev_lat.stg_imports;
CREATE table Public.stg_lat as select *  FROM dev_lat.stg_lat;
CREATE table Public.stg_lat_imports as select *  FROM dev_lat.stg_lat_imports;
CREATE table Public.stg_uscities as select *  FROM dev_lat.stg_uscities;
CREATE table Public.strikeOrProtest  as select * FROM dev_lat.strikeOrProtest;
CREATE table Public.trade_union as select *  FROM dev_lat.trade_union;
CREATE table Public.uscities as select *  FROM dev_lat.uscities;
CREATE table Public.workerDemands as select *  FROM dev_lat.workerDemands;


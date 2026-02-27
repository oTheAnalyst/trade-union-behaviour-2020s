--copy(
--select * 
--from stg_lat
--where import_id = 127
--) to 'output.csv' (HEADER, DELIMITER ',')

--copy(
--select * 
--from stg_lat
--where import_id = 123
--) to 'output2.csv' (HEADER, DELIMITER ',')


create temp table t1  as
SELECT
 id, approximateNumberOfParticipants
FROM stg_lat
where import_id = 123
order by id desc;



create temp table t2  as
SELECT
 id, approximateNumberOfParticipants
FROM stg_lat
where import_id = 127
order by id desc;


select * from t1
except 
select * from t2;



select * from t2 
except 
select * from t1;

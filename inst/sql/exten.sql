INSTALL httpfs;
LOAD httpfs;

SELECT * FROM 
read_json('evedata.json')
LIMIT 20;


INSERT INTO stg_imports 
 SELECT nextval('serial'),
 import_dt,
 'email',
 '",loc,"',
 'NA',
 'NA'
 FROM stg_lat_imports
 WHERE 
 import_dt
 NOT IN(
select import_dt from stg_imports 
 )
 GROUP BY import_dt;


 INSERT INTO stg_imports 
 SELECT nextval('serial'),
 import_dt,
 'email',
 '",loc,"',
 'NA',
 'NA'
 FROM stg_lat_imports
 WHERE 
 import_dt
 NOT IN(
select import_dt from stg_imports 
 )
 GROUP BY import_dt;

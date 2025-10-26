INSTALL httpfs;
LOAD httpfs;

SELECT * FROM 
read_json('evedata.json')
LIMIT 20;


INSERT INTO dataImports.stg_imports 
 SELECT nextval('dataImports.serial'),
 import_dt,
 'email',
 '",loc,"',
 'NA',
 'NA'
 FROM dataImports.stg_lat_imports
 WHERE 
 import_dt
 NOT IN(
select import_dt from dataImports.stg_imports 
 )
 GROUP BY import_dt;


 INSERT INTO dataImports.stg_imports 
 SELECT nextval('dataImports.serial'),
 import_dt,
 'email',
 '",loc,"',
 'NA',
 'NA'
 FROM dataImports.stg_lat_imports
 WHERE 
 import_dt
 NOT IN(
select import_dt from dataImports.stg_imports 
 )
 GROUP BY import_dt;
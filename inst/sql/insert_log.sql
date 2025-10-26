INSERT INTO dataImports.stg_imports 
 SELECT 
 nextval('dataImports.serial'),
 import_dt,
 'email',
'/home/pretender/R/x86_64-pc-linux-gnu-library/4.4/dsa/extdata'
 'NA',
 'NA',
 'NA'
 FROM dataImports.stg_lat_imports
 WHERE 
 import_dt
 NOT IN(
select import_dt from dataImports.stg_imports 
 )
 GROUP BY import_dt;

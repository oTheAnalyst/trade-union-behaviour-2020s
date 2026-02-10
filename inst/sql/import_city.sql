
INSERT INTO stg_imports 
 SELECT 
 nextval('serial'),
 import_dt,
 'email',
'/home/pretender/R/x86_64-pc-linux-gnu-library/4.4/dsa/extdata'
 'NA',
 'NA',
 'NA'
 FROM stg_excel
 WHERE 
 import_dt
 NOT IN(
select import_dt from stg_imports 
 )
 GROUP BY import_dt;



--create table stg_uscities as
--select *
--from read_csv('./inst/extdata/uscities.csv')
;



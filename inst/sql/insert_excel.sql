LOAD EXCEL;


INSERT INTO stg_excel 
SELECT current_localtimestamp() AS import_dt, * 
FROM read_xlsx('./inst/extdata/12.1.25.xlsx', all_varchar = true);

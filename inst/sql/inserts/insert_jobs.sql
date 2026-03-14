load excel;
create or replace table job_tracker as
select * 
from read_xlsx('./inst/extdata/tracker_jobs.xlsx', all_varchar = true);

select * from job_tracker
limit 3;

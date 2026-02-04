DROP VIEW IF EXISTS monthly_average_protest;
DROP VIEW IF EXISTS monthly_average_strike;

--SET temp_directory = '~/temp_dir/';
--drop table sop
CREATE VIEW monthly_average_strike AS 
WITH cte AS (
    SELECT
    s.*,
    e.*
    from main.strikeOrProtest s
    join main.location e
    on s.id = e.id
    where s.id is not null AND
    strikeOrProtest ILIKE 'strike'
  ), cte2 AS (
  SELECT
      count(*) as recordcountpermonth,
      state,
      monthname(startDate) as monthname
    FROM cte
    GROUP BY 
    state,
    monthname
  ), cte3 as(
   SELECT 
     sum(recordcountpermonth) as total,
     state, 
     monthname
   FROM cte2
   WHERE state not in('California', 'New York')
   GROUP BY
    state, 
    monthname
  ) 
  select
    round(avg(total)) as monthly_average_strikes,
    round(median(total)) as monthly_median_strikes,
    monthname
    from cte3
    GROUP BY 
    monthname
    ORDER BY
    monthname

;

CREATE VIEW monthly_average_protest AS 
WITH cte AS (
    SELECT
    s.*,
    e.*
    from main.strikeOrProtest s
    join main.location e
    on s.id = e.id
    where s.id is not null AND
    strikeOrProtest ILIKE 'protest'
  ), cte2 AS (
  SELECT
      count(*) as recordcountpermonth,
      state,
      monthname(startDate) as monthname
    FROM cte
    GROUP BY 
    state,
    monthname
  ), cte3 as(
   SELECT 
     sum(recordcountpermonth) as total,
     state, 
     monthname
   FROM cte2
   WHERE state not in('California', 'New York')
   GROUP BY
    state, 
    monthname
  ) 
  select
    round(avg(total)) as monthly_average_protest,
    round(median(total)) as monthly_median_protest,
    monthname
    from cte3
    GROUP BY 
    monthname
    ORDER BY
    monthname
;


SELECT * FROM monthly_average_protest;
SELECT * FROM monthly_average_strike;
























-- Get the median maryland strikes and the

WITH strikecount AS (

SELECT
DISTINCT
state,
count(*) as numberofstrikes,
isoyear(startDate) as year
FROM sop
WHERE
strikeOrProtest ILIKE 'strike'
and state ILIKE 'maryland'
GROUP BY year, state

) 
SELECT 
strikecount.state,
strikecount.year,
strikecount.numberofstrikes,
medianstrike.yearly_median_strikes,
CASE WHEN
strikecount.numberofstrikes < medianstrike.yearly_median_strikes
THEN 'Below Median Strikes'
WHEN strikecount.numberofstrikes > medianstrike.yearly_median_strikes
THEN 'Above Median Strikes'
WHEN strikecount.numberofstrikes = medianstrike.yearly_median_strikes
THEN 'Equal to Median Strikes' 
End as MedianStrikes
FROM strikecount
LEFT JOIN yearly_average_strike as medianstrike
ON medianstrike.isoyear = strikecount.year
ORDER BY strikecount.year ASC
;



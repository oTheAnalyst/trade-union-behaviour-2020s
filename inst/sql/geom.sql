LOAD spatial;

select  
  l1.id,
  st_point(
  split_part(STRING_SPLIT(l1.latitudeLongitude, ';').UNNEST(), ',',2)::double,
  split_part(STRING_SPLIT(l2.latitudeLongitude, ';').UNNEST(), ',', 1)::double
  ) as point
from stg_lat as l1
join stg_lat as l2
on l1.id = l2.id
--WHERE
--l1.id NOT IN(
--select id from main.geom
--)

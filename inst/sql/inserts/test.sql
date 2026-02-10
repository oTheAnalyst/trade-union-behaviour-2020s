select 
  citations.internal_id as citations_id,
  location.Internal_id as location_id,
  workerDemands.Internal_id as workderDemands_id,
  location.state,
  stg_uscities.city
from location
left join stg_uscities
on location.city = stg_uscities.city and 
location.state = stg_uscities.state_name
join strikeOrProtest
on location.id = strikeOrProtest.id
join workerDemands
on location.id = workerDemands.id
join citations
on location.id = citations.id


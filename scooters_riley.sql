SELECT *
FROM trips 
ORDER BY tripdistance;

select max (endlongitude), min (endlongitude)
from trips;

select count(distinct (sumdgroup))
from scooters;

(select distinct (companyname)
from trips) 
INTERSECT
(select distinct (companyname)
from scooters);







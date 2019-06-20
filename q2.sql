SELECT
    trips.trip_id,
    trips.start_station,
    round(stations.lat, 2),
    round(stations.long, 2)
FROM
    trips 
JOIN
    stations
ON
    trips.start_station = stations.name;
	
	
SELECT
    s.city,
    round(AVG(s.lat), 2) lat,
    round(AVG(s.long),2) long,
    COUNT(*)
FROM
    stations s
JOIN
    trips t
ON
    t.start_station = s.name 
GROUP BY 1;
-----------------------------------

--What are the three longest trips on rainy days?
WITH
	rainy	
AS 	(SELECT
   		DATE(date) rain_date
	 	FROM
   		weather
	 	where events = 'Rain'
   GROUP BY 1)
SELECT
  	t.trip_id,
	t.duration,
	DATE(start_date)
FROM
	trips t
JOIN
	rainy r
ON
	DATE (t.start_date) = r.rain_date
ORDER BY duration DESC
LIMIT 3;

----------------------------------------------------------------
SELECT
status.station_id,
stations.name,
COUNT(CASE WHEN docks_available=0 then 1 END) Docks_full
FROM status
JOIN stations
on stations.station_id = status.station_id
GROUP BY 1,2
ORDER BY Docks_full DESC;
---------------------------------------------------------------------
SELECT
	trips.start_station,
	stations.dockcount,
	count(*)
	FROM trips
	Join stations
	ON stations.name = trips.start_station
	Group by 1,2
	ORDER by 2 DESC;
	
-----------------------------------------------------------------------------
---What's the length of the longest trip for each day it rains anywhere?
WITH
	rainy	
AS 	(SELECT
   		DATE(date) rain_date
	 	FROM
   		weather
	 	where events = 'Rain'
   GROUP BY 1),
   rain_trips
AS (SELECT
  	trip_id,
	duration,
	DATE(t.start_date) rain_trips_date 
FROM
	trips t
JOIN
	rainy r
ON
	r.rain_date = DATE(t.start_date) 
ORDER BY duration DESC)
SELECT
rain_trips_date,
max(duration) max_duration
from rain_trips
GROUP BY 1
ORDER BY max_duration desc;

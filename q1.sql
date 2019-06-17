SELECT
	date,
	zip,
	max(MaxTemperatureF)
FROM
	weather
GROUP BY 1, 2
ORDER BY 3 desc
LIMIT 1;

SELECT
	start_station,
    COUNT(start_station) as station_count
FROM
    trips
GROUP BY 1
ORDER BY 2 desc;

SELECT
	start_station,
	min(duration)
FROM
    trips
GROUP BY 1
ORDER by 2
LIMIT 25;

SELECT
	end_station,
	start_station,
	ROUND (avg (duration), 2)
FROM
    trips
GROUP BY 1, 2
ORDER BY 3;
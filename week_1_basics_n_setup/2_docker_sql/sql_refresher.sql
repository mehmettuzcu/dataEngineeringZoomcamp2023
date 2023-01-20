SELECT
  tpep_pickup_datetime,
  tpep_dropoff_datetime,
  total_amount,
  CONCAT(zpu."Borough", ' / ', zpu."Zone") As "pickup_loc",
  CONCAT(zdo."Borough", ' / ' , zpu."Zone") As "dropoff_loc"
FROM
  yellow_taxi_trips t,
  zones zpu,
  zones zdo
WHERE
  t."PULocationID" = zpu."LocationID" AND
  t."DOLocationID" = zdo."LocationID"
LIMIT 100;

--

SELECT
  tpep_pickup_datetime,
  tpep_dropoff_datetime,
  total_amount,
  CONCAT(zpu."Borough", ' / ', zpu."Zone") As "pickup_loc",
  CONCAT(zdo."Borough", ' / ' , zpu."Zone") As "dropoff_loc"
FROM
  yellow_taxi_trips t JOIN zones zpu
  	ON t."PULocationID" = zpu."LocationID"
  	-- now we have one table
  	-- which we will join with another table
  JOIN zones zdo
  	ON t."DOLocationID" = zdo."LocationID"
  LIMIT 100;

--

SELECT
  tpep_pickup_datetime,
  tpep_dropoff_datetime,
  total_amount,
  "PULocationID",
  "DOLocationID"
FROM
  yellow_taxi_trips t
WHERE
  -- "PULocationID" is NULL
  "DOLocationID" is NULL
LIMIT 100

--


SELECT
  tpep_pickup_datetime,
  tpep_dropoff_datetime,
  total_amount,
  "PULocationID",
  "DOLocationID"
FROM
  yellow_taxi_trips t
WHERE
  -- "DOLocationID" NOT IN (SELECT "LocationID" FROM zones)
  "PULocationID" NOT IN (SELECT "LocationID" FROM zones)
LIMIT 100

--

DELETE FROM zones WHERE "LocationID" = 142;


--
SELECT
  tpep_pickup_datetime,
  tpep_dropoff_datetime,
  total_amount,
  CONCAT(zpu."Borough", ' / ', zpu."Zone") As "pickup_loc",
  CONCAT(zdo."Borough", ' / ' , zpu."Zone") As "dropoff_loc"
FROM
  -- Added "LEFT" to the previous statement.
  yellow_taxi_trips t LEFT JOIN zones zpu
  	ON t."PULocationID" = zpu."LocationID"

  -- LEFT
  LEFT JOIN zones zdo
  	ON t."DOLocationID" = zdo."LocationID"
  LIMIT 100;

--

SELECT
  tpep_pickup_datetime,
  tpep_dropoff_datetime,
  -- formats to datetime
  -- DATE_TRUNC('DAY', tpepe_dropoff_datetime),
  -- also formats to datetime
  CAST(tpep_dropoff_datetime as DATE),
  total_amount
FROM
  yellow_taxi_trips t
  LIMIT 100;

--
SELECT
  CAST(tpep_dropoff_datetime as DATE) as "day",
  COUNT(1) as "count"
FROM
  yellow_taxi_trips t
GROUP BY
  CAST(tpep_dropoff_datetime as DATE)
ORDER BY "day" ASC;

--

SELECT
  CAST(tpep_dropoff_datetime as DATE) as "day",
  COUNT(1) as "count",
  -- maximum total amount in day on a trip
  MAX(total_amount),
  -- maximum passenger_count amount in day on a trip
  -- how many people can you fit in a car...?
  MAX(passenger_count)
FROM
  yellow_taxi_trips t
GROUP BY
  CAST(tpep_dropoff_datetime as DATE)
ORDER BY "count" DESC;

--
SELECT
  CAST(tpep_dropoff_datetime as DATE) as "day",
  "DOLocationID",
  COUNT(1) as "count",
  MAX(total_amount),
  MAX(passenger_count)
FROM
  yellow_taxi_trips t
GROUP BY
  -- CAST(tpepe_dropoff_datetime as DATE),
  -- "DOLocationID"
  1, 2
ORDER BY
	"day" ASC,
	"DOLocationID" ASC;


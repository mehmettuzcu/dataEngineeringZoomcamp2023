select count(*) from green_taxi_data
truncate green_taxi_data

select CAST(lpep_pickup_datetime as DATE) as pickup_Day,* from green_taxi_data limit 10;

SELECT
  MAX(CAST(lpep_pickup_datetime as DATE)) as "pickupDay",
  MAX(CAST(lpep_dropoff_datetime as DATE)) as "dropoff_day",
  SUM(total_amount),
  COUNT(*)
FROM
  green_taxi_data
  where CAST(lpep_pickup_datetime as DATE) = '2019-01-15'
  group by CAST(lpep_pickup_datetime as DATE)
  LIMIT 100;

  ----

SELECT
CAST(lpep_pickup_datetime as DATE) as "pickupDay",
CAST(lpep_dropoff_datetime as DATE) as "dropoff_day",
CAST(lpep_dropoff_datetime as timestamp) - CAST(lpep_pickup_datetime as timestamp) AS DIFF
FROM
  green_taxi_data
  order by 3 DESC
  limit 100

  ---


SELECT
  passenger_count,
  MAX(CAST(lpep_pickup_datetime as DATE)) as "pickupDay",
  MAX(CAST(lpep_dropoff_datetime as DATE)) as "dropoff_day",
  SUM(total_amount),
  COUNT(*)
FROM
  green_taxi_data
  where CAST(lpep_pickup_datetime as DATE) = '2019-01-01'
  group by passenger_count
  LIMIT 100;

  ---
select * from zones limit 10;

SELECT
  lpep_pickup_datetime,
  lpep_dropoff_datetime,
  total_amount,
  zpu."Zone",
  CONCAT(zpu."Borough", ' / ', zpu."Zone") As "pickup_loc",
  tip_amount,
  zpu.service_zone, zpu."Borough"
FROM
  -- Added "LEFT" to the previous statement.
  green_taxi_data t LEFT JOIN zones zpu
  	ON t."PULocationID" = zpu."LocationID"
	--where zpu."Zone" = 'Astoria'
	order by tip_amount desc
  LIMIT 100;


---

SELECT
  lpep_pickup_datetime,
  lpep_dropoff_datetime,
  total_amount,
  CONCAT(zpu."Borough", ' / ', zpu."Zone") As "pickup_loc",
  CONCAT(zdo."Borough", ' / ' , zpu."Zone") As "dropoff_loc",
  tip_amount,
  zdo."Borough",zdo."Zone"
FROM
  -- Added "LEFT" to the previous statement.
  yellow_taxi_trips t LEFT JOIN zones zpu
  	ON t."PULocationID" = zpu."LocationID"

  -- LEFT
  LEFT JOIN zones zdo
  	ON t."DOLocationID" = zdo."LocationID"
	where zpu."Zone" = 'Astoria'
	and zdo."Zone" in ('Central Park', 'Jamaica', 'South Ozone Park', 'Long Island City/Queens Plaza')
	order by tip_amount desc
  LIMIT 100;

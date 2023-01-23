import pandas as pd

# url = "<https://s3.amazonaws.com/nyc-tlc/trip+data/yellow_tripdata_2021-01.csv>"

df = pd.read_csv('week_1_basics_n_setup/2_docker_sql/green_tripdata_2019-01.csv', nrows=100)
# nrows -> first n amount of rows you want to read
df.head()
df.columns

pd.io.sql.get_schema(df, name="yellow_taxi_data")

lpep_pickup_datetime = pd.to_datetime(df.lpep_pickup_datetime)
lpep_dropoff_datetime = pd.to_datetime(df.lpep_dropoff_datetime)

pd.io.sql.get_schema(df, name="yellow_taxi_data")

from sqlalchemy import create_engine

# specify the database you want to use based on the docker run command we had
# postgresql://username:password@localhost:port/dbname
engine = create_engine('postgresql://root:root@localhost:5432/ny_taxi')

# create the connection to the database engine to see if everything is working properly
engine.connect()

# pass the engine variable to get_schema function
# Pandas will execute the schema SQL statement using the engine connection we have defined
pd.io.sql.get_schema(df, name="green_taxi_data", con=engine)

# df_iter = pd.read_csv('week_1_basics_n_setup/2_docker_sql/yellow_tripdata_2020-01.csv', iterator=True, chunksize=100000)
df_iter = pd.read_csv('week_1_basics_n_setup/2_docker_sql/green_tripdata_2019-01.csv', iterator=True, chunksize=100000)
df = next(df_iter)

lpep_pickup_datetime = pd.to_datetime(df.lpep_pickup_datetime)
lpep_dropoff_datetime = pd.to_datetime(df.lpep_dropoff_datetime)

df.head(n=0)

df.to_sql(name="green_taxi_data", con=engine, if_exists="replace")

df.to_sql(name="green_taxi_data", con=engine, if_exists="append")


from time import time

while True:
	# benchmark time start
	t_start = time()

	# iterates through 100000 chunks of rows
	df = next(df_iter)

	# fixes timestamp type issue

	lpep_pickup_datetime = pd.to_datetime(df.lpep_pickup_datetime)
	lpep_dropoff_datetime = pd.to_datetime(df.lpep_dropoff_datetime)

	# appends data to existing table
	df.to_sql(name="green_taxi_data", con=engine, if_exists="append")

	# benchmark time ends
	t_end = time()

	# prints the time it took to execute the code
	print('Inserted another chunk... took %.3f second(s)' % (t_end - t_start))

# this url contains taxi zone data
# assume we have downloaded the file as "taxi+_zone_lookup.csv"
url = "<>"

df_zones = pd.read_csv("week_1_basics_n_setup/2_docker_sql/taxi+_zone_lookup.csv")
df_zones.to_sql(name='zones', con=engine, if_exists='replace') # zones is a new table


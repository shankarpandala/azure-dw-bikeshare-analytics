import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT
from utils import *

############################################################################
# Update connection string information #
credentials = {
    "host" : "dwsql.postgres.database.azure.com", 
    "user" : "sqladmin", 
    "password" : input("Enter Password: "), 
    "dbname" : "postgres"
}
############################################################################


############################################################################
# Create a new DB
conn, cursor = get_connection(credentials, ISOLATION_LEVEL_AUTOCOMMIT)

credentials['dbname'] = "bikeshare"
cursor.execute(f"DROP DATABASE IF EXISTS {credentials['dbname']}")
cursor.execute(f"CREATE DATABASE {credentials['dbname']}")
close_connection(conn, cursor)
############################################################################


############################################################################
# Reconnect to the new DB bikeshare
conn, cursor = get_connection(credentials)
############################################################################


############################################################################
# Create Rider table
table = "rider"
create = f"""CREATE TABLE {table} (
    rider_id INTEGER PRIMARY KEY, 
    firstName VARCHAR(50), 
    lastName VARCHAR(50), 
    _address VARCHAR(100), 
    birthday DATE, 
    account_start_date DATE, 
    account_end_date DATE, 
    is_member BOOLEAN
);"""
drop_recreate(cursor, table, create)
filename = './data/riders.csv'
populate_table(conn, cursor, filename, table)
############################################################################


############################################################################
# Create Payment table
table = "payment"
create = f"""CREATE TABLE {table} (
    payment_id INTEGER PRIMARY KEY, 
    _date DATE, 
    amount MONEY, 
    rider_id INTEGER
);"""

drop_recreate(cursor, table, create)
filename = './data/payments.csv'
populate_table(conn, cursor, filename, table)
############################################################################


############################################################################
# Create Station table
table = "station"
create = f"""CREATE TABLE {table} (
    station_id VARCHAR(50) PRIMARY KEY, 
    _name VARCHAR(75), 
    latitude FLOAT, 
    longitude FLOAT
);"""

drop_recreate(cursor, table, create)
filename = './data/stations.csv'
populate_table(conn, cursor, filename, table)
############################################################################


############################################################################
# Create Trip table
table = "trip"
create = f"""CREATE TABLE {table} (
    trip_id VARCHAR(50) PRIMARY KEY, 
    rideable_type VARCHAR(75), 
    start_at TIMESTAMP, 
    ended_at TIMESTAMP, 
    start_station_id VARCHAR(50), 
    end_station_id VARCHAR(50), 
    rider_id INTEGER
);"""

drop_recreate(cursor, table, create)
filename = './data/trips.csv'
populate_table(conn, cursor, filename, table)
############################################################################


close_connection(conn, cursor)

print("All done!")
--############################################################################
--Create fact_trip table
CREATE TABLE fact_trip (
    [trip_id] VARCHAR(50) NOT NULL,
    [rider_id] INTEGER,
    [start_station_id] VARCHAR(50), 
    [end_station_id] VARCHAR(50), 
    [start_time_id] VARCHAR(50), 
    [end_time_id] VARCHAR(50), 
    [rideable_type] VARCHAR(75),
    [duration] VARCHAR(75),
    [rider_age] VARCHAR(75)
);

ALTER TABLE fact_trip add CONSTRAINT PK_fact_trip_trip_id PRIMARY KEY NONCLUSTERED (trip_id) NOT ENFORCED


INSERT INTO fact_trip (
    [trip_id],
    [rider_id],
    [start_station_id], 
    [end_station_id], 
    [start_time_id], 
    [end_time_id], 
    [rideable_type],
    [duration],
    [rider_age])
SELECT 
    staging_trips.trip_id,
    staging_riders.rider_id,
    staging_trips.start_station_id, 
    staging_trips.end_station_id, 
    start_time.time_id                                                  AS start_time_id,
    end_time.time_id                                                    AS end_time_id,
    staging_trips.rideable_type,
    DATEDIFF(hour, staging_trips.start_at, staging_trips.ended_at)      AS duration,
    DATEDIFF(year, staging_riders.birthday, staging_trips.start_at)     AS rider_age

FROM staging_trips
JOIN staging_riders             ON staging_riders.rider_id = staging_trips.rider_id
JOIN dim_time AS start_time     ON start_time._date = staging_trips.start_at
JOIN dim_time AS end_time       ON DATEDIFF(dd, 0, end_time._date) = DATEDIFF(dd, 0, staging_trips.ended_at)
--############################################################################




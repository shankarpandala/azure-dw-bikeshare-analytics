--############################################################################
--Create dim_station table

CREATE TABLE dim_station (
	[station_id] [nvarchar](4000)  NULL,
	[_name] [nvarchar](4000)  NULL,
	[latitude] [float]  NULL,
	[longitude] [float]  NULL
)
GO;

INSERT INTO dim_station ([station_id],[_name],[latitude],[longitude])
    SELECT [station_id],[_name],[latitude],[longitude]
    FROM staging_stations

GO;

SELECT TOP (100) * FROM [dbo].[dim_station]
--############################################################################
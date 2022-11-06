IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseDelimitedTextFormat') 
	CREATE EXTERNAL FILE FORMAT [SynapseDelimitedTextFormat] 
	WITH ( FORMAT_TYPE = DELIMITEDTEXT ,
	       FORMAT_OPTIONS (
			 FIELD_TERMINATOR = ',',
			 USE_TYPE_DEFAULT = FALSE
			))
GO

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'dwfilesystem_dwstorageshankar_dfs_core_windows_net') 
	CREATE EXTERNAL DATA SOURCE [dwfilesystem_dwstorageshankar_dfs_core_windows_net] 
	WITH (
		LOCATION = 'abfss://dwfilesystem@dwstorageshankar.dfs.core.windows.net', 
		TYPE = HADOOP 
	)
GO

CREATE EXTERNAL TABLE staging_trips (
	[trip_id] nvarchar(4000),
	[rideable_type] nvarchar(4000),
	[start_at] VARCHAR(50),
	[ended_at] VARCHAR(50),
	[start_station_id] nvarchar(4000),
	[end_station_id] nvarchar(4000),
	[rider_id] bigint
	)
	WITH (
	LOCATION = 'publictrip.txt',
	DATA_SOURCE = [dwfilesystem_dwstorageshankar_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
	)
GO


SELECT TOP 100 * FROM dbo.staging_trips
GO
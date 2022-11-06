--############################################################################
--Create dim_time table

CREATE TABLE dim_time (
	[time_id] [uniqueidentifier] NOT NULL,
	[_date] [varchar](50)  NULL,
    [dayofweek] int,
    [dayofmonth] int,
    [weekofyear] int,
	[_quarter] int,
	[_month] int,
	[_year] int
)
GO;

ALTER TABLE dim_time add CONSTRAINT PK_dim_time_time_id PRIMARY KEY NONCLUSTERED (time_id) NOT ENFORCED

DECLARE @StartDate DATETIME
DECLARE @EndDate DATETIME
SET @StartDate = (SELECT MIN(TRY_CONVERT(datetime, left(start_at, 19))) FROM staging_trips)
SET @EndDate = DATEADD(year, 5, (SELECT MAX(TRY_CONVERT(datetime, left(start_at, 19))) FROM staging_trips))

WHILE @StartDate <= @EndDate
    BEGIN
        INSERT INTO [dim_time]
        SELECT
            NEWID(),
            @StartDate,
            DATEPART(WEEKDAY, @StartDate),
            DATEPART(DAY, @StartDate),
            DATEPART(WEEK, @StartDate),
            DATEPART(QUARTER, @StartDate),
            DATEPART(MONTH, @StartDate),
            DATEPART(YEAR, @StartDate)

        SET @StartDate = DATEADD(day, 1, @StartDate)
    END


SELECT TOP (100) * FROM [dbo].[dim_time]
--############################################################################
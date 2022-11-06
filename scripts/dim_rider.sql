--############################################################################
-- Create Rider table


CREATE TABLE dim_rider (
	[rider_id] [bigint]  NULL,
	[first_name] [nvarchar](4000)  NULL,
	[last_name] [nvarchar](4000)  NULL,
	[address] [nvarchar](4000)  NULL,
	[birthday] [varchar](50)  NULL,
	[account_start_date] [varchar](50)  NULL,
	[account_end_date] [varchar](50)  NULL,
	[is_member] [bit]  NULL
)
GO;

INSERT INTO dim_rider (
    [rider_id]
    ,[first_name]
    ,[last_name]
    ,[address]
    ,[birthday]
    ,[account_start_date]
    ,[account_end_date]
    ,[is_member])
SELECT 
    [rider_id]
    ,[first_name]
    ,[last_name]
    ,[address]
    ,[birthday]
    ,[account_start_date]
    ,[account_end_date]
    ,[is_member]
FROM staging_riders

GO;

SELECT TOP (100) * FROM [dbo].[dim_rider]
--############################################################################
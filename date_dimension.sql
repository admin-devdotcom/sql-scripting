Use Budget

CREATE TABLE [dbo].[date_dimension](
       [DateId] [int] NOT NULL,
       [DateKey] [date] NOT NULL,       
       [DayOfWeek] [tinyint] NOT NULL,
       [DayOfWeekName] [nvarchar](10) NOT NULL,
       [DayOfMonth] [tinyint] NOT NULL,
       [DayOfYear] [smallint] NOT NULL,
       [WeekOfYear] [tinyint] NOT NULL,
       [MonthName] [nvarchar](10) NOT NULL,
       [MonthOfYear] [tinyint] NOT NULL,
       [CalendarQuarter] [tinyint] NOT NULL,
       [CalendarYear] [smallint] NOT NULL,
	   [WeekEnding] [date],
       [IsWeekend] [bit] NOT NULL,
       [IsLeapYear] [bit] NOT NULL,
 CONSTRAINT [PK_DimDate] PRIMARY KEY CLUSTERED
(
       [DateKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[date_dimension] ADD  CONSTRAINT [DF_DimDate_IsWeekend]  DEFAULT ((0)) FOR [IsWeekend]
GO
ALTER TABLE [dbo].[date_dimension] ADD  CONSTRAINT [DF_DimDate_IsLeapYear]  DEFAULT ((0)) FOR [IsLeapYear]
GO


-- Declare and set variables for loop
Declare
@StartDate date,
@EndDate date,
@Date date
Set @StartDate = '2020-01-01'
Set @EndDate = '2030-01-01'
Set @Date = @StartDate
-- Loop through dates
WHILE @Date <= @EndDate
BEGIN
    -- Check for leap year
    DECLARE @IsLeapYear BIT
    IF ((Year(@Date) % 4 = 0) AND (Year(@Date) % 100 != 0 OR Year(@Date) % 400 = 0))
    BEGIN
        SELECT @IsLeapYear = 1
    END
    ELSE
    BEGIN
        SELECT @IsLeapYear = 0
    END
    -- Check for weekend
    DECLARE @IsWeekend BIT
    IF (DATEPART(dw, @Date) = 1 OR DATEPART(dw, @Date) = 7)
    BEGIN
        SELECT @IsWeekend = 1
    END
    ELSE
    BEGIN
        SELECT @IsWeekend = 0
    END
    -- Insert record in dimension table if date does not exist
    IF NOT EXISTS ( SELECT 'X' from dbo.[date_dimension] (NOLOCK) where DateKey = @Date )
    BEGIN
   
    INSERT Into [date_dimension] with(rowlock)
    (
		[DateId]			
       ,[DateKey]		
       ,[DayOfWeek]		
       ,[DayOfWeekName]	
       ,[DayOfMonth]		
       ,[DayOfYear]		
       ,[WeekOfYear]		
       ,[MonthName]		
       ,[MonthOfYear]	
       ,[CalendarQuarter]
       ,[CalendarYear]		   		
       ,[IsWeekend]		
       ,[IsLeapYear]		
    )
    Values
    (
    Convert(INT, CONVERT(varchar(10), @Date, 112)),
    @Date,
    DATEPART(dw, @Date),
    DATENAME(dw, @Date),
    Day(@Date),
    DATEPART(dy, @Date),
    DATEPART(wk, @Date),
    DATENAME(mm, @Date),
    DATEPART(mm, @Date),
    DATENAME(qq, @Date),
    Year(@Date),
    @IsWeekend,
    @IsLeapYear
    )
   
    END
    -- Goto next day
    Set @Date = dateadd(day,1,@Date )
END

select * from [date_dimension]

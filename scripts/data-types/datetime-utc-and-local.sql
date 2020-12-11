----------------------------------------------------------------------------------------------------------------------------
--
--	Purpose:			working with dates and times stored in utc and converting to local
--
----------------------------------------------------------------------------------------------------------------------------

-- converting date and time from utc to a local timezone
declare @dateInBST datetime2 = '2020-06-02 15:00'
declare @dateInGMT datetime2 = '2020-12-02 15:00'

SELECT 
		@dateInBST AS DateInBST,
		@dateInBST AT TIME ZONE 'GMT Standard Time' AS DateInBSTAtGMT,
		DATEADD(MINUTE, DATEPART(tz, @dateInBST AT TIME ZONE 'GMT Standard Time'), @dateInBST) AS DateInBSTAtCurrentGMTDateTime,
	  
		@dateInGMT AS DateInGMT,
		@dateInGMT AT TIME ZONE 'GMT Standard Time' AS DateInGMTAtGMT,
		DATEADD(MINUTE, DATEPART(tz, @dateInGMT AT TIME ZONE 'GMT Standard Time'), @dateInGMT) AS DateInGMTAtCurrentGMTDateTime


-- shows the timezone information in the sql server
select *
from sys.time_zone_info
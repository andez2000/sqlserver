SELECT
	 path AS [Default Trace File]
	,max_size AS [Max File Size of Trace File]
	,max_files AS [Max No of Trace Files]
	,start_time AS [Start Time]
	,last_event_time AS [Last Event Time]
FROM sys.traces WHERE is_default = 1


USE tempdb
GO

IF OBJECT_ID('dbo.TraceTable', 'U') IS NOT NULL
	DROP TABLE dbo.TraceTable;

SELECT * INTO TraceTable
FROM ::fn_trace_gettable
('D:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\Log\log_22.trc', default)
GO

SELECT
	 DatabaseID
	,DatabaseName
	,LoginName
	,HostName
	,ApplicationName
	,StartTime
	,CASE
		WHEN EventClass = 46 THEN 'Database Created'
		WHEN EventClass = 47 THEN 'Database Dropped'
	ELSE 'NONE'
	END AS EventType
FROM tempdb.dbo.TraceTable
	WHERE EventClass = 47
	
	
	and DatabaseName like '%031abfbea72%'
	--	AND (EventClass = 46 /* Event Class 46 refers to Object:Created */
	--		OR EventClass = 47) /* Event Class 47 refers to Object:Deleted */
GO
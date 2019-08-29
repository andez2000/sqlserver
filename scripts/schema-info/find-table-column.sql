-------------------------------------------------------------------------------
--
--	Purpose:	Finds the columns in a database.
--
--	Detail:		This returns extended column information such as the data 
--				type.
--
-------------------------------------------------------------------------------
declare @findExact bit = 1
declare @columnName varchar(max) --= 'status'
declare @tableName varchar(max) = 'CourseTemplate'
declare @colType varchar(max)


select	  
		  tbl.[name] as [Table]
		, SCHEMA_NAME(tbl.[schema_id]) as [Schema]
		, col.[name] as [Column]
		, t.[name] as [DataType]
		--, col.[max_length]
		--, t.[max_length]
		--, t.[user_type_id]
		
from sys.columns col
join sys.tables tbl on col.[object_id] = tbl.[object_id]
join sys.types t on t.[user_type_id] = col.[user_type_id]
join sys.schemas s on t.[schema_id] = s.[schema_id]

where
	1=1
	and (@colType is null or t.[name] = @colType)
	and (@tableName is null 
		or (@findExact = 1 and tbl.[name] = @tableName) 
		or (@findExact = 0 and tbl.[name] like '%' + @tableName + '%')
	)
	and (@columnName is null 
		or (@findExact = 1 and col.[name] = @columnName) 
		or (@findExact = 0 and col.[name] like '%' + @columnName + '%')
	)

order by 
	  tbl.[name]
	, col.[name]
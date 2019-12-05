-------------------------------------------------------------------------------
--
--	Purpose:	Finds the columns in a database.
--
--	Detail:		This returns extended column information such as the data 
--				type.
--
-------------------------------------------------------------------------------
declare @findExact bit = 0
declare @columnName varchar(max) = ''
declare @tableName varchar(max) = 'coursetemplate'
declare @colType varchar(max)


select	  
		  s.[name] as [Schema]
		, tbl.[name] as [Table]
		, col.[name] as [Column]
		, t.[name] as [DataType]
		, col.[max_length]
		, t.[max_length]
		, t.[user_type_id]

from sys.columns col
join sys.tables tbl on col.[object_id] = tbl.[object_id]
join sys.types t on t.[user_type_id] = col.[user_type_id]
join sys.schemas s on tbl.[schema_id] = s.[schema_id]

where
	1=1
	and (@colType is null or t.[name] = @colType)
	and (IsNull(@tableName, '') = ''
		or (@findExact = 1 and tbl.[name] = @tableName) 
		or (@findExact = 0 and tbl.[name] like '%' + @tableName + '%')
	)
	and (IsNull(@columnName, '') = ''
		or (@findExact = 1 and col.[name] = @columnName) 
		or (@findExact = 0 and col.[name] like '%' + @columnName + '%')
	)

order by 
	  tbl.[name]
	, col.[name]
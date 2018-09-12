-------------------------------------------------------------------------------
--
--	Purpose:	Finds the columns in a database.
--
--	Detail:		This returns extended column information such as the data 
--				type.
--
-------------------------------------------------------------------------------
declare @columnName varchar(max) = 'vendor'
declare @tableName varchar(max)
declare @colType varchar(max)


select	  
		  tbl.[name] as [Table]
		, col.[name] as [Column]
		, t.[name] as [DataType]
		--, col.[max_length]
		--, t.[max_length]
		--, t.[user_type_id]
		
from sys.columns col
join sys.tables tbl on col.[object_id] = tbl.[object_id]
join sys.types t on t.[user_type_id] = col.[user_type_id]

where
	1=1
	and (@colType is null or t.[name] = @colType)
	and (@tableName is null or tbl.[name] like '%' + @tableName + '%')
	and (@columnName is null or col.[name] like '%' + @columnName + '%')

order by 
	  tbl.[name]
	, col.[name]
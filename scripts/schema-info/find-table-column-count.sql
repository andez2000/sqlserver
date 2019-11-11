-------------------------------------------------------------------------------
--
--	Purpose:	Finds the # columns per table in a database.
--
--	Detail:		
--
-------------------------------------------------------------------------------
declare @findExact bit = 1
declare @columnName varchar(max) = ''
declare @tableName varchar(max) = ''
declare @colType varchar(max)


select	  
		  tbl.[name] as [Table]
		, count(col.column_id)
		
from sys.columns col
join sys.tables tbl on col.[object_id] = tbl.[object_id]

where
	1=1
	and (IsNull(@tableName, '') = ''
		or (@findExact = 1 and tbl.[name] = @tableName) 
		or (@findExact = 0 and tbl.[name] like '%' + @tableName + '%')
	)
	and (IsNull(@columnName, '') = ''
		or (@findExact = 1 and col.[name] = @columnName) 
		or (@findExact = 0 and col.[name] like '%' + @columnName + '%')
	)

group by tbl.name

order by 
	  2 desc


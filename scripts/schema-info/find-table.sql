-------------------------------------------------------------------------------
--
--	Purpose:	Finds the tables in a database.
--
--	Detail:		
--
-------------------------------------------------------------------------------
declare @findExact bit = 0
declare @tableName varchar(max) = 'transaction'

select	  
		  sn.[schema_name]
		, tbl.[name] as [Table]
		
from sys.tables tbl 
join sys.schemas s on tbl.[schema_id] = s.[schema_id]
cross apply (
	select SCHEMA_NAME(tbl.[schema_id]) as [schema_name]
) sn

where
	1=1
	and (IsNull(@tableName, '') = ''
		or (@findExact = 1 and tbl.[name] = @tableName) 
		or (@findExact = 0 and tbl.[name] like '%' + @tableName + '%')
	)

order by 
	  sn.[schema_name]
	, tbl.[name]

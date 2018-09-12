-------------------------------------------------------------------------------
--
--	Purpose:	Finds the columns with constraints in a database.
--
--	Detail:		
--
-------------------------------------------------------------------------------
declare @columnName varchar(max)
declare @tableName varchar(max)
declare @colType varchar(max)


select	  
		  tbl.[name] as [Table]
		, col.[name] as [Column]
		, con.[name] as [ConstraintName]
		, con.[type_desc] as [ConstraintType]
		, t.[name] as [DataType]
		, con.[definition] as [ConstraintDefinition]
		, con.[create_date] as [ConstraintCreated]
		, con.[modify_date] as [ConstraintModified]
		
from sys.default_constraints con
join sys.columns col on  con.parent_column_id = col.column_id  
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


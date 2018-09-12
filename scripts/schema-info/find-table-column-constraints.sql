-------------------------------------------------------------------------------
--
--	Purpose:	Finds the columns with constraints in a database.
--
--	Detail:		
--
-------------------------------------------------------------------------------
declare @useLike bit
declare @columnName varchar(max)
declare @tableName varchar(max) = 'User'
declare @colType varchar(max)
declare @constraintName varchar(max)


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
inner join sys.columns col ON col.default_object_id = con.[object_id]
inner join sys.objects o ON o.[object_id] = con.parent_object_id 
join sys.tables tbl on col.[object_id] = tbl.[object_id]
join sys.types t on t.[user_type_id] = col.[user_type_id]

where
	1=1
	and (@colType is null or t.[name] = @colType)
	and (@tableName is null 
			or ((IsNull(@useLike, 0) = 1 and tbl.[name] like '%' + @tableName + '%') 
				or (tbl.[name] = @tableName)
			)
		)
	and (@columnName is null or col.[name] like '%' + @columnName + '%')
	and (@constraintName is null or con.[name] like '%' + @constraintName + '%')

order by 
	  tbl.[name]
	, col.[name]
	, con.[name]

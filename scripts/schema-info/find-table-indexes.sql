-------------------------------------------------------------------------------
--
--	Purpose:	Finds the indexes in a database.
--
--	Detail:		The scripts returns all clustered and non clustered indexes.
--
-------------------------------------------------------------------------------
declare @tableName varchar(max) = 'User'
declare @colType varchar(max)
declare @columnName varchar(max)
declare @indexType varchar(max) = 'NONCLUSTERED'
declare @primaryKeys bit = 0

select
      t.[name] as [TableName]
    , i.[name] as [IndexName]
    , c.[Name] as [ColumnName]
	, i.[type_desc] as [IndexType]
	, i.[is_primary_key] as [IsPrimaryKey]

from sys.tables t
inner join sys.indexes i ON t.[object_id] = i.[object_id]
inner join sys.index_columns ic ON i.[index_id] = ic.[index_id] AND i.[object_id] = ic.[object_id]
inner join sys.columns c ON ic.[column_id] = c.[column_id] AND ic.[object_id] = c.[object_id]

where
	1=1
	and (@colType is null or t.[name] = @colType)
	and (@tableName is null or t.[name] like '%' + @tableName + '%')
	and (@columnName is null or c.[name] like '%' + @columnName + '%')
	and (@indexType is null or i.[type_desc] = @indexType)
	and (@primaryKeys is null or i.[is_primary_key] = @primaryKeys)

order by 
	  t.[name]
	, c.[name]

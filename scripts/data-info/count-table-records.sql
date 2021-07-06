select 
      t.[name] AS TableName
    , i.[name] as indexName
    , p.[rows]
    , sum(a.[total_pages]) as TotalPages
    , sum(a.[used_pages]) as UsedPages
    , sum(a.[data_pages]) as DataPages
    , (sum(a.[total_pages]) * 8) / 1024 as TotalSpaceMB
    , (sum(a.[used_pages]) * 8) / 1024 as UsedSpaceMB
    , (sum(a.[data_pages]) * 8) / 1024 as DataSpaceMB

from 
    sys.tables t

inner join
    sys.indexes i on t.[object_id] = i.[object_id]
inner join
    sys.partitions p on i.[object_id] = p.[object_id] AND i.[index_id] = p.[index_id]
inner join 
    sys.allocation_units a on p.[partition_id] = a.[container_id]

WHERE 
    t.NAME NOT LIKE 'dt%' AND
    i.OBJECT_ID > 255 AND   
    i.index_id <= 1

	--and t.name like '%disci%'

GROUP BY 
    t.NAME, i.object_id, i.index_id, i.name, p.[Rows]

ORDER BY 
      p.[Rows] desc
	, object_name(i.object_id)
----------------------------------------------------------------------------------------------------------------------------
--
--	Purpose:			resolving hierarchical data
--
--	More Information:	https://docs.microsoft.com/en-us/previous-versions/sql/sql-server-2008-r2/ms186243(v=sql.105)
--
----------------------------------------------------------------------------------------------------------------------------
declare @selfReferencingTable table
(
	[id] int,
	[name] varchar(max),
	[parent_id] int null
)

insert into @selfReferencingTable
values
(1, 'Entity 1', null),
(2, 'Entity 2', null),

(3, 'Entity 1.1', 1),
(4, 'Entity 1.2', 1),
(5, 'Entity 2.1', 2),
(6, 'Entity 2.2', 2),

(7, 'Entity 1.1.1', 3),
(8, 'Entity 1.2.1', 4),

(9, 'Entity 1.1.1.1', 7)


select *
from @selfReferencingTable


;with FindHierarchy
 as 
(
	-- anchor
    select anchor.[id], anchor.[parent_id], anchor.[name]
    from @selfReferencingTable anchor
    where anchor.parent_id is null

    union all

	-- recursive member definition
	select e.[id], e.[parent_id], e.[Name]
    from @selfReferencingTable e
    inner join FindHierarchy nextChild on nextChild.[id] = e.[parent_id]
)
select * from FindHierarchy

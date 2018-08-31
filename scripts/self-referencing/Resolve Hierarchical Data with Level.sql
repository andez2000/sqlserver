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
	[parent_id] int null,
	[level] bit
)

declare @levelToSearchTo int = 1

insert into @selfReferencingTable
values
(1, 'Entity 1.1', null, 1),
(2, 'Entity 1.2', 1, 2),
(3, 'Entity 1.3', 2, 3),
(4, 'Entity 1.4', 3, 4),

(5, 'Entity 2.1', null, 1),
(6, 'Entity 2.2', 5, 2),
(7, 'Entity 3.1', null, 1)



select *
from @selfReferencingTable


;with FindHierarchy(id, parent_id, [level], [thetop])
as 
(
	-- anchor member definition
    select anchor.[id], anchor.parent_id, anchor.[level], anchor.id as [thetop]
    from @selfReferencingTable anchor
    where anchor.parent_id is null

    union all

	-- recursive member definition
    select x.id, x.parent_id, x.[level], x.parent_id as [thetop]
	from @selfReferencingTable x
	inner join FindHierarchy nextchild on nextchild.parent_id = x.id
	--where @levelToSearchTo = -1 or nextchild.[level] <= @levelToSearchTo
)
select * from FindHierarchy x
order by x.id, x.parent_id, x.[level]


--select 
--		  parent.id as 'ParentId'
--		, parent.[name] as 'ParentName'
--		, parent.parent_id as 'ParentDirectParentId'
--		, parent.is_latest as 'ParentIsLatest'
--		, child.id as 'ChildId'
--		, child.parentid as 'ChildParentId'
--		--, child.id as 'ChildId'
--		--, child.[name] as 'ChildName'
--		--, child.parent_id as 'ChildParentId'
--		--, child.is_latest as 'ChildIsLatest'

--from @selfReferencingTable parent
--left join FindHierarchy child on child.id = parent.parent_id
----where rfxh.id = @rfxid
--order by parent.[name], parent.[id]
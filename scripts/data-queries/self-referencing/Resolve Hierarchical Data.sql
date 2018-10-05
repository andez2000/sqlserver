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
--	[version] int,
	[parent_id] int null,
	[is_latest] bit
)

insert into @selfReferencingTable
values
(1, 'Entity 1.1', null, 0),
(2, 'Entity 1.2', 1, 0),
(3, 'Entity 1.3', 2, 0),
(4, 'Entity 1.4', 3, 1),

(5, 'Entity 2.1', null, 0),
(6, 'Entity 2.2', 5, 1),
(7, 'Entity 3.1', null, 1)

--1, 
--2, 
--3, 
--4, 
--1, 
--2, 
--1, 

select *
from @selfReferencingTable


;with FindHierarchy(parentid, id)
 as 
(
	-- anchor member definition
    select anchor.[id], anchor.parent_id
    from @selfReferencingTable anchor
    where anchor.parent_id is null

    union all

	-- recursive member definition
    select x.parent_id, x.id
	from @selfReferencingTable x
    inner join FindHierarchy nextchild on x.id = nextchild.parentid

	--where x.is_latest = 1
)
select * from FindHierarchy

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
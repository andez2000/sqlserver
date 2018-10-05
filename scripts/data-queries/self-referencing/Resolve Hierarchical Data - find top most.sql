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
	[level] int
)

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

-- top to bottom
;with cte(id, parent_id, [level], topLevelParentId)
as 
(
	-- anchor member definition
    select anchor.[id], anchor.parent_id, anchor.[level], anchor.id as topLevelParentId
    from @selfReferencingTable anchor
    where anchor.parent_id is null

    union all

    select x.id, x.parent_id, x.[level], cte.topLevelParentId
  	from @selfReferencingTable x
	join cte on cte.id = x.parent_id
)
select 
		  s.id
		, s.[name]
		, s.parent_id
		, s.[level]
		, x.topLevelParentId
from cte x
join @selfReferencingTable s on x.id = s.id

order by x.id, x.parent_id, x.[level]  










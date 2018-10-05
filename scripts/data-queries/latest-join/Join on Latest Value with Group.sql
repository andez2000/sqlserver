----------------------------------------------------------------------------------------------------------------------------
--
--	Purpose:			join two tables where one contains a subset of values where we need the latest from a group
--
----------------------------------------------------------------------------------------------------------------------------

declare @Parent table (
	[Id] int,
	[Name] varchar(max)
)

declare @Child table (
	[Id] int,
	[Name] varchar(max),
	[ParentId] int,
	[GroupName] varchar(max),
	[Value] int
)

insert into @Parent
values
(1, 'Parent 1')

insert into @Child
values
(1, 'Child 1.1', 1, 'Group 1', 1),
(2, 'Child 1.2', 1, 'Group 1', 100),
(3, 'Child 1.3', 1, 'Group 1', 3),

(4, 'Child 2.1', 1, 'Group 2', 100),
(5, 'Child 2.2', 1, 'Group 2', 1),
(6, 'Child 2.3', 1, 'Group 2', 2),

(7, 'Child 3.1', 1, 'Group 3', 10),
(8, 'Child 3.2', 1, 'Group 3', 1),
(9, 'Child 3.3', 1, 'Group 3', 300),

(10, 'Child 4.1', 1, 'Group 4', 12)

-- return:
--	Parent 1, Child 1.2, Group1
--	Parent 1, Child 2.1, Group2
--	Parent 1, Child 3.3, Group3
--	Parent 1, Child 4.1, Group4
--	Parent 1, null, null

select 
		  p.Id
		, p.[Name]
		, maxchild.[Id] as 'ChildId'
		, maxchild.[ChildName]
		, maxchild.[Value]
		, maxchild.[GroupName]
from @Parent as p
OUTER APPLY (
	select
		  c.Id
		, c.[Name] as [ChildName]
		, c.[Value] 
		, c.[GroupName]
	from @Child c 
	where 
		c.ParentId = p.Id  
		and c.Id = (
			select top 1
					  cx.Id
			from @Child cx 
			where c.GroupName = cx.GroupName and c.ParentId = cx.ParentId
			order by cx.[Value] desc
		)
) as maxchild

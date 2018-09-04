----------------------------------------------------------------------------------------------------------------------------
--
--	Purpose:			join two tables where one contains a subset of values where we need the latest
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
	[Value] int
)

insert into @Parent
values
(1, 'Parent 1'),
(2, 'Parent 2'),
(3, 'Parent 3'),
(4, 'Parent 4'),
(5, 'Parent 5')

insert into @Child
values
(1, 'Child 1.1', 1, 1),
(2, 'Child 1.2', 1, 100),
(3, 'Child 1.3', 1, 3),

(4, 'Child 2.1', 2, 100),
(5, 'Child 2.2', 2, 1),
(6, 'Child 2.3', 2, 2),

(7, 'Child 3.1', 3, 10),
(8, 'Child 3.2', 3, 1),
(9, 'Child 3.3', 3, 300),

(10, 'Child 4.1', 4, 12)


-- return:
--	Parent 1, Child 1.2
--	Parent 2, Child 2.1
--	Parent 3, Child 3.3
--	Parent 4, Child 4.1
--	Parent 5, null

select 
		  p.Id
		, p.[Name]
		, maxchild.[Id] as 'ChildId'
		, maxchild.[ChildName]
		, maxchild.[Value]
from @Parent as p
OUTER APPLY (
	select top 1 
		  c.Id
		, c.[Name] as [ChildName]
		, c.[Value] 
	from @Child c 
	where 
		c.ParentId = P.Id  
	ORDER BY C.[Value] desc
) as maxchild
--left join @Child c on maxchild.Id = c.Id
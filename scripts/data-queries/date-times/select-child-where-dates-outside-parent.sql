-- compare 2 date ranges over two tables

declare @parent table (
	[name] varchar(max),
	[from] datetime,
	[to] datetime
);

declare @child table (
	[name] varchar(max),
	[from] datetime,
	[to] datetime
);

insert into @parent
values
('item-1', '2021-02-15', '2021-02-16'),
('item-2', '2021-02-20', '2021-02-25'),
('item-3', '2021-02-20', '2021-02-25')
;

insert into @child
values
('item-1', '2021-02-15', '2021-02-16'),
('item-2', '2021-02-20', '2021-02-25'),
('item-2', '2021-02-19', '2021-02-19'),
('item-2', '2021-02-26', '2021-02-26')
;


select 
		  p.[name]
		, p.[from] as 'parent from'
		, p.[to] as 'parent to'
		, c.[from] as 'child from'
		, c.[to] as 'child to'

from @parent p
join @child c on p.[name] = c.[name]

where c.[from] < p.[from] or c.[to] > p.[to]


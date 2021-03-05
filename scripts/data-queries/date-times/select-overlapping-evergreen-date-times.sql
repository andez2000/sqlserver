----------------------------------------------------------------------------------------------------------------------------
--
--	Purpose:			applying date range filter queries to data range data allowing for evergreen
--
--	In a nutshell:		the following selection criteria satisfies all cases:
--							EffectiveFrom <= @endDate and EffectiveTo >= @startDate
--
----------------------------------------------------------------------------------------------------------------------------

declare @data table (
	[id] int,
	[name] varchar(max),
	[effective_from] datetime2,
	[effective_to] datetime2
);

insert into @data
values
(1, 'Jan 21', '2021-01-01', '2021-01-31'),
(4, 'Jan 22 (Evergreen)', '2022-01-01', null),
(5, 'Jan 22 (Transient)', null, '2022-01-31')
;

-- a range of mid jan to mid feb 2021
-- selects "Jan 21, Feb 21
select *
from @data d
where (d.[effective_from] <= '2021-02-15') and (d.[effective_to] >= '2021-01-15')

-- a range of start jan to start feb 2021
-- selects Jan 21 and Feb 21
select *
from @data d
where d.[effective_from] <= '2021-02-01' and d.[effective_to] >= '2021-01-01'



-- a range of mid jan to mid feb 22
-- selects "Jan (1), Feb (2) and Jan (Evergreen) (3)
select *
from @data d
where (d.[effective_from] is null or d.[effective_from] <= '2021-02-15') and (d.[effective_to] is null or d.[effective_to] >= '2021-01-15')
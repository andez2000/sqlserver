----------------------------------------------------------------------------------------------------------------------------
--
--	Purpose:			applying date range filter queries to data range data.
--
--	In a nutshell:		the following selection criteria satisfies all cases:
--							EffectiveFrom <= @endDate and EffectiveTo >= @startDate
--
----------------------------------------------------------------------------------------------------------------------------

declare @data table (
	[id] int,
	[name] varchar(max),
	[effective_from] datetime2 not null,
	[effective_to] datetime2 not null
);

insert into @data
values
(1, 'Jan 21', '2021-01-01', '2021-01-31'),
(2, 'Feb 21', '2021-02-01', '2021-02-28'),
(3, 'Mar 21', '2021-03-31', '2021-03-31 23:59:59'),
(4, 'Apr 21', '2021-04-01', '2021-04-30')
;

-- a range of start jan to start feb 2021
-- selects "Jan 21" and "Feb 21"
select *
from @data d
where d.[effective_from] <= '2021-02-01' and d.[effective_to] >= '2021-01-01'


-- a range of mid jan to mid feb 2021
-- selects "Jan 21", "Feb 21"
select *
from @data d
where (d.[effective_from] <= '2021-02-15') and (d.[effective_to] >= '2021-01-15')

-- a range of end mar 21
-- selects "Mar 21"
select *
from @data d
where (d.[effective_from] <= '2021-03-31') and (d.[effective_to] >= '2021-03-31')


-- a range of end mar to start apr 2021
-- selects "Mar 21", "Apr 21"
select *
from @data d
where (d.[effective_from] <= '2021-04-01') and (d.[effective_to] >= '2021-03-31')
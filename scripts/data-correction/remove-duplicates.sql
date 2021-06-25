declare @plop table (
	  id int
	, [name] varchar(max)
	, [some_image] image
);

insert into @plop
values
  (1, 'plop 1', cast(cast('ploppy' as varbinary(max)) as image))
, (2, 'plop 2', null)
, (2, 'plop 2', null)
, (3, 'plop 3', null)
, (3, 'plop 3', null)


select * from @plop

;

-- remove duplicates
with dups as (
	select 
		  id
		, [name]
		, ROW_NUMBER() over (
			partition by
				  [name]
				--, [name]
				--, [image]
			order by id
		) as row_num
	from @plop
)
delete from dups
where row_num > 1
;

select * from @plop







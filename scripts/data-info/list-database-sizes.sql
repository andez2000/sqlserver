select 
		  d.name
		, case when m.type = 0 then 'Data' else 'Log' end as 'Type'
		,  m.size * 8 / 1024 as 'SizeMB'
		,  m.size * 8.0 / 1024.0 / 1024.0 as 'SizeGB'
from sys.master_files m JOIN sys.databases d ON d.database_id = m.database_id
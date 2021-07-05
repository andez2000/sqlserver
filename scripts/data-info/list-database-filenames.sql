SELECT
      db.name AS DBName
    --, mf.type_desc AS FileType
    , mf_d.Physical_Name AS DataLocation
	, mf_l.Physical_Name AS LogLocation

FROM sys.databases db
cross apply (
	select mf.physical_name, mf.database_id
	from sys.master_files mf
	where mf.database_id = db.database_id and mf.type_desc = 'ROWS'
) mf_d
cross apply (
	select mf.physical_name, mf.database_id
	from sys.master_files mf
	where mf.database_id = db.database_id and mf.type_desc = 'LOG'
) mf_l



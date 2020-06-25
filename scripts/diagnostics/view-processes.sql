SELECT 
	  db_name(p.dbid) as DatabaseName
	, p.program_name
	, p.cmd
	, p.nt_username
FROM sys.sysprocesses p
WHERE dbid > 0
and db_name(dbid) = 'acme.playground'
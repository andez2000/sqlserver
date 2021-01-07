use [master]

if not exists (select p.[name] from [master].sys.server_principals p where p.[name] = 'SOME_SQL_USERNAME')
begin
	create login [SOME_SQL_USERNAME] 
		  with password = N'SOME_PASSWORD'
		, default_database = [master]
		, check_expiration = off
		, check_policy = off
end





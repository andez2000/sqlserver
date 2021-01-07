if database_principal_id('db_executor') is null
begin
	create role [db_executor] authorization [dbo]
end
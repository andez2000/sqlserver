declare @log nvarchar(max)

set @log = CONVERT(varchar, SYSDATETIME(), 121) + ': Task 2 - Inserting into Temp Approval History done...'
RAISERROR (@log, 10, 1) WITH NOWAIT
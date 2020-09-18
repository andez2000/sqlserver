-- 
--	Purpose:		Creates a new session to collate the xml_deadlock_report information
--	SQL Versions:	SQL 2016, 2019
--


CREATE EVENT SESSION [Collect-Deadlocks] ON SERVER 
ADD EVENT sqlserver.xml_deadlock_report(
    ACTION(
	  package0.callstack,package0.collect_system_time,package0.event_sequence,package0.process_id
	, sqlos.task_time,sqlserver.client_app_name,sqlserver.client_hostname,sqlserver.client_pid,sqlserver.context_info
	, sqlserver.database_id,sqlserver.database_name,sqlserver.is_system,sqlserver.nt_username,sqlserver.plan_handle
	, sqlserver.request_id,sqlserver.session_id,sqlserver.session_nt_username,sqlserver.session_resource_group_id
	, sqlserver.session_resource_pool_id,sqlserver.session_server_principal_name,sqlserver.sql_text,sqlserver.transaction_id
	, sqlserver.transaction_sequence,sqlserver.tsql_frame,sqlserver.tsql_stack,sqlserver.username))
ADD TARGET package0.event_file(SET filename=N'C:\sql-logs\deadlocks\deadlocks.xel',max_file_size=(20),max_rollover_files=(50))
WITH (
	  MAX_MEMORY=4096 KB,EVENT_RETENTION_MODE=ALLOW_SINGLE_EVENT_LOSS,MAX_DISPATCH_LATENCY=30 SECONDS
	, MAX_EVENT_SIZE=0 KB,MEMORY_PARTITION_MODE=NONE,TRACK_CAUSALITY=OFF,STARTUP_STATE=ON)
GO



SELECT 
	  r.session_id,
CASE r.transaction_isolation_level
WHEN 1 THEN 'ReadUncomitted'
WHEN 2 THEN 'ReadCommitted'
WHEN 3 THEN 'Repeatable'
WHEN 4 THEN 'Serializable'
WHEN 5 THEN 'Snapshot'
ELSE 'Unspecified' END AS transaction_isolation_level
FROM sys.dm_exec_requests r
CROSS APPLY sys.dm_exec_query_plan(plan_handle) ph


select @@SPID
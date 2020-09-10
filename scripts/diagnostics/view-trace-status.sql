DBCC TRACESTATUS;

-- globally
DBCC TRACESTATUS(-1);  

-- current session
DBCC TRACESTATUS();

-- specific statuses
DBCC TRACESTATUS (3605, 1204);

-- NOTE: to enable/disable a trace use: 
--		DBCC TRACEON (8690, -1); 
--		DBCC TRACEOFF(8690, -1)
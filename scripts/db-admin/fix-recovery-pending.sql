----------------------------------------------------------------------------------------------------------------------------
--
--	Purpose:			Database is stuck 'Recovery Pending'
--
--	More Information:	https://www.stellarinfo.com/blog/fix-sql-database-recovery-pending-state-issue/
--
----------------------------------------------------------------------------------------------------------------------------

ALTER DATABASE MyDatabaseName SET EMERGENCY;
GO
ALTER DATABASE MyDatabaseName set single_user
GO
DBCC CHECKDB (MyDatabaseName, REPAIR_ALLOW_DATA_LOSS) WITH ALL_ERRORMSGS;
GO
ALTER DATABASE MyDatabaseName set multi_user
GO
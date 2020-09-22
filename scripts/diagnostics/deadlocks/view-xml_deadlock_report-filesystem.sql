-- 
--	Purpose:	Read the Deadlock Report from the filesystem based Extended Event Collection
--	Status:		This query worked fine on test system
--

declare @extendedEventSessionName varchar(max)

set @extendedEventSessionName = 'Collect-Deadlocks'

-----------------------------------------------------------------------------------------------------------------------
;
with EventFileTargetFilename
AS (
	select XFileData.XFile.value('@name', 'varchar(128)') as [fileName]
	
	from sys.dm_xe_session_targets st
	inner join sys.dm_xe_sessions s on s.[address] = st.[event_session_address]
	cross apply (
		select Cast(target_data as xml) as [target_data_xml]
	) as TargetData
	
	cross apply 
		TargetData.target_data_xml.nodes('//EventFileTarget/File') AS XFileData (XFile)
	
	where s.[name] = @extendedEventSessionName
	and st.[target_name] = 'event_file'
)
select deadlock_info.[xml_deadlock_report],
       deadlock_info.[execution_time]

from EventFileTargetFilename
cross apply 
	sys.fn_xe_file_target_read_file(EventFileTargetFilename.[fileName], null, null, null)
cross apply (
	select 
		Convert(xml, event_data).query('/event/data/value/child::*') as [xml_deadlock_report],
		Convert(xml, event_data).value('(event[@name="xml_deadlock_report"]/@timestamp)[1]','datetime') as [execution_time]
) as deadlock_info
order by deadlock_info.execution_time desc
;

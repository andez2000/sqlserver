WITH DeadlockData
AS (
    SELECT
	    CAST(target_data as xml) AS XMLData
    FROM
	    sys.dm_xe_session_targets st
    JOIN
	    sys.dm_xe_sessions s 
    ON s.address = st.event_session_address
    WHERE name   = 'Collect-Deadlocks'
    AND st.target_name = 'ring_buffer' 
)
SELECT 
    XEventData.XEvent.value('@name', 'varchar(128)') as eventName,
    XEventData.XEvent.value('@timestamp', 'datetime2') as eventDate,
    CAST(XEventData.XEvent.query('(data/value/deadlock)[1]') AS XML) AS DeadLockGraph 
FROM 
    DeadlockData
CROSS APPLY
    XMLData.nodes('//RingBufferTarget/event') AS XEventData 
(XEvent)
WHERE
    XEventData.XEvent.value('@name','varchar(4000)') = 
'xml_deadlock_report' 
;
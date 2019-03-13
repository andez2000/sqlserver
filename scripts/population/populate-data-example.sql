/******************************************************************************

	Purpose:		Data Population Sample

	Description:	Given a lot of systems have data that is time based where
					things happen at certain points in time, this script aims
					to put populating data into some form.

******************************************************************************/
declare @beforeTime datetime
declare @aheadOfTime datetime
declare @withinTimeWindow datetime
declare @timeWindowStart datetime
declare @timeWindowEnd datetime

declare @request table
(
	  id int
	, title nvarchar(max)
	, sent_date datetime
	, response_deadline_date datetime
);

declare @response table
(
	  id int
	, request_id int
	, title nvarchar(max)
	, submitted_date datetime
)

-- request in past
-- request not sent

-- response in window
-- resonse after after window (deadline)

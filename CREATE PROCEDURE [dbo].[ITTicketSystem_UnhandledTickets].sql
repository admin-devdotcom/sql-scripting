USE [ITTicketSystem]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Proc will get the number of unhandled tickets
CREATE PROCEDURE [dbo].[ITTicketSystem_UnhandledTickets]

AS
BEGIN
	
	SET NOCOUNT ON;
    
	select count(*)[UnhandledTickets]		
	from ticket t 
	left join app_user a on t.assigned_app_user_id = a.app_user_id
	join ticket_status s on t.ticket_status_id = s.ticket_status_id		
	where t.active_flag = 1
	and active_status_id = 1
	
END
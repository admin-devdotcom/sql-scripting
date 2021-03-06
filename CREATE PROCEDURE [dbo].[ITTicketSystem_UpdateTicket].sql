USE [ITTicketSystem]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Proc will update a ticket record
CREATE PROCEDURE [dbo].[ITTicketSystem_UpdateTicket]
	@TicketID int,
	@TicketStatus varchar(150),
	--@AssignedTo varchar(150),	
	@TicketNotes varchar(5000),
	@UpdatedDate datetime
AS
BEGIN
	
	SET NOCOUNT ON;
    
	
	update t set
		t.ticket_status_id = s.ticket_status_id
	  -- ,t.assigned_app_user_id = a.app_user_id
	   ,t.ticket_notes = @TicketNotes
	   ,t.updated_date = @UpdatedDate
	FROM ticket t
	cross apply ticket_status s
	--cross apply app_user a
	WHERE ticket_id = @TicketID
	and s.name = @TicketStatus
	--and concat(a.first_name,'',a.last_name) = @AssignedTo
	

END

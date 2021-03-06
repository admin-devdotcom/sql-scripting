USE [ITTicketSystem]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Proc will update the active flag to 0 on any tickets that are deleted through the UI
CREATE PROCEDURE [dbo].[ITTicketSystem_DeleteTicket]
	@Id int			

AS
BEGIN
	
	SET NOCOUNT ON;
    
	
	update t set		
	    t.active_flag = 0
	   ,t.updated_date = getdate()
	FROM ticket t
	WHERE ticket_id = @Id	

END

USE [ITTicketSystem]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Proc will insert a ticket with a status of New
CREATE PROCEDURE [dbo].[ITTicketSystem_InsertTicket]
	@Title varchar(150),
	@Category varchar(150),
	@Description varchar(1000),	
	@RequestedBy varchar(500)
	
AS
BEGIN
	
	SET NOCOUNT ON;
    
	insert into ticket(title, category, description, ticket_status_id, requested_by, updated_date, active_flag)
	select @Title, @Category, @Description, s.ticket_status_id, @RequestedBy, getdate(), 1
	from ticket_status s	
	where s.code = 'NEW'	
	
END
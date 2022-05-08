USE [ITTicketSystem]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Proc will get a count of all active app users
CREATE PROCEDURE [dbo].[ITTicketSystem_AppUserCount]

AS
BEGIN
	
	SET NOCOUNT ON;
    
	select count(*)TotalCount
	from app_user
	where active_flag = 1

END
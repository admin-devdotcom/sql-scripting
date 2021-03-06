USE [ITTicketSystem]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Proc will get an app_user by ID
CREATE PROCEDURE [dbo].[ITTicketSystem_GetOneAppUsers] 
	@Id int
AS
BEGIN
	
	SET NOCOUNT ON;
    
	SELECT app_user_id[AppUserID]
		  ,first_name[FirstName]
		  ,last_name[LastName]
		  ,email_address[EmailAddress]
		  ,s.name[Status]		  
	FROM app_user a
	JOIN app_user_status s on a.app_user_status_id = s.app_user_status_id 	
	WHERE app_user_id = @Id

END
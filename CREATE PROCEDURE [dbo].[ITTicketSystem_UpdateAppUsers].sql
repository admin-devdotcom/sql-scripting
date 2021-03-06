USE [ITTicketSystem]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Proc will update a app_user record
CREATE PROCEDURE [dbo].[ITTicketSystem_UpdateAppUsers]
	@AppUserID int,
	@FirstName varchar(150),
	@LastName varchar(150),
	@EmailAddress varchar(500),	
	@UpdatedDate datetime,
	@Status varchar(150)
AS
BEGIN
	
	SET NOCOUNT ON;
    
	
	UPDATE a set first_name = @FirstName
		  ,last_name = @LastName
		  ,email_address = @EmailAddress
		  ,app_user_status_id = s.app_user_status_id
		  ,a.active_flag = iif(s.app_user_status_id = 1,1,0) 
		  ,updated_date = @UpdatedDate
	FROM app_user a
	cross apply app_user_status s
	WHERE app_user_id = @AppUserID
	and s.code = @Status
	

END
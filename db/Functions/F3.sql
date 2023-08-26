CREATE FUNCTION Func_notification_usuarios(@UserId uniqueidentifier)
RETURNS TABLE
AS
RETURN(
	SELECT * FROM practica1.Notification WHERE [UserId] = @UserId
);

-- SELECT * FROM dbo.Func_notification_usuarios('B1E877DB-BACD-42F6-BEC1-DE4CB89903BB');

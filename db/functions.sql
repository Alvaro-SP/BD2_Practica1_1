-- Functions

--Function 4 "Func_logger"
CREATE FUNCTION Func_logger()
RETURNS TABLE
AS
RETURN(
  SELECT Id, Date, Description
  FROM practica1.HistoryLog
);

-- Function 5 "Func_usuarios"
CREATE FUNCTION Func_usuarios(@UserId uniqueidentifier)
RETURNS @Resultado TABLE (
  Firstname NVARCHAR(MAX),
  Lastname NVARCHAR(MAX),
  Email NVARCHAR(MAX),
  DateOfBirth DATETIME2(7),
  Credits INT,
  RoleName NVARCHAR(MAX)
)
AS
BEGIN
  BEGIN TRY
    BEGIN TRANSACTION;
      INSERT INTO @Resultado (Firstname, Lastname, Email, DateOfBirth, Credits, RoleName)
      SELECT u.Firstname, u.Lastname, u.Email, u.DateOfBirth, uc.Credits, r.RoleName
      FROM practica1.Usuarios u
      INNER JOIN practica1.UsuarioRole ur ON u.Id = ur.UserId
      INNER JOIN practica1.Roles r ON ur.RoleId = r.Id
      WHERE u.Id = @UserId;
      COMMIT TRANSACTION;
  END TRY
  BEGIN CATCH
    IF @@TRANCOUNT > 0
      ROLLBACK TRANSACTION;
    -- Manejo de errores, mensaje personalizado
    DECLARE @ErrorMessage NVARCHAR(4000) = 'Error, no se pudieron obtener los datos del estudiante buscado';
    THROW 50001, @ErrorMessage, 1;
    END CATCH;
    RETURN;
END;



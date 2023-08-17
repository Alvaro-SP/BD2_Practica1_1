-- Functions

--Function 4 "Func_logger"
CREATE FUNCTION Func_logger()
RETURNS @results TABLE (
    Id INT,
    Date DATETIME2(7),
    Description NVARCHAR(MAX)
)
AS
BEGIN
    SELECT *
    FROM historyLog;
    RETURN;
END;

-- Function 5 "Func_usuarios"
CREATE FUNCTION Func_usuarios(@UserId uniqueidentifier)
RETURNS @results TABLE (
  Firstname NVARCHAR(MAX),
  Lastname NVARCHAR(MAX),
  Email NVARCHAR(MAX),
  DateOfBirth DATETIME2(7),
  Credits INT,
  RoleName NVARCHAR(MAX)
)
AS
BEGIN
    SELECT u.Firstname, u.Lastname, u.Email, u.DateOfBirth, uc.Credits, r.RoleName
    FROM practica1.Usuarios u
    INNER JOIN practica1.UsuarioRole ur ON u.Id = ur.UserId
    INNER JOIN practica1.Roles r ON ur.RoleId = r.Id
    WHERE u.Id = @UserId;
    RETURN;
END;



DROP FUNCTION IF EXISTS dbo.Func_usuarios;
GO
CREATE FUNCTION Func_usuarios(@UserId uniqueidentifier)
RETURNS TABLE
AS
RETURN(
SELECT u.Firstname, u.Lastname, u.Email, u.DateOfBirth, uc.Credits, r.RoleName
    FROM practica1.Usuarios u
    INNER JOIN practica1.UsuarioRole ur ON u.Id = ur.UserId
    INNER JOIN practica1.Roles r ON ur.RoleId = r.Id
	INNER JOIN practica1.ProfileStudent uc ON uc.UserId = @UserId
    WHERE u.Id = @UserId
);

-- SELECT * FROM dbo.Func_usuarios('3F1069D0-F94E-4104-8885-B83092837BE0'); -- F5
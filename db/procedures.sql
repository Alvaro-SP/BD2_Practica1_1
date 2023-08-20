--Procedures--------------------------

--Procedure X with GPT
--wothout transaccion
USE BD2
GO

CREATE PROCEDURE InsertStudentWithoutTransaction
(
    @Firstname NVARCHAR(MAX),
    @Lastname NVARCHAR(MAX),
    @Email NVARCHAR(MAX),
    @DateOfBirth DATETIME2,
    @Password NVARCHAR(MAX)
)
AS
BEGIN
    INSERT INTO practica1.Usuarios (Firstname, Lastname, Email, DateOfBirth, Password, LastChanges, EmailConfirmed)
    VALUES (@Firstname, @Lastname, @Email, @DateOfBirth, @Password, GETDATE(), 0);
END;

--with transaccion
USE BD2
GO

CREATE PROCEDURE InsertStudentWithTransaction
(
    @Firstname NVARCHAR(MAX),
    @Lastname NVARCHAR(MAX),
    @Email NVARCHAR(MAX),
    @DateOfBirth DATETIME2,
    @Password NVARCHAR(MAX)
)
AS
BEGIN
    BEGIN TRANSACTION; -- Inicia la transacción

    BEGIN TRY
        INSERT INTO practica1.Usuarios (Firstname, Lastname, Email, DateOfBirth, Password, LastChanges, EmailConfirmed)
        VALUES (@Firstname, @Lastname, @Email, @DateOfBirth, @Password, GETDATE(), 0);

        COMMIT TRANSACTION; -- Confirma la transacción si no hay errores
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION; -- Revierte la transacción en caso de error
    END CATCH;
END;

--Using procedure with transaction
DECLARE @Firstname NVARCHAR(MAX) = 'Nombre';
DECLARE @Lastname NVARCHAR(MAX) = 'Apellido';
DECLARE @Email NVARCHAR(MAX) = 'correo@example.com';
DECLARE @DateOfBirth DATETIME2 = '1990-01-01';
DECLARE @Password NVARCHAR(MAX) = 'Contraseña';

EXEC InsertStudentWithTransaction @Firstname, @Lastname, @Email, @DateOfBirth, @Password;


--Procedure 1 "Registro de Usuarios"



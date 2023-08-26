-- Registers with errors
INSERT INTO [practica1].[Course] ([CodCourse], [Name], [CreditsRequired])
VALUES (3, '11111 nombre malo', 5);

INSERT INTO [practica1].[Course] ([CodCourse], [Name], [CreditsRequired])
VALUES (4, 'nombre_bueno_malos_creditos', '-1');


INSERT INTO [practica1].[Usuarios] (Id, Firstname, Lastname, Email, DateOfBirth, Password, LastChanges, EmailConfirmed)
VALUES (NEWID(), '111 firstname', 'Hernandez', 'sergie@gmail.com',GETDATE(), 'usac2023', GETDATE(), 1);

INSERT INTO [practica1].[Usuarios] (Id, Firstname, Lastname, Email, DateOfBirth, Password, LastChanges, EmailConfirmed)
VALUES (NEWID(), 'Luis', '222 Lastname', 'sergie@gmail.com',GETDATE(), 'usac2023', GETDATE(), 1);



-- Course name constraint
ALTER TABLE [practica1].[Course]
WITH NOCHECK
ADD CONSTRAINT CK_Course_Name
CHECK ([Name] IS NOT NULL AND [Name] <> '' AND [Name] LIKE '[A-Za-z][_A-Za-z0-9 ]%');

-- Course credits required constraint
ALTER TABLE [practica1].[Course]
WITH NOCHECK
ADD CONSTRAINT CK_Course_CreditsRequired
CHECK (ISNUMERIC([CreditsRequired]) = 1 AND [CreditsRequired]>0);

-- User name constraint
ALTER TABLE [practica1].[Usuarios]
WITH NOCHECK
ADD CONSTRAINT CK_Usuarios_Firstname
CHECK ([Firstname] IS NOT NULL AND [Firstname] <> '' AND [Firstname] LIKE '[A-Za-z][_A-Za-z0-9 ]%');

-- User lastname constraint
ALTER TABLE [practica1].[Usuarios]
WITH NOCHECK
ADD CONSTRAINT CK_Usuarios_Lastname
CHECK ([Lastname] IS NOT NULL AND [Lastname] <> '' AND [Lastname] LIKE '[A-Za-z][_A-Za-z0_9 ]%');



DROP PROCEDURE IF EXISTS PR6;
GO
CREATE PROCEDURE PR6
AS
BEGIN
    -- Update course names
    UPDATE [practica1].[Course]
    SET
        [Name] = 'Nombre Corregido'
    WHERE
        [Name] IS NULL OR [Name] = '' OR [Name] NOT LIKE '[A-Za-z][_A-Za-z0-9 ]%';
    -- Update course credit requirements
    UPDATE [practica1].[Course]
    SET
        [CreditsRequired] = 1
    WHERE
        ISNUMERIC([CreditsRequired]) = 0 or [CreditsRequired]<0;
    -- Update user first names
    UPDATE [practica1].[Usuarios]
    SET
        [Firstname] = 'Nombre Corregido'
    WHERE
        [Firstname] IS NULL OR [Firstname] = '' OR [Firstname] NOT LIKE '[A-Za-z][_A-Za-z0-9 ]%';
    -- Update user last names
    UPDATE [practica1].[Usuarios]
    SET
        [Lastname] = 'Apellido Corregido'
    WHERE
        [Lastname] IS NULL OR [Lastname] = '' OR [Lastname] NOT LIKE '[A-Za-z][_A-Za-z0_9 ]%';
END;

-- Example of execution
EXEC PR6;

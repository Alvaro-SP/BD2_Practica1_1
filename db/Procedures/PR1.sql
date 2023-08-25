-- ? █▀█ █▀▀ █▀▀ █ █▀ ▀█▀ █▀█ █▀█
-- ? █▀▄ ██▄ █▄█ █ ▄█ ░█░ █▀▄ █▄█
-- ! Procedure 1 "Registro de Usuarios"
USE BD2
    GO
    IF OBJECT_ID('PR1', 'P') IS NOT NULL
    BEGIN
        DROP PROCEDURE PR1;
    END;
    GO
    CREATE PROCEDURE PR1
        @Firstname nvarchar(max), --* Nombre del usuario
        @Lastname nvarchar(max), --* Apellido del usuario
        @Email nvarchar(max), --* Correo electrónico del usuario
        @DateOfBirth datetime2(7), --* Fecha de nacimiento del usuario
        @Password nvarchar(max), --* Contraseña del usuario
        @Credits int --* Créditos del estudiante
    AS
    BEGIN
        -- Validate the email format
        IF (LEN(@Email) > 0) AND (@Email LIKE '%_@__%.__%') BEGIN
            BEGIN TRANSACTION; -- Start a new transaction

            BEGIN TRY
                --* Verificar si el correo electrónico ya está registrado
                IF EXISTS (SELECT 1 FROM [practica1].[Usuarios] WHERE Email = @Email)
                BEGIN
                    PRINT 'El correo electrónico ya está registrado.';
                END;
                ELSE
                    BEGIN
                        DECLARE @UserId uniqueidentifier = NEWID(); -- Generar un nuevo GUID para el usuario
                        DECLARE @EmailConfirmed bit = 1; --! Cambiar a 0 si se desactiva el USER
                        DECLARE @TFAStatus bit = 0; -- Cambiar a 1 si el segundo factor de autenticación está activado
                        --* Insertar el registro en la tabla Usuarios
                        INSERT INTO [practica1].[Usuarios] (Id, Firstname, Lastname, Email, DateOfBirth, Password, LastChanges, EmailConfirmed)
                        VALUES (@UserId, @Firstname, @Lastname, @Email, @DateOfBirth, @Password, GETDATE(), 1);

                        --* Insertar el perfil de estudiante en la tabla ProfileStudent
                        INSERT INTO [practica1].[ProfileStudent] (UserId, Credits)
                        VALUES (@UserId, @Credits);

                        --* Verificar y agregar el rol de estudiante en la tabla UsuarioRole
                        DECLARE @StudentRoleId uniqueidentifier;
                        DECLARE @RoleId uniqueidentifier = NEWID(); 
                        INSERT INTO [practica1].[Roles] (Id, RoleName) 
                        VALUES (@RoleId, 'Estudiante')
                        INSERT INTO [practica1].[UsuarioRole] (RoleId, UserId, IsLatestVersion)
                        VALUES (@RoleId, @UserId, 1);

                        --* Agregar la información de autenticación de segundo factor en la tabla TFA
                        INSERT INTO [practica1].[TFA] (UserId, Status, LastUpdate)
                        VALUES (@UserId, @TFAStatus, GETDATE());

                        --* Agregar una entrada en el historial de registros
                        INSERT INTO [practica1].[HistoryLog] (Date, Description)
                        VALUES (GETDATE(), 'Se registró un nuevo estudiante.');

                        --* Agregar una notificación al estudiante
                        INSERT INTO [practica1].[Notification] (UserId, Message, Date)
                        VALUES (@UserId, 'Bienvenido al sistema. Su registro como estudiante se ha completado.', GETDATE());
                        --* Agregar una notificación al estudiante
                        INSERT INTO [practica1].[Notification] (UserId, Message, Date)
                        VALUES (@UserId, 'Bienvenido al sistema. Su registro como estudiante se ha completado.', GETDATE());
                        
                        PRINT 'El usuario se ha registrado correctamente.';
                    END
            END TRY
            BEGIN CATCH
                ROLLBACK; -- Rollback the transaction on error
                -- THROW; -- Throw the error to the client
                PRINT 'Error durante el registro, intente nuevamente.';
            END CATCH;

            COMMIT; -- Commit the transaction on successful completion
        END ELSE BEGIN
            PRINT 'El formato del correo electrónico no es válido.';
        END
    END;

    DECLARE @Firstname nvarchar(max) = 'John';
    DECLARE @Lastname nvarchar(max) = 'Doe';
    DECLARE @Email nvarchar(max) = 'socop241ee2@gmail.com';
    DECLARE @DateOfBirth datetime2(7) = '1990-01-15';
    DECLARE @Password nvarchar(max) = 'SecurePassword123';
    DECLARE @Credits int = 0;

    EXEC PR1 @Firstname, @Lastname, @Email, @DateOfBirth, @Password, @Credits;

    DELETE FROM [practica1].[Usuarios] WHERE Email = 'socop241ee2@gmail.com';
    -- UPDATE [practica1].[Usuarios] SET EmailConfirmed = 1 WHERE Email = 'socop241ee2@gmail.com';
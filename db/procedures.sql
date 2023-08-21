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

--with transaccion n validations
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
      BEGIN TRANSACTION; --! Start of TRANSACTION

      BEGIN TRY
         -- Validación de Nombre y Apellido
         IF (NOT ISNULL(@Firstname, '') LIKE '%[^a-zA-Z]%')
               AND (NOT ISNULL(@Lastname, '') LIKE '%[^a-zA-Z]%')
         BEGIN
               -- Validación de Email
               IF @Email LIKE '%_@__%.__%'
               BEGIN
                  -- Validación de DateOfBirth (mayor de edad)
                  IF DATEDIFF(YEAR, @DateOfBirth, GETDATE()) >= 18
                  BEGIN
                     -- Validación de Password (mayúscula, carácter especial, número y longitud)
                     IF @Password LIKE '%[A-Z]%' AND @Password LIKE '%[^a-zA-Z0-9]%' AND @Password LIKE '%[0-9]%' AND LEN(@Password) >= 8
                     BEGIN
                           INSERT INTO practica1.Usuarios (Firstname, Lastname, Email, DateOfBirth, Password, LastChanges, EmailConfirmed)
                           VALUES (@Firstname, @Lastname, @Email, @DateOfBirth, @Password, GETDATE(), 0);

                           COMMIT TRANSACTION; -- Confirma la transacción si no hay errores
                     END
                     ELSE
                     BEGIN
                           -- Error en la validación de Password
                           THROW 50001, 'Error: Password inválido.', 1;
                     END
                  END
                  ELSE
                  BEGIN
                     -- Error en la validación de DateOfBirth
                     THROW 50002, 'Error: El estudiante debe ser mayor de edad.', 1;
                  END
               END
               ELSE
               BEGIN
                  -- Error en la validación de Email
                  THROW 50003, 'Error: Formato de correo inválido.', 1;
               END
         END
         ELSE
         BEGIN
               -- Error en la validación de Nombre o Apellido
               THROW 50004, 'Error: Nombre y apellido deben contener solo letras.', 1;
         END
      END TRY
      BEGIN CATCH
         ROLLBACK TRANSACTION; -- * To avoid to send the error to the client
         THROW;
      END CATCH;
   END;
   GO


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
      --* Verificar si el correo electrónico ya está registrado
      IF EXISTS (SELECT 1 FROM [practica1].[Usuarios] WHERE Email = @Email)
      BEGIN
         THROW 51000, 'El correo electrónico ya está registrado.', 1;
         RETURN;
      END;
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

      --* Enviar un correo electrónico de notificación al estudiante
      DECLARE @EmailSubject nvarchar(max) = 'Registro exitoso en el sistema';
      DECLARE @EmailBody nvarchar(max) = 'Estimado ' + @Firstname + ', su registro como estudiante en el sistema se ha completado correctamente. ¡Bienvenido!';
      
      EXEC msdb.dbo.sp_send_dbmail
         @profile_name = 'socop2412@gmail.com',  --* Nombre del perfil de correo electrónico configurado en SQL Server
         @recipients = @Email,
         @subject = @EmailSubject,
         @body = @EmailBody;
   END;
   
   DECLARE @Firstname nvarchar(max) = 'John';
   DECLARE @Lastname nvarchar(max) = 'Doe';
   DECLARE @Email nvarchar(max) = 'socop2412@gmail.com';
   DECLARE @DateOfBirth datetime2(7) = '1990-01-15';
   DECLARE @Password nvarchar(max) = 'SecurePassword123';
   DECLARE @Credits int = 0;

   EXEC PR1 @Firstname, @Lastname, @Email, @DateOfBirth, @Password, @Credits;
   DELETE FROM [practica1].[Usuarios] WHERE Email = @Email;
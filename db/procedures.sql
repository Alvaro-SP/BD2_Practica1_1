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

      --* Enviar un correo electrónico de notificación al estudiante
      -- DECLARE @EmailSubject nvarchar(max) = 'Registro exitoso en el sistema';
      -- DECLARE @EmailBody nvarchar(max) = 'Estimado ' + @Firstname + ', su registro como estudiante en el sistema se ha completado correctamente. ¡Bienvenido!';
      
      -- EXEC msdb.dbo.sp_send_dbmail
      --    @profile_name = 'socop2412@gmail.com',  --* Nombre del perfil de correo electrónico configurado en SQL Server
      --    @recipients = @Email,
      --    @subject = @EmailSubject,
      --    @body = @EmailBody;
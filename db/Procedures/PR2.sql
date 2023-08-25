
-- ! Procedure 2 "Cambio de Roles "
    USE BD2
    GO
    IF OBJECT_ID('PR2', 'P') IS NOT NULL
    BEGIN
        DROP PROCEDURE PR2;
    END;
    GO
    CREATE PROCEDURE PR2
        @Email nvarchar(max),      --* Correo electrónico del estudiante/tutor
        @CodCourse int             --* Código del curso a asignar como tutor
    AS
    BEGIN
        BEGIN TRANSACTION; -- Start a new transaction

        BEGIN TRY
            --* Verificar si el usuario es un estudiante con cuenta activa
            IF NOT EXISTS (SELECT 1 FROM [practica1].[Usuarios] WHERE Email = @Email AND EmailConfirmed = 1)
            BEGIN
                PRINT 'El usuario no es un estudiante con cuenta activa.';
            END;
            ELSE
                BEGIN
                    -- Obtener el UserId del estudiante/tutor
                    DECLARE @UserId uniqueidentifier;
                    SELECT @UserId = Id FROM [practica1].[Usuarios] WHERE Email = @Email;

                    -- Verificar si el estudiante ya es tutor en el curso
                    IF EXISTS (SELECT 1 FROM [practica1].[CourseTutor] WHERE TutorId = @UserId AND CourseCodCourse = @CodCourse)
                    BEGIN
                        PRINT 'El tutor ya es tutor de ese curso.';
                    END;
                    ELSE
                        BEGIN
                            -- Obtener el RoleId del rol de tutor
                            DECLARE @TutorRoleId uniqueidentifier;
                            SELECT @TutorRoleId = Id FROM [practica1].[Roles] WHERE RoleName = 'Tutor';

                            -- Agregar el rol de tutor al usuario en UsuarioRole
                            INSERT INTO [practica1].[UsuarioRole] (RoleId, UserId, IsLatestVersion)
                            VALUES (@TutorRoleId, @UserId, 1);

                            -- Agregar el perfil de tutor al usuario en TutorProfile
                            INSERT INTO [practica1].[TutorProfile] (UserId, TutorCode)
                            VALUES (@UserId, 'Código de Tutor X');

                            -- Asignar el estudiante como tutor en el curso en CourseTutor
                            INSERT INTO [practica1].[CourseTutor] (TutorId, CourseCodCourse)
                            VALUES (@UserId, @CodCourse);

                            -- Agregar una notificación al usuario
                            INSERT INTO [practica1].[Notification] (UserId, Message, Date)
                            VALUES (@UserId, 'Ha sido promovido al rol de tutor en el curso.', GETDATE());
                        END
                END
        END TRY
    BEGIN CATCH
        ROLLBACK; -- Rollback the transaction in case of an error
        THROW;    -- Re-throw the error
    END CATCH;
    PRINT 'The user was promoted successfully.';
    COMMIT; -- Commit the transaction on successful completion
    END;
    GO




EXEC PR2 'socop241ee2@gmail.com', 772;
DROP PROCEDURE IF EXISTS PR3;
GO
CREATE PROCEDURE PR3
    @Email NVARCHAR(MAX),
    @CodCourse INT
AS
BEGIN
	-- Get the UserId based on the provided email
   DECLARE @UserId UNIQUEIDENTIFIER;
   SELECT @UserId = Id FROM [practica1].[Usuarios] WHERE [Email] = @Email;
	-- Check if the user exists
	IF @UserId IS NOT NULL BEGIN

		-- Check if the student is already assigned to the course
		IF NOT EXISTS (SELECT 1 FROM [practica1].[CourseAssignment] WHERE [StudentId] = @UserId AND [CourseCodCourse] = @CodCourse) BEGIN

			-- Get the credits required for the course
            DECLARE @CreditsRequired INT;
            SELECT @CreditsRequired = [CreditsRequired] FROM [practica1].[Course] WHERE [CodCourse] = @CodCourse;

            -- Get the student's credits
            DECLARE @StudentCredits INT;
            SELECT @StudentCredits = [Credits] FROM [practica1].[ProfileStudent] WHERE [UserId] = @UserId;

			-- Check if the student has enough credits
            IF @StudentCredits >= @CreditsRequired BEGIN
				BEGIN TRANSACTION;

				BEGIN TRY

					-- Insert course assignment
                    INSERT INTO [practica1].[CourseAssignment] ([StudentId], [CourseCodCourse])
                    VALUES (@UserId, @CodCourse);
					COMMIT;

				END TRY BEGIN CATCH
					ROLLBACK;
					PRINT 'Error al asignar el estudiante al curso';
				END CATCH;

			END ELSE BEGIN
				PRINT 'El estudiante no tiene suficientes créditos para asignar este curso.';
			END
		END ELSE BEGIN
			PRINT 'El estudiante ya está asignado a este curso.';
		END
	END ELSE BEGIN
		PRINT 'El correo ingresado no corresponde a ningún usuario.';
   END
END;

GO
EXEC PR3 'sergiearizandieta@gmail.com',1;

-- inicializanido datos

-- INSERT INTO [practica1].[Usuarios] ([Id], [Firstname], [Lastname], [Email], [DateOfBirth], [Password], [LastChanges], [EmailConfirmed])
-- VALUES (NEWID(), 'Sergie', 'Arizandieta', 'sergiearizandieta@gmail.com', '2022-05-22', 'Serch132@', GETDATE(), 1);

-- SELECT * FROM [practica1].[Usuarios];

-- INSERT INTO [practica1].[ProfileStudent] ([UserId], [Credits])
-- VALUES ('8BFE0823-0E7C-4D9E-B0BB-B46886D67641', 0);

-- SELECT * FROM [practica1].[ProfileStudent];

-- SELECT * FROM [practica1].[Roles];

-- INSERT INTO [practica1].[UsuarioRole] ([RoleId], [UserId], [IsLatestVersion])
-- VALUES ('F4E6D8FB-DF45-4C91-9794-38E043FD5ACD', '8BFE0823-0E7C-4D9E-B0BB-B46886D67641', 1);

-- SELECT * FROM [practica1].[UsuarioRole];
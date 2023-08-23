DROP PROCEDURE IF EXISTS PR5;
GO
CREATE PROCEDURE PR5
    @CourseCode INT,
    @Name NVARCHAR(MAX),
    @CreditsRequired INT
AS
BEGIN
    -- Verify if @CourseCode is a valid number
    IF ISNUMERIC(@CourseCode) = 1
    BEGIN
        -- Verify if @CreditsRequired is a valid number
        IF ISNUMERIC(@CreditsRequired) = 1
        BEGIN
            -- Verify if the course name is valid
            IF @Name IS NOT NULL AND @Name <> '' AND @Name LIKE '[A-Za-z][_A-Za-z0-9 ]%'
            BEGIN
                -- Verify if the course name not exists
                IF NOT EXISTS (SELECT 1 FROM [practica1].[Course] WHERE [Name] = @Name)
                BEGIN
                    -- Begin transaction
                    BEGIN TRANSACTION;
                    -- Insert the new course
                    BEGIN TRY
                        INSERT INTO [practica1].[Course] ([CodCourse], [Name], [CreditsRequired])
                        VALUES (@CourseCode, @Name, @CreditsRequired);
                        -- Confirm the transaction
                        COMMIT;
                        PRINT 'The course was created successfully.';
                    END TRY
                    BEGIN CATCH
                        -- If an error occurs, rollback the transaction
                        ROLLBACK;
                        PRINT 'Error during course insertion, try again later';
                    END CATCH;
                END
                ELSE
                BEGIN
                    PRINT 'The course already exists, try with another course';
                END
            END
            ELSE
            BEGIN
                PRINT 'The course name is not valid';
            END
        END
        ELSE
        BEGIN
            PRINT 'Invalid @CreditsRequired value. Please provide a valid number.';
        END
    END
    ELSE
    BEGIN
        PRINT 'Invalid @CourseCode value. Please provide a valid number.';
    END
END;

-- Example of execution
EXEC PR5 1,'Idioma Técnico 1',10;
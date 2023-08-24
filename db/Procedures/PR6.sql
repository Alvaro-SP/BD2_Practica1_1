DROP PROCEDURE IF EXISTS PR6;
GO
CREATE PROCEDURE PR6
AS
BEGIN
    -- Begin transaction
    BEGIN TRANSACTION;
    -- Update invalid courses in the "Course" table
    BEGIN TRY
        -- Update course names
        UPDATE [practica1].[Course]
        SET
            [Name] = 'Nombre Corregido'
        WHERE
            [Name] IS NULL OR [Name] = '' OR [Name] NOT LIKE '[A-Za-z][_A-Za-z0-9 ]%';
        -- Update course credit requirements
        UPDATE [practica1].[Course]
        SET
            [CreditsRequired] = 0 -- Set a valid value
        WHERE
            ISNUMERIC([CreditsRequired]) = 0;
        -- Confirm the transaction
        COMMIT;
        PRINT 'Invalid course data has been updated successfully.';
    END TRY
    BEGIN CATCH
        -- If an error occurs, rollback the transaction
        ROLLBACK;
        PRINT 'Error during update process, try again later';
    END CATCH;
    -- Begin another transaction for updating user data
    BEGIN TRANSACTION;
    -- Update invalid users in the "Usuarios" table
    BEGIN TRY
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
        -- Confirm the transaction
        COMMIT;
        PRINT 'Invalid user data has been updated successfully.';
    END TRY
    BEGIN CATCH
        -- If an error occurs, rollback the transaction
        ROLLBACK;
        PRINT 'Error during update process, try again later';
    END CATCH;
END;

-- Example of execution
EXEC PR6;
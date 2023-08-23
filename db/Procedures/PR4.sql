DROP PROCEDURE IF EXISTS PR4;
GO
CREATE PROCEDURE PR4
    @RoleName NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Verificar si el RoleName es válido
    IF @RoleName IS NOT NULL AND @RoleName <> '' AND @RoleName LIKE '[A-Za-z][_A-Za-z0-9 ]%'
    BEGIN
        -- Verificar si el RoleName ya existe
        IF NOT EXISTS (SELECT 1 FROM [practica1].[Roles] WHERE [RoleName] = @RoleName)
        BEGIN
            -- Iniciar la transacción
            BEGIN TRANSACTION;

            -- Intentar insertar el nuevo RoleName en la tabla Roles
            BEGIN TRY
                INSERT INTO [practica1].[Roles] ([Id], [RoleName])
                VALUES (NEWID(), @RoleName);

                -- Confirmar la transacción
                COMMIT;
                PRINT 'El nuevo rol se ha insertado correctamente.';
            END TRY
            BEGIN CATCH
                -- Si ocurre un error, deshacer la transacción
                ROLLBACK;
                PRINT 'Error al insertar el nuevo rol.';
            END CATCH;
        END
        ELSE
        BEGIN
            PRINT 'El nombre del rol ya existe.';
        END
    END
    ELSE
    BEGIN
        PRINT 'El nombre del rol no es válido.';
    END
END;
GO
EXEC PR4 'NuevoRol 2';

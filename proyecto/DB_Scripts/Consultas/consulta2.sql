
--! ------------------ CONSULTA 2------------------
-- Stored procedure que reciba un parámetro alfanumérico para buscar juegos por nombre (palabras o aproximaciones). 

  DROP PROCEDURE IF EXISTS c2;
GO
CREATE PROCEDURE c2
    @palabraBusqueda VARCHAR(100)
AS
BEGIN
    -- Validar que la palabra de búsqueda no sea vacía
    IF LEN(@palabraBusqueda) = 0
    BEGIN
        PRINT 'La palabra de búsqueda no puede estar vacía';
        RETURN;
    END

    -- Validar que @palabraBusqueda tenga más de 4 caracteres
    IF LEN(@palabraBusqueda) < 4
    BEGIN
        -- Buscar coincidencias en cada palabra de name que tenga más de 4 caracteres
        SELECT DISTINCT name
            ,alternative_names
            ,(SELECT dbo.obtenerGeneros([genres])) as Generos
            ,ROUND([rating], 2)
            ,summary
            ,url
        FROM [PROYECTO_CLASE].[dbo].[games]
        CROSS APPLY STRING_SPLIT(name, ' ') AS Words
        WHERE LEN(Words.value) > 4
        AND CHARINDEX(@palabraBusqueda, Words.value) > 0;
    END
    ELSE
    BEGIN
        -- Buscar coincidencias en cada palabra de name que tenga más de 4 caracteres
        SELECT DISTINCT name
            ,alternative_names
            ,(SELECT dbo.obtenerGeneros([genres])) as Generos
            ,ROUND([rating], 2) as rating
            ,summary
            ,url
        FROM [PROYECTO_CLASE].[dbo].[games]
        WHERE  CHARINDEX(@palabraBusqueda, name) > 0;
    END
END;

EXEC c2 'legend of zelda' 

--

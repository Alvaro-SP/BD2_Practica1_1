
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

    -- Buscar coincidencias en cada palabra de name que tenga más de 4 caracteres
    SELECT DISTINCT name
		,alternative_names
        ,(SELECT dbo.obtenerGeneros([genres])) as Generos
		,rating
		,summary
        ,url
    FROM [PROYECTO_CLASE].[dbo].[games]
    CROSS APPLY STRING_SPLIT(name, ' ') AS Words
    WHERE LEN(Words.value) > 4
      AND CHARINDEX(@palabraBusqueda, Words.value) > 0;
END;

EXEC c2 'zelda' 

--

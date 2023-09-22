
--! ------------------ CONSULTA 3------------------
-- Stored procedure que reciba un parámetro el juego, que busque y muestre la información y agrupe por plataforma.

DROP PROCEDURE IF EXISTS c3;
GO
CREATE PROCEDURE c3
    @palabraBusqueda VARCHAR(100)
AS
BEGIN
    -- Validar que la palabra de búsqueda no sea vacía
    IF LEN(@palabraBusqueda) = 0
    BEGIN
        PRINT 'La palabra de búsqueda no puede estar vacía';
        RETURN;
    END

    -- Declarar variables para los atributos de plataforma
    DECLARE @platformID INT;
    DECLARE @abbreviation NVARCHAR(255);
    DECLARE @alternativeName NVARCHAR(255);
    DECLARE @category INT;
    DECLARE @name NVARCHAR(MAX);
    DECLARE @summary NVARCHAR(MAX);
    DECLARE @url NVARCHAR(MAX);

    -- Declarar un cursor para iterar a través de los juegos
    DECLARE gameCursor CURSOR FOR
    SELECT G.id, G.name, G.rating, G.url, G.platforms
    FROM [PROYECTO_CLASE].[dbo].[games] G
    WHERE CHARINDEX(@palabraBusqueda, G.name) > 0;

    -- Variables para almacenar los valores del juego actual
    DECLARE @gameID INT;
    DECLARE @gameName NVARCHAR(255);
    DECLARE @gameRating FLOAT;
    DECLARE @genres NVARCHAR(MAX);
    DECLARE @gameURL NVARCHAR(MAX);
    DECLARE @gamePlatforms NVARCHAR(MAX);

    -- Abrir el cursor
    OPEN gameCursor;

    -- Iniciar el bucle para recorrer los juegos
    FETCH NEXT FROM gameCursor INTO @gameID, @gameName, @gameRating, @gameURL, @gamePlatforms;

    -- Bucle para procesar cada juego
    WHILE @@FETCH_STATUS = 0
    BEGIN
		PRINT '------------------------------------------------------'
        -- Mostrar los atributos del juego actual
        PRINT @gameID;
        PRINT @gameName;
        PRINT @gameRating;
        PRINT @gameURL;
		
        -- Separar los IDs de plataforma y recorrerlos
        DECLARE platformCursor CURSOR FOR
        SELECT Numero FROM dbo.ParseNumbersFromText(@gamePlatforms);

        -- Iniciar el bucle para recorrer las plataformas
        OPEN platformCursor;

        -- Bucle para procesar cada plataforma del juego actual
        FETCH NEXT FROM platformCursor INTO @platformID;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            -- Obtener atributos de la plataforma actual
            SELECT @abbreviation = abbreviation, @alternativeName = alternative_name, @category = category, @name = name, @summary = summary, @url = url
            FROM [PROYECTO_CLASE].[dbo].[platforms]
            WHERE id = @platformID;

            -- Mostrar los atributos de la plataforma actual
            PRINT 'PLATAFORMA --> '+ 'id: ' + CAST(@platformID AS NVARCHAR(MAX));
			PRINT 'name: ' + @name;
            PRINT 'abbreviation: ' + @abbreviation;
            PRINT 'alternative_name: ' + @alternativeName;
            PRINT 'category: ' + CAST(@category AS NVARCHAR(MAX));
			PRINT 'summary:' + CAST(@summary AS NVARCHAR(MAX));
			PRINT 'url: ' + @url;

            FETCH NEXT FROM platformCursor INTO @platformID;
        END;

        -- Cerrar el cursor de plataformas
        CLOSE platformCursor;
        DEALLOCATE platformCursor;

        -- Obtener el siguiente juego
        FETCH NEXT FROM gameCursor INTO @gameID, @gameName, @gameRating, @gameURL, @gamePlatforms;
    END;

    -- Cerrar el cursor de juegos
    CLOSE gameCursor;
    DEALLOCATE gameCursor;
END;
EXEC c3 'Mario';

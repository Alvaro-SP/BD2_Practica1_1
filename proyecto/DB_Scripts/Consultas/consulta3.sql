
--! ------------------ CONSULTA 3 FORMA VISTA------------------
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
    -- DECLARE gameCursor CURSOR FOR
    -- SELECT G.id, G.name, G.rating, G.url, G.platforms
    -- FROM [PROYECTO_CLASE].[dbo].[games] G
    -- WHERE CHARINDEX(@palabraBusqueda, G.name) > 0;
    
    

    
    IF LEN(@palabraBusqueda) < 4
    BEGIN
        -- Declarar un cursor para iterar a través de los juegos
        DECLARE gameCursor CURSOR FOR
        SELECT G.id, G.name, G.rating, G.url, G.platforms, G.summary
        FROM [PROYECTO_CLASE].[dbo].[games] G
        CROSS APPLY STRING_SPLIT(name, ' ') AS Words  --separar por palabras
        WHERE LEN(Words.value) > 4 --palabras de mas de 4 letras
        AND CHARINDEX(@palabraBusqueda, Words.value) > 0; --buscar coincidencias
    END
    ELSE
    BEGIN
        -- Buscar coincidencias en cada palabra de name que tenga más de 4 caracteres
        -- Declarar un cursor para iterar a través de los juegos
        DECLARE gameCursor CURSOR FOR
        SELECT G.id, G.name, G.rating, G.url, G.platforms, G.summary
        FROM [PROYECTO_CLASE].[dbo].[games] G
        WHERE  CHARINDEX(@palabraBusqueda, name) > 0;
    END

    -- Variables para almacenar los valores del juego actual
    DECLARE @gameID INT;
    DECLARE @gameName NVARCHAR(255);
    DECLARE @gameRating FLOAT;
    DECLARE @genres NVARCHAR(MAX);
    DECLARE @gameURL NVARCHAR(MAX);
    DECLARE @summaryGame NVARCHAR(MAX);
    DECLARE @gamePlatforms NVARCHAR(MAX);

    -- Abrir el cursor
    OPEN gameCursor;

    -- Iniciar el bucle para recorrer los juegos
    FETCH NEXT FROM gameCursor INTO @gameID, @gameName, @gameRating, @gameURL, @gamePlatforms, @summaryGame;

    -- Bucle para procesar cada juego
    WHILE @@FETCH_STATUS = 0
    BEGIN
		PRINT '--------------- ID: '+ CAST(@gameID AS NVARCHAR(MAX))+'        Nombre: '+@gameName+' -------------------'
        -- Mostrar los atributos del juego actual
        -- PRINT @gameID;
        -- PRINT @gameName;
        PRINT '    Puntuacion:  '+ CAST(@gameRating AS NVARCHAR(MAX))+'               URL: '+@gameURL;
        PRINT '    Summary:     '+ CAST(@summaryGame AS NVARCHAR(MAX));
        print '';
        -- PRINT @gameURL;
		
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
            PRINT '     PLATAFORMA ---> '+ 'id: ' + CAST(@platformID AS NVARCHAR(MAX))+ '      ---->    name:  ' + @name
			PRINT '         | abbreviation: ' + @abbreviation+'     |'+'      abbreviation: ' + @abbreviation;
            PRINT '         | alternative_name: ' + @alternativeName+'     | category:     ' + CAST(@category AS NVARCHAR(MAX));
            PRINT '         | url: ' + @url;
			PRINT '         | summary:      ' + CAST(@summary AS NVARCHAR(MAX));
            PRINT '';

            FETCH NEXT FROM platformCursor INTO @platformID;
        END;
        PRINT '';
        -- Cerrar el cursor de plataformas
        CLOSE platformCursor;
        DEALLOCATE platformCursor;

        -- Obtener el siguiente juego
        FETCH NEXT FROM gameCursor INTO @gameID, @gameName, @gameRating, @gameURL, @gamePlatforms, @summaryGame;
    END;

    -- Cerrar el cursor de juegos
    CLOSE gameCursor;
    DEALLOCATE gameCursor;
END;
EXEC c3 'Mario';
--! ------------------ CONSULTA 3------------------
GO
DROP PROCEDURE IF EXISTS c3xtra;
GO
CREATE PROCEDURE c3xtra
    @palabraBusqueda VARCHAR(100)
AS
BEGIN
    -- Validar que la palabra de búsqueda no sea vacía
    IF LEN(@palabraBusqueda) = 0
    BEGIN
        PRINT 'La palabra de búsqueda no puede estar vacía';
        RETURN;
    END

    -- Crear una tabla temporal para almacenar los resultados
    CREATE TABLE #Resultados (
        GameID INT,
        GameName NVARCHAR(255),
        GameRating FLOAT,
        PlatformID INT,
        PlatformName NVARCHAR(MAX),
        PlatformAbbreviation NVARCHAR(255),
        PlatformAlternativeName NVARCHAR(255),
        PlatformCategory INT,
        PlatformSummary NVARCHAR(MAX),
        PlatformURL NVARCHAR(MAX)
    );

    IF LEN(@palabraBusqueda) < 4
    BEGIN
        -- Declarar un cursor para iterar a través de los juegos
        DECLARE gameCursor CURSOR FOR
        SELECT G.id, G.name, G.rating, P.Numero
        FROM [PROYECTO_CLASE].[dbo].[games] G
        CROSS APPLY STRING_SPLIT(name, ' ') AS Words  --separar por palabras
        CROSS APPLY dbo.ParseNumbersFromText(G.platforms) P
        WHERE LEN(Words.value) > 4 --palabras de mas de 4 letras
        AND CHARINDEX(@palabraBusqueda, Words.value) > 0; --buscar coincidencias
    END
    ELSE
    BEGIN
        -- Buscar coincidencias en cada palabra de name que tenga más de 4 caracteres
        -- Declarar un cursor para iterar a través de los juegos
        DECLARE gameCursor CURSOR FOR
        SELECT G.id, G.name, G.rating, P.Numero
        FROM [PROYECTO_CLASE].[dbo].[games] G
        CROSS APPLY dbo.ParseNumbersFromText(G.platforms) P
        WHERE  CHARINDEX(@palabraBusqueda, name) > 0;
    END

    -- Variables para almacenar los valores del juego actual
    DECLARE @gameID INT;
    DECLARE @gameName NVARCHAR(255);
    DECLARE @gameRating FLOAT;
    DECLARE @platformID INT;

    -- Abrir el cursor
    OPEN gameCursor;

    -- Iniciar el bucle para recorrer los juegos
    FETCH NEXT FROM gameCursor INTO @gameID, @gameName, @gameRating, @platformID;

    -- Bucle para procesar cada juego
    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Obtener atributos de la plataforma actual
        DECLARE @abbreviation NVARCHAR(255);
        DECLARE @alternativeName NVARCHAR(255);
        DECLARE @category INT;
        DECLARE @name NVARCHAR(MAX);
        DECLARE @summary NVARCHAR(MAX);
        DECLARE @url NVARCHAR(MAX);

        SELECT @abbreviation = abbreviation, @alternativeName = alternative_name, @category = category, @name = name, @summary = summary, @url = url
        FROM [PROYECTO_CLASE].[dbo].[platforms]
        WHERE id = @platformID;

        -- Insertar los datos en la tabla temporal
        INSERT INTO #Resultados (GameID, GameName, GameRating, PlatformID, PlatformName, PlatformAbbreviation, PlatformAlternativeName, PlatformCategory, PlatformSummary, PlatformURL)
        VALUES (@gameID, @gameName, @gameRating, @platformID, @name, @abbreviation, @alternativeName, @category, @summary, @url);

        -- Obtener el siguiente juego
        FETCH NEXT FROM gameCursor INTO @gameID, @gameName, @gameRating, @platformID;
    END;

    -- Cerrar el cursor de juegos
    CLOSE gameCursor;
    DEALLOCATE gameCursor;

    -- Seleccionar los datos de la tabla temporal
    SELECT *
    FROM #Resultados;

    -- Eliminar la tabla temporal
    DROP TABLE #Resultados;
END;
GO
EXEC c3xtra 'Mario';
--! ------------------ CONSULTA 1------------------
-- Vista que muestre el top 100 de los juegos evaluado por Rating o valoración según el sitio web. (nombre, plataforma, rating, genero) 

DROP FUNCTION IF EXISTS obtenerGeneros;
GO
CREATE FUNCTION dbo.obtenerGeneros
(
    @idList NVARCHAR(MAX)
)
RETURNS NVARCHAR(MAX)
AS
BEGIN
	DECLARE @genreNames NVARCHAR(MAX) = '';
	
	IF @idList IS NULL
		BEGIN
			RETURN 'Sin informacion';
		END
	ELSE
	BEGIN
		DECLARE @idArray NVARCHAR(MAX) = '';
		-- Eliminar los corchetes "[" y "]" del arreglo
		SET @idArray = REPLACE(REPLACE(@idList, '[', ''), ']', '');

		-- Consulta para obtener los nombres de géneros basados en la lista de IDs
		SELECT @genreNames = @genreNames + name + ', '
		FROM [PROYECTO_CLASE].[dbo].[genres]
		WHERE CHARINDEX(CAST(Id AS NVARCHAR(MAX)), @idArray + ',') > 0;

		-- Eliminar la coma adicional al final
		SET @genreNames = LEFT(@genreNames, LEN(@genreNames) - 1);

	END
	RETURN @genreNames;
END;
GO
DROP FUNCTION IF EXISTS obtenerPlataformas;
GO
CREATE FUNCTION dbo.obtenerPlataformas
(
    @idList NVARCHAR(MAX)
)
RETURNS NVARCHAR(MAX)
AS
BEGIN
	DECLARE @genreNames NVARCHAR(MAX) = '';
	
	IF @idList IS NULL
		BEGIN
			RETURN 'Sin informacion';
		END
	ELSE
	BEGIN
		DECLARE @idArray NVARCHAR(MAX) = '';
		-- Eliminar los corchetes "[" y "]" del arreglo
		SET @idArray = REPLACE(REPLACE(@idList, '[', ''), ']', '');

		-- Consulta para obtener los nombres de géneros basados en la lista de IDs
		SELECT @genreNames = @genreNames + name + ', '
		FROM [PROYECTO_CLASE].[dbo].[platforms]
		WHERE CHARINDEX(CAST(Id AS NVARCHAR(MAX)), @idArray + ',') > 0;

		-- Eliminar la coma adicional al final
		SET @genreNames = LEFT(@genreNames, LEN(@genreNames) - 1);

	END
	RETURN @genreNames;
END;

GO
DROP VIEW IF EXISTS consulta1;
GO
CREATE VIEW consulta1
AS

SELECT TOP (100) [id]
	  ,[name]
      ,[rating]
	  ,[aggregated_rating]
      ,(SELECT dbo.obtenerGeneros([genres])) as Generos     
      ,(SELECT dbo.obtenerPlataformas([platforms])) as Plataformas  
	  ,url
  FROM [PROYECTO_CLASE].[dbo].[games]
  ORDER BY [rating] DESC

 GO
 SELECT * FROM consulta1;
 GO

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

--! ------------------ CONSULTA 4------------------
-- Vista que muestre el top 100 de juegos que soporten más idiomas (subtítulos y audio) ordenados por rating, nombre y que idiomas soportan.
SELECT TOP (100) [id]
    ,[name]
    ,[rating]
    ,[aggregated_rating]
    ,[genres]
    ,[platforms]
    ,url
FROM [PROYECTO_CLASE].[dbo].[games]
ORDER BY [rating] DESC


--! ------------------ CONSULTA 5------------------
-- Consulta que muestre el top los juegos por genero, ordenados por rating
DROP PROCEDURE IF EXISTS c5;
GO
CREATE PROCEDURE c5
AS
BEGIN
    SELECT TOP (1000) [id]
        ,[name]
        ,[rating]
        ,(SELECT dbo.obtenerGeneros([genres])) as Generos
        ,[aggregated_rating]
        ,[platforms]
        ,url
    FROM [PROYECTO_CLASE].[dbo].[games]
    ORDER BY [rating] DESC

END;
GO


--! ------------------ FUNCION OBTENER LOS IDS ------------------

GO
CREATE FUNCTION dbo.ParseNumbersFromText(@inputText NVARCHAR(MAX))
RETURNS TABLE
AS
RETURN
(
    SELECT CAST(value AS INT) AS Numero
    FROM STRING_SPLIT(REPLACE(REPLACE(@inputText, '[', ''), ']', ''), ',')
);

GO

CREATE FUNCTION dbo.obtenerGeneros
(
    @idList NVARCHAR(MAX)
)
RETURNS NVARCHAR(MAX)
AS
BEGIN
    DECLARE @genreNames NVARCHAR(MAX) = '';
    -- Eliminar los corchetes "[" y "]" del arreglo
    SET @idArray = REPLACE(REPLACE(@idList, '[', ''), ']', '');

    -- Consulta para obtener los nombres de géneros basados en la lista de IDs
    SELECT @genreNames = @genreNames + name + ', '
    FROM [PROYECTO_CLASE].[dbo].[genres]
    WHERE CHARINDEX(CAST(Id AS NVARCHAR(MAX)), @idList + ',') > 0;

    -- Eliminar la coma adicional al final
    SET @genreNames = LEFT(@genreNames, LEN(@genreNames) - 1);

    RETURN @genreNames;
END;
























CREATE TABLE TablaTexto (
    Texto NVARCHAR(MAX) -- Utiliza NVARCHAR(MAX) para permitir una gran cantidad de texto
);

-- Crear una tabla para el número
CREATE TABLE TablaNumero (
    Numero INT -- Puedes ajustar el tipo de dato según tus necesidades
);


INSERT INTO TablaTexto (Texto)
VALUES ('[1,2,3,4,5,6,7]');


SELECT Texto FROM TablaTexto;


GO
CREATE FUNCTION dbo.ParseNumbersFromText(@inputText NVARCHAR(MAX))
RETURNS TABLE
AS
RETURN
(
    SELECT CAST(value AS INT) AS Numero
    FROM STRING_SPLIT(REPLACE(REPLACE(@inputText, '[', ''), ']', ''), ',')
);

GO
INSERT INTO TablaNumero (Numero)
SELECT Numero
FROM TablaTexto
CROSS APPLY dbo.ParseNumbersFromText(Texto);

SELECT Numero FROM TablaNumero;

















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

    -- Declarar un cursor para iterar a través de los juegos
    DECLARE gameCursor CURSOR FOR
    SELECT G.id, G.name, G.rating, G.url, G.platforms
    FROM [PROYECTO_CLASE].[dbo].[games] G
    WHERE CHARINDEX(@palabraBusqueda, G.name) > 0;

    -- Variables para almacenar los valores del juego actual
    DECLARE @gameID INT;
    DECLARE @gameName NVARCHAR(255);
    DECLARE @gameRating FLOAT;
    DECLARE @gameURL NVARCHAR(MAX);
    DECLARE @gamePlatforms NVARCHAR(MAX);

    -- Abrir el cursor
    OPEN gameCursor;

    -- Iniciar el bucle para recorrer los juegos
    FETCH NEXT FROM gameCursor INTO @gameID, @gameName, @gameRating, @gameURL, @gamePlatforms;

    -- Bucle para procesar cada juego
    WHILE @@FETCH_STATUS = 0
    BEGIN
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
            SELECT @abbreviation = abbreviation, @alternativeName = alternative_name, @category = category
            FROM [PROYECTO_CLASE].[dbo].[platforms]
            WHERE id = @platformID;

            -- Mostrar los atributos de la plataforma actual
            PRINT 'PLATFORMS';
            PRINT 'id: ' + CAST(@platformID AS NVARCHAR(MAX));
            PRINT 'abbreviation: ' + @abbreviation;
            PRINT 'alternative_name: ' + @alternativeName;
            PRINT 'category: ' + CAST(@category AS NVARCHAR(MAX));

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

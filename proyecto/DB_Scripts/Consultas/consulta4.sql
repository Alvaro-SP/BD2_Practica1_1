-------------------------------------- Funciones utilizadas para esta consulta---------------------------------------

-- Función que en base a un arrays de ids de language_supports, devuelve los lenguajes soportados
DROP FUNCTION IF EXISTS obtenerLenguajesSoportadosPorUnJuego;
CREATE FUNCTION dbo.obtenerLenguajesSoportadosPorUnJuego
(
    @idList NVARCHAR(MAX)
)
RETURNS NVARCHAR(MAX)
AS
BEGIN
    DECLARE @languagesNames NVARCHAR(MAX) = '';
    IF @idList IS NULL
    BEGIN
        RETURN 'Sin información';
    END
    ELSE
    BEGIN
        -- Eliminar corchetes si están presentes
        SET @idList = REPLACE(@idList, '[', '');
        SET @idList = REPLACE(@idList, ']', '');
        -- Comprobar si la lista contiene solo un valor
        IF CHARINDEX(',', @idList) = 0
        BEGIN
            -- Consulta para obtener el nombre del lenguaje
            SELECT @languagesNames = l.name
            FROM [PROYECTO_CLASE].[dbo].[language_supports] ls 
            INNER JOIN [PROYECTO_CLASE].[dbo].[languages] l ON ls.language = l.id
            WHERE ls.id = CAST(@idList AS INT);
        END
        ELSE
        BEGIN
            -- Crear una tabla temporal para almacenar los IDs de la lista
            DECLARE @idTable TABLE (id INT);
            DECLARE @separator NVARCHAR(1) = ',';
            DECLARE @start INT, @end INT, @value NVARCHAR(MAX);
            -- Dividir la lista de IDs y almacenarlos en la tabla temporal
            SET @start = 1;
            SET @end = CHARINDEX(@separator, @idList);
            WHILE @end > 0
            BEGIN
                SET @value = SUBSTRING(@idList, @start, @end - @start);
                INSERT INTO @idTable (id) VALUES (CAST(@value AS INT));
                SET @start = @end + 1;
                SET @end = CHARINDEX(@separator, @idList, @start);
            END
            SET @value = SUBSTRING(@idList, @start, LEN(@idList) - @start + 1);
            INSERT INTO @idTable (id) VALUES (CAST(@value AS INT));
            -- Consulta para obtener los nombres de lenguajes basados en la lista de IDs
            SELECT @languagesNames = @languagesNames + l.name + ', '
            FROM [PROYECTO_CLASE].[dbo].[language_supports] ls 
            INNER JOIN [PROYECTO_CLASE].[dbo].[languages] l ON ls.language = l.id
            WHERE ls.id IN (SELECT id FROM @idTable);
            -- Eliminar la coma adicional al final
            SET @languagesNames = LEFT(@languagesNames, LEN(@languagesNames) - 1);
        END
    END
    RETURN @languagesNames;
END;

--- Función que devuelve la cantidad de lenguajes soportados de tipo "Audio" que tiene el juego
DROP FUNCTION IF EXISTS obtenerContadorDeLenguajesDeTipoAudioPorJuego;
CREATE FUNCTION dbo.obtenerContadorDeLenguajesDeTipoAudioPorJuego
(
    @idList NVARCHAR(MAX)
)
RETURNS INT
AS
BEGIN
    DECLARE @totalRegistros INT = 0;

    IF @idList IS NULL
    BEGIN
        RETURN 0; -- Devuelve 0 si la lista está vacía
    END
    ELSE
    BEGIN
        -- Eliminar corchetes si están presentes
        SET @idList = REPLACE(@idList, '[', '');
        SET @idList = REPLACE(@idList, ']', '');

        -- Comprobar si la lista contiene solo un valor
        IF CHARINDEX(',', @idList) = 0
        BEGIN
            -- Consulta para obtener el total de registros con status "1"
            SELECT @totalRegistros = COUNT(*)
            FROM [PROYECTO_CLASE].[dbo].[language_supports]
            WHERE id = CAST(@idList AS INT) AND language_support_type = 1;
        END
        ELSE
        BEGIN
            -- Crear una tabla temporal para almacenar los IDs de la lista
            DECLARE @idTable TABLE (id INT);
            DECLARE @separator NVARCHAR(1) = ',';
            DECLARE @start INT, @end INT, @value NVARCHAR(MAX);

            -- Dividir la lista de IDs y almacenarlos en la tabla temporal
            SET @start = 1;
            SET @end = CHARINDEX(@separator, @idList);

            WHILE @end > 0
            BEGIN
                SET @value = SUBSTRING(@idList, @start, @end - @start);
                INSERT INTO @idTable (id) VALUES (CAST(@value AS INT));
                SET @start = @end + 1;
                SET @end = CHARINDEX(@separator, @idList, @start);
            END

            SET @value = SUBSTRING(@idList, @start, LEN(@idList) - @start + 1);
            INSERT INTO @idTable (id) VALUES (CAST(@value AS INT));

            -- Consulta para obtener el total de registros con status "1" para los IDs en la lista
            SELECT @totalRegistros = COUNT(*)
            FROM [PROYECTO_CLASE].[dbo].[language_supports]
            WHERE id IN (SELECT id FROM @idTable) AND language_support_type  = 1;
        END
    END

    RETURN @totalRegistros;
END;


--- Función que devuelve la cantidad de lenguajes soportados de tipo "Subtitulo" que tiene el juego
DROP FUNCTION IF EXISTS obtenerContadorDeLenguajesDeTipoSubtituloPorJuego;
CREATE FUNCTION dbo.obtenerContadorDeLenguajesDeTipoSubtituloPorJuego
(
    @idList NVARCHAR(MAX)
)
RETURNS INT
AS
BEGIN
    DECLARE @totalRegistros INT = 0;

    IF @idList IS NULL
    BEGIN
        RETURN 0; -- Devuelve 0 si la lista está vacía
    END
    ELSE
    BEGIN
        -- Eliminar corchetes si están presentes
        SET @idList = REPLACE(@idList, '[', '');
        SET @idList = REPLACE(@idList, ']', '');

        -- Comprobar si la lista contiene solo un valor
        IF CHARINDEX(',', @idList) = 0
        BEGIN
            -- Consulta para obtener el total de registros con status "2"
            SELECT @totalRegistros = COUNT(*)
            FROM [PROYECTO_CLASE].[dbo].[language_supports]
            WHERE id = CAST(@idList AS INT) AND language_support_type = 2;
        END
        ELSE
        BEGIN
            -- Crear una tabla temporal para almacenar los IDs de la lista
            DECLARE @idTable TABLE (id INT);
            DECLARE @separator NVARCHAR(1) = ',';
            DECLARE @start INT, @end INT, @value NVARCHAR(MAX);

            -- Dividir la lista de IDs y almacenarlos en la tabla temporal
            SET @start = 1;
            SET @end = CHARINDEX(@separator, @idList);

            WHILE @end > 0
            BEGIN
                SET @value = SUBSTRING(@idList, @start, @end - @start);
                INSERT INTO @idTable (id) VALUES (CAST(@value AS INT));
                SET @start = @end + 1;
                SET @end = CHARINDEX(@separator, @idList, @start);
            END

            SET @value = SUBSTRING(@idList, @start, LEN(@idList) - @start + 1);
            INSERT INTO @idTable (id) VALUES (CAST(@value AS INT));

            -- Consulta para obtener el total de registros con status "2" para los IDs en la lista
            SELECT @totalRegistros = COUNT(*)
            FROM [PROYECTO_CLASE].[dbo].[language_supports]
            WHERE id IN (SELECT id FROM @idTable) AND language_support_type  = 2;
        END
    END

    RETURN @totalRegistros;
END;


--- Función que devuelve la cantidad de lenguajes soportados de tipo "Interfaz" que tiene el juego
DROP FUNCTION IF EXISTS obtenerContadorDeLenguajesDeTipoInterfazPorJuego;
CREATE FUNCTION dbo.obtenerContadorDeLenguajesDeTipoInterfazPorJuego
(
    @idList NVARCHAR(MAX)
)
RETURNS INT
AS
BEGIN
    DECLARE @totalRegistros INT = 0;

    IF @idList IS NULL
    BEGIN
        RETURN 0; -- Devuelve 0 si la lista está vacía
    END
    ELSE
    BEGIN
        -- Eliminar corchetes si están presentes
        SET @idList = REPLACE(@idList, '[', '');
        SET @idList = REPLACE(@idList, ']', '');

        -- Comprobar si la lista contiene solo un valor
        IF CHARINDEX(',', @idList) = 0
        BEGIN
            -- Consulta para obtener el total de registros con status "3"
            SELECT @totalRegistros = COUNT(*)
            FROM [PROYECTO_CLASE].[dbo].[language_supports]
            WHERE id = CAST(@idList AS INT) AND language_support_type = 3;
        END
        ELSE
        BEGIN
            -- Crear una tabla temporal para almacenar los IDs de la lista
            DECLARE @idTable TABLE (id INT);
            DECLARE @separator NVARCHAR(1) = ',';
            DECLARE @start INT, @end INT, @value NVARCHAR(MAX);

            -- Dividir la lista de IDs y almacenarlos en la tabla temporal
            SET @start = 1;
            SET @end = CHARINDEX(@separator, @idList);

            WHILE @end > 0
            BEGIN
                SET @value = SUBSTRING(@idList, @start, @end - @start);
                INSERT INTO @idTable (id) VALUES (CAST(@value AS INT));
                SET @start = @end + 1;
                SET @end = CHARINDEX(@separator, @idList, @start);
            END

            SET @value = SUBSTRING(@idList, @start, LEN(@idList) - @start + 1);
            INSERT INTO @idTable (id) VALUES (CAST(@value AS INT));

            -- Consulta para obtener el total de registros con status "3" para los IDs en la lista
            SELECT @totalRegistros = COUNT(*)
            FROM [PROYECTO_CLASE].[dbo].[language_supports]
            WHERE id IN (SELECT id FROM @idTable) AND language_support_type  = 3;
        END
    END

    RETURN @totalRegistros;
END;



--! ------------------ CONSULTA 4------------------
-- Vista que muestre el top 100 de juegos que soporten más idiomas (subtítulos y audio) ordenados 
-- por rating, nombre y que idiomas soportan.
DROP VIEW IF EXISTS consulta4;
CREATE VIEW consulta4
AS
SELECT TOP (100) [id]
    ,[name]
    ,(SELECT dbo.obtenerContadorDeLenguajesDeTipoAudioPorJuego([language_supports])) as audio_languages_counter
    ,(SELECT dbo.obtenerLenguajesSoportadosPorUnJuego([language_supports])) as languages_supported
    ,[rating] 
    ,(SELECT dbo.obtenerContadorDeLenguajesDeTipoSubtituloPorJuego([language_supports])) as subtitle_languages_counter
    ,(SELECT dbo.obtenerContadorDeLenguajesDeTipoInterfazPorJuego([language_supports])) as interface_languages_counter
    ,(SELECT dbo.obtenerGeneros([genres])) as game_genres
    ,(SELECT dbo.obtenerPlataformas([platforms])) as game_platforms 
    ,url
FROM [PROYECTO_CLASE].[dbo].[games]
ORDER BY audio_languages_counter DESC,[rating] DESC, name DESC

SELECT * FROM consulta4;
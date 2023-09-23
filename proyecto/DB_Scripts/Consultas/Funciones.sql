
--! ------------------ FUNCION OBTENER LOS IDS ------------------
--* dado un arreglo de ids en formato string, devuelve un arreglo de ids en formato int
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
--! ------------------ FUNCION OBTENER LOS GENEROS ------------------
--* Dado un arreglo de ids de generos, devuelve un string con los nombres de los generos
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

    -- Verificar si @genreNames no es NULL antes de usar LEN
    IF @genreNames IS NOT NULL
    BEGIN
        -- Eliminar la coma adicional al final
        SET @genreNames = LEFT(@genreNames, LEN(@genreNames) - 1);
    END

    RETURN @genreNames;
END;

GO
--! ------------------ FUNCION OBTENER LAS PLATAFORMAS ------------------
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

        -- Verificar si @genreNames no es NULL antes de usar LEN
        IF @genreNames IS NOT NULL
        BEGIN
            -- Eliminar la coma adicional al final
            SET @genreNames = LEFT(@genreNames, LEN(@genreNames) - 1);
        END

	END
	RETURN @genreNames;
END;

GO

--! ------------------ FUNCION OBTENER FECHA FORMATEADA ------------------
--* Dado un arreglo de ids de generos, devuelve un string con los nombres de los generos
CREATE FUNCTION ConvertirFechaIntToString (@fechaInt INT)
RETURNS NVARCHAR(255)
AS
BEGIN
    DECLARE @fecha DATETIME;
    SET @fecha = DATEADD(SECOND, @fechaInt, '19700101'); -- Convierte la fecha INT a DATETIME

    -- Formatea la fecha en un formato legible
    DECLARE @fechaTexto NVARCHAR(255);
    SET @fechaTexto = CONVERT(NVARCHAR(255), @fecha, 120); -- Formato ISO 8601 (YYYY-MM-DD HH:MI:SS)

    RETURN @fechaTexto;
END;
GO
--! ------------------ FUNCION OBTENER RELEASE DATES  ------------------
--* Dado un arreglo de ids de release_dates, devuelve un string con las fechas que tiene la tabla
-- * en el campo human, y lo concatena con region y platform, agrupandolo por plataforma
-- [25216, 25217, 25218]
DROP FUNCTION IF EXISTS obtenerReleaseSpliteado;
GO
CREATE FUNCTION obtenerReleaseSpliteado (@release_dates_list NVARCHAR(MAX))
RETURNS NVARCHAR(MAX)
AS
BEGIN
    -- Validar que la palabra de búsqueda no sea vacía o NULL
    IF @release_dates_list IS NULL OR LEN(@release_dates_list) = 0
    BEGIN
        RETURN 'La palabra de búsqueda no puede estar vacía';;
    END
    DECLARE @current_platform NVARCHAR(MAX) = ''; -- Plataforma actual
    DECLARE @release_dates NVARCHAR(MAX) = ''; -- Valor a retornar
    DECLARE @release_dates2 NVARCHAR(MAX) = ''; -- Valor a retornar

    -- Eliminar los corchetes "[" y "]" del arreglo
    SET @release_dates = REPLACE(REPLACE(@release_dates_list, '[', ''), ']', '');

    -- Verificar si @genreNames no es NULL antes de usar LEN
    IF @release_dates IS NOT NULL
    BEGIN
        -- Eliminar la coma adicional al final
        SET @release_dates = LEFT(@release_dates, LEN(@release_dates) - 1);
    END

    -- Almacenar el valor en una variable de tabla
    DECLARE @result TABLE (ReleaseDates NVARCHAR(MAX), platform NVARCHAR(MAX));
    INSERT INTO @result (ReleaseDates, platform)
    SELECT 
    CONCAT(' | human: ', [human], ' | region: ',(SELECT dbo.obtenerRegiones([region])) ), (SELECT dbo.obtenerPlataformadadoid([platform])) as platform
    FROM [PROYECTO_CLASE].[dbo].[release_dates]
    WHERE CHARINDEX(CAST([Id] AS NVARCHAR(MAX)), @release_dates_list) > 0
    ORDER BY [platform];

    -- Concatenar los resultados en @release_dates
    -- SELECT @release_dates = STRING_AGG(ReleaseDates, ', ') WITHIN GROUP (ORDER BY ReleaseDates)
    -- FROM @result;
    -- Iterar a través de los resultados y agrupar por plataforma
    SELECT @release_dates2 = @release_dates2 + 
        CASE 
            WHEN [platform] <> @current_platform THEN
                CHAR(13) + CHAR(10) + 'platform: ' + [platform] + '$' + ReleaseDates
            ELSE
                '$' + ReleaseDates
        END,
        @current_platform = [platform]
    FROM @result;

    -- Devolver el valor concatenado
    RETURN @release_dates2;
END;
GO
SELECT dbo.obtenerReleaseSpliteado('[25216, 25217, 25218]');

GO
--! ------------------ FUNCION OBTENER LAS REGIONES ------------------
DROP FUNCTION IF EXISTS obtenerRegiones;
GO
CREATE FUNCTION dbo.obtenerRegiones
(
    @region INT
)
RETURNS NVARCHAR(MAX)
AS
BEGIN
	DECLARE @regionName NVARCHAR(MAX) = '';
	
	IF @region IS NULL
		BEGIN
			RETURN 'Sin informacion';
		END
	ELSE
	BEGIN
		DECLARE @idArray NVARCHAR(MAX) = '';
		SET @regionName = CASE
            WHEN @region = 1 THEN 'europe [EU]'
            WHEN @region = 2 THEN 'north_america [NA]'
            WHEN @region = 3 THEN 'australia [AU]'
            WHEN @region = 4 THEN 'new_zealand [NZ]'
            WHEN @region = 5 THEN 'japan [JP]'
            WHEN @region = 6 THEN 'china [CH]'
            WHEN @region = 7 THEN 'asia [AS]'
            WHEN @region = 8 THEN 'worldwide [WW]'
            WHEN @region = 9 THEN 'korea [KO]'
            WHEN @region = 10 THEN 'brazil [BR]'
            ELSE 'desconocido' -- Valor predeterminado si no se encuentra una coincidencia
        END;


	END
	RETURN @regionName;
END;

GO
SELECT dbo.obtenerRegiones(5);


-- ! ------------------ FUNCION OBTENER PLATAFORMA DADO ID ------------------
DROP FUNCTION IF EXISTS obtenerPlataformadadoid;
GO
CREATE FUNCTION dbo.obtenerPlataformadadoid
(
    @idList INT
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
		SELECT @genreNames =name
		FROM [PROYECTO_CLASE].[dbo].[platforms]
		WHERE id = @idList;
	END
	RETURN @genreNames;
END;

GO

--! ------------------ FUNCION OBTENER LOS PUBLISHERS AND DEVS ------------------
--* Dado un arreglo de ids de generos, devuelve un string con los nombres de los generos
DROP FUNCTION IF EXISTS obtenerDevelopers;
GO
CREATE FUNCTION dbo.obtenerDevelopers
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
		FROM [PROYECTO_CLASE].[dbo].[companies]
		WHERE CHARINDEX(CAST(Id AS NVARCHAR(MAX)), @idArray + ',') > 0;

		-- Eliminar la coma adicional al final
		-- Verificar si @genreNames no es NULL antes de usar LEN
        IF @genreNames IS NOT NULL
        BEGIN
            -- Eliminar la coma adicional al final
            SET @genreNames = LEFT(@genreNames, LEN(@genreNames) - 1);
        END

	END
	RETURN @genreNames;
END;

GO
SELECT dbo.obtenerDevelopers('[2739, 2740, 21014]');

--! ------------------ FUNCION OBTENER LOS GAME MODE ------------------
--* Dado un arreglo de ids de generos, devuelve un string con los nombres de los generos
DROP FUNCTION IF EXISTS obtenerGameMode;
GO
CREATE FUNCTION dbo.obtenerGameMode
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
		FROM [PROYECTO_CLASE].[dbo].[game_modes]
		WHERE CHARINDEX(CAST(Id AS NVARCHAR(MAX)), @idArray + ',') > 0;

		-- Eliminar la coma adicional al final
		-- Verificar si @genreNames no es NULL antes de usar LEN
        IF @genreNames IS NOT NULL
        BEGIN
            -- Eliminar la coma adicional al final
            SET @genreNames = LEFT(@genreNames, LEN(@genreNames) - 1);
        END

	END
	RETURN @genreNames;
END;

GO

--! ------------------ FUNCION OBTENER LOS Themes ------------------
--* Dado un arreglo de ids de generos, devuelve un string con los nombres de los generos
DROP FUNCTION IF EXISTS obtenerTemas;
GO
CREATE FUNCTION dbo.obtenerTemas
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
		FROM [PROYECTO_CLASE].[dbo].[themes]
		WHERE CHARINDEX(CAST(Id AS NVARCHAR(MAX)), @idArray + ',') > 0;

		-- Eliminar la coma adicional al final
		-- Verificar si @genreNames no es NULL antes de usar LEN
        IF @genreNames IS NOT NULL
        BEGIN
            -- Eliminar la coma adicional al final
            SET @genreNames = LEFT(@genreNames, LEN(@genreNames) - 1);
        END

	END
	RETURN @genreNames;
END;

GO

--! ------------------ FUNCION OBTENER LOS obtenerPerspectivas ------------------
--* Dado un arreglo de ids de generos, devuelve un string con los nombres de los generos
DROP FUNCTION IF EXISTS obtenerPerspectivas;
GO
CREATE FUNCTION dbo.obtenerPerspectivas
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
		FROM [PROYECTO_CLASE].[dbo].[player_perspectives]
		WHERE CHARINDEX(CAST(Id AS NVARCHAR(MAX)), @idArray + ',') > 0;

		-- Eliminar la coma adicional al final
		-- Verificar si @genreNames no es NULL antes de usar LEN
        IF @genreNames IS NOT NULL
        BEGIN
            -- Eliminar la coma adicional al final
            SET @genreNames = LEFT(@genreNames, LEN(@genreNames) - 1);
        END

	END
	RETURN @genreNames;
END;

GO

--! ------------------ FUNCION OBTENER LOS obtenerSeriesCollections ------------------
--* Dado un arreglo de ids de generos, devuelve un string con los nombres de los generos
DROP FUNCTION IF EXISTS obtenerSeriesCollections;
GO
CREATE FUNCTION dbo.obtenerSeriesCollections
(
    @idList INT
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
		-- Consulta para obtener los nombres de géneros basados en la lista de IDs
		SELECT @genreNames =  name
		FROM [PROYECTO_CLASE].[dbo].[collections]
		WHERE id = @idList;
	END
	RETURN @genreNames;
END;

GO

--! ------------------ FUNCION OBTENER LOS obtenerengines ------------------
--* Dado un arreglo de ids de generos, devuelve un string con los nombres de los generos
DROP FUNCTION IF EXISTS obtenerengines;
GO
CREATE FUNCTION dbo.obtenerengines
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
		FROM [PROYECTO_CLASE].[dbo].[game_engines]
		WHERE CHARINDEX(CAST(Id AS NVARCHAR(MAX)), @idArray + ',') > 0;

		-- Eliminar la coma adicional al final
		-- Verificar si @genreNames no es NULL antes de usar LEN
        IF @genreNames IS NOT NULL
        BEGIN
            -- Eliminar la coma adicional al final
            SET @genreNames = LEFT(@genreNames, LEN(@genreNames) - 1);
        END

	END
	RETURN @genreNames;
END;

GO

--! ------------------ FUNCION OBTENER LOS obtenergamelocalization ------------------
--* Dado un arreglo de ids de generos, devuelve un string con los nombres de los generos
DROP FUNCTION IF EXISTS obtenergamelocalization;
GO
CREATE FUNCTION dbo.obtenergamelocalization
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
		FROM [PROYECTO_CLASE].[dbo].[game_localizations]
		WHERE CHARINDEX(CAST(Id AS NVARCHAR(MAX)), @idArray + ',') > 0;

		-- Eliminar la coma adicional al final
		-- Verificar si @genreNames no es NULL antes de usar LEN
        IF @genreNames IS NOT NULL
        BEGIN
            -- Eliminar la coma adicional al final
            SET @genreNames = LEFT(@genreNames, LEN(@genreNames) - 1);
        END

	END
	RETURN @genreNames;
END;

GO


--! ------------------ FUNCION OBTENER LOS obtenerAlternativenames ------------------
--* Dado un arreglo de ids de generos, devuelve un string con los nombres de los generos
DROP FUNCTION IF EXISTS obtenerAlternativenames;
GO
CREATE FUNCTION dbo.obtenerAlternativenames
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
		FROM [PROYECTO_CLASE].[dbo].[alternative_names]
		WHERE CHARINDEX(CAST(Id AS NVARCHAR(MAX)), @idArray + ',') > 0;

		-- Eliminar la coma adicional al final
		-- Verificar si @genreNames no es NULL antes de usar LEN
        IF @genreNames IS NOT NULL
        BEGIN
            -- Eliminar la coma adicional al final
            SET @genreNames = LEFT(@genreNames, LEN(@genreNames) - 1);
        END

	END
	RETURN @genreNames;
END;

GO

DROP FUNCTION IF EXISTS test;
GO
CREATE FUNCTION test (@release_dates_list NVARCHAR(MAX))
RETURNS NVARCHAR(MAX)
AS
BEGIN
    -- Validar que la palabra de búsqueda no sea vacía o NULL
    IF @release_dates_list IS NULL OR LEN(@release_dates_list) = 0
    BEGIN
        RETURN NULL; -- O puedes devolver NULL o un valor predeterminado apropiado
    END

    DECLARE @release_dates NVARCHAR(MAX) = ''; -- Valor a retornar

    -- Eliminar los corchetes "[" y "]" del arreglo
    SET @release_dates = REPLACE(REPLACE(@release_dates_list, '[', ''), ']', '');
    -- Verificar si @genreNames no es NULL antes de usar LEN
    IF @release_dates IS NOT NULL
    BEGIN
        -- Eliminar la coma adicional al final
        SET @release_dates = LEFT(@release_dates, LEN(@release_dates) - 1);
    END
    -- Almacenar el valor en una variable de tabla
    DECLARE @result TABLE (ReleaseDates NVARCHAR(MAX));
    INSERT INTO @result (ReleaseDates) VALUES (@release_dates);

    -- Devolver el valor
    RETURN (SELECT ReleaseDates FROM @result);
END;

GO
SELECT dbo.test('[25216, 25217, 25218]');
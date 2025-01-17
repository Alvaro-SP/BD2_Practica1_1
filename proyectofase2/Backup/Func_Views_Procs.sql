USE [PROYECTO_CLASE]
GO
/****** Object:  UserDefinedFunction [dbo].[ConvertirFechaIntToString]    Script Date: 26/10/2023 22:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ConvertirFechaIntToString] (@fechaInt INT)
RETURNS NVARCHAR(255)
AS
BEGIN
    DECLARE @fecha DATETIME;
    SET @fecha = DATEADD(SECOND, @fechaInt, '19700101'); -- Convierte la fecha INT a DATETIME

    -- Calcula los años transcurridos
    DECLARE @añosTranscurridos INT;
    SET @añosTranscurridos = DATEDIFF(YEAR, @fecha, '20230101');

    -- Formatea la fecha en un formato legible
    DECLARE @fechaTexto NVARCHAR(255);
    SET @fechaTexto = FORMAT(@fecha, 'MMMM dd, yyyy') + ' (Hace ' + CAST(@añosTranscurridos AS NVARCHAR(10)) + ' años)';

    RETURN @fechaTexto;
END;
GO
/****** Object:  UserDefinedFunction [dbo].[obtenerAlternativenames]    Script Date: 26/10/2023 22:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[obtenerAlternativenames]
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
/****** Object:  UserDefinedFunction [dbo].[obtenerContadorDeLenguajesDeTipoAudioPorJuego]    Script Date: 26/10/2023 22:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[obtenerContadorDeLenguajesDeTipoAudioPorJuego]
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
GO
/****** Object:  UserDefinedFunction [dbo].[obtenerContadorDeLenguajesDeTipoInterfazPorJuego]    Script Date: 26/10/2023 22:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[obtenerContadorDeLenguajesDeTipoInterfazPorJuego]
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

            -- Consulta para obtener el total de registros con status "1" para los IDs en la lista
            SELECT @totalRegistros = COUNT(*)
            FROM [PROYECTO_CLASE].[dbo].[language_supports]
            WHERE id IN (SELECT id FROM @idTable) AND language_support_type  = 3;
        END
    END

    RETURN @totalRegistros;
END;
GO
/****** Object:  UserDefinedFunction [dbo].[obtenerContadorDeLenguajesDeTipoSubtituloPorJuego]    Script Date: 26/10/2023 22:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[obtenerContadorDeLenguajesDeTipoSubtituloPorJuego]
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

            -- Consulta para obtener el total de registros con status "1" para los IDs en la lista
            SELECT @totalRegistros = COUNT(*)
            FROM [PROYECTO_CLASE].[dbo].[language_supports]
            WHERE id IN (SELECT id FROM @idTable) AND language_support_type  = 2;
        END
    END

    RETURN @totalRegistros;
END;
GO
/****** Object:  UserDefinedFunction [dbo].[obtenerDevelopers]    Script Date: 26/10/2023 22:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[obtenerDevelopers]
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
/****** Object:  UserDefinedFunction [dbo].[obtenerengines]    Script Date: 26/10/2023 22:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[obtenerengines]
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
/****** Object:  UserDefinedFunction [dbo].[obtenergamelocalization]    Script Date: 26/10/2023 22:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[obtenergamelocalization]
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
/****** Object:  UserDefinedFunction [dbo].[obtenerGameMode]    Script Date: 26/10/2023 22:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[obtenerGameMode]
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
/****** Object:  UserDefinedFunction [dbo].[obtenerGeneros]    Script Date: 26/10/2023 22:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[obtenerGeneros]
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
/****** Object:  UserDefinedFunction [dbo].[obtenerLenguajesSoportadosPorUnJuego]    Script Date: 26/10/2023 22:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[obtenerLenguajesSoportadosPorUnJuego]
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
GO
/****** Object:  UserDefinedFunction [dbo].[obtenerPerspectivas]    Script Date: 26/10/2023 22:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[obtenerPerspectivas]
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
/****** Object:  UserDefinedFunction [dbo].[obtenerPlataformadadoid]    Script Date: 26/10/2023 22:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[obtenerPlataformadadoid]
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
/****** Object:  UserDefinedFunction [dbo].[obtenerPlataformas]    Script Date: 26/10/2023 22:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[obtenerPlataformas]
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
/****** Object:  UserDefinedFunction [dbo].[obtenerRegiones]    Script Date: 26/10/2023 22:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[obtenerRegiones]
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
/****** Object:  UserDefinedFunction [dbo].[obtenerReleaseSpliteado]    Script Date: 26/10/2023 22:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[obtenerReleaseSpliteado] (@release_dates_list NVARCHAR(MAX))
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

    SET @release_dates = LEFT(@release_dates, LEN(@release_dates) - 1);

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
/****** Object:  UserDefinedFunction [dbo].[obtenerSeriesCollections]    Script Date: 26/10/2023 22:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[obtenerSeriesCollections]
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
/****** Object:  UserDefinedFunction [dbo].[obtenerTemas]    Script Date: 26/10/2023 22:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[obtenerTemas]
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
/****** Object:  UserDefinedFunction [dbo].[test]    Script Date: 26/10/2023 22:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[test] (@release_dates_list NVARCHAR(MAX))
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
/****** Object:  UserDefinedFunction [dbo].[ParseNumbersFromText]    Script Date: 26/10/2023 22:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ParseNumbersFromText](@inputText NVARCHAR(MAX))
RETURNS TABLE
AS
RETURN
(
    SELECT CAST(value AS INT) AS Numero
    FROM STRING_SPLIT(REPLACE(REPLACE(@inputText, '[', ''), ']', ''), ',')
);

GO
/****** Object:  View [dbo].[consulta1]    Script Date: 26/10/2023 22:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[consulta1]
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
/****** Object:  View [dbo].[consulta4]    Script Date: 26/10/2023 22:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[consulta4]
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
GO
/****** Object:  StoredProcedure [dbo].[c2]    Script Date: 26/10/2023 22:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[c2]
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
            ,ROUND([rating], 2)
            ,summary
            ,url
        FROM [PROYECTO_CLASE].[dbo].[games]
        WHERE  CHARINDEX(@palabraBusqueda, name) > 0;
    END
END;
GO
/****** Object:  StoredProcedure [dbo].[c2_testing_erwin]    Script Date: 26/10/2023 22:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[c2_testing_erwin]
    @nombresearch VARCHAR(100)
AS
BEGIN
    BEGIN
        SELECT name
        FROM [PROYECTO_CLASE].[dbo].[games]
        WHERE CHARINDEX(@nombresearch, name) > 0
              AND LEN(@nombresearch) >= 4
              AND LEN(name) - LEN(REPLACE(name, ' ', '')) >= LEN(@nombresearch);
    END
END;
GO
/****** Object:  StoredProcedure [dbo].[c3]    Script Date: 26/10/2023 22:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[c3]
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
GO
/****** Object:  StoredProcedure [dbo].[c3xtra]    Script Date: 26/10/2023 22:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[c3xtra]
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
/****** Object:  StoredProcedure [dbo].[c5]    Script Date: 26/10/2023 22:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[c5]
AS
BEGIN
    SELECT TOP (1000) [id]
        ,[name]
        ,ROUND([rating], 2)
        ,(SELECT dbo.obtenerGeneros([genres])) as Generos
        ,ROUND([aggregated_rating], 2)
        ,(SELECT dbo.obtenerPlataformas([platforms])) as Plataformas  
        ,url
    FROM [PROYECTO_CLASE].[dbo].[games]
    ORDER BY [rating] DESC

END;
GO
/****** Object:  StoredProcedure [dbo].[GetTop100GamesWithLanguageSupports]    Script Date: 26/10/2023 22:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetTop100GamesWithLanguageSupports]
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Delimiter CHAR(1) = ',';
    DECLARE @Counter INT = 1;
    DECLARE @GameId INT;
    DECLARE @LanguageSupports VARCHAR(MAX);
    DECLARE @Result TABLE (
        id INT,
        name NVARCHAR(255),
        cantidad_language_supports INT,
        languages_supports_names NVARCHAR(MAX)
    );

    INSERT INTO @Result (id, name, cantidad_language_supports, languages_supports_names)
    SELECT
        g.id,
        g.name,
        COUNT(ls.id) AS cantidad_language_supports,
        STRING_AGG(ls.name, ', ') AS languages_supports_names
    FROM
        games g
    CROSS APPLY STRING_SPLIT(REPLACE(REPLACE(g.language_supports, '[', ''), ']', ''), @Delimiter) AS s
    INNER JOIN language_supports ls ON CAST(s.value AS INT) = ls.id
    GROUP BY
        g.id,
        g.name
    ORDER BY
        cantidad_language_supports DESC
    OFFSET 0 ROWS FETCH NEXT 100 ROWS ONLY;

    SELECT * FROM @Result;
END;
GO
/****** Object:  StoredProcedure [dbo].[infogame]    Script Date: 26/10/2023 22:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[infogame]
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
    SELECT DISTINCT 
        id as IGDB_ID
        ,name
        ,(SELECT dbo.ConvertirFechaIntToString([first_release_date])) as FechaRelease
		,alternative_names
        ,(SELECT dbo.obtenerGeneros([genres])) as Generos
        ,(SELECT dbo.obtenerPlataformas([platforms])) as Plataformas
		,ROUND([rating], 2) as rating
        ,ROUND([aggregated_rating], 2) as rating
        ,rating_count AS Total_ratings
		,summary
        ,(SELECT dbo.obtenerReleaseSpliteado([release_dates])) as Release_dates
        ,(SELECT dbo.obtenerDevelopers([involved_companies])) as Developers
        ,(SELECT dbo.obtenerDevelopers([involved_companies])) as Publishers
        ,url
		,(SELECT dbo.obtenerGeneros([genres])) as Genre
        ,(SELECT dbo.obtenerTemas([themes])) as Themes
        ,(SELECT dbo.obtenerGameMode([game_modes])) as Game_modes
        ,(SELECT dbo.obtenerPerspectivas([player_perspectives])) as Player_perspectives
        ,(SELECT dbo.obtenerSeriesCollections([collection])) as Series
        ,storyline
        ,(SELECT dbo.obtenerSeriesCollections([collection])) as Franchises
        ,(SELECT dbo.obtenerengines([game_engines])) as GameEngine
        ,(SELECT dbo.obtenergamelocalization([game_localizations])) as Game_Localizations
        ,(SELECT dbo.obtenerAlternativenames([alternative_names])) as Alternative_Names
        
    FROM [PROYECTO_CLASE].[dbo].[games]
    WHERE CHARINDEX(@palabraBusqueda, name) > 0;
END;
GO

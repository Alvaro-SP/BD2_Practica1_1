USE [master]
GO
/****** Object:  Database [PROYECTO_CLASE]    Script Date: 26/10/2023 22:06:01 ******/
CREATE DATABASE [PROYECTO_CLASE]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PROYECTO_CLASE', FILENAME = N'/var/opt/mssql/data/PROYECTO_CLASE.mdf' , SIZE = 532480KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'PROYECTO_CLASE_log', FILENAME = N'/var/opt/mssql/data/PROYECTO_CLASE_log.ldf' , SIZE = 335872KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [PROYECTO_CLASE] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PROYECTO_CLASE].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PROYECTO_CLASE] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PROYECTO_CLASE] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PROYECTO_CLASE] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PROYECTO_CLASE] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PROYECTO_CLASE] SET ARITHABORT OFF 
GO
ALTER DATABASE [PROYECTO_CLASE] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PROYECTO_CLASE] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PROYECTO_CLASE] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PROYECTO_CLASE] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PROYECTO_CLASE] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PROYECTO_CLASE] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PROYECTO_CLASE] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PROYECTO_CLASE] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PROYECTO_CLASE] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PROYECTO_CLASE] SET  ENABLE_BROKER 
GO
ALTER DATABASE [PROYECTO_CLASE] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PROYECTO_CLASE] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PROYECTO_CLASE] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PROYECTO_CLASE] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PROYECTO_CLASE] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PROYECTO_CLASE] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PROYECTO_CLASE] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PROYECTO_CLASE] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [PROYECTO_CLASE] SET  MULTI_USER 
GO
ALTER DATABASE [PROYECTO_CLASE] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PROYECTO_CLASE] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PROYECTO_CLASE] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PROYECTO_CLASE] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [PROYECTO_CLASE] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [PROYECTO_CLASE] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [PROYECTO_CLASE] SET QUERY_STORE = OFF
GO
USE [PROYECTO_CLASE]
GO
/****** Object:  UserDefinedFunction [dbo].[ConvertirFechaIntToString]    Script Date: 26/10/2023 22:06:02 ******/
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
/****** Object:  UserDefinedFunction [dbo].[obtenerAlternativenames]    Script Date: 26/10/2023 22:06:02 ******/
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
/****** Object:  UserDefinedFunction [dbo].[obtenerContadorDeLenguajesDeTipoAudioPorJuego]    Script Date: 26/10/2023 22:06:02 ******/
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
/****** Object:  UserDefinedFunction [dbo].[obtenerContadorDeLenguajesDeTipoInterfazPorJuego]    Script Date: 26/10/2023 22:06:02 ******/
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
/****** Object:  UserDefinedFunction [dbo].[obtenerContadorDeLenguajesDeTipoSubtituloPorJuego]    Script Date: 26/10/2023 22:06:02 ******/
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
/****** Object:  UserDefinedFunction [dbo].[obtenerDevelopers]    Script Date: 26/10/2023 22:06:02 ******/
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
/****** Object:  UserDefinedFunction [dbo].[obtenerengines]    Script Date: 26/10/2023 22:06:02 ******/
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
/****** Object:  UserDefinedFunction [dbo].[obtenergamelocalization]    Script Date: 26/10/2023 22:06:02 ******/
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
/****** Object:  UserDefinedFunction [dbo].[obtenerGameMode]    Script Date: 26/10/2023 22:06:02 ******/
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
/****** Object:  UserDefinedFunction [dbo].[obtenerGeneros]    Script Date: 26/10/2023 22:06:02 ******/
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
/****** Object:  UserDefinedFunction [dbo].[obtenerLenguajesSoportadosPorUnJuego]    Script Date: 26/10/2023 22:06:02 ******/
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
/****** Object:  UserDefinedFunction [dbo].[obtenerPerspectivas]    Script Date: 26/10/2023 22:06:02 ******/
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
/****** Object:  UserDefinedFunction [dbo].[obtenerPlataformadadoid]    Script Date: 26/10/2023 22:06:02 ******/
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
/****** Object:  UserDefinedFunction [dbo].[obtenerPlataformas]    Script Date: 26/10/2023 22:06:02 ******/
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
/****** Object:  UserDefinedFunction [dbo].[obtenerRegiones]    Script Date: 26/10/2023 22:06:02 ******/
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
/****** Object:  UserDefinedFunction [dbo].[obtenerReleaseSpliteado]    Script Date: 26/10/2023 22:06:02 ******/
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
/****** Object:  UserDefinedFunction [dbo].[obtenerSeriesCollections]    Script Date: 26/10/2023 22:06:02 ******/
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
/****** Object:  UserDefinedFunction [dbo].[obtenerTemas]    Script Date: 26/10/2023 22:06:02 ******/
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
/****** Object:  UserDefinedFunction [dbo].[test]    Script Date: 26/10/2023 22:06:02 ******/
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
/****** Object:  Table [dbo].[games]    Script Date: 26/10/2023 22:06:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[games](
	[id] [int] NOT NULL,
	[age_ratings] [varchar](max) NULL,
	[aggregated_rating] [float] NULL,
	[aggregated_rating_count] [int] NULL,
	[alternative_names] [varchar](max) NULL,
	[artworks] [varchar](max) NULL,
	[bundles] [varchar](max) NULL,
	[category] [int] NULL,
	[checksum] [varchar](36) NULL,
	[collection] [int] NULL,
	[cover] [int] NULL,
	[created_at] [int] NULL,
	[dlcs] [varchar](max) NULL,
	[expanded_games] [varchar](max) NULL,
	[expansions] [varchar](max) NULL,
	[external_games] [varchar](max) NULL,
	[first_release_date] [int] NULL,
	[follows] [int] NULL,
	[forks] [varchar](max) NULL,
	[franchise] [int] NULL,
	[franchises] [varchar](max) NULL,
	[game_engines] [varchar](max) NULL,
	[game_localizations] [varchar](max) NULL,
	[game_modes] [varchar](max) NULL,
	[genres] [varchar](max) NULL,
	[hypes] [int] NULL,
	[involved_companies] [varchar](max) NULL,
	[keywords] [varchar](max) NULL,
	[language_supports] [varchar](max) NULL,
	[multiplayer_modes] [varchar](max) NULL,
	[name] [varchar](max) NULL,
	[parent_game] [int] NULL,
	[platforms] [varchar](max) NULL,
	[player_perspectives] [varchar](max) NULL,
	[ports] [varchar](max) NULL,
	[rating] [float] NULL,
	[rating_count] [int] NULL,
	[release_dates] [varchar](max) NULL,
	[remakes] [varchar](max) NULL,
	[remasters] [varchar](max) NULL,
	[screenshots] [varchar](max) NULL,
	[similar_games] [varchar](max) NULL,
	[slug] [varchar](max) NULL,
	[standalone_expansions] [varchar](max) NULL,
	[status] [int] NULL,
	[storyline] [varchar](max) NULL,
	[summary] [varchar](max) NULL,
	[tags] [varchar](max) NULL,
	[themes] [varchar](max) NULL,
	[total_rating] [float] NULL,
	[total_rating_count] [int] NULL,
	[updated_at] [int] NULL,
	[url] [varchar](max) NULL,
	[version_parent] [int] NULL,
	[version_title] [varchar](max) NULL,
	[videos] [varchar](max) NULL,
	[websites] [varchar](max) NULL,
 CONSTRAINT [PK_games] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[consulta1]    Script Date: 26/10/2023 22:06:02 ******/
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
/****** Object:  View [dbo].[consulta4]    Script Date: 26/10/2023 22:06:02 ******/
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
/****** Object:  UserDefinedFunction [dbo].[ParseNumbersFromText]    Script Date: 26/10/2023 22:06:02 ******/
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
/****** Object:  Table [dbo].[age_rating_content_descriptions]    Script Date: 26/10/2023 22:06:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[age_rating_content_descriptions](
	[id] [int] NOT NULL,
	[category] [int] NULL,
	[checksum] [varchar](36) NULL,
	[description] [varchar](max) NULL,
 CONSTRAINT [PK_age_rating_content_descriptions] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[age_ratings]    Script Date: 26/10/2023 22:06:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[age_ratings](
	[id] [int] NOT NULL,
	[category] [int] NULL,
	[checksum] [varchar](36) NULL,
	[content_descriptions] [varchar](max) NULL,
	[rating] [varchar](max) NULL,
	[rating_cover_url] [varchar](max) NULL,
	[synopsis] [varchar](max) NULL,
 CONSTRAINT [PK_age_ratings] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[alternative_names]    Script Date: 26/10/2023 22:06:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[alternative_names](
	[id] [int] NOT NULL,
	[checksum] [varchar](36) NULL,
	[comment] [varchar](max) NULL,
	[game] [int] NULL,
	[name] [varchar](max) NULL,
 CONSTRAINT [PK_alternative_names] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[character_mug_shots]    Script Date: 26/10/2023 22:06:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[character_mug_shots](
	[id] [int] NOT NULL,
	[alpha_channel] [varchar](5) NULL,
	[animated] [varchar](5) NULL,
	[checksum] [varchar](36) NULL,
	[height] [int] NULL,
	[image_id] [varchar](max) NULL,
	[width] [int] NULL,
 CONSTRAINT [PK_character_mug_shots] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[characters]    Script Date: 26/10/2023 22:06:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[characters](
	[id] [int] NOT NULL,
	[akas] [varchar](max) NULL,
	[checksum] [varchar](36) NULL,
	[country_name] [varchar](max) NULL,
	[created_at] [int] NULL,
	[description] [varchar](max) NULL,
	[games] [varchar](max) NULL,
	[gender] [int] NULL,
	[mug_shot] [int] NULL,
	[name] [varchar](max) NULL,
	[slug] [varchar](max) NULL,
	[species] [int] NULL,
	[updated_at] [int] NULL,
	[url] [varchar](max) NULL,
 CONSTRAINT [PK_characters] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[collections]    Script Date: 26/10/2023 22:06:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[collections](
	[id] [int] NOT NULL,
	[checksum] [varchar](36) NULL,
	[created_at] [int] NULL,
	[games] [varchar](max) NULL,
	[name] [varchar](max) NULL,
	[slug] [varchar](max) NULL,
	[updated_at] [int] NULL,
	[url] [varchar](max) NULL,
 CONSTRAINT [PK_collections] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[companies]    Script Date: 26/10/2023 22:06:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[companies](
	[id] [bigint] NOT NULL,
	[change_date] [bigint] NULL,
	[change_date_category] [bigint] NULL,
	[changed_company_id] [bigint] NULL,
	[checksum] [varchar](36) NULL,
	[country] [bigint] NULL,
	[created_at] [bigint] NULL,
	[description] [varchar](max) NULL,
	[developed] [varchar](max) NULL,
	[logo] [bigint] NULL,
	[name] [varchar](max) NULL,
	[parent] [bigint] NULL,
	[published] [varchar](max) NULL,
	[slug] [varchar](max) NULL,
	[start_date] [bigint] NULL,
	[start_date_category] [bigint] NULL,
	[updated_at] [bigint] NULL,
	[url] [varchar](max) NULL,
	[websites] [varchar](max) NULL,
 CONSTRAINT [PK_companies] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[company_websites]    Script Date: 26/10/2023 22:06:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[company_websites](
	[id] [int] NOT NULL,
	[category] [int] NULL,
	[checksum] [varchar](36) NULL,
	[trusted] [varchar](5) NULL,
	[url] [varchar](max) NULL,
 CONSTRAINT [PK_company_websites] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[external_games]    Script Date: 26/10/2023 22:06:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[external_games](
	[id] [int] NOT NULL,
	[category] [int] NULL,
	[checksum] [varchar](36) NULL,
	[countries] [varchar](max) NULL,
	[created_at] [int] NULL,
	[game] [int] NULL,
	[media] [int] NULL,
	[name] [varchar](max) NULL,
	[platform] [int] NULL,
	[uid] [varchar](max) NULL,
	[updated_at] [int] NULL,
	[url] [varchar](max) NULL,
	[year] [int] NULL,
 CONSTRAINT [PK_external_games] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[franchises]    Script Date: 26/10/2023 22:06:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[franchises](
	[id] [int] NOT NULL,
	[checksum] [varchar](36) NULL,
	[created_at] [bigint] NULL,
	[games] [varchar](max) NULL,
	[name] [varchar](max) NULL,
	[slug] [varchar](max) NULL,
	[updated_at] [bigint] NULL,
	[url] [varchar](max) NULL,
 CONSTRAINT [PK_franchises] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[game_engines]    Script Date: 26/10/2023 22:06:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[game_engines](
	[id] [int] NOT NULL,
	[checksum] [varchar](36) NULL,
	[companies] [varchar](max) NULL,
	[created_at] [int] NULL,
	[description] [varchar](max) NULL,
	[logo] [varchar](max) NULL,
	[name] [varchar](max) NULL,
	[platforms] [varchar](max) NULL,
	[slug] [varchar](max) NULL,
	[updated_at] [int] NULL,
	[url] [varchar](max) NULL,
 CONSTRAINT [PK_game_engines] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[game_localizations]    Script Date: 26/10/2023 22:06:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[game_localizations](
	[id] [int] NOT NULL,
	[cover] [int] NULL,
	[checksum] [varchar](36) NULL,
	[created_at] [bigint] NULL,
	[name] [varchar](max) NULL,
	[region] [int] NULL,
	[updated_at] [bigint] NULL,
	[game] [int] NULL,
 CONSTRAINT [PK__game_loc__3213E83F873B8E0C] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[game_modes]    Script Date: 26/10/2023 22:06:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[game_modes](
	[id] [int] NOT NULL,
	[checksum] [varchar](36) NULL,
	[created_at] [bigint] NULL,
	[name] [varchar](max) NULL,
	[slug] [varchar](max) NULL,
	[updated_at] [bigint] NULL,
	[url] [varchar](max) NULL,
 CONSTRAINT [PK__game_mod__3213E83FE7F1618D] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[game_version_feature_values]    Script Date: 26/10/2023 22:06:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[game_version_feature_values](
	[id] [int] NOT NULL,
	[checksum] [varchar](36) NULL,
	[game] [int] NULL,
	[included_feature] [int] NULL,
	[note] [varchar](max) NULL,
 CONSTRAINT [PK__game_ver__3213E83F96ECAA01] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[game_version_features]    Script Date: 26/10/2023 22:06:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[game_version_features](
	[id] [int] NOT NULL,
	[checksum] [varchar](36) NULL,
	[category] [int] NULL,
	[description] [varchar](max) NULL,
	[position] [int] NULL,
	[tittle] [varchar](max) NULL,
	[values_] [varchar](max) NULL,
 CONSTRAINT [PK__game_ver__3213E83FF5306992] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[game_versions]    Script Date: 26/10/2023 22:06:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[game_versions](
	[id] [int] NOT NULL,
	[checksum] [varchar](36) NULL,
	[features] [varchar](max) NULL,
	[game] [int] NULL,
	[games] [varchar](max) NULL,
	[created_at] [bigint] NULL,
	[updated_at] [bigint] NULL,
	[url] [varchar](max) NULL,
 CONSTRAINT [PK__game_ver__3213E83F5AE86080] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[game_videos]    Script Date: 26/10/2023 22:06:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[game_videos](
	[id] [int] NOT NULL,
	[checksum] [varchar](36) NULL,
	[game] [int] NULL,
	[name] [varchar](max) NULL,
	[video_id] [varchar](max) NULL,
 CONSTRAINT [PK__game_vid__3213E83FEBEAB43B] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[genres]    Script Date: 26/10/2023 22:06:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[genres](
	[id] [int] NOT NULL,
	[checksum] [varchar](36) NULL,
	[created_at] [bigint] NULL,
	[name] [varchar](max) NULL,
	[slug] [varchar](max) NULL,
	[updated_at] [bigint] NULL,
	[url] [varchar](max) NULL,
 CONSTRAINT [PK__genres__3213E83F1F33B7C4] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[involved_companies]    Script Date: 26/10/2023 22:06:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[involved_companies](
	[id] [int] NOT NULL,
	[checksum] [varchar](36) NULL,
	[company] [bigint] NULL,
	[created_at] [bigint] NULL,
	[developer] [varchar](max) NULL,
	[game] [int] NULL,
	[porting] [varchar](max) NULL,
	[publisher] [varchar](max) NULL,
	[supporting] [varchar](max) NULL,
	[updated_at] [bigint] NULL,
 CONSTRAINT [PK__involved__3213E83FDB218A00] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[keywords]    Script Date: 26/10/2023 22:06:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[keywords](
	[id] [int] NOT NULL,
	[checksum] [varchar](36) NULL,
	[created_at] [bigint] NULL,
	[name] [varchar](500) NULL,
	[slug] [varchar](500) NULL,
	[updated_at] [bigint] NULL,
	[url] [varchar](500) NULL,
 CONSTRAINT [PK__keywords__3213E83FCFAAE7DA] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[language_support_types]    Script Date: 26/10/2023 22:06:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[language_support_types](
	[id] [int] NOT NULL,
	[checksum] [varchar](36) NULL,
	[created_at] [bigint] NULL,
	[name] [varchar](max) NULL,
	[updated_at] [bigint] NULL,
 CONSTRAINT [PK__language__3213E83F605ED9E8] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[language_supports]    Script Date: 26/10/2023 22:06:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[language_supports](
	[id] [int] NOT NULL,
	[checksum] [varchar](36) NULL,
	[game] [int] NULL,
	[language] [int] NULL,
	[language_support_type] [int] NULL,
	[created_at] [bigint] NULL,
	[updated_at] [bigint] NULL,
 CONSTRAINT [PK__language__3213E83F89E04A99] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[languages]    Script Date: 26/10/2023 22:06:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[languages](
	[id] [int] NOT NULL,
	[checksum] [varchar](36) NULL,
	[created_at] [bigint] NULL,
	[locale] [nvarchar](10) NULL,
	[name] [nvarchar](100) NULL,
	[native_name] [nvarchar](100) NULL,
	[updated_at] [bigint] NULL,
 CONSTRAINT [PK__language__3213E83F35F4223C] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[multiplayer_modes]    Script Date: 26/10/2023 22:06:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[multiplayer_modes](
	[id] [int] NOT NULL,
	[campaigncoop] [varchar](5) NULL,
	[checksum] [varchar](36) NULL,
	[dropin] [varchar](5) NULL,
	[game] [int] NULL,
	[lancoop] [varchar](5) NULL,
	[offlinecoop] [varchar](5) NULL,
	[offlinecoopmax] [int] NULL,
	[offlinemax] [int] NULL,
	[onlinecoop] [varchar](5) NULL,
	[onlinecoopmax] [int] NULL,
	[onlinemax] [int] NULL,
	[platform] [int] NULL,
	[splitscreen] [varchar](5) NULL,
	[splitscreenonline] [varchar](5) NULL,
 CONSTRAINT [PK__multipla__3213E83FCD222836] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[platform_families]    Script Date: 26/10/2023 22:06:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[platform_families](
	[id] [int] NOT NULL,
	[checksum] [varchar](36) NULL,
	[name] [varchar](max) NULL,
	[slug] [varchar](max) NULL,
 CONSTRAINT [PK__platform__3213E83FAE9DBCFE] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[platform_version_companies]    Script Date: 26/10/2023 22:06:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[platform_version_companies](
	[id] [int] NOT NULL,
	[checksum] [varchar](36) NULL,
	[comment] [varchar](max) NULL,
	[company] [bigint] NULL,
	[developer] [varchar](5) NULL,
	[manufacturer] [varchar](5) NULL,
 CONSTRAINT [PK__platform__3213E83F1499FEE4] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[platform_version_release_dates]    Script Date: 26/10/2023 22:06:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[platform_version_release_dates](
	[id] [int] NOT NULL,
	[category] [int] NULL,
	[checksum] [varchar](36) NULL,
	[created_at] [bigint] NULL,
	[date] [bigint] NULL,
	[human] [varchar](max) NULL,
	[m] [int] NULL,
	[platform_version] [int] NULL,
	[region] [int] NULL,
	[updated_at] [bigint] NULL,
	[y] [int] NULL,
 CONSTRAINT [PK__platform__3213E83F6F715D19] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[platform_versions]    Script Date: 26/10/2023 22:06:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[platform_versions](
	[id] [int] NOT NULL,
	[checksum] [varchar](36) NULL,
	[companies] [varchar](max) NULL,
	[connectivity] [varchar](max) NULL,
	[cpu] [varchar](max) NULL,
	[graphics] [varchar](max) NULL,
	[main_manufacturer] [int] NULL,
	[media] [varchar](max) NULL,
	[memory] [varchar](max) NULL,
	[name] [varchar](max) NULL,
	[online] [varchar](max) NULL,
	[os] [varchar](max) NULL,
	[output] [varchar](max) NULL,
	[platform_logo] [int] NULL,
	[platform_version_release_dates] [varchar](max) NULL,
	[resolutions] [varchar](max) NULL,
	[slug] [varchar](max) NULL,
	[sound] [varchar](max) NULL,
	[storage] [varchar](max) NULL,
	[summary] [varchar](max) NULL,
	[url] [varchar](max) NULL,
 CONSTRAINT [PK__platform__3213E83F4FB675C1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[platform_websites]    Script Date: 26/10/2023 22:06:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[platform_websites](
	[id] [int] NOT NULL,
	[category] [int] NULL,
	[checksum] [varchar](36) NULL,
	[trusted] [varchar](5) NULL,
	[url] [varchar](max) NULL,
 CONSTRAINT [PK__platform__3213E83FB7B360F0] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[platforms]    Script Date: 26/10/2023 22:06:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[platforms](
	[id] [int] NOT NULL,
	[abbreviation] [varchar](max) NULL,
	[alternative_name] [varchar](max) NULL,
	[category] [int] NULL,
	[checksum] [varchar](36) NULL,
	[created_at] [bigint] NULL,
	[generation] [int] NULL,
	[name] [varchar](max) NULL,
	[platform_family] [int] NULL,
	[platform_logo] [int] NULL,
	[slug] [varchar](max) NULL,
	[summary] [varchar](max) NULL,
	[updated_at] [bigint] NULL,
	[url] [varchar](max) NULL,
	[versions] [varchar](max) NULL,
	[websites] [varchar](max) NULL,
 CONSTRAINT [PK__platform__3213E83FFC163939] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[player_perspectives]    Script Date: 26/10/2023 22:06:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[player_perspectives](
	[id] [int] NOT NULL,
	[checksum] [varchar](36) NULL,
	[created_at] [bigint] NULL,
	[name] [varchar](max) NULL,
	[slug] [varchar](max) NULL,
	[updated_at] [bigint] NULL,
	[url] [varchar](max) NULL,
 CONSTRAINT [PK__player_p__3213E83FFF3DE428] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[regions]    Script Date: 26/10/2023 22:06:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[regions](
	[id] [int] NOT NULL,
	[category] [varchar](max) NULL,
	[checksum] [varchar](36) NULL,
	[created_at] [bigint] NULL,
	[identifier] [varchar](max) NULL,
	[name] [varchar](max) NULL,
	[updated_at] [bigint] NULL,
 CONSTRAINT [PK__regions__3213E83FF7F19929] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[release_date_statuses]    Script Date: 26/10/2023 22:06:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[release_date_statuses](
	[id] [int] NOT NULL,
	[checksum] [varchar](36) NULL,
	[created_at] [bigint] NULL,
	[description] [varchar](max) NULL,
	[name] [varchar](max) NULL,
	[updated_at] [bigint] NULL,
 CONSTRAINT [PK__release___3213E83FC03A550B] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[release_dates]    Script Date: 26/10/2023 22:06:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[release_dates](
	[id] [int] NOT NULL,
	[category] [int] NULL,
	[checksum] [varchar](36) NULL,
	[created_at] [bigint] NULL,
	[date] [bigint] NULL,
	[game] [int] NULL,
	[human] [varchar](max) NULL,
	[m] [int] NULL,
	[platform] [int] NULL,
	[region] [int] NULL,
	[status] [int] NULL,
	[updated_at] [bigint] NULL,
	[y] [int] NULL,
 CONSTRAINT [PK__release___3213E83F87CEBE6B] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[search]    Script Date: 26/10/2023 22:06:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[search](
	[id] [int] NOT NULL,
	[alternative_name] [varchar](max) NULL,
	[character] [int] NULL,
	[checksum] [varchar](36) NULL,
	[collection] [int] NULL,
	[company] [bigint] NULL,
	[description] [varchar](max) NULL,
	[game] [int] NULL,
	[name] [varchar](max) NULL,
	[platform] [int] NULL,
	[published_at] [bigint] NULL,
	[test_dummy] [int] NULL,
	[theme] [int] NULL,
 CONSTRAINT [PK__search__3213E83F35E01184] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[themes]    Script Date: 26/10/2023 22:06:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[themes](
	[id] [int] NOT NULL,
	[checksum] [varchar](36) NULL,
	[created_at] [bigint] NULL,
	[name] [varchar](max) NULL,
	[slug] [varchar](max) NULL,
	[updated_at] [bigint] NULL,
	[url] [varchar](max) NULL,
 CONSTRAINT [PK__themes__3213E83F107A2C5E] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[websites]    Script Date: 26/10/2023 22:06:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[websites](
	[id] [int] NOT NULL,
	[category] [int] NULL,
	[checksum] [varchar](36) NULL,
	[game] [int] NULL,
	[trusted] [varchar](5) NULL,
	[url] [varchar](max) NULL,
 CONSTRAINT [PK__websites__3213E83F7BAE030D] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[alternative_names]  WITH NOCHECK ADD  CONSTRAINT [FK_alternative_names_games] FOREIGN KEY([game])
REFERENCES [dbo].[games] ([id])
GO
ALTER TABLE [dbo].[alternative_names] NOCHECK CONSTRAINT [FK_alternative_names_games]
GO
ALTER TABLE [dbo].[characters]  WITH NOCHECK ADD  CONSTRAINT [FK_characters_character_mug_shots] FOREIGN KEY([mug_shot])
REFERENCES [dbo].[character_mug_shots] ([id])
GO
ALTER TABLE [dbo].[characters] NOCHECK CONSTRAINT [FK_characters_character_mug_shots]
GO
ALTER TABLE [dbo].[external_games]  WITH NOCHECK ADD  CONSTRAINT [FK_external_games_games] FOREIGN KEY([game])
REFERENCES [dbo].[games] ([id])
GO
ALTER TABLE [dbo].[external_games] NOCHECK CONSTRAINT [FK_external_games_games]
GO
ALTER TABLE [dbo].[game_version_feature_values]  WITH NOCHECK ADD  CONSTRAINT [FK_game_version_feature_values_games] FOREIGN KEY([game])
REFERENCES [dbo].[games] ([id])
GO
ALTER TABLE [dbo].[game_version_feature_values] NOCHECK CONSTRAINT [FK_game_version_feature_values_games]
GO
ALTER TABLE [dbo].[game_versions]  WITH NOCHECK ADD  CONSTRAINT [FK_game_versions_games] FOREIGN KEY([game])
REFERENCES [dbo].[games] ([id])
GO
ALTER TABLE [dbo].[game_versions] NOCHECK CONSTRAINT [FK_game_versions_games]
GO
ALTER TABLE [dbo].[game_videos]  WITH NOCHECK ADD  CONSTRAINT [FK_game_videos_games] FOREIGN KEY([game])
REFERENCES [dbo].[games] ([id])
GO
ALTER TABLE [dbo].[game_videos] NOCHECK CONSTRAINT [FK_game_videos_games]
GO
ALTER TABLE [dbo].[games]  WITH NOCHECK ADD  CONSTRAINT [FK_games_collections] FOREIGN KEY([collection])
REFERENCES [dbo].[collections] ([id])
GO
ALTER TABLE [dbo].[games] NOCHECK CONSTRAINT [FK_games_collections]
GO
ALTER TABLE [dbo].[games]  WITH NOCHECK ADD  CONSTRAINT [FK_games_franchises] FOREIGN KEY([franchise])
REFERENCES [dbo].[franchises] ([id])
GO
ALTER TABLE [dbo].[games] NOCHECK CONSTRAINT [FK_games_franchises]
GO
ALTER TABLE [dbo].[involved_companies]  WITH NOCHECK ADD  CONSTRAINT [FK_involved_companies_companies] FOREIGN KEY([company])
REFERENCES [dbo].[companies] ([id])
GO
ALTER TABLE [dbo].[involved_companies] NOCHECK CONSTRAINT [FK_involved_companies_companies]
GO
ALTER TABLE [dbo].[involved_companies]  WITH NOCHECK ADD  CONSTRAINT [FK_involved_companies_games] FOREIGN KEY([game])
REFERENCES [dbo].[games] ([id])
GO
ALTER TABLE [dbo].[involved_companies] NOCHECK CONSTRAINT [FK_involved_companies_games]
GO
ALTER TABLE [dbo].[language_supports]  WITH NOCHECK ADD  CONSTRAINT [FK_language_supports_games] FOREIGN KEY([game])
REFERENCES [dbo].[games] ([id])
GO
ALTER TABLE [dbo].[language_supports] NOCHECK CONSTRAINT [FK_language_supports_games]
GO
ALTER TABLE [dbo].[language_supports]  WITH NOCHECK ADD  CONSTRAINT [FK_language_supports_language_support_types] FOREIGN KEY([language_support_type])
REFERENCES [dbo].[language_support_types] ([id])
GO
ALTER TABLE [dbo].[language_supports] NOCHECK CONSTRAINT [FK_language_supports_language_support_types]
GO
ALTER TABLE [dbo].[multiplayer_modes]  WITH NOCHECK ADD  CONSTRAINT [FK_multiplayer_modes_games] FOREIGN KEY([game])
REFERENCES [dbo].[games] ([id])
GO
ALTER TABLE [dbo].[multiplayer_modes] NOCHECK CONSTRAINT [FK_multiplayer_modes_games]
GO
ALTER TABLE [dbo].[platform_version_companies]  WITH NOCHECK ADD  CONSTRAINT [FK_platform_version_companies_companies] FOREIGN KEY([company])
REFERENCES [dbo].[companies] ([id])
GO
ALTER TABLE [dbo].[platform_version_companies] NOCHECK CONSTRAINT [FK_platform_version_companies_companies]
GO
ALTER TABLE [dbo].[platform_version_release_dates]  WITH NOCHECK ADD  CONSTRAINT [FK_platform_version_release_dates_platform_versions] FOREIGN KEY([platform_version])
REFERENCES [dbo].[platform_versions] ([id])
GO
ALTER TABLE [dbo].[platform_version_release_dates] NOCHECK CONSTRAINT [FK_platform_version_release_dates_platform_versions]
GO
ALTER TABLE [dbo].[platform_versions]  WITH NOCHECK ADD  CONSTRAINT [FK_platform_versions_platform_version_companies] FOREIGN KEY([main_manufacturer])
REFERENCES [dbo].[platform_version_companies] ([id])
GO
ALTER TABLE [dbo].[platform_versions] NOCHECK CONSTRAINT [FK_platform_versions_platform_version_companies]
GO
ALTER TABLE [dbo].[release_dates]  WITH NOCHECK ADD  CONSTRAINT [FK_release_dates_games] FOREIGN KEY([game])
REFERENCES [dbo].[games] ([id])
GO
ALTER TABLE [dbo].[release_dates] NOCHECK CONSTRAINT [FK_release_dates_games]
GO
ALTER TABLE [dbo].[release_dates]  WITH NOCHECK ADD  CONSTRAINT [FK_release_dates_release_date_statuses] FOREIGN KEY([status])
REFERENCES [dbo].[release_date_statuses] ([id])
GO
ALTER TABLE [dbo].[release_dates] NOCHECK CONSTRAINT [FK_release_dates_release_date_statuses]
GO
ALTER TABLE [dbo].[search]  WITH NOCHECK ADD  CONSTRAINT [FK_search_collections] FOREIGN KEY([collection])
REFERENCES [dbo].[collections] ([id])
GO
ALTER TABLE [dbo].[search] NOCHECK CONSTRAINT [FK_search_collections]
GO
ALTER TABLE [dbo].[search]  WITH NOCHECK ADD  CONSTRAINT [FK_search_companies] FOREIGN KEY([company])
REFERENCES [dbo].[companies] ([id])
GO
ALTER TABLE [dbo].[search] NOCHECK CONSTRAINT [FK_search_companies]
GO
ALTER TABLE [dbo].[search]  WITH NOCHECK ADD  CONSTRAINT [FK_search_games] FOREIGN KEY([game])
REFERENCES [dbo].[games] ([id])
GO
ALTER TABLE [dbo].[search] NOCHECK CONSTRAINT [FK_search_games]
GO
ALTER TABLE [dbo].[search]  WITH NOCHECK ADD  CONSTRAINT [FK_search_themes] FOREIGN KEY([theme])
REFERENCES [dbo].[themes] ([id])
GO
ALTER TABLE [dbo].[search] NOCHECK CONSTRAINT [FK_search_themes]
GO
ALTER TABLE [dbo].[websites]  WITH NOCHECK ADD  CONSTRAINT [FK_websites_games] FOREIGN KEY([game])
REFERENCES [dbo].[games] ([id])
GO
ALTER TABLE [dbo].[websites] NOCHECK CONSTRAINT [FK_websites_games]
GO
/****** Object:  StoredProcedure [dbo].[c2]    Script Date: 26/10/2023 22:06:03 ******/
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
/****** Object:  StoredProcedure [dbo].[c2_testing_erwin]    Script Date: 26/10/2023 22:06:03 ******/
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
/****** Object:  StoredProcedure [dbo].[c3]    Script Date: 26/10/2023 22:06:03 ******/
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
/****** Object:  StoredProcedure [dbo].[c3xtra]    Script Date: 26/10/2023 22:06:03 ******/
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
/****** Object:  StoredProcedure [dbo].[c5]    Script Date: 26/10/2023 22:06:03 ******/
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
/****** Object:  StoredProcedure [dbo].[GetTop100GamesWithLanguageSupports]    Script Date: 26/10/2023 22:06:03 ******/
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
/****** Object:  StoredProcedure [dbo].[infogame]    Script Date: 26/10/2023 22:06:03 ******/
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
USE [master]
GO
ALTER DATABASE [PROYECTO_CLASE] SET  READ_WRITE 
GO

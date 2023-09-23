
--! ------------------ PROCEDURE GENERAL ------------------
-- Stored procedure que reciba un parámetro alfanumérico para buscar juegos por nombre (palabras o aproximaciones). 
DROP PROCEDURE IF EXISTS infogame;
GO
CREATE PROCEDURE infogame
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

EXEC infogame 'The Legend of Zelda: Phantom Hourglass' 
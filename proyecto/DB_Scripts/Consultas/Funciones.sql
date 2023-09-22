
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

    -- Eliminar la coma adicional al final
    SET @genreNames = LEFT(@genreNames, LEN(@genreNames) - 1);

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

		-- Eliminar la coma adicional al final
		SET @genreNames = LEFT(@genreNames, LEN(@genreNames) - 1);

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

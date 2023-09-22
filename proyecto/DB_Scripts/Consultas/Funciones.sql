
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

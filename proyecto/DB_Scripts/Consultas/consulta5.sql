
--! ------------------ CONSULTA 5------------------
-- Consulta que muestre el top los juegos por genero, ordenados por rating
DROP PROCEDURE IF EXISTS c5;
GO
CREATE PROCEDURE c5
AS
BEGIN
    SELECT TOP (1000) [id]
        ,[name]
        ,ROUND([rating], 2)
        ,(SELECT dbo.obtenerGeneros([genres])) as Generos
        ,[aggregated_rating]
        ,[platforms]
        ,url
    FROM [PROYECTO_CLASE].[dbo].[games]
    ORDER BY [rating] DESC

END;
GO

EXEC c5;
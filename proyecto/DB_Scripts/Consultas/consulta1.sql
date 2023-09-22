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

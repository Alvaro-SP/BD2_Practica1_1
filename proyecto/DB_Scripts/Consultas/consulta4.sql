
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


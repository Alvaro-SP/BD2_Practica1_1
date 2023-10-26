

-- * 1. Truncar la bitácora: Para truncar la bitácora de transacciones de una base de datos,
USE [PROYECTO_CLASE];
GO
CHECKPOINT;
GO
DBCC SHRINKFILE(N'PROYECTO_CLASE_log', 1);
GO

-- * 2. Obtener el collation de las tablas y columnas
SELECT 
    t.name AS TableName,
    c.name AS ColumnName,
    c.collation_name 
FROM 
    sys.columns c
INNER JOIN 
    sys.tables t ON c.object_id = t.object_id;


-- * 3. Obtener la fragmentación de los índices:
SELECT 
    DB_NAME(database_id) AS DatabaseName,
    OBJECT_NAME(ps.OBJECT_ID) AS TableName,
    i.name AS IndexName,
    ps.index_id,
    index_type_desc,
    avg_fragmentation_in_percent
FROM 
    sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL , 'LIMITED') ps
INNER JOIN 
    sys.indexes i ON ps.OBJECT_ID = i.OBJECT_ID AND ps.index_id = i.index_id
WHERE 
    avg_fragmentation_in_percent > 0.0  
ORDER BY 
    avg_fragmentation_in_percent DESC;
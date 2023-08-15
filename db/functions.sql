-- Functions


--Function5 "Func_logger"
-- Crear la función
CREATE FUNCTION Func_logger()
RETURNS @Resultados TABLE (
    Id INT,
    Date DATETIME2(7),
    Description NVARCHAR(MAX)
)
AS
BEGIN
  BEGIN TRY
    BEGIN TRANSACTION;
      INSERT INTO @Resultados
      SELECT Id, Date, Description
      FROM practica1.HistoryLog;
      COMMIT TRANSACTION;
  END TRY
  BEGIN CATCH
    IF @@TRANCOUNT > 0
      ROLLBACK TRANSACTION;
      -- En caso de error, mensaje de error
    DECLARE @ErrorMessage NVARCHAR(4000) = 'Error, no se pudieron obtener los resultados de la tabla HistoryLog';
    THROW 50001, @ErrorMessage, 1;
  END CATCH;
  RETURN;
END;

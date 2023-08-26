DROP FUNCTION IF EXISTS dbo.Func_logger;
GO
--Function 4 "Func_logger"
CREATE FUNCTION Func_logger()
RETURNS TABLE
AS
RETURN(
SELECT *
    FROM practica1.historyLog
);

-- Execute function 4 "Func_Logger"
-- SELECT * FROM dbo.Func_logger();
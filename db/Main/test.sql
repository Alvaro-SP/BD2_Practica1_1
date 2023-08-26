-- antes de crear constrains
SELECT * FROM [practica1].[Usuarios];
SELECT * FROM [practica1].[Course];

INSERT INTO [practica1].[Course] ([CodCourse], [Name], [CreditsRequired])
VALUES (3, '11111 nombre malo', 5);

INSERT INTO [practica1].[Course] ([CodCourse], [Name], [CreditsRequired])
VALUES (4, 'nombre_bueno_malos_creditos', '-1');



--- Inicio procedures
EXEC PR6;

EXEC PR1  '11 John', 'Doe', 'socop241ee2@gmail.com', '1990-01-15', 'SecurePassword123', 0;
EXEC PR1  'John', 'Doe', 'socop241ee2@gmail.com', '1990-01-15', 'SecurePassword123', 0;

EXEC PR1  'Sergie', 'Arizandieta', 'sergiearizandieta@gmail.com', '2002-05-22', 'usac', 0;
EXEC PR1  'Alvaro', 'socop', 'Alvarosocop@gmail.com', '1990-01-15', 'usac1', 0;
EXEC PR1  'Erwin', 'Vasquez', 'ErwinVasquez@gmail.com', '2000-01-15', 'usac2', 0;
EXEC PR1  'EjemplarFist', 'EjemplarLast', 'Ejemplar@gmail.com', '2000-01-15', 'usac3', 100;
EXEC PR1  'UnicoFist', 'UnicoLast', 'Unico@gmail.com', '2000-01-15', 'usac4', 1000;

EXEC PR1  'testfist', 'testlast', 'sergieariz123123', '2002-05-22', 'usac', 0;  -- Err correo
EXEC PR1  '111 testfist', 'testlast', 'test@gmail.com', '2002-05-22', 'usac', 0; -- Err fistname
EXEC PR1  'testfist', '2222 testlast', 'test@gmail.com', '2002-05-22', 'usac', 0; -- Err lastname


EXEC PR2 'test1 ', 772; -- Err cuenta activa

EXEC PR2 'ErwinVasquez@gmail.com', 772;
EXEC PR2 'Alvarosocop@gmail.com', 775;
EXEC PR2 'ErwinVasquez@gmail.com', 772; -- Err ya esta asignado al curso
EXEC PR2 'Alvarosocop@gmail.com', 772; -- Err el curso ya tiene tutor asignado
EXEC PR2 'ErwinVasquez@gmail.com', 283; 

EXEC PR3 'sergiearizandieta@gmail.com',775; -- Err creditos insuficientes
EXEC PR3 'sergiearizandie',775; -- Err correo invalido
EXEC PR3 'sasdas@gmail.com',775; -- Err usuario no encontrado
EXEC PR3 'Ejemplar@gmail.com',775;
EXEC PR3 'Ejemplar@gmail.com',775; -- Err estudainte ya asignado
EXEC PR3 'Ejemplar@gmail.com',666; -- Err creditos insuficientes

EXEC PR4 'NuevoRol 3';
EXEC PR4 '123 NuevoRol 4'; -- Err role invalido
EXEC PR4 'NuevoRol 3'; -- Err role ya existe


EXEC PR5 772,'Manejo e Implementacion de Archivos',4; --  Err por cod repetido
EXEC PR5 773,'123 Manejo e Implementacion de Archivos',4; -- Err nombre invalido
EXEC PR5 773,'Manejo e Implementacion de Archivos',-1; --  Err creditos negativos
EXEC PR5 773,'Manejo e Implementacion de Archivos',4;


EXEC PR3 'sergiearizandieta@gmail.com',773;
EXEC PR4 'NuevoRol 3';
EXEC PR5 773,'Manejo e Implementacion de Archivos',4;

--- Inicio funciones

SELECT * FROM dbo.Func_course_usuarios(775); -- F1
SELECT * FROM dbo.Func_course_usuarios(7735); -- cod curso incorrecta 

SELECT * FROM dbo.Func_tutor_course('6FF04ABF-0432-4094-B72E-40A232103ABD'); -- F2
SELECT * FROM dbo.Func_tutor_course('7B678DD0-1507-448A-9A10-D0BFB96D7BDB'); 
SELECT * FROM dbo.Func_tutor_course('7B678DD0-1507-448A-9A10-D0BFB96D7BDZ'); -- err id

SELECT * FROM dbo.Func_notification_usuarios('B1E877DB-BACD-42F6-BEC1-DE4CB89903BB'); -- F3
SELECT * FROM dbo.Func_notification_usuarios('B1E877DB-BACD-42F6-BEC1-D0BFB96D7BDZ'); -- err id

SELECT * FROM dbo.Func_logger(); -- F4

SELECT * FROM dbo.Func_usuarios('3F1069D0-F94E-4104-8885-B83092837BE0'); -- F5

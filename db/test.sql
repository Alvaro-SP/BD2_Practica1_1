EXEC PR1  '11 John', 'Doe', 'socop241ee2@gmail.com', '1990-01-15', 'SecurePassword123', 0;
EXEC PR1  'John', 'Doe', 'socop241ee2@gmail.com', '1990-01-15', 'SecurePassword123', 0;

EXEC PR1  'Sergie', 'Arizandieta', 'sergiearizandieta@gmail.com', '2002-05-22', 'usac', 0;
EXEC PR1  'Alvaro', 'socop', 'Alvarosocop@gmail.com', '1990-01-15', 'usac1', 0;
EXEC PR1  'Erwin', 'Vasquez', 'ErwinVasquez@gmail.com', '2000-01-15', 'usac2', 0;
EXEC PR1  'EjemplarFist', 'EjemplarLast', 'Ejemplar@gmail.com', '2000-01-15', 'usac3', 100;

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


EXEC PR3 'sergiearizandieta@gmail.com',773;
EXEC PR4 'NuevoRol 3';
EXEC PR5 773,'Manejo e Implementacion de Archivos',4;

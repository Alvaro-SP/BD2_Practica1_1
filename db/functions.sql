--Functions--------------------------

--Function 1 "Func_credits"
USE BD2
GO

CREATE FUNCTION GetStudentsInCourse
(
    @CourseCodCourse INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT
        ca.Id AS CourseAssignmentId,
        u.Firstname,
        u.Lastname,
        u.Email
    FROM
        practica1.CourseAssignment ca
    INNER JOIN
        practica1.Usuarios u ON ca.StudentId = u.Id
    WHERE
        ca.CourseCodCourse = @CourseCodCourse
);

--Function 2 "Func_tutor_course"
USE BD2
GO

CREATE FUNCTION GetCoursesForTutor
(
    @TutorId UNIQUEIDENTIFIER
)
RETURNS TABLE
AS
RETURN
(
    SELECT
        ct.Id AS CourseTutorId,
        c.CodCourse,
        c.Name AS CourseName,
        c.CreditsRequired
    FROM
        practica1.CourseTutor ct
    INNER JOIN
        practica1.Course c ON ct.CourseCodCourse = c.CodCourse
    WHERE
        ct.TutorId = @TutorId
);


--Function 4 "Func_logger"
CREATE FUNCTION Func_logger()
RETURNS TABLE
AS
RETURN(
SELECT *
    FROM practica1.historyLog
);

-- Execute function 4 "Func_Logger"
SELECT * FROM dbo.Func_logger();

-- Function 5 "Func_usuarios"
CREATE FUNCTION Func_usuarios(@UserId uniqueidentifier)
RETURNS TABLE
AS
RETURN(
SELECT u.Firstname, u.Lastname, u.Email, u.DateOfBirth, uc.Credits, r.RoleName
    FROM practica1.Usuarios u
    INNER JOIN practica1.UsuarioRole ur ON u.Id = ur.UserId
    INNER JOIN practica1.Roles r ON ur.RoleId = r.Id
	INNER JOIN practica1.ProfileStudent uc ON ur.UserId = @UserId
    WHERE u.Id = @UserId
);

-- Execute function 5 "Func_usuarios"
SELECT * FROM dbo.Func_usuarios(5);



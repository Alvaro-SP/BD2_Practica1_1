DROP FUNCTION IF EXISTS dbo.Func_course_usuarios;
GO
CREATE FUNCTION Func_course_usuarios
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
GO
SELECT * FROM dbo.Func_course_usuarios(773);
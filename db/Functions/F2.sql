DROP FUNCTION IF EXISTS dbo.Func_tutor_course;
GO
CREATE FUNCTION Func_tutor_course
(
    @TutorId UNIQUEIDENTIFIER
)
RETURNS TABLE
AS
RETURN
(
    SELECT
        ct.Id AS CourseTutorId,
        c.CodCourse AS CodeCourse,
        c.Name AS CourseName,
        c.CreditsRequired
    FROM
        practica1.CourseTutor ct
    INNER JOIN
        practica1.Course c ON ct.CourseCodCourse = c.CodCourse
    WHERE
        ct.TutorId = @TutorId
);
GO
SELECT * FROM dbo.Func_tutor_course('8BFE0823-0E7C-4D9E-B0BB-B46886D67641');
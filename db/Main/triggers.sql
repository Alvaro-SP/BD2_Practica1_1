-- ! VER TRIGGERS CREADOS
SELECT name AS TriggerName, OBJECT_NAME(parent_id) AS TableName, type_desc AS TriggerType
FROM sys.triggers;
-- Eliminar triggers en orden inverso
-- Drop triggers de la tabla practica1.TFA
IF OBJECT_ID('practica1.trg_InsertHistory_TFA', 'TR') IS NOT NULL
    DROP TRIGGER practica1.trg_InsertHistory_TFA;
IF OBJECT_ID('practica1.trg_DeleteHistory_TFA', 'TR') IS NOT NULL
    DROP TRIGGER practica1.trg_DeleteHistory_TFA;

-- Drop triggers de la tabla practica1.UsuarioRole
IF OBJECT_ID('practica1.trg_InsertHistory_UsuarioRole', 'TR') IS NOT NULL
    DROP TRIGGER practica1.trg_InsertHistory_UsuarioRole;
IF OBJECT_ID('practica1.trg_DeleteHistory_UsuarioRole', 'TR') IS NOT NULL
    DROP TRIGGER practica1.trg_DeleteHistory_UsuarioRole;
IF OBJECT_ID('practica1.trg_UpdateHistory_UsuarioRole', 'TR') IS NOT NULL
    DROP TRIGGER practica1.trg_UpdateHistory_UsuarioRole;

-- Drop triggers de la tabla practica1.CourseTutor
IF OBJECT_ID('practica1.trg_InsertHistory_CourseTutor', 'TR') IS NOT NULL
    DROP TRIGGER practica1.trg_InsertHistory_CourseTutor;
IF OBJECT_ID('practica1.trg_DeleteHistory_CourseTutor', 'TR') IS NOT NULL
    DROP TRIGGER practica1.trg_DeleteHistory_CourseTutor;
IF OBJECT_ID('practica1.trg_UpdateHistory_CourseTutor', 'TR') IS NOT NULL
    DROP TRIGGER practica1.trg_UpdateHistory_CourseTutor;

-- Drop triggers de la tabla practica1.CourseAssignment
IF OBJECT_ID('practica1.trg_InsertHistory_CourseAssignment', 'TR') IS NOT NULL
    DROP TRIGGER practica1.trg_InsertHistory_CourseAssignment;
IF OBJECT_ID('practica1.trg_DeleteHistory_CourseAssignment', 'TR') IS NOT NULL
    DROP TRIGGER practica1.trg_DeleteHistory_CourseAssignment;
IF OBJECT_ID('practica1.trg_UpdateHistory_CourseAssignment', 'TR') IS NOT NULL
    DROP TRIGGER practica1.trg_UpdateHistory_CourseAssignment;

-- Drop triggers de la tabla practica1.Course
IF OBJECT_ID('practica1.trg_InsertHistory_Course', 'TR') IS NOT NULL
    DROP TRIGGER practica1.trg_InsertHistory_Course;
IF OBJECT_ID('practica1.trg_DeleteHistory_Course', 'TR') IS NOT NULL
    DROP TRIGGER practica1.trg_DeleteHistory_Course;
IF OBJECT_ID('practica1.trg_UpdateHistory_Course', 'TR') IS NOT NULL
    DROP TRIGGER practica1.trg_UpdateHistory_Course;

-- Drop triggers de la tabla practica1.Notification
IF OBJECT_ID('practica1.trg_InsertHistory_Notification', 'TR') IS NOT NULL
    DROP TRIGGER practica1.trg_InsertHistory_Notification;
IF OBJECT_ID('practica1.trg_DeleteHistory_Notification', 'TR') IS NOT NULL
    DROP TRIGGER practica1.trg_DeleteHistory_Notification;
IF OBJECT_ID('practica1.trg_UpdateHistory_Notification', 'TR') IS NOT NULL
    DROP TRIGGER practica1.trg_UpdateHistory_Notification;

-- Drop triggers de la tabla practica1.ProfileStudent
IF OBJECT_ID('practica1.trg_InsertHistory_ProfileStudent', 'TR') IS NOT NULL
    DROP TRIGGER practica1.trg_InsertHistory_ProfileStudent;
IF OBJECT_ID('practica1.trg_DeleteHistory_ProfileStudent', 'TR') IS NOT NULL
    DROP TRIGGER practica1.trg_DeleteHistory_ProfileStudent;
IF OBJECT_ID('practica1.trg_UpdateHistory_ProfileStudent', 'TR') IS NOT NULL
    DROP TRIGGER practica1.trg_UpdateHistory_ProfileStudent;

-- Drop triggers de la tabla practica1.TutorProfile
IF OBJECT_ID('practica1.trg_InsertHistory_TutorProfile', 'TR') IS NOT NULL
    DROP TRIGGER practica1.trg_InsertHistory_TutorProfile;
IF OBJECT_ID('practica1.trg_DeleteHistory_TutorProfile', 'TR') IS NOT NULL
    DROP TRIGGER practica1.trg_DeleteHistory_TutorProfile;
IF OBJECT_ID('practica1.trg_UpdateHistory_TutorProfile', 'TR') IS NOT NULL
    DROP TRIGGER practica1.trg_UpdateHistory_TutorProfile;

-- Drop triggers de la tabla practica1.Usuarios
IF OBJECT_ID('practica1.trg_InsertHistory_Usuarios', 'TR') IS NOT NULL
    DROP TRIGGER practica1.trg_InsertHistory_Usuarios;
IF OBJECT_ID('practica1.trg_DeleteHistory_Usuarios', 'TR') IS NOT NULL
    DROP TRIGGER practica1.trg_DeleteHistory_Usuarios;
IF OBJECT_ID('practica1.trg_UpdateHistory_Usuarios', 'TR') IS NOT NULL
    DROP TRIGGER practica1.trg_UpdateHistory_Usuarios;

GO



-- Trigger para INSERT en HistoryLog_Course
    CREATE OR ALTER TRIGGER trg_InsertHistory_Course
    ON [practica1].[Course]
    AFTER INSERT
    AS
    BEGIN
        DECLARE @Description nvarchar(max);
        
        SELECT @Description = 'Se ha insertado un nuevo registro en la tabla [practica1].[Course]: ' +
                            'CodCourse: ' + CAST(INSERTED.CodCourse AS nvarchar(max)) + ', ' +
                            'Name: ''' + INSERTED.Name + ''', ' +  -- Escapar manualmente el valor de Name
                            'CreditsRequired: ' + CAST(INSERTED.CreditsRequired AS nvarchar(max))
        FROM INSERTED;
        
        INSERT INTO [practica1].[HistoryLog] (Date, Description)
        VALUES (GETDATE(), @Description);
    END;
GO
-- Trigger para DELETE en HistoryLog_Course
    CREATE OR ALTER TRIGGER trg_DeleteHistory_Course
    ON [practica1].[Course]
    AFTER DELETE
    AS
    BEGIN
        DECLARE @Description nvarchar(max);
        
        SELECT @Description = 'Se ha eliminado un registro de la tabla [practica1].[Course]: ' +
                            'CodCourse: ' + CAST(DELETED.CodCourse AS nvarchar(max)) + ', ' +
                            'Name: ''' + DELETED.Name + ''', ' +  -- Escapar manualmente el valor de Name
                            'CreditsRequired: ' + CAST(DELETED.CreditsRequired AS nvarchar(max))
        FROM DELETED;
        
        INSERT INTO [practica1].[HistoryLog] (Date, Description)
        VALUES (GETDATE(), @Description);
    END;
GO
-- Trigger para UPDATE en HistoryLog_Course
    CREATE OR ALTER TRIGGER trg_UpdateHistory_Course
    ON [practica1].[Course]
    AFTER UPDATE
    AS
    BEGIN
        DECLARE @OldDescription nvarchar(max), @NewDescription nvarchar(max);
        
        SELECT @OldDescription = 'Registro modificado (Antiguo) en la tabla [practica1].[Course]: ' +
                                'CodCourse: ' + CAST(DELETED.CodCourse AS nvarchar(max)) + ', ' +
                                'Name: ''' + DELETED.Name + ''', ' +  -- Escapar manualmente el valor de Name
                                'CreditsRequired: ' + CAST(DELETED.CreditsRequired AS nvarchar(max)),
            @NewDescription = 'Registro modificado (Nuevo) en la tabla [practica1].[Course]: ' +
                                'CodCourse: ' + CAST(INSERTED.CodCourse AS nvarchar(max)) + ', ' +
                                'Name: ''' + INSERTED.Name + ''', ' +  -- Escapar manualmente el valor de Name
                                'CreditsRequired: ' + CAST(INSERTED.CreditsRequired AS nvarchar(max))
        FROM DELETED
        JOIN INSERTED ON DELETED.CodCourse = INSERTED.CodCourse;
        
        INSERT INTO [practica1].[HistoryLog] (Date, Description)
        VALUES (GETDATE(), @OldDescription);
        
        INSERT INTO [practica1].[HistoryLog] (Date, Description)
        VALUES (GETDATE(), @NewDescription);
    END;
GO






-- Trigger para INSERT en HistoryLog_CourseAssignment
    CREATE OR ALTER TRIGGER trg_InsertHistory_CourseAssignment
    ON [practica1].[CourseAssignment]
    AFTER INSERT
    AS
    BEGIN
        DECLARE @Description nvarchar(max);
        
        SELECT @Description = 'Se ha insertado un nuevo registro en la tabla [practica1].[CourseAssignment]: ' +
                            'Id: ' + CAST(INSERTED.Id AS nvarchar(max)) + ', ' +
                            'StudentId: ''' + CAST(INSERTED.StudentId AS nvarchar(max)) + ''', ' +  -- Escapar manualmente el valor de StudentId
                            'CourseCodCourse: ' + CAST(INSERTED.CourseCodCourse AS nvarchar(max))
        FROM INSERTED;
        
        INSERT INTO [practica1].[HistoryLog] (Date, Description)
        VALUES (GETDATE(), @Description);
    END;
GO
-- Trigger para DELETE en HistoryLog_CourseAssignment
    CREATE OR ALTER TRIGGER trg_DeleteHistory_CourseAssignment
    ON [practica1].[CourseAssignment]
    AFTER DELETE
    AS
    BEGIN
        DECLARE @Description nvarchar(max);
        
        SELECT @Description = 'Se ha eliminado un registro de la tabla [practica1].[CourseAssignment]: ' +
                            'Id: ' + CAST(DELETED.Id AS nvarchar(max)) + ', ' +
                            'StudentId: ''' + CAST(DELETED.StudentId AS nvarchar(max)) + ''', ' +  -- Escapar manualmente el valor de StudentId
                            'CourseCodCourse: ' + CAST(DELETED.CourseCodCourse AS nvarchar(max))
        FROM DELETED;
        
        INSERT INTO [practica1].[HistoryLog] (Date, Description)
        VALUES (GETDATE(), @Description);
    END;
GO
-- Trigger para UPDATE en HistoryLog_CourseAssignment
    CREATE OR ALTER TRIGGER trg_UpdateHistory_CourseAssignment
    ON [practica1].[CourseAssignment]
    AFTER UPDATE
    AS
    BEGIN
        DECLARE @OldDescription nvarchar(max), @NewDescription nvarchar(max);
        
        SELECT @OldDescription = 'Registro modificado (Antiguo) en la tabla [practica1].[CourseAssignment]: ' +
                                'Id: ' + CAST(DELETED.Id AS nvarchar(max)) + ', ' +
                                'StudentId: ''' + CAST(DELETED.StudentId AS nvarchar(max)) + ''', ' +  -- Escapar manualmente el valor de StudentId
                                'CourseCodCourse: ' + CAST(DELETED.CourseCodCourse AS nvarchar(max)),
            @NewDescription = 'Registro modificado (Nuevo) en la tabla [practica1].[CourseAssignment]: ' +
                                'Id: ' + CAST(INSERTED.Id AS nvarchar(max)) + ', ' +
                                'StudentId: ''' + CAST(INSERTED.StudentId AS nvarchar(max)) + ''', ' +  -- Escapar manualmente el valor de StudentId
                                'CourseCodCourse: ' + CAST(INSERTED.CourseCodCourse AS nvarchar(max))
        FROM DELETED
        JOIN INSERTED ON DELETED.Id = INSERTED.Id;
        
        INSERT INTO [practica1].[HistoryLog] (Date, Description)
        VALUES (GETDATE(), @OldDescription);
        
        INSERT INTO [practica1].[HistoryLog] (Date, Description)
        VALUES (GETDATE(), @NewDescription);
    END;
GO







-- Trigger para INSERT en HistoryLog_CourseTutor
    CREATE OR ALTER TRIGGER trg_InsertHistory_CourseTutor
    ON [practica1].[CourseTutor]
    AFTER INSERT
    AS
    BEGIN
        DECLARE @Description nvarchar(max);
        
        SELECT @Description = 'Se ha insertado un nuevo registro en la tabla [practica1].[CourseTutor]: ' +
                            'Id: ' + CAST(INSERTED.Id AS nvarchar(max)) + ', ' +
                            'TutorId: ''' + CAST(INSERTED.TutorId AS nvarchar(max)) + ''', ' +  -- Escapar manualmente el valor de TutorId
                            'CourseCodCourse: ' + CAST(INSERTED.CourseCodCourse AS nvarchar(max))
        FROM INSERTED;
        
        INSERT INTO [practica1].[HistoryLog] (Date, Description)
        VALUES (GETDATE(), @Description);
    END;
GO
-- Trigger para DELETE en HistoryLog_CourseTutor
    CREATE OR ALTER TRIGGER trg_DeleteHistory_CourseTutor
    ON [practica1].[CourseTutor]
    AFTER DELETE
    AS
    BEGIN
        DECLARE @Description nvarchar(max);
        
        SELECT @Description = 'Se ha eliminado un registro de la tabla [practica1].[CourseTutor]: ' +
                            'Id: ' + CAST(DELETED.Id AS nvarchar(max)) + ', ' +
                            'TutorId: ''' + CAST(DELETED.TutorId AS nvarchar(max)) + ''', ' +  -- Escapar manualmente el valor de TutorId
                            'CourseCodCourse: ' + CAST(DELETED.CourseCodCourse AS nvarchar(max))
        FROM DELETED;
        
        INSERT INTO [practica1].[HistoryLog] (Date, Description)
        VALUES (GETDATE(), @Description);
    END;
GO
-- Trigger para UPDATE en HistoryLog_CourseTutor
    CREATE OR ALTER TRIGGER trg_UpdateHistory_CourseTutor
    ON [practica1].[CourseTutor]
    AFTER UPDATE
    AS
    BEGIN
        DECLARE @OldDescription nvarchar(max), @NewDescription nvarchar(max);
        
        SELECT @OldDescription = 'Registro modificado (Antiguo) en la tabla [practica1].[CourseTutor]: ' +
                                'Id: ' + CAST(DELETED.Id AS nvarchar(max)) + ', ' +
                                'TutorId: ''' + CAST(DELETED.TutorId AS nvarchar(max)) + ''', ' +  -- Escapar manualmente el valor de TutorId
                                'CourseCodCourse: ' + CAST(DELETED.CourseCodCourse AS nvarchar(max)),
            @NewDescription = 'Registro modificado (Nuevo) en la tabla [practica1].[CourseTutor]: ' +
                                'Id: ' + CAST(INSERTED.Id AS nvarchar(max)) + ', ' +
                                'TutorId: ''' + CAST(INSERTED.TutorId AS nvarchar(max)) + ''', ' +  -- Escapar manualmente el valor de TutorId
                                'CourseCodCourse: ' + CAST(INSERTED.CourseCodCourse AS nvarchar(max))
        FROM DELETED
        JOIN INSERTED ON DELETED.Id = INSERTED.Id;
        
        INSERT INTO [practica1].[HistoryLog] (Date, Description)
        VALUES (GETDATE(), @OldDescription);
        
        INSERT INTO [practica1].[HistoryLog] (Date, Description)
        VALUES (GETDATE(), @NewDescription);
    END;
GO







-- Trigger para INSERT en HistoryLog_Notification
    CREATE OR ALTER TRIGGER trg_InsertHistory_Notification
    ON [practica1].[Notification]
    AFTER INSERT
    AS
    BEGIN
        DECLARE @Description nvarchar(max);
        
        SELECT @Description = 'Se ha insertado un nuevo registro en la tabla [practica1].[Notification]: ' +
                            'Id: ' + CAST(INSERTED.Id AS nvarchar(max)) + ', ' +
                            'UserId: ''' + CAST(INSERTED.UserId AS nvarchar(max)) + ''', ' +  -- Escapar manualmente el valor de UserId
                            'Message: ' + QUOTENAME(INSERTED.Message, '''') + ', ' +  -- Escapar manualmente el valor de Message
                            'Date: ' + CAST(INSERTED.Date AS nvarchar(max))
        FROM INSERTED;
        
        INSERT INTO [practica1].[HistoryLog] (Date, Description)
        VALUES (GETDATE(), @Description);
    END;
GO
-- Trigger para DELETE en HistoryLog_Notification
    CREATE OR ALTER TRIGGER trg_DeleteHistory_Notification
    ON [practica1].[Notification]
    AFTER DELETE
    AS
    BEGIN
        DECLARE @Description nvarchar(max);
        
        SELECT @Description = 'Se ha eliminado un registro de la tabla [practica1].[Notification]: ' +
                            'Id: ' + CAST(DELETED.Id AS nvarchar(max)) + ', ' +
                            'UserId: ''' + CAST(DELETED.UserId AS nvarchar(max)) + ''', ' +  -- Escapar manualmente el valor de UserId
                            'Message: ' + QUOTENAME(DELETED.Message, '''') + ', ' +  -- Escapar manualmente el valor de Message
                            'Date: ' + CAST(DELETED.Date AS nvarchar(max))
        FROM DELETED;
        
        INSERT INTO [practica1].[HistoryLog] (Date, Description)
        VALUES (GETDATE(), @Description);
    END;
GO
-- Trigger para UPDATE en HistoryLog_Notification
    CREATE OR ALTER TRIGGER trg_UpdateHistory_Notification
    ON [practica1].[Notification]
    AFTER UPDATE
    AS
    BEGIN
        DECLARE @OldDescription nvarchar(max), @NewDescription nvarchar(max);
        
        SELECT @OldDescription = 'Registro modificado (Antiguo) en la tabla [practica1].[Notification]: ' +
                                'Id: ' + CAST(DELETED.Id AS nvarchar(max)) + ', ' +
                                'UserId: ''' + CAST(DELETED.UserId AS nvarchar(max)) + ''', ' +  -- Escapar manualmente el valor de UserId
                                'Message: ' + QUOTENAME(DELETED.Message, '''') + ', ' +  -- Escapar manualmente el valor de Message
                                'Date: ' + CAST(DELETED.Date AS nvarchar(max)),
            @NewDescription = 'Registro modificado (Nuevo) en la tabla [practica1].[Notification]: ' +
                                'Id: ' + CAST(INSERTED.Id AS nvarchar(max)) + ', ' +
                                'UserId: ''' + CAST(INSERTED.UserId AS nvarchar(max)) + ''', ' +  -- Escapar manualmente el valor de UserId
                                'Message: ' + QUOTENAME(INSERTED.Message, '''') + ', ' +  -- Escapar manualmente el valor de Message
                                'Date: ' + CAST(INSERTED.Date AS nvarchar(max))
        FROM DELETED
        JOIN INSERTED ON DELETED.Id = INSERTED.Id;
        
        INSERT INTO [practica1].[HistoryLog] (Date, Description)
        VALUES (GETDATE(), @OldDescription);
        
        INSERT INTO [practica1].[HistoryLog] (Date, Description)
        VALUES (GETDATE(), @NewDescription);
    END;
GO







-- Trigger para INSERT en HistoryLog_ProfileStudent
    CREATE OR ALTER TRIGGER trg_InsertHistory_ProfileStudent
    ON [practica1].[ProfileStudent]
    AFTER INSERT
    AS
    BEGIN
        DECLARE @Description nvarchar(max);
        
        SELECT @Description = 'Se ha insertado un nuevo registro en la tabla [practica1].[ProfileStudent]: ' +
                            'Id: ' + CAST(INSERTED.Id AS nvarchar(max)) + ', ' +
                            'UserId: ''' + CAST(INSERTED.UserId AS nvarchar(max)) + ''', ' +  -- Escapar manualmente el valor de UserId
                            'Credits: ' + CAST(INSERTED.Credits AS nvarchar(max))
        FROM INSERTED;
        
        INSERT INTO [practica1].[HistoryLog] (Date, Description)
        VALUES (GETDATE(), @Description);
    END;
GO
-- Trigger para DELETE en HistoryLog_ProfileStudent
    CREATE OR ALTER TRIGGER trg_DeleteHistory_ProfileStudent
    ON [practica1].[ProfileStudent]
    AFTER DELETE
    AS
    BEGIN
        DECLARE @Description nvarchar(max);
        
        SELECT @Description = 'Se ha eliminado un registro de la tabla [practica1].[ProfileStudent]: ' +
                            'Id: ' + CAST(DELETED.Id AS nvarchar(max)) + ', ' +
                            'UserId: ''' + CAST(DELETED.UserId AS nvarchar(max)) + ''', ' +  -- Escapar manualmente el valor de UserId
                            'Credits: ' + CAST(DELETED.Credits AS nvarchar(max))
        FROM DELETED;
        
        INSERT INTO [practica1].[HistoryLog] (Date, Description)
        VALUES (GETDATE(), @Description);
    END;
GO
-- Trigger para UPDATE en HistoryLog_ProfileStudent
    CREATE OR ALTER TRIGGER trg_UpdateHistory_ProfileStudent
    ON [practica1].[ProfileStudent]
    AFTER UPDATE
    AS
    BEGIN
        DECLARE @OldDescription nvarchar(max), @NewDescription nvarchar(max);
        
        SELECT @OldDescription = 'Registro modificado (Antiguo) en la tabla [practica1].[ProfileStudent]: ' +
                                'Id: ' + CAST(DELETED.Id AS nvarchar(max)) + ', ' +
                                'UserId: ''' + CAST(DELETED.UserId AS nvarchar(max)) + ''', ' +  -- Escapar manualmente el valor de UserId
                                'Credits: ' + CAST(DELETED.Credits AS nvarchar(max)),
            @NewDescription = 'Registro modificado (Nuevo) en la tabla [practica1].[ProfileStudent]: ' +
                                'Id: ' + CAST(INSERTED.Id AS nvarchar(max)) + ', ' +
                                'UserId: ''' + CAST(INSERTED.UserId AS nvarchar(max)) + ''', ' +  -- Escapar manualmente el valor de UserId
                                'Credits: ' + CAST(INSERTED.Credits AS nvarchar(max))
        FROM DELETED
        JOIN INSERTED ON DELETED.Id = INSERTED.Id;
        
        INSERT INTO [practica1].[HistoryLog] (Date, Description)
        VALUES (GETDATE(), @OldDescription);
        
        INSERT INTO [practica1].[HistoryLog] (Date, Description)
        VALUES (GETDATE(), @NewDescription);
    END;
GO






-- Trigger para INSERT en HistoryLog_Roles
    CREATE OR ALTER TRIGGER trg_InsertHistory_Roles
    ON [practica1].[Roles]
    AFTER INSERT
    AS
    BEGIN
        DECLARE @Description nvarchar(max);
        
        SELECT @Description = 'Se ha insertado un nuevo registro en la tabla [practica1].[Roles]: ' +
                            'Id: ''' + CAST(INSERTED.Id AS nvarchar(max)) + ''', ' +  -- Escapar manualmente el valor de Id
                            'RoleName: ' + CAST(INSERTED.RoleName AS nvarchar(max))
        FROM INSERTED;
        
        INSERT INTO [practica1].[HistoryLog] (Date, Description)
        VALUES (GETDATE(), @Description);
    END;
GO
-- Trigger para DELETE en HistoryLog_Roles
    CREATE OR ALTER TRIGGER trg_DeleteHistory_Roles
    ON [practica1].[Roles]
    AFTER DELETE
    AS
    BEGIN
        DECLARE @Description nvarchar(max);
        
        SELECT @Description = 'Se ha eliminado un registro de la tabla [practica1].[Roles]: ' +
                            'Id: ''' + CAST(DELETED.Id AS nvarchar(max)) + ''', ' +  -- Escapar manualmente el valor de Id
                            'RoleName: ' + CAST(DELETED.RoleName AS nvarchar(max))
        FROM DELETED;
        
        INSERT INTO [practica1].[HistoryLog] (Date, Description)
        VALUES (GETDATE(), @Description);
    END;
GO
-- Trigger para UPDATE en HistoryLog_Roles
    CREATE OR ALTER TRIGGER trg_UpdateHistory_Roles
    ON [practica1].[Roles]
    AFTER UPDATE
    AS
    BEGIN
        DECLARE @OldDescription nvarchar(max), @NewDescription nvarchar(max);
        
        SELECT @OldDescription = 'Registro modificado (Antiguo) en la tabla [practica1].[Roles]: ' +
                                'Id: ''' + CAST(DELETED.Id AS nvarchar(max)) + ''', ' +  -- Escapar manualmente el valor de Id
                                'RoleName: ' + CAST(DELETED.RoleName AS nvarchar(max)),
            @NewDescription = 'Registro modificado (Nuevo) en la tabla [practica1].[Roles]: ' +
                                'Id: ''' + CAST(INSERTED.Id AS nvarchar(max)) + ''', ' +  -- Escapar manualmente el valor de Id
                                'RoleName: ' + CAST(INSERTED.RoleName AS nvarchar(max))
        FROM DELETED
        JOIN INSERTED ON DELETED.Id = INSERTED.Id;
        
        INSERT INTO [practica1].[HistoryLog] (Date, Description)
        VALUES (GETDATE(), @OldDescription);
        
        INSERT INTO [practica1].[HistoryLog] (Date, Description)
        VALUES (GETDATE(), @NewDescription);
    END;
GO





-- Trigger para INSERT en HistoryLog_TFA
    CREATE OR ALTER TRIGGER trg_InsertHistory_TFA
    ON [practica1].[TFA]
    AFTER INSERT
    AS
    BEGIN
        DECLARE @Description nvarchar(max);
        
        SELECT @Description = 'Se ha insertado un nuevo registro en la tabla [practica1].[TFA]: ' +
                            'Id: ' + CAST(INSERTED.Id AS nvarchar(max)) + ', ' +
                            'UserId: ''' + CAST(INSERTED.UserId AS nvarchar(max)) + ''', ' +  -- Escapar manualmente el valor de UserId
                            'Status: ' + CAST(INSERTED.Status AS nvarchar(max)) + ', ' +
                            'LastUpdate: ' + CAST(INSERTED.LastUpdate AS nvarchar(max))
        FROM INSERTED;
        
        INSERT INTO [practica1].[HistoryLog] (Date, Description)
        VALUES (GETDATE(), @Description);
    END;
GO
-- Trigger para DELETE en HistoryLog_TFA
    CREATE OR ALTER TRIGGER trg_DeleteHistory_TFA
    ON [practica1].[TFA]
    AFTER DELETE
    AS
    BEGIN
        DECLARE @Description nvarchar(max);
        
        SELECT @Description = 'Se ha eliminado un registro de la tabla [practica1].[TFA]: ' +
                            'Id: ' + CAST(DELETED.Id AS nvarchar(max)) + ', ' +
                            'UserId: ''' + CAST(DELETED.UserId AS nvarchar(max)) + ''', ' +  -- Escapar manualmente el valor de UserId
                            'Status: ' + CAST(DELETED.Status AS nvarchar(max)) + ', ' +
                            'LastUpdate: ' + CAST(DELETED.LastUpdate AS nvarchar(max))
        FROM DELETED;
        
        INSERT INTO [practica1].[HistoryLog] (Date, Description)
        VALUES (GETDATE(), @Description);
    END;
GO
-- Trigger para UPDATE en HistoryLog_TFA
    CREATE OR ALTER TRIGGER trg_UpdateHistory_TFA
    ON [practica1].[TFA]
    AFTER UPDATE
    AS
    BEGIN
        DECLARE @OldDescription nvarchar(max), @NewDescription nvarchar(max);
        
        SELECT @OldDescription = 'Registro modificado (Antiguo) en la tabla [practica1].[TFA]: ' +
                                'Id: ' + CAST(DELETED.Id AS nvarchar(max)) + ', ' +
                                'UserId: ''' + CAST(DELETED.UserId AS nvarchar(max)) + ''', ' +  -- Escapar manualmente el valor de UserId
                                'Status: ' + CAST(DELETED.Status AS nvarchar(max)) + ', ' +
                                'LastUpdate: ' + CAST(DELETED.LastUpdate AS nvarchar(max)),
            @NewDescription = 'Registro modificado (Nuevo) en la tabla [practica1].[TFA]: ' +
                                'Id: ' + CAST(INSERTED.Id AS nvarchar(max)) + ', ' +
                                'UserId: ''' + CAST(INSERTED.UserId AS nvarchar(max)) + ''', ' +  -- Escapar manualmente el valor de UserId
                                'Status: ' + CAST(INSERTED.Status AS nvarchar(max)) + ', ' +
                                'LastUpdate: ' + CAST(INSERTED.LastUpdate AS nvarchar(max))
        FROM DELETED
        JOIN INSERTED ON DELETED.Id = INSERTED.Id;
        
        INSERT INTO [practica1].[HistoryLog] (Date, Description)
        VALUES (GETDATE(), @OldDescription);
        
        INSERT INTO [practica1].[HistoryLog] (Date, Description)
        VALUES (GETDATE(), @NewDescription);
    END;
GO







-- Trigger para INSERT en HistoryLog_TutorProfile
    CREATE OR ALTER TRIGGER trg_InsertHistory_TutorProfile
    ON [practica1].[TutorProfile]
    AFTER INSERT
    AS
    BEGIN
        DECLARE @Description nvarchar(max);
        
        SELECT @Description = 'Se ha insertado un nuevo registro en la tabla [practica1].[TutorProfile]: ' +
                            'Id: ' + CAST(INSERTED.Id AS nvarchar(max)) + ', ' +
                            'UserId: ''' + CAST(INSERTED.UserId AS nvarchar(max)) + ''', ' +  -- Escapar manualmente el valor de UserId
                            'TutorCode: ' + QUOTENAME(INSERTED.TutorCode, '''')
        FROM INSERTED;
        
        INSERT INTO [practica1].[HistoryLog] (Date, Description)
        VALUES (GETDATE(), @Description);
    END;
GO
-- Trigger para DELETE en HistoryLog_TutorProfile
    CREATE OR ALTER TRIGGER trg_DeleteHistory_TutorProfile
    ON [practica1].[TutorProfile]
    AFTER DELETE
    AS
    BEGIN
        DECLARE @Description nvarchar(max);
        
        SELECT @Description = 'Se ha eliminado un registro de la tabla [practica1].[TutorProfile]: ' +
                            'Id: ' + CAST(DELETED.Id AS nvarchar(max)) + ', ' +
                            'UserId: ''' + CAST(DELETED.UserId AS nvarchar(max)) + ''', ' +  -- Escapar manualmente el valor de UserId
                            'TutorCode: ' + QUOTENAME(DELETED.TutorCode, '''')
        FROM DELETED;
        
        INSERT INTO [practica1].[HistoryLog] (Date, Description)
        VALUES (GETDATE(), @Description);
    END;
GO
-- Trigger para UPDATE en HistoryLog_TutorProfile
    CREATE OR ALTER TRIGGER trg_UpdateHistory_TutorProfile
    ON [practica1].[TutorProfile]
    AFTER UPDATE
    AS
    BEGIN
        DECLARE @OldDescription nvarchar(max), @NewDescription nvarchar(max);
        
        SELECT @OldDescription = 'Registro modificado (Antiguo) en la tabla [practica1].[TutorProfile]: ' +
                                'Id: ' + CAST(DELETED.Id AS nvarchar(max)) + ', ' +
                                'UserId: ''' + CAST(DELETED.UserId AS nvarchar(max)) + ''', ' +  -- Escapar manualmente el valor de UserId
                                'TutorCode: ' + QUOTENAME(DELETED.TutorCode, ''''),
            @NewDescription = 'Registro modificado (Nuevo) en la tabla [practica1].[TutorProfile]: ' +
                                'Id: ' + CAST(INSERTED.Id AS nvarchar(max)) + ', ' +
                                'UserId: ''' + CAST(INSERTED.UserId AS nvarchar(max)) + ''', ' +  -- Escapar manualmente el valor de UserId
                                'TutorCode: ' + QUOTENAME(INSERTED.TutorCode, '''')
        FROM DELETED
        JOIN INSERTED ON DELETED.Id = INSERTED.Id;
        
        INSERT INTO [practica1].[HistoryLog] (Date, Description)
        VALUES (GETDATE(), @OldDescription);
        
        INSERT INTO [practica1].[HistoryLog] (Date, Description)
        VALUES (GETDATE(), @NewDescription);
    END;
GO





-- Trigger para INSERT en HistoryLog_UsuarioRole
    CREATE OR ALTER TRIGGER trg_InsertHistory_UsuarioRole
    ON [practica1].[UsuarioRole]
    AFTER INSERT
    AS
    BEGIN
        DECLARE @Description nvarchar(max);
        
        SELECT @Description = 'Se ha insertado un nuevo registro en la tabla [practica1].[UsuarioRole]: ' +
                            'Id: ' + CAST(INSERTED.Id AS nvarchar(max)) + ', ' +
                            'RoleId: ''' + CAST(INSERTED.RoleId AS nvarchar(max)) + ''', ' +  -- Escapar manualmente el valor de RoleId
                            'UserId: ''' + CAST(INSERTED.UserId AS nvarchar(max)) + ''', ' +  -- Escapar manualmente el valor de UserId
                            'IsLatestVersion: ' + CAST(INSERTED.IsLatestVersion AS nvarchar(max))
        FROM INSERTED;
        
        INSERT INTO [practica1].[HistoryLog] (Date, Description)
        VALUES (GETDATE(), @Description);
    END;
GO
-- Trigger para DELETE en HistoryLog_UsuarioRole
    CREATE OR ALTER TRIGGER trg_DeleteHistory_UsuarioRole
    ON [practica1].[UsuarioRole]
    AFTER DELETE
    AS
    BEGIN
        DECLARE @Description nvarchar(max);
        
        SELECT @Description = 'Se ha eliminado un registro de la tabla [practica1].[UsuarioRole]: ' +
                            'Id: ' + CAST(DELETED.Id AS nvarchar(max)) + ', ' +
                            'RoleId: ''' + CAST(DELETED.RoleId AS nvarchar(max)) + ''', ' +  -- Escapar manualmente el valor de RoleId
                            'UserId: ''' + CAST(DELETED.UserId AS nvarchar(max)) + ''', ' +  -- Escapar manualmente el valor de UserId
                            'IsLatestVersion: ' + CAST(DELETED.IsLatestVersion AS nvarchar(max))
        FROM DELETED;
        
        INSERT INTO [practica1].[HistoryLog] (Date, Description)
        VALUES (GETDATE(), @Description);
    END;
GO







-- Trigger para INSERT en HistoryLog_Usuarios
    CREATE TRIGGER trg_InsertHistory_Usuarios
    ON [practica1].[Usuarios]
    AFTER INSERT
    AS
    BEGIN
        DECLARE @Description nvarchar(max);

        SELECT @Description = 'Se ha insertado un nuevo registro en la tabla [practica1].[Usuarios]: ' +
                            'Id: ' + CAST(INSERTED.Id AS nvarchar(max)) + ', ' +
                            'Firstname: ' + CAST(INSERTED.Firstname AS nvarchar(max)) + ', ' +
                            'Lastname: ' + CAST(INSERTED.Lastname AS nvarchar(max)) + ', ' +
                            'Email: ' + CAST(INSERTED.Email AS nvarchar(max)) + ', ' +
                            'DateOfBirth: ' + CAST(INSERTED.DateOfBirth AS nvarchar(max)) + ', ' +
                            'Password: ' + CAST(INSERTED.Password AS nvarchar(max)) + ', ' +
                            'LastChanges: ' + CAST(INSERTED.LastChanges AS nvarchar(max)) + ', ' +
                            'EmailConfirmed: ' + CAST(INSERTED.EmailConfirmed AS nvarchar(max))
        FROM INSERTED;

        INSERT INTO [practica1].[HistoryLog] (Date, Description)
        VALUES (GETDATE(), @Description);
    END;
GO
-- Trigger para UPDATE en HistoryLog_Usuarios
    CREATE TRIGGER trg_UpdateHistory_Usuarios
    ON [practica1].[Usuarios]
    AFTER UPDATE
    AS
    BEGIN
        DECLARE @OldDescription nvarchar(max), @NewDescription nvarchar(max);

        SELECT @OldDescription = 'Registro modificado (Antiguo) en la tabla [practica1].[Usuarios]: ' +
                                'Id: ' + CAST(DELETED.Id AS nvarchar(max)) + ', ' +
                                'Firstname: ' + CAST(DELETED.Firstname AS nvarchar(max)) + ', ' +
                                'Lastname: ' + CAST(DELETED.Lastname AS nvarchar(max)) + ', ' +
                                'Email: ' + CAST(DELETED.Email AS nvarchar(max)) + ', ' +
                                'DateOfBirth: ' + CAST(DELETED.DateOfBirth AS nvarchar(max)) + ', ' +
                                'Password: ' + CAST(DELETED.Password AS nvarchar(max)) + ', ' +
                                'LastChanges: ' + CAST(DELETED.LastChanges AS nvarchar(max)) + ', ' +
                                'EmailConfirmed: ' + CAST(DELETED.EmailConfirmed AS nvarchar(max)),
            @NewDescription = 'Registro modificado (Nuevo) en la tabla [practica1].[Usuarios]: ' +
                                'Id: ' + CAST(INSERTED.Id AS nvarchar(max)) + ', ' +
                                'Firstname: ' + CAST(INSERTED.Firstname AS nvarchar(max)) + ', ' +
                                'Lastname: ' + CAST(INSERTED.Lastname AS nvarchar(max)) + ', ' +
                                'Email: ' + CAST(INSERTED.Email AS nvarchar(max)) + ', ' +
                                'DateOfBirth: ' + CAST(INSERTED.DateOfBirth AS nvarchar(max)) + ', ' +
                                'Password: ' + CAST(INSERTED.Password AS nvarchar(max)) + ', ' +
                                'LastChanges: ' + CAST(INSERTED.LastChanges AS nvarchar(max)) + ', ' +
                                'EmailConfirmed: ' + CAST(INSERTED.EmailConfirmed AS nvarchar(max))
        FROM DELETED
        JOIN INSERTED ON DELETED.Id = INSERTED.Id;

        INSERT INTO [practica1].[HistoryLog] (Date, Description)
        VALUES (GETDATE(), @OldDescription);

        INSERT INTO [practica1].[HistoryLog] (Date, Description)
        VALUES (GETDATE(), @NewDescription);
    END;
GO
-- Trigger para DELETE en HistoryLog_Usuarios
    CREATE TRIGGER trg_DeleteHistory_Usuarios
    ON [practica1].[Usuarios]
    AFTER DELETE
    AS
    BEGIN
        DECLARE @Description nvarchar(max);

        SELECT @Description = 'Se ha eliminado un registro de la tabla [practica1].[Usuarios]: ' +
                            'Id: ' + CAST(DELETED.Id AS nvarchar(max)) + ', ' +
                            'Firstname: ' + CAST(DELETED.Firstname AS nvarchar(max)) + ', ' +
                            'Lastname: ' + CAST(DELETED.Lastname AS nvarchar(max)) + ', ' +
                            'Email: ' + CAST(DELETED.Email AS nvarchar(max)) + ', ' +
                            'DateOfBirth: ' + CAST(DELETED.DateOfBirth AS nvarchar(max)) + ', ' +
                            'Password: ' + CAST(DELETED.Password AS nvarchar(max)) + ', ' +
                            'LastChanges: ' + CAST(DELETED.LastChanges AS nvarchar(max)) + ', ' +
                            'EmailConfirmed: ' + CAST(DELETED.EmailConfirmed AS nvarchar(max))
        FROM DELETED;

        INSERT INTO [practica1].[HistoryLog] (Date, Description)
        VALUES (GETDATE(), @Description);
    END;
GO

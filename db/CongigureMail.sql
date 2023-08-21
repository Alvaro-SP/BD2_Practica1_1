--   ACTIVATE MAILS IN Server
    show advanced options
    EXEC sp_configure 'show advanced options', 1
    GO
    RECONFIGURE
    GO

    -- enable Database Mail XPs
    EXEC sp_configure 'Database Mail XPs', 1
    GO
    RECONFIGURE
    GO

    -- check if it has been changed
    EXEC sp_configure 'Database Mail XPs'
    GO

    -- hide advanced options
    EXEC sp_configure 'show advanced options', 0
    GO
    RECONFIGURE
    GO

    -- Create a Database Mail profile  
    -- Grant access to the profile to the DBMailUsers role  
    EXECUTE msdb.dbo.sysmail_add_principalprofile_sp  
        @profile_name = 'Notifications',  
        @principal_name = 'public',  
        @is_default = 1 ;
    GO

    -- Create a Database Mail account  
    EXECUTE msdb.dbo.sysmail_add_account_sp  
        @account_name = 'Gmail',  
        @description = 'Mail account for sending outgoing notifications.',  
        @email_address = 'socop2412@gmail.com',  
        @display_name = 'Automated Mailer Grupo 1 BD2',  
        @mailserver_name = 'smtp.gmail.com',
        @port = 465,
        @enable_ssl = 1,
        @username = 'socop2412@gmail.com',
        @password = '' ;  
    GO

    -- Add the account to the profile  
    EXECUTE msdb.dbo.sysmail_add_profileaccount_sp  
        @profile_name = 'Notifications',  
        @account_name = 'Gmail',  
        @sequence_number =1 ;  
    GO

    EXEC msdb.dbo.sp_send_dbmail
        @profile_name = 'Notification',
        @recipients = 'alvaro24.ingenieria@gmail.com',
        @body = 'The database mail configuration was completed successfully.',
        @subject = 'Automated Success Message';
    GO




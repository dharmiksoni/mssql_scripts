
-- user creation
USE employee_book; -- Switch to the appropriate database
GRANT SELECT ON SCHEMA::dbo TO [DSONI-LAP\PrimeSoft];

USE employee_book;
--create user
CREATE LOGIN [DSONI-LAP\PrimeSoft] FROM WINDOWS;

CREATE LOGIN PrimeSoftLogin WITH PASSWORD = '***********';

--permission
--assign permission
ALTER ROLE db_admin ADD MEMBER [DSONI-LAP\PrimeSoft]; -- Grants SELECT permissions
ALTER ROLE db_datawriter ADD MEMBER NewUser; -- Grants INSERT, UPDATE, DELETE permissions

-- drop role
drop role 'custom_rolename'
drop user 'custom_username'
--Related tables
-- sys.database_principals
-- sys.database_role_members 
-- sys.database_principals

-- SQL user, role and permssion management with detail task

/*
Create a new SQL Server user named "guest" and grant them read-only access to a specific table in a database of your choice.
*/
    CREATE USER guest FOR LOGIN guest;
    GRANT SELECT ON employee_book.dbo.employees TO guest;
/*
Grant a SQL Server user the "db_datawriter" fixed database role on a database.
*/
    EXEC sp_addrolemember 'db_datawriter', [DSONI-LAP\PrimeSoft];

/*
Create a user-defined role called "SalesTeam" and grant it read and insert permissions on all tables in a specific schema.
*/ 
    CREATE ROLE employeeModifier
    GRANT SELECT,INSERT ON SCHEMA::dbo TO employeeModifier

/*
Revoke delete permission for a specific user on a particular table.
*/
    REVOKE DELETE ON [employee_book].[dbo].[employees] FROM guest;

/*
Add a user to the "db_owner" fixed database role and explain the implications of this action.
*/
    EXEC sp_addrolemember 'db_owner', '[DSONI-LAP\PrimeSoft]'
/*
Create a SQL Server user with a strong password policy and password expiration policy.
*/
    CREATE LOGIN manager WITH PASSWORD='******', CHECK_POLICY=ON, CHECK_EXPIRATION=ON

/*
Grant a user execute permissions on a specific stored procedure.
*/
GRANT EXECUTE ON employee_book.dbo.spx_bulk_import TO manager
/*
Deny select permission on a table for a specific user.
*/
DENY SELECT ON employee_book.dbo.salaries TO manager
/*
Create a user with no login, known as a "database-only" user.
*/
CREATE USER [dummy-user] WITHOUT LOGIN;
/*
List all the users in a SQL Server database and the roles they belong to.
*/
	SELECT 
    u.name AS UserName, 
    r.name AS RoleName
FROM sys.database_principals u
LEFT JOIN sys.database_role_members rm ON u.principal_id = rm.member_principal_id
LEFT JOIN sys.database_principals r ON rm.role_principal_id = r.principal_id
--WHERE u.type_desc = 'SQL_USER'; SQL_USER | DATABASE_ROLE | WINDOWS_USER

/*
MEDIUM
Create a user-defined SQL Server role called "HRManagers" and grant it the ability to update employee information in a specific table.
*/
/*
Assign multiple users to a user-defined role and ensure they have the same permissions.
*/
/*
Create a schema, move a table into that schema, and grant a role access to all objects in that schema.
*/
CREATE SCHEMA prj;
ALTER SCHEMA prj TRANSFER dbo.sample
/*
Set up a login trigger to log login attempts to a table.
*/
CREATE TABLE loginAttempts(
    attemptId INT IDENTITY(1,1),
    loginName varchar(50),
    loginTime DATETIME
)
-- login trigger
CREATE TRIGGER userLoginAttempts
ON ALL SERVER
FOR LOGON
AS 
BEGIN
    INSERT INTO loginAttempts (loginName, loginTime)
    VALUES(ORIGINAL_LOGIN(), GETDATE())
END

/*
Implement a security policy that restricts access to sensitive customer data for users who are not in the "CustomerSupport" role.
*/
CREATE SECURITY POLICY CustomerSupport
ADD FILTER PREDICATE dbo.IsCustomerSupportUser()
ON dbo.customerData
WITH (STATE = ON)

-- create function
CREATE FUNCTION IsCustomerSupportUser
RETURNS TABLE
AS 
RETURN(
    SELECT 1 AS IsCustomerSupport
    WHERE EXISTS (
        SELECT 1
        FROM sys.database_principals dp
        JOIN sys.database_role_members rm ON dp.principal_id = rm.member_principal_id
        JOIN sys.database_principals rp ON rm.role_principal_id = rp.principal_id
        WHERE dp.name = USER_NAME() -- Check the current user
        AND rp.name = 'customerData' -- Check the "customerData" role
    )
)

/*
Implement a security scenario where users can only access the database during specific hours of the day.
*/
CREATE TRIGGER accessHours
ON ALL SERVER
FOR LOGON
AS
BEGIN
    IF (DATEPART(HOUR, GETDATE()) < 9 OR DATEPART(HOUR, GETDATE()) > 17)
    BEGIN
        ROLLBACK -- rollback all logins
    END
END

/*
HARD
Implement a dynamic SQL-based role-based security model where role membership and permissions are determined based on user attributes.
*/
/*
Set up SQL Server Transparent Data Encryption (TDE) and ensure that only authorized users can access decrypted data.
*/
/*
Configure SQL Server Always Encrypted for specific columns in a table and manage access to encrypted data.
*/
/*
Implement a custom server-level role with unique server-wide permissions.
*/
/*
Create a user-defined role that can only execute specific stored procedures but has no other permissions.
*/
/*
Configure SQL Server Auditing to track changes to sensitive tables by specific users.
*/
/*
Implement a security model where users can only connect to SQL Server through a specific application or application role.
*/
/*
Set up row-level security using SQL Server's built-in row-level security features, and create a user-defined function for filtering data.
*/
/*
Implement SQL Server Dynamic Data Masking on sensitive columns and test its effectiveness.
*/
/*
Design and implement a comprehensive SQL Server security policy and procedure document for your organization, including user account creation, role management, and auditing guidelines.
*/


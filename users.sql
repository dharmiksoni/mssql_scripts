
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


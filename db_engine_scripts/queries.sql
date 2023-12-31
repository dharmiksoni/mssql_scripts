USE [master]
GO
/****** Object:  Database [employee_book]    Script Date: 10/7/2023 7:46:01 PM ******/
CREATE DATABASE [employee_book]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'employee_book', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS01\MSSQL\DATA\employee_book.mdf' , SIZE = 512000KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'employee_book_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS01\MSSQL\DATA\employee_book_log.ldf' , SIZE = 512000KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [employee_book] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [employee_book].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [employee_book] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [employee_book] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [employee_book] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [employee_book] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [employee_book] SET ARITHABORT OFF 
GO
ALTER DATABASE [employee_book] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [employee_book] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [employee_book] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [employee_book] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [employee_book] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [employee_book] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [employee_book] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [employee_book] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [employee_book] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [employee_book] SET  DISABLE_BROKER 
GO
ALTER DATABASE [employee_book] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [employee_book] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [employee_book] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [employee_book] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [employee_book] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [employee_book] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [employee_book] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [employee_book] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [employee_book] SET  MULTI_USER 
GO
ALTER DATABASE [employee_book] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [employee_book] SET DB_CHAINING OFF 
GO
ALTER DATABASE [employee_book] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [employee_book] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [employee_book] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [employee_book] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [employee_book] SET QUERY_STORE = ON
GO
ALTER DATABASE [employee_book] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [employee_book]
GO
/****** Object:  User [dummy-user]    Script Date: 10/7/2023 7:46:01 PM ******/
CREATE USER [dummy-user] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [DSONI-LAP\PrimeSoft]    Script Date: 10/7/2023 7:46:01 PM ******/
CREATE USER [DSONI-LAP\PrimeSoft] FOR LOGIN [DSONI-LAP\PrimeSoft] WITH DEFAULT_SCHEMA=[DSONI-LAP\PrimeSoft]
GO
/****** Object:  DatabaseRole [employeeModifier]    Script Date: 10/7/2023 7:46:01 PM ******/
CREATE ROLE [employeeModifier]
GO
ALTER ROLE [db_owner] ADD MEMBER [DSONI-LAP\PrimeSoft]
GO
ALTER ROLE [db_accessadmin] ADD MEMBER [DSONI-LAP\PrimeSoft]
GO
ALTER ROLE [db_securityadmin] ADD MEMBER [DSONI-LAP\PrimeSoft]
GO
ALTER ROLE [db_backupoperator] ADD MEMBER [DSONI-LAP\PrimeSoft]
GO
/****** Object:  Schema [dbo1]    Script Date: 10/7/2023 7:46:01 PM ******/
CREATE SCHEMA [dbo1]
GO
/****** Object:  Schema [DSONI-LAP\PrimeSoft]    Script Date: 10/7/2023 7:46:01 PM ******/
CREATE SCHEMA [DSONI-LAP\PrimeSoft]
GO
/****** Object:  Schema [prj]    Script Date: 10/7/2023 7:46:01 PM ******/
CREATE SCHEMA [prj]
GO
/****** Object:  UserDefinedFunction [dbo].[getEmployees]    Script Date: 10/7/2023 7:46:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- get count of all employees
CREATE FUNCTION [dbo].[getEmployees]()
RETURNS INT
AS
BEGIN
	DECLARE @e_count INT
    -- function body
    SELECT @e_count = COUNT(id) from employees

	RETURN @e_count
END
GO
/****** Object:  UserDefinedFunction [dbo].[getHighestSalariesEmpByDeptMultiStatement]    Script Date: 10/7/2023 7:46:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/**
-- multi statement table

**/
CREATE FUNCTION [dbo].[getHighestSalariesEmpByDeptMultiStatement](@dept_id INT)
RETURNS @Table Table (id BIGINT, first_name varchar(15), last_name varchar(15))
AS
BEGIN
    INSERT INTO @Table
    SELECT e.id AS emp_id,
        e.first_name,
        e.last_name
    FROM employee_book.dbo.employees e
    JOIN ( SELECT emp_no, MAX(salary) AS max_salary FROM salaries GROUP BY emp_no) max_salaries ON e.id = max_salaries.emp_no
    JOIN salaries s ON e.id = s.emp_no AND s.salary = max_salaries.max_salary
    JOIN departments d ON e.department_id = d.id
    WHERE e.department_id = @dept_id
	Return
END
GO
/****** Object:  Table [dbo].[departments]    Script Date: 10/7/2023 7:46:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[departments](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[dept_name] [varchar](40) NOT NULL,
	[creation_date] [datetime] NOT NULL,
	[updation_date] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[dept_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[employees]    Script Date: 10/7/2023 7:46:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[employees](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[creation_date] [datetime] NOT NULL,
	[updation_date] [datetime] NULL,
	[birth_date] [date] NOT NULL,
	[first_name] [varchar](15) NOT NULL,
	[last_name] [varchar](15) NOT NULL,
	[email] [nvarchar](50) NOT NULL,
	[gender] [char](2) NOT NULL,
	[department_id] [bigint] NULL,
	[hired_on] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[salaries]    Script Date: 10/7/2023 7:46:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[salaries](
	[emp_no] [bigint] NOT NULL,
	[salary] [money] NULL,
	[from_date] [date] NOT NULL,
	[to_date] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[emp_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[getHighestSalariesEmpByDept]    Script Date: 10/7/2023 7:46:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**
-- inline table valued function
-- select * from getHighestSalariesEmpByDept()
-- SQL query to find the highest salary employees in each department
**/
CREATE FUNCTION [dbo].[getHighestSalariesEmpByDept](@dept_id INT)
RETURNS TABLE
AS
RETURN (
	SELECT e.id AS emp_id,
    e.first_name,
    e.last_name,
    d.dept_name,
    s.salary
FROM employee_book.dbo.employees e
JOIN ( SELECT emp_no, MAX(salary) AS max_salary FROM salaries GROUP BY emp_no) max_salaries ON e.id = max_salaries.emp_no
JOIN salaries s ON e.id = s.emp_no AND s.salary = max_salaries.max_salary
JOIN departments d ON e.department_id = d.id
WHERE e.department_id = @dept_id)
GO
/****** Object:  Table [dbo].[dept_manager]    Script Date: 10/7/2023 7:46:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dept_manager](
	[emp_no] [bigint] NOT NULL,
	[dept_no] [bigint] NOT NULL,
	[from_date] [date] NOT NULL,
	[to_date] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[emp_no] ASC,
	[dept_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[designation]    Script Date: 10/7/2023 7:46:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[designation](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[designation_name] [varchar](50) NOT NULL,
	[creation_date] [datetime] NOT NULL,
	[updation_date] [datetime] NULL,
	[dept_id] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[emp_designation]    Script Date: 10/7/2023 7:46:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[emp_designation](
	[emp_no] [bigint] IDENTITY(1,1) NOT NULL,
	[title] [varchar](50) NOT NULL,
	[from_date] [date] NOT NULL,
	[to_date] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[emp_no] ASC,
	[title] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[loginAttempts]    Script Date: 10/7/2023 7:46:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[loginAttempts](
	[attemptId] [int] IDENTITY(1,1) NOT NULL,
	[loginName] [varchar](50) NULL,
	[loginTime] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [prj].[sample]    Script Date: 10/7/2023 7:46:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [prj].[sample](
	[id] [bigint] NOT NULL,
	[name] [varchar](50) NULL,
	[email] [varchar](50) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[departments] ADD  DEFAULT (getdate()) FOR [creation_date]
GO
ALTER TABLE [dbo].[designation] ADD  DEFAULT (getdate()) FOR [creation_date]
GO
ALTER TABLE [dbo].[employees] ADD  DEFAULT (getdate()) FOR [creation_date]
GO
ALTER TABLE [dbo].[dept_manager]  WITH CHECK ADD FOREIGN KEY([dept_no])
REFERENCES [dbo].[departments] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[dept_manager]  WITH CHECK ADD FOREIGN KEY([emp_no])
REFERENCES [dbo].[employees] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[emp_designation]  WITH CHECK ADD FOREIGN KEY([emp_no])
REFERENCES [dbo].[employees] ([id])
GO
ALTER TABLE [dbo].[salaries]  WITH CHECK ADD FOREIGN KEY([emp_no])
REFERENCES [dbo].[employees] ([id])
ON DELETE CASCADE
GO
/****** Object:  StoredProcedure [dbo].[spx_add_employee_import]    Script Date: 10/7/2023 7:46:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ======================================================
-- Author:		Dharmik Soni
-- Create date: 2023-10-08
-- Description:	To add/save new employee in
-- ======================================================
--EXEC employee_book.dbo.add_employee @birth_date='11-01-1965', @first_name='Mili', @last_name='Sairous', @email='mili.sairous@gmail.com', @gender='M', @hired_on='12-05-1985', @is_dept_mgnr=1, @salary=205000, @designation_name='Data Scientist'

CREATE PROC [dbo].[spx_add_employee_import]
(
    @birth_date DATE NULL,
    @first_name VARCHAR(15) NULL, 
    @last_name VARCHAR(15) NULL, 
    @email NVARCHAR(50) NULL, 
    @gender CHAR(2) NULL,
    -- @department_id BIGINT NOT NULL,
    @hired_on DATE NULL,
    @is_dept_mgnr BIT NULL,
    @salary MONEY NULL,
    @designation_name VARCHAR(50) NULL,
	@json NVARCHAR(MAX) = NULL

)
AS
BEGIN
    SET NOCOUNT ON;

    -- Declare variables
	DECLARE @msg VARCHAR(100) = '', @rows_affected INT = 0, @Id BIGINT = NULL;
    DECLARE @emp_no BIGINT=0, @dprt_id BIGINT=0, @dsgn_id BIGINT=0, @desg_name VARCHAR(50)='';

    IF ISNULL(@json,'') <> ''
    BEGIN
        IF OBJECT_ID('tempdb..#master_table') IS NOT NULL 
		DROP TABLE #master_table

        SELECT * INTO #master_table
        FROM OPENJSON(@json)
        WITH (
            [birth_date] [date] '$.birth_date',
            [first_name] VARCHAR(50) '$.first_name',
            [last_name] VARCHAR(50) '$.last_name',
            [email] VARCHAR(50) '$.email',
            [gender] CHAR(2) '$.gender',
            [hired_on] [date] '$.hired_on',
            [is_dept_mgnr] BIT '$.is_dept_mgnr',
            [salary] MONEY '$.salary',
            [designation_name] varchar(50) '$.designation_name'
        );
        SELECT @dsgn_id=ISNULL(d.id,0), @dprt_id=ISNULL(d.dept_id,0), @desg_name=ISNULL(d.designation_name, '')
        FROM dbo.designation d WITH (NOLOCK)
		INNER JOIN #master_table mt WITH (NOLOCK) ON d.designation_name = mt.designation_name;

		-- if record exist then return
		SELECT @emp_no=ISNULL(e.id, '')
		FROM dbo.employees e
		INNER JOIN #master_table mt WITH (NOLOCK) ON e.email= mt.email;

    END
	--if emp_id got from json value
	IF ISNULL(@emp_no, '') <> ''
	BEGIN
		SET @msg = 'Record Exists'
	END
	ELSE
	BEGIN
		-- if pass in input
		SELECT @emp_no=ISNULL(e.id, '')
		FROM dbo.employees e
		WHERE email=@email 
	END

	IF ISNULL(@emp_no, '') <> ''
	BEGIN
		SET @msg = 'Record Exists'
	END
	ELSE
		BEGIN
			select @dsgn_id=ISNULL(d.id,0), @dprt_id=ISNULL(d.dept_id,0), @desg_name=ISNULL(d.designation_name, '')
		from designation d
		where d.designation_name = @designation_name;

		--PRINT 'dsgn: '+ @dsgn_id;
		--PRINT 'dprt: '+ @dprt_id;

		-- Insert into employees table
		INSERT INTO employees (birth_date, first_name, last_name, email, gender, department_id, hired_on)
		VALUES (@birth_date, @first_name, @last_name, @email, @gender, @dprt_id, @hired_on);

		-- Get the newly inserted employee ID
		SET @emp_no = (SELECT MAX(id) FROM employees);

		-- Insert into salaries table if salary is provided
		IF @salary IS NOT NULL
		BEGIN
			INSERT INTO salaries (emp_no, salary, from_date, to_date)
			VALUES (@emp_no, @salary, @hired_on, '9999-12-31'); -- Assuming '9999-12-31' as the end date for the current salary
		END

		IF @dsgn_id IS NOT NULL
		BEGIN
			INSERT INTO emp_designation (emp_no, title, from_date, to_date)
			VALUES (@emp_no, @desg_name, @hired_on, '9999-12-31'); -- Assuming '9999-12-31' as the end date for the current designation
		END

		-- Insert into dept_manager table if the employee is a department manager
		IF @is_dept_mgnr = 1
		BEGIN
			INSERT INTO dept_manager (emp_no, dept_no, from_date, to_date)
			VALUES (@emp_no, @dprt_id, @hired_on, '9999-12-31'); -- Assuming '9999-12-31' as an end date for current managers
		END

	END
    
    -- Return the newly inserted employee ID
    SELECT @msg 'msg', @emp_no AS 'New_Employee_ID';

END
GO
/****** Object:  StoredProcedure [dbo].[spx_add_employee_no_import]    Script Date: 10/7/2023 7:46:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ======================================================
-- Author:		Dharmik Soni
-- Create date: 2023-10-08
-- Description:	To add/save new employee in
-- ======================================================
-- EXEC employee_book.dbo.spx_add_employee_no_import @birth_date='1973-05-07', @first_name='Michael', @last_name='Adkins', 
-- @email='derick_kuhlm@yahoo.com', @gender='M', @hired_on='1980-04-21', @is_dept_mgnr=1, @salary=400000, 
-- @designation_name='Chief Financial Officer'

CREATE PROC [dbo].[spx_add_employee_no_import]
(
    @birth_date DATE NULL,
    @first_name VARCHAR(15) NULL, 
    @last_name VARCHAR(15) NULL, 
    @email NVARCHAR(50) NULL, 
    @gender CHAR(2) NULL,
    -- @department_id BIGINT NOT NULL,
    @hired_on DATE NULL,
    @is_dept_mgnr BIT,
    @salary MONEY NULL,
    @designation_name VARCHAR(50) NULL
)
AS
BEGIN
    SET NOCOUNT ON;

    -- Declare variables
    DECLARE @emp_no BIGINT=0, @dprt_id BIGINT=0, @dsgn_id BIGINT=0, @desg_name VARCHAR(50)='', 
    @msg VARCHAR(100) = '';

    SELECT @dsgn_id=ISNULL(d.id,0), @dprt_id=ISNULL(d.dept_id,0), @desg_name=ISNULL(d.designation_name, '')
    FROM designation d
    WHERE d.designation_name = @designation_name;

    --PRINT 'dsgn: '+ @dsgn_id;
    --PRINT 'dprt: '+ @dprt_id;

    -- if record exist then return
    SELECT @emp_no=ISNULL(e.id, 0)
    FROM dbo.employees e WITH (NOLOCK)
    WHERE @email= e.email;

    IF ISNULL(@emp_no, 0) > 0
	BEGIN
		SET @msg = 'Record Exists'
	END
	ELSE
		BEGIN
            -- Insert into employees table
            INSERT INTO employees (birth_date, first_name, last_name, email, gender, department_id, hired_on)
            VALUES (@birth_date, @first_name, @last_name, @email, @gender, @dprt_id, @hired_on);

            -- Get the newly inserted employee ID
            SET @emp_no = (SELECT MAX(id) FROM employees);

            -- Generate a random number of days between 0 and maximum difference in days
            DECLARE @MaxDiffDays INT = DATEDIFF(DAY, @hired_on, GETDATE())
            DECLARE @DaysDiff1 INT = CAST(RAND() * @MaxDiffDays AS INT)
            DECLARE @DaysDiff2 INT = CAST(RAND() * (@MaxDiffDays - @DaysDiff1) AS INT)

            -- Generate random dates between @hired_on and today
            DECLARE @ToDate1 DATE = DATEADD(DAY, @DaysDiff1, @hired_on)
            DECLARE @ToDate2 DATE = DATEADD(DAY, @DaysDiff1 + @DaysDiff2, @hired_on)

            -- Make sure @ToDate2 is the greater date
            IF @ToDate1 > @ToDate2
            BEGIN
                DECLARE @Temp DATE = @ToDate1
                SET @ToDate1 = @ToDate2
                SET @ToDate2 = @Temp
            END
            
            -- Insert into salaries table if salary is provided
            IF @salary IS NOT NULL
            BEGIN
                INSERT INTO salaries (emp_no, salary, from_date, to_date)
                VALUES (@emp_no, @salary, @hired_on, @ToDate1);
            END

            IF @dsgn_id IS NOT NULL
            BEGIN
                INSERT INTO emp_designation (emp_no, title, from_date, to_date)
                VALUES (@emp_no, @desg_name, @ToDate1, @ToDate2);
            END

            -- Insert into dept_manager table if the employee is a department manager
            IF @is_dept_mgnr = 1
            BEGIN
                INSERT INTO dept_manager (emp_no, dept_no, from_date, to_date)
                VALUES (@emp_no, @dprt_id, @ToDate1, @ToDate2);
            END
        END
    END
    -- Return the newly inserted employee ID
    SELECT @emp_no AS 'New_Employee_ID', @msg as 'message';

GO
USE [master]
GO
ALTER DATABASE [employee_book] SET  READ_WRITE 
GO

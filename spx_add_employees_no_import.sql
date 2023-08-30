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



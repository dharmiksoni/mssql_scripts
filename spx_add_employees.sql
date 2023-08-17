-- ======================================================
-- Author:		Dharmik Soni
-- Create date: 2023-10-08
-- Description:	To add/save new employee in
-- ======================================================
--EXEC employee_book.dbo.add_employee @birth_date='11-01-1965', @first_name='Mili', @last_name='Sairous', @email='mili.sairous@gmail.com', @gender='M', @hired_on='12-05-1985', @is_dept_mgnr=1, @salary=205000, @designation_name='Data Scientist'

ALTER PROC [dbo].[spx_add_employee]
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


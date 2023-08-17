
-- ======================================================
-- Author:		Dharmik Soni
-- Create date: 2023-12-08
-- Description:	To bulk import in json format
-- ======================================================
--EXEC spx_bulk_import N'[JSON]'

/**
birth_date, first_name, last_name, @email, @gender, @hired_on, @is_dept_mgnr, @salary, @designation_name
*/

CREATE PROC [dbo].[spx_bulk_import]
(
	@json NVARCHAR(MAX)
)
AS
BEGIN
	SET NOCOUNT OFF;
	DECLARE @msg VARCHAR(100) = '', @rows_affected INT = 0,@Id BIGINT = NULL
	--DECLARE @json NVARCHAR(MAX);

	IF OBJECT_ID('tempdb..#master_table') IS NOT NULL 
		DROP TABLE #master_table

    SELECT * INTO #master_table
	FROM OPENJSON(@json)
	WITH (
		[birth_date] [date] '$.birth_date',
        [first_name] VARCHAR(50) '$.first_name',
		[last_name] VARCHAR(50) '$.last_name',
		[email] VARCHAR(50) '$.email'
		[gender] CHAR(2) '$.gender'
		[hired_on] [date] '$.hired_on'
		[is_dept_mgnr] BIT '$.is_dept_mgnr'
		[salary] MONEY '$.salary',
        [designation_name] varchar(50) '$.designation_name'
	);

    -- Declare variables
    DECLARE @emp_no BIGINT=0, @dprt_id BIGINT=0, @dsgn_id BIGINT=0, @desg_name VARCHAR(50)='';

    SELECT @dsgn_id=ISNULL(d.id,0), @dprt_id=ISNULL(d.dept_id,0), @desg_name=ISNULL(d.designation_name, '')
    FROM designation d
    FROM #master_table mt;
    WHERE d.designation_name = mt.designation_name;

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






    INSERT INTO [kyc].[dbo].[tbl_kyc_bank_acc_type_master](
        birth_date,
        first_name,
        last_name,
        email,
        gender,
        hired_on,
        is_dept_mgnr,
        salary
	)SELECT
		mt.birth_date,
        mt.first_name,
        mt.last_name,
        mt.email,
        mt.gender,
        mt.hired_on,
        mt.is_dept_mgnr,
        mt.salary
	FROM #master_table mt;

  	SET @rows_affected = @@ROWCOUNT;

	IF @rows_affected > 0
		SET @msg = 'DATA_SAVED_SUCCESSFULLY'
	ELSE 
	SET @msg = 'NO_RECORDS_UPDATED'

	DROP TABLE #master_table

	SELECT @msg AS 'message',@rows_affected as 'rows_affected'
END
GO
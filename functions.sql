/**
-- scaler user-defined function
-- select dbo.getEmployees()
-- get count of all employees
**/
CREATE FUNCTION getEmployees()
RETURNS INT
AS
BEGIN
	DECLARE @e_count INT
    -- function body
    SELECT @e_count = COUNT(id) from employees

	RETURN @e_count
END

/**
-- inline table valued function
-- select * from getHighestSalariesEmpByDept()
-- SQL query to find the highest salary employees in each department
**/
CREATE FUNCTION getHighestSalariesEmpByDept(@dept_id INT)
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


/**
-- multi statement table

**/
CREATE FUNCTION getHighestSalariesEmpByDeptMultiStatement(@dept_id INT)
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
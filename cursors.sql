-- write a SQL cursor to compute the experience of all the managers. Return employee ID, employee name, 
-- job name, joining date, and experience

DECLARE @name nvarchar(100) = NULL;
DECLARE employeeCursor CURSOR FOR

SELECT  first_name FROM employees

OPEN employeeCursor

FETCH NEXT FROM employeeCursor INTO @name=first_name;

WHILE @@FETCH_STATUS=0
    BEGIN
        FETCH NEXT FROM employeeCursor;
    END

CLOSE employeeCursor
DEALLOCATE employeeCursor

---

DECLARE @id BIGINT, @first_name varchar(15), @last_name varchar(15)
, @hired_on DATE, @from_date DATE;

DECLARE employeeCursor CURSOR FOR

SELECT
    e.id,
    e.first_name + ' ' + e.last_name AS employee_name,
    e.hired_on AS joining_date,
    dm.from_date AS manager_start_date,
    DATEDIFF(YEAR, e.hired_on, GETDATE()) AS experience_years
FROM employees e
INNER JOIN dept_manager dm ON e.id = dm.emp_no
WHERE e.id IS NOT NULL
ORDER BY e.id;

OPEN employeeCursor


FETCH NEXT FROM employeeCursor INTO @name=first_name;

WHILE @@FETCH_STATUS=0 
    BEGIN
        FETCH NEXT FROM employeeCursor;
    END

CLOSE employeeCursor
DEALLOCATE employeeCursor
--write a SQL query to compute the experience of all the managers. Return employee ID, employee name, job name, joining date, and experience

-- solution 1 - INNER join using 
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

-- write a SQL query to find those departments where no employee works. Return department ID
-- solution 1 - using RIGHT JOIN
SELECT
   ISNULL(d.id,0), ISNULL(d.dept_name,'')
FROM departments d WITH (NOLOCK)
RIGHT JOIN employees e WITH (NOLOCK) ON d.id= e.department_id
WHERE e.department_id IS NULL;

-- solution 1 - using LEFT JOIN

SELECT
   ISNULL(d.id,0), ISNULL(d.dept_name,'')
FROM employees e WITH (NOLOCK)
LEFT JOIN departments d WITH (NOLOCK) ON d.id= e.department_id
WHERE e.department_id IS NULL;


--Write a SQL query to find the highest salary employees in each department

-- solution : 1 - using join
SELECT
    e.id AS emp_id,
    e.first_name,
    e.last_name,
    d.dept_name,
    s.salary
FROM employees e
JOIN salaries s ON e.id = s.emp_no
JOIN departments d ON e.department_id = d.id
LEFT JOIN salaries s2 ON e.id = s2.emp_no AND s.salary < s2.salary
WHERE s2.emp_no IS NULL;

-- solution : 2 - using group by
SELECT
    e.id AS emp_id,
    e.first_name,
    e.last_name,
    d.dept_name,
    MAX(s.salary) AS highest_salary
FROM employees e
JOIN salaries s ON e.id = s.emp_no
JOIN departments d ON e.department_id = d.id
GROUP BY e.id, e.first_name, e.last_name, d.dept_name;

-- solution : 3 - using cte
WITH MaxSalaries AS (
    SELECT
        emp_no,
        salary,
        ROW_NUMBER() OVER(PARTITION BY emp_no ORDER BY salary DESC) AS salary_rank
    FROM salaries
)
SELECT
    e.id AS emp_id,
    e.first_name,
    e.last_name,
    d.dept_name,
    s.salary
FROM employees e
JOIN MaxSalaries s ON e.id = s.emp_no AND s.salary_rank = 1
JOIN departments d ON e.department_id = d.id;

-- solution : 4 - using inner join
SELECT
    e.id AS emp_id,
    e.first_name,
    e.last_name,
    d.dept_name,
    s.salary
FROM employees e
INNER JOIN (
    SELECT
        emp_no,
        MAX(salary) AS max_salary
    FROM salaries
    GROUP BY emp_no
) max_salaries ON e.id = max_salaries.emp_no
INNER JOIN salaries s ON e.id = s.emp_no AND s.salary = max_salaries.max_salary
INNER JOIN departments d ON e.department_id = d.id;

-- solution : 5 - using left join
SELECT
    e.id AS emp_id,
    e.first_name,
    e.last_name,
    d.dept_name,
    s.salary
FROM employees e
LEFT JOIN (
    SELECT
        emp_no,
        MAX(salary) AS max_salary
    FROM salaries
    GROUP BY emp_no
) max_salaries ON e.id = max_salaries.emp_no
LEFT JOIN salaries s ON e.id = s.emp_no AND s.salary = max_salaries.max_salary
LEFT JOIN departments d ON e.department_id = d.id;

-- solution : 6 - join with subquery
SELECT
    e.id AS emp_id,
    e.first_name,
    e.last_name,
    d.dept_name,
    s.salary
FROM employees e
JOIN (
    SELECT
        emp_no,
        salary,
        ROW_NUMBER() OVER(PARTITION BY emp_no ORDER BY salary DESC) AS salary_rank
    FROM salaries
) s ON e.id = s.emp_no AND s.salary_rank = 1
JOIN departments d ON e.department_id = d.id;



--select statements
select * from designation WITH (NOLOCK);
select * from departments WITH (NOLOCK);
select * from employees WITH (NOLOCK);
select * from dept_manager WITH (NOLOCK);
select * from emp_designation WITH (NOLOCK);
select * from salaries WITH (NOLOCK);

--drop table
drop table employees
drop table dept_manager
drop table emp_designation
drop table salaries

--delete record
delete from employees
where id between 1 and 30

--update record
UPDATE designation
SET dept_id = 9
where id between 42 and 45


-- Generate a random number of days between 0 and maximum difference in years converted to days (e.g., 3 years = 1095 days, 5 years = 1825 days, 11 years = 4015 days)
DECLARE @MaxDiffYears INT = 40 -- You can change this value to any desired maximum difference in years
DECLARE @MaxDaysDiff INT = @MaxDiffYears * 365
DECLARE @DaysDiff1 INT = RAND() * @MaxDaysDiff
DECLARE @DaysDiff2 INT = RAND() * @MaxDaysDiff

-- Generate a random date between 1947-01-01 and today
DECLARE @ToDate1 DATE = DATEADD(DAY, -@DaysDiff1, GETDATE())
DECLARE @ToDate2 DATE = DATEADD(DAY, -@DaysDiff2, GETDATE())

-- Make sure @ToDate2 is the greater date
IF @ToDate1 > @ToDate2
BEGIN
    DECLARE @Temp DATE = @ToDate1
    SET @ToDate1 = @ToDate2
    SET @ToDate2 = @Temp
END

-- Generate a random number of days between 730 (2 years) and @DaysDiff1 (maximum difference) for @FromDate1
DECLARE @FromDateDiff1 INT = ROUND(RAND() * (@DaysDiff1 - 730) + 730, 0)
DECLARE @FromDate1 DATE = DATEADD(DAY, -@FromDateDiff1, @ToDate1)

-- Generate a random number of days between 730 (2 years) and @DaysDiff2 (maximum difference) for @FromDate2
DECLARE @FromDateDiff2 INT = ROUND(RAND() * (@DaysDiff2 - 730) + 730, 0)
DECLARE @FromDate2 DATE = DATEADD(DAY, -@FromDateDiff2, @ToDate2)

SELECT @FromDate1 AS from_date, @ToDate1 AS to_date

UNION ALL
SELECT @FromDate2 AS from_date, @ToDate2 AS to_date

-----------------
--Generate random users
-----------------

-- Generate a list of random cities using a subquery within a CTE
;WITH RandomCities AS (
    SELECT TOP 100
        city
    FROM
        (
            VALUES
                ('New York'),
                ('Los Angeles'),
                ('Chicago'),
                ('Houston'),
                ('Seattle'),
                ('Kansas City'),
                ('Denver'),
                ('Austin'),
                ('Las Vegas'),
                ('Detroit'),
                ('Phoenix')
        ) AS Cities(city)
    ORDER BY NEWID()
)

-- Generate a list of random department IDs using a subquery within a CTE
, RandomDepartments AS (
    SELECT TOP 100
        id
    from departments
    ORDER BY NEWID()
)

-- Insert 100 random records into 'users' with random names, city, and department_id
INSERT INTO dbo.users ([name], [gender], [city], [department_id], [salary])
SELECT TOP 100
    --(SELECT TOP 1 FirstName FROM @FirstNames ORDER BY NEWID()) + ' ' + (SELECT TOP 1 LastName FROM @LastNames ORDER BY NEWID()) AS [name],
	CONCAT('Name', ABS(CHECKSUM(NEWID())) % 1000) AS [name],
    CASE WHEN ABS(CHECKSUM(NEWID())) % 2 = 0 THEN 'M' ELSE 'F' END AS [gender],
    [city],
    id,
    CAST((ABS(CHECKSUM(NEWID())) % 90000 + 30000) AS MONEY) AS [salary]
FROM RandomCities
CROSS JOIN RandomDepartments;
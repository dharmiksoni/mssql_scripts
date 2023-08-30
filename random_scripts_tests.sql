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

-- Query - 5 
--    Solution - 3

---------------------------
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
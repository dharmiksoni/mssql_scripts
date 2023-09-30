select * from dbo.departments

select * from dbo.users

--------------------
CREATE TABLE [dbo].[departments](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[dept_name] [varchar](40) NOT NULL,
	[location] varchar(100),
	[dept_head] varchar(100)
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


--------------
INSERT INTO departments(dept_name, [location], [dept_head]) VALUES('Marketing', 'New York', 'Michell'),
('Finance', 'Los Angeles', 'Michael'),
('Human Resources', 'Chicago', 'Deva'),
('Production', 'Seattle', 'Hissar'),
('Development', 'Denver', 'Murado'),
('Quality Management', 'Austin', 'Gale'),
('Sales', 'Las Vegas', 'Rahul'),
('Research', 'Detroit', 'Priti'),
('Customer Service', 'Phoenix', 'Laura')

INSERT INTO departments(dept_name, [location], [dept_head]) VALUES('Software', 'New Jersey', 'Sahu')
-----------------
CREATE TABLE [dbo].users(
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[name] varchar(100),
	[gender] [char](2) NOT NULL,
	[city] varchar(50),
	[department_id] [bigint] NOT NULL,
	[salary] money
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].users  WITH CHECK ADD FOREIGN KEY([department_id])
REFERENCES [dbo].[departments] ([id])
GO


---

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

----
delete from users
where id between 1 and 300

----
update users
set department_id = NULL
where id=202

---------------

select *
from users u
join departments d on u.department_id = d.id
where u.department_id IS NULL
OR d.id IS NULL

alter table users
alter column department_id BIGINT null


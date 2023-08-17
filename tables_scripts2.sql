tables

tables
    designation - y
    emp_designation

    employees - y

    dept_manager
    -- dept_emp
    departments - y

    salaries

columns
-- all designation list
CREATE TABLE designation(
    id      INT    IDENTITY(1,1)         NOT NULL,
    designation_name       VARCHAR(50)     NOT NULL,
    [creation_date] [datetime] default(getdate()) NOT NULL,
	[updation_date] [datetime] NULL,
    dept_id		BIGINT
    -- from_date   DATE            NOT NULL,
    -- to_date     DATE,
    -- FOREIGN KEY (emp_no) REFERENCES employees (emp_no) ON DELETE CASCADE, 
    -- PRIMARY KEY (emp_no,title, from_date)
    PRIMARY KEY CLUSTERED
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE emp_designation (
    emp_no     BIGINT   NOT NULL,
    designation_id     BIGINT     NOT NULL,
    from_date   DATE            NOT NULL,
    to_date     DATE,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no) ON DELETE CASCADE,
    PRIMARY KEY (emp_no,title, from_date)
);
ALTER TABLE [emp_designation]  WITH CHECK ADD FOREIGN KEY([emp_no])
REFERENCES [employees] ([id])
GO


CREATE TABLE employees (
    id      BIGINT IDENTITY(1,1) NOT NULL,
    [creation_date] [datetime] default(getdate()) NOT NULL,
	[updation_date] [datetime] NULL,
    birth_date  DATE NOT NULL,
    first_name  VARCHAR(15) NOT NULL,
    last_name   VARCHAR(15) NOT NULL,
    email       NVARCHAR(50) NOT NULL,
    gender      CHAR(2)  NOT NULL,
    hired_on    DATE NOT NULL,
    department_id DATE NOT NULL,
    PRIMARY KEY CLUSTERED
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [employees]  WITH CHECK ADD FOREIGN KEY([department_id])
REFERENCES [departments] ([id])
GO

CREATE TABLE departments (
    id BIGINT IDENTITY(1,1) NOT NULL,
    dept_name   VARCHAR(40) UNIQUE  KEY NOT NULL,
    [creation_date] [datetime] default(getdate()) NOT NULL,
	[updation_date] [datetime] NULL,
    PRIMARY KEY CLUSTERED
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE dept_manager (
   emp_no       INT             NOT NULL,
   dept_no      CHAR(4)         NOT NULL,
   from_date    DATE            NOT NULL,
   to_date      DATE            NOT NULL,
   FOREIGN KEY (emp_no)  REFERENCES employees (id)    ON DELETE CASCADE,
   FOREIGN KEY (dept_no) REFERENCES departments (id) ON DELETE CASCADE,
   PRIMARY KEY (emp_no,dept_no)
); 

-- CREATE TABLE dept_emp (
--     emp_no      INT             NOT NULL,
--     dept_no     CHAR(4)         NOT NULL,
--     from_date   DATE            NOT NULL,
--     to_date     DATE            NOT NULL,
--     FOREIGN KEY (emp_no)  REFERENCES employees   (emp_no)  ON DELETE CASCADE,
--     FOREIGN KEY (dept_no) REFERENCES departments (dept_no) ON DELETE CASCADE,
--     PRIMARY KEY (emp_no,dept_no)
-- );


CREATE TABLE salaries (
    emp_no      INT             NOT NULL,
    salary      INT             NOT NULL,
    from_date   DATE            NOT NULL,
    to_date     DATE            NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (id) ON DELETE CASCADE,
    PRIMARY KEY (emp_no, from_date)
); 

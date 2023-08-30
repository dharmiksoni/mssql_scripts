
--departments
CREATE TABLE [dbo].[departments](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[dept_name] [varchar](40) NOT NULL,
	[creation_date] [datetime] NOT NULL,
	[updation_date] [datetime] NULL,
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

ALTER TABLE [dbo].[departments] ADD  DEFAULT (getdate()) FOR [creation_date]
GO
-----------------------------------------------------------------

--dept_manager
CREATE TABLE [dbo].[dept_manager](
	[emp_no] [bigint] NOT NULL,
	[dept_no] [bigint] NOT NULL,
	[from_date] [date] NOT NULL,
	[to_date] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[emp_no] ASC,
	[dept_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[dept_manager]  WITH CHECK ADD FOREIGN KEY([dept_no])
REFERENCES [dbo].[departments] ([id])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[dept_manager]  WITH CHECK ADD FOREIGN KEY([emp_no])
REFERENCES [dbo].[employees] ([id])
ON DELETE CASCADE
GO

-----------------------------------------------------------------

--designation
CREATE TABLE [dbo].[designation](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[designation_name] [varchar](50) NOT NULL,
	[creation_date] [datetime] NOT NULL,
	[updation_date] [datetime] NULL,
	[dept_id] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[designation] ADD  DEFAULT (getdate()) FOR [creation_date]
GO

-----------------------------------------------------------------

--emp_designation
CREATE TABLE [dbo].[emp_designation](
	[emp_no] [bigint] IDENTITY(1,1) NOT NULL,
	[title] [varchar](50) NOT NULL,
	[from_date] [date] NOT NULL,
	[to_date] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[emp_no] ASC,
	[title] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[emp_designation]  WITH CHECK ADD FOREIGN KEY([emp_no])
REFERENCES [dbo].[employees] ([id])
GO

-----------------------------------------------------------------

--employees
CREATE TABLE [dbo].[employees](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[creation_date] [datetime] NOT NULL,
	[updation_date] [datetime] NULL,
	[birth_date] [date] NOT NULL,
	[first_name] [varchar](15) NOT NULL,
	[last_name] [varchar](15) NOT NULL,
	[email] [nvarchar](50) NOT NULL,
	[gender] [char](2) NOT NULL,
	[department_id] [bigint] NOT NULL,
	[hired_on] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[employees] ADD  DEFAULT (getdate()) FOR [creation_date]
GO

ALTER TABLE [dbo].[employees]  WITH CHECK ADD FOREIGN KEY([department_id])
REFERENCES [dbo].[departments] ([id])
GO

-----------------------------------------------------------------

--salaries
CREATE TABLE [dbo].[salaries](
	[emp_no] [bigint] NOT NULL,
	[salary] [money] NULL,
	[from_date] [date] NOT NULL,
	[to_date] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[emp_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[salaries]  WITH CHECK ADD FOREIGN KEY([emp_no])
REFERENCES [dbo].[employees] ([id])
ON DELETE CASCADE
GO



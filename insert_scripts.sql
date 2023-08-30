
/**
Raw data for department and designation with id's
5
1	Staff
2	Senior Staff
3	Assistant Engineer
4	Engineer
5	Senior Engineer
6	Technique Leader

1
7	Manager
8	Marketing Manager
9	Brand Manager
10	SEO Specialist
11	Email Marketing Specialist
12	Graphic Designer
13	Copywriter
14	Market Research Analyst

2
15	Chief Financial Officer
16	Financial Analyst
17	Accountant
18	Compliance Officer
19	Internal Auditor

3
20	Human Resources Manager
21	Talent Acquisition Specialist
22	Employee Relations Specialist
23	HR Analyst
24	HR Director
25	HR Consultant

4
26	Production Manager
27	Production Supervisor
28	Quality Control Inspector
29	Manufacturing Engineer
30	Inventory Controller
31	Packaging Operator

6
32	Quality Manager
33	Quality Engineer

7
34	Sales Quality Manager
35	Customer Experience Specialist
36	Sales Operations Analyst
37	Sales Operations Analyst

8
38	Research Analyst
39	Data Scientist
40	Principal Investigator
41	Research Consultant

9
42	Customer Support Specialist
43	Customer Service Manager
44	Call Center Agent
45	Customer Success Manager


1	Marketing
2	Finance
3	Human Resources
4	Production
5	Development
6	Quality Management
7	Sales
8	Research
9	Customer Service

*/

--departments
INSERT INTO departments(dept_name) VALUES('Marketing')
INSERT INTO departments(dept_name) VALUES('Finance')
INSERT INTO departments(dept_name) VALUES('Human Resources')
INSERT INTO departments(dept_name) VALUES('Production')
INSERT INTO departments(dept_name) VALUES('Development')
INSERT INTO departments(dept_name) VALUES('Quality Management')
INSERT INTO departments(dept_name) VALUES('Sales')
INSERT INTO departments(dept_name) VALUES('Research')
INSERT INTO departments(dept_name) VALUES('Customer Service')


--designation
INSERT INTO designation(designation_name) VALUES('Staff')
INSERT INTO designation(designation_name) VALUES('Senior Staff')
INSERT INTO designation(designation_name) VALUES('Assistant Engineer')
INSERT INTO designation(designation_name) VALUES('Engineer')
INSERT INTO designation(designation_name) VALUES('Senior Engineer')
INSERT INTO designation(designation_name) VALUES('Technique Leader')
INSERT INTO designation(designation_name) VALUES('Manager')

INSERT INTO designation(designation_name) VALUES('Marketing Manager')
INSERT INTO designation(designation_name) VALUES('Brand Manager')
INSERT INTO designation(designation_name) VALUES('SEO Specialist')
INSERT INTO designation(designation_name) VALUES('Email Marketing Specialist')
INSERT INTO designation(designation_name) VALUES('Graphic Designer')
INSERT INTO designation(designation_name) VALUES('Copywriter')
INSERT INTO designation(designation_name) VALUES('Market Research Analyst')


INSERT INTO designation(designation_name) VALUES('Chief Financial Officer')
INSERT INTO designation(designation_name) VALUES('Financial Analyst')
INSERT INTO designation(designation_name) VALUES('Accountant')
INSERT INTO designation(designation_name) VALUES('Compliance Officer')
INSERT INTO designation(designation_name) VALUES('Internal Auditor')


INSERT INTO designation(designation_name) VALUES('Human Resources Manager')
INSERT INTO designation(designation_name) VALUES('Talent Acquisition Specialist')
INSERT INTO designation(designation_name) VALUES('Employee Relations Specialist')
INSERT INTO designation(designation_name) VALUES('HR Analyst')
INSERT INTO designation(designation_name) VALUES('HR Director')
INSERT INTO designation(designation_name) VALUES('HR Consultant')


INSERT INTO designation(designation_name) VALUES('Production Manager')
INSERT INTO designation(designation_name) VALUES('Production Supervisor')
INSERT INTO designation(designation_name) VALUES('Quality Control Inspector')
INSERT INTO designation(designation_name) VALUES('Manufacturing Engineer')
INSERT INTO designation(designation_name) VALUES('Inventory Controller')
INSERT INTO designation(designation_name) VALUES('Packaging Operator')

INSERT INTO designation(designation_name) VALUES('Quality Manager')
INSERT INTO designation(designation_name) VALUES('Quality Engineer')


INSERT INTO designation(designation_name) VALUES('Sales Quality Manager')
INSERT INTO designation(designation_name) VALUES('Customer Experience Specialist')
INSERT INTO designation(designation_name) VALUES('Sales Operations Analyst')
INSERT INTO designation(designation_name) VALUES('Sales Operations Analyst')

INSERT INTO designation(designation_name) VALUES('Research Assistant')

INSERT INTO designation(designation_name) VALUES('Research Analyst')
INSERT INTO designation(designation_name) VALUES('Data Scientist')
INSERT INTO designation(designation_name) VALUES('Principal Investigator')
INSERT INTO designation(designation_name) VALUES('Research Consultant')


INSERT INTO designation(designation_name) VALUES('Customer Support Specialist')
INSERT INTO designation(designation_name) VALUES('Customer Service Manager')
INSERT INTO designation(designation_name) VALUES('Call Center Agent')
INSERT INTO designation(designation_name) VALUES('Customer Success Manager')


--employees
INSERT INTO dbo.employees (birth_date, first_name, last_name, email, gender, department_id, hired_on)
VALUES ('1953-09-02','Georgi','Facello','georgi.facello@gmail.com','M',2,'1986-06-26'),
('1964-06-02','Bezalel','Simmel','Bezalel.Simmel@gmail.com','F',2,'1985-11-21'),
('1959-12-03','Parto','Bamford','Parto.Bamford@gmail.com','M',1,'1986-08-28'),
('1954-05-01','Chirstian','Koblick','Chirstian.Koblick@gmail.com','M',1,'1986-12-01'),
('1955-01-21','Kyoichi','Maliniak','Kyoichi.Maliniak','M',3,'1989-09-12'),
('1953-04-20','Anneke','Preusig','Anneke.Preusig@gmail.com','F',3,'1989-06-02'),
('1957-05-23','Tzvetan','Zielinski','Tzvetan.Zielinski@gmail.com','F',3,'1989-02-10'),
('1958-02-19','Saniya','Kalloufi','Saniya.Kalloufi@gmail.com','M',4,'1994-09-15'),
('1952-04-19','Sumant','Peac','Sumant.Peac@gmail.com','F',4,'1985-02-18'),
('1963-06-01','Duangkaew','Piveteau','Duangkaew.Piveteau@gmail.com','F',4,'1989-08-24'),
('1953-11-07','Mary','Sluis','Mary.Sluis@gmail.com','F',5,'1990-01-22'),
('1960-10-04','Patricio','Bridgland','Patricio.Bridgland@gmail.com','M',5,'1992-12-18'),
('1963-06-07','Eberhardt','Terkki','Eberhardt.Terkki@gmail.com','M',5,'1985-10-20'),
('1956-02-12','Berni','Genin','Berni.Genin@gmail.com','M',5,'1987-03-11'),
('1959-08-19','Guoxiang','Nooteboom','Guoxiang.Nooteboom@gmail.com','M',5,'1987-07-02'),
('1961-05-02','Kazuhito','Cappelletti','Kazuhito.Cappelletti@gmail.com','M',5,'1995-01-27'),
('1958-07-06','Cristinel','Bouloucos','Cristinel.Bouloucos@gmail.com','F',5,'1993-08-03'),
('1954-06-19','Kazuhide','Peha','Kazuhide.Peha@gmail.com','F',5,'1987-04-03'),
('1953-01-23','Lillian','Haddadi','Lillian.Haddadi@gmail.com','M',6,'1999-04-30'),
('1952-12-24','Mayuko','Warwick','Mayuko.Warwick@gmail.com','M',6,'1991-01-26'),
('1960-02-20','Ramzi','Erde','Ramzi.Erde@gmail.com','M',7,'1988-02-10'),
('1952-07-08','Shahaf','Famili','Shahaf.Famili@gmail.com','M',7,'1995-08-22'),
('1953-09-29','Bojan','Montemayor','Bojan.Montemayor@gmail.com','F',7,'1989-12-17'),
('1958-09-05','Suzette','Pettey','Suzette.Pettey@gmail.com','F',7,'1997-05-19'),
('1958-10-31','Prasadram','Heyers','Prasadram.Heyers@gmail.com','M',8,'1987-08-17'),
('1953-04-03','Yongqiao','Berztiss','Yongqiao.Berztiss@gmail.com','M',8,'1995-03-20'),
('1962-07-10','Divier','Reistad','Divier.Reistad@gmail.com','F',8,'1989-07-07'),
('1963-11-26','Domenick','Tempesti','Domenick.Tempesti@gmail.com','M',9,'1991-10-22'),
('1956-12-13','Otmar','Herbst','Otmar.Herbst@gmail.com','M',9,'1985-11-20')

--emp_designtation
INSERT INTO dbo.emp_designation(emp_no, designation_id, from_date, to_date)
VALUES (1,15,'1986-06-26','9999-01-01')
VALUES (2,16,'1986-06-26','9999-01-01')

VALUES (3,15,'1986-06-26','9999-01-01')
VALUES (1,15,'1986-06-26','9999-01-01')
VALUES (1,15,'1986-06-26','9999-01-01')
VALUES (1,15,'1986-06-26','9999-01-01')
VALUES (1,15,'1986-06-26','9999-01-01')

VALUES (1,15,'1986-06-26','9999-01-01')
VALUES (1,15,'1986-06-26','9999-01-01')
VALUES (1,15,'1986-06-26','9999-01-01')
VALUES (1,15,'1986-06-26','9999-01-01')
VALUES (1,15,'1986-06-26','9999-01-01')
VALUES (1,15,'1986-06-26','9999-01-01')
VALUES (1,15,'1986-06-26','9999-01-01')
VALUES (1,15,'1986-06-26','9999-01-01')
VALUES (1,15,'1986-06-26','9999-01-01')
VALUES (1,15,'1986-06-26','9999-01-01')
VALUES (1,15,'1986-06-26','9999-01-01')
VALUES (1,15,'1986-06-26','9999-01-01')
VALUES (1,15,'1986-06-26','9999-01-01')
VALUES (1,15,'1986-06-26','9999-01-01')
VALUES (1,15,'1986-06-26','9999-01-01')
VALUES (1,15,'1986-06-26','9999-01-01')
VALUES (1,15,'1986-06-26','9999-01-01')
VALUES (1,15,'1986-06-26','9999-01-01')
VALUES (1,15,'1986-06-26','9999-01-01')
VALUES (1,15,'1986-06-26','9999-01-01')
VALUES (1,15,'1986-06-26','9999-01-01')
VALUES (1,15,'1986-06-26','9999-01-01')

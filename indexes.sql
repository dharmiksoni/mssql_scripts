-- types
/*
    1. clustered
    2. non-clustered
    3. unique
    4. filtered
    5. xml
    6. full text
    7. spatial
    8. columnstore
    9.index with included column
    10. index on computed column
*/

-- create index on salaries
CREATE index IX_tblEmployee_Salary
ON dbo.salaries (salary asc)

/*
clustered index determines physical order of data in table. so table can have only one clustered index.
*/
-- clustered index
CREATE clustered index IX_tblEmployee_Gender_Salary
ON dbo.employees(id asc)

-- drop existing clustered index
drop index employees.PK__employee__3213E83F79CCB23A

-- composite index
CREATE clustered index IX_tblEmployee_Gender_Salary
ON dbo.employees(id asc, gender DESC)

-- non clustered
/*
a non-clustered index is analogous to an index in a textbook. the data is stored in one place and index at another.
the index will have pointers to the storage location of the data.

since non-clustered index is stored separately from actual data, table can have more than one non-clustered index

*/
create NONCLUSTERED index IX_tblEmployee_Name
ON employees (first_name)

create NONCLUSTERED index IX_tblEmployee_Name
ON emp_designation (title)

/*
difference clustered vs non-clustered
1. only one clustered index per table, you can have more than one non-clustered index
2. clusterd index is faster because it has to refer back to table, if the selected column is not present in the index
3. cluster index determines the storage order of rows in the table, and doesnt require additional disk space, whereas 
non-clustered indexes are stored are separately and pointers are define poining to data store
*/


/*
unique index is used to enforce uniqueness key values in the index

primary key creates/uses unique cluster index to enforce uniqueness of records
*/
create unique NONCLUSTERED index
UIX_tblEmployee_FirstName_LastName
on dbo.employees(first_name, last_name)

/*
difference b/w unique constraint and unique index

:- there is no major diff b/w unique contraint and unique index, when you add unique constraint unique index gets
created behind the scenes
*/

/*
1. by default : a PK contraint, creates a unique clustered index, where unique contraint created unique non-clustered
index.
*/
-- Backup
BACKUP DATABASE employee_book
TO DISK = 'path to folder'
WITH FORMAT, INIT, NAME = 'Employee Book full backup'


-- restore
use employee_book;
RESTORE DATABASE employee_book
FROM DISK = 'path to back file/file.bak'
WITH REPLACE;

-- UI process
-- Open MS Server Management studio
-- Open database tree
-- Select database to backup
-- Right click -> Tasks -> Select Backup
-- Right click -> Tasks -> Select Restore
-- task1 
-- 1. Data is raw numbers, figures and symbols. Database is a collection of data which can be stored, managed and edited. Relational database is a database which is linked to the certain tables. A table is a structure whic stores data in columns and rows.
-- 2. 5 key features of sql server are Relational database amanagement, Security, Performance, High avaibility, Integration tools.
-- 3. Windows authentication, sql server authentication, mixed.

-- task 2
-- 4 and 5
create database schoolDB 
create table Students (StudentID int primary key, Name varchar(50), Age int);
select * from Students
-- 6. SQL is a programming language. SQL server is the engine we use to manage data in SQL. SSMS is an application that we can connect to the sql server and run sql queries.

-- task 3
-- 7. DQL (Data query language): SELECT. It shows data from the database.
--    DML (Data manipulation language): INSERT, UPDATE, DELETE
--    DDL (Data definition language): CREATE, ALTER, DROP, TRUNCATE
--    DCL (Data control language): GRANT, REVOKE
--    TCL (Transaction control language): COMMIT, ROLLBACK, SAVEPOINT
-- 8.
INSERT INTO Students (StudentID, Name, Age)
VALUES 
(1, 'Alice', 20),
(2, 'Bob', 22),
(3, 'Charlie', 19);
-- 9. First we download AdventureWorksDW2022.bak file then open SSMS. Right-click on Databases, then we select Restore Database, then browse to find this file. After we found it, we select OK.

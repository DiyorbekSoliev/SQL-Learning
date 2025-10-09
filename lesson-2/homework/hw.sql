create database company

-- in this database we create a table for employees
create table Employees (EmpID int, Name varchar(50), Salary decimal(10,2))

select * from Employees 

-- now, we insert data into this table in 2 ways(single-line and multi-line)
insert into Employees (EmpID, Name, Salary) values (1, 'John Smith', 60000)
insert into Employees (EmpID, Name, Salary) 
values
(2, 'Emily Johnson', 55000),
(3, 'Michael Brown', 75000);

update Employees
set Salary = 7000
where EmpID = 1

delete from Employees where EmpID = 2

-- delete =  removes some or all records from the table, truncate = removes all records, drop = deletes the entire table

alter table employees
alter column Name varchar(100);

alter table employees
add Department varchar(50);

alter table employees
alter column Salary float;

create table Departments (DepartmentID int primary key, DepartmentName varchar(50))

select * from Departments

truncate table employees

-- task 2

insert into Departments (DepartmentID, DepartmentName)
values 
(1, 'Marketing'),
(2, 'Security'),
(3, 'IT'),
(4, 'Finance')
insert into Departments (DepartmentID, DepartmentName)
values 
(5, 'Management')

select * from Departments

insert into Employees (EmpID, Name, Salary, Department)
values
(1, 'John Smith', 4800, 'IT'),
(2, 'Emily Johnson', 9000, 'Finance'),
(3, 'Michael Brown', 2000, 'Management'),
(4, 'Sophia Davis', 4500, 'Marketing'),
(5, 'Daniel Wilson', 4000, 'Security'),
(6, 'Olivia Taylor', 1000, 'Marketing'),
(7, 'James Anderson', 7000, 'Finance'),
(8, 'Ava Martin', 7000, 'IT'),
(9, 'William Thomas', 8000, 'Management'),
(10, 'Mia Garcia', 8000, 'Security');

select * from Employees

update Employees
set Department = 'Management'
where Salary > 5000

Truncate table employees

alter table employees
drop column Department

exec sp_rename employees, StaffMembers
select * from StaffMembers

drop table Departments

-- task3

create table Products (ProductID int primary key, ProductName varchar(50), Category varchar(50), Price decimal(10, 2))
select * from Products

alter table Products
add constraint chk_price_positive
check (price > 0)

exec sp_help Products

alter table Products
add StockQuantity int default 50

exec sp_rename 'Products.Category', 'ProductCategory', 'COLUMN'

insert into Products (ProductID, ProductName, ProductCategory, Price, StockQuantity)
values
(1, 'Wireless Mouse', 'Accessories', 25.99, 50),
(2, 'Mechanical Keyboard', 'Accesories', 89.50, 50),
(3, 'Gaming Headset', 'Electronics', 59.00, 50),
(4, 'LED Monitor 24-inch', 'Electronics', 149.99, 50),
(5, 'USB-C Charger', 'Power Devices', 19.99, 50);

select * into Products_Backup from Products
select * from Products_Backup

exec sp_rename 'Products', 'Inventory'

alter table Inventory
drop chk_price_positive

alter table Inventory
alter column Price float

alter table Inventory
add ProductCode int identity(1000, 5)

select * from Inventory

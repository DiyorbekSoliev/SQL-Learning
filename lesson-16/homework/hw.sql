--create database lesson16
--go
--use lesson16


CREATE TABLE Numbers1(Number INT)

INSERT INTO Numbers1 VALUES (5),(9),(8),(6),(7)

CREATE TABLE FindSameCharacters
(
     Id INT
    ,Vals VARCHAR(10)
)
 
INSERT INTO FindSameCharacters VALUES
(1,'aa'),
(2,'cccc'),
(3,'abc'),
(4,'aabc'),
(5,NULL),
(6,'a'),
(7,'zzz'),
(8,'abc')



CREATE TABLE RemoveDuplicateIntsFromNames
(
      PawanName INT
    , Pawan_slug_name VARCHAR(1000)
)
 
 
INSERT INTO RemoveDuplicateIntsFromNames VALUES
(1,  'PawanA-111'  ),
(2, 'PawanB-123'   ),
(3, 'PawanB-32'    ),
(4, 'PawanC-4444' ),
(5, 'PawanD-3'  )





CREATE TABLE Example
(
Id       INTEGER IDENTITY(1,1) PRIMARY KEY,
String VARCHAR(30) NOT NULL
);


INSERT INTO Example VALUES('123456789'),('abcdefghi');


CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    DepartmentID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Salary DECIMAL(10, 2)
);

INSERT INTO Employees (EmployeeID, DepartmentID, FirstName, LastName, Salary) VALUES
(1, 1, 'John', 'Doe', 60000.00),
(2, 1, 'Jane', 'Smith', 65000.00),
(3, 2, 'James', 'Brown', 70000.00),
(4, 3, 'Mary', 'Johnson', 75000.00),
(5, 4, 'Linda', 'Williams', 80000.00),
(6, 2, 'Michael', 'Jones', 85000.00),
(7, 1, 'Robert', 'Miller', 55000.00),
(8, 3, 'Patricia', 'Davis', 72000.00),
(9, 4, 'Jennifer', 'García', 77000.00),
(10, 1, 'William', 'Martínez', 69000.00);

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'HR'),
(2, 'Sales'),
(3, 'Marketing'),
(4, 'Finance'),
(5, 'IT'),
(6, 'Operations'),
(7, 'Customer Service'),
(8, 'R&D'),
(9, 'Legal'),
(10, 'Logistics');

CREATE TABLE Sales (
    SalesID INT PRIMARY KEY,
    EmployeeID INT,
    ProductID INT,
    SalesAmount DECIMAL(10, 2),
    SaleDate DATE
);
INSERT INTO Sales (SalesID, EmployeeID, ProductID, SalesAmount, SaleDate) VALUES
-- January 2025
(1, 1, 1, 1550.00, '2025-01-02'),
(2, 2, 2, 2050.00, '2025-01-04'),
(3, 3, 3, 1250.00, '2025-01-06'),
(4, 4, 4, 1850.00, '2025-01-08'),
(5, 5, 5, 2250.00, '2025-01-10'),
(6, 6, 6, 1450.00, '2025-01-12'),
(7, 7, 1, 2550.00, '2025-01-14'),
(8, 8, 2, 1750.00, '2025-01-16'),
(9, 9, 3, 1650.00, '2025-01-18'),
(10, 10, 4, 1950.00, '2025-01-20'),
(11, 1, 5, 2150.00, '2025-02-01'),
(12, 2, 6, 1350.00, '2025-02-03'),
(13, 3, 1, 2050.00, '2025-02-05'),
(14, 4, 2, 1850.00, '2025-02-07'),
(15, 5, 3, 1550.00, '2025-02-09'),
(16, 6, 4, 2250.00, '2025-02-11'),
(17, 7, 5, 1750.00, '2025-02-13'),
(18, 8, 6, 1650.00, '2025-02-15'),
(19, 9, 1, 2550.00, '2025-02-17'),
(20, 10, 2, 1850.00, '2025-02-19'),
(21, 1, 3, 1450.00, '2025-03-02'),
(22, 2, 4, 1950.00, '2025-03-05'),
(23, 3, 5, 2150.00, '2025-03-08'),
(24, 4, 6, 1700.00, '2025-03-11'),
(25, 5, 1, 1600.00, '2025-03-14'),
(26, 6, 2, 2050.00, '2025-03-17'),
(27, 7, 3, 2250.00, '2025-03-20'),
(28, 8, 4, 1350.00, '2025-03-23'),
(29, 9, 5, 2550.00, '2025-03-26'),
(30, 10, 6, 1850.00, '2025-03-29'),
(31, 1, 1, 2150.00, '2025-04-02'),
(32, 2, 2, 1750.00, '2025-04-05'),
(33, 3, 3, 1650.00, '2025-04-08'),
(34, 4, 4, 1950.00, '2025-04-11'),
(35, 5, 5, 2050.00, '2025-04-14'),
(36, 6, 6, 2250.00, '2025-04-17'),
(37, 7, 1, 2350.00, '2025-04-20'),
(38, 8, 2, 1800.00, '2025-04-23'),
(39, 9, 3, 1700.00, '2025-04-26'),
(40, 10, 4, 2000.00, '2025-04-29'),
(41, 1, 5, 2200.00, '2025-05-03'),
(42, 2, 6, 1650.00, '2025-05-07'),
(43, 3, 1, 2250.00, '2025-05-11'),
(44, 4, 2, 1800.00, '2025-05-15'),
(45, 5, 3, 1900.00, '2025-05-19'),
(46, 6, 4, 2000.00, '2025-05-23'),
(47, 7, 5, 2400.00, '2025-05-27'),
(48, 8, 6, 2450.00, '2025-05-31'),
(49, 9, 1, 2600.00, '2025-06-04'),
(50, 10, 2, 2050.00, '2025-06-08'),
(51, 1, 3, 1550.00, '2025-06-12'),
(52, 2, 4, 1850.00, '2025-06-16'),
(53, 3, 5, 1950.00, '2025-06-20'),
(54, 4, 6, 1900.00, '2025-06-24'),
(55, 5, 1, 2000.00, '2025-07-01'),
(56, 6, 2, 2100.00, '2025-07-05'),
(57, 7, 3, 2200.00, '2025-07-09'),
(58, 8, 4, 2300.00, '2025-07-13'),
(59, 9, 5, 2350.00, '2025-07-17'),
(60, 10, 6, 2450.00, '2025-08-01');

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    CategoryID INT,
    ProductName VARCHAR(100),
    Price DECIMAL(10, 2)
);

INSERT INTO Products (ProductID, CategoryID, ProductName, Price) VALUES
(1, 1, 'Laptop', 1000.00),
(2, 1, 'Smartphone', 800.00),
(3, 2, 'Tablet', 500.00),
(4, 2, 'Monitor', 300.00),
(5, 3, 'Headphones', 150.00),
(6, 3, 'Mouse', 25.00),
(7, 4, 'Keyboard', 50.00),
(8, 4, 'Speaker', 200.00),
(9, 5, 'Smartwatch', 250.00),
(10, 5, 'Camera', 700.00);

--Easy Tasks
--Create a numbers table using a recursive query from 1 to 1000.
WITH Numbers AS (
    SELECT 1 AS n               -- anchor (start)
    UNION ALL
    SELECT n + 1                -- recursive (increment)
    FROM Numbers
    WHERE n < 1000
)
SELECT * FROM Numbers
option (maxrecursion 0)

--Write a query to find the total sales per employee using a derived table.(Sales, Employees)
select e.EmployeeID, e.FirstName+e.LastName as FullName, d.TotalSales from Employees e
join (select EmployeeID, sum(SalesAmount) as TotalSales from Sales
group by EmployeeID) as d
on e.EmployeeID = d.EmployeeID

--Create a CTE to find the average salary of employees.(Employees)
with AvgSalaryCTE as (
	select avg(Salary) as [Avg Salary] from Employees
	)
select * from AvgSalaryCTE

--Write a query using a derived table to find the highest sales for each product.(Sales, Products)
select p.ProductID, p.ProductName, s.HighestSales from Products p
join (select ProductID, max(SalesAmount) as HighestSales from Sales
group by ProductID) as s
on p.ProductID = s.ProductID

--Beginning at 1, write a statement to double the number for each record, the max value you get should be less than 1000000.
with DNumber as (
	select 1 as n
	union all
	select 2*n from DNumber
	where 2*n<1000000
	)
select * from DNumber
option (maxrecursion 0)

--Use a CTE to get the names of employees who have made more than 5 sales.(Sales, Employees)
with SalesCTE as (
	select EmployeeID, count(SalesID) as NumSales from Sales
	group by EmployeeID
	)
select e.FirstName+' '+e.LastName as FullName, s.NumSales from Employees e
join SalesCTE as s
	on e.EmployeeID = s.EmployeeID
where s.NumSales > 5

--Write a query using a CTE to find all products with sales greater than $500.(Sales, Products)
with SalesCTE as (
	select ProductID, sum(SalesAmount) as Tsales from Sales
	group by ProductID
	)
select p.ProductID, p.ProductName, s.Tsales from Products p
join SalesCTE s
	on p.ProductID = s.ProductID
where s.Tsales > 500

--Create a CTE to find employees with salaries above the average salary.(Employees)
with empCTE as (
			select avg(Salary) as AvgSalary from Employees
			)
select 
	e.EmployeeID,
	CONCAT_WS(' ', e.FirstName, e.LastName) as FullName,
	e.Salary,
	c.AvgSalary
from Employees e
join empCTE as c
	on e.Salary > c.AvgSalary

--Medium Tasks
--Write a query using a derived table to find the top 5 employees by the number of orders made.(Employees, Sales)
select 
	e.EmployeeID,
	CONCAT_WS(' ', e.FirstName, e.LastName) as FullName,
	s.NumSales
from Employees e
join (
	select top 5 s.EmployeeID, count(s.SalesID) as NumSales from Sales s
	group by s.EmployeeID
	order by count(s.SalesID) desc ) as s
on e.EmployeeID = s.EmployeeID
--Write a query using a derived table to find the sales per product category.(Sales, Products)
select p.CategoryID, sum(s.Tsales) as GTSales from Products p
join (
	select s.ProductID, sum(s.SalesAmount) as Tsales from Sales s
	group by s.ProductID ) as s
	on p.ProductID = s.ProductID
group by p.CategoryID

--Write a script to return the factorial of each value next to it.(Numbers1)
with FactorialCTE (n,m) as (
	select 0 as n, 1 as m
	union all
	select n+1, (n+1)*m from FactorialCTE where n < 5
	)
select * from FactorialCTE

--This script uses recursion to split a string into rows of substrings for each character in the string.(Example)

--Use a CTE to calculate the sales difference between the current month and the previous month.(Sales)
with cte as (
	select datename(month, SaleDate) as Smonth, sum(SalesAmount) as Tsales from Sales 
	group by datename(month, SaleDate) )

select smonth,Tsales, lag(Tsales) over (order by Smonth) as PrevMonth, Tsales - lag(Tsales) over (order by Smonth) as SalesDifference from cte
order by Smonth

--Create a derived table to find employees with sales over $4500 in each quarter.(Sales, Employees)
select e.EmployeeID, CONCAT_WS(' ', e.FirstName, e.LastName) as FullName,  s.Tsales as [Total Sales], s.QuarterT as Quarter from Employees e
join (
	select EmployeeID, datepart(quarter, SaleDate) as QuarterT, sum(SalesAmount) as TSales from Sales
	group by EmployeeID, datepart(quarter, SaleDate)
	having sum(SalesAmount) > 4500 
	) as s
	on e.EmployeeID = s.EmployeeID
order by e.EmployeeID, s.QuarterT

--Difficult Tasks
--This script uses recursion to calculate Fibonacci numbers

DECLARE @MaxTerm INT = 10;  -- You can change this number for more terms

WITH FibonacciCTE AS (
    -- Anchor members (first two numbers)
    SELECT 
        1 AS n,        -- Term number
        0 AS fib1,     -- First Fibonacci value
        1 AS fib2      -- Second Fibonacci value
    UNION ALL
    -- Recursive part
    SELECT 
        n + 1, 
        fib2, 
        fib1 + fib2
    FROM FibonacciCTE
    WHERE n < @MaxTerm
)
SELECT 
    n AS TermNumber,
    fib1 AS FibonacciValue
FROM FibonacciCTE;

--Find a string where all characters are the same and the length is greater than 1.(FindSameCharacters)
declare @str varchar(50) = 'bbbbbbbbbb'
select * from FindSameCharacters 
where len(Vals)>1 and len(REPLACE(Vals, SUBSTRING(Vals,1,1), ''))=0

--Create a numbers table that shows all numbers 1 through n and their order gradually increasing by the next number in the sequence.(Example:n=5 | 1, 12, 123, 1234, 12345)
with cte as (
	select 1 as n, cast('1' as varchar(50)) as num
	union all
	select n+1,cast(num + cast(n+1 as varchar(50)) as varchar(50))  from cte where n<5 )

select n, num from cte

--Write a query using a derived table to find the employees who have made the most sales in the last 6 months.(Employees,Sales)
SELECT 
    E.EmployeeID,
    E.FirstName + ' ' + E.LastName AS EmployeeName,
    DT.TotalSales
FROM Employees E
JOIN (
    SELECT 
        EmployeeID,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    WHERE SaleDate >= DATEADD(MONTH, -6, GETDATE())
    GROUP BY EmployeeID
) AS DT
    ON E.EmployeeID = DT.EmployeeID
WHERE DT.TotalSales = (
    SELECT MAX(TotalSales)
    FROM (
        SELECT SUM(SalesAmount) AS TotalSales
        FROM Sales
        WHERE SaleDate >= DATEADD(MONTH, -6, GETDATE())
        GROUP BY EmployeeID
    ) AS MaxDT
)
ORDER BY E.EmployeeID;


--Write a T-SQL query to remove the duplicate integer values present in the string column. Additionally, remove the single integer character that appears in the string.(RemoveDuplicateIntsFromNames)

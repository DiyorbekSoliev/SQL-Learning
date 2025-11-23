-- Now we have only 2 tables: products and sales
select * from Products
select * from Sales
--1. Create a temporary table named MonthlySales to store the total quantity sold and total revenue for each product in the current month.
--Return: ProductID, TotalQuantity, TotalRevenue

select p.ProductID, sum(s.Quantity) as TotalQuantity, sum(s.Quantity*p.Price) as TotalRevenue 
into #MonthlySales from Products p 
join Sales s 
on p.ProductID = s.ProductID
where month(s.SaleDate) = month(getdate())
group by p.ProductID

--2. Create a view named vw_ProductSalesSummary that returns product info along with total sales quantity across all time.
--Return: ProductID, ProductName, Category, TotalQuantitySold

go
create view vw_ProductSalesSummary as
select p.ProductID, p.ProductName, p.Category, sum(s.Quantity) as TotalQuantity 
from Products p join Sales s on p.ProductID = s.ProductID
group by p.ProductID, p.ProductName, p.Category
go
select * from vw_ProductSalesSummary

--3. Create a function named fn_GetTotalRevenueForProduct(@ProductID INT)
--Return: total revenue for the given product ID
go
create function fn_GetTotalRevenueForProduct(@ProductID int)
returns table
AS
RETURN
(
    SELECT 
        p.ProductID, 
        p.ProductName, 
        SUM(s.Quantity * p.Price) AS TotalRevenue
    FROM Products p
    JOIN Sales s ON p.ProductID = s.ProductID
    WHERE p.ProductID = @ProductID
    GROUP BY p.ProductID, p.ProductName
);
select * from dbo.fn_GetTotalRevenueForProduct(5)

--4. Create an function fn_GetSalesByCategory(@Category VARCHAR(50))
--Return: ProductName, TotalQuantity, TotalRevenue for all products in that category.

go
create function fn_GetSalesByCategory(@Category varchar(50))
returns table
as
return
(
	select p.ProductName, sum(s.Quantity) as TotalQuantity, sum(p.Price*s.Quantity) as TotalRevenue from Products p 
	join Sales s on p.ProductID = s.ProductID
	where p.Category = @Category
	group by p.ProductName
);
select * from fn_GetSalesByCategory('Electronics')

--5. You have to create a function that get one argument as input from user and the function should return 'Yes' if the input number is a prime number and 'No' otherwise. You can start it like this:

create function fn_isprime(@Num int)
returns varchar(100)
as
begin
	declare @i int = 2;
	declare @div int = 1;

	if @Num < 2
		return 'NO';

	while @i<= floor(sqrt(@Num))
	begin
		if @Num % @i = 0
		begin
			set @div = 0;
			break;
		end
		set @i = @i+1
	end

	RETURN CASE 
               WHEN @div = 1 THEN 'Yes'
               ELSE 'No'
           END;
end;

select dbo.fn_isprime(91)

-- 6. Create a table-valued function named fn_GetNumbersBetween that accepts two integers as input

CREATE FUNCTION fn_GetNumbersBetween (@Start INT, @End INT)
RETURNS @Numbers TABLE (Num INT)
AS
BEGIN
    DECLARE @i INT = @Start;

    WHILE @i <= @End
    BEGIN
        INSERT INTO @Numbers VALUES (@i);
        SET @i = @i + 1;
    END

    RETURN;  -- return the table variable
END;

select * from dbo.fn_GetNumbersBetween(10, 20)

--7. Write an SQL query to return the Nth highest distinct salary from the Employee table. If there are fewer than N distinct salaries, return NULL.
go
CREATE FUNCTION udf_NthSalary (@N INT)
RETURNS INT
AS
BEGIN
    DECLARE @Result INT;

    ;WITH Ranked AS (
        SELECT 
            Salary,
            DENSE_RANK() OVER (ORDER BY Salary DESC) AS rn
        FROM Employee
        GROUP BY Salary
    )
    SELECT @Result = Salary
    FROM Ranked
    WHERE rn = @N;

    RETURN @Result;  -- returns NULL if no such row
END;
GO
SELECT dbo.udf_NthSalary(5)

--8. Write a SQL query to find the person who has the most friends.
--Return: Their id, The total number of friends they have
--Friendship is mutual. For example, if user A sends a request to user B and it's accepted, both A and B are considered friends with each other. 
--The test case is guaranteed to have only one user with the most friends.

SELECT TOP 1 id, COUNT(*) AS num
FROM (
    SELECT requester_id AS id, accepter_id AS friend_id
    FROM RequestAccepted
    UNION ALL
    SELECT accepter_id AS id, requester_id AS friend_id
    FROM RequestAccepted
) AS AllFriends
GROUP BY id
ORDER BY COUNT(*) DESC;

--9. Create a View for Customer Order Summary.

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT FOREIGN KEY REFERENCES Customers(customer_id),
    order_date DATE,
    amount DECIMAL(10,2)
);

-- Customers
INSERT INTO Customers (customer_id, name, city)
VALUES
(1, 'Alice Smith', 'New York'),
(2, 'Bob Jones', 'Chicago'),
(3, 'Carol White', 'Los Angeles');

-- Orders
INSERT INTO Orders (order_id, customer_id, order_date, amount)
VALUES
(101, 1, '2024-12-10', 120.00),
(102, 1, '2024-12-20', 200.00),
(103, 1, '2024-12-30', 220.00),
(104, 2, '2025-01-12', 120.00),
(105, 2, '2025-01-20', 180.00);

/* Create a view called vw_CustomerOrderSummary that returns a summary of customer orders. The view must contain the following columns:

Column Name | Description
customer_id | Unique identifier of the customer
name | Full name of the customer
total_orders | Total number of orders placed by the customer
total_amount | Cumulative amount spent across all orders
last_order_date | Date of the most recent order placed by the customer */

select * from Customers
select * from Orders
go
create view vw_CustomerOrderSummary as
with LastOrderDate as (
	select c.customer_id, o.order_date, DENSE_RANK() over (partition by c.customer_id order by o.order_date desc) as rn 
	from Customers c join Orders o on c.customer_id = o.customer_id
	),
TotalTable as (
	select c.customer_id, c.name, count(o.order_id) as TotalOrders, sum(o.amount) as TotalAmount from Customers c join Orders o on c.customer_id = o.customer_id
	group by c.customer_id,c.name
	)
select l.customer_id, t.name, t.TotalAmount, t.TotalOrders, l.order_date as [LastOrderDate] 
from LastOrderDate l join TotalTable t on l.customer_id = t.customer_id where l.rn = 1
go
select * from vw_CustomerOrderSummary

--10. Write an SQL statement to fill in the missing gaps. You have to write only select statement, no need to modify the table.

DROP TABLE IF EXISTS Gaps;

CREATE TABLE Gaps
(
RowNumber   INTEGER PRIMARY KEY,
TestCase    VARCHAR(100) NULL
);

INSERT INTO Gaps (RowNumber, TestCase) VALUES
(1,'Alpha'),(2,NULL),(3,NULL),(4,NULL),
(5,'Bravo'),(6,NULL),(7,NULL),(8,NULL),(9,NULL),(10,'Charlie'), (11, NULL), (12, NULL)

SELECT
    RowNumber,
    TestCase,
    MAX(TestCase) OVER (
        ORDER BY RowNumber
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS Workflow
FROM Gaps
ORDER BY RowNumber;

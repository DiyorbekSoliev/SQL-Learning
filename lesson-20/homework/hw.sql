
CREATE TABLE #Sales (
    SaleID INT PRIMARY KEY IDENTITY(1,1),
    CustomerName VARCHAR(100),
    Product VARCHAR(100),
    Quantity INT,
    Price DECIMAL(10,2),
    SaleDate DATE
);


INSERT INTO #Sales (CustomerName, Product, Quantity, Price, SaleDate) VALUES
('Alice', 'Laptop', 1, 1200.00, '2024-01-15'),
('Bob', 'Smartphone', 2, 800.00, '2024-02-10'),
('Charlie', 'Tablet', 1, 500.00, '2024-02-20'),
('David', 'Laptop', 1, 1300.00, '2024-03-05'),
('Eve', 'Smartphone', 3, 750.00, '2024-03-12'),
('Frank', 'Headphones', 2, 100.00, '2024-04-08'),
('Grace', 'Smartwatch', 1, 300.00, '2024-04-25'),
('Hannah', 'Tablet', 2, 480.00, '2024-05-05'),
('Isaac', 'Laptop', 1, 1250.00, '2024-05-15'),
('Jack', 'Smartphone', 1, 820.00, '2024-06-01');

--1. Find customers who purchased at least one item in March 2024 using EXISTS

SELECT s.CustomerName
FROM #Sales s
WHERE EXISTS (
    SELECT 1 
    FROM #Sales x
    WHERE x.CustomerName = s.CustomerName
      AND YEAR(x.SaleDate) = 2024
      AND MONTH(x.SaleDate) = 3
)
GROUP BY s.CustomerName;

--2. Find the product with the highest total sales revenue using a subquery.

SELECT Product, SUM(Quantity * Price) AS TotalSales
FROM #Sales
GROUP BY Product
HAVING SUM(Quantity * Price) = (
    SELECT MAX(TotalRevenue)
    FROM (
        SELECT SUM(Quantity * Price) AS TotalRevenue
        FROM #Sales
        GROUP BY Product
    ) AS t
);

--3. Find the second highest sale amount using a subquery

SELECT Product, SUM(Quantity * Price) AS TotalSales
FROM #Sales
GROUP BY Product
HAVING SUM(Quantity * Price) = (
    SELECT TotalRevenue
    FROM (
        SELECT TotalRevenue,
               ROW_NUMBER() OVER (ORDER BY TotalRevenue DESC) AS rn
        FROM (
            SELECT SUM(Quantity * Price) AS TotalRevenue
            FROM #Sales
            GROUP BY Product
        ) x
    ) y
    WHERE rn = 2
);

--4. Find the total quantity of products sold per month using a subquery

SELECT 
    MonthName,
    TotalQuantity
FROM (
    SELECT 
        FORMAT(SaleDate, 'yyyy-MM') AS MonthName,
        SUM(Quantity) AS TotalQuantity
    FROM #Sales
    GROUP BY FORMAT(SaleDate, 'yyyy-MM')
) AS m;

--5. Find customers who bought same products as another customer using EXISTS

SELECT DISTINCT
    s1.CustomerName AS CustomerA,
    s2.CustomerName AS CustomerB,
    s1.Product
FROM #Sales s1
JOIN #Sales s2
    ON s1.Product = s2.Product
   AND s1.CustomerName < s2.CustomerName   -- avoid duplicates + self-match
ORDER BY CustomerA, CustomerB, Product;

--6. Return how many fruits does each person have in individual fruit level
SELECT 
    Name,
    SUM(CASE WHEN Fruit = 'Apple'  THEN 1 ELSE 0 END) AS Apple,
    SUM(CASE WHEN Fruit = 'Orange' THEN 1 ELSE 0 END) AS Orange,
    SUM(CASE WHEN Fruit = 'Banana' THEN 1 ELSE 0 END) AS Banana
FROM Fruits
GROUP BY Name
ORDER BY Name;

-- with pivot
SELECT *
FROM Fruits
PIVOT(
    COUNT(Fruit)
    FOR Fruit IN ([Apple],[Orange],[Banana])
) AS p;

--7. Return older people in the family with younger ones

WITH FamilyCTE AS (
    -- Direct Parent → Child
    SELECT ParentID, ChildID
    FROM Family

    UNION ALL

    -- Recursive: Parent → Grandchild (and deeper)
    SELECT f.ParentID, c.ChildID
    FROM Family f
    JOIN FamilyCTE c ON f.ChildID = c.ParentID
)
SELECT DISTINCT ParentID AS OlderPerson, ChildID AS YoungerPerson
FROM FamilyCTE
ORDER BY ParentID, ChildID;

--8. Write an SQL statement given the following requirements. For every customer that had a delivery to California,
--provide a result set of the customer orders that were delivered to Texas

SELECT *
FROM #Orders o
WHERE o.DeliveryState = 'TX'
  AND EXISTS (
      SELECT 1
      FROM #Orders o2
      WHERE o2.CustomerID = o.CustomerID
        AND o2.DeliveryState = 'CA'
  )
ORDER BY o.CustomerID, o.OrderID;

--9. Insert the names of residents if they are missing

-- Update the fullname column only if it's NULL or empty
UPDATE #residents
SET fullname = 
    LTRIM(RTRIM(
        SUBSTRING(address, 
                  CHARINDEX('name=', address) + 5, 
                  CHARINDEX(' ', address + ' ', CHARINDEX('name=', address) + 5) - (CHARINDEX('name=', address) + 5)
                 )
    ))
WHERE fullname IS NULL
   OR fullname = '';

--10. Write a query to return the route to reach from Tashkent to Khorezm. The result should include the cheapest and the most expensive routes
WITH RouteCTE AS (
    -- Anchor: start from Tashkent
    SELECT 
        DepartureCity,
        ArrivalCity,
        CAST(RouteID AS VARCHAR(MAX)) AS Path,
        Cost,
        CAST(DepartureCity + '->' + ArrivalCity AS VARCHAR(MAX)) AS RouteCities
    FROM #Routes
    WHERE DepartureCity = 'Tashkent'

    UNION ALL

    -- Recursive: extend the path
    SELECT 
        r.DepartureCity,
        r.ArrivalCity,
        c.Path + ',' + CAST(r.RouteID AS VARCHAR),
        c.Cost + r.Cost,
        c.RouteCities + '->' + r.ArrivalCity
    FROM RouteCTE c
    JOIN #Routes r ON c.ArrivalCity = r.DepartureCity
    -- Prevent cycles
    WHERE c.RouteCities NOT LIKE '%'+r.ArrivalCity+'%'
)
-- Store all routes to a temp table
SELECT *
INTO #AllRoutes
FROM RouteCTE
WHERE ArrivalCity = 'Khorezm';

-- Select cheapest and most expensive routes in one query
SELECT 'Cheapest' AS RouteType, *
FROM #AllRoutes
WHERE Cost = (SELECT MIN(Cost) FROM #AllRoutes)

UNION ALL

SELECT 'Most Expensive' AS RouteType, *
FROM #AllRoutes
WHERE Cost = (SELECT MAX(Cost) FROM #AllRoutes);

--11. Rank products based on their order of insertion.
 
-- Solution: Assign group number based on 'Product' occurrences
WITH Flag AS (
    SELECT *,
           CASE WHEN Vals = 'Product' THEN 1 ELSE 0 END AS IsProduct
    FROM #RankingPuzzle
),
Cumulative AS (
    SELECT *,
           SUM(IsProduct) OVER (ORDER BY ID ROWS UNBOUNDED PRECEDING) AS ProductGroup
    FROM Flag
)
SELECT ID, Vals, ProductGroup
FROM Cumulative
ORDER BY ID;

--12. Find employees whose sales were higher than the average sales in their department

select * from #EmployeeSales s1
where s1.SalesAmount > (select avg(s2.SalesAmount) as AverageSales from #EmployeeSales s2
						where s1.department = s2.department)

-- Assume we have Employees, Sales, Products, and Orders tables already created

-- 13. Employees who had the highest sales in any given month using EXISTS
SELECT DISTINCT s1.EmployeeID
FROM Sales s1
WHERE EXISTS (
    SELECT 1
    FROM Sales s2
    WHERE MONTH(s1.SaleDate) = MONTH(s2.SaleDate)
      AND YEAR(s1.SaleDate) = YEAR(s2.SaleDate)
    GROUP BY s2.EmployeeID
    HAVING SUM(s2.SalesAmount) <= SUM(s1.SalesAmount)
);

-- 14. Employees who made sales in every month using NOT EXISTS
SELECT e.EmployeeID
FROM Employees e
WHERE NOT EXISTS (
    SELECT 1
    FROM (SELECT DISTINCT MONTH(SaleDate) AS SaleMonth, YEAR(SaleDate) AS SaleYear FROM Sales) m
    WHERE NOT EXISTS (
        SELECT 1
        FROM Sales s
        WHERE s.EmployeeID = e.EmployeeID
          AND MONTH(s.SaleDate) = m.SaleMonth
          AND YEAR(s.SaleDate) = m.SaleYear
    )
);

-- 15. Products more expensive than average price
SELECT Name
FROM Products
WHERE Price > (SELECT AVG(Price) FROM Products);

-- 16. Products with stock lower than the highest stock
SELECT Name
FROM Products
WHERE Stock < (SELECT MAX(Stock) FROM Products);

-- 17. Products in the same category as 'Laptop'
SELECT Name
FROM Products
WHERE Category = (SELECT Category FROM Products WHERE Name = 'Laptop');

-- 18. Products whose price is greater than the lowest price in Electronics
SELECT Name
FROM Products
WHERE Price > (SELECT MIN(Price) FROM Products WHERE Category = 'Electronics');

-- 19. Products with price higher than the average price of their category
SELECT Name
FROM Products p1
WHERE Price > (SELECT AVG(Price) FROM Products p2 WHERE p2.Category = p1.Category);

-- 20. Products that have been ordered at least once
SELECT DISTINCT p.Name
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID;

-- 21. Products ordered more than average quantity
SELECT p.Name
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID
GROUP BY p.Name
HAVING SUM(o.Quantity) > (SELECT AVG(Quantity) FROM Orders);

-- 22. Products that have never been ordered
SELECT p.Name
FROM Products p
WHERE NOT EXISTS (
    SELECT 1 FROM Orders o WHERE o.ProductID = p.ProductID
);

-- 23. Product with highest total quantity ordered
SELECT TOP 1 p.Name, SUM(o.Quantity) AS TotalQuantity
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID
GROUP BY p.Name
ORDER BY TotalQuantity DESC;

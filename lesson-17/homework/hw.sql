--create database lesson17
--go
--use lesson17

--1. You must provide a report of all distributors and their sales by region. If a distributor did not have any sales for a region, provide a zero-dollar
--value for that day. Assume there is at least one sale for each region.

--Solution:
select r.region, d.distributor, isnull(rs.Sales, 0) as Sales 
from
	(select distinct region from #RegionSales) r
cross join
	(select distinct distributor from #RegionSales) d
left join #RegionSales rs
	on r.Region = rs.Region and d.Distributor = rs.Distributor
order by r.Region, d.Distributor

--2. Find managers with at least five direct reports

-- Solution:
select e.id , e.name as Manager, count(b.id) as DirectReports from Employee e
join Employee b
on e.id = b.managerId
group by e.id, e.name
having count(b.id) >= 5 

--3. Write a solution to get the names of products that have at least 100 units ordered in February 2020 and their amount.

--Solution:

select p.product_name, sum(o.unit) as Units from products p
join (select * from orders where month(order_date) = 2) o
	on p.product_id = o.product_id
group by p.product_name
having sum(o.unit) >= 100

--4. . Write an SQL statement that returns the vendor from which each customer has placed the most orders

-- Solution:
with VendorCounts as(
	select 
		CustomerID, 
		Vendor, 
		count(*) as OrderCount 
	from Orders
	group by Vendor, CustomerID ),
Ranked as (
	select 
		CustomerID, 
		Vendor, 
		OrderCount, 
		ROW_NUMBER() over 
			(partition by CustomerID 
			order by OrderCount desc )
			as rn 
	from VendorCounts)
select CustomerID, Vendor, OrderCount from Ranked
where rn = 1

--5. You will be given a number as a variable called @Check_Prime check if this number is prime then return 'This number is prime' else eturn 'This number is not prime'

create function udf_isprime(@Num int)
returns varchar(100)
as
begin
	declare @i int = 2;
	declare @div int = 1;

	if @Num < 2
		return 'This is not prime number';

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
               WHEN @div = 1 THEN 'This is prime number'
               ELSE 'This is not prime number'
           END;
end;

DECLARE @Check_Prime INT = 91;
select dbo.udf_isprime(@Check_Prime)

--6.  Write an SQL query to return the number of locations,in which location most signals sent, and total number of signal for each device from the given table.

--Solution:
with SignalCounts as (
select device_id,Locations, count(device_id) as Signals from Device
group by Locations, device_id),
Ranked as ( 
select Device_id, Locations, Signals, ROW_NUMBER() over (partition by device_id order by signals desc ) as rn from SignalCounts),
NumOfLocations as (
select count(distinct locations) as NumLocation from Device),
TotalSignals as (
select device_id, count(*) as TotalSignal from Device group by device_id )

select r.device_id, l.NumLocation as [Number of Locations], r.Locations, r.Signals, t.TotalSignal as [Total signal per device]
from Ranked r
join TotalSignals t on r.device_id = t.device_id
cross join NumOfLocations l
where r.rn = 1

--7. Write an SQL to find all Employees who earn more than the average salary in their corresponding department. Return EmpID, EmpName,Salary in your output.

--Solution:
with MaximumSalary as (
	select DeptID, max(Salary) as MaxSalary from Employee
	group by DeptID)

select e.EmpID, e.EmpName, e.Salary from Employee e
join MaximumSalary m
on e.Salary = m.MaxSalary

--8. You are part of an office lottery pool where you keep a table of the winning lottery numbers along with a table of each ticket’s chosen numbers. If a ticket has 
--some but not all the winning numbers, you win $10. If a ticket has all the winning numbers, you win $100. Calculate the total winnings for today’s drawing.
WITH MatchCounts AS (
    SELECT 
        t.TicketID,
        COUNT(n.Number) AS Matches
    FROM Tickets t
    LEFT JOIN Numbers n
        ON t.Number = n.Number
    GROUP BY t.TicketID
),
WinningTotal AS (
    SELECT COUNT(*) AS TotalWinners FROM Numbers
)
SELECT 
    SUM(
        CASE 
            WHEN m.Matches = w.TotalWinners THEN 100
            WHEN m.Matches > 0 THEN 10
            ELSE 0
        END
    ) AS TotalWinnings
FROM MatchCounts m
CROSS JOIN WinningTotal w;

--9. The Spending table keeps the logs of the spendings history of users that make purchases from an online shopping website which has a desktop and a mobile devices.
--Write an SQL query to find the total number of users and the total amount spent using mobile only, desktop only and both mobile and desktop together for each date.

--Solution:
WITH platform_summary AS (
    SELECT
        Spend_date,
        User_id,
        SUM(Amount) AS total_amount,
        COUNT(DISTINCT Platform) AS platform_count,
        MIN(Platform) AS p1,
        MAX(Platform) AS p2   -- helps identify platform combination
    FROM Spending
    GROUP BY Spend_date, User_id
),

user_type AS (
    SELECT
        Spend_date,
        CASE
            WHEN platform_count = 1 AND p1 = 'Mobile' THEN 'Mobile Only'
            WHEN platform_count = 1 AND p1 = 'Desktop' THEN 'Desktop Only'
            WHEN platform_count = 2 THEN 'Both'
        END AS usage_type,
        User_id,
        total_amount
    FROM platform_summary
)

SELECT
    Spend_date,
    usage_type,
    COUNT(DISTINCT User_id) AS total_users,
    SUM(total_amount) AS total_amount
FROM user_type
GROUP BY Spend_date, usage_type
ORDER BY Spend_date, usage_type;

--10.  Write an SQL Statement to de-group the following data.

-- Solution:
DECLARE @maxQty INT;
SELECT @maxQty = MAX(Quantity) FROM Grouped;

WITH nums AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM nums
    WHERE n < @maxQty
)
SELECT g.Product
FROM Grouped g
JOIN nums n
    ON n.n <= g.Quantity
ORDER BY g.Product, n.n
OPTION (MAXRECURSION 0);  -- allow recursion beyond 100

-- task 1
select ProductName as Name from Products

select * from Customers as Client

select ProductName from Products
union -- here union removes duplicates
select ProductName from Products_Discounted

select * from Products
intersect
select * from Products_Discounted

select distinct FirstName as Name, Country from Customers

select ProductID, ProductName, Price,
	case 
		when Price > 1000 then 'High'
		else 'Low'
	end as PriceCategory
	from Products

select StockQuantity, iif(StockQuantity>100, 'yes', 'no') from Products_Discounted

select * from Products
except 
select * from Products_Discounted
go
select * from Products_Backup
except 
select * from Products

select ProductName, Price, iif(Price>1000, 'expensive', 'affordable') as Opinion from Products

select FirstName, LastName, Age, Salary from Employees
where Age<25 or Salary>60000

update Employees
set Salary = 1.1*Salary
where EmployeeID = 1 or DepartmentName = 'HR'
select * from Employees

select ProductID, SaleAmount, 
	case
		when SaleAmount>500 then 'Top tier'
		when SaleAmount between 200 and 500 then 'Mid tier'
		else 'Low tier'
	end as SaleDefintion
from Sales

select CustomerID from Orders
except
select CustomerID from Sales

select CustomerID, Quantity, TotalAmount,
	case
		when Quantity = 1 then TotalAmount*0.03
		when Quantity between 1 and 3 then TotalAmount*0.05
		else TotalAmount*0.07
	end as Discount
from Orders

-- Task 1
/* bulk insert is an sql command which we use to import a large amount of data to the database directly. Its has many purposes, for example, it saves our time because of its speed,
it prevents us from writing manual insert into commands, can be useful in practical works like ETL processes. */

-- The formats that can be imported to sql server are csv(comma seperated values), txt(text file), xls or xlsx(excel file), xml(extensible markup language)

create table Products (ProductID int primary key, ProductName varchar(50), Price decimal(10,2))

select * from Products

insert into Products (ProductID, ProductName, Price)
values
(1, 'Wireless Mouse', 25.99),
(2, 'Mechanical Keyboard', 89.50),
(3, 'Gaming Headset', 59.00)

/* null = not value or unknown value
   not null = must have always value */ 

alter table Products
add constraint UQ_ProductName unique (ProductName)
-- here we added constraint to make Product Names different. Duplicates aren't allowed, if we try to write the same name, it shows an error

alter table Products
add CategoryID int

--now we'll create another table called Categories
create table Categories (
	CategoryID int primary key,
	CategoryName varchar(50) unique
);
INSERT INTO Categories (CategoryID, CategoryName)
VALUES
(1, 'Electronics'),
(2, 'Furniture'),
(3, 'Appliances'),
(4, 'Stationery'),
(5, 'Miscellaneous');

select * from Categories

-- we use identity command to automatically generate numeric values for each new row. By this way we don't have to type ID numbers manually

--task2

bulk insert Products from 'C:\Users\user\Documents\products_sample.csv'
with (
	fieldterminator = ',', -- this seperates columns
	rowterminator = '\n',  -- this seperates rows
	firstrow = 2
);

INSERT INTO Products (ProductID, ProductName, Price, CategoryID)
VALUES
(1, 'Laptop', 1200.00, 1),
(2, 'Desk Chair', 150.00, 2),
(3, 'Coffee Maker', null, 3),
(4, 'Smartphone', 950.00, 1),
(5, 'Notebook', 3.50, 4);
select * from Products

update Products
set CategoryID = 1 where CategoryID not in (select CategoryID from Categories)

-- let's create a foreign key which references Categories table
alter table Products
add constraint FK_Products_Categories
foreign key (CategoryID) references Categories(CategoryID)

--Primary key is a key that uniquely idetifies each record in the table, and unique key ensures all records in the column are not the same. 
--We can use primary key only once in the table, unique key multiple times. Both don't allow null values.

alter table Products
add constraint chk_price_positive
check (Price>0)

alter table Products
add Stock int not null default 0

select ProductID, ProductName, isnull (Price, 0) as Price, CategoryID, Stock from Products;

-- A FOREIGN KEY makes sure that the relationship between two tables stays valid.

-- task3

create table Customers (CustomerID int primary key, CustomerName varchar(50), Age int not null check (age>=18), DiscountNumber int identity(100,10))

INSERT INTO Customers (CustomerID, CustomerName, Age)
VALUES
(1, 'Alice Johnson', 28),
(2, 'Michael Smith', 35),
(3, 'Fatima Karimova', 22),
(4, 'John Anderson', 41),
(5, 'Laylo Tursunova', 30),
(6, 'David Brown', 27),
(7, 'Nodirbek Rasulov', 33),
(8, 'Emma Wilson', 25),
(9, 'Zafar Usmonov', 38),
(10, 'Olivia Davis', 29);

select * from Customers

-- here we're creating composite primary key in the new OrderDetails table
create table OrderDetails (OrderID int, ProductID int, Quantity int, Price decimal(10,2), constraint PK_OrderDetails primary key (OrderID, ProductID));
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price)
VALUES
(1, 101, 2, 1200.50),
(1, 102, 1, 150.00),
(1, 103, 3, 80.00),
(2, 101, 1, 1200.50),
(2, 104, 2, 25.00),
(3, 102, 5, 150.00),
(3, 103, 2, 80.00),
(4, 105, 1, 3.50),
(4, 101, 1, 1200.50),
(5, 104, 4, 25.00);

select * from OrderDetails
-- isnull replaces null with one specific value
-- coalesce checks the given expressions and returns first not-Null value

CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,               -- Primary Key
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,           -- Unique Key
    Salary DECIMAL(10,2),
    Department VARCHAR(50)
);

ALTER TABLE Employees
ADD CONSTRAINT FK_Employees_Departments
FOREIGN KEY (DepartmentID)
REFERENCES Departments(DepartmentID)
ON DELETE CASCADE
ON UPDATE CASCADE;

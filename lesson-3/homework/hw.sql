-- Task 1
/* bulk insert is an sql command which we use to import a large amount of data to the database directly. Its has many purposes, for example, it saves our time becase of its speed,
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

select * from Categories

-- we use identity command to automatically generate numeric values for each new row. By this way we don't have to type ID numbers manually

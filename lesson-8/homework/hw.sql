--easy-level tasks

--1. find the total number of products available in each category
select category, count(*) as total_products
from products
group by category;

--2. get the average price of products in the 'electronics' category
select avg(price) as avg_price
from products
where category = 'electronics';

--3. list all customers from cities that start with 'l'
select *
from customers
where city like 'l%';

--4. get all product names that end with 'er'
select productname
from products
where productname like '%er';

--5. list all customers from countries ending in 'a'
select *
from customers
where country like '%a';

--6. show the highest price among all products
select max(price) as highest_price
from products;

--7. label stock as 'low stock' if quantity < 30, else 'sufficient'
select productname,
       case when stockquantity < 30 then 'low stock' else 'sufficient' end as stock_status
from products;

--8. find the total number of customers in each country
select country, count(*) as total_customers
from customers
group by country;

--9. find the minimum and maximum quantity ordered
select min(quantity) as min_quantity, max(quantity) as max_quantity
from orders;


--medium-level tasks

--1. list customer ids who placed orders in january 2023 but did not have invoices
select distinct o.customerid
from orders o
where year(orderdate) = 2023 and month(orderdate) = 1
and o.customerid not in (
    select customerid from invoices
    where year(invoicedate) = 2023 and month(invoicedate) = 1
);

--2. combine all product names from products and products_discounted including duplicates
select productname from products
union all
select productname from products_discounted;

--3. combine all product names from products and products_discounted without duplicates
select productname from products
union
select productname from products_discounted;

--4. find the average order amount by year
select year(orderdate) as order_year, avg(totalamount) as avg_order_amount
from orders
group by year(orderdate);

--5. group products based on price: 'low'(<100), 'mid'(100–500), 'high'(>500)
select productname,
       case
           when price < 100 then 'low'
           when price between 100 and 500 then 'mid'
           else 'high'
       end as price_group
from products;

--6. use pivot to show year values in separate columns and copy results to new table
select district_name, [2012], [2013]
into population_each_year
from (
    select district_name, population, year
    from city_population
) src
pivot (
    sum(population)
    for year in ([2012], [2013])
) pvt;

--7. find total sales per product id
select productid, sum(saleamount) as total_sales
from sales
group by productid;

--8. find products that contain 'oo' in the name
select productname
from products
where productname like '%oo%';

--9. use pivot to show city values in separate columns and copy results to new table
select year, [bektemir], [chilonzor], [yakkasaroy]
into population_each_city
from (
    select district_name, population, year
    from city_population
) src
pivot (
    sum(population)
    for district_name in ([bektemir], [chilonzor], [yakkasaroy])
) pvt;


--hard-level tasks

--1. show top 3 customers with the highest total invoice amount
select top 3 customerid, sum(totalamount) as totalspent
from invoices
group by customerid
order by totalspent desc;

--2. transform population_each_year table to its original format
select district_name, '2012' as year, [2012] as population from population_each_year
union all
select district_name, '2013', [2013] from population_each_year;

--3. list product names and number of times each has been sold
select p.productname, count(s.saleid) as times_sold
from products p
join sales s on p.productid = s.productid
group by p.productname;

--4. transform population_each_city table to its original format
select 'bektemir' as district_name, year, [bektemir] as population from population_each_city
union all
select 'chilonzor', year, [chilonzor] from population_each_city
union all
select 'yakkasaroy', year, [yakkasaroy] from population_each_city;

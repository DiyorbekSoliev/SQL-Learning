--1
select productname, suppliername
from products
cross join suppliers;

--2
select departmentname, name as employeename
from departments
cross join employees;

--3
select s.suppliername, p.productname
from suppliers s
join products p on s.supplierid = p.supplierid;

--4
select c.firstname + ' ' + c.lastname as customername, o.orderid
from customers c
join orders o on c.customerid = o.customerid;

--5
select s.name as studentname, c.coursename
from students s
cross join courses c;

--6
select p.productname, o.orderid
from products p
join orders o on p.productid = o.productid;

--7
select e.name as employeename, d.departmentname
from employees e
join departments d on e.departmentid = d.departmentid;

--8
select s.name as studentname, e.courseid
from students s
join enrollments e on s.studentid = e.studentid;

--9
select o.orderid, p.paymentid, p.amount
from orders o
join payments p on o.orderid = p.orderid;

--10
select o.orderid, p.productname, p.price
from orders o
join products p on o.productid = p.productid
where p.price > 100;

--11
select distinct c.customerid, c.firstname + ' ' + c.lastname as customername
from customers c
join orders o on c.customerid = o.customerid
where o.orderdate between '2023-01-01' and '2023-12-31';

--12
select c.firstname + ' ' + c.lastname as customername, count(o.orderid) as totalorders
from customers c
join orders o on c.customerid = o.customerid
group by c.firstname, c.lastname;

--13
select p.productname, count(o.orderid) as totalorders
from products p
join orders o on p.productid = o.productid
group by p.productname;

--14
select d.departmentname, count(e.employeeid) as totalemployees
from departments d
join employees e on d.departmentid = e.departmentid
group by d.departmentname;

--15
select c.courseid, avg(c.grade) as averagegrade
from enrollments c
group by c.courseid;

--16
select s.suppliername, sum(p.price) as totalvalue
from suppliers s
join products p on s.supplierid = p.supplierid
group by s.suppliername;

--17
select p.productname, o.orderid, p.price, (o.quantity * p.price) as totalamount
from orders o
join products p on o.productid = p.productid;

--18
select c.firstname + ' ' + c.lastname as customername, sum(p.amount) as totalpaid
from customers c
join orders o on c.customerid = o.customerid
join payments p on o.orderid = p.orderid
group by c.firstname, c.lastname;

--19
select s.name as studentname, c.coursename
from students s
join enrollments e on s.studentid = e.studentid
join courses c on e.courseid = c.courseid;

--20
select p.productname, o.orderdate
from orders o
join products p on o.productid = p.productid
where year(o.orderdate) = 2023;

--21
select top 3 c.customerid, c.firstname + ' ' + c.lastname as customername, sum(p.amount) as totalspent
from customers c
join orders o on c.customerid = o.customerid
join payments p on o.orderid = p.orderid
group by c.customerid, c.firstname, c.lastname
order by totalspent desc;

--22
select s.suppliername, count(p.productid) as productcount
from suppliers s
join products p on s.supplierid = p.supplierid
group by s.suppliername
having count(p.productid) > 1;

--23
select e.name as employeename, d.departmentname, count(e.employeeid) over(partition by d.departmentid) as deptcount
from employees e
join departments d on e.departmentid = d.departmentid;

--24
select s.name as studentname, avg(e.grade) as avggrade
from students s
join enrollments e on s.studentid = e.studentid
group by s.name
having avg(e.grade) > 80;

--25
select c.firstname + ' ' + c.lastname as customername, p.amount, p.paymentdate
from customers c
join orders o on c.customerid = o.customerid
join payments p on o.orderid = p.orderid
where p.paymentdate = (
    select max(paymentdate) from payments
);

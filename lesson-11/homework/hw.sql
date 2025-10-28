--1
select e.name as employeename, e.salary, d.departmentname
from employees e
join departments d on e.departmentid = d.departmentid
where e.salary > 50000;

--2
select c.firstname, c.lastname, o.orderdate
from customers c
join orders o on c.customerid = o.customerid
where year(o.orderdate) = 2023;

--3
select e.name as employeename, d.departmentname
from employees e
left join departments d on e.departmentid = d.departmentid;

--4
select s.suppliername, p.productname
from suppliers s
left join products p on s.supplierid = p.supplierid;

--5
select o.orderid, o.orderdate, p.paymentdate, p.amount
from orders o
full join payments p on o.orderid = p.orderid;

--6
select e.name as employeename, m.name as managername
from employees e
left join employees m on e.managerid = m.employeeid;

--7
select s.name as studentname, c.coursename
from students s
join enrollments e on s.studentid = e.studentid
join courses c on e.courseid = c.courseid
where c.coursename = 'math 101';

--8
select c.firstname, c.lastname, o.quantity
from customers c
join orders o on c.customerid = o.customerid
where o.quantity > 3;

--9
select e.name as employeename, d.departmentname
from employees e
join departments d on e.departmentid = d.departmentid
where d.departmentname = 'human resources';

--10
select d.departmentname, count(e.employeeid) as employeecount
from departments d
join employees e on d.departmentid = e.departmentid
group by d.departmentname
having count(e.employeeid) > 5;

--11
select p.productid, p.productname
from products p
left join sales s on p.productid = s.productid
where s.productid is null;

--12
select c.firstname, c.lastname, count(o.orderid) as totalorders
from customers c
join orders o on c.customerid = o.customerid
group by c.firstname, c.lastname
having count(o.orderid) >= 1;

--13
select e.name as employeename, d.departmentname
from employees e
inner join departments d on e.departmentid = d.departmentid
where e.departmentid is not null and d.departmentid is not null;

--14
select e1.name as employee1, e2.name as employee2, e1.managerid
from employees e1
join employees e2 on e1.managerid = e2.managerid
where e1.employeeid < e2.employeeid;

--15
select o.orderid, o.orderdate, c.firstname, c.lastname
from orders o
join customers c on o.customerid = c.customerid
where year(o.orderdate) = 2022;

--16
select e.name as employeename, e.salary, d.departmentname
from employees e
join departments d on e.departmentid = d.departmentid
where d.departmentname = 'sales' and e.salary > 60000;

--17
select o.orderid, o.orderdate, p.paymentdate, p.amount
from orders o
join payments p on o.orderid = p.orderid;

--18
select p.productid, p.productname
from products p
left join orders o on p.productid = o.productid
where o.productid is null;

--19
select e.name as employeename, e.salary
from employees e
join (
    select departmentid, avg(salary) as avgsalary
    from employees
    group by departmentid
) a on e.departmentid = a.departmentid
where e.salary > a.avgsalary;

--20
select o.orderid, o.orderdate
from orders o
left join payments p on o.orderid = p.orderid
where o.orderdate < '2020-01-01' and p.paymentid is null;

--21
select p.productid, p.productname
from products p
left join categories c on p.categoryid = c.categoryid
where c.categoryid is null;

--22
select e1.name as employee1, e2.name as employee2, e1.managerid, e1.salary
from employees e1
join employees e2 on e1.managerid = e2.managerid
where e1.employeeid < e2.employeeid and e1.salary > 60000;

--23
select e.name as employeename, d.departmentname
from employees e
join departments d on e.departmentid = d.departmentid
where d.departmentname like 'm%';

--24
select s.saleid, p.productname, s.saleamount
from sales s
join products p on s.productid = p.productid
where s.saleamount > 500;

--25
select s.studentid, s.name as studentname
from students s
where s.studentid not in (
    select e.studentid
    from enrollments e
    join courses c on e.courseid = c.courseid
    where c.coursename = 'math 101'
);

--26
select o.orderid, o.orderdate, p.paymentid
from orders o
left join payments p on o.orderid = p.orderid
where p.paymentid is null;

--27
select p.productid, p.productname, c.categoryname
from products p
join categories c on p.categoryid = c.categoryid
where c.categoryname in ('electronics', 'furniture');

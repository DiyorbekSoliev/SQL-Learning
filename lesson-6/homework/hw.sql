--puzzle 1. solution:
select distinct 
    case when col1 < col2 then col1 else col2 end as col1,
    case when col1 < col2 then col2 else col1 end as col2
from inputtbl;

--puzzle 2. solution:
select * 
from testmultiplezero
where coalesce(a,0) + coalesce(b,0) + coalesce(c,0) + coalesce(d,0) <> 0;

--puzzle 3. solution:
select * 
from section1
where id % 2 = 1;

--puzzle 4. solution:
select top 1 * 
from section1
order by id asc;

--puzzle 5. solution:
select top 1 * 
from section1
order by id desc;

--puzzle 6. solution:
select * 
from section1
where name like 'b%';

--puzzle 7. solution:
select * 
from productcodes
where code like '%[_]%';

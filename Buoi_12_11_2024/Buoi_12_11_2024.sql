use db5;
-- exe1: lien ket khoa ngoai --- 
ALTER TABLE building
ADD CONSTRAINT FK_Host
FOREIGN KEY (host_id) REFERENCES host(id);

ALTER TABLE building
ADD CONSTRAINT FK_Contractor
FOREIGN KEY (contractor_id) REFERENCES contractor(id);

ALTER TABLE `work`
ADD CONSTRAINT FK_Building FOREIGN KEY (building_id) REFERENCES building(id),
ADD CONSTRAINT FK_Worker FOREIGN KEY (worker_id) REFERENCES worker(id);

ALTER TABLE design
ADD CONSTRAINT FK_Architect FOREIGN KEY (architect_id) REFERENCES architect(id),
ADD CONSTRAINT FK_Build FOREIGN KEY (building_id) REFERENCES building(id);

-- exe2 --
select * from building order by cost desc limit 1;

select * from building
where cost > all (
	select cost from building
    where city = 'can tho'
);

select * from building
where cost > any (
	select cost from building
    where city = 'can tho'
);

select * from building 
where id not in (select distinct(building_id) from design);

select *  from architect 
where birthday and place ;

-- exe3 --
select a.id , a.name, avg(d.benefit) 
from design d
right join architect a on a.id = d.architect_id 
group by a.id;

SELECT city,sum(cost) as total FROM building
GROUP BY city;

-- select b.*, sum(d.benefit) as pay
-- from  
-- 	( select d.building_id , d.benefit from design d having pay > 50)
-- group by b.id = d.building_id;

select b.* , d.benefit as pay 
from building b
join design d on d.building_id = b.id
where pay > 50;

select place , count(*) count 
from architect 
group by place 
having count >= 1;

-- exe 4 -- 
select b.name , h.name , c.name 
from building b 
	 inner join host h on b.host_id = h.id
     inner join contractor c on b.contractor_id = c.id;

select b.name , a.name , d.benefit 
from building b 
	inner join design d on b.id = d.building_id
    inner join architect a on a.id = d.architect_id;
    
select b.name , b.address from building b 
	inner join contractor c on c.id = b.contractor_id
where c.name = 'cty xd so 6';

select c.name , c.address from contractor c 
join building b on b.contractor_id = b.id
join design d on b.id = d.building_id
join architect a on a.id = d.architect_id
where a.name = 'le kim dung' and b.city = 'can tho' ;

select a.place from architect a
join design d on d.architect_id = a.id
join building b on b.id = d.building_id
where b.name = 'khach san quoc te' and b.city = 'can tho';

select * from worker wk
inner join work w on wk.id = w.worker_id
inner join building b on b.id = w.building_id
where b.name = 'khach san quoc te' 
and b.city = 'can tho'
and w.date between '1994-12-15' and '1994-12-31';

select a.name , a.birthday from architect a
join design d on d.architect_id = a.id
join building b on b.id = d.building_id
where place = 'tp hcm' and cost > 400;

select b.name from building b order by cost desc limit 1;

select distinct a.name from architect a 
join design d on d.architect_id = a.id
join building b on b.id = d.building_id
join contractor c on b.contractor_id = c.id
where c.name = 'le van son' and c.name = 'phong dich vu so xd';

select wk.name from worker wk 
inner join work w on w.worker_id = wk.id
inner join building b on b.id = w.building_id
where b.city like 'can tho' 
and wk.id not in ( 
	select wk.id from worker wk 
	join work w on w.worker_id = wk.id
    join building b on b.id = w.building_id
    where b.city like 'vinh long');

select c.name as contractor_name
from contractor c
inner join building b on c.id = b.contractor_id
where b.cost > (select sum(cost) from building b where contractor_id = (select id from
 contractor where name = 'Phòng Dịch vụ Sở Xây Dựng'))
group by c.name;

select a.name from architect a 
inner join design d on d.architect_id = a.id
where d.benefit < (select avg(benefit) from design)
group by a.name;

select c.name , c.address from contractor c
inner join building b on b.contractor_id = c.id 
where b.cost = (select min(cost) from building );

select wk.name , wk.skill from worker wk 
inner join work w on w.worker_id = wk.id
inner join building b on b.id = w.building_id
inner join design d on d.building_id = b.id
inner join architect a on d.architect_id = a.id
where a.name = 'le thanh tung';

select c1.name from contractor c1;

select c.name , sum(b.cost) from building b
inner join contractor c on c.id = b.contractor_id
group by c.name;

select a.name , sum(d.benefit) from architect a 
inner join design d on d.architect_id = a.id
group by a.name 
having sum(d.benefit) > 25;

select b.name , count(wk.id) as totalWorker from building b 
inner join work w on w.building_id = b.id
inner join worker wk on wk.id = w.worker_id
group by b.name;

-- select b.name , b.address, count(wk.id) as total_workers
-- from building b
-- inner join work w on w.building_id = b.id
-- inner join worker wk on wk.id = w.worker_id
-- group by b.id , b.name, w.worker_id  -- Add w.worker_id here
-- order by count(wk.id) desc
-- limit 1;

select b.name, b.address, 
(select count(*) from work w2 where w2.building_id = b.id) as total_workers
from building b
group by b.id, b.name
order by total_workers desc
limit 1;

select b.city , avg(b.cost) from building b 
group by b.city 
order by avg(b.cost) desc;

-- select wk.name from worker wk
-- inner join work w on w.worker_id = wk.id
-- inner join building b on b.id = w.building_id
-- where sum(datediff(b.start, w.date)) > (
-- 	select wk.id from worker wk
-- 	inner join work w on w.worker_id = wk.id
-- 	inner join building b on b.id = w.building_id
--     where wk.name = 'nguyen hong van'
-- );

select c.name , b.city , count(b.id) from building b 
inner join contractor c on c.id = b.contractor_id
group by b.city , c.name
order by count(b.id) desc;

SELECT wk.name
FROM worker wk
INNER JOIN work w ON w.worker_id = wk.id
INNER JOIN building b ON b.id = w.building_id
WHERE NOT EXISTS (
  SELECT *
  FROM building b2
  WHERE NOT EXISTS (
    SELECT *
    FROM work w2
    WHERE w2.worker_id = wk.id
    AND w2.building_id = b2.id
  )
);


-- exe5 --
CREATE TABLE employee (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    salary DECIMAL(10,2)
);

CREATE TABLE department (
    department_id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE employee_department (
    employee_id INT,
    department_id INT,
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id),
    FOREIGN KEY (department_id) REFERENCES department(department_id)
);


SELECT e.employee_id, e.name
FROM employee e
INNER JOIN employee_department ed ON e.employee_id = ed.employee_id
INNER JOIN department d ON ed.department_id = d.department_id
WHERE d.name = 'Kế toán';

SELECT employee_id, name, salary
FROM employee
WHERE salary > 50000;

SELECT d.name, COUNT(*) AS total_employees
FROM department d
INNER JOIN employee_department ed ON d.department_id = ed.department_id
GROUP BY d.name;

SELECT d.name, e.name, e.salary
FROM employee e
INNER JOIN employee_department ed ON e.employee_id = ed.employee_id
INNER JOIN department d ON ed.department_id = d.department_id
WHERE (d.name, e.salary) IN (
    SELECT d.name, MAX(e.salary)
    FROM employee e
    INNER JOIN employee_department ed ON e.employee_id = ed.employee_id
    INNER JOIN department d ON ed.department_id = d.department_id
    GROUP BY d.name
);

SELECT d.name, SUM(e.salary) AS total_salary
FROM department d
INNER JOIN employee_department ed ON d.department_id = ed.department_id
INNER JOIN employee e ON ed.employee_id = e.employee_id
GROUP BY d.name
HAVING SUM(e.salary) > 100000;

SELECT e.employee_id, e.name, COUNT(ed.department_id) AS num_departments
FROM employee e
INNER JOIN employee_department ed ON e.employee_id = ed.employee_id
GROUP BY e.employee_id, e.name
HAVING COUNT(ed.department_id) > 2;

create view not_retired on 
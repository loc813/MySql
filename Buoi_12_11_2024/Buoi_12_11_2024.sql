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

select c.name from contractor c 
join 

use session_04;



-- procedure --- 
DELIMITER $$
create procedure getAllMaleArchitect()
begin
	select * from architect 
	where sex = 1;
end $$ 
DELIMITER $$


call getAllMaleArchitect;

-- tao mot thu tuc lay thong tin cac building duoc thiet ket boi cac kien truc su nu --- 
-- architect , buliding , design -- 

delimiter $$ 
create procedure getAllBuildingByFemale()
begin 
	select * from building b 
	inner join design d on d.building_id = b.id
	inner join architect a on d.architect_id = a.id
	where a.sex = 0 ;
end $$
delimiter $$

call getAllBuildingByFemale();


-- viet mot thu tuc tinh tong taon bo benefit ma cac architect -- 
-- anm da kiem duoc -- 
-- Tao 1 bien local var co gia tri = gioi tinh nam(0) -- 
delimiter $$
create procedure CalculateTotalBenefit()
begin 
	declare total_benefit int default 0 ;
    
    select sum(benefit) into total_benefit from design d
    inner join architect a on a.id = d.architect_id
    where a.sex = 1;
    
    select total_benefit as tb;
end $$ 
delimiter $$

call CalculateTotalBenefit();
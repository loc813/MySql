create database InventoryManagement;
use InventoryManagement;

create table Products (
	productId int primary key auto_increment,
    productName varchar(100),
    quantity int not null
);

insert into Products( productName , quantity) values 
('Iphone XSMAX' , 10),
('Iphone 11', 15),
('Iphone 14', 20);

create table InventoryChanges(
	ChangeId int primary key auto_increment,
    productId int,
    OldQuantity int,
    NewQuantity int,
    ChangeDate date,
    foreign key (productId) references Products(productId)
);


-- exe 1 -- 
delimiter $$
create trigger AfterProductUpdate 
after update 
on Products 
for each row 
begin 
	insert into InventoryChanges (productId , OldQuantity, NewQuantity , ChangeDate) values ( old.productId , old.quantity , new.quantity, now());
end $$
delimiter ;

UPDATE Products
SET quantity = quantity + 10
WHERE productID = 1;

UPDATE Products
SET quantity = quantity + 15
WHERE productID = 2;

select * from InventoryChanges;

-- exe 2 --
delimiter $$ 
create trigger beforeProductDelete 
before update 
on Products 
for each row
begin
	declare count int;
	select quantity into count from Products ;
    if count > 10 then 
		signal sqlstate '45000' set message_text = 'Erro delete product limit';
    end if;
end $$ 
delimiter ;

DELETE FROM Products WHERE productId = 2;

-- exe 3 --

alter table Products  add LatsDate date;

delimiter $$
create trigger AfterProductUpdateSetDate 
before update 
on Products
for each row 
begin 
	 set new.LatsDate = now();
end $$
delimiter ;

update products 
set quantity = 40 
where productId = 2;

select * from Products;

drop trigger AfterProductUpdateSetDate;
-- exe 4 -- 
create table ProductSummary (
	SummaryId int primary key auto_increment,
    TotalQuantity int
);


delimiter $$ 
create trigger AfterProductUpdateSummary
after update 
on products
for each row 
begin 
	update ProductSummary set totalQuantity  = (select sum(quantity) from Products);
end $$ 
delimiter ;



-- exe 5 -- 
create table InventoryChangesHistory(
	historyId int primary key auto_increment ,
    productId int ,
    oldQuantity int,
    newQuantity int,
    changeType enum('Increase', 'Decrease'),
    changeDate datetime
);

DELIMITER $$
CREATE TRIGGER AfterProductUpdateHistory
AFTER UPDATE ON Products
FOR EACH ROW
BEGIN
    
    IF OLD.Quantity != NEW.Quantity THEN
        INSERT INTO InventoryChangeHistory (ProductID, ChangeType, OldQuantity, NewQuantity, ChangeDate)
        VALUES (
            NEW.ProductID,
            CASE 
                WHEN NEW.Quantity > OLD.Quantity THEN 'Increase'
                WHEN NEW.Quantity < OLD.Quantity THEN 'Decrease'
                ELSE 'No Change'
            END,
            OLD.Quantity,
            NEW.Quantity,
            NOW()
        );
    END IF;
END$$
DELIMITER ;

-- exe 6 --
CREATE TABLE ProductRestock (
    RestockID INT PRIMARY KEY AUTO_INCREMENT,
    ProductID INT NOT NULL,
    RestockQuantity INT NOT NULL,
    RequestDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

DELIMITER $$
CREATE TRIGGER AfterProductUpdateRestock
AFTER UPDATE ON Products
FOR EACH ROW
BEGIN
    IF NEW.Quantity < 10 AND OLD.Quantity >= 10 THEN
        INSERT INTO ProductRestock (ProductID, RestockQuantity, RequestDate)
        VALUES (NEW.ProductID, 20, NOW());  
    END IF;
END$$
DELIMITER ;




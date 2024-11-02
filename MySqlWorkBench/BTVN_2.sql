use CompanyDB;

create table Products (
	ProductID int primary key auto_increment,
    ProductName varchar(255) not null,
    Category varchar(255) not null,
    Price int,
    StockQuantity int
);

INSERT INTO Products (ProductName, Category, Price, StockQuantity) VALUES
('Apple', 'Food', 1, 200),
('Bread', 'Food', 2, 150),
('Milk', 'Food', 1, 100);

select * from products;
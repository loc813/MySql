use CompanyDB; 
-- cach 1 -- 
create table Orders(
	OrderID int primary key auto_increment,
    OrderDate date not null,
    Customer_ID int not null, foreign key (Customer_ID) references Customers(CustomerID),
    TotalAmount int , CHECK (TotalAmount > 0)
);


-- cach 2 -- 
create table Orders(
	OrderID int primary key auto_increment,
    OrderDate date not null,
    Customer_ID int not null,
    TotalAmount int 
);

ALTER TABLE Orders
ADD CONSTRAINT FK_Customer
FOREIGN KEY (Customer_ID) REFERENCES Customers(CustomerID);

ALTER TABLE Orders
ADD CONSTRAINT chk_TotalAmount CHECK (TotalAmount >= 0);


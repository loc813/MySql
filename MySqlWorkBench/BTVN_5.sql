use CompanyDB;

-- chen them 10 bang ghi vao bang product -- 
INSERT INTO Products (ProductName, Category, Price, StockQuantity) VALUES
('Nước khoáng', 'Drink', 8000, 200),
('Nước ngọt', 'Drink', 12000, 100),
('Nước trái cây', 'Drink', 15000, 80),
('Bia', 'Drink', 25000, 90),
('Thịt gà', 'Meat', 60000, 50),
('Thịt bò', 'Meat', 150000, 30),
('Thịt heo', 'Meat', 70000, 40),
('Thịt cừu', 'Meat', 200000, 20),
('Thịt nguội', 'Meat', 50000, 70),
('Sữa đặc', 'Drink', 25000, 60);

select * from products ;

create table Orders(
	OrderID int primary key auto_increment,
    OrderDate date not null,
	Product_ID int not null, foreign key (Product_ID) references products(ProductID),
    Quantity int not null ,
    TotalAmount int , CHECK (TotalAmount > 0)
);

-- tao trigger de tu dong cap nhat totalAmount tu dong tinh theo so luong bang Price * Quantity -- 
DELIMITER //

CREATE TRIGGER UpdateTotalAmount
BEFORE INSERT ON Orders
FOR EACH ROW
BEGIN
    DECLARE product_price INT;

    -- Lấy giá của sản phẩm từ bảng Products
    SELECT Price INTO product_price FROM Products WHERE ProductID = NEW.Product_ID;

    -- Gán giá trị cho TotalAmount
    SET NEW.TotalAmount = NEW.Quantity * product_price;
END; //

DELIMITER ;

-- chen 10 ban ghi vao orders -- 
INSERT INTO Orders (OrderDate, Product_ID, Quantity) VALUES
('2024-11-01', 1, 5),  -- Nước khoáng
('2024-11-01', 2, 3),  -- Nước ngọt
('2024-11-01', 3, 2),  -- Nước trái cây
('2024-11-01', 4, 1),  -- Bia
('2024-11-01', 5, 10), -- Thịt gà
('2024-11-01', 6, 5),  -- Thịt bò
('2024-11-01', 7, 4),  -- Thịt heo
('2024-11-01', 8, 2),  -- Thịt cừu
('2024-11-01', 9, 6),  -- Thịt nguội
('2024-11-01', 10, 3);  -- Sữa đặc

-- truy van toan bo san pham va so luong ton dong trong kho -- 
select ProductID, ProductName, StockQuantity from products;

-- truy vấn để lấy thông tin về tất cả các đơn hàng cùng với tên sản phẩm, số lượng, và tổng số tiền của từng đơn hàng. --
select 
	OrderID,
	OrderDate,
    ProductName,
    Quantity,
    TotalAmount
from 
	Orders
Join products on Product_ID = ProductID -- de lay thong tin lien quan den san pham: gia ... --



CREATE DATABASE ECommerceDB;
USE ECommerceDB;

-- Tạo bảng Users
CREATE TABLE Users (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(50) UNIQUE NOT NULL,
    PasswordHash VARCHAR(255) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Tạo bảng Products
CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Description TEXT,
    Price DECIMAL(10, 2) NOT NULL,
    Stock INT NOT NULL
);

-- Tạo bảng Orders
CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT,
    OrderDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Tạo bảng OrderDetails
CREATE TABLE OrderDetails (
    OrderDetailID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    PriceAtOrder DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Tạo bảng Reviews
CREATE TABLE Reviews (
    ReviewID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT,
    UserID INT,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    ReviewText TEXT,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);


-- insert -- 
INSERT INTO Users (Username, PasswordHash, Email)
VALUES
    ('nguyen_van_a', '5f4dcc3b5aa765d61d8327deb882cf99', 'nguyen.a@example.com'),  -- Mật khẩu: password
    ('le_thi_b', '098f6bcd4621d373cade4e832627b4f6', 'le.b@example.com'), -- Mật khẩu: test
    ('pham_quang_c', 'e99a18c428cb38d5f260853678922e03', 'pham.c@example.com');  -- Mật khẩu: abc123


INSERT INTO Products (ProductName, Description, Price, Stock)
VALUES
    ('Smartphone', 'Smartphone with 6GB RAM and 128GB storage', 599.99, 100),
    ('Laptop', 'Laptop with Intel i7 processor, 16GB RAM', 1299.50, 50),
    ('Wireless Headphones', 'Bluetooth wireless headphones with noise cancellation', 199.99, 200),
    ('Smartwatch', 'Smartwatch with heart rate monitor and GPS', 299.99, 150),
    ('Tablet', '10-inch tablet with 64GB storage', 249.99, 75);


-- Đơn hàng 1
INSERT INTO Orders (UserID, TotalAmount)
VALUES (1, 899.98);  -- John Doe

-- Chi tiết đơn hàng 1
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, PriceAtOrder)
VALUES
    (1, 1, 1, 599.99),  -- 1 Smartphone
    (1, 3, 1, 199.99);  -- 1 Wireless Headphones

-- Đơn hàng 2
INSERT INTO Orders (UserID, TotalAmount)
VALUES (2, 1499.50);  -- Jane Smith

-- Chi tiết đơn hàng 2
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, PriceAtOrder)
VALUES
    (2, 2, 1, 1299.50),  -- 1 Laptop
    (2, 4, 1, 299.99);  -- 1 Smartwatch

INSERT INTO Reviews (ProductID, UserID, Rating, ReviewText)
VALUES
    (1, 1, 5, 'Great smartphone! Fast performance and excellent camera. Highly recommended!'),  -- Review for Smartphone (John Doe)
    (2, 2, 4, 'Good laptop, but a bit expensive. Overall, solid performance for work and gaming.'),  -- Review for Laptop (Jane Smith)
    (3, 3, 3, 'Headphones are decent but could use better bass response. Comfortable though.');  -- Review for Wireless Headphones (Alex Brown)


select * from Products;
-- update -- 
UPDATE Products
SET Price = 1000
WHERE ProductID = '1';

UPDATE Products
SET Stock = 100
WHERE ProductID = '3';

UPDATE Users
SET Email = 'loc123email@example.com'
WHERE UserID = '1';

-- delete -- 
-- Xóa bản ghi trong bảng OrderDetails có liên quan đến sản phẩm
DELETE FROM OrderDetails
WHERE ProductID = '5';

-- Xóa bản ghi trong bảng Reviews có liên quan đến sản phẩm
DELETE FROM Reviews
WHERE ProductID = '5';

-- Xóa sản phẩm từ bảng Products
DELETE FROM Products
WHERE ProductID = '5';

-- Xóa các chi tiết của đơn hàng trong bảng OrderDetails
DELETE FROM OrderDetails
WHERE OrderID = '2';

-- Xóa đơn hàng từ bảng Orders
DELETE FROM Orders
WHERE OrderID = '2';


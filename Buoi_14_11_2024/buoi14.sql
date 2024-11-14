-- Tạo bảng Customers
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerName VARCHAR(255),
    ContactName VARCHAR(255),
    Country VARCHAR(255)
);

-- Tạo bảng Orders
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Tạo bảng Products
CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(255),
    Price DECIMAL(10, 2)
);

-- Tạo bảng OrderDetails
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    UnitPrice DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Tạo view để hiển thị thông tin đơn hàng
CREATE VIEW OrderInfo AS
SELECT 
    Orders.OrderID,
    Customers.CustomerName,
    Orders.OrderDate,
    Orders.TotalAmount
FROM 
    Orders
JOIN 
    Customers ON Orders.CustomerID = Customers.CustomerID;

-- Tạo view để hiển thị chi tiết đơn hàng
CREATE VIEW OrderDetailsInfo AS
SELECT 
    OrderDetails.OrderDetailID,
    Orders.OrderID,
    Products.ProductName,
    OrderDetails.Quantity,
    OrderDetails.UnitPrice
FROM 
    OrderDetails
JOIN 
    Orders ON OrderDetails.OrderID = Orders.OrderID
JOIN 
    Products ON OrderDetails.ProductID = Products.ProductID;

-- Tạo chỉ mục cho bảng Orders
CREATE INDEX idx_order_customer ON Orders(CustomerID);

-- Tạo chỉ mục cho bảng OrderDetails
CREATE INDEX idx_orderdetails_order ON OrderDetails(OrderID);
CREATE INDEX idx_orderdetails_product ON OrderDetails(ProductID);

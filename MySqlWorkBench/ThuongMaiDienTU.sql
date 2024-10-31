USE demo_database;

CREATE TABLE Users (
    `ID` int PRIMARY KEY AUTO_INCREMENT,
    `username` varchar(50) UNIQUE NOT NULL,
    `passwordHash` varchar(255) NOT NULL,
    `email` varchar(100) UNIQUE NOT NULL
);

CREATE TABLE Products (
    `ID` int PRIMARY KEY AUTO_INCREMENT,
    `productName` varchar(100) NOT NULL, 
    `description` TEXT, 
    `price` DECIMAL(10,2) NOT NULL,
    `stock` int NOT NULL
);

CREATE TABLE Cart (
    `ID` int PRIMARY KEY AUTO_INCREMENT,
    `userID` int,
    FOREIGN KEY (userID) REFERENCES Users(ID),
    `total` int NOT NULL 
);

CREATE TABLE CartItems (
    `ID` int PRIMARY KEY AUTO_INCREMENT,
    `cartID` int,
    FOREIGN KEY (cartID) REFERENCES Cart(ID),
    `productID` int,
    FOREIGN KEY (productID) REFERENCES Products(ID),
    `quantity` int NOT NULL 
);

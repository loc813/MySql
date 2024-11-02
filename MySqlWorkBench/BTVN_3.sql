use CompanyDB;

-- tao bang department -- 
CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
    DepartmentName VARCHAR(100) NOT NULL
);

-- chinh sua lai bang employees -- 
ALTER TABLE Employees
ADD DepartmentID INT,
ADD FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID);

-- chen du lieu vao bang department -- 
INSERT INTO Department (DepartmentName) VALUES
('Sales'),
('Marketing'),
('IT'),
('HR'),
('Finance');

-- xoa cot department thay bang departmantID de tao khoa ngoai ket noi toi bang Department -- 
ALTER TABLE Employees DROP COLUMN Department;

-- insert ban ghi mau vao bang employees -- 
INSERT INTO Employees (FirstName, LastName, HireDate, Salary, DepartmentID) VALUES
('John', 'Doe', '2020-01-15', 50000.00, 1),
('Jane', 'Smith', '2019-03-22', 60000.00, 2),
('Michael', 'Johnson', '2021-07-30', 55000.00, 3),
('Emily', 'Davis', '2018-11-05', 70000.00, 4),
('Chris', 'Brown', '2022-04-10', 45000.00, 5),
('Patricia', 'Garcia', '2020-08-17', 62000.00, 1),
('Robert', 'Martinez', '2023-02-01', 48000.00, 3),
('Linda', 'Lopez', '2021-12-25', 75000.00, 2),
('David', 'Wilson', '2019-09-11', 58000.00, 4),
('Jennifer', 'Anderson', '2022-05-14', 50000.00, 5);

-- tim kiem cac nhan vien thuoc phong ban '1' tuc la phong ban 'sale' -- 
select * from Employees
where DepartmentID = '1'; 

-- cap nhat luong cua mot nhan vien vi du nhan vien co ma nhan vien = '1' --
UPDATE employees
SET salary = 1500000.00
WHERE EmployeeID = '1';

-- Xoa tat ca nhan vien co muc luong < 50000 -- 
DELETE FROM employees
WHERE salary < 50000;



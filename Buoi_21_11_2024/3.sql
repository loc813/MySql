CREATE SCHEMA demo_index;
USE demo_index;
CREATE TABLE Employees
(
    Id INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(50),
    Email VARCHAR(50),
    Department VARCHAR(50)
);

DELIMITER $$

CREATE PROCEDURE PopulateEmployees()
BEGIN
    DECLARE counter INT DEFAULT 1;
    DECLARE employeeName VARCHAR(50);
    DECLARE employeeEmail VARCHAR(50);
    DECLARE employeeDept VARCHAR(10);

    WHILE counter <= 100000 DO
        SET employeeName = CONCAT('ABC ', counter);
        SET employeeEmail = CONCAT('abc', counter, '@pragimtech.com');
        SET employeeDept = CONCAT('Dept ', counter);

        INSERT INTO Employees (Name, Email, Department) VALUES (employeeName, employeeEmail, employeeDept);

        SET counter = counter + 1;

        IF counter % 10000 = 0 THEN
            SELECT CONCAT(counter, ' rows inserted') AS Progress;
        END IF;
    END WHILE;
END $$

DELIMITER ;

-- To execute the procedure and populate the table
CALL PopulateEmployees();
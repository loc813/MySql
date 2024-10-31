create database engineering;
use engineering;


-- CREATE TABLE host (
--     Fid INT PRIMARY KEY,
--     name VARCHAR(45),
--     address VARCHAR(45)
-- );

-- CREATE TABLE architect (
--     id INT PRIMARY KEY,
--     name VARCHAR(255),
--     sex TINYINT(1),
--     birthday DATE,
--     place VARCHAR(255)
-- );

-- CREATE TABLE building (
--     id INT PRIMARY KEY,
--     name VARCHAR(45),
--     address VARCHAR(255),
--     city VARCHAR(45),
--     cost FLOAT,
--     start DATE
-- );

-- CREATE TABLE contractor (
--     id INT PRIMARY KEY,
--     name VARCHAR(255),
--     address VARCHAR(255)
-- );

-- CREATE TABLE worker (
--     id INT PRIMARY KEY,
--     name VARCHAR(45),
--     birthday VARCHAR(45),
--     year VARCHAR(45),
--     skill VARCHAR(45)
-- );

-- CREATE TABLE work (
--     building_id INT,
--     worker_id INT,
--     date DATE,
--     total VARCHAR(45),
--     PRIMARY KEY (building_id, worker_id),
--     FOREIGN KEY (building_id) REFERENCES building(id),
--     FOREIGN KEY (worker_id) REFERENCES worker(id)
-- );

-- CREATE TABLE design (
--     building_id INT,
--     architect_id INT,
--     PRIMARY KEY (building_id, architect_id),
--     FOREIGN KEY (building_id) REFERENCES building(id),
--     FOREIGN KEY (architect_id) REFERENCES architect(id)
-- );

ALTER TABLE building 
ADD host_id INT,
ADD contractor_id int;


ALTER TABLE building 
ADD FOREIGN KEY (host_id) REFERENCES host(Fid),
ADD FOREIGN KEY (contractor_id) references contractor(id);


USE contruction;

INSERT INTO architect (id, name, birthday, sex, place, address) VALUES
(6, 'Johnny Deep', 1990, 1, 'Hanoi', '123 Tran Duy Hung'),
(7, 'Messi', 1992, 1, 'Thanh Hoa', 'Duong 7 Ha Long'),
(8, 'Alice Johnson', 1993, 0, 'Hanoi', 'Co Nhue'),
(9, 'Bob Brown', 1994, 1, 'Hue', '101 Duong Lang'),
(10, 'Charlie Davis', 1995, 1, 'Da Nang', '202 Ho Guom');


SELECT * FROM architect;

ALTER TABLE building
ADD CONSTRAINT FK_Host
FOREIGN KEY (host_id) REFERENCES host(id);

ALTER TABLE building
ADD CONSTRAINT FK_Contractor
FOREIGN KEY (contractor_id) REFERENCES contractor(id);

ALTER TABLE `work`
ADD CONSTRAINT FK_Building FOREIGN KEY (building_id) REFERENCES building(id),
ADD CONSTRAINT FK_Worker FOREIGN KEY (worker_id) REFERENCES worker(id);

ALTER TABLE design
ADD CONSTRAINT FK_Architect FOREIGN KEY (architect_id) REFERENCES architect(id),
ADD CONSTRAINT FK_Build FOREIGN KEY (building_id) REFERENCES building(id);






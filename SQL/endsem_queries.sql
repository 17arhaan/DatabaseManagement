CREATE TABLE Employee (
    EmpNo INT PRIMARY KEY,
    EmpName VARCHAR(255) NOT NULL,
    Gender CHAR(1) NOT NULL CHECK (Gender IN ('M', 'F')),
    Salary DECIMAL(10, 2) NOT NULL,
    Address VARCHAR(255) NOT NULL
);

Insert into Employee
VALUES  (123,'Arhaan','M',50000,'Paris'),
        (456,'Zrhaan','M',80000,'Nice'),
        (789,'Xrhaan','F',20000,'Monte');


ALTER TABLE Employee
ADD DOB DATE;


UPDATE Employee
SET DOB = '2004-01-17'
WHERE EmpNo = 123;

UPDATE Employee
SET DOB = '1985-09-22'
WHERE EmpNo = 456;

UPDATE Employee
SET DOB = '1993-11-30'
WHERE EmpNo = 789;


SELECT 
    DATE_FORMAT(DOB, '%d-%b-%Y') AS birth_date_full,
    DATE_FORMAT(DOB, '%d-%b-%y') AS birth_date_short,
    DATE_FORMAT(DOB, '%d-%m-%y') AS birth_date_mm_yy
FROM Employee;

select * from Employee;

SELECT 
    EmpName,DOB,
    CASE 
        WHEN DATE_FORMAT(DOB, '%Y') = '2004' THEN 'Two thousand four'
        WHEN DATE_FORMAT(DOB, '%Y') = '1985' THEN 'Nineteen eighty five'
        WHEN DATE_FORMAT(DOB, '%Y') = '1993' THEN 'Nineteen ninety three'
    END AS year_spelled_out
FROM Employee;


CREATE TABLE Part (
    PartNo INT PRIMARY KEY,
    PartName VARCHAR(255) NOT NULL,
    VehicleType VARCHAR(2) CHECK (VehicleType IN ('V1', 'V2', 'V3', 'V4', 'V5')),
    UnitPrice DECIMAL(10, 2) CHECK (UnitPrice > 0),
    SalesPrice DECIMAL(10, 2) CHECK (SalesPrice > 0)
);

CREATE TABLE Service (
    ServiceNo INT PRIMARY KEY,
    PartNo INT,
    ServiceDate DATE,
    CustomerNo INT,
    Qty INT,
    FOREIGN KEY (PartNo) REFERENCES Part(PartNo)
);


alter table serivce
ADD CONSTRAINT chk_services CHECK(CustomerNo > 0 AND Qty > 0);

alter table service
add CONSTRAINT fk_partno FOREIGN KEY (PartNo) REFERENCES Part(PartNo);

INSERT INTO Service 
VALUES
    (1, 2, '2017-01-01', 10, 5),
    (1, 3, '2017-01-01', 10, 4),
    (2, 3, '2018-02-05', 20, 10),
    (3, 1, '2018-05-15', 30, 9),
    (4, 1, '2019-06-03', 10, 5);
SELECT * FROM Service;

INSERT INTO Part 
VALUES 
    (1, 'P1', 'V1', 10, 12),
    (2, 'P2', 'V2', 100, 110),
    (3, 'P3', 'V1', 150, 175),
    (4, 'P4', 'V3', 200, 250),
    (5, 'P5', 'V2', 75, 90);


SELECT PartName
FROM Part 
LEFT JOIN Service ON Part.PartNo = Service.PartNo
WHERE Service.PartNo IS NULL;

SELECT * from Service;

SELECT CustomerNo
FROM Service
GROUP BY CustomerNo
ORDER BY COUNT(*) DESC
LIMIT 1;

create table Player(
    PlayerID int PRIMARY KEY,
    LastName varchar(20),
    FirstName varchar(20),
    Country varchar(20),
    Yearborn int,
    Birthplace varchar(20)
);
CREATE TABLE Batting (
    MatchID INT,
    PlayerID INT UNIQUE,
    BattingOrder INT,
    RunsScored INT,
    FOREIGN KEY (MatchID) REFERENCES `Match`(MatchID),
    FOREIGN KEY (PlayerID) REFERENCES Player(PlayerID),
    PRIMARY KEY (MatchID)
);

CREATE TABLE `Match` (
    MatchID INT PRIMARY KEY,
    TeamName1 VARCHAR(20),
    TeamName2 VARCHAR(20),
    Ground VARCHAR(20),
    MatchDate DATE
);

INSERT INTO `Match` (MatchID, TeamName1, TeamName2, Ground, MatchDate)
VALUES
(2675, 'Australia', 'India', 'Melbourne', '2008-10-02'),
(2688, 'Australia', 'India', 'Sydney', '2008-02-03'),
(2689, 'Australia', 'India', 'Brisbane', '2008-04-03'),
(2755, 'India', 'West Indies', 'Brisbane', '2010-07-07'),
(2750, 'Sri Lanka', 'India', 'Brisbane', '2010-07-04');

-- Insert data into Player table
INSERT INTO Player (PlayerID, LastName, FirstName, Country, YearBorn, BirthPlace)
VALUES
(89001, 'Tendulkar', 'Sachin', 'India', 1973, 'Mumbai'),
(27002, 'Sharma', 'Ishant', 'India', 1988, 'Delhi'),
(99001, 'Lee', 'Brett', 'Australia', 1976, 'Wollongong'),
(98002, 'Lara', 'Brian', 'West Indies', 1969, 'Santa Cruz'),
(91001, 'Jayasurya', 'Sanath', 'Sri Lanka', 1969, 'Matara');

use Arhaan_main;
-- Insert data into Batting table
INSERT INTO Batting (MatchID, PlayerID, RunsScored, BattingOrder)
VALUES
(2688, 98002, 42, 2),
(2675, 27002, 0, 2),
(2689, 99001, 9, 2),
(2750, 89001, 40, 4),
(2755, 27002, 29, 3),
(2675, 27002, 0, 4);

select * from Batting;


---------------------------


use University;

WITH maximum_budget AS (
    SELECT MAX(budget) AS max_budget 
    FROM Department
)
SELECT m.max_budget, d.dept_name
FROM maximum_budget m
JOIN Department d ON m.max_budget = d.budget;

select distinct dept_name , avg(salary) as avg_salary
from Instructor
group by dept_name; 

select count(ID) as total_courses , title
from takes natural join course
group by course_id;

select count(ID) , course_id
from takes
group by course_id;

select * from all_courses;

create view all_courses as
select course.course_id , section.building , section.sec_id
from course join section on course.course_id = section.course_id
where course.dept_name = 'Physics' And section.semester = 'Fall' and section.year = 2009;


select dept_name
from Instructor
GROUP BY dept_name
ORDER BY avg(salary) DESC;

select name 
from Instructor 
where salary > ALL(
    Select salary
    from Instructor
    where dept_name = 'Biology'
);


select name 
from Instructor 
where salary > Some (
    Select salary
    from Instructor
    where dept_name = 'Biology'
);

select COUNT(ID)
from takes
where course_id IN (
    select course_id
    from teaches
    where ID = 10101
);

select course_id , title
from course
where course_id IN ( 
    SELECT course_id 
    From takes
    where semester = 'Fall' and year = 2009) AND
    course_id NOT IN (
    SELECT course_id 
    From takes
    where semester = 'Spring' and year = 2010
    );
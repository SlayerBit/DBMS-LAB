CREATE DATABASE sports_management;
USE sports_management;

-- Create Tables
CREATE TABLE Student (
    sid INT PRIMARY KEY,
    sname VARCHAR(50),
    age INT
);

CREATE TABLE `Match` (
    mid VARCHAR(10) PRIMARY KEY,
    mname VARCHAR(50),
    venue VARCHAR(50)
);

CREATE TABLE Play (
    sid INT,
    mid VARCHAR(10),
    day DATE,
    PRIMARY KEY (sid, mid, day),
    FOREIGN KEY (sid) REFERENCES Student(sid),
    FOREIGN KEY (mid) REFERENCES `Match`(mid)
);

-- Populate the tables with sample data
INSERT INTO Student (sid, sname, age) VALUES
(1, 'Amit', 20),
(2, 'Raj', 22),
(3, 'Priya', 21),
(4, 'Neha', 20);

INSERT INTO `Match` (mid, mname, venue) VALUES
('B10', 'Cricket', 'Delhi'),
('B11', 'Football', 'Mumbai'),
('B12', 'Tennis', 'Delhi');

INSERT INTO Play (sid, mid, day) VALUES
(1, 'B10', '2024-10-10'),
(2, 'B11', '2024-10-10'),
(1, 'B11', '2024-10-11'),
(3, 'B12', '2024-10-12'),
(4, 'B10', '2024-10-13'),
(1, 'B10', '2024-10-13');

-- Query 1: Find all information of students who have played match number B10
SELECT Student.*
FROM Student
JOIN Play ON Student.sid = Play.sid
WHERE Play.mid = 'B10';

-- Query 2: Find the name of matches played by Amit
SELECT `Match`.mname
FROM `Match`
JOIN Play ON `Match`.mid = Play.mid
JOIN Student ON Play.sid = Student.sid
WHERE Student.sname = 'Amit';

-- Query 3: Find the names of students who have played a match in Delhi
SELECT DISTINCT Student.sname
FROM Student
JOIN Play ON Student.sid = Play.sid
JOIN `Match` ON Play.mid = `Match`.mid
WHERE `Match`.venue = 'Delhi';

-- Query 4: Find the names of students who have played at least one match
SELECT DISTINCT sname
FROM Student
JOIN Play ON Student.sid = Play.sid;

-- Query 5: Find the ids and names of students who have played two different matches on the same day
SELECT Student.sid, Student.sname
FROM Student
JOIN Play ON Student.sid = Play.sid
GROUP BY Student.sid, Play.day
HAVING COUNT(DISTINCT Play.mid) >= 2;

-- Query 6: Find the ids of students who have played a match in Delhi or Mumbai
SELECT DISTINCT Student.sid
FROM Student
JOIN Play ON Student.sid = Play.sid
JOIN `Match` ON Play.mid = `Match`.mid
WHERE `Match`.venue IN ('Delhi', 'Mumbai');

-- Query 7: Find the average age of students
SELECT AVG(age) AS average_age FROM Student;

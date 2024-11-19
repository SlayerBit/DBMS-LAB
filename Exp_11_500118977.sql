create database exp11;
use exp11;

--  1: Create the EMPLOYEES table
CREATE TABLE EMPLOYEES (
    Employee_id CHAR(10) PRIMARY KEY,
    First_Name CHAR(30) NOT NULL,
    Last_Name CHAR(30) NOT NULL,
    DOB DATE,
    Salary NUMERIC(25, 2) NOT NULL,
    Department_id CHAR(10)
);

--  2: Insert 6 sample rows into the EMPLOYEES table
INSERT INTO EMPLOYEES (Employee_id, First_Name, Last_Name, DOB, Salary, Department_id) VALUES
('E001', 'John', 'Doe', '1985-01-15', 55000, 'D001'),
('E002', 'Jane', 'Smith', '1990-04-22', 60000, 'D002'),
('E003', 'James', 'Brown', '1987-07-12', 58000, 'D001'),
('E004', 'Emily', 'Davis', '1995-02-10', 62000, 'D003'),
('E005', 'Michael', 'Wilson', '1992-09-05', 59000, 'D002'),
('E006', 'Sarah', 'Taylor', '1988-12-30', 63000, 'D004');

--  3: Create an index on Last_Name and Department_id
CREATE INDEX employee_idx ON EMPLOYEES (Last_Name, Department_id);

--  4: Create a unique index on Employee_id
CREATE UNIQUE INDEX unique_employee_id_idx ON EMPLOYEES (Employee_id);

--  5: Create a reverse index on Employee_id
CREATE INDEX reverse_employee_id_idx ON EMPLOYEES (Employee_id DESC);

--  6: Create a unique composite index on Employee_id and check for duplicity
CREATE UNIQUE INDEX unique_composite_employee_id_idx ON EMPLOYEES (Employee_id, Department_id);

--  7: Create function-based indexes on Last_Name for case-insensitive searches
CREATE INDEX upper_last_name_idx ON EMPLOYEES ((UPPER(Last_Name)));
CREATE INDEX lower_last_name_idx ON EMPLOYEES ((LOWER(Last_Name)));

--  8: Drop the function-based index on Last_Name
DROP INDEX upper_last_name_idx ON EMPLOYEES;
CREATE DATABASE exp9;
USE exp9;

-- Creating the EMPLOYEES Table
CREATE TABLE EMPLOYEES (
 Employee_id CHAR(10) PRIMARY KEY,
 First_Name CHAR(30) NOT NULL,
 Last_Name CHAR(30) NOT NULL,
 DOB DATE,
 Salary DECIMAL(10, 2) NOT NULL,  -- Using DECIMAL to handle salaries with two decimal places
 Department_id CHAR(10)
);

-- Inserting values into the EMPLOYEES table
INSERT INTO EMPLOYEES (Employee_id, First_Name, Last_Name, DOB, Salary, Department_id) VALUES
('E001', 'John', 'Doe', '1990-01-15', 50000.00, 'D01'),
('E002', 'Jane', 'Smith', '1985-03-22', 60000.00, 'D02'),
('E003', 'Emily', 'Jones', '1992-06-30', 55000.00, 'D01'),
('E004', 'Michael', 'Brown', '1988-12-05', 70000.00, 'D03'),
('E005', 'Linda', 'Davis', '1995-05-15', 65000.00, 'D02'),
('E006', 'James', 'Wilson', '1980-09-25', 75000.00, 'D01');

-- Creating a View named emp_view
CREATE VIEW emp_view AS
SELECT Employee_id, Last_Name, Salary, Department_id
FROM EMPLOYEES;

-- You cannot directly insert into a view like this unless you are inserting into an updatable view that maps directly to a base table.
-- Remove the insert into view since it will cause errors.

-- If you need to modify the Salary column to allow NULL values, you'd do the following:
ALTER TABLE EMPLOYEES MODIFY Salary DECIMAL(10, 2) NULL;

-- Now, you can insert a row with a NULL salary
INSERT INTO EMPLOYEES (Employee_id, First_Name, Last_Name, DOB, Salary, Department_id) VALUES
('E007', 'Chris', 'Anderson', NULL, NULL, 'D01');

-- Update operations on the View (affects the base table EMPLOYEES)
UPDATE emp_view
SET Salary = 80000.00
WHERE Employee_id = 'E001';

-- Delete an employee from the view (and consequently from the EMPLOYEES table)
DELETE FROM emp_view
WHERE Employee_id = 'E003';

SELECT * FROM emp_view;
-- Dropping the emp_view
DROP VIEW emp_view;

-- Create a View named salary_view to show annual salary for employees in Department D02
CREATE VIEW salary_view AS
SELECT Employee_id, Last_Name, Salary * 12 AS Annual_Salary
FROM EMPLOYEES
WHERE Department_id = 'D02';

-- View the salary_view
SELECT * FROM salary_view;
-- Om Tripathi
-- 500119524

CREATE DATABASE CompanyDB;
USE CompanyDB;

CREATE TABLE EMP (
    EMPNO INT PRIMARY KEY,
    ENAME VARCHAR(50),
    JOB VARCHAR(50),
    MGR INT,
    HIREDATE DATE,
    SAL DECIMAL(10, 2),
    COMM DECIMAL(10, 2),
    DEPTNO INT
);
INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES
(7369, 'SMITH', 'CLERK', 7902, '1980-12-17', 500, 800, 20),
(7499, 'ALLEN', 'SALESMAN', 7698, '1981-02-20', 1600, 300, 30),
(7521, 'WARD', 'SALESMAN', 7698, '1981-02-22', 1250, 500, 30),
(7566, 'JONES', 'MANAGER', 7839, '1981-04-02', 2975, NULL, 20),
(7654, 'MARTIN', 'SALESMAN', 7698, '1981-09-28', 1250, 1400, 30),
(7698, 'BLAKE', 'MANAGER', 7839, '1981-05-01', 2850, NULL, 30),
(7782, 'CLARK', 'MANAGER', 7839, '1981-06-09', 2450, NULL, 10),
(7788, 'SCOTT', 'ANALYST', 7566, '1982-12-09', 3000, NULL, 20),
(7839, 'KING', 'PRESIDENT', NULL, '1981-11-17', 5000, NULL, 10),
(7844, 'TURNER', 'SALESMAN', 7698, '1981-09-08', 1500, 0, 30),
(7876, 'ADAMS', 'CLERK', 7788, '1983-01-12', 1100, NULL, 20),
(7900, 'JAMES', 'CLERK', 7698, '1981-12-03', 950, NULL, 30),
(7902, 'FORD', 'ANALYST', 7566, '1981-12-03', 3000, NULL, 20),
(7934, 'MILLER', 'CLERK', 7782, '1982-01-23', 1300, NULL, 10);

CREATE TABLE DEPT (
    DEPTNO INT PRIMARY KEY,
    DNAME VARCHAR(50),
    LOC VARCHAR(50)
);

INSERT INTO DEPT (DEPTNO, DNAME, LOC) VALUES
(10, 'ACCOUNTING', 'NEW YORK'),
(20, 'RESEARCH', 'DALLAS'),
(30, 'SALES', 'CHICAGO'),
(40, 'OPERATIONS', 'BOSTON');


-- 1. Retrieve the average salary of all employees.
SELECT AVG(SAL) AS Avg_Salary FROM EMP;

-- 2. Retrieve the number of employees.
SELECT COUNT(*) AS Number_Of_Employees FROM EMP;

-- 3. Retrieve the distinct number of employees.
SELECT COUNT(DISTINCT EMPNO) AS Distinct_Employees FROM EMP;

-- 4. Retrieve the total salary of employees grouped by job.
SELECT JOB, SUM(SAL) AS Total_Salary FROM EMP GROUP BY JOB;

-- 5. Display the employee information with the maximum salary.
SELECT * FROM EMP WHERE SAL = (SELECT MAX(SAL) FROM EMP);

-- 6. Find the highest paid employee in department 10.
SELECT * FROM EMP WHERE SAL = (SELECT MAX(SAL) FROM EMP WHERE DEPTNO = 10);

-- 7. List the employees whose salary is equal to the average of max and minimum salary.
SELECT * FROM EMP WHERE SAL = (SELECT (MAX(SAL) + MIN(SAL)) / 2 FROM EMP);

-- 8. List the employees who joined the company on the same date.
SELECT HIREDATE, GROUP_CONCAT(ENAME) AS Employees_Joined_On_Same_Date
FROM EMP
GROUP BY HIREDATE
HAVING COUNT(*) > 1;

-- 9. Display the employee names in both upper and lower case.
SELECT UPPER(ENAME) AS Upper_Name, LOWER(ENAME) AS Lower_Name FROM EMP;

-- 10. Find the date that is 3 days later from hiredate.
SELECT ENAME, HIREDATE, DATE_ADD(HIREDATE, INTERVAL 3 DAY) AS Date_3_Days_Later FROM EMP;

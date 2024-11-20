-- OM Tripathi
-- 500119524

USE company_2;

-- 1. Retrieve the names of all employees in department 5 who work more than 10 hours per week on the 'ProductX' project.
SELECT E.Fname, E.Lname
FROM Employee E
JOIN Works_On W ON E.Ssn = W.Essn
JOIN Project P ON W.Pno = P.Pnumber
WHERE E.Dno = 5 AND W.Hours > 10 AND P.Pname = 'ProductX';

-- 2. Retrieve the names of employees who work on every project.
SELECT E.Fname, E.Lname
FROM Employee E
WHERE NOT EXISTS (
    SELECT P.Pnumber
    FROM Project P
    WHERE NOT EXISTS (
        SELECT W.Essn
        FROM Works_On W
        WHERE W.Pno = P.Pnumber AND W.Essn = E.Ssn
    )
);

-- 3. List the names of all employees who have a dependent with the same first name as themselves.
SELECT E.Fname, E.Lname
FROM Employee E
JOIN Dependent D ON E.Ssn = D.Essn
WHERE E.Fname = D.Dependent_name;

-- 4. Find the names of employees who are directly supervised by 'Franklin Wong'.
SELECT E.Fname, E.Lname
FROM Employee E
JOIN Employee S ON E.Super_ssn = S.Ssn
WHERE S.Fname = 'Franklin' AND S.Lname = 'Wong';

-- 5. Retrieve the names of employees who do not work on any project.
SELECT E.Fname, E.Lname
FROM Employee E
LEFT JOIN Works_On W ON E.Ssn = W.Essn
WHERE W.Essn IS NULL;

-- 6. Retrieve the names and addresses of all employees who work on at least one project located in Houston but whose department has no location in Houston.
SELECT E.Fname, E.Lname, E.Address
FROM Employee E
JOIN Works_On W ON E.Ssn = W.Essn
JOIN Project P ON W.Pno = P.Pnumber
JOIN Dept_Locations DL ON E.Dno = DL.Dnumber
WHERE P.Plocation = 'Houston'
AND E.Dno NOT IN (
    SELECT DL2.Dnumber
    FROM Dept_Locations DL2
    WHERE DL2.Dlocation = 'Houston'
);

-- 7. Retrieve the last names of all department managers who have no dependents.
SELECT E.Lname
FROM Employee E
JOIN Department D ON E.Ssn = D.Mgr_ssn
LEFT JOIN Dependent Dep ON E.Ssn = Dep.Essn
WHERE Dep.Essn IS NULL;

use company;

-- 1. View with Department Name, Manager Name, and Manager Salary for Every Department
CREATE VIEW dept_manager_salary AS
SELECT 
    d.dept_name,
    e.emp_name AS manager_name,
    e.salary AS manager_salary
FROM 
    Department d
JOIN 
    Employee e ON d.manager_id = e.emp_id;

-- 2. View with Employee Name, Supervisor Name, and Employee Salary for Employees in the ‘Research’ Department
CREATE VIEW research_emp_supervisor AS
SELECT 
    e.emp_name AS employee_name,
    s.emp_name AS supervisor_name,
    e.salary AS employee_salary
FROM 
    Employee e
LEFT JOIN 
    Employee s ON e.supervisor_id = s.emp_id
JOIN 
    Department d ON e.dept_id = d.dept_id
WHERE 
    d.dept_name = 'Research';

-- 3. View with Project Name, Controlling Department Name, Number of Employees, and Total Hours Worked per Week for Each Project
CREATE VIEW project_summary AS
SELECT 
    p.proj_name,
    d.dept_name AS controlling_dept_name,
    COUNT(w.emp_id) AS num_employees,
    SUM(w.hours_per_week) AS total_hours_per_week
FROM 
    Project p
JOIN 
    Department d ON p.dept_id = d.dept_id
JOIN 
    Works_On w ON p.proj_id = w.proj_id
GROUP BY 
    p.proj_name, d.dept_name;

-- 4. View with Project Name, Controlling Department Name, Number of Employees, and Total Hours Worked per Week for Projects with More Than One Employee
CREATE VIEW project_multiple_employees AS
SELECT 
    p.proj_name,
    d.dept_name AS controlling_dept_name,
    COUNT(w.emp_id) AS num_employees,
    SUM(w.hours_per_week) AS total_hours_per_week
FROM 
    Project p
JOIN 
    Department d ON p.dept_id = d.dept_id
JOIN 
    Works_On w ON p.proj_id = w.proj_id
GROUP BY 
    p.proj_name, d.dept_name
HAVING 
    COUNT(w.emp_id) > 1;

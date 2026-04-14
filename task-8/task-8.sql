use intern;
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    department_id INT,
    salary INT,
    manager_id INT
);

INSERT INTO employees VALUES
(1, 'Alice', 101, 90000, NULL),
(2, 'Bob', 101, 60000, 1),
(3, 'Charlie', 102, 50000, 1),
(4, 'David', 101, 55000, 2),
(5, 'Eva', 102, 45000, 3),
(6, 'Frank', 103, 70000, 1),
(7, 'Grace', 103, 48000, 6);

WITH DeptAvgSalary AS (SELECT department_id,AVG(salary) AS avg_salary
FROM employees GROUP BY department_id)

SELECT * FROM DeptAvgSalary
WHERE avg_salary > 50000;

WITH RECURSIVE OrgHierarchy AS (SELECT emp_id, name, manager_id, 1 AS level
FROM employees
WHERE manager_id IS NULL
UNION ALL
SELECT e.emp_id,e.name,e.manager_id,oh.level + 1 FROM employees e
INNER JOIN OrgHierarchy oh
ON e.manager_id = oh.emp_id
)

SELECT *
FROM OrgHierarchy;

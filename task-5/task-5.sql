use intern;

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    salary INT,
    dept_id INT
);
INSERT INTO employees VALUES (1, 'Arun', 50000, 10);
INSERT INTO employees VALUES (2, 'Bala', 60000, 10);
INSERT INTO employees VALUES (3, 'Charan', 40000, 20);
INSERT INTO employees VALUES (4, 'Divya', 70000, 20);

SELECT * from employees;

-- Non-Correlated Subquery
SELECT name, salary
FROM employees
WHERE salary > (
    SELECT AVG(salary) FROM employees
);

-- Correlates Subquery

SELECT name, salary, dept_id FROM employees e1 
WHERE salary > (SELECT AVG(salary) 
FROM employees e2 WHERE e2.dept_id=e1.dept_id);

-- Subquery in SELECT (Dynamic Column)

SELECT name, salary, (SELECT AVG(salary)
FROM employees e2
WHERE e2.dept_id = e1.dept_id) AS dept_avg
FROM employees e1;
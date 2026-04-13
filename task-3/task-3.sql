CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    experience INT
);

INSERT INTO employees VALUES
(1, 'Arun', 'IT', 50000, 2),
(2, 'Bala', 'IT', 60000, 3),
(3, 'Charan', 'HR', 40000, 1),
(4, 'Divya', 'HR', 45000, 2),
(5, 'Elan', 'Finance', 70000, 5),
(6, 'Farah', 'Finance', 80000, 6),
(7, 'Gokul', 'IT', 55000, 2),
(8, 'Hema', 'HR', 42000, 1);

SELECT department, COUNT(*) AS total_employees FROM employees GROUP BY department;

SELECT department, sum(salary) AS total_salary FROM employees GROUP BY department;

SELECT department, avg(salary) AS average_salary FROM employees GROUP BY department;

SELECT department, COUNT(*) FROM employees GROUP BY department HAVING COUNT(*)>2;

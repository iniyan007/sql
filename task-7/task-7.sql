use intern;

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    salary INT
);

INSERT INTO employees (emp_id, emp_name, department, salary) VALUES
(1, 'Alice', 'HR', 50000),
(2, 'Bob', 'HR', 60000),
(3, 'Charlie', 'HR', 60000),
(4, 'David', 'IT', 70000),
(5, 'Eve', 'IT', 80000),
(6, 'Frank', 'IT', 70000),
(7, 'Grace', 'Finance', 90000),
(8, 'Hannah', 'Finance', 85000);

SELECT emp_id , emp_name, department ,salary, 
ROW_NUMBER() OVER(PARTITION BY DEPARTMENT ORDER BY SALARY DESC)
AS row_num FROM employees;

SELECT emp_id , emp_name, department ,salary, 
RANK() OVER(PARTITION BY DEPARTMENT ORDER BY SALARY DESC)
AS row_num FROM employees;

SELECT emp_id , emp_name, department ,salary, 
DENSE_RANK() OVER(PARTITION BY DEPARTMENT ORDER BY SALARY DESC)
AS row_num FROM employees;

SELECT emp_id , emp_name, department ,salary, 
LEAD(salary) OVER(PARTITION BY DEPARTMENT ORDER BY SALARY DESC)
AS next_salary FROM employees;

SELECT emp_id , emp_name, department ,salary, 
LAG(salary) OVER(PARTITION BY DEPARTMENT ORDER BY SALARY DESC)
AS previous_salary FROM employees;

SELECT emp_id , emp_name, department ,salary, 
salary - LAG(salary) OVER(PARTITION BY DEPARTMENT ORDER BY SALARY DESC)
AS salary_difference FROM employees;
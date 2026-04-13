use intern;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product VARCHAR(50),
    amount INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

INSERT INTO Customers VALUES
(1, 'Arun', 'Chennai'),
(2, 'Bala', 'Mumbai'),
(3, 'Charan', 'Delhi');
INSERT INTO Customers VALUES (4, 'Divya', 'Bangalore');
INSERT INTO Orders VALUES
(101, 1, 'Laptop', 50000),
(102, 1, 'Mouse', 500),
(103, 2, 'Keyboard', 1500),
(104, 4, 'Monitor', 7000);

SELECT * FROM Customers;
SELECT * FROM Orders;

SELECT c.name, o. product, o.amount FROM Customers as c JOIN Orders as o ON c.customer_id = o.customer_id; 

SELECT c.name, o. product, o.amount FROM Customers as c LEFT JOIN Orders as o ON c.customer_id = o.customer_id; 

SELECT c.name, o. product, o.amount FROM Customers as c RIGHT JOIN Orders as o ON c.customer_id = o.customer_id; 

SELECT c.name , SUM(o.amount) as Total_spend
FROM Customers as c 
JOIN Orders as o ON c.customer_id = o.customer_id 
GROUP BY c.name;
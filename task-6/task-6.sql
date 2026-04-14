use intern;

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    order_date DATETIME,
    amount DECIMAL(10,2)
);

INSERT INTO orders VALUES
(1, 'Arun', '2026-04-10 10:30:00', 2500.50),
(2, 'Priya', '2026-03-25 14:20:00', 1800.00),
(3, 'Rahul', '2026-03-01 09:15:00', 3200.75),
(4, 'Sneha', '2026-04-12 18:45:00', 1500.25),
(5, 'Kiran', '2026-02-28 11:10:00', 2750.00);

SELECT * FROM orders;
SELECT NOW();

SELECT order_id,customer_name,order_date,
DATEDIFF(NOW(), order_date) AS days_ago
FROM orders;

SELECT order_id, DATE_ADD(order_date, INTERVAL 7 DAY) AS delivery_date
FROM orders;

SELECT order_id, order_date, DATE_SUB(order_date, INTERVAL 10 DAY) AS sub_date
FROM orders;

SELECT * FROM orders
WHERE order_date >= DATE_SUB(NOW(), INTERVAL 30 DAY);

SELECT order_id,
YEAR(order_date) AS year,
MONTH(order_date) AS month,
DAY(order_date) AS day
FROM orders;

SELECT order_id, DATE_FORMAT(order_date, '%d-%m-%Y') AS formatted_date
FROM orders;
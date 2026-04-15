use intern;
CREATE TABLE sales (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100),
    quantity INT,
    price DECIMAL(10,2),
    sale_date DATE
);

INSERT INTO sales (product_name, quantity, price, sale_date) VALUES
('Laptop', 2, 50000, '2026-04-01'),
('Mouse', 5, 500, '2026-04-03'),
('Keyboard', 3, 1500, '2026-04-05'),
('Monitor', 1, 12000, '2026-04-10'),
('Printer', 2, 8000, '2026-04-12');

DELIMITER $$
CREATE PROCEDURE GetTotalSales(IN start_date DATE,IN end_date DATE)
BEGIN
SELECT SUM(quantity * price) AS total_sales
FROM sales
WHERE sale_date BETWEEN start_date AND end_date;
END $$
DELIMITER ;

CALL GetTotalSales('2026-04-01', '2026-04-10');

DELIMITER $$

CREATE FUNCTION CalculateDiscount(amount DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE discount DECIMAL(10,2);
    IF amount > 20000 THEN
        SET discount = amount * 0.10;
    ELSE
        SET discount = amount * 0.05;
    END IF;
    RETURN discount;
END $$
DELIMITER ;

SELECT CalculateDiscount(30000) AS discount;
SELECT CalculateDiscount(10000) AS discount;

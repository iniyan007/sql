use intern;
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) UNIQUE,
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE Categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(150) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL CHECK (stock >= 0),
    category_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50) DEFAULT 'PENDING',
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE OrderDetails (
    order_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT CHECK (quantity > 0),
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    payment_method VARCHAR(50),
    payment_status VARCHAR(50),
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

CREATE TABLE InventoryLogs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    change_amount INT,
    log_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO Categories (category_name) VALUES ('Electronics'), ('Clothing');

INSERT INTO Products (name, price, stock, category_id) VALUES
('Laptop', 60000, 10, 1),
('T-Shirt', 500, 50, 2);

INSERT INTO Customers (name, email, phone, address) VALUES
('Arun Kumar', 'arun@example.com', '9876543210', 'Chennai'),
('Priya Sharma', 'priya@example.com', '9876543211', 'Mumbai');

CREATE INDEX idx_product_name ON Products(name);
CREATE INDEX idx_order_customer ON Orders(customer_id);
CREATE INDEX idx_orderdetails_order ON OrderDetails(order_id);

DELIMITER $$
CREATE TRIGGER reduce_stock_after_order
AFTER INSERT ON OrderDetails
FOR EACH ROW
BEGIN
    UPDATE Products
    SET stock = stock - NEW.quantity
    WHERE product_id = NEW.product_id;

    INSERT INTO InventoryLogs(product_id, change_amount)
    VALUES (NEW.product_id, -NEW.quantity);
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER prevent_negative_stock
BEFORE UPDATE ON Products
FOR EACH ROW
BEGIN
    IF NEW.stock < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Stock cannot be negative';
    END IF;
END$$
DELIMITER ;

START TRANSACTION;

-- Create Order
INSERT INTO Orders (customer_id, status, total_amount)
VALUES (1, 'CONFIRMED', 60500);

SET @order_id = LAST_INSERT_ID();

-- Insert Order Details
INSERT INTO OrderDetails (order_id, product_id, quantity, price)
VALUES (@order_id, 1, 1, 60000),
       (@order_id, 2, 1, 500);

-- Payment Entry
INSERT INTO Payments (order_id, payment_method, payment_status)
VALUES (@order_id, 'UPI', 'SUCCESS');

COMMIT;

CREATE VIEW OrderSummary AS
SELECT 
    o.order_id,
    c.name AS customer_name,
    o.total_amount,
    o.status,
    o.order_date
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id;

CREATE VIEW ProductSales AS
SELECT 
    p.name,
    SUM(od.quantity) AS total_sold
FROM OrderDetails od
JOIN Products p ON od.product_id = p.product_id
GROUP BY p.name;

SELECT * FROM Products;
SELECT * FROM InventoryLogs;
SELECT * FROM OrderSummary;
SELECT * FROM ProductSales;
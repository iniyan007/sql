create database intern;
use intern;
CREATE table products (
	product_id int PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(256) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    description TEXT,
    sku VARCHAR(100) UNIQUE,
    stock_quantity INT DEFAULT 0
);

INSERT INTO products (name, price, description, sku, stock_quantity)
VALUES ("Mouse", 500, "wireless mouse", "SKU_160", 5),
("Keyboard", 3000, "mechanical keyboard", "SKU_165", 7),
("Monitor", 7500, "24-inch LED monitor", "SKU_444", 4);

SELECT * from products
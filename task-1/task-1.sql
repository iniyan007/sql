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
VALUES ("Gaming Mouse", 1200, "RGB gaming mouse", "SKU_200", 10),
("Office Keyboard", 1500, "standard keyboard", "SKU_201", 0),
("Curved Monitor", 15000, "32-inch curved monitor", "SKU_202", 2),
("USB Cable", 200, "Type-C cable", "SKU_203", 25),
("Laptop Stand", 1800, "adjustable stand", "SKU_204", 6),
("Webcam", 2500, "HD webcam", "SKU_205", 3),
("Speakers", 2200, "stereo speakers", "SKU_206", 8),
("External HDD", 6000, "1TB storage", "SKU_207", 1),
("SSD", 9000, "512GB SSD", "SKU_208", 4),
("Microphone", 3500, "USB condenser mic", "SKU_209", 0),
("Router", 2800, "WiFi router", "SKU_210", 9),
("Printer", 12000, "inkjet printer", "SKU_211", 2);

SELECT * from products
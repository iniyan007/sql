use intern;

SELECT * FROM products WHERE price < 1000;

SELECT * FROM products WHERE stock_quantity = 0;

SELECT * FROM products WHERE price > 5000 ORDER BY price DESC;

SELECT * FROM products WHERE name LIKE 'M%';

SELECT * FROM products WHERE price > 500 and price <= 2000 ORDER BY price DESC;

SELECT * FROM products WHERE (price > 500 and price <= 2000) and stock_quantity > 0 ORDER BY price DESC;
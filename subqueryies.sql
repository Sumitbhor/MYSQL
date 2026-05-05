CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL,
    city VARCHAR(30)
);

CREATE TABLE Product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL,
    price DECIMAL(10,2)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

INSERT INTO Customer VALUES
(1, 'Alice', 'New York'),
(2, 'Bob', 'Los Angeles'),
(3, 'Charlie', 'Chicago');

INSERT INTO Product VALUES
(1, 'Laptop', 1000.00),
(2, 'Smartphone', 500.00),
(3, 'Tablet', 300.00);

insert into Orders values
(1, 1, 1, 2),
(2, 1, 2, 1),
(3, 2, 1, 1),
(4, 2, 3, 3),
(5, 3, 2, 2);

SELECT customer_name
FROM Customer
WHERE customer_id IN (
    SELECT customer_id
    FROM Orders
);

SELECT customer_name
FROM Customer
WHERE customer_id NOT IN (
    SELECT customer_id
    FROM Orders
);

SELECT product_name, price
FROM Product
WHERE price = (
    SELECT MAX(price)
    FROM Product
);

SELECT product_name, price
FROM Product
WHERE price > (
    SELECT AVG(price)
    FROM Product
);

SELECT customer_name
FROM Customer
WHERE customer_id IN (
    SELECT customer_id
    FROM Orders
    WHERE product_id = 101
);

SELECT product_name, price
FROM Product
WHERE price < ALL (
    SELECT p.price
    FROM Product p
    JOIN Orders o ON p.product_id = o.product_id
    WHERE o.customer_id = 1
);

SELECT product_name
FROM Product
WHERE product_id NOT IN (
    SELECT product_id
    FROM Orders
);

SELECT customer_name
FROM Customer
WHERE city IS NULL;

SELECT product_name, price
FROM Product
WHERE price IS NOT NULL;



SELECT product_name, price
FROM Product
WHERE price > ANY (
    SELECT p.price
    FROM Product p
    JOIN Orders o ON p.product_id = o.product_id
    WHERE o.customer_id = 1
);


SELECT customer_name
FROM Customer
WHERE customer_id IN (
    SELECT customer_id
    FROM Orders
    WHERE product_id IN (
        SELECT product_id
        FROM Product
        WHERE price > 20000
    )
);

SELECT product_name, price
FROM Product
WHERE price < (
    SELECT AVG(price)
    FROM Product
);


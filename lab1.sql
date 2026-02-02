-- Use MySQL system database (optional)
USE mysql;

-- Drop database if it already exists (safe rerun)
DROP DATABASE IF EXISTS ecommerce_retail;

-- Create database
CREATE DATABASE ecommerce_retail;

-- Use the database
USE ecommerce_retail;

-------------------------------------------------
-- CUSTOMER TABLE
-------------------------------------------------
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-------------------------------------------------
-- CATEGORIES TABLE
-------------------------------------------------
CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100)
);

-------------------------------------------------
-- PRODUCTS TABLE
-------------------------------------------------
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(150),
    price DECIMAL(10,2),
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-------------------------------------------------
-- ORDERS TABLE
-------------------------------------------------
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-------------------------------------------------
-- ORDER ITEMS TABLE
-------------------------------------------------
CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-------------------------------------------------
-- CLICKS TABLE
-------------------------------------------------
CREATE TABLE clicks (
    click_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    click_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-------------------------------------------------
-- REVIEWS TABLE
-------------------------------------------------
CREATE TABLE reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    review_text TEXT,
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-------------------------------------------------
-- RECOMMENDATIONS TABLE
-------------------------------------------------
CREATE TABLE recommendations (
    recommendation_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    score DECIMAL(5,2),
    recommended_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-------------------------------------------------
-- INSERT DATA (CORRECT ORDER)
-------------------------------------------------

-- 1️⃣ Insert Categories FIRST
INSERT INTO categories (category_name)
VALUES
('Electronics'),
('Clothing'),
('Books');

-- 2️⃣ Insert Products (now category_id exists)
INSERT INTO products (product_name, price, category_id)
VALUES
('Laptop', 75000, 1),
('Headphones', 3000, 1),
('T-Shirt', 500, 2),
('Java Programming Book', 800, 3);

-- 3️⃣ Insert Customers
INSERT INTO customers (name, email)
VALUES
('Rahul Sharma', 'rahul@gmail.com'),
('Anita Verma', 'anita@gmail.com'),
('Karan Singh', 'karan@gmail.com');

-- 4️⃣ Insert Orders
INSERT INTO orders (customer_id, total_amount)
VALUES
(1, 78000),
(2, 500);

-- 5️⃣ Insert Order Items
INSERT INTO order_items (order_id, product_id, quantity, price)
VALUES
(1, 1, 1, 75000),
(1, 2, 1, 3000),
(2, 3, 1, 500);

-- 6️⃣ Insert Clicks
INSERT INTO clicks (customer_id, product_id)
VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 1);

-- 7️⃣ Insert Reviews
INSERT INTO reviews (customer_id, product_id, rating, review_text)
VALUES
(1, 1, 5, 'Excellent performance'),
(2, 3, 4, 'Good quality fabric'),
(3, 2, 3, 'Average sound quality');

-- 8️⃣ Insert Recommendations
INSERT INTO recommendations (customer_id, product_id, score)
VALUES
(1, 4, 0.92),
(2, 1, 0.85),
(3, 3, 0.78);

-------------------------------------------------
-- VERIFY DATA
-------------------------------------------------
USE ecommerce_retail;

-------------------------------------------------
-- READ OPERATIONS
-------------------------------------------------

-- View all customers
SELECT * FROM customers;

-- View products with category names
SELECT 
    p.product_name,
    p.price,
    c.category_name
FROM products p
JOIN categories c ON p.category_id = c.category_id;

-- View purchase history of customer_id = 1 (Rahul Sharma)
SELECT 
    o.order_id,
    p.product_name,
    oi.quantity,
    oi.price
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE o.customer_id = 1;

-------------------------------------------------
-- UPDATE OPERATIONS
-------------------------------------------------

-- Update Rahul's email
UPDATE customers
SET email = 'rahul.sharma@gmail.com'
WHERE customer_id = 1;

-- Increase price of Headphones
UPDATE products
SET price = 3500
WHERE product_name = 'Headphones';

-- Update review text and rating
UPDATE reviews
SET rating = 4,
    review_text = 'Good performance after long-term use'
WHERE review_id = 1;

-------------------------------------------------
-- DELETE OPERATIONS
-------------------------------------------------

-- Delete a specific review
DELETE FROM reviews
WHERE review_id = 3;

-- Delete an accidental click entry
DELETE FROM clicks
WHERE click_id = 4;

-- Delete customer with no orders (customer_id = 3)
DELETE FROM customers
WHERE customer_id = 3;




-- Use the 'test' database
USE test;

-- Show all tables in the database
SHOW TABLES;

-- Create the 'orders' table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id VARCHAR(10) NOT NULL,
    order_date DATE NOT NULL,
    delivery_time_mins INT,
    payment_method VARCHAR(20),
    city VARCHAR(50),
    order_value DECIMAL(10,2),
    status VARCHAR(20)
);

-- Insert sample records into the 'orders' table
INSERT INTO orders (order_id, customer_id, order_date, delivery_time_mins, payment_method, city, order_value, status) 
VALUES
(101, 'C001', '2025-08-01', 32, 'UPI', 'Bengaluru', 450, 'Delivered'),
(102, 'C002', '2025-08-01', 25, 'COD', 'Mumbai', 799, 'Delivered'),
(103, 'C003', '2025-08-02', 40, 'Card', 'Delhi', 1200, 'Cancelled'),
(104, 'C001', '2025-08-02', 22, 'UPI', 'Bengaluru', 350, 'Delivered'),
(105, 'C004', '2025-08-03', 55, 'UPI', 'Hyderabad', 999, 'Delivered'),
(106, 'C005', '2025-08-03', 18, 'Wallet', 'Bengaluru', 200, 'Delivered'),
(107, 'C002', '2025-08-04', 29, 'COD', 'Mumbai', 650, 'Delivered'),
(108, 'C006', '2025-08-04', 70, 'Card', 'Delhi', 1450, 'Delivered'),
(109, 'C007', '2025-08-05', 33, 'UPI', 'Chennai', 550, 'Delivered'),
(110, 'C008', '2025-08-05', 45, 'UPI', 'Bengaluru', 899, 'Cancelled');

-- Fetch all delivered orders
SELECT * FROM orders WHERE status = 'Delivered';

-- Find the total number of orders placed in Bengaluru
SELECT COUNT(*) AS total_number_of_Bengaluru 
FROM orders 
WHERE city = 'Bengaluru';

-- Get distinct payment methods used by customers
SELECT DISTINCT(payment_method) 
FROM orders;

-- Retrieve the average delivery time for all delivered orders
SELECT AVG(delivery_time_mins) AS avg_delivery_time
FROM orders
WHERE status = 'Delivered';

-- Calculate total revenue generated city-wise (only for delivered orders)
SELECT city, SUM(order_value) AS city_wise_revenue 
FROM orders 
WHERE status = 'Delivered' 
GROUP BY city;

-- Find the top 2 customers with the highest total order value
SELECT customer_id, SUM(order_value) AS total_order_value 
FROM orders 
GROUP BY customer_id 
ORDER BY total_order_value DESC 
LIMIT 2;

-- Find the percentage of cancelled orders out of total orders
SELECT (SUM(CASE WHEN status = 'Cancelled' THEN 1 ELSE 0 END) * 100 / COUNT(*)) 
       AS percentage_of_cancelled_orders
FROM orders;

-- Calculate the average order value grouped by payment method
SELECT payment_method, AVG(order_value) AS avg_order_value
FROM orders 
GROUP BY payment_method;

-- Find the repeat customers (customers with more than 1 order) and their total spend
SELECT customer_id, COUNT(order_id) AS total_orders, SUM(order_value) AS total_spend
FROM orders 
GROUP BY customer_id 
HAVING COUNT(order_id) > 1;

-- Identify the city with the fastest average delivery time
SELECT city, AVG(delivery_time_mins) AS avg_dt 
FROM orders 
WHERE status = 'Delivered' 
GROUP BY city 
ORDER BY avg_dt ASC 
LIMIT 1;

-- Identify the city with the slowest average delivery time
SELECT city, AVG(delivery_time_mins) AS avg_dt 
FROM orders 
WHERE status = 'Delivered' 
GROUP BY city 
ORDER BY avg_dt DESC 
LIMIT 1;

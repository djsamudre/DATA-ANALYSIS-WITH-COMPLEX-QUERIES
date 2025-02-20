-- Step 1: Creating the necessary tables
CREATE DATABASE SalesDB;
USE SalesDB;

-- Creating the Customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(255) NOT NULL
);

-- Creating the Products table
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(255) NOT NULL
);

-- Creating the Sales table
CREATE TABLE sales (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Creating the Sales Details table
CREATE TABLE sales_details (
    sale_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES sales(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Step 2: Inserting sample data
INSERT INTO customers (customer_name) VALUES ('Devika'), ('Ram'), ('Rohit'), ('Zoya'), ('Namrata');

-- Explicitly specifying product_id to ensure correctness
INSERT INTO products (product_id, product_name) VALUES
    (1, 'Laptop'),
    (2, 'Phone'),
    (3, 'Tablet'),
    (4, 'Headphones'),
    (5, 'Smartwatch');

INSERT INTO sales (customer_id, order_date, total_amount) VALUES
    (1, '2024-01-05', 200.00),
    (2, '2024-01-10', 450.00),
    (3, '2024-02-15', 300.00),
    (4, '2024-02-20', 150.00),
    (5, '2024-03-05', 500.00);

-- Ensuring all order_id and product_id exist before inserting
INSERT INTO sales_details (order_id, product_id, quantity) VALUES
    (1, 1, 2),
    (2, 2, 1),
    (3, 3, 3),
    (4, 4, 2),
    (5, 5, 1);

-- Step 3: Running Analysis Queries
-- Monthly Sales Trends with Joins
WITH MonthlySales AS (
    SELECT 
        DATE_FORMAT(s.order_date, '%Y-%m') AS month,
        SUM(s.total_amount) AS total_sales,
        COUNT(s.order_id) AS total_orders
    FROM sales s
    GROUP BY month
)
SELECT 
    month, 
    total_sales,
    LAG(total_sales) OVER (ORDER BY month) AS previous_month_sales,
    (total_sales - LAG(total_sales) OVER (ORDER BY month)) / NULLIF(LAG(total_sales) OVER (ORDER BY month), 0) * 100 AS sales_growth_percent
FROM MonthlySales;

-- Top 5 Customers Based on Total Spending Using Joins
SELECT ranked_customers.customer_id, ranked_customers.customer_name, ranked_customers.total_spent
FROM (
    SELECT 
        c.customer_id, 
        c.customer_name, 
        SUM(s.total_amount) AS total_spent,
        RANK() OVER (ORDER BY SUM(s.total_amount) DESC) AS rank_position
    FROM customers c
    JOIN sales s ON c.customer_id = s.customer_id
    GROUP BY c.customer_id, c.customer_name
) ranked_customers
WHERE ranked_customers.rank_position <= 5;

-- Most Popular Products Based on Sales Quantity Using Joins
SELECT 
    p.product_id, 
    p.product_name, 
    SUM(sd.quantity) AS total_sold,
    RANK() OVER (ORDER BY SUM(sd.quantity) DESC) AS popularity_rank
FROM sales_details sd
JOIN products p ON sd.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY popularity_rank;

-- Identifying Repeat Customers Using Joins
SELECT DISTINCT c.customer_id, c.customer_name
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
WHERE c.customer_id IN (
    SELECT customer_id
    FROM sales
    GROUP BY customer_id
    HAVING COUNT(order_id) > 1
);

-- Average Order Value Per Customer Using Joins and CTEs
WITH CustomerOrderValue AS (
    SELECT 
        c.customer_id, 
        c.customer_name,
        SUM(s.total_amount) / COUNT(s.order_id) AS avg_order_value
    FROM customers c
    JOIN sales s ON c.customer_id = s.customer_id
    GROUP BY c.customer_id, c.customer_name
)
SELECT customer_id, customer_name, avg_order_value
FROM CustomerOrderValue
ORDER BY avg_order_value DESC;

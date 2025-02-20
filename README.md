# DATA-ANALYSIS-WITH-COMPLEX-QUERIES

*COMPANY*: CODTECH IT SOLUTIONS

*NAME:  Devika Jeevan Samudre

*INTERN ID* : CT08NIB

*DOMAIN*: SQL

*DURATION*: 4 WEEKS

*MENTOR* : NEELA SANTOSH

*DESCRIPTION OF TASK*:

Objective
The goal of this task is to analyze sales data using advanced SQL techniques such as window functions, subqueries, and common table expressions (CTEs). The analysis aims to extract valuable business insights, including monthly sales trends, customer spending patterns, popular products, and repeat customers. These insights will help in understanding sales performance, customer behavior, and product demand, leading to informed decision-making.

To achieve this, a relational database named SalesDB is designed, consisting of four interconnected tables:

Customers – Stores customer details.
Products – Contains product information.
Sales – Records purchase transactions.
Sales Details – Maintains details of each product sold in a transaction.
Once the database is set up, complex SQL queries are executed to generate reports highlighting various trends and patterns.

Approach and Methodology
1. Database and Table Creation
The first step in this task is to create the necessary database and tables in MySQL. The database SalesDB is structured to support efficient data retrieval and analysis.

The Customers table includes a unique customer_id and the customer's name.
The Products table consists of product_id and product name to identify available items.
The Sales table records each transaction with details such as customer_id, order_date, and total_amount. A foreign key constraint ensures that customer details in sales transactions reference existing customers.
The Sales Details table maintains records of products purchased in each transaction, linking order_id from the Sales table with product_id from the Products table. This structure ensures that data remains consistent and properly linked.
2. Data Insertion
After setting up the tables, sample data is inserted to simulate real-world transactions. The dataset includes multiple customers, a variety of products, and different sales transactions. This provides realistic data for conducting analysis using SQL queries.

3. Advanced Data Analysis Using SQL Queries
Once the database is populated, complex SQL queries are executed to generate meaningful insights. The following analysis techniques are used:

A. Monthly Sales Trends (Using CTEs and Window Functions)
To understand sales performance over time, a Common Table Expression (CTE) is used to group sales by month.

SUM() function calculates the total sales for each month.
LAG() window function retrieves the previous month's sales to compare growth.
A percentage increase or decrease is calculated to determine sales trends over time.
This analysis helps businesses identify peak sales months and plan inventory accordingly.

B. Identifying Top 5 Customers (Using Ranking Functions)
A subquery is used to rank customers based on their total spending.

SUM() function aggregates total spending per customer.
RANK() OVER (ORDER BY total_spent DESC) ranks customers based on the highest purchases.
The TOP 5 customers are extracted to identify the most valuable customers.
This insight is valuable for businesses to implement loyalty programs and targeted marketing campaigns.

C. Most Popular Products (Using Ranking and Aggregation)
To identify the best-selling products:

The sales_details table is queried to sum up product sales.
The RANK() function ranks products based on sales volume.
The final result shows the most popular products based on total quantity sold.
This data can be used for inventory management and promotional strategies.

D. Identifying Repeat Customers (Using Subqueries)
A subquery is used to filter customers who have made more than one purchase.

The HAVING COUNT(order_id) > 1 condition ensures only repeat customers are selected.
Businesses can use this information to offer personalized discounts and retain loyal customers.

E. Average Order Value Per Customer (Using CTEs and Joins)
To evaluate customer spending habits:

A CTE groups customer purchases and calculates their average order value.
SUM(total_amount) / COUNT(order_id) determines the average purchase amount per customer.
The result is sorted in descending order to identify high-value customers.
This analysis helps businesses understand purchasing behavior and adjust pricing strategies.

Deliverables
A Structured Database – A well-organized MySQL database with properly linked tables.
Complex SQL Queries – Queries that analyze sales data using CTEs, window functions, and subqueries.
A Report Showcasing Trends – Insights extracted from SQL queries, such as:
Sales growth trends over time.
Top 5 highest-spending customers.
Most popular products based on sales volume.
List of repeat customers.
Average order value per customer.
By implementing advanced SQL techniques, businesses can effectively track performance, optimize marketing efforts, and improve customer retention. The insights gained from these queries allow for data-driven decision-making and better resource allocation.


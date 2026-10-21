-- Module 9 Assignment: Advanced SQL Queries for Data Analysis and Dashboards
-- Database: module9_sql

-- Step 1: Project Setup
CREATE DATABASE module9_sql;

USE module9_sql;

CREATE TABLE Customers (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(100),
    City VARCHAR(100)
);

CREATE TABLE Orders (
    Order_ID INT PRIMARY KEY,
    Customer_ID INT,
    Product VARCHAR(100),
    Quantity INT,
    Price DECIMAL(10,2)
);

INSERT INTO Customers (Customer_ID, Customer_Name, City)
VALUES
(1, 'Rahim Ahmed', 'Dhaka'),
(2, 'Karim Hasan', 'Chittagong'),
(3, 'Nusrat Jahan', 'Dhaka'),
(4, 'Sadia Islam', 'Khulna'),
(5, 'Tanvir Hossain', 'Rajshahi'),
(6, 'Mim Akter', 'Sylhet'),
(7, 'Fahim Rahman', 'Comilla'),
(8, 'Jannatul Ferdous', 'Barisal'),
(9, 'Sakib Khan', 'Rangpur'),
(10, 'Rafiul Islam', 'Jashore');

INSERT INTO Orders (Order_ID, Customer_ID, Product, Quantity, Price)
VALUES
(101, 1, 'Laptop', 1, 65000),
(102, 1, 'Mouse', 2, 1200),
(103, 2, 'Smartphone', 2, 30000),
(104, 3, 'Monitor', 2, 18000),
(105, 3, 'Keyboard', 1, 2500),
(106, 4, 'Laptop', 2, 65000),
(107, 4, 'Headphones', 3, 4500),
(108, 5, 'Printer', 2, 15000),
(109, 5, 'Mouse', 4, 1200),
(110, 6, 'Smartphone', 1, 30000),
(111, 6, 'Monitor', 1, 18000),
(112, 7, 'Laptop', 1, 65000),
(113, 7, 'Keyboard', 3, 2500),
(114, 8, 'Headphones', 2, 4500),
(115, 8, 'Printer', 2, 15000),
(116, 2, 'Smartphone', 3, 30000),
(117, 3, 'Mouse', 1, 1200),
(118, 4, 'Monitor', 3, 18000),
(119, 5, 'Laptop', 1, 65000),
(120, 2, 'Headphones', 1, 4500),
(121, 1, 'Keyboard', 2, 2500),
(122, 6, 'Printer', 1, 15000);


-- Step 2: INNER JOIN
SELECT c.Customer_Name, c.City, o.Product, o.Quantity, o.Price
FROM Customers c
INNER JOIN Orders o
    ON c.Customer_ID = o.Customer_ID;


-- Step 3: LEFT JOIN
SELECT c.Customer_ID, c.Customer_Name, c.City,
       o.Order_ID, o.Product, o.Quantity, o.Price
FROM Customers c
LEFT JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
ORDER BY c.Customer_ID;


-- Step 4: Product-wise Sales Analysis
SELECT Product, SUM(Quantity * Price) AS Total_Sales
FROM Orders
GROUP BY Product
ORDER BY Total_Sales DESC;


-- Step 5: Product-wise Quantity Analysis
SELECT Product, SUM(Quantity) AS Total_Quantity
FROM Orders
GROUP BY Product;


-- Step 6: Filter Grouped Results (GROUP BY + HAVING)
SELECT Product, SUM(Quantity * Price) AS Total_Sales
FROM Orders
GROUP BY Product
HAVING SUM(Quantity * Price) > 100000;


-- Step 7: Customer-wise Sales Analysis
SELECT c.Customer_Name, SUM(o.Quantity * o.Price) AS Total_Sales
FROM Customers c
JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Customer_Name
ORDER BY Total_Sales DESC;


-- Step 8: Subquery Practice (average of customer totals, then customers above it)
SELECT AVG(customer_total)
FROM (
    SELECT SUM(Quantity * Price) AS customer_total
    FROM Orders
    GROUP BY Customer_ID
) AS totals;

SELECT c.Customer_Name, SUM(o.Quantity * o.Price) AS Total_Sales
FROM Customers c
JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Customer_Name
HAVING SUM(o.Quantity * o.Price) > (
    SELECT AVG(customer_total)
    FROM (
        SELECT SUM(Quantity * Price) AS customer_total
        FROM Orders
        GROUP BY Customer_ID
    ) AS totals
)
ORDER BY Total_Sales DESC;


-- Step 9: Final SQL Query
SELECT c.Customer_Name, o.Product, SUM(o.Quantity * o.Price) AS Total_Sales
FROM Customers c
JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Customer_Name, o.Product
ORDER BY Total_Sales DESC;

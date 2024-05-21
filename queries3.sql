# Selecting the database
USE masai;

# Join()
SELECT b.CustomerID, FirstName, LastName, MAX(OrderDate) AS Recent_Order_Date
FROM Orders AS a
JOIN Customers AS b
ON a.CustomerID = b.CustomerID
GROUP BY b.CustomerID, FirstName, LastName
ORDER BY b.CustomerID;

# Self Join Example 1
SELECT a.FirstName AS Customer_A_First_Name, 
a.LastName AS Customer_A_Last_Name,
b.FirstName AS Customer_B_First_Name, 
b.LastName AS Customer_B_Last_Name,
a.city AS City_of_Customer_A,
b.city AS City_of_Customer_B
FROM Customers AS a
JOIN Customers AS b
ON a.city = b.city
WHERE a.FirstName <> b.FirstName OR a.LastName <> b.LastName;

# Self Join Example 2
SELECT a.FirstName AS Customer_A_First_Name, 
a.LastName AS Customer_A_Last_Name,
b.FirstName AS Customer_B_First_Name, 
b.LastName AS Customer_B_Last_Name,
a.city AS City_of_Customer_A,
b.city AS City_of_Customer_B
FROM Customers AS a
JOIN Customers AS b
ON a.city = b.city
WHERE a.FirstName <> b.FirstName OR a.LastName <> b.LastName
AND a.city IN ('New York', 'Dublin');

# Homework -> Find the employee example discussed on internet and solve it

# Common Table Expressions
SELECT * FROM Orders;
SELECT * FROM Payments;
SELECT * FROM Customers;

# Get the OrderID, FirstName, LastName, PaymentID, CustomerID, Total_Order_Amount
# and the Payment Type
# Tables - Customers, Orders, Payments

SELECT a.OrderID, c.FirstName, c.LastName, b.PaymentID,
a.CustomerID, Total_Order_Amount, b.PaymentType
FROM Orders AS a
JOIN Payments AS b
ON a.PaymentID = b.PaymentID
JOIN Customers AS c 
ON a.CustomerID = c.CustomerID;

# CTE 
WITH Order_Payments_Info AS (
SELECT a.OrderID, b.PaymentID, a.CustomerID, 
Total_Order_Amount, b.PaymentType
FROM Orders AS a
JOIN Payments AS b 
ON a.PaymentID = b.PaymentID
)

SELECT d.*, e.FirstName, e.LastName
FROM Customers AS e 
JOIN Order_Payments_Info AS d
ON e.CustomerID = d.CustomerID;

# Benefits of CTE -> Complex Problems, Easy to integrate, Memory Efficient

# Examples of CTE
# Question 1 - Calculate the total amount spent by each customer on orders

WITH CustomerSpending AS (
	SELECT CustomerID, SUM(Total_Order_Amount) AS Total_Spent
    FROM Orders
    GROUP BY CustomerID
    )
SELECT c.FirstName, c.LastName, cs.Total_Spent
FROM Customers AS c
JOIN CustomerSpending AS cs 
ON c.CustomerID = cs.CustomerID;
    
# Question 2 - Find all products that have never been ordered 
# and are from inactive categories

WITH InactiveCategories AS (
	SELECT CategoryID
    FROM Category 
    WHERE Active = 'No'
    ),
    
UnorderedProducts AS (
	SELECT ProductID
    FROM Products 
    WHERE ProductID NOT IN 
		(
        SELECT ProductID
        FROM OrderDetails
        )
	)

SELECT p.ProductID, p.Product
FROM Products AS p 
JOIN InactiveCategories AS ic 
ON p.Category_ID = ic.CategoryID
JOIN UnorderedProducts AS up 
ON p.ProductID = up.ProductID;

# Views -> Virtual Table

# Query to get weekend orders
SELECT *, DAYNAME(OrderDate) AS Week_Day
FROM Orders
WHERE DAYNAME(OrderDate) IN ('Saturday', 'Sunday');

# Creating a View 
CREATE VIEW weekend_orders AS 
SELECT *, DAYNAME(OrderDate) AS Week_Day
FROM Orders
WHERE DAYNAME(OrderDate) IN ('Saturday', 'Sunday');

# A table is treated like a normal table.

# Getting the total data
SELECT * 
FROM weekend_orders;

# Filtering data in a view
SELECT * 
FROM weekend_orders
WHERE PaymentID = 2;

# Altering the view
ALTER VIEW weekend_orders AS 
SELECT *, DAYNAME(OrderDate) AS Week_Day
FROM Orders
WHERE DAYNAME(OrderDate) IN ('Saturday', 'Sunday')
AND Total_Order_Amount > 20000;

# Getting the total data
SELECT * 
FROM weekend_orders;

# Renaming a view
RENAME TABLE weekend_orders
TO newView;

# Getting the total data
SELECT * 
FROM newView;

# Dropping a view 
DROP VIEW newView;

# Practice Problem (CTE) - 
# List the average market price of products supplied by each supplier

WITH SupplierProducts AS (
	SELECT s.SupplierID, p.ProductID, p.Market_Price
    FROM Suppliers AS s
    JOIN orderdetails AS od 
    ON s.SupplierID = od.SupplierID
    JOIN Products AS p 
    ON p.ProductID = od.ProductID
    )
    
SELECT sp.SupplierID, AVG(sp.Market_Price) AS Average_Market_Price
FROM SupplierProducts AS sp
GROUP BY sp.SupplierID
ORDER BY sp.SupplierID;

# Homewok - 
# Get the details of the latest order for each customer (CTE)




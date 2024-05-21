# Selecting the database
USE masai;

# Getting the country wise count of customers
SELECT Country, COUNT(*) AS Number_of_Customers
FROM Customers
GROUP BY Country
ORDER BY Country;

# Getting an idea about the customers table 
SELECT * 
FROM Customers;

# Window Functions
SELECT *, COUNT(*) OVER(PARTITION BY Country) AS Number_of_People
FROM Customers;

SELECT *, COUNT(*) OVER() AS Number_of_People
FROM Customers;

# Getting an idea about orders table
SELECT * 
FROM Orders;

# Question - Get all the columns from orders table 
# and a new column giving the number of orders made by every customer
SELECT *, COUNT(*) OVER(PARTITION BY CustomerID) AS Number_of_Orders
FROM Orders;

# Question - Get all the columns from orders table 
# and a new column giving the the first order date for every customer
SELECT *, MIN(OrderDate) OVER(PARTITION BY CustomerID) AS First_Order_Date
FROM Orders;

# Mixing subqueries with window functions
SELECT * 
FROM (
	SELECT *,
    MIN(OrderDate) OVER(PARTITION BY CustomerID) AS First_Order_Date
	FROM Orders
    ) AS c;

SELECT CustomerID, OrderDate, COUNT(*) AS Number_of_Orders_on_First_Day
FROM (
	SELECT * 
	FROM (
		SELECT *,
		MIN(OrderDate) OVER(PARTITION BY CustomerID) AS First_Order_Date
		FROM Orders
		) AS c
	WHERE OrderDate = First_Order_Date
    ) AS d
GROUP BY CustomerID, OrderDate
ORDER BY Number_of_Orders_on_First_Day DESC;

# Rank() Function 
# Ranking the orders of every customer by the descending amount of order total
SELECT *,
RANK() OVER (PARTITION BY CustomerID ORDER BY Total_Order_Amount DESC) AS rank_
FROM Orders;

SELECT *,
RANK() OVER (PARTITION BY CustomerID ORDER BY Total_Order_Amount) AS rank_
FROM Orders;

SELECT *,
RANK() OVER (PARTITION BY CustomerID ORDER BY Total_Order_Amount ASC) AS rank_
FROM Orders;

# Ranking the orders by the descending amount of order total
SELECT *,
RANK() OVER (ORDER BY Total_Order_Amount DESC) AS rank_
FROM Orders;

# Getting the highest order total of every customer
SELECT * 
FROM (
	SELECT *,
	RANK() OVER (PARTITION BY CustomerID ORDER BY Total_Order_Amount DESC) AS rank_
	FROM Orders
	) AS f
WHERE f.rank_ = 1;

# Dense_Rank() Function 
SELECT *,
DENSE_RANK() OVER (PARTITION BY CustomerID ORDER BY Total_Order_Amount DESC) AS dense_rank_
FROM Orders;

SELECT *,
DENSE_RANK() OVER (PARTITION BY CustomerID ORDER BY Total_Order_Amount) AS dense_rank_
FROM Orders;

SELECT *,
DENSE_RANK() OVER (PARTITION BY CustomerID ORDER BY Total_Order_Amount ASC) AS dense_rank_
FROM Orders;

# ROW_NUMBER()
SELECT *,
ROW_NUMBER() OVER (ORDER BY DateEntered DESC) AS serial_number
FROM Customers;

# Generally is used to populate the index column. 

# Practice Problems 
# Find the 5 most recent orders details for each customer
SELECT *
FROM (
	SELECT *,
	ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY OrderDate DESC) AS Sequence
	FROM Orders
    ) AS c
HAVING c.Sequence <= 5;

# Rank the products based on the number of times they have been ordered
# All the Details of Orderdetails table required
# Table -> OrderDetails
SELECT ProductID, 
SUM(Quantity) AS TotalQuantity,
RANK() OVER (ORDER BY SUM(Quantity) DESC) AS Rank_
FROM OrderDetails
GROUP BY ProductID;

# Get the dense rank of categories based on the number of products they have
SELECT Category_ID, 
COUNT(ProductID) AS Product_Count,
DENSE_RANK() OVER (ORDER BY COUNT(ProductID) DESC) AS Dense_Rank_
FROM Products
GROUP BY Category_ID;





# Selecting the database
USE masai;

# CTE Problem Statement
# Find all the products that have never been ordered
# and are from inactive categories
# Tables -> Category, Products, OrderDetails

SELECT * 
FROM Category;

SELECT * 
FROM Products;

SELECT * 
FROM OrderDetails;

WITH InactiveCategories AS (
	SELECT CategoryID
    FROM Category 
    WHERE Active LIKE '%No%'
    ),
    UnorderedProducts AS (
    SELECT ProductID
    FROM Products
    WHERE ProductID NOT IN (
		SELECT ProductID
        FROM OrderDetails 
        )
	)
SELECT p.ProductID, p.Product
FROM Products AS p
JOIN InactiveCategories AS ic
ON p.Category_ID = ic.CategoryID
JOIN UnorderedProducts AS up
ON up.ProductID = p.ProductID;

# List the average market price of products supoplied by each supplier
# Tables - Suppliers, Products

WITH SuppliersProducts AS (
	SELECT s.SupplierID, p.ProductID, p.Market_Price
    FROM Suppliers AS s
    JOIN OrderDetails AS od
    ON s.SupplierID = od.SupplierID
    JOIN Products AS p 
    ON od.ProductID = p.ProductID
    )
SELECT sp.SupplierID, AVG(sp.Market_Price) AS Avg_Market_Price
FROM SuppliersProducts AS sp
GROUP BY sp.SupplierID
ORDER BY sp.SupplierID;

# This problem can also be solved by Window Fucntions

# General Problems -
# Get the sum of quantity shipped by each shipper
# in each quarter of each year
# Tables -> Orders, OrderDetails, Shippers

SELECT YEAR(ShipDate) AS Year, QUARTER(ShipDate) AS Quarter,
b.ShipperID, SUM(Quantity) AS Total_Quantity 
FROM Orders AS a
JOIN Shippers AS b
ON a.ShipperID = b.ShipperID
JOIN OrderDetails AS c 
ON a.orderid = c.OrderID
GROUP BY YEAR(ShipDate), QUARTER(ShipDate), b.ShipperID
ORDER BY YEAR(ShipDate), QUARTER(ShipDate), b.ShipperID;

# Pivoting Shipper ID
WITH cte AS (
	SELECT YEAR(ShipDate) AS Year, QUARTER(ShipDate) AS Quarter,
	b.ShipperID, SUM(Quantity) AS Total_Quantity 
	FROM Orders AS a
	JOIN Shippers AS b
	ON a.ShipperID = b.ShipperID
	JOIN OrderDetails AS c 
	ON a.orderid = c.OrderID
	GROUP BY YEAR(ShipDate), QUARTER(ShipDate), b.ShipperID
	ORDER BY YEAR(ShipDate), QUARTER(ShipDate), b.ShipperID
)

SELECT Year, Quarter, 
(CASE WHEN ShipperID = 1 THEN Total_Quantity END) AS 'Shipper_ID_1',
(CASE WHEN ShipperID = 2 THEN Total_Quantity END) AS 'Shipper_ID_2',
(CASE WHEN ShipperID = 3 THEN Total_Quantity END) AS 'Shipper_ID_3',
(CASE WHEN ShipperID = 4 THEN Total_Quantity END) AS 'Shipper_ID_4',
(CASE WHEN ShipperID = 5 THEN Total_Quantity END) AS 'Shipper_ID_5',
(CASE WHEN ShipperID = 6 THEN Total_Quantity END) AS 'Shipper_ID_6',
(CASE WHEN ShipperID = 7 THEN Total_Quantity END) AS 'Shipper_ID_7',
(CASE WHEN ShipperID = 8 THEN Total_Quantity END) AS 'Shipper_ID_8'
FROM cte;

# Pivoting Shipper ID
WITH cte AS (
	SELECT YEAR(ShipDate) AS Year, QUARTER(ShipDate) AS Quarter,
	b.ShipperID, SUM(Quantity) AS Total_Quantity 
	FROM Orders AS a
	JOIN Shippers AS b
	ON a.ShipperID = b.ShipperID
	JOIN OrderDetails AS c 
	ON a.orderid = c.OrderID
	GROUP BY YEAR(ShipDate), QUARTER(ShipDate), b.ShipperID
	ORDER BY YEAR(ShipDate), QUARTER(ShipDate), b.ShipperID
)

SELECT Year, Quarter, 
SUM(CASE WHEN ShipperID = 1 THEN Total_Quantity END) AS 'Shipper_ID_1',
SUM(CASE WHEN ShipperID = 2 THEN Total_Quantity END) AS 'Shipper_ID_2',
SUM(CASE WHEN ShipperID = 3 THEN Total_Quantity END) AS 'Shipper_ID_3',
SUM(CASE WHEN ShipperID = 4 THEN Total_Quantity END) AS 'Shipper_ID_4',
SUM(CASE WHEN ShipperID = 5 THEN Total_Quantity END) AS 'Shipper_ID_5',
SUM(CASE WHEN ShipperID = 6 THEN Total_Quantity END) AS 'Shipper_ID_6',
SUM(CASE WHEN ShipperID = 7 THEN Total_Quantity END) AS 'Shipper_ID_7',
SUM(CASE WHEN ShipperID = 8 THEN Total_Quantity END) AS 'Shipper_ID_8'
FROM cte
GROUP BY Year, Quarter;

# Practice Problems 

# Question 1 - 
# Print Customer Id, Full Name(FirstName LastName), Postal Code
# Sort the output in decreasing order Customer Id.
SELECT CustomerID, CONCAT(FirstName, ' ', LastName) AS Full_Name, PostalCode
FROM Customers
ORDER BY CustomerID DESC;

# Question 2 - 
# Get the Description of customer along with the Customerid and Domain of their email
# For customer with no lastname take "Web" as their last name.

# The Final output should contain this columns Customerid, Domain of their email, Description.
# Get the details of description from the below attached sample output Description_column.
# Sort the result by DateEntered desc, if date entered is same then CustomerId in ascending.

# Description Sample -
# Malcom Julian was born on 8th March 1985 has ordered 12 orders yet.

# Note- All letters are case sensetive take same case letters as given in sample output Description_. 
# Every Day value will have 'th' in front of it.

# Tables -> Customers, Orders

SELECT c.CustomerID, RIGHT(email, LENGTH(email) - POSITION('@' IN email)) AS Domain,
CONCAT(FirstName, ' ', COALESCE(LastName, 'Web'), ' was born on ', DAY(Date_of_Birth), 'th ',
MONTHNAME(Date_of_Birth), ' ', YEAR(Date_of_Birth), ' has ordered ', COUNT(DISTINCT o.OrderID), 
' orders yet.') AS Description_
FROM Customers AS c
JOIN Orders AS o
ON c.CustomerID = o.CustomerID 
GROUP BY c.CustomerID, RIGHT(email, LENGTH(email) - POSITION('@' IN email))
ORDER BY DateEntered DESC, CustomerID ASC;

# Question 3 - 
# The company wants to see if the shippers are delivering the orders on weekends or not.
# So for that, they want to see the number of orders delivered on a particular Saturday and Sunday.
# Print DayName, count of orders delivered on that day in the descending order of count of orders.
SELECT DAYNAME(DeliveryDate) AS Day_Name, COUNT(*) AS Number_of_Orders
FROM Orders
GROUP BY DAYNAME(DeliveryDate)
HAVING Day_Name IN ('Saturday', 'Sunday')
ORDER BY Number_of_Orders DESC;

# Question 4 - 
# Print ProductId, ProductName, Sub-Category for of those Products 
# which are having no Sub Category 
# and fill 'No_sub_category' in that place.
# Sort the order in ascending order of ProductId.

SELECT ProductID, Product, 
COALESCE(Sub_Category, 'No_Sub_Category') AS Sub_Category
FROM Products
WHERE Sub_Category IS NULL
ORDER BY ProductID;

# Question 5 - 
# Write a query to find the average revenue for each order whose difference between 
# the order date and ship date is 3.
# Use the total order amount to calculate the revenue. 
# Print the order ID, customer ID, average revenue, 
# and sort them in increasing order of the order ID.
SELECT OrderID, CustomerID, AVG(Total_Order_Amount) AS Avg_Total_Order_Amount
FROM Orders
WHERE DATEDIFF(ShipDate, OrderDate) = 3
GROUP BY OrderID, CustomerID
ORDER BY OrderID;


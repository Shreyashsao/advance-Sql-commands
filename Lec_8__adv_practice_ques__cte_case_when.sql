# Selecting the database
USE masai;

# Question 6 - (Common Table Expression)
# A Customers who born earlier than or 1980 (included) they known as Gen X, 
# a customers who born between 1981 and 1996 both included they known as Millennials 
# and Customers who born after 1996 they known as Gen Z . 
# Print all these generations name and total discounts avail by them 
# and sort the table on generation name. 
# Discount meaning here price difference between sell price and market price.

# Tables needed - orderdetails, orders, customers, products
WITH CTE1 AS (
	SELECT CustomerID, Quantity*(Market_Price - Sale_Price) AS Total_Discount
    FROM Orderdetails
    INNER JOIN Products
    ON Orderdetails.ProductID = Products.ProductID
    INNER JOIN Orders
    ON Orders.OrderID = Orderdetails.OrderID
    ),
CTE2 AS (
	SELECT CTE1.CustomerID, Total_Discount,
    CASE 
		WHEN YEAR(Date_of_Birth) <= 1980 THEN 'Gen_X'
        WHEN YEAR(Date_of_Birth) BETWEEN 1981 AND 1996 THEN 'Millenials'
        ELSE 'Gen_Z'
        END AS Gen
	FROM CTE1
	INNER JOIN Customers
	ON CTE1.CustomerID = Customers.CustomerID
	)
SELECT Gen, SUM(Total_Discount) AS Sum_Total_Discount
FROM CTE2
GROUP BY Gen
ORDER BY Sum_Total_Discount DESC;

# Question 7 - 
# List the average market price of products supplied by each supplier
# Use CTE

# Getting an idea about the tables
SELECT * 
FROM Suppliers;

SELECT * 
FROM Products;

SELECT * 
FROM OrderDetails;

WITH SupplierProducts AS (
	SELECT s.SupplierID, p.ProductID, p.Market_Price
    FROM OrderDetails AS od
    JOIN Products AS p
    ON od.ProductID = p.ProductID
    JOIN Suppliers AS s
    ON s.SupplierID = od.SupplierID
	)
SELECT sp.SupplierID, ROUND(AVG(sp.Market_Price), 2) AS Avg_Market_Price
FROM SupplierProducts AS sp
GROUP BY sp.SupplierID
ORDER BY sp.SupplierID;

# Question 8 - 
# Get the details of the latest order for each customer
# Use CTE with Window Fuctions

WITH LatestOrders AS (
	SELECT CustomerID, OrderID, OrderDate, 
    RANK() OVER (PARTITION BY CustomerID ORDER BY OrderDate DESC) AS rank_
    FROM Orders
    )
SELECT lo.CustomerID, lo.OrderID, lo.OrderDate
FROM LatestOrders AS lo
WHERE lo.rank_ = 1;

# Question 9 -
# Count the number of Suppliers based out of each Country.
# Print the following sentence:
# For Example : if the number of suppliers are more than 1 then print 
# 'There are 100 Suppliers from France' 
# else print 'There is 1 Supplier from France'
# Order the output in ascending order of country.
# Note: All characters are case sensitive.

SELECT CONCAT('There ',
			  CASE WHEN COUNT(*) = 1 THEN 'is ' ELSE 'are ' END, COUNT(*),
              CASE WHEN COUNT(*) = 1 THEN ' supplier ' ELSE ' suppliers ' END,
              'from ', Country) AS Supplier_Details
FROM Suppliers
GROUP BY Country
ORDER BY Country;

# Question 10 - (Common Table Expressions)
# The stakeholders want to know 
# the average number of days a customer takes to order for the year 2021.
# In here, if customer ordered multiple times in a single day 
# then that date will be counted only once 
# and next order will be considered for the next unique day customer ordered.
# If the decimal value(.07 in 65.07) in the avg number of days 
# is above 0.5 then get the ceil of the average, 
# if it is below 0.5 (included), then get the floor of the value.

# Print Customer Id, First Name, Last Name, Average number of days they take to order.
# Sort the output in ascending order of Customer Id.

WITH CTE AS (
	SELECT DISTINCT CustomerID,
    DATEDIFF(OrderDate, LAG(OrderDate) OVER (PARTITION BY CustomerID ORDER BY OrderDate )) AS Days
    FROM Orders
    WHERE YEAR(OrderDate) = 2021
    )
SELECT c.CustomerID, FirstName, LastName,
CASE WHEN AVG(Days) - FLOOR(AVG(Days)) > 0.5 THEN CEIL(AVG(Days))
ELSE FLOOR(AVG(Days))
END AS Avg_days
FROM CTE
JOIN Customers AS c
ON c.CustomerID = cte.CustomerID
GROUP BY c.CustomerID, FirstName, LastName
ORDER BY c.CustomerID;












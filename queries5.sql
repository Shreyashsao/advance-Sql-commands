# Selecting the database
USE masai;

# Getting an idea about Students table 
SELECT * 
FROM Students;

# NTILE -> after sorting/ordering the data,
# if we want to create groups/buckets

SELECT COUNT(*) AS Numb
FROM Students;

# Creating 2 groups based on marks
SELECT *, NTILE(2) OVER(ORDER BY Marks DESC) AS Bucket_Number
FROM Students;

# Creating 3 groups based on marks
SELECT *, NTILE(3) OVER(ORDER BY Marks DESC) AS Bucket_Number
FROM Students;

# If the total number of data points is not divisible by the number of groups
# first group will have higher number of data points
# followed by second, followed by third and so on

# Creating 2 groups based on marks for every class
SELECT *, NTILE(2) OVER(PARTITION BY Class ORDER BY Marks DESC) AS Bucket_Number
FROM Students;

# Getting an idea about the year sales data
SELECT * 
FROM YearSales;

# LEAD() & LAG()
SELECT *, LAG(Sales) OVER (ORDER BY Year, Quarter) AS Previous_Sales
FROM YearSales;

SELECT *, 
LAG(Sales) OVER (PARTITION BY Year ORDER BY Year, Quarter) AS Previous_Sales
FROM YearSales;

SELECT *, LEAD(Sales) OVER (ORDER BY Year, Quarter) AS Next_Sales
FROM YearSales;

SELECT *, 
LEAD(Sales) OVER (PARTITION BY Year ORDER BY Year, Quarter) AS Next_Sales
FROM YearSales;

# Modifying the spacing and null entry
SELECT *, 
LAG(Sales, 1, 100) OVER (PARTITION BY Year ORDER BY Year, Quarter) 
AS Previous_Sales
FROM YearSales;

# 1 -> Spacing Interval
# 100 -> Value to replace null entry

SELECT *, 
LAG(Sales, 2, 0) OVER (ORDER BY Year, Quarter) AS Previous_Sales
FROM YearSales;

SELECT *, 
LEAD(Sales, 2, 0) OVER (ORDER BY Year, Quarter) AS Next_Sales
FROM YearSales;

# Aggregation Functions
SELECT * 
FROM Sales;

# Query 
SELECT *, SUM(Sales) OVER() AS total_sales
FROM Sales;

SELECT MONTHNAME(Month_) AS Month, Sales,
SUM(Sales) OVER (ORDER BY Month_) AS cum_sum
FROM Sales;

# Question - Get the details of the orders along with the total amount
# that every customer has spent till the given order date
SELECT *, 
SUM(Total_Order_Amount) OVER(PARTITION BY CustomerID ORDER BY OrderDate)
AS cum_sales_for_each_customer
FROM Orders;

# AVG()
SELECT MONTHNAME(Month_) AS Month, Sales,
AVG(Sales) OVER (ORDER BY Month_) AS Avg_Sales
FROM Sales;

SELECT *, 
AVG(Total_Order_Amount) OVER(PARTITION BY CustomerID ORDER BY OrderDate)
AS avg_sales_for_each_customer
FROM Orders;

# 3 months rolling sum 
SELECT MONTHNAME(Month_) AS Month_Name, Sales,
SUM(Sales) OVER (ORDER BY Month_ ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) 
AS '3_Month_Rolling_Sum'
FROM Sales;

# 3 months rolling sum 
SELECT MONTHNAME(Month_) AS Month_Name, Sales,
SUM(Sales) OVER (ORDER BY Month_ ROWS 2 PRECEDING) 
AS '3_Month_Rolling_Sum'
FROM Sales;

# 3 months rolling sum 
SELECT MONTHNAME(Month_) AS Month_Name, Sales,
SUM(Sales) OVER (ORDER BY Month_ ROWS BETWEEN 1 FOLLOWING AND 3 FOLLOWING) 
AS '3_Month_Rolling_Sum'
FROM Sales;

# 3 months rolling sum 
SELECT MONTHNAME(Month_) AS Month_Name, Sales,
AVG(Sales) OVER (ORDER BY Month_ ROWS BETWEEN 1 FOLLOWING AND 3 FOLLOWING) 
AS '3_Month_Rolling_Avg'
FROM Sales;

# 3 months rolling sum 
SELECT MONTHNAME(Month_) AS Month_Name, Sales,
SUM(Sales) OVER (ORDER BY Month_ ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) 
AS '3_Month_Rolling_Sum'
FROM Sales;

# Reverse Cumulative Sum 
SELECT MONTHNAME(Month_) AS Month_Name, Sales,
COUNT(*) OVER (ORDER BY Month_ ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) 
AS Count,
SUM(Sales) OVER (ORDER BY Month_ ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) 
AS Rev_Cum_Sum
FROM Sales
ORDER BY MONTH(Month_);

# Cumulative Sum and Month Count 
SELECT MONTHNAME(Month_) AS Month_Name, Sales,
COUNT(*) OVER (ORDER BY Month_ ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) 
AS Count,
SUM(Sales) OVER (ORDER BY Month_ ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) 
AS Cum_Sum
FROM Sales
ORDER BY MONTH(Month_);

# Question -
# Rank Customers within each city by their total number of orders
SELECT c.CustomerID, c.City, COUNT(o.OrderID) AS OrderCount,
RANK() OVER(PARTITION  BY c.City ORDER BY COUNT(o.OrderID) DESC) AS 
Customer_City_Rank
FROM Customers AS c
JOIN Orders AS o
ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.City
ORDER BY c.City;









# Selecting the database
USE masai;

# Getting an idea about the orders table
SELECT * 
FROM Orders;

# Getting the delivery days 
SELECT *, TIMESTAMPDIFF(DAY, OrderDate, DeliveryDate) AS Delivery_Days
FROM Orders;

# Getting the delivery days 
SELECT *, TIMESTAMPDIFF(WEEK, OrderDate, DeliveryDate) AS Delivery_Days
FROM Orders;

# Units can be Days, Weeks, Months, Quarters, Years

# Getting the average number of delivery days for every customer
SELECT a.CustomerID, a.FirstName, 
AVG(TIMESTAMPDIFF(DAY, b.OrderDate, b.DeliveryDate)) AS Average_Number_of_Days
FROM Customers AS a
JOIN Orders AS b 
ON a.CustomerID = b.CustomerID
GROUP BY a.CustomerID, a.FirstName
ORDER BY Average_Number_of_Days DESC;

# Casting the Data 
SELECT *, 
CAST(TIMESTAMPDIFF(DAY, OrderDate, DeliveryDate) AS SIGNED) AS Number_of_Days
FROM Orders; 

# Casting the Data 
SELECT *, 
CAST(TIMESTAMPDIFF(DAY, OrderDate, DeliveryDate) AS UNSIGNED) AS Number_of_Days
FROM Orders; 

# Getting the Customers table
SELECT * 
FROM Customers;

SELECT CustomerID, FirstName, LastName,
Date_of_Birth, CAST(Date_of_Birth AS DATE) AS DOB
FROM Customers;

# Using CONCAT Function 
SELECT CONCAT(CAST(1 AS NCHAR), ' plus ', CAST(2 AS NCHAR), ' is three.')
AS output;

SELECT CONCAT(CONVERT(1, NCHAR), ' plus ', CONVERT(2, NCHAR), ' is three.')
AS output;

# Question - 
# Write a statement for every customer - 
# 'The total amount spent by Customer A is 1000.'

SELECT a.CustomerID, a.FirstName, SUM(total_order_amount) AS total_spent
FROM Customers AS a
JOIN Orders AS b 
ON a.CustomerID = b.CustomerID 
GROUP BY a.CustomerID, a.FirstName;

SELECT CONCAT('The total amount spent by ', FirstName, ' is ', total_spent) AS output
FROM (
	SELECT a.CustomerID, a.FirstName, SUM(b.total_order_amount) AS total_spent
	FROM Customers AS a
	JOIN Orders AS b 
	ON a.CustomerID = b.CustomerID 
	GROUP BY a.CustomerID, a.FirstName
    ) AS h;

# Filtering based on CAST/CONVERT
SELECT a.CustomerID, a.FirstName, SUM(total_order_amount) AS total_spent
FROM Customers AS a 
JOIN Orders AS b 
ON a.CustomerID = b.CustomerID
GROUP BY a.CustomerID, a.FirstName
HAVING CAST(SUM(total_order_amount) AS NCHAR) LIKE '30%';

# IFNULL, COALESCE
SELECT COALESCE(NULL, NULL, 2, 'Hi') AS output;
SELECT IFNULL(NULL, 2) AS output;

# Coalesce -> Selects the First non null entry in the series (Selection)
# IFNULL -> Replaces the null values (if present) in the first entry by the second value (Replacing)

# Coalesce -> Can take any number of values
# IFNULL -> Can take only 2 values

# Getting the customers data
SELECT * 
FROM Customers;

# Inserting the data into Customers
INSERT INTO Customers (CustomerID, FirstName, City)
VALUES 
(1, 'Prateek', 'Bangalore');

# Getting the Full Name 
SELECT CONCAT(FirstName, ' ', LastName) AS Full_Name
FROM Customers;

# Getting the Full Name 
SELECT CONCAT(FirstName, ' ', COALESCE(LastName, ' ')) AS Full_Name
FROM Customers;

# Getting the Full Name 
SELECT CONCAT(FirstName, ' ', IFNULL(LastName, ' ')) AS Full_Name
FROM Customers;

# String Functions 
SELECT CONCAT('The first 3 letters in the name of ', 
FirstName, ' are ', SUBSTRING(FirstName, 1, 3)) AS output
FROM Customers;

# LENGTH() Function 
SELECT FirstName, LENGTH(FirstName) AS FirstName
FROM Customers;

SELECT *
FROM Customers
ORDER BY SUBSTRING(FirstName, 1, 3);

# Ordering the data by the last 3 letters of firstname
SELECT *
FROM Customers
ORDER BY SUBSTRING(FirstName, LENGTH(FirstName) - 2, LENGTH(FirstName));

# RIGHT() 
SELECT *
FROM Customers 
ORDER BY RIGHT(FirstName, 3);

# LEFT() 
SELECT *
FROM Customers 
ORDER BY LEFT(FirstName, 3);

# REPLACE()
SELECT REPLACE(FirstName, 'a', 'A') AS output
FROM Customers;

SELECT REPLACE('Hello World !', 'Hello ', '') AS output;

# TRIM() Function 
SELECT TRIM('		There are a lot of empty spaces.		') AS output;
SELECT LTRIM('		There are a lot of empty spaces.		') AS output;
SELECT RTRIM('		There are a lot of empty spaces.		') AS output;

# UPPER() & LOWER()
SELECT LOWER(FirstName) AS FirstName, UPPER(LastName) AS LastName
FROM Customers;

# REVERSE() -> Pallindromes
SELECT FirstName
FROM Customers
WHERE FirstName = REVERSE(FirstName);

# REPEAT()
SELECT CONCAT(REPEAT('0', 4), UPPER(SUBSTRING(FirstName, 1, 3)),
CAST(CustomerID AS NCHAR),
LOWER(SUBSTRING(LastName, 1, 4)), REPEAT('1', 5)) AS output
FROM Customers;

# POSITION()
SELECT POSITION('Hello' IN 'This is a Hello World program') AS output;
SELECT POSITION('Hi' IN 'This is a Hello World program') AS output;

# Datetime Functions 
SELECT CURRENT_DATE() AS date_today;
SELECT NOW() AS datetime_today;

# DAY()
SELECT DAY(CURRENT_DATE()) AS date_today;

# MONTH()
SELECT MONTH(CURRENT_DATE()) AS month_today;

# QUARTER()
SELECT QUARTER(CURRENT_DATE()) AS quarter_today;

# YEAR()
SELECT YEAR(CURRENT_DATE()) AS year_today;

# WEEK()
SELECT WEEK(CURRENT_DATE()) AS week_today;

# DAYNAME()
SELECT DAYNAME(CURRENT_DATE()) AS dayname_today;

# Getting the Customers data
SELECT *
FROM Customers;

SELECT FirstName, Date_of_Birth,
YEAR(Date_of_Birth) AS Year_of_Birth,
MONTH(Date_of_Birth) AS Month_of_Birth,
WEEK(Date_of_Birth) AS Week_of_Birth,
DAY(Date_of_Birth) AS Day_of_Birth,
QUARTER(Date_of_Birth) AS Quarter_of_Birth,
DAYNAME(Date_of_Birth) AS DayName_of_Birth
FROM Customers;

# Getting the number of people born in each day
SELECT DAYNAME(Date_of_Birth) AS DayName, COUNT(*) AS Num
FROM Customers
GROUP BY DAYNAME(Date_of_Birth);

# Getting the number of people born in each month
SELECT MONTHNAME(Date_of_Birth) AS MonthName, COUNT(*) AS Num
FROM Customers
GROUP BY MonthName;

# Filtering the data by datetime functions 
SELECT DAYNAME(Date_of_Birth) AS DayName, COUNT(*) AS Num
FROM Customers
GROUP BY DAYNAME(Date_of_Birth)
HAVING DayName IN ('Wednesday', 'Thursday');

# Getting the year wise quarter wise total sales 
SELECT YEAR(OrderDate) AS Year_, QUARTER(OrderDate) AS Quarter_,
SUM(total_order_amount) AS Total_Sales
FROM Orders
GROUP BY Year_, Quarter_;

# DATEDIFF
SELECT DATEDIFF('2022-04-30', '2022-03-31') AS output;

# Getting the lead time 
SELECT *, DATEDIFF(DeliveryDate, OrderDate) AS Lead_Time
FROM Orders;

# Getting the first order of every Customer
SELECT CustomerID, MIN(OrderDate) AS First_Order_Date
FROM Orders
GROUP BY CustomerID;

# Getting the recent order of every Customer
SELECT CustomerID, MAX(OrderDate) AS Recent_Order_Date
FROM Orders
GROUP BY CustomerID;






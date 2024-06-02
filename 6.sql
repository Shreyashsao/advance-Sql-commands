# Selecting the database
USE masai;

# Getting an idea about Sales table 
SELECT * 
FROM Sales;

# Get the maximum out of 2 previous, current and 1 following month
SELECT MONTHNAME(Month_) AS Month_Name, Sales,
MAX(Sales) OVER(ORDER BY Month_ ROWS BETWEEN 2 PRECEDING AND 1 FOLLOWING) AS Max_Sales
FROM Sales;

# Get the minimum out of 2 previous, current and 1 following month
SELECT MONTHNAME(Month_) AS Month_Name, Sales,
MIN(Sales) OVER(ORDER BY Month_ ROWS BETWEEN 2 PRECEDING AND 1 FOLLOWING) 
AS Min_Sales
FROM Sales;

# Get all the columns from Orders Table along with 
# the average order amount for every customer sorted by order date 
# among 4 previous and 1 following date and 
# the number of orders for every customer sorted by order date

SELECT * 
FROM Orders;

SELECT *,
AVG(Total_Order_Amount) OVER (PARTITION BY CustomerID ORDER BY OrderDate
ROWS BETWEEN 4 PRECEDING AND 1 FOLLOWING) AS Avg_Order_Amount,
COUNT(*) OVER (PARTITION BY CustomerID ORDER BY OrderDate
ROWS BETWEEN 4 PRECEDING AND 1 FOLLOWING) AS Numb_Orders
FROM Orders;

# Stored Procedures

SELECT * 
FROM Customers 
WHERE City LIKE 'New York';

SELECT * 
FROM Customers 
WHERE City LIKE 'Berlin';

SELECT * 
FROM Customers 
WHERE City LIKE 'Melbourne';

# Creating a Stored Proccedure
DELIMITER $$ 
CREATE PROCEDURE procedure_1 (IN CityName VARCHAR(30))
BEGIN
SELECT * 
FROM Customers
WHERE City LIKE CityName;
END $$

DELIMITER ;

# Calling a stored procedure
CALL procedure_1('New York');
CALL procedure_1('Berlin');
CALL procedure_1('Melbourne');

# Creating a stored procedure
# Input -> order_amount, weekday

DELIMITER //
CREATE PROCEDURE Orders_Weekday_Proc
(IN order_amount FLOAT, weekday VARCHAR(30))
BEGIN 
SELECT *, DAYNAME(OrderDate) AS week_day 
FROM Orders
WHERE Total_order_amount >= order_amount AND
DAYNAME(OrderDate) LIKE weekday;
END //

DELIMITER ;

# Calling a procedure 
CALL Orders_Weekday_Proc(9000, 'Sunday');
CALL Orders_Weekday_Proc(7500, 'Thursday');

CALL Orders_Weekday_Proc(7500);

# Dropping a stored procedure
DROP PROCEDURE procedure_1;

# Changing the stored procedure -> Use alter procedue here
CALL Orders_Weekday_Proc(7500);

# Getting an idea about the products table
SELECT * 
FROM products_owned;

SELECT * 
FROM products_prices;

# CASE WHEN Statements
SELECT Product,
(CASE WHEN Year = 2012 THEN Price END) AS '2012', 
(CASE WHEN Year = 2013 THEN Price END) AS '2013', 
(CASE WHEN Year = 2014 THEN Price END) AS '2014', 
(CASE WHEN Year = 2015 THEN Price END) AS '2015', 
(CASE WHEN Year = 2016 THEN Price END) AS '2016'
FROM products_prices; 

SELECT Product,
(CASE WHEN Year = 2012 THEN Price END) AS '2012', 
(CASE WHEN Year = 2013 THEN Price END) AS '2013', 
(CASE WHEN Year = 2014 THEN Price END) AS '2014', 
(CASE WHEN Year = 2015 THEN Price END) AS '2015', 
(CASE WHEN Year = 2016 THEN Price END) AS '2016'
FROM products_prices
ORDER BY Product; 

SELECT Product,
(CASE WHEN Year = 2012 THEN Price END) AS '2012', 
(CASE WHEN Year = 2013 THEN Price END) AS '2013', 
(CASE WHEN Year = 2014 THEN Price END) AS '2014', 
(CASE WHEN Year = 2015 THEN Price END) AS '2015', 
(CASE WHEN Year = 2016 THEN Price END) AS '2016'
FROM products_prices
WHERE Product = 'Apple IPhone';

SELECT Product,
SUM(CASE WHEN Year = 2012 THEN Price END) AS '2012', 
SUM(CASE WHEN Year = 2013 THEN Price END) AS '2013', 
SUM(CASE WHEN Year = 2014 THEN Price END) AS '2014', 
SUM(CASE WHEN Year = 2015 THEN Price END) AS '2015', 
SUM(CASE WHEN Year = 2016 THEN Price END) AS '2016'
FROM products_prices
GROUP BY Product 
ORDER BY Product; 

SELECT Product,
MAX(CASE WHEN Year = 2012 THEN Price END) AS '2012', 
MAX(CASE WHEN Year = 2013 THEN Price END) AS '2013', 
MAX(CASE WHEN Year = 2014 THEN Price END) AS '2014', 
MAX(CASE WHEN Year = 2015 THEN Price END) AS '2015', 
MAX(CASE WHEN Year = 2016 THEN Price END) AS '2016'
FROM products_prices
GROUP BY Product 
ORDER BY Product; 

# CASE WHEN Statement
SELECT Year,
(CASE WHEN Product = 'Apple IPhone' THEN Price END) AS 'Apple IPhone',
(CASE WHEN Product = 'One Plus 5' THEN Price END) AS 'One Plus 5',
(CASE WHEN Product = 'Samsung Note 3' THEN Price END) AS 'Samsung Note 3',
(CASE WHEN Product = 'Sony Xperia Z' THEN Price END) AS 'Sony Xperia Z'
FROM products_prices;

SELECT Year,
SUM(CASE WHEN Product = 'Apple IPhone' THEN Price END) AS 'Apple IPhone',
SUM(CASE WHEN Product = 'One Plus 5' THEN Price END) AS 'One Plus 5',
SUM(CASE WHEN Product = 'Samsung Note 3' THEN Price END) AS 'Samsung Note 3',
SUM(CASE WHEN Product = 'Sony Xperia Z' THEN Price END) AS 'Sony Xperia Z'
FROM products_prices
GROUP BY Year;

# Getting an idea about the products table
SELECT * 
FROM products_owned;

SELECT Name, Phone_Number, 
(CASE WHEN Product_Owned = 'iPhone'  THEN Price END) AS 'iPhone',
(CASE WHEN Product_Owned = 'Gshock'  THEN Price END) AS 'Gshock',
(CASE WHEN Product_Owned = 'Rolex'  THEN Price END) AS 'Rolex',
(CASE WHEN Product_Owned = 'S22 Ultra'  THEN Price END) AS 'S22 Ultra',
(CASE WHEN Product_Owned = 'Pixel 4'  THEN Price END) AS 'Pixel 4'
FROM products_owned;

SELECT Name, Phone_Number, 
SUM(CASE WHEN Product_Owned = 'iPhone'  THEN Price END) AS 'iPhone',
SUM(CASE WHEN Product_Owned = 'Gshock'  THEN Price END) AS 'Gshock',
SUM(CASE WHEN Product_Owned = 'Rolex'  THEN Price END) AS 'Rolex',
SUM(CASE WHEN Product_Owned = 'S22 Ultra'  THEN Price END) AS 'S22 Ultra',
SUM(CASE WHEN Product_Owned = 'Pixel 4'  THEN Price END) AS 'Pixel 4'
FROM products_owned
GROUP BY Name, Phone_Number;

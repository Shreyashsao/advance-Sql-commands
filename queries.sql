# Creating a database 
CREATE DATABASE demo;

# Selecting the database
USE demo;

# Constraints -> Rules/Restrictions

# Primary Key (Way 1)
CREATE TABLE Users (
ID INT PRIMARY KEY,
Full_Name VARCHAR(30)
);

# Primary Key -> Uniquely identify every row in the given table
# Unique, Non-Null values

# Inserting the data into the table
INSERT INTO Users 
VALUES 
(1, 'Aman');

# Inserting the data into the table
INSERT INTO Users 
VALUES 
(1, 'Ajay');

# Getting the data
SELECT * 
FROM Users;

# Dropping the table 
DROP TABLE Users;

# Primary Key (Way 2)
CREATE TABLE Users (
ID INT,
Full_Name VARCHAR(30),
CONSTRAINT pk_users_ PRIMARY KEY (ID)
);

# Primary Key -> Uniquely identify every row in the given table
# Unique, Non-Null values

# Inserting the data into the table
INSERT INTO Users 
VALUES 
(1, 'Aman');

# Inserting the data into the table
INSERT INTO Users 
VALUES 
(1, 'Ajay');

# Getting the data
SELECT * 
FROM Users;

# Dropping the table 
DROP TABLE Users;

# Unique Constraint (Way 1) 
CREATE TABLE Users (
ID INT,
Full_Name VARCHAR(30),
CONSTRAINT unique_constraint UNIQUE (ID)
);

# Inserting the data into the table
INSERT INTO Users 
VALUES 
(1, 'Aman');

# Inserting the data into the table
INSERT INTO Users 
VALUES 
(1, 'Ajay');

# Getting the data
SELECT * 
FROM Users;

# Dropping the table 
DROP TABLE Users;

# Unique Constraint (Way 2) 
CREATE TABLE Users (
ID INT UNIQUE,
Full_Name VARCHAR(30)
);

# Inserting the data into the table
INSERT INTO Users 
VALUES 
(1, 'Aman');

# Inserting the data into the table
INSERT INTO Users 
VALUES 
(1, 'Ajay');

# Getting the data
SELECT * 
FROM Users;

# Dropping the table 
DROP TABLE Users;

# Foreign Key (Way 1)
CREATE TABLE Users (
ID INT PRIMARY KEY,
Full_Name VARCHAR(30)
);

CREATE TABLE Blogs (
ID INT PRIMARY KEY,
Blog_Name VARCHAR(30),
User_ID INT,
FOREIGN KEY (User_ID) REFERENCES Users(ID)
);

# Dropping the tables
DROP TABLE Blogs;
DROP TABLE Users;

# Foreign Key (Way 2)
CREATE TABLE Users (
ID INT PRIMARY KEY,
Full_Name VARCHAR(30)
);

CREATE TABLE Blogs (
ID INT PRIMARY KEY,
Blog_Name VARCHAR(30),
User_ID INT,
CONSTRAINT fk_users_ FOREIGN KEY (User_ID) REFERENCES Users(ID)
);

# CHECK Constraint 

# Way 1 -
CREATE TABLE Users (
ID INT PRIMARY KEY,
Full_Name VARCHAR(30) CHECK (Full_Name LIKE '%a%')
);

# Percentage (%) is a wildcard character 
# denoting any number of any characters

# Inserting the data into the table
INSERT INTO Users 
VALUES 
(1, 'Aman');

# Inserting the data into the table
INSERT INTO Users 
VALUES 
(2, 'Nrupul');

# Dropping the tables
DROP TABLE Users;

# Way 2 -
CREATE TABLE Users (
ID INT PRIMARY KEY,
Full_Name VARCHAR(30),
CONSTRAINT ck_users_ CHECK (Full_Name LIKE '%a%')
);

# Percentage (%) is a wildcard character 
# denoting any number of any characters

# Inserting the data into the table
INSERT INTO Users 
VALUES 
(1, 'Aman');

# Inserting the data into the table
INSERT INTO Users 
VALUES 
(2, 'Nrupul');

# Dropping the tables
DROP TABLE Users;

# Default Constraint 
CREATE TABLE Users (
ID INT PRIMARY KEY,
Full_Name VARCHAR(30) DEFAULT 'MySQL'
);

# Inserting the data 
INSERT INTO Users (ID) 
VALUES
(1),
(2),
(3);

SELECT * 
FROM Users;

# Dropping the tables
DROP TABLE Users;

# NOT NULL Constraint
CREATE TABLE Users (
ID INT NOT NULL,
Full_Name VARCHAR(30)
);

# Inserting the data 
INSERT INTO Users (Full_Name) 
VALUES
('Ajay');

# Dropping the tables
DROP TABLE Users;

# Dropping the database
DROP DATABASE demo;

# Getting an idea about the tables 
SELECT * FROM category;
SELECT * FROM customers;
SELECT * FROM orderdetails;
SELECT * FROM orders;
SELECT * FROM payments;
SELECT * FROM products;
SELECT * FROM shippers;
SELECT * FROM suppliers;

# ALTER Statement -> Change the structure of the table

# Adding a new column to the table
ALTER TABLE Customers
ADD Favorite_Sport VARCHAR(30);

SELECT * 
FROM Customers;

# Dropping a column
ALTER TABLE Customers
DROP COLUMN Favorite_Sport;

SELECT * 
FROM Customers;

# Adding a new column to the table
ALTER TABLE Customers
ADD Favorite_Sport VARCHAR(30);

# Setting the default value
ALTER TABLE Customers
ALTER Favorite_Sport SET DEFAULT 'Cricket';

# Getting the data
SELECT * 
FROM Customers;

# Inserting the data 
INSERT INTO Customers (CustomerID, FirstName, City)
VALUES
(1, 'Prateek', 'Bangalore');

# Getting the data
SELECT * 
FROM Customers;

# Dropping the null
ALTER TABLE Customers
ALTER Favorite_Sport DROP DEFAULT;

# Inserting the data 
INSERT INTO Customers (CustomerID, FirstName, City)
VALUES
(2, 'Nrupul', 'Pune');

# Setting the default to NULL
ALTER TABLE Customers
ALTER Favorite_Sport SET DEFAULT NULL;

# Inserting the data 
INSERT INTO Customers (CustomerID, FirstName, City)
VALUES
(2, 'Nrupul', 'Pune');

# Getting the data
SELECT * 
FROM Customers;

# Adding the primary key (Way 1)
ALTER TABLE Customers
ADD PRIMARY KEY (CustomerID);

# Dropping the primary key 
ALTER TABLE Customers
DROP PRIMARY KEY;

# Adding the primary key (Way 1)
ALTER TABLE Customers
ADD CONSTRAINT pk_cust_ PRIMARY KEY (CustomerID);

# Dropping the primary key 
ALTER TABLE Customers
DROP PRIMARY KEY;

# Getting the data
SELECT * 
FROM Customers;

# Converting datetime column to date format
ALTER TABLE Customers
MODIFY COLUMN Date_of_Birth DATE;

# Getting the data
SELECT * 
FROM Customers;

# Renaming a column 
ALTER TABLE Customers
RENAME COLUMN CustomerID TO ID;

# Getting the data
SELECT * 
FROM Customers;

# Renaming a table 
ALTER TABLE Customers
RENAME Customer_Details;

SELECT * 
FROM Customers;

SELECT * 
FROM Customer_Details;

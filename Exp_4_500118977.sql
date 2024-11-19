-- Om Tripathi
-- 500119524

CREATE DATABASE client;
USE client;

CREATE TABLE CLIENT_MASTER (
    CLIENTNO VARCHAR(6) PRIMARY KEY CHECK (CLIENTNO LIKE 'C%'),
    NAME VARCHAR(20) NOT NULL,
    ADDRESS1 VARCHAR(30),
    ADDRESS2 VARCHAR(30),
    CITY VARCHAR(15),
    PINCODE INTEGER CHECK (PINCODE >= 0),
    STATE VARCHAR(15),
    BALDUE DECIMAL(10, 2) DEFAULT 0.00    
);

CREATE TABLE PRODUCT_MASTER (
 PRODUCTNO VARCHAR(6),
 CHECK (PRODUCTNO LIKE 'P%'),
 DESCRIPTION VARCHAR(15) NOT NULL,
 PROFITPERCENT DECIMAL(4,2) NOT NULL,
 UNIT_MEASURE VARCHAR(10) NOT NULL,
 QTYONHAND INTEGER(8) NOT NULL,
 REORDERLVL INTEGER(8) NOT NULL,
 SELLPRICE DECIMAL(8,2) NOT NULL,
 COSTPRICE DECIMAL(8,2) NOT NULL
);

CREATE TABLE SALESMAN_MASTER (
 SALESMANNO VARCHAR(6) PRIMARY KEY CHECK (SALESMANNO LIKE 'S%'),
 SALESMANNAME VARCHAR(20) NOT NULL,
 ADDRESS1 VARCHAR(30) NOT NULL,
 ADDRESS2 VARCHAR(30),
 CITY VARCHAR(20),
 PINCODE INTEGER(8),
 STATE VARCHAR(20),
 SALAMT REAL(8,2) NOT NULL CHECK (SALAMT <> 0),
 TGTTOGET DECIMAL(6,2) NOT NULL CHECK (TGTTOGET <> 0),
 YTDSALES DOUBLE(6,2) NOT NULL,
 REMARKS VARCHAR(60)
);

-- Inserting elements into tables

INSERT INTO CLIENT_MASTER (CLIENTNO, NAME, CITY, PINCODE, STATE, BALDUE) VALUES
('C00001', 'Ivan bayross', 'Mumbai', 400054, 'Maharashtra', 15.000),
('C00002', 'Mamta muzumdar', 'Madras', 780001, 'Tamil Nadu', 0.0),
('C00003', 'Chhaya bankar', 'Mumbai', 400057, 'Maharashtra', 50.00),
('C00004', 'Ashwini joshi', 'Bangalore', 560001, 'Karnataka', 0.0),
('C00005', 'Hansel colaco', 'Mumbai', 400060, 'Maharashtra', 200.0),
('C00006', 'Deepak sharma', 'Mangalore', 560050, 'Karnataka', 0.0);
SELECT * FROM CLIENT_MASTER;

INSERT INTO SALESMAN_MASTER (SALESMANNO, SALESMANNAME, ADDRESS1, ADDRESS2, CITY, PINCODE, STATE,SALAMT,TGTTOGET,YTDSALES) VALUES
('S00001', 'Aman', 'A/14', 'Worli', 'Mumbai', 400002, 'Maharashtra',8,5,5),
('S00002', 'Omkar', '65', 'Nariman', 'Mumbai', 400001, 'Maharashtra',7,5,5),
('S00003', 'Raj', 'P-7', 'Bandra', 'Mumbai', 400032, 'Maharashtra',9,5,5),
('S00004', 'Ashish', 'A/5', 'Juhu', 'Mumbai', 400044, 'Maharashtra',6,5,5);
SELECT * FROM SALESMAN_MASTER;

INSERT INTO PRODUCT_MASTER (PRODUCTNO, DESCRIPTION, PROFITPERCENT, UNIT_MEASURE, QTYONHAND, 
REORDERLVL, SELLPRICE, COSTPRICE) VALUES
('P00001', 'T-Shirt', 5, 'Piece', 200, 50, 350, 250),
('P0345', 'Shirts', 6, 'Piece', 150, 50, 500, 350),
('P06734', 'Cotton jeans', 5, 'Piece', 100, 20, 600, 450),
('P07865', 'Jeans', 5, 'Piece', 100, 20, 750, 500),
('P07868', 'Trousers', 2, 'Piece', 150, 50, 850, 550),
('P07885', 'Pull Overs', 2.5, 'Piece', 80, 30, 700, 450),
('P07965', 'Denim jeans', 4, 'Piece', 100, 40, 350, 250),
('P07975', 'Lycra tops', 5, 'Piece', 70, 30, 300, 175),
('P08865', 'Skirts', 5, 'Piece', 75, 30, 450, 300);
SELECT * FROM PRODUCT_MASTER;

-- Queries
-- Exercise on retrieving records from a table.

-- Find names of all clients
SELECT NAME FROM CLIENT_MASTER;
-- Retrieve entire contents of CLIENT_MASTER
SELECT * FROM CLIENT_MASTER;
--  List all products available
SELECT NAME, CITY, STATE FROM CLIENT_MASTER;
-- List names, city, and state of all clients
SELECT DESCRIPTION FROM PRODUCT_MASTER;
-- List all clients located in Mumbai
SELECT * FROM CLIENT_MASTER WHERE CITY = 'Mumbai';
-- Find names of salesmen with a salary equal to Rs. 3000
SELECT SALESMANNAME FROM SALESMAN_MASTER WHERE SALAMT = 3000;


-- Update commands
-- Exercise on updating records in a table

-- Change the city of ClientNo 'C00005' to 'Bangalore'
UPDATE CLIENT_MASTER SET CITY = 'Bangalore' WHERE CLIENTNO = 'C00005';
-- Change BalDue of ClientNo 'C00001' to Rs. 1000
UPDATE CLIENT_MASTER SET BALDUE = 1000 WHERE CLIENTNO = 'C00001';
-- Change the cost price of 'Trousers' to Rs. 950.00
UPDATE PRODUCT_MASTER SET COSTPRICE = 950 WHERE PRODUCTNO = 'P07868';
-- Change the city of salesmen to 'Pune'
UPDATE SALESMAN_MASTER SET CITY = 'Pune';


-- Delete all salesmen from Salesman_Master whose salaries are equal to Rs.3500.
DELETE FROM Salesman_Master
WHERE SALAMT = 3500;

-- Delete all products from Product_Master where the quantity on hand is equal to 100.
DELETE FROM Product_Master
WHERE QTYONHAND = 100;

--  Delete from Client_Master where the column state holds the value ‘Tamil Nadu’.
DELETE FROM Client_Master
WHERE STATE = 'Tamil Nadu';

--  Add a column called ‘Telephone’ of data type integer to the Client_Master table.
ALTER TABLE Client_Master
ADD Telephone INT;

--  Change the size of SellPrice column in Product_Master to 10, 2.
ALTER TABLE Product_Master
MODIFY COLUMN SellPrice DECIMAL(10, 2);

--  Destroy the table Client_Master along with its data.
DROP TABLE Client_Master;

-- Om Tripathi
-- 500119524

CREATE DATABASE SUPPLY;
USE SUPPLY;
CREATE TABLE Supplier (
    scode INT PRIMARY KEY,
    sname VARCHAR(100),
    scity VARCHAR(50),
    turnover DECIMAL(10, 2)
);

CREATE TABLE Part (
    pcode INT PRIMARY KEY,
    weight DECIMAL(10, 2),
    cost DECIMAL(10, 2),
    sellingprice DECIMAL(10, 2)
);

CREATE TABLE Supplier_Part (
    scode INT,
    pcode INT,
    qty INT,
    PRIMARY KEY (scode, pcode),
    FOREIGN KEY (scode) REFERENCES Supplier(scode),
    FOREIGN KEY (pcode) REFERENCES Part(pcode)
);


INSERT INTO Supplier (scode, sname, scity, turnover) VALUES
(1, 'Supplier A', 'Bombay', 50.00),
(2, 'Supplier B', 'Delhi', 75.00),
(3, 'Supplier C', 'Bangalore', NULL),
(4, 'Supplier D', 'Hyderabad', 65.00),
(5, 'Supplier E', 'Bombay', 85.00);


INSERT INTO Part (pcode, weight, cost, sellingprice) VALUES
(1, 30.00, 20.00, 30.00),
(2, 25.00, 15.00, 25.00),
(3, 35.00, 40.00, 50.00),
(4, 28.00, 30.00, 45.00),
(5, 22.00, 10.00, 20.00);


INSERT INTO Supplier_Part (scode, pcode, qty) VALUES
(1, 1, 300),
(1, 2, 200),
(2, 3, 400),
(3, 4, 150),
(4, 5, 100),
(5, 1, 300);
 
 
 

-- Get the supplier number and part number in ascending order of supplier number:-- 
   
   SELECT scode, pcode 
   FROM Supplier_Part 
   ORDER BY scode ASC;
   

-- Get the details of suppliers who operate from Bombay with a turnover of 50:-- 
   
   SELECT * 
   FROM Supplier 
   WHERE scity = 'Bombay' AND turnover = 50;
   

 -- Get the total number of suppliers:-- 
   
   SELECT COUNT(*) AS Total_Suppliers 
   FROM Supplier;
   

 -- Get the part numbers weighing between 25 and 35:-- 
   
   SELECT pcode 
   FROM Part 
   WHERE weight BETWEEN 25 AND 35;
   

 -- Get the supplier number whose turnover is NULL:-- 
   
   SELECT scode 
   FROM Supplier 
   WHERE turnover IS NULL;
   

 -- Get the part number that costs 20, 30, or 40 rupees:-- 
   
   SELECT pcode 
   FROM Part 
   WHERE cost IN (20, 30, 40);
   

-- Get the total quantity of part 2 that is supplied:-- 
   
   SELECT SUM(qty) AS Total_Quantity 
   FROM Supplier_Part 
   WHERE pcode = 2;
   

 -- Get the name of the supplier who supplies part 2:-- 
   
   SELECT S.sname 
   FROM Supplier S 
   JOIN Supplier_Part SP ON S.scode = SP.scode 
   WHERE SP.pcode = 2;
   

 -- Get the part number whose cost is greater than the average cost:-- 
   
   SELECT pcode 
   FROM Part 
   WHERE cost > (SELECT AVG(cost) FROM Part);
   

-- Get the supplier number and turnover in descending order of turnover:-- 
   
   SELECT scode, turnover 
   FROM Supplier 
   ORDER BY turnover DESC;
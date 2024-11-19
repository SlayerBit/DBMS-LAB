CREATE DATABASE my_database;
USE my_database;

-- 1) MySQL query to accept the value of A, B & C and display which is greater
-- Using variables to store values
SET @A = 10;
SET @B = 20;
SET @C = 30;

-- Checking which value is greater
SELECT 
    CASE 
        WHEN @A > @B AND @A > @C THEN 'A is greater'
        WHEN @B > @A AND @B > @C THEN 'B is greater'
        ELSE 'C is greater'
    END AS GreaterValue;

-- 2) MySQL query to create a simple loop that displays the message 20 times
-- We use a stored procedure with a loop
DELIMITER $$

CREATE PROCEDURE DisplayMessage()
BEGIN
    DECLARE counter INT DEFAULT 1;
    WHILE counter <= 20 DO
        SELECT 'Welcome to PL/SQL Programming';
        SET counter = counter + 1;
    END WHILE;
END $$

DELIMITER ;

-- To execute the stored procedure:
CALL DisplayMessage();

-- 3) MySQL query to find the factorial of a number
DELIMITER $$

CREATE PROCEDURE FindFactorial(IN num INT)
BEGIN
    DECLARE fact INT DEFAULT 1;
    DECLARE i INT DEFAULT 1;

    -- Loop to calculate factorial
    WHILE i <= num DO
        SET fact = fact * i;
        SET i = i + 1;
    END WHILE;

    SELECT CONCAT('Factorial of ', num, ' is ', fact) AS FactorialResult;
END $$

DELIMITER ;

-- To execute the stored procedure for calculating factorial of 5:
CALL FindFactorial(5);

-- 4) MySQL query to generate Fibonacci series
DELIMITER $$

CREATE PROCEDURE GenerateFibonacci(IN n INT)
BEGIN
    DECLARE a INT DEFAULT 0;
    DECLARE b INT DEFAULT 1;
    DECLARE temp INT;
    DECLARE counter INT DEFAULT 1;

    SELECT 'Fibonacci Series:';

    WHILE counter <= n DO
        SELECT a;
        SET temp = a + b;
        SET a = b;
        SET b = temp;
        SET counter = counter + 1;
    END WHILE;
END $$

DELIMITER ;

-- To execute the stored procedure for generating a Fibonacci series for 10 terms:
CALL GenerateFibonacci(10);

-- 5) MySQL query to find the sum of first N numbers
DELIMITER $$

CREATE PROCEDURE FindSumOfFirstNNumbers(IN N INT)
BEGIN
    DECLARE sum INT DEFAULT 0;
    DECLARE i INT DEFAULT 1;

    -- Loop to calculate the sum
    WHILE i <= N DO
        SET sum = sum + i;
        SET i = i + 1;
    END WHILE;

    SELECT CONCAT('Sum of first ', N, ' numbers is ', sum) AS SumResult;
END $$

DELIMITER ;

-- To execute the stored procedure for calculating the sum of first 5 numbers:
CALL FindSumOfFirstNNumbers(5);
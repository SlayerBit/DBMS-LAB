-- 1) Create a table that simulates the EMPID_SEQ sequence (since MySQL doesn't support CREATE SEQUENCE)
CREATE TABLE EMPID_SEQ (
    seq_value INT NOT NULL AUTO_INCREMENT PRIMARY KEY
);

-- Insert a starting value (this is equivalent to creating a sequence starting with 100)
INSERT INTO EMPID_SEQ (seq_value) VALUES (100);

-- 2) SQL command to find the current and next status of the simulated sequence
-- Current value (last inserted value)
SELECT seq_value FROM EMPID_SEQ ORDER BY seq_value DESC LIMIT 1;

-- Next value (simulate getting the next sequence value)
INSERT INTO EMPID_SEQ (seq_value) VALUES (NULL);
SELECT seq_value FROM EMPID_SEQ ORDER BY seq_value DESC LIMIT 1;

-- 3) Change the Cache value of the sequence EMPID_SEQ to 20 and maxvalue to 1000
-- MySQL does not have a direct "cache" or "maxvalue" option like Oracle sequences.
-- We simulate this behavior manually if needed.

-- 4) Insert values in employees table using the simulated sequence for employee_id column
CREATE TABLE employees (
    employee_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    salary DECIMAL(10, 2)
);

-- Insert an employee using the simulated sequence
INSERT INTO employees (employee_id, name, salary) VALUES ((SELECT seq_value FROM EMPID_SEQ ORDER BY seq_value DESC LIMIT 1), 'John Doe', 50000);

-- 5) Drop the simulated sequence EMPID_SEQ (Dropping the sequence simulation table)
DROP TABLE EMPID_SEQ;

-- 6) Create a sequence called REVERSE to generate numbers in descending order from 10000 to 1000 with a decrement of 5
-- We need a stored procedure to handle the reverse sequence insertion.

DELIMITER $$

CREATE PROCEDURE GenerateReverseSequence()
BEGIN
    DECLARE seq_value INT DEFAULT 10000;

    -- Loop to insert values from 10000 to 1000 with a decrement of 5
    WHILE seq_value >= 1000 DO
        INSERT INTO REVERSE (seq_value) VALUES (seq_value);
        SET seq_value = seq_value - 5;
    END WHILE;
END$$

DELIMITER ;

-- Now we can call the stored procedure to generate the reverse sequence.
CALL GenerateReverseSequence();

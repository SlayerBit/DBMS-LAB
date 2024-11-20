-- Create Database
CREATE DATABASE MovieRental;
USE MovieRental;

-- Movies Table
CREATE TABLE Movies (
    movie_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    genre VARCHAR(50),
    release_year INT,
    price_per_day DECIMAL(5, 2) NOT NULL,
    availability BOOLEAN DEFAULT TRUE
);

-- Customers Table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(15),
    address TEXT
);

-- Rentals Table
CREATE TABLE Rentals (
    rental_id INT PRIMARY KEY AUTO_INCREMENT,
    movie_id INT NOT NULL,
    customer_id INT NOT NULL,
    rental_date DATE NOT NULL,
    return_date DATE,
    total_cost DECIMAL(10, 2),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Payments Table
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    rental_id INT NOT NULL,
    payment_date DATE NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_method VARCHAR(50),
    FOREIGN KEY (rental_id) REFERENCES Rentals(rental_id)
);

-- Insert Sample Data into Movies
INSERT INTO Movies (title, genre, release_year, price_per_day, availability)
VALUES
('Inception', 'Sci-Fi', 2010, 3.50, TRUE),
('The Godfather', 'Crime', 1972, 4.00, TRUE),
('The Dark Knight', 'Action', 2008, 3.75, TRUE);

-- Insert Sample Data into Customers
INSERT INTO Customers (name, email, phone, address)
VALUES
('John Doe', 'john.doe@example.com', '1234567890', '123 Main St'),
('Jane Smith', 'jane.smith@example.com', '9876543210', '456 Elm St');

-- Insert Sample Data into Rentals
INSERT INTO Rentals (movie_id, customer_id, rental_date, return_date, total_cost)
VALUES
(1, 1, '2024-11-15', '2024-11-17', 7.00),
(2, 2, '2024-11-16', '2024-11-18', 8.00);

-- Insert Sample Data into Payments
INSERT INTO Payments (rental_id, payment_date, amount, payment_method)
VALUES
(1, '2024-11-17', 7.00, 'Credit Card'),
(2, '2024-11-18', 8.00, 'PayPal');

-- Query to View Available Movies
SELECT movie_id, title, genre, price_per_day
FROM Movies
WHERE availability = TRUE;

-- Query to Track Rentals
SELECT 
    r.rental_id, 
    c.name AS Customer, 
    m.title AS Movie, 
    r.rental_date, 
    r.return_date, 
    r.total_cost
FROM Rentals r
JOIN Customers c ON r.customer_id = c.customer_id
JOIN Movies m ON r.movie_id = m.movie_id;

-- Query for Customer Payment History
SELECT 
    c.name AS Customer, 
    p.payment_date, 
    p.amount, 
    p.payment_method
FROM Payments p
JOIN Rentals r ON p.rental_id = r.rental_id
JOIN Customers c ON r.customer_id = c.customer_id;

-- Query to Generate Total Revenue Report
SELECT SUM(amount) AS Total_Revenue
FROM Payments;

-- Query to Check Overdue Rentals
SELECT 
    r.rental_id, 
    c.name AS Customer, 
    m.title AS Movie, 
    r.rental_date, 
    r.return_date
FROM Rentals r
JOIN Customers c ON r.customer_id = c.customer_id
JOIN Movies m ON r.movie_id = m.movie_id
WHERE r.return_date < CURDATE();

-- Trigger to Update Availability After Rental
DELIMITER $$
CREATE TRIGGER UpdateAvailabilityAfterRental
AFTER INSERT ON Rentals
FOR EACH ROW
BEGIN
    UPDATE Movies
    SET availability = FALSE
    WHERE movie_id = NEW.movie_id;
END$$
DELIMITER ;

-- Stored Procedure for Late Fee Calculation
DELIMITER $$
CREATE PROCEDURE CalculateLateFee(IN rentalID INT, OUT lateFee DECIMAL(10, 2))
BEGIN
    DECLARE dueDate DATE;
    DECLARE today DATE;
    SET today = CURDATE();
    SELECT return_date INTO dueDate FROM Rentals WHERE rental_id = rentalID;
    IF today > dueDate THEN
        SET lateFee = DATEDIFF(today, dueDate) * 1.50; -- $1.50 per day late fee
    ELSE
        SET lateFee = 0.00;
    END IF;
END$$
DELIMITER ;